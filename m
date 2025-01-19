Return-Path: <linux-btrfs+bounces-11004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97072A16048
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 06:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A110162DF2
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 05:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FB01632CA;
	Sun, 19 Jan 2025 05:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIUVIk2N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B51110F9
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737263519; cv=none; b=RWPJfLAEXGgz4MwWmYTqZUWYxM9atU2Yh3288EGy0s5AKpwVwNsg94Rhes6AsOj48U1eNhWZi9kvePYLaa9rnZhvKbje63dnE2uwoDw7qyBfKxeUKG5DhSfi7WUk8vNFV8jXrmq+ETC3r9KJ7tv+hwFUuafrnOccrkW2fzE15/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737263519; c=relaxed/simple;
	bh=Zjk/BFA/B7myn7AdqAycM70NHtw6KEVZ4N6WcOha6ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXamgjJgYqsHDOH9aJdsSPPKaYHOSK18tOa4ZogyBmNRBER4OVJZJMJjEaKZAfOvhh5dRdtFcgCl6BS14LJkgYje4TcoGINxwhxFbxzd+umArFzxBSdjMP4SKJfCSSLS5wu2awy+tW5ePoVLdH46cZUJCBxGntszEKnNMVuUAF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIUVIk2N; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so5380335276.3
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jan 2025 21:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737263510; x=1737868310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KJjJtAOs+pYfRTA88giqzGhE9KClmWM4wzcazIIErc=;
        b=FIUVIk2NNZcaHzJ6qxG25LvYHoAs6dxbcKBtpbePtku1EOUZZOo+gWZ5RXq9wTm/pG
         GF2iNbgRYnKyM4TmVvnQPY3Pn0DhboFlcD3FRGSXJmem/5GEEsDLL2ffvuCrSChsX5FE
         0txGCs+HnOGz0CxMFayv1x8WgUdpSycuHf0lX1f9FECrDt3mjcVoQ2tzwo4zOR7DSN2j
         ewFVCzAL/gI2dZWUQjUu2JbBcn6cADBmsqewAnMPwtosUof2PGseRMkEzVZ4lC1Q1Q+1
         fe3Yf94oC23zrLeSRbcgER+gy3SjJmx3MKhIV9YKC4LCxwoaCXLLHvNFqvymaiKu3L3r
         HsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737263510; x=1737868310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KJjJtAOs+pYfRTA88giqzGhE9KClmWM4wzcazIIErc=;
        b=tTyN9BavN8vrKXggm+hJfEE1fL9l3yhAq6zKK4/kPdwnDNp5zXeB9N4pwQ/luvw/1K
         6KFRbocK9vxwq9+oTPA66u5Y63tRQuZ6YESFQhxw0KH+jsUsN19ovWpJhwEka8j9PRBh
         8P3KK8g079CTRfw+Jpgu1zShV0+9COso8/q2ZI7Z40qdI5nmaKC8ppIcBo4KlQA8vsSi
         pLOPGsHaHYToTMhfctUUcXumr99qIUnH4395mSaqtLbpMM5e3y7XQG0Sg8uBkcVSIdjE
         +CILxI9sn30d9sihvg8FmJZ4SuC6o6b2vXBisC8hkLiBl5GMhNx3mEH6pxSbnhOaMIXA
         tv2Q==
X-Gm-Message-State: AOJu0YxEP85tUUQT8HXtTmt6mf5xMAw9IZQtErJEei1Nrnp1Ps7ze9lC
	O88y8I591iBxWIHoCjs5cJ0pA/7KF9trFKKZ1p2pnq/M4Bo6p3gQhg+Xq7pnpFiDgSPNmbskEkQ
	0XXLrvZwkvXHADKM00n8FYzKRpNN6EEHIwP0=
X-Gm-Gg: ASbGncsYal3WumQ11Rc1toa/ZkciOhaHx2Cm5hxq9tSA9sfRf+RM3rgXXXn0sLKNNS2
	6DD4kE6+IQLoSONKzM58N5HnwGSiHeBN25jKQsScoXQTEpt1BL6o=
X-Google-Smtp-Source: AGHT+IH41HtioELyRy5y0BMJ6U1gFIF4ondF7jqDaI/O+VahHh1ZJZ+CCRSsePnWy8o8mFyUG/Ee8ruXGYRr6v8Wz6Y=
X-Received: by 2002:a05:690c:6a0e:b0:6e3:37a7:8a98 with SMTP id
 00721157ae682-6f6eb6627f7mr62877637b3.14.1737263508133; Sat, 18 Jan 2025
 21:11:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdWbB4zZ4Xz2r7WSkC+2xt8umXn3jP6Gg43t7e8REbjJ2iioA@mail.gmail.com>
 <43f5b804-d18e-4bd6-8c19-08b4c688307c@gmx.com> <CAGdWbB6A5S7-+VM9HsPyb=5FMTqOSb3GVCzS+ix0vvRg3sfJ5g@mail.gmail.com>
 <34c2418a-c08e-4408-bf6e-3216d6b64ea3@gmx.com> <CAGdWbB7tFj_CT_XGEb0egRF+pDqB9+bVeP-Y1643y0WvsMcfMg@mail.gmail.com>
 <CAGdWbB57fOy3hZdeo3FykDQOfvkHjj-9zQodN_eZ+OLFXQKHVw@mail.gmail.com>
In-Reply-To: <CAGdWbB57fOy3hZdeo3FykDQOfvkHjj-9zQodN_eZ+OLFXQKHVw@mail.gmail.com>
From: Dave T <davestechshop@gmail.com>
Date: Sun, 19 Jan 2025 00:11:37 -0500
X-Gm-Features: AbW1kvZ4nxh8mWHWQNJavUaGpdAxdJZd1uN1TfBWLyrYLtDjz0CpfW48UUCPLtc
Message-ID: <CAGdWbB7u7XWJNbQa-zhRbLQveeiBPDE0oTTpVLROLoSmik4B-A@mail.gmail.com>
Subject: Re: BTRFS critical: unable to find chunk map for logical
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

here is the 2nd section of the log with the other balance failure:


Jan 18 15:11:39 laptop kernel: BTRFS info (device dm-0): balance:
start -dusage=3D99,limit=3D2..10 -musage=3D99,limit=3D2..10 -susage=3D99,>
Jan 18 15:11:39 laptop kernel: BTRFS info (device dm-0): relocating
block group 2267194327040 flags data
Jan 18 15:11:39 laptop kernel: BTRFS info (device dm-0): found 446
extents, stage: move data extents
Jan 18 15:11:41 laptop kernel: BTRFS info (device dm-0): found 446
extents, stage: update data pointers
Jan 18 15:11:42 laptop kernel: BTRFS info (device dm-0): relocating
block group 2266120585216 flags metadata
Jan 18 15:11:45 laptop kernel: BTRFS info (device dm-0): found 19964
extents, stage: move data extents
Jan 18 15:11:46 laptop kernel: BTRFS info (device dm-0): relocating
block group 2265046843392 flags metadata
Jan 18 15:11:58 laptop kernel: BTRFS info (device dm-0): found 59402
extents, stage: move data extents
Jan 18 15:12:05 laptop kernel: BTRFS info (device dm-0): relocating
block group 2263973101568 flags metadata
Jan 18 15:12:23 laptop kernel: BTRFS info (device dm-0): found 59803
extents, stage: move data extents
Jan 18 15:12:31 laptop kernel: BTRFS info (device dm-0): relocating
block group 2262899359744 flags data
Jan 18 15:12:32 laptop kernel: BTRFS info (device dm-0): found 2
extents, stage: move data extents
Jan 18 15:12:32 laptop kernel: BTRFS info (device dm-0): found 2
extents, stage: update data pointers
Jan 18 15:12:32 laptop kernel: BTRFS info (device dm-0): relocating
block group 2261825617920 flags data
Jan 18 15:12:32 laptop kernel: BTRFS info (device dm-0): found 1688
extents, stage: move data extents
Jan 18 15:12:35 laptop kernel: BTRFS info (device dm-0): found 1688
extents, stage: update data pointers
Jan 18 15:12:38 laptop kernel: BTRFS info (device dm-0): relocating
block group 2074960986112 flags data
Jan 18 15:12:39 laptop kernel: BTRFS info (device dm-0): found 26
extents, stage: move data extents
Jan 18 15:12:40 laptop kernel: BTRFS info (device dm-0): found 26
extents, stage: update data pointers
Jan 18 15:12:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 1581039747072 flags metadata
Jan 18 15:12:58 laptop kernel: BTRFS info (device dm-0): found 64736
extents, stage: move data extents
Jan 18 15:13:06 laptop kernel: BTRFS info (device dm-0): relocating
block group 70888980480 flags metadata
Jan 18 15:13:18 laptop kernel: BTRFS info (device dm-0): found 64760
extents, stage: move data extents
Jan 18 15:13:22 laptop kernel: BTRFS info (device dm-0): balance:
ended with status: 0


Jan 18 15:15:24 laptop kernel: BTRFS info (device dm-0): balance: start -d =
-m -s
Jan 18 15:15:24 laptop kernel: BTRFS info (device dm-0): relocating
block group 2276858003456 flags metadata
Jan 18 15:15:25 laptop kernel: BTRFS info (device dm-0): found 18763
extents, stage: move data extents
Jan 18 15:15:25 laptop kernel: BTRFS info (device dm-0): relocating
block group 2275784261632 flags metadata
Jan 18 15:15:32 laptop kernel: BTRFS info (device dm-0): found 59356
extents, stage: move data extents
Jan 18 15:15:34 laptop kernel: BTRFS info (device dm-0): relocating
block group 2274710519808 flags data
Jan 18 15:15:34 laptop kernel: BTRFS info (device dm-0): found 3
extents, stage: move data extents
Jan 18 15:15:35 laptop kernel: BTRFS info (device dm-0): found 3
extents, stage: update data pointers
Jan 18 15:15:35 laptop kernel: BTRFS info (device dm-0): relocating
block group 2273636777984 flags data
Jan 18 15:15:35 laptop kernel: BTRFS info (device dm-0): found 1712
extents, stage: move data extents
Jan 18 15:15:39 laptop kernel: BTRFS info (device dm-0): found 1712
extents, stage: update data pointers
Jan 18 15:15:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 2272563036160 flags data
Jan 18 15:15:42 laptop kernel: BTRFS info (device dm-0): found 25
extents, stage: move data extents
Jan 18 15:15:44 laptop kernel: BTRFS info (device dm-0): found 25
extents, stage: update data pointers
Jan 18 15:15:45 laptop kernel: BTRFS info (device dm-0): relocating
block group 2271489294336 flags metadata
Jan 18 15:16:00 laptop kernel: BTRFS info (device dm-0): found 56181
extents, stage: move data extents
Jan 18 15:16:07 laptop kernel: BTRFS info (device dm-0): relocating
block group 2270415552512 flags metadata
Jan 18 15:16:24 laptop kernel: BTRFS info (device dm-0): found 64846
extents, stage: move data extents
Jan 18 15:16:32 laptop kernel: BTRFS info (device dm-0): relocating
block group 2269341810688 flags metadata
Jan 18 15:16:49 laptop kernel: BTRFS info (device dm-0): found 65158
extents, stage: move data extents
Jan 18 15:16:57 laptop kernel: BTRFS info (device dm-0): relocating
block group 2268268068864 flags data
Jan 18 15:16:58 laptop kernel: BTRFS info (device dm-0): found 460
extents, stage: move data extents
Jan 18 15:16:59 laptop kernel: BTRFS info (device dm-0): found 459
extents, stage: update data pointers
Jan 18 15:17:00 laptop kernel: BTRFS info (device dm-0): relocating
block group 2129721819136 flags system
Jan 18 15:17:00 laptop kernel: BTRFS info (device dm-0): found 7
extents, stage: move data extents
Jan 18 15:17:00 laptop kernel: BTRFS info (device dm-0): relocating
block group 2073887244288 flags data
Jan 18 15:17:03 laptop kernel: BTRFS info (device dm-0): found 46657
extents, stage: move data extents
Jan 18 15:17:25 laptop kernel: BTRFS info (device dm-0): found 46657
extents, stage: update data pointers
Jan 18 15:17:38 laptop kernel: BTRFS info (device dm-0): relocating
block group 2072813502464 flags data
Jan 18 15:17:40 laptop kernel: BTRFS info (device dm-0): found 1600
extents, stage: move data extents
Jan 18 15:17:41 laptop kernel: BTRFS info (device dm-0): found 1600
extents, stage: update data pointers
Jan 18 15:17:42 laptop kernel: BTRFS info (device dm-0): relocating
block group 2071739760640 flags data
Jan 18 15:17:45 laptop kernel: BTRFS info (device dm-0): found 54693
extents, stage: move data extents
Jan 18 15:18:06 laptop kernel: BTRFS info (device dm-0): found 54693
extents, stage: update data pointers
Jan 18 15:18:19 laptop kernel: BTRFS info (device dm-0): relocating
block group 2070666018816 flags data
Jan 18 15:18:20 laptop kernel: BTRFS info (device dm-0): found 62
extents, stage: move data extents
Jan 18 15:18:21 laptop kernel: BTRFS info (device dm-0): found 62
extents, stage: update data pointers
Jan 18 15:18:23 laptop kernel: BTRFS info (device dm-0): relocating
block group 2069592276992 flags data
Jan 18 15:18:26 laptop kernel: BTRFS info (device dm-0): found 78889
extents, stage: move data extents
Jan 18 15:18:50 laptop kernel: BTRFS info (device dm-0): found 78889
extents, stage: update data pointers
Jan 18 15:19:04 laptop kernel: BTRFS info (device dm-0): relocating
block group 2068518535168 flags data
Jan 18 15:19:05 laptop kernel: BTRFS info (device dm-0): found 33
extents, stage: move data extents
Jan 18 15:19:06 laptop kernel: BTRFS info (device dm-0): found 33
extents, stage: update data pointers
Jan 18 15:19:07 laptop kernel: BTRFS info (device dm-0): relocating
block group 2067444793344 flags data
Jan 18 15:19:08 laptop kernel: BTRFS info (device dm-0): found 35
extents, stage: move data extents
Jan 18 15:19:08 laptop kernel: BTRFS info (device dm-0): found 35
extents, stage: update data pointers
Jan 18 15:19:08 laptop kernel: BTRFS info (device dm-0): relocating
block group 2066371051520 flags data
Jan 18 15:19:10 laptop kernel: BTRFS info (device dm-0): found 39
extents, stage: move data extents
Jan 18 15:19:10 laptop kernel: BTRFS info (device dm-0): found 39
extents, stage: update data pointers
Jan 18 15:19:10 laptop kernel: BTRFS info (device dm-0): relocating
block group 2065297309696 flags data
Jan 18 15:19:11 laptop kernel: BTRFS info (device dm-0): found 35
extents, stage: move data extents
Jan 18 15:19:11 laptop kernel: BTRFS info (device dm-0): found 35
extents, stage: update data pointers
Jan 18 15:19:12 laptop kernel: BTRFS info (device dm-0): relocating
block group 2064223567872 flags data
Jan 18 15:19:13 laptop kernel: BTRFS info (device dm-0): found 40
extents, stage: move data extents
Jan 18 15:19:13 laptop kernel: BTRFS info (device dm-0): found 40
extents, stage: update data pointers
Jan 18 15:19:13 laptop kernel: BTRFS info (device dm-0): relocating
block group 2063149826048 flags data
Jan 18 15:19:15 laptop kernel: BTRFS info (device dm-0): found 1939
extents, stage: move data extents
Jan 18 15:19:20 laptop kernel: BTRFS info (device dm-0): found 1937
extents, stage: update data pointers
Jan 18 15:19:23 laptop kernel: BTRFS info (device dm-0): relocating
block group 2061002342400 flags data
Jan 18 15:19:24 laptop kernel: BTRFS info (device dm-0): found 30
extents, stage: move data extents
Jan 18 15:19:24 laptop kernel: BTRFS info (device dm-0): found 30
extents, stage: update data pointers
Jan 18 15:19:25 laptop kernel: BTRFS info (device dm-0): relocating
block group 2059928600576 flags data
Jan 18 15:19:28 laptop kernel: BTRFS info (device dm-0): found 74571
extents, stage: move data extents
Jan 18 15:19:52 laptop kernel: BTRFS info (device dm-0): found 74570
extents, stage: update data pointers
Jan 18 15:20:04 laptop kernel: BTRFS info (device dm-0): relocating
block group 2058854858752 flags data
Jan 18 15:20:06 laptop kernel: BTRFS info (device dm-0): found 1665
extents, stage: move data extents
Jan 18 15:20:07 laptop kernel: BTRFS info (device dm-0): found 1665
extents, stage: update data pointers
Jan 18 15:20:08 laptop kernel: BTRFS info (device dm-0): relocating
block group 2057781116928 flags data
Jan 18 15:20:09 laptop kernel: BTRFS info (device dm-0): found 2794
extents, stage: move data extents
Jan 18 15:20:13 laptop kernel: BTRFS info (device dm-0): found 2794
extents, stage: update data pointers
Jan 18 15:20:15 laptop kernel: BTRFS info (device dm-0): relocating
block group 2056707375104 flags data
Jan 18 15:20:16 laptop kernel: BTRFS info (device dm-0): found 2679
extents, stage: move data extents
Jan 18 15:20:20 laptop kernel: BTRFS info (device dm-0): found 2679
extents, stage: update data pointers
Jan 18 15:20:22 laptop kernel: BTRFS info (device dm-0): relocating
block group 2055633633280 flags data
Jan 18 15:20:23 laptop kernel: BTRFS info (device dm-0): found 37
extents, stage: move data extents
Jan 18 15:20:23 laptop kernel: BTRFS info (device dm-0): found 37
extents, stage: update data pointers
Jan 18 15:20:24 laptop kernel: BTRFS info (device dm-0): relocating
block group 2054559891456 flags data
Jan 18 15:20:25 laptop kernel: BTRFS info (device dm-0): found 2589
extents, stage: move data extents
Jan 18 15:20:29 laptop kernel: BTRFS info (device dm-0): found 2589
extents, stage: update data pointers
Jan 18 15:20:31 laptop kernel: BTRFS info (device dm-0): relocating
block group 2053486149632 flags data
Jan 18 15:20:33 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: move data extents
Jan 18 15:20:33 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: update data pointers
Jan 18 15:20:33 laptop kernel: BTRFS info (device dm-0): relocating
block group 2052412407808 flags data
Jan 18 15:20:34 laptop kernel: BTRFS info (device dm-0): found 2845
extents, stage: move data extents
Jan 18 15:20:38 laptop kernel: BTRFS info (device dm-0): found 2845
extents, stage: update data pointers
Jan 18 15:20:40 laptop kernel: BTRFS info (device dm-0): relocating
block group 2051338665984 flags data
Jan 18 15:20:42 laptop kernel: BTRFS info (device dm-0): found 2539
extents, stage: move data extents
Jan 18 15:20:46 laptop kernel: BTRFS info (device dm-0): found 2539
extents, stage: update data pointers
Jan 18 15:20:48 laptop kernel: BTRFS info (device dm-0): relocating
block group 2050264924160 flags data
Jan 18 15:20:50 laptop kernel: BTRFS info (device dm-0): found 1559
extents, stage: move data extents
Jan 18 15:20:53 laptop kernel: BTRFS info (device dm-0): found 1559
extents, stage: update data pointers
Jan 18 15:20:55 laptop kernel: BTRFS info (device dm-0): relocating
block group 2049191182336 flags data
Jan 18 15:20:56 laptop kernel: BTRFS info (device dm-0): found 2497
extents, stage: move data extents
Jan 18 15:20:59 laptop kernel: BTRFS info (device dm-0): found 2497
extents, stage: update data pointers
Jan 18 15:21:02 laptop kernel: BTRFS info (device dm-0): relocating
block group 2048117440512 flags data
Jan 18 15:21:03 laptop kernel: BTRFS info (device dm-0): found 1982
extents, stage: move data extents
Jan 18 15:21:06 laptop kernel: BTRFS info (device dm-0): found 1982
extents, stage: update data pointers
Jan 18 15:21:08 laptop kernel: BTRFS info (device dm-0): relocating
block group 2047043698688 flags data
Jan 18 15:21:10 laptop kernel: BTRFS info (device dm-0): found 2185
extents, stage: move data extents
Jan 18 15:21:13 laptop kernel: BTRFS info (device dm-0): found 2185
extents, stage: update data pointers
Jan 18 15:21:16 laptop kernel: BTRFS info (device dm-0): relocating
block group 2045969956864 flags data
Jan 18 15:21:17 laptop kernel: BTRFS info (device dm-0): found 2175
extents, stage: move data extents
Jan 18 15:21:21 laptop kernel: BTRFS info (device dm-0): found 2175
extents, stage: update data pointers
Jan 18 15:21:23 laptop kernel: BTRFS info (device dm-0): relocating
block group 2044896215040 flags data
Jan 18 15:21:25 laptop kernel: BTRFS info (device dm-0): found 1218
extents, stage: move data extents
Jan 18 15:21:27 laptop kernel: BTRFS info (device dm-0): found 1218
extents, stage: update data pointers
Jan 18 15:21:29 laptop kernel: BTRFS info (device dm-0): relocating
block group 2043822473216 flags data
Jan 18 15:21:30 laptop kernel: BTRFS info (device dm-0): found 48
extents, stage: move data extents
Jan 18 15:21:31 laptop kernel: BTRFS info (device dm-0): found 48
extents, stage: update data pointers
Jan 18 15:21:31 laptop kernel: BTRFS info (device dm-0): relocating
block group 2042748731392 flags data
Jan 18 15:21:32 laptop kernel: BTRFS info (device dm-0): found 1316
extents, stage: move data extents
Jan 18 15:21:35 laptop kernel: BTRFS info (device dm-0): found 1316
extents, stage: update data pointers
Jan 18 15:21:37 laptop kernel: BTRFS info (device dm-0): relocating
block group 2041674989568 flags data
Jan 18 15:21:38 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: move data extents
Jan 18 15:21:39 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: update data pointers
Jan 18 15:21:39 laptop kernel: BTRFS info (device dm-0): relocating
block group 2040601247744 flags data
Jan 18 15:21:40 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:21:40 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:21:40 laptop kernel: BTRFS info (device dm-0): relocating
block group 2039527505920 flags data
Jan 18 15:21:42 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:21:42 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:21:42 laptop kernel: BTRFS info (device dm-0): relocating
block group 2038453764096 flags data
Jan 18 15:21:44 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: move data extents
Jan 18 15:21:44 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: update data pointers
Jan 18 15:21:44 laptop kernel: BTRFS info (device dm-0): relocating
block group 2037380022272 flags data
Jan 18 15:21:46 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:21:46 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:21:46 laptop kernel: BTRFS info (device dm-0): relocating
block group 2036306280448 flags data
Jan 18 15:21:48 laptop kernel: BTRFS info (device dm-0): found 1850
extents, stage: move data extents
Jan 18 15:21:48 laptop kernel: BTRFS info (device dm-0): found 1850
extents, stage: update data pointers
Jan 18 15:21:49 laptop kernel: BTRFS info (device dm-0): relocating
block group 2035232538624 flags data
Jan 18 15:21:51 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:21:51 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:21:51 laptop kernel: BTRFS info (device dm-0): relocating
block group 2034158796800 flags data
Jan 18 15:21:53 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:21:53 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:21:53 laptop kernel: BTRFS info (device dm-0): relocating
block group 2033085054976 flags data
Jan 18 15:21:55 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:21:55 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:21:55 laptop kernel: BTRFS info (device dm-0): relocating
block group 2032011313152 flags data
Jan 18 15:21:57 laptop kernel: BTRFS info (device dm-0): found 2076
extents, stage: move data extents
Jan 18 15:21:58 laptop kernel: BTRFS info (device dm-0): found 2076
extents, stage: update data pointers
Jan 18 15:21:59 laptop kernel: BTRFS info (device dm-0): relocating
block group 2030937571328 flags data
Jan 18 15:22:01 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:22:01 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:22:01 laptop kernel: BTRFS info (device dm-0): relocating
block group 2029863829504 flags data
Jan 18 15:22:03 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:22:03 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:22:03 laptop kernel: BTRFS info (device dm-0): relocating
block group 2028790087680 flags data
Jan 18 15:22:05 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:22:05 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:22:06 laptop kernel: BTRFS info (device dm-0): relocating
block group 2027716345856 flags data
Jan 18 15:22:07 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:22:08 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:22:08 laptop kernel: BTRFS info (device dm-0): relocating
block group 2026642604032 flags data
Jan 18 15:22:10 laptop kernel: BTRFS info (device dm-0): found 2042
extents, stage: move data extents
Jan 18 15:22:10 laptop kernel: BTRFS info (device dm-0): found 2042
extents, stage: update data pointers
Jan 18 15:22:10 laptop kernel: BTRFS info (device dm-0): relocating
block group 2025568862208 flags data
Jan 18 15:22:12 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:22:13 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:22:13 laptop kernel: BTRFS info (device dm-0): relocating
block group 2024495120384 flags data
Jan 18 15:22:15 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: move data extents
Jan 18 15:22:15 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: update data pointers
Jan 18 15:22:15 laptop kernel: BTRFS info (device dm-0): relocating
block group 2023421378560 flags data
Jan 18 15:22:17 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:22:17 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:22:18 laptop kernel: BTRFS info (device dm-0): relocating
block group 2022347636736 flags data
Jan 18 15:22:20 laptop kernel: BTRFS info (device dm-0): found 2490
extents, stage: move data extents
Jan 18 15:22:23 laptop kernel: BTRFS info (device dm-0): found 2490
extents, stage: update data pointers
Jan 18 15:22:26 laptop kernel: BTRFS info (device dm-0): relocating
block group 2021273894912 flags data
Jan 18 15:22:27 laptop kernel: BTRFS info (device dm-0): found 45
extents, stage: move data extents
Jan 18 15:22:28 laptop kernel: BTRFS info (device dm-0): found 45
extents, stage: update data pointers
Jan 18 15:22:28 laptop kernel: BTRFS info (device dm-0): relocating
block group 2020200153088 flags data
Jan 18 15:22:30 laptop kernel: BTRFS info (device dm-0): found 2903
extents, stage: move data extents
Jan 18 15:22:34 laptop kernel: BTRFS info (device dm-0): found 2903
extents, stage: update data pointers
Jan 18 15:22:37 laptop kernel: BTRFS info (device dm-0): relocating
block group 2019126411264 flags data
Jan 18 15:22:39 laptop kernel: BTRFS info (device dm-0): found 2622
extents, stage: move data extents
Jan 18 15:22:44 laptop kernel: BTRFS info (device dm-0): found 2622
extents, stage: update data pointers
Jan 18 15:22:47 laptop kernel: BTRFS info (device dm-0): relocating
block group 2018052669440 flags data
Jan 18 15:22:49 laptop kernel: BTRFS info (device dm-0): found 2307
extents, stage: move data extents
Jan 18 15:22:53 laptop kernel: BTRFS info (device dm-0): found 2307
extents, stage: update data pointers
Jan 18 15:22:56 laptop kernel: BTRFS info (device dm-0): relocating
block group 2016978927616 flags data
Jan 18 15:22:58 laptop kernel: BTRFS info (device dm-0): found 1923
extents, stage: move data extents
Jan 18 15:23:02 laptop kernel: BTRFS info (device dm-0): found 1923
extents, stage: update data pointers
Jan 18 15:23:04 laptop kernel: BTRFS info (device dm-0): relocating
block group 2015905185792 flags data
Jan 18 15:23:06 laptop kernel: BTRFS info (device dm-0): found 69
extents, stage: move data extents
Jan 18 15:23:06 laptop kernel: BTRFS info (device dm-0): found 69
extents, stage: update data pointers
Jan 18 15:23:07 laptop kernel: BTRFS info (device dm-0): relocating
block group 2014831443968 flags data
Jan 18 15:23:08 laptop kernel: BTRFS info (device dm-0): found 2078
extents, stage: move data extents
Jan 18 15:23:12 laptop kernel: BTRFS info (device dm-0): found 2078
extents, stage: update data pointers
Jan 18 15:23:15 laptop kernel: BTRFS info (device dm-0): relocating
block group 2013757702144 flags data
Jan 18 15:23:16 laptop kernel: BTRFS info (device dm-0): found 68
extents, stage: move data extents
Jan 18 15:23:17 laptop kernel: BTRFS info (device dm-0): found 68
extents, stage: update data pointers
Jan 18 15:23:17 laptop kernel: BTRFS info (device dm-0): relocating
block group 2012683960320 flags data
Jan 18 15:23:18 laptop kernel: BTRFS info (device dm-0): found 1707
extents, stage: move data extents
Jan 18 15:23:22 laptop kernel: BTRFS info (device dm-0): found 1707
extents, stage: update data pointers
Jan 18 15:23:24 laptop kernel: BTRFS info (device dm-0): relocating
block group 2011610218496 flags data
Jan 18 15:23:25 laptop kernel: BTRFS info (device dm-0): found 37
extents, stage: move data extents
Jan 18 15:23:26 laptop kernel: BTRFS info (device dm-0): found 37
extents, stage: update data pointers
Jan 18 15:23:26 laptop kernel: BTRFS info (device dm-0): relocating
block group 2010536476672 flags data
Jan 18 15:23:27 laptop kernel: BTRFS info (device dm-0): found 24
extents, stage: move data extents
Jan 18 15:23:28 laptop kernel: BTRFS info (device dm-0): found 24
extents, stage: update data pointers
Jan 18 15:23:28 laptop kernel: BTRFS info (device dm-0): relocating
block group 2009462734848 flags data
Jan 18 15:23:29 laptop kernel: BTRFS info (device dm-0): found 1703
extents, stage: move data extents
Jan 18 15:23:32 laptop kernel: BTRFS info (device dm-0): found 1703
extents, stage: update data pointers
Jan 18 15:23:34 laptop kernel: BTRFS info (device dm-0): relocating
block group 2008388993024 flags data
Jan 18 15:23:35 laptop kernel: BTRFS info (device dm-0): found 41
extents, stage: move data extents
Jan 18 15:23:35 laptop kernel: BTRFS info (device dm-0): found 41
extents, stage: update data pointers
Jan 18 15:23:35 laptop kernel: BTRFS info (device dm-0): relocating
block group 2007315251200 flags data
Jan 18 15:23:37 laptop kernel: BTRFS info (device dm-0): found 33
extents, stage: move data extents
Jan 18 15:23:37 laptop kernel: BTRFS info (device dm-0): found 33
extents, stage: update data pointers
Jan 18 15:23:37 laptop kernel: BTRFS info (device dm-0): relocating
block group 2006241509376 flags data
Jan 18 15:23:39 laptop kernel: BTRFS info (device dm-0): found 29
extents, stage: move data extents
Jan 18 15:23:39 laptop kernel: BTRFS info (device dm-0): found 29
extents, stage: update data pointers
Jan 18 15:23:39 laptop kernel: BTRFS info (device dm-0): relocating
block group 2005167767552 flags data
Jan 18 15:23:41 laptop kernel: BTRFS info (device dm-0): found 25
extents, stage: move data extents
Jan 18 15:23:41 laptop kernel: BTRFS info (device dm-0): found 25
extents, stage: update data pointers
Jan 18 15:23:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 2004094025728 flags data
Jan 18 15:23:43 laptop kernel: BTRFS info (device dm-0): found 27
extents, stage: move data extents
Jan 18 15:23:43 laptop kernel: BTRFS info (device dm-0): found 27
extents, stage: update data pointers
Jan 18 15:23:44 laptop kernel: BTRFS info (device dm-0): relocating
block group 2003020283904 flags data
Jan 18 15:23:46 laptop kernel: BTRFS info (device dm-0): found 30
extents, stage: move data extents
Jan 18 15:23:46 laptop kernel: BTRFS info (device dm-0): found 30
extents, stage: update data pointers
Jan 18 15:23:46 laptop kernel: BTRFS info (device dm-0): relocating
block group 2001946542080 flags data
Jan 18 15:23:48 laptop kernel: BTRFS info (device dm-0): found 29
extents, stage: move data extents
Jan 18 15:23:48 laptop kernel: BTRFS info (device dm-0): found 29
extents, stage: update data pointers
Jan 18 15:23:48 laptop kernel: BTRFS info (device dm-0): relocating
block group 2000872800256 flags data
Jan 18 15:23:50 laptop kernel: BTRFS info (device dm-0): found 26
extents, stage: move data extents
Jan 18 15:23:50 laptop kernel: BTRFS info (device dm-0): found 26
extents, stage: update data pointers
Jan 18 15:23:50 laptop kernel: BTRFS info (device dm-0): relocating
block group 1999799058432 flags data
Jan 18 15:23:52 laptop kernel: BTRFS info (device dm-0): found 32
extents, stage: move data extents
Jan 18 15:23:52 laptop kernel: BTRFS info (device dm-0): found 32
extents, stage: update data pointers
Jan 18 15:23:52 laptop kernel: BTRFS info (device dm-0): relocating
block group 1998725316608 flags data
Jan 18 15:23:54 laptop kernel: BTRFS info (device dm-0): found 27
extents, stage: move data extents
Jan 18 15:23:54 laptop kernel: BTRFS info (device dm-0): found 27
extents, stage: update data pointers
Jan 18 15:23:54 laptop kernel: BTRFS info (device dm-0): relocating
block group 1997651574784 flags data
Jan 18 15:23:56 laptop kernel: BTRFS info (device dm-0): found 25
extents, stage: move data extents
Jan 18 15:23:56 laptop kernel: BTRFS info (device dm-0): found 25
extents, stage: update data pointers
Jan 18 15:23:57 laptop kernel: BTRFS info (device dm-0): relocating
block group 1996577832960 flags data
Jan 18 15:23:58 laptop kernel: BTRFS info (device dm-0): found 29
extents, stage: move data extents
Jan 18 15:23:59 laptop kernel: BTRFS info (device dm-0): found 29
extents, stage: update data pointers
Jan 18 15:23:59 laptop kernel: BTRFS info (device dm-0): relocating
block group 1995504091136 flags data
Jan 18 15:24:01 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: move data extents
Jan 18 15:24:01 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: update data pointers
Jan 18 15:24:01 laptop kernel: BTRFS info (device dm-0): relocating
block group 1994430349312 flags data
Jan 18 15:24:03 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: move data extents
Jan 18 15:24:03 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: update data pointers
Jan 18 15:24:03 laptop kernel: BTRFS info (device dm-0): relocating
block group 1993356607488 flags data
Jan 18 15:24:05 laptop kernel: BTRFS info (device dm-0): found 30
extents, stage: move data extents
Jan 18 15:24:06 laptop kernel: BTRFS info (device dm-0): found 30
extents, stage: update data pointers
Jan 18 15:24:06 laptop kernel: BTRFS info (device dm-0): relocating
block group 1992282865664 flags data
Jan 18 15:24:08 laptop kernel: BTRFS info (device dm-0): found 1180
extents, stage: move data extents
Jan 18 15:24:10 laptop kernel: BTRFS info (device dm-0): found 1180
extents, stage: update data pointers
Jan 18 15:24:12 laptop kernel: BTRFS info (device dm-0): relocating
block group 1991209123840 flags data
Jan 18 15:24:13 laptop kernel: BTRFS info (device dm-0): found 38
extents, stage: move data extents
Jan 18 15:24:13 laptop kernel: BTRFS info (device dm-0): found 38
extents, stage: update data pointers
Jan 18 15:24:13 laptop kernel: BTRFS info (device dm-0): relocating
block group 1990135382016 flags data
Jan 18 15:24:15 laptop kernel: BTRFS info (device dm-0): found 26
extents, stage: move data extents
Jan 18 15:24:15 laptop kernel: BTRFS info (device dm-0): found 26
extents, stage: update data pointers
Jan 18 15:24:15 laptop kernel: BTRFS info (device dm-0): relocating
block group 1989061640192 flags data
Jan 18 15:24:17 laptop kernel: BTRFS info (device dm-0): found 50
extents, stage: move data extents
Jan 18 15:24:17 laptop kernel: BTRFS info (device dm-0): found 50
extents, stage: update data pointers
Jan 18 15:24:17 laptop kernel: BTRFS info (device dm-0): relocating
block group 1987987898368 flags data
Jan 18 15:24:19 laptop kernel: BTRFS info (device dm-0): found 1387
extents, stage: move data extents
Jan 18 15:24:22 laptop kernel: BTRFS info (device dm-0): found 1387
extents, stage: update data pointers
Jan 18 15:24:24 laptop kernel: BTRFS info (device dm-0): relocating
block group 1986914156544 flags data
Jan 18 15:24:25 laptop kernel: BTRFS info (device dm-0): found 48
extents, stage: move data extents
Jan 18 15:24:26 laptop kernel: BTRFS info (device dm-0): found 48
extents, stage: update data pointers
Jan 18 15:24:26 laptop kernel: BTRFS info (device dm-0): relocating
block group 1985840414720 flags data
Jan 18 15:24:28 laptop kernel: BTRFS info (device dm-0): found 52
extents, stage: move data extents
Jan 18 15:24:28 laptop kernel: BTRFS info (device dm-0): found 52
extents, stage: update data pointers
Jan 18 15:24:29 laptop kernel: BTRFS info (device dm-0): relocating
block group 1984766672896 flags data
Jan 18 15:24:31 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: move data extents
Jan 18 15:24:31 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: update data pointers
Jan 18 15:24:31 laptop kernel: BTRFS info (device dm-0): relocating
block group 1983692931072 flags data
Jan 18 15:24:33 laptop kernel: BTRFS info (device dm-0): found 1320
extents, stage: move data extents
Jan 18 15:24:36 laptop kernel: BTRFS info (device dm-0): found 1320
extents, stage: update data pointers
Jan 18 15:24:37 laptop kernel: BTRFS info (device dm-0): relocating
block group 1982619189248 flags data
Jan 18 15:24:39 laptop kernel: BTRFS info (device dm-0): found 66
extents, stage: move data extents
Jan 18 15:24:39 laptop kernel: BTRFS info (device dm-0): found 66
extents, stage: update data pointers
Jan 18 15:24:40 laptop kernel: BTRFS info (device dm-0): relocating
block group 1981545447424 flags data
Jan 18 15:24:42 laptop kernel: BTRFS info (device dm-0): found 1566
extents, stage: move data extents
Jan 18 15:24:44 laptop kernel: BTRFS info (device dm-0): found 1566
extents, stage: update data pointers
Jan 18 15:24:46 laptop kernel: BTRFS info (device dm-0): relocating
block group 1980471705600 flags data
Jan 18 15:24:48 laptop kernel: BTRFS info (device dm-0): found 1438
extents, stage: move data extents
Jan 18 15:24:50 laptop kernel: BTRFS info (device dm-0): found 1437
extents, stage: update data pointers
Jan 18 15:24:52 laptop kernel: BTRFS info (device dm-0): relocating
block group 1979397963776 flags data
Jan 18 15:24:53 laptop kernel: BTRFS info (device dm-0): found 1783
extents, stage: move data extents
Jan 18 15:24:56 laptop kernel: BTRFS info (device dm-0): found 1783
extents, stage: update data pointers
Jan 18 15:24:58 laptop kernel: BTRFS info (device dm-0): relocating
block group 1978324221952 flags data
Jan 18 15:24:59 laptop kernel: BTRFS info (device dm-0): found 1660
extents, stage: move data extents
Jan 18 15:25:02 laptop kernel: BTRFS info (device dm-0): found 1660
extents, stage: update data pointers
Jan 18 15:25:04 laptop kernel: BTRFS info (device dm-0): relocating
block group 1977250480128 flags data
Jan 18 15:25:06 laptop kernel: BTRFS info (device dm-0): found 70
extents, stage: move data extents
Jan 18 15:25:06 laptop kernel: BTRFS info (device dm-0): found 70
extents, stage: update data pointers
Jan 18 15:25:07 laptop kernel: BTRFS info (device dm-0): relocating
block group 1976176738304 flags data
Jan 18 15:25:08 laptop kernel: BTRFS info (device dm-0): found 1108
extents, stage: move data extents
Jan 18 15:25:11 laptop kernel: BTRFS info (device dm-0): found 1108
extents, stage: update data pointers
Jan 18 15:25:13 laptop kernel: BTRFS info (device dm-0): relocating
block group 1975102996480 flags data
Jan 18 15:25:14 laptop kernel: BTRFS info (device dm-0): found 1290
extents, stage: move data extents
Jan 18 15:25:17 laptop kernel: BTRFS info (device dm-0): found 1290
extents, stage: update data pointers
Jan 18 15:25:20 laptop kernel: BTRFS info (device dm-0): relocating
block group 1974029254656 flags data
Jan 18 15:25:21 laptop kernel: BTRFS info (device dm-0): found 1356
extents, stage: move data extents
Jan 18 15:25:24 laptop kernel: BTRFS info (device dm-0): found 1356
extents, stage: update data pointers
Jan 18 15:25:26 laptop kernel: BTRFS info (device dm-0): relocating
block group 1972955512832 flags data
Jan 18 15:25:28 laptop kernel: BTRFS info (device dm-0): found 2079
extents, stage: move data extents
Jan 18 15:25:31 laptop kernel: BTRFS info (device dm-0): found 2079
extents, stage: update data pointers
Jan 18 15:25:34 laptop kernel: BTRFS info (device dm-0): relocating
block group 1971881771008 flags data
Jan 18 15:25:35 laptop kernel: BTRFS info (device dm-0): found 1642
extents, stage: move data extents
Jan 18 15:25:38 laptop kernel: BTRFS info (device dm-0): found 1642
extents, stage: update data pointers
Jan 18 15:25:40 laptop kernel: BTRFS info (device dm-0): relocating
block group 1970808029184 flags data
Jan 18 15:25:41 laptop kernel: BTRFS info (device dm-0): found 28
extents, stage: move data extents
Jan 18 15:25:41 laptop kernel: BTRFS info (device dm-0): found 28
extents, stage: update data pointers
Jan 18 15:25:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 1969734287360 flags data
Jan 18 15:25:43 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:25:43 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:25:43 laptop kernel: BTRFS info (device dm-0): relocating
block group 1968660545536 flags data
Jan 18 15:25:44 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:25:44 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:25:45 laptop kernel: BTRFS info (device dm-0): relocating
block group 1967586803712 flags data
Jan 18 15:25:46 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:25:46 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:25:46 laptop kernel: BTRFS info (device dm-0): relocating
block group 1966513061888 flags data
Jan 18 15:25:48 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:25:48 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:25:49 laptop kernel: BTRFS info (device dm-0): relocating
block group 1965439320064 flags data
Jan 18 15:25:50 laptop kernel: BTRFS info (device dm-0): found 1862
extents, stage: move data extents
Jan 18 15:25:52 laptop kernel: BTRFS info (device dm-0): found 1862
extents, stage: update data pointers
Jan 18 15:25:53 laptop kernel: BTRFS info (device dm-0): relocating
block group 1964365578240 flags data
Jan 18 15:25:54 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:25:55 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:25:55 laptop kernel: BTRFS info (device dm-0): relocating
block group 1963291836416 flags data
Jan 18 15:25:57 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:25:57 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:25:57 laptop kernel: BTRFS info (device dm-0): relocating
block group 1962218094592 flags data
Jan 18 15:25:59 laptop kernel: BTRFS info (device dm-0): found 2038
extents, stage: move data extents
Jan 18 15:25:59 laptop kernel: BTRFS info (device dm-0): found 2038
extents, stage: update data pointers
Jan 18 15:26:00 laptop kernel: BTRFS info (device dm-0): relocating
block group 1961144352768 flags data
Jan 18 15:26:01 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:26:01 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:26:02 laptop kernel: BTRFS info (device dm-0): relocating
block group 1960070610944 flags data
Jan 18 15:26:03 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:26:04 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:26:04 laptop kernel: BTRFS info (device dm-0): relocating
block group 1958996869120 flags data
Jan 18 15:26:06 laptop kernel: BTRFS info (device dm-0): found 2036
extents, stage: move data extents
Jan 18 15:26:06 laptop kernel: BTRFS info (device dm-0): found 2036
extents, stage: update data pointers
Jan 18 15:26:06 laptop kernel: BTRFS info (device dm-0): relocating
block group 1957923127296 flags data
Jan 18 15:26:08 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:26:08 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:26:08 laptop kernel: BTRFS info (device dm-0): relocating
block group 1956849385472 flags data
Jan 18 15:26:10 laptop kernel: BTRFS info (device dm-0): found 2023
extents, stage: move data extents
Jan 18 15:26:11 laptop kernel: BTRFS info (device dm-0): found 2023
extents, stage: update data pointers
Jan 18 15:26:11 laptop kernel: BTRFS info (device dm-0): relocating
block group 1955775643648 flags data
Jan 18 15:26:13 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:26:13 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:26:13 laptop kernel: BTRFS info (device dm-0): relocating
block group 1954701901824 flags data
Jan 18 15:26:15 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:26:15 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:26:15 laptop kernel: BTRFS info (device dm-0): relocating
block group 1953628160000 flags data
Jan 18 15:26:17 laptop kernel: BTRFS info (device dm-0): found 2040
extents, stage: move data extents
Jan 18 15:26:17 laptop kernel: BTRFS info (device dm-0): found 2040
extents, stage: update data pointers
Jan 18 15:26:18 laptop kernel: BTRFS info (device dm-0): relocating
block group 1952554418176 flags data
Jan 18 15:26:20 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:26:20 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:26:20 laptop kernel: BTRFS info (device dm-0): relocating
block group 1951480676352 flags data
Jan 18 15:26:22 laptop kernel: BTRFS info (device dm-0): found 2051
extents, stage: move data extents
Jan 18 15:26:22 laptop kernel: BTRFS info (device dm-0): found 2051
extents, stage: update data pointers
Jan 18 15:26:22 laptop kernel: BTRFS info (device dm-0): relocating
block group 1950406934528 flags data
Jan 18 15:26:24 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:26:24 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:26:24 laptop kernel: BTRFS info (device dm-0): relocating
block group 1949333192704 flags data
Jan 18 15:26:26 laptop kernel: BTRFS info (device dm-0): found 2034
extents, stage: move data extents
Jan 18 15:26:27 laptop kernel: BTRFS info (device dm-0): found 2034
extents, stage: update data pointers
Jan 18 15:26:27 laptop kernel: BTRFS info (device dm-0): relocating
block group 1948259450880 flags data
Jan 18 15:26:29 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:26:29 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:26:29 laptop kernel: BTRFS info (device dm-0): relocating
block group 1947185709056 flags data
Jan 18 15:26:31 laptop kernel: BTRFS info (device dm-0): found 2049
extents, stage: move data extents
Jan 18 15:26:31 laptop kernel: BTRFS info (device dm-0): found 2049
extents, stage: update data pointers
Jan 18 15:26:32 laptop kernel: BTRFS info (device dm-0): relocating
block group 1946111967232 flags data
Jan 18 15:26:33 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:26:34 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:26:34 laptop kernel: BTRFS info (device dm-0): relocating
block group 1945038225408 flags data
Jan 18 15:26:36 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:26:36 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:26:36 laptop kernel: BTRFS info (device dm-0): relocating
block group 1943964483584 flags data
Jan 18 15:26:38 laptop kernel: BTRFS info (device dm-0): found 2028
extents, stage: move data extents
Jan 18 15:26:38 laptop kernel: BTRFS info (device dm-0): found 2028
extents, stage: update data pointers
Jan 18 15:26:38 laptop kernel: BTRFS info (device dm-0): relocating
block group 1942890741760 flags data
Jan 18 15:26:40 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:26:40 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:26:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 1941816999936 flags data
Jan 18 15:26:42 laptop kernel: BTRFS info (device dm-0): found 1920
extents, stage: move data extents
Jan 18 15:26:43 laptop kernel: BTRFS info (device dm-0): found 1920
extents, stage: update data pointers
Jan 18 15:26:43 laptop kernel: BTRFS info (device dm-0): relocating
block group 1940743258112 flags data
Jan 18 15:26:45 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:26:45 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:26:45 laptop kernel: BTRFS info (device dm-0): relocating
block group 1939669516288 flags data
Jan 18 15:26:47 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:26:47 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:26:47 laptop kernel: BTRFS info (device dm-0): relocating
block group 1938595774464 flags data
Jan 18 15:26:49 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: move data extents
Jan 18 15:26:50 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: update data pointers
Jan 18 15:26:50 laptop kernel: BTRFS info (device dm-0): relocating
block group 1937522032640 flags data
Jan 18 15:26:52 laptop kernel: BTRFS info (device dm-0): found 2044
extents, stage: move data extents
Jan 18 15:26:52 laptop kernel: BTRFS info (device dm-0): found 2044
extents, stage: update data pointers
Jan 18 15:26:53 laptop kernel: BTRFS info (device dm-0): relocating
block group 1936448290816 flags data
Jan 18 15:26:55 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:26:55 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:26:55 laptop kernel: BTRFS info (device dm-0): relocating
block group 1935374548992 flags data
Jan 18 15:26:57 laptop kernel: BTRFS info (device dm-0): found 1402
extents, stage: move data extents
Jan 18 15:26:59 laptop kernel: BTRFS info (device dm-0): found 1402
extents, stage: update data pointers
Jan 18 15:27:00 laptop kernel: BTRFS info (device dm-0): relocating
block group 1934300807168 flags data
Jan 18 15:27:01 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:27:02 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:27:02 laptop kernel: BTRFS info (device dm-0): relocating
block group 1933227065344 flags data
Jan 18 15:27:03 laptop kernel: BTRFS info (device dm-0): found 2029
extents, stage: move data extents
Jan 18 15:27:04 laptop kernel: BTRFS info (device dm-0): found 2029
extents, stage: update data pointers
Jan 18 15:27:04 laptop kernel: BTRFS info (device dm-0): relocating
block group 1932153323520 flags data
Jan 18 15:27:06 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:27:07 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:27:07 laptop kernel: BTRFS info (device dm-0): relocating
block group 1931079581696 flags data
Jan 18 15:27:09 laptop kernel: BTRFS info (device dm-0): found 2048
extents, stage: move data extents
Jan 18 15:27:09 laptop kernel: BTRFS info (device dm-0): found 2048
extents, stage: update data pointers
Jan 18 15:27:10 laptop kernel: BTRFS info (device dm-0): relocating
block group 1930005839872 flags data
Jan 18 15:27:11 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:27:12 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:27:12 laptop kernel: BTRFS info (device dm-0): relocating
block group 1928932098048 flags data
Jan 18 15:27:14 laptop kernel: BTRFS info (device dm-0): found 47
extents, stage: move data extents
Jan 18 15:27:14 laptop kernel: BTRFS info (device dm-0): found 47
extents, stage: update data pointers
Jan 18 15:27:15 laptop kernel: BTRFS info (device dm-0): relocating
block group 1927858356224 flags data
Jan 18 15:27:17 laptop kernel: BTRFS info (device dm-0): found 1960
extents, stage: move data extents
Jan 18 15:27:18 laptop kernel: BTRFS info (device dm-0): found 1960
extents, stage: update data pointers
Jan 18 15:27:19 laptop kernel: BTRFS info (device dm-0): relocating
block group 1926784614400 flags data
Jan 18 15:27:20 laptop kernel: BTRFS info (device dm-0): found 887
extents, stage: move data extents
Jan 18 15:27:23 laptop kernel: BTRFS info (device dm-0): found 887
extents, stage: update data pointers
Jan 18 15:27:25 laptop kernel: BTRFS info (device dm-0): relocating
block group 1925710872576 flags data
Jan 18 15:27:26 laptop kernel: BTRFS info (device dm-0): found 954
extents, stage: move data extents
Jan 18 15:27:28 laptop kernel: BTRFS info (device dm-0): found 954
extents, stage: update data pointers
Jan 18 15:27:30 laptop kernel: BTRFS info (device dm-0): relocating
block group 1924637130752 flags data
Jan 18 15:27:32 laptop kernel: BTRFS info (device dm-0): found 66
extents, stage: move data extents
Jan 18 15:27:32 laptop kernel: BTRFS info (device dm-0): found 66
extents, stage: update data pointers
Jan 18 15:27:32 laptop kernel: BTRFS info (device dm-0): relocating
block group 1923563388928 flags data
Jan 18 15:27:34 laptop kernel: BTRFS info (device dm-0): found 26
extents, stage: move data extents
Jan 18 15:27:34 laptop kernel: BTRFS info (device dm-0): found 26
extents, stage: update data pointers
Jan 18 15:27:34 laptop kernel: BTRFS info (device dm-0): relocating
block group 1922489647104 flags data
Jan 18 15:27:37 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:27:37 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:27:37 laptop kernel: BTRFS info (device dm-0): relocating
block group 1921415905280 flags data
Jan 18 15:27:39 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:27:39 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:27:39 laptop kernel: BTRFS info (device dm-0): relocating
block group 1920342163456 flags data
Jan 18 15:27:41 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: move data extents
Jan 18 15:27:41 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: update data pointers
Jan 18 15:27:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 1919268421632 flags data
Jan 18 15:27:43 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:27:44 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:27:44 laptop kernel: BTRFS info (device dm-0): relocating
block group 1918194679808 flags data
Jan 18 15:27:46 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:27:46 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:27:46 laptop kernel: BTRFS info (device dm-0): relocating
block group 1917120937984 flags data
Jan 18 15:27:48 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:27:48 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:27:48 laptop kernel: BTRFS info (device dm-0): relocating
block group 1916047196160 flags data
Jan 18 15:27:50 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:27:50 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:27:50 laptop kernel: BTRFS info (device dm-0): relocating
block group 1914973454336 flags data
Jan 18 15:27:52 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:27:52 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:27:52 laptop kernel: BTRFS info (device dm-0): relocating
block group 1913899712512 flags data
Jan 18 15:27:55 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:27:55 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:27:55 laptop kernel: BTRFS info (device dm-0): relocating
block group 1912825970688 flags data
Jan 18 15:27:57 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:27:57 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:27:57 laptop kernel: BTRFS info (device dm-0): relocating
block group 1911752228864 flags data
Jan 18 15:27:59 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: move data extents
Jan 18 15:27:59 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: update data pointers
Jan 18 15:27:59 laptop kernel: BTRFS info (device dm-0): relocating
block group 1910678487040 flags data
Jan 18 15:28:01 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:28:01 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:28:01 laptop kernel: BTRFS info (device dm-0): relocating
block group 1909604745216 flags data
Jan 18 15:28:03 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:28:03 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:28:03 laptop kernel: BTRFS info (device dm-0): relocating
block group 1908531003392 flags data
Jan 18 15:28:05 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:28:05 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:28:05 laptop kernel: BTRFS info (device dm-0): relocating
block group 1907457261568 flags data
Jan 18 15:28:07 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:28:07 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:28:07 laptop kernel: BTRFS info (device dm-0): relocating
block group 1906383519744 flags data
Jan 18 15:28:09 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: move data extents
Jan 18 15:28:09 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: update data pointers
Jan 18 15:28:09 laptop kernel: BTRFS info (device dm-0): relocating
block group 1905309777920 flags data
Jan 18 15:28:11 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:28:12 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:28:12 laptop kernel: BTRFS info (device dm-0): relocating
block group 1904236036096 flags data
Jan 18 15:28:14 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:28:14 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:28:14 laptop kernel: BTRFS info (device dm-0): relocating
block group 1903162294272 flags data
Jan 18 15:28:16 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: move data extents
Jan 18 15:28:16 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: update data pointers
Jan 18 15:28:17 laptop kernel: BTRFS info (device dm-0): relocating
block group 1902088552448 flags data
Jan 18 15:28:18 laptop kernel: BTRFS info (device dm-0): found 897
extents, stage: move data extents
Jan 18 15:28:21 laptop kernel: BTRFS info (device dm-0): found 897
extents, stage: update data pointers
Jan 18 15:28:22 laptop kernel: BTRFS info (device dm-0): relocating
block group 1901014810624 flags data
Jan 18 15:28:24 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: move data extents
Jan 18 15:28:24 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: update data pointers
Jan 18 15:28:24 laptop kernel: BTRFS info (device dm-0): relocating
block group 1899941068800 flags data
Jan 18 15:28:26 laptop kernel: BTRFS info (device dm-0): found 64
extents, stage: move data extents
Jan 18 15:28:26 laptop kernel: BTRFS info (device dm-0): found 64
extents, stage: update data pointers
Jan 18 15:28:27 laptop kernel: BTRFS info (device dm-0): relocating
block group 1898867326976 flags data
Jan 18 15:28:28 laptop kernel: BTRFS info (device dm-0): found 1307
extents, stage: move data extents
Jan 18 15:28:31 laptop kernel: BTRFS info (device dm-0): found 1307
extents, stage: update data pointers
Jan 18 15:28:33 laptop kernel: BTRFS info (device dm-0): relocating
block group 1897793585152 flags data
Jan 18 15:28:34 laptop kernel: BTRFS info (device dm-0): found 35
extents, stage: move data extents
Jan 18 15:28:35 laptop kernel: BTRFS info (device dm-0): found 35
extents, stage: update data pointers
Jan 18 15:28:35 laptop kernel: BTRFS info (device dm-0): relocating
block group 1896719843328 flags data
Jan 18 15:28:37 laptop kernel: BTRFS info (device dm-0): found 997
extents, stage: move data extents
Jan 18 15:28:40 laptop kernel: BTRFS info (device dm-0): found 997
extents, stage: update data pointers
Jan 18 15:28:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 1895646101504 flags data
Jan 18 15:28:43 laptop kernel: BTRFS info (device dm-0): found 36
extents, stage: move data extents
Jan 18 15:28:43 laptop kernel: BTRFS info (device dm-0): found 36
extents, stage: update data pointers
Jan 18 15:28:44 laptop kernel: BTRFS info (device dm-0): relocating
block group 1894572359680 flags data
Jan 18 15:28:46 laptop kernel: BTRFS info (device dm-0): found 883
extents, stage: move data extents
Jan 18 15:28:49 laptop kernel: BTRFS info (device dm-0): found 883
extents, stage: update data pointers
Jan 18 15:28:50 laptop kernel: BTRFS info (device dm-0): relocating
block group 1893498617856 flags data
Jan 18 15:28:52 laptop kernel: BTRFS info (device dm-0): found 1454
extents, stage: move data extents
Jan 18 15:28:54 laptop kernel: BTRFS info (device dm-0): found 1454
extents, stage: update data pointers
Jan 18 15:28:56 laptop kernel: BTRFS info (device dm-0): relocating
block group 1892424876032 flags data
Jan 18 15:28:58 laptop kernel: BTRFS info (device dm-0): found 1385
extents, stage: move data extents
Jan 18 15:29:00 laptop kernel: BTRFS info (device dm-0): found 1385
extents, stage: update data pointers
Jan 18 15:29:02 laptop kernel: BTRFS info (device dm-0): relocating
block group 1891351134208 flags data
Jan 18 15:29:03 laptop kernel: BTRFS info (device dm-0): found 49
extents, stage: move data extents
Jan 18 15:29:04 laptop kernel: BTRFS info (device dm-0): found 49
extents, stage: update data pointers
Jan 18 15:29:05 laptop kernel: BTRFS info (device dm-0): relocating
block group 1890277392384 flags data
Jan 18 15:29:06 laptop kernel: BTRFS info (device dm-0): found 47
extents, stage: move data extents
Jan 18 15:29:07 laptop kernel: BTRFS info (device dm-0): found 47
extents, stage: update data pointers
Jan 18 15:29:07 laptop kernel: BTRFS info (device dm-0): relocating
block group 1889203650560 flags data
Jan 18 15:29:09 laptop kernel: BTRFS info (device dm-0): found 27
extents, stage: move data extents
Jan 18 15:29:10 laptop kernel: BTRFS info (device dm-0): found 27
extents, stage: update data pointers
Jan 18 15:29:10 laptop kernel: BTRFS info (device dm-0): relocating
block group 1888129908736 flags data
Jan 18 15:29:12 laptop kernel: BTRFS info (device dm-0): found 22
extents, stage: move data extents
Jan 18 15:29:12 laptop kernel: BTRFS info (device dm-0): found 22
extents, stage: update data pointers
Jan 18 15:29:12 laptop kernel: BTRFS info (device dm-0): relocating
block group 1887056166912 flags data
Jan 18 15:29:14 laptop kernel: BTRFS info (device dm-0): found 51
extents, stage: move data extents
Jan 18 15:29:14 laptop kernel: BTRFS info (device dm-0): found 51
extents, stage: update data pointers
Jan 18 15:29:15 laptop kernel: BTRFS info (device dm-0): relocating
block group 1885982425088 flags data
Jan 18 15:29:16 laptop kernel: BTRFS info (device dm-0): found 59
extents, stage: move data extents
Jan 18 15:29:17 laptop kernel: BTRFS info (device dm-0): found 59
extents, stage: update data pointers
Jan 18 15:29:17 laptop kernel: BTRFS info (device dm-0): relocating
block group 1884908683264 flags data
Jan 18 15:29:19 laptop kernel: BTRFS info (device dm-0): found 27
extents, stage: move data extents
Jan 18 15:29:19 laptop kernel: BTRFS info (device dm-0): found 27
extents, stage: update data pointers
Jan 18 15:29:19 laptop kernel: BTRFS info (device dm-0): relocating
block group 1883834941440 flags data
Jan 18 15:29:21 laptop kernel: BTRFS info (device dm-0): found 23
extents, stage: move data extents
Jan 18 15:29:21 laptop kernel: BTRFS info (device dm-0): found 23
extents, stage: update data pointers
Jan 18 15:29:22 laptop kernel: BTRFS info (device dm-0): relocating
block group 1882761199616 flags data
Jan 18 15:29:24 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: move data extents
Jan 18 15:29:24 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: update data pointers
Jan 18 15:29:24 laptop kernel: BTRFS info (device dm-0): relocating
block group 1881687457792 flags data
Jan 18 15:29:26 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: move data extents
Jan 18 15:29:26 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: update data pointers
Jan 18 15:29:26 laptop kernel: BTRFS info (device dm-0): relocating
block group 1880613715968 flags data
Jan 18 15:29:29 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:29:29 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:29:29 laptop kernel: BTRFS info (device dm-0): relocating
block group 1879539974144 flags data
Jan 18 15:29:31 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:29:31 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:29:32 laptop kernel: BTRFS info (device dm-0): relocating
block group 1878466232320 flags data
Jan 18 15:29:33 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: move data extents
Jan 18 15:29:34 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: update data pointers
Jan 18 15:29:34 laptop kernel: BTRFS info (device dm-0): relocating
block group 1877392490496 flags data
Jan 18 15:29:36 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: move data extents
Jan 18 15:29:36 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: update data pointers
Jan 18 15:29:36 laptop kernel: BTRFS info (device dm-0): relocating
block group 1876318748672 flags data
Jan 18 15:29:38 laptop kernel: BTRFS info (device dm-0): found 22
extents, stage: move data extents
Jan 18 15:29:38 laptop kernel: BTRFS info (device dm-0): found 22
extents, stage: update data pointers
Jan 18 15:29:38 laptop kernel: BTRFS info (device dm-0): relocating
block group 1875245006848 flags data
Jan 18 15:29:40 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: move data extents
Jan 18 15:29:40 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: update data pointers
Jan 18 15:29:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 1874171265024 flags data
Jan 18 15:29:42 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: move data extents
Jan 18 15:29:43 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: update data pointers
Jan 18 15:29:43 laptop kernel: BTRFS info (device dm-0): relocating
block group 1873097523200 flags data
Jan 18 15:29:45 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: move data extents
Jan 18 15:29:45 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: update data pointers
Jan 18 15:29:45 laptop kernel: BTRFS info (device dm-0): relocating
block group 1872023781376 flags data
Jan 18 15:29:47 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:29:47 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:29:47 laptop kernel: BTRFS info (device dm-0): relocating
block group 1870950039552 flags data
Jan 18 15:29:49 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:29:49 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:29:49 laptop kernel: BTRFS info (device dm-0): relocating
block group 1869876297728 flags data
Jan 18 15:29:51 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: move data extents
Jan 18 15:29:52 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: update data pointers
Jan 18 15:29:52 laptop kernel: BTRFS info (device dm-0): relocating
block group 1868802555904 flags data
Jan 18 15:29:54 laptop kernel: BTRFS info (device dm-0): found 24
extents, stage: move data extents
Jan 18 15:29:54 laptop kernel: BTRFS info (device dm-0): found 24
extents, stage: update data pointers
Jan 18 15:29:54 laptop kernel: BTRFS info (device dm-0): relocating
block group 1867728814080 flags data
Jan 18 15:29:56 laptop kernel: BTRFS info (device dm-0): found 23
extents, stage: move data extents
Jan 18 15:29:57 laptop kernel: BTRFS info (device dm-0): found 23
extents, stage: update data pointers
Jan 18 15:29:57 laptop kernel: BTRFS info (device dm-0): relocating
block group 1866655072256 flags data
Jan 18 15:29:59 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: move data extents
Jan 18 15:29:59 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: update data pointers
Jan 18 15:29:59 laptop kernel: BTRFS info (device dm-0): relocating
block group 1865581330432 flags data
Jan 18 15:30:01 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:30:01 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:30:01 laptop kernel: BTRFS info (device dm-0): relocating
block group 1864507588608 flags data
Jan 18 15:30:04 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:30:04 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:30:04 laptop kernel: BTRFS info (device dm-0): relocating
block group 1863433846784 flags data
Jan 18 15:30:06 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:30:06 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:30:06 laptop kernel: BTRFS info (device dm-0): relocating
block group 1862360104960 flags data
Jan 18 15:30:08 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:30:08 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:30:08 laptop kernel: BTRFS info (device dm-0): relocating
block group 1861286363136 flags data
Jan 18 15:30:10 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:30:10 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:30:10 laptop kernel: BTRFS info (device dm-0): relocating
block group 1860212621312 flags data
Jan 18 15:30:12 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: move data extents
Jan 18 15:30:12 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: update data pointers
Jan 18 15:30:12 laptop kernel: BTRFS info (device dm-0): relocating
block group 1859138879488 flags data
Jan 18 15:30:14 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: move data extents
Jan 18 15:30:15 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: update data pointers
Jan 18 15:30:15 laptop kernel: BTRFS info (device dm-0): relocating
block group 1858065137664 flags data
Jan 18 15:30:17 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:30:17 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:30:17 laptop kernel: BTRFS info (device dm-0): relocating
block group 1856991395840 flags data
Jan 18 15:30:19 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: move data extents
Jan 18 15:30:19 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: update data pointers
Jan 18 15:30:19 laptop kernel: BTRFS info (device dm-0): relocating
block group 1855917654016 flags data
Jan 18 15:30:21 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:30:21 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:30:22 laptop kernel: BTRFS info (device dm-0): relocating
block group 1854843912192 flags data
Jan 18 15:30:23 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: move data extents
Jan 18 15:30:24 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: update data pointers
Jan 18 15:30:24 laptop kernel: BTRFS info (device dm-0): relocating
block group 1853770170368 flags data
Jan 18 15:30:26 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: move data extents
Jan 18 15:30:26 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: update data pointers
Jan 18 15:30:26 laptop kernel: BTRFS info (device dm-0): relocating
block group 1852696428544 flags data
Jan 18 15:30:28 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: move data extents
Jan 18 15:30:28 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: update data pointers
Jan 18 15:30:29 laptop kernel: BTRFS info (device dm-0): relocating
block group 1851622686720 flags data
Jan 18 15:30:31 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: move data extents
Jan 18 15:30:31 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: update data pointers
Jan 18 15:30:31 laptop kernel: BTRFS info (device dm-0): relocating
block group 1850548944896 flags data
Jan 18 15:30:33 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:30:33 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:30:34 laptop kernel: BTRFS info (device dm-0): relocating
block group 1849475203072 flags data
Jan 18 15:30:36 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:30:36 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:30:36 laptop kernel: BTRFS info (device dm-0): relocating
block group 1848401461248 flags data
Jan 18 15:30:38 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:30:38 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:30:38 laptop kernel: BTRFS info (device dm-0): relocating
block group 1847327719424 flags data
Jan 18 15:30:40 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:30:40 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:30:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 1846253977600 flags data
Jan 18 15:30:42 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:30:43 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:30:43 laptop kernel: BTRFS info (device dm-0): relocating
block group 1845180235776 flags data
Jan 18 15:30:44 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:30:45 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:30:45 laptop kernel: BTRFS info (device dm-0): relocating
block group 1844106493952 flags data
Jan 18 15:30:46 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:30:47 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:30:47 laptop kernel: BTRFS info (device dm-0): relocating
block group 1843032752128 flags data
Jan 18 15:30:49 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:30:49 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:30:49 laptop kernel: BTRFS info (device dm-0): relocating
block group 1841959010304 flags data
Jan 18 15:30:51 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:30:51 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:30:51 laptop kernel: BTRFS info (device dm-0): relocating
block group 1840885268480 flags data
Jan 18 15:30:53 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:30:54 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:30:54 laptop kernel: BTRFS info (device dm-0): relocating
block group 1839811526656 flags data
Jan 18 15:30:56 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:30:56 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:30:56 laptop kernel: BTRFS info (device dm-0): relocating
block group 1838737784832 flags data
Jan 18 15:30:58 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: move data extents
Jan 18 15:30:58 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: update data pointers
Jan 18 15:30:58 laptop kernel: BTRFS info (device dm-0): relocating
block group 1837664043008 flags data
Jan 18 15:31:00 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:31:00 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:31:00 laptop kernel: BTRFS info (device dm-0): relocating
block group 1836590301184 flags data
Jan 18 15:31:02 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:31:03 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:31:03 laptop kernel: BTRFS info (device dm-0): relocating
block group 1835516559360 flags data
Jan 18 15:31:05 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:31:05 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:31:05 laptop kernel: BTRFS info (device dm-0): relocating
block group 1834442817536 flags data
Jan 18 15:31:07 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:31:07 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:31:07 laptop kernel: BTRFS info (device dm-0): relocating
block group 1833369075712 flags data
Jan 18 15:31:09 laptop kernel: BTRFS info (device dm-0): found 9
extents, stage: move data extents
Jan 18 15:31:09 laptop kernel: BTRFS info (device dm-0): found 9
extents, stage: update data pointers
Jan 18 15:31:10 laptop kernel: BTRFS info (device dm-0): relocating
block group 1832295333888 flags data
Jan 18 15:31:11 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:31:12 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:31:12 laptop kernel: BTRFS info (device dm-0): relocating
block group 1831221592064 flags data
Jan 18 15:31:14 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:31:14 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:31:14 laptop kernel: BTRFS info (device dm-0): relocating
block group 1830147850240 flags data
Jan 18 15:31:16 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:31:16 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:31:16 laptop kernel: BTRFS info (device dm-0): relocating
block group 1829074108416 flags data
Jan 18 15:31:18 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: move data extents
Jan 18 15:31:19 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: update data pointers
Jan 18 15:31:19 laptop kernel: BTRFS info (device dm-0): relocating
block group 1828000366592 flags data
Jan 18 15:31:20 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: move data extents
Jan 18 15:31:21 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: update data pointers
Jan 18 15:31:21 laptop kernel: BTRFS info (device dm-0): relocating
block group 1826926624768 flags data
Jan 18 15:31:23 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:31:23 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:31:23 laptop kernel: BTRFS info (device dm-0): relocating
block group 1825852882944 flags data
Jan 18 15:31:25 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: move data extents
Jan 18 15:31:25 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: update data pointers
Jan 18 15:31:26 laptop kernel: BTRFS info (device dm-0): relocating
block group 1824779141120 flags data
Jan 18 15:31:27 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: move data extents
Jan 18 15:31:28 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: update data pointers
Jan 18 15:31:28 laptop kernel: BTRFS info (device dm-0): relocating
block group 1823705399296 flags data
Jan 18 15:31:30 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:31:30 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:31:30 laptop kernel: BTRFS info (device dm-0): relocating
block group 1822631657472 flags data
Jan 18 15:31:32 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:31:32 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:31:33 laptop kernel: BTRFS info (device dm-0): relocating
block group 1821557915648 flags data
Jan 18 15:31:34 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:31:35 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:31:35 laptop kernel: BTRFS info (device dm-0): relocating
block group 1820484173824 flags data
Jan 18 15:31:37 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: move data extents
Jan 18 15:31:37 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: update data pointers
Jan 18 15:31:37 laptop kernel: BTRFS info (device dm-0): relocating
block group 1819410432000 flags data
Jan 18 15:31:39 laptop kernel: BTRFS info (device dm-0): found 9
extents, stage: move data extents
Jan 18 15:31:39 laptop kernel: BTRFS info (device dm-0): found 9
extents, stage: update data pointers
Jan 18 15:31:39 laptop kernel: BTRFS info (device dm-0): relocating
block group 1818336690176 flags data
Jan 18 15:31:41 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:31:41 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:31:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 1817262948352 flags data
Jan 18 15:31:44 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:31:44 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:31:44 laptop kernel: BTRFS info (device dm-0): relocating
block group 1816189206528 flags data
Jan 18 15:31:46 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:31:46 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:31:46 laptop kernel: BTRFS info (device dm-0): relocating
block group 1815115464704 flags data
Jan 18 15:31:48 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:31:48 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:31:48 laptop kernel: BTRFS info (device dm-0): relocating
block group 1814041722880 flags data
Jan 18 15:31:50 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: move data extents
Jan 18 15:31:50 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: update data pointers
Jan 18 15:31:51 laptop kernel: BTRFS info (device dm-0): relocating
block group 1812967981056 flags data
Jan 18 15:31:52 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:31:53 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:31:53 laptop kernel: BTRFS info (device dm-0): relocating
block group 1811894239232 flags data
Jan 18 15:31:55 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:31:55 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:31:55 laptop kernel: BTRFS info (device dm-0): relocating
block group 1810820497408 flags data
Jan 18 15:31:57 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: move data extents
Jan 18 15:31:58 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: update data pointers
Jan 18 15:31:58 laptop kernel: BTRFS info (device dm-0): relocating
block group 1809746755584 flags data
Jan 18 15:32:00 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: move data extents
Jan 18 15:32:00 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: update data pointers
Jan 18 15:32:01 laptop kernel: BTRFS info (device dm-0): relocating
block group 1808673013760 flags data
Jan 18 15:32:02 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: move data extents
Jan 18 15:32:03 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: update data pointers
Jan 18 15:32:03 laptop kernel: BTRFS info (device dm-0): relocating
block group 1807599271936 flags data
Jan 18 15:32:05 laptop kernel: BTRFS info (device dm-0): found 43
extents, stage: move data extents
Jan 18 15:31:44 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:31:44 laptop kernel: BTRFS info (device dm-0): relocating
block group 1816189206528 flags data
Jan 18 15:31:46 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:31:46 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:31:46 laptop kernel: BTRFS info (device dm-0): relocating
block group 1815115464704 flags data
Jan 18 15:31:48 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:31:48 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:31:48 laptop kernel: BTRFS info (device dm-0): relocating
block group 1814041722880 flags data
Jan 18 15:31:50 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: move data extents
Jan 18 15:31:50 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: update data pointers
Jan 18 15:31:51 laptop kernel: BTRFS info (device dm-0): relocating
block group 1812967981056 flags data
Jan 18 15:31:52 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:31:53 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:31:53 laptop kernel: BTRFS info (device dm-0): relocating
block group 1811894239232 flags data
Jan 18 15:31:55 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:31:55 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:31:55 laptop kernel: BTRFS info (device dm-0): relocating
block group 1810820497408 flags data
Jan 18 15:31:57 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: move data extents
Jan 18 15:31:58 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: update data pointers
Jan 18 15:31:58 laptop kernel: BTRFS info (device dm-0): relocating
block group 1809746755584 flags data
Jan 18 15:32:00 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: move data extents
Jan 18 15:32:00 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: update data pointers
Jan 18 15:32:01 laptop kernel: BTRFS info (device dm-0): relocating
block group 1808673013760 flags data
Jan 18 15:32:02 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: move data extents
Jan 18 15:32:03 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: update data pointers
Jan 18 15:32:03 laptop kernel: BTRFS info (device dm-0): relocating
block group 1807599271936 flags data
Jan 18 15:32:05 laptop kernel: BTRFS info (device dm-0): found 43
extents, stage: move data extents
Jan 18 15:32:06 laptop kernel: BTRFS info (device dm-0): found 43
extents, stage: update data pointers
Jan 18 15:32:06 laptop kernel: BTRFS info (device dm-0): relocating
block group 1806525530112 flags data
Jan 18 15:32:08 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:32:09 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:32:09 laptop kernel: BTRFS info (device dm-0): relocating
block group 1805451788288 flags data
Jan 18 15:32:11 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:32:11 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:32:11 laptop kernel: BTRFS info (device dm-0): relocating
block group 1804378046464 flags data
Jan 18 15:32:13 laptop kernel: BTRFS info (device dm-0): found 23
extents, stage: move data extents
Jan 18 15:32:13 laptop kernel: BTRFS info (device dm-0): found 23
extents, stage: update data pointers
Jan 18 15:32:14 laptop kernel: BTRFS info (device dm-0): relocating
block group 1803304304640 flags data
Jan 18 15:32:16 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: move data extents
Jan 18 15:32:17 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: update data pointers
Jan 18 15:32:18 laptop kernel: BTRFS info (device dm-0): relocating
block group 1802230562816 flags data
Jan 18 15:32:21 laptop kernel: BTRFS info (device dm-0): found 855
extents, stage: move data extents
Jan 18 15:32:23 laptop kernel: BTRFS info (device dm-0): found 855
extents, stage: update data pointers
Jan 18 15:32:24 laptop kernel: BTRFS info (device dm-0): relocating
block group 1801156820992 flags data
Jan 18 15:32:26 laptop kernel: BTRFS info (device dm-0): found 1094
extents, stage: move data extents
Jan 18 15:32:28 laptop kernel: BTRFS info (device dm-0): found 1094
extents, stage: update data pointers
Jan 18 15:32:29 laptop kernel: BTRFS info (device dm-0): relocating
block group 1800083079168 flags data
Jan 18 15:32:31 laptop kernel: BTRFS info (device dm-0): found 1248
extents, stage: move data extents
Jan 18 15:32:33 laptop kernel: BTRFS info (device dm-0): found 1248
extents, stage: update data pointers
Jan 18 15:32:35 laptop kernel: BTRFS info (device dm-0): relocating
block group 1799009337344 flags data
Jan 18 15:32:36 laptop kernel: BTRFS info (device dm-0): found 1186
extents, stage: move data extents
Jan 18 15:32:38 laptop kernel: BTRFS info (device dm-0): found 1186
extents, stage: update data pointers
Jan 18 15:32:40 laptop kernel: BTRFS info (device dm-0): relocating
block group 1797935595520 flags data
Jan 18 15:32:41 laptop kernel: BTRFS info (device dm-0): found 975
extents, stage: move data extents
Jan 18 15:32:44 laptop kernel: BTRFS info (device dm-0): found 975
extents, stage: update data pointers
Jan 18 15:32:45 laptop kernel: BTRFS info (device dm-0): relocating
block group 1796861853696 flags data
Jan 18 15:32:47 laptop kernel: BTRFS info (device dm-0): found 24
extents, stage: move data extents
Jan 18 15:32:47 laptop kernel: BTRFS info (device dm-0): found 24
extents, stage: update data pointers
Jan 18 15:32:48 laptop kernel: BTRFS info (device dm-0): relocating
block group 1795788111872 flags data
Jan 18 15:32:50 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:32:50 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:32:51 laptop kernel: BTRFS info (device dm-0): relocating
block group 1794714370048 flags data
Jan 18 15:32:53 laptop kernel: BTRFS info (device dm-0): found 906
extents, stage: move data extents
Jan 18 15:32:55 laptop kernel: BTRFS info (device dm-0): found 906
extents, stage: update data pointers
Jan 18 15:32:56 laptop kernel: BTRFS info (device dm-0): relocating
block group 1793640628224 flags data
Jan 18 15:32:58 laptop kernel: BTRFS info (device dm-0): found 784
extents, stage: move data extents
Jan 18 15:32:59 laptop kernel: BTRFS info (device dm-0): found 784
extents, stage: update data pointers
Jan 18 15:33:00 laptop kernel: BTRFS info (device dm-0): relocating
block group 1792566886400 flags data
Jan 18 15:33:02 laptop kernel: BTRFS info (device dm-0): found 22
extents, stage: move data extents
Jan 18 15:33:02 laptop kernel: BTRFS info (device dm-0): found 22
extents, stage: update data pointers
Jan 18 15:33:03 laptop kernel: BTRFS info (device dm-0): relocating
block group 1791493144576 flags data
Jan 18 15:33:05 laptop kernel: BTRFS info (device dm-0): found 830
extents, stage: move data extents
Jan 18 15:33:07 laptop kernel: BTRFS info (device dm-0): found 830
extents, stage: update data pointers
Jan 18 15:33:08 laptop kernel: BTRFS info (device dm-0): relocating
block group 1790419402752 flags data
Jan 18 15:33:09 laptop kernel: BTRFS info (device dm-0): found 42
extents, stage: move data extents
Jan 18 15:33:10 laptop kernel: BTRFS info (device dm-0): found 42
extents, stage: update data pointers
Jan 18 15:33:10 laptop kernel: BTRFS info (device dm-0): relocating
block group 1789345660928 flags data
Jan 18 15:33:12 laptop kernel: BTRFS info (device dm-0): found 29
extents, stage: move data extents
Jan 18 15:33:12 laptop kernel: BTRFS info (device dm-0): found 29
extents, stage: update data pointers
Jan 18 15:33:13 laptop kernel: BTRFS info (device dm-0): relocating
block group 1788271919104 flags data
Jan 18 15:33:15 laptop kernel: BTRFS info (device dm-0): found 779
extents, stage: move data extents
Jan 18 15:33:17 laptop kernel: BTRFS info (device dm-0): found 779
extents, stage: update data pointers
Jan 18 15:33:18 laptop kernel: BTRFS info (device dm-0): relocating
block group 1787198177280 flags data
Jan 18 15:33:19 laptop kernel: BTRFS info (device dm-0): found 26
extents, stage: move data extents
Jan 18 15:33:19 laptop kernel: BTRFS info (device dm-0): found 26
extents, stage: update data pointers
Jan 18 15:33:20 laptop kernel: BTRFS info (device dm-0): relocating
block group 1786124435456 flags data
Jan 18 15:33:21 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: move data extents
Jan 18 15:33:21 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: update data pointers
Jan 18 15:33:22 laptop kernel: BTRFS info (device dm-0): relocating
block group 1785050693632 flags data
Jan 18 15:33:23 laptop kernel: BTRFS info (device dm-0): found 31
extents, stage: move data extents
Jan 18 15:33:24 laptop kernel: BTRFS info (device dm-0): found 31
extents, stage: update data pointers
Jan 18 15:33:24 laptop kernel: BTRFS info (device dm-0): relocating
block group 1783976951808 flags data
Jan 18 15:33:26 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: move data extents
Jan 18 15:33:26 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: update data pointers
Jan 18 15:33:27 laptop kernel: BTRFS info (device dm-0): relocating
block group 1782903209984 flags data
Jan 18 15:33:27 laptop kernel: perf: interrupt took too long (3138 >
3132), lowering kernel.perf_event_max_sample_rate to 63600
Jan 18 15:33:28 laptop kernel: BTRFS info (device dm-0): found 689
extents, stage: move data extents
Jan 18 15:33:30 laptop kernel: BTRFS info (device dm-0): found 689
extents, stage: update data pointers
Jan 18 15:33:30 laptop kernel: BTRFS info (device dm-0): relocating
block group 1781829468160 flags data
Jan 18 15:33:32 laptop kernel: BTRFS info (device dm-0): found 30
extents, stage: move data extents
Jan 18 15:33:33 laptop kernel: BTRFS info (device dm-0): found 30
extents, stage: update data pointers
Jan 18 15:33:33 laptop kernel: BTRFS info (device dm-0): relocating
block group 1780755726336 flags data
Jan 18 15:33:35 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: move data extents
Jan 18 15:33:35 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: update data pointers
Jan 18 15:33:35 laptop kernel: BTRFS info (device dm-0): relocating
block group 1779681984512 flags data
Jan 18 15:33:37 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: move data extents
Jan 18 15:33:37 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: update data pointers
Jan 18 15:33:38 laptop kernel: BTRFS info (device dm-0): relocating
block group 1778608242688 flags data
Jan 18 15:33:39 laptop kernel: BTRFS info (device dm-0): found 1018
extents, stage: move data extents
Jan 18 15:33:41 laptop kernel: BTRFS info (device dm-0): found 1018
extents, stage: update data pointers
Jan 18 15:33:42 laptop kernel: BTRFS info (device dm-0): relocating
block group 1777534500864 flags data
Jan 18 15:33:44 laptop kernel: BTRFS info (device dm-0): found 37
extents, stage: move data extents
Jan 18 15:33:44 laptop kernel: BTRFS info (device dm-0): found 37
extents, stage: update data pointers
Jan 18 15:33:44 laptop kernel: BTRFS info (device dm-0): relocating
block group 1776460759040 flags data
Jan 18 15:33:46 laptop kernel: BTRFS info (device dm-0): found 1116
extents, stage: move data extents
Jan 18 15:33:48 laptop kernel: BTRFS info (device dm-0): found 1116
extents, stage: update data pointers
Jan 18 15:33:50 laptop kernel: BTRFS info (device dm-0): relocating
block group 1775387017216 flags data
Jan 18 15:33:51 laptop kernel: BTRFS info (device dm-0): found 42
extents, stage: move data extents
Jan 18 15:33:52 laptop kernel: BTRFS info (device dm-0): found 42
extents, stage: update data pointers
Jan 18 15:33:52 laptop kernel: BTRFS info (device dm-0): relocating
block group 1774313275392 flags data
Jan 18 15:33:54 laptop kernel: BTRFS info (device dm-0): found 846
extents, stage: move data extents
Jan 18 15:33:56 laptop kernel: BTRFS info (device dm-0): found 846
extents, stage: update data pointers
Jan 18 15:33:58 laptop kernel: BTRFS info (device dm-0): relocating
block group 1773239533568 flags data
Jan 18 15:34:00 laptop kernel: BTRFS info (device dm-0): found 1175
extents, stage: move data extents
Jan 18 15:34:01 laptop kernel: BTRFS info (device dm-0): found 1175
extents, stage: update data pointers
Jan 18 15:34:02 laptop kernel: BTRFS info (device dm-0): relocating
block group 1772165791744 flags data
Jan 18 15:34:05 laptop kernel: BTRFS info (device dm-0): found 64785
extents, stage: move data extents
Jan 18 15:34:29 laptop kernel: BTRFS info (device dm-0): found 64785
extents, stage: update data pointers
Jan 18 15:34:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 1771092049920 flags data
Jan 18 15:34:43 laptop kernel: BTRFS info (device dm-0): found 1382
extents, stage: move data extents
Jan 18 15:34:45 laptop kernel: BTRFS info (device dm-0): found 1382
extents, stage: update data pointers
Jan 18 15:34:46 laptop kernel: BTRFS info (device dm-0): relocating
block group 1770018308096 flags data
Jan 18 15:34:47 laptop kernel: BTRFS info (device dm-0): found 935
extents, stage: move data extents
Jan 18 15:34:49 laptop kernel: BTRFS info (device dm-0): found 935
extents, stage: update data pointers
Jan 18 15:34:51 laptop kernel: BTRFS info (device dm-0): relocating
block group 1768944566272 flags data
Jan 18 15:34:52 laptop kernel: BTRFS info (device dm-0): found 46
extents, stage: move data extents
Jan 18 15:34:53 laptop kernel: BTRFS info (device dm-0): found 46
extents, stage: update data pointers
Jan 18 15:34:54 laptop kernel: BTRFS info (device dm-0): relocating
block group 1767870824448 flags data
Jan 18 15:34:55 laptop kernel: BTRFS info (device dm-0): found 25
extents, stage: move data extents
Jan 18 15:34:55 laptop kernel: BTRFS info (device dm-0): found 25
extents, stage: update data pointers
Jan 18 15:34:56 laptop kernel: BTRFS info (device dm-0): relocating
block group 1766797082624 flags data
Jan 18 15:34:58 laptop kernel: BTRFS info (device dm-0): found 34679
extents, stage: move data extents
Jan 18 15:35:07 laptop kernel: BTRFS info (device dm-0): found 34679
extents, stage: update data pointers
Jan 18 15:35:12 laptop kernel: BTRFS info (device dm-0): relocating
block group 1765723340800 flags data
Jan 18 15:35:14 laptop kernel: BTRFS info (device dm-0): found 59
extents, stage: move data extents
Jan 18 15:35:14 laptop kernel: BTRFS info (device dm-0): found 59
extents, stage: update data pointers
Jan 18 15:35:14 laptop kernel: BTRFS info (device dm-0): relocating
block group 1764649598976 flags data
Jan 18 15:35:16 laptop kernel: BTRFS info (device dm-0): found 45
extents, stage: move data extents
Jan 18 15:35:16 laptop kernel: BTRFS info (device dm-0): found 45
extents, stage: update data pointers
Jan 18 15:35:17 laptop kernel: BTRFS info (device dm-0): relocating
block group 1763575857152 flags data
Jan 18 15:35:18 laptop kernel: BTRFS info (device dm-0): found 702
extents, stage: move data extents
Jan 18 15:35:20 laptop kernel: BTRFS info (device dm-0): found 702
extents, stage: update data pointers
Jan 18 15:35:21 laptop kernel: BTRFS info (device dm-0): relocating
block group 1762502115328 flags data
Jan 18 15:35:23 laptop kernel: BTRFS info (device dm-0): found 28198
extents, stage: move data extents
Jan 18 15:35:32 laptop kernel: BTRFS info (device dm-0): found 28198
extents, stage: update data pointers
Jan 18 15:35:37 laptop kernel: BTRFS info (device dm-0): relocating
block group 1761428373504 flags data
Jan 18 15:35:39 laptop kernel: BTRFS info (device dm-0): found 1336
extents, stage: move data extents
Jan 18 15:35:41 laptop kernel: BTRFS info (device dm-0): found 1336
extents, stage: update data pointers
Jan 18 15:35:42 laptop kernel: BTRFS info (device dm-0): relocating
block group 1760354631680 flags data
Jan 18 15:35:43 laptop kernel: BTRFS info (device dm-0): found 1102
extents, stage: move data extents
Jan 18 15:35:45 laptop kernel: BTRFS info (device dm-0): found 1102
extents, stage: update data pointers
Jan 18 15:35:46 laptop kernel: BTRFS info (device dm-0): relocating
block group 1759280889856 flags data
Jan 18 15:35:48 laptop kernel: BTRFS info (device dm-0): found 1221
extents, stage: move data extents
Jan 18 15:35:49 laptop kernel: BTRFS info (device dm-0): found 1221
extents, stage: update data pointers
Jan 18 15:35:51 laptop kernel: BTRFS info (device dm-0): relocating
block group 1758207148032 flags data
Jan 18 15:35:53 laptop kernel: BTRFS info (device dm-0): found 29477
extents, stage: move data extents
Jan 18 15:36:02 laptop kernel: BTRFS info (device dm-0): found 29477
extents, stage: update data pointers
Jan 18 15:36:07 laptop kernel: BTRFS info (device dm-0): relocating
block group 1757133406208 flags data
Jan 18 15:36:09 laptop kernel: BTRFS info (device dm-0): found 37
extents, stage: move data extents
Jan 18 15:36:09 laptop kernel: BTRFS info (device dm-0): found 37
extents, stage: update data pointers
Jan 18 15:36:09 laptop kernel: BTRFS info (device dm-0): relocating
block group 1756059664384 flags data
Jan 18 15:36:11 laptop kernel: BTRFS info (device dm-0): found 1230
extents, stage: move data extents
Jan 18 15:36:12 laptop kernel: BTRFS info (device dm-0): found 1230
extents, stage: update data pointers
Jan 18 15:36:13 laptop kernel: BTRFS info (device dm-0): relocating
block group 1754985922560 flags data
Jan 18 15:36:15 laptop kernel: BTRFS info (device dm-0): found 760
extents, stage: move data extents
Jan 18 15:36:15 laptop kernel: BTRFS info (device dm-0): found 760
extents, stage: update data pointers
Jan 18 15:36:16 laptop kernel: BTRFS info (device dm-0): relocating
block group 1753912180736 flags data
Jan 18 15:36:17 laptop kernel: BTRFS info (device dm-0): found 551
extents, stage: move data extents
Jan 18 15:36:18 laptop kernel: BTRFS info (device dm-0): found 551
extents, stage: update data pointers
Jan 18 15:36:19 laptop kernel: BTRFS info (device dm-0): relocating
block group 1752838438912 flags data
Jan 18 15:36:20 laptop kernel: BTRFS info (device dm-0): found 704
extents, stage: move data extents
Jan 18 15:36:21 laptop kernel: BTRFS info (device dm-0): found 704
extents, stage: update data pointers
Jan 18 15:36:22 laptop kernel: BTRFS info (device dm-0): relocating
block group 1751764697088 flags data
Jan 18 15:36:24 laptop kernel: BTRFS info (device dm-0): found 1227
extents, stage: move data extents
Jan 18 15:36:26 laptop kernel: BTRFS info (device dm-0): found 1227
extents, stage: update data pointers
Jan 18 15:36:27 laptop kernel: BTRFS info (device dm-0): relocating
block group 1750690955264 flags data
Jan 18 15:36:28 laptop kernel: BTRFS info (device dm-0): found 27
extents, stage: move data extents
Jan 18 15:36:29 laptop kernel: BTRFS info (device dm-0): found 27
extents, stage: update data pointers
Jan 18 15:36:29 laptop kernel: BTRFS info (device dm-0): relocating
block group 1749617213440 flags data
Jan 18 15:36:31 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: move data extents
Jan 18 15:36:32 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: update data pointers
Jan 18 15:36:33 laptop kernel: BTRFS info (device dm-0): relocating
block group 1748543471616 flags data
Jan 18 15:36:35 laptop kernel: BTRFS info (device dm-0): found 1230
extents, stage: move data extents
Jan 18 15:36:36 laptop kernel: BTRFS info (device dm-0): found 1230
extents, stage: update data pointers
Jan 18 15:36:37 laptop kernel: BTRFS info (device dm-0): relocating
block group 1747469729792 flags data
Jan 18 15:36:39 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: move data extents
Jan 18 15:36:39 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: update data pointers
Jan 18 15:36:39 laptop kernel: BTRFS info (device dm-0): relocating
block group 1746395987968 flags data
Jan 18 15:36:41 laptop kernel: BTRFS info (device dm-0): found 48
extents, stage: move data extents
Jan 18 15:36:41 laptop kernel: BTRFS info (device dm-0): found 48
extents, stage: update data pointers
Jan 18 15:36:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 1745322246144 flags data
Jan 18 15:36:44 laptop kernel: BTRFS info (device dm-0): found 42929
extents, stage: move data extents
Jan 18 15:36:57 laptop kernel: BTRFS info (device dm-0): found 42929
extents, stage: update data pointers
Jan 18 15:37:05 laptop kernel: BTRFS info (device dm-0): relocating
block group 1744248504320 flags data
Jan 18 15:37:06 laptop kernel: BTRFS info (device dm-0): found 728
extents, stage: move data extents
Jan 18 15:37:07 laptop kernel: BTRFS info (device dm-0): found 728
extents, stage: update data pointers
Jan 18 15:37:08 laptop kernel: BTRFS info (device dm-0): relocating
block group 1743174762496 flags data
Jan 18 15:37:10 laptop kernel: BTRFS info (device dm-0): found 36
extents, stage: move data extents
Jan 18 15:37:10 laptop kernel: BTRFS info (device dm-0): found 36
extents, stage: update data pointers
Jan 18 15:37:10 laptop kernel: BTRFS info (device dm-0): relocating
block group 1742101020672 flags data
Jan 18 15:37:11 laptop kernel: BTRFS info (device dm-0): found 29
extents, stage: move data extents
Jan 18 15:37:12 laptop kernel: BTRFS info (device dm-0): found 29
extents, stage: update data pointers
Jan 18 15:37:12 laptop kernel: BTRFS info (device dm-0): relocating
block group 1741027278848 flags data
Jan 18 15:37:13 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: move data extents
Jan 18 15:37:13 laptop kernel: BTRFS info (device dm-0): found 15
extents, stage: update data pointers
Jan 18 15:37:14 laptop kernel: BTRFS info (device dm-0): relocating
block group 1739953537024 flags data
Jan 18 15:37:15 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:37:15 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:37:16 laptop kernel: BTRFS info (device dm-0): relocating
block group 1738879795200 flags data
Jan 18 15:37:17 laptop kernel: BTRFS info (device dm-0): found 28
extents, stage: move data extents
Jan 18 15:37:18 laptop kernel: BTRFS info (device dm-0): found 28
extents, stage: update data pointers
Jan 18 15:37:18 laptop kernel: BTRFS info (device dm-0): relocating
block group 1737806053376 flags data
Jan 18 15:37:20 laptop kernel: BTRFS info (device dm-0): found 41
extents, stage: move data extents
Jan 18 15:37:20 laptop kernel: BTRFS info (device dm-0): found 41
extents, stage: update data pointers
Jan 18 15:37:20 laptop kernel: BTRFS info (device dm-0): relocating
block group 1736732311552 flags data
Jan 18 15:37:22 laptop kernel: BTRFS info (device dm-0): found 261
extents, stage: move data extents
Jan 18 15:37:23 laptop kernel: BTRFS info (device dm-0): found 261
extents, stage: update data pointers
Jan 18 15:37:23 laptop kernel: BTRFS info (device dm-0): relocating
block group 1735658569728 flags data
Jan 18 15:37:25 laptop kernel: BTRFS info (device dm-0): found 60
extents, stage: move data extents
Jan 18 15:37:25 laptop kernel: BTRFS info (device dm-0): found 60
extents, stage: update data pointers
Jan 18 15:37:26 laptop kernel: BTRFS info (device dm-0): relocating
block group 1734584827904 flags data
Jan 18 15:37:27 laptop kernel: BTRFS info (device dm-0): found 82
extents, stage: move data extents
Jan 18 15:37:28 laptop kernel: BTRFS info (device dm-0): found 82
extents, stage: update data pointers
Jan 18 15:37:28 laptop kernel: BTRFS info (device dm-0): relocating
block group 1733511086080 flags data
Jan 18 15:37:30 laptop kernel: BTRFS info (device dm-0): found 99
extents, stage: move data extents
Jan 18 15:37:30 laptop kernel: BTRFS info (device dm-0): found 99
extents, stage: update data pointers
Jan 18 15:37:30 laptop kernel: BTRFS info (device dm-0): relocating
block group 1732437344256 flags data
Jan 18 15:37:32 laptop kernel: BTRFS info (device dm-0): found 96
extents, stage: move data extents
Jan 18 15:37:32 laptop kernel: BTRFS info (device dm-0): found 96
extents, stage: update data pointers
Jan 18 15:37:32 laptop kernel: BTRFS info (device dm-0): relocating
block group 1731363602432 flags data
Jan 18 15:37:34 laptop kernel: BTRFS info (device dm-0): found 163
extents, stage: move data extents
Jan 18 15:37:34 laptop kernel: BTRFS info (device dm-0): found 163
extents, stage: update data pointers
Jan 18 15:37:34 laptop kernel: BTRFS info (device dm-0): relocating
block group 1730289860608 flags data
Jan 18 15:37:36 laptop kernel: BTRFS info (device dm-0): found 91
extents, stage: move data extents
Jan 18 15:37:36 laptop kernel: BTRFS info (device dm-0): found 91
extents, stage: update data pointers
Jan 18 15:37:36 laptop kernel: BTRFS info (device dm-0): relocating
block group 1729216118784 flags data
Jan 18 15:37:38 laptop kernel: BTRFS info (device dm-0): found 93
extents, stage: move data extents
Jan 18 15:37:38 laptop kernel: BTRFS info (device dm-0): found 93
extents, stage: update data pointers
Jan 18 15:37:39 laptop kernel: BTRFS info (device dm-0): relocating
block group 1728142376960 flags data
Jan 18 15:37:40 laptop kernel: BTRFS info (device dm-0): found 91
extents, stage: move data extents
Jan 18 15:37:41 laptop kernel: BTRFS info (device dm-0): found 91
extents, stage: update data pointers
Jan 18 15:37:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 1727068635136 flags data
Jan 18 15:37:42 laptop kernel: BTRFS info (device dm-0): found 90
extents, stage: move data extents
Jan 18 15:37:43 laptop kernel: BTRFS info (device dm-0): found 90
extents, stage: update data pointers
Jan 18 15:37:43 laptop kernel: BTRFS info (device dm-0): relocating
block group 1725994893312 flags data
Jan 18 15:37:45 laptop kernel: BTRFS info (device dm-0): found 54
extents, stage: move data extents
Jan 18 15:37:45 laptop kernel: BTRFS info (device dm-0): found 54
extents, stage: update data pointers
Jan 18 15:37:45 laptop kernel: BTRFS info (device dm-0): relocating
block group 1724921151488 flags data
Jan 18 15:37:47 laptop kernel: BTRFS info (device dm-0): found 172
extents, stage: move data extents
Jan 18 15:37:47 laptop kernel: BTRFS info (device dm-0): found 172
extents, stage: update data pointers
Jan 18 15:37:47 laptop kernel: BTRFS info (device dm-0): relocating
block group 1723847409664 flags data
Jan 18 15:37:49 laptop kernel: BTRFS info (device dm-0): found 51
extents, stage: move data extents
Jan 18 15:37:49 laptop kernel: BTRFS info (device dm-0): found 51
extents, stage: update data pointers
Jan 18 15:37:49 laptop kernel: BTRFS info (device dm-0): relocating
block group 1722773667840 flags data
Jan 18 15:37:51 laptop kernel: BTRFS info (device dm-0): found 62
extents, stage: move data extents
Jan 18 15:37:51 laptop kernel: BTRFS info (device dm-0): found 62
extents, stage: update data pointers
Jan 18 15:37:51 laptop kernel: BTRFS info (device dm-0): relocating
block group 1721699926016 flags data
Jan 18 15:37:53 laptop kernel: BTRFS info (device dm-0): found 100
extents, stage: move data extents
Jan 18 15:37:54 laptop kernel: BTRFS info (device dm-0): found 100
extents, stage: update data pointers
Jan 18 15:37:54 laptop kernel: BTRFS info (device dm-0): relocating
block group 1720626184192 flags data
Jan 18 15:37:56 laptop kernel: BTRFS info (device dm-0): found 168
extents, stage: move data extents
Jan 18 15:37:56 laptop kernel: BTRFS info (device dm-0): found 168
extents, stage: update data pointers
Jan 18 15:37:56 laptop kernel: BTRFS info (device dm-0): relocating
block group 1719552442368 flags data
Jan 18 15:37:58 laptop kernel: BTRFS info (device dm-0): found 175
extents, stage: move data extents
Jan 18 15:37:58 laptop kernel: BTRFS info (device dm-0): found 175
extents, stage: update data pointers
Jan 18 15:37:58 laptop kernel: BTRFS info (device dm-0): relocating
block group 1718478700544 flags data
Jan 18 15:38:00 laptop kernel: BTRFS info (device dm-0): found 84
extents, stage: move data extents
Jan 18 15:38:00 laptop kernel: BTRFS info (device dm-0): found 84
extents, stage: update data pointers
Jan 18 15:38:01 laptop kernel: BTRFS info (device dm-0): relocating
block group 1717404958720 flags data
Jan 18 15:38:03 laptop kernel: BTRFS info (device dm-0): found 75
extents, stage: move data extents
Jan 18 15:38:03 laptop kernel: BTRFS info (device dm-0): found 75
extents, stage: update data pointers
Jan 18 15:38:03 laptop kernel: BTRFS info (device dm-0): relocating
block group 1716331216896 flags data
Jan 18 15:38:05 laptop kernel: BTRFS info (device dm-0): found 57
extents, stage: move data extents
Jan 18 15:38:05 laptop kernel: BTRFS info (device dm-0): found 57
extents, stage: update data pointers
Jan 18 15:38:05 laptop kernel: BTRFS info (device dm-0): relocating
block group 1715257475072 flags data
Jan 18 15:38:07 laptop kernel: BTRFS info (device dm-0): found 59
extents, stage: move data extents
Jan 18 15:38:07 laptop kernel: BTRFS info (device dm-0): found 59
extents, stage: update data pointers
Jan 18 15:38:07 laptop kernel: BTRFS info (device dm-0): relocating
block group 1714183733248 flags data
Jan 18 15:38:10 laptop kernel: BTRFS info (device dm-0): found 61
extents, stage: move data extents
Jan 18 15:38:10 laptop kernel: BTRFS info (device dm-0): found 61
extents, stage: update data pointers
Jan 18 15:38:10 laptop kernel: BTRFS info (device dm-0): relocating
block group 1713109991424 flags data
Jan 18 15:38:12 laptop kernel: BTRFS info (device dm-0): found 62
extents, stage: move data extents
Jan 18 15:38:12 laptop kernel: BTRFS info (device dm-0): found 62
extents, stage: update data pointers
Jan 18 15:38:12 laptop kernel: BTRFS info (device dm-0): relocating
block group 1712036249600 flags data
Jan 18 15:38:14 laptop kernel: BTRFS info (device dm-0): found 59
extents, stage: move data extents
Jan 18 15:38:14 laptop kernel: BTRFS info (device dm-0): found 59
extents, stage: update data pointers
Jan 18 15:38:14 laptop kernel: BTRFS info (device dm-0): relocating
block group 1710962507776 flags data
Jan 18 15:38:16 laptop kernel: BTRFS info (device dm-0): found 59
extents, stage: move data extents
Jan 18 15:38:16 laptop kernel: BTRFS info (device dm-0): found 59
extents, stage: update data pointers
Jan 18 15:38:16 laptop kernel: BTRFS info (device dm-0): relocating
block group 1709888765952 flags data
Jan 18 15:38:18 laptop kernel: BTRFS info (device dm-0): found 64
extents, stage: move data extents
Jan 18 15:38:18 laptop kernel: BTRFS info (device dm-0): found 64
extents, stage: update data pointers
Jan 18 15:38:19 laptop kernel: BTRFS info (device dm-0): relocating
block group 1708815024128 flags data
Jan 18 15:38:20 laptop kernel: BTRFS info (device dm-0): found 61
extents, stage: move data extents
Jan 18 15:38:21 laptop kernel: BTRFS info (device dm-0): found 61
extents, stage: update data pointers
Jan 18 15:38:21 laptop kernel: BTRFS info (device dm-0): relocating
block group 1707741282304 flags data
Jan 18 15:38:22 laptop kernel: BTRFS info (device dm-0): found 62
extents, stage: move data extents
Jan 18 15:38:23 laptop kernel: BTRFS info (device dm-0): found 62
extents, stage: update data pointers
Jan 18 15:38:23 laptop kernel: BTRFS info (device dm-0): relocating
block group 1706667540480 flags data
Jan 18 15:38:25 laptop kernel: BTRFS info (device dm-0): found 62
extents, stage: move data extents
Jan 18 15:38:25 laptop kernel: BTRFS info (device dm-0): found 62
extents, stage: update data pointers
Jan 18 15:38:25 laptop kernel: BTRFS info (device dm-0): relocating
block group 1705593798656 flags data
Jan 18 15:38:27 laptop kernel: BTRFS info (device dm-0): found 62
extents, stage: move data extents
Jan 18 15:38:27 laptop kernel: BTRFS info (device dm-0): found 62
extents, stage: update data pointers
Jan 18 15:38:27 laptop kernel: BTRFS info (device dm-0): relocating
block group 1704520056832 flags data
Jan 18 15:38:29 laptop kernel: BTRFS info (device dm-0): found 276
extents, stage: move data extents
Jan 18 15:38:29 laptop kernel: BTRFS info (device dm-0): found 276
extents, stage: update data pointers
Jan 18 15:38:30 laptop kernel: BTRFS info (device dm-0): relocating
block group 1703446315008 flags data
Jan 18 15:38:31 laptop kernel: BTRFS info (device dm-0): found 61
extents, stage: move data extents
Jan 18 15:38:32 laptop kernel: BTRFS info (device dm-0): found 61
extents, stage: update data pointers
Jan 18 15:38:32 laptop kernel: BTRFS info (device dm-0): relocating
block group 1702372573184 flags data
Jan 18 15:38:34 laptop kernel: BTRFS info (device dm-0): found 57
extents, stage: move data extents
Jan 18 15:38:34 laptop kernel: BTRFS info (device dm-0): found 57
extents, stage: update data pointers
Jan 18 15:38:34 laptop kernel: BTRFS info (device dm-0): relocating
block group 1701298831360 flags data
Jan 18 15:38:36 laptop kernel: BTRFS info (device dm-0): found 54
extents, stage: move data extents
Jan 18 15:38:36 laptop kernel: BTRFS info (device dm-0): found 54
extents, stage: update data pointers
Jan 18 15:38:36 laptop kernel: BTRFS info (device dm-0): relocating
block group 1700225089536 flags data
Jan 18 15:38:38 laptop kernel: BTRFS info (device dm-0): found 68
extents, stage: move data extents
Jan 18 15:38:38 laptop kernel: BTRFS info (device dm-0): found 68
extents, stage: update data pointers
Jan 18 15:38:38 laptop kernel: BTRFS info (device dm-0): relocating
block group 1699151347712 flags data
Jan 18 15:38:40 laptop kernel: BTRFS info (device dm-0): found 56
extents, stage: move data extents
Jan 18 15:38:40 laptop kernel: BTRFS info (device dm-0): found 56
extents, stage: update data pointers
Jan 18 15:38:40 laptop kernel: BTRFS info (device dm-0): relocating
block group 1698077605888 flags data
Jan 18 15:38:42 laptop kernel: BTRFS info (device dm-0): found 1041
extents, stage: move data extents
Jan 18 15:38:43 laptop kernel: BTRFS info (device dm-0): found 1041
extents, stage: update data pointers
Jan 18 15:38:44 laptop kernel: BTRFS info (device dm-0): relocating
block group 1697003864064 flags data
Jan 18 15:38:46 laptop kernel: BTRFS info (device dm-0): found 55
extents, stage: move data extents
Jan 18 15:38:46 laptop kernel: BTRFS info (device dm-0): found 55
extents, stage: update data pointers
Jan 18 15:38:46 laptop kernel: BTRFS info (device dm-0): relocating
block group 1695930122240 flags data
Jan 18 15:38:48 laptop kernel: BTRFS info (device dm-0): found 51
extents, stage: move data extents
Jan 18 15:38:48 laptop kernel: BTRFS info (device dm-0): found 51
extents, stage: update data pointers
Jan 18 15:38:48 laptop kernel: BTRFS info (device dm-0): relocating
block group 1694856380416 flags data
Jan 18 15:38:50 laptop kernel: BTRFS info (device dm-0): found 58
extents, stage: move data extents
Jan 18 15:38:50 laptop kernel: BTRFS info (device dm-0): found 58
extents, stage: update data pointers
Jan 18 15:38:51 laptop kernel: BTRFS info (device dm-0): relocating
block group 1693782638592 flags data
Jan 18 15:38:53 laptop kernel: BTRFS info (device dm-0): found 878
extents, stage: move data extents
Jan 18 15:38:53 laptop kernel: BTRFS info (device dm-0): found 878
extents, stage: update data pointers
Jan 18 15:38:54 laptop kernel: BTRFS info (device dm-0): relocating
block group 1692708896768 flags data
Jan 18 15:38:56 laptop kernel: BTRFS info (device dm-0): found 67
extents, stage: move data extents
Jan 18 15:38:56 laptop kernel: BTRFS info (device dm-0): found 67
extents, stage: update data pointers
Jan 18 15:38:56 laptop kernel: BTRFS info (device dm-0): relocating
block group 1691635154944 flags data
Jan 18 15:38:58 laptop kernel: BTRFS info (device dm-0): found 71
extents, stage: move data extents
Jan 18 15:38:58 laptop kernel: BTRFS info (device dm-0): found 71
extents, stage: update data pointers
Jan 18 15:38:58 laptop kernel: BTRFS info (device dm-0): relocating
block group 1690561413120 flags data
Jan 18 15:39:00 laptop kernel: BTRFS info (device dm-0): found 72
extents, stage: move data extents
Jan 18 15:39:01 laptop kernel: BTRFS info (device dm-0): found 72
extents, stage: update data pointers
Jan 18 15:39:01 laptop kernel: BTRFS info (device dm-0): relocating
block group 1689487671296 flags data
Jan 18 15:39:02 laptop kernel: BTRFS info (device dm-0): found 66
extents, stage: move data extents
Jan 18 15:39:03 laptop kernel: BTRFS info (device dm-0): found 66
extents, stage: update data pointers
Jan 18 15:39:03 laptop kernel: BTRFS info (device dm-0): relocating
block group 1688413929472 flags data
Jan 18 15:39:05 laptop kernel: BTRFS info (device dm-0): found 66
extents, stage: move data extents
Jan 18 15:39:05 laptop kernel: BTRFS info (device dm-0): found 66
extents, stage: update data pointers
Jan 18 15:39:05 laptop kernel: BTRFS info (device dm-0): relocating
block group 1687340187648 flags data
Jan 18 15:39:07 laptop kernel: BTRFS info (device dm-0): found 71
extents, stage: move data extents
Jan 18 15:39:07 laptop kernel: BTRFS info (device dm-0): found 71
extents, stage: update data pointers
Jan 18 15:39:07 laptop kernel: BTRFS info (device dm-0): relocating
block group 1686266445824 flags data
Jan 18 15:39:09 laptop kernel: BTRFS info (device dm-0): found 71
extents, stage: move data extents
Jan 18 15:39:09 laptop kernel: BTRFS info (device dm-0): found 71
extents, stage: update data pointers
Jan 18 15:39:10 laptop kernel: BTRFS info (device dm-0): relocating
block group 1685192704000 flags data
Jan 18 15:39:11 laptop kernel: BTRFS info (device dm-0): found 75
extents, stage: move data extents
Jan 18 15:39:12 laptop kernel: BTRFS info (device dm-0): found 75
extents, stage: update data pointers
Jan 18 15:39:12 laptop kernel: BTRFS info (device dm-0): relocating
block group 1684118962176 flags data
Jan 18 15:39:13 laptop kernel: BTRFS info (device dm-0): found 1446
extents, stage: move data extents
Jan 18 15:39:14 laptop kernel: BTRFS info (device dm-0): found 1446
extents, stage: update data pointers
Jan 18 15:39:14 laptop kernel: BTRFS info (device dm-0): relocating
block group 1683045220352 flags data
Jan 18 15:39:16 laptop kernel: BTRFS info (device dm-0): found 63
extents, stage: move data extents
Jan 18 15:39:16 laptop kernel: BTRFS info (device dm-0): found 63
extents, stage: update data pointers
Jan 18 15:39:16 laptop kernel: BTRFS info (device dm-0): relocating
block group 1681971478528 flags data
Jan 18 15:39:18 laptop kernel: BTRFS info (device dm-0): found 30
extents, stage: move data extents
Jan 18 15:39:18 laptop kernel: BTRFS info (device dm-0): found 30
extents, stage: update data pointers
Jan 18 15:39:18 laptop kernel: BTRFS info (device dm-0): relocating
block group 1680897736704 flags data
Jan 18 15:39:20 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: move data extents
Jan 18 15:39:21 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: update data pointers
Jan 18 15:39:21 laptop kernel: BTRFS info (device dm-0): relocating
block group 1679823994880 flags data
Jan 18 15:39:23 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:39:23 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:39:23 laptop kernel: BTRFS info (device dm-0): relocating
block group 1678750253056 flags data
Jan 18 15:39:25 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:39:25 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:39:25 laptop kernel: BTRFS info (device dm-0): relocating
block group 1677676511232 flags data
Jan 18 15:39:27 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:39:27 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:39:27 laptop kernel: BTRFS info (device dm-0): relocating
block group 1676602769408 flags data
Jan 18 15:39:29 laptop kernel: BTRFS info (device dm-0): found 1535
extents, stage: move data extents
Jan 18 15:39:30 laptop kernel: BTRFS info (device dm-0): found 1535
extents, stage: update data pointers
Jan 18 15:39:30 laptop kernel: BTRFS info (device dm-0): relocating
block group 1675529027584 flags data
Jan 18 15:39:32 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: move data extents
Jan 18 15:39:32 laptop kernel: BTRFS info (device dm-0): found 20
extents, stage: update data pointers
Jan 18 15:39:32 laptop kernel: BTRFS info (device dm-0): relocating
block group 1674455285760 flags data
Jan 18 15:39:34 laptop kernel: BTRFS info (device dm-0): found 1660
extents, stage: move data extents
Jan 18 15:39:35 laptop kernel: BTRFS info (device dm-0): found 1660
extents, stage: update data pointers
Jan 18 15:39:35 laptop kernel: BTRFS info (device dm-0): relocating
block group 1673381543936 flags data
Jan 18 15:39:37 laptop kernel: BTRFS info (device dm-0): found 9
extents, stage: move data extents
Jan 18 15:39:37 laptop kernel: BTRFS info (device dm-0): found 9
extents, stage: update data pointers
Jan 18 15:39:37 laptop kernel: BTRFS info (device dm-0): relocating
block group 1672307802112 flags data
Jan 18 15:39:39 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:39:39 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:39:39 laptop kernel: BTRFS info (device dm-0): relocating
block group 1671234060288 flags data
Jan 18 15:39:41 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:39:41 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:39:42 laptop kernel: BTRFS info (device dm-0): relocating
block group 1670160318464 flags data
Jan 18 15:39:43 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:39:44 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:39:44 laptop kernel: BTRFS info (device dm-0): relocating
block group 1669086576640 flags data
Jan 18 15:39:46 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: move data extents
Jan 18 15:39:46 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: update data pointers
Jan 18 15:39:46 laptop kernel: BTRFS info (device dm-0): relocating
block group 1668012834816 flags data
Jan 18 15:39:48 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:39:48 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:39:48 laptop kernel: BTRFS info (device dm-0): relocating
block group 1666939092992 flags data
Jan 18 15:39:50 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:39:50 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:39:50 laptop kernel: BTRFS info (device dm-0): relocating
block group 1665865351168 flags data
Jan 18 15:39:53 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:39:53 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:39:53 laptop kernel: BTRFS info (device dm-0): relocating
block group 1664791609344 flags data
Jan 18 15:39:55 laptop kernel: BTRFS info (device dm-0): found 1422
extents, stage: move data extents
Jan 18 15:39:55 laptop kernel: BTRFS info (device dm-0): found 1422
extents, stage: update data pointers
Jan 18 15:39:56 laptop kernel: BTRFS info (device dm-0): relocating
block group 1663717867520 flags data
Jan 18 15:39:57 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: move data extents
Jan 18 15:39:58 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: update data pointers
Jan 18 15:39:58 laptop kernel: BTRFS info (device dm-0): relocating
block group 1662644125696 flags data
Jan 18 15:40:00 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:40:00 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:40:00 laptop kernel: BTRFS info (device dm-0): relocating
block group 1661570383872 flags data
Jan 18 15:40:02 laptop kernel: BTRFS info (device dm-0): found 1792
extents, stage: move data extents
Jan 18 15:40:02 laptop kernel: BTRFS info (device dm-0): found 1792
extents, stage: update data pointers
Jan 18 15:40:02 laptop kernel: BTRFS info (device dm-0): relocating
block group 1660496642048 flags data
Jan 18 15:40:05 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:40:05 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:40:05 laptop kernel: BTRFS info (device dm-0): relocating
block group 1659422900224 flags data
Jan 18 15:40:07 laptop kernel: BTRFS info (device dm-0): found 1362
extents, stage: move data extents
Jan 18 15:40:07 laptop kernel: BTRFS info (device dm-0): found 1362
extents, stage: update data pointers
Jan 18 15:40:08 laptop kernel: BTRFS info (device dm-0): relocating
block group 1658349158400 flags data
Jan 18 15:40:10 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:40:10 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:40:10 laptop kernel: BTRFS info (device dm-0): relocating
block group 1657275416576 flags data
Jan 18 15:40:12 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: move data extents
Jan 18 15:40:12 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: update data pointers
Jan 18 15:40:12 laptop kernel: BTRFS info (device dm-0): relocating
block group 1656201674752 flags data
Jan 18 15:40:14 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:40:14 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:40:14 laptop kernel: BTRFS info (device dm-0): relocating
block group 1655127932928 flags data
Jan 18 15:40:16 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: move data extents
Jan 18 15:40:17 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: update data pointers
Jan 18 15:40:17 laptop kernel: BTRFS info (device dm-0): relocating
block group 1654054191104 flags data
Jan 18 15:40:18 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:40:19 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:40:19 laptop kernel: BTRFS info (device dm-0): relocating
block group 1652980449280 flags data
Jan 18 15:40:21 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:40:21 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:40:21 laptop kernel: BTRFS info (device dm-0): relocating
block group 1651906707456 flags data
Jan 18 15:40:23 laptop kernel: BTRFS info (device dm-0): found 623
extents, stage: move data extents
Jan 18 15:40:23 laptop kernel: BTRFS info (device dm-0): found 623
extents, stage: update data pointers
Jan 18 15:40:23 laptop kernel: BTRFS info (device dm-0): relocating
block group 1650832965632 flags data
Jan 18 15:40:25 laptop kernel: BTRFS info (device dm-0): found 1688
extents, stage: move data extents
Jan 18 15:40:26 laptop kernel: BTRFS info (device dm-0): found 1688
extents, stage: update data pointers
Jan 18 15:40:26 laptop kernel: BTRFS info (device dm-0): relocating
block group 1649759223808 flags data
Jan 18 15:40:28 laptop kernel: BTRFS info (device dm-0): found 1636
extents, stage: move data extents
Jan 18 15:40:28 laptop kernel: BTRFS info (device dm-0): found 1636
extents, stage: update data pointers
Jan 18 15:40:29 laptop kernel: BTRFS info (device dm-0): relocating
block group 1648685481984 flags data
Jan 18 15:40:30 laptop kernel: BTRFS info (device dm-0): found 25
extents, stage: move data extents
Jan 18 15:40:31 laptop kernel: BTRFS info (device dm-0): found 25
extents, stage: update data pointers
Jan 18 15:40:31 laptop kernel: BTRFS info (device dm-0): relocating
block group 1647611740160 flags data
Jan 18 15:40:33 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:40:33 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:40:33 laptop kernel: BTRFS info (device dm-0): relocating
block group 1646537998336 flags data
Jan 18 15:40:35 laptop kernel: BTRFS info (device dm-0): found 9
extents, stage: move data extents
Jan 18 15:40:35 laptop kernel: BTRFS info (device dm-0): found 9
extents, stage: update data pointers
Jan 18 15:40:35 laptop kernel: BTRFS info (device dm-0): relocating
block group 1645464256512 flags data
Jan 18 15:40:37 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:40:38 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:40:38 laptop kernel: BTRFS info (device dm-0): relocating
block group 1644390514688 flags data
Jan 18 15:40:39 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:40:40 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:40:40 laptop kernel: BTRFS info (device dm-0): relocating
block group 1643316772864 flags data
Jan 18 15:40:42 laptop kernel: BTRFS info (device dm-0): found 9
extents, stage: move data extents
Jan 18 15:40:42 laptop kernel: BTRFS info (device dm-0): found 9
extents, stage: update data pointers
Jan 18 15:40:42 laptop kernel: BTRFS info (device dm-0): relocating
block group 1642243031040 flags data
Jan 18 15:40:44 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:40:44 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:40:44 laptop kernel: BTRFS info (device dm-0): relocating
block group 1641169289216 flags data
Jan 18 15:40:46 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:40:46 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:40:46 laptop kernel: BTRFS info (device dm-0): relocating
block group 1640095547392 flags data
Jan 18 15:40:48 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:40:48 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:40:48 laptop kernel: BTRFS info (device dm-0): relocating
block group 1639021805568 flags data
Jan 18 15:40:50 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:40:50 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:40:50 laptop kernel: BTRFS info (device dm-0): relocating
block group 1637948063744 flags data
Jan 18 15:40:52 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: move data extents
Jan 18 15:40:52 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: update data pointers
Jan 18 15:40:53 laptop kernel: BTRFS info (device dm-0): relocating
block group 1636874321920 flags data
Jan 18 15:40:54 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:40:55 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:40:55 laptop kernel: BTRFS info (device dm-0): relocating
block group 1635800580096 flags data
Jan 18 15:40:56 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:40:57 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:40:57 laptop kernel: BTRFS info (device dm-0): relocating
block group 1634726838272 flags data
Jan 18 15:40:59 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:40:59 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:40:59 laptop kernel: BTRFS info (device dm-0): relocating
block group 1633653096448 flags data
Jan 18 15:41:01 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:41:01 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:41:01 laptop kernel: BTRFS info (device dm-0): relocating
block group 1632579354624 flags data
Jan 18 15:41:03 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:41:03 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:41:03 laptop kernel: BTRFS info (device dm-0): relocating
block group 1631505612800 flags data
Jan 18 15:41:05 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: move data extents
Jan 18 15:41:05 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: update data pointers
Jan 18 15:41:05 laptop kernel: BTRFS info (device dm-0): relocating
block group 1630431870976 flags data
Jan 18 15:41:07 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:41:08 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:41:08 laptop kernel: BTRFS info (device dm-0): relocating
block group 1629358129152 flags data
Jan 18 15:41:10 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:41:10 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:41:10 laptop kernel: BTRFS info (device dm-0): relocating
block group 1628284387328 flags data
Jan 18 15:41:13 laptop kernel: BTRFS info (device dm-0): found 1883
extents, stage: move data extents
Jan 18 15:41:13 laptop kernel: BTRFS info (device dm-0): found 1883
extents, stage: update data pointers
Jan 18 15:41:13 laptop kernel: BTRFS info (device dm-0): relocating
block group 1627210645504 flags data
Jan 18 15:41:15 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:41:15 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:41:15 laptop kernel: BTRFS info (device dm-0): relocating
block group 1626136903680 flags data
Jan 18 15:41:17 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:41:17 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:41:17 laptop kernel: BTRFS info (device dm-0): relocating
block group 1625063161856 flags data
Jan 18 15:41:19 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:41:19 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:41:20 laptop kernel: BTRFS info (device dm-0): relocating
block group 1623989420032 flags data
Jan 18 15:41:22 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:41:22 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:41:22 laptop kernel: BTRFS info (device dm-0): relocating
block group 1622915678208 flags data
Jan 18 15:41:24 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:41:24 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:41:24 laptop kernel: BTRFS info (device dm-0): relocating
block group 1621841936384 flags data
Jan 18 15:41:26 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:41:26 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:41:26 laptop kernel: BTRFS info (device dm-0): relocating
block group 1620768194560 flags data
Jan 18 15:41:29 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:41:29 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:41:29 laptop kernel: BTRFS info (device dm-0): relocating
block group 1619694452736 flags data
Jan 18 15:41:31 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:41:31 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:41:31 laptop kernel: BTRFS info (device dm-0): relocating
block group 1618620710912 flags data
Jan 18 15:41:33 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:41:34 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:41:34 laptop kernel: BTRFS info (device dm-0): relocating
block group 1617546969088 flags data
Jan 18 15:41:35 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: move data extents
Jan 18 15:41:36 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: update data pointers
Jan 18 15:41:36 laptop kernel: BTRFS info (device dm-0): relocating
block group 1616473227264 flags data
Jan 18 15:41:38 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:41:38 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:41:38 laptop kernel: BTRFS info (device dm-0): relocating
block group 1615399485440 flags data
Jan 18 15:41:40 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:41:40 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:41:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 1614325743616 flags data
Jan 18 15:41:42 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:41:43 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:41:43 laptop kernel: BTRFS info (device dm-0): relocating
block group 1613252001792 flags data
Jan 18 15:41:45 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:41:45 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:41:45 laptop kernel: BTRFS info (device dm-0): relocating
block group 1612178259968 flags data
Jan 18 15:41:47 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: move data extents
Jan 18 15:41:47 laptop kernel: BTRFS info (device dm-0): found 10
extents, stage: update data pointers
Jan 18 15:41:47 laptop kernel: BTRFS info (device dm-0): relocating
block group 1611104518144 flags data
Jan 18 15:41:49 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: move data extents
Jan 18 15:41:49 laptop kernel: BTRFS info (device dm-0): found 11
extents, stage: update data pointers
Jan 18 15:41:49 laptop kernel: BTRFS info (device dm-0): relocating
block group 1610030776320 flags data
Jan 18 15:41:51 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:41:51 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:41:52 laptop kernel: BTRFS info (device dm-0): relocating
block group 1608957034496 flags data
Jan 18 15:41:53 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: move data extents
Jan 18 15:41:54 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: update data pointers
Jan 18 15:41:54 laptop kernel: BTRFS info (device dm-0): relocating
block group 1607883292672 flags data
Jan 18 15:41:56 laptop kernel: BTRFS info (device dm-0): found 24955
extents, stage: move data extents
Jan 18 15:42:05 laptop kernel: BTRFS info (device dm-0): found 24955
extents, stage: update data pointers
Jan 18 15:42:10 laptop kernel: BTRFS info (device dm-0): relocating
block group 1606809550848 flags data
Jan 18 15:42:12 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: move data extents
Jan 18 15:42:12 laptop kernel: BTRFS info (device dm-0): found 14
extents, stage: update data pointers
Jan 18 15:42:12 laptop kernel: BTRFS info (device dm-0): relocating
block group 1605735809024 flags data
Jan 18 15:42:14 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: move data extents
Jan 18 15:42:14 laptop kernel: BTRFS info (device dm-0): found 8
extents, stage: update data pointers
Jan 18 15:42:14 laptop kernel: BTRFS info (device dm-0): relocating
block group 1604662067200 flags data
Jan 18 15:42:15 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:42:16 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:42:16 laptop kernel: BTRFS info (device dm-0): relocating
block group 1603588325376 flags data
Jan 18 15:42:17 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:42:18 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:42:18 laptop kernel: BTRFS info (device dm-0): relocating
block group 1602514583552 flags data
Jan 18 15:42:19 laptop kernel: BTRFS info (device dm-0): found 9
extents, stage: move data extents
Jan 18 15:42:19 laptop kernel: BTRFS info (device dm-0): found 9
extents, stage: update data pointers
Jan 18 15:42:20 laptop kernel: BTRFS info (device dm-0): relocating
block group 1601440841728 flags data
Jan 18 15:42:21 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:42:21 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:42:22 laptop kernel: BTRFS info (device dm-0): relocating
block group 1600367099904 flags data
Jan 18 15:42:23 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: move data extents
Jan 18 15:42:24 laptop kernel: BTRFS info (device dm-0): found 12
extents, stage: update data pointers
Jan 18 15:42:24 laptop kernel: BTRFS info (device dm-0): relocating
block group 1599293358080 flags data
Jan 18 15:42:26 laptop kernel: BTRFS info (device dm-0): found 22
extents, stage: move data extents
Jan 18 15:42:26 laptop kernel: BTRFS info (device dm-0): found 22
extents, stage: update data pointers
Jan 18 15:42:26 laptop kernel: BTRFS info (device dm-0): relocating
block group 1597145874432 flags data
Jan 18 15:42:28 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: move data extents
Jan 18 15:42:28 laptop kernel: BTRFS info (device dm-0): found 19
extents, stage: update data pointers
Jan 18 15:42:29 laptop kernel: BTRFS info (device dm-0): relocating
block group 1596072132608 flags data
Jan 18 15:42:30 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: move data extents
Jan 18 15:42:31 laptop kernel: BTRFS info (device dm-0): found 16
extents, stage: update data pointers
Jan 18 15:42:31 laptop kernel: BTRFS info (device dm-0): relocating
block group 1594998390784 flags data
Jan 18 15:42:33 laptop kernel: BTRFS info (device dm-0): found 28
extents, stage: move data extents
Jan 18 15:42:33 laptop kernel: BTRFS info (device dm-0): found 28
extents, stage: update data pointers
Jan 18 15:42:33 laptop kernel: BTRFS info (device dm-0): relocating
block group 1593924648960 flags data
Jan 18 15:42:35 laptop kernel: BTRFS info (device dm-0): found 28
extents, stage: move data extents
Jan 18 15:42:35 laptop kernel: BTRFS info (device dm-0): found 28
extents, stage: update data pointers
Jan 18 15:42:35 laptop kernel: BTRFS info (device dm-0): relocating
block group 1592850907136 flags data
Jan 18 15:42:37 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: move data extents
Jan 18 15:42:37 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: update data pointers
Jan 18 15:42:38 laptop kernel: BTRFS info (device dm-0): relocating
block group 1591777165312 flags data
Jan 18 15:42:39 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: move data extents
Jan 18 15:42:40 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: update data pointers
Jan 18 15:42:40 laptop kernel: BTRFS info (device dm-0): relocating
block group 1590703423488 flags data
Jan 18 15:42:42 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: move data extents
Jan 18 15:42:42 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: update data pointers
Jan 18 15:42:42 laptop kernel: BTRFS info (device dm-0): relocating
block group 1589629681664 flags data
Jan 18 15:42:44 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: move data extents
Jan 18 15:42:44 laptop kernel: BTRFS info (device dm-0): found 17
extents, stage: update data pointers
Jan 18 15:42:44 laptop kernel: BTRFS info (device dm-0): relocating
block group 1588555939840 flags data
Jan 18 15:42:46 laptop kernel: BTRFS info (device dm-0): found 24
extents, stage: move data extents
Jan 18 15:42:46 laptop kernel: BTRFS info (device dm-0): found 24
extents, stage: update data pointers
Jan 18 15:42:47 laptop kernel: BTRFS info (device dm-0): relocating
block group 1587482198016 flags data
Jan 18 15:42:48 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: move data extents
Jan 18 15:42:49 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: update data pointers
Jan 18 15:42:49 laptop kernel: BTRFS info (device dm-0): relocating
block group 1586408456192 flags data
Jan 18 15:42:50 laptop kernel: BTRFS info (device dm-0): found 28
extents, stage: move data extents
Jan 18 15:42:51 laptop kernel: BTRFS info (device dm-0): found 28
extents, stage: update data pointers
Jan 18 15:42:51 laptop kernel: BTRFS info (device dm-0): relocating
block group 1585334714368 flags data
Jan 18 15:42:53 laptop kernel: BTRFS info (device dm-0): found 24
extents, stage: move data extents
Jan 18 15:42:53 laptop kernel: BTRFS info (device dm-0): found 24
extents, stage: update data pointers
Jan 18 15:42:53 laptop kernel: BTRFS info (device dm-0): relocating
block group 1584260972544 flags data
Jan 18 15:42:55 laptop kernel: BTRFS info (device dm-0): found 32
extents, stage: move data extents
Jan 18 15:42:55 laptop kernel: BTRFS info (device dm-0): found 32
extents, stage: update data pointers
Jan 18 15:42:56 laptop kernel: BTRFS info (device dm-0): relocating
block group 1583187230720 flags data
Jan 18 15:42:58 laptop kernel: BTRFS info (device dm-0): found 30749
extents, stage: move data extents
Jan 18 15:43:05 laptop kernel: BTRFS info (device dm-0): found 30749
extents, stage: update data pointers
Jan 18 15:43:09 laptop kernel: BTRFS info (device dm-0): relocating
block group 1579966005248 flags data
Jan 18 15:43:11 laptop kernel: BTRFS info (device dm-0): found 1399
extents, stage: move data extents
Jan 18 15:43:12 laptop kernel: BTRFS info (device dm-0): found 1399
extents, stage: update data pointers
Jan 18 15:43:13 laptop kernel: BTRFS info (device dm-0): relocating
block group 1578892263424 flags data
Jan 18 15:43:14 laptop kernel: BTRFS info (device dm-0): found 31
extents, stage: move data extents
Jan 18 15:43:14 laptop kernel: BTRFS info (device dm-0): found 31
extents, stage: update data pointers
Jan 18 15:43:14 laptop kernel: BTRFS info (device dm-0): relocating
block group 1577818521600 flags data
Jan 18 15:43:16 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: move data extents
Jan 18 15:43:16 laptop kernel: BTRFS info (device dm-0): found 21
extents, stage: update data pointers
Jan 18 15:43:16 laptop kernel: BTRFS info (device dm-0): relocating
block group 1576744779776 flags data
Jan 18 15:43:17 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: move data extents
Jan 18 15:43:17 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: update data pointers
Jan 18 15:43:18 laptop kernel: BTRFS info (device dm-0): relocating
block group 1575671037952 flags data
Jan 18 15:43:19 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:43:19 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:43:19 laptop kernel: BTRFS info (device dm-0): relocating
block group 1574563741696 flags data
Jan 18 15:43:21 laptop kernel: BTRFS info (device dm-0): found 862
extents, stage: move data extents
Jan 18 15:43:22 laptop kernel: BTRFS info (device dm-0): found 862
extents, stage: update data pointers
Jan 18 15:43:23 laptop kernel: BTRFS info (device dm-0): relocating
block group 1573489999872 flags data
Jan 18 15:43:24 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: move data extents
Jan 18 15:43:25 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: update data pointers
Jan 18 15:43:25 laptop kernel: BTRFS info (device dm-0): relocating
block group 1572416258048 flags data
Jan 18 15:43:27 laptop kernel: BTRFS info (device dm-0): found 21244
extents, stage: move data extents
Jan 18 15:43:36 laptop kernel: BTRFS info (device dm-0): found 21244
extents, stage: update data pointers
Jan 18 15:43:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 299998642176 flags data
Jan 18 15:43:44 laptop kernel: BTRFS info (device dm-0): found 26160
extents, stage: move data extents
Jan 18 15:43:48 laptop kernel: BTRFS critical (device dm-0): unable to
find chunk map for logical 404419657728 length 16384
Jan 18 15:43:48 laptop kernel: BTRFS critical (device dm-0): unable to
find chunk map for logical 404419657728 length 16384
Jan 18 15:44:03 laptop kernel: BTRFS info (device dm-0): balance:
ended with status: -5
Jan 18 16:00:22 laptop systemd[1]: Starting btrbk backup...
Jan 18 16:00:22 laptop btrbk_run.sh[8109]: TARGET         SOURCE
        FSTYPE OPTIONS
Jan 18 16:00:22 laptop btrbk_run.sh[8109]: /mnt/top_level
/dev/mapper/rootluks btrfs
rw,noatime,nodiratime,compress=3Dlzo,ssd,spac>
Jan 18 16:00:24 laptop btrbk_run.sh[8110]:
---------------------------------------------------------------------------=
-----
Jan 18 16:00:24 laptop btrbk_run.sh[8110]: Backup Summary (btrbk
command line client, version 0.32.6)
Jan 18 16:00:24 laptop btrbk_run.sh[8110]:     Date:   Sat Jan 18 16:00:22 =
2025
Jan 18 16:00:24 laptop btrbk_run.sh[8110]:     Config: /etc/btrbk/btrbk.con=
f
Jan 18 16:00:24 laptop btrbk_run.sh[8110]: Legend:
Jan 18 16:00:24 laptop btrbk_run.sh[8110]:     =3D=3D=3D  up-to-date
subvolume (source snapshot)
Jan 18 16:00:24 laptop btrbk_run.sh[8110]:     +++  created subvolume
(source snapshot)
Jan 18 16:00:24 laptop btrbk_run.sh[8110]:     ---  deleted subvolume
Jan 18 15:43:18 laptop kernel: BTRFS info (device dm-0): relocating
block group 1575671037952 flags data
Jan 18 15:43:19 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: move data extents
Jan 18 15:43:19 laptop kernel: BTRFS info (device dm-0): found 13
extents, stage: update data pointers
Jan 18 15:43:19 laptop kernel: BTRFS info (device dm-0): relocating
block group 1574563741696 flags data
Jan 18 15:43:21 laptop kernel: BTRFS info (device dm-0): found 862
extents, stage: move data extents
Jan 18 15:43:22 laptop kernel: BTRFS info (device dm-0): found 862
extents, stage: update data pointers
Jan 18 15:43:23 laptop kernel: BTRFS info (device dm-0): relocating
block group 1573489999872 flags data
Jan 18 15:43:24 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: move data extents
Jan 18 15:43:25 laptop kernel: BTRFS info (device dm-0): found 18
extents, stage: update data pointers
Jan 18 15:43:25 laptop kernel: BTRFS info (device dm-0): relocating
block group 1572416258048 flags data
Jan 18 15:43:27 laptop kernel: BTRFS info (device dm-0): found 21244
extents, stage: move data extents
Jan 18 15:43:36 laptop kernel: BTRFS info (device dm-0): found 21244
extents, stage: update data pointers
Jan 18 15:43:41 laptop kernel: BTRFS info (device dm-0): relocating
block group 299998642176 flags data
Jan 18 15:43:44 laptop kernel: BTRFS info (device dm-0): found 26160
extents, stage: move data extents
Jan 18 15:43:48 laptop kernel: BTRFS critical (device dm-0): unable to
find chunk map for logical 404419657728 length 16384
Jan 18 15:43:48 laptop kernel: BTRFS critical (device dm-0): unable to
find chunk map for logical 404419657728 length 16384
Jan 18 15:44:03 laptop kernel: BTRFS info (device dm-0): balance:
ended with status: -5

On Sun, Jan 19, 2025 at 12:02=E2=80=AFAM Dave T <davestechshop@gmail.com> w=
rote:
>
> Does this section of the journal include what you need?
>
> Jan 18 14:23:53 laptop kernel: BTRFS info (device dm-0): found 37399
> extents, stage: move data extents
> Jan 18 14:24:14 laptop kernel: BTRFS info (device dm-0): found 37399
> extents, stage: update data pointers
> Jan 18 14:24:25 laptop kernel: BTRFS info (device dm-0): relocating
> block group 346437976064 flags data
> Jan 18 14:24:29 laptop kernel: BTRFS info (device dm-0): found 54017
> extents, stage: move data extents
> Jan 18 14:24:50 laptop kernel: BTRFS info (device dm-0): found 54017
> extents, stage: update data pointers
> Jan 18 14:25:02 laptop kernel: BTRFS info (device dm-0): relocating
> block group 315131691008 flags data
> Jan 18 14:25:04 laptop kernel: BTRFS info (device dm-0): found 10490
> extents, stage: move data extents
> Jan 18 14:25:10 laptop kernel: BTRFS info (device dm-0): found 10490
> extents, stage: update data pointers
> Jan 18 14:25:14 laptop kernel: BTRFS info (device dm-0): relocating
> block group 314057949184 flags data
> Jan 18 14:25:16 laptop kernel: BTRFS info (device dm-0): found 12169
> extents, stage: move data extents
> Jan 18 14:25:27 laptop kernel: BTRFS info (device dm-0): found 12169
> extents, stage: update data pointers
> Jan 18 14:25:33 laptop kernel: BTRFS info (device dm-0): relocating
> block group 305400905728 flags data
> Jan 18 14:25:36 laptop kernel: BTRFS info (device dm-0): found 23943
> extents, stage: move data extents
> Jan 18 14:25:55 laptop kernel: BTRFS info (device dm-0): found 23943
> extents, stage: update data pointers
> Jan 18 14:26:06 laptop kernel: BTRFS info (device dm-0): relocating
> block group 303219867648 flags data
> Jan 18 14:26:08 laptop kernel: BTRFS info (device dm-0): found 21717
> extents, stage: move data extents
> Jan 18 14:26:27 laptop kernel: BTRFS info (device dm-0): found 21717
> extents, stage: update data pointers
> Jan 18 14:26:37 laptop kernel: BTRFS info (device dm-0): relocating
> block group 299998642176 flags data
> Jan 18 14:26:40 laptop kernel: BTRFS info (device dm-0): found 26155
> extents, stage: move data extents
> Jan 18 14:26:43 laptop kernel: BTRFS info (device dm-0): leaf
> 1581486112768 gen 1332468 total ptrs 101 free space 8877 owner 2
> Jan 18 14:26:43 laptop kernel:         item 0 key (301068791808 168
> 4096) itemoff 16233 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 958990 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062339653632 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 2062339588096 count 1
> Jan 18 14:26:43 laptop kernel:         item 1 key (301068795904 168
> 8192) itemoff 16105 itemsize 128
> Jan 18 14:26:43 laptop kernel:                 extent refs 8 gen 958990 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598985060352 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1598985043968 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
> backref parent 1598985027584 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
> backref parent 1598985011200 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
> backref parent 1598984994816 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
> backref parent 1598984962048 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
> backref parent 1598984929280 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
> backref parent 1598984912896 count 1
> Jan 18 14:26:43 laptop kernel:         item 2 key (301068804096 168
> 4096) itemoff 15964 itemsize 141
> Jan 18 14:26:43 laptop kernel:                 extent refs 9 gen 958990 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598749818880 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1598749802496 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
> backref parent 1598749786112 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
> backref parent 1598741512192 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
> backref parent 1598741495808 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
> backref parent 1598741430272 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
> backref parent 1598741397504 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
> backref parent 1598741381120 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#8: shared data
> backref parent 1598741348352 count 1
> Jan 18 14:26:43 laptop kernel:         item 3 key (301068808192 168
> 4096) itemoff 15927 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599069863936 count 1
> Jan 18 14:26:43 laptop kernel:         item 4 key (301068812288 168
> 86016) itemoff 15877 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1263812 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062155202560 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 2062155186176 count 1
> Jan 18 14:26:43 laptop kernel:         item 5 key (301068898304 168
> 73728) itemoff 15827 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1302583 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062348271616 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 2062348255232 count 1
> Jan 18 14:26:43 laptop kernel:         item 6 key (301068972032 168
> 8192) itemoff 15790 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581288947712 count 1
> Jan 18 14:26:43 laptop kernel:         item 7 key (301068980224 168
> 4096) itemoff 15753 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1208508 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599068258304 count 1
> Jan 18 14:26:43 laptop kernel:         item 8 key (301068984320 168
> 8192) itemoff 15716 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581288947712 count 1
> Jan 18 14:26:43 laptop kernel:         item 9 key (301068992512 168
> 4096) itemoff 15679 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062551859200 count 1
> Jan 18 14:26:43 laptop kernel:         item 10 key (301069000704 168
> 4096) itemoff 15525 itemsize 154
> Jan 18 14:26:43 laptop kernel:                 extent refs 10 gen 958990 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062562082816 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 2062562066432 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
> backref parent 2062562050048 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
> backref parent 2062562033664 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
> backref parent 2062561918976 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
> backref parent 2062561886208 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
> backref parent 2062340702208 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
> backref parent 1598918508544 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#8: shared data
> backref parent 1598918492160 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#9: shared data
> backref parent 1598918475776 count 1
> Jan 18 14:26:43 laptop kernel:         item 11 key (301069004800 168
> 131072) itemoff 15462 itemsize 63
> Jan 18 14:26:43 laptop kernel:                 extent refs 3 gen 906904 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062150959104 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 2062150795264 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
> backref parent 1599015010304 count 1
> Jan 18 14:26:43 laptop kernel:         item 12 key (301069135872 168
> 77824) itemoff 15425 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 906904 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598714101760 count 1
> Jan 18 14:26:43 laptop kernel:         item 13 key (301069213696 168
> 86016) itemoff 15271 itemsize 154
> Jan 18 14:26:43 laptop kernel:                 extent refs 10 gen 906904 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062172192768 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 2062172176384 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
> backref parent 2062172160000 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
> backref parent 2062172143616 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
> backref parent 2062172127232 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
> backref parent 2062172110848 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
> backref parent 2062172094464 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
> backref parent 1599079170048 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#8: shared data
> backref parent 1599079153664 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#9: shared data
> backref parent 1599079071744 count 1
> Jan 18 14:26:43 laptop kernel:         item 14 key (301069299712 168
> 12288) itemoff 15208 itemsize 63
> Jan 18 14:26:43 laptop kernel:                 extent refs 3 gen 958990 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581203456000 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1581203423232 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
> backref parent 1581203390464 count 1
> Jan 18 14:26:43 laptop kernel:         item 15 key (301069312000 168
> 49152) itemoff 15080 itemsize 128
> Jan 18 14:26:43 laptop kernel:                 extent refs 8 gen 1070104 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599082283008 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1599082266624 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
> backref parent 1599082250240 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
> backref parent 1599082217472 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
> backref parent 1599082201088 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
> backref parent 1598950162432 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
> backref parent 1598950146048 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
> backref parent 1598950096896 count 1
> Jan 18 14:26:43 laptop kernel:         item 16 key (301069365248 168
> 4096) itemoff 15043 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1037514 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598873567232 count 1
> Jan 18 14:26:43 laptop kernel:         item 17 key (301069369344 168
> 4096) itemoff 15006 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062551891968 count 1
> Jan 18 14:26:43 laptop kernel:         item 18 key (301069373440 168
> 73728) itemoff 14969 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1320338 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599018188800 count 1
> Jan 18 14:26:43 laptop kernel:         item 19 key (301069447168 168
> 8192) itemoff 14932 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581288947712 count 1
> Jan 18 14:26:43 laptop kernel:         item 20 key (301069455360 168
> 8192) itemoff 14895 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581288947712 count 1
> Jan 18 14:26:43 laptop kernel:         item 21 key (301069463552 168
> 45056) itemoff 14858 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1315995 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598918557696 count 1
> Jan 18 14:26:43 laptop kernel:         item 22 key (301069508608 168
> 24576) itemoff 14821 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598964023296 count 1
> Jan 18 14:26:43 laptop kernel:         item 23 key (301069533184 168
> 45056) itemoff 14758 itemsize 63
> Jan 18 14:26:43 laptop kernel:                 extent refs 3 gen 908474 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599041290240 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1599041273856 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
> backref parent 1599041257472 count 1
> Jan 18 14:26:43 laptop kernel:         item 24 key (301069578240 168
> 4096) itemoff 14721 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581855440896 count 1
> Jan 18 14:26:43 laptop kernel:         item 25 key (301069582336 168
> 180224) itemoff 14684 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 571604 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062488043520 count 1
> Jan 18 14:26:43 laptop kernel:         item 26 key (301069762560 168
> 81920) itemoff 14647 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1297538 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1582871822336 count 1
> Jan 18 14:26:43 laptop kernel:         item 27 key (301069844480 168
> 20480) itemoff 14610 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581288947712 count 1
> Jan 18 14:26:43 laptop kernel:         item 28 key (301069864960 168
> 69632) itemoff 14573 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 906904 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598940725248 count 1
> Jan 18 14:26:43 laptop kernel:         item 29 key (301069934592 168
> 20480) itemoff 14536 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1217768 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062935654400 count 1
> Jan 18 14:26:43 laptop kernel:         item 30 key (301069955072 168
> 4096) itemoff 14499 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218348 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599215878144 count 1
> Jan 18 14:26:43 laptop kernel:         item 31 key (301069959168 168
> 4096) itemoff 14462 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218348 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598976933888 count 1
> Jan 18 14:26:43 laptop kernel:         item 32 key (301069963264 168
> 4096) itemoff 14425 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062552334336 count 1
> Jan 18 14:26:43 laptop kernel:         item 33 key (301069967360 168
> 45056) itemoff 14388 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1315995 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598918557696 count 1
> Jan 18 14:26:43 laptop kernel:         item 34 key (301070016512 168
> 118784) itemoff 14273 itemsize 115
> Jan 18 14:26:43 laptop kernel:                 extent refs 7 gen 1217727 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062441398272 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1598929846272 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
> backref parent 1598929797120 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
> backref parent 1598929764352 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
> backref parent 1598929747968 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
> backref parent 1598929731584 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
> backref parent 1598929649664 count 1
> Jan 18 14:26:43 laptop kernel:         item 35 key (301070135296 168
> 4096) itemoff 14236 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218430 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599215878144 count 1
> Jan 18 14:26:43 laptop kernel:         item 36 key (301070139392 168
> 53248) itemoff 14186 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1070104 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599091015680 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1599090999296 count 1
> Jan 18 14:26:43 laptop kernel:         item 37 key (301070192640 168
> 8192) itemoff 14149 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1245771 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062686699520 count 1
> Jan 18 14:26:43 laptop kernel:         item 38 key (301070200832 168
> 69632) itemoff 14112 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 6 gen 1007611 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599136923648 count 6
> Jan 18 14:26:43 laptop kernel:         item 39 key (301070270464 168
> 4096) itemoff 14075 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062553006080 count 1
> Jan 18 14:26:43 laptop kernel:         item 40 key (301070274560 168
> 110592) itemoff 14025 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 906904 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598829887488 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1598829772800 count 1
> Jan 18 14:26:43 laptop kernel:         item 41 key (301070385152 168
> 69632) itemoff 13988 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1217759 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062152400896 count 1
> Jan 18 14:26:43 laptop kernel:         item 42 key (301070454784 168
> 77824) itemoff 13951 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1012715 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062722400256 count 1
> Jan 18 14:26:43 laptop kernel:         item 43 key (301070532608 168
> 20480) itemoff 13914 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598940577792 count 1
> Jan 18 14:26:43 laptop kernel:         item 44 key (301070553088 168
> 131072) itemoff 13877 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1182909 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 71836729344 count 1
> Jan 18 14:26:43 laptop kernel:         item 45 key (301070684160 168
> 20480) itemoff 13840 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581288947712 count 1
> Jan 18 14:26:43 laptop kernel:         item 46 key (301070704640 168
> 4096) itemoff 13803 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218355 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581489029120 count 1
> Jan 18 14:26:43 laptop kernel:         item 47 key (301070708736 168
> 4096) itemoff 13766 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218359 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599215878144 count 1
> Jan 18 14:26:43 laptop kernel:         item 48 key (301070712832 168
> 65536) itemoff 13586 itemsize 180
> Jan 18 14:26:43 laptop kernel:                 extent refs 12 gen
> 1069705 flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598926536704 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1598926454784 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
> backref parent 1598926422016 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
> backref parent 1598926405632 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
> backref parent 1598926356480 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
> backref parent 1598926340096 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
> backref parent 1598926323712 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
> backref parent 1598926307328 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#8: shared data
> backref parent 1598926290944 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#9: shared data
> backref parent 1598926274560 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#10: shared data
> backref parent 1598926209024 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#11: shared data
> backref parent 1598926192640 count 1
> Jan 18 14:26:43 laptop kernel:         item 49 key (301070778368 168
> 16384) itemoff 13536 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1036734 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599053217792 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1599053070336 count 1
> Jan 18 14:26:43 laptop kernel:         item 50 key (301070798848 168
> 4096) itemoff 13499 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062553006080 count 1
> Jan 18 14:26:43 laptop kernel:         item 51 key (301070802944 168
> 98304) itemoff 13371 itemsize 128
> Jan 18 14:26:43 laptop kernel:                 extent refs 8 gen 566208 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599071502336 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1599071485952 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
> backref parent 1599071469568 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
> backref parent 1599071453184 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
> backref parent 1599071436800 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
> backref parent 1599071420416 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
> backref parent 1599071404032 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
> backref parent 1599071387648 count 1
> Jan 18 14:26:43 laptop kernel:         item 52 key (301070901248 168
> 49152) itemoff 13334 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1315995 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598918557696 count 1
> Jan 18 14:26:43 laptop kernel:         item 53 key (301070950400 168
> 8192) itemoff 13297 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581288947712 count 1
> Jan 18 14:26:43 laptop kernel:         item 54 key (301070958592 168
> 8192) itemoff 13260 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581234864128 count 1
> Jan 18 14:26:43 laptop kernel:         item 55 key (301070966784 168
> 8192) itemoff 13223 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581234864128 count 1
> Jan 18 14:26:43 laptop kernel:         item 56 key (301070974976 168
> 45056) itemoff 13160 itemsize 63
> Jan 18 14:26:43 laptop kernel:                 extent refs 3 gen 908474 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599041290240 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1599041273856 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
> backref parent 1599041257472 count 1
> Jan 18 14:26:43 laptop kernel:         item 57 key (301071020032 168
> 8192) itemoff 13123 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581234864128 count 1
> Jan 18 14:26:43 laptop kernel:         item 58 key (301071028224 168
> 8192) itemoff 13086 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581234864128 count 1
> Jan 18 14:26:43 laptop kernel:         item 59 key (301071036416 168
> 4096) itemoff 13049 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599071518720 count 1
> Jan 18 14:26:43 laptop kernel:         item 60 key (301071040512 168
> 86016) itemoff 12986 itemsize 63
> Jan 18 14:26:43 laptop kernel:                 extent refs 3 gen 906904 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599145459712 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1599145443328 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
> backref parent 1599145426944 count 1
> Jan 18 14:26:43 laptop kernel:         item 61 key (301071126528 168
> 102400) itemoff 12936 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1317825 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2063022342144 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 2063022325760 count 1
> Jan 18 14:26:43 laptop kernel:         item 62 key (301071228928 168
> 4096) itemoff 12899 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1007933 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598722490368 count 1
> Jan 18 14:26:43 laptop kernel:         item 63 key (301071233024 168
> 8192) itemoff 12862 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1247702 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2063034925056 count 1
> Jan 18 14:26:43 laptop kernel:         item 64 key (301071241216 168
> 4096) itemoff 12825 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1247702 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599069175808 count 1
> Jan 18 14:26:43 laptop kernel:         item 65 key (301071245312 168
> 4096) itemoff 12788 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1245772 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598555897856 count 1
> Jan 18 14:26:43 laptop kernel:         item 66 key (301071249408 168
> 57344) itemoff 12751 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 908474 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062583218176 count 1
> Jan 18 14:26:43 laptop kernel:         item 67 key (301071306752 168
> 28672) itemoff 12714 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1217768 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599169822720 count 1
> Jan 18 14:26:43 laptop kernel:         item 68 key (301071335424 168
> 4096) itemoff 12677 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1200554 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1582963212288 count 1
> Jan 18 14:26:43 laptop kernel:         item 69 key (301071339520 168
> 20480) itemoff 12640 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1086462 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599109824512 count 1
> Jan 18 14:26:43 laptop kernel:         item 70 key (301071360000 168
> 4096) itemoff 12603 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1086462 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062646919168 count 1
> Jan 18 14:26:43 laptop kernel:         item 71 key (301071364096 168
> 4096) itemoff 12566 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1200554 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1582969438208 count 1
> Jan 18 14:26:43 laptop kernel:         item 72 key (301071368192 168
> 4096) itemoff 12529 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1086462 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599024381952 count 1
> Jan 18 14:26:43 laptop kernel:         item 73 key (301071372288 168
> 8192) itemoff 12492 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1007746 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599154323456 count 1
> Jan 18 14:26:43 laptop kernel:         item 74 key (301071380480 168
> 4096) itemoff 12455 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1007894 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599136923648 count 1
> Jan 18 14:26:43 laptop kernel:         item 75 key (301071384576 168
> 4096) itemoff 12418 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218357 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598976933888 count 1
> Jan 18 14:26:43 laptop kernel:         item 76 key (301071388672 168
> 4096) itemoff 12381 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218359 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1581489029120 count 1
> Jan 18 14:26:43 laptop kernel:         item 77 key (301071392768 168
> 4096) itemoff 12344 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218370 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598976933888 count 1
> Jan 18 14:26:43 laptop kernel:         item 78 key (301071396864 168
> 86016) itemoff 12307 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 751768 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599081250816 count 1
> Jan 18 14:26:43 laptop kernel:         item 79 key (301071482880 168
> 102400) itemoff 12257 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 906904 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599154126848 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1599154110464 count 1
> Jan 18 14:26:43 laptop kernel:         item 80 key (301071585280 168
> 69632) itemoff 12220 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 906904 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062165999616 count 1
> Jan 18 14:26:43 laptop kernel:         item 81 key (301071654912 168
> 77824) itemoff 12183 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 906904 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062441365504 count 1
> Jan 18 14:26:43 laptop kernel:         item 82 key (301071732736 168
> 65536) itemoff 12133 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 906904 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062584479744 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 2062166065152 count 1
> Jan 18 14:26:43 laptop kernel:         item 83 key (301071798272 168
> 32768) itemoff 12096 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1325121 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062597505024 count 1
> Jan 18 14:26:43 laptop kernel:         item 84 key (301071831040 168
> 8192) itemoff 12059 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1247702 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2063032139776 count 1
> Jan 18 14:26:43 laptop kernel:         item 85 key (301071839232 168
> 4096) itemoff 12022 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1247702 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599069175808 count 1
> Jan 18 14:26:43 laptop kernel:         item 86 key (301071843328 168
> 65536) itemoff 11972 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 906904 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2063009595392 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 2063009579008 count 1
> Jan 18 14:26:43 laptop kernel:         item 87 key (301071908864 168
> 90112) itemoff 11922 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1263812 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062155202560 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 2062155186176 count 1
> Jan 18 14:26:43 laptop kernel:         item 88 key (301071998976 168
> 4096) itemoff 11872 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1218906 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598779932672 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1598779899904 count 1
> Jan 18 14:26:43 laptop kernel:         item 89 key (301072003072 168
> 73728) itemoff 11822 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 906904 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598928273408 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1598928257024 count 1
> Jan 18 14:26:43 laptop kernel:         item 90 key (301072076800 168
> 65536) itemoff 11785 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 906904 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062807810048 count 1
> Jan 18 14:26:43 laptop kernel:         item 91 key (301072142336 168
> 90112) itemoff 11735 itemsize 50
> Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 906904 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599138496512 count 1
> Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
> backref parent 1599138480128 count 1
> Jan 18 14:26:43 laptop kernel:         item 92 key (301072232448 168
> 45056) itemoff 11698 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1315995 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598918557696 count 1
> Jan 18 14:26:43 laptop kernel:         item 93 key (301072277504 168
> 40960) itemoff 11661 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1325014 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1582604926976 count 1
> Jan 18 14:26:43 laptop kernel:         item 94 key (301072318464 168
> 4096) itemoff 11624 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1245772 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1598676369408 count 1
> Jan 18 14:26:43 laptop kernel:         item 95 key (301072322560 168
> 4096) itemoff 11587 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1200554 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1582969438208 count 1
> Jan 18 14:26:43 laptop kernel:         item 96 key (301072326656 168
> 32768) itemoff 11550 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1217768 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 2062553464832 count 1
> Jan 18 14:26:43 laptop kernel:         item 97 key (301072359424 168
> 4096) itemoff 11513 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1245772 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 71840104448 count 1
> Jan 18 14:26:43 laptop kernel:         item 98 key (301072363520 168
> 4096) itemoff 11476 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599071518720 count 1
> Jan 18 14:26:43 laptop kernel:         item 99 key (301072367616 168
> 12288) itemoff 11439 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 698261 f=
lags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1583155068928 count 1
> Jan 18 14:26:43 laptop kernel:         item 100 key (301072379904 168
> 4096) itemoff 11402 itemsize 37
> Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 =
flags 1
> Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
> backref parent 1599071518720 count 1
> Jan 18 14:26:43 laptop kernel: BTRFS error (device dm-0): tree block
> extent item (404419657728) is not found in extent tree
> Jan 18 14:26:43 laptop kernel: ------------[ cut here ]------------
> Jan 18 14:26:43 laptop kernel: WARNING: CPU: 0 PID: 2431 at
> fs/btrfs/relocation.c:3308 add_data_references+0x520/0x540 [btrfs]
> Jan 18 14:26:43 laptop kernel: Modules linked in: rfcomm ccm cmac
> algif_hash algif_skcipher af_alg bnep snd_hda_codec_hdmi snd_hd>
> Jan 18 14:26:43 laptop kernel:  platform_profile i2c_smbus cfg80211
> firmware_attributes_class wmi_bmof pps_core intel_wmi_thunder>
> Jan 18 14:26:43 laptop kernel:  video i8042 wmi serio vfat fat
> Jan 18 14:26:43 laptop kernel: CPU: 0 UID: 0 PID: 2431 Comm: btrfs
> Tainted: G     U             6.12.9-arch1-1 #1 4fef9133193e91a>
> Jan 18 14:26:43 laptop kernel: Tainted: [U]=3DUSER
> Jan 18 14:26:43 laptop kernel: Hardware name: LENOVO
> Jan 18 14:26:43 laptop kernel: RIP: 0010:add_data_references+0x520/0x540 =
[btrfs]
> Jan 18 14:26:43 laptop kernel: Code: 48 8b 6c 24 10 45 89 f5 e9 0e ff
> ff ff 4c 87 fd 49 8b 3f e8 02 fd f8 ff 4c 89 ea 48 c7 c6 a8>
> Jan 18 14:26:43 laptop kernel: RSP: 0018:ffffc171c3acb938 EFLAGS: 0001029=
6
> Jan 18 14:26:43 laptop kernel: RAX: 0000000000000000 RBX:
> ffffc171c3acb96f RCX: 0000000000000027
> Jan 18 14:26:43 laptop kernel: RDX: 0000000000000000 RSI:
> 0000000000000001 RDI: ffff9afa024218c0
> Jan 18 14:26:43 laptop kernel: RBP: ffff9af6ca740000 R08:
> 0000000000000000 R09: ffffc171c3acb718
> Jan 18 14:26:43 laptop kernel: R10: ffffffffba6b5528 R11:
> 0000000000000003 R12: ffff9af8eefb1000
> Jan 18 14:26:43 laptop kernel: R13: 0000005e294a4000 R14:
> 0000000000000001 R15: ffff9af90bbdf690
> Jan 18 14:26:43 laptop kernel: FS:  000074c0e270c900(0000)
> GS:ffff9afa02400000(0000) knlGS:0000000000000000
> Jan 18 14:26:43 laptop kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033
> Jan 18 14:26:43 laptop kernel: CR2: 000002a8050f5000 CR3:
> 00000001680ae003 CR4: 00000000003706f0
> Jan 18 14:26:43 laptop kernel: Call Trace:
> Jan 18 14:26:43 laptop kernel:  <TASK>
> Jan 18 14:26:43 laptop kernel:  ? add_data_references+0x520/0x540
> [btrfs 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
> Jan 18 14:26:43 laptop kernel:  ? __warn.cold+0x93/0xf6
> Jan 18 14:26:43 laptop kernel:  ? add_data_references+0x520/0x540
> [btrfs 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
> Jan 18 14:26:43 laptop kernel:  ? report_bug+0xff/0x140
> Jan 18 14:26:43 laptop kernel:  ? handle_bug+0x58/0x90
> Jan 18 14:26:43 laptop kernel:  ? exc_invalid_op+0x17/0x70
> Jan 18 14:26:43 laptop kernel:  ? asm_exc_invalid_op+0x1a/0x20
> Jan 18 14:26:43 laptop kernel:  ? add_data_references+0x520/0x540
> [btrfs 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
> Jan 18 14:26:43 laptop kernel:  ? add_data_references+0x520/0x540
> [btrfs 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
> Jan 18 14:26:43 laptop kernel:  relocate_block_group+0x348/0x540
> [btrfs 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
> Jan 18 14:26:43 laptop kernel:  btrfs_relocate_block_group+0x242/0x410
> [btrfs 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
> Jan 18 14:26:43 laptop kernel:  btrfs_relocate_chunk+0x3f/0x130 [btrfs
> 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
> Jan 18 14:26:43 laptop kernel:  btrfs_balance+0x7fe/0x1020 [btrfs
> 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
> Jan 18 14:26:43 laptop kernel:  btrfs_ioctl+0x2329/0x25c0 [btrfs
> 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
> Jan 18 14:26:43 laptop kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
> Jan 18 14:26:43 laptop kernel:  ? do_syscall_64+0x8e/0x190
> Jan 18 14:26:43 laptop kernel:  __x64_sys_ioctl+0x91/0xd0
> Jan 18 14:26:43 laptop kernel:  do_syscall_64+0x82/0x190
> Jan 18 14:26:43 laptop kernel:  ? do_fault+0x2dc/0x4c0
> Jan 18 14:26:43 laptop kernel:  ? __handle_mm_fault+0x7c2/0xfa0
> Jan 18 14:26:43 laptop kernel:  ? __count_memcg_events+0x53/0xf0
> Jan 18 14:26:43 laptop kernel:  ? count_memcg_events.constprop.0+0x1a/0x3=
0
> Jan 18 14:26:43 laptop kernel:  ? handle_mm_fault+0x1bb/0x2c0
> Jan 18 14:26:43 laptop kernel:  ? do_user_addr_fault+0x36c/0x620
> Jan 18 14:26:43 laptop kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Jan 18 14:26:43 laptop kernel: RIP: 0033:0x74c0e2887ced
> Jan 18 14:26:43 laptop kernel: Code: 04 25 28 00 00 00 48 89 45 c8 31
> c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0>
> Jan 18 14:26:43 laptop kernel: RSP: 002b:00007fffb6d0bd60 EFLAGS:
> 00000246 ORIG_RAX: 0000000000000010
> Jan 18 14:26:43 laptop kernel: RAX: ffffffffffffffda RBX:
> 0000000000000003 RCX: 000074c0e2887ced
> Jan 18 14:26:43 laptop kernel: RDX: 00007fffb6d0be60 RSI:
> 00000000c4009420 RDI: 0000000000000003
> Jan 18 14:26:43 laptop kernel: RBP: 00007fffb6d0bdb0 R08:
> 0000000000000000 R09: 0000000000000000
> Jan 18 14:26:43 laptop kernel: R10: 0000000000000000 R11:
> 0000000000000246 R12: 0000000000000000
> Jan 18 14:26:43 laptop kernel: R13: 00007fffb6d0cd41 R14:
> 00007fffb6d0be60 R15: 0000000000000000
> Jan 18 14:26:43 laptop kernel:  </TASK>
> Jan 18 14:26:43 laptop kernel: ---[ end trace 0000000000000000 ]---
> Jan 18 14:26:59 laptop kernel: BTRFS info (device dm-0): balance:
> ended with status: -22
>
> On Sat, Jan 18, 2025 at 11:32=E2=80=AFPM Dave T <davestechshop@gmail.com>=
 wrote:
> >
> > It's Arch Linux and kernel version 6.12.6-arch1-1
> >
> > Here is the output of btrfs check. (FYI - BTRFS runs on top of
> > dm-crypt, and I passed the "--readonly" flag to "cryptesetup open"
> > before running this. I guess that is why it says "log skipped" below.)
> >
> > [1/8] checking log skipped (none written)
> > [2/8] checking root items
> > [3/8] checking extents
> > ref mismatch on [300690628608 16384] extent item 10, found 9
> > data extent[300690628608, 16384] bytenr mimsmatch, extent item bytenr
> > 300690628608 file item bytenr 0
> > data extent[300690628608, 16384] referencer count mismatch (parent
> > 404419657728) wanted 1 have 0
> > backpointer mismatch on [300690628608 16384]
> > ERROR: errors found in extent allocation tree or chunk allocation
> > [4/8] checking free space cache
> > [5/8] checking fs roots
> > root 336 inode 69064 errors 1040, bad file extent, some csum missing
> > root 336 inode 113496 errors 1040, bad file extent, some csum missing
> > root 336 inode 113558 errors 1040, bad file extent, some csum missing
> > root 336 inode 113563 errors 1040, bad file extent, some csum missing
> > root 336 inode 113624 errors 1040, bad file extent, some csum missing
> > root 336 inode 113839 errors 1040, bad file extent, some csum missing
> > root 336 inode 113931 errors 1040, bad file extent, some csum missing
> > root 336 inode 114145 errors 1040, bad file extent, some csum missing
> > root 336 inode 133069 errors 1040, bad file extent, some csum missing
> > root 336 inode 133072 errors 1040, bad file extent, some csum missing
> > root 336 inode 133074 errors 1040, bad file extent, some csum missing
> > root 336 inode 133153 errors 1040, bad file extent, some csum missing
> > root 336 inode 134151 errors 1040, bad file extent, some csum missing
> > root 336 inode 134154 errors 1040, bad file extent, some csum missing
> > root 336 inode 134782 errors 1040, bad file extent, some csum missing
> > root 336 inode 134783 errors 1040, bad file extent, some csum missing
> > root 336 inode 134919 errors 1040, bad file extent, some csum missing
> > root 336 inode 138340 errors 1040, bad file extent, some csum missing
> > root 336 inode 143988 errors 1040, bad file extent, some csum missing
> > root 336 inode 143995 errors 1040, bad file extent, some csum missing
> > root 336 inode 144002 errors 1040, bad file extent, some csum missing
> > root 336 inode 144003 errors 1040, bad file extent, some csum missing
> > root 336 inode 144014 errors 1040, bad file extent, some csum missing
> > root 336 inode 147060 errors 1040, bad file extent, some csum missing
> > root 336 inode 147061 errors 1040, bad file extent, some csum missing
> > root 336 inode 147063 errors 1040, bad file extent, some csum missing
> > root 336 inode 148818 errors 1040, bad file extent, some csum missing
> > root 336 inode 148819 errors 1040, bad file extent, some csum missing
> > root 336 inode 152019 errors 1040, bad file extent, some csum missing
> > root 336 inode 152027 errors 1040, bad file extent, some csum missing
> > root 336 inode 155177 errors 1040, bad file extent, some csum missing
> > root 336 inode 155769 errors 1040, bad file extent, some csum missing
> > root 336 inode 155772 errors 1040, bad file extent, some csum missing
> > root 336 inode 156233 errors 1040, bad file extent, some csum missing
> > root 336 inode 156236 errors 1040, bad file extent, some csum missing
> > root 336 inode 156293 errors 1040, bad file extent, some csum missing
> > root 336 inode 156497 errors 1040, bad file extent, some csum missing
> > root 336 inode 166294 errors 1040, bad file extent, some csum missing
> > root 336 inode 166419 errors 1040, bad file extent, some csum missing
> > root 336 inode 171167 errors 1040, bad file extent, some csum missing
> > root 336 inode 201429 errors 1040, bad file extent, some csum missing
> > root 336 inode 201564 errors 1040, bad file extent, some csum missing
> > root 336 inode 201575 errors 1040, bad file extent, some csum missing
> > root 336 inode 201577 errors 1040, bad file extent, some csum missing
> > root 336 inode 201584 errors 1040, bad file extent, some csum missing
> > root 336 inode 201585 errors 1040, bad file extent, some csum missing
> > root 336 inode 201597 errors 1040, bad file extent, some csum missing
> > root 336 inode 201666 errors 1040, bad file extent, some csum missing
> > root 336 inode 201673 errors 1040, bad file extent, some csum missing
> > root 336 inode 202502 errors 1040, bad file extent, some csum missing
> > root 336 inode 202504 errors 1040, bad file extent, some csum missing
> > root 336 inode 202506 errors 1040, bad file extent, some csum missing
> > root 336 inode 202517 errors 1040, bad file extent, some csum missing
> > root 336 inode 202520 errors 1040, bad file extent, some csum missing
> > root 336 inode 202521 errors 1040, bad file extent, some csum missing
> > root 336 inode 216890 errors 1040, bad file extent, some csum missing
> > root 336 inode 216938 errors 1040, bad file extent, some csum missing
> > root 336 inode 216948 errors 1040, bad file extent, some csum missing
> > root 336 inode 217216 errors 1040, bad file extent, some csum missing
> > root 336 inode 217218 errors 1040, bad file extent, some csum missing
> > root 336 inode 217367 errors 1040, bad file extent, some csum missing
> > root 336 inode 217632 errors 1040, bad file extent, some csum missing
> > root 336 inode 217635 errors 1040, bad file extent, some csum missing
> > root 336 inode 217636 errors 1040, bad file extent, some csum missing
> > root 336 inode 218188 errors 1040, bad file extent, some csum missing
> > root 336 inode 218198 errors 1040, bad file extent, some csum missing
> > root 336 inode 218201 errors 1040, bad file extent, some csum missing
> > root 336 inode 218204 errors 1040, bad file extent, some csum missing
> > root 336 inode 218594 errors 1040, bad file extent, some csum missing
> > root 336 inode 218596 errors 1040, bad file extent, some csum missing
> > root 336 inode 218600 errors 1040, bad file extent, some csum missing
> > root 336 inode 219356 errors 1040, bad file extent, some csum missing
> > root 336 inode 219357 errors 1040, bad file extent, some csum missing
> > root 336 inode 219358 errors 1040, bad file extent, some csum missing
> > root 336 inode 219793 errors 1040, bad file extent, some csum missing
> > root 336 inode 219797 errors 1040, bad file extent, some csum missing
> > root 336 inode 219810 errors 1040, bad file extent, some csum missing
> > root 336 inode 219944 errors 1040, bad file extent, some csum missing
> > root 336 inode 219946 errors 1040, bad file extent, some csum missing
> > root 336 inode 219949 errors 1040, bad file extent, some csum missing
> > root 336 inode 219950 errors 1040, bad file extent, some csum missing
> > root 336 inode 219954 errors 1040, bad file extent, some csum missing
> > root 336 inode 219955 errors 1040, bad file extent, some csum missing
> > root 336 inode 219956 errors 1040, bad file extent, some csum missing
> > root 336 inode 219958 errors 1040, bad file extent, some csum missing
> > root 336 inode 219959 errors 1040, bad file extent, some csum missing
> > root 336 inode 219967 errors 1040, bad file extent, some csum missing
> > root 336 inode 219974 errors 1040, bad file extent, some csum missing
> > root 336 inode 219975 errors 1040, bad file extent, some csum missing
> > root 336 inode 219976 errors 1040, bad file extent, some csum missing
> > root 336 inode 219977 errors 1040, bad file extent, some csum missing
> > root 336 inode 219978 errors 1040, bad file extent, some csum missing
> > root 336 inode 219979 errors 1040, bad file extent, some csum missing
> > root 336 inode 219981 errors 1040, bad file extent, some csum missing
> > root 336 inode 219983 errors 1040, bad file extent, some csum missing
> > root 336 inode 219985 errors 1040, bad file extent, some csum missing
> > root 336 inode 219987 errors 1040, bad file extent, some csum missing
> > root 336 inode 219988 errors 1040, bad file extent, some csum missing
> > root 336 inode 223581 errors 1040, bad file extent, some csum missing
> > root 336 inode 225590 errors 1040, bad file extent, some csum missing
> > root 336 inode 228361 errors 1040, bad file extent, some csum missing
> > root 336 inode 247689 errors 1040, bad file extent, some csum missing
> > root 336 inode 247693 errors 1040, bad file extent, some csum missing
> > root 336 inode 251782 errors 1040, bad file extent, some csum missing
> > root 336 inode 251787 errors 1040, bad file extent, some csum missing
> > root 336 inode 251788 errors 1040, bad file extent, some csum missing
> > root 336 inode 252228 errors 1040, bad file extent, some csum missing
> > root 336 inode 253363 errors 1040, bad file extent, some csum missing
> > root 336 inode 337045 errors 1040, bad file extent, some csum missing
> > root 336 inode 337096 errors 1040, bad file extent, some csum missing
> > root 336 inode 346036 errors 1040, bad file extent, some csum missing
> > root 336 inode 347087 errors 1040, bad file extent, some csum missing
> > root 336 inode 347091 errors 1040, bad file extent, some csum missing
> > root 336 inode 347236 errors 1040, bad file extent, some csum missing
> > root 336 inode 347266 errors 1040, bad file extent, some csum missing
> > root 336 inode 347271 errors 1040, bad file extent, some csum missing
> > root 336 inode 347288 errors 1040, bad file extent, some csum missing
> > root 336 inode 347372 errors 1040, bad file extent, some csum missing
> > root 336 inode 347375 errors 1040, bad file extent, some csum missing
> > root 336 inode 347391 errors 1040, bad file extent, some csum missing
> > root 336 inode 347396 errors 1040, bad file extent, some csum missing
> > root 336 inode 347397 errors 1040, bad file extent, some csum missing
> > root 336 inode 347455 errors 1040, bad file extent, some csum missing
> > root 2932 inode 322 errors 1040, bad file extent, some csum missing
> > root 2932 inode 323 errors 1040, bad file extent, some csum missing
> > root 2932 inode 325 errors 1040, bad file extent, some csum missing
> > root 2932 inode 326 errors 1040, bad file extent, some csum missing
> > root 2932 inode 336 errors 1040, bad file extent, some csum missing
> > root 2932 inode 339 errors 1040, bad file extent, some csum missing
> > root 2932 inode 340 errors 1040, bad file extent, some csum missing
> > root 2932 inode 347 errors 1040, bad file extent, some csum missing
> > root 2932 inode 348 errors 1040, bad file extent, some csum missing
> > root 2932 inode 355 errors 1040, bad file extent, some csum missing
> > root 2932 inode 363 errors 1040, bad file extent, some csum missing
> > root 2932 inode 364 errors 1040, bad file extent, some csum missing
> > root 2932 inode 365 errors 1040, bad file extent, some csum missing
> > root 2932 inode 366 errors 1040, bad file extent, some csum missing
> > root 2932 inode 368 errors 1040, bad file extent, some csum missing
> > root 2932 inode 371 errors 1040, bad file extent, some csum missing
> > root 2932 inode 381 errors 1040, bad file extent, some csum missing
> > root 2932 inode 386 errors 1040, bad file extent, some csum missing
> > root 2932 inode 389 errors 1040, bad file extent, some csum missing
> > root 2932 inode 390 errors 1040, bad file extent, some csum missing
> > root 2932 inode 394 errors 1040, bad file extent, some csum missing
> > root 2932 inode 395 errors 1040, bad file extent, some csum missing
> > root 2932 inode 396 errors 1040, bad file extent, some csum missing
> > root 2932 inode 397 errors 1040, bad file extent, some csum missing
> > root 2932 inode 400 errors 1040, bad file extent, some csum missing
> > root 2932 inode 401 errors 1040, bad file extent, some csum missing
> > root 2932 inode 408 errors 1040, bad file extent, some csum missing
> > root 2932 inode 409 errors 1040, bad file extent, some csum missing
> > root 2932 inode 415 errors 1040, bad file extent, some csum missing
> > root 2932 inode 417 errors 1040, bad file extent, some csum missing
> > root 2932 inode 419 errors 1040, bad file extent, some csum missing
> > root 2932 inode 426 errors 1040, bad file extent, some csum missing
> > root 2932 inode 427 errors 1040, bad file extent, some csum missing
> > root 2932 inode 428 errors 1040, bad file extent, some csum missing
> > root 2932 inode 431 errors 1040, bad file extent, some csum missing
> > root 2932 inode 432 errors 1040, bad file extent, some csum missing
> > root 2932 inode 433 errors 1040, bad file extent, some csum missing
> > ERROR: errors found in fs roots
> > Opening filesystem to check...
> > Checking filesystem on /dev/mapper/int_luks
> > UUID: a7613217-9dd7-4197-b5dd-e10cc7ed0afa
> > found 786786136064 bytes used, error(s) found
> > total csum bytes: 750877664
> > total tree bytes: 4204183552
> > total fs tree bytes: 2994487296
> > total extent tree bytes: 367149056
> > btree space waste bytes: 721104463
> > file data blocks allocated: 2761159544832
> >  referenced 1384698466304
> >
> > On Sat, Jan 18, 2025 at 11:12=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.=
com> wrote:
> > >
> > >
> > >
> > > =E5=9C=A8 2025/1/19 14:17, Dave T =E5=86=99=E9=81=93:
> > > > Here is the full dmesg. Does this go back far enough?
> > >
> > > It indeed shows the first error. But it doesn't include the kernel ca=
ll
> > > trace shown in your initial mail:
> > >
> > > [  +0.000002] RSP: 002b:00007fffb6d0bd60 EFLAGS: 00000246 ORIG_RAX:
> > > 0000000000000010
> > > [  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
> > > 000074c0e2887ced
> > > [  +0.000002] RDX: 00007fffb6d0be60 RSI: 00000000c4009420 RDI:
> > > 0000000000000003
> > > [  +0.000002] RBP: 00007fffb6d0bdb0 R08: 0000000000000000 R09:
> > > 0000000000000000
> > > [  +0.000001] R10: 0000000000000000 R11: 0000000000000246 R12:
> > > 0000000000000000
> > > [  +0.000001] R13: 00007fffb6d0cd41 R14: 00007fffb6d0be60 R15:
> > > 0000000000000000
> > > [  +0.000004]  </TASK>
> > > [  +0.000001] ---[ end trace 0000000000000000 ]---
> > > [ +15.464049] BTRFS info (device dm-0): balance: ended with status: -=
22
> > >
> > > I guess that's no longer in the dmesg buffer?
> > >
> > >
> > > > I will run the "btrfs check --readonly" soon.
> > > >
> > > > # dmesg
> > >
> > > > [  +5.340568] BTRFS info (device dm-0): relocating block group
> > > > 299998642176 flags data
> > > > [  +3.354148] BTRFS info (device dm-0): found 26160 extents, stage:
> > > > move data extents
> > > > [  +3.453557] BTRFS critical (device dm-0): unable to find chunk ma=
p
> > > > for logical 404419657728 length 16384
> > > > [  +0.000011] BTRFS critical (device dm-0): unable to find chunk ma=
p
> > > > for logical 404419657728 length 16384
> > > > [Jan18 15:44] BTRFS info (device dm-0): balance: ended with status:=
 -5
> > > > [Jan18 17:31] netfs: FS-Cache loaded
> > >
> > > So far that balance is trying to balancing a tree block at the next
> > > block group. That definitely doesn't look correct.
> > >
> > > Please also provide the kernel version.
> > >
> > > Thanks,
> > > Qu

