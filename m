Return-Path: <linux-btrfs+bounces-11767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFEAA43E2E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 12:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A1207AB8BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 11:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E392673B8;
	Tue, 25 Feb 2025 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cN6P9Ys/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24FB1E1C2B
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484116; cv=none; b=laaBlD5pEEWMb1KKZ1COh+KnSduyXy2d/B7T6CLHa0IrV9cPU1Yy8QcEtEH00KSKOhtmi9bS+f5wetIzSbT9gNosa2ZJiluTZF2qG95C2Wq6HGriwn2ub5Itvh+KVjUY5mDEHQAmqUBkz2ExzJDycv5jSn7Z4895vr68D85423c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484116; c=relaxed/simple;
	bh=dg+j6TVtWoCNsNvNeH5+ahUoV5RBOkAFuflja1u7u7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5eeRSl4NFM4h108nlwitsHsQPYcXK+Yj5aJ2U1pMrNyHiLWHec1lBL8V+Pt2s1ST7PkeubjSpec6fjIq17lu43viPqoveMB69WiE9QcluaCpmKUj+A9wa4xFMzuLcUuJ2MA+6D5GtZE/6k3fQsSAq1KxMI4SgTtxe4rsuWR3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cN6P9Ys/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e0452f859cso8629536a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 03:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740484112; x=1741088912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeAK+A0Jq0At+HTnrqjorUDu9wQ64nM4Y8Ds7b/XCrw=;
        b=cN6P9Ys/8NrTKWCivmO4rj7zr0IOJcI5NvCRS0PrCoFaAs7VLRLcQM6HNSrte5Kp60
         hMsKbTLiLvCSKn7e6OTfgrT2D/aZe8hPevouJyZPLz1/7EjlRxNGLsUmHvddozqklzn1
         qnEXiEnirXCFWUDIHtYwXWjdoYA/iIfxaDdvztNDKByVLynjiI5KW7r76R8e/hLX6I0G
         psrQ2bgBho/KtWy09Lg/Vy/9gD4YpiLUTT2BXriwr10eY1QqFkLoD7xVn3ZGeHIlxL+r
         CXLPxTuacnCM52pr5+avNpTbny2byhYpOj3eqMKB8OE0TkQGCRVKE9s2ZlR2g5+0AgTM
         A0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484112; x=1741088912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeAK+A0Jq0At+HTnrqjorUDu9wQ64nM4Y8Ds7b/XCrw=;
        b=jEPAgKN3gJAt+2zAcTkTTk+78dE8JembPP9+tW/90y1Bh+kVkWBDGocS6+YBdNrhJq
         tayBoDTR75LczsbIqjrTuCLzJqSRX6xb2X1umNgGmV2kxwKU4VGpyqqQbqH7Cyz6sb9K
         0FLNLmdGP7eWiJe/fzxaFmdgQsR9+qXxCc7fliixV07+DfM4FnwSYFexi96ZkJHOccUA
         mn6hkljsVW+LPmSnKWdmvDRcj5gcbbGJaEfC1y4hzchJe19WmYUW2llgrrfWqaKJsV8S
         u9t48uH42W20DYAi8FJUJ0uRNp2TSCCc/71QucZRkEGvCJj8KrlII3eCkiov9HgdSQZL
         HGPA==
X-Gm-Message-State: AOJu0Yy31tMx0v+X7CVJnDA7lSuthu0S4ygMfpUCmZEcgC6K5G/eQRdW
	sS+cPxs1iNc8f7ejSElbQW3XhSF8rbgdjS3r+aUHJ+yxkzGmz9UY8PWO9XTjPHcngHh6N0Hj+to
	LkxdD4YEA78UcskKlLEpFsxeA2MoxqTKMczoyC1/w6fN+lwNN
X-Gm-Gg: ASbGncvzksqwnFpXRzBFk1cE7CzsPMxkarNaIyCcwNSZv7oZJBa3seJN3hVQlfJd75f
	EeKhGagQo75IXnbrVjeVgA/SI71ZxHAQeEQNvlEfET0blfXgHraqV6KSmHFbyGdqhgBrwyIt9UI
	SO81d0+g==
X-Google-Smtp-Source: AGHT+IFB4hsQOw2hlULYxrtKAR9dInzZVFN6l+ZPJZNyLb7anzN9A5/wB/MRjidlUFfM1V+2ZPQxw/Rv7+OB+RZIF7I=
X-Received: by 2002:a17:906:31c4:b0:abb:b1a4:b0fd with SMTP id
 a640c23a62f3a-abc099eb5c4mr1653855066b.7.1740484112025; Tue, 25 Feb 2025
 03:48:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740427964.git.fdmanana@suse.com> <CAPjX3Fef=7GQxKc1oke5az043i9oea7ryH5W2hfCrKhtKfWCvQ@mail.gmail.com>
 <CAL3q7H5S6A8Ckapb3Wfs4rrNg10XDF-O-GKOc=cQmndbj-uiNA@mail.gmail.com>
In-Reply-To: <CAL3q7H5S6A8Ckapb3Wfs4rrNg10XDF-O-GKOc=cQmndbj-uiNA@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 25 Feb 2025 12:48:21 +0100
X-Gm-Features: AWEUYZmImAU6MYdPlJZGmaeu5QFO6RC0jJJUlpxz_N6gFdrs2Wd1A1jh1wngMEQ
Message-ID: <CAPjX3FfpUrphpL9P7SAr8zNMK=NKorjTyySakHC9abH8KeksLw@mail.gmail.com>
Subject: Re: [PATCH 0/3] btrfs: some fixes around automatic block group reclaim
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Feb 2025 at 12:40, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Tue, Feb 25, 2025 at 11:38=E2=80=AFAM Daniel Vacek <neelx@suse.com> wr=
ote:
> >
> > On Tue, 25 Feb 2025 at 11:58, <fdmanana@kernel.org> wrote:
> > >
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Fix a couple races that should be mostly harmless but trigger KCSAN w=
arnings
> > > and fix the accounting of reclaimed bytes. More details in the change=
 logs.
> > >
> > > Filipe Manana (3):
> > >   btrfs: get zone unusable bytes while holding lock at btrfs_reclaim_=
bgs_work()
> > >   btrfs: get used bytes while holding lock at btrfs_reclaim_bgs_work(=
)
> > >   btrfs: fix reclaimed bytes accounting after automatic block group r=
eclaim
> >
> > I'd say 2 and 3 would better be folded into one patch. The split is a
> > bit confusing.
>
> I find it less confusing, because it's 2 different problems being
> solved and easier to review and reason about.

OK

> >
> > >
> > >  fs/btrfs/block-group.c | 55 ++++++++++++++++++++++++++++++++--------=
--
> > >  1 file changed, 42 insertions(+), 13 deletions(-)
> > >
> > > --
> > > 2.45.2
> > >
> > >

