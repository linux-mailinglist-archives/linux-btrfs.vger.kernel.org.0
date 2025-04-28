Return-Path: <linux-btrfs+bounces-13455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC77A9E627
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 04:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17778189BAD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 02:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1464165F1A;
	Mon, 28 Apr 2025 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzZ2aWVN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B813AC1;
	Mon, 28 Apr 2025 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745806465; cv=none; b=uDo4tWDdGRkXNIbCukJSnTu8swdYxSJGsUcnPIW9hxOLZRQbGoJkoQBuNumd9hE7SDRCBEQTDScMoUGIdIQXIv1+R2voVKHLEnUhP0gEsW7mT34rMqaxKw2OZ6J05oHYlhWYyvaHRSCo2AGY9QVlG3y8QtOHmDvBF8pd9sG7L30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745806465; c=relaxed/simple;
	bh=hWIa3pYS2MhlFME8LNN/Sw/meR4rq/DXnNiOz65h0xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUP7sSCXqXcNHl9LSSz4GpwgigNS0UTULKp3z4la049mcKNBt4QekYByU2jFEXkFLA7VPgoyNkjeMpQbdCvYhdltnh2EspewQfgU0S+tJmjkyDBDAToodkqefuOpMMUH1MLXnVLL5tYY9LZV7kwv3BD6cEdoGBaQ2v/WSvFaf4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzZ2aWVN; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so35550621fa.2;
        Sun, 27 Apr 2025 19:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745806461; x=1746411261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6L7mReCEPPU3SVcDk4HNDfLPe55YhTxKj7HSojarmXE=;
        b=KzZ2aWVNmzx6wQxBBWaYfntZsbQu5G6kh0phAbxIigzdY8lE6mDpOOatPpODdsX94G
         Up2MRrt0GkQcP8/thq+JGfCuVKLVwdQerNJihrn1FODNIpxZNKpxInQCWudURolBSFtM
         /+O9Uv+vXsiAQF/OQvX7PTev+QpEGuLpMnCDerjaNY+GSyjs5l8WPNut1lc32YNuaW94
         8sPkdwArwqgkJ36uhTpVfVk3orJFYhQ4PDGyp+VM5y9S6AdIc6TvrNMnZYTk7xEo+f46
         PgrduVcQDVx0TUUP5Z+se5Bldn5bk82RWgWoq7dBMFB5WzWhzDfshipCsNKtKJa8vBqD
         PyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745806461; x=1746411261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6L7mReCEPPU3SVcDk4HNDfLPe55YhTxKj7HSojarmXE=;
        b=e/Cfbnz+V1enYylo8Fgq4PJvrjIpSFoUwJIC+PRcgh3LaAddPbnCxzCvv8/Hdfjru2
         gCkT384VK02m3ez12gbKjRlpKHt4k89+rlkAB4s4TuUocNNarHxfDqPVbKOt8gPDtirP
         VmzZCOsQVvb2uRsTI9sOUCvs9+M0X9wfcJUcJ37s7NqynonyvyutiH3vQVY4gv6KpIng
         Tzrjo9S1btVZRTBHAZH5cCR5PR9NHJDm5W0NZjAKe1dIfNogLk+1BZmcGsIoD8OVP0Tf
         k4qfRpohwMjd6DYdgLg+gd/bEVfnsh9HzdbZJdHz2QsO3ai8Liy19FKAriya70gBEKuR
         UwsA==
X-Forwarded-Encrypted: i=1; AJvYcCUjj4nB2ZiY6hdLoqJBTq3kkqKrMy+ptfSX0PXoYpJC8HE9bVg2EBGeYVOmszsLvNlCsOh8dtxOyuKihSZm@vger.kernel.org, AJvYcCUm8LtNRc+8+EiQCc5Qvf81tPrKJelyi3HlA2gsQSV7qonP2AoutzXECmHRh4gKNK738uqkKKttow61Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35vjuLaysq8uDYWsYv32Z/sOXSsbQJ1KEuIxx5K6fVgSGmy/0
	kHf0XFugV/aFxrgCA5Wfxy5MnHwne5682QnRl5DIbbk1IPbkKiY4BCcug/6p43u/vdP6xOJQGTc
	8NPkgO3bwSINWsYhCRoTwsEY4tkE=
X-Gm-Gg: ASbGncvXBZ84Mt7394Wnuya+ku4ChOGSQyBRJYpX0ETANDgqPrcK+KLVZ61hltD7ahP
	fYb+hwmZtsqryaozXZvGNJMoCCiiDSAoJjF01h0cTquKKFFOY/QXQvlYVQa+SZIBYVxHgnWwsuc
	gbNNpQD4lRgMbFYB0UJffbqA==
X-Google-Smtp-Source: AGHT+IFqG9IvL4DdVin/erLTT+mbKNl7H+n8o92o8qsmXMKCS3wOobNfOjdFUutakNI3AHxLZMz1lW/P8kipZLZf9Qg=
X-Received: by 2002:a05:651c:1465:b0:30b:d05a:c103 with SMTP id
 38308e7fff4ca-31907be7ee1mr36751781fa.29.1745806460856; Sun, 27 Apr 2025
 19:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427185908.90450-1-ryncsn@gmail.com> <20250427185908.90450-3-ryncsn@gmail.com>
 <30968c68-7ec2-4185-9b48-f8335dc2e0b0@gmx.com>
In-Reply-To: <30968c68-7ec2-4185-9b48-f8335dc2e0b0@gmx.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 28 Apr 2025 10:14:03 +0800
X-Gm-Features: ATxdqUE43AwjPoI39IyPOxqKFyZI2qqvwM-fZ2nBNpIE4zuv8EfJ6_f8pPBi_4M
Message-ID: <CAMgjq7CGhkgfOhCEEBKrto82jPVzwHib6skVwnnwJbMExEh5xw@mail.gmail.com>
Subject: Re: [PATCH 2/6] btrfs: drop usage of folio_index
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 8:55=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/4/28 04:29, Kairui Song =E5=86=99=E9=81=93:
> > From: Kairui Song <kasong@tencent.com>
> >
> > folio_index is only needed for mixed usage of page cache and swap
> > cache, for pure page cache usage, the caller can just use
> > folio->index instead.
>
> The patch looks good to me, but I'm afraid the next commit message is
> not accurate.
>
> >
> > It can't be a swap cache folio here.  Swap mapping may only call into f=
s
> > through `swap_rw` and that is not supported for btrfs.  So just drop it
> > and use folio->index instead.
>

Thanks for the review.

> Btrfs supports swap file, it's just not through the swap_rw() callback.

Right, I just meant btrfs is not using `swap_rw`. Of course it
supports swap files. Let me update the commit message a bit to clarify
that.

>
> In this particular case, the folio belongs to the metadata (btree)
> inode, thus it will never be swap cache folio.
>
> With that changed, it looks good to me.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks,
> Qu
>
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Cc: Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM)
> > Cc: Josef Bacik <josef@toxicpanda.com> (maintainer:BTRFS FILE SYSTEM)
> > Cc: David Sterba <dsterba@suse.com> (maintainer:BTRFS FILE SYSTEM)
> > Cc: linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >   fs/btrfs/extent_io.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 197f5e51c474..e08b50504d13 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -3509,7 +3509,7 @@ static void btree_clear_folio_dirty_tag(struct fo=
lio *folio)
> >       xa_lock_irq(&folio->mapping->i_pages);
> >       if (!folio_test_dirty(folio))
> >               __xa_clear_mark(&folio->mapping->i_pages,
> > -                             folio_index(folio), PAGECACHE_TAG_DIRTY);
> > +                             folio->index, PAGECACHE_TAG_DIRTY);
> >       xa_unlock_irq(&folio->mapping->i_pages);
> >   }
> >
>
>

