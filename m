Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8B872B6DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 06:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbjFLEtP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 00:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbjFLEsh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 00:48:37 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CD2173C
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jun 2023 21:47:53 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-559b0ddcd4aso2114974eaf.0
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jun 2023 21:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686545270; x=1689137270;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ySqq7sqiNMdZA9OMo1TptNOkackh/DQ61dG8r4SDh2M=;
        b=TrwvRiwOuuLNaazzhJuRAscFyMFwDe7cELP9zrnAbLtnqBEOewrvM2/faFSEh+Af76
         8zAufLLZah/w1MADNthK1+lY964oItxqQfzC9Q823Jjz4GUtw21bG9FTzRWFJFOejfWp
         6gZTBg61QUj9+UudLi0Iuq+mxmD1UzWnXCsAvg+BHA6jATGVuoK2rDNOl9mSX8iyS/yh
         eQ6KYzFoUt2L5zKR7uCUyACA95B5qojf74l45fOL+VIGd+0CaeDQd3+tLUiLn0TSWydj
         FHRaYiseW3OOKpVuZQ+2zjFKOQHohJZWHs4KnYxjAaRIxU7XjThBVBj+8MJo8eAv/fFO
         g9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686545270; x=1689137270;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySqq7sqiNMdZA9OMo1TptNOkackh/DQ61dG8r4SDh2M=;
        b=JMXWCcH+5g4NJkVlZFHOdSiAtrlgKjXs2bU5Ol1jjmgW1dRx9AWol2HMZjvKp7nlyo
         9A6Te00XBLf++S7koa9pr7T9pfn1Mp38czlByefRWTlEvjKUSN22d5Kxx8NvTq8jOcxb
         0XdbEVbVAbhTYV1wDjQUkO7bl6wm1bEXoZrtYJhenI8S5OY8mnWHmKnrWYEEHZ1N4qYV
         vkXhLlbXmmoI9aLwsrn9F5xAWbC2Tpai6snpX+hFyzptrNec0OuwTa0Z+WaQY45CvxKh
         B/VR7J+qgV30hf/tlVNVBtdkPSxyxA6Go/0QQWzpGGre5znEewdW2bM37BnkrLG/Jkmc
         pRHQ==
X-Gm-Message-State: AC+VfDzJOHetBa2xCHPKizaS/LvgGTUgsqnKdHDXuu6WgMUyyQnYDsCx
        SZHiszLMWgBsF9iW1wtXI+0c/Ah83X8Lh6GR+lxyA63P2Dqkog==
X-Google-Smtp-Source: ACHHUZ5HJB+LxO/nbq0K52npWxskEHnkl6dcQPIi93qkZSF4Mr9txeEI5amws2HUlF9j+KC6r7Bkhk+QOLD3u6AaYyA=
X-Received: by 2002:a4a:d542:0:b0:55a:7bfe:2df3 with SMTP id
 q2-20020a4ad542000000b0055a7bfe2df3mr4063306oos.8.1686545269813; Sun, 11 Jun
 2023 21:47:49 -0700 (PDT)
MIME-Version: 1.0
From:   Stefan N <stefannnau@gmail.com>
Date:   Mon, 12 Jun 2023 14:17:38 +0930
Message-ID: <CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com>
Subject: Out of space loop: skip_balance not working
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm having trouble trying to break my array out of an out of space loop.

On reboot I'm able to mount the filesystem and read files fine but as
soon as I try to delete/write it hangs until the mount is made read
only when it then fails.

The following command (immediately after boot, no fstab) suggests
perhaps the skip_balance is not working as expected:
$ mount -o skip_balance -t btrfs /dev/sde /mnt/point && btrfs device
add /dev/loop12 /mnt/point/
ERROR: unable to start device add, another exclusive operation
'balance' in progress
and ps shows a [btrfs-balance] process.

If I perform a rm or truncate during this window it fails to perform
any action before being marked read only. The same applies if I
attempt to cancel the balance.

How can I get out of this cycle? I've previously run out of space and
been able to recover by deleting a few files etc without needing to
invoke skip_balance, but that was likely on older versions.

Any help would be greatly appreciated.

- Stefan

$ uname -a
Linux my.host 5.15.0-73-generic #80-Ubuntu SMP Mon May 15 15:18:26 UTC
2023 x86_64 x86_64 x86_64 GNU/Linux
$ btrfs --version
btrfs-progs v5.16.2
$ btrfs fi show
Label: none  uuid: ---
        Total devices 8 FS bytes used 64.67TiB
        devid    1 size 10.91TiB used 10.91TiB path /dev/sdk
        devid    2 size 10.91TiB used 10.91TiB path /dev/sdh
        devid    3 size 10.91TiB used 10.91TiB path /dev/sdj
        devid    4 size 10.91TiB used 10.91TiB path /dev/sdi
        devid    5 size 10.91TiB used 10.91TiB path /dev/sdf
        devid    6 size 10.91TiB used 10.91TiB path /dev/sdg
        devid    7 size 10.91TiB used 10.91TiB path /dev/sdd
        devid    8 size 10.91TiB used 10.91TiB path /dev/sde
$ btrfs fi df /mnt/point/
Data, RAID6: total=64.76TiB, used=64.59TiB
System, RAID1C4: total=37.00MiB, used=5.11MiB
Metadata, RAID1C4: total=77.79GiB, used=77.10GiB
GlobalReserve, single: total=512.00MiB, used=387.11MiB
$

BTRFS: Transaction aborted (error -28)
BTRFS: error (device sdk) in __btrfs_free_extent:3180: errno=-28 No space left
BTRFS info (device sdk): forced readonly
BTRFS error (device sdk): failed to run delayed ref for logical
101911627694080 num_bytes 126976 type 184 action 2 ref_mod 1: -28
WARNING: CPU: 2 PID: 7851 at fs/btrfs/extent-tree.c:3180
__btrfs_free_extent+0x7e4/0x950 [btrfs]
BTRFS: error (device sdk) in btrfs_run_delayed_refs:2152: errno=-28 No
space left
BTRFS warning (device sdk): btrfs_uuid_scan_kthread failed -28
Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_nat
xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 xfrm_user xfrm_algo nft_counter xt_addrtype nft_compat
nf_tables nfnetlink br_netfilter bridge stp llc ipmi_devintf
ipmi_msghandler overlay binfmt_misc intel_rapl_msr intel_rapl_common
edac_mce_amd snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
snd_hda_codec_hdmi kvm_amd nls_iso8859_1 kvm snd_hda_intel rapl
snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core
wmi_bmof input_leds snd_hwdep snd_pcm k10temp snd_timer snd ccp
soundcore mac_hid sch_fq_codel dm_multipath scsi_dh_rdac scsi_dh_emc
scsi_dh_alua bonding tls ramoops pstore_blk msr reed_solomon
pstore_zone efi_pstore nfsd auth_rpcgss nfs_acl lockd grace sunrpc
ip_tables x_tables autofs4 btrfs blake2b_generic zstd_compress raid10
raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor
raid6_pq libcrc32c raid1 raid0 multipath linear
hid_generic usbhid hid uas usb_storage amdgpu iommu_v2 gpu_sched
drm_ttm_helper crct10dif_pclmul ttm drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops crc32_pclmul cec ghash_clmulni_intel
aesni_intel mpt3sas rc_core raid_class crypto_simd drm nvme i2c_piix4
cryptd scsi_transport_sas igb dca ahci libahci xhci_pci qlcnic
i2c_algo_bit nvme_core xhci_pci_renesas wmi video
CPU: 2 PID: 7851 Comm: btrfs-transacti Not tainted 5.15.0-73-generic #80-Ubuntu
Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
P3.70 02/23/2022
RIP: 0010:__btrfs_free_extent+0x7e4/0x950 [btrfs]
Code: a0 48 05 50 0a 00 00 f0 48 0f ba 28 03 72 1d 8b 45 84 83 f8 fb
74 32 83 f8 e2 74 2d 89 c6 48 c7 c7 98 f6 34 c1 e8 ed 42 a9 e6 <0f> 0b
8b 4d 84 48 8b 7d 90 ba 6c 0c 00 00 48 c7 c6 60 39 34 c1 e8
RSP: 0018:ffffb63581c9fb68 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 00000000000000d1 RCX: 0000000000000027
RDX: ffff8ceda0aa0588 RSI: 0000000000000001 RDI: ffff8ceda0aa0580
RBP: ffffb63581c9fc10 R08: 0000000000000003 R09: fffffffffffe2710
R10: 000000002938322d R11: 00000000322d2072 R12: 00005cb02659c000
R13: 00000000000014ce R14: ffff8ce8ab3fb7e0 R15: ffff8ce8de433800
FS:  0000000000000000(0000) GS:ffff8ceda0a80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f2f46bb4c8 CR3: 000000010814c000 CR4: 00000000003506e0
Call Trace:
<TASK>
run_delayed_data_ref+0x93/0x160 [btrfs]
btrfs_run_delayed_refs_for_head+0x193/0x520 [btrfs]
__btrfs_run_delayed_refs+0x8c/0x1d0 [btrfs]
btrfs_run_delayed_refs+0x73/0x200 [btrfs]
btrfs_start_dirty_block_groups+0x296/0x4f0 [btrfs]
btrfs_commit_transaction+0x716/0xaa0 [btrfs]
? start_transaction+0xd1/0x5b0 [btrfs]
? __bpf_trace_hrtimer_init+0x20/0x20
transaction_kthread+0x13c/0x1b0 [btrfs]
? btrfs_cleanup_transaction.isra.0+0x3c0/0x3c0 [btrfs]
kthread+0x12a/0x150
? set_kthread_struct+0x50/0x50
ret_from_fork+0x22/0x30
</TASK>
---[ end trace 8a20922ac453f776 ]---
BTRFS: error (device sdk) in __btrfs_free_extent:3180: errno=-28 No space left
BTRFS error (device sdk): failed to run delayed ref for logical
101911627415552 num_bytes 126976 type 184 action 2 ref_mod 1: -28
BTRFS: error (device sdk) in btrfs_run_delayed_refs:2152: errno=-28 No
space left
