Return-Path: <linux-btrfs+bounces-19433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 351EEC97C60
	for <lists+linux-btrfs@lfdr.de>; Mon, 01 Dec 2025 15:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C053A332B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Dec 2025 14:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1D43191A2;
	Mon,  1 Dec 2025 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="UaeQTlTO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3130ACF1
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Dec 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598203; cv=none; b=KcUnNH9ytap5oEJnq4twIsty5k+JuwPZZM+mNGJLwbcflNnA3CWDAbHoYTHNdijyydXi7d8M6Ct6SxtcXylakZfAJmFGq2T2dKWi6SabHlUFr021AXKvYNY57GQpGn+ApqgEPMV26gpru9gP3HASenGr2eH7cLYZbMuOPDM70FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598203; c=relaxed/simple;
	bh=9N2Br49cfTTo33IutbTBwA0nRKCP3MxmMyD3p/hCdrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwGO6oE6evnoah3uHxg+kORcwnfZR7hEyjzbJTAofdS+lSN/J5ALNRzVXOBQ8y5+mn0tvoinohGeQduSYgc3zWPS93no+2EoOHKiADq3a5v5AQV3FZCexKppMXyCigZKSWn4M0QoQ1EVmOvC7bdgEUu9++Hqdhh8uftazE9Cw2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com; spf=pass smtp.mailfrom=lucidpixels.com; dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b=UaeQTlTO; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucidpixels.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3e8f418e051so2318483fac.3
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Dec 2025 06:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1764598201; x=1765203001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N2Br49cfTTo33IutbTBwA0nRKCP3MxmMyD3p/hCdrk=;
        b=UaeQTlTOOpE9UetgBbE1UWF5Pl4tK1TjAcI4ng88cBx8yWE9+VBpkAzAeGs7BQAmcZ
         on2xVCVYnh61WC4UxZJO11i1FZy59PEc6NJ4iugKlq1sQjfEsTrGMR2mTMDWU/xbSVAO
         Mqd1Bokim5Z8DLpmni2I/QOnPdZxVzyq6mcVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764598201; x=1765203001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9N2Br49cfTTo33IutbTBwA0nRKCP3MxmMyD3p/hCdrk=;
        b=tjZKgamGMSF3y2sY5jwQ0I9aAE6fXJoltShuaPiol0rMXweP4U5jfoeg2UKGI3H5fy
         OXHWujPo/ByxI7Hu1zwKal5lBQzyaWTNFNK5M5OGqkboT/+CgZO9xcslyf9d2gIA6qtA
         fQcgycOTmHUrpYXgLmCOd8M0ZKk4fmTKM7Z9GW5+sqk/QOnyhUI43OPRJlwm51C5IKiT
         DUbKnmEzvJi78oijKwLkLhgELwZyxVSg7ub/mIz/+30ZH1mPdsXrP0O3maRMJcMH6fZ4
         D8n0E/qLZie8sZh1D27rfyL64LWw/mgET+sntjpOzDtgFryTeqTGvXzLeTH5Wv4fvham
         WAog==
X-Forwarded-Encrypted: i=1; AJvYcCXsLRSJnmbjLyFEFdSb6DHEMvuF/JvfpKCYkWZ65lgy37mbJYsdj5tbJ52JshbmHB3Z9tmFmYv3wQZu/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVTN7tOpNWhXDI7+o6lWmMZZRnVb7nP0VdmPVNP0S/D2q59rRe
	14Oy+jLPnh+UjbaczRDqUWPgDHOL5hHkW5ZF/RBo9tWehYpe6Wd2HuSaAAH0+ZBP7Ff0Hn81ZPK
	Eid2Tt0SjZ7MFXxbkeBm+vHqkJaSoCKsK/GTNpf6dJw==
X-Gm-Gg: ASbGncvQAj4yIt7ncvoIes4rLfZRR38zOQ7HTbApTmNsOnfN/Vjfier6z2oCPexA8dU
	YOA3vYkcpOd3sQ9zLs6d1wZr0MCuen0yaWpbrq9UP4jxNdPcofi1zVJimXqd1fYQsznLGEgo9zP
	u5GgfX3uICMwqX6dEOWZ80YdyT0Y0jNZ72mfMXPI0i62V/x+7sOWozAMr8scXTt450NWBHfzU38
	DiqNTTNTdeuTtFwEzIk40NOLxxGp6ruTr3VVQSJy08O5ab9YOGM9HM1lz103KZh2Hp5JqCDHPDQ
	Txlw0osyhSsjueOlHg6ow11l+Yb0hvom0ENE8ySkeBTn0ghJvZ5/Ee2Hs99mjUs=
X-Google-Smtp-Source: AGHT+IFRUfgSsf/TJkHeANSH4dfp2CZgqrYY4eMQAE8vHEGMie1cY6/g5n24t2kOWvlcuoH0jVrzNRVVuINc92eyik0=
X-Received: by 2002:a05:6808:67c6:b0:43f:2464:ee55 with SMTP id
 5614622812f47-451128f91d5mr15599176b6e.20.1764598201100; Mon, 01 Dec 2025
 06:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <aSXBwBoBZp9t890U@gallifrey>
In-Reply-To: <aSXBwBoBZp9t890U@gallifrey>
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 1 Dec 2025 09:09:50 -0500
X-Gm-Features: AWmQ_bm5--99g4Aj2GUCOOkdASboV31CU7h7n5xreYibAeG3yoF9MLp3qxHFWQE
Message-ID: <CAO9zADyCd_rDa3WEYCU1tw2pNv6PxdJdDkPuJwM437Wv3CRYNg@mail.gmail.com>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-raid@vger.kernel.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 9:48=E2=80=AFAM Dr. David Alan Gilbert
<linux@treblig.org> wrote:
>
> * Justin Piszcz (jpiszcz@lucidpixels.com) wrote:
> > Hello,
> >
> > Issue/Summary:
> > 1. Usually once a month, a random WD Red SN700 4TB NVME drive will
> > drop out of a NAS array, after power cycling the device, it rebuilds
> > successfully.
> >
> > Questions:
>
> > 3. Are there any debug options that can be enabled that could help to
> > pinpoint the root cause?
>
> Have you tried using the 'nvme' command to see if the drives have
> anything in their smart or error logs?

Thanks, I did check on this and ran the usual tests, everything passed
- as part of this thread it was mentioned that some consumer NVME
drives have these issues:
https://github.com/openzfs/zfs/discussions/14793

For those using an multiple NVME drives with BTRFS/ZFS, are there
known good NVME drives that will work and not have this consistent
timeout issue where the drives drop offline?

