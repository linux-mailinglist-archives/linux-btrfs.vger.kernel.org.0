Return-Path: <linux-btrfs+bounces-14051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5E5AB8C99
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 18:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F161BC62E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 16:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD967221D86;
	Thu, 15 May 2025 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MvcrSj52"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C731221FCD
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327026; cv=none; b=SpttBBWXjALyZ2v2V8jiVm79fbk5PjMZ8u9M6nKaqRjAMLDXOjpwlGKS1YKTJy4wrNOa0Hx7mOYN5KHxfDUmSBFs3EczXK4IMaZJhzSvFkkrb6BaDShzBlrlheMccMyxCObV6SwZ/5w4+a+m+UPVbQDSG22WZZSVp9eDz5O9AVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327026; c=relaxed/simple;
	bh=OP1fw44QWQd2P2ubXg1NFXsuZ9UYkKXTZuYa5rG/SPU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fVNS/dxyn79wGxo38WyISC1XYWM6I/87w5hqOs/Pi8MVxbccm+ErmcBh1nRiZTS0dnGFohaoE9POMeu58diH7O14KJEcD9mUJZrc97A6l0x4tiUHS6gc2I+H8sZCOt+omnHxmq2YCrAG+9NsXBPxf27SNeo5zacE7iERz74WJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=MvcrSj52; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FFi99m026914
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:37:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=UKe38SZzjl8bSoMLtUB+0+l
	22CP+jTxwbdaTR3qaf0E=; b=MvcrSj52rgWlhXMP+9KHKDOdPjIFCqYV6c6cNSl
	W5BK+NXKGsG8Ink0VQNqxiQtlHgBGcx5DTTn6D3CLANL7L9yu6QWIEpZ/zD6GH2W
	0jgek6C6uvPZV50e4IPCf7Q6QV+aznjXnmXosn8by4//Sd5+43BSbgkRFv/pind1
	rkNo=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46n9gfv9p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 09:37:01 -0700 (PDT)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 15 May 2025 16:37:00 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id B440DF3BE100; Thu, 15 May 2025 17:36:45 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [RFC PATCH 00/10] Remap tree
Date: Thu, 15 May 2025 17:36:28 +0100
Message-ID: <20250515163641.3449017-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: RJbPtkpe21CbUpBy2SB4kaWAxh1iId6z
X-Authority-Analysis: v=2.4 cv=famty1QF c=1 sm=1 tr=0 ts=6826182d cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=NEAV23lmAAAA:8 a=Lsd6zfMvCUWDHZzkZQoA:9 a=tLFeCk1aXtsA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2NCBTYWx0ZWRfX0CIREW2/zhFu J4GAFh44Jhau9NavIyeGY4UHvFKXD/mduqMBcv+2ksHGm3lh82cICtlI/gezXrA/IoWt3F/jwJa /gl0WF5QQ8sdkjGzg6gGR93r/099DE7CvsVTXCGuy5KdGUyBaI2QDqeFwnd5MBoM6QEiG603MDE
 M+SBYGiXZHZYsgEqxCE5JI1lZtqJQGbnShTSUbtTjbuXHC1z18+/UDUjIgD2BMoiaYKXXECASgC dqkMJ5oU9+Yarh9Ek6kryfdm7mfBGnkWyQTjn4AUTLmIHGYT09DvoNJ6+V0IKYLAwf5AAkgj9SV H0FsB20xKdCsjLVu2mGhhIbKc2Vu5bUPx7yfbxlYQMQE4VqG25vu5ROZY5OeTapZthd/wnWWFHO
 f3+4WIQNKcFyo86qVRvipEWow57zZCvYigMNc1VpkKejEQOiwSZrSe42OzkCc2wCHyaRCxzH
X-Proofpoint-ORIG-GUID: RJbPtkpe21CbUpBy2SB4kaWAxh1iId6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01

Hi all,

This is an RFC for an experimental remap-tree incompat feature, which rew=
orks
how we perform relocations. Our present system involves following backref=
s to
rewrite addresses in the metadata trees, which can be slow and has knock-=
on
effects such as breaking nocow files. Instead, this adds a remap tree to =
act as
another layer of indirection: if a block group has the REMAPPED bit set, =
all
I/O to addresses nominally within it get translated by a lookup to the re=
map
tree.

See https://github.com/btrfs/btrfs-todo/issues/54 for Josef's original de=
sign,
which I've elaborated on, and more on the rationale. To test this you wil=
l also
need a patched btrfs-progs, for `mkfs.btrfs -O remap-tree`:
https://github.com/maharmstone/btrfs-progs/tree/remap-tree. See also
https://github.com/maharmstone/btrfs/blob/remap-tree/btrfs-dump.pl for a =
dumper
script that's remap-aware.

The BTRFS_FEATURE_INCOMPAT_REMAP_TREE flag implies the following changes:

* There's a new remap tree, which is created empty

* The data reloc tree isn't created, as it's no longer needed (data reloc=
ation
is no longer done via snapshots)

* There's a new metadata chunk type, REMAP, which consists solely of the =
remap
tree. This is to avoid bootstrapping issues: REMAP chunks, like SYSTEM, a=
re
still relocated the old way (i.e. by COWing every leaf). We can't put the=
 remap
tree in SYSTEM: because the chunk items are put in the superblock, it wou=
ld
limit our available space

* The top of the remap tree is recorded in the superblock

* Two new fields are added to struct btrfs_block_group_item: le64 remap_b=
ytes
and le32 identity_remap_count. remap_bytes records how much data in a blo=
ck
group has been relocated from another block group. identity_remap_count r=
ecords
how many identity remaps exist for this block group (see later)

* If a block group has the REMAPPED flag set and identity_remaps =3D=3D 0=
, its
chunk will have 0 stripes and 0 dev extents: everything nominally within =
it its
actually located elsewhere

* All data and metadata addresses are now translated addresses, for which=
 we
need to consult the remap tree to find the underlying addresses before do=
ing
I/O, if they live in a remapped BG. The exception is the free-space tree,=
 which
is entirely underlying addresses (the free-space cache v1 isn't supported=
 here).

REMAP TREE
----------

The remap tree consists of three types of items: identity remaps, remaps,=
 and
remap backrefs. Each represents a non-overlapping range. Remaps are ortho=
gonal
to extents: an extent might be split into several ranges in the remap tre=
e, or
multiple consecutive extents might be remapped together.

Identity remaps represent a range for which we don't need to do a transla=
tion,
i.e. the REMAPPED flag has been set for the BG but we haven't yet done a
relocation.

Remaps have a u64 payload which gives the underlying address to use for t=
he
start of this range, i.e. the non-REMAPPED block group we should use for =
I/O.

Remap backrefs are a reverse index for the remaps, with their objectid be=
ing
the underlying address and their u64 payload being the translated address=
.
We need backrefs because when relocation a block group that contains exis=
ting
remaps, these need to be moved first (we don't want to have to consult an
ever-increasing chain of BGs).

RELOCATION
----------

For SYSTEM and REMAP block groups, relocation is as it is at the moment (=
mark
the BG readonly, COW every leaf).

For DATA and METADATA block groups, we do the following:

* If remap_bytes > 0, search the remap tree for the remap backrefs that a=
re
physically located in this block group. Move the data on disk, munge the =
remap
and free-space trees to reflect this, and reduce remap_bytes. Loop until
remap_bytes is 0.

* Search the free-space tree for holes, convert these into identity remap=
s
within the remap tree, set the identity_remap_count within in the block
group item, and set the REMAPPED flag on the block group item and the chu=
nk.
The REMAPPED flag will prevent new allocations from being made from this =
block
group.

* Walk through the remap tree looking for the identity remaps that we hav=
e
created. For each one, try to reserve the same amount of space in another=
 block
group. Read the data into memory, and write an exact copy into the new
location. Increase remap_bytes in the destination block group, and reduce
identity_remap_count in the source block group if we can move the whole t=
hing.
Add the space back to the free-space tree in the source BG, and remove th=
e
space in the free-space tree for the destination BG.

* When identity_remaps_count =3D=3D 0, the block group has been fully rem=
apped, and
now exists solely for the purposes of remapping. Set num_stripes to 0 in =
the
chunk item, remove its stripes, and remove the entries in the dev extent =
tree.

* If a block group has the REMAPPED flag set, identity_remaps_count =3D=3D=
 0, and
remap_bytes =3D=3D 0, it is now empty. The block group item, chunk item, =
and
entries in the free-space tree can be removed.

KNOWN ISSUES
------------

* Still a few problems with some fstests: btrfs/156, btrfs/170,
btrfs/177, btrfs/226, btrfs/250, btrfs/252.

* There's a race when it comes to nodatacow writes. I think we ought to b=
e
calling btrfs_inc_nocow_writers(), but that COWs rather than blocking.

* It can be reluctant to drop entries for empty remapped block groups. Th=
is
doesn't waste substantial amounts of space on disk as there's no dev exte=
nts,
but it is polluting the block group and chunk trees. Similarly we ought t=
o be
removing any enties in the free-space tree for fully remapped block group=
s: no
new allocations can be done within them, and they no longer correspond to=
 a
location on disk.

* At the moment we're allocating 1GB for the REMAP chunks, which is proba=
bly
overkilled. One 16KB leaf of the remap tree can cover ~250GB in the best =
case
and ~1MB in the worst case. Possibly 32MB is the sweet spot, as for SYSTE=
M.
Allocating more REMAP chunks isn't a problem, as unlike SYSTEM they don't=
 go in
the superblock.

* There's a spurious lockdep warning when doing remapped metadata reads, =
as
we're locking an extent buffer within the remap tree while already holdin=
g
another extent buffer lock. We either need to disable the warning for thi=
s, or
change the code to use search_commit_root. We can't add another level to =
the
lockdep hierarchy as we're already maxed out at 8.

* I'm think the lookup code in btrfs_translate_remap() probably needs to =
be
refined. Possibly we can do without the call to btrfs_prev_leaf().

* At present we scan the free-space holes and create the identity remaps =
all in
the same transaction. For the worst-case scenario of a 1GB block group wi=
th
every other sector allocated, relocation takes ~30 seconds on my system, =
on an
NVMe drive with no other load. Josef has suggested that we split this int=
o
multiple transactions, setting something like
BTRFS_BLOCK_GROUP_ADDING_IDENTITY_REMAPS at the start, and discarding any
progress on mount if we find a BG with this flag set, which makes sense t=
o me.
The code is currently gated behind CONFIG_BTRFS_EXPERIMENTAL. My preferen=
ce
would be that, like with the RAID stripe tree, we accept that there may b=
e
minor on-disk format changes until it can be moved out of experimental - =
i.e.
we treat this as a (near-)future improvement rather than a blocker.

* Josef has also suggested that we don't log metadata items for the remap=
 tree
in the extent tree, in anticipation of later omitting all COW-only metada=
ta
items from the extent tree. My view is that treating the remap tree as a
special case would be more trouble than it's worth, both here and in prog=
s, and
omitting all COW-only metadata items should be relegated to a later incom=
pat
change that depends on this one.

* There's still a lot of userspace work to be done: making sure that all =
space
reporting etc. tools are okay, adding a comprehensive series of tests to =
btrfs
check, allowing toggling this incompat flag on and off in btrfstune.

Thanks

Mark

Mark Harmstone (10):
  btrfs: add definitions and constants for remap-tree
  btrfs: add REMAP chunk type
  btrfs: allow remapped chunks to have zero stripes
  btrfs: add extended version of struct block_group_item
  btrfs: allow mounting filesystems with remap-tree incompat flag
  btrfs: redirect I/O for remapped block groups
  btrfs: handle deletions from remapped block group
  btrfs: handle setting up relocation of block group with remap-tree
  btrfs: move existing remaps before relocating block group
  btrfs: replace identity maps with actual remaps when doing relocations

 fs/btrfs/Kconfig                |    2 +
 fs/btrfs/accessors.h            |   29 +
 fs/btrfs/block-group.c          |  181 ++-
 fs/btrfs/block-group.h          |   15 +-
 fs/btrfs/block-rsv.c            |    8 +
 fs/btrfs/block-rsv.h            |    1 +
 fs/btrfs/ctree.c                |   11 +-
 fs/btrfs/ctree.h                |    3 +
 fs/btrfs/disk-io.c              |   88 +-
 fs/btrfs/extent-tree.c          |   38 +-
 fs/btrfs/free-space-tree.c      |    4 +-
 fs/btrfs/free-space-tree.h      |    5 +-
 fs/btrfs/fs.h                   |    7 +-
 fs/btrfs/relocation.c           | 2065 ++++++++++++++++++++++++++++++-
 fs/btrfs/relocation.h           |    8 +-
 fs/btrfs/space-info.c           |   20 +-
 fs/btrfs/sysfs.c                |    4 +
 fs/btrfs/transaction.c          |    7 +
 fs/btrfs/tree-checker.c         |   37 +-
 fs/btrfs/volumes.c              |  106 +-
 fs/btrfs/volumes.h              |   17 +-
 include/uapi/linux/btrfs.h      |    1 +
 include/uapi/linux/btrfs_tree.h |   29 +-
 23 files changed, 2509 insertions(+), 177 deletions(-)

--=20
2.49.0


