Return-Path: <linux-btrfs+bounces-10451-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033F09F43CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 07:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8491695BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 06:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640A15CD41;
	Tue, 17 Dec 2024 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9jr5lkx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1E11581EE
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417310; cv=none; b=Gwsa5VFpi17newsiHenuwftuPtXcSJlr9/m/yg5vY9KlXGUA6raZWD9MG5ei1nK1EkjICj4WNSaLirK4I3xWqo6zJ8RWYoZ+ubIN1mZokwYNikKc3iEw5HOi6RqM7JrGrEsG+Mhc+yCqL2gR5leaRSl+gKD7XXcRzGL8MXGY3Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417310; c=relaxed/simple;
	bh=E+nWpuUKInY3cpUQlz8GMNySfgBa0OBAwvh/zTETaeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwlA8F8WhBiYVM9pEML5v412cQuSvjZ7JxlRkZMiCc31bWAXpyjQshTZnt3ZScdS+KrUROoos6O26BGFGMz6Dp0oNBhMT2FkS1kG9CNxm2BnoFLSypz44ed17IFqIykjneIdXfas0Bgg2t1wmyL+rHIYzlCTqL5coQaVk+SJZ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9jr5lkx; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3022484d4e4so55915991fa.1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 22:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734417306; x=1735022106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+nWpuUKInY3cpUQlz8GMNySfgBa0OBAwvh/zTETaeU=;
        b=L9jr5lkxXvHWlcm6eWJc4kFvvfXRYf2rsbF8DHxequUhIaa059aOvLvSltbMkK9hnb
         eJM9aInLDUoqNTdI7cyZcLPvBo+iFA2VhHoT60IvFFlIXepyg/5VfM5MFFpKGqvXNjag
         4WTX1kZPBLkWZDIfkcXPF6TMTpdzvzjp2PzpZhLcgLg4++UxJkmYUXldqGNxC0mdu/pW
         mWrDIG8AQpRH4+lyuvPqx9uzL1/P2Gv8DOgZYNNCFTJSPAOOwvCnw9+kohH87P3hKbX+
         NjMOKkA2ufM47ytOn2pWk/lN1r6eWSoMoHgOOJ0EVJ5SFVhyGE4aI1sGSgnnEN5JGcrY
         b0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734417306; x=1735022106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+nWpuUKInY3cpUQlz8GMNySfgBa0OBAwvh/zTETaeU=;
        b=jelNXkrdBYelaoji8jJs3rXjWd/356bWL5tzyNExg9tJOap9/UPunTAKKcy7KOhbW/
         TymUafkuqOodqtsHVNzjYURD5TTq/3Sbcivksv4Cc0kaowR3BkUqSQaQtETbDggjRnzy
         zT0heA+Bh6XdhoPDkpr6CxAgMeF9fCJ5EUrDqq+Mv6VznQGsQckltcf3XwzrnSD9f9Ef
         Mvjm0oH1EzEsTYw7W/HPmvptnX14UMDwiX/LuNaLNvrKQLYcDAjPhoGvK8lWOh4hq2jt
         +peau5KtOhKSz++RVzi3oYwHqC0GkQ/hhg03rmf2hds9PqGChHUWzYDzi1/J/xZ+PZIk
         DgKA==
X-Forwarded-Encrypted: i=1; AJvYcCVfPLUIukUygvALfivUJAbqeh1G9Re8i9GTlEPLMRofEbLtBpVFjbbN7dj0T9Xot/AAF3M7rYECMQ0pMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ1XZuN2q+Hbziv0LeQBjn/YMImtG6uKLAMF9wgwpNT3j0i6k8
	H90CW14/uBHpgk5iJAQAQ/IP0AFnB7T1CJXAVv0+BOyfZXkyquueenV22QUU66ZcnhixEybyQLx
	1BMDW2v5nSt8616oL6IWJizUDwNJ6TA==
X-Gm-Gg: ASbGncsD51srh3+YhBeKvBG5uTldKgEYenMv2HwJORv5QcfOVbAnE1hQRF5QqjOE+VP
	VETH2UAyfECgoBlhUtLtZXisk35pIidU/aLKJVbw=
X-Google-Smtp-Source: AGHT+IGe8Oi0Wzi+OVgkaGbM5H0drOgRTwyMKnUUmdg6zXddFZH9PX9UjKXDXDGBxykcoTeauZEpN4tvydpjw8Yf+uk=
X-Received: by 2002:a05:651c:10d2:b0:302:497a:9e6c with SMTP id
 38308e7fff4ca-3044351f694mr6613791fa.20.1734417306325; Mon, 16 Dec 2024
 22:35:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADhu7iD1LOT=93o1DhFYBeDHTKW9SuYdSmz8VXvsE4vf285tDg@mail.gmail.com>
 <c5ec9e5e-9113-490d-84c3-82ded6baa793@gmx.com> <CADhu7iBFDmRvBwWxxa4KszyZpyTq5JetB+a13jxGj4YBjaYWKQ@mail.gmail.com>
 <561aab35-007d-48d5-bf61-8cfc159cba28@gmx.com> <CADhu7iCYRjcQ2kHWqvaZYTnwVUY-qFaBSaDyZA_OL2MEpr6EYg@mail.gmail.com>
 <61140354-83ce-43cb-8bb6-fc7b5ecaa1f1@gmx.com> <CADhu7iBR-i9bOHRDN-adtWkoF8R9v=kvFhAySV_Fbfk_v8iFXg@mail.gmail.com>
 <CADhu7iBQf_vE3hSoDH7L=eCPzq9LZQyr1R8xDhF-OEXHENkD1w@mail.gmail.com>
 <CADhu7iD+kKsvxZtnX9q94tuJzS6z=zs3B7Xc9Bb4G+mnQ6_UhQ@mail.gmail.com>
 <2e3d5a0b-4cc5-48e7-80a6-7cc5454d54e3@suse.com> <CADhu7iDkie++6DhJD7e1Ce2LqeS57VnOhX-fDAhPFXJ13yyPpw@mail.gmail.com>
In-Reply-To: <CADhu7iDkie++6DhJD7e1Ce2LqeS57VnOhX-fDAhPFXJ13yyPpw@mail.gmail.com>
From: j4nn <j4nn.xda@gmail.com>
Date: Tue, 17 Dec 2024 07:34:55 +0100
Message-ID: <CADhu7iD2U1R9ssAruFVu6s+xvkcAtAr7dYj26cRJ5f5pLNmiyw@mail.gmail.com>
Subject: Re: clear space cache v1 fails with Unable to find block group for 0
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Dec 2024 at 07:10, j4nn <j4nn.xda@gmail.com> wrote:
>
> On Tue, 17 Dec 2024 at 06:50, Qu Wenruo <wqu@suse.com> wrote:
> > =E5=9C=A8 2024/12/17 16:01, j4nn =E5=86=99=E9=81=93:
> > > On Mon, 16 Dec 2024 at 19:52, j4nn <j4nn.xda@gmail.com> wrote:
> > >>
> >
> > This is from the metadata writeback.
> >
> > My guess is, since you're transfering a lot of data, the metadata also
> > go very large very fast.
> >
> > And the default commit interval is 30s, and considering your hardware,
> > your hardware memory may also be pretty large (at least 32G I believe?)=
.
> >
> > That means we can have several giga bytes of metadata waiting to be
> > written back.
> >
> > What makes things worse may be the fact that, metadata writeback
> > nowadays are always in nodesize, no merging at all.
> >
> > Furthermore since your storage device is HDD, the low IOPS performance
> > is making it even worse.
> >
> >
> > Combining all those things together, we're writing several giga bytes o=
f
> > metadata, all in 16K nodesize no merging, resulting a very bad write
> > performance on rotating disks...
> >
> > IIRC there are some ways to limit how many bytes can be utilized by pag=
e
> > cache (btrfs metadata is also utilizing page cache), thus it may improv=
e
> > the situation by not writing too much metadata in one go.
> >
> > [...]
> > Considering the transfer finished, and you can unmount the fs, it shoul=
d
> > really be a false alert, mind to share how large your RAM is?
> > 32G or even 64G?
>
> Yes, you are right, using both :-)
> That is 96GB of RAM...
>
> Thank you for the explanations, particularly the "16K nodesize no
> merging" metadata chunks.
> The reported 'time' of the transfer included a 'sync' command after
> the btrfs receive.

I guess the hung task backtrace that appeared during creating of free
space tree cache had the same cause as this simple btrfs send and
receive?

