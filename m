Return-Path: <linux-btrfs+bounces-11003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17759A1603F
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 06:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BAA1658D2
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jan 2025 05:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0390615350B;
	Sun, 19 Jan 2025 05:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYiAO7gn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F310F9
	for <linux-btrfs@vger.kernel.org>; Sun, 19 Jan 2025 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737262977; cv=none; b=M1uz2CAmJNZJhHbYnb/TN11uGkHEB6cMz9W1Jsbxqi5LsN6TlKkSZ2siriPNsPmqACq1AS8oItIY0CQTQp9TL/5q9xReAMzL7bMntjsnYs5XENcdTdSq2Nyvqm9VnIJ8b5iGLdzmqAb0u+m9T57qfPngWZp13RMZTggsEENlZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737262977; c=relaxed/simple;
	bh=NPipHX9E+XULhIKk6d2RI3G9R1nA2lbaMeRYz3qV8z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlKwzGaleti6j1CayBYqGQ43MoA2J7xiWxq/bsffYYwQp9hmXt/tCgwS66z7Gvp09x4zeVpP5GaKOyT81IRkPPevgZ2CTjdFOcdmWQEur+eJ63XbokANiGfg9YuLz8HHqTL/AtO5U0Xx6ALh100nUWXhoKeymSh2afBOT7VQIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYiAO7gn; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e54d268bc3dso6442330276.1
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jan 2025 21:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737262972; x=1737867772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHdjwz6R+C9JuaetLlJVoZ+UdzA/GU48unxeNO4KxL4=;
        b=CYiAO7gn/78TSEdjTZ+0tykoWieqvGj56vH1poWQdTjvPrFnflCX8cuOG3O6sm9BhM
         ukT1tPKqAcNNv855Vn4Wd0adP8gW+pyv2W20oTSYtcU3y4NhS4Mt8n5RI3C6QUR4Hd+9
         XhplZEFDPnb5rgzS6DVQP3PLcpmb9G0a3hu4pfa4TaWv5RM/Z3PYO84uviozQTj3ZyBR
         +k7eWWiOrRW7weVxHwnW8jQB8GP8COTErtOOG0bVWfQh+NN5poBsDktYx2Acx/3WQMOY
         W7bJ8YCcc2zNvxFCr2ZEur9sKAkdeUDjLtEPEQaA7y39/Yio71nadXQ4JJRBG3Nm7Pel
         v4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737262972; x=1737867772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHdjwz6R+C9JuaetLlJVoZ+UdzA/GU48unxeNO4KxL4=;
        b=ogsOGorR7g86OvV87xBNLHTLoslDSdiiX/Vy6IqExgi2E65nRNdyCuAqERe8iZQRnq
         tsp+iKcmjSD9Yp+5D45kg59r54fo+/M7CXEFhSGoFZnIOz3nuq3z4WcFe8lYo5qO/wYl
         amktpIn1C/JxKQrbFg8AlY+7UWn8cdcsa8kMJmDBH6s/ha6j/7KKuu5CYtIhgbMTv6vS
         PP3XXFY06Ph9o8Dd3CRVuKYFKicpzoEaq+NXNREc4gFHPwHa0UxOX8plMrEhqrQIK5A4
         7ttelAheBhsdEYL6TsoikKBR25K+DnUC+zVXgoVRBD5DMyU/yEhin1DKm/3h6S9mho8W
         Xnbw==
X-Gm-Message-State: AOJu0YxcieNnxDuQDU5Cucwz1Zh/KQ8uf1y3jFSijgLqwhBE14SniJyQ
	w3hkZUeLQqFNGFiUFw4p1DK6pj6gY2CkaR4FjqQhgXjRjbIsAGlA3/YnPfGij5knzpZBXeHfSN8
	ClUvo7RWxLQFLd6nu3RSsC9EjYHq3YS8KDvQ=
X-Gm-Gg: ASbGncsgU1d8chKgVMTSJi2JnCe1MoKHoL5pxy/pWvfN/4XtJoF+Ie5SCVNdZjYsQuh
	PJXDfdH2DnTzxHxl/XKM5VKPOYYLXeipqfmSHBHo3WtGpwoIYGZA=
X-Google-Smtp-Source: AGHT+IGybc1ZjjBmcjhAYUYLoMFpJo3mBwJ49UyKWdSkTvuqWRMX6FNzbqygziDP7w94hErU4vLnQgmpZHo7qMSF8u4=
X-Received: by 2002:a05:690c:6d88:b0:6ef:9017:3cc8 with SMTP id
 00721157ae682-6f6eb93dd94mr69406367b3.31.1737262971862; Sat, 18 Jan 2025
 21:02:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGdWbB4zZ4Xz2r7WSkC+2xt8umXn3jP6Gg43t7e8REbjJ2iioA@mail.gmail.com>
 <43f5b804-d18e-4bd6-8c19-08b4c688307c@gmx.com> <CAGdWbB6A5S7-+VM9HsPyb=5FMTqOSb3GVCzS+ix0vvRg3sfJ5g@mail.gmail.com>
 <34c2418a-c08e-4408-bf6e-3216d6b64ea3@gmx.com> <CAGdWbB7tFj_CT_XGEb0egRF+pDqB9+bVeP-Y1643y0WvsMcfMg@mail.gmail.com>
In-Reply-To: <CAGdWbB7tFj_CT_XGEb0egRF+pDqB9+bVeP-Y1643y0WvsMcfMg@mail.gmail.com>
From: Dave T <davestechshop@gmail.com>
Date: Sun, 19 Jan 2025 00:02:41 -0500
X-Gm-Features: AbW1kvaD6fVXRxNj2McK_fxGlrDueolqf8ABDqiCGKwaVijcJSFePpow9b7h77w
Message-ID: <CAGdWbB57fOy3hZdeo3FykDQOfvkHjj-9zQodN_eZ+OLFXQKHVw@mail.gmail.com>
Subject: Re: BTRFS critical: unable to find chunk map for logical
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Does this section of the journal include what you need?

Jan 18 14:23:53 laptop kernel: BTRFS info (device dm-0): found 37399
extents, stage: move data extents
Jan 18 14:24:14 laptop kernel: BTRFS info (device dm-0): found 37399
extents, stage: update data pointers
Jan 18 14:24:25 laptop kernel: BTRFS info (device dm-0): relocating
block group 346437976064 flags data
Jan 18 14:24:29 laptop kernel: BTRFS info (device dm-0): found 54017
extents, stage: move data extents
Jan 18 14:24:50 laptop kernel: BTRFS info (device dm-0): found 54017
extents, stage: update data pointers
Jan 18 14:25:02 laptop kernel: BTRFS info (device dm-0): relocating
block group 315131691008 flags data
Jan 18 14:25:04 laptop kernel: BTRFS info (device dm-0): found 10490
extents, stage: move data extents
Jan 18 14:25:10 laptop kernel: BTRFS info (device dm-0): found 10490
extents, stage: update data pointers
Jan 18 14:25:14 laptop kernel: BTRFS info (device dm-0): relocating
block group 314057949184 flags data
Jan 18 14:25:16 laptop kernel: BTRFS info (device dm-0): found 12169
extents, stage: move data extents
Jan 18 14:25:27 laptop kernel: BTRFS info (device dm-0): found 12169
extents, stage: update data pointers
Jan 18 14:25:33 laptop kernel: BTRFS info (device dm-0): relocating
block group 305400905728 flags data
Jan 18 14:25:36 laptop kernel: BTRFS info (device dm-0): found 23943
extents, stage: move data extents
Jan 18 14:25:55 laptop kernel: BTRFS info (device dm-0): found 23943
extents, stage: update data pointers
Jan 18 14:26:06 laptop kernel: BTRFS info (device dm-0): relocating
block group 303219867648 flags data
Jan 18 14:26:08 laptop kernel: BTRFS info (device dm-0): found 21717
extents, stage: move data extents
Jan 18 14:26:27 laptop kernel: BTRFS info (device dm-0): found 21717
extents, stage: update data pointers
Jan 18 14:26:37 laptop kernel: BTRFS info (device dm-0): relocating
block group 299998642176 flags data
Jan 18 14:26:40 laptop kernel: BTRFS info (device dm-0): found 26155
extents, stage: move data extents
Jan 18 14:26:43 laptop kernel: BTRFS info (device dm-0): leaf
1581486112768 gen 1332468 total ptrs 101 free space 8877 owner 2
Jan 18 14:26:43 laptop kernel:         item 0 key (301068791808 168
4096) itemoff 16233 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 958990 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062339653632 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 2062339588096 count 1
Jan 18 14:26:43 laptop kernel:         item 1 key (301068795904 168
8192) itemoff 16105 itemsize 128
Jan 18 14:26:43 laptop kernel:                 extent refs 8 gen 958990 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598985060352 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1598985043968 count 1
Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
backref parent 1598985027584 count 1
Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
backref parent 1598985011200 count 1
Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
backref parent 1598984994816 count 1
Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
backref parent 1598984962048 count 1
Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
backref parent 1598984929280 count 1
Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
backref parent 1598984912896 count 1
Jan 18 14:26:43 laptop kernel:         item 2 key (301068804096 168
4096) itemoff 15964 itemsize 141
Jan 18 14:26:43 laptop kernel:                 extent refs 9 gen 958990 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598749818880 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1598749802496 count 1
Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
backref parent 1598749786112 count 1
Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
backref parent 1598741512192 count 1
Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
backref parent 1598741495808 count 1
Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
backref parent 1598741430272 count 1
Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
backref parent 1598741397504 count 1
Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
backref parent 1598741381120 count 1
Jan 18 14:26:43 laptop kernel:                 ref#8: shared data
backref parent 1598741348352 count 1
Jan 18 14:26:43 laptop kernel:         item 3 key (301068808192 168
4096) itemoff 15927 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599069863936 count 1
Jan 18 14:26:43 laptop kernel:         item 4 key (301068812288 168
86016) itemoff 15877 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1263812 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062155202560 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 2062155186176 count 1
Jan 18 14:26:43 laptop kernel:         item 5 key (301068898304 168
73728) itemoff 15827 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1302583 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062348271616 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 2062348255232 count 1
Jan 18 14:26:43 laptop kernel:         item 6 key (301068972032 168
8192) itemoff 15790 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581288947712 count 1
Jan 18 14:26:43 laptop kernel:         item 7 key (301068980224 168
4096) itemoff 15753 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1208508 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599068258304 count 1
Jan 18 14:26:43 laptop kernel:         item 8 key (301068984320 168
8192) itemoff 15716 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581288947712 count 1
Jan 18 14:26:43 laptop kernel:         item 9 key (301068992512 168
4096) itemoff 15679 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062551859200 count 1
Jan 18 14:26:43 laptop kernel:         item 10 key (301069000704 168
4096) itemoff 15525 itemsize 154
Jan 18 14:26:43 laptop kernel:                 extent refs 10 gen 958990 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062562082816 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 2062562066432 count 1
Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
backref parent 2062562050048 count 1
Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
backref parent 2062562033664 count 1
Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
backref parent 2062561918976 count 1
Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
backref parent 2062561886208 count 1
Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
backref parent 2062340702208 count 1
Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
backref parent 1598918508544 count 1
Jan 18 14:26:43 laptop kernel:                 ref#8: shared data
backref parent 1598918492160 count 1
Jan 18 14:26:43 laptop kernel:                 ref#9: shared data
backref parent 1598918475776 count 1
Jan 18 14:26:43 laptop kernel:         item 11 key (301069004800 168
131072) itemoff 15462 itemsize 63
Jan 18 14:26:43 laptop kernel:                 extent refs 3 gen 906904 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062150959104 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 2062150795264 count 1
Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
backref parent 1599015010304 count 1
Jan 18 14:26:43 laptop kernel:         item 12 key (301069135872 168
77824) itemoff 15425 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 906904 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598714101760 count 1
Jan 18 14:26:43 laptop kernel:         item 13 key (301069213696 168
86016) itemoff 15271 itemsize 154
Jan 18 14:26:43 laptop kernel:                 extent refs 10 gen 906904 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062172192768 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 2062172176384 count 1
Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
backref parent 2062172160000 count 1
Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
backref parent 2062172143616 count 1
Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
backref parent 2062172127232 count 1
Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
backref parent 2062172110848 count 1
Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
backref parent 2062172094464 count 1
Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
backref parent 1599079170048 count 1
Jan 18 14:26:43 laptop kernel:                 ref#8: shared data
backref parent 1599079153664 count 1
Jan 18 14:26:43 laptop kernel:                 ref#9: shared data
backref parent 1599079071744 count 1
Jan 18 14:26:43 laptop kernel:         item 14 key (301069299712 168
12288) itemoff 15208 itemsize 63
Jan 18 14:26:43 laptop kernel:                 extent refs 3 gen 958990 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581203456000 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1581203423232 count 1
Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
backref parent 1581203390464 count 1
Jan 18 14:26:43 laptop kernel:         item 15 key (301069312000 168
49152) itemoff 15080 itemsize 128
Jan 18 14:26:43 laptop kernel:                 extent refs 8 gen 1070104 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599082283008 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1599082266624 count 1
Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
backref parent 1599082250240 count 1
Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
backref parent 1599082217472 count 1
Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
backref parent 1599082201088 count 1
Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
backref parent 1598950162432 count 1
Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
backref parent 1598950146048 count 1
Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
backref parent 1598950096896 count 1
Jan 18 14:26:43 laptop kernel:         item 16 key (301069365248 168
4096) itemoff 15043 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1037514 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598873567232 count 1
Jan 18 14:26:43 laptop kernel:         item 17 key (301069369344 168
4096) itemoff 15006 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062551891968 count 1
Jan 18 14:26:43 laptop kernel:         item 18 key (301069373440 168
73728) itemoff 14969 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1320338 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599018188800 count 1
Jan 18 14:26:43 laptop kernel:         item 19 key (301069447168 168
8192) itemoff 14932 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581288947712 count 1
Jan 18 14:26:43 laptop kernel:         item 20 key (301069455360 168
8192) itemoff 14895 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581288947712 count 1
Jan 18 14:26:43 laptop kernel:         item 21 key (301069463552 168
45056) itemoff 14858 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1315995 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598918557696 count 1
Jan 18 14:26:43 laptop kernel:         item 22 key (301069508608 168
24576) itemoff 14821 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598964023296 count 1
Jan 18 14:26:43 laptop kernel:         item 23 key (301069533184 168
45056) itemoff 14758 itemsize 63
Jan 18 14:26:43 laptop kernel:                 extent refs 3 gen 908474 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599041290240 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1599041273856 count 1
Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
backref parent 1599041257472 count 1
Jan 18 14:26:43 laptop kernel:         item 24 key (301069578240 168
4096) itemoff 14721 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581855440896 count 1
Jan 18 14:26:43 laptop kernel:         item 25 key (301069582336 168
180224) itemoff 14684 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 571604 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062488043520 count 1
Jan 18 14:26:43 laptop kernel:         item 26 key (301069762560 168
81920) itemoff 14647 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1297538 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1582871822336 count 1
Jan 18 14:26:43 laptop kernel:         item 27 key (301069844480 168
20480) itemoff 14610 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581288947712 count 1
Jan 18 14:26:43 laptop kernel:         item 28 key (301069864960 168
69632) itemoff 14573 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 906904 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598940725248 count 1
Jan 18 14:26:43 laptop kernel:         item 29 key (301069934592 168
20480) itemoff 14536 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1217768 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062935654400 count 1
Jan 18 14:26:43 laptop kernel:         item 30 key (301069955072 168
4096) itemoff 14499 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218348 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599215878144 count 1
Jan 18 14:26:43 laptop kernel:         item 31 key (301069959168 168
4096) itemoff 14462 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218348 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598976933888 count 1
Jan 18 14:26:43 laptop kernel:         item 32 key (301069963264 168
4096) itemoff 14425 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062552334336 count 1
Jan 18 14:26:43 laptop kernel:         item 33 key (301069967360 168
45056) itemoff 14388 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1315995 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598918557696 count 1
Jan 18 14:26:43 laptop kernel:         item 34 key (301070016512 168
118784) itemoff 14273 itemsize 115
Jan 18 14:26:43 laptop kernel:                 extent refs 7 gen 1217727 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062441398272 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1598929846272 count 1
Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
backref parent 1598929797120 count 1
Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
backref parent 1598929764352 count 1
Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
backref parent 1598929747968 count 1
Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
backref parent 1598929731584 count 1
Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
backref parent 1598929649664 count 1
Jan 18 14:26:43 laptop kernel:         item 35 key (301070135296 168
4096) itemoff 14236 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218430 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599215878144 count 1
Jan 18 14:26:43 laptop kernel:         item 36 key (301070139392 168
53248) itemoff 14186 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1070104 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599091015680 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1599090999296 count 1
Jan 18 14:26:43 laptop kernel:         item 37 key (301070192640 168
8192) itemoff 14149 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1245771 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062686699520 count 1
Jan 18 14:26:43 laptop kernel:         item 38 key (301070200832 168
69632) itemoff 14112 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 6 gen 1007611 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599136923648 count 6
Jan 18 14:26:43 laptop kernel:         item 39 key (301070270464 168
4096) itemoff 14075 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062553006080 count 1
Jan 18 14:26:43 laptop kernel:         item 40 key (301070274560 168
110592) itemoff 14025 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 906904 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598829887488 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1598829772800 count 1
Jan 18 14:26:43 laptop kernel:         item 41 key (301070385152 168
69632) itemoff 13988 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1217759 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062152400896 count 1
Jan 18 14:26:43 laptop kernel:         item 42 key (301070454784 168
77824) itemoff 13951 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1012715 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062722400256 count 1
Jan 18 14:26:43 laptop kernel:         item 43 key (301070532608 168
20480) itemoff 13914 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598940577792 count 1
Jan 18 14:26:43 laptop kernel:         item 44 key (301070553088 168
131072) itemoff 13877 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1182909 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 71836729344 count 1
Jan 18 14:26:43 laptop kernel:         item 45 key (301070684160 168
20480) itemoff 13840 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581288947712 count 1
Jan 18 14:26:43 laptop kernel:         item 46 key (301070704640 168
4096) itemoff 13803 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218355 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581489029120 count 1
Jan 18 14:26:43 laptop kernel:         item 47 key (301070708736 168
4096) itemoff 13766 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218359 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599215878144 count 1
Jan 18 14:26:43 laptop kernel:         item 48 key (301070712832 168
65536) itemoff 13586 itemsize 180
Jan 18 14:26:43 laptop kernel:                 extent refs 12 gen
1069705 flags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598926536704 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1598926454784 count 1
Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
backref parent 1598926422016 count 1
Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
backref parent 1598926405632 count 1
Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
backref parent 1598926356480 count 1
Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
backref parent 1598926340096 count 1
Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
backref parent 1598926323712 count 1
Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
backref parent 1598926307328 count 1
Jan 18 14:26:43 laptop kernel:                 ref#8: shared data
backref parent 1598926290944 count 1
Jan 18 14:26:43 laptop kernel:                 ref#9: shared data
backref parent 1598926274560 count 1
Jan 18 14:26:43 laptop kernel:                 ref#10: shared data
backref parent 1598926209024 count 1
Jan 18 14:26:43 laptop kernel:                 ref#11: shared data
backref parent 1598926192640 count 1
Jan 18 14:26:43 laptop kernel:         item 49 key (301070778368 168
16384) itemoff 13536 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1036734 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599053217792 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1599053070336 count 1
Jan 18 14:26:43 laptop kernel:         item 50 key (301070798848 168
4096) itemoff 13499 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062553006080 count 1
Jan 18 14:26:43 laptop kernel:         item 51 key (301070802944 168
98304) itemoff 13371 itemsize 128
Jan 18 14:26:43 laptop kernel:                 extent refs 8 gen 566208 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599071502336 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1599071485952 count 1
Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
backref parent 1599071469568 count 1
Jan 18 14:26:43 laptop kernel:                 ref#3: shared data
backref parent 1599071453184 count 1
Jan 18 14:26:43 laptop kernel:                 ref#4: shared data
backref parent 1599071436800 count 1
Jan 18 14:26:43 laptop kernel:                 ref#5: shared data
backref parent 1599071420416 count 1
Jan 18 14:26:43 laptop kernel:                 ref#6: shared data
backref parent 1599071404032 count 1
Jan 18 14:26:43 laptop kernel:                 ref#7: shared data
backref parent 1599071387648 count 1
Jan 18 14:26:43 laptop kernel:         item 52 key (301070901248 168
49152) itemoff 13334 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1315995 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598918557696 count 1
Jan 18 14:26:43 laptop kernel:         item 53 key (301070950400 168
8192) itemoff 13297 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581288947712 count 1
Jan 18 14:26:43 laptop kernel:         item 54 key (301070958592 168
8192) itemoff 13260 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581234864128 count 1
Jan 18 14:26:43 laptop kernel:         item 55 key (301070966784 168
8192) itemoff 13223 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581234864128 count 1
Jan 18 14:26:43 laptop kernel:         item 56 key (301070974976 168
45056) itemoff 13160 itemsize 63
Jan 18 14:26:43 laptop kernel:                 extent refs 3 gen 908474 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599041290240 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1599041273856 count 1
Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
backref parent 1599041257472 count 1
Jan 18 14:26:43 laptop kernel:         item 57 key (301071020032 168
8192) itemoff 13123 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581234864128 count 1
Jan 18 14:26:43 laptop kernel:         item 58 key (301071028224 168
8192) itemoff 13086 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1327485 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581234864128 count 1
Jan 18 14:26:43 laptop kernel:         item 59 key (301071036416 168
4096) itemoff 13049 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599071518720 count 1
Jan 18 14:26:43 laptop kernel:         item 60 key (301071040512 168
86016) itemoff 12986 itemsize 63
Jan 18 14:26:43 laptop kernel:                 extent refs 3 gen 906904 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599145459712 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1599145443328 count 1
Jan 18 14:26:43 laptop kernel:                 ref#2: shared data
backref parent 1599145426944 count 1
Jan 18 14:26:43 laptop kernel:         item 61 key (301071126528 168
102400) itemoff 12936 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1317825 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2063022342144 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 2063022325760 count 1
Jan 18 14:26:43 laptop kernel:         item 62 key (301071228928 168
4096) itemoff 12899 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1007933 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598722490368 count 1
Jan 18 14:26:43 laptop kernel:         item 63 key (301071233024 168
8192) itemoff 12862 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1247702 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2063034925056 count 1
Jan 18 14:26:43 laptop kernel:         item 64 key (301071241216 168
4096) itemoff 12825 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1247702 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599069175808 count 1
Jan 18 14:26:43 laptop kernel:         item 65 key (301071245312 168
4096) itemoff 12788 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1245772 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598555897856 count 1
Jan 18 14:26:43 laptop kernel:         item 66 key (301071249408 168
57344) itemoff 12751 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 908474 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062583218176 count 1
Jan 18 14:26:43 laptop kernel:         item 67 key (301071306752 168
28672) itemoff 12714 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1217768 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599169822720 count 1
Jan 18 14:26:43 laptop kernel:         item 68 key (301071335424 168
4096) itemoff 12677 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1200554 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1582963212288 count 1
Jan 18 14:26:43 laptop kernel:         item 69 key (301071339520 168
20480) itemoff 12640 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1086462 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599109824512 count 1
Jan 18 14:26:43 laptop kernel:         item 70 key (301071360000 168
4096) itemoff 12603 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1086462 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062646919168 count 1
Jan 18 14:26:43 laptop kernel:         item 71 key (301071364096 168
4096) itemoff 12566 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1200554 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1582969438208 count 1
Jan 18 14:26:43 laptop kernel:         item 72 key (301071368192 168
4096) itemoff 12529 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1086462 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599024381952 count 1
Jan 18 14:26:43 laptop kernel:         item 73 key (301071372288 168
8192) itemoff 12492 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1007746 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599154323456 count 1
Jan 18 14:26:43 laptop kernel:         item 74 key (301071380480 168
4096) itemoff 12455 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1007894 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599136923648 count 1
Jan 18 14:26:43 laptop kernel:         item 75 key (301071384576 168
4096) itemoff 12418 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218357 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598976933888 count 1
Jan 18 14:26:43 laptop kernel:         item 76 key (301071388672 168
4096) itemoff 12381 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218359 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1581489029120 count 1
Jan 18 14:26:43 laptop kernel:         item 77 key (301071392768 168
4096) itemoff 12344 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1218370 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598976933888 count 1
Jan 18 14:26:43 laptop kernel:         item 78 key (301071396864 168
86016) itemoff 12307 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 751768 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599081250816 count 1
Jan 18 14:26:43 laptop kernel:         item 79 key (301071482880 168
102400) itemoff 12257 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 906904 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599154126848 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1599154110464 count 1
Jan 18 14:26:43 laptop kernel:         item 80 key (301071585280 168
69632) itemoff 12220 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 906904 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062165999616 count 1
Jan 18 14:26:43 laptop kernel:         item 81 key (301071654912 168
77824) itemoff 12183 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 906904 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062441365504 count 1
Jan 18 14:26:43 laptop kernel:         item 82 key (301071732736 168
65536) itemoff 12133 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 906904 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062584479744 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 2062166065152 count 1
Jan 18 14:26:43 laptop kernel:         item 83 key (301071798272 168
32768) itemoff 12096 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1325121 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062597505024 count 1
Jan 18 14:26:43 laptop kernel:         item 84 key (301071831040 168
8192) itemoff 12059 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1247702 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2063032139776 count 1
Jan 18 14:26:43 laptop kernel:         item 85 key (301071839232 168
4096) itemoff 12022 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1247702 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599069175808 count 1
Jan 18 14:26:43 laptop kernel:         item 86 key (301071843328 168
65536) itemoff 11972 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 906904 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2063009595392 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 2063009579008 count 1
Jan 18 14:26:43 laptop kernel:         item 87 key (301071908864 168
90112) itemoff 11922 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1263812 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062155202560 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 2062155186176 count 1
Jan 18 14:26:43 laptop kernel:         item 88 key (301071998976 168
4096) itemoff 11872 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 1218906 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598779932672 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1598779899904 count 1
Jan 18 14:26:43 laptop kernel:         item 89 key (301072003072 168
73728) itemoff 11822 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 906904 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598928273408 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1598928257024 count 1
Jan 18 14:26:43 laptop kernel:         item 90 key (301072076800 168
65536) itemoff 11785 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 906904 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062807810048 count 1
Jan 18 14:26:43 laptop kernel:         item 91 key (301072142336 168
90112) itemoff 11735 itemsize 50
Jan 18 14:26:43 laptop kernel:                 extent refs 2 gen 906904 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599138496512 count 1
Jan 18 14:26:43 laptop kernel:                 ref#1: shared data
backref parent 1599138480128 count 1
Jan 18 14:26:43 laptop kernel:         item 92 key (301072232448 168
45056) itemoff 11698 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1315995 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598918557696 count 1
Jan 18 14:26:43 laptop kernel:         item 93 key (301072277504 168
40960) itemoff 11661 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1325014 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1582604926976 count 1
Jan 18 14:26:43 laptop kernel:         item 94 key (301072318464 168
4096) itemoff 11624 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1245772 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1598676369408 count 1
Jan 18 14:26:43 laptop kernel:         item 95 key (301072322560 168
4096) itemoff 11587 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1200554 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1582969438208 count 1
Jan 18 14:26:43 laptop kernel:         item 96 key (301072326656 168
32768) itemoff 11550 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1217768 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 2062553464832 count 1
Jan 18 14:26:43 laptop kernel:         item 97 key (301072359424 168
4096) itemoff 11513 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1245772 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 71840104448 count 1
Jan 18 14:26:43 laptop kernel:         item 98 key (301072363520 168
4096) itemoff 11476 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599071518720 count 1
Jan 18 14:26:43 laptop kernel:         item 99 key (301072367616 168
12288) itemoff 11439 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 698261 fla=
gs 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1583155068928 count 1
Jan 18 14:26:43 laptop kernel:         item 100 key (301072379904 168
4096) itemoff 11402 itemsize 37
Jan 18 14:26:43 laptop kernel:                 extent refs 1 gen 1026053 fl=
ags 1
Jan 18 14:26:43 laptop kernel:                 ref#0: shared data
backref parent 1599071518720 count 1
Jan 18 14:26:43 laptop kernel: BTRFS error (device dm-0): tree block
extent item (404419657728) is not found in extent tree
Jan 18 14:26:43 laptop kernel: ------------[ cut here ]------------
Jan 18 14:26:43 laptop kernel: WARNING: CPU: 0 PID: 2431 at
fs/btrfs/relocation.c:3308 add_data_references+0x520/0x540 [btrfs]
Jan 18 14:26:43 laptop kernel: Modules linked in: rfcomm ccm cmac
algif_hash algif_skcipher af_alg bnep snd_hda_codec_hdmi snd_hd>
Jan 18 14:26:43 laptop kernel:  platform_profile i2c_smbus cfg80211
firmware_attributes_class wmi_bmof pps_core intel_wmi_thunder>
Jan 18 14:26:43 laptop kernel:  video i8042 wmi serio vfat fat
Jan 18 14:26:43 laptop kernel: CPU: 0 UID: 0 PID: 2431 Comm: btrfs
Tainted: G     U             6.12.9-arch1-1 #1 4fef9133193e91a>
Jan 18 14:26:43 laptop kernel: Tainted: [U]=3DUSER
Jan 18 14:26:43 laptop kernel: Hardware name: LENOVO
Jan 18 14:26:43 laptop kernel: RIP: 0010:add_data_references+0x520/0x540 [b=
trfs]
Jan 18 14:26:43 laptop kernel: Code: 48 8b 6c 24 10 45 89 f5 e9 0e ff
ff ff 4c 87 fd 49 8b 3f e8 02 fd f8 ff 4c 89 ea 48 c7 c6 a8>
Jan 18 14:26:43 laptop kernel: RSP: 0018:ffffc171c3acb938 EFLAGS: 00010296
Jan 18 14:26:43 laptop kernel: RAX: 0000000000000000 RBX:
ffffc171c3acb96f RCX: 0000000000000027
Jan 18 14:26:43 laptop kernel: RDX: 0000000000000000 RSI:
0000000000000001 RDI: ffff9afa024218c0
Jan 18 14:26:43 laptop kernel: RBP: ffff9af6ca740000 R08:
0000000000000000 R09: ffffc171c3acb718
Jan 18 14:26:43 laptop kernel: R10: ffffffffba6b5528 R11:
0000000000000003 R12: ffff9af8eefb1000
Jan 18 14:26:43 laptop kernel: R13: 0000005e294a4000 R14:
0000000000000001 R15: ffff9af90bbdf690
Jan 18 14:26:43 laptop kernel: FS:  000074c0e270c900(0000)
GS:ffff9afa02400000(0000) knlGS:0000000000000000
Jan 18 14:26:43 laptop kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
Jan 18 14:26:43 laptop kernel: CR2: 000002a8050f5000 CR3:
00000001680ae003 CR4: 00000000003706f0
Jan 18 14:26:43 laptop kernel: Call Trace:
Jan 18 14:26:43 laptop kernel:  <TASK>
Jan 18 14:26:43 laptop kernel:  ? add_data_references+0x520/0x540
[btrfs 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
Jan 18 14:26:43 laptop kernel:  ? __warn.cold+0x93/0xf6
Jan 18 14:26:43 laptop kernel:  ? add_data_references+0x520/0x540
[btrfs 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
Jan 18 14:26:43 laptop kernel:  ? report_bug+0xff/0x140
Jan 18 14:26:43 laptop kernel:  ? handle_bug+0x58/0x90
Jan 18 14:26:43 laptop kernel:  ? exc_invalid_op+0x17/0x70
Jan 18 14:26:43 laptop kernel:  ? asm_exc_invalid_op+0x1a/0x20
Jan 18 14:26:43 laptop kernel:  ? add_data_references+0x520/0x540
[btrfs 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
Jan 18 14:26:43 laptop kernel:  ? add_data_references+0x520/0x540
[btrfs 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
Jan 18 14:26:43 laptop kernel:  relocate_block_group+0x348/0x540
[btrfs 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
Jan 18 14:26:43 laptop kernel:  btrfs_relocate_block_group+0x242/0x410
[btrfs 9ce4705c599aca73253a1a011fb27cadcc14e6bf]
Jan 18 14:26:43 laptop kernel:  btrfs_relocate_chunk+0x3f/0x130 [btrfs
9ce4705c599aca73253a1a011fb27cadcc14e6bf]
Jan 18 14:26:43 laptop kernel:  btrfs_balance+0x7fe/0x1020 [btrfs
9ce4705c599aca73253a1a011fb27cadcc14e6bf]
Jan 18 14:26:43 laptop kernel:  btrfs_ioctl+0x2329/0x25c0 [btrfs
9ce4705c599aca73253a1a011fb27cadcc14e6bf]
Jan 18 14:26:43 laptop kernel:  ? syscall_exit_to_user_mode+0x37/0x1c0
Jan 18 14:26:43 laptop kernel:  ? do_syscall_64+0x8e/0x190
Jan 18 14:26:43 laptop kernel:  __x64_sys_ioctl+0x91/0xd0
Jan 18 14:26:43 laptop kernel:  do_syscall_64+0x82/0x190
Jan 18 14:26:43 laptop kernel:  ? do_fault+0x2dc/0x4c0
Jan 18 14:26:43 laptop kernel:  ? __handle_mm_fault+0x7c2/0xfa0
Jan 18 14:26:43 laptop kernel:  ? __count_memcg_events+0x53/0xf0
Jan 18 14:26:43 laptop kernel:  ? count_memcg_events.constprop.0+0x1a/0x30
Jan 18 14:26:43 laptop kernel:  ? handle_mm_fault+0x1bb/0x2c0
Jan 18 14:26:43 laptop kernel:  ? do_user_addr_fault+0x36c/0x620
Jan 18 14:26:43 laptop kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Jan 18 14:26:43 laptop kernel: RIP: 0033:0x74c0e2887ced
Jan 18 14:26:43 laptop kernel: Code: 04 25 28 00 00 00 48 89 45 c8 31
c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0>
Jan 18 14:26:43 laptop kernel: RSP: 002b:00007fffb6d0bd60 EFLAGS:
00000246 ORIG_RAX: 0000000000000010
Jan 18 14:26:43 laptop kernel: RAX: ffffffffffffffda RBX:
0000000000000003 RCX: 000074c0e2887ced
Jan 18 14:26:43 laptop kernel: RDX: 00007fffb6d0be60 RSI:
00000000c4009420 RDI: 0000000000000003
Jan 18 14:26:43 laptop kernel: RBP: 00007fffb6d0bdb0 R08:
0000000000000000 R09: 0000000000000000
Jan 18 14:26:43 laptop kernel: R10: 0000000000000000 R11:
0000000000000246 R12: 0000000000000000
Jan 18 14:26:43 laptop kernel: R13: 00007fffb6d0cd41 R14:
00007fffb6d0be60 R15: 0000000000000000
Jan 18 14:26:43 laptop kernel:  </TASK>
Jan 18 14:26:43 laptop kernel: ---[ end trace 0000000000000000 ]---
Jan 18 14:26:59 laptop kernel: BTRFS info (device dm-0): balance:
ended with status: -22

On Sat, Jan 18, 2025 at 11:32=E2=80=AFPM Dave T <davestechshop@gmail.com> w=
rote:
>
> It's Arch Linux and kernel version 6.12.6-arch1-1
>
> Here is the output of btrfs check. (FYI - BTRFS runs on top of
> dm-crypt, and I passed the "--readonly" flag to "cryptesetup open"
> before running this. I guess that is why it says "log skipped" below.)
>
> [1/8] checking log skipped (none written)
> [2/8] checking root items
> [3/8] checking extents
> ref mismatch on [300690628608 16384] extent item 10, found 9
> data extent[300690628608, 16384] bytenr mimsmatch, extent item bytenr
> 300690628608 file item bytenr 0
> data extent[300690628608, 16384] referencer count mismatch (parent
> 404419657728) wanted 1 have 0
> backpointer mismatch on [300690628608 16384]
> ERROR: errors found in extent allocation tree or chunk allocation
> [4/8] checking free space cache
> [5/8] checking fs roots
> root 336 inode 69064 errors 1040, bad file extent, some csum missing
> root 336 inode 113496 errors 1040, bad file extent, some csum missing
> root 336 inode 113558 errors 1040, bad file extent, some csum missing
> root 336 inode 113563 errors 1040, bad file extent, some csum missing
> root 336 inode 113624 errors 1040, bad file extent, some csum missing
> root 336 inode 113839 errors 1040, bad file extent, some csum missing
> root 336 inode 113931 errors 1040, bad file extent, some csum missing
> root 336 inode 114145 errors 1040, bad file extent, some csum missing
> root 336 inode 133069 errors 1040, bad file extent, some csum missing
> root 336 inode 133072 errors 1040, bad file extent, some csum missing
> root 336 inode 133074 errors 1040, bad file extent, some csum missing
> root 336 inode 133153 errors 1040, bad file extent, some csum missing
> root 336 inode 134151 errors 1040, bad file extent, some csum missing
> root 336 inode 134154 errors 1040, bad file extent, some csum missing
> root 336 inode 134782 errors 1040, bad file extent, some csum missing
> root 336 inode 134783 errors 1040, bad file extent, some csum missing
> root 336 inode 134919 errors 1040, bad file extent, some csum missing
> root 336 inode 138340 errors 1040, bad file extent, some csum missing
> root 336 inode 143988 errors 1040, bad file extent, some csum missing
> root 336 inode 143995 errors 1040, bad file extent, some csum missing
> root 336 inode 144002 errors 1040, bad file extent, some csum missing
> root 336 inode 144003 errors 1040, bad file extent, some csum missing
> root 336 inode 144014 errors 1040, bad file extent, some csum missing
> root 336 inode 147060 errors 1040, bad file extent, some csum missing
> root 336 inode 147061 errors 1040, bad file extent, some csum missing
> root 336 inode 147063 errors 1040, bad file extent, some csum missing
> root 336 inode 148818 errors 1040, bad file extent, some csum missing
> root 336 inode 148819 errors 1040, bad file extent, some csum missing
> root 336 inode 152019 errors 1040, bad file extent, some csum missing
> root 336 inode 152027 errors 1040, bad file extent, some csum missing
> root 336 inode 155177 errors 1040, bad file extent, some csum missing
> root 336 inode 155769 errors 1040, bad file extent, some csum missing
> root 336 inode 155772 errors 1040, bad file extent, some csum missing
> root 336 inode 156233 errors 1040, bad file extent, some csum missing
> root 336 inode 156236 errors 1040, bad file extent, some csum missing
> root 336 inode 156293 errors 1040, bad file extent, some csum missing
> root 336 inode 156497 errors 1040, bad file extent, some csum missing
> root 336 inode 166294 errors 1040, bad file extent, some csum missing
> root 336 inode 166419 errors 1040, bad file extent, some csum missing
> root 336 inode 171167 errors 1040, bad file extent, some csum missing
> root 336 inode 201429 errors 1040, bad file extent, some csum missing
> root 336 inode 201564 errors 1040, bad file extent, some csum missing
> root 336 inode 201575 errors 1040, bad file extent, some csum missing
> root 336 inode 201577 errors 1040, bad file extent, some csum missing
> root 336 inode 201584 errors 1040, bad file extent, some csum missing
> root 336 inode 201585 errors 1040, bad file extent, some csum missing
> root 336 inode 201597 errors 1040, bad file extent, some csum missing
> root 336 inode 201666 errors 1040, bad file extent, some csum missing
> root 336 inode 201673 errors 1040, bad file extent, some csum missing
> root 336 inode 202502 errors 1040, bad file extent, some csum missing
> root 336 inode 202504 errors 1040, bad file extent, some csum missing
> root 336 inode 202506 errors 1040, bad file extent, some csum missing
> root 336 inode 202517 errors 1040, bad file extent, some csum missing
> root 336 inode 202520 errors 1040, bad file extent, some csum missing
> root 336 inode 202521 errors 1040, bad file extent, some csum missing
> root 336 inode 216890 errors 1040, bad file extent, some csum missing
> root 336 inode 216938 errors 1040, bad file extent, some csum missing
> root 336 inode 216948 errors 1040, bad file extent, some csum missing
> root 336 inode 217216 errors 1040, bad file extent, some csum missing
> root 336 inode 217218 errors 1040, bad file extent, some csum missing
> root 336 inode 217367 errors 1040, bad file extent, some csum missing
> root 336 inode 217632 errors 1040, bad file extent, some csum missing
> root 336 inode 217635 errors 1040, bad file extent, some csum missing
> root 336 inode 217636 errors 1040, bad file extent, some csum missing
> root 336 inode 218188 errors 1040, bad file extent, some csum missing
> root 336 inode 218198 errors 1040, bad file extent, some csum missing
> root 336 inode 218201 errors 1040, bad file extent, some csum missing
> root 336 inode 218204 errors 1040, bad file extent, some csum missing
> root 336 inode 218594 errors 1040, bad file extent, some csum missing
> root 336 inode 218596 errors 1040, bad file extent, some csum missing
> root 336 inode 218600 errors 1040, bad file extent, some csum missing
> root 336 inode 219356 errors 1040, bad file extent, some csum missing
> root 336 inode 219357 errors 1040, bad file extent, some csum missing
> root 336 inode 219358 errors 1040, bad file extent, some csum missing
> root 336 inode 219793 errors 1040, bad file extent, some csum missing
> root 336 inode 219797 errors 1040, bad file extent, some csum missing
> root 336 inode 219810 errors 1040, bad file extent, some csum missing
> root 336 inode 219944 errors 1040, bad file extent, some csum missing
> root 336 inode 219946 errors 1040, bad file extent, some csum missing
> root 336 inode 219949 errors 1040, bad file extent, some csum missing
> root 336 inode 219950 errors 1040, bad file extent, some csum missing
> root 336 inode 219954 errors 1040, bad file extent, some csum missing
> root 336 inode 219955 errors 1040, bad file extent, some csum missing
> root 336 inode 219956 errors 1040, bad file extent, some csum missing
> root 336 inode 219958 errors 1040, bad file extent, some csum missing
> root 336 inode 219959 errors 1040, bad file extent, some csum missing
> root 336 inode 219967 errors 1040, bad file extent, some csum missing
> root 336 inode 219974 errors 1040, bad file extent, some csum missing
> root 336 inode 219975 errors 1040, bad file extent, some csum missing
> root 336 inode 219976 errors 1040, bad file extent, some csum missing
> root 336 inode 219977 errors 1040, bad file extent, some csum missing
> root 336 inode 219978 errors 1040, bad file extent, some csum missing
> root 336 inode 219979 errors 1040, bad file extent, some csum missing
> root 336 inode 219981 errors 1040, bad file extent, some csum missing
> root 336 inode 219983 errors 1040, bad file extent, some csum missing
> root 336 inode 219985 errors 1040, bad file extent, some csum missing
> root 336 inode 219987 errors 1040, bad file extent, some csum missing
> root 336 inode 219988 errors 1040, bad file extent, some csum missing
> root 336 inode 223581 errors 1040, bad file extent, some csum missing
> root 336 inode 225590 errors 1040, bad file extent, some csum missing
> root 336 inode 228361 errors 1040, bad file extent, some csum missing
> root 336 inode 247689 errors 1040, bad file extent, some csum missing
> root 336 inode 247693 errors 1040, bad file extent, some csum missing
> root 336 inode 251782 errors 1040, bad file extent, some csum missing
> root 336 inode 251787 errors 1040, bad file extent, some csum missing
> root 336 inode 251788 errors 1040, bad file extent, some csum missing
> root 336 inode 252228 errors 1040, bad file extent, some csum missing
> root 336 inode 253363 errors 1040, bad file extent, some csum missing
> root 336 inode 337045 errors 1040, bad file extent, some csum missing
> root 336 inode 337096 errors 1040, bad file extent, some csum missing
> root 336 inode 346036 errors 1040, bad file extent, some csum missing
> root 336 inode 347087 errors 1040, bad file extent, some csum missing
> root 336 inode 347091 errors 1040, bad file extent, some csum missing
> root 336 inode 347236 errors 1040, bad file extent, some csum missing
> root 336 inode 347266 errors 1040, bad file extent, some csum missing
> root 336 inode 347271 errors 1040, bad file extent, some csum missing
> root 336 inode 347288 errors 1040, bad file extent, some csum missing
> root 336 inode 347372 errors 1040, bad file extent, some csum missing
> root 336 inode 347375 errors 1040, bad file extent, some csum missing
> root 336 inode 347391 errors 1040, bad file extent, some csum missing
> root 336 inode 347396 errors 1040, bad file extent, some csum missing
> root 336 inode 347397 errors 1040, bad file extent, some csum missing
> root 336 inode 347455 errors 1040, bad file extent, some csum missing
> root 2932 inode 322 errors 1040, bad file extent, some csum missing
> root 2932 inode 323 errors 1040, bad file extent, some csum missing
> root 2932 inode 325 errors 1040, bad file extent, some csum missing
> root 2932 inode 326 errors 1040, bad file extent, some csum missing
> root 2932 inode 336 errors 1040, bad file extent, some csum missing
> root 2932 inode 339 errors 1040, bad file extent, some csum missing
> root 2932 inode 340 errors 1040, bad file extent, some csum missing
> root 2932 inode 347 errors 1040, bad file extent, some csum missing
> root 2932 inode 348 errors 1040, bad file extent, some csum missing
> root 2932 inode 355 errors 1040, bad file extent, some csum missing
> root 2932 inode 363 errors 1040, bad file extent, some csum missing
> root 2932 inode 364 errors 1040, bad file extent, some csum missing
> root 2932 inode 365 errors 1040, bad file extent, some csum missing
> root 2932 inode 366 errors 1040, bad file extent, some csum missing
> root 2932 inode 368 errors 1040, bad file extent, some csum missing
> root 2932 inode 371 errors 1040, bad file extent, some csum missing
> root 2932 inode 381 errors 1040, bad file extent, some csum missing
> root 2932 inode 386 errors 1040, bad file extent, some csum missing
> root 2932 inode 389 errors 1040, bad file extent, some csum missing
> root 2932 inode 390 errors 1040, bad file extent, some csum missing
> root 2932 inode 394 errors 1040, bad file extent, some csum missing
> root 2932 inode 395 errors 1040, bad file extent, some csum missing
> root 2932 inode 396 errors 1040, bad file extent, some csum missing
> root 2932 inode 397 errors 1040, bad file extent, some csum missing
> root 2932 inode 400 errors 1040, bad file extent, some csum missing
> root 2932 inode 401 errors 1040, bad file extent, some csum missing
> root 2932 inode 408 errors 1040, bad file extent, some csum missing
> root 2932 inode 409 errors 1040, bad file extent, some csum missing
> root 2932 inode 415 errors 1040, bad file extent, some csum missing
> root 2932 inode 417 errors 1040, bad file extent, some csum missing
> root 2932 inode 419 errors 1040, bad file extent, some csum missing
> root 2932 inode 426 errors 1040, bad file extent, some csum missing
> root 2932 inode 427 errors 1040, bad file extent, some csum missing
> root 2932 inode 428 errors 1040, bad file extent, some csum missing
> root 2932 inode 431 errors 1040, bad file extent, some csum missing
> root 2932 inode 432 errors 1040, bad file extent, some csum missing
> root 2932 inode 433 errors 1040, bad file extent, some csum missing
> ERROR: errors found in fs roots
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/int_luks
> UUID: a7613217-9dd7-4197-b5dd-e10cc7ed0afa
> found 786786136064 bytes used, error(s) found
> total csum bytes: 750877664
> total tree bytes: 4204183552
> total fs tree bytes: 2994487296
> total extent tree bytes: 367149056
> btree space waste bytes: 721104463
> file data blocks allocated: 2761159544832
>  referenced 1384698466304
>
> On Sat, Jan 18, 2025 at 11:12=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
> >
> >
> >
> > =E5=9C=A8 2025/1/19 14:17, Dave T =E5=86=99=E9=81=93:
> > > Here is the full dmesg. Does this go back far enough?
> >
> > It indeed shows the first error. But it doesn't include the kernel call
> > trace shown in your initial mail:
> >
> > [  +0.000002] RSP: 002b:00007fffb6d0bd60 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000010
> > [  +0.000003] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
> > 000074c0e2887ced
> > [  +0.000002] RDX: 00007fffb6d0be60 RSI: 00000000c4009420 RDI:
> > 0000000000000003
> > [  +0.000002] RBP: 00007fffb6d0bdb0 R08: 0000000000000000 R09:
> > 0000000000000000
> > [  +0.000001] R10: 0000000000000000 R11: 0000000000000246 R12:
> > 0000000000000000
> > [  +0.000001] R13: 00007fffb6d0cd41 R14: 00007fffb6d0be60 R15:
> > 0000000000000000
> > [  +0.000004]  </TASK>
> > [  +0.000001] ---[ end trace 0000000000000000 ]---
> > [ +15.464049] BTRFS info (device dm-0): balance: ended with status: -22
> >
> > I guess that's no longer in the dmesg buffer?
> >
> >
> > > I will run the "btrfs check --readonly" soon.
> > >
> > > # dmesg
> >
> > > [  +5.340568] BTRFS info (device dm-0): relocating block group
> > > 299998642176 flags data
> > > [  +3.354148] BTRFS info (device dm-0): found 26160 extents, stage:
> > > move data extents
> > > [  +3.453557] BTRFS critical (device dm-0): unable to find chunk map
> > > for logical 404419657728 length 16384
> > > [  +0.000011] BTRFS critical (device dm-0): unable to find chunk map
> > > for logical 404419657728 length 16384
> > > [Jan18 15:44] BTRFS info (device dm-0): balance: ended with status: -=
5
> > > [Jan18 17:31] netfs: FS-Cache loaded
> >
> > So far that balance is trying to balancing a tree block at the next
> > block group. That definitely doesn't look correct.
> >
> > Please also provide the kernel version.
> >
> > Thanks,
> > Qu

