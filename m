Return-Path: <linux-btrfs+bounces-14488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B38ACF42E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 18:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0F11885910
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAF1274FD7;
	Thu,  5 Jun 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ii58ri2q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98FC1C4A13
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140639; cv=none; b=qb5BZAhI4swjc67OjT+bvO6zGUKNuawXP6TK5jDFPZ207OgEjWsVaazCpH3X3NgTiv9HsGF1n+N6Cj/ceyl4k7NnL5RrnIB+wOqipTgeGvK0T15Jcu9MjjOMX8zsEHQ/lPZFCJELDV6DxbzJIKmER+buYvaDFhLTeoYYCTP4k6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140639; c=relaxed/simple;
	bh=aDxoyTpwhXITlnuKuvx683Z07XenBHQ2f26yZZvKLzY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E6TTI1/3Qp9vmJ9R/EiRVsM5VtaArkx1PokDQCwZjN8WYBh5cQbNbqQ6sv/TgTjecCmTuw0l4YfbTgoiVweKM+rjIEOu/IBkxPdtpO4QGwMckLZegaO0HV6PCLWUrfuHb7SLNcwMG2Ri+56J/NLDSF0ojYdw06rNLSqeu82962M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=Ii58ri2q; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555Dw0bW027778
	for <linux-btrfs@vger.kernel.org>; Thu, 5 Jun 2025 09:23:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=IAh9B95gdRp0GV79HBXtJ+D
	W4UtRaFSIbZvQLo1eHAk=; b=Ii58ri2qrTzKGJGlVPimK75y+h3AZD5B4/dyjyQ
	sa9bfy1qVl6/J9cpRvhisDBKn/7zkRAo7dbA46brUbPJG88FgOdNeTX8zdxMf0oA
	QjNkVawlFGuxbmvwVfwSHpTSFwg66g1h4DEsnsKikqhDE6AcFvU8wfYSKLFXB6F9
	SkXs=
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4739tktdmr-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 09:23:57 -0700 (PDT)
Received: from twshared53813.03.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 5 Jun 2025 16:23:54 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 2961DFEC2E5D; Thu,  5 Jun 2025 17:23:48 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH 00/12] btrfs: remap tree
Date: Thu, 5 Jun 2025 17:23:30 +0100
Message-ID: <20250605162345.2561026-1-maharmstone@fb.com>
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
X-Authority-Analysis: v=2.4 cv=ZbEdNtVA c=1 sm=1 tr=0 ts=6841c49d cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=07d9gI8wAAAA:8 a=NEAV23lmAAAA:8 a=RjVo25tpq5Rm3DbVET8A:9 a=e2CUPOnPG4QKp8I52DXD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE0NCBTYWx0ZWRfX7B+muRzBxT75 WML97hexR8EVbZjNxLL81uYaBLUqGh+8p7ZUFgMHeEox2qB21fSiMbXetmiUGZWyA1iGfgq51bm E33mzImx7rBHW6RlZCLQvBYAUge3mFJETTYPpow65Is/5cTKE82zCx0t9D8N3PwpGIwyehEAPXD
 iwTrpH0lgv1t2h0at/3g0r5z9/N0h5vwY6otSi8YmYpqg+d6o9+9Y3238TTcbVUaid6oN/XZL1Y nsAIvES0zcH40OWt2CQGH7Auh8k7TkX+OLlj9j8cjy7kj461lrkqknIoU1Pmqep0Wk5IHFFdGq5 9CWD59IHZ6EQfvg90luhu2ViAPJ9VtLIqzAq4KQ3h/PteAeFfc+NmVSjZSlEho=
X-Proofpoint-GUID: gu68Ibqj8jmBqMTMMOrwRvdWWRzRnGOB
X-Proofpoint-ORIG-GUID: gu68Ibqj8jmBqMTMMOrwRvdWWRzRnGOB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_04,2025-06-05_01,2025-03-28_01

This patch series adds a disk format change gated behind
CONFIG_BTRFS_EXPERIMENTAL to add a "remap tree", which acts as a layer of
indirection when doing I/O. When doing relocation, rather than fixing up =
every
tree, we instead record the old and new addresses in the remap tree. This=
 should
hopefully make things more reliable and flexible, as well as enabling som=
e
future changes we'd like to make, such as larger data extents and reducin=
g
write amplification by removing cow-only metadata items.

The remap tree lives in a new REMAP chunk type. This is because bootstrap=
ping
means that it can't be remapped itself, and has to be relocated by COWing=
 it as
at present. It can't go in the SYSTEM chunk as we are then limited by the=
 chunk
item needing to fit in the superblock.

For more on the design and rationale, please see my RFC sent last month[1=
], as
well as Josef Bacik's original design document[2]. The main change from J=
osef's
design is that I've added remap backrefs, as we need to be able to move a
chunk's existing remaps before remapping it.

You will also need my patches to btrfs-progs[3] to make
`mkfs.btrfs -O remap-tree` work, as well as allowing `btrfs check` to rec=
ognize
the new format.

Changes since the RFC:

* I've reduce the REMAP chunk size from the normal 1GB to 32MB, to match =
the
  SYSTEM chunk. For a filesystem with 4KB sectors and 16KB node size, the=
 worst
  case is that one leaf covers ~1MB of data, and the best case ~250GB. Fo=
r a
  chunk, that implies a worst case of ~2GB and a best case of ~500TB.
  This isn't a disk-format change, so we can always adjust it if it prove=
s too
  big or small in practice. mkfs creates 8MB chunks, as it does for every=
thing.

* You can't make new allocations from remapped block groups, so I've chan=
ged
  it so there's no free-space entries for these (thanks to Boris Burkov f=
or the
  suggestion).

* The remap tree doesn't have metadata items in the extent tree (thanks t=
o Josef
  for the suggestion). This was to work around some corruption that delay=
ed refs
  were causing, but it also fits it with our future plans of removing all
  metadata items for COW-only trees, reducing write amplification.
  A knock-on effect of this is that I've had to disable balancing of the =
remap
  chunk itself. This is because we can no longer walk the extent tree, an=
d will
  have to walk the remap tree instead. When we remove the COW-only metada=
ta
  items, we will also have to do this for the chunk and root trees, as
  bootstrapping means they can't be remapped.

* btrfs_translate_remap() uses search_commit_root when doing metadata loo=
kups,
  to avoid nested locking issues. This also seems to be a lot quicker (bt=
rfs/187
  went from ~20mins to ~90secs).

* Unused remapped block groups should now get cleaned up more aggressivel=
y

* Other miscellaneous cleanups and fixes

Known issues:

* Relocation still needs to be implemented for the remap tree itself (see=
 above)

* Some test failures: btrfs/156, btrfs/170, btrfs/226, btrfs/250

* nodatacow extents aren't safe, as they can race with the relocation thr=
ead.
  We either need to follow the btrfs_inc_nocow_writers() approach, which =
COWs
  the extent, or change it so that it blocks here.

* When initially marking a block group as remapped, we are walking the fr=
ee-
  space tree and creating the identity remaps all in one transaction. For=
 the
  worst-case scenario, i.e. a 1GB block group with every other sector all=
ocated
  (131,072 extents), this can result in transaction times of more than 10=
 mins.
  This needs to be changed to allow this to happen over multiple transact=
ions.

* All this is disabled for zoned devices for the time being, as I've not =
been
  able to test it. I'm planning to make it compatible with zoned at a lat=
er
  date.

Thanks

[1] https://lwn.net/Articles/1021452/
[2] https://github.com/btrfs/btrfs-todo/issues/54
[3] https://github.com/maharmstone/btrfs-progs/tree/remap-tree

Mark Harmstone (12):
  btrfs: add definitions and constants for remap-tree
  btrfs: add REMAP chunk type
  btrfs: allow remapped chunks to have zero stripes
  btrfs: remove remapped block groups from the free-space tree
  btrfs: don't add metadata items for the remap tree to the extent tree
  btrfs: add extended version of struct block_group_item
  btrfs: allow mounting filesystems with remap-tree incompat flag
  btrfs: redirect I/O for remapped block groups
  btrfs: handle deletions from remapped block group
  btrfs: handle setting up relocation of block group with remap-tree
  btrfs: move existing remaps before relocating block group
  btrfs: replace identity maps with actual remaps when doing relocations

 fs/btrfs/Kconfig                |    2 +
 fs/btrfs/accessors.h            |   29 +
 fs/btrfs/block-group.c          |  202 +++-
 fs/btrfs/block-group.h          |   15 +-
 fs/btrfs/block-rsv.c            |    8 +
 fs/btrfs/block-rsv.h            |    1 +
 fs/btrfs/discard.c              |   11 +-
 fs/btrfs/disk-io.c              |   91 +-
 fs/btrfs/extent-tree.c          |  152 ++-
 fs/btrfs/free-space-tree.c      |    4 +-
 fs/btrfs/free-space-tree.h      |    5 +-
 fs/btrfs/fs.h                   |    7 +-
 fs/btrfs/relocation.c           | 1897 ++++++++++++++++++++++++++++++-
 fs/btrfs/relocation.h           |    8 +-
 fs/btrfs/space-info.c           |   22 +-
 fs/btrfs/sysfs.c                |    4 +
 fs/btrfs/transaction.c          |    7 +
 fs/btrfs/tree-checker.c         |   37 +-
 fs/btrfs/volumes.c              |  115 +-
 fs/btrfs/volumes.h              |   17 +-
 include/uapi/linux/btrfs.h      |    1 +
 include/uapi/linux/btrfs_tree.h |   29 +-
 22 files changed, 2444 insertions(+), 220 deletions(-)

--=20
2.49.0


