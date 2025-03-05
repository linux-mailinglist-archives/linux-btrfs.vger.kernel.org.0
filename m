Return-Path: <linux-btrfs+bounces-12013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB4A4F7CC
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 08:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4929188E977
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 07:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EAA1EB9EB;
	Wed,  5 Mar 2025 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P/q8Ntel"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1074A18FDB1
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159293; cv=none; b=lGmS9n54PrhI02q7v/ceiS12WhUsEZ/RAPVmufAuEBqWzCbtjP96Eh4OndiPf2Sa0o2LQ6m9pGQKtrvxWYq0XOb5enfycFfXclSXRDqDfr9Wl6xNJWjyBoXQIZ2W8y/NPv2oSnRqwahNYlkZd0kX3uFazJb2m6NQPrJOaqYJw9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159293; c=relaxed/simple;
	bh=FWiVbgrVSDx7efTDRnApyDcSfeAwaYu37v9yc/EX6jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUP0QeragrtoVXukxbpxb9t2KQWVK2qYThN+esQjta+Fg1cchE9s/lHq5LUsBlqnRZJShRmsgHUuaehPCsISskXHX4SsrLyYTx/UUArNtxBALOz+3AdJw3wMIXFY5GeBGMHFOoAPhdBSK6eIZeNQlhKhzkPp6DjYx6K1bjllBhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P/q8Ntel; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e535d16180so4568308a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Mar 2025 23:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741159289; x=1741764089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n7E2iIxbquV5DEhVAqL/jOB6AynE5bJgRlahEKaSwEo=;
        b=P/q8NtelURS2Zi3uRe8BgP3C0gYZXu/mb1udx8hPpRQ/VLRSEMrTKmwjd+W+Jtnz2M
         wLV/9oVDrcc8DNjdsNOLHo4L26Y2y2UQrroGIEPX3bP0ijznzilLOP8KmHn4UR1vdaTZ
         ODkcTTM5OnpUky2F1acXTLYb4yxiDAy2lGC96KUauPQEwk6YVImf29B0VRq99f8M8olt
         5KMSL8PW5ddxsVI+PllEd7GoTAVUL2XYJ4PSIw7LRcykMC+jJbwI2uiaW6SrfsDnG/0N
         1jcBQk+NFK3X5cOZ50JDCVDqYoGv2ben3873F6aVLyMuCpJerSKwEGa/7QJ/pHKmJrQ1
         ArSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741159289; x=1741764089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7E2iIxbquV5DEhVAqL/jOB6AynE5bJgRlahEKaSwEo=;
        b=GxTauBFidr/nUe0xA0DCj+00IcA52sfl4ZS0s4CO3MXzlnYbVdywTWZGXxQXYFyTNV
         CiYoT27BhfVmOETAVYPEvJwTsU65W96K7ekSN4HQUYeRQWaFi1cF7KEFKRt2IzlHyH33
         BQyI4nH1LaOyweVFhnCq5gwSwfj8eLt8v8ii9N4v2b/UQj23EtN3mGgFJ45Bwr41mlUT
         5LxRuMCiDX41GuZzIA2N4ybFE0obwziMh7BIBBBxKqVxc8W7OJCpRnB1TnZfU8+HRaCY
         g1fEuqIbAw2suDiYc5Yud0XCb7xvo1m7WdziNciqO4JONZ7YtyN/5J06TnTvqeq0uQdV
         ZiKg==
X-Forwarded-Encrypted: i=1; AJvYcCVXKtgckmgoVH9RpgK1I4fJ/qkpPCiSAJb9dOFH3tWytmYRkHR9jCObh3gSgh7p1EEP79mZGBp/Qg8D8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh44prRWGy18+HOPjdwqce9fX5QKZVm3NnMiO+cB6+/AMnOnKK
	ikseJ8yDfPLuf+NDp7GMyPrWpkiOh+oir4O4WmMtxRbNXZvmr3gQpg33LyixyZ6c/VT5pEby9fW
	kr2bRJ51HiLTc0UHWKz1ZnSAEZW26S1bGGuRBiw==
X-Gm-Gg: ASbGncsph3poRu23wA68/Ir9BwGIHu1vjPxc4OHbVa5ZjNT5E9n5Rb6P1SmOKvg/0t+
	sAQtABc/e18lqxxfOFdkGSl7mtD8K3xhJgSyTIoax8VfFnq8Tn7HuVcVqTbFv9UATrbFm9XcVw3
	pSEfF5/gdIjEtvFtx6exYbwQ8Z
X-Google-Smtp-Source: AGHT+IHuApDPVDRFRbrTPuLSdVBnC7FHJHTSc8gozyAwKc2e8pXdXmijruollANCPFDROEIL6rBLbccCqt4VOclfcG0=
X-Received: by 2002:a05:6402:2351:b0:5e4:af36:2315 with SMTP id
 4fb4d7f45d1cf-5e59f3d4a3dmr5029582a12.12.1741159289212; Tue, 04 Mar 2025
 23:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304171403.571335-1-neelx@suse.com> <bc3446ce-347f-41da-9255-233e2e08f91c@gmx.com>
 <CAPjX3FcZ6TJZnHNf3sm00F49BVsDzQaZr5fJHMXRUXne3gLZ2w@mail.gmail.com> <20250305070521.GZ5777@suse.cz>
In-Reply-To: <20250305070521.GZ5777@suse.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Mar 2025 08:21:18 +0100
X-Gm-Features: AQ5f1Jrjsdd5CDdoZsEd_DpUb66xQjOsH_XPes7FPtkCWeHTerUTjPR-8XsLj1M
Message-ID: <CAPjX3Fe-_vcVvkMvmgaVCoVU3kAXVH84rN=_77NpMUMSYw3G7A@mail.gmail.com>
Subject: Re: [PATCH] btrfs/defrag: implement compression levels
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 08:05, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Mar 05, 2025 at 08:02:28AM +0100, Daniel Vacek wrote:
> > > > @@ -1376,10 +1377,19 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
> > > >               return -EINVAL;
> > > >
> > > >       if (do_compress) {
> > > > -             if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> > > > -                     return -EINVAL;
> > > > -             if (range->compress_type)
> > > > -                     compress_type = range->compress_type;
> > > > +             if (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL) {
> > > > +                     if (range->compress.type >= BTRFS_NR_COMPRESS_TYPES)
> > > > +                             return -EINVAL;
> > > > +                     if (range->compress.type) {
> > > > +                             compress_type = range->compress.type;
> > > > +                             compress_level= range->compress.level;
> > > > +                     }
> > >
> > > I am not familiar with the compress level, but
> > > btrfs_compress_set_level() does extra clamping, maybe we also want to do
> > > that too?
> >
> > This is intentionally left to be limited later. There's no need to do
> > it at this point and the code is simpler. It's also compression
> > type/method agnostic.
>
> This is input parameter validation so we should not postpone it until
> the whole process starts. The complexity can be wrapped in helpers, we
> already have that for various purposes like
> compression_decompress_bio().

OK, that makes sense. I'll add the check in v2.

Thaks guys.

