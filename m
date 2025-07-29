Return-Path: <linux-btrfs+bounces-15739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF2B14BD0
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 11:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F037A30B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 09:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3E52882AC;
	Tue, 29 Jul 2025 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+P9yskP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA301C3C04
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783170; cv=none; b=j7VnowPWXWVTlaiLBi6UmfzjEzKeKyalpenlcDKjSWtcs2KS+OxKmSozbn+Yl1OdoiXfF/lsEUxUpkJqlU15CXG928qAsDQJI55Dp8bPzr2ygNC4LuBzsOrHMm+EkBTY0kkrFmhn9XnBbPTFkreq5h2nJap8whYP/DQr7UpfNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783170; c=relaxed/simple;
	bh=cOXjXLfSr/mUcimHMZy2aVMFrvApxPoU2IQPG6+Mcc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1ZN2+U4sgezegEheHsRR0PZHlyvDoeQ+GX7HnYV0Cp0Dri49Qfi0UmmAro9Yu0UKfm9LUz4QcSVVEfS22GpADUY8hBl9kgIhgyHOwYrQ7J8AeVxzxEd5QPhPqgFwzFCfJLrMetZIhyZ6AFn5YmgCnImdIdZAZez61J0vySIo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+P9yskP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753783167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqj8Ujd8wBLVIc3K9XrJeXggu7XV6BdIFHDBGEMB5qU=;
	b=W+P9yskPZqRdRcAGLOaKomf2izLaD+ZwO/mdjs+8QXqwP01MH8c+ghqOj1es0esSLj8tQ1
	5SNTMTLo4b5ab4hnhMrsd0q975fds0ybKXQ2INRTyQnnrGlWsc3znhMBydUhdYLRhccfAu
	MZHt8AZK3kNmA+4MeQWPukDw2RvZh/Y=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-YoTaKpXcNoSMnyDOjhgS8A-1; Tue, 29 Jul 2025 05:59:25 -0400
X-MC-Unique: YoTaKpXcNoSMnyDOjhgS8A-1
X-Mimecast-MFC-AGG-ID: YoTaKpXcNoSMnyDOjhgS8A_1753783164
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fe98c50daso21538445ad.3
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jul 2025 02:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753783164; x=1754387964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqj8Ujd8wBLVIc3K9XrJeXggu7XV6BdIFHDBGEMB5qU=;
        b=La+96Zr/6977R6ue3sAAhBjUco4O+QAL/f8iSd2hvDLuvXH7JZt/t+EvHMdKOsJK8F
         X7A1t+lR0ZVeZI7mGk1y6n5KzVLAbGBpreFb2R1FXFJe9fkbfShvkKRv3YgcjcAw6rsq
         1HKAdp4ErUVvfdLPVGonBTISZqEmRDi+J9/8X6VT0HR/JxOAsweZ0SSfBNCj7nXNKqAN
         /nBC/YbvqkZVtuYwQIcNUjF7XtYkwYP+Y4i2XzgJsY1QJRDgx2KOVOZ12E4oMz+Xmdl7
         aCjOE3j2a4DZP/jak58g6u3+u8QFi8zXSJrCRQQyaxh9xfTkPS++ptlyLiPbfdLszQtW
         e1sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY69csz67A7wZfQY0XcabHNs+5/MeYlVqSetbVCID7AQKQHQkYNR3FNk94K8vHcNwI6jWNeRoI7bT4cA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7MsSqs7aKrpUCN02t2NgR1LKyhJK/gpBCOLZhnAIC08kd50f
	IeLKvwB7sm3mcNjBk9pObczZQAp1jLrPidZELAWXGN9k2ATQOuw2yh+0/aWs1/J6/3eeiD1Wink
	Qj+CnFJHdFO34BYcYouq+iW2HommPash4HnAlossrA50+9cgWYNFtVL9AEfmgcAErorvT2PYkjQ
	iPgCg3l5aAl0fYvxE0wlEC6yrTuyTMbouFVs/lmiRqx4U9fRkvDw==
X-Gm-Gg: ASbGncssy3OR4ivGQNe6wG4a5WWXyJf3ZwRSJss2p4Bm1wZnVGtx+iM+hIcl7Cicxdr
	EIiTSvYIB7PGy0tcgTdf/NpS5MCUBWyu1nsjR1ptaTKFHR0MT+CZDswUrQDgN1ZAJ6QKvonFmg2
	wDxR8b+P/QeHiox5RPGps=
X-Received: by 2002:a17:902:c78c:b0:23f:f39b:eae8 with SMTP id d9443c01a7336-23ff39bee2amr97334015ad.19.1753783164346;
        Tue, 29 Jul 2025 02:59:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmZHSAibdb582TD8nqJVUGUQuhShICGIa5kRBKSOOwZF7PRRK+HPAndieJXuut/fnr8fX9zVKPd9QH/eioL8c=
X-Received: by 2002:a17:902:c78c:b0:23f:f39b:eae8 with SMTP id
 d9443c01a7336-23ff39bee2amr97333805ad.19.1753783164022; Tue, 29 Jul 2025
 02:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749557686.git.dsterba@suse.com> <3b3190a56dfabfeb0632fc131648567b84fcb04f.1749557686.git.dsterba@suse.com>
In-Reply-To: <3b3190a56dfabfeb0632fc131648567b84fcb04f.1749557686.git.dsterba@suse.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 29 Jul 2025 11:59:12 +0200
X-Gm-Features: Ac12FXzqoxIG5M-sHBi5MOURgs3194pH9ojVlHoiexthT5kl3iOvYBLa6HdAWCI
Message-ID: <CAHc6FU4gyR-mqBbzuxm4cWzmGqwMtD68KeD66YRtMMwZMvfBOQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] btrfs: add helper folio_end()
To: David Sterba <dsterba@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, Jul 29, 2025 at 11:44=E2=80=AFAM David Sterba <dsterba@suse.com> wr=
ote:
> There are several cases of folio_pos + folio_size, add a convenience
> helper for that. This is a local helper and not proposed as folio API
> because it does not seem to be heavily used elsewhere:
>
> A quick grep (folio_size + folio_end) in fs/ shows
>
>      24 btrfs
>       4 iomap
>       4 ext4
>       2 xfs
>       2 netfs
>       1 gfs2
>       1 f2fs
>       1 bcachefs
>       1 buffer.c

we now have a folio_end() helper in btrfs and a folio_end_pos() helper
in bcachefs, so people obviously keep reinventing the same thing.
Could this please be turned into a proper common helper?

I guess Willy will have a preferred function name.

Thanks,
Andreas

> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/misc.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> index 9cc292402696..ff5eac84d819 100644
> --- a/fs/btrfs/misc.h
> +++ b/fs/btrfs/misc.h
> @@ -7,6 +7,8 @@
>  #include <linux/bitmap.h>
>  #include <linux/sched.h>
>  #include <linux/wait.h>
> +#include <linux/mm.h>
> +#include <linux/pagemap.h>
>  #include <linux/math64.h>
>  #include <linux/rbtree.h>
>
> @@ -158,4 +160,9 @@ static inline bool bitmap_test_range_all_zero(const u=
nsigned long *addr,
>         return (found_set =3D=3D start + nbits);
>  }
>
> +static inline u64 folio_end(struct folio *folio)
> +{
> +       return folio_pos(folio) + folio_size(folio);
> +}
> +
>  #endif
> --
> 2.47.1
>


