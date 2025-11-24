Return-Path: <linux-btrfs+bounces-19289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42448C80712
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 13:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E12B6342547
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 12:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7719026F467;
	Mon, 24 Nov 2025 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZboiaoYq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66331E487
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986991; cv=none; b=Ns94yr6aP0TVsQenFvU3m0FN8FWgekFKXmhl1DOCTiEdPChs7TtDBwvscP0cmVzB5rBcI28KkoMExyUGmLd2vU7APRIVYGG+bU4Bb+ya77dVE5B7Ib5EfX6/hq1BrXglJjJ0oJNRXFegSBkrGRkjRYYjaqw45WW4yC7nFisJQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986991; c=relaxed/simple;
	bh=LdH6sF/CGO5qmFYPb/wm0IHdQLpUaIT0ax5m3SHI48I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oky5ouwtKvjjM6aQ1tBmAJ5dJZ7XATrG2jcCjJfBAmgYEJhdBZ71mtwcEnkkXooQj39YsUdR6c0/YbZDPULBxGY8U86MuqEGSZfyB7pDjZrPQs6nCXsShGmGFR6l6H6zOvn4ANFj880ZUqGWg/HTwCEhsJSfL7I8zyZh71ctR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZboiaoYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30792C4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763986991;
	bh=LdH6sF/CGO5qmFYPb/wm0IHdQLpUaIT0ax5m3SHI48I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZboiaoYqh3MGXvLcwNZfoLKydGUWeRspTdjbVGH6OST9nodk03pjzJgjGfw0aJIF1
	 RxukFt2yzFeBnKzuTuCcC7A9Q5XukLVifM7H5XdBrBgmo+wk23IcFAzyEdNrQMEqqU
	 fHKX0XqYkfBNn7Drjn/HNaZgutvUQlNcxE890WiKrjwdjANIr8LoP9GNjMhexvv14N
	 r3fZD0cUsRQASDPSvORYy0pONwFbupghN+AQdUwCrxydtmbg2i+884ll9rks0CgZ0P
	 9gjF4dH5BqCfFpUoo1v0vFt/FfQr8z9QamK12mSN1eQEe2RbC3zjuu2Ts3BhqFS+9W
	 SD0dZJeuhIpLw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso6269175a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:23:11 -0800 (PST)
X-Gm-Message-State: AOJu0YzduFeaUI4/RGx3LZXWpq5XV4jScaiDHBmj3j8t0JTR0EMuDN8j
	KBp5cluGk+FHcJp8yOacCZYbVaGC52GrabICgeQjD8omrnzFqmHu9H8U2RxJ9akhS7BkH3RzlgD
	6/fdDgS5ZuK1G8+gNc9T46Rs1FbBVwNI=
X-Google-Smtp-Source: AGHT+IFeSDTb92A7b7Cq9l089QgNis+tsST2cZUluf4l2EmOkJ0Uy9akyzL75A5YuL6AxxiPiLBJQ53t0gHkoSFQOAo=
X-Received: by 2002:a17:906:c10a:b0:b73:8b7f:8c51 with SMTP id
 a640c23a62f3a-b76718ce2b9mr1224532666b.46.1763986989601; Mon, 24 Nov 2025
 04:23:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763629982.git.wqu@suse.com> <5960f3429b90311423a57beff157494698ab1395.1763629982.git.wqu@suse.com>
 <CAL3q7H6pV-pb6T70aOATXc2VBvA0PJZJcoo+B-SzK48qxzyqbg@mail.gmail.com> <21484358-d1dc-4c03-837a-28bc57c80fe6@suse.com>
In-Reply-To: <21484358-d1dc-4c03-837a-28bc57c80fe6@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 24 Nov 2025 12:22:32 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7Jb5t0uFYk6hJDydNu6DH5rNnPvRKOjfOCVbtqR=mHBg@mail.gmail.com>
X-Gm-Features: AWmQ_bmFgI8GsFKF4-eVd5NjsovLjB-QXhG2hvFNzFDn_ivK_j2zjN-3ECcTvig
Message-ID: <CAL3q7H7Jb5t0uFYk6hJDydNu6DH5rNnPvRKOjfOCVbtqR=mHBg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] btrfs: make sure all ordered extents beyond EOF is
 properly truncated
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 1:14=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/11/21 22:25, Filipe Manana =E5=86=99=E9=81=93:
> [...]
> >> Fixes: f0a0f5bfe04e ("btrfs: truncate ordered extent when skipping wri=
teback past i_size")
> >
> > The commit ID is not stable yet, as that change is not in Linus' tree y=
et.
>
> Thanks for pointing this out. Now it's removed from for-next and will
> resend the series with proper upstream commit during the next merge windo=
w.

Instead of waiting until the next merge window, David may want to
include this in this one, in which case no Fixes tag is needed, just
mention the patch's subject in the change log (that's usually what we
do).
This way it will avoid backports if we want until the next merge
window (for 6.20).

Or may be included in a pull request for one of the 6.19-rcs.

>
> [...]
>
> >> +               u32 cur_len =3D file_offset + len - cur;
> >
> > Please avoid repeating "file_offset + len" so many times. Use a const
> > variable at the top like:
> >
> > const u64 end =3D file_offset + len;
> >
> > Then use 'end' instead.
>
> I intentionally avoided using @end as we have pretty confusing
> inclusive/exclusive behaviors on all @end usages.
>
> A lot of them are inclusive, but also quite some are exclusive.
>
> In fact even inside ordered-data.c, we have different
> inclusive/exclusive usages.
>
> E.g. @end inside btrfs_start_ordered_extent_nowriteback() is inclusive,
> but @range_end inside btrfs_wait_ordered_extents() is exclusive.
>
> It's almost half-half in that file.
>
> Although I can definitely add an @end, I'm not sure if it's improving
> anything, considering it's only utilized twice per loop.

I don't think it's confusing at all in this context.

It may be confusing when there's an end argument, where we may have to
check callers to see how it's computed to find out if it's an
inclusive or exclusive end offset.

Now having the end offset stored in a local variable, it makes it very
easy to see that it's exclusive, especially for such a short function.
I prefer that than open-coding the sum multiple times (3 times in this
function). The compiler generally optimizes and avoids repeating the
sum, but it makes the code easier to read and reason.

>
> Thanks,
> Qu
>

