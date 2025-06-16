Return-Path: <linux-btrfs+bounces-14670-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB84ADB75D
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jun 2025 18:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86E517AB455
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jun 2025 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC7285CAC;
	Mon, 16 Jun 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="iDkpJGzn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I/DGLtBb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C01A5BB7
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 16:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750092568; cv=none; b=sP9Oxdqse1RVExPZWq8FdaCV2RGDxQElajeyFv1CQX+gXoGtAGnwfGLdKhZROF2JKk79JOEp257AYtDstSSdDk7P3Q+fx+vAtbGugePkLiK24hbsd3YtrNLqtiwrRfNZ//+FJl3QSOeGQZ2ZUEMKAlY9JNiou+jFZtIOe6qVRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750092568; c=relaxed/simple;
	bh=MvWPFm8HyBpEhoO7nFI1rQm0gFj2Nm2pal32YKJWF6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcHPfimHGC4CLW0IP7k9NQC06Qj93eOc7Qap/rc7HkYDvftDreHFhCBXjVvzFU68GEiPrepsWfyF+JD/HqQ0YoAZ0ZxgJA8bIe5nkXPO3EURsdwsXkYQ9QVjkgoLG0JyJlRaM20ok3jWmYOW63WkjaFTBWtO2NmZ1VErWdX4K24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=iDkpJGzn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I/DGLtBb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6799E1380397;
	Mon, 16 Jun 2025 12:49:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 16 Jun 2025 12:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1750092565;
	 x=1750178965; bh=d9fdKrMrr0EA6B7mRd/j+DNW+aLIQY1QssealNnmzHE=; b=
	iDkpJGznrgtfkSFea2UtHJhtZHAC/gSifrj03Q2eQZQV0uFFTfJ0/3OA5CaJBXC1
	1j2cVy31haVXYKF5TSY7mgIsSN3HJAD94zdm81tP5Pha+Kd+c8X4FwWP2Tp/3iI9
	GQqIHPGH7QiM0YiBkPq2r1a/9JyGdLbwHVyYbhsmf6XtwOJgNztnB0/HBc13uLYL
	X8l6XqzP4wD0/yL/cE0ijkBEYk4DJX7A4TxmX4Uig8YzcleMGzOqH2wiY3DX/Ooj
	GbdGp+lmqjchysQBsOVcO8kRO/O+33Kj8EkQj3rE9RVXnmKFPsxSSpmvHeCN4yXR
	+TsRIIz56hsC3M2+WBqQVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750092565; x=
	1750178965; bh=d9fdKrMrr0EA6B7mRd/j+DNW+aLIQY1QssealNnmzHE=; b=I
	/DGLtBbVDrCtrX03fXF83o6SfTTIoM/obto5VG/2uHhToz7nYYnISijdOFUzQAfA
	B4/U3YAqMFfO0SpSmn7C0FO1tqx+7R1I5fpLcMOvZJS/EJWSxCeme40H3d+F4b2o
	+45Yx5QQMJ7GmwK+hmDFgA0doWOkmabBIJZk18hjUgqOo1wpZy1NgYHXb+uiS+bA
	yLNypyrSvOfd6kgxdLWaCTjtBps31WYt3HxC4VjZREZ70342abnXxzLVsOWOvWkb
	qLM0NZ2ErXte+IbQVtTLL+g7QEQxz6843kR6yq9r4VUFZHYXyHn8oonHRUDZFz38
	fIlfuqHbCxZc6DcMiBb5Q==
X-ME-Sender: <xms:FUtQaPcDDMyU64EoJDvvUDnlb0fzKatpDwSBgw-Or-v5JJzFYHKdEQ>
    <xme:FUtQaFO2V87qV2Ole6-oXzlQPwuwQg9SPzP1TpkiGf5yDNuVwcLFUZ12lToP0IETi
    agUnM2BIkJxkX0fLvs>
X-ME-Received: <xmr:FUtQaIiLC68XWFaVSqEiPLTntNlmRrLJvStrEDYXu4g0edlTiuBZ6s0D2VWmil3eSupKsOaVC2_8D-sa8-bXeNUaeTI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvjedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpedulefhtdfhteduvdethfeftdeitdethedvtdekvdeltddv
    veegtdeuuddtiedtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FUtQaA8Fir1ren2rbwo_FLoBn14XZ_K0osTRVRxa1DuqeKmWcHS-kg>
    <xmx:FUtQaLtlZ5zh4WL_0EwioflcGBlH_sWIM0Fn6a05XeleZgkHG_Walw>
    <xmx:FUtQaPHutvCg2nr7GYPgrLrQXVCXF7I1ejhpGr0xkutKRFrLmpo8rw>
    <xmx:FUtQaCPUWY874Om4HYZq_ytUNuh9eWe81Qkx3xlHQaiPClibEMFvWA>
    <xmx:FUtQaM4KS-AgylzMLY_M9aj2xINi2dNVCbD7ipxEmtMIy5Pr_ATwpgMB>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Jun 2025 12:49:24 -0400 (EDT)
Date: Mon, 16 Jun 2025 09:49:00 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: check BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE at
 __add_block_group_free_space()
Message-ID: <20250616164900.GA838931@zen.localdomain>
References: <cover.1749421865.git.fdmanana@suse.com>
 <40dd299a0b7551fb8163da00a6ed716a8f8c3d46.1749421865.git.fdmanana@suse.com>
 <20250616154458.GA812359@zen.localdomain>
 <CAL3q7H6Ojtu5zYuSVyZ+NrWhhPyYEKdrX4d4d3W6BVcfmKi1rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6Ojtu5zYuSVyZ+NrWhhPyYEKdrX4d4d3W6BVcfmKi1rQ@mail.gmail.com>

On Mon, Jun 16, 2025 at 04:48:34PM +0100, Filipe Manana wrote:
> On Mon, Jun 16, 2025 at 4:45 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Sun, Jun 08, 2025 at 11:43:34PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Every caller of __add_block_group_free_space() is checking if the flag
> > > BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE is set before calling it. This is
> > > duplicate code and it's prone to some mistake in case we add more callers
> > > in the future. So move the check for that flag into the start of
> > > __add_block_group_free_space().
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  fs/btrfs/free-space-tree.c | 58 ++++++++++++++++++--------------------
> > >  1 file changed, 28 insertions(+), 30 deletions(-)
> > >
> > > diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> > > index af005fb4b676..f03f3610b713 100644
> > > --- a/fs/btrfs/free-space-tree.c
> > > +++ b/fs/btrfs/free-space-tree.c
> > > @@ -816,11 +816,9 @@ int __remove_from_free_space_tree(struct btrfs_trans_handle *trans,
> > >       u32 flags;
> > >       int ret;
> > >
> > > -     if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags)) {
> > > -             ret = __add_block_group_free_space(trans, block_group, path);
> > > -             if (ret)
> > > -                     return ret;
> > > -     }
> > > +     ret = __add_block_group_free_space(trans, block_group, path);
> > > +     if (ret)
> > > +             return ret;
> > >
> > >       info = search_free_space_info(NULL, block_group, path, 0);
> > >       if (IS_ERR(info))
> > > @@ -1011,11 +1009,9 @@ int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
> > >       u32 flags;
> > >       int ret;
> > >
> > > -     if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags)) {
> > > -             ret = __add_block_group_free_space(trans, block_group, path);
> > > -             if (ret)
> > > -                     return ret;
> > > -     }
> > > +     ret = __add_block_group_free_space(trans, block_group, path);
> > > +     if (ret)
> > > +             return ret;
> > >
> > >       info = search_free_space_info(NULL, block_group, path, 0);
> > >       if (IS_ERR(info))
> > > @@ -1403,9 +1399,12 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
> > >                                       struct btrfs_block_group *block_group,
> > >                                       struct btrfs_path *path)
> > >  {
> > > +     bool own_path = false;
> > >       int ret;
> > >
> > > -     clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags);
> > > +     if (!test_and_clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
> > > +                             &block_group->runtime_flags))
> > > +             return 0;
> > >
> > >       /*
> > >        * While rebuilding the free space tree we may allocate new metadata
> > > @@ -1430,10 +1429,19 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
> > >        */
> > >       set_bit(BLOCK_GROUP_FLAG_FREE_SPACE_ADDED, &block_group->runtime_flags);
> > >
> > > +     if (!path) {
> > > +             path = btrfs_alloc_path();
> > > +             if (!path) {
> > > +                     btrfs_abort_transaction(trans, -ENOMEM);
> > > +                     return -ENOMEM;
> > > +             }
> > > +             own_path = true;
> > > +     }
> > > +
> >
> > Is the "own_path" change intended to be bundled with this one? If so,
> > can you mention it in the commit message as well?
> 
> Yes it's supposed, why wouldn't it?
> This is because the path allocation from add_block_group_free_space()
> has to be gone and done in this function now if it receives a NULL
> path.
> 
> I would think this is obvious since the diff for
> add_block_group_free_space() removes the path allocation.

That totally makes sense. All I'm asking for is a
"Since add_block_group_free_space() conditionally allocated the path
based on the check, move that allocation into
__add_block_group_free_space() as well" in the commit message.

(or whatever equivalent you like)

> 
> Thanks.
> 
> >
> > >       ret = add_new_free_space_info(trans, block_group, path);
> > >       if (ret) {
> > >               btrfs_abort_transaction(trans, ret);
> > > -             return ret;
> > > +             goto out;
> > >       }
> > >
> > >       ret = __add_to_free_space_tree(trans, block_group, path,
> > > @@ -1441,33 +1449,23 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
> > >       if (ret)
> > >               btrfs_abort_transaction(trans, ret);
> > >
> > > -     return 0;
> > > +out:
> > > +     if (own_path)
> > > +             btrfs_free_path(path);
> > > +
> > > +     return ret;
> > >  }
> > >
> > >  int add_block_group_free_space(struct btrfs_trans_handle *trans,
> > >                              struct btrfs_block_group *block_group)
> > >  {
> > > -     struct btrfs_fs_info *fs_info = trans->fs_info;
> > > -     struct btrfs_path *path = NULL;
> > > -     int ret = 0;
> > > +     int ret;
> > >
> > > -     if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
> > > +     if (!btrfs_fs_compat_ro(trans->fs_info, FREE_SPACE_TREE))
> > >               return 0;
> > >
> > >       mutex_lock(&block_group->free_space_lock);
> > > -     if (!test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags))
> > > -             goto out;
> > > -
> > > -     path = btrfs_alloc_path();
> > > -     if (!path) {
> > > -             ret = -ENOMEM;
> > > -             btrfs_abort_transaction(trans, ret);
> > > -             goto out;
> > > -     }
> > > -
> > > -     ret = __add_block_group_free_space(trans, block_group, path);
> > > -out:
> > > -     btrfs_free_path(path);
> > > +     ret = __add_block_group_free_space(trans, block_group, NULL);
> > >       mutex_unlock(&block_group->free_space_lock);
> > >       return ret;
> > >  }
> > > --
> > > 2.47.2
> > >

