Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810A879FD34
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 09:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjINH1e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 03:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjINH1d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 03:27:33 -0400
X-Greylist: delayed 60 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 00:27:29 PDT
Received: from outbound1p.ore.mailhop.org (outbound1p.ore.mailhop.org [54.149.210.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF14F3
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 00:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694676388; cv=none;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        b=ewBFkKzD1gSHfgJTMmUf2bmPWcd1QSxUp8JsIhfeKfkdg5bLBHRYRkCHggkz8eBAb352/snoi+DzQ
         dS8iDpWlUkOM6xCva6EA6mD/w73rzvqnNuvALmZmAJ+WmEnWcTACwS2P+WYTdWwjq9ALJ07p5YEcHP
         wyB3zwCRgh8LSdRTGwK5fvCoV5WhJHRFhN790nrTHQ35onMHpLdOkxKHeTKCahpHLGN9Qyg0MiCQVD
         0lTjj3eqi7DtoXktjV9zwUkxmEhmldVQRDCpaJ22RGvOdEtVIgRfQUboo7OYcjH3Pp1GL2nC1xjvpC
         c/zs0HhbllbHJqMSVAvICiR8YurqikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=arc-outbound20181012;
        h=content-transfer-encoding:content-type:message-id:references:in-reply-to:
         subject:cc:to:from:date:mime-version:dkim-signature:dkim-signature:from;
        bh=H89pj98IExXTg64IPeazqKvdFCk3sf4OurM0HnPlWAA=;
        b=E6zspml5qwGXsZum+u1A9c+XoVufDVAdptJkl8dkAStasmUni+c30AFYjvKKwFwujteWkdkGZJE2r
         pOm/S7hibPO0xldx/7ow9rEHQD7QpxpdjSVUnoaFkA3oowk44KKOPTiWeLk+9BJLwRCgUwyfzC9cB9
         Cj/c+zBrzrZ6RDGkF3lLVPiUKDY0Foe62ybNM+kJG3Di8YAf/tLqAR1Yp+XE4ayaEILuVKQ6m8tK/a
         AvwIIT6BCspASIwITK2kUf6eZ0uTk5aRp6eIiZrNPTur34VDm6oMLYr6kmGGL1b1yEwMJI0y7BG/eD
         MdXhG8mRYMSDgwTI5gUcStUBmHm88cQ==
ARC-Authentication-Results: i=1; outbound3.ore.mailhop.org;
        spf=softfail smtp.mailfrom=bllue.org smtp.remote-ip=66.108.6.151;
        dmarc=none header.from=bllue.org;
        arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bllue.org; s=duo-1694650998788-390f10b9;
        h=content-transfer-encoding:content-type:message-id:references:in-reply-to:
         subject:cc:to:from:date:mime-version:from;
        bh=H89pj98IExXTg64IPeazqKvdFCk3sf4OurM0HnPlWAA=;
        b=sl1xFRCSEi68asgv+Owt9vkNFW9QekS1R9PXrZyBg3w2v770+OCHXgQYvP7fwTqOG3a5gDIJtuUwi
         JvprEypH/Cs95PXki1YHDdOzywJi8EXqWBxzubCdzQU/Gd6Hp+3I07dn1plRwzEPNjEc63wF98XWE9
         1CWAHKptMs6A+j0k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=outbound.mailhop.org; s=dkim-high;
        h=content-transfer-encoding:content-type:message-id:references:in-reply-to:
         subject:cc:to:from:date:mime-version:from;
        bh=H89pj98IExXTg64IPeazqKvdFCk3sf4OurM0HnPlWAA=;
        b=Zsc3a2j4nG/nIxAEohIt8/TSmEus0FSGYqBtjniX/aDePbE4QVqeLaj+3a3mWqOOlMYR03+o9lceb
         HRV7aF4v4pmQjWNtabAKYOGi2KGCdK45kN5L3CL43qyjc3r0jfszu9+ejze3dp21Yb0pQp//DpXvrt
         Ebd/B7h+Cu2c218+CoWqbgeDT0i0Up0wLTiJ7a5T1Fa8t2ALWZxss8HaPTGupg+SM0O3AQCVFBsDEn
         ND+YJTDMF/j7cwBbTpHUbziLnZHkTNjY0FUVpl3bZbFXxBpX6idUy/8SdEId98nbYzU7Ck3sq3WDC4
         iMZ2gqkZSSCvVHEwU1F3lYlChzAy0DA==
X-Originating-IP: 66.108.6.151
X-MHO-RoutePath: YmxsdWVfb3JnX2VtYWls
X-MHO-User: 007ef838-52d0-11ee-8626-d1581f149e9f
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from static.bllue.org (cpe-66-108-6-151.nyc.res.rr.com [66.108.6.151])
        by outbound3.ore.mailhop.org (Halon) with ESMTPSA
        id 007ef838-52d0-11ee-8626-d1581f149e9f;
        Thu, 14 Sep 2023 07:26:25 +0000 (UTC)
Received: from bllue.org (localhost.localdomain [127.0.0.1])
        by static.bllue.org (Postfix) with ESMTP id 3D2B6400138;
        Thu, 14 Sep 2023 03:26:16 -0400 (EDT)
MIME-Version: 1.0
Date:   Thu, 14 Sep 2023 03:26:16 -0400
From:   Kenneth Topp <ken@bllue.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: delayed dir index insertion failure
In-Reply-To: <ZQBJC+lhiiLnBYJ/@debian0.Home>
References: <CAE6xmH+Lp=Q=E61bU+v9eWX8gYfLvu6jLYxjxjFpo3zHVPR0EQ@mail.gmail.com>
 <ZQBJC+lhiiLnBYJ/@debian0.Home>
Message-ID: <e0bfd50b13c89fa431062d8a413aeed9@bllue.org>
X-Sender: ken@bllue.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-14) on static.bllue.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2023-09-12 07:18, Filipe Manana wrote:
> On Mon, Sep 11, 2023 at 11:14:49PM -0400, ken wrote:
>> I've been getting these reliably, so I switched to stock fedora 38
>> kernel, and I recreated the filesystem and repopulated the data from
>> backups (the filesystem failed btrfs check, didn't save the output of
>> that).  But with a fresh filesystem and all data recovered it's still
>> triggering.  Filesystem is   created "-O no-holes -d single -m raid1"
>> ontop two dm-crypt block devices.
>> mount options are "defaults,noatime,space_cache=v2"
>> 
>> I've seen some recent patches for this, not sure if that's a fix or
>> just improved diagnostics.  Happy to try something out to try to get
>> to the root cause.  The machine is under extremely heavy load during
>> bootup, which is mostly services putting in io requests which I
>> suspect could be involved.
>> 
>> details below,
> 
> Thanks for the report.
> 
> This should be the same that syzbot reported about a week ago.
> I've just sent a fix for it:
> 
> https://lore.kernel.org/linux-btrfs/903764240e39987ca676cd02913a836b3b4930c8.1694515104.git.fdmanana@suse.com/
> 
> This won't apply cleanly without the following recent patchset:
> 
> https://lore.kernel.org/linux-btrfs/cover.1694260751.git.fdmanana@suse.com/
> 
> But it's independent of it actually.
> 
> Thnaks.
> 

Unfortunately, I was not able to reproduce the issue anymore with the 
same kernel that was triggering the BUG constantly on boot up. I have 
booted up 6.4.16-rc1 both with and without your additional patches, and 
no occurrence of the issue there as well.  So unfortunately, I cannot 
say this fixed the issue, but at least I can say it's not any worse.  I 
will be running with these patches until they are upstream, and will 
report anything unexpected.

Thanks,

Ken

>> 
>> ken
>> 
>> Sep 11 22:33:09 myhostname kernel: Linux version
>> 6.4.15-200.fc38.x86_64 (mockbuild@2e6cd98d8465441c8330a02794035256)
>> (gcc (GCC) 13.2.1 20230728 (Red Hat 13.2.1-1), GNU ld version
>> 2.39-9.fc38) #1 SMP PREEMPT_DYNAMIC Thu Sep  7 00:25:01 UTC 2023
>> Sep 11 22:33:09 myhostname kernel: Command line:
>> BOOT_IMAGE=(hd0,msdos1)/vmlinuz-6.4.15-200.fc38.x86_64
>> root=LABEL=r3-root ro slub_debug=- usbcore.autosuspend=-1 rd.md=0
>> rd.lvm=0 rd.dm=0 libata.allow_tpm=1 vconsole.keymap=us rd.luks=0
>> vconsole.font
>> =latarcyrheb-sun16 quiet systemd.show_status=1 selinux=0 
>> mitigations=off
>> 
>> 
>> 
>> 
>> Sep 11 22:34:59 myhostname kernel: BTRFS error (device dm-3): err add
>> delayed dir index item(name: cockroach-stderr.log) into the insertion
>> tree of the delayed node(root id: 5, inode id: 4539217, errno: -17)
>> Sep 11 22:34:59 myhostname kernel: ------------[ cut here 
>> ]------------
>> Sep 11 22:34:59 myhostname kernel: kernel BUG at 
>> fs/btrfs/delayed-inode.c:1504!
>> Sep 11 22:34:59 myhostname kernel: invalid opcode: 0000 [#1] PREEMPT 
>> SMP NOPTI
>> Sep 11 22:34:59 myhostname kernel: CPU: 0 PID: 7159 Comm: cockroach
>> Not tainted 6.4.15-200.fc38.x86_64 #1
>> Sep 11 22:34:59 myhostname kernel: Hardware name: ASUS ESC500 G3/P9D
>> WS, BIOS 2402 06/27/2018
>> Sep 11 22:34:59 myhostname kernel: RIP:
>> 0010:btrfs_insert_delayed_dir_index+0x1da/0x260
>> Sep 11 22:34:59 myhostname kernel: Code: eb dd 48 8b 43 10 4c 8b 0b 44
>> 89 e2 48 c7 c6 00 3a 91 85 48 8b 7d 50 4c 8b 80 f7 01 00 00 41 57 48
>> 8b 4c 24 08 e8 56 67 04 00 <0f> 0b 65 8b 05 b9 e9 9c 7b 89 c0 48 0f a3
>> 05 c3 f0 cb 01 0f 83 2f
>> Sep 11 22:34:59 myhostname kernel: RSP: 0000:ffffa9980e0fbb28 EFLAGS: 
>> 00010282
>> Sep 11 22:34:59 myhostname kernel: RAX: 0000000000000000 RBX:
>> ffff8b10b8f4a3c0 RCX: 0000000000000000
>> Sep 11 22:34:59 myhostname kernel: RDX: 0000000000000000 RSI:
>> ffff8b177ec21540 RDI: ffff8b177ec21540
>> Sep 11 22:34:59 myhostname kernel: RBP: ffff8b110cf80888 R08:
>> 0000000000000000 R09: ffffa9980e0fb938
>> Sep 11 22:34:59 myhostname kernel: R10: 0000000000000003 R11:
>> ffffffff86146508 R12: 0000000000000014
>> Sep 11 22:34:59 myhostname kernel: R13: ffff8b1131ae5b40 R14:
>> ffff8b10b8f4a418 R15: 00000000ffffffef
>> Sep 11 22:34:59 myhostname kernel: FS:  00007fb14a7fe6c0(0000)
>> GS:ffff8b177ec00000(0000) knlGS:0000000000000000
>> Sep 11 22:34:59 myhostname kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Sep 11 22:34:59 myhostname kernel: CR2: 000000c00143d000 CR3:
>> 00000001b3b4e002 CR4: 00000000001706f0
>> Sep 11 22:34:59 myhostname kernel: Call Trace:
>> Sep 11 22:34:59 myhostname kernel:  <TASK>
>> Sep 11 22:34:59 myhostname kernel:  ? die+0x36/0x90
>> Sep 11 22:34:59 myhostname kernel:  ? do_trap+0xda/0x100
>> Sep 11 22:34:59 myhostname kernel:  ? 
>> btrfs_insert_delayed_dir_index+0x1da/0x260
>> Sep 11 22:34:59 myhostname kernel:  ? do_error_trap+0x6a/0x90
>> Sep 11 22:34:59 myhostname kernel:  ? 
>> btrfs_insert_delayed_dir_index+0x1da/0x260
>> Sep 11 22:34:59 myhostname kernel:  ? exc_invalid_op+0x50/0x70
>> Sep 11 22:34:59 myhostname kernel:  ? 
>> btrfs_insert_delayed_dir_index+0x1da/0x260
>> Sep 11 22:34:59 myhostname kernel:  ? asm_exc_invalid_op+0x1a/0x20
>> Sep 11 22:34:59 myhostname kernel:  ? 
>> btrfs_insert_delayed_dir_index+0x1da/0x260
>> Sep 11 22:34:59 myhostname kernel:  ? 
>> btrfs_insert_delayed_dir_index+0x1da/0x260
>> Sep 11 22:34:59 myhostname kernel:  btrfs_insert_dir_item+0x200/0x280
>> Sep 11 22:34:59 myhostname kernel:  btrfs_add_link+0xab/0x4f0
>> Sep 11 22:34:59 myhostname kernel:  ? ktime_get_real_ts64+0x47/0xe0
>> Sep 11 22:34:59 myhostname kernel:  btrfs_create_new_inode+0x7cd/0xa80
>> Sep 11 22:34:59 myhostname kernel:  btrfs_symlink+0x190/0x4d0
>> Sep 11 22:34:59 myhostname kernel:  ? schedule+0x5e/0xd0
>> Sep 11 22:34:59 myhostname kernel:  ? __d_lookup+0x7e/0xc0
>> Sep 11 22:34:59 myhostname kernel:  vfs_symlink+0x148/0x1e0
>> Sep 11 22:34:59 myhostname kernel:  do_symlinkat+0x130/0x140
>> Sep 11 22:34:59 myhostname kernel:  __x64_sys_symlinkat+0x3d/0x50
>> Sep 11 22:34:59 myhostname kernel:  do_syscall_64+0x5d/0x90
>> Sep 11 22:34:59 myhostname kernel:  ? 
>> syscall_exit_to_user_mode+0x2b/0x40
>> Sep 11 22:34:59 myhostname kernel:  ? do_syscall_64+0x6c/0x90
>> Sep 11 22:34:59 myhostname kernel:  
>> entry_SYSCALL_64_after_hwframe+0x72/0xdc
>> Sep 11 22:34:59 myhostname kernel: RIP: 0033:0x83d8d0
>> Sep 11 22:34:59 myhostname kernel: Code: 8b 7c 24 10 48 8b 74 24 18 48
>> 8b 54 24 20 49 c7 c2 00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00
>> 00 00 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff
>> ff ff ff 48 c7 44 24 30
>> Sep 11 22:34:59 myhostname kernel: RSP: 002b:000000c0012b4588 EFLAGS:
>> 00000212 ORIG_RAX: 000000000000010a
>> Sep 11 22:34:59 myhostname kernel: RAX: ffffffffffffffda RBX:
>> 000000c000080000 RCX: 000000000083d8d0
>> Sep 11 22:34:59 myhostname kernel: RDX: 000000c000d98f00 RSI:
>> ffffffffffffff9c RDI: 000000c000894680
>> Sep 11 22:34:59 myhostname kernel: RBP: 000000c0012b45f0 R08:
>> 0000000000000000 R09: 0000000000000000
>> Sep 11 22:34:59 myhostname kernel: R10: 0000000000000000 R11:
>> 0000000000000212 R12: ffffffffffffffff
>> Sep 11 22:34:59 myhostname kernel: R13: 0000000000000031 R14:
>> 0000000000000030 R15: 0000000000000066
>> Sep 11 22:34:59 myhostname kernel:  </TASK>
>> Sep 11 22:34:59 myhostname kernel: Modules linked in: rpcrdma rdma_cm
>> iw_cm ib_cm ib_core nf_conntrack_netlink br_netfilter tun wireguard
>> curve25519_x86_64 libcurve25519_generic ip6_udp_tunnel udp_tunnel
>> ip6table_nat ip6table_filter des_generic lib
>> des md4 nf_log_syslog nft_log nft_limit nft_reject_inet nf_reject_ipv4
>> nf_reject_ipv6 nft_reject xt_conntrack iptable_filter nft_ct
>> xt_multiport xt_nat xt_addrtype nft_masq xt_mark nft_redir
>> xt_MASQUERADE xt_comment iptable_nat veth nft_nat bridge nft_ch
>> ain_nat stp nf_nat llc nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
>> overlay nf_tables nfnetlink nct6775 nct6775_core hwmon_vid jc42
>> binfmt_misc ir_rc6_decoder rc_rc6_mce ir_toy cdc_acm cdc_mbim cdc_wdm
>> cdc_ncm cdc_ether usbnet hid_logitech_hidpp joydev dm_
>> crypt hid_logitech_dj intel_rapl_msr amdgpu ppdev r8152 at24 mii
>> mei_hdcp mei_pxp iTCO_wdt intel_pmc_bxt iTCO_vendor_support
>> intel_rapl_common rt73usb x86_pkg_temp_thermal rt2x00usb rt2x00lib
>> intel_powerclamp coretemp iwlmvm r820t kvm_intel snd_hda_codec
>> _realtek rtl2832 snd_hda_codec_generic i2c_mux
>> Sep 11 22:34:59 myhostname kernel:  snd_hda_codec_hdmi kvm mac80211
>> irqbypass dvb_usb_rtl28xxu snd_hda_intel rapl snd_usb_audio eeepc_wmi
>> snd_intel_dspcfg iommu_v2 snd_intel_sdw_acpi dvb_usb_v2 drm_buddy
>> iwlwifi dvb_core asus_wmi snd_hda_codec snd_
>> usbmidi_lib ledtrig_audio snd_rawmidi gpu_sched sparse_keymap libarc4
>> platform_profile snd_hda_core mc wmi_bmof intel_cstate intel_uncore
>> snd_hwdep drm_suballoc_helper mxm_wmi pcspkr snd_seq i2c_i801
>> drm_ttm_helper cfg80211 snd_seq_device i2c_smbus ttm s
>> nd_pcm drm_display_helper lpc_ich mei_me mei snd_timer cec snd
>> soundcore rfkill ie31200_edac parport_pc parport nfsd auth_rpcgss
>> nfs_acl lockd grace sunrpc loop zram usb_storage crct10dif_pclmul
>> crc32_pclmul crc32c_intel polyval_clmulni polyval_generic f
>> irewire_ohci ghash_clmulni_intel firewire_core sha512_ssse3 crc_itu_t
>> mpt3sas igb i2c_algo_bit raid_class dca scsi_transport_sas video wmi
>> scsi_dh_rdac scsi_dh_emc scsi_dh_alua ip6_tables ip_tables
>> pkcs8_key_parser dm_multipath i2c_dev fuse
>> Sep 11 22:34:59 myhostname kernel: ---[ end trace 0000000000000000 
>> ]---
>> Sep 11 22:34:59 myhostname kernel: RIP:
>> 0010:btrfs_insert_delayed_dir_index+0x1da/0x260
>> Sep 11 22:34:59 myhostname kernel: Code: eb dd 48 8b 43 10 4c 8b 0b 44
>> 89 e2 48 c7 c6 00 3a 91 85 48 8b 7d 50 4c 8b 80 f7 01 00 00 41 57 48
>> 8b 4c 24 08 e8 56 67 04 00 <0f> 0b 65 8b 05 b9 e9 9c 7b 89 c0 48 0f a3
>> 05 c3 f0 cb 01 0f 83 2f
>> Sep 11 22:34:59 myhostname kernel: RSP: 0000:ffffa9980e0fbb28 EFLAGS: 
>> 00010282
>> Sep 11 22:34:59 myhostname kernel: RAX: 0000000000000000 RBX:
>> ffff8b10b8f4a3c0 RCX: 0000000000000000
>> Sep 11 22:34:59 myhostname kernel: RDX: 0000000000000000 RSI:
>> ffff8b177ec21540 RDI: ffff8b177ec21540
>> Sep 11 22:34:59 myhostname kernel: RBP: ffff8b110cf80888 R08:
>> 0000000000000000 R09: ffffa9980e0fb938
>> Sep 11 22:34:59 myhostname kernel: R10: 0000000000000003 R11:
>> ffffffff86146508 R12: 0000000000000014
>> Sep 11 22:34:59 myhostname kernel: R13: ffff8b1131ae5b40 R14:
>> ffff8b10b8f4a418 R15: 00000000ffffffef
>> Sep 11 22:34:59 myhostname kernel: FS:  00007fb14a7fe6c0(0000)
>> GS:ffff8b177ec00000(0000) knlGS:0000000000000000
>> Sep 11 22:34:59 myhostname kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>> 0000000080050033
>> Sep 11 22:34:59 myhostname kernel: CR2: 000000c00143d000 CR3:
>> 00000001b3b4e002 CR4: 00000000001706f0
