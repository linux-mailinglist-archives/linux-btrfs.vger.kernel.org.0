Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341413540FA
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Apr 2021 12:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhDEJwh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Apr 2021 05:52:37 -0400
Received: from mail.tuxforce.de ([84.38.66.179]:45572 "EHLO mail.tuxforce.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232447AbhDEJwh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Apr 2021 05:52:37 -0400
Received: from [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d] (2001-4dd5-b099-0-19b2-6b8c-f4bb-b22d.ipv6dyn.netcologne.de [IPv6:2001:4dd5:b099:0:19b2:6b8c:f4bb:b22d])
        by mail.tuxforce.de (Postfix) with ESMTPSA id B81B452007A;
        Mon,  5 Apr 2021 11:52:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.tuxforce.de B81B452007A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tuxforce.de;
        s=202009; t=1617616349;
        bh=InJyhimLKziyIp92AetQaB+FtrFXI3emxxV0N/tQMxg=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=LmG1S1ms4E0HlqaITsuWoO89bXCLrNWI8S63lNwyEqGngoC/QEgJpD5E0O0SarnjM
         +cVmoTjYS4n8St5P9Mx8xLKWwg6bf0RHdW85yNx5Gg8zeKUK+8quglM2kUA68w0Tc3
         wdcZTW7gQM5UrNXYEHOTBeNFYnN2Rz0Vsr0PhELX6rVL3t/56AGfh8dgHeHxvLsixL
         tzF5N3xro5M8fyYRzg8u+5Bxw5ltjgcpK+TD13ExpTgj3fSPvST4L760cgc4AFmbh0
         9T6tebI+OdqQNgYBRZBjc+T0z9PkBxub4tUTtnFpqjE/4dTYF2N10iOmf3jhN5c6Cy
         cHth5rg0CMyew==
From:   Lukas Middendorf <kernel@tuxforce.de>
Subject: Re: Is request_firmware() really safe to call in resume callback when
 /usr/lib/firmware is on btrfs?
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Lukas Middendorf <kernel@tuxforce.de>,
        Greg KH <gregkh@linuxfoundation.org>, dsterba@suse.cz
References: <a79f1a0c-012d-bebe-c9c7-b505f59079c2@tuxforce.de>
 <20200817152056.GD4332@42.do-not-panic.com>
 <9e5c716e-1736-9890-54be-75739ea5462f@tuxforce.de>
 <20200818143715.GF4332@42.do-not-panic.com>
 <6b61e549-42b8-8e71-ff57-43b7c5b4291f@tuxforce.de>
 <20210402180253.GS4332@42.do-not-panic.com>
 <CAB=NE6WVnR197DnH+EgHDoyy98x15D0fVdoGjZcHW9W5P7Jipg@mail.gmail.com>
 <CAB=NE6X8bXUoTuTxhy-DDqO8ByaFiJqbjzCSmmGwTbbLY95FhA@mail.gmail.com>
 <679f1f74-1304-9e79-1d83-0810361b4503@tuxforce.de>
 <20210403202538.GW4332@42.do-not-panic.com>
 <20210403210444.GU13911@42.do-not-panic.com>
Message-ID: <d7ebf04a-8875-dd9b-7f85-ef5ad2336498@tuxforce.de>
Date:   Mon, 5 Apr 2021 11:52:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210403210444.GU13911@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 03/04/2021 23:04, Luis Chamberlain wrote:
> OK this fixes it but this just shows that likely the thaw'ing allows
> a race to take place which we didn't expect. I'll do some more digging
> for a proper fix.

I can indeed confirm that this fixes the stall. This however does not
seem to be the (complete) solution. Instead I now get a kernel crash
message (see below) for every firmware location tried to read during
resume. This might be intentional for debugging purposes during testing.
This is identical for ext4 and btrfs.

If the firmware file can not be found during caching on suspend, the
reads are still attempted again during resume. This leads to multiple of
those crash messages (for different firmware locations) during resume if
the firmware file is not present, even for drivers properly requesting
caching.

So if this patch is to go in (those crashes would really help with
getting the si2168 patches in…), I think you have to make sure that even for
non-existent firmware files, no read is ever attempted on resume. Which
means to set up the caching even if the initial request_firmware()
failed and to store knowledge about failed caching attempts to not retry
these reads on resume.

Lukas

------------[ cut here ]------------
WARNING: CPU: 0 PID: 662 at fs/kernel_read_file.c:161 kernel_read_file_from_path_initns+0x11c/0x140
Modules linked in: test_firmware nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink intel_rapl_msr intel_rapl_common kvm_amd vmwgfx ccp kvm ttm drm_kms_helper snd_pcm joydev snd_timer snd e1000 irqbypass cec soundcore vboxguest i2c_piix4 pcspkr drm fuse zram ip_tables crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw ata_generic pata_acpi video
CPU: 0 PID: 662 Comm: systemd-sleep Not tainted 5.12.0-rc5+ #2
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
RIP: 0010:kernel_read_file_from_path_initns+0x11c/0x140
Code: ff ff 4c 89 e7 89 44 24 10 e8 50 07 fc ff e8 fb 1c d8 ff 44 8b 44 24 10 48 83 c4 28 44 89 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 <0f> 0b 80 3d b4 10 7a 01 00 75 e3 e9 5b 5e 83 00 e8 cf 1c d8 ff 45
RSP: 0018:ffffa096c0b9fb90 EFLAGS: 00010286
RAX: 00000000fffffff5 RBX: 0000000000000000 RCX: ffffffffbd85d688
RDX: ffffffffbd85d688 RSI: 0000000000000297 RDI: ffffffffbd85d680
RBP: ffffa096c0b9fbe0 R08: 00000000fffffff5 R09: ffffffffbd85d688
R10: ffffffffffffffff R11: 0000000000000000 R12: ffff8976ca811000
R13: ffffa096c0b9fc00 R14: 000000007fffffff R15: 0000000000000001
FS:  00007f4718de3b40(0000) GS:ffff8979cfc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005594afeca4f8 CR3: 0000000106a62000 CR4: 00000000000506f0
Call Trace:
  ? snprintf+0x39/0x40
  fw_get_filesystem_firmware+0xe2/0x270
  _request_firmware+0x21e/0x500
  request_firmware+0x32/0x50
  test_firmware_resume.cold+0x4e/0xb2 [test_firmware]
  ? platform_pm_suspend+0x40/0x40
  dpm_run_callback+0x4c/0x120
  device_resume+0xa7/0x200
  dpm_resume+0xce/0x2c0
  dpm_resume_end+0xd/0x20
  suspend_devices_and_enter+0x195/0x750
  pm_suspend.cold+0x329/0x374
  state_store+0x71/0xd0
  kernfs_fop_write_iter+0x11c/0x1b0
  new_sync_write+0x108/0x180
  vfs_write+0x1b8/0x270
  ksys_write+0x4f/0xc0
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f4719a527a7
Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007ffee4d18e18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f4719a527a7
RDX: 0000000000000004 RSI: 00007ffee4d18f00 RDI: 0000000000000004
RBP: 00007ffee4d18f00 R08: 00005626b555c710 R09: 00007f4719ae84e0
R10: 00007f4719ae83e0 R11: 0000000000000246 R12: 0000000000000004
R13: 00005626b5558650 R14: 0000000000000004 R15: 00007f4719b25700
---[ end trace 7f7ef0dc067dd714 ]---
Trying to do direct read when not available
test_firmware test_firmware: loading /lib/firmware/updates/5.12.0-rc5+/test-firmware.bin failed with error -11
------------[ cut here ]------------
