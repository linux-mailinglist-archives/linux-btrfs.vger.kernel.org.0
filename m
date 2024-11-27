Return-Path: <linux-btrfs+bounces-9938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5579DA3FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 09:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0902E1666A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE540191F75;
	Wed, 27 Nov 2024 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kknHXXSB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8622C18CC13
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732696320; cv=none; b=b0KDQqZmJZ9e10AEBbsKF4rZ1K/z9286TYFfWJUbpFBw4KtRXfGqUVzX92a+oOCcbytO4i9ApnoxioxKN06IfkpRRtSONUngFdWlI4iCs+wEc/h/HxQ3/GU5ee4hLkeNH24Vxx1TUaydm03Nr2ev3Lhjk8204/FpOG/FSoaoYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732696320; c=relaxed/simple;
	bh=PeA+DxbPbvlORJaZriRMCvvW+X8jSkuWwyK2UpZxN78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=qk0G1I+NWzsbzuyeVEDP27LKVqwG47tauia2SIkSF19noxMBRmXmM6yBbjSB4tThWSIRasc+9k8Cc22DrXYjYC+NZRf+3FnoPwtIqFR61Mfr/FgPaS2gV2+j6lS9b339n4Xw7TyYOUib9n/DvBUAo0EUuoz6AYZJgI1bdr+MP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kknHXXSB; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3882273bc8so5894264276.1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 00:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732696317; x=1733301117; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PeA+DxbPbvlORJaZriRMCvvW+X8jSkuWwyK2UpZxN78=;
        b=kknHXXSBQPusvCxPO7tIWBygUh1ovpO92Aa6xtGfj+4Wh9kE5ogYgCDKPYEty4NNU2
         c/4gyhySWkg0HdXT0iqhek3ZFI07xeFeMhhDpWS8JY6RZPrBl5EEXYeRqlp1H4cn1MlP
         ed8kSATbGy1OOR6qx1OSfplCEJQjQXz30ufL0lYYfbWzNPW9sd31PDC3/4ENeHvkEO33
         LrE2yKfwJTNLZGEjTkHfdqgLVFfcxoichhpn8ZdCGUszdhlF/1IX/sTy/fnUwdBx+kns
         dvfwkK75BQ4uFG6SQwgqicGc3DFEbCi98SZzsqd/JVTxfsigC+Ch2/AKjKfv9WhKcZgU
         ADkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732696317; x=1733301117;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeA+DxbPbvlORJaZriRMCvvW+X8jSkuWwyK2UpZxN78=;
        b=vCydN6E9gJl1v19cxM9V0kt2fK4uRul6BNzWL0JStT8Jan4jCQFq2XXQI6V7yE5zKX
         6zUV3KE5DZHlzdLMYPmE6bYq/sw/NtESClWnLJYmt07rXCKDlbazwIuEuvcruyYcA84f
         sJBo3i/XnFX5eHzVHBYWwelu5ueKTCJ4L/+LLKXUqVgYNWrhsas3h6gkExa5ffC/8cki
         FkDPKVts04j2NoJPRGCqUZDSYMR5KNmHuMShDcnWvFH0PzHyz5UcSZJMiMQYef9m810u
         G5x1Nh+ARVFevJgsUglqXVCPdAZgaXszNZv43etT9TYuZl2ZaSuQhHiJfQ+glJbt/eoT
         lUXA==
X-Gm-Message-State: AOJu0YwNU4yOsb9wy/ZbuHmEWMoo+RCsBkDKllMiwaVm5LVAAS8059je
	hBxmDlmGUFj5kye809yTQWECyqrwGrVT45gbyHTLDSk2/DNf198PA/o1hrwHGIpPl0ky6fZ6MSu
	sHrAJEi5+w+jZW/f2eyghLO03iyR6DWTg
X-Gm-Gg: ASbGncuS7thkBQLh8swZSeeqTfAdE1Eur0pVm0xQ2nKkbztVonwzn4ywU80lgBwqmJl
	4x327lQbMNthCN6DcICStWF1yrnjIh8AUzA==
X-Google-Smtp-Source: AGHT+IHzUz61U6WKdPx6BaU6mJ34qN/qpxbEp31RYlo9G2exxK3c7pmTZHIDO34nb4cV6FOJPa8US6rKrBhMj6e8A1c=
X-Received: by 2002:a05:6902:2513:b0:e29:10ff:bb6 with SMTP id
 3f1490d57ef6-e395b8c1cb2mr2036123276.23.1732696317418; Wed, 27 Nov 2024
 00:31:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFvQSYRxZ80O6cEVnU5_qG0HP2Lwn0LnBYmyy5EuCvX=Pa8ukQ@mail.gmail.com>
 <902510e3-3793-4444-bef1-ee33309be7c1@gmx.com>
In-Reply-To: <902510e3-3793-4444-bef1-ee33309be7c1@gmx.com>
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Wed, 27 Nov 2024 09:31:46 +0100
Message-ID: <CAFvQSYS650FwYj1n_2yZb9x7hw3yui4HyK87cA6pdNP53tav+A@mail.gmail.com>
Subject: Re: "fixed up error" during scrub reported multiple times for same logical
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Qu,

Thanks for taking a look at the logs / data.

> Kernel version please.
> We had a big rework on scrub some time ago, it affects both the error
> reporting and introduce some regression.
> Thus hard to say what's the situation here.

Currently it is running on 6.6.51.

> The corruption may be inside metadata
Am I right to assume that inside data it would not end as "fixed up",
as it is currently not DUP?


Thanks, Clemens

