Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5E32B259
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbhCCB6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:58:16 -0500
Received: from out20-25.mail.aliyun.com ([115.124.20.25]:36417 "EHLO
        out20-25.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349559AbhCBKhc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Mar 2021 05:37:32 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0193764-0.000440993-0.980183;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JfNvPw0_1614681394;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JfNvPw0_1614681394)
          by smtp.aliyun-inc.com(10.147.42.241);
          Tue, 02 Mar 2021 18:36:34 +0800
Date:   Tue, 02 Mar 2021 18:36:38 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 1/2] btrfs-progs: check: detect and warn about tree blocks cross 64K page boundary
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <e478e495-e2f6-452d-c615-a7e1f32805e7@suse.com>
References: <20210302164758.28C1.409509F4@e16-tech.com> <e478e495-e2f6-452d-c615-a7e1f32805e7@suse.com>
Message-Id: <20210302183637.96B4.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-Mailer: Becky! ver. 2.75.03 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

This is a full mkfs.btrtfs log

[root@T7610 ~]# mkfs.btrfs -O no-holes -R free-space-tree /dev/sdb1 -f
btrfs-progs v5.10.1
See http://btrfs.wiki.kernel.org for more information.

Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if you want to force metadata duplication.
Label:              (null)
UUID:               8c745f77-3cdb-45f0-9b67-c69a9bd491a1
Node size:          16384
Sector size:        4096
Filesystem size:    60.00GiB
Block group profiles:
  Data:             single            8.00MiB
  Metadata:         single            8.00MiB
  System:           single            4.00MiB
SSD detected:       yes
Incompat features:  extref, skinny-metadata, no-holes
Runtime features:   free-space-tree
Checksum:           crc32c
Number of devices:  1
Devices:
   ID        SIZE  PATH
    1    60.00GiB  /dev/sdb1

[root@T7610 ~]# btrfs check /dev/sdb1
Opening filesystem to check...
Checking filesystem on /dev/sdb1
UUID: 8c745f77-3cdb-45f0-9b67-c69a9bd491a1
[1/7] checking root items
[2/7] checking extents
WARNING: tree block [5292032, 5308416) crosses 64K page boudnary, may cause problem for 64K page system
WARNING: tree block [5357568, 5373952) crosses 64K page boudnary, may cause problem for 64K page system
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 147456 bytes used, no error found
total csum bytes: 0
total tree bytes: 147456
total fs tree bytes: 32768
total extent tree bytes: 16384
btree space waste bytes: 140356
file data blocks allocated: 0
 referenced 0
[root@T7610 ~]# mount /dev/sdb1 /mnt/scratch/
[root@T7610 ~]# btrfs filesystem usage /mnt/scratch
Overall:
    Device size:                  60.00GiB
    Device allocated:             20.00MiB
    Device unallocated:           59.98GiB
    Device missing:                  0.00B
    Used:                        144.00KiB
    Free (estimated):             59.99GiB      (min: 59.99GiB)
    Free (statfs, df):            59.99GiB
    Data ratio:                       1.00
    Metadata ratio:                   1.00
    Global reserve:                3.25MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:8.00MiB, Used:0.00B (0.00%)
   /dev/sdb1       8.00MiB

Metadata,single: Size:8.00MiB, Used:128.00KiB (1.56%)
   /dev/sdb1       8.00MiB

System,single: Size:4.00MiB, Used:16.00KiB (0.39%)
   /dev/sdb1       4.00MiB

Unallocated:
   /dev/sdb1      59.98GiB


[root@T7610 ~]# parted /dev/sdb unit s print
Model: TOSHIBA PX05SMQ040 (scsi)
Disk /dev/sdb: 97677846s
Sector size (logical/physical): 4096B/4096B
Partition Table: gpt
Disk Flags:

Number  Start      End        Size       File system  Name     Flags
 1      262144s    15990783s  15728640s  btrfs        primary
 2      15990784s  31719423s  15728640s               primary
 3      31719424s  47448063s  15728640s               primary
 4      47448064s  63176703s  15728640s               primary
 5      63176704s  78905343s  15728640s               primary

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/03/02

> 
> 
> On 2021/3/2 ÏÂÎç4:48, Wang Yugui wrote:
> > Hi, Qu Wenruo
> >
> > This warning message happen even in new created filesystem on amd64
> > system.
> >
> > Should we slicent it before mkfs.btrfs is ready for  64K page system?
> 
> Nope.
> 
> If your fs reports such problem, it means your metadata chunk is not properly aligned.
> 
> The behavior of chunk allocator alignment has been there for a long long time, thus most metadata chunks should already been properly aligned to 64K.
> 
> Either btrfs kernel module or mkfs.btrfs has something wrong.
> 
> 
> >
> > The paration is aligned in 1GiB
> >
> > btrfs-progs: v5.10.x branch
> >
> > # mkfs.btrfs /dev/sdb1 -f
> > 
> And running v5.10.1 I can't reproduce it.
> 
> > # btrfs check /dev/sdb1
> > Opening filesystem to check...
> > Checking filesystem on /dev/sdb1
> > UUID: b298271d-6d1d-4792-a579-fb93653aa811
> > [1/7] checking root items
> > [2/7] checking extents
> > WARNING: tree block [5292032, 5308416) crosses 64K page boudnary, may cause problem for 64K page system
> > WARNING: tree block [5357568, 5373952) crosses 64K page boudnary, may cause problem for 64K page system
> 
> I doubt if you're really using v5.10.x mkfs.btrfs.
> 
> As for default btrfs, the metadata chunk is after DATA and SYS chunks, this means metadata chunks should only exist after bytenr 16M, but here your metadata is only at around 5M.
> 
> I strongly doubt your mkfs parameters.
> 
> Please attach the full mkfs output.
> 
> Thanks,
> Qu
> 
> > [3/7] checking free space tree
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > found 147456 bytes used, no error found
> > total csum bytes: 0
> > total tree bytes: 147456
> > total fs tree bytes: 32768
> > total extent tree bytes: 16384
> > btree space waste bytes: 140356
> > file data blocks allocated: 0
> >   referenced 0
> >
> > # parted /dev/sdb unit KiB print
> > Model: TOSHIBA PX05SMQ040 (scsi)
> > Disk /dev/sdb: 390711384kiB
> > Sector size (logical/physical): 4096B/4096B
> > Partition Table: gpt
> > Disk Flags:
> >
> > Number  Start         End           Size         File system  Name     Flags
> >   1      1048576kiB    63963136kiB   62914560kiB  btrfs        primary
> >
> >
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2021/03/02
> >
> >> For the incoming subpage support, there is a new requirement for tree
> >> blocks.
> >> Tree blocks should not cross 64K page boudnary.
> >>
> >> For current btrfs-progs and kernel, there shouldn't be any causes to
> >> create such tree blocks.
> >>
> >> But still, we want to detect such tree blocks in the wild before subpage
> >> support fully lands in upstream.
> >>
> >> This patch will add such check for both lowmem and original mode.
> >> Currently it's just a warning, since there aren't many users using 64K
> >> page size yet.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   check/main.c        |  2 ++
> >>   check/mode-common.h | 18 ++++++++++++++++++
> >>   check/mode-lowmem.c |  2 ++
> >>   3 files changed, 22 insertions(+)
> >>
> >> diff --git a/check/main.c b/check/main.c
> >> index e7996b7c8c0e..0ce9c2f334b4 100644
> >> --- a/check/main.c
> >> +++ b/check/main.c
> >> @@ -5375,6 +5375,8 @@ static int process_extent_item(struct btrfs_root *root,
> >>   		      num_bytes, gfs_info->sectorsize);
> >>   		return -EIO;
> >>   	}
> >> +	if (metadata)
> >> +		btrfs_check_subpage_eb_alignment(key.objectid, num_bytes);
> >>  >>   	memset(&tmpl, 0, sizeof(tmpl));
> >>   	tmpl.start = key.objectid;
> >> diff --git a/check/mode-common.h b/check/mode-common.h
> >> index 4efc07a4f44d..bcda0f53e2c4 100644
> >> --- a/check/mode-common.h
> >> +++ b/check/mode-common.h
> >> @@ -171,4 +171,22 @@ static inline u32 btrfs_type_to_imode(u8 type)
> >>  >>   	return imode_by_btrfs_type[(type)];
> >>   }
> >> +
> >> +/*
> >> + * Check tree block alignement for future subpage support on 64K page system.
> >> + *
> >> + * Subpage support on 64K page size require one eb to be completely contained
> >> + * by a page. Not allowing a tree block to cross 64K page boudanry.
> >> + *
> >> + * Since subpage support is still under development, this check only provides
> >> + * warning.
> >> + */
> >> +static inline void btrfs_check_subpage_eb_alignment(u64 start, u32 len)
> >> +{
> >> +	if (start / BTRFS_MAX_METADATA_BLOCKSIZE !=
> >> +	    (start + len) / BTRFS_MAX_METADATA_BLOCKSIZE)
> >> +		warning(
> >> +"tree block [%llu, %llu) crosses 64K page boudnary, may cause problem for 64K page system",
> >> +			start, start + len);
> >> +}
> >>   #endif
> >> diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
> >> index 2b689b2abf63..6dbfe829bb7c 100644
> >> --- a/check/mode-lowmem.c
> >> +++ b/check/mode-lowmem.c
> >> @@ -4206,6 +4206,8 @@ static int check_extent_item(struct btrfs_path *path)
> >>   		      key.objectid, key.objectid + nodesize);
> >>   		err |= CROSSING_STRIPE_BOUNDARY;
> >>   	}
> >> +	if (metadata)
> >> +		btrfs_check_subpage_eb_alignment(key.objectid, nodesize);
> >>  >>   	ptr = (unsigned long)(ei + 1);
> >>  >> --
> >> 2.29.2
> >
> > 


