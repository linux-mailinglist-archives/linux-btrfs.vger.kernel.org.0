Return-Path: <linux-btrfs+bounces-6225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8284E928781
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 13:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D241C221A1
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 11:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63D0148FFC;
	Fri,  5 Jul 2024 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkuSKhMd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C813665A;
	Fri,  5 Jul 2024 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177604; cv=none; b=YN1f1iOHTKHYOZ3GjuMs7Rihw5DBiAWObR8kkrPjC0gWlatD5Qq1CuoEriuUcN6ts5dIcOOXZEzxuMoWPXXxwZfmkmTR+pZ5oRmNAIFtJb08f9rLo0s+Dr9EUTJuuxYxv8AJxo6OdtmHOc80Mm6gdFOfY93hi+6QQXM3UYFHpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177604; c=relaxed/simple;
	bh=8+WZaP3nhTCnIc1AsENbtDY0K0ju2lbrz8eZmgxBEWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueW0E+Ixm0pi7DT98qregxBV2MSfn2iwTPVG2C9LjGa/RAtqut75oa8tKqeJgIVUCeoBYw2U33Ck58v4kiz97v4dtBVu1lCXoehLr7P4L3vKP/L6FRFmJYnzi8Jz/mJSu1GKMY0gKJU9Fu+XkobP3Mg0iwyibGS9qmm2nLeuQnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkuSKhMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB17C32781;
	Fri,  5 Jul 2024 11:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720177603;
	bh=8+WZaP3nhTCnIc1AsENbtDY0K0ju2lbrz8eZmgxBEWs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bkuSKhMd/s1M3jLIO5uXA38ScJC4HgzeApnoM5clKKZCYo7ifptsB+wzGZjU7w5xp
	 YeoEm3oS+aF/P3gmmt4sltJoNAGcmRReYglcyl3vk+a6I5QAOrbMiAFvtE/9FaLB6h
	 QC4Gxw/PvgvSU8So6P3I7R5ZkRiMvButtyCV+BAStu1WVbfNTsrDQfIEArRiL+BajF
	 xfj9+OmTSBQuvFRN02Kh9sYRsAYwTZXW7jbR2jHR+ek+jv4uwm9Z8D3EsMVkBpqfNQ
	 IwSbVlHarIP8UNQPW7dVMttofHu/JQ7/xgZi95yBuByQPg6HstXnNoGa/RphPSg30W
	 T36vHHWZLfPnA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso129919266b.0;
        Fri, 05 Jul 2024 04:06:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwQlweXfgr6Xycl4QwF11Ui4iTfbF/LRfMgbZUrHltSQjvp3GxeYRJtJlwPzfqp0ppgjYpExQgQu5QoSwuPdaIwSzO4XMlukcO0SaGJuxMZ/wJYBi8XbYLOiOm6cCWZZTpc43YjAJ+kYk=
X-Gm-Message-State: AOJu0YwI1cFvbhPO+TYMFE4O2urzWSPALsp1qOBfvkK8HzF8g5choJa2
	mkWUbqn8gj7tu9D+SJSt15OjKpfGxqvUXLHDrGdpNH540k4/sQqJ49e68vsA6/IvPPrL4rjxj53
	xXg6MUFs7xjuBkToluvbSwfPbF3s=
X-Google-Smtp-Source: AGHT+IH64c+v1szNlZ0nWhKoen4VTG9k6IK/Oj+q+L+IPrB+lOM0thHysuOIn7Ff3Wm2h1RYlJynnym5RR6NAAryEa0=
X-Received: by 2002:a17:906:34d3:b0:a6f:b58f:ae3c with SMTP id
 a640c23a62f3a-a77ba468a2amr307138466b.26.1720177601984; Fri, 05 Jul 2024
 04:06:41 -0700 (PDT)
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
 <CAL3q7H4D8Sq1-pbgZb8J_0VeNO=MZqDYPM7aauXqLHDM70UmAg@mail.gmail.com> <CAK-xaQYwgOKkeD4HvMtNqNqqchW4aS2gtvzGJ-yKwfE6uaUYng@mail.gmail.com>
In-Reply-To: <CAK-xaQYwgOKkeD4HvMtNqNqqchW4aS2gtvzGJ-yKwfE6uaUYng@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 5 Jul 2024 12:06:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7MP7HQbyMpGgRrG+rejQX+5Hc7ipPNPN_tjbaUzNBNGQ@mail.gmail.com>
Message-ID: <CAL3q7H7MP7HQbyMpGgRrG+rejQX+5Hc7ipPNPN_tjbaUzNBNGQ@mail.gmail.com>
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough memory
To: Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	dsterba@suse.com, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 7:30=E2=80=AFAM Andrea Gelmini <andrea.gelmini@gmail=
.com> wrote:
>
> Il giorno gio 4 lug 2024 alle ore 19:25 Filipe Manana
> <fdmanana@kernel.org> ha scritto:
> > 1) First let's check that the problem is really a consequence of the sh=
rinker.
> >     Try this patch:
> >
> >     https://gist.githubusercontent.com/fdmanana/b44abaade0000d28ba0e1e1=
ae3ac4fee/raw/5c9bf0beb5aa156b893be2837c9244d035962c74/gistfile1.txt
> >
> >     This disables the shrinker. This is just to confirm if I'm looking
> > in the right direction, if your problem is the same as Mikhail's and
> > double check his bisection.
>
> Ok, so, I confirm. With this change, just a little bit of PSI memory
> sometime (<3%), but no skyrocket. Also, tar at full speed.

Ok, so the bisection is reliable and it means you are experiencing the
same problem that Mikhail reported.

>
> Now, I'm going to prepare the btrfs image to send you.

That might not be necessary, not sure how it would help, the 2nd patch
to try would confirm if it's any fragmentation causing too many slow
reads after extent map eviction.
So save yourself some time for now because making the image is likely slow.

>
> The other steps later.

Thanks!

