Return-Path: <linux-btrfs+bounces-14661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6915AD98DD
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Jun 2025 02:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BED3B6F56
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Jun 2025 00:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0563A2CA9;
	Sat, 14 Jun 2025 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="AkYXvYFr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aFhhlRVN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662710F2
	for <linux-btrfs@vger.kernel.org>; Sat, 14 Jun 2025 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749859466; cv=none; b=QnRdh6DCGaSfmZnrsY03xELH9erBTJc+d8iOebj4ZwocxqoyggllpOjitQz7JMX3rmyqFDr4Q0BjOIS3JcUVwzW3CJvjydIvg1uTAdF1TA8sK3DGLWK0sVJSBBSwPZ7YXP9gIP3G6zH8AR+1xwsrLuq3em+DdNtvIA35hWDkaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749859466; c=relaxed/simple;
	bh=TougHU1SGuLrcmRM8ABIqsnBErQouRew5K4qpKBuy0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpcbzlcqmzFh8D+UMBr70xCrxd3zsODTaymASPCOlc4jq4TCB683hof37c4QBP3FR0n7lR2+SZ//Vh3/MBhd1OVhKnF1DaY1kGoE4bS63YQjJH8Yy3zvj+sOPmdeYS84Y+bOVCzztcOG6XOBcvtPqsEWtoN2Rk7GZmv1N3pWA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=AkYXvYFr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aFhhlRVN; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A8422114012A;
	Fri, 13 Jun 2025 20:04:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 13 Jun 2025 20:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1749859462; x=1749945862; bh=PFlgAy/3jH
	ewgiITY/bZ3PDDwG1GjJI2FMyeF1gQ9+8=; b=AkYXvYFrtuJUcwHhV0cLXAwZM9
	fYJn6rBz0R/6yE8lf73Wcd3ZqC4Rh8DwnR2IClsMLTLPDo8oBxIoDvVSLZP7GHPE
	3dHyydbTgakfUOGGmi9Li/QBieEBGdZJr2n9mB/UqXDwK+KuxT7YSHwNWPw0sgZ9
	GiSv6AeExCWPhoE1VNHmv9YjRQentLoffn3WvcLsrNKncfTUJ6b24AiNLSY2TWf/
	pUic+ZLtUj3PgvOz3hev4PyBbyfuh5jlBtT/lZt8/WZfagCoQmmJJ2QE4AN2bjMZ
	AeC8HdysruFN92Z9Ts1DEWCm3yaNtB26JvclQ0mVdW3fTPJ76g9kINZjwYgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749859462; x=1749945862; bh=PFlgAy/3jHewgiITY/bZ3PDDwG1GjJI2FMy
	eF1gQ9+8=; b=aFhhlRVNZ8SbYpdB6FGb18MPpbMmgF88ua+QPqVXoPC1YwJmvmT
	cUGBrCTUAJYXJ0dqAUERMqJcyTks4SNe0W2MtZoFD45ZDjTB3bwrNSmoK3h7JjXU
	3e1sWWXa04bOn/CeKHCPCb6XcZbwkzItWsg1gC9wxePHxd5PAsQHdjx0knX/DNPz
	O1S2ysbslZW/PvX3kDtg59mejUxC511qgst4vnu5xu05lMON3JU8bnd5OmkbgJi2
	O96FwJ1TOn6rmqV7aLviltzCJr4PtWAXTm+eeIx1py87m+T2A3WPJk2mkC+cc54C
	QHNdrxTAARyU+aN7l9tZs42OqCID5PyJgfA==
X-ME-Sender: <xms:hrxMaKikjecXq5Acp7OHwk2QfJ7y4ljhtNCZZCxSDzqyp-im35mqXQ>
    <xme:hrxMaLAnFJxK6oEGSFj9uHRIX1MUe7ijJESC3YodRRfCUDoYgs5itXSHktL2tUbt_
    7HlZsKXPFShfd6d6cw>
X-ME-Received: <xmr:hrxMaCFe3b001ZqKnWYphTmLwokSptTaHWp7Qu1ikVj6V80p3WJz9ZPE9S_onIPig-ceJYLLn3EX1Z8uzkYR7Nr4Cag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduleefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepgeelffefvdegfeegudegueeujeetledtheduleeuueelveek
    udevfeevvdfgudeinecuffhomhgrihhnpehlfihnrdhnvghtpdhgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhr
    ihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepmhgrhhgrrhhmshhtohhnvgesfhgsrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hrxMaDQmImNQqZl9geShkYqTVTv7IVCvfl247ew4Fb-j39NpdFGN6Q>
    <xmx:hrxMaHzAEHBfcTny9g3sT9TQHTwRgj3p0tIdFIKYEcxRs2j5IAhCVA>
    <xmx:hrxMaB75Rz_IB-IbAp-iUxRsBFJ9YXKBwZspWQQlqzzOuW68qykHfw>
    <xmx:hrxMaEyXu7kGe4kfug1Ea-2pDxz4WdtyS_xRA-CY4rJjLdxLn03hxw>
    <xmx:hrxMaDEStmOu0-ak0BU_WNKaQGofp_D0Vsu400kUf77ppIvYR_le-EPY>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 20:04:22 -0400 (EDT)
Date: Fri, 13 Jun 2025 17:04:02 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: remap tree
Message-ID: <20250614000402.GH3621880@zen.localdomain>
References: <20250605162345.2561026-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605162345.2561026-1-maharmstone@fb.com>

On Thu, Jun 05, 2025 at 05:23:30PM +0100, Mark Harmstone wrote:
> This patch series adds a disk format change gated behind
> CONFIG_BTRFS_EXPERIMENTAL to add a "remap tree", which acts as a layer of
> indirection when doing I/O. When doing relocation, rather than fixing up every
> tree, we instead record the old and new addresses in the remap tree. This should
> hopefully make things more reliable and flexible, as well as enabling some
> future changes we'd like to make, such as larger data extents and reducing
> write amplification by removing cow-only metadata items.
> 
> The remap tree lives in a new REMAP chunk type. This is because bootstrapping
> means that it can't be remapped itself, and has to be relocated by COWing it as
> at present. It can't go in the SYSTEM chunk as we are then limited by the chunk
> item needing to fit in the superblock.
> 
> For more on the design and rationale, please see my RFC sent last month[1], as
> well as Josef Bacik's original design document[2]. The main change from Josef's
> design is that I've added remap backrefs, as we need to be able to move a
> chunk's existing remaps before remapping it.
> 
> You will also need my patches to btrfs-progs[3] to make
> `mkfs.btrfs -O remap-tree` work, as well as allowing `btrfs check` to recognize
> the new format.
> 
> Changes since the RFC:
> 
> * I've reduce the REMAP chunk size from the normal 1GB to 32MB, to match the
>   SYSTEM chunk. For a filesystem with 4KB sectors and 16KB node size, the worst
>   case is that one leaf covers ~1MB of data, and the best case ~250GB. For a
>   chunk, that implies a worst case of ~2GB and a best case of ~500TB.
>   This isn't a disk-format change, so we can always adjust it if it proves too
>   big or small in practice. mkfs creates 8MB chunks, as it does for everything.
> 
> * You can't make new allocations from remapped block groups, so I've changed
>   it so there's no free-space entries for these (thanks to Boris Burkov for the
>   suggestion).
> 
> * The remap tree doesn't have metadata items in the extent tree (thanks to Josef
>   for the suggestion). This was to work around some corruption that delayed refs
>   were causing, but it also fits it with our future plans of removing all
>   metadata items for COW-only trees, reducing write amplification.
>   A knock-on effect of this is that I've had to disable balancing of the remap
>   chunk itself. This is because we can no longer walk the extent tree, and will
>   have to walk the remap tree instead. When we remove the COW-only metadata
>   items, we will also have to do this for the chunk and root trees, as
>   bootstrapping means they can't be remapped.
> 
> * btrfs_translate_remap() uses search_commit_root when doing metadata lookups,
>   to avoid nested locking issues. This also seems to be a lot quicker (btrfs/187
>   went from ~20mins to ~90secs).
> 
> * Unused remapped block groups should now get cleaned up more aggressively
> 
> * Other miscellaneous cleanups and fixes
> 
> Known issues:
> 
> * Relocation still needs to be implemented for the remap tree itself (see above)
> 
> * Some test failures: btrfs/156, btrfs/170, btrfs/226, btrfs/250
> 
> * nodatacow extents aren't safe, as they can race with the relocation thread.
>   We either need to follow the btrfs_inc_nocow_writers() approach, which COWs
>   the extent, or change it so that it blocks here.
> 
> * When initially marking a block group as remapped, we are walking the free-
>   space tree and creating the identity remaps all in one transaction. For the
>   worst-case scenario, i.e. a 1GB block group with every other sector allocated
>   (131,072 extents), this can result in transaction times of more than 10 mins.
>   This needs to be changed to allow this to happen over multiple transactions.
> 
> * All this is disabled for zoned devices for the time being, as I've not been
>   able to test it. I'm planning to make it compatible with zoned at a later
>   date.
> 
> Thanks

This is really great, thanks Mark. I have tried to review the setup
patches some more, as during the RFC I mostly looked at the "remap
copying" stuff.

I still owe you more thorough review on the chunk map bit (looks quite
reasonable to me, though) and the details on the identity remaps going
away.

With that said, some more high level thoughts:

Do you have a design document for the new structures, new invariants,
etc..? This is changing some pretty fundamental assumptions about the
extent tree, free space tree, is introducing double logical mapping,
etc... Whether it is in the patches that introduce the new on disk
stuff, or a separate doc patch, I think it is quite critical. Perhaps
that will primarily live with the progs changes, but I still think some
thorough exposition in these patches will be good.

Reading all the patches, I found myself a bit concerned about the
proliferation of special cases for the remapped case that didn't feel
fully fleshed out or understood. I apologize if they were all carefully
considered, but just going through the code some of them felt thrown in
to not have to worry about it. I feel like that incurs non-trivial tech
debt in the long run and I would really like to avoid it. Each special
case should be thoroughly reasoned and as elegantly "hidden" as
possible, IMO. I understand that this is kind of picky and high-level,
so I also tried to call out the ones where I had a specific reason I felt
they didn't make sense or the code could be improved to make this
complaint as concrete as possible.

Performance numbers like you started sharing in your reply would be great.
In particular, in addition to what you shared, I would like to know:
1. How badly does it beat regular relocation when lots of backrefs are
involved? Jack up the snapshots/reflinks and show the scaling. I
*assume* it should blow the doors off relocation v1 in that case, but I
want to see it :)
2. How bad is the overhead on the remapped reads in the happy case in
practice?

There were concerns (I think from Qu) about this increasing
file fragmentation by breaking up the remapped allocations down to block
size. Should we separate that change out? I think slipping that in as an
incidental side-effect with this is not ideal, as we aren't sure we want
that. I personally kind of think it is neat and makes relocation more
robust, but that's just a hunch.

I'd also love to hear what others view as blockers on moving forward with
this. So far I think we have concerns about:
- new space info
- relocating the remap tree itself being needed for full balances but
  not supported
- potential read perf issues
- increased file fragmentation
- transaction latency issues for the "read all the free space tree holes
  and write out identity remaps" transaction

and maybe some others I'm forgetting. Which are blockers to landing
behind EXPERIMENTAL? Which are blockers for moving from EXPERIMENTAL to
fully legit status? This question is probably more directed at other
reviewers and the development group at large rather than you, Mark.

Thanks again for your excellent work on this patch series, and I
earnestly hope we can all start reaping the benefits of this soon!

Boris

> 
> [1] https://lwn.net/Articles/1021452/
> [2] https://github.com/btrfs/btrfs-todo/issues/54
> [3] https://github.com/maharmstone/btrfs-progs/tree/remap-tree
> 
> Mark Harmstone (12):
>   btrfs: add definitions and constants for remap-tree
>   btrfs: add REMAP chunk type
>   btrfs: allow remapped chunks to have zero stripes
>   btrfs: remove remapped block groups from the free-space tree
>   btrfs: don't add metadata items for the remap tree to the extent tree
>   btrfs: add extended version of struct block_group_item
>   btrfs: allow mounting filesystems with remap-tree incompat flag
>   btrfs: redirect I/O for remapped block groups
>   btrfs: handle deletions from remapped block group
>   btrfs: handle setting up relocation of block group with remap-tree
>   btrfs: move existing remaps before relocating block group
>   btrfs: replace identity maps with actual remaps when doing relocations
> 
>  fs/btrfs/Kconfig                |    2 +
>  fs/btrfs/accessors.h            |   29 +
>  fs/btrfs/block-group.c          |  202 +++-
>  fs/btrfs/block-group.h          |   15 +-
>  fs/btrfs/block-rsv.c            |    8 +
>  fs/btrfs/block-rsv.h            |    1 +
>  fs/btrfs/discard.c              |   11 +-
>  fs/btrfs/disk-io.c              |   91 +-
>  fs/btrfs/extent-tree.c          |  152 ++-
>  fs/btrfs/free-space-tree.c      |    4 +-
>  fs/btrfs/free-space-tree.h      |    5 +-
>  fs/btrfs/fs.h                   |    7 +-
>  fs/btrfs/relocation.c           | 1897 ++++++++++++++++++++++++++++++-
>  fs/btrfs/relocation.h           |    8 +-
>  fs/btrfs/space-info.c           |   22 +-
>  fs/btrfs/sysfs.c                |    4 +
>  fs/btrfs/transaction.c          |    7 +
>  fs/btrfs/tree-checker.c         |   37 +-
>  fs/btrfs/volumes.c              |  115 +-
>  fs/btrfs/volumes.h              |   17 +-
>  include/uapi/linux/btrfs.h      |    1 +
>  include/uapi/linux/btrfs_tree.h |   29 +-
>  22 files changed, 2444 insertions(+), 220 deletions(-)
> 
> -- 
> 2.49.0
> 

