Return-Path: <linux-btrfs+bounces-6266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52898929795
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 13:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1746B20FF0
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9811C2A8;
	Sun,  7 Jul 2024 11:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS0IKh1U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD312B95;
	Sun,  7 Jul 2024 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720350919; cv=none; b=Vs+wSKTMq41GY65gyQ12QhaXwNpLYErv7quQR/QSB7rqdXZVYNm2e0BlTlfjzju75AnVJoRoWNjN00PJ80+BFlMxgCBQUzwpR93GjLlzdJw7EtU97sopyTGodO5lwnQTMl8MyOrrWo/45f9IgMhAjRZPq/Yzfz6Ug99UNmvDUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720350919; c=relaxed/simple;
	bh=GCiV83PkQGQBX0iCvr2E0PjQAzhoDidHblBBsoMp9Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cos5hHeU0xMF5vGDjnnmtS12NGPB7tHOhQp1LRyy4+5bGWIBZrkg3pZZyUPuebdnZeR8LFJqhG4hbxW7I2iIAJen69xDxVOESAGWwcDGFV9dcJHq/Uzeku56SBMAeoc6Oi4CueVEvcsMYqAUR4oEWlSpke9WaB5TXN6kC3C7qAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS0IKh1U; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-64b05fab14eso29322897b3.2;
        Sun, 07 Jul 2024 04:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720350917; x=1720955717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JEDaHctMDjTLUQmt8H4eKIsXIEH/NgBcNg9NnhklDGc=;
        b=cS0IKh1UCD/XFCERftuDjiEhnSWPETQpQZ5ndDd3JiHu7fB+suhumbgxeVS1HeeAX3
         zgnVdxeU8Vc+YRS8qJAoVu81WgDOr9rtxjPQtybimGrP8gmBrW6XSqbUKkkz/XK3Hxr6
         jk8vLWxw6YUUhsFYId99bSDU0gKZt+VahWu2g0erDeX0a35cpaiaKHM1JixyDoEccD8/
         UXUeqiy+DmiMys8aoznO+zjEUKIDuwMyVXjeApGp+4Pa+jkALVILS8lEmfazoJGsiCjq
         6C1HVQpBWAkQUQv+sfNN+sR+KHiqmaY02Z/MD4Tj2oILW2bqCJx+qGiIIVJ/+D0pJxH0
         kroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720350917; x=1720955717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEDaHctMDjTLUQmt8H4eKIsXIEH/NgBcNg9NnhklDGc=;
        b=F80/KyiZPs5diBDoFqogwRYyVtyneSczkcWeytig5N64mkpWdKhJ0YiCz6OpKU/70o
         PVD7dm9pPPN0RnfPtOacgR76VUIC5VPizjWZ9x89qsxC07xb1k8Rg0lPru43y1vW6mU4
         TWHZm2MWJVMQSKsmzkCq/LLBeHyFXawpbsE0KJo0//tHka4H1FGDdclJ/OCx2Ouy38VN
         Cn+VP8QD22jirtZQviAIvI+uVaIAlOhWe6656kOQV8bMPz7RwXcRDv1wJGqhdHMb32Hf
         OesLiM7IkeUBbaT3zRBX/JFsiQoCj99t13HNLvqPfis9cyb0RdX/vmqwyy2tD4bgEy50
         9XoA==
X-Forwarded-Encrypted: i=1; AJvYcCWSDkaDxXHHuUH5AaC87Z0WreBbKFtey2mkYH4gB1Ak/yOwyc017N/3ujCv6eDnri6x07XpeQWwOC57FE8C8Ti3Mii2OESb0HU0fEJHeRgiNGWgrf12j/eSSpAovw49Qx4kujuiV5KGwu4=
X-Gm-Message-State: AOJu0YxIK1BFLySATvmb//fZVyQdM9SA+ryjn+ugjQRlQX8ICnq/T9ga
	eRpVMdzzilUuzQFk7m4XlTUPm8xfnpMH8hIhMKuvnNm3S2J+SoK+HxeF7lab6mveuQYAK2aITZ9
	L3Zdamv4pNdpFKqiBU3RSxgPbssk=
X-Google-Smtp-Source: AGHT+IF+cw2g6r/QOlqBO2ajneYgMMcCF8mdTACxJgT8VoYFfD/U+McKqqzQTSTWgFZrYRQtFjG8cHAyRVVKR8uPHCQ=
X-Received: by 2002:a05:690c:f0b:b0:64b:52e8:4ad0 with SMTP id
 00721157ae682-652d52266a8mr113145587b3.6.1720350917069; Sun, 07 Jul 2024
 04:15:17 -0700 (PDT)
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
 <CAK-xaQZ25nyCeOvMs0G31sL7R71dxQqZhx61cYzTK7rZD-JxeQ@mail.gmail.com>
 <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com>
 <CAK-xaQaesuU-TjDQcXgbjoNbZa0Y2qLHtSu5efy99EUDVnuhUg@mail.gmail.com>
 <CAK-xaQbcpzvH1uGiDa04g1NrQsBMnyH2z-FPC4CdS=GDfRCsLg@mail.gmail.com>
 <CAL3q7H63GexJexkDxSz9Av_s=XyYotJqLqjUubZmuU7vynaQNQ@mail.gmail.com>
 <CAL3q7H5fogJTfdkj_7y8upZj7+4dz65o-tKzyGf0WfLwm3nfUw@mail.gmail.com>
 <CAK-xaQaYDg60DizL3kJ3XKU5JD3kKVi3kecb2s18Po96T9tAHg@mail.gmail.com> <CAL3q7H6rir8w6ge6zDPXYFaBoLyHsbcApr9WXb+A1Vc+8RP77w@mail.gmail.com>
In-Reply-To: <CAL3q7H6rir8w6ge6zDPXYFaBoLyHsbcApr9WXb+A1Vc+8RP77w@mail.gmail.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Sun, 7 Jul 2024 13:15:00 +0200
Message-ID: <CAK-xaQaDGR_x_HZ3CfTsguYQxWjUehKGSpapYLyF3wC=ofRB8g@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"

Il giorno dom 7 lug 2024 alle ore 12:28 Filipe Manana
<fdmanana@kernel.org> ha scritto:

> > Ok, recompile now and test!
>
> Thanks! Much appreciated!

So, usual benchmark:
    fresh: 0:03:16 [ 275MiB/s]
    aged: 0:02:30 [ 680MiB/s]

I let you know in a few days.
Well, does it make sense to add the option to disable shrinker via /proc?

Thanks to you,
Gelma

