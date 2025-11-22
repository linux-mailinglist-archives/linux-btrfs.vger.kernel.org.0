Return-Path: <linux-btrfs+bounces-19270-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51876C7D2E5
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 15:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103603A6963
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 14:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BF028489B;
	Sat, 22 Nov 2025 14:36:43 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37A260566
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Nov 2025 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763822203; cv=none; b=FKra+wcFTqLcX+lXhD9Nij9+4wnkr/SZMa7ZtrxW6GWoKVISbxi0Z1m/W2hP8aerSsj0HlivDoeQlPyd3qJZMqBMXLcWSugtuGHolVGAFxgPDagbIQnd9y7bE0RnG7WmxHFXuX98MKU+lD/4eyoUSvlofICZnhg7uqCJhN28hv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763822203; c=relaxed/simple;
	bh=EFYi9L5UwDPh1mzI94F/EK35AXPC5I9gw0Q51gsezgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pb633lNHI0u+IE1oBxop6uaD5uUfRnJzn8UOXUHyF2Q52nCp9JO2YZEnNVQtu82HjB4ktlTny+pYLNv2KkI+4PKJtsoxflsiZ3IbyNEZIhDdMJwIPQO4P3AhaL+0XGNg1kDhH2ZtXQ+UpEmQiYTcl87W6SzZ5LZbugZMIN3J2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3ec46e3c65bso2340522fac.0
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Nov 2025 06:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763822200; x=1764427000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mrG3FRl3ZQJELga2T7IxRw84N89LNPCPL/hcWM8uf/0=;
        b=WXZXF0BandPlN2oN0yHW3Hh5LPPcw0aa/z1T2m8TqwXEhrB1DGOnAFb01lYedlmecR
         hXuyUwr4Ykm9mgDgKEiJeZpX0t2ayMTw+Vf/atPqAtdOP5I93ZbjjwddbHA5Xdr4rtR3
         8Zf1TBYldxsIUupcV1gtHZO8hWkYBw119Y2FYFDS+zHo7ID2AIZ8KbYngFNNZl494gBe
         EC9ED9igTo2HRGA/1m0KjF95ozlvFA19JM6TmECsHMqeMcEtQv65CXfONUzsddCH6dTx
         Hh5iwdPQ7W+DhuBm/EWMcdu6zWlAJiyBb4SmReFdxDVQ7nHhUnPcuChydbpk6QNdP3v8
         GiZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOr+0hT/1mAO1ADVvlV7GwQJr+/jHnuKRuljN/GUpm7G0PFjsq1s/PYVwEILQAAY+ZKln9h/yPevdDBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1tdOwCac3NawZLzTu2NsADrw5BvCajBChsIDpUJ8phwx+5WP
	tD8lyO+BhJgwG2Chuq0SBZV48RR7Wf5fKWwylffwX+kJcfwP/VuEvibwmff1Ag==
X-Gm-Gg: ASbGncvDERsud041Wj8YRcFhCe1YZEhlgUuid/mTpZujF5p6Z/xJovmA4cEQQcE08RH
	ZbiOOJz1I+ll9/s1pK+HlDw4Qqvu55lYlB3CKinuz6+GX8Rk+c2QFc0EiPUanx1IjcgpkqGyRBG
	UTVj+K875qSYbVQ2iE3re9imemQArebGQN0o8IZ5jcdEIMAMOyft52YWc1TId5nium96B4wZ/O8
	OETjquC4D2SUuzLrLRXDQfKQmowLa8m/KOf3Fu0ay9Ytu/dvqAUl+glQ0OdKRnt5yJEPc6G/NSn
	a2iVcUYnd6SdEeUMRr120xFKgJfxETKx6pAanyQ365aDa8PP9h5KB6C6KAsn5Ag51IzVqweq5q+
	CM/FgCmImN+R/tWj6xxMZdrfvk6ohpIZoQwnZ+t9CcwiXzGdwFcsiCGbWcnTK3kHrd9w7MJ2+ig
	akcE9u5OeVcS+p1TRa+5+yIPan9pIWdynWYdxC/qbaC21iP08+uT0ERdBZx9OF/IdO2rd66tM3
X-Google-Smtp-Source: AGHT+IFDrrlreD0AIozK9rF/azJ4dWi3TA/dd6kRZjugszA1OVhsTQFkhXkE/ssMYw7A2p0PsB3UsQ==
X-Received: by 2002:a05:6808:1786:b0:450:d927:947c with SMTP id 5614622812f47-45115a64badmr2020901b6e.30.1763822199903;
        Sat, 22 Nov 2025 06:36:39 -0800 (PST)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450ffe2d425sm2479244b6e.4.2025.11.22.06.36.39
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 06:36:39 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c7660192b0so1987189a34.0
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Nov 2025 06:36:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbrOmcnw8rBqo2rUagd1UEB3nhOAlxCv/9BscFGu/U8YlDd6cpBMMxBjS0yXOEt50gWqALjB583pdtRg==@vger.kernel.org
X-Received: by 2002:a05:6830:3488:b0:771:5ae2:fcde with SMTP id
 46e09a7af769-7c798f7ba96mr2916201a34.2.1763822199328; Sat, 22 Nov 2025
 06:36:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7458cde1f481c8d8af2786ee64d2bffde5f0386c.1763700989.git.wqu@suse.com>
 <9523838F-B99E-4CC5-8434-B34B105FD08B@scientia.org> <bc5249ba-9c39-42b1-903d-e50375a433d2@suse.com>
 <3C200394-F95B-4D1C-9256-3718E331ED34@scientia.org> <5495561f-415d-4bb0-9cd4-4543c510f111@suse.com>
In-Reply-To: <5495561f-415d-4bb0-9cd4-4543c510f111@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Sat, 22 Nov 2025 09:36:03 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_3rtWr2P_j76792+s30VPn84sDv-u_61_vmLBUE0ztkg@mail.gmail.com>
X-Gm-Features: AWmQ_bmqpnKk3EPf9MVQGz5yyOka6iv918VShrajeq5dDuRVH8lOvvN7LP780X0
Message-ID: <CAEg-Je_3rtWr2P_j76792+s30VPn84sDv-u_61_vmLBUE0ztkg@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: docs: add warning for btrfs checksum features
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Anton Mitterer <calestyo@scientia.org>, linux-btrfs@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 1:44=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2025/11/21 16:32, Christoph Anton Mitterer =E5=86=99=E9=81=93:
> >
> >
> > On November 21, 2025 6:24:26 AM GMT+01:00, Qu Wenruo <wqu@suse.com> wro=
te:
> >> =E5=9C=A8 2025/11/21 15:47, Christoph Anton Mitterer =E5=86=99=E9=81=
=93:
> >>> Is that even the case when the wohle btrfs itself is encrypted, like =
in dm-crypt (without AEAD or verity, but only a normal cipher like aes-xts-=
plain64)?
> >>> Wouldn't an attacker then neet to know how he can forge the right enc=
rypted checksum?
> >>
> >> In that case the attacker won't even know it's a btrfs or not.
> >
> > I wouldn't be so sure about that, at least not depending on the threat =
model.
> > First, there's always the case of leaking meta data,... like people obs=
erving the list or my access to Debian's packages archives (btrfs-progs) wo=
uld e.g. know that there's a good chance I'm using btrfs.
> >
> > Also, an attacker might be able to make snapshots of the offline device=
 and see write patterns that may be typical for btrfs.
> > Even with only a single snapshot being made, with the empty device not =
randomised in advance, it might be clear which fs is used.
> >
> >
> > But all that's anyway not the main point.
> >
> > Even if an attacker doesn't know what's in it,  he could try to silentl=
y corrupt data or replace (encrypted)  blocks with such from an older snaps=
hot... which would then perhaps decrypt to something non-gibberish.
>
> Adding linux-crypto list for more feedback.
>
> In that case, as long as the csum tree can not be modified, no matter
> whatever algorithm is, btrfs can still detect something is modified.
>

A few years back, the Fedora Btrfs folks debated whether we should
switch the default away from crc32c to xxhash or anything else[1], and it
basically came down to the performance hit being too significant to
consider.
Given that crc32c does the job in detecting tampering with it, and you
can reinforce it with fsverity, I'm not too worried about it.

[1]: https://pagure.io/fedora-btrfs/project/issue/40



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

