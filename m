Return-Path: <linux-btrfs+bounces-13833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C44DAAFBD2
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 15:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AA91BA381F
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6885022D4D7;
	Thu,  8 May 2025 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOrOE4tf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C5E227BA1
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711854; cv=none; b=gaBt/hNBW69mxy5sqpGCY1LbZOXfDwhatBfrU9f04gTwCVPA702kXwZCpnbLQwUDQmsNLIMI02dzi37eQwootVK3Q8mejvjt4xGXxkjqp5D5GF6KNMuHWno9Y9w1IuirDfnDts+oVewBOFZYR2Qs8gqarWL8xiSkGbgfDqzqm/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711854; c=relaxed/simple;
	bh=d8QD3ia31Kk0wlZb0jzrX1iSlZu/VosIag4xpr+RQfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKcXnmoGPWnwQo5i8SbDZkVWOWC1Am0kVUm1Qend3myYy2X4n71wYDp9pc4d9DA4W8QgmQVwpXU5WP/+al3xCTAIX1HPH+m/J5ZjrS4v328tzBgylhWNDeZ0yxkeZYk0FHuKmkCIN+iaIpbJh+QuqyNSs8AyVfcV4dVwad89nWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOrOE4tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CA4C4CEE9
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 13:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746711854;
	bh=d8QD3ia31Kk0wlZb0jzrX1iSlZu/VosIag4xpr+RQfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EOrOE4tfBdmSkrD6zuY7ZEC826AMhijKODFKaqcAB7HAin4zcgW/ZptUryxBdYnEW
	 gCJL52UNSfa2DA7KiHduPXmfOeL4kXCgexzjCimMn8WFCuKSlubx3Y1l5Vq3uypurI
	 qp/BA2MtsRIZEoLBSpkdMqYPDE1uVs4fONa7BW4klCkiyW0oSln7FkiKioPRkdY7KH
	 9t2r45qV3IKt7lh8A6e6v3FW7uQmMn19VEovtku9VY1UqDE5osHJI+mOE6PVscWI+q
	 GBYY1VaL6zonUZAl0a8hsmhj+frvLdlqug7rnwfkUzhQrOcmZx63dd8rAo+he5itxs
	 W7Lw6GEKu7Fsg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so190778666b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 08 May 2025 06:44:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNuOR8UYUwKmb137a6uYUTXIqu6mAkW0k3xN86roxUcb5fdo/TzLP8qVYPigVOayfmWeS+GKILVHQ80A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxeVZJNpw/uknlaE9wonGs5r6VhmF/6Po8WAN5qknIqe759u0T7
	m2uVyFPIwOYIcB/SMI3s1zrX9tmAVbIEmYkG34+u2xCygzsciwAegks2kH1Qt1X1wLc2QMzxRvE
	uR1aIEciJ8JqqsuRxwE+kF59iin0=
X-Google-Smtp-Source: AGHT+IFRJzolL7r2B/BxkCVDD8RwQ7WhHj+m1Pq/qm5mXvt/+rUgNzcyLRX4z1Tak61ug+GRH0wfvQAbyFa6NGLOD18=
X-Received: by 2002:a17:907:7fa7:b0:ac2:88d5:770b with SMTP id
 a640c23a62f3a-ad1e8c91ed4mr819343366b.25.1746711852742; Thu, 08 May 2025
 06:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746638347.git.fdmanana@suse.com> <b2b4a73fb7ef395f131884cd5c903cbf92517e6f.1746638347.git.fdmanana@suse.com>
 <20250507223347.GB332956@zen.localdomain> <ccacb32f-e345-49c7-9c6b-8bdc72c69a7f@suse.com>
In-Reply-To: <ccacb32f-e345-49c7-9c6b-8bdc72c69a7f@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 8 May 2025 14:43:36 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4YWzsCTsSC=oup6_typt_PdNVAdAuK1RVhuH1nEto-eQ@mail.gmail.com>
X-Gm-Features: ATxdqUGIPpzVbG63uiWYTEceTlTzA_JtQCCiMJOlpYw4zc3sYnvkXFfUI2AKYAA
Message-ID: <CAL3q7H4YWzsCTsSC=oup6_typt_PdNVAdAuK1RVhuH1nEto-eQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] btrfs: fix qgroup reservation leak on failure to
 allocate ordered extent
To: Qu Wenruo <wqu@suse.com>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 12:12=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/5/8 08:03, Boris Burkov =E5=86=99=E9=81=93:
> > On Wed, May 07, 2025 at 06:23:13PM +0100, fdmanana@kernel.org wrote:
> >> From: Filipe Manana <fdmanana@suse.com>
> >>
> >> If we fail to allocate an ordered extent for a COW write we end up lea=
king
> >> a qgroup data reservation since we called btrfs_qgroup_release_data() =
but
> >> we didn't call btrfs_qgroup_free_refroot() (which would happen when
> >> running the respective data delayed ref created by ordered extent
> >> completion or when finishing the ordered extent in case an error happe=
ned).
> >>
> >> So make sure we call btrfs_qgroup_free_refroot() if we fail to allocat=
e an
> >> ordered extent for a COW write.
> >
> > I haven't tried it myself yet, but I believe that this patch will doubl=
e
> > free reservation from the qgroup when this case occurs.
> >
> > Can you share the context where you saw this bug? Have you run fstests
> > with qgroups or squotas enabled? I think this should show pretty quickl=
y
> > in generic/475 with qgroups on.
> >
> > Consider, for example, the following execution of the dio case:
> >
> > btrfs_dio_iomap_begin
> >    btrfs_check_data_free_space // reserves the data into `reserved`, se=
ts dio_data->data_space_reserved
> >    btrfs_get_blocks_direct_write
> >      btrfs_create_dio_extent
> >        btrfs_alloc_ordered_extent
> >          alloc_ordered_extent // fails and frees refroot, reserved is "=
wrong" now.
> >        // error propagates up
> >      // error propagates up via PTR_ERR
> >
> > which brings us to the code:
> > if (ret < 0)
> >          goto unlock_err;
> > ...
> > unlock_err:
> > ...
> > if (dio_data->data_space_reserved) {
> >          btrfs_free_reserved_data_space()
> > }
> >
> > so the execution continues...
> >
> > btrfs_free_reserved_data_space
> >    btrfs_qgroup_free_data
> >      __btrfs_qgroup_release_data
> >        qgroup_free_reserved_data
> >          btrfs_qgroup_free_refroot
> >
> > This will result in a underflow of the reservation once everything
> > outstanding gets released.
>
> That should still be safe.
>
> Firstly at alloc_ordered_extent() we released the qgroup space already,
> thus there will be no EXTENT_QGROUP_RESERVED range in extent-io tree
> anymore.
>
> Then at the final cleanup, qgroup_free_reserved_data_space() will
> release/free nothing, because the extent-io tree no longer has the
> corresponding range with EXTENT_QGROUP_RESERVED.
>
> This is the core design of qgroup data reserved space, which allows us
> to call btrfs_release/free_data() twice without double accounting.
>
> >
> > Furthermore, raw calls to free_refroot in cases where we have a reserve=
d
> > changeset make me worried, because they will run afoul of races with
> > multiple threads touching the various bits. I don't see the bugs here,
> > but the reservation lifetime is really tricky so I wouldn't be surprise=
d
> > if something like that was wrong too.
>
> This free_refroot() is the common practice here. The extent-io tree
> based accounting can only cover the reserved space before ordered extent
> is allocated.
>
> Then the reserved space is "transferred" to ordered extent, and
> eventually go to the new data extent, and finally freed at
> btrfs_qgroup_account_extents(), which also goes the free_refroot() way.
>
> >
> > As of the last time I looked at this, I think cow_file_range handles
> > this correctly as well. Looking really quickly now, it looks like maybe
> > submit_one_async_extent() might not do a qgroup free, but I'm not sure
> > where the corresponding reservation is coming from.
> >
> > I think if you have indeed found a different codepath that makes a data
> > reservation but doesn't release the qgroup part when allocating the
> > ordered extent fails, then the fastest path to a fix is to do that at
> > the same level as where it calls btrfs_check_data_free_space or (howeve=
r
> > it gets the reservation), as is currently done by the main
> > ordered_extent allocation paths. With async_extent, we might need to
> > plumb through the reserved extent changeset through the async chunk to
> > do it perfectly...
>
> I agree with you that, the extent io tree based double freeing
> prevention should only be the last safe net, not something we should
> abuse when possible.
>
> But I can't find a better solution, mostly due to the fact that after
> the btrfs_qgroup_release_data() call, the qgroup reserved space is
> already released, and we have no way to undo that...
>
> Maybe we can delayed the qgroup release/free calls until the ordered
> extent @entry is allocated?

At some point I considered allocating first the ordered extent and
then doing the qgroup free/release calls, and that would fix the leak
too.
At the moment it seemed more clear to me the way I did, but if
everyone prefers that other way I'm fine with it and will change it.

Thanks.


>
> Thanks,
> Qu
>
>
> >
> > Thanks,
> > Boris
> >
> >>
> >> Fixes: 7dbeaad0af7d ("btrfs: change timing for qgroup reserved space f=
or ordered extents to fix reserved space leak")
> >> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >> ---
> >>   fs/btrfs/ordered-data.c | 12 +++++++++---
> >>   1 file changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> >> index ae49f87b27e8..e44d3dd17caf 100644
> >> --- a/fs/btrfs/ordered-data.c
> >> +++ b/fs/btrfs/ordered-data.c
> >> @@ -153,9 +153,10 @@ static struct btrfs_ordered_extent *alloc_ordered=
_extent(
> >>      struct btrfs_ordered_extent *entry;
> >>      int ret;
> >>      u64 qgroup_rsv =3D 0;
> >> +    const bool is_nocow =3D (flags &
> >> +           ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALL=
OC)));
> >>
> >> -    if (flags &
> >> -        ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)=
)) {
> >> +    if (is_nocow) {
> >>              /* For nocow write, we can release the qgroup rsv right n=
ow */
> >>              ret =3D btrfs_qgroup_free_data(inode, NULL, file_offset, =
num_bytes, &qgroup_rsv);
> >>              if (ret < 0)
> >> @@ -170,8 +171,13 @@ static struct btrfs_ordered_extent *alloc_ordered=
_extent(
> >>                      return ERR_PTR(ret);
> >>      }
> >>      entry =3D kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS)=
;
> >> -    if (!entry)
> >> +    if (!entry) {
> >> +            if (!is_nocow)
> >> +                    btrfs_qgroup_free_refroot(inode->root->fs_info,
> >> +                                              btrfs_root_id(inode->ro=
ot),
> >> +                                              qgroup_rsv, BTRFS_QGROU=
P_RSV_DATA);
> >>              return ERR_PTR(-ENOMEM);
> >> +    }
> >>
> >>      entry->file_offset =3D file_offset;
> >>      entry->num_bytes =3D num_bytes;
> >> --
> >> 2.47.2
> >>
> >
>

