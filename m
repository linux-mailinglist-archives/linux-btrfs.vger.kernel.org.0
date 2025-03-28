Return-Path: <linux-btrfs+bounces-12644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B27A74AA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 14:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3AB3B4DDD
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 13:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD43921ADC6;
	Fri, 28 Mar 2025 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="IhCRt9/k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267C821ABD4
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743168477; cv=none; b=NYuWTMQb+D0xfj84cmB9NcYzFR0OKyJbWmRatHKJKgK5azDUyjIHb3g1blpMZ4vx3WwhAwMlfkfEqUcWjri5lGL67oUPaWbb7XDcfZ6EbgO6yKaNA/cUqaWC0W30//oWvmU/ehkn0TiC9IB3XVdRhZYNSZ+n9+ckZ7oUyDNohcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743168477; c=relaxed/simple;
	bh=R8twSQhZiqufLbFYX49Zm/LxlnHUOrmz1Cx0DgHNgCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB8GmkHVtutZACS9dVIsMQTjN6IOilJKSRhDy3/bj+xoM3xTSdECOTSK32hio6apyyTCYEmAb5salnMmHtd1ZrrPVyZkvTTpKaDTa2eriP8I3kNpliXnzRO6zqSYQwEy9d7AGHiOp22xvNr8NGO6te6I5GpXyM6LX64mRZODVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=IhCRt9/k; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e643f234e08so1744251276.0
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Mar 2025 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1743168474; x=1743773274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ME+FzMk+g0nSNd/Sqk1FMg3lQrjjQV/C81Bv7PfU3bE=;
        b=IhCRt9/keMB5zudnPeK3vHesvLlRfa+Jd1+aGVIBIBM8DhbvwO+/R5W1N0t2nEVL+G
         Q9QdONTlAjl58MOyqoxhrgtvQqtlPvr+fzdOLyZs/niNQF+pQBubghcoKBTZR/Xov4JP
         RQNO/vOWEM+nvW5mCUqVD8Rm5L0WdEyc7nHZfWqfjeR6NfEwNeYSVFtJQk7tqfZJgr5A
         iuL8DUUz7VNF5qmQUrGmYiVTzE9nu7YJTEw4Z2lYBdfiO32CBVwSzIHdbW+s66OLH5qb
         9kO6hKvKFQViKALoc31mzBpQZveeOBlbUv0o6bLb5COuQdwScvV6tmrX6gN9ZI7tFsdg
         vdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743168474; x=1743773274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ME+FzMk+g0nSNd/Sqk1FMg3lQrjjQV/C81Bv7PfU3bE=;
        b=tbsD41+8bxPG/NAkzWqtC/AsiORNtkMw2BANoCgTVjujtqzONTTBLA7vgjlo7jW69b
         yheEwipxZHOI3q1WoJRSv6L/aYWcdqyBJ04Skt4z8XY3TBszF29xLeAkKzlKPI4GPvZY
         AA59J7GbgWkXWvvFuAfDHKpQMFNN5MOG/dqTkSW5Bwfa0Rubi4NnVG9F8mbxO6eKZAiN
         CIui3xvIgcXs3ADItLdqKpQKGYyYra924tuQ2eqUu91mwDJs8hViE9G1YmyIJ1qRIwuR
         WsTdakV8h50hnUgVLEkPFCAjHRfiR3yCNDipFy9BN4+woS3CdZV6k4M30fdXSzm6yLfv
         bilg==
X-Gm-Message-State: AOJu0YzPqjm0YUKTvyl9nKe0+7epo3cF9v9Ge2+kRuYFKqv3aHoHPbEQ
	FE8rr3RAiLY0Q6PIz4x966tIh4Y0Khlg8JNfbz5MH0KQmz7+mn0rjwkjQI27ePqgh6PNlKUu4RG
	q
X-Gm-Gg: ASbGncvkohIzXzPnz+kvCpAmnQ+3ABRyGdPMWG684BDl+172SU+hzZm42uew/9PJCAY
	IMSFw4ZZ6u9qHWkS+Gen/f8THncMoOE85IbZrnaRzR4hDZwGKYd9uNoXGi7XBNOf6elTYkhUfNk
	nS1yUlZncOx8hRjxPsC/EfVzLXGQr8kb6JZQvKH2Z2FrWxwyEYkdpPj5CzpS5aQhlAkT2yV2grj
	Y69UhOF6jmvsu3S5xxlzwPqNEBcNp13PO02fnG52942GEt98xT5Zo8XWT+81OWaNNCUQIb1vEL5
	Pjczk+dMOgJLORbnVhUK3UPZAi/Rs8xD3wZR1247Cfa/mqLKbgJFTA5j1vHMKEYGlRdtZHgyRjl
	qTGpy1g==
X-Google-Smtp-Source: AGHT+IHzkEX0O2SPVBpzBNliCBYfuOuooKZVkSBlRBJV6h4rJePk6fjYqvKgT96g7Ym0yNK1f1f7IA==
X-Received: by 2002:a05:6902:161e:b0:e69:1efc:997b with SMTP id 3f1490d57ef6-e694355108amr9717207276.14.1743168473787;
        Fri, 28 Mar 2025 06:27:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e6b711b752asm543910276.8.2025.03.28.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 06:27:52 -0700 (PDT)
Date: Fri, 28 Mar 2025 09:27:51 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs updates for 6.15
Message-ID: <20250328132751.GA1379678@perftesting>
References: <cover.1742834133.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1742834133.git.dsterba@suse.com>

On Mon, Mar 24, 2025 at 05:37:51PM +0100, David Sterba wrote:
> Hi,
> 
> please pull the following btrfs updates, thanks.
> 
> User visible changes:
> 
> - fall back to buffered write if direct io is done on a file that requires
>   checksums

<trimming the everybody linux-btrfs from the cc list>

What?  We use this constantly in a bunch of places to avoid page cache overhead,
it's perfectly legitimate to do DIO to a file that requires checksums.  Does the
vm case mess this up?  Absolutely, but that's why we say use NOCOW for that
case.  We've always had this behavior, we've always been clear that if you break
it you buy it.  This is a huge regression for a pretty significant use case.
Thanks,

Josef

