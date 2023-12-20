Return-Path: <linux-btrfs+bounces-1078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2024819BCC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 10:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C6B1C22442
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 09:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289E020300;
	Wed, 20 Dec 2023 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gurwpEAI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F7E2030B;
	Wed, 20 Dec 2023 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso6790283a12.3;
        Wed, 20 Dec 2023 01:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703066096; x=1703670896; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mdMl+0w5mxyZ0vTmPRSqUENVLMYM8Y48+3cOXUO3d1Q=;
        b=gurwpEAI/NFkAC5bvXHGPMNY4YIdX64HfClKdjvNiMLsZ4kdkr+/TS83KMBQTbBQiF
         98XUWU71B/7vIec1fWDVCvWRR4Eyb0+1xRaihGsa3ydc6rjBJq5qNHlI770IB3PFastK
         B9f2XVyWBDP51yawXQ+zWzwNBN2LQ1/7Jqiajsb0o7Fj8+y5948fXMEcnk5LvdAFzdNK
         YDT6gk3q7CMnqwyPVcnZmzFh1yz90A6Yz52fPuiNor3TJOmmKAt54L8f0IOl1UqPsKBE
         dHmQB357XB6ubBXViqDz1rvw9stiNvX0xuSZ2L5oKkDUZvnhjCbCtOqzc9adDpAN1lD5
         uH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703066096; x=1703670896;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mdMl+0w5mxyZ0vTmPRSqUENVLMYM8Y48+3cOXUO3d1Q=;
        b=FiCWWs1H8jBychos/5g5iKNcO6iQoQ0dHuQsJJYxCs65LcIop5jp31LXLMYLs6BShi
         Fsj/AMd380HIvpocOSPvjUkZeB39QlRgo/qLpbKorIkWFFjoxg8+T3O/PiaL2mISbvFl
         fX5Diu5dHHMYB+/Hvqx4Int/MoVfaYCyFTKe4YxXfmUJez5Q9+Ny2woi3TocAxrBVrhL
         Pzqx+TMGwoBEkF2QE3yVgnO/748gOV4bCXcPM8uJvJHMjpTuBrPkQs27zgwRUOTAueyE
         x0h/EUREM3feeigTAPUD6WsntK0uiJ5TmQonyuvwvZsAVqytjaW6ZKxMYTdoI7DRqPw8
         HveQ==
X-Gm-Message-State: AOJu0YxS0To7FWu7ubN0ePN/RxicyYxo38+JuHa/0tfqkoyfOZdyxcId
	OlOvcFfNAs9+qlJgjD8O+w==
X-Google-Smtp-Source: AGHT+IHgRaWr6SxcC1caULR6Eb7HVa63b6n2lvJZ9vDv4FVGi7Cc5q28d8wZCqoP1Yq9KngAh/VipA==
X-Received: by 2002:a17:907:86a5:b0:a26:8856:95c with SMTP id qa37-20020a17090786a500b00a268856095cmr1172869ejc.22.1703066096090;
        Wed, 20 Dec 2023 01:54:56 -0800 (PST)
Received: from p183 ([46.53.248.146])
        by smtp.gmail.com with ESMTPSA id vq6-20020a170907a4c600b00a1d5444c2cdsm16713510ejc.140.2023.12.20.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 01:54:55 -0800 (PST)
Date: Wed, 20 Dec 2023 12:54:53 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Qu Wenruo <wqu@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-btrfs@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Message-ID: <b3ae8802-b4e0-4542-8fe0-e2d169944ac0@p183>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> Just as mentioned in the comment of memparse(), the simple_stroull()
> usage can lead to overflow all by itself.

which is the root cause...

I don't like one char suffixes. They are easy to integrate but then the
_real_ suffixes are "MiB", "GiB", etc.

If you care only about memparse(), then using _parse_integer() can be
arranged. I don't see why not.

