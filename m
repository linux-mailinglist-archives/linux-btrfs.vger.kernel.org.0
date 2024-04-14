Return-Path: <linux-btrfs+bounces-4238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B708A41CF
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 12:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88078B21218
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 10:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9C92D04E;
	Sun, 14 Apr 2024 10:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnwtsPhu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3852C684
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713090176; cv=none; b=FKlHo6HgFWx1VEtLSAlHkBFyKJd5o2auzRVo7Sq/K6Qk/3qNa1xjtMy0IlUCU4K5pzq6tjnztkF/yxhf0GM/tkxtQwQAF1AsZXPBK0MW8hAC+CdkHhmrdsX/k3Q3I5Mzjtgxl7qogEgjrCjZ37aW6jwaMbbqKnkhRXzfPxDgHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713090176; c=relaxed/simple;
	bh=7b1zWZ8zURs32fpV1K+a9oiL6ABz1S3QHpM41P7g0UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YarSITC8B5JvifXDp/tfSzUGvNyDBYCorvJZaUNLiBGVlofIstBiA1/dVJDXRKNliUnuIPkxcpV+hTqkvaI2fb7bBmQLycaijlalWhVwO+gquGO1fNAF8PGyxDcbVYhSVw9UmPoVenXccH/sJr8wY+QaBqOJbp96ArklNe2ru1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnwtsPhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D95C32781
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 10:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713090176;
	bh=7b1zWZ8zURs32fpV1K+a9oiL6ABz1S3QHpM41P7g0UA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VnwtsPhuJSb2eswqqqTCDapN3BMFHuQzyDBZvcXpUU9VIDORhSMhEu+/JbEosuLnt
	 1zguCwgHc3ArPtPhDE2CpagT4fQeO1GsTDuvwLINBILxae48nCQgknYvT7Gkor4S2C
	 CqeItrqDBkOmXaHsSG6jRx3DyIp3BZfYhBsz+5Gc6Ah2d1o/Tuj9xziLDS7PmQ5Avj
	 ucQ4maO2C2/qiSE6pG88YGsyu1Ljj0GHVQqzWU4wtLCx7tphSc752Tje1LSzehV4mW
	 UAYsda4tm7ofduJzvJKqLLRmULutVpxG6gQFctb8tgHF9Ro9/U2/6A0YoF1u9TJRVZ
	 JAZFsifya1sAQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4702457ccbso273351266b.3
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Apr 2024 03:22:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YwR5Lod5cOR+vXs26rHyFWQR+myS/cDhDOpKb3iygsGh5lZAM0n
	fCh2wIcHzm072iTcJtXBYcMp8PTLUMXFMzmM7+yuxajK8u4duWCHmV7PwlAyVQHHsmp9IJ0k6Jy
	hlNJ1o0+FINRZYBVgRdPn/LnX4UQ=
X-Google-Smtp-Source: AGHT+IH9aoy4kAy/zQkCJRgI9IRKy8c3CvDv35UUU3UL2+4QPEnahT/TXJi6FPIWSVIDlNuFV0KJW3qQk8l56wa6svM=
X-Received: by 2002:a17:906:f148:b0:a52:14b3:480c with SMTP id
 gw8-20020a170906f14800b00a5214b3480cmr5036308ejb.76.1713090174752; Sun, 14
 Apr 2024 03:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5062a746cf151bfbc217c00e149740956e748abb.1713073723.git.josef@toxicpanda.com>
In-Reply-To: <5062a746cf151bfbc217c00e149740956e748abb.1713073723.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 14 Apr 2024 11:22:17 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4si0_KhB+iXMJr-CvH6etyKmxG3LBAHpoaHQdMM62PTA@mail.gmail.com>
Message-ID: <CAL3q7H4si0_KhB+iXMJr-CvH6etyKmxG3LBAHpoaHQdMM62PTA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: set start on clone before calling copy_extent_buffer_full
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 6:50=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Our subpage testing started hanging on generic/560 and I bisected it
> down to Fixes: 1cab1375ba6d ("btrfs: reuse cloned extent buffer during

The "Fixes:" should be here, seems like a copy paste mistake from the
bottom of the change log.

> fiemap to avoid re-allocations").  This is subtle because we use
> eb->start to figure out where in the folio we're copying to when we're
> subpage, as our ->start may refer to an area inside of the folio.

Where is that exactly? Is it at get_eb_offset_in_folio()? If it's that
I don't see why it's subpage specific.
Can you mention where exactly in the change log?

>
> We were copying with ->start set to the previous value, and then
> re-setting ->start in order to be used later on by fiemap.  However this
> changed the offset into the eb that we would read from, which would

I don't understand this part that says: "we would read from".
We would read what and where? Are you saying we need to read from the
destination eb during copy_full_extent_buffer()?
Where is that?

Does this only affect copy_extent_buffer_full()? Doesn't it affect
copy_extent_buffer() too? If not, why?
Can you please give all these details in the changelog?

> cause us to not emit EOF sometimes for fiemap.  Thanks to a bug in the
> duperemove that the CI vms are using this manifested as a hung test.
>
> Fix this by setting start before we co copy_extent_buffer_full to make
> sure that we're copying into the same offset inside of the folio that we
> will read from later.
>
> With this fix we now pass generic/560 on our subpage tests.
>
> Fixes: 1cab1375ba6d ("btrfs: reuse cloned extent buffer during fiemap toa=
void re-allocations")

Missing a space at "toavoid", in the commit's subject there's actually a sp=
ace.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent_io.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 49f7161a6578..a3d0befaa461 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2809,13 +2809,17 @@ static int fiemap_next_leaf_item(struct btrfs_ino=
de *inode, struct btrfs_path *p
>                 goto out;
>         }
>
> -       /* See the comment at fiemap_search_slot() about why we clone. */
> -       copy_extent_buffer_full(clone, path->nodes[0]);
>         /*
>          * Important to preserve the start field, for the optimizations w=
hen
>          * checking if extents are shared (see extent_fiemap()).
> +        *
> +        * Additionally it needs to be set before we call
> +        * copy_extent_buffer_full because for subpagesize we need to mak=
e sure

Can we get the () in front of the function name, so that it's
consistent with the rest of the comment (paragraph above)?

> +        * we have the correctly calculated offset.
>          */
>         clone->start =3D path->nodes[0]->start;
> +       /* See the comment at fiemap_search_slot() about why we clone. */
> +       copy_extent_buffer_full(clone, path->nodes[0]);

Ok so this is a landmine and I doubt people will remember to do this
when using copy_extent_buffer_full() in the future.
If this is really needed, why not do that at copy_extent_buffer_full()
itself? This would be more future proof.

Why wouldn't we need this in other places that use
copy_extent_buffer_full() too?

For example in the tree log code where we use a dummy eb and we don't
update the eb's ->start because we don't care about it. Why is it not
a problem there? Or you missed it?

Or another example at btrfs_copy_root(). where we can't obviously set
the destination eb's ->start to that of the source eb. Why don't we
run into any problem there?

I'm puzzled at why we need to this ->start update only in this place,
why the ->start of the destination eb of copy_extent_buffer_full() is
used or why it causes a problem, why is it subpage specific

Thanks.


>
>         slot =3D path->slots[0];
>         btrfs_release_path(path);
> --
> 2.43.0
>
>

