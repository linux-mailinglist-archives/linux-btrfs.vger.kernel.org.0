Return-Path: <linux-btrfs+bounces-6198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F1892793D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 16:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F15B5B25CC7
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 14:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECFF1B1402;
	Thu,  4 Jul 2024 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZjZdmss"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5163C1B1207;
	Thu,  4 Jul 2024 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104529; cv=none; b=SLHgCsdqpY1Iip/VM3ZsKUIwiAimdTXX2WQj3hZ0T1cvlNOCq5O6YcdSAqv+H7G92S01ZOKopZyY8nhI7bQpkGEByhDoSjj0ERi5pvXC2zf4XANVrvJXMORMtAmnhwfluFpkoMWpxl0HXl50l2ZvL1EmZv2Q5/PSj71jPlXQbek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104529; c=relaxed/simple;
	bh=hTQ5+Ju5PD+FvRF1hnYejUZPbE8kNPGJFeDeitAPK5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poaEF9WOKSouT3nW1rR7BMCzH4s00X9qi+r/3H74ChKsN/OKk1OdriRyL3IgRq/I6wN+Fr/pmqEjk7bb5VD3oGqahmI+fvhFsDtn2LRbuMDT93mhPgSijCRtNIvwL0vn0pHraTlUrtt7JLZb1gd1mL1gjYhPxCrGqH16KTwZgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZjZdmss; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-64f4fd64773so8186587b3.0;
        Thu, 04 Jul 2024 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720104527; x=1720709327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cp5edY4coh4CGekIA4INUCYnmNceA0sPbADqg4C7PGY=;
        b=cZjZdmssC3ZIJoV4qR8gNDuJGBDwbRsBMYN2ShNilh/UeWZioaqYp6E/9ArHPXXPgt
         1y9x4WO+YoBn7QEJ7irYujbqvbe0PfWvFF9wBB7BsU5UQvlWkBTvt2bRFawNlgDnhtEE
         +YBEvgvSdiP2ZeAFBJgiA4xKaJWVfky8lwgnlBBxENBpLQq9CEWYh09n8XX7nT9Es91T
         eu60aH2cDATFAZyVXHxcBn3Ulye0nH+9VvvuStHJVTAbOqYrNgpGWVY8sGAmOVkw42Z7
         digb+t7vZpO1lhYLjq4BE34SipSpVRrGyItLiw+apqn00ixMdhvLF+r5pL6+XunIjQpn
         xr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720104527; x=1720709327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cp5edY4coh4CGekIA4INUCYnmNceA0sPbADqg4C7PGY=;
        b=dcZQ15Gp/vuMEM4pkEzY6wml4NLr9FUdt5LBQuLwfLCKpTaNWYhM/nmVhO1wfAxaUo
         M8YBhIlurbDoP3oSNHsmdyJxXLRYGkuupPK/kLVcGghVNrlyl2n79Oi7ax+4hI42bOVf
         6ebu+o1srG6HnJUeihvifHd163uL1R8b9BANVhNyFxJ4SJKSbpKdmf3jYKKcIpg1pT42
         IGdPy2fo44YAlnbxkHUa4mVUmr0KuyElQV5fff4CotKonIb+XNhEYiQfbFy0GN4jVYNz
         1WJWwEPwhmZ4La/ssRz+w04jhidEkAkbKnT9oaGIvP1f/SqVF5HysBhdk1SZC/izMUWe
         BCYw==
X-Forwarded-Encrypted: i=1; AJvYcCVhofD340nqRGHn0x2sGlbzcVkFtQVGcZzrGMfr8r0a/pVoL3duc+/2q0so5QAuf3aXTy1TZnNeUkRWq2S2AX3c+jNw5DJ4WwgL176XramAS5FXnYdJxHMa4Aqxsc+oDp/FhcNciX3T0Dg=
X-Gm-Message-State: AOJu0YyQk5qZyMEB++hAOb6crRtSPxeS9RCs/33KYthxgDYZ3JbmKROc
	2muLQ4Av3KigNDh3i/WqcW2LiqDC1I2wB2EbCbcRyboNmbNBeLbINm4p9R/sj9a++WCVKkQ4VeK
	yUfFhA9++EqcMflENeRPBCGEidvI=
X-Google-Smtp-Source: AGHT+IHPh8VBc7TGunrBIhkcZ45omy48LyXKyt7ZQZfzz/Ure6Rsthc0HV+ttveS0aTA5+Sur0JRJSuNsRm78pF9IDs=
X-Received: by 2002:a05:690c:4d82:b0:64a:9832:48a with SMTP id
 00721157ae682-652d29025f0mr24371487b3.0.1720104527343; Thu, 04 Jul 2024
 07:48:47 -0700 (PDT)
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
 <CAK-xaQZ=c7aociwZ5YQreTmT+sBLGdH0rkTKmFzt4i_mrXBmgg@mail.gmail.com> <CAK-xaQb2OrgNOKKXp8d_43kqMNyuHxS1V8jSDL6PdNZPTv79+g@mail.gmail.com>
In-Reply-To: <CAK-xaQb2OrgNOKKXp8d_43kqMNyuHxS1V8jSDL6PdNZPTv79+g@mail.gmail.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Thu, 4 Jul 2024 16:48:30 +0200
Message-ID: <CAK-xaQZ25nyCeOvMs0G31sL7R71dxQqZhx61cYzTK7rZD-JxeQ@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Filipe Manana <fdmanana@kernel.org>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 4 lug 2024 alle ore 15:47 Andrea Gelmini
<andrea.gelmini@gmail.com> ha scritto:
> I send you everything when I collect enough data.

Here we are.

Kernel rc6+branch:
    Output of bfptrace:
    https://pastebin.com/P9RFp5mg

    Recording of tar session: (summary: start fast, then flipping super slow)
    https://asciinema.org/a/BxYI83TkrlOhEe42IWXNY135D

    Recording of htop session: (summary: PSI high and two threads at 100%)
    https://asciinema.org/a/ZwGSepZZ8TSpFfPssACUUXcCB


Kernel 6.6.36:
    Recording of tar session: (summary: tar always fast)
    https://asciinema.org/a/a6dOkbjyPFkkQ5aNTaRiFD3H8

    Recording of htop session: (summary: no threads and PSI load)
    https://asciinema.org/a/mFsypWzHfSdsjrIQf8zpzNpKo

If you need to run for longer time, I can do it in the weekend.
If you need dump of my BTRFS fs, no problem, but I need 'btrfs image
-s" working (point is: scrambling filenames).

Thanks a lot,
Gelma

