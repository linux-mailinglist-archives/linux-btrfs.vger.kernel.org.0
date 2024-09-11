Return-Path: <linux-btrfs+bounces-7925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C74974C20
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 10:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C775E1C25CB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 08:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02BA155CAC;
	Wed, 11 Sep 2024 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGBxi17R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA826143878
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 08:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041902; cv=none; b=o9bFfH4n8nABO3RTnlzb5dszwtTqakS2XmiwZ7hhhRj2DsyrP/5Vx09YCorK2NIP5AvzBgJKBDV1+hB6Asc3PupJIiz9IHj8zkjVCkWSiwyJWkNHBjn/0zPNgdO1S7/9Xh6cpaPoduTlk19HDHiS7YuNEXXbp9KKrESLZ7QM3e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041902; c=relaxed/simple;
	bh=p0iYE82CxglUZJYhWZ9jp5U6il1rswYiYVzHSHBL42U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jxlWyCBeAu3nj+5SwG/IOew7kDcjqeZ8m1zQobWDMOKeDaPyi9dsfPPIik35DTPZmt2LE2qeO4UK8w7XXC1ncno1lJbxYYDTuyOXrhGpj0oExc+l96wJVydjl8dqBROEcVPdP/W5g1Pe/0ylA2WAYiR9kGp8YxdRKtCVcpp1Xd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGBxi17R; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5365a9574b6so7509162e87.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 01:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726041899; x=1726646699; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCL6cHpln/7MFqCmS5CDdWwEdQ8ojvnZNQU/PNcJ1rA=;
        b=WGBxi17RuDitUJpAb7gwV6xs2+fw6XAr08MYShROfyBZb+J4c/xsYsdrcBdKece7zy
         +EjdNKji529NihyxQo3/lbD3wGTEEIGI5PHMONS9ujLdt1PYmyHXuIZ/fqFm9fL/00JY
         z/dbnhzDZjOhGiKdMf4hn3vC40OpnKRnu2cTEAd/UkQ7D69/fiJfYbqMzxB6Lq3GPXOo
         /gyY2zcpO1B3zfIqeAD18Ial0fiD1LqG6aVNr5OO5pA1b/F85Cav/l0meA829/nXY0v5
         wqNFUNsom4Uy+bDqRdELodwkdoPkxQBsZyaeC3yGEmM7gBIApMNpjWJgtxa4/JLtuCjt
         jNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041899; x=1726646699;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCL6cHpln/7MFqCmS5CDdWwEdQ8ojvnZNQU/PNcJ1rA=;
        b=dd0V+zAzmcUySlIxmLI1yMsnJRgYl4upMBW321GhiMWb+PZobYwDcwaPUviGxBW4Dj
         Uy5uoYeQNgzeZdXPEi5ADM5Fj5KP6Cfs6cEDno2KoVkYvOw3Gerc0k4hZP7GX+z6ydAi
         wjXmv8dxdqYW6CPCG2uOV6IZUAANkSb5Kt3rYo1mWguG6ZcYnQhY5XHfIApFh7cSWDew
         Fzz79z+xNnLXTMPg4pTGwqu9aLdm4K4bM4JosVQvZ/HRxgvHdedlfGGh0pu8xn7jmTep
         5NZKfBvYVuAvfyHRAH4l0w6lrii0nTDdEg10ov0NLUuhKGiM6fKlqvEuBh6Jya9dcCyr
         LSlA==
X-Gm-Message-State: AOJu0Yw8mymIpyIH9ZqsDAwTGLsdkhXMlioPdyc7yNHAIm+N+QoKoc+z
	Dcetppzy9mp/APGuaV3NvbKLWzPnD7tN+TbBG4x3i5PEs3FcdrmK+AEN6GwqPqCGilqBlvFRH6V
	qy3md2ct2w0z23G4zyCISe8Rwm0Jobg==
X-Google-Smtp-Source: AGHT+IHQu0FzLm4kK5mTppyDHSa/a4HxQbUvhtwwkxC3PEi0wcbukAWeZmRh1hjV6IpMA9tMDUZe+l5tuBwcmLvAHsg=
X-Received: by 2002:a05:6512:108e:b0:52c:76ac:329b with SMTP id
 2adb3069b0e04-536587db757mr15989510e87.35.1726041897810; Wed, 11 Sep 2024
 01:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b9b86b32095ba924fb8c7eec4d8ec024113d9ff4.camel@beware.dropbear.id.au>
 <5fdb905b-20ee-4978-ba81-10b1fc4ac475@gmx.com> <20240911080004.GA218002@tik.uni-stuttgart.de>
In-Reply-To: <20240911080004.GA218002@tik.uni-stuttgart.de>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Wed, 11 Sep 2024 11:04:46 +0300
Message-ID: <CAA91j0UsEziD9PWxrWMfTxHuQH6YqcRi8DrQrWOX1YNG8Xx15A@mail.gmail.com>
Subject: Re: Btrfs balance broke filesystem
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 11:00=E2=80=AFAM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
>
> On Sun 2024-09-01 (19:15), Qu Wenruo wrote:
>
> > Convert/balance is only recommended if you have unallocated space (show=
n
> > in `btrfs fi show`) to fulfill at least a metadata block group (1G in
> > size for most cases).
>
> How can I detect this "unallocated space"?
> I have eg:
>
> root@fex:# btrfs fi show /
> Label: 'U22'  uuid: 3a37b060-8d05-402a-83b9-16690588a070
>         Total devices 1 FS bytes used 11.91GiB
>         devid    1 size 64.00GiB used 15.07GiB path /dev/sdd1
>

So, you have almost 40GiB of unallocated space on this device.

