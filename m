Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260E46D3BD9
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Apr 2023 04:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjDCCh3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Apr 2023 22:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDCCh2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Apr 2023 22:37:28 -0400
X-Greylist: delayed 1469 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Apr 2023 19:37:25 PDT
Received: from se2.syd.hostingplatform.net.au (se2.syd.hostingplatform.net.au [IPv6:2400:b800:3:1::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77836AF3C
        for <linux-btrfs@vger.kernel.org>; Sun,  2 Apr 2023 19:37:25 -0700 (PDT)
Received: from s02bd.syd2.hostingplatform.net.au ([103.27.32.42])
        by se2.syd.hostingplatform.net.au with esmtps (TLSv1.2:AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <linuxkernel@edcint.co.nz>)
        id 1pj9gg-0002iQ-1M
        for linux-btrfs@vger.kernel.org; Mon, 03 Apr 2023 12:12:54 +1000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:Subject:
        From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vKL5VN5gEQytIjk8tgLNF3KbIDpDvWDJGFzXtSxN0og=; b=RkutDj0aRb5FEnG5hF3n3jXZf2
        ISLWi4BnkRVvpL2MYD3nYHt53ENWGk1VhLOzadIea+IrgEM5+lA6jiRoIJYZJnnjrYx/sWGg1H072
        HwLkpcn7Xbc+OzIMHymrNt/l8X0K4n5TUclMc8e+OxUKMkCw7CNgu6j84ZNxK+lFr8DPcYRP1HP5L
        vs4kybdJ/ngwuphTKqXShV/P9JbdyVwGiwNNWfOK4K6AHrMJQJf/gNZ+pYFgF1Ut7hIswHRqfpDuN
        wM9f6PSPPE8qlysCCZKPhTuq3hVz6U9RNnL22+8wCOabf8tLHatwYh79hwNqIgbxIRDoKS6m8PVC8
        klSrMUjw==;
Received: from [159.196.20.165] (port=17363 helo=[192.168.2.80])
        by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <linuxkernel@edcint.co.nz>)
        id 1pj9gf-000ZzW-2A
        for linux-btrfs@vger.kernel.org;
        Mon, 03 Apr 2023 12:12:49 +1000
Message-ID: <01bc2043-28ea-905e-44f2-de61cd86934e@edcint.co.nz>
Date:   Mon, 3 Apr 2023 12:12:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To:     linux-btrfs@vger.kernel.org
Content-Language: en-US
From:   Matthew Jurgens <linuxkernel@edcint.co.nz>
Subject: Readonly file system: __btrfs_unlink_inode:4325: errno=-2 No such
 entry
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s02bd.syd2.hostingplatform.net.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - edcint.co.nz
X-Get-Message-Sender-Via: s02bd.syd2.hostingplatform.net.au: authenticated_id: default@edcint.co.nz
X-Authenticated-Sender: s02bd.syd2.hostingplatform.net.au: default@edcint.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Originating-IP: 103.27.32.42
X-SpamExperts-Domain: out-2.hostyourservices.net
X-SpamExperts-Username: 103.27.32.42
Authentication-Results: syd.hostingplatform.net.au; auth=pass smtp.auth=103.27.32.42@out-2.hostyourservices.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00152521522048)
X-Recommended-Action: accept
X-Filter-ID: Pt3MvcO5N4iKaDQ5O6lkdGlMVN6RH8bjRMzItlySaT9+ZFNNFHvR34f+xGWypjguPUtbdvnXkggZ
 3YnVId/Y5jcf0yeVQAvfjHznO7+bT5ztW2DfCmdqRCMoho/8w6SaWy8Zi3U/W0AnUgWIBqewEKvp
 k7Vp2UXVHEQMIct0liIFenrlVPFN7JLWYeTEMH4MswKQDamPN66SYe4XX4xmgLCYsio9CJXI1dEg
 ssO98q8hUArge52zFlDybzC33IYWpuGXed8VjoeeEKguXydrkTGNg+WW4Te4WbcL+p/1yxbQmiJo
 jrfzAYCmmhKpeMYWCEUAwjbHRjDQBE7lprbCYP5h9t+Rsczj3XfeY2wzO8rM7XUFEqpPwHi4uufu
 LPy68sEzNshBxIbwvSM7MvzRDUzENyoN4S9qF8+QOROUf3UuBpCeYXwfqlroHwxMrWWKAAn0bQYy
 8xI4CGTS1oSPzJkRDwCGfz1JXQHWqw9OMCYI1buGfzBzbPwORezig0Kivdn+kS0d+AZnld5hVrcw
 Voljc3cdkir05kMDTgrRv8/dAGQ93WWVSHcYlg6mr/IfPd0rEuGjFyZoidhtHm+WoTjHVFmIiC2y
 A3TZpzDYma9zrN6CcT8EzqRdkOJxtLfoQ/N/j0g56pGmhVr4ZF6hb8PH12Bh87aa4YfZs104p87O
 ifVovUq7COge14oi3y0trSOIPpeqwlm2NDGXIJ2x7ILGWCPhBwAkn5iw/flc3EziU5Z2qXJ2/64p
 fmIoNwzj0Md/pVOWXwGRf11oiSygJ23OAbMpQA6t67cxz8flHKC9/iV1OO/e1B4mqzS3OBAZLPde
 C2osMQ2uc367tvJ8uqBlkBL2blkAqDWoat5k50UA5OPWaRQMwUC9AJJ79P9b91IyW7bVDpANUQvy
 ZzPgigTugv1leQFvfCG5Mo+bZdpTqMD4genGMCojY6KY8bTQflbSThDH1qjNcR328PWpNqmCT+WD
 Vl7mMFEDbEvOkCuqGEkV3K6+lm/jPpYZ4zAFDg2SsGxokhHdHorIHTzGw32iM7shZiWRf9K1ROq9
 kLZK6Ae4w98/0207GSm/Qzdsq4qoolcF4fd6kXCLa0045u0jmh9MfC2OFpHHL4Gbc51zrN6CcT8E
 zqRdkOJxtLfo08DmSjWgtWB8NLFWEuJIvXapsh8uNBF2oMImqxAbwkWjUshJyKbsiLX+ZFMHepfC
 DTdrpIs2EnpDXb/iNlruMQ==
X-Report-Abuse-To: spam@se.syd.hostingplatform.net.au
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a RAID0 btrfs filesystem that worked for a long time without 
errors. After being mounted by the system it would show the following in 
the mount output:

/dev/sda on /export/duplicate type btrfs 
(ro,relatime,degraded,compress=zstd:1,space_cache,subvolid=5,subvol=/,x-systemd.automount)

Now, every few days it goes read only. After the fault, when I look, the 
mount output now looks like:

systemd-1 on /export/duplicate type autofs 
(rw,relatime,fd=62,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=37662)
/dev/sda on /export/duplicate type btrfs 
(ro,relatime,degraded,compress=zstd:1,space_cache,subvolid=5,subvol=/,x-systemd.automount)

The effect is that it is, in fact, read only.

I can umount it (twice) to clear all the mounts and then remount it. 
Then it works again until the problem occurs again.

I get the following in the messages file:

Apr  3 02:27:59 gw kernel: BTRFS info (device sda): failed to delete 
reference to dd02f3c3-e4fe-4f63-b908-bd11845475af@starship.eml, inode 
146458293 parent 168755802
Apr  3 02:27:59 gw kernel: ------------[ cut here ]------------
Apr  3 02:27:59 gw kernel: WARNING: CPU: 6 PID: 662157 at 
fs/btrfs/inode.c:4325 __btrfs_unlink_inode.cold+0x5a/0xcc
Apr  3 02:27:59 gw kernel: Modules linked in: nls_utf8 cifs cifs_arc4 
cifs_md4 dns_resolver fscache netfs tls snd_seq_dummy snd_hrtimer tun 
rpcrdma rdma_cm iw_cm ib_cm ib_core vboxnetadp(OE) vboxnetflt(OE) 
vboxdrv(OE) qrtr nft_chain_nat nf_nat ipt_REJECT nf_reject_ipv4 
xt_multiport xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 nft_compat nf_tables nct6775 nfnetlink nct6775_core 
hwmon_vid vfat fat intel_rapl_msr iTCO_wdt intel_pmc_bxt 
iTCO_vendor_support mei_pxp mei_hdcp pmt_telemetry pmt_class 
intel_rapl_common intel_tcc_cooling x86_pkg_temp_thermal 
intel_powerclamp coretemp kvm_intel kvm irqbypass rapl intel_cstate 
intel_uncore asus_nb_wmi asus_wmi sparse_keymap platform_profile rfkill 
wmi_bmof rc_dib0700_rc5 snd_sof_pci_intel_tgl snd_sof_intel_hda_common 
soundwire_intel soundwire_generic_allocation soundwire_cadence 
snd_sof_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_utils 
snd_soc_hdac_hda snd_hda_ext_core snd_soc_acpi_intel_match snd_soc_acpi 
soundwire_bus
Apr  3 02:27:59 gw kernel: snd_soc_core snd_compress snd_hda_codec_hdmi 
ac97_bus snd_pcm_dmaengine snd_hda_intel snd_intel_dspcfg 
snd_intel_sdw_acpi snd_hda_codec i2c_i801 snd_hda_core i2c_smbus 
uvcvideo mei_me videobuf2_vmalloc videobuf2_memops snd_usb_audio mei 
dib7000p videobuf2_v4l2 videobuf2_common dvb_usb_dib0700 snd_usbmidi_lib 
snd_seq snd_hwdep snd_rawmidi dib7000m videodev dib0090 snd_seq_device 
dib0070 snd_pcm dib3000mc dibx000_common dvb_usb snd_timer dvb_core snd 
ch341 soundcore mc idma64 intel_vsec acpi_tad acpi_pad nfsd auth_rpcgss 
nfs_acl lockd grace sunrpc fuse zram raid1 i915 crct10dif_pclmul 
crc32_pclmul crc32c_intel drm_buddy drm_display_helper nvme igc 
nvme_core ghash_clmulni_intel uas cec usb_storage ttm vmd wmi video 
pinctrl_alderlake
Apr  3 02:27:59 gw kernel: Unloaded tainted modules: pcc_cpufreq():1 
pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1
Apr  3 02:27:59 gw kernel: acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 eeepc_wmi():1 
pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
pcc_cpufreq():1
Apr  3 02:27:59 gw kernel: acpi_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1
Apr  3 02:27:59 gw kernel: pcc_cpufreq():1 acpi_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
fjes():1 acpi_cpufreq():1 pcc_cpufreq():1 fjes():1 acpi_cpufreq():1 
pcc_cpufreq():1 fjes():1 acpi_cpufreq():1 pcc_cpufreq():1 fjes():1 
acpi_cpufreq():1 pcc_cpufreq():1 fjes():1 pcc_cpufreq():1 
acpi_cpufreq():1 fjes():1 pcc_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 fjes():1 acpi_cpufreq():1 acpi_cpufreq():1 fjes():1 
pcc_cpufreq():1 fjes():1 acpi_cpufreq():1 pcc_cpufreq():1 
pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 
pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 
pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
Apr  3 02:27:59 gw kernel: pcc_cpufreq():1 pcc_cpufreq():1 
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 
fjes():1 fjes():1 fjes():1 fjes():1 fjes():1 fjes():1 fjes():1 fjes():1 
fjes():1
Apr  3 02:27:59 gw kernel: CPU: 6 PID: 662157 Comm: rm Tainted: 
G           OE     5.19.9-200.fc36.x86_64 #1
Apr  3 02:27:59 gw kernel: Hardware name: ASUS System Product Name/ROG 
STRIX Z690-G GAMING WIFI, BIOS 1403 03/30/2022
Apr  3 02:27:59 gw kernel: RIP: 0010:__btrfs_unlink_inode.cold+0x5a/0xcc
Apr  3 02:27:59 gw kernel: Code: 58 0a 00 00 f0 48 0f ba 2a 03 8b 45 a0 
72 20 83 f8 fb 74 66 83 f8 e2 74 61 89 c6 48 c7 c7 78 be 66 9c 89 45 b8 
e8 e8 7c fe ff <0f> 0b 8b 45 b8 48 8b 7d c0 89 c1 ba e5 10 00 00 89 45 
b8 48 c7 c6
Apr  3 02:27:59 gw kernel: RSP: 0018:ffffad2c8b433cc8 EFLAGS: 00010292
Apr  3 02:27:59 gw kernel: RAX: 0000000000000025 RBX: ffff9785589b59a8 
RCX: 0000000000000000
Apr  3 02:27:59 gw kernel: RDX: 0000000000000001 RSI: ffffffff9c6811a0 
RDI: 00000000ffffffff
Apr  3 02:27:59 gw kernel: RBP: ffffad2c8b433d30 R08: 0000000000000000 
R09: ffffad2c8b433b80
Apr  3 02:27:59 gw kernel: R10: 0000000000000003 R11: ffffffff9cf45d88 
R12: ffff978634160e28
Apr  3 02:27:59 gw kernel: R13: ffff9784051e81c0 R14: ffff97871b16b800 
R15: 000000000a0f025a
Apr  3 02:27:59 gw kernel: FS:  00007f9475892740(0000) 
GS:ffff97933f380000(0000) knlGS:0000000000000000
Apr  3 02:27:59 gw kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr  3 02:27:59 gw kernel: CR2: 00007fe7a05cfa88 CR3: 00000001d8de4003 
CR4: 0000000000772ee0
Apr  3 02:27:59 gw kernel: PKRU: 55555554
Apr  3 02:27:59 gw kernel: Call Trace:
Apr  3 02:27:59 gw kernel: <TASK>
Apr  3 02:27:59 gw kernel: ? mutex_lock+0xe/0x30
Apr  3 02:27:59 gw kernel: btrfs_unlink+0x83/0x100
Apr  3 02:27:59 gw kernel: vfs_unlink+0x10b/0x280
Apr  3 02:27:59 gw kernel: do_unlinkat+0xf4/0x2d0
Apr  3 02:27:59 gw kernel: __x64_sys_unlinkat+0x33/0x60
Apr  3 02:27:59 gw kernel: do_syscall_64+0x58/0x80
Apr  3 02:27:59 gw kernel: ? list_lru_add+0xf0/0x1a0
Apr  3 02:27:59 gw kernel: ? do_unlinkat+0x79/0x2d0
Apr  3 02:27:59 gw kernel: ? kmem_cache_free+0x140/0x380
Apr  3 02:27:59 gw kernel: ? do_unlinkat+0x79/0x2d0
Apr  3 02:27:59 gw kernel: ? syscall_exit_to_user_mode+0x17/0x40
Apr  3 02:27:59 gw kernel: ? do_syscall_64+0x67/0x80
Apr  3 02:27:59 gw kernel: entry_SYSCALL_64_after_hwframe+0x63/0xcd
Apr  3 02:27:59 gw kernel: RIP: 0033:0x7f947570314b
Apr  3 02:27:59 gw kernel: Code: 73 01 c3 48 8b 0d d5 4c 0f 00 f7 d8 64 
89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 07 
01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a5 4c 0f 00 f7 d8 
64 89 01 48
Apr  3 02:27:59 gw kernel: RSP: 002b:00007ffcc2532a28 EFLAGS: 00000246 
ORIG_RAX: 0000000000000107
Apr  3 02:27:59 gw kernel: RAX: ffffffffffffffda RBX: 0000557624f5a5a0 
RCX: 00007f947570314b
Apr  3 02:27:59 gw kernel: RDX: 0000000000000000 RSI: 0000557624f5a6a0 
RDI: 0000000000000005
Apr  3 02:27:59 gw kernel: RBP: 0000557624ea75a0 R08: 0000000000000003 
R09: 0000000000000000
Apr  3 02:27:59 gw kernel: R10: 0000557624f88f80 R11: 0000000000000246 
R12: 0000000000000000
Apr  3 02:27:59 gw kernel: R13: 00007ffcc2532b40 R14: 00007ffcc2532b40 
R15: 0000000000000000
Apr  3 02:27:59 gw kernel: </TASK>
Apr  3 02:27:59 gw kernel: ---[ end trace 0000000000000000 ]---
Apr  3 02:27:59 gw kernel: BTRFS: error (device sda: state A) in 
__btrfs_unlink_inode:4325: errno=-2 No such entry
Apr  3 02:27:59 gw kernel: BTRFS info (device sda: state EA): forced 
readonly


Other relevant info is:

Kernel: 5.19.9-200.fc36.x86_64

btrfs-progs v5.18

I have done a scrub and it turned up no errors

