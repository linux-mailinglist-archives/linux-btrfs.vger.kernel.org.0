Return-Path: <linux-btrfs+bounces-3999-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AEA89A991
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 09:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB9C1F2253E
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Apr 2024 07:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7C922616;
	Sat,  6 Apr 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6h2hmAL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9986CA50
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Apr 2024 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712388688; cv=none; b=lxCXIqHliezZyz/UV20WO1Eoj+0XXNL42XAp6DhUSTiFugnTq8y48JomsIhM5tGVMd2IlibVT3lKHWSukxB94/QsYfkUqRUWRnt4fCK2+i0bFCGM3hQE0oYRCPskYm+nDb/7ISY0P6KrGKkaetfdYlEu+04XG1DwR9DGCg3ASEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712388688; c=relaxed/simple;
	bh=7VHEoAZjxMG7+uqk+dZT1doljW3dnljre2RhI2SoOiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LKiYpw5ZdDIFQiSHuPZCPyqSMYRwcU8zOSE6jSCGRAX2kfMGgS3bfguRTb4VwnUIip5uS6AyiUsbua9zzl6J1Gz3LtricR+Kz+V/NLcbFhFHyDmqcJ4sJ57xJbLRbSBzqFNEO1A/7j98BMZnRlIHRMfYqpwIuFhZBu9mJfshycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6h2hmAL; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-432ffed0423so14087851cf.1
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Apr 2024 00:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712388685; x=1712993485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VHEoAZjxMG7+uqk+dZT1doljW3dnljre2RhI2SoOiw=;
        b=E6h2hmALM0TPQXEL0Jw61L75FMdV/oJl5TYGzZChQDrqONZz5iQbWdF6bt/HFfL3PP
         m/MmSKy0flW2Di88Rdoou7AvSJx1cT5q0mbo+8t9afjUz4UPnoXrcKsElwPRynRXD584
         4nOsjpqmTgEeOfiYlbFVDxMNuoI2ytYy3tAMdfDjROe7hM4d0a3SZfiWyZOU0ByUCp/S
         SHXtuOLcSqPoG9UacOQAdGvn/oPykE6bVmEwwL8J6YxEkulhxWuFBTZQ1rJLdG2fxCVy
         N8jB0ITQp98XXmGCdAtjY9EGJ8y41jrDCoNpDgVfbGhApcxQlasZyTvOwnU8HVqMpeNd
         8jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712388685; x=1712993485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VHEoAZjxMG7+uqk+dZT1doljW3dnljre2RhI2SoOiw=;
        b=qBnm2iWv6us1sUk3P4Cwj98+64r/xXet2NyKLNYw85FJNBCBBG0I18G7I0qMdOJbp7
         AhQIO+MfD+IOZWsDar9FaoQF6BRWzrjunjBi3/VLyEemwj82yusOdpsbpuV++5IECCML
         wlnGcP0NrLzsAsbDQjTxBc4VNa/XZtalR29mrTl0nSdXBipaJGbyUpnlz6lnu3n9iaxv
         s3i43k2L9ctBQQZqr3IRKxzhqg682sPEq+RKfzaNJOvbcpuuBg04DAtqDs491Y/5z0/S
         DeFJwrh3arGUoI7lhetTdCUOirb+1gFaWmqoDnc4wWz9CGUhT5Kmnt2AcGsV5nRSs7l5
         fdsw==
X-Gm-Message-State: AOJu0Yx/dl1il7dS5PGK7YooLyj3q3V+zBdPSGjN/cpNYnazkE6/Lers
	IIRST4S9z3O6MLOxi7g1ug6gDNhBb5tfu5QV6gYSGAQ/gW/4V95RHUEjDj7rBHoDyJjpkOo9jHQ
	WQvI4vOQj3z/Aom++4Aw9QXot5cc=
X-Google-Smtp-Source: AGHT+IEhkNgb6sIOI6SupoJeiDVKXEyzT5lRwFeCfDp2JGHgml/Ibfwuw3xEQC3SNeHkQzs77rfM3rKPC8JtfRFWSsU=
X-Received: by 2002:a05:622a:138e:b0:434:4e8d:4362 with SMTP id
 o14-20020a05622a138e00b004344e8d4362mr3885642qtk.33.1712388685419; Sat, 06
 Apr 2024 00:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGRSmLtrH7GNzAE2o69qvfEMk9mTR1a=zUq36dzwkCeQTz7F8A@mail.gmail.com>
 <f1e7424c-64a8-4752-8a36-fa08f902ce7b@gmx.com>
In-Reply-To: <f1e7424c-64a8-4752-8a36-fa08f902ce7b@gmx.com>
From: "David F." <df7729@gmail.com>
Date: Sat, 6 Apr 2024 00:31:14 -0700
Message-ID: <CAGRSmLuKoYmxVJ+w=Bb2RxXUi6Z79mU+yLmxhc_OfWtmkhFg8Q@mail.gmail.com>
Subject: Re: Preconfigured BTRFS Virtual Drives for testing?
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

How can I set up btrfs so that the chunk_tree, extent_tree, and root
of roots all exist with all 8 levels (0-7) in use (or say I only want
4 levels)?

I just need it on a single drive, a .vhdx, .vmdk, .vdi type file would
make it easy to grab and test.

Thanks.

On Fri, Apr 5, 2024 at 8:47=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/4/6 12:04, David F. =E5=86=99=E9=81=93:
> > Hello,
> >
> > I wonder if there are preconfigured BTRFS virtual hard drives setup
> > with all the various conditions BTRFS metadata can be in (leaf only,
> > max nodes, new format, full drive, etc..) for testing purposes?
>
> It's not possible, due to zoned support.
>
> A virtual disk image can not easily tell a VM to emulate a zoned device
> for it.
>
> For features other than zoned, you can mostly specify the feature at
> mkfs time.
>
> That's how we handle it for fstests.
>
> Thanks,
> Qu
> >
> > If so, where can they be downloaded?
> >
> > Thanks.
> >

