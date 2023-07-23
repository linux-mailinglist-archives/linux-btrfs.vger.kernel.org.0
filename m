Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627AC75E03E
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jul 2023 09:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjGWHXe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jul 2023 03:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjGWHXd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jul 2023 03:23:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963891BD4
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jul 2023 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690096994; x=1690701794; i=quwenruo.btrfs@gmx.com;
 bh=MmnLuxFC4PGVzvZbT0DfW6/mVf32jpmTR95JJNEw1+0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=aw8jWyflOdVsZ7b6agUntL2Gu8sBUuNZeyNto+TFx4R5wOQt+P4mvaqJa+rOuu9BFIgTD3G
 ExwWnNN251OQYdjXYuvmPkZx8uDdeT0B8wWsrINWcLX3cMcu/q5L6bkWGLv4VN+Tpuvb3Zwj2
 kgA9UrS54VsGKaJLdCeRQrxnqIS9xQCDh/Z4V7ASkOpaGw0Kj6eXupANngEnRb5ecVkNC/ELn
 EGRxAZGrRWZQqnwAIM+SX9R2g67gvDHiYdaKB/qrQrP/NXiwrC6c6svipviRjFeTbsFkBa5H9
 yB+yFl2DkFroiKPo/6C4O67Mj/pHk/1oVBrVGDEylddPwWJX1foA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVDM-1qcoQb365I-00Jt4Z; Sun, 23
 Jul 2023 09:23:14 +0200
Message-ID: <c4b714cc-100c-0099-c498-896b815b8e5f@gmx.com>
Date:   Sun, 23 Jul 2023 15:23:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Out of space loop: skip_balance not working
Content-Language: en-US
To:     Stefan N <stefannnau@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Filipe Manana <fdmanana@kernel.org>
References: <CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com>
 <16ab1898-1714-a927-b8df-4a20eb39b8cd@gmx.com>
 <CA+W5K0pm+Aum0vQGeRfUCsH_4x8+L3O+baUfRJM-iWdh+tDwNA@mail.gmail.com>
 <403c9e19-e58e-8857-bee8-dd9f9d8fc34f@suse.com>
 <CA+W5K0qzk0Adt2a_Xp5qh=JYyO02mh5YK3c1wgvQEyS3mHSR_w@mail.gmail.com>
 <e559f54f-c5b8-0132-b420-22b6db5539f3@gmx.com>
 <CA+W5K0r3jpw-zN1y9=essSUUwCRrsGveV1qHSFsKfmrM40OgJQ@mail.gmail.com>
 <1d920a8b-efd8-468b-3abe-f998f0b0966a@gmx.com>
 <CA+W5K0o-aVROdCH+qWacW_96oAVXGpWSXqSSsM=1R024WhLgXQ@mail.gmail.com>
 <124f60c9-4df1-20d0-1884-3d868329608d@suse.com>
 <CA+W5K0r=5RSEvKwN03iTSYwf_5c2QNU02jtumwbXwdo3iV1ZfQ@mail.gmail.com>
 <714d2d98-23f6-fcf2-2ff4-ad6ef85294e7@gmx.com>
 <CA+W5K0r6xPTFa5tGJVgW3GjAQp42kpgAuPGeGpx6Jo5oq=zzSg@mail.gmail.com>
 <CA+W5K0pQyJH5zWxs4JxfHR06DSUWDOcDPNsKxbdKQ_CiUtpyUg@mail.gmail.com>
 <5b42e858-6eb9-31b2-7513-e1346a71e7a4@gmx.com>
 <CA+W5K0oDRo2LZMiUiysYXpcpmfXTvS27hPdjm1pzq4kfq9=vdQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CA+W5K0oDRo2LZMiUiysYXpcpmfXTvS27hPdjm1pzq4kfq9=vdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KcfdhNdk0AbXWyakvo0DN5lfzBa2VRQjqaYWzUsnko5rQY9o/jr
 xZxbJRS6N+XNTzd+1BMyjQvxAV3rlSuBjeOxl54SvXYGIcKQ8p1hdQ3p4e//oNhG5rD5hxB
 VqANJ4qd5LeHj9LsHflmRq3QaTeqGkCipa5SuMseZZZhrWzb96wCtFIWcz4NAJ9kM0oKj5D
 EvVjihk8kDrkhMmeTR3nw==
UI-OutboundReport: notjunk:1;M01:P0:LiuF+Cg0eLI=;4FrDlvuiJIeo4TgfAp7OAAIadB4
 37wsebbSIXdEp1hZNkqKJXVCjYwbRxALgZsIhzAfyC7q4h9/lf0RoyejckkwKwr4xuChufgN/
 vQrGawanMoLYXvcawcvO+HX+9yicSbrSN2gBlU7KyfTCGIL+dsIXYTYg0cUwYn76KkZyzixeA
 iqIfhUR8kywrgTqL0m013Hrz+jTlR3K++BPW7U1uEUGNeN0/9pEx5UubobQXwBOpSsC2ek4yR
 shDY1TvOzTAEBBX/cvckMDRDN3fFUC21TVXFZGZZD/nbowvuddmXXx4CUH8NabdjBGCC8ND7r
 sS3V5vmmR81+bIRZmMOGA4/0rvyrg2gdGu4t9/Ewb1DaFEW0pKR+wzYZ+VQJ+9L0U0j7taZPb
 7fjJNyXI/7KQzslZu1lteAppdUs0JaNXOCV+/pifecLfXmKuK1OoYID8zYf0C88eRzdqZ8XoU
 pcCHVpFbqV3Kzr1eV8kAY6rJRDrXSNVs6dBv3qQXywcA+p6cBQwKLnSX2tUvpB+aW5fshjSGe
 KYlgoQ8dpPIOt6dEBVAkNoSg82xMdXUsXomkU6D5S85nA9KKIsNrsXGl7jGzhfKx7y+rEGlkU
 1mxrAwDrq5WeHOFKveN+KYG8qpKVP2vRI4N2snxGIVZjjtNAgRhQ027gPuS40JdeOwYxlMoDS
 7y2mq6PK+QIyOwsD3e/hCNqBj03c+KBmPt2fiQ5dTq2LhksWPDJLOLXcRFq8NkpoelROL82LI
 ZRtpuUY6/e8rQge4ZGApqEU1BcwyB5yKl0h5fjutaX7No6KUHw7rghCKoWT4zSnk1+GFEdyvG
 noxFk/dz+8HSQ5RUkPH20Cov2U7DrI+YI/F5gz8EEBBAd6FKbzSDpQ9P3dNyhHJuyh456Co7Z
 14o0QAVVViQzasCWGssEtiFnB2GVrZ8QpeADIOyEX83+GAF+bbFvAbd7skholRf14Gc4bWbhQ
 AwBICYssTiaW9CsojUkNCr8PyPU=
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/23 14:21, Stefan N wrote:
> Hi Qu,
>
> Many thanks for that new patch, that's done the job.
>
> As I've now got 3 disks with plenty of space, I've converted
> metadata/system to RAID1C3 to mitigate the issue until the 4th disk has
> finished replacing.
>
> Hopefully a fix for the underlying issue is applied by the time I start
> running low on space, though looking at the usage now (below) it looks
> like I might never run out again=C2=A0=F0=9F=98=82=C2=A0judging by this,=
 is it possible the
> issue I had only existed because I was on LTS with kernel 5,15, and 6.2
> might already have fixed the under allocation issue that caused this?

Unfortunately I'm not an export on the extent allocator nor ENOSPC
situations, thus I can not help much on the root cauese.

Filipe and Josef may provide mode helps on this.

Thanks,
Qu

>
> Many thanks again,
>
> Stefan
>
> Data,RAID6: Size:65.41TiB, Used:65.22TiB (99.70%)
>  =C2=A0 =C2=A0/dev/sdf =C2=A0 =C2=A0 =C2=A0 11.49TiB
>  =C2=A0 =C2=A0/dev/sdg =C2=A0 =C2=A0 =C2=A0 10.91TiB
>  =C2=A0 =C2=A0/dev/sdd =C2=A0 =C2=A0 =C2=A0 11.46TiB
>  =C2=A0 =C2=A0/dev/sdj =C2=A0 =C2=A0 =C2=A0 10.88TiB
>  =C2=A0 =C2=A0/dev/sde =C2=A0 =C2=A0 =C2=A0 10.88TiB
>  =C2=A0 =C2=A0/dev/sdc =C2=A0 =C2=A0 =C2=A0 10.88TiB
>  =C2=A0 =C2=A0/dev/sdh =C2=A0 =C2=A0 =C2=A0 11.47TiB
>  =C2=A0 =C2=A0/dev/sdb =C2=A0 =C2=A0 =C2=A0 10.89TiB
>
> Metadata,RAID1C3: Size:133.00GiB, Used:77.74GiB (58.45%)
>  =C2=A0 =C2=A0/dev/sdf =C2=A0 =C2=A0 =C2=A0133.00GiB
>  =C2=A0 =C2=A0/dev/sdd =C2=A0 =C2=A0 =C2=A0133.00GiB
>  =C2=A0 =C2=A0/dev/sdh =C2=A0 =C2=A0 =C2=A0133.00GiB
>
> System,RAID1C3: Size:32.00MiB, Used:5.25MiB (16.41%)
>  =C2=A0 =C2=A0/dev/sdf =C2=A0 =C2=A0 =C2=A0 32.00MiB
>  =C2=A0 =C2=A0/dev/sdd =C2=A0 =C2=A0 =C2=A0 32.00MiB
>  =C2=A0 =C2=A0/dev/sdh =C2=A0 =C2=A0 =C2=A0 32.00MiB
>
> Unallocated:
>  =C2=A0 =C2=A0/dev/sda =C2=A0 =C2=A0 =C2=A0 10.91TiB <-- replace target =
(in progress)
>  =C2=A0 =C2=A0/dev/sdf =C2=A0 =C2=A0 =C2=A0 =C2=A04.75TiB
>  =C2=A0 =C2=A0/dev/sdg =C2=A0 =C2=A0 =C2=A0 =C2=A05.41GiB
>  =C2=A0 =C2=A0/dev/sdd =C2=A0 =C2=A0 =C2=A0 =C2=A04.78TiB
>  =C2=A0 =C2=A0/dev/sdj =C2=A0 =C2=A0 =C2=A0 36.49GiB
>  =C2=A0 =C2=A0/dev/sde =C2=A0 =C2=A0 =C2=A0 38.53GiB
>  =C2=A0 =C2=A0/dev/sdc =C2=A0 =C2=A0 =C2=A0 36.33GiB
>  =C2=A0 =C2=A0/dev/sdh =C2=A0 =C2=A0 =C2=A0 =C2=A04.77TiB
>  =C2=A0 =C2=A0/dev/sdb =C2=A0 =C2=A0 =C2=A0 26.01GiB
>
>
> On Sat, 22 Jul 2023 at 19:38, Qu Wenruo <quwenruo.btrfs@gmx.com
> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>
>
>
>     On 2023/7/22 13:28, Stefan N wrote:
>      > Hi again Qu,
>      >
>      > Thanks for all your help last month, I managed to get things goin=
g
>      > again and have been slowly adding new disks, but have now ended u=
p
>      > with a similar but slightly more complicated problem I need some =
more
>      > assistance with.
>      >
>      > Since last time: I used loop devices to get the fs operational ag=
ain,
>      > then deleted some files to create space, removed the loop devices=
,
>      > successfully used btrfs replace to replace 3x 12tb disks with 18t=
bs,
>      > and moved to space cache v2 in the hope it'd prevent future issue=
s.
>      >
>      > The problem: during the 4th replace operation the metadata issue =
has
>      > recurred, the first time self correcting when remounted, but this
>      > second time has resulted in a similar paradox to last time. I've
>      > rebooted into the patched kernel from last month, but the same
>      > solution is now ineffective due to the system failing to detect t=
he
>      > replace target, despite no disks having been removed nor changing
>     from
>      > /dev/sda and /dev/sdl during the reboots.
>      >
>      > During the replace process the disks were in use, and while after
>      > there's plenty of space for data it seems enough was written to f=
ill
>      > metadata again. In hindsight I should have left the 4 loop device=
s in
>      > place until the replaces had completed to satisfy the RAID1C4
>      > requirement for the metadata, as despite deleting files data has =
not
>      > been freed from the existing 12tb disks.
>      >
>      > The 'missing' replace target is:
>      > Disk /dev/sda: 16.37 TiB, 18000207937536 bytes, 35156656128 secto=
rs
>
>     The problem seems to be that, replace cancel also needs to commit
>     transaction, which is obviously a bad situation during high metadata
>     stress.
>
>
>     But the root problem is still why we hit ENOSPC, AFAIK Filipe is wor=
king
>     on this problem.
>
>
>     For now, the problem can be more or less worked around by the same
>     method, instead of committing transaction we just cancel the current=
 one
>     so that you can continue to go with the patched device add.
>
>     I have updated the branch to have a new patch, please try if this al=
lows
>     you to mount it with "-o degraded" then try cancel and add devices.
>
>     https://github.com/adam900710/linux/tree/dev_add_no_commit
>     <https://github.com/adam900710/linux/tree/dev_add_no_commit>
>
>     Thanks,
>     Qu
>
>     [...]
>      >
>      >
>      > $ sudo mount -o degraded /mnt/data ; sudo btrfs replace cancel
>      > /mnt/data ; sudo btrfs dev add -K -f /dev/loop20 /dev/loop21
>      > /dev/loop22 /dev/loop23 /mnt/data ; sudo btrfs fi sync /mnt/data
>      > ERROR: error adding device '/dev/loop20': Read-only file system
>      > ERROR: error adding device '/dev/loop21': Read-only file system
>      > ERROR: error adding device '/dev/loop22': Read-only file system
>      > ERROR: error adding device '/dev/loop23': Read-only file system
>      > ERROR: Could not sync filesystem: Read-only file system
>      > $
>      >
>      > syslog:
>      > BTRFS info (device sdf): using crc32c (crc32c-intel) checksum
>     algorithm
>      > BTRFS info (device sdf): allowing degraded mounts
>      > BTRFS info (device sdf): using free space tree
>      > BTRFS info (device sdf): bdev /dev/sdg errs: wr 0, rd 0, flush 0,
>      > corrupt 845, gen 0
>      > BTRFS info (device sdf): bdev /dev/sde errs: wr 3, rd 7, flush 0,
>      > corrupt 0, gen 0
>      > BTRFS info (device sdf): bdev /dev/sdc errs: wr 41, rd 0, flush 0=
,
>      > corrupt 0, gen 0
>      > BTRFS info (device sdf): cannot continue dev_replace, tgtdev is
>     missing
>      > BTRFS info (device sdf): you may cancel the operation after
>     'mount -o degraded'
>      > BTRFS: Transaction aborted (error -28)
>      > WARNING: CPU: 0 PID: 6659 at fs/btrfs/extent-tree.c:3077
>      > __btrfs_free_extent+0xa18/0xf50 [btrfs]
>      > Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_n=
at
>      > xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_=
ipv6
>      > nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tabl=
es
>      > nfnetlink br_netfilter bridge stp llc rpcsec_gss_krb5 nfsv4 nfs
>      > fscache netfs ipmi_devintf ipmi_msghandler overlay iwlwifi_compat=
(O)
>      > binfmt_misc nls_iso8859_1 intel_rapl_msr snd_hda_codec_realtek
>      > snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_in=
tel
>      > snd_intel_dspcfg intel_rapl_common snd_intel_sdw_acpi edac_mce_am=
d
>      > snd_hda_codec kvm_amd snd_hda_core kvm snd_hwdep irqbypass snd_pc=
m
>      > rapl wmi_bmof snd_timer k10temp snd ccp soundcore joydev input_le=
ds
>      > mac_hid dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua
>     bonding tls
>      > msr nfsd efi_pstore auth_rpcgss nfs_acl lockd grace sunrpc dmi_sy=
sfs
>      > ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456
>      > async_raid6_recov async_memcpy async_pq async_xor async_tx xor
>      > raid6_pq libcrc32c raid1 raid0 multipath linear
>      >=C2=A0 =C2=A0hid_logitech_hidpp hid_logitech_dj amdgpu hid_generic=
 iommu_v2
>      > drm_buddy gpu_sched drm_ttm_helper ttm drm_display_helper uas cec
>      > rc_core usbhid hid usb_storage drm_kms_helper syscopyarea sysfill=
rect
>      > sysimgblt crct10dif_pclmul igb crc32_pclmul polyval_clmulni
>      > polyval_generic ghash_clmulni_intel dca sha512_ssse3 aesni_intel
>      > crypto_simd drm nvme ahci cryptd libahci qlcnic i2c_algo_bit
>     nvme_core
>      > mpt3sas xhci_pci video raid_class scsi_transport_sas xhci_pci_ren=
esas
>      > nvme_common i2c_piix4 wmi
>      > CPU: 0 PID: 6659 Comm: btrfs Tainted: G=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 W=C2=A0 O
>      > 6.2.0-23-generic #23+btrdebug2c
>      > Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
>      > P3.70 02/23/2022
>      > RIP: 0010:__btrfs_free_extent+0xa18/0xf50 [btrfs]
>      > Code: 48 c7 c6 80 19 71 c1 48 8b 78 50 e8 82 57 0e 00 41 b8 01 00=
 00
>      > 00 e9 58 fe ff ff 8b 75 94 48 c7 c7 a8 19 71 c1 e8 d8 92 4d c7
>     <0f> 0b
>      > e9 64 fb ff ff 8b 7d 90 e8 b9 04 ff ff 84 c0 0f 85 f1 01 00
>      > RSP: 0018:ffffb05e4746fa38 EFLAGS: 00010246
>      > RAX: 0000000000000000 RBX: 0000b711db1d0000 RCX: 0000000000000000
>      > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>      > RBP: ffffb05e4746fad8 R08: 0000000000000000 R09: 0000000000000000
>      > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
>      > R13: 0000000000000000 R14: ffff88edc031ea90 R15: ffff88edc3ba0230
>      > FS:=C2=A0 00007f2b14740d40(0000) GS:ffff88f4e0a00000(0000)
>     knlGS:0000000000000000
>      > CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>      > CR2: 000000c000253000 CR3: 00000001e7cc8000 CR4: 00000000003506f0
>      > Call Trace:
>      >=C2=A0 =C2=A0<TASK>
>      >=C2=A0 =C2=A0run_delayed_tree_ref+0x69/0x1b0 [btrfs]
>      >=C2=A0 =C2=A0btrfs_run_delayed_refs_for_head+0x3aa/0x520 [btrfs]
>      >=C2=A0 =C2=A0? btrfs_create_pending_block_groups+0x280/0x4d0 [btrf=
s]
>      >=C2=A0 =C2=A0__btrfs_run_delayed_refs+0xe6/0x1d0 [btrfs]
>      >=C2=A0 =C2=A0btrfs_run_delayed_refs+0x6d/0x1f0 [btrfs]
>      >=C2=A0 =C2=A0commit_cowonly_roots+0x1e7/0x240 [btrfs]
>      >=C2=A0 =C2=A0btrfs_commit_transaction+0x5d2/0xbc0 [btrfs]
>      >=C2=A0 =C2=A0? start_transaction+0xc8/0x600 [btrfs]
>      >=C2=A0 =C2=A0btrfs_dev_replace_cancel+0x168/0x2e0 [btrfs]
>      >=C2=A0 =C2=A0btrfs_ioctl+0x12ed/0x14d0 [btrfs]
>      >=C2=A0 =C2=A0? __handle_mm_fault+0x661/0x720
>      >=C2=A0 =C2=A0__x64_sys_ioctl+0xa0/0xe0
>      >=C2=A0 =C2=A0do_syscall_64+0x5b/0x90
>      >=C2=A0 =C2=A0? do_user_addr_fault+0x1e8/0x720
>      >=C2=A0 =C2=A0? exit_to_user_mode_prepare+0x30/0xb0
>      >=C2=A0 =C2=A0? irqentry_exit_to_user_mode+0x9/0x20
>      >=C2=A0 =C2=A0? irqentry_exit+0x43/0x50
>      >=C2=A0 =C2=A0? exc_page_fault+0x91/0x1b0
>      >=C2=A0 =C2=A0entry_SYSCALL_64_after_hwframe+0x72/0xdc
>      > RIP: 0033:0x7f2b145119ef
>      > Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00=
 48
>      > 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05
>     <89> c2
>      > 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
>      > RSP: 002b:00007ffcda96ca10 EFLAGS: 00000246 ORIG_RAX:
>     0000000000000010
>      > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2b145119ef
>      > RDX: 00007ffcda96ca80 RSI: 00000000ca289435 RDI: 0000000000000003
>      > RBP: 0000000000000003 R08: 0000000000021001 R09: 0000000000000000
>      > R10: fffffffffffff000 R11: 0000000000000246 R12: 00007ffcda96e7eb
>      > R13: 000056092aafbe60 R14: 000056092aab3578 R15: 0000000000000000
>      >=C2=A0 =C2=A0</TASK>
>      > ---[ end trace 0000000000000000 ]---
>      > BTRFS info (device sdf: state A): dumping space info:
>      > BTRFS info (device sdf: state A): space_info DATA has 21964679577=
6
>      > free, is not full
>      > BTRFS info (device sdf: state A): space_info total=3D718457421168=
64,
>      > used=3D71626091782144, pinned=3D0, reserved=3D0, may_use=3D0,
>     readonly=3D3538944
>      > zone_unusable=3D0
>      > BTRFS info (device sdf: state A): space_info METADATA has -536821=
760
>      > free, is full
>      > BTRFS info (device sdf: state A): space_info total=3D83481329664,
>      > used=3D83421233152, pinned=3D57606144, reserved=3D2490368,
>      > may_use=3D536821760, readonly=3D0 zone_unusable=3D0
>      > BTRFS info (device sdf: state A): space_info SYSTEM has 20676608
>     free,
>      > is not full
>      > BTRFS info (device sdf: state A): space_info total=3D26214400,
>      > used=3D5537792, pinned=3D0, reserved=3D0, may_use=3D0, readonly=
=3D0
>      > zone_unusable=3D0
>      > BTRFS info (device sdf: state A): global_block_rsv: size 53687091=
2
>      > reserved 536805376
>      > BTRFS info (device sdf: state A): trans_block_rsv: size 0 reserve=
d 0
>      > BTRFS info (device sdf: state A): chunk_block_rsv: size 0 reserve=
d 0
>      > BTRFS info (device sdf: state A): delayed_block_rsv: size 0
>     reserved 0
>      > BTRFS info (device sdf: state A): delayed_refs_rsv: size 52323942=
4
>      > reserved 16384
>      > BTRFS: error (device sdf: state A) in __btrfs_free_extent:3077:
>      > errno=3D-28 No space left
>      > BTRFS info (device sdf: state EA): forced readonly
>      > BTRFS error (device sdf: state EA): failed to run delayed ref for
>      > logical 201287318437888 num_bytes 16384 type 176 action 2 ref_mod=
 1:
>      > -28
>      > BTRFS: error (device sdf: state EA) in btrfs_run_delayed_refs:215=
1:
>      > errno=3D-28 No space left
>      > BTRFS warning (device sdf: state EA): Skipping commit of aborted
>     transaction.
>      > BTRFS: error (device sdf: state EA) in cleanup_transaction:1986:
>      > errno=3D-28 No space left
>      > ------------[ cut here ]------------
>      > WARNING: CPU: 0 PID: 6659 at fs/btrfs/dev-replace.c:1121
>      > btrfs_dev_replace_cancel+0x2b0/0x2e0 [btrfs]
>      > Modules linked in: xt_nat xt_tcpudp veth xt_conntrack nft_chain_n=
at
>      > xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_=
ipv6
>      > nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat nf_tabl=
es
>      > nfnetlink br_netfilter bridge stp llc rpcsec_gss_krb5 nfsv4 nfs
>      > fscache netfs ipmi_devintf ipmi_msghandler overlay iwlwifi_compat=
(O)
>      > binfmt_misc nls_iso8859_1 intel_rapl_msr snd_hda_codec_realtek
>      > snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_in=
tel
>      > snd_intel_dspcfg intel_rapl_common snd_intel_sdw_acpi edac_mce_am=
d
>      > snd_hda_codec kvm_amd snd_hda_core kvm snd_hwdep irqbypass snd_pc=
m
>      > rapl wmi_bmof snd_timer k10temp snd ccp soundcore joydev input_le=
ds
>      > mac_hid dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua
>     bonding tls
>      > msr nfsd efi_pstore auth_rpcgss nfs_acl lockd grace sunrpc dmi_sy=
sfs
>      > ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456
>      > async_raid6_recov async_memcpy async_pq async_xor async_tx xor
>      > raid6_pq libcrc32c raid1 raid0 multipath linear
>      > 2023-07-22T14:04:29.956673+09:30 ltsnas kernel: [=C2=A0 422.69018=
4]
>      > hid_logitech_hidpp hid_logitech_dj amdgpu hid_generic iommu_v2
>      > drm_buddy gpu_sched drm_ttm_helper ttm drm_display_helper uas cec
>      > rc_core usbhid hid usb_storage drm_kms_helper syscopyarea sysfill=
rect
>      > sysimgblt crct10dif_pclmul igb crc32_pclmul polyval_clmulni
>      > polyval_generic ghash_clmulni_intel dca sha512_ssse3 aesni_intel
>      > crypto_simd drm nvme ahci cryptd libahci qlcnic i2c_algo_bit
>     nvme_core
>      > mpt3sas xhci_pci video raid_class scsi_transport_sas xhci_pci_ren=
esas
>      > nvme_common i2c_piix4 wmi
>      > CPU: 0 PID: 6659 Comm: btrfs Tainted: G=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 W=C2=A0 O
>      > 6.2.0-23-generic #23+btrdebug2c
>      > Hardware name: To Be Filled By O.E.M. X570M Pro4/X570M Pro4, BIOS
>      > P3.70 02/23/2022
>      > RIP: 0010:btrfs_dev_replace_cancel+0x2b0/0x2e0 [btrfs]
>      > Code: 4c 89 c2 e8 52 3f 02 00 e8 9d 4a 4e c7 e9 35 ff ff ff 4c 89=
 e7
>      > 48 89 45 d0 e8 bc d5 3f c8 48 8b 45 d0 41 89 c5 e9 38 ff ff ff
>     <0f> 0b
>      > e9 b9 fe ff ff 41 bd e2 ff ff ff e9 26 ff ff ff 48 c7 c2 74
>      > RSP: 0018:ffffb05e4746fd58 EFLAGS: 00010286
>      > RAX: 00000000ffffffe4 RBX: ffff88edda916000 RCX: 0000000000000000
>      > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>      > RBP: ffffb05e4746fd88 R08: 0000000000000000 R09: 0000000000000000
>      > R10: 0000000000000000 R11: 0000000000000000 R12: ffff88edda916ab0
>      > R13: ffff88eddb627800 R14: ffff88ede7fad000 R15: ffff88edda916ad0
>      > FS:=C2=A0 00007f2b14740d40(0000) GS:ffff88f4e0a00000(0000)
>     knlGS:0000000000000000
>      > CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>      > CR2: 000000c000253000 CR3: 00000001e7cc8000 CR4: 00000000003506f0
>      > Call Trace:
>      >=C2=A0 =C2=A0<TASK>
>      >=C2=A0 =C2=A0btrfs_ioctl+0x12ed/0x14d0 [btrfs]
>      >=C2=A0 =C2=A0? __handle_mm_fault+0x661/0x720
>      >=C2=A0 =C2=A0__x64_sys_ioctl+0xa0/0xe0
>      >=C2=A0 =C2=A0do_syscall_64+0x5b/0x90
>      >=C2=A0 =C2=A0? do_user_addr_fault+0x1e8/0x720
>      >=C2=A0 =C2=A0? exit_to_user_mode_prepare+0x30/0xb0
>      >=C2=A0 =C2=A0? irqentry_exit_to_user_mode+0x9/0x20
>      >=C2=A0 =C2=A0? irqentry_exit+0x43/0x50
>      >=C2=A0 =C2=A0? exc_page_fault+0x91/0x1b0
>      >=C2=A0 =C2=A0entry_SYSCALL_64_after_hwframe+0x72/0xdc
>      > RIP: 0033:0x7f2b145119ef
>      > Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00=
 48
>      > 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05
>     <89> c2
>      > 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
>      > RSP: 002b:00007ffcda96ca10 EFLAGS: 00000246 ORIG_RAX:
>     0000000000000010
>      > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f2b145119ef
>      > RDX: 00007ffcda96ca80 RSI: 00000000ca289435 RDI: 0000000000000003
>      > RBP: 0000000000000003 R08: 0000000000021001 R09: 0000000000000000
>      > R10: fffffffffffff000 R11: 0000000000000246 R12: 00007ffcda96e7eb
>      > R13: 000056092aafbe60 R14: 000056092aab3578 R15: 0000000000000000
>      >=C2=A0 =C2=A0</TASK>
>      > ---[ end trace 0000000000000000 ]---
>      > BTRFS info (device sdf: state EA): suspended dev_replace from
>     /dev/sdl
>      > (devid 4) to <missing disk> canceled
>      > BTRFS error (device sdf: state EA): failed to add disk
>     /dev/loop20: -30
>      > BTRFS error (device sdf: state EA): failed to add disk
>     /dev/loop21: -30
>      > BTRFS error (device sdf: state EA): failed to add disk
>     /dev/loop22: -30
>      > BTRFS error (device sdf: state EA): failed to add disk
>     /dev/loop23: -30
>      >
>      > On Mon, 26 Jun 2023 at 22:28, Stefan N <stefannnau@gmail.com
>     <mailto:stefannnau@gmail.com>> wrote:
>      >>
>      >> Hi Qu,
>      >>
>      >> Thanks for all the help, I managed to get it mounted and synced =
with
>      >> 5G loops (2G allocated to metadata, 3G unallocated on each).
>      >>
>      >> I'm able to read existing files, write new files, and any change=
s
>      >> remain after an unmount and remount.
>      >>
>      >> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo
>     btrfs
>      >> dev add -K -f /dev/loop20 /dev/loop21 /dev/loop22 /dev/loop23
>      >> /mnt/data ; sudo btrfs fi sync /mnt/data
>      >> $ sudo btrfs fi show
>      >> Label: none=C2=A0 uuid: abc123
>      >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Total devices 12 FS bytes used=
 64.52TiB
>      >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 1 size 10.9=
1TiB used 10.89TiB path /dev/sdd
>      >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 2 size 10.9=
1TiB used 10.89TiB path /dev/sdh
>      >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 3 size 10.9=
1TiB used 10.89TiB path /dev/sdb
>      >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 4 size 10.9=
1TiB used 10.89TiB path /dev/sdg
>      >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 5 size 10.9=
1TiB used 10.89TiB path /dev/sdi
>      >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 6 size 10.9=
1TiB used 10.89TiB path /dev/sde
>      >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 7 size 10.9=
1TiB used 10.89TiB path /dev/sdf
>      >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 8 size 10.9=
1TiB used 10.89TiB path /dev/sdc
>      >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A0 9 size 5.00=
GiB used 2.00GiB path /dev/loop20
>      >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A010 size 5.00=
GiB used 2.00GiB path /dev/loop21
>      >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A011 size 5.00=
GiB used 2.00GiB path /dev/loop22
>      >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 devid=C2=A0 =C2=A012 size 5.00=
GiB used 2.00GiB path /dev/loop23
>      >> $
>      >>
>      >> I'd be keen to know what you'd suggest for next steps. I have
>     two 18T
>      >> disks to upgrade two of the existing 12T disks, which could be a
>      >> substitute or add them over USB for a while.
>      >>
>      >> While a random sample of files seem to be perfectly intact, I'd =
be
>      >> keen to verify the integrity to track down any corrupted files.
>      >>
>      >> Should I perform a scrub before adding/replacing the new disks,
>     or can
>      >> this be safely done afterwards? e.g. can I safely add 2x18tb, re=
move
>      >> loops, begin scrub, and then remove 2x 12tb when scrub completes=
?
>      >>
>      >> See kernel log below:
>      >>
>      >> kernel: [=C2=A0 399.272458] BTRFS info (device sdd): using crc32=
c
>      >> (crc32c-intel) checksum algorithm
>      >> kernel: [=C2=A0 399.272476] BTRFS info (device sdd): disk space
>     caching is enabled
>      >> kernel: [=C2=A0 404.855750] BTRFS info (device sdd): bdev /dev/s=
dh
>     errs: wr
>      >> 0, rd 0, flush 0, corrupt 845, gen 0
>      >> kernel: [=C2=A0 404.855766] BTRFS info (device sdd): bdev /dev/s=
db
>     errs: wr
>      >> 41089, rd 1556, flush 0, corrupt 0, gen 0
>      >> kernel: [=C2=A0 404.855778] BTRFS info (device sdd): bdev /dev/s=
di
>     errs: wr
>      >> 3, rd 7, flush 0, corrupt 0, gen 0
>      >> kernel: [=C2=A0 404.855785] BTRFS info (device sdd): bdev /dev/s=
de
>     errs: wr
>      >> 41, rd 0, flush 0, corrupt 0, gen 0
>      >> kernel: [=C2=A0 630.844173] BTRFS info (device sdd): balance: re=
sume
>     skipped
>      >> kernel: [=C2=A0 630.844185] BTRFS info (device sdd): checking UU=
ID tree
>      >> kernel: [=C2=A0 630.871787] BTRFS info (device sdd): disk added
>     /dev/loop20
>      >> kernel: [=C2=A0 630.881223] BTRFS info (device sdd): disk added
>     /dev/loop21
>      >> kernel: [=C2=A0 630.888817] BTRFS info (device sdd): disk added
>     /dev/loop22
>      >> kernel: [=C2=A0 630.896302] BTRFS info (device sdd): disk added
>     /dev/loop23
>      >> kernel: [=C2=A0 846.849616] INFO: task btrfs-uuid:4834 blocked f=
or more
>      >> than 120 seconds.
>      >> kernel: [=C2=A0 846.849660]=C2=A0 =C2=A0 =C2=A0 =C2=A0Tainted: G=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O
>      >> 6.2.0-23-generic #23+btrdebug2c
>      >> kernel: [=C2=A0 846.849693] "echo 0 >
>      >> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>      >> kernel: [=C2=A0 846.849725] task:btrfs-uuid=C2=A0 =C2=A0 =C2=A0 =
state:D stack:0
>      >> pid:4834=C2=A0 ppid:2=C2=A0 =C2=A0 =C2=A0 flags:0x00004000
>      >> kernel: [=C2=A0 846.849735] Call Trace:
>      >> kernel: [=C2=A0 846.849739]=C2=A0 <TASK>
>      >> kernel: [=C2=A0 846.849747]=C2=A0 __schedule+0x2aa/0x610
>      >> kernel: [=C2=A0 846.849761]=C2=A0 schedule+0x63/0x110
>      >> kernel: [=C2=A0 846.849769]=C2=A0 wait_current_trans+0x100/0x160=
 [btrfs]
>      >> kernel: [=C2=A0 846.849908]=C2=A0 ? __pfx_autoremove_wake_functi=
on+0x10/0x10
>      >> kernel: [=C2=A0 846.849920]=C2=A0 start_transaction+0x28b/0x600 =
[btrfs]
>      >> kernel: [=C2=A0 846.850057]=C2=A0 btrfs_start_transaction+0x1e/0=
x30 [btrfs]
>      >> kernel: [=C2=A0 846.850191]=C2=A0 btrfs_uuid_scan_kthread+0x314/=
0x420 [btrfs]
>      >> kernel: [=C2=A0 846.850359]=C2=A0 ?
>     __pfx_btrfs_uuid_rescan_kthread+0x10/0x10 [btrfs]
>      >> kernel: [=C2=A0 846.850487]=C2=A0 btrfs_uuid_rescan_kthread+0x20=
/0x70 [btrfs]
>      >> kernel: [=C2=A0 846.850614]=C2=A0 kthread+0xe9/0x110
>      >> kernel: [=C2=A0 846.850623]=C2=A0 ? __pfx_kthread+0x10/0x10
>      >> kernel: [=C2=A0 846.850631]=C2=A0 ret_from_fork+0x2c/0x50
>      >> kernel: [=C2=A0 846.850642]=C2=A0 </TASK>
>      >> kernel: [=C2=A0 846.850645] INFO: task btrfs:4850 blocked for mo=
re
>     than 120 seconds.
>      >> kernel: [=C2=A0 846.850676]=C2=A0 =C2=A0 =C2=A0 =C2=A0Tainted: G=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O
>      >> 6.2.0-23-generic #23+btrdebug2c
>      >> kernel: [=C2=A0 846.850707] "echo 0 >
>      >> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>      >> kernel: [=C2=A0 846.850738] task:btrfs=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0state:D stack:0
>      >> pid:4850=C2=A0 ppid:4849=C2=A0 =C2=A0flags:0x00000002
>      >> kernel: [=C2=A0 846.850746] Call Trace:
>      >> kernel: [=C2=A0 846.850749]=C2=A0 <TASK>
>      >> kernel: [=C2=A0 846.850752]=C2=A0 __schedule+0x2aa/0x610
>      >> kernel: [=C2=A0 846.850760]=C2=A0 schedule+0x63/0x110
>      >> kernel: [=C2=A0 846.850765]=C2=A0 btrfs_commit_transaction+0x9b7=
/0xbc0 [btrfs]
>      >> kernel: [=C2=A0 846.850899]=C2=A0 ? __pfx_autoremove_wake_functi=
on+0x10/0x10
>      >> kernel: [=C2=A0 846.850908]=C2=A0 btrfs_sync_fs+0x5a/0x1b0 [btrf=
s]
>      >> kernel: [=C2=A0 846.851027]=C2=A0 btrfs_ioctl+0x643/0x14d0 [btrf=
s]
>      >> kernel: [=C2=A0 846.851186]=C2=A0 ? putname+0x5d/0x80
>      >> kernel: [=C2=A0 846.851195]=C2=A0 ? do_sys_openat2+0xab/0x180
>      >> kernel: [=C2=A0 846.851203]=C2=A0 ? exit_to_user_mode_prepare+0x=
30/0xb0
>      >> kernel: [=C2=A0 846.851213]=C2=A0 __x64_sys_ioctl+0xa0/0xe0
>      >> kernel: [=C2=A0 846.851221]=C2=A0 do_syscall_64+0x5b/0x90
>      >> kernel: [=C2=A0 846.851229]=C2=A0 ? exc_page_fault+0x91/0x1b0
>      >> kernel: [=C2=A0 846.851236]=C2=A0 entry_SYSCALL_64_after_hwframe=
+0x72/0xdc
>      >> kernel: [=C2=A0 846.851243] RIP: 0033:0x7fbf339119ef
>      >> kernel: [=C2=A0 846.851249] RSP: 002b:00007ffd58427660 EFLAGS: 0=
0000246
>      >> ORIG_RAX: 0000000000000010
>      >> kernel: [=C2=A0 846.851255] RAX: ffffffffffffffda RBX: 000000000=
0000003
>      >> RCX: 00007fbf339119ef
>      >> kernel: [=C2=A0 846.851259] RDX: 0000000000000000 RSI: 000000000=
0009408
>      >> RDI: 0000000000000003
>      >> kernel: [=C2=A0 846.851263] RBP: 0000000000000007 R08: 000000000=
0000000
>      >> R09: 0000000000000000
>      >> kernel: [=C2=A0 846.851266] R10: 0000000000000000 R11: 000000000=
0000246
>      >> R12: 00007fbf339f642c
>      >> kernel: [=C2=A0 846.851269] R13: 0000000000000001 R14: 000055738=
4b29578
>      >> R15: 0000000000000000
>      >> kernel: [=C2=A0 846.851277]=C2=A0 </TASK>
>      >> kernel: [=C2=A0 967.681770] INFO: task btrfs-uuid:4834 blocked f=
or more
>      >> than 241 seconds.
>      >> kernel: [=C2=A0 967.681818]=C2=A0 =C2=A0 =C2=A0 =C2=A0Tainted: G=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O
>      >> 6.2.0-23-generic #23+btrdebug2c
>      >> kernel: [=C2=A0 967.681852] "echo 0 >
>      >> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>      >> kernel: [=C2=A0 967.681884] task:btrfs-uuid=C2=A0 =C2=A0 =C2=A0 =
state:D stack:0
>      >> pid:4834=C2=A0 ppid:2=C2=A0 =C2=A0 =C2=A0 flags:0x00004000
>      >> kernel: [=C2=A0 967.681895] Call Trace:
>      >> kernel: [=C2=A0 967.681899]=C2=A0 <TASK>
>      >> kernel: [=C2=A0 967.681907]=C2=A0 __schedule+0x2aa/0x610
>      >> kernel: [=C2=A0 967.681922]=C2=A0 schedule+0x63/0x110
>      >> kernel: [=C2=A0 967.681931]=C2=A0 wait_current_trans+0x100/0x160=
 [btrfs]
>      >> kernel: [=C2=A0 967.682070]=C2=A0 ? __pfx_autoremove_wake_functi=
on+0x10/0x10
>      >> kernel: [=C2=A0 967.682082]=C2=A0 start_transaction+0x28b/0x600 =
[btrfs]
>      >> kernel: [=C2=A0 967.682219]=C2=A0 btrfs_start_transaction+0x1e/0=
x30 [btrfs]
>      >> kernel: [=C2=A0 967.682353]=C2=A0 btrfs_uuid_scan_kthread+0x314/=
0x420 [btrfs]
>      >> kernel: [=C2=A0 967.682519]=C2=A0 ?
>     __pfx_btrfs_uuid_rescan_kthread+0x10/0x10 [btrfs]
>      >> kernel: [=C2=A0 967.682645]=C2=A0 btrfs_uuid_rescan_kthread+0x20=
/0x70 [btrfs]
>      >> kernel: [=C2=A0 967.682728]=C2=A0 kthread+0xe9/0x110
>      >> kernel: [=C2=A0 967.682734]=C2=A0 ? __pfx_kthread+0x10/0x10
>      >> kernel: [=C2=A0 967.682739]=C2=A0 ret_from_fork+0x2c/0x50
>      >> kernel: [=C2=A0 967.682746]=C2=A0 </TASK>
>      >> kernel: [=C2=A0 967.682749] INFO: task btrfs:4850 blocked for mo=
re
>     than 241 seconds.
>      >> kernel: [=C2=A0 967.682771]=C2=A0 =C2=A0 =C2=A0 =C2=A0Tainted: G=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O
>      >> 6.2.0-23-generic #23+btrdebug2c
>      >> kernel: [=C2=A0 967.682793] "echo 0 >
>      >> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>      >> kernel: [=C2=A0 967.682815] task:btrfs=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0state:D stack:0
>      >> pid:4850=C2=A0 ppid:4849=C2=A0 =C2=A0flags:0x00000002
>      >> kernel: [=C2=A0 967.682820] Call Trace:
>      >> kernel: [=C2=A0 967.682822]=C2=A0 <TASK>
>      >> kernel: [=C2=A0 967.682824]=C2=A0 __schedule+0x2aa/0x610
>      >> kernel: [=C2=A0 967.682829]=C2=A0 schedule+0x63/0x110
>      >> kernel: [=C2=A0 967.682832]=C2=A0 btrfs_commit_transaction+0x9b7=
/0xbc0 [btrfs]
>      >> kernel: [=C2=A0 967.682918]=C2=A0 ? __pfx_autoremove_wake_functi=
on+0x10/0x10
>      >> kernel: [=C2=A0 967.682923]=C2=A0 btrfs_sync_fs+0x5a/0x1b0 [btrf=
s]
>      >> kernel: [=C2=A0 967.682999]=C2=A0 btrfs_ioctl+0x643/0x14d0 [btrf=
s]
>      >> kernel: [=C2=A0 967.683085]=C2=A0 ? putname+0x5d/0x80
>      >> kernel: [=C2=A0 967.683091]=C2=A0 ? do_sys_openat2+0xab/0x180
>      >> kernel: [=C2=A0 967.683096]=C2=A0 ? exit_to_user_mode_prepare+0x=
30/0xb0
>      >> kernel: [=C2=A0 967.683103]=C2=A0 __x64_sys_ioctl+0xa0/0xe0
>      >> kernel: [=C2=A0 967.683107]=C2=A0 do_syscall_64+0x5b/0x90
>      >> kernel: [=C2=A0 967.683112]=C2=A0 ? exc_page_fault+0x91/0x1b0
>      >> kernel: [=C2=A0 967.683116]=C2=A0 entry_SYSCALL_64_after_hwframe=
+0x72/0xdc
>      >> kernel: [=C2=A0 967.683121] RIP: 0033:0x7fbf339119ef
>      >> kernel: [=C2=A0 967.683124] RSP: 002b:00007ffd58427660 EFLAGS: 0=
0000246
>      >> ORIG_RAX: 0000000000000010
>      >> kernel: [=C2=A0 967.683128] RAX: ffffffffffffffda RBX: 000000000=
0000003
>      >> RCX: 00007fbf339119ef
>      >> kernel: [=C2=A0 967.683130] RDX: 0000000000000000 RSI: 000000000=
0009408
>      >> RDI: 0000000000000003
>      >> kernel: [=C2=A0 967.683132] RBP: 0000000000000007 R08: 000000000=
0000000
>      >> R09: 0000000000000000
>      >> kernel: [=C2=A0 967.683134] R10: 0000000000000000 R11: 000000000=
0000246
>      >> R12: 00007fbf339f642c
>      >> kernel: [=C2=A0 967.683136] R13: 0000000000000001 R14: 000055738=
4b29578
>      >> R15: 0000000000000000
>      >> kernel: [=C2=A0 967.683141]=C2=A0 </TASK>
>      >> kernel: [ 1088.519959] INFO: task btrfs-uuid:4834 blocked for mo=
re
>      >> than 362 seconds.
>      >> kernel: [ 1088.520006]=C2=A0 =C2=A0 =C2=A0 =C2=A0Tainted: G=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O
>      >> 6.2.0-23-generic #23+btrdebug2c
>      >> kernel: [ 1088.520039] "echo 0 >
>      >> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>      >> kernel: [ 1088.520071] task:btrfs-uuid=C2=A0 =C2=A0 =C2=A0 state=
:D stack:0
>      >> pid:4834=C2=A0 ppid:2=C2=A0 =C2=A0 =C2=A0 flags:0x00004000
>      >> kernel: [ 1088.520082] Call Trace:
>      >> kernel: [ 1088.520087]=C2=A0 <TASK>
>      >> kernel: [ 1088.520094]=C2=A0 __schedule+0x2aa/0x610
>      >> kernel: [ 1088.520108]=C2=A0 schedule+0x63/0x110
>      >> kernel: [ 1088.520117]=C2=A0 wait_current_trans+0x100/0x160 [btr=
fs]
>      >> kernel: [ 1088.520257]=C2=A0 ? __pfx_autoremove_wake_function+0x=
10/0x10
>      >> kernel: [ 1088.520269]=C2=A0 start_transaction+0x28b/0x600 [btrf=
s]
>      >> kernel: [ 1088.520406]=C2=A0 btrfs_start_transaction+0x1e/0x30 [=
btrfs]
>      >> kernel: [ 1088.520539]=C2=A0 btrfs_uuid_scan_kthread+0x314/0x420=
 [btrfs]
>      >> kernel: [ 1088.520706]=C2=A0 ?
>     __pfx_btrfs_uuid_rescan_kthread+0x10/0x10 [btrfs]
>      >> kernel: [ 1088.520834]=C2=A0 btrfs_uuid_rescan_kthread+0x20/0x70=
 [btrfs]
>      >> kernel: [ 1088.520961]=C2=A0 kthread+0xe9/0x110
>      >> kernel: [ 1088.520969]=C2=A0 ? __pfx_kthread+0x10/0x10
>      >> kernel: [ 1088.520977]=C2=A0 ret_from_fork+0x2c/0x50
>      >> kernel: [ 1088.520987]=C2=A0 </TASK>
>      >> kernel: [ 1088.520990] INFO: task btrfs:4850 blocked for more
>     than 362 seconds.
>      >> kernel: [ 1088.521021]=C2=A0 =C2=A0 =C2=A0 =C2=A0Tainted: G=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O
>      >> 6.2.0-23-generic #23+btrdebug2c
>      >> kernel: [ 1088.521052] "echo 0 >
>      >> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>      >> kernel: [ 1088.521084] task:btrfs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0state:D stack:0
>      >> pid:4850=C2=A0 ppid:4849=C2=A0 =C2=A0flags:0x00000002
>      >> kernel: [ 1088.521092] Call Trace:
>      >> kernel: [ 1088.521095]=C2=A0 <TASK>
>      >> kernel: [ 1088.521098]=C2=A0 __schedule+0x2aa/0x610
>      >> kernel: [ 1088.521106]=C2=A0 schedule+0x63/0x110
>      >> kernel: [ 1088.521111]=C2=A0 btrfs_commit_transaction+0x9b7/0xbc=
0 [btrfs]
>      >> kernel: [ 1088.521245]=C2=A0 ? __pfx_autoremove_wake_function+0x=
10/0x10
>      >> kernel: [ 1088.521254]=C2=A0 btrfs_sync_fs+0x5a/0x1b0 [btrfs]
>      >> kernel: [ 1088.521372]=C2=A0 btrfs_ioctl+0x643/0x14d0 [btrfs]
>      >> kernel: [ 1088.521530]=C2=A0 ? putname+0x5d/0x80
>      >> kernel: [ 1088.521539]=C2=A0 ? do_sys_openat2+0xab/0x180
>      >> kernel: [ 1088.521548]=C2=A0 ? exit_to_user_mode_prepare+0x30/0x=
b0
>      >> kernel: [ 1088.521559]=C2=A0 __x64_sys_ioctl+0xa0/0xe0
>      >> kernel: [ 1088.521567]=C2=A0 do_syscall_64+0x5b/0x90
>      >> kernel: [ 1088.521575]=C2=A0 ? exc_page_fault+0x91/0x1b0
>      >> kernel: [ 1088.521582]=C2=A0 entry_SYSCALL_64_after_hwframe+0x72=
/0xdc
>      >> kernel: [ 1088.521589] RIP: 0033:0x7fbf339119ef
>      >> kernel: [ 1088.521595] RSP: 002b:00007ffd58427660 EFLAGS: 000002=
46
>      >> ORIG_RAX: 0000000000000010
>      >> kernel: [ 1088.521602] RAX: ffffffffffffffda RBX: 00000000000000=
03
>      >> RCX: 00007fbf339119ef
>      >> kernel: [ 1088.521606] RDX: 0000000000000000 RSI: 00000000000094=
08
>      >> RDI: 0000000000000003
>      >> kernel: [ 1088.521610] RBP: 0000000000000007 R08: 00000000000000=
00
>      >> R09: 0000000000000000
>      >> kernel: [ 1088.521613] R10: 0000000000000000 R11: 00000000000002=
46
>      >> R12: 00007fbf339f642c
>      >> kernel: [ 1088.521616] R13: 0000000000000001 R14: 0000557384b295=
78
>      >> R15: 0000000000000000
>      >> kernel: [ 1088.521626]=C2=A0 </TASK>
>      >> kernel: [ 1209.357423] INFO: task btrfs-uuid:4834 blocked for mo=
re
>      >> than 483 seconds.
>      >> kernel: [ 1209.357473]=C2=A0 =C2=A0 =C2=A0 =C2=A0Tainted: G=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O
>      >> 6.2.0-23-generic #23+btrdebug2c
>      >> kernel: [ 1209.357507] "echo 0 >
>      >> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>      >> kernel: [ 1209.357540] task:btrfs-uuid=C2=A0 =C2=A0 =C2=A0 state=
:D stack:0
>      >> pid:4834=C2=A0 ppid:2=C2=A0 =C2=A0 =C2=A0 flags:0x00004000
>      >> kernel: [ 1209.357551] Call Trace:
>      >> kernel: [ 1209.357555]=C2=A0 <TASK>
>      >> kernel: [ 1209.357563]=C2=A0 __schedule+0x2aa/0x610
>      >> kernel: [ 1209.357577]=C2=A0 schedule+0x63/0x110
>      >> kernel: [ 1209.357597]=C2=A0 wait_current_trans+0x100/0x160 [btr=
fs]
>      >> kernel: [ 1209.357738]=C2=A0 ? __pfx_autoremove_wake_function+0x=
10/0x10
>      >> kernel: [ 1209.357750]=C2=A0 start_transaction+0x28b/0x600 [btrf=
s]
>      >> kernel: [ 1209.357887]=C2=A0 btrfs_start_transaction+0x1e/0x30 [=
btrfs]
>      >> kernel: [ 1209.358021]=C2=A0 btrfs_uuid_scan_kthread+0x314/0x420=
 [btrfs]
>      >> kernel: [ 1209.358187]=C2=A0 ?
>     __pfx_btrfs_uuid_rescan_kthread+0x10/0x10 [btrfs]
>      >> kernel: [ 1209.358315]=C2=A0 btrfs_uuid_rescan_kthread+0x20/0x70=
 [btrfs]
>      >> kernel: [ 1209.358442]=C2=A0 kthread+0xe9/0x110
>      >> kernel: [ 1209.358451]=C2=A0 ? __pfx_kthread+0x10/0x10
>      >> kernel: [ 1209.358458]=C2=A0 ret_from_fork+0x2c/0x50
>      >> kernel: [ 1209.358468]=C2=A0 </TASK>
>      >> kernel: [ 1330.195147] INFO: task btrfs-transacti:4088 blocked f=
or
>      >> more than 120 seconds.
>      >> kernel: [ 1330.195192]=C2=A0 =C2=A0 =C2=A0 =C2=A0Tainted: G=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O
>      >> 6.2.0-23-generic #23+btrdebug2c
>      >> kernel: [ 1330.195221] "echo 0 >
>      >> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>      >> kernel: [ 1330.195250] task:btrfs-transacti state:D stack:0
>      >> pid:4088=C2=A0 ppid:2=C2=A0 =C2=A0 =C2=A0 flags:0x00004000
>      >> kernel: [ 1330.195259] Call Trace:
>      >> kernel: [ 1330.195263]=C2=A0 <TASK>
>      >> kernel: [ 1330.195269]=C2=A0 __schedule+0x2aa/0x610
>      >> kernel: [ 1330.195281]=C2=A0 schedule+0x63/0x110
>      >> kernel: [ 1330.195288]=C2=A0 wait_for_commit+0x14c/0x1b0 [btrfs]
>      >> kernel: [ 1330.195413]=C2=A0 ? __pfx_autoremove_wake_function+0x=
10/0x10
>      >> kernel: [ 1330.195424]=C2=A0 btrfs_commit_transaction+0x16c/0xbc=
0 [btrfs]
>      >> kernel: [ 1330.195552]=C2=A0 ? start_transaction+0xc8/0x600 [btr=
fs]
>      >> kernel: [ 1330.195676]=C2=A0 transaction_kthread+0x14b/0x1c0 [bt=
rfs]
>      >> kernel: [ 1330.195795]=C2=A0 ? __pfx_transaction_kthread+0x10/0x=
10
>     [btrfs]
>      >> kernel: [ 1330.195912]=C2=A0 kthread+0xe9/0x110
>      >> kernel: [ 1330.195920]=C2=A0 ? __pfx_kthread+0x10/0x10
>      >> kernel: [ 1330.195927]=C2=A0 ret_from_fork+0x2c/0x50
>      >> kernel: [ 1330.195937]=C2=A0 </TASK>
>      >> kernel: [ 1330.195939] INFO: task btrfs-uuid:4834 blocked for mo=
re
>      >> than 604 seconds.
>      >> kernel: [ 1330.195968]=C2=A0 =C2=A0 =C2=A0 =C2=A0Tainted: G=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O
>      >> 6.2.0-23-generic #23+btrdebug2c
>      >> kernel: [ 1330.195997] "echo 0 >
>      >> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>      >> kernel: [ 1330.196026] task:btrfs-uuid=C2=A0 =C2=A0 =C2=A0 state=
:D stack:0
>      >> pid:4834=C2=A0 ppid:2=C2=A0 =C2=A0 =C2=A0 flags:0x00004000
>      >> kernel: [ 1330.196033] Call Trace:
>      >> kernel: [ 1330.196036]=C2=A0 <TASK>
>      >> kernel: [ 1330.196039]=C2=A0 __schedule+0x2aa/0x610
>      >> kernel: [ 1330.196046]=C2=A0 schedule+0x63/0x110
>      >> kernel: [ 1330.196051]=C2=A0 wait_current_trans+0x100/0x160 [btr=
fs]
>      >> kernel: [ 1330.196169]=C2=A0 ? __pfx_autoremove_wake_function+0x=
10/0x10
>      >> kernel: [ 1330.196177]=C2=A0 start_transaction+0x28b/0x600 [btrf=
s]
>      >> kernel: [ 1330.196298]=C2=A0 btrfs_start_transaction+0x1e/0x30 [=
btrfs]
>      >> kernel: [ 1330.196416]=C2=A0 btrfs_uuid_scan_kthread+0x314/0x420=
 [btrfs]
>      >> kernel: [ 1330.196565]=C2=A0 ?
>     __pfx_btrfs_uuid_rescan_kthread+0x10/0x10 [btrfs]
>      >> kernel: [ 1330.196680]=C2=A0 btrfs_uuid_rescan_kthread+0x20/0x70=
 [btrfs]
>      >> kernel: [ 1330.196794]=C2=A0 kthread+0xe9/0x110
>      >> kernel: [ 1330.196800]=C2=A0 ? __pfx_kthread+0x10/0x10
>      >> kernel: [ 1330.196807]=C2=A0 ret_from_fork+0x2c/0x50
>      >> kernel: [ 1330.196814]=C2=A0 </TASK>
>      >> kernel: [ 1451.031238] INFO: task btrfs-transacti:4088 blocked f=
or
>      >> more than 241 seconds.
>      >> kernel: [ 1451.031286]=C2=A0 =C2=A0 =C2=A0 =C2=A0Tainted: G=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O
>      >> 6.2.0-23-generic #23+btrdebug2c
>      >> kernel: [ 1451.031319] "echo 0 >
>      >> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>      >> kernel: [ 1451.031352] task:btrfs-transacti state:D stack:0
>      >> pid:4088=C2=A0 ppid:2=C2=A0 =C2=A0 =C2=A0 flags:0x00004000
>      >> kernel: [ 1451.031362] Call Trace:
>      >> kernel: [ 1451.031366]=C2=A0 <TASK>
>      >> kernel: [ 1451.031373]=C2=A0 __schedule+0x2aa/0x610
>      >> kernel: [ 1451.031388]=C2=A0 schedule+0x63/0x110
>      >> kernel: [ 1451.031396]=C2=A0 wait_for_commit+0x14c/0x1b0 [btrfs]
>      >> kernel: [ 1451.031535]=C2=A0 ? __pfx_autoremove_wake_function+0x=
10/0x10
>      >> kernel: [ 1451.031548]=C2=A0 btrfs_commit_transaction+0x16c/0xbc=
0 [btrfs]
>      >> kernel: [ 1451.031684]=C2=A0 ? start_transaction+0xc8/0x600 [btr=
fs]
>      >> kernel: [ 1451.031819]=C2=A0 transaction_kthread+0x14b/0x1c0 [bt=
rfs]
>      >> kernel: [ 1451.031951]=C2=A0 ? __pfx_transaction_kthread+0x10/0x=
10
>     [btrfs]
>      >> kernel: [ 1451.032082]=C2=A0 kthread+0xe9/0x110
>      >> kernel: [ 1451.032091]=C2=A0 ? __pfx_kthread+0x10/0x10
>      >> kernel: [ 1451.032098]=C2=A0 ret_from_fork+0x2c/0x50
>      >> kernel: [ 1451.032108]=C2=A0 </TASK>
>      >>
>      >> On Mon, 26 Jun 2023 at 19:48, Qu Wenruo <quwenruo.btrfs@gmx.com
>     <mailto:quwenruo.btrfs@gmx.com>> wrote:
>      >>>
>      >>>
>      >>>
>      >>> On 2023/6/24 23:29, Stefan N wrote:
>      >>>> Whoops, I had left --dry-run on the first debug patch you
>     commited, so
>      >>>> that didn't run correctly.
>      >>>>
>      >>>> I've included the output from both patches, as they result in
>     different output.
>      >>>>
>      >>>> Rerunning the older patch first, with loop devices (I tried bo=
th
>      >>>> 4x100mb and 4x1gb) I get the following:
>      >>>>
>      >>> [...]
>      >>>> *** The below is using the newer patch as follows:
>      >>>> $ diff fs/btrfs/ ../linux-6.2.0-dist/fs/btrfs/
>      >>>> diff fs/btrfs/ioctl.c ../linux-6.2.0-dist/fs/btrfs/ioctl.c
>      >>>> 2656,2658d2655
>      >>>> <=C2=A0 =C2=A0 =C2=A0 =C2=A0else
>      >>>> <=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0btrfs_=
err(fs_info, "failed to add disk %s: %d",
>      >>>> <=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vol_args->name, ret);
>      >>>> diff fs/btrfs/transaction.c
>     ../linux-6.2.0-dist/fs/btrfs/transaction.c
>      >>>> 1029d1028
>      >>>> <=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
>      >>>> 1031d1029
>      >>>> <=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>      >>>> diff fs/btrfs/volumes.c ../linux-6.2.0-dist/fs/btrfs/volumes.c
>      >>>> 2677c2677
>      >>>> <=C2=A0 =C2=A0 =C2=A0 =C2=A0trans =3D btrfs_join_transaction(r=
oot);
>      >>>> ---
>      >>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trans =3D btrfs_start_transa=
ction(root, 0);
>      >>>> 2680d2679
>      >>>> <=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0btrfs_=
err(fs_info, "failed to start trans:
>     %d", ret);
>      >>>> 2769d2767
>      >>>> <=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0btrfs_=
err(fs_info, "failed to add dev item:
>     %d", ret);
>      >>>> 2787,2789c2785
>      >>>> <=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D btrfs_end_transaction(tran=
s);
>      >>>> <=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret < 0)
>      >>>> <=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0btrfs_=
err(fs_info, "failed to end trans: %d",
>     ret);
>      >>>> ---
>      >>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D btrfs_commit_transac=
tion(trans);
>      >>>> $
>      >>>>
>      >>>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ;
>     sudo btrfs
>      >>>> dev add -K -f /dev/loop12 /dev/loop13 /dev/loop14 /dev/loop15
>      >>>> /mnt/data ; sudo btrfs fi sync /mnt/data
>      >>>> ERROR: Could not sync filesystem: No space left on device
>      >>>
>      >>> Is it the same even with 4x1GiB loopback devices?
>      >>>
>      >>>> $
>      >>>>
>      >>>> kernel: [ 1811.846087] BTRFS info (device sdc): using crc32c
>      >>>> (crc32c-intel) checksum algorithm
>      >>>> kernel: [ 1811.846107] BTRFS info (device sdc): disk space
>     caching is enabled
>      >>>> kernel: [ 1817.852850] BTRFS info (device sdc): bdev /dev/sde
>     errs: wr
>      >>>> 0, rd 0, flush 0, corrupt 845, gen 0
>      >>>> kernel: [ 1817.852866] BTRFS info (device sdc): bdev /dev/sda
>     errs: wr
>      >>>> 41089, rd 1556, flush 0, corrupt 0, gen 0
>      >>>> kernel: [ 1817.852877] BTRFS info (device sdc): bdev /dev/sdh
>     errs: wr
>      >>>> 3, rd 7, flush 0, corrupt 0, gen 0
>      >>>> kernel: [ 1817.852884] BTRFS info (device sdc): bdev /dev/sdd
>     errs: wr
>      >>>> 41, rd 0, flush 0, corrupt 0, gen 0
>      >>>> kernel: [ 2037.562050] BTRFS info (device sdc): balance:
>     resume skipped
>      >>>> kernel: [ 2037.562064] BTRFS info (device sdc): checking UUID =
tree
>      >>>> kernel: [ 2037.581550] BTRFS info (device sdc): disk added
>     /dev/loop12
>      >>>> kernel: [ 2037.591163] BTRFS info (device sdc): disk added
>     /dev/loop13
>      >>>> kernel: [ 2037.599477] BTRFS info (device sdc): disk added
>     /dev/loop14
>      >>>> kernel: [ 2037.607064] BTRFS info (device sdc): disk added
>     /dev/loop15
>      >>>> kernel: [ 2176.124630] INFO: task btrfs:7783 blocked for more
>     than 120 seconds.
>      >>>> kernel: [ 2176.124678]=C2=A0 =C2=A0 =C2=A0 =C2=A0Tainted: G=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O
>      >>>> 6.2.0-23-generic #23+btrdebug2c
>      >>>> kernel: [ 2176.124710] "echo 0 >
>      >>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message=
.
>      >>>> kernel: [ 2176.124742] task:btrfs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0state:D stack:0
>      >>>> pid:7783=C2=A0 ppid:7782=C2=A0 =C2=A0flags:0x00004002
>      >>>> kernel: [ 2176.124753] Call Trace:
>      >>>> kernel: [ 2176.124758]=C2=A0 <TASK>
>      >>>> kernel: [ 2176.124765]=C2=A0 __schedule+0x2aa/0x610
>      >>>> kernel: [ 2176.124780]=C2=A0 schedule+0x63/0x110
>      >>>> kernel: [ 2176.124788]=C2=A0 btrfs_commit_transaction+0x9b7/0x=
bc0
>     [btrfs]
>      >>>
>      >>> This means we're doing the real work, but it seems to take too
>     long.
>      >>>
>      >>> In fact this is already looking promising as we have when
>     through the
>      >>> whole device add part.
>      >>>
>      >>> Just need to let the final commit to finish.
>      >>>
>      >>>> kernel: [ 2176.124929]=C2=A0 ? __pfx_autoremove_wake_function+=
0x10/0x10
>      >>>> kernel: [ 2176.124941]=C2=A0 btrfs_sync_fs+0x5a/0x1b0 [btrfs]
>      >>>> kernel: [ 2176.125060]=C2=A0 btrfs_ioctl+0x643/0x14d0 [btrfs]
>      >>>> kernel: [ 2176.125225]=C2=A0 __x64_sys_ioctl+0xa0/0xe0
>      >>>> kernel: [ 2176.125235]=C2=A0 do_syscall_64+0x5b/0x90
>      >>>> kernel: [ 2176.125242]=C2=A0 ? do_sys_openat2+0xab/0x180
>      >>>> kernel: [ 2176.125251]=C2=A0 ? exit_to_user_mode_prepare+0x30/=
0xb0
>      >>>> kernel: [ 2176.125260]=C2=A0 ? syscall_exit_to_user_mode+0x29/=
0x50
>      >>>> kernel: [ 2176.125268]=C2=A0 ? do_syscall_64+0x67/0x90
>      >>>> kernel: [ 2176.125275]=C2=A0 entry_SYSCALL_64_after_hwframe+0x=
72/0xdc
>      >>>> kernel: [ 2176.125282] RIP: 0033:0x7f2e8eb119ef
>      >>>> kernel: [ 2176.125288] RSP: 002b:00007ffd632b6aa0 EFLAGS: 0000=
0246
>      >>>> ORIG_RAX: 0000000000000010
>      >>>> kernel: [ 2176.125295] RAX: ffffffffffffffda RBX: 000000000000=
0003
>      >>>> RCX: 00007f2e8eb119ef
>      >>>> kernel: [ 2176.125300] RDX: 0000000000000000 RSI: 000000000000=
9408
>      >>>> RDI: 0000000000000003
>      >>>> kernel: [ 2176.125303] RBP: 0000000000000007 R08: 000000000000=
0000
>      >>>> R09: 0000000000000000
>      >>>> kernel: [ 2176.125306] R10: 0000000000000000 R11: 000000000000=
0246
>      >>>> R12: 00007f2e8ebf642c
>      >>>> kernel: [ 2176.125310] R13: 0000000000000001 R14: 000055cdb794=
0578
>      >>>> R15: 0000000000000000
>      >>>> kernel: [ 2176.125318]=C2=A0 </TASK>
>      >>>> kernel: [ 2296.956781] INFO: task btrfs:7783 blocked for more
>     than 241 seconds.
>      >>>> kernel: [ 2296.956824]=C2=A0 =C2=A0 =C2=A0 =C2=A0Tainted: G=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O
>      >>>> 6.2.0-23-generic #23+btrdebug2c
>      >>>> kernel: [ 2296.956856] "echo 0 >
>      >>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message=
.
>      >>>> kernel: [ 2296.956887] task:btrfs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0state:D stack:0
>      >>>> pid:7783=C2=A0 ppid:7782=C2=A0 =C2=A0flags:0x00004002
>      >>>> kernel: [ 2296.956898] Call Trace:
>      >>>> kernel: [ 2296.956902]=C2=A0 <TASK>
>      >>>> kernel: [ 2296.956908]=C2=A0 __schedule+0x2aa/0x610
>      >>>> kernel: [ 2296.956921]=C2=A0 schedule+0x63/0x110
>      >>>> kernel: [ 2296.956928]=C2=A0 btrfs_commit_transaction+0x9b7/0x=
bc0
>     [btrfs]
>      >>>> kernel: [ 2296.957069]=C2=A0 ? __pfx_autoremove_wake_function+=
0x10/0x10
>      >>>> kernel: [ 2296.957080]=C2=A0 btrfs_sync_fs+0x5a/0x1b0 [btrfs]
>      >>>> kernel: [ 2296.957200]=C2=A0 btrfs_ioctl+0x643/0x14d0 [btrfs]
>      >>>> kernel: [ 2296.957366]=C2=A0 __x64_sys_ioctl+0xa0/0xe0
>      >>>> kernel: [ 2296.957375]=C2=A0 do_syscall_64+0x5b/0x90
>      >>>> kernel: [ 2296.957383]=C2=A0 ? do_sys_openat2+0xab/0x180
>      >>>> kernel: [ 2296.957391]=C2=A0 ? exit_to_user_mode_prepare+0x30/=
0xb0
>      >>>> kernel: [ 2296.957399]=C2=A0 ? syscall_exit_to_user_mode+0x29/=
0x50
>      >>>> kernel: [ 2296.957407]=C2=A0 ? do_syscall_64+0x67/0x90
>      >>>> kernel: [ 2296.957414]=C2=A0 entry_SYSCALL_64_after_hwframe+0x=
72/0xdc
>      >>>> kernel: [ 2296.957420] RIP: 0033:0x7f2e8eb119ef
>      >>>> kernel: [ 2296.957426] RSP: 002b:00007ffd632b6aa0 EFLAGS: 0000=
0246
>      >>>> ORIG_RAX: 0000000000000010
>      >>>> kernel: [ 2296.957433] RAX: ffffffffffffffda RBX: 000000000000=
0003
>      >>>> RCX: 00007f2e8eb119ef
>      >>>> kernel: [ 2296.957438] RDX: 0000000000000000 RSI: 000000000000=
9408
>      >>>> RDI: 0000000000000003
>      >>>> kernel: [ 2296.957441] RBP: 0000000000000007 R08: 000000000000=
0000
>      >>>> R09: 0000000000000000
>      >>>> kernel: [ 2296.957444] R10: 0000000000000000 R11: 000000000000=
0246
>      >>>> R12: 00007f2e8ebf642c
>      >>>> kernel: [ 2296.957448] R13: 0000000000000001 R14: 000055cdb794=
0578
>      >>>> R15: 0000000000000000
>      >>>> kernel: [ 2296.957468]=C2=A0 </TASK>
>      >>>> kernel: [ 2314.043258] ------------[ cut here ]------------
>      >>>> kernel: [ 2314.043264] BTRFS: Transaction aborted (error -28)
>      >>>> kernel: [ 2314.043334] WARNING: CPU: 2 PID: 7739 at
>      >>>> fs/btrfs/extent-tree.c:2847 do_free_extent_accounting+0x21a/0x=
220
>      >>>> [btrfs]
>      >>>> kernel: [ 2314.043467] Modules linked in: ipmi_devintf
>     ipmi_msghandler
>      >>>> overlay iwlwifi_compat(O) binfmt_misc nls_iso8859_1 intel_rapl=
_msr
>      >>>> snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
>      >>>> intel_rapl_common snd_hda_codec_hdmi edac_mce_amd snd_hda_inte=
l
>      >>>> snd_intel_dspcfg kvm_amd snd_intel_sdw_acpi snd_hda_codec kvm
>      >>>> snd_hda_core snd_hwdep snd_pcm snd_timer irqbypass rapl
>     wmi_bmof snd
>      >>>> k10temp ccp soundcore input_leds mac_hid dm_multipath scsi_dh_=
rdac
>      >>>> scsi_dh_emc scsi_dh_alua bonding tls msr nfsd efi_pstore
>     auth_rpcgss
>      >>>> nfs_acl lockd grace sunrpc dmi_sysfs ip_tables x_tables
>     autofs4 btrfs
>      >>>> blake2b_generic raid10 raid456 async_raid6_recov async_memcpy
>     async_pq
>      >>>> async_xor async_tx xor raid6_pq libcrc32c raid1 raid0
>     multipath linear
>      >>>> amdgpu iommu_v2 drm_buddy gpu_sched drm_ttm_helper hid_generic=
 ttm
>      >>>> drm_display_helper cec uas rc_core usbhid hid drm_kms_helper
>      >>>> crct10dif_pclmul syscopyarea usb_storage crc32_pclmul
>     polyval_clmulni
>      >>>> sysfillrect polyval_generic sysimgblt nvme ghash_clmulni_intel
>      >>>> sha512_ssse3
>      >>>> kernel: [ 2314.043599]=C2=A0 nvme_core aesni_intel crypto_simd
>     mpt3sas drm
>      >>>> cryptd raid_class ahci i2c_piix4 scsi_transport_sas
>     nvme_common igb
>      >>>> xhci_pci qlcnic dca xhci_pci_renesas libahci i2c_algo_bit
>     video wmi
>      >>>> kernel: [ 2314.043631] CPU: 2 PID: 7739 Comm: btrfs-transacti
>     Tainted:
>      >>>> G=C2=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O=C2=A0 =C2=A0 =C2=A0 =C2=
=A06.2.0-23-generic #23+btrdebug2c
>      >>>> kernel: [ 2314.043638] Hardware name: To Be Filled By O.E.M. X=
570M
>      >>>> Pro4/X570M Pro4, BIOS P3.70 02/23/2022
>      >>>> kernel: [ 2314.043641] RIP:
>     0010:do_free_extent_accounting+0x21a/0x220 [btrfs]
>      >>>> kernel: [ 2314.043766] Code: ce 0f 0b eb b8 44 89 e6 48 c7 c7
>     a8 39 a0
>      >>>> c1 e8 2c d5 1e ce 0f 0b e9 78 ff ff ff 44 89 e6 48 c7 c7 a8 39
>     a0 c1
>      >>>> e8 16 d5 1e ce <0f> 0b eb b9 66 90 90 90 90 90 90 90 90 90 90
>     90 90 90
>      >>>> 90 90 90 90
>      >>>> kernel: [ 2314.043771] RSP: 0018:ffffad0b11b7bb38 EFLAGS: 0001=
0246
>      >>>> kernel: [ 2314.043777] RAX: 0000000000000000 RBX: ffff9c80e40e=
8f08
>      >>>> RCX: 0000000000000000
>      >>>> kernel: [ 2314.043781] RDX: 0000000000000000 RSI: 000000000000=
0000
>      >>>> RDI: 0000000000000000
>      >>>> kernel: [ 2314.043784] RBP: ffffad0b11b7bb60 R08: 000000000000=
0000
>      >>>> R09: 0000000000000000
>      >>>> kernel: [ 2314.043787] R10: 0000000000000000 R11: 000000000000=
0000
>      >>>> R12: 00000000ffffffe4
>      >>>> kernel: [ 2314.043790] R13: 00005e4c359ba000 R14: 000000000002=
0000
>      >>>> R15: ffff9c824d9a58c0
>      >>>> kernel: [ 2314.043794] FS:=C2=A0 0000000000000000(0000)
>      >>>> GS:ffff9c87a0a80000(0000) knlGS:0000000000000000
>      >>>> kernel: [ 2314.043798] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:
>     0000000080050033
>      >>>> kernel: [ 2314.043802] CR2: 00007f54adc86000 CR3: 00000001471d=
8000
>      >>>> CR4: 00000000003506e0
>      >>>> kernel: [ 2314.043806] Call Trace:
>      >>>> kernel: [ 2314.043809]=C2=A0 <TASK>
>      >>>> kernel: [ 2314.043815]=C2=A0 __btrfs_free_extent+0x6bc/0xf50 [=
btrfs]
>      >>>> kernel: [ 2314.043943]=C2=A0 run_delayed_data_ref+0x8b/0x180 [=
btrfs]
>      >>>> kernel: [ 2314.044068]
>     btrfs_run_delayed_refs_for_head+0x196/0x520 [btrfs]
>      >>>> kernel: [ 2314.044192]=C2=A0 __btrfs_run_delayed_refs+0xe6/0x1=
d0
>     [btrfs]
>      >>>> kernel: [ 2314.044316]=C2=A0 btrfs_run_delayed_refs+0x6d/0x1f0=
 [btrfs]
>      >>>> kernel: [ 2314.044439]
>     btrfs_start_dirty_block_groups+0x36b/0x530 [btrfs]
>      >>>> kernel: [ 2314.044598]=C2=A0 btrfs_commit_transaction+0xb3/0xb=
c0
>     [btrfs]
>      >>>> kernel: [ 2314.044754]=C2=A0 ? start_transaction+0xc8/0x600 [b=
trfs]
>      >>>> kernel: [ 2314.044890]=C2=A0 transaction_kthread+0x14b/0x1c0 [=
btrfs]
>      >>>> kernel: [ 2314.045021]=C2=A0 ? __pfx_transaction_kthread+0x10/=
0x10
>     [btrfs]
>      >>>> kernel: [ 2314.045151]=C2=A0 kthread+0xe9/0x110
>      >>>> kernel: [ 2314.045162]=C2=A0 ? __pfx_kthread+0x10/0x10
>      >>>> kernel: [ 2314.045170]=C2=A0 ret_from_fork+0x2c/0x50
>      >>>> kernel: [ 2314.045180]=C2=A0 </TASK>
>      >>>> kernel: [ 2314.045182] ---[ end trace 0000000000000000 ]---
>      >>>> kernel: [ 2314.045186] BTRFS info (device sdc: state A):
>     dumping space info:
>      >>>> kernel: [ 2314.045191] BTRFS info (device sdc: state A):
>     space_info
>      >>>> DATA has 160777674752 free, is not full
>      >>>> kernel: [ 2314.045197] BTRFS info (device sdc: state A):
>     space_info
>      >>>> total=3D71201958395904, used=3D71013439856640, pinned=3D277373=
25568,
>      >>>> reserved=3D0, may_use=3D0, readonly=3D3538944 zone_unusable=3D=
0
>      >>>> kernel: [ 2314.045205] BTRFS info (device sdc: state A):
>     space_info
>      >>>> METADATA has -429047808 free, is full
>      >>>
>      >>> This means we need at least 500+ MiB metadata space.
>      >>>
>      >>> Thus you may want to try 4x1GiB to see if this makes any
>     difference.
>      >>>
>      >>> Thanks,
>      >>> Qu
>      >>>> kernel: [ 2314.045209] BTRFS info (device sdc: state A):
>     space_info
>      >>>> total=3D83634421760, used=3D82789777408, pinned=3D244891648,
>      >>>> reserved=3D599687168, may_use=3D429047808, readonly=3D65536
>     zone_unusable=3D0
>      >>>> kernel: [ 2314.045217] BTRFS info (device sdc: state A):
>     space_info
>      >>>> SYSTEM has 33390592 free, is not full
>      >>>> kernel: [ 2314.045221] BTRFS info (device sdc: state A):
>     space_info
>      >>>> total=3D38797312, used=3D5373952, pinned=3D16384, reserved=3D1=
6384,
>     may_use=3D0,
>      >>>> readonly=3D0 zone_unusable=3D0
>      >>>> kernel: [ 2314.045227] BTRFS info (device sdc: state A):
>      >>>> global_block_rsv: size 536870912 reserved 428523520
>      >>>> kernel: [ 2314.045231] BTRFS info (device sdc: state A):
>      >>>> trans_block_rsv: size 524288 reserved 524288
>      >>>> kernel: [ 2314.045235] BTRFS info (device sdc: state A):
>      >>>> chunk_block_rsv: size 0 reserved 0
>      >>>> kernel: [ 2314.045239] BTRFS info (device sdc: state A):
>      >>>> delayed_block_rsv: size 0 reserved 0
>      >>>> kernel: [ 2314.045242] BTRFS info (device sdc: state A):
>      >>>> delayed_refs_rsv: size 249756909568 reserved 0
>      >>>> kernel: [ 2314.045251] BTRFS: error (device sdc: state A) in
>      >>>> do_free_extent_accounting:2847: errno=3D-28 No space left
>      >>>> kernel: [ 2314.045265] BTRFS warning (device sdc: state A):
>      >>>> btrfs_uuid_scan_kthread failed -28
>      >>>> kernel: [ 2314.045295] BTRFS info (device sdc: state EA):
>     forced readonly
>      >>>> kernel: [ 2314.045300] BTRFS error (device sdc: state EA):
>     failed to
>      >>>> run delayed ref for logical 103681409916928 num_bytes 131072
>     type 184
>      >>>> action 2 ref_mod 1: -28
>      >>>> kernel: [ 2314.045360] BTRFS: error (device sdc: state EA) in
>      >>>> btrfs_run_delayed_refs:2151: errno=3D-28 No space left
>      >>>> kernel: [ 2314.049204] BTRFS: error (device sdc: state EA) in
>      >>>> btrfs_create_pending_block_groups:2487: errno=3D-28 No space l=
eft
>      >>>> kernel: [ 2314.049331] BTRFS: error (device sdc: state EA) in
>      >>>> btrfs_create_pending_block_groups:2499: errno=3D-28 No space l=
eft
>      >>>> kernel: [ 2314.053259] BTRFS: error (device sdc: state EA) in
>      >>>> do_free_extent_accounting:2847: errno=3D-28 No space left
>      >>>> kernel: [ 2314.053318] BTRFS error (device sdc: state EA):
>     failed to
>      >>>> run delayed ref for logical 103681419366400 num_bytes 131072
>     type 184
>      >>>> action 2 ref_mod 1: -28
>      >>>> kernel: [ 2314.053375] BTRFS: error (device sdc: state EA) in
>      >>>> btrfs_run_delayed_refs:2151: errno=3D-28 No space left
>      >>>> kernel: [ 2314.053430] BTRFS warning (device sdc: state EA):
>     Skipping
>      >>>> commit of aborted transaction.
>      >>>> kernel: [ 2314.053435] BTRFS: error (device sdc: state EA) in
>      >>>> cleanup_transaction:1986: errno=3D-28 No space left
>      >>>>
>      >>>>
>      >>>>
>      >>>> On Fri, 23 Jun 2023 at 19:16, Qu Wenruo <wqu@suse.com
>     <mailto:wqu@suse.com>> wrote:
>      >>>>>
>      >>>>>
>      >>>>>
>      >>>>> On 2023/6/23 17:00, Stefan N wrote:
>      >>>>>> Apologies, I thought I included the log output too, though I
>     can't see
>      >>>>>> any additional output
>      >>>>>>
>      >>>>>>=C2=A0 =C2=A0 From a fresh run, still using the same kernel
>      >>>>>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ;
>     sudo btrfs
>      >>>>>> dev add -f /dev/sdl /dev/sdm /dev/sdn /dev/sdo /mnt/data ;
>     sudo btrfs
>      >>>>>> fi sync /mnt/data
>      >>>>>> ERROR: error adding device '/dev/sdl': Input/output error
>      >>>>>> ERROR: error adding device '/dev/sdm': Read-only file system
>      >>>>>> ERROR: error adding device '/dev/sdn': Read-only file system
>      >>>>>> ERROR: error adding device '/dev/sdo': Read-only file system
>      >>>>>> ERROR: Could not sync filesystem: Read-only file system
>      >>>>>> $
>      >>>>>>
>      >>>>>> Output from kern.log, syslog or dmesg -k
>      >>>>>>
>      >>>>> [...]
>      >>>>>
>      >>>>> None of the newly added debug lines triggered, so there is
>     something
>      >>>>> else causing the problem.
>      >>>>>
>      >>>>> And furthermore the backtrace is not that helpful, it only
>     shows it's
>      >>>>> some async metadata reclaim kthread causing the problem.
>      >>>>>
>      >>>>> Although I guess the async metadata reclaim is triggered by t=
he
>      >>>>> btrfs_start_transaction() call when adding a device.
>      >>>>> So I updated my github branch to go btrfs_join_transaction()
>     which would
>      >>>>> not flush any metadata, thus avoid the problem.
>      >>>>>
>      >>>>> Would you please give it a try again?
>      >>>>>
>      >>>>>>
>      >>>>>> However, now I started digging into logs to check I hadn't
>     missed
>      >>>>>> where the errors were being logged, I've found this from
>     roughly a
>      >>>>>> week before I started having issues, which I had not previou=
sly
>      >>>>>> noticed
>      >>>>>
>      >>>>> You don't need to bother most error messages after the fs
>     flipped RO.
>      >>>>> As it's known to have some false alerts.
>      >>>>>
>      >>>>> Thanks,
>      >>>>> Qu
>      >>>>>
>      >>>>>> [ 1990.495861] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 107988943355904 num_bytes 245760 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [ 1990.518282] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 107989043494912 num_bytes 245760 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 620.104065] BTRFS error (device sdk): failed to run
>     delayed ref for
>      >>>>>> logical 123187655077888 num_bytes 176128 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 620.126209] BTRFS error (device sdk): failed to run
>     delayed ref for
>      >>>>>> logical 123190279929856 num_bytes 134217728 type 184 action
>     2 ref_mod
>      >>>>>> 1: -28
>      >>>>>> [=C2=A0 620.126241] BTRFS error (device sdk): failed to run
>     delayed ref for
>      >>>>>> logical 123189970468864 num_bytes 134217728 type 184 action
>     2 ref_mod
>      >>>>>> 1: -28
>      >>>>>> [=C2=A0 620.126271] BTRFS error (device sdk): failed to run
>     delayed ref for
>      >>>>>> logical 123190414409728 num_bytes 134217728 type 184 action
>     2 ref_mod
>      >>>>>> 1: -28
>      >>>>>> [=C2=A0 476.565308] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 101906434228224 num_bytes 651264 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 476.565932] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 101906434031616 num_bytes 180224 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 447.371754] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 101946151927808 num_bytes 262144 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 447.372362] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 101946083725312 num_bytes 245760 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 439.839007] BTRFS error (device sdj): failed to run
>     delayed ref for
>      >>>>>> logical 101923102179328 num_bytes 192512 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 439.839578] BTRFS error (device sdj): failed to run
>     delayed ref for
>      >>>>>> logical 101923401629696 num_bytes 245760 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 466.393884] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 101981116137472 num_bytes 245760 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 466.394451] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 101981122854912 num_bytes 1720320 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 431.541367] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 101876426952704 num_bytes 126976 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 431.542010] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 101876427780096 num_bytes 126976 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 597.487948] BTRFS error (device sdj): failed to run
>     delayed ref for
>      >>>>>> logical 108127459409920 num_bytes 196608 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 597.488539] BTRFS error (device sdj): failed to run
>     delayed ref for
>      >>>>>> logical 108124677865472 num_bytes 126976 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 534.717509] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 101958618710016 num_bytes 1597440 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 534.718494] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 101958756335616 num_bytes 368640 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 508.089394] BTRFS error (device sdk): failed to run
>     delayed ref for
>      >>>>>> logical 101911627694080 num_bytes 126976 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [=C2=A0 508.090007] BTRFS error (device sdk): failed to run
>     delayed ref for
>      >>>>>> logical 101911627415552 num_bytes 126976 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [ 1632.112084] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 102203759886336 num_bytes 229376 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>> [ 1632.112885] BTRFS error (device sdh): failed to run
>     delayed ref for
>      >>>>>> logical 102203764379648 num_bytes 126976 type 184 action 2
>     ref_mod 1:
>      >>>>>> -28
>      >>>>>>
>      >>>>>> and today, when leaving the disks mounted read-only for a
>     while, I
>      >>>>>> found many occurances similar to:
>      >>>>>> BTRFS error (device sdc: state EA): level verify failed on
>     logical
>      >>>>>> 201329754554368 mirror 1 wanted 2 found 0
>      >>>>>> BTRFS error (device sdc: state EA): level verify failed on
>     logical
>      >>>>>> 201329754554368 mirror 2 wanted 2 found 0
>      >>>>>> BTRFS error (device sdc: state EA): level verify failed on
>     logical
>      >>>>>> 201329754554368 mirror 3 wanted 2 found 0
>      >>>>>> BTRFS error (device sdc: state EA): level verify failed on
>     logical
>      >>>>>> 201329754554368 mirror 4 wanted 2 found 0
>      >>>>>> BTRFS error (device sdc: state EA): level verify failed on
>     logical
>      >>>>>> 201329754554368 mirror 1 wanted 2 found 0
>      >>>>>> BTRFS error (device sdc: state EA): level verify failed on
>     logical
>      >>>>>> 201329754554368 mirror 2 wanted 2 found 0
>      >>>>>> BTRFS error (device sdc: state EA): level verify failed on
>     logical
>      >>>>>> 201329754554368 mirror 3 wanted 2 found 0
>      >>>>>> BTRFS error (device sdc: state EA): level verify failed on
>     logical
>      >>>>>> 201350830227456 mirror 4 wanted 2 found 0
>      >>>>>> BTRFS error (device sdc: state EA): level verify failed on
>     logical
>      >>>>>> 201350830227456 mirror 1 wanted 2 found 0
>      >>>>>> BTRFS error (device sdc: state EA): level verify failed on
>     logical
>      >>>>>> 201350830227456 mirror 2 wanted 2 found 0
>      >>>>>>
>      >>>>>> On Fri, 23 Jun 2023 at 10:27, Qu Wenruo
>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>      >>>>>>>
>      >>>>>>>
>      >>>>>>>
>      >>>>>>> On 2023/6/23 06:18, Stefan N wrote:
>      >>>>>>>> Hi Qu,
>      >>>>>>>>
>      >>>>>>>> I got one new line this time, but it doesn't seem to match
>     your commit
>      >>>>>>>> ERROR: zoned: unable to stat /dev/loop/13
>      >>>>>>>
>      >>>>>>> Please provide the dmesg of that attempt, as all the extra
>     debug info is
>      >>>>>>> inside dmesg.
>      >>>>>>>
>      >>>>>>> With that info provided, we can determine what to do next.
>      >>>>>>>
>      >>>>>>> Thanks,
>      >>>>>>> Qu
>      >>>>>>>
>      >>>>>>>>
>      >>>>>>>> I tried it on the USB flash drives too and didn't get any
>     extra line
>      >>>>>>>>
>      >>>>>>>> In context
>      >>>>>>>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ;
>     sudo btrfs
>      >>>>>>>> dev add -K -f /dev/loop12 /dev/loop/13 /dev/loop14 /dev/lo=
op15
>      >>>>>>>> /mnt/data ; sudo btrfs fi sync /mnt/data
>      >>>>>>>> ERROR: error adding device '/dev/loop12': Input/output err=
or
>      >>>>>>>> ERROR: zoned: unable to stat /dev/loop/13
>      >>>>>>>> ERROR: checking status of /dev/loop/13: No such file or
>     directory
>      >>>>>>>> ERROR: error adding device '/dev/loop14': Read-only file
>     system
>      >>>>>>>> ERROR: error adding device '/dev/loop15': Read-only file
>     system
>      >>>>>>>> ERROR: Could not sync filesystem: Read-only file system
>      >>>>>>>> $
>      >>>>>>>>
>      >>>>>>>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ;
>     sudo btrfs
>      >>>>>>>> dev add -f /dev/sdl /dev/sdm /dev/sdn /dev/sdo /mnt/data ;
>     sudo btrfs
>      >>>>>>>> fi sync /mnt/data
>      >>>>>>>> ERROR: error adding device '/dev/sdl': Input/output error
>      >>>>>>>> ERROR: error adding device '/dev/sdm': Read-only file syst=
em
>      >>>>>>>> ERROR: error adding device '/dev/sdn': Read-only file syst=
em
>      >>>>>>>> ERROR: error adding device '/dev/sdo': Read-only file syst=
em
>      >>>>>>>> ERROR: Could not sync filesystem: Read-only file system
>      >>>>>>>> $
>      >>>>>>>>
>      >>>>>>>> On Thu, 22 Jun 2023 at 18:48, Qu Wenruo
>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>      >>>>>>>>>
>      >>>>>>>>>
>      >>>>>>>>>
>      >>>>>>>>> On 2023/6/22 16:33, Stefan N wrote:
>      >>>>>>>>>> Hi Qu,
>      >>>>>>>>>>
>      >>>>>>>>>> Many thanks for the detailed instructions and your
>     patience. I got it
>      >>>>>>>>>> working combined with
>      >>>>>>>>>> https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel
>     <https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel> on the main syst=
em
>      >>>>>>>>>> OS instead, tagged +btrfix
>      >>>>>>>>>> $ uname -vr
>      >>>>>>>>>> 6.2.0-23-generic #23+btrfix SMP PREEMPT_DYNAMIC Thu Jun =
22
>      >>>>>>>>>>
>      >>>>>>>>>> However, I've not had luck with the commands suggested,
>     and would
>      >>>>>>>>>> appreciate any further ideas.
>      >>>>>>>>>>
>      >>>>>>>>>> Outputs follow below, with /mnt/data as the btrfs mount
>     point that
>      >>>>>>>>>> currently contains 8x disks sd[a-j] with an additional
>     4x 64gb USB
>      >>>>>>>>>> flash drives being added sd[l-o]
>      >>>>>>>>>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data
>     ; sudo btrfs
>      >>>>>>>>>> dev add -f /dev/sdl /dev/sdm /dev/sdn /dev/sdo /mnt/data
>     ; sudo btrfs
>      >>>>>>>>>> fi sync /mnt/data
>      >>>>>>>>>> ERROR: error adding device '/dev/sdl': Input/output erro=
r
>      >>>>>>>>>> ERROR: error adding device '/dev/sdm': Read-only file sy=
stem
>      >>>>>>>>>> ERROR: error adding device '/dev/sdn': Read-only file sy=
stem
>      >>>>>>>>>> ERROR: error adding device '/dev/sdo': Read-only file sy=
stem
>      >>>>>>>>>> ERROR: Could not sync filesystem: Read-only file system
>      >>>>>>>>>> $
>      >>>>>>>>>>
>      >>>>>>>>>> The same occurs if I try to add 4x 100mb loop devices
>     (on a ssd so
>      >>>>>>>>>> they're super quick to zero);
>      >>>>>>>>>> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data
>     ; sudo btrfs
>      >>>>>>>>>> dev add -K -f /dev/loop16 /dev/loop17 /dev/loop18
>     /dev/loop19
>      >>>>>>>>>> /mnt/data ; sudo btrfs fi sync /mnt/data
>      >>>>>>>>>> ERROR: error adding device '/dev/loop16': Input/output e=
rror
>      >>>>>>>>>
>      >>>>>>>>> This is the interesting part, this means we're erroring
>     out due to -EIO
>      >>>>>>>>> (not -ENOSPC) during the first device add.
>      >>>>>>>>>
>      >>>>>>>>> And by somehow, after the first device add, we already
>     got the trans abort.
>      >>>>>>>>>
>      >>>>>>>>> Would you please try the following branch?
>      >>>>>>>>>
>      >>>>>>>>>
>     https://github.com/adam900710/linux/tree/dev_add_no_commit
>     <https://github.com/adam900710/linux/tree/dev_add_no_commit>
>      >>>>>>>>>
>      >>>>>>>>> It has not only the patch to skip the commit, but also
>     extra debug
>      >>>>>>>>> output for the situation.
>      >>>>>>>>>
>      >>>>>>>>> Thanks,
>      >>>>>>>>> Qu
>      >>>>>>>>>
>      >>>>>>>>>> ERROR: error adding device '/dev/loop17': Read-only file
>     system
>      >>>>>>>>>> ERROR: error adding device '/dev/loop18': Read-only file
>     system
>      >>>>>>>>>> ERROR: error adding device '/dev/loop19': Read-only file
>     system
>      >>>>>>>>>> ERROR: Could not sync filesystem: Read-only file system
>      >>>>>>>>>> $
>      >>>>>>>>>>
>      >>>>>>>>>> I confirmed before both these kernel builds that the
>     replaced line was
>      >>>>>>>>>> btrfs_end_transaction rather than
>     btrfs_commit_transaction (anyone
>      >>>>>>>>>> else following, I needed to remove the -n in the patch
>     command
>      >>>>>>>>>> earlier)
>      >>>>>>>>>> $ grep -A3 -ri btrfs_sysfs_update_sprout
>     */fs/btrfs/volumes.c*
>      >>>>>>>>>> linux-6.2.0-dist/fs/btrfs/volumes.c:
>      >>>>>>>>>> btrfs_sysfs_update_sprout_fsid(fs_devices);
>      >>>>>>>>>> linux-6.2.0-dist/fs/btrfs/volumes.c-=C2=A0 =C2=A0 }
>      >>>>>>>>>> linux-6.2.0-dist/fs/btrfs/volumes.c-
>      >>>>>>>>>> linux-6.2.0-dist/fs/btrfs/volumes.c-=C2=A0 =C2=A0 ret =
=3D
>     btrfs_commit_transaction(trans);
>      >>>>>>>>>> --
>      >>>>>>>>>> linux-6.2.0-v2/fs/btrfs/volumes.c:
>      >>>>>>>>>> btrfs_sysfs_update_sprout_fsid(fs_devices);
>      >>>>>>>>>> linux-6.2.0-v2/fs/btrfs/volumes.c-=C2=A0 =C2=A0 =C2=A0 }
>      >>>>>>>>>> linux-6.2.0-v2/fs/btrfs/volumes.c-
>      >>>>>>>>>> linux-6.2.0-v2/fs/btrfs/volumes.c-=C2=A0 =C2=A0 =C2=A0 r=
et =3D
>     btrfs_end_transaction(trans);
>      >>>>>>>>>> --
>      >>>>>>>>>> linux-6.2.0-v3/fs/btrfs/volumes.c:
>      >>>>>>>>>> btrfs_sysfs_update_sprout_fsid(fs_devices);
>      >>>>>>>>>> linux-6.2.0-v3/fs/btrfs/volumes.c-=C2=A0 =C2=A0 =C2=A0 }
>      >>>>>>>>>> linux-6.2.0-v3/fs/btrfs/volumes.c-
>      >>>>>>>>>> linux-6.2.0-v3/fs/btrfs/volumes.c-=C2=A0 =C2=A0 =C2=A0 r=
et =3D
>     btrfs_end_transaction(trans);
>      >>>>>>>>>> $
>      >>>>>>>>>>
>      >>>>>>>>>> $ btrfs fi usage /mnt/data
>      >>>>>>>>>> Overall:
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Device size:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 87.31TiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Device allocated:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A087.31TiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Device unallocated:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1.94GiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Device missing:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00B
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Device slack:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0.00B
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Used:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08=
7.08TiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Free (estimated):=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 173.29GiB
>     (min: 172.33GiB)
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Free (statfs, df):=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0171.84GiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Data ratio:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01=
.34
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Metadata ratio:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04.00
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Global reserve:=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 512.00MiB
>     (used: 371.25MiB)
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Multiple profiles:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no
>      >>>>>>>>>>
>      >>>>>>>>>> Data,RAID6: Size:64.76TiB, Used:64.59TiB (99.74%)
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdc=C2=A0 =C2=A0 =
=C2=A0 =C2=A010.90TiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdf=C2=A0 =C2=A0 =
=C2=A0 =C2=A010.90TiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sda=C2=A0 =C2=A0 =
=C2=A0 =C2=A010.86TiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdg=C2=A0 =C2=A0 =
=C2=A0 =C2=A010.87TiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdh=C2=A0 =C2=A0 =
=C2=A0 =C2=A010.86TiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdd=C2=A0 =C2=A0 =
=C2=A0 =C2=A010.87TiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sde=C2=A0 =C2=A0 =
=C2=A0 =C2=A010.88TiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdb=C2=A0 =C2=A0 =
=C2=A0 =C2=A010.88TiB
>      >>>>>>>>>>
>      >>>>>>>>>> Metadata,RAID1C4: Size:77.79GiB, Used:77.11GiB (99.12%)
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdc=C2=A0 =C2=A0 =
=C2=A0 =C2=A015.33GiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdf=C2=A0 =C2=A0 =
=C2=A0 =C2=A018.41GiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sda=C2=A0 =C2=A0 =
=C2=A0 =C2=A049.63GiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdg=C2=A0 =C2=A0 =
=C2=A0 =C2=A049.50GiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdh=C2=A0 =C2=A0 =
=C2=A0 =C2=A051.52GiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdd=C2=A0 =C2=A0 =
=C2=A0 =C2=A048.70GiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sde=C2=A0 =C2=A0 =
=C2=A0 =C2=A039.09GiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdb=C2=A0 =C2=A0 =
=C2=A0 =C2=A039.01GiB
>      >>>>>>>>>>
>      >>>>>>>>>> System,RAID1C4: Size:37.00MiB, Used:5.11MiB (13.81%)
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdc=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1.00MiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sda=C2=A0 =C2=A0 =
=C2=A0 =C2=A037.00MiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdg=C2=A0 =C2=A0 =
=C2=A0 =C2=A037.00MiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdh=C2=A0 =C2=A0 =
=C2=A0 =C2=A036.00MiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdd=C2=A0 =C2=A0 =
=C2=A0 =C2=A037.00MiB
>      >>>>>>>>>>
>      >>>>>>>>>> Unallocated:
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdc=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1.00MiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdf=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1.00MiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sda=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1.27GiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdg=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1.00MiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdh=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1.00MiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdd=C2=A0 =C2=A0 =
=C2=A0 687.00MiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sde=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1.00MiB
>      >>>>>>>>>>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/dev/sdb=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1.00MiB
>      >>>>>>>>>> $
>      >>>>>>>>>>
>      >>>>>>>>>>
>      >>>>>>>>>> This first attempt generated the following syslog output=
:
>      >>>>>>>>>> kernel: [=C2=A0 868.435387] BTRFS info (device sde): usi=
ng crc32c
>      >>>>>>>>>> (crc32c-intel) checksum algorithm
>      >>>>>>>>>> kernel: [=C2=A0 868.435407] BTRFS info (device sde): dis=
k
>     space caching is enabled
>      >>>>>>>>>> kernel: [=C2=A0 874.477712] BTRFS info (device sde): bde=
v
>     /dev/sdg errs: wr
>      >>>>>>>>>> 0, rd 0, flush 0, corrupt 845, gen 0
>      >>>>>>>>>> kernel: [=C2=A0 874.477727] BTRFS info (device sde): bde=
v
>     /dev/sdc errs: wr
>      >>>>>>>>>> 41089, rd 1556, flush 0, corrupt 0, gen 0
>      >>>>>>>>>> kernel: [=C2=A0 874.477735] BTRFS info (device sde): bde=
v
>     /dev/sdj errs: wr
>      >>>>>>>>>> 3, rd 7, flush 0, corrupt 0, gen 0
>      >>>>>>>>>> kernel: [=C2=A0 874.477740] BTRFS info (device sde): bde=
v
>     /dev/sdf errs: wr
>      >>>>>>>>>> 41, rd 0, flush 0, corrupt 0, gen 0
>      >>>>>>>>>> kernel: [ 1082.645551] BTRFS info (device sde): balance:
>     resume skipped
>      >>>>>>>>>> kernel: [ 1082.645564] BTRFS info (device sde): checking
>     UUID tree
>      >>>>>>>>>> kernel: [ 1082.645551] BTRFS info (device sde): balance:
>     resume skipped
>      >>>>>>>>>> kernel: [ 1082.645564] BTRFS info (device sde): checking
>     UUID tree
>      >>>>>>>>>> kernel: [ 1267.280506] BTRFS: Transaction aborted (error
>     -28)
>      >>>>>>>>>> kernel: [ 1267.280553] BTRFS: error (device sde: state A=
) in
>      >>>>>>>>>> do_free_extent_accounting:2847: errno=3D-28 No space lef=
t
>      >>>>>>>>>> kernel: [ 1267.280604] BTRFS info (device sde: state
>     EA): forced readonly
>      >>>>>>>>>> kernel: [ 1267.280610] BTRFS error (device sde: state
>     EA): failed to
>      >>>>>>>>>> run delayed ref for logical 102255404044288 num_bytes
>     294912 type 184
>      >>>>>>>>>> action 2 ref_mod 1: -28
>      >>>>>>>>>> kernel: [ 1267.280584] WARNING: CPU: 3 PID: 14519 at
>      >>>>>>>>>> fs/btrfs/extent-tree.c:2847
>     do_free_extent_accounting+0x21a/0x220
>      >>>>>>>>>> [btrfs]
>      >>>>>>>>>> kernel: [ 1267.280666] BTRFS: error (device sde: state
>     EA) in
>      >>>>>>>>>> btrfs_run_delayed_refs:2151: errno=3D-28 No space left
>      >>>>>>>>>> kernel: [ 1267.280695] BTRFS warning (device sde: state =
EA):
>      >>>>>>>>>> btrfs_uuid_scan_kthread failed -5
>      >>>>>>>>>> kernel: [ 1267.280794] Modules linked in: xt_nat
>     xt_tcpudp veth
>      >>>>>>>>>> xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
>     nf_conntrack_netlink
>      >>>>>>>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user
>     xfrm_algo
>      >>>>>>>>>> xt_addrtype nft_compat nf_tables nfnetlink br_netfilter
>     bridge stp llc
>      >>>>>>>>>> ipmi_devintf ipmi_msghandler overlay iwlwifi_compat(O)
>     binfmt_misc
>      >>>>>>>>>> nls_iso8859_1 intel_rapl_msr intel_rapl_common edac_mce_=
amd
>      >>>>>>>>>> snd_hda_codec_realtek kvm_amd snd_hda_codec_generic
>     ledtrig_audio kvm
>      >>>>>>>>>> snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg
>     snd_intel_sdw_acpi
>      >>>>>>>>>> snd_hda_codec irqbypass snd_hda_core snd_hwdep rapl
>     snd_pcm snd_timer
>      >>>>>>>>>> wmi_bmof k10temp snd ccp soundcore input_leds mac_hid
>     dm_multipath
>      >>>>>>>>>> scsi_dh_rdac scsi_dh_emc scsi_dh_alua bonding tls
>     efi_pstore msr nfsd
>      >>>>>>>>>> auth_rpcgss nfs_acl lockd grace sunrpc dmi_sysfs
>     ip_tables x_tables
>      >>>>>>>>>> autofs4 btrfs blake2b_generic raid10 raid456
>     async_raid6_recov
>      >>>>>>>>>> async_memcpy async_pq async_xor async_txxor raid6_pq
>     libcrc32c raid1
>      >>>>>>>>>> raid0 multipath linear hid_generic usbhid hid amdgpu uas
>     usb_storage
>      >>>>>>>>>> kernel: [ 1267.280994] CPU: 3 PID: 14519 Comm:
>     btrfs-transacti
>      >>>>>>>>>> Tainted: G=C2=A0 =C2=A0 =C2=A0 =C2=A0 W=C2=A0 O=C2=A0 =
=C2=A0 =C2=A0 =C2=A06.2.0-23-generic #23+btrfix
>      >>>>>>>>>> kernel: [ 1267.281005] RIP:
>     0010:do_free_extent_accounting+0x21a/0x220 [btrfs]
>      >>>>>>>>>> kernel: [ 1267.281181]=C2=A0 __btrfs_free_extent+0x6bc/0=
xf50
>     [btrfs]
>      >>>>>>>>>> kernel: [ 1267.281310]=C2=A0 run_delayed_data_ref+0x8b/0=
x180
>     [btrfs]
>      >>>>>>>>>> kernel: [ 1267.281444]
>     btrfs_run_delayed_refs_for_head+0x196/0x520 [btrfs]
>      >>>>>>>>>> kernel: [ 1267.281570]
>     __btrfs_run_delayed_refs+0xe6/0x1d0 [btrfs]
>      >>>>>>>>>> kernel: [ 1267.281694]
>     btrfs_run_delayed_refs+0x6d/0x1f0 [btrfs]
>      >>>>>>>>>> kernel: [ 1267.281818]
>     btrfs_start_dirty_block_groups+0x36b/0x530 [btrfs]
>      >>>>>>>>>> kernel: [ 1267.281976]
>     btrfs_commit_transaction+0xb3/0xbc0 [btrfs]
>      >>>>>>>>>> kernel: [ 1267.282110]=C2=A0 ? start_transaction+0xc8/0x=
600
>     [btrfs]
>      >>>>>>>>>> kernel: [ 1267.282244]=C2=A0 transaction_kthread+0x14b/0=
x1c0
>     [btrfs]
>      >>>>>>>>>> kernel: [ 1267.282375]=C2=A0 ?
>     __pfx_transaction_kthread+0x10/0x10 [btrfs]
>      >>>>>>>>>> kernel: [ 1267.282548] BTRFS info (device sde: state
>     EA): dumping space info:
>      >>>>>>>>>> kernel: [ 1267.282552] BTRFS info (device sde: state
>     EA): space_info
>      >>>>>>>>>> DATA has 160777674752 free, is not full
>      >>>>>>>>>> kernel: [ 1267.282558] BTRFS info (device sde: state
>     EA): space_info
>      >>>>>>>>>> total=3D71201958395904, used=3D71018191273984,
>     pinned=3D22985908224,
>      >>>>>>>>>> reserved=3D0, may_use=3D0, readonly=3D3538944 zone_unusa=
ble=3D0
>      >>>>>>>>>> kernel: [ 1267.282566] BTRFS info (device sde: state
>     EA): space_info
>      >>>>>>>>>> METADATA has -124944384 free, is full
>      >>>>>>>>>> kernel: [ 1267.282571] BTRFS info (device sde: state
>     EA): space_info
>      >>>>>>>>>> total=3D83530612736, used=3D82791497728, pinned=3D242745=
344,
>      >>>>>>>>>> reserved=3D496369664, may_use=3D124944384, readonly=3D0
>     zone_unusable=3D0
>      >>>>>>>>>> kernel: [ 1267.282577] BTRFS info (device sde: state
>     EA): space_info
>      >>>>>>>>>> SYSTEM has 33439744 free, is not full
>      >>>>>>>>>> kernel: [ 1267.282582] BTRFS info (device sde: state
>     EA): space_info
>      >>>>>>>>>> total=3D38797312, used=3D5357568, pinned=3D0, reserved=
=3D0,
>     may_use=3D0,
>      >>>>>>>>>> readonly=3D0 zone_unusable=3D0
>      >>>>>>>>>> kernel: [ 1267.282588] BTRFS info (device sde: state EA)=
:
>      >>>>>>>>>> global_block_rsv: size 536870912 reserved 124944384
>      >>>>>>>>>> kernel: [ 1267.282592] BTRFS info (device sde: state EA)=
:
>      >>>>>>>>>> trans_block_rsv: size 0 reserved 0
>      >>>>>>>>>> kernel: [ 1267.282595] BTRFS info (device sde: state EA)=
:
>      >>>>>>>>>> chunk_block_rsv: size 0 reserved 0
>      >>>>>>>>>> kernel: [ 1267.282599] BTRFS info (device sde: state EA)=
:
>      >>>>>>>>>> delayed_block_rsv: size 0 reserved 0
>      >>>>>>>>>> kernel: [ 1267.282602] BTRFS info (device sde: state EA)=
:
>      >>>>>>>>>> delayed_refs_rsv: size 251322957824 reserved 0
>      >>>>>>>>>> kernel: [ 1267.282608] BTRFS: error (device sde: state
>     EA) in
>      >>>>>>>>>> do_free_extent_accounting:2847: errno=3D-28 No space lef=
t
>      >>>>>>>>>> kernel: [ 1267.282653] BTRFS error (device sde: state
>     EA): failed to
>      >>>>>>>>>> run delayed ref for logical 102255401897984 num_bytes
>     126976 type 184
>      >>>>>>>>>> action 2 ref_mod 1: -28
>      >>>>>>>>>> kernel: [ 1267.282708] BTRFS: error (device sde: state
>     EA) in
>      >>>>>>>>>> btrfs_run_delayed_refs:2151: errno=3D-28 No space left
>      >>>>>>>>>>
>      >>>>>>>>>> A couple of kernel recompiles later, the second attempt
>     on the SSD
>      >>>>>>>>>> generated similar:
>      >>>>>>>>>> kernel: [ 1472.203470] BTRFS info (device sdc): using cr=
c32c
>      >>>>>>>>>> (crc32c-intel) checksum algorithm
>      >>>>>>>>>> kernel: [ 1472.203491] BTRFS info (device sdc): disk
>     space caching is enabled
>      >>>>>>>>>> kernel: [ 1478.155004] BTRFS info (device sdc): bdev
>     /dev/sdf errs: wr
>      >>>>>>>>>> 0, rd 0, flush 0, corrupt 845, gen 0
>      >>>>>>>>>> kernel: [ 1478.155022] BTRFS info (device sdc): bdev
>     /dev/sda errs: wr
>      >>>>>>>>>> 41089, rd 1556, flush 0, corrupt 0, gen 0
>      >>>>>>>>>> kernel: [ 1478.155034] BTRFS info (device sdc): bdev
>     /dev/sdh errs: wr
>      >>>>>>>>>> 3, rd 7, flush 0, corrupt 0, gen 0
>      >>>>>>>>>> kernel: [ 1478.155041] BTRFS info (device sdc): bdev
>     /dev/sdd errs: wr
>      >>>>>>>>>> 41, rd 0, flush 0, corrupt 0, gen 0
>      >>>>>>>>>> kernel: [ 1696.662526] BTRFS info (device sdc): balance:
>     resume skipped
>      >>>>>>>>>> kernel: [ 1696.662537] BTRFS info (device sdc): checking
>     UUID tree
>      >>>>>>>>>> kernel: [ 1919.452464] BTRFS: Transaction aborted (error
>     -28)
>      >>>>>>>>>> kernel: [ 1919.452534] WARNING: CPU: 1 PID: 161 at
>      >>>>>>>>>> fs/btrfs/extent-tree.c:2847
>     do_free_extent_accounting+0x21a/0x220
>      >>>>>>>>>> [btrfs]
>      >>>>>>>>>> kernel: [ 1919.452655] Modules linked in: xt_nat
>     xt_tcpudp veth
>      >>>>>>>>>> xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat
>     nf_conntrack_netlink
>      >>>>>>>>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user
>     xfrm_algo
>      >>>>>>>>>> xt_addrtype nft_compat nf_tables nfnetlink br_netfilter
>     bridge stp llc
>      >>>>>>>>>> ipmi_devintf ipmi_msghandler overlay iwlwifi_compat(O)
>     binfmt_misc
>      >>>>>>>>>> nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_generi=
c
>      >>>>>>>>>> ledtrig_audio snd_hda_codec_hdmi snd_hda_intel
>     snd_intel_dspcfg
>      >>>>>>>>>> snd_intel_sdw_acpi snd_hda_codec intel_rapl_msr snd_hda_=
core
>      >>>>>>>>>> intel_rapl_common edac_mce_amd snd_hwdep kvm_amd snd_pcm
>     snd_timer kvm
>      >>>>>>>>>> irqbypass rapl wmi_bmof snd k10temp soundcore ccp
>     input_leds mac_hid
>      >>>>>>>>>> dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua
>     bonding tls nfsd
>      >>>>>>>>>> msr auth_rpcgss efi_pstore nfs_acl lockd grace sunrpc
>     dmi_sysfs
>      >>>>>>>>>> ip_tables x_tables autofs4 btrfs blake2b_generic raid10
>     raid456
>      >>>>>>>>>> async_raid6_recov async_memcpy async_pq async_xor
>     async_tx xor
>      >>>>>>>>>> raid6_pq libcrc32c raid1 raid0 multipath linear
>     hid_generic usbhid
>      >>>>>>>>>> amdgpu uas hid iommu_v2
>      >>>>>>>>>> kernel: [ 1919.452839] Workqueue: events_unbound
>      >>>>>>>>>> btrfs_async_reclaim_metadata_space [btrfs]
>      >>>>>>>>>> kernel: [ 1919.452985] RIP:
>     0010:do_free_extent_accounting+0x21a/0x220 [btrfs]
>      >>>>>>>>>> kernel: [ 1919.453141]=C2=A0 __btrfs_free_extent+0x6bc/0=
xf50
>     [btrfs]
>      >>>>>>>>>> kernel: [ 1919.453256]=C2=A0 run_delayed_data_ref+0x8b/0=
x180
>     [btrfs]
>      >>>>>>>>>> kernel: [ 1919.453368]
>     btrfs_run_delayed_refs_for_head+0x196/0x520 [btrfs]
>      >>>>>>>>>> kernel: [ 1919.453480]
>     __btrfs_run_delayed_refs+0xe6/0x1d0 [btrfs]
>      >>>>>>>>>> kernel: [ 1919.453592]
>     btrfs_run_delayed_refs+0x6d/0x1f0 [btrfs]
>      >>>>>>>>>> kernel: [ 1919.453703]=C2=A0 flush_space+0x23c/0x2c0 [bt=
rfs]
>      >>>>>>>>>> kernel: [ 1919.453845]
>     btrfs_async_reclaim_metadata_space+0x19b/0x2b0 [btrfs]
>      >>>>>>>>>> kernel: [ 1919.454034] BTRFS info (device sdc: state A):
>     dumping space info:
>      >>>>>>>>>> kernel: [ 1919.454038] BTRFS info (device sdc: state A):
>     space_info
>      >>>>>>>>>> DATA has 160778723328 free, is not full
>      >>>>>>>>>> kernel: [ 1919.454043] BTRFS info (device sdc: state A):
>     space_info
>      >>>>>>>>>> total=3D71201958395904, used=3D71017442181120,
>     pinned=3D23733952512,
>      >>>>>>>>>> reserved=3D0, may_use=3D0, readonly=3D3538944 zone_unusa=
ble=3D0
>      >>>>>>>>>> kernel: [ 1919.454050] BTRFS info (device sdc: state A):
>     space_info
>      >>>>>>>>>> METADATA has -147570688 free, is full
>      >>>>>>>>>> kernel: [ 1919.454054] BTRFS info (device sdc: state A):
>     space_info
>      >>>>>>>>>> total=3D83530612736, used=3D82792185856, pinned=3D238059=
520,
>      >>>>>>>>>> reserved=3D500367360, may_use=3D147570688, readonly=3D0
>     zone_unusable=3D0
>      >>>>>>>>>> kernel: [ 1919.454060] BTRFS info (device sdc: state A):
>     space_info
>      >>>>>>>>>> SYSTEM has 33439744 free, is not full
>      >>>>>>>>>> kernel: [ 1919.454064] BTRFS info (device sdc: state A):
>     space_info
>      >>>>>>>>>> total=3D38797312, used=3D5357568, pinned=3D0, reserved=
=3D0,
>     may_use=3D0,
>      >>>>>>>>>> readonly=3D0 zone_unusable=3D0
>      >>>>>>>>>> kernel: [ 1919.454070] BTRFS info (device sdc: state A):
>      >>>>>>>>>> global_block_rsv: size 536870912 reserved 147570688
>      >>>>>>>>>> kernel: [ 1919.454074] BTRFS info (device sdc: state A):
>      >>>>>>>>>> trans_block_rsv: size 0 reserved 0
>      >>>>>>>>>> kernel: [ 1919.454077] BTRFS info (device sdc: state A):
>      >>>>>>>>>> chunk_block_rsv: size 0 reserved 0
>      >>>>>>>>>> kernel: [ 1919.454080] BTRFS info (device sdc: state A):
>      >>>>>>>>>> delayed_block_rsv: size 0 reserved 0
>      >>>>>>>>>> kernel: [ 1919.454083] BTRFS info (device sdc: state A):
>      >>>>>>>>>> delayed_refs_rsv: size 254292787200 reserved 0
>      >>>>>>>>>> kernel: [ 1919.454086] BTRFS: error (device sdc: state A=
) in
>      >>>>>>>>>> do_free_extent_accounting:2847: errno=3D-28 No space lef=
t
>      >>>>>>>>>> kernel: [ 1919.454123] BTRFS info (device sdc: state
>     EA): forced readonly
>      >>>>>>>>>> kernel: [ 1919.454127] BTRFS error (device sdc: state
>     EA): failed to
>      >>>>>>>>>> run delayed ref for logical 102538713931776 num_bytes
>     245760 type 184
>      >>>>>>>>>> action 2 ref_mod 1: -28
>      >>>>>>>>>> kernel: [ 1919.454176] BTRFS: error (device sdc: state
>     EA) in
>      >>>>>>>>>> btrfs_run_delayed_refs:2151: errno=3D-28 No space left
>      >>>>>>>>>> kernel: [ 1919.454249] BTRFS warning (device sdc: state =
EA):
>      >>>>>>>>>> btrfs_uuid_scan_kthread failed -5
>      >>>>>>>>>> kernel: [ 1919.472381] BTRFS: error (device sdc: state
>     EA) in
>      >>>>>>>>>> __btrfs_free_extent:3077: errno=3D-28 No space left
>      >>>>>>>>>> kernel: [ 1919.472417] BTRFS error (device sdc: state
>     EA): failed to
>      >>>>>>>>>> run delayed ref for logical 102538732191744 num_bytes
>     245760 type 184
>      >>>>>>>>>> action 2 ref_mod 1: -28
>      >>>>>>>>>> kernel: [ 1919.472442] BTRFS: error (device sdc: state
>     EA) in
>      >>>>>>>>>> btrfs_run_delayed_refs:2151: errno=3D-28 No space left
>      >>>>>>>>>>
>      >>>>>>>>>>
>      >>>>>>>>>> On Sat, 17 Jun 2023 at 15:00, Qu Wenruo <wqu@suse.com
>     <mailto:wqu@suse.com>> wrote:
>      >>>>>>>>>>>
>      >>>>>>>>>>>
>      >>>>>>>>>>>
>      >>>>>>>>>>> On 2023/6/17 13:11, Stefan N wrote:
>      >>>>>>>>>>>> Hi Qu,
>      >>>>>>>>>>>>
>      >>>>>>>>>>>> I believe I've got this environment ready, with the
>     6.2.0 kernel as
>      >>>>>>>>>>>> before using the Ubuntu kernel, but can switch to
>     vanilla if required.
>      >>>>>>>>>>>>
>      >>>>>>>>>>>> I've not done anything kernel modifications for a
>     solid decade, so
>      >>>>>>>>>>>> would be keen for a bit of guidance.
>      >>>>>>>>>>>
>      >>>>>>>>>>> Sure no problem.
>      >>>>>>>>>>>
>      >>>>>>>>>>> Please fetch the kernel source tar ball (6.2.x) first,
>     decompress, then
>      >>>>>>>>>>> apply the attached one-line patch by:
>      >>>>>>>>>>>
>      >>>>>>>>>>> $ tar czf linux*.tar.xz
>      >>>>>>>>>>> $ cd linux*
>      >>>>>>>>>>> $ patch -np1 -i <the patch file>
>      >>>>>>>>>>>
>      >>>>>>>>>>> Then use your running system kernel config if possible:
>      >>>>>>>>>>>
>      >>>>>>>>>>> $ cp /proc/config.gz .
>      >>>>>>>>>>> $ gunzip config.gz
>      >>>>>>>>>>> $ mv config .config
>      >>>>>>>>>>> $ make olddefconfig
>      >>>>>>>>>>>
>      >>>>>>>>>>> Then you can start your kernel compiling, and
>     considering you're using
>      >>>>>>>>>>> your distro's default, it would include tons of
>     drivers, thus would be
>      >>>>>>>>>>> very slow. (Replace the number to something more
>     suitable to your
>      >>>>>>>>>>> system, using all CPU cores can be very hot)
>      >>>>>>>>>>>
>      >>>>>>>>>>> $ make -j12
>      >>>>>>>>>>>
>      >>>>>>>>>>> Finally you need to install the modules/kernel.
>      >>>>>>>>>>>
>      >>>>>>>>>>> Unfortunately this is distro specific, but if you're
>     using Ubuntu, it
>      >>>>>>>>>>> may be much easier:
>      >>>>>>>>>>>
>      >>>>>>>>>>> $ make bindeb-pkg
>      >>>>>>>>>>>
>      >>>>>>>>>>> Then install the generated dpkg I guess? I have never
>     tried kernel
>      >>>>>>>>>>> building using deb/rpm, but only manual installation,
>     which is also
>      >>>>>>>>>>> distro dependent in the initramfs generation part.
>      >>>>>>>>>>>
>      >>>>>>>>>>> # cp arch/x86/boot/bzImage /boot/vmlinuz-custom
>      >>>>>>>>>>> # make modules_install
>      >>>>>>>>>>> # mkinitcpio -k /boot/vmlinuz-custom -g
>     /boot/initramfs-custom.img
>      >>>>>>>>>>>
>      >>>>>>>>>>>
>      >>>>>>>>>>> The last step is to update your bootloader to add the
>     new kernel, which
>      >>>>>>>>>>> is not only distro dependent but also bootloader depend=
ent.
>      >>>>>>>>>>>
>      >>>>>>>>>>> In my case, I go with systemd-boot with manually
>     crafted entries.
>      >>>>>>>>>>> But if you go Ubuntu I believe just installing the
>     kernel dpkg would
>      >>>>>>>>>>> have everything handled?
>      >>>>>>>>>>>
>      >>>>>>>>>>> Finally you can try reboot into the newer kernel, and
>     try device add
>      >>>>>>>>>>> (need to add 4 disks), then sync and see if things work
>     as expected.
>      >>>>>>>>>>>
>      >>>>>>>>>>> Thanks,
>      >>>>>>>>>>> Qu
>      >>>>>>>>>>>>
>      >>>>>>>>>>>> I will recover a 1tb SSD and partition it into 4 in a
>     USB enclosure,
>      >>>>>>>>>>>> but failing this will use 4x loop devices.
>      >>>>>>>>>>>>
>      >>>>>>>>>>>> On Tue, 13 Jun 2023 at 11:28, Qu Wenruo
>     <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>      >>>>>>>>>>>>> In your particular case, since you're running RAID1C4
>     you need to add 4
>      >>>>>>>>>>>>> devices in one transaction.
>      >>>>>>>>>>>>>
>      >>>>>>>>>>>>> I can easily craft a patch to avoid commit
>     transaction, but still you'll
>      >>>>>>>>>>>>> need to add at least 4 disks, and then sync to see if
>     things would work.
>      >>>>>>>>>>>>>
>      >>>>>>>>>>>>> Furthermore this means you need a liveCD with full
>     kernel compiling
>      >>>>>>>>>>>>> environment.
>      >>>>>>>>>>>>>
>      >>>>>>>>>>>>> If you want to go this path, I can send you the patch
>     when you've
>      >>>>>>>>>>>>> prepared the needed environment.
>
