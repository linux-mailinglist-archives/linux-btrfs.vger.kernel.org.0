Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682D2739CF2
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jun 2023 11:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjFVJ2I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jun 2023 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjFVJ1j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jun 2023 05:27:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D73E30E9
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 02:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1687425525; x=1688030325; i=quwenruo.btrfs@gmx.com;
 bh=YJRKrlWJ03uAuaQNXYg3KeIvaANRZLX5EG6t5o/yYrw=;
 h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
 b=PXdaUfXrpTOrqXRZP0eadtDEfm6fKMlqx/Ax8TZMA6/4KPNspwkf9RsLJO8AS1jUbzab8dd
 b+OEpTB8CFVLMl3fG4zDwGF33TD+cm4wCJ4RsR3dIPGmaTCNYvOqq21Qf13d5SDo8kvFKTtMm
 t2teApqkIsySFeoaaR+3Ngi/C+aW7tPETfc3PfsbsyS6NZAcd+ceF4kBZhdTPsg9pQQ+/vtHy
 jG6EwPh8PQZLyrBUGkeHS2BqKLgZ5SLzWBbJ2uzKOsM4OsbbEYx4CFbndIhotC4AMhD+EV/dl
 qEE8la8ukM6aCuRUu8AdVMRCf3KT3ssjzf3GQbqh7c8vXf0q9sOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6siz-1q1E7A400V-018JaT; Thu, 22
 Jun 2023 11:18:45 +0200
Message-ID: <e559f54f-c5b8-0132-b420-22b6db5539f3@gmx.com>
Date:   Thu, 22 Jun 2023 17:18:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Stefan N <stefannnau@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com>
 <1ee0e330-1226-7abf-44bc-033decbe43e0@gmx.com>
 <CA+W5K0ow+95pWnzam8N6=c5Ff61ZeHyv7_yDK0LG6ujU48=yBA@mail.gmail.com>
 <40ecba88-9de2-7315-4ac5-e3eb892aac39@gmx.com>
 <CA+W5K0qLN3SaqQ242Jerp_fiyBw407e2h_BEA9rQ45HU-TfaZA@mail.gmail.com>
 <SYCPR01MB46856D101B81641A6CE21FB99E55A@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <CA+W5K0oKO2Vxu3D2jOLET1RrM=wOxTEH2a_uH1w44H2x9kT2tQ@mail.gmail.com>
 <16ab1898-1714-a927-b8df-4a20eb39b8cd@gmx.com>
 <CA+W5K0pm+Aum0vQGeRfUCsH_4x8+L3O+baUfRJM-iWdh+tDwNA@mail.gmail.com>
 <403c9e19-e58e-8857-bee8-dd9f9d8fc34f@suse.com>
 <CA+W5K0qzk0Adt2a_Xp5qh=JYyO02mh5YK3c1wgvQEyS3mHSR_w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Out of space loop: skip_balance not working
In-Reply-To: <CA+W5K0qzk0Adt2a_Xp5qh=JYyO02mh5YK3c1wgvQEyS3mHSR_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wJcxLxDemktBaZ6joZAbQJEFHes7Qu4Y3WocaBtJ/6LSe4Krv5U
 jwxHSP5AeQ4ycTOgYpUCUU0RRfzGRWusLTeYJam0IJsAI3+P+TPPsy/7L8OXVUU+skuyA3i
 GkELAeBp1sO7TIEcN9gp/dumi3N/pl/XtuV+01i9us3OUlL3t7ZPtgeqwegvHFP30f7llrK
 y7twFgPqDuRn3scROFTLA==
UI-OutboundReport: notjunk:1;M01:P0:YOVWmDrLdoA=;18OGr4Sm8bfl5qsa8F6RRciPlmk
 uN2ooG/K+ta8tvJTysDeIAAx4XtPTugo7aYyCs8hC3aDxF72ZBA0imtEKkBLIjK0+BKiIrrVd
 jiNhk/YpD0DQTf7fnbP46NKlM8c9R33Q8FzqGBUITGfewL1KOwqj+DGUVkPd/awOXBoFcR75n
 QbXsNBACG7mh66kngZnSOau7wnOj/gP6AZTMoze0qOahR8BA84wobZFnqUPJC1fMt/BMZeABz
 v8jfxTyWBeBe0TM9sWn9bmYPlKoEza6JW6QaQEDg6+944UWRSUxp+kRizuqvmsF45oBJjnwXL
 Ie/iR7DHyPaMxP3EA9RSZXo+nWj7sSeqXfiXG6cw+i1Nw71Jo/2DUy8JV5uQx3JHjf2UbTQGu
 LHqXJ12CARpTh0/ABeOoDmAd/eD2dD74C9ZuAFjHrccbE+iaoZqhCnPDCJ5vSSYhm+8/U63Ld
 1yQc6+6yxIPLJuqJcFhmmKVS4lV28Jh6J3G4vlk5ZCA3KzOl7MC5ocKqGvDAOx8DAwzyYT4tO
 EYih0tJ7+zWsltEqVX4ZQGng4iuS+p3//fzk7dmEC0PImuMh7VIf0ZXIYaR7mVVmwZKjk7NEp
 U4+UgRUn6tpuP6EgZR/KMd+EMb1vtkEhtyu5CbTJYPvaZCY1UrhzM2UVBM7lIcvk98Kymr41/
 ncdn3QlTkMS7v1MyF1jnvL+FTccKb31hP3piqL967ERUpGsTG4aEJ12ybvdOpGxnOtxUlv/XC
 BHLOenTs0RDVpOFphjbV0sbvI8u72hLzMrbdZeQze23LqxUdmip83dkIG5pi0H8zr7HYY/K8/
 352G032+R6iJHjyYvZfHDvtQnkfh2UhMZo6YQvZDahdTEv6WxMVsYOf/5eTR/UV+g+b+/nzRv
 0lgvwh5tZdL3obqedvH8XiChe1pWzrH2PkHhyXbSvg9tmM25LbMD4ZHCHhbz4B0bKnb5elKWo
 4s3gisT4Yqnf9KLG+3Ht7+3uXro=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/22 16:33, Stefan N wrote:
> Hi Qu,
>
> Many thanks for the detailed instructions and your patience. I got it
> working combined with
> https://wiki.ubuntu.com/Kernel/BuildYourOwnKernel on the main system
> OS instead, tagged +btrfix
> $ uname -vr
> 6.2.0-23-generic #23+btrfix SMP PREEMPT_DYNAMIC Thu Jun 22
>
> However, I've not had luck with the commands suggested, and would
> appreciate any further ideas.
>
> Outputs follow below, with /mnt/data as the btrfs mount point that
> currently contains 8x disks sd[a-j] with an additional 4x 64gb USB
> flash drives being added sd[l-o]
> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
> dev add -f /dev/sdl /dev/sdm /dev/sdn /dev/sdo /mnt/data ; sudo btrfs
> fi sync /mnt/data
> ERROR: error adding device '/dev/sdl': Input/output error
> ERROR: error adding device '/dev/sdm': Read-only file system
> ERROR: error adding device '/dev/sdn': Read-only file system
> ERROR: error adding device '/dev/sdo': Read-only file system
> ERROR: Could not sync filesystem: Read-only file system
> $
>
> The same occurs if I try to add 4x 100mb loop devices (on a ssd so
> they're super quick to zero);
> $ sudo mount -o skip_balance -t btrfs /dev/sde /mnt/data ; sudo btrfs
> dev add -K -f /dev/loop16 /dev/loop17 /dev/loop18 /dev/loop19
> /mnt/data ; sudo btrfs fi sync /mnt/data
> ERROR: error adding device '/dev/loop16': Input/output error

This is the interesting part, this means we're erroring out due to -EIO
(not -ENOSPC) during the first device add.

And by somehow, after the first device add, we already got the trans abort=
.

Would you please try the following branch?

https://github.com/adam900710/linux/tree/dev_add_no_commit

It has not only the patch to skip the commit, but also extra debug
output for the situation.

Thanks,
Qu

> ERROR: error adding device '/dev/loop17': Read-only file system
> ERROR: error adding device '/dev/loop18': Read-only file system
> ERROR: error adding device '/dev/loop19': Read-only file system
> ERROR: Could not sync filesystem: Read-only file system
> $
>
> I confirmed before both these kernel builds that the replaced line was
> btrfs_end_transaction rather than btrfs_commit_transaction (anyone
> else following, I needed to remove the -n in the patch command
> earlier)
> $ grep -A3 -ri btrfs_sysfs_update_sprout */fs/btrfs/volumes.c*
> linux-6.2.0-dist/fs/btrfs/volumes.c:
> btrfs_sysfs_update_sprout_fsid(fs_devices);
> linux-6.2.0-dist/fs/btrfs/volumes.c-    }
> linux-6.2.0-dist/fs/btrfs/volumes.c-
> linux-6.2.0-dist/fs/btrfs/volumes.c-    ret =3D btrfs_commit_transaction=
(trans);
> --
> linux-6.2.0-v2/fs/btrfs/volumes.c:
> btrfs_sysfs_update_sprout_fsid(fs_devices);
> linux-6.2.0-v2/fs/btrfs/volumes.c-      }
> linux-6.2.0-v2/fs/btrfs/volumes.c-
> linux-6.2.0-v2/fs/btrfs/volumes.c-      ret =3D btrfs_end_transaction(tr=
ans);
> --
> linux-6.2.0-v3/fs/btrfs/volumes.c:
> btrfs_sysfs_update_sprout_fsid(fs_devices);
> linux-6.2.0-v3/fs/btrfs/volumes.c-      }
> linux-6.2.0-v3/fs/btrfs/volumes.c-
> linux-6.2.0-v3/fs/btrfs/volumes.c-      ret =3D btrfs_end_transaction(tr=
ans);
> $
>
> $ btrfs fi usage /mnt/data
> Overall:
>      Device size:                  87.31TiB
>      Device allocated:             87.31TiB
>      Device unallocated:            1.94GiB
>      Device missing:                  0.00B
>      Device slack:                    0.00B
>      Used:                         87.08TiB
>      Free (estimated):            173.29GiB      (min: 172.33GiB)
>      Free (statfs, df):           171.84GiB
>      Data ratio:                       1.34
>      Metadata ratio:                   4.00
>      Global reserve:              512.00MiB      (used: 371.25MiB)
>      Multiple profiles:                  no
>
> Data,RAID6: Size:64.76TiB, Used:64.59TiB (99.74%)
>     /dev/sdc       10.90TiB
>     /dev/sdf       10.90TiB
>     /dev/sda       10.86TiB
>     /dev/sdg       10.87TiB
>     /dev/sdh       10.86TiB
>     /dev/sdd       10.87TiB
>     /dev/sde       10.88TiB
>     /dev/sdb       10.88TiB
>
> Metadata,RAID1C4: Size:77.79GiB, Used:77.11GiB (99.12%)
>     /dev/sdc       15.33GiB
>     /dev/sdf       18.41GiB
>     /dev/sda       49.63GiB
>     /dev/sdg       49.50GiB
>     /dev/sdh       51.52GiB
>     /dev/sdd       48.70GiB
>     /dev/sde       39.09GiB
>     /dev/sdb       39.01GiB
>
> System,RAID1C4: Size:37.00MiB, Used:5.11MiB (13.81%)
>     /dev/sdc        1.00MiB
>     /dev/sda       37.00MiB
>     /dev/sdg       37.00MiB
>     /dev/sdh       36.00MiB
>     /dev/sdd       37.00MiB
>
> Unallocated:
>     /dev/sdc        1.00MiB
>     /dev/sdf        1.00MiB
>     /dev/sda        1.27GiB
>     /dev/sdg        1.00MiB
>     /dev/sdh        1.00MiB
>     /dev/sdd      687.00MiB
>     /dev/sde        1.00MiB
>     /dev/sdb        1.00MiB
> $
>
>
> This first attempt generated the following syslog output:
> kernel: [  868.435387] BTRFS info (device sde): using crc32c
> (crc32c-intel) checksum algorithm
> kernel: [  868.435407] BTRFS info (device sde): disk space caching is en=
abled
> kernel: [  874.477712] BTRFS info (device sde): bdev /dev/sdg errs: wr
> 0, rd 0, flush 0, corrupt 845, gen 0
> kernel: [  874.477727] BTRFS info (device sde): bdev /dev/sdc errs: wr
> 41089, rd 1556, flush 0, corrupt 0, gen 0
> kernel: [  874.477735] BTRFS info (device sde): bdev /dev/sdj errs: wr
> 3, rd 7, flush 0, corrupt 0, gen 0
> kernel: [  874.477740] BTRFS info (device sde): bdev /dev/sdf errs: wr
> 41, rd 0, flush 0, corrupt 0, gen 0
> kernel: [ 1082.645551] BTRFS info (device sde): balance: resume skipped
> kernel: [ 1082.645564] BTRFS info (device sde): checking UUID tree
> kernel: [ 1082.645551] BTRFS info (device sde): balance: resume skipped
> kernel: [ 1082.645564] BTRFS info (device sde): checking UUID tree
> kernel: [ 1267.280506] BTRFS: Transaction aborted (error -28)
> kernel: [ 1267.280553] BTRFS: error (device sde: state A) in
> do_free_extent_accounting:2847: errno=3D-28 No space left
> kernel: [ 1267.280604] BTRFS info (device sde: state EA): forced readonl=
y
> kernel: [ 1267.280610] BTRFS error (device sde: state EA): failed to
> run delayed ref for logical 102255404044288 num_bytes 294912 type 184
> action 2 ref_mod 1: -28
> kernel: [ 1267.280584] WARNING: CPU: 3 PID: 14519 at
> fs/btrfs/extent-tree.c:2847 do_free_extent_accounting+0x21a/0x220
> [btrfs]
> kernel: [ 1267.280666] BTRFS: error (device sde: state EA) in
> btrfs_run_delayed_refs:2151: errno=3D-28 No space left
> kernel: [ 1267.280695] BTRFS warning (device sde: state EA):
> btrfs_uuid_scan_kthread failed -5
> kernel: [ 1267.280794] Modules linked in: xt_nat xt_tcpudp veth
> xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo
> xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc
> ipmi_devintf ipmi_msghandler overlay iwlwifi_compat(O) binfmt_misc
> nls_iso8859_1 intel_rapl_msr intel_rapl_common edac_mce_amd
> snd_hda_codec_realtek kvm_amd snd_hda_codec_generic ledtrig_audio kvm
> snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi
> snd_hda_codec irqbypass snd_hda_core snd_hwdep rapl snd_pcm snd_timer
> wmi_bmof k10temp snd ccp soundcore input_leds mac_hid dm_multipath
> scsi_dh_rdac scsi_dh_emc scsi_dh_alua bonding tls efi_pstore msr nfsd
> auth_rpcgss nfs_acl lockd grace sunrpc dmi_sysfs ip_tables x_tables
> autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov
> async_memcpy async_pq async_xor async_txxor raid6_pq libcrc32c raid1
> raid0 multipath linear hid_generic usbhid hid amdgpu uas usb_storage
> kernel: [ 1267.280994] CPU: 3 PID: 14519 Comm: btrfs-transacti
> Tainted: G        W  O       6.2.0-23-generic #23+btrfix
> kernel: [ 1267.281005] RIP: 0010:do_free_extent_accounting+0x21a/0x220 [=
btrfs]
> kernel: [ 1267.281181]  __btrfs_free_extent+0x6bc/0xf50 [btrfs]
> kernel: [ 1267.281310]  run_delayed_data_ref+0x8b/0x180 [btrfs]
> kernel: [ 1267.281444]  btrfs_run_delayed_refs_for_head+0x196/0x520 [btr=
fs]
> kernel: [ 1267.281570]  __btrfs_run_delayed_refs+0xe6/0x1d0 [btrfs]
> kernel: [ 1267.281694]  btrfs_run_delayed_refs+0x6d/0x1f0 [btrfs]
> kernel: [ 1267.281818]  btrfs_start_dirty_block_groups+0x36b/0x530 [btrf=
s]
> kernel: [ 1267.281976]  btrfs_commit_transaction+0xb3/0xbc0 [btrfs]
> kernel: [ 1267.282110]  ? start_transaction+0xc8/0x600 [btrfs]
> kernel: [ 1267.282244]  transaction_kthread+0x14b/0x1c0 [btrfs]
> kernel: [ 1267.282375]  ? __pfx_transaction_kthread+0x10/0x10 [btrfs]
> kernel: [ 1267.282548] BTRFS info (device sde: state EA): dumping space =
info:
> kernel: [ 1267.282552] BTRFS info (device sde: state EA): space_info
> DATA has 160777674752 free, is not full
> kernel: [ 1267.282558] BTRFS info (device sde: state EA): space_info
> total=3D71201958395904, used=3D71018191273984, pinned=3D22985908224,
> reserved=3D0, may_use=3D0, readonly=3D3538944 zone_unusable=3D0
> kernel: [ 1267.282566] BTRFS info (device sde: state EA): space_info
> METADATA has -124944384 free, is full
> kernel: [ 1267.282571] BTRFS info (device sde: state EA): space_info
> total=3D83530612736, used=3D82791497728, pinned=3D242745344,
> reserved=3D496369664, may_use=3D124944384, readonly=3D0 zone_unusable=3D=
0
> kernel: [ 1267.282577] BTRFS info (device sde: state EA): space_info
> SYSTEM has 33439744 free, is not full
> kernel: [ 1267.282582] BTRFS info (device sde: state EA): space_info
> total=3D38797312, used=3D5357568, pinned=3D0, reserved=3D0, may_use=3D0,
> readonly=3D0 zone_unusable=3D0
> kernel: [ 1267.282588] BTRFS info (device sde: state EA):
> global_block_rsv: size 536870912 reserved 124944384
> kernel: [ 1267.282592] BTRFS info (device sde: state EA):
> trans_block_rsv: size 0 reserved 0
> kernel: [ 1267.282595] BTRFS info (device sde: state EA):
> chunk_block_rsv: size 0 reserved 0
> kernel: [ 1267.282599] BTRFS info (device sde: state EA):
> delayed_block_rsv: size 0 reserved 0
> kernel: [ 1267.282602] BTRFS info (device sde: state EA):
> delayed_refs_rsv: size 251322957824 reserved 0
> kernel: [ 1267.282608] BTRFS: error (device sde: state EA) in
> do_free_extent_accounting:2847: errno=3D-28 No space left
> kernel: [ 1267.282653] BTRFS error (device sde: state EA): failed to
> run delayed ref for logical 102255401897984 num_bytes 126976 type 184
> action 2 ref_mod 1: -28
> kernel: [ 1267.282708] BTRFS: error (device sde: state EA) in
> btrfs_run_delayed_refs:2151: errno=3D-28 No space left
>
> A couple of kernel recompiles later, the second attempt on the SSD
> generated similar:
> kernel: [ 1472.203470] BTRFS info (device sdc): using crc32c
> (crc32c-intel) checksum algorithm
> kernel: [ 1472.203491] BTRFS info (device sdc): disk space caching is en=
abled
> kernel: [ 1478.155004] BTRFS info (device sdc): bdev /dev/sdf errs: wr
> 0, rd 0, flush 0, corrupt 845, gen 0
> kernel: [ 1478.155022] BTRFS info (device sdc): bdev /dev/sda errs: wr
> 41089, rd 1556, flush 0, corrupt 0, gen 0
> kernel: [ 1478.155034] BTRFS info (device sdc): bdev /dev/sdh errs: wr
> 3, rd 7, flush 0, corrupt 0, gen 0
> kernel: [ 1478.155041] BTRFS info (device sdc): bdev /dev/sdd errs: wr
> 41, rd 0, flush 0, corrupt 0, gen 0
> kernel: [ 1696.662526] BTRFS info (device sdc): balance: resume skipped
> kernel: [ 1696.662537] BTRFS info (device sdc): checking UUID tree
> kernel: [ 1919.452464] BTRFS: Transaction aborted (error -28)
> kernel: [ 1919.452534] WARNING: CPU: 1 PID: 161 at
> fs/btrfs/extent-tree.c:2847 do_free_extent_accounting+0x21a/0x220
> [btrfs]
> kernel: [ 1919.452655] Modules linked in: xt_nat xt_tcpudp veth
> xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo
> xt_addrtype nft_compat nf_tables nfnetlink br_netfilter bridge stp llc
> ipmi_devintf ipmi_msghandler overlay iwlwifi_compat(O) binfmt_misc
> nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_generic
> ledtrig_audio snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg
> snd_intel_sdw_acpi snd_hda_codec intel_rapl_msr snd_hda_core
> intel_rapl_common edac_mce_amd snd_hwdep kvm_amd snd_pcm snd_timer kvm
> irqbypass rapl wmi_bmof snd k10temp soundcore ccp input_leds mac_hid
> dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua bonding tls nfsd
> msr auth_rpcgss efi_pstore nfs_acl lockd grace sunrpc dmi_sysfs
> ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456
> async_raid6_recov async_memcpy async_pq async_xor async_tx xor
> raid6_pq libcrc32c raid1 raid0 multipath linear hid_generic usbhid
> amdgpu uas hid iommu_v2
> kernel: [ 1919.452839] Workqueue: events_unbound
> btrfs_async_reclaim_metadata_space [btrfs]
> kernel: [ 1919.452985] RIP: 0010:do_free_extent_accounting+0x21a/0x220 [=
btrfs]
> kernel: [ 1919.453141]  __btrfs_free_extent+0x6bc/0xf50 [btrfs]
> kernel: [ 1919.453256]  run_delayed_data_ref+0x8b/0x180 [btrfs]
> kernel: [ 1919.453368]  btrfs_run_delayed_refs_for_head+0x196/0x520 [btr=
fs]
> kernel: [ 1919.453480]  __btrfs_run_delayed_refs+0xe6/0x1d0 [btrfs]
> kernel: [ 1919.453592]  btrfs_run_delayed_refs+0x6d/0x1f0 [btrfs]
> kernel: [ 1919.453703]  flush_space+0x23c/0x2c0 [btrfs]
> kernel: [ 1919.453845]  btrfs_async_reclaim_metadata_space+0x19b/0x2b0 [=
btrfs]
> kernel: [ 1919.454034] BTRFS info (device sdc: state A): dumping space i=
nfo:
> kernel: [ 1919.454038] BTRFS info (device sdc: state A): space_info
> DATA has 160778723328 free, is not full
> kernel: [ 1919.454043] BTRFS info (device sdc: state A): space_info
> total=3D71201958395904, used=3D71017442181120, pinned=3D23733952512,
> reserved=3D0, may_use=3D0, readonly=3D3538944 zone_unusable=3D0
> kernel: [ 1919.454050] BTRFS info (device sdc: state A): space_info
> METADATA has -147570688 free, is full
> kernel: [ 1919.454054] BTRFS info (device sdc: state A): space_info
> total=3D83530612736, used=3D82792185856, pinned=3D238059520,
> reserved=3D500367360, may_use=3D147570688, readonly=3D0 zone_unusable=3D=
0
> kernel: [ 1919.454060] BTRFS info (device sdc: state A): space_info
> SYSTEM has 33439744 free, is not full
> kernel: [ 1919.454064] BTRFS info (device sdc: state A): space_info
> total=3D38797312, used=3D5357568, pinned=3D0, reserved=3D0, may_use=3D0,
> readonly=3D0 zone_unusable=3D0
> kernel: [ 1919.454070] BTRFS info (device sdc: state A):
> global_block_rsv: size 536870912 reserved 147570688
> kernel: [ 1919.454074] BTRFS info (device sdc: state A):
> trans_block_rsv: size 0 reserved 0
> kernel: [ 1919.454077] BTRFS info (device sdc: state A):
> chunk_block_rsv: size 0 reserved 0
> kernel: [ 1919.454080] BTRFS info (device sdc: state A):
> delayed_block_rsv: size 0 reserved 0
> kernel: [ 1919.454083] BTRFS info (device sdc: state A):
> delayed_refs_rsv: size 254292787200 reserved 0
> kernel: [ 1919.454086] BTRFS: error (device sdc: state A) in
> do_free_extent_accounting:2847: errno=3D-28 No space left
> kernel: [ 1919.454123] BTRFS info (device sdc: state EA): forced readonl=
y
> kernel: [ 1919.454127] BTRFS error (device sdc: state EA): failed to
> run delayed ref for logical 102538713931776 num_bytes 245760 type 184
> action 2 ref_mod 1: -28
> kernel: [ 1919.454176] BTRFS: error (device sdc: state EA) in
> btrfs_run_delayed_refs:2151: errno=3D-28 No space left
> kernel: [ 1919.454249] BTRFS warning (device sdc: state EA):
> btrfs_uuid_scan_kthread failed -5
> kernel: [ 1919.472381] BTRFS: error (device sdc: state EA) in
> __btrfs_free_extent:3077: errno=3D-28 No space left
> kernel: [ 1919.472417] BTRFS error (device sdc: state EA): failed to
> run delayed ref for logical 102538732191744 num_bytes 245760 type 184
> action 2 ref_mod 1: -28
> kernel: [ 1919.472442] BTRFS: error (device sdc: state EA) in
> btrfs_run_delayed_refs:2151: errno=3D-28 No space left
>
>
> On Sat, 17 Jun 2023 at 15:00, Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> On 2023/6/17 13:11, Stefan N wrote:
>>> Hi Qu,
>>>
>>> I believe I've got this environment ready, with the 6.2.0 kernel as
>>> before using the Ubuntu kernel, but can switch to vanilla if required.
>>>
>>> I've not done anything kernel modifications for a solid decade, so
>>> would be keen for a bit of guidance.
>>
>> Sure no problem.
>>
>> Please fetch the kernel source tar ball (6.2.x) first, decompress, then
>> apply the attached one-line patch by:
>>
>> $ tar czf linux*.tar.xz
>> $ cd linux*
>> $ patch -np1 -i <the patch file>
>>
>> Then use your running system kernel config if possible:
>>
>> $ cp /proc/config.gz .
>> $ gunzip config.gz
>> $ mv config .config
>> $ make olddefconfig
>>
>> Then you can start your kernel compiling, and considering you're using
>> your distro's default, it would include tons of drivers, thus would be
>> very slow. (Replace the number to something more suitable to your
>> system, using all CPU cores can be very hot)
>>
>> $ make -j12
>>
>> Finally you need to install the modules/kernel.
>>
>> Unfortunately this is distro specific, but if you're using Ubuntu, it
>> may be much easier:
>>
>> $ make bindeb-pkg
>>
>> Then install the generated dpkg I guess? I have never tried kernel
>> building using deb/rpm, but only manual installation, which is also
>> distro dependent in the initramfs generation part.
>>
>> # cp arch/x86/boot/bzImage /boot/vmlinuz-custom
>> # make modules_install
>> # mkinitcpio -k /boot/vmlinuz-custom -g /boot/initramfs-custom.img
>>
>>
>> The last step is to update your bootloader to add the new kernel, which
>> is not only distro dependent but also bootloader dependent.
>>
>> In my case, I go with systemd-boot with manually crafted entries.
>> But if you go Ubuntu I believe just installing the kernel dpkg would
>> have everything handled?
>>
>> Finally you can try reboot into the newer kernel, and try device add
>> (need to add 4 disks), then sync and see if things work as expected.
>>
>> Thanks,
>> Qu
>>>
>>> I will recover a 1tb SSD and partition it into 4 in a USB enclosure,
>>> but failing this will use 4x loop devices.
>>>
>>> On Tue, 13 Jun 2023 at 11:28, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>>> In your particular case, since you're running RAID1C4 you need to add=
 4
>>>> devices in one transaction.
>>>>
>>>> I can easily craft a patch to avoid commit transaction, but still you=
'll
>>>> need to add at least 4 disks, and then sync to see if things would wo=
rk.
>>>>
>>>> Furthermore this means you need a liveCD with full kernel compiling
>>>> environment.
>>>>
>>>> If you want to go this path, I can send you the patch when you've
>>>> prepared the needed environment.
