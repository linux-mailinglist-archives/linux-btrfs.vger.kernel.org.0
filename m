Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5184F8EE16
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2019 16:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbfHOOVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Aug 2019 10:21:38 -0400
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:37676 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730497AbfHOOVi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Aug 2019 10:21:38 -0400
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-06v.sys.comcast.net with ESMTP
        id yFSFhUUjauvPDyGdBhBWIC; Thu, 15 Aug 2019 14:21:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1565878893;
        bh=0WIEvPsIslZ2xtozYSdQWShDy70NjjC9ZSToTyJLyFQ=;
        h=Received:Received:Received:Received:Date:From:To:Subject:
         Message-ID:Reply-To:MIME-Version:Content-Type;
        b=wpqw66+Av68sTcTc0Rk+4FIr/t2uHP8ipStpGEQ4Wd/yI1FV3+OMDCzr8i1l3KZaL
         ddmsl5E8EONdNXBkJMoOm3yHvNI4ReQflAuSoUZIRUsmIAcG+Jr4mR0UYN0YgoFl2h
         bsAJGEl1vxGFnmbsmojahSd5CTyTQXaVJKNXNqD0JUvw97Z4snpazvPfk8kk4v1XBU
         21XCfZNbSifKJaevGnWjm4ZQOdGi8gCpH5WtKF3a3NbUMAFgdlxRu95+8Fn3g1S5v/
         ETMYy6n+GFDmNTbxCC9S5hPlHWu7zFW/mkk8h1nHnRhQN2VuclKYCVrXttMxAmuwQl
         7dyHzV3e+982Q==
Received: from beta.localdomain ([73.209.109.78])
        by resomta-po-05v.sys.comcast.net with ESMTPA
        id yGcjhNu9CCDVRyGckhSpGU; Thu, 15 Aug 2019 14:21:28 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgeduvddrudefuddgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkrhhfgggtuggjvggfsehmtderredtredvnecuhfhrohhmpefvihhmucghrghlsggvrhhguceothifrghlsggvrhhgsegtohhmtggrshhtrdhnvghtqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeejfedrvddtledruddtledrjeeknecurfgrrhgrmhephhgvlhhopegsvghtrgdrlhhotggrlhguohhmrghinhdpihhnvghtpeejfedrvddtledruddtledrjeekpdhmrghilhhfrhhomhepthifrghlsggvrhhgsegtohhmtggrshhtrdhnvghtpdhrtghpthhtohepqhhufigvnhhruhhordgsthhrfhhssehgmhigrdgtohhmpdhrtghpthhtohepthifrghlsggvrhhgsegtohhmtggrshhtrdhnvghtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-Xfinity-VMeta: sc=0;st=legit
Received: from calvin.localdomain ([10.0.0.8])
        by beta.localdomain with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <twalberg@comcast.net>)
        id 1hyGcj-0007WE-DR; Thu, 15 Aug 2019 09:21:05 -0500
Received: from tew by calvin.localdomain with local (Exim 4.84_2)
        (envelope-from <tew@calvin.localdomain>)
        id 1hyGcj-0004Fm-7y; Thu, 15 Aug 2019 09:21:05 -0500
Date:   Thu, 15 Aug 2019 09:21:05 -0500
From:   Tim Walberg <twalberg@comcast.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Tim Walberg <twalberg@comcast.net>, linux-btrfs@vger.kernel.org
Subject: Re: recovering from "parent transid verify failed"
Message-ID: <20190815142105.GE2731@comcast.net>
Reply-To: Tim Walberg <twalberg@comcast.net>
References: <20190814183213.GA2731@comcast.net>
 <4be5086f-61e7-a108-8036-da7d7a5d5c11@gmx.com>
 <20190815135251.GC2731@comcast.net>
 <b871da91-1330-f8c9-add8-858025a91fc9@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <b871da91-1330-f8c9-add8-858025a91fc9@gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

'dump-super -Ffa' from all three devices attached.

'btrfs restore' did appear to recover most of the main data, minus
snapshots, which would have greatly increased the required time and
capacity, since I was recovering to XFS.

'btrfs rescue chunk-recover' ran, but failed to fix anything.
'btrfs rescue super-recover' says all supers are fine.

Initial corruption was due to a hard hang, which didn't leave enough
crumbs to determine the source - might have been btrfs, might have
been nvidia, might have been something completely different.


On 08/15/2019 22:07 +0800, Qu Wenruo wrote:
>>	
>>	
>>	On 2019/8/15 ??????9:52, Tim Walberg wrote:
>>	> Had to wait for 'btrfs recover' to finish before I proceed farther.
>>	> 
>>	> Kernel is 4.19.45, tools are 4.19.1
>>	> 
>>	> File system is a 3-disk RAID10 with WD3003FZEX (WD Black 3TB)
>>	> 
>>	> Output from attempting to mount:
>>	> 
>>	> # mount -o ro,usebackuproot /dev/sdc1 /mnt
>>	> mount: wrong fs type, bad option, bad superblock on /dev/sdc1,
>>	>        missing codepage or helper program, or other error
>>	> 
>>	>        In some cases useful info is found in syslog - try
>>	>        dmesg | tail or so.
>>	> 
>>	> Kernel messages from the mount attempt:
>>	> 
>>	> [Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): trying to use backup root at mount time
>>	> [Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): disk space caching is enabled
>>	> [Thu Aug 15 08:47:42 2019] BTRFS info (device sdc1): has skinny extents
>>	> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): parent transid verify failed on 229846466560 wanted 49749 found 49750
>>	> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): parent transid verify failed on 229846466560 wanted 49749 found 49750
>>	> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): failed to read block groups: -5
>>	
>>	Extent tree corruption.
>>	
>>	So if that's the only corruption, you have a very high chance to recover
>>	most of your data.
>>	
>>	Btrfs rescue can work, or you can try the experimental patches which
>>	provides rescue=skip_bg mount option to allow you mount the fs RO and
>>	receive your data (later is way faster than user space rescue)
>>	https://patchwork.kernel.org/project/linux-btrfs/list/?series=130637
>>	
>>	Also, for your dump super output, it doesn't provide too much info.
>>	
>>	You would like to use -Ffa option for more info.
>>	Also, you could also try that on all 3 devices, to find out which one
>>	has lower generation.
>>	
>>	Also, please provide the history of the corruption.
>>	One generation corruptions is a little rare. Is sudden power loss
>>	involved in this case?
>>	
>>	Thanks,
>>	Qu
>>	
>>	> [Thu Aug 15 08:47:42 2019] BTRFS error (device sdc1): open_ctree failed
>>	> 
>>	> Output from 'btrfs check -p /dev/sdc1':
>>	> 
>>	> # btrfs check -p /dev/sdc1
>>	> Opening filesystem to check...
>>	> parent transid verify failed on 229846466560 wanted 49749 found 49750
>>	> Ignoring transid failure
>>	> ERROR: child eb corrupted: parent bytenr=229845336064 item=0 parent level=1 child level=2
>>	> ERROR: cannot open file system
>>	> 
>>	> 
>>	> 
>>	> On 08/15/2019 10:35 +0800, Qu Wenruo wrote:
>>	>>> 	
>>	>>> 	
>>	>>> 	On 2019/8/15 ??????2:32, Tim Walberg wrote:
>>	>>> 	> Most of the recommendations I've found online deal with when "wanted" is
>>	>>> 	> greater than "found", which, if I understand correctly means that one or
>>	>>> 	> more transactions were interrupted/lost before fully committed.
>>	>>> 	
>>	>>> 	No matter what the case is, a proper transaction shouldn't have any tree
>>	>>> 	block overwritten.
>>	>>> 	
>>	>>> 	That means, either the FLUSH/FUA of the hardware/lower block layer is
>>	>>> 	screwed up, or the COW of tree block is already screwed up.
>>	>>> 	
>>	>>> 	> 
>>	>>> 	> Are the recommendations for recovery the same if the system is reporting a
>>	>>> 	> "wanted" that is less than "found"?
>>	>>> 	> 
>>	>>> 	The salvage is no difference than any transid mismatch, no matter if
>>	>>> 	it's larger or smaller.
>>	>>> 	
>>	>>> 	It depends on the tree block.
>>	>>> 	
>>	>>> 	Please provide full dmesg output and btrfs check for further advice.
>>	>>> 	
>>	>>> 	Thanks,
>>	>>> 	Qu
>>	>>> 	
>>	> 
>>	> 
>>	> 
>>	> 
>>	



End of included message



-- 
+----------------------+
| Tim Walberg          |
| 830 Carriage Dr.     |
| Algonquin, IL 60102  |
| twalberg@comcast.net |
+----------------------+

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="supers.txt"

superblock: bytenr=65536, device=/dev/sdc1
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x4331039b [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			53749823-faaf-46f9-866d-3778d93cb1ca
label			btrfs1
generation		49750
root			229846646784
sys_array_size		129
chunk_root_generation	49725
root_level		1
chunk_root		2568857059328
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		9001775738880
bytes_used		2085801975808
sectorsize		4096
nodesize		16384
leafsize (deprecated)		16384
stripesize		4096
root_dir		6
num_devices		3
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x361
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA |
			  NO_HOLES )
cache_generation	49748
uuid_tree_generation	49748
dev_item.uuid		7338a973-9a45-4032-a4c9-d18142fd7908
dev_item.fsid		53749823-faaf-46f9-866d-3778d93cb1ca [match]
dev_item.type		0
dev_item.total_bytes	3000591912960
dev_item.bytes_used	1407675531264
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 2568857059328)
		length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 2 offset 300690702336
			dev_uuid acad0cd5-aaec-4f6d-bf61-6c5b26888562
			stripe 1 devid 3 offset 1083179008
			dev_uuid ee71c327-ff63-4f46-8177-6328976f891f
backup_roots[4]:
	backup 0:
		backup_tree_root:	205750272	gen: 49747	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	174325760	gen: 49747	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	270893056	gen: 49747	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 1:
		backup_tree_root:	230054100992	gen: 49748	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	230054117376	gen: 49748	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	230736379904	gen: 49748	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 2:
		backup_tree_root:	2031969501184	gen: 49745	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031960915968	gen: 49745	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2031960244224	gen: 49745	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802795008
		backup_num_devices:	3

	backup 3:
		backup_tree_root:	2032017784832	gen: 49746	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031988506624	gen: 49746	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2032023994368	gen: 49746	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802778624
		backup_num_devices:	3


superblock: bytenr=67108864, device=/dev/sdc1
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xe3502b55 [match]
bytenr			67108864
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			53749823-faaf-46f9-866d-3778d93cb1ca
label			btrfs1
generation		49750
root			229846646784
sys_array_size		129
chunk_root_generation	49725
root_level		1
chunk_root		2568857059328
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		9001775738880
bytes_used		2085801975808
sectorsize		4096
nodesize		16384
leafsize (deprecated)		16384
stripesize		4096
root_dir		6
num_devices		3
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x361
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA |
			  NO_HOLES )
cache_generation	49748
uuid_tree_generation	49748
dev_item.uuid		7338a973-9a45-4032-a4c9-d18142fd7908
dev_item.fsid		53749823-faaf-46f9-866d-3778d93cb1ca [match]
dev_item.type		0
dev_item.total_bytes	3000591912960
dev_item.bytes_used	1407675531264
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 2568857059328)
		length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 2 offset 300690702336
			dev_uuid acad0cd5-aaec-4f6d-bf61-6c5b26888562
			stripe 1 devid 3 offset 1083179008
			dev_uuid ee71c327-ff63-4f46-8177-6328976f891f
backup_roots[4]:
	backup 0:
		backup_tree_root:	205750272	gen: 49747	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	174325760	gen: 49747	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	270893056	gen: 49747	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 1:
		backup_tree_root:	230054100992	gen: 49748	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	230054117376	gen: 49748	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	230736379904	gen: 49748	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 2:
		backup_tree_root:	2031969501184	gen: 49745	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031960915968	gen: 49745	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2031960244224	gen: 49745	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802795008
		backup_num_devices:	3

	backup 3:
		backup_tree_root:	2032017784832	gen: 49746	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031988506624	gen: 49746	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2032023994368	gen: 49746	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802778624
		backup_num_devices:	3


superblock: bytenr=274877906944, device=/dev/sdc1
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x1ed77d64 [match]
bytenr			274877906944
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			53749823-faaf-46f9-866d-3778d93cb1ca
label			btrfs1
generation		49750
root			229846646784
sys_array_size		129
chunk_root_generation	49725
root_level		1
chunk_root		2568857059328
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		9001775738880
bytes_used		2085801975808
sectorsize		4096
nodesize		16384
leafsize (deprecated)		16384
stripesize		4096
root_dir		6
num_devices		3
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x361
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA |
			  NO_HOLES )
cache_generation	49748
uuid_tree_generation	49748
dev_item.uuid		7338a973-9a45-4032-a4c9-d18142fd7908
dev_item.fsid		53749823-faaf-46f9-866d-3778d93cb1ca [match]
dev_item.type		0
dev_item.total_bytes	3000591912960
dev_item.bytes_used	1407675531264
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 2568857059328)
		length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 2 offset 300690702336
			dev_uuid acad0cd5-aaec-4f6d-bf61-6c5b26888562
			stripe 1 devid 3 offset 1083179008
			dev_uuid ee71c327-ff63-4f46-8177-6328976f891f
backup_roots[4]:
	backup 0:
		backup_tree_root:	205750272	gen: 49747	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	174325760	gen: 49747	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	270893056	gen: 49747	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 1:
		backup_tree_root:	230054100992	gen: 49748	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	230054117376	gen: 49748	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	230736379904	gen: 49748	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 2:
		backup_tree_root:	2031969501184	gen: 49745	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031960915968	gen: 49745	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2031960244224	gen: 49745	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802795008
		backup_num_devices:	3

	backup 3:
		backup_tree_root:	2032017784832	gen: 49746	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031988506624	gen: 49746	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2032023994368	gen: 49746	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802778624
		backup_num_devices:	3


superblock: bytenr=65536, device=/dev/sdd1
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xd0f74999 [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			53749823-faaf-46f9-866d-3778d93cb1ca
label			btrfs1
generation		49750
root			229846646784
sys_array_size		129
chunk_root_generation	49725
root_level		1
chunk_root		2568857059328
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		9001775738880
bytes_used		2085801975808
sectorsize		4096
nodesize		16384
leafsize (deprecated)		16384
stripesize		4096
root_dir		6
num_devices		3
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x361
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA |
			  NO_HOLES )
cache_generation	49748
uuid_tree_generation	49748
dev_item.uuid		acad0cd5-aaec-4f6d-bf61-6c5b26888562
dev_item.fsid		53749823-faaf-46f9-866d-3778d93cb1ca [match]
dev_item.type		0
dev_item.total_bytes	3000591912960
dev_item.bytes_used	1404487860224
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		2
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 2568857059328)
		length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 2 offset 300690702336
			dev_uuid acad0cd5-aaec-4f6d-bf61-6c5b26888562
			stripe 1 devid 3 offset 1083179008
			dev_uuid ee71c327-ff63-4f46-8177-6328976f891f
backup_roots[4]:
	backup 0:
		backup_tree_root:	205750272	gen: 49747	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	174325760	gen: 49747	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	270893056	gen: 49747	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 1:
		backup_tree_root:	230054100992	gen: 49748	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	230054117376	gen: 49748	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	230736379904	gen: 49748	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 2:
		backup_tree_root:	2031969501184	gen: 49745	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031960915968	gen: 49745	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2031960244224	gen: 49745	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802795008
		backup_num_devices:	3

	backup 3:
		backup_tree_root:	2032017784832	gen: 49746	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031988506624	gen: 49746	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2032023994368	gen: 49746	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802778624
		backup_num_devices:	3


superblock: bytenr=67108864, device=/dev/sdd1
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x70966157 [match]
bytenr			67108864
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			53749823-faaf-46f9-866d-3778d93cb1ca
label			btrfs1
generation		49750
root			229846646784
sys_array_size		129
chunk_root_generation	49725
root_level		1
chunk_root		2568857059328
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		9001775738880
bytes_used		2085801975808
sectorsize		4096
nodesize		16384
leafsize (deprecated)		16384
stripesize		4096
root_dir		6
num_devices		3
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x361
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA |
			  NO_HOLES )
cache_generation	49748
uuid_tree_generation	49748
dev_item.uuid		acad0cd5-aaec-4f6d-bf61-6c5b26888562
dev_item.fsid		53749823-faaf-46f9-866d-3778d93cb1ca [match]
dev_item.type		0
dev_item.total_bytes	3000591912960
dev_item.bytes_used	1404487860224
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		2
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 2568857059328)
		length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 2 offset 300690702336
			dev_uuid acad0cd5-aaec-4f6d-bf61-6c5b26888562
			stripe 1 devid 3 offset 1083179008
			dev_uuid ee71c327-ff63-4f46-8177-6328976f891f
backup_roots[4]:
	backup 0:
		backup_tree_root:	205750272	gen: 49747	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	174325760	gen: 49747	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	270893056	gen: 49747	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 1:
		backup_tree_root:	230054100992	gen: 49748	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	230054117376	gen: 49748	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	230736379904	gen: 49748	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 2:
		backup_tree_root:	2031969501184	gen: 49745	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031960915968	gen: 49745	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2031960244224	gen: 49745	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802795008
		backup_num_devices:	3

	backup 3:
		backup_tree_root:	2032017784832	gen: 49746	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031988506624	gen: 49746	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2032023994368	gen: 49746	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802778624
		backup_num_devices:	3


superblock: bytenr=274877906944, device=/dev/sdd1
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x8d113766 [match]
bytenr			274877906944
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			53749823-faaf-46f9-866d-3778d93cb1ca
label			btrfs1
generation		49750
root			229846646784
sys_array_size		129
chunk_root_generation	49725
root_level		1
chunk_root		2568857059328
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		9001775738880
bytes_used		2085801975808
sectorsize		4096
nodesize		16384
leafsize (deprecated)		16384
stripesize		4096
root_dir		6
num_devices		3
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x361
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA |
			  NO_HOLES )
cache_generation	49748
uuid_tree_generation	49748
dev_item.uuid		acad0cd5-aaec-4f6d-bf61-6c5b26888562
dev_item.fsid		53749823-faaf-46f9-866d-3778d93cb1ca [match]
dev_item.type		0
dev_item.total_bytes	3000591912960
dev_item.bytes_used	1404487860224
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		2
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 2568857059328)
		length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 2 offset 300690702336
			dev_uuid acad0cd5-aaec-4f6d-bf61-6c5b26888562
			stripe 1 devid 3 offset 1083179008
			dev_uuid ee71c327-ff63-4f46-8177-6328976f891f
backup_roots[4]:
	backup 0:
		backup_tree_root:	205750272	gen: 49747	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	174325760	gen: 49747	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	270893056	gen: 49747	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 1:
		backup_tree_root:	230054100992	gen: 49748	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	230054117376	gen: 49748	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	230736379904	gen: 49748	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 2:
		backup_tree_root:	2031969501184	gen: 49745	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031960915968	gen: 49745	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2031960244224	gen: 49745	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802795008
		backup_num_devices:	3

	backup 3:
		backup_tree_root:	2032017784832	gen: 49746	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031988506624	gen: 49746	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2032023994368	gen: 49746	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802778624
		backup_num_devices:	3


superblock: bytenr=65536, device=/dev/sde1
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xb89a7a2e [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			53749823-faaf-46f9-866d-3778d93cb1ca
label			btrfs1
generation		49750
root			229846646784
sys_array_size		129
chunk_root_generation	49725
root_level		1
chunk_root		2568857059328
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		9001775738880
bytes_used		2085801975808
sectorsize		4096
nodesize		16384
leafsize (deprecated)		16384
stripesize		4096
root_dir		6
num_devices		3
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x361
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA |
			  NO_HOLES )
cache_generation	49748
uuid_tree_generation	49748
dev_item.uuid		ee71c327-ff63-4f46-8177-6328976f891f
dev_item.fsid		53749823-faaf-46f9-866d-3778d93cb1ca [match]
dev_item.type		0
dev_item.total_bytes	3000591912960
dev_item.bytes_used	1405561602048
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		3
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 2568857059328)
		length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 2 offset 300690702336
			dev_uuid acad0cd5-aaec-4f6d-bf61-6c5b26888562
			stripe 1 devid 3 offset 1083179008
			dev_uuid ee71c327-ff63-4f46-8177-6328976f891f
backup_roots[4]:
	backup 0:
		backup_tree_root:	205750272	gen: 49747	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	174325760	gen: 49747	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	270893056	gen: 49747	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 1:
		backup_tree_root:	230054100992	gen: 49748	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	230054117376	gen: 49748	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	230736379904	gen: 49748	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 2:
		backup_tree_root:	2031969501184	gen: 49745	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031960915968	gen: 49745	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2031960244224	gen: 49745	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802795008
		backup_num_devices:	3

	backup 3:
		backup_tree_root:	2032017784832	gen: 49746	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031988506624	gen: 49746	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2032023994368	gen: 49746	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802778624
		backup_num_devices:	3


superblock: bytenr=67108864, device=/dev/sde1
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x18fb52e0 [match]
bytenr			67108864
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			53749823-faaf-46f9-866d-3778d93cb1ca
label			btrfs1
generation		49750
root			229846646784
sys_array_size		129
chunk_root_generation	49725
root_level		1
chunk_root		2568857059328
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		9001775738880
bytes_used		2085801975808
sectorsize		4096
nodesize		16384
leafsize (deprecated)		16384
stripesize		4096
root_dir		6
num_devices		3
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x361
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA |
			  NO_HOLES )
cache_generation	49748
uuid_tree_generation	49748
dev_item.uuid		ee71c327-ff63-4f46-8177-6328976f891f
dev_item.fsid		53749823-faaf-46f9-866d-3778d93cb1ca [match]
dev_item.type		0
dev_item.total_bytes	3000591912960
dev_item.bytes_used	1405561602048
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		3
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 2568857059328)
		length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 2 offset 300690702336
			dev_uuid acad0cd5-aaec-4f6d-bf61-6c5b26888562
			stripe 1 devid 3 offset 1083179008
			dev_uuid ee71c327-ff63-4f46-8177-6328976f891f
backup_roots[4]:
	backup 0:
		backup_tree_root:	205750272	gen: 49747	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	174325760	gen: 49747	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	270893056	gen: 49747	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 1:
		backup_tree_root:	230054100992	gen: 49748	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	230054117376	gen: 49748	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	230736379904	gen: 49748	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 2:
		backup_tree_root:	2031969501184	gen: 49745	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031960915968	gen: 49745	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2031960244224	gen: 49745	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802795008
		backup_num_devices:	3

	backup 3:
		backup_tree_root:	2032017784832	gen: 49746	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031988506624	gen: 49746	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2032023994368	gen: 49746	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802778624
		backup_num_devices:	3


superblock: bytenr=274877906944, device=/dev/sde1
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0xe57c04d1 [match]
bytenr			274877906944
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			53749823-faaf-46f9-866d-3778d93cb1ca
label			btrfs1
generation		49750
root			229846646784
sys_array_size		129
chunk_root_generation	49725
root_level		1
chunk_root		2568857059328
chunk_root_level	1
log_root		0
log_root_transid	0
log_root_level		0
total_bytes		9001775738880
bytes_used		2085801975808
sectorsize		4096
nodesize		16384
leafsize (deprecated)		16384
stripesize		4096
root_dir		6
num_devices		3
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x361
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA |
			  NO_HOLES )
cache_generation	49748
uuid_tree_generation	49748
dev_item.uuid		ee71c327-ff63-4f46-8177-6328976f891f
dev_item.fsid		53749823-faaf-46f9-866d-3778d93cb1ca [match]
dev_item.type		0
dev_item.total_bytes	3000591912960
dev_item.bytes_used	1405561602048
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		3
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0
dev_item.generation	0
sys_chunk_array[2048]:
	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 2568857059328)
		length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
		io_align 65536 io_width 65536 sector_size 4096
		num_stripes 2 sub_stripes 1
			stripe 0 devid 2 offset 300690702336
			dev_uuid acad0cd5-aaec-4f6d-bf61-6c5b26888562
			stripe 1 devid 3 offset 1083179008
			dev_uuid ee71c327-ff63-4f46-8177-6328976f891f
backup_roots[4]:
	backup 0:
		backup_tree_root:	205750272	gen: 49747	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	174325760	gen: 49747	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	270893056	gen: 49747	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 1:
		backup_tree_root:	230054100992	gen: 49748	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	230054117376	gen: 49748	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	229931761664	gen: 49747	level: 1
		backup_csum_root:	230736379904	gen: 49748	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085801975808
		backup_num_devices:	3

	backup 2:
		backup_tree_root:	2031969501184	gen: 49745	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031960915968	gen: 49745	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2031960244224	gen: 49745	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802795008
		backup_num_devices:	3

	backup 3:
		backup_tree_root:	2032017784832	gen: 49746	level: 1
		backup_chunk_root:	2568857059328	gen: 49725	level: 1
		backup_extent_root:	2031988506624	gen: 49746	level: 2
		backup_fs_root:		850472665088	gen: 49727	level: 0
		backup_dev_root:	230821036032	gen: 49738	level: 1
		backup_csum_root:	2032023994368	gen: 49746	level: 3
		backup_total_bytes:	9001775738880
		backup_bytes_used:	2085802778624
		backup_num_devices:	3



--xHFwDpU9dbj6ez1V--
