Return-Path: <linux-btrfs+bounces-13056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC97A8AFEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 07:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E968189F574
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 05:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6E022CBF3;
	Wed, 16 Apr 2025 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9t5p8ge"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DEB229B13
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783102; cv=none; b=Hq0A2VAh1pUDFcj8SsFn78lqKvrIggU0Z2I6t029fLkiGwn6lP6m+kScYpdnJgTfzEZWKkjZgsORoVZpCA8HufKnMMybAIyLMzzu8auG5PMI8dCKSMLjB/tGv+cxuhXnkyaD7SrCVzWZTHt9exvgycRspkL3ZCGwB0iJliG1heQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783102; c=relaxed/simple;
	bh=2BQmtDjpXFzo2Fd5wxnOFsm3/micNpgFEY2UN4mbhx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjZywxjK3PrzHUpLVwddwwjzT/Nppx4cLe2WC9bX654xGbEHDrLZ70atVK465dpw2RjG/Bpi6KAunZPpCDRecadA0WaMYFJuQkk4bZfscNy+ISCnxbIvY9xKCJh3lWzV1RUeUCZ+m0Mb4JSnggDB+ISlgTP/H8TAtMmAYyAjyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9t5p8ge; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aca99fc253bso985707866b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 22:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744783097; x=1745387897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKmacO+Sq4W9PKJyaht44IGI239gWcRa9oem3QZdvnQ=;
        b=O9t5p8geCEETegBQV+GJj9IIGTzkUWk39ydCnkg2OiEsl0Q0cCy3wcQ9genCzMoc/S
         NXYH14oNMFRsHsdEzK/v60ZiiLZj8BPCdWlnON7QKd2CUKmDCDHBVRZo4Tx8jrqu7nmO
         7tcJc0V06fK4+gIctUnuUx2yUTRcDjecY/0jNcDXteNb54ehjF2ltY+s1qPdPdkNKUdB
         yXZhoyDGuWnmCtx00qrqC/1c4WuGMewdDM93I7omAB3R7uMXLps+FfBxTw5Hts/pC2dv
         6SJALdbaZdOkeF7HoO31PLox7WoYnebm2gt49sYkJru4t5XSo+zoPhoocv3xcrd9QH0m
         KNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744783097; x=1745387897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKmacO+Sq4W9PKJyaht44IGI239gWcRa9oem3QZdvnQ=;
        b=XoyydravoBx2ihCjTpCNmNqE2374zsTnWyMwakHuEDkYquTc/AWMM1QyjJIFZBsbm6
         +dGsqzUSpHBcSjq2VreVKkzoRHX0/Q2uDZebTuWbL2Nasl4TLQqdXGukgSL5wdgZpmzo
         AL7PEb1mnxmDX26xnVsaWCMgZJgdK+I1noDnmc5Sy1hLPgqLeTxJ/ag40TJGQsTwRBNo
         Q+zXu2zeOx7xdoj0bxit67OmsBzXaQcBvubjoeyZIA9QoryS9fGxIlST/I14XyOHLsPZ
         PcyOaZjCQmWcCqq39QUeJ8Q5ezMucNyr6dznkb0X7PCFDFhlGUBXaWR7UK7uBh44IB0O
         cbuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvqk4EN+RkhJUeTAQRMUmCOtrSX7gUsTG18T1JAqfmCnilLsgCHuuHqtRbUr+JyPu43bFOfJsSwDHXpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz60IJxmx8keiPD60SGnDG9NyoPt0jj2AHqvBNSetva6eB1rZrj
	2QYw6FegMEpXWIBTc6ApLNkMspshcc2lkLVfOp/xjNY5RbC9B7Pn7p4+PTsy7yNwMcS+5G5rywX
	YPYih1vhUP55g55fzfFscvNcVV9wX/enWpTM=
X-Gm-Gg: ASbGncv5pYutu9iwRaXXgDo51Iq5BzbBSRjayXHjruUGVgxLmKL2/oaAIVXp1pjvUXF
	b9A7KSl36a3Rz/uZ+TPZDx4cbAIcX6DtNbguw0CpPU6uneUcTIt6TCvIKdqaJuiMy3szHo8bAju
	H1HrAhUcOk5Gy6xNuNw0o6qFgr0CYNw6rI7RE=
X-Google-Smtp-Source: AGHT+IFiNjavjxNrxF6wHlneQfIeOJePFe+9nFbq6Od3Bi748yrJXYhAB5ipNKFL+8rkhWLs+H+C1PLoTD7F23lEZf0=
X-Received: by 2002:a17:907:3ea6:b0:ac7:970b:8ee5 with SMTP id
 a640c23a62f3a-acb429e41ffmr34869466b.27.1744783097018; Tue, 15 Apr 2025
 22:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744344865.git.wqu@suse.com> <d66c922e591b3a57a230ca357b9085fe6ae53812.1744344865.git.wqu@suse.com>
 <Z_qycnlLXbCgd7uF@surfacebook.localdomain> <37e556c8-d7a4-4d65-81d7-44821d92603e@gmx.com>
 <CAHp75VdyLRQrnByZtPPL2sn9ucGWVkyZu-kBvZvvpr4P_tOTpw@mail.gmail.com>
 <20250415181841.GN16750@twin.jikos.cz> <CAHp75Vf3Z=qQPKkALhCbSSCd9VYiYYZ4xVJ9aT=sYKW7tbPd2A@mail.gmail.com>
 <408fff7f-00a9-41ec-91e6-168dcffb2de6@gmx.com>
In-Reply-To: <408fff7f-00a9-41ec-91e6-168dcffb2de6@gmx.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 Apr 2025 08:57:40 +0300
X-Gm-Features: ATxdqUGFs9XeAbaY2KHAqLpnYv4mlCiKcLF9rVuHQ-B6FuiRf3FIhXaDOa7Ya5A
Message-ID: <CAHp75VdJoPKoYu=fOZYPV6Cd+rgcWVM9_NDJ-Gyu3O33tS447w@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: make btrfs_truncate_block() zero folio range
 for certain subpage corner cases
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 2:57=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
> =E5=9C=A8 2025/4/16 03:51, Andy Shevchenko =E5=86=99=E9=81=93:
> > On Tue, Apr 15, 2025 at 9:18=E2=80=AFPM David Sterba <dsterba@suse.cz> =
wrote:
> >> On Mon, Apr 14, 2025 at 01:40:11PM +0300, Andy Shevchenko wrote:
> >>> On Mon, Apr 14, 2025 at 4:20=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx=
.com> wrote:
> >>>> =E5=9C=A8 2025/4/13 04:05, Andy Shevchenko =E5=86=99=E9=81=93:
> >>>>> Fri, Apr 11, 2025 at 02:44:01PM +0930, Qu Wenruo kirjoitti:

[...]

> >>>>>> +    block_start =3D round_down(clamp_start, block_size);
> >>>>>> +    block_end =3D round_up(clamp_end + 1, block_size) - 1;
> >>>>>
> >>>>> LKP rightfully complains, I believe you want to use ALIGN*() macros=
 instead.
> >>>>
> >>>> Personally speaking I really want to explicitly show whether it's
> >>>> rounding up or down.
> >>>>
> >>>> And unfortunately the ALIGN() itself doesn't show that (meanwhile th=
e
> >>>> ALIGN_DOWN() is pretty fine).
> >>>>
> >>>> Can I just do a forced conversion on the @blocksize to fix the warni=
ng?
> >>>
> >>> ALIGN*() are for pointers, the round_*() are for integers. So, please
> >>> use ALIGN*().
> >>
> >> clamp_start and blocksize are integers and there's a lot of use of ALI=
GN
> >> with integers too. There's no documentation saying it should be used f=
or
> >> pointers, I can see PTR_ALIGN that does the explicit cast to unsigned
> >> logn and then passes it to ALIGN (as integer).
> >
> > Yes, because the unsigned long is natural holder for the addresses and
> > due to some APIs use it instead of pointers (for whatever reasons) the
> > PTR_ALIGN() does that. But you see the difference? round_*() expect
> > _the same_ types of the arguments, while ALIGN*() do not. That is what
> > makes it so.
> >
> >> Historically in the btrfs code the use of ALIGN and round_* is basical=
ly
> >> 50/50 so we don't have a consistent style, although we'd like to. As t=
he
> >> round_up and round_down are clear I'd rather keep using them in new
> >> code.
> >
> > And how do you suggest avoiding the warning, please?
>
> By fixing the typo, @block_size -> @blocksize.

Ah, if it's that simple, of course, round_*() is okay to go.
My only worries are about explicit castings to "fix" such a warning.

> The original warning is not about the type difference, but that
> @block_size is a function pointer.
>
> We have tons of round_down()/round_up() usage inside btrfs, with
> different types.
>
> E.g. btrfs_check_data_free_space(), which is calling
> round_down()/round_up() against u64 and u32, and do you got any warnings?


--=20
With Best Regards,
Andy Shevchenko

