Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24C41E585C
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2019 05:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfJZDge convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 25 Oct 2019 23:36:34 -0400
Received: from magic.merlins.org ([209.81.13.136]:49516 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfJZDgd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 23:36:33 -0400
Received: from svh-gw.merlins.org ([173.11.111.145]:44944 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtps 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1iOCsO-0007vC-P3; Fri, 25 Oct 2019 20:36:32 -0700
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1iOCsM-0007AY-NA; Fri, 25 Oct 2019 20:36:26 -0700
Date:   Fri, 25 Oct 2019 20:36:26 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Su Yue <Damenly_Su@gmx.com>
Message-ID: <20191026033626.GC5700@merlins.org>
References: <20180717205905.GB10237@merlins.org>
 <20180718002451.GF10237@merlins.org>
 <20191018025604.GA31526@merlins.org>
 <20191019030728.GA13323@merlins.org>
 <20191023005553.GF15771@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191023005553.GF15771@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 173.11.111.145
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Checker-Version: SpamAssassin 3.4.2-mmrules_20121111 (2018-09-13) on
        magic.merlins.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=7.0 tests=GREYLIST_ISWHITE,
        RCVD_IN_DNSWL_BLOCKED,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.2-mmrules_20121111
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: merlins.org]
        *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [173.11.111.145 listed in list.dnswl.org]
        *  1.0 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        * -1.5 GREYLIST_ISWHITE The incoming server has been whitelisted for
        *      this receipient and sender
Subject: Re: 5.1.21: fs/btrfs/extent-tree.c:7100
 __btrfs_free_extent+0x18b/0x921
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So, no reply at all.
No one cares about massive filesystem corruption in a recent enough
kernel?

On Tue, Oct 22, 2019 at 05:55:53PM -0700, Marc MERLIN wrote:
> On Fri, Oct 18, 2019 at 08:07:28PM -0700, Marc MERLIN wrote:
> > Ok, so before blowing the filesystem away after it was apparently badly
> > damaged by a suspend to disk, I tried check --repair and I hit an
> > infinite loop.
> > 
> > Let me know if you'd like anything off the FS before I delete it.
> 
> I heard nothing back, so I deleted the FS and restored from backup.
> 
> But now I'm scared of ever doing a suspend to disk again.
> Could someone please look at the logs and give me some idea of what
> happened, if at all possible?
> 
> Non recoverable data corruption on my laptop when I travel and
> backups/restores are complicated, is a bit unnerving...
> 
> Thanks,
> Marc
> 
> > Thanks,
> > Marc
> > 
> > enabling repair mode
> > repair mode will force to clear out log tree, are you sure? [y/N]: y
> > Checking filesystem on /dev/mapper/pool1
> > UUID: fda628bc-1ca4-49c5-91c2-4260fe967a23
> > checking extents
> > Backref 415334400 parent 36028797198598144 not referenced back 0x5648ef1870e0
> > Backref 415334400 parent 179634176 root 179634176 not found in extent tree
> > Incorrect global backref count on 415334400 found 2 wanted 1
> > backpointer mismatch on [415334400 16384]
> > repair deleting extent record: key 415334400 169 0
> > adding new tree backref on start 415334400 len 16384 parent 179634176 root 179634176
> > Repaired extent references for 415334400
> > ref mismatch on [101995261952 4096] extent item 36028797018963969, found 1
> > repair deleting extent record: key 101995261952 168 4096
> > adding new data backref on 101995261952 root 456 owner 74455677 offset 64892928 found 1
> > Repaired extent references for 101995261952
> > Incorrect local backref count on 458640384000 root 456 owner 81409181 offset 17039360 found 0 wanted 1 back 0x5648eefd3d10
> > Backref disk bytenr does not match extent record, bytenr=458640384000, ref bytenr=0
> > Backref 458640384000 root 456 owner 73020573 offset 17039360 num_refs 0 not found in extent tree
> > Incorrect local backref count on 458640384000 root 456 owner 73020573 offset 17039360 found 1 wanted 0 back 0x5648b32a9600
> > backpointer mismatch on [458640384000 86016]
> > repair deleting extent record: key 458640384000 168 86016
> > adding new data backref on 458640384000 parent 438017720320 owner 0 offset 0 found 1
> > adding new data backref on 458640384000 root 456 owner 73020573 offset 17039360 found 1
> > Repaired extent references for 458640384000
> > Fixed 0 roots.
> > checking free space cache
> > cache and super generation don't match, space cache will be invalidated
> > checking fs roots
> > Deleting bad dir index [10138517,96,436945] root 456
> > Deleting bad dir index [10138518,96,646273] root 456
> > Deleting bad dir index [10138517,96,437016] root 456
> > Deleting bad dir index [10138518,96,808999] root 456
> > Deleting bad dir index [10215134,96,149427] root 456
> > Deleting bad dir index [10240541,96,268037] root 456
> > Deleting bad dir index [10138517,96,540247] root 456
> > Deleting bad dir index [10138518,96,825234] root 456
> > Deleting bad dir index [10138517,96,736673] root 456
> > Deleting bad dir index [10138518,96,1118221] root 456
> > Deleting bad dir index [10240541,96,439703] root 456
> > Deleting bad dir index [10138517,96,752282] root 456
> > root 456 inode 75431563 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 4096, len: 4096
> > root 456 inode 75431568 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 1638400
> > root 456 inode 75431583 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 147456
> > root 456 inode 75431585 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 208896
> > root 456 inode 75431591 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 2523136
> > root 456 inode 75431730 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 208896
> > root 456 inode 75431744 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 2084864
> > root 456 inode 75431751 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 172032
> > root 456 inode 75431756 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 8192
> > root 456 inode 75431760 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 12288
> > root 456 inode 75431765 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 32768
> > root 456 inode 75431773 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 90112
> > Fixed discount file extents for inode: 75432421 in root: 456
> > Fixed discount file extents for inode: 75432429 in root: 456
> > root 456 inode 75432429 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > Fixed discount file extents for inode: 75432430 in root: 456
> > Fixed discount file extents for inode: 75432432 in root: 456
> > Fixed discount file extents for inode: 75432433 in root: 456
> > root 456 inode 75432433 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > root 456 inode 75432434 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 724992
> > Fixed discount file extents for inode: 75432436 in root: 456
> > Fixed discount file extents for inode: 75432437 in root: 456
> > root 456 inode 75432437 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > Fixed discount file extents for inode: 75432438 in root: 456
> > Fixed discount file extents for inode: 75432441 in root: 456
> > root 456 inode 75432441 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > Fixed discount file extents for inode: 75432444 in root: 456
> > root 456 inode 75432444 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > Fixed discount file extents for inode: 75432445 in root: 456
> > Fixed discount file extents for inode: 75432447 in root: 456
> > Fixed discount file extents for inode: 75432448 in root: 456
> > Fixed discount file extents for inode: 75432454 in root: 456
> > Fixed discount file extents for inode: 75432457 in root: 456
> > root 456 inode 75432457 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > root 456 inode 75432471 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 20480
> > Fixed discount file extents for inode: 75432473 in root: 456
> > root 456 inode 75432473 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 20480
> > Fixed discount file extents for inode: 75432482 in root: 456
> > Fixed discount file extents for inode: 75432483 in root: 456
> > Fixed discount file extents for inode: 75432484 in root: 456
> > Fixed discount file extents for inode: 75432487 in root: 456
> > Fixed discount file extents for inode: 75432489 in root: 456
> > Fixed discount file extents for inode: 75432494 in root: 456
> > Fixed discount file extents for inode: 75432611 in root: 456
> > Fixed discount file extents for inode: 75432622 in root: 456
> > Fixed discount file extents for inode: 75432626 in root: 456
> > Fixed discount file extents for inode: 75432628 in root: 456
> > Fixed discount file extents for inode: 75432636 in root: 456
> > Fixed discount file extents for inode: 75432637 in root: 456
> > root 456 inode 75432637 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > Fixed discount file extents for inode: 75432643 in root: 456
> > root 456 inode 75432643 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 135168
> > Fixed discount file extents for inode: 75432650 in root: 456
> > root 456 inode 75432650 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > Fixed discount file extents for inode: 75432656 in root: 456
> > root 456 inode 75432656 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > Fixed discount file extents for inode: 75432657 in root: 456
> > root 456 inode 75432657 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > Fixed discount file extents for inode: 75432659 in root: 456
> > Fixed discount file extents for inode: 75432662 in root: 456
> > root 456 inode 75432662 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 8192
> > Fixed discount file extents for inode: 75432663 in root: 456
> > root 456 inode 75432663 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 8192
> > Fixed discount file extents for inode: 75432664 in root: 456
> > root 456 inode 75432664 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 8192
> > Fixed discount file extents for inode: 75432674 in root: 456
> > root 456 inode 75432674 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 8192
> > Fixed discount file extents for inode: 75432692 in root: 456
> > root 456 inode 75432692 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > Fixed discount file extents for inode: 75432708 in root: 456
> > Fixed discount file extents for inode: 75432709 in root: 456
> > root 456 inode 75432709 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > Fixed discount file extents for inode: 75432712 in root: 456
> > Fixed discount file extents for inode: 75432717 in root: 456
> > Fixed discount file extents for inode: 75432720 in root: 456
> > Fixed discount file extents for inode: 75432725 in root: 456
> > Fixed discount file extents for inode: 75432731 in root: 456
> > Fixed discount file extents for inode: 75432732 in root: 456
> > Fixed discount file extents for inode: 75432749 in root: 456
> > Fixed discount file extents for inode: 75432762 in root: 456
> > Fixed discount file extents for inode: 75432765 in root: 456
> > Fixed discount file extents for inode: 75432783 in root: 456
> > Fixed discount file extents for inode: 75432784 in root: 456
> > Fixed discount file extents for inode: 75432785 in root: 456
> > root 456 inode 75432785 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 8192
> > Fixed discount file extents for inode: 75432786 in root: 456
> > root 456 inode 75432786 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 8192
> > Fixed discount file extents for inode: 75432796 in root: 456
> > root 456 inode 75432796 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 8192
> > Fixed discount file extents for inode: 75432799 in root: 456
> > root 456 inode 75432799 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 8192
> > Fixed discount file extents for inode: 75432801 in root: 456
> > root 456 inode 75432801 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > Fixed discount file extents for inode: 75432807 in root: 456
> > Fixed discount file extents for inode: 75432817 in root: 456
> > Fixed discount file extents for inode: 75432829 in root: 456
> > Fixed discount file extents for inode: 75432860 in root: 456
> > root 456 inode 75432860 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 4096
> > Fixed discount file extents for inode: 75432862 in root: 456
> > Fixed discount file extents for inode: 75432863 in root: 456
> > Fixed discount file extents for inode: 75432869 in root: 456
> > Fixed discount file extents for inode: 75432870 in root: 456
> > Fixed discount file extents for inode: 75432871 in root: 456
> > Fixed discount file extents for inode: 75432872 in root: 456
> > Fixed discount file extents for inode: 75432875 in root: 456
> > Fixed discount file extents for inode: 75432877 in root: 456
> > Fixed discount file extents for inode: 75432882 in root: 456
> > Fixed discount file extents for inode: 75432883 in root: 456
> > Fixed discount file extents for inode: 75432893 in root: 456
> > Fixed discount file extents for inode: 75432894 in root: 456
> > Fixed discount file extents for inode: 75432897 in root: 456
> > Fixed discount file extents for inode: 75432899 in root: 456
> > Fixed discount file extents for inode: 75432900 in root: 456
> > Fixed discount file extents for inode: 75432905 in root: 456
> > Fixed discount file extents for inode: 75432906 in root: 456
> > Fixed discount file extents for inode: 75432916 in root: 456
> > Fixed discount file extents for inode: 75432917 in root: 456
> > Fixed discount file extents for inode: 75432919 in root: 456
> > Fixed discount file extents for inode: 75432920 in root: 456
> > Fixed discount file extents for inode: 75432923 in root: 456
> > Fixed discount file extents for inode: 75432942 in root: 456
> > Fixed discount file extents for inode: 75432944 in root: 456
> > Fixed discount file extents for inode: 75432948 in root: 456
> > root 456 inode 75432948 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 8192
> > Fixed discount file extents for inode: 75432949 in root: 456
> > root 456 inode 75432949 errors 100, file extent discount
> > Found file extent holes:
> > 	start: 0, len: 8192
> > and it loops forever on 456
> > 
> > On Thu, Oct 17, 2019 at 07:56:04PM -0700, Marc MERLIN wrote:
> > > This happened almost after a resume from suspend to disk.
> > > First corruption and read only I got a very long time.
> > > 
> > > Could they be related?
> > > 
> > > [26062.126505] ------------[ cut here ]------------
> > > [26062.126524] WARNING: CPU: 7 PID: 12394 at fs/btrfs/extent-tree.c:7100 __btrfs_free_extent+0x18b/0x921
> > > [26062.126526] Modules linked in: msr ccm ipt_MASQUERADE ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_conntrack nf_log_ipv4 nf_log_common xt_LOG iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables bpfilter rfcomm ax25 bnep pci_stub vboxpci(O) vboxnetadp(O) vboxnetflt(O) vboxdrv(O) autofs4 binfmt_misc uinput nfsd auth_rpcgss nfs_acl nfs lockd grace fscache sunrpc nls_utf8 nls_cp437 vfat fat cuse ecryptfs bbswitch(OE) configs input_polldev loop firewire_sbp2 firewire_core crc_itu_t ppdev parport_pc lp parport uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev media btusb btrtl btbcm btintel bluetooth ecdh_generic hid_generic usbhid hid joydev arc4 coretemp x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm irqbypass snd_hda_codec_realtek snd_hda_codec_generic intel_wmi_thunderbolt iTCO_wdt wmi_bmof mei_hdcp iTCO_vendor_support rtsx_pci_sdmmc snd_hda_intel
> > > [26062.126561]  snd_hda_codec iwlmvm crct10dif_pclmul snd_hda_core crc32_pclmul mac80211 snd_hwdep thinkpad_acpi snd_pcm ghash_clmulni_intel nvram ledtrig_audio intel_cstate deflate snd_seq efi_pstore iwlwifi snd_seq_device snd_timer intel_rapl_perf psmouse pcspkr efivars wmi hwmon snd ac battery cfg80211 mei_me soundcore xhci_pci xhci_hcd rtsx_pci i2c_i801 rfkill sg nvidiafb intel_pch_thermal usbcore vgastate fb_ddc pcc_cpufreq sata_sil24 r8169 libphy mii fuse fan raid456 multipath mmc_block mmc_core dm_snapshot dm_bufio dm_mirror dm_region_hash dm_log dm_crypt dm_mod async_raid6_recov async_pq async_xor async_memcpy async_tx blowfish_x86_64 blowfish_common crc32c_intel bcache crc64 aesni_intel input_leds i915 aes_x86_64 crypto_simd cryptd ptp glue_helper serio_raw pps_core thermal evdev [last unloaded: e1000e]
> > > [26062.126597] CPU: 7 PID: 12394 Comm: btrfs-transacti Tainted: G        W  OE     5.1.21-amd64-preempt-sysrq-20190816 #5
> > > [26062.126599] Hardware name: LENOVO 20ERCTO1WW/20ERCTO1WW, BIOS N1DET95W (2.21 ) 12/13/2017
> > > [26062.126604] RIP: 0010:__btrfs_free_extent+0x18b/0x921
> > > [26062.126606] Code: 00 8b 45 40 44 29 e0 83 f8 05 0f 8f 2e 05 00 00 41 ff cc eb a5 83 f8 fe 0f 85 29 07 00 00 48 c7 c7 f8 67 f0 89 e8 f6 cb dd ff <0f> 0b 48 8b 7d 00 e8 e5 54 00 00 4c 89 fa 48 c7 c6 85 e0 f4 89 41
> > > [26062.126608] RSP: 0018:ffffb2d9c46e7c88 EFLAGS: 00010246
> > > [26062.126611] RAX: 0000000000000024 RBX: ffff9abca20884e0 RCX: 0000000000000000
> > > [26062.126613] RDX: 0000000000000000 RSI: ffff9abccf5d6558 RDI: ffff9abccf5d6558
> > > [26062.126617] RBP: ffff9ab5a4545460 R08: 0000000000000001 R09: ffffffff8a80c7af
> > > [26062.126618] R10: 0000000000000002 R11: ffffb2d9c46e7b2f R12: 0000000000000169
> > > [26062.126622] R13: 00000000fffffffe R14: 0000000001040000 R15: 0000006ac918e000
> > > [26062.126625] FS:  0000000000000000(0000) GS:ffff9abccf5c0000(0000) knlGS:0000000000000000
> > > [26062.126627] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [26062.126629] CR2: 0000199a9fb4d000 CR3: 000000016c20e006 CR4: 00000000003606e0
> > > [26062.126633] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [26062.126634] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [26062.126636] Call Trace:
> > > [26062.126647]  __btrfs_run_delayed_refs+0x750/0xc36
> > > [26062.126653]  ? __switch_to_asm+0x41/0x70
> > > [26062.126655]  ? __switch_to_asm+0x35/0x70
> > > [26062.126658]  ? __switch_to_asm+0x41/0x70
> > > [26062.126662]  ? __switch_to+0x13d/0x3d5
> > > [26062.126668]  btrfs_run_delayed_refs+0x5d/0x132
> > > [26062.126672]  btrfs_commit_transaction+0x55/0x7c8
> > > [26062.126676]  ? start_transaction+0x347/0x3cb
> > > [26062.126679]  transaction_kthread+0xc9/0x135
> > > [26062.126683]  ? btrfs_cleanup_transaction+0x403/0x403
> > > [26062.126688]  kthread+0xeb/0xf0
> > > [26062.126692]  ? kthread_create_worker_on_cpu+0x65/0x65
> > > [26062.126695]  ret_from_fork+0x35/0x40
> > > [26062.126698] ---[ end trace 4c1a6b3749a2f650 ]---
> > > [26062.126703] BTRFS info (device dm-2): leaf 510067163136 gen 2427077 total ptrs 130 free space 4329 owner 2
> > > [26062.126706] 	item 0 key (458630676480 168 65536) itemoff 16217 itemsize 66
> > > [26062.126708] 		extent refs 2 gen 2369265 flags 1
> > > [26062.126709] 		ref#0: extent data backref root 456 objectid 72925787 offset 5472256 count 1
> > > [26062.126711] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.126714] 	item 1 key (458630856704 168 69632) itemoff 16151 itemsize 66
> > > [26062.126715] 		extent refs 2 gen 2369025 flags 1
> > > [26062.126716] 		ref#0: extent data backref root 456 objectid 72925787 offset 4796416 count 1
> > > [26062.126718] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.126720] 	item 2 key (458631012352 168 16384) itemoff 15968 itemsize 183
> > > [26062.126722] 		extent refs 11 gen 1800715 flags 1
> > > [26062.126722] 		ref#0: extent data backref root 456 objectid 56413614 offset 63946752 count 1
> > > [26062.126724] 		ref#1: shared data backref parent 508153839616 count 1
> > > [26062.126726] 		ref#2: shared data backref parent 493541244928 count 1
> > > [26062.126727] 		ref#3: shared data backref parent 492677332992 count 1
> > > [26062.126728] 		ref#4: shared data backref parent 492328566784 count 1
> > > [26062.126730] 		ref#5: shared data backref parent 492245188608 count 1
> > > [26062.126731] 		ref#6: shared data backref parent 475885109248 count 1
> > > [26062.126732] 		ref#7: shared data backref parent 471036608512 count 1
> > > [26062.126733] 		ref#8: shared data backref parent 436114243584 count 1
> > > [26062.126735] 		ref#9: shared data backref parent 886718464 count 1
> > > [26062.126736] 		ref#10: shared data backref parent 90259456 count 1
> > > [26062.126738] 	item 3 key (458631028736 168 524288) itemoff 15902 itemsize 66
> > > [26062.126740] 		extent refs 2 gen 2420471 flags 1
> > > [26062.126741] 		ref#0: extent data backref root 456 objectid 75167213 offset 2097152 count 1
> > > [26062.126743] 		ref#1: shared data backref parent 41020112896 count 1
> > > [26062.126745] 	item 4 key (458631553024 168 69632) itemoff 15849 itemsize 53
> > > [26062.126746] 		extent refs 1 gen 2422941 flags 1
> > > [26062.126747] 		ref#0: extent data backref root 456 objectid 75259665 offset 0 count 1
> > > [26062.126749] 	item 5 key (458632052736 168 2269184) itemoff 15796 itemsize 53
> > > [26062.126750] 		extent refs 1 gen 1444854 flags 1
> > > [26062.126751] 		ref#0: extent data backref root 456 objectid 50397136 offset 0 count 1
> > > [26062.126753] 	item 6 key (458634321920 168 311296) itemoff 15759 itemsize 37
> > > [26062.126754] 		extent refs 1 gen 1444854 flags 1
> > > [26062.126755] 		ref#0: shared data backref parent 214892544 count 1
> > > [26062.126757] 	item 7 key (458635517952 168 1032192) itemoff 15722 itemsize 37
> > > [26062.126758] 		extent refs 1 gen 1444854 flags 1
> > > [26062.126759] 		ref#0: shared data backref parent 102547456 count 1
> > > [26062.126761] 	item 8 key (458636550144 168 438272) itemoff 15656 itemsize 66
> > > [26062.126762] 		extent refs 2 gen 2422644 flags 1
> > > [26062.126763] 		ref#0: extent data backref root 456 objectid 75244720 offset 0 count 1
> > > [26062.126765] 		ref#1: shared data backref parent 470658482176 count 1
> > > [26062.126768] 	item 9 key (458637037568 168 73728) itemoff 15590 itemsize 66
> > > [26062.126769] 		extent refs 2 gen 2369217 flags 1
> > > [26062.126770] 		ref#0: extent data backref root 456 objectid 72925787 offset 5332992 count 1
> > > [26062.126772] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.126774] 	item 10 key (458637152256 168 73728) itemoff 15524 itemsize 66
> > > [26062.126775] 		extent refs 2 gen 2369242 flags 1
> > > [26062.126776] 		ref#0: extent data backref root 456 objectid 72925787 offset 5402624 count 1
> > > [26062.126778] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.126780] 	item 11 key (458637328384 168 45056) itemoff 15471 itemsize 53
> > > [26062.126781] 		extent refs 1 gen 2369305 flags 1
> > > [26062.126782] 		ref#0: extent data backref root 456 objectid 73017376 offset 131072 count 1
> > > [26062.126784] 	item 12 key (458637885440 168 69632) itemoff 15405 itemsize 66
> > > [26062.126786] 		extent refs 2 gen 2369052 flags 1
> > > [26062.126787] 		ref#0: extent data backref root 456 objectid 72925787 offset 4861952 count 1
> > > [26062.126788] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.126790] 	item 13 key (458638147584 168 69632) itemoff 15352 itemsize 53
> > > [26062.126792] 		extent refs 1 gen 2369305 flags 1
> > > [26062.126793] 		ref#0: extent data backref root 456 objectid 73017334 offset 131072 count 1
> > > [26062.126795] 	item 14 key (458638561280 168 73728) itemoff 15286 itemsize 66
> > > [26062.126796] 		extent refs 2 gen 2368754 flags 1
> > > [26062.126797] 		ref#0: extent data backref root 456 objectid 72925787 offset 4063232 count 1
> > > [26062.126799] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.126801] 	item 15 key (458638970880 168 90112) itemoff 15103 itemsize 183
> > > [26062.126802] 		extent refs 11 gen 1800682 flags 1
> > > [26062.126803] 		ref#0: extent data backref root 456 objectid 56413614 offset 40665088 count 1
> > > [26062.126805] 		ref#1: shared data backref parent 508153069568 count 1
> > > [26062.126806] 		ref#2: shared data backref parent 508031270912 count 1
> > > [26062.126808] 		ref#3: shared data backref parent 493564215296 count 1
> > > [26062.126809] 		ref#4: shared data backref parent 493540098048 count 1
> > > [26062.126811] 		ref#5: shared data backref parent 492676038656 count 1
> > > [26062.126813] 		ref#6: shared data backref parent 475884142592 count 1
> > > [26062.126814] 		ref#7: shared data backref parent 471032840192 count 1
> > > [26062.126816] 		ref#8: shared data backref parent 436112146432 count 1
> > > [26062.126817] 		ref#9: shared data backref parent 883752960 count 1
> > > [26062.126818] 		ref#10: shared data backref parent 86654976 count 1
> > > [26062.126820] 	item 16 key (458639060992 168 86016) itemoff 15053 itemsize 50
> > > [26062.126822] 		extent refs 2 gen 2369347 flags 1
> > > [26062.126823] 		ref#0: shared data backref parent 492981370880 count 1
> > > [26062.126824] 		ref#1: shared data backref parent 438017720320 count 1
> > > [26062.126826] 	item 17 key (458639147008 168 86016) itemoff 15003 itemsize 50
> > > [26062.126827] 		extent refs 2 gen 2369347 flags 1
> > > [26062.126828] 		ref#0: shared data backref parent 492981370880 count 1
> > > [26062.126830] 		ref#1: shared data backref parent 438017720320 count 1
> > > [26062.126832] 	item 18 key (458639233024 168 90112) itemoff 14953 itemsize 50
> > > [26062.126833] 		extent refs 2 gen 2369347 flags 1
> > > [26062.126834] 		ref#0: shared data backref parent 492981370880 count 1
> > > [26062.126836] 		ref#1: shared data backref parent 438017720320 count 1
> > > [26062.126839] 	item 19 key (458639323136 168 81920) itemoff 14916 itemsize 37
> > > [26062.126840] 		extent refs 1 gen 2369352 flags 1
> > > [26062.126841] 		ref#0: shared data backref parent 510058790912 count 1
> > > [26062.126843] 	item 20 key (458639405056 168 77824) itemoff 14879 itemsize 37
> > > [26062.126845] 		extent refs 1 gen 2369352 flags 1
> > > [26062.126845] 		ref#0: shared data backref parent 510058790912 count 1
> > > [26062.126848] 	item 21 key (458639482880 168 69632) itemoff 14842 itemsize 37
> > > [26062.126849] 		extent refs 1 gen 2369352 flags 1
> > > [26062.126850] 		ref#0: shared data backref parent 510058790912 count 1
> > > [26062.126852] 	item 22 key (458639585280 168 86016) itemoff 14792 itemsize 50
> > > [26062.126853] 		extent refs 2 gen 2369347 flags 1
> > > [26062.126854] 		ref#0: shared data backref parent 492981370880 count 1
> > > [26062.126856] 		ref#1: shared data backref parent 438017720320 count 1
> > > [26062.126858] 	item 23 key (458639671296 168 90112) itemoff 14742 itemsize 50
> > > [26062.126859] 		extent refs 2 gen 2369347 flags 1
> > > [26062.126860] 		ref#0: shared data backref parent 492981370880 count 1
> > > [26062.126862] 		ref#1: shared data backref parent 438017720320 count 1
> > > [26062.126864] 	item 24 key (458639761408 168 81920) itemoff 14692 itemsize 50
> > > [26062.126865] 		extent refs 2 gen 2369347 flags 1
> > > [26062.126866] 		ref#0: shared data backref parent 492981370880 count 1
> > > [26062.126868] 		ref#1: shared data backref parent 438017720320 count 1
> > > [26062.126870] 	item 25 key (458640027648 168 90112) itemoff 14642 itemsize 50
> > > [26062.126871] 		extent refs 2 gen 2369347 flags 1
> > > [26062.126873] 		ref#0: shared data backref parent 492981370880 count 1
> > > [26062.126874] 		ref#1: shared data backref parent 438017720320 count 1
> > > [26062.126876] 	item 26 key (458640117760 168 90112) itemoff 14592 itemsize 50
> > > [26062.126877] 		extent refs 2 gen 2369347 flags 1
> > > [26062.126878] 		ref#0: shared data backref parent 492981370880 count 1
> > > [26062.126880] 		ref#1: shared data backref parent 438017720320 count 1
> > > [26062.126882] 	item 27 key (458640207872 168 86016) itemoff 14542 itemsize 50
> > > [26062.126883] 		extent refs 2 gen 2369347 flags 1
> > > [26062.126884] 		ref#0: shared data backref parent 492981370880 count 1
> > > [26062.126885] 		ref#1: shared data backref parent 438017720320 count 1
> > > [26062.126888] 	item 28 key (458640293888 168 90112) itemoff 14492 itemsize 50
> > > [26062.126889] 		extent refs 2 gen 2369347 flags 1
> > > [26062.126890] 		ref#0: shared data backref parent 492981370880 count 1
> > > [26062.126891] 		ref#1: shared data backref parent 438017720320 count 1
> > > [26062.126893] 	item 29 key (458640384000 168 86016) itemoff 14413 itemsize 79
> > > [26062.126894] 		extent refs 3 gen 2369347 flags 1
> > > [26062.126895] 		ref#0: extent data backref root 456 objectid 81409181 offset 17039360 count 1
> > > [26062.126897] 		ref#1: shared data backref parent 492981370880 count 1
> > > [26062.126898] 		ref#2: shared data backref parent 438017720320 count 1
> > > [26062.126900] 	item 30 key (458640470016 168 86016) itemoff 14347 itemsize 66
> > > [26062.126902] 		extent refs 2 gen 2369347 flags 1
> > > [26062.126903] 		ref#0: extent data backref root 456 objectid 73020573 offset 17170432 count 1
> > > [26062.126904] 		ref#1: shared data backref parent 438017720320 count 1
> > > [26062.126906] 	item 31 key (458640556032 168 77824) itemoff 14310 itemsize 37
> > > [26062.126907] 		extent refs 1 gen 2369352 flags 1
> > > [26062.126908] 		ref#0: shared data backref parent 510058790912 count 1
> > > [26062.126910] 	item 32 key (458640756736 168 24576) itemoff 14231 itemsize 79
> > > [26062.126912] 		extent refs 6 gen 1800750 flags 1
> > > [26062.126913] 		ref#0: extent data backref root 456 objectid 56413614 offset 697655296 count 2
> > > [26062.126915] 		ref#1: shared data backref parent 509782933504 count 2
> > > [26062.126917] 		ref#2: shared data backref parent 508543795200 count 2
> > > [26062.126919] 	item 33 key (458641227776 168 73728) itemoff 14165 itemsize 66
> > > [26062.126920] 		extent refs 2 gen 2369075 flags 1
> > > [26062.126921] 		ref#0: extent data backref root 456 objectid 72925787 offset 4927488 count 1
> > > [26062.126923] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.126925] 	item 34 key (458641346560 168 8192) itemoff 14086 itemsize 79
> > > [26062.126926] 		extent refs 3 gen 1800733 flags 1
> > > [26062.126927] 		ref#0: extent data backref root 456 objectid 56413614 offset 667910144 count 1
> > > [26062.126929] 		ref#1: shared data backref parent 509783719936 count 1
> > > [26062.126930] 		ref#2: shared data backref parent 509351231488 count 1
> > > [26062.126932] 	item 35 key (458641518592 168 524288) itemoff 14020 itemsize 66
> > > [26062.126934] 		extent refs 2 gen 2420471 flags 1
> > > [26062.126934] 		ref#0: extent data backref root 456 objectid 75167213 offset 2621440 count 1
> > > [26062.126936] 		ref#1: shared data backref parent 41020112896 count 1
> > > [26062.126938] 	item 36 key (458642042880 168 524288) itemoff 13954 itemsize 66
> > > [26062.126939] 		extent refs 2 gen 2420471 flags 1
> > > [26062.126940] 		ref#0: extent data backref root 456 objectid 75167213 offset 3145728 count 1
> > > [26062.126943] 		ref#1: shared data backref parent 41020112896 count 1
> > > [26062.126945] 	item 37 key (458642747392 168 8192) itemoff 13875 itemsize 79
> > > [26062.126946] 		extent refs 3 gen 1800733 flags 1
> > > [26062.126947] 		ref#0: extent data backref root 456 objectid 56413614 offset 668401664 count 1
> > > [26062.126949] 		ref#1: shared data backref parent 509783719936 count 1
> > > [26062.126950] 		ref#2: shared data backref parent 509351231488 count 1
> > > [26062.126953] 	item 38 key (458642841600 168 524288) itemoff 13809 itemsize 66
> > > [26062.126954] 		extent refs 2 gen 2420502 flags 1
> > > [26062.126955] 		ref#0: extent data backref root 456 objectid 75168659 offset 524288 count 1
> > > [26062.126957] 		ref#1: shared data backref parent 492274728960 count 1
> > > [26062.126959] 	item 39 key (458643431424 168 524288) itemoff 13743 itemsize 66
> > > [26062.126961] 		extent refs 2 gen 2420478 flags 1
> > > [26062.126962] 		ref#0: extent data backref root 456 objectid 75167502 offset 524288 count 1
> > > [26062.126964] 		ref#1: shared data backref parent 41020112896 count 1
> > > [26062.126966] 	item 40 key (458644230144 168 331776) itemoff 13706 itemsize 37
> > > [26062.126967] 		extent refs 1 gen 1444854 flags 1
> > > [26062.126968] 		ref#0: shared data backref parent 214908928 count 1
> > > [26062.126970] 	item 41 key (458644561920 168 1671168) itemoff 13653 itemsize 53
> > > [26062.126971] 		extent refs 1 gen 2376479 flags 1
> > > [26062.126972] 		ref#0: extent data backref root 456 objectid 73223285 offset 0 count 1
> > > [26062.126975] 	item 42 key (458646454272 168 2121728) itemoff 13600 itemsize 53
> > > [26062.126976] 		extent refs 1 gen 1444854 flags 1
> > > [26062.126977] 		ref#0: extent data backref root 456 objectid 50397133 offset 0 count 1
> > > [26062.126979] 	item 43 key (458648576000 168 1605632) itemoff 13563 itemsize 37
> > > [26062.126981] 		extent refs 1 gen 1444854 flags 1
> > > [26062.126982] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.126984] 	item 44 key (458650181632 168 1474560) itemoff 13526 itemsize 37
> > > [26062.126985] 		extent refs 1 gen 1444854 flags 1
> > > [26062.126986] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.126988] 	item 45 key (458651656192 168 2125824) itemoff 13489 itemsize 37
> > > [26062.126990] 		extent refs 1 gen 1444854 flags 1
> > > [26062.126991] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.126993] 	item 46 key (458653782016 168 356352) itemoff 13452 itemsize 37
> > > [26062.126994] 		extent refs 1 gen 1444854 flags 1
> > > [26062.126995] 		ref#0: shared data backref parent 214908928 count 1
> > > [26062.126997] 	item 47 key (458655539200 168 524288) itemoff 13360 itemsize 92
> > > [26062.126998] 		extent refs 4 gen 2419085 flags 1
> > > [26062.126999] 		ref#0: extent data backref root 456 objectid 75099153 offset 2621440 count 1
> > > [26062.127001] 		ref#1: shared data backref parent 494075035648 count 1
> > > [26062.127002] 		ref#2: shared data backref parent 470850240512 count 1
> > > [26062.127004] 		ref#3: shared data backref parent 437034745856 count 1
> > > [26062.127006] 	item 48 key (458656153600 168 8192) itemoff 13281 itemsize 79
> > > [26062.127008] 		extent refs 3 gen 1800733 flags 1
> > > [26062.127009] 		ref#0: extent data backref root 456 objectid 56413614 offset 668811264 count 1
> > > [26062.127011] 		ref#1: shared data backref parent 509783719936 count 1
> > > [26062.127013] 		ref#2: shared data backref parent 509351231488 count 1
> > > [26062.127015] 	item 49 key (458656161792 168 69632) itemoff 13215 itemsize 66
> > > [26062.127016] 		extent refs 2 gen 2368859 flags 1
> > > [26062.127017] 		ref#0: extent data backref root 456 objectid 72925787 offset 4325376 count 1
> > > [26062.127019] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.127021] 	item 50 key (458657443840 168 1847296) itemoff 13162 itemsize 53
> > > [26062.127023] 		extent refs 1 gen 2376479 flags 1
> > > [26062.127024] 		ref#0: extent data backref root 456 objectid 73223286 offset 0 count 1
> > > [26062.127026] 	item 51 key (458659307520 168 98304) itemoff 12979 itemsize 183
> > > [26062.127028] 		extent refs 11 gen 1800674 flags 1
> > > [26062.127029] 		ref#0: extent data backref root 456 objectid 56413614 offset 41541632 count 1
> > > [26062.127031] 		ref#1: shared data backref parent 508153118720 count 1
> > > [26062.127032] 		ref#2: shared data backref parent 508031533056 count 1
> > > [26062.127034] 		ref#3: shared data backref parent 493564477440 count 1
> > > [26062.127036] 		ref#4: shared data backref parent 493540179968 count 1
> > > [26062.127038] 		ref#5: shared data backref parent 492675366912 count 1
> > > [26062.127039] 		ref#6: shared data backref parent 475132116992 count 1
> > > [26062.127041] 		ref#7: shared data backref parent 471032922112 count 1
> > > [26062.127042] 		ref#8: shared data backref parent 436112244736 count 1
> > > [26062.127044] 		ref#9: shared data backref parent 883998720 count 1
> > > [26062.127046] 		ref#10: shared data backref parent 87015424 count 1
> > > [26062.127048] 	item 52 key (458659405824 168 1753088) itemoff 12942 itemsize 37
> > > [26062.127050] 		extent refs 1 gen 2408131 flags 1
> > > [26062.127052] 		ref#0: shared data backref parent 509278633984 count 1
> > > [26062.127055] 	item 53 key (458661167104 168 24576) itemoff 12759 itemsize 183
> > > [26062.127056] 		extent refs 11 gen 1800715 flags 1
> > > [26062.127058] 		ref#0: extent data backref root 456 objectid 56413614 offset 36765696 count 1
> > > [26062.127059] 		ref#1: shared data backref parent 508152889344 count 1
> > > [26062.127061] 		ref#2: shared data backref parent 508031139840 count 1
> > > [26062.127062] 		ref#3: shared data backref parent 493563478016 count 1
> > > [26062.127065] 		ref#4: shared data backref parent 493539983360 count 1
> > > [26062.127066] 		ref#5: shared data backref parent 492674990080 count 1
> > > [26062.127068] 		ref#6: shared data backref parent 475132166144 count 1
> > > [26062.127070] 		ref#7: shared data backref parent 471032348672 count 1
> > > [26062.127071] 		ref#8: shared data backref parent 436111769600 count 1
> > > [26062.127073] 		ref#9: shared data backref parent 883359744 count 1
> > > [26062.127074] 		ref#10: shared data backref parent 85082112 count 1
> > > [26062.127077] 	item 54 key (458661191680 168 524288) itemoff 12667 itemsize 92
> > > [26062.127078] 		extent refs 4 gen 2419085 flags 1
> > > [26062.127079] 		ref#0: extent data backref root 456 objectid 75099153 offset 3145728 count 1
> > > [26062.127085] 		ref#1: shared data backref parent 494075035648 count 1
> > > [26062.127088] 		ref#2: shared data backref parent 470850240512 count 1
> > > [26062.127089] 		ref#3: shared data backref parent 437034745856 count 1
> > > [26062.127093] 	item 55 key (458662014976 168 524288) itemoff 12601 itemsize 66
> > > [26062.127095] 		extent refs 2 gen 2421893 flags 1
> > > [26062.127096] 		ref#0: extent data backref root 456 objectid 75220094 offset 1048576 count 1
> > > [26062.127099] 		ref#1: shared data backref parent 493703069696 count 1
> > > [26062.127102] 	item 56 key (458663206912 168 786432) itemoff 12548 itemsize 53
> > > [26062.127104] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127105] 		ref#0: extent data backref root 456 objectid 50397303 offset 0 count 1
> > > [26062.127109] 	item 57 key (458664165376 168 77824) itemoff 12482 itemsize 66
> > > [26062.127111] 		extent refs 2 gen 2368700 flags 1
> > > [26062.127112] 		ref#0: extent data backref root 456 objectid 72993362 offset 262144 count 1
> > > [26062.127114] 		ref#1: shared data backref parent 494105804800 count 1
> > > [26062.127118] 	item 58 key (458664243200 168 1159168) itemoff 12445 itemsize 37
> > > [26062.127120] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127121] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.127125] 	item 59 key (458665431040 168 753664) itemoff 12408 itemsize 37
> > > [26062.127127] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127128] 		ref#0: shared data backref parent 214433792 count 1
> > > [26062.127131] 	item 60 key (458666274816 168 393216) itemoff 12371 itemsize 37
> > > [26062.127132] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127133] 		ref#0: shared data backref parent 214908928 count 1
> > > [26062.127136] 	item 61 key (458667044864 168 24576) itemoff 12292 itemsize 79
> > > [26062.127138] 		extent refs 3 gen 1800750 flags 1
> > > [26062.127139] 		ref#0: extent data backref root 456 objectid 56413614 offset 709386240 count 1
> > > [26062.127141] 		ref#1: shared data backref parent 509783556096 count 1
> > > [26062.127143] 		ref#2: shared data backref parent 508544974848 count 1
> > > [26062.127147] 	item 62 key (458667069440 168 69632) itemoff 12226 itemsize 66
> > > [26062.127148] 		extent refs 2 gen 2368707 flags 1
> > > [26062.127149] 		ref#0: extent data backref root 456 objectid 72925787 offset 3932160 count 1
> > > [26062.127151] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.127153] 	item 63 key (458667143168 168 155648) itemoff 12043 itemsize 183
> > > [26062.127155] 		extent refs 11 gen 1800674 flags 1
> > > [26062.127156] 		ref#0: extent data backref root 456 objectid 56413614 offset 35766272 count 1
> > > [26062.127157] 		ref#1: shared data backref parent 508152905728 count 1
> > > [26062.127159] 		ref#2: shared data backref parent 508031057920 count 1
> > > [26062.127160] 		ref#3: shared data backref parent 493563166720 count 1
> > > [26062.127161] 		ref#4: shared data backref parent 493539934208 count 1
> > > [26062.127163] 		ref#5: shared data backref parent 492674908160 count 1
> > > [26062.127164] 		ref#6: shared data backref parent 475884208128 count 1
> > > [26062.127165] 		ref#7: shared data backref parent 471032266752 count 1
> > > [26062.127167] 		ref#8: shared data backref parent 436111720448 count 1
> > > [26062.127168] 		ref#9: shared data backref parent 883179520 count 1
> > > [26062.127170] 		ref#10: shared data backref parent 83017728 count 1
> > > [26062.127172] 	item 64 key (458667323392 168 393216) itemoff 12006 itemsize 37
> > > [26062.127173] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127174] 		ref#0: shared data backref parent 214908928 count 1
> > > [26062.127176] 	item 65 key (458668109824 168 393216) itemoff 11940 itemsize 66
> > > [26062.127177] 		extent refs 2 gen 2381729 flags 1
> > > [26062.127178] 		ref#0: extent data backref root 456 objectid 73362062 offset 131072 count 1
> > > [26062.127180] 		ref#1: shared data backref parent 437808545792 count 1
> > > [26062.127182] 	item 66 key (458668605440 168 73728) itemoff 11874 itemsize 66
> > > [26062.127183] 		extent refs 2 gen 2369098 flags 1
> > > [26062.127184] 		ref#0: extent data backref root 456 objectid 72925787 offset 4997120 count 1
> > > [26062.127186] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.127188] 	item 67 key (458668683264 168 77824) itemoff 11808 itemsize 66
> > > [26062.127189] 		extent refs 2 gen 2368700 flags 1
> > > [26062.127190] 		ref#0: extent data backref root 456 objectid 72993362 offset 393216 count 1
> > > [26062.127191] 		ref#1: shared data backref parent 494105804800 count 1
> > > [26062.127193] 	item 68 key (458668761088 168 1167360) itemoff 11771 itemsize 37
> > > [26062.127195] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127195] 		ref#0: shared data backref parent 102547456 count 1
> > > [26062.127197] 	item 69 key (458670264320 168 24576) itemoff 11692 itemsize 79
> > > [26062.127198] 		extent refs 3 gen 1800750 flags 1
> > > [26062.127199] 		ref#0: extent data backref root 456 objectid 56413614 offset 717283328 count 1
> > > [26062.127201] 		ref#1: shared data backref parent 509783408640 count 1
> > > [26062.127202] 		ref#2: shared data backref parent 508543451136 count 1
> > > [26062.127204] 	item 70 key (458670465024 168 1814528) itemoff 11655 itemsize 37
> > > [26062.127205] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127206] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.127208] 	item 71 key (458672279552 168 2256896) itemoff 11618 itemsize 37
> > > [26062.127209] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127210] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.127213] 	item 72 key (458674536448 168 1024000) itemoff 11565 itemsize 53
> > > [26062.127214] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127215] 		ref#0: extent data backref root 456 objectid 50397314 offset 0 count 1
> > > [26062.127217] 	item 73 key (458675560448 168 524288) itemoff 11473 itemsize 92
> > > [26062.127219] 		extent refs 4 gen 2419085 flags 1
> > > [26062.127220] 		ref#0: extent data backref root 456 objectid 75099153 offset 3670016 count 1
> > > [26062.127222] 		ref#1: shared data backref parent 494075035648 count 1
> > > [26062.127223] 		ref#2: shared data backref parent 470850240512 count 1
> > > [26062.127225] 		ref#3: shared data backref parent 437034745856 count 1
> > > [26062.127226] 	item 74 key (458677182464 168 24576) itemoff 11394 itemsize 79
> > > [26062.127228] 		extent refs 3 gen 1800750 flags 1
> > > [26062.127229] 		ref#0: extent data backref root 456 objectid 56413614 offset 717316096 count 1
> > > [26062.127230] 		ref#1: shared data backref parent 509783408640 count 1
> > > [26062.127232] 		ref#2: shared data backref parent 508543451136 count 1
> > > [26062.127234] 	item 75 key (458678693888 168 69632) itemoff 11328 itemsize 66
> > > [26062.127235] 		extent refs 2 gen 2368731 flags 1
> > > [26062.127236] 		ref#0: extent data backref root 456 objectid 72925787 offset 3997696 count 1
> > > [26062.127237] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.127239] 	item 76 key (458681303040 168 1789952) itemoff 11291 itemsize 37
> > > [26062.127241] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127241] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.127243] 	item 77 key (458683092992 168 1941504) itemoff 11254 itemsize 37
> > > [26062.127244] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127245] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.127247] 	item 78 key (458685034496 168 1355776) itemoff 11217 itemsize 37
> > > [26062.127249] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127249] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.127252] 	item 79 key (458686390272 168 1409024) itemoff 11180 itemsize 37
> > > [26062.127253] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127254] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.127257] 	item 80 key (458687799296 168 1748992) itemoff 11143 itemsize 37
> > > [26062.127258] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127259] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.127262] 	item 81 key (458690596864 168 393216) itemoff 11090 itemsize 53
> > > [26062.127263] 		extent refs 1 gen 2381741 flags 1
> > > [26062.127264] 		ref#0: extent data backref root 456 objectid 73362154 offset 131072 count 1
> > > [26062.127266] 	item 82 key (458691379200 168 69632) itemoff 11024 itemsize 66
> > > [26062.127268] 		extent refs 2 gen 2368882 flags 1
> > > [26062.127269] 		ref#0: extent data backref root 456 objectid 72925787 offset 4390912 count 1
> > > [26062.127270] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.127272] 	item 83 key (458692284416 168 73728) itemoff 10958 itemsize 66
> > > [26062.127274] 		extent refs 2 gen 2368909 flags 1
> > > [26062.127275] 		ref#0: extent data backref root 456 objectid 72925787 offset 4456448 count 1
> > > [26062.127277] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.127279] 	item 84 key (458695856128 168 69632) itemoff 10892 itemsize 66
> > > [26062.127280] 		extent refs 2 gen 2369146 flags 1
> > > [26062.127281] 		ref#0: extent data backref root 456 objectid 72925787 offset 5128192 count 1
> > > [26062.127283] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.127285] 	item 85 key (458699677696 168 53248) itemoff 10855 itemsize 37
> > > [26062.127286] 		extent refs 1 gen 2369353 flags 1
> > > [26062.127287] 		ref#0: shared data backref parent 510167498752 count 1
> > > [26062.127289] 	item 86 key (458699730944 168 8192) itemoff 10776 itemsize 79
> > > [26062.127294] 		extent refs 3 gen 1800733 flags 1
> > > [26062.127294] 		ref#0: extent data backref root 456 objectid 56413614 offset 673275904 count 1
> > > [26062.127296] 		ref#1: shared data backref parent 509783752704 count 1
> > > [26062.127298] 		ref#2: shared data backref parent 509351313408 count 1
> > > [26062.127299] 	item 87 key (458699747328 168 155648) itemoff 10593 itemsize 183
> > > [26062.127303] 		extent refs 22 gen 1800674 flags 1
> > > [26062.127304] 		ref#0: extent data backref root 456 objectid 56413614 offset 36257792 count 2
> > > [26062.127306] 		ref#1: shared data backref parent 508152889344 count 2
> > > [26062.127307] 		ref#2: shared data backref parent 508031139840 count 2
> > > [26062.127308] 		ref#3: shared data backref parent 493563478016 count 2
> > > [26062.127310] 		ref#4: shared data backref parent 493539983360 count 2
> > > [26062.127311] 		ref#5: shared data backref parent 492674990080 count 2
> > > [26062.127312] 		ref#6: shared data backref parent 475132166144 count 2
> > > [26062.127314] 		ref#7: shared data backref parent 471032348672 count 2
> > > [26062.127315] 		ref#8: shared data backref parent 436111769600 count 2
> > > [26062.127317] 		ref#9: shared data backref parent 883359744 count 2
> > > [26062.127318] 		ref#10: shared data backref parent 85082112 count 2
> > > [26062.127320] 	item 88 key (458700173312 168 180224) itemoff 10410 itemsize 183
> > > [26062.127321] 		extent refs 33 gen 1800674 flags 1
> > > [26062.127322] 		ref#0: extent data backref root 456 objectid 56413614 offset 36610048 count 3
> > > [26062.127324] 		ref#1: shared data backref parent 508152889344 count 3
> > > [26062.127325] 		ref#2: shared data backref parent 508031139840 count 3
> > > [26062.127327] 		ref#3: shared data backref parent 493563478016 count 3
> > > [26062.127328] 		ref#4: shared data backref parent 493539983360 count 3
> > > [26062.127329] 		ref#5: shared data backref parent 492674990080 count 3
> > > [26062.127331] 		ref#6: shared data backref parent 475132166144 count 3
> > > [26062.127333] 		ref#7: shared data backref parent 471032348672 count 3
> > > [26062.127334] 		ref#8: shared data backref parent 436111769600 count 3
> > > [26062.127335] 		ref#9: shared data backref parent 883359744 count 3
> > > [26062.127337] 		ref#10: shared data backref parent 85082112 count 3
> > > [26062.127338] 	item 89 key (458700353536 168 524288) itemoff 10318 itemsize 92
> > > [26062.127340] 		extent refs 4 gen 2419085 flags 1
> > > [26062.127341] 		ref#0: extent data backref root 456 objectid 75099153 offset 4194304 count 1
> > > [26062.127342] 		ref#1: shared data backref parent 494075035648 count 1
> > > [26062.127344] 		ref#2: shared data backref parent 470850240512 count 1
> > > [26062.127345] 		ref#3: shared data backref parent 437034745856 count 1
> > > [26062.127347] 	item 90 key (458701094912 168 69632) itemoff 10252 itemsize 66
> > > [26062.127348] 		extent refs 2 gen 2368932 flags 1
> > > [26062.127349] 		ref#0: extent data backref root 456 objectid 72925787 offset 4526080 count 1
> > > [26062.127351] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.127353] 	item 91 key (458701164544 168 57344) itemoff 10215 itemsize 37
> > > [26062.127354] 		extent refs 1 gen 2369353 flags 1
> > > [26062.127355] 		ref#0: shared data backref parent 510165155840 count 1
> > > [26062.127356] 	item 92 key (458701221888 168 73728) itemoff 10149 itemsize 66
> > > [26062.127358] 		extent refs 2 gen 2369168 flags 1
> > > [26062.127359] 		ref#0: extent data backref root 456 objectid 72925787 offset 5193728 count 1
> > > [26062.127360] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.127362] 	item 93 key (458701295616 168 61440) itemoff 10096 itemsize 53
> > > [26062.127364] 		extent refs 1 gen 2369305 flags 1
> > > [26062.127365] 		ref#0: extent data backref root 456 objectid 73017376 offset 0 count 1
> > > [26062.127367] 	item 94 key (458702897152 168 524288) itemoff 10004 itemsize 92
> > > [26062.127369] 		extent refs 4 gen 2419085 flags 1
> > > [26062.127370] 		ref#0: extent data backref root 456 objectid 75099153 offset 4718592 count 1
> > > [26062.127372] 		ref#1: shared data backref parent 494075035648 count 1
> > > [26062.127374] 		ref#2: shared data backref parent 470850240512 count 1
> > > [26062.127375] 		ref#3: shared data backref parent 437034745856 count 1
> > > [26062.127377] 	item 95 key (458703454208 168 69632) itemoff 9938 itemsize 66
> > > [26062.127378] 		extent refs 2 gen 2368955 flags 1
> > > [26062.127379] 		ref#0: extent data backref root 456 objectid 72925787 offset 4591616 count 1
> > > [26062.127382] 		ref#1: shared data backref parent 437615230976 count 1
> > > [26062.127384] 	item 96 key (458703523840 168 294912) itemoff 9901 itemsize 37
> > > [26062.127385] 		extent refs 1 gen 2369352 flags 1
> > > [26062.127386] 		ref#0: shared data backref parent 510178295808 count 1
> > > [26062.127388] 	item 97 key (458703818752 168 81920) itemoff 9864 itemsize 37
> > > [26062.127390] 		extent refs 1 gen 2369352 flags 1
> > > [26062.127391] 		ref#0: shared data backref parent 510058790912 count 1
> > > [26062.127393] 	item 98 key (458703900672 168 131072) itemoff 9827 itemsize 37
> > > [26062.127394] 		extent refs 1 gen 2369352 flags 1
> > > [26062.127395] 		ref#0: shared data backref parent 510059184128 count 1
> > > [26062.127398] 	item 99 key (458704031744 168 524288) itemoff 9774 itemsize 53
> > > [26062.127399] 		extent refs 1 gen 2378552 flags 1
> > > [26062.127400] 		ref#0: extent data backref root 456 objectid 73276414 offset 11010048 count 1
> > > [26062.127403] 	item 100 key (458704556032 168 524288) itemoff 9721 itemsize 53
> > > [26062.127405] 		extent refs 1 gen 2378552 flags 1
> > > [26062.127406] 		ref#0: extent data backref root 456 objectid 73276414 offset 11534336 count 1
> > > [26062.127408] 	item 101 key (458705080320 168 393216) itemoff 9668 itemsize 53
> > > [26062.127409] 		extent refs 1 gen 2381741 flags 1
> > > [26062.127410] 		ref#0: extent data backref root 456 objectid 73362155 offset 131072 count 1
> > > [26062.127413] 	item 102 key (458707353600 168 81920) itemoff 9602 itemsize 66
> > > [26062.127414] 		extent refs 2 gen 2368700 flags 1
> > > [26062.127415] 		ref#0: extent data backref root 456 objectid 72993362 offset 131072 count 1
> > > [26062.127416] 		ref#1: shared data backref parent 494105804800 count 1
> > > [26062.127419] 	item 103 key (458707435520 168 81920) itemoff 9536 itemsize 66
> > > [26062.127420] 		extent refs 2 gen 2368700 flags 1
> > > [26062.127421] 		ref#0: extent data backref root 456 objectid 72993362 offset 524288 count 1
> > > [26062.127423] 		ref#1: shared data backref parent 494105804800 count 1
> > > [26062.127425] 	item 104 key (458707517440 168 81920) itemoff 9470 itemsize 66
> > > [26062.127426] 		extent refs 2 gen 2368700 flags 1
> > > [26062.127428] 		ref#0: extent data backref root 456 objectid 72993362 offset 655360 count 1
> > > [26062.127430] 		ref#1: shared data backref parent 494105804800 count 1
> > > [26062.127432] 	item 105 key (458707738624 168 57344) itemoff 9287 itemsize 183
> > > [26062.127434] 		extent refs 11 gen 1800699 flags 1
> > > [26062.127435] 		ref#0: extent data backref root 456 objectid 56413614 offset 39002112 count 1
> > > [26062.127437] 		ref#1: shared data backref parent 508152987648 count 1
> > > [26062.127439] 		ref#2: shared data backref parent 508031172608 count 1
> > > [26062.127440] 		ref#3: shared data backref parent 493563822080 count 1
> > > [26062.127441] 		ref#4: shared data backref parent 493540130816 count 1
> > > [26062.127443] 		ref#5: shared data backref parent 492675170304 count 1
> > > [26062.127444] 		ref#6: shared data backref parent 475884584960 count 1
> > > [26062.127446] 		ref#7: shared data backref parent 471032496128 count 1
> > > [26062.127447] 		ref#8: shared data backref parent 436111884288 count 1
> > > [26062.127448] 		ref#9: shared data backref parent 883703808 count 1
> > > [26062.127450] 		ref#10: shared data backref parent 85671936 count 1
> > > [26062.127452] 	item 106 key (458707800064 168 393216) itemoff 9250 itemsize 37
> > > [26062.127453] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127454] 		ref#0: shared data backref parent 214908928 count 1
> > > [26062.127457] 	item 107 key (458708193280 168 11943936) itemoff 9213 itemsize 37
> > > [26062.127458] 		extent refs 1 gen 2426255 flags 1
> > > [26062.127459] 		ref#0: shared data backref parent 436271005696 count 1
> > > [26062.127461] 	item 108 key (458725122048 168 131072) itemoff 9030 itemsize 183
> > > [26062.127463] 		extent refs 22 gen 1800674 flags 1
> > > [26062.127464] 		ref#0: extent data backref root 456 objectid 56413614 offset 38928384 count 2
> > > [26062.127465] 		ref#1: shared data backref parent 508152987648 count 2
> > > [26062.127467] 		ref#2: shared data backref parent 508031172608 count 2
> > > [26062.127468] 		ref#3: shared data backref parent 493563822080 count 2
> > > [26062.127470] 		ref#4: shared data backref parent 493540130816 count 2
> > > [26062.127472] 		ref#5: shared data backref parent 492675170304 count 2
> > > [26062.127473] 		ref#6: shared data backref parent 475884584960 count 2
> > > [26062.127475] 		ref#7: shared data backref parent 471032496128 count 2
> > > [26062.127476] 		ref#8: shared data backref parent 436111884288 count 2
> > > [26062.127478] 		ref#9: shared data backref parent 883703808 count 2
> > > [26062.127480] 		ref#10: shared data backref parent 85671936 count 2
> > > [26062.127483] 	item 109 key (458725285888 168 1069056) itemoff 8993 itemsize 37
> > > [26062.127486] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127488] 		ref#0: shared data backref parent 167198720 count 1
> > > [26062.127491] 	item 110 key (458726379520 168 3158016) itemoff 8927 itemsize 66
> > > [26062.127494] 		extent refs 2 gen 1400856 flags 1
> > > [26062.127496] 		ref#0: extent data backref root 456 objectid 49348086 offset 0 count 1
> > > [26062.127498] 		ref#1: shared data backref parent 470954196992 count 1
> > > [26062.127501] 	item 111 key (458729537536 168 2166784) itemoff 8890 itemsize 37
> > > [26062.127503] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127504] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.127507] 	item 112 key (458731704320 168 393216) itemoff 8837 itemsize 53
> > > [26062.127510] 		extent refs 1 gen 2381741 flags 1
> > > [26062.127512] 		ref#0: extent data backref root 456 objectid 73362156 offset 131072 count 1
> > > [26062.127518] 	item 113 key (458732539904 168 77824) itemoff 8771 itemsize 66
> > > [26062.127520] 		extent refs 2 gen 2368701 flags 1
> > > [26062.127521] 		ref#0: extent data backref root 456 objectid 72993032 offset 0 count 1
> > > [26062.127523] 		ref#1: shared data backref parent 494107131904 count 1
> > > [26062.127526] 	item 114 key (458732752896 168 196608) itemoff 8588 itemsize 183
> > > [26062.127527] 		extent refs 44 gen 1800674 flags 1
> > > [26062.127528] 		ref#0: extent data backref root 456 objectid 56413614 offset 37789696 count 4
> > > [26062.127530] 		ref#1: shared data backref parent 508152987648 count 4
> > > [26062.127532] 		ref#2: shared data backref parent 508031172608 count 4
> > > [26062.127533] 		ref#3: shared data backref parent 493563822080 count 4
> > > [26062.127535] 		ref#4: shared data backref parent 493540130816 count 4
> > > [26062.127537] 		ref#5: shared data backref parent 492675170304 count 4
> > > [26062.127539] 		ref#6: shared data backref parent 475884584960 count 4
> > > [26062.127540] 		ref#7: shared data backref parent 471032496128 count 4
> > > [26062.127542] 		ref#8: shared data backref parent 436111884288 count 4
> > > [26062.127543] 		ref#9: shared data backref parent 883703808 count 4
> > > [26062.127545] 		ref#10: shared data backref parent 85671936 count 4
> > > [26062.127547] 	item 115 key (458732949504 168 24576) itemoff 8509 itemsize 79
> > > [26062.127549] 		extent refs 3 gen 1800750 flags 1
> > > [26062.127552] 		ref#0: extent data backref root 456 objectid 56413614 offset 738836480 count 1
> > > [26062.127554] 		ref#1: shared data backref parent 509783130112 count 1
> > > [26062.127557] 		ref#2: shared data backref parent 508544876544 count 1
> > > [26062.127560] 	item 116 key (458732978176 168 1351680) itemoff 8472 itemsize 37
> > > [26062.127561] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127562] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.127565] 	item 117 key (458734329856 168 393216) itemoff 8435 itemsize 37
> > > [26062.127566] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127568] 		ref#0: shared data backref parent 214908928 count 1
> > > [26062.127570] 	item 118 key (458801938432 168 1785856) itemoff 8398 itemsize 37
> > > [26062.127572] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127573] 		ref#0: shared data backref parent 93732864 count 1
> > > [26062.127577] 	item 119 key (458801938432 192 1073741824) itemoff 8374 itemsize 24
> > > [26062.127580] 		block group used 834060288 chunk_objectid 256 flags 1
> > > [26062.127581] 	item 120 key (458803724288 168 1409024) itemoff 8337 itemsize 37
> > > [26062.127583] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127584] 		ref#0: shared data backref parent 167198720 count 1
> > > [26062.127586] 	item 121 key (458805133312 168 1183744) itemoff 8300 itemsize 37
> > > [26062.127587] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127588] 		ref#0: shared data backref parent 167198720 count 1
> > > [26062.127590] 	item 122 key (458806317056 168 1323008) itemoff 8263 itemsize 37
> > > [26062.127591] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127592] 		ref#0: shared data backref parent 167198720 count 1
> > > [26062.127594] 	item 123 key (458807640064 168 1589248) itemoff 8226 itemsize 37
> > > [26062.127595] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127596] 		ref#0: shared data backref parent 167198720 count 1
> > > [26062.127598] 	item 124 key (458809229312 168 2727936) itemoff 8189 itemsize 37
> > > [26062.127599] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127600] 		ref#0: shared data backref parent 167198720 count 1
> > > [26062.127602] 	item 125 key (458811957248 168 1978368) itemoff 8152 itemsize 37
> > > [26062.127603] 		extent refs 1 gen 1444854 flags 1
> > > [26062.127604] 		ref#0: shared data backref parent 167198720 count 1
> > > [26062.127606] 	item 126 key (458813943808 168 8192) itemoff 7969 itemsize 183
> > > [26062.127607] 		extent refs 11 gen 2409230 flags 1
> > > [26062.127608] 		ref#0: extent data backref root 456 objectid 56413614 offset 58589184 count 1
> > > [26062.127610] 		ref#1: shared data backref parent 508153675776 count 1
> > > [26062.127611] 		ref#2: shared data backref parent 493566640128 count 1
> > > [26062.127613] 		ref#3: shared data backref parent 493540999168 count 1
> > > [26062.127614] 		ref#4: shared data backref parent 492676497408 count 1
> > > [26062.127616] 		ref#5: shared data backref parent 475884634112 count 1
> > > [26062.127617] 		ref#6: shared data backref parent 475691106304 count 1
> > > [26062.127619] 		ref#7: shared data backref parent 471034494976 count 1
> > > [26062.127620] 		ref#8: shared data backref parent 436113883136 count 1
> > > [26062.127622] 		ref#9: shared data backref parent 886407168 count 1
> > > [26062.127623] 		ref#10: shared data backref parent 89440256 count 1
> > > [26062.127625] 	item 127 key (458813960192 168 8192) itemoff 7799 itemsize 170
> > > [26062.127626] 		extent refs 10 gen 2413323 flags 1
> > > [26062.127629] 		ref#0: extent data backref root 456 objectid 56413614 offset 58580992 count 1
> > > [26062.127631] 		ref#1: shared data backref parent 508153675776 count 1
> > > [26062.127633] 		ref#2: shared data backref parent 493566640128 count 1
> > > [26062.127635] 		ref#3: shared data backref parent 493540999168 count 1
> > > [26062.127636] 		ref#4: shared data backref parent 492676497408 count 1
> > > [26062.127638] 		ref#5: shared data backref parent 475691106304 count 1
> > > [26062.127640] 		ref#6: shared data backref parent 471034494976 count 1
> > > [26062.127642] 		ref#7: shared data backref parent 436113883136 count 1
> > > [26062.127643] 		ref#8: shared data backref parent 886407168 count 1
> > > [26062.127645] 		ref#9: shared data backref parent 89440256 count 1
> > > [26062.127647] 	item 128 key (458814124032 168 8192) itemoff 7762 itemsize 37
> > > [26062.127648] 		extent refs 1 gen 2407793 flags 1
> > > [26062.127649] 		ref#0: shared data backref parent 475884634112 count 1
> > > [26062.127653] 	item 129 key (458814738432 168 8192) itemoff 7579 itemsize 183
> > > [26062.127655] 		extent refs 11 gen 1800729 flags 1
> > > [26062.127656] 		ref#0: extent data backref root 456 objectid 56413614 offset 40116224 count 1
> > > [26062.127658] 		ref#1: shared data backref parent 508153069568 count 1
> > > [26062.127659] 		ref#2: shared data backref parent 508031270912 count 1
> > > [26062.127661] 		ref#3: shared data backref parent 493564215296 count 1
> > > [26062.127663] 		ref#4: shared data backref parent 493540098048 count 1
> > > [26062.127664] 		ref#5: shared data backref parent 492676038656 count 1
> > > [26062.127666] 		ref#6: shared data backref parent 475884142592 count 1
> > > [26062.127668] 		ref#7: shared data backref parent 471032840192 count 1
> > > [26062.127669] 		ref#8: shared data backref parent 436112146432 count 1
> > > [26062.127671] 		ref#9: shared data backref parent 883752960 count 1
> > > [26062.127674] 		ref#10: shared data backref parent 86654976 count 1
> > > [26062.127678] BTRFS error (device dm-2): unable to find ref byte nr 458640384000 parent 0 root 456  owner 73020573 offset 17039360
> > > [26062.127680] ------------[ cut here ]------------
> > > [26062.127682] BTRFS: Transaction aborted (error -2)
> > > [26062.127696] WARNING: CPU: 7 PID: 12394 at fs/btrfs/extent-tree.c:7106 __btrfs_free_extent+0x1e0/0x921
> > > [26062.127698] Modules linked in: msr ccm ipt_MASQUERADE ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_conntrack nf_log_ipv4 nf_log_common xt_LOG iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables bpfilter rfcomm ax25 bnep pci_stub vboxpci(O) vboxnetadp(O) vboxnetflt(O) vboxdrv(O) autofs4 binfmt_misc uinput nfsd auth_rpcgss nfs_acl nfs lockd grace fscache sunrpc nls_utf8 nls_cp437 vfat fat cuse ecryptfs bbswitch(OE) configs input_polldev loop firewire_sbp2 firewire_core crc_itu_t ppdev parport_pc lp parport uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev media btusb btrtl btbcm btintel bluetooth ecdh_generic hid_generic usbhid hid joydev arc4 coretemp x86_pkg_temp_thermal intel_powerclamp kvm_intel kvm irqbypass snd_hda_codec_realtek snd_hda_codec_generic intel_wmi_thunderbolt iTCO_wdt wmi_bmof mei_hdcp iTCO_vendor_support rtsx_pci_sdmmc snd_hda_intel
> > > [26062.127733]  snd_hda_codec iwlmvm crct10dif_pclmul snd_hda_core crc32_pclmul mac80211 snd_hwdep thinkpad_acpi snd_pcm ghash_clmulni_intel nvram ledtrig_audio intel_cstate deflate snd_seq efi_pstore iwlwifi snd_seq_device snd_timer intel_rapl_perf psmouse pcspkr efivars wmi hwmon snd ac battery cfg80211 mei_me soundcore xhci_pci xhci_hcd rtsx_pci i2c_i801 rfkill sg nvidiafb intel_pch_thermal usbcore vgastate fb_ddc pcc_cpufreq sata_sil24 r8169 libphy mii fuse fan raid456 multipath mmc_block mmc_core dm_snapshot dm_bufio dm_mirror dm_region_hash dm_log dm_crypt dm_mod async_raid6_recov async_pq async_xor async_memcpy async_tx blowfish_x86_64 blowfish_common crc32c_intel bcache crc64 aesni_intel input_leds i915 aes_x86_64 crypto_simd cryptd ptp glue_helper serio_raw pps_core thermal evdev [last unloaded: e1000e]
> > > [26062.127793] CPU: 7 PID: 12394 Comm: btrfs-transacti Tainted: G        W  OE     5.1.21-amd64-preempt-sysrq-20190816 #5
> > > [26062.127795] Hardware name: LENOVO 20ERCTO1WW/20ERCTO1WW, BIOS N1DET95W (2.21 ) 12/13/2017
> > > [26062.127799] RIP: 0010:__btrfs_free_extent+0x1e0/0x921
> > > [26062.127801] Code: e8 82 d2 fe ff 48 8b 43 50 f0 48 0f ba a8 30 17 00 00 02 0f 92 c0 5a 84 c0 75 11 44 89 ee 48 c7 c7 03 d8 f4 89 e8 33 f1 d8 ff <0f> 0b b9 fe ff ff ff ba c2 1b 00 00 48 c7 c6 e0 c7 c3 89 48 89 df
> > > [26062.127803] RSP: 0018:ffffb2d9c46e7c88 EFLAGS: 00010282
> > > [26062.127805] RAX: 0000000000000000 RBX: ffff9abca20884e0 RCX: 0000000000000007
> > > [26062.127807] RDX: 0000000000000000 RSI: ffffb2d9c46e7b64 RDI: ffff9abccf5d6550
> > > [26062.127809] RBP: ffff9ab5a4545460 R08: 0000000000000001 R09: ffffffff8a80c7af
> > > [26062.127811] R10: 0000000005f5e100 R11: ffffb2d9c46e7b27 R12: 0000000000000169
> > > [26062.127813] R13: 00000000fffffffe R14: 0000000001040000 R15: 0000006ac918e000
> > > [26062.127815] FS:  0000000000000000(0000) GS:ffff9abccf5c0000(0000) knlGS:0000000000000000
> > > [26062.127817] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [26062.127819] CR2: 0000199a9fb4d000 CR3: 000000016c20e006 CR4: 00000000003606e0
> > > [26062.127821] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [26062.127822] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [26062.127823] Call Trace:
> > > [26062.127832]  __btrfs_run_delayed_refs+0x750/0xc36
> > > [26062.127837]  ? __switch_to_asm+0x41/0x70
> > > [26062.127839]  ? __switch_to_asm+0x35/0x70
> > > [26062.127841]  ? __switch_to_asm+0x41/0x70
> > > [26062.127848]  ? __switch_to+0x13d/0x3d5
> > > [26062.127852]  btrfs_run_delayed_refs+0x5d/0x132
> > > [26062.127855]  btrfs_commit_transaction+0x55/0x7c8
> > > [26062.127858]  ? start_transaction+0x347/0x3cb
> > > [26062.127862]  transaction_kthread+0xc9/0x135
> > > [26062.127865]  ? btrfs_cleanup_transaction+0x403/0x403
> > > [26062.127869]  kthread+0xeb/0xf0
> > > [26062.127872]  ? kthread_create_worker_on_cpu+0x65/0x65
> > > [26062.127875]  ret_from_fork+0x35/0x40
> > > [26062.127879] ---[ end trace 4c1a6b3749a2f651 ]---
> > > [26062.127914] BTRFS: error (device dm-2) in __btrfs_free_extent:7106: errno=-2 No such entry
> > > [26062.127917] BTRFS info (device dm-2): forced readonly
> > > [26062.127921] BTRFS: error (device dm-2) in btrfs_run_delayed_refs:3008: errno=-2 No such entry

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
