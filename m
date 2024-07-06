Return-Path: <linux-btrfs+bounces-6257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31305928FAC
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 02:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55EA81C21C69
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 00:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6224A35;
	Sat,  6 Jul 2024 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEwHME6V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA63A2D;
	Sat,  6 Jul 2024 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720224729; cv=none; b=fojacH4EBTDbCngraohF1aztXHPfw36hS1TGbj4D/u97MOKLd41lRD75oFFgPOxl4Exk257qFNB4cHl6ALpHhRNE9ufN8EaMQlxvv4DnJlTZ0fcVrDgxt9b5l/wlCTD72Rit4eEd8gk0EDt3KbBB2vMCVoTsVTPQnjFdqlkqDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720224729; c=relaxed/simple;
	bh=k/fo/4vLr7G1b5FnRs+xhoG2wyCli0F4i6F+itX6vlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXuMKd3wlRCwmWtTIzBdE7MWBq02sMmy70mfL55NAaJ6VcOS1lOgX920Q8KSdj7EI9z5i2kajye8OiOpzhJEDw+V5Fz9kUezgGZ9hg0Z3kq2IRHvt+PWgoW1lQ9nS2Tr14dOb8Ui0jKYmTNNyegY9c0o4Bn9l0p6DsJcqC5OBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEwHME6V; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-64f4fb6ce65so18505947b3.2;
        Fri, 05 Jul 2024 17:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720224727; x=1720829527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vBTT/deLqJ1bwFj4A2vyIjvPYow0/EdCovNSuo3+N+c=;
        b=kEwHME6VB3/vdMWEgZUrz6DSpIYwta+xt07Gx8/vXPXdRbyOPaKQpLeDg2I1usdmW2
         V9d9CKwUUYE1sAvqSEYbZYEzl3xmX3apw3Vd+uwBf2jsW5SFB3Yycn4+R+YNmQZAD0TA
         pJ5Y2UexA53tz0JUQ2ohivC9iqrlg8WvaXkAtapVgmqrpqQWm2rJoRgsswxXd6Ifz6gR
         u8T+SmyQmuqi2pnYS2S8KbKOVktmHKXsWB+5R94v10qtjubw5ktXyD1ln4/WJy7ypf7A
         Tt7CDGneD1/DowwSef1hMz3BSCU4tUcaxs2ZgY3DTLMkisAsyyOgSlolCC5mSwiCmmLL
         8i5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720224727; x=1720829527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBTT/deLqJ1bwFj4A2vyIjvPYow0/EdCovNSuo3+N+c=;
        b=IRooKtud6NdcU/ryOSjPvzFkNgS5AR8BQZKemn1MY71XfR60HWUZQ/PmDUheGQQP1Y
         pRZSd83kNHg7jU7AEl5CtJiFgmbztYzhn6uGe6OSn0c4hkKTY4zh3ZMH4sKz1QCbIb/b
         y8NP73oYuFfKTNVfp6wz0vBYd51D18F+PrJwBglqw/5yexyujFjRI/Sh9JtuX9DH3idx
         sEML7cN15q+4BLfY8Sj4w/cWa6VA/TZ97Msy+WPjRSdY2lUpGpReFspp0iwBl2URDY4x
         c2riHfu5vqvzYe+vY0nUi0Kp4RUSXZsuwO8NX5Rd1Oyt7R9LVzfNg9Y7K+24vl31EyrK
         pu3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr3i8HAsicCE9DfkuZrGOOXhVRFz2Ix/MLkM+ZkABVBiCbZ8Vt9FjHSnwkpVQ+FXWedjP7/6GoJhyeE6T7NW6VCwNhN5pyOmJ230B+RvD7LYuuoXObMVTSac/y7ksFmoKtFTBpif54OUc=
X-Gm-Message-State: AOJu0Yx43GDuJRY2aR1780LaOU4Is8Hpp/4fIDdzIXAn3niGqBzc5Kmd
	0o2sGYcchQ9WbOtQmlgkGxShgopV602avCCSggUrOyThK4NRKTFNhEZQCMEgFwA0c/QXMvAM4Ot
	2HDhb7emO9mlp8oqs311IwHZcB9w=
X-Google-Smtp-Source: AGHT+IHl00DB5lXcnle5oez+bUlSAk/kaG3U9/6sbycSjRwDjbucmdsBlfppNjNxMo8MiIyhZDs9xcQeWqjD0WI54YY=
X-Received: by 2002:a81:8303:0:b0:62c:c62e:e0db with SMTP id
 00721157ae682-652da927280mr54086967b3.44.1720224727260; Fri, 05 Jul 2024
 17:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com>
 <CAL3q7H4yBx7EAwTWWRboK78nhCbzy1YnXGYVsazWs+VxNYDBmA@mail.gmail.com>
 <CABXGCsMWYaxZry+VDCgP=UM7c9do+JYSKdHAbCcx5=xEwXjE6Q@mail.gmail.com>
 <CAL3q7H7Xb9FQx-5PMQtK_-reMq-cbfysCx6s-ZOWL1FUPSm8sA@mail.gmail.com>
 <CABXGCsP9tSwgR4dN-k97maqHB1KOtykakmHNz78SYbAuHydUTQ@mail.gmail.com>
 <CAL3q7H6vG6PEKjcsXtSuq=yks_g-MczAz_-V96QSZCs9ezRZpg@mail.gmail.com>
 <CAL3q7H5RC6dinsA2KLtus07jxDuY1PecPXbhYOWtW+nVyzXwuA@mail.gmail.com>
 <CAL3q7H4MiarsqxSMc0OzY2TNRk8J7Lg+89MaPHY2+NPO-EcDgQ@mail.gmail.com>
 <CAK-xaQYYx6SPQaOVwL+ardB0y5LzYJw9a_hfWWtVEZ=y1rXq5w@mail.gmail.com>
 <CAL3q7H74jpSoMvvkSvmrtB_VGiscz8zN5aHnApWuYU+hpKe+rA@mail.gmail.com>
 <CAL3q7H6V9M0B4jmW79keUtTdjWsabyWZeU5g4KEN5_-a+wEHVQ@mail.gmail.com>
 <CAK-xaQZ=c7aociwZ5YQreTmT+sBLGdH0rkTKmFzt4i_mrXBmgg@mail.gmail.com>
 <CAK-xaQb2OrgNOKKXp8d_43kqMNyuHxS1V8jSDL6PdNZPTv79+g@mail.gmail.com>
 <CAK-xaQZ25nyCeOvMs0G31sL7R71dxQqZhx61cYzTK7rZD-JxeQ@mail.gmail.com> <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com>
In-Reply-To: <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Sat, 6 Jul 2024 02:11:50 +0200
Message-ID: <CAK-xaQaesuU-TjDQcXgbjoNbZa0Y2qLHtSu5efy99EUDVnuhUg@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 4 lug 2024 alle ore 19:25 Filipe Manana
<fdmanana@kernel.org> ha scritto:
> 2) Then drop that patch that disables the shrinker.
>      With all the previous 4 patches applied, apply this one on top of them:
>
>      https://gist.githubusercontent.com/fdmanana/9cea16ca56594f8c7e20b67dc66c6c94/raw/557bd5f6b37b65d210218f8da8987b74bfe5e515/gistfile1.txt
>
>      The goal here is to see if the extent map eviction done by the
> shrinker is making reads from other tasks too slow, and check if
> that's what0s making your system unresponsive.
>
> 3) Then drop the patch from step 2), and on top of the previous 4
> patches from my git tree, apply this one:
>
>      https://gist.githubusercontent.com/fdmanana/a7c9c2abb69c978cf5b80c2f784243d5/raw/b4cca964904d3ec15c74e36ccf111a3a2f530520/gistfile1.txt
>
>      This is just to confirm if we do have concurrent calls to the
> shrinker, as the tracing seems to suggest, and where the negative
> numbers come from.
>      It also helps to check if not allowing concurrent calls to it, by
> skipping if it's already running, helps making the problems go away.

Uhm... good news...
To recap, here's this evening tests:

Kernel 6.6.36:
   Fresh BTRFS: (tar cp . | pv -ta > /dev/null): 0:03:53 [ 231MiB/s]
(time and average speed)
   Aged snapshots: (tar cp /.snapshots/|pv -at -s 100G -S >
/dev/null): 0:02:20 [ 726MiB/s]

Kernel rc6+branch+2nd patch:
   Fresh BTRFS: 0:03:14 [ 278MiB/s]
   Aged snapshots: I had to stop. PSI memory > 80%. Processes stucked
for most time. i.e.: mplayer via nfs stops every few seconds for a
while, switching virtual desktop takes >5 seconds. Also "echo 3 >
drop_caches" takes more than 5 minutes to finish (on the other two
kernels, it was quite immediate).

Kernel rc6+branch+3rd patch:
   Fresh BTRFS: 0:03:40 [ 245MiB/s]
   Aged snapshots: 0:02:03 [ 826MiB/s]
   N.b.: no skyrocket PSI memory, no swap pressure, no sluggish results!!!

Now, that was just one run, I'm going to use this patch for a few
days. Next week I can tell you for sure if everything is right!
For the moment it seems we have a winner!

