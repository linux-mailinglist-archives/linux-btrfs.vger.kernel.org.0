Return-Path: <linux-btrfs+bounces-6268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5409C9297C0
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 14:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11EAB20F77
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jul 2024 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D99C1CF8B;
	Sun,  7 Jul 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtZvQ319"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3D6FBE;
	Sun,  7 Jul 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720354256; cv=none; b=PlB6tK88VHh6HQY8vDMcQayHjUt7V6pNDN46G3CExG34x4ytbOYCFti2mDK+X2SgH41sD5OTzOsYn3w1nCa8uc1Y/gp+6sQ8PmbiHSoe2hITl76xD7Cwd/AKdB197irLJW/JYO7J5/TvyB5HabAiQyFgNm8JdOKZJUf7safrkRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720354256; c=relaxed/simple;
	bh=/479mnKxbNY0SUBJUbUY3ywJKrX3yXeedLVzkffqrBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUq+0v2A8vYZ0rXY7QR8RFccCp1r4hB711spB7rnUsCsfslFY3D+HDzYFUgZq8UdZ2933/9Bt+cMe//EwYPakScu9aZU0jLqBxtzzysRqeSwq/sR0FiT27aBlrMsiwgSpQSdfgp69ijnW8fS9VYIquBhAqMRo2XWdEYP01ZzbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtZvQ319; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3496C4AF0B;
	Sun,  7 Jul 2024 12:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720354255;
	bh=/479mnKxbNY0SUBJUbUY3ywJKrX3yXeedLVzkffqrBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WtZvQ319wGp5k3a6GstJqEoT5MLhRlnGA+NgH3O1O6PtFkNoRJILLqpqfL0oSrNMi
	 vkpI5a5eGAGNzVhJe4zZgdigNp8FfZ6NYDqpAi8XIBz2CM1ZWA5DMP/Dg6Sy7pixBD
	 bVqxXYo4u2wiXUmTZAsOIhF1IU7tszY3WlH36osyQMFOxsE/b9ImYRJeM/7oj6RABE
	 sKuNKcrV3insDtSHXL0uqZjlAl+bFibIYCJblHRDxi40yq/Ce60YJ81YwBNIglDByQ
	 83Zn8PIrv7t9Mt/CRSRB0d5+waCuNU09leTVokKI32hYmkRwuFRnkMMTe4ekh6skih
	 +Y1Mscle1ArWg==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77c25beae1so304522966b.2;
        Sun, 07 Jul 2024 05:10:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9MxODdHoUYeF5T3CCGKa31EAoIq5o0MkY3RaTGAR9nbjmSh3BYIYD/xaGKaKIFKy7+aTyujoWpYNRaWDpaXFcsvy/2daBJdk49aq97TBWurUIlyXBJAwoiJ8x1qYZe+756O7+iqTRTtg=
X-Gm-Message-State: AOJu0Yz+wi0gPOxwdQNHFW3jiWE16rywfrmYuVzuKt99zbedqUmvabkZ
	SwKUQZD9eyn5do6zTSWWTMOw6apBqX/UoVX/4aKIqvdLZT/Cuj5JZEE6zjUKF6gr/Ok1zsZgTsp
	zHkdrM2dWkW3NI7ANz1MHEHVxWjA=
X-Google-Smtp-Source: AGHT+IElHiW5qA4DsvI0Di/BVmP5t3VP9VF2CQHRElQkg8UbgeCgRQED9vVcY8j7Gop0XNpWcrFAdutmMD0rnlNz7YQ=
X-Received: by 2002:a17:906:594b:b0:a77:cf09:9c71 with SMTP id
 a640c23a62f3a-a77cf099da3mr354914266b.34.1720354254351; Sun, 07 Jul 2024
 05:10:54 -0700 (PDT)
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
 <CAK-xaQaYDg60DizL3kJ3XKU5JD3kKVi3kecb2s18Po96T9tAHg@mail.gmail.com>
 <CAL3q7H6rir8w6ge6zDPXYFaBoLyHsbcApr9WXb+A1Vc+8RP77w@mail.gmail.com> <CAK-xaQaDGR_x_HZ3CfTsguYQxWjUehKGSpapYLyF3wC=ofRB8g@mail.gmail.com>
In-Reply-To: <CAK-xaQaDGR_x_HZ3CfTsguYQxWjUehKGSpapYLyF3wC=ofRB8g@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 7 Jul 2024 13:10:17 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5Q-LZkoXLbh8XiVCgJYgf4QUCnaS2ngr3LT=nrT4q+=Q@mail.gmail.com>
Message-ID: <CAL3q7H5Q-LZkoXLbh8XiVCgJYgf4QUCnaS2ngr3LT=nrT4q+=Q@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 12:15=E2=80=AFPM Andrea Gelmini <andrea.gelmini@gmai=
l.com> wrote:
>
> Il giorno dom 7 lug 2024 alle ore 12:28 Filipe Manana
> <fdmanana@kernel.org> ha scritto:
>
> > > Ok, recompile now and test!
> >
> > Thanks! Much appreciated!
>
> So, usual benchmark:
>     fresh: 0:03:16 [ 275MiB/s]
>     aged: 0:02:30 [ 680MiB/s]
>
> I let you know in a few days.
> Well, does it make sense to add the option to disable shrinker via /proc?

Maybe (through sysfs), but  the shrinker is important to prevent OOM
situations because otherwise we can create an unlimited number of
extent maps.
It can be triggered by a regular user, intentionally or not.

>
> Thanks to you,
> Gelma

