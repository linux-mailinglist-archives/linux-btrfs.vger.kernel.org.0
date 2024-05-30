Return-Path: <linux-btrfs+bounces-5359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BCC8D445E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 05:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BD12838DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 03:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D06142E71;
	Thu, 30 May 2024 03:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2ud51y4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAAA142E6B
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 03:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717041119; cv=none; b=SrQs8ttxUhF5Xw0M0ohBOWYMvo8oIBioUrlxB+SGZnaGRREHPL8yrDbOfmPJm8Q2jl0oWs8NslPVc5JnIaq9tXNM5I6xtZljUGDpWSn8B7+frb2B2ZMbJuzG0mq8UZV9WUwrRfidqmxD4wFGLi5Kv2FibIWMmlBXPvgDLUZueNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717041119; c=relaxed/simple;
	bh=0VA1gl8TIpMoLBk0w1BVpi1wdfkjOtO6Y8etGq9qzYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wu5hCPJ584yEkpK2Tbrt8f1s9dLg3cWaFIBWwTI4fMCw3ezl3hqJNiKnXmw/PiiZ2lSlsuz2zkdkhaG0i6zdZIN9eTJoHN3itkVFTyvunoa9s6blOYGKi+dDVlipgUyJk7qjIW0ma3BZ9P6LB6x6tovKF9MmKEbehi5nR8XUyD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2ud51y4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5785199f7d1so164924a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 20:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717041115; x=1717645915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VA1gl8TIpMoLBk0w1BVpi1wdfkjOtO6Y8etGq9qzYY=;
        b=M2ud51y4DqXWbXBivYjDosBa8t1P3r08cC502JLXYUnUDRNYcFn4Q8FXLkQtMdz+6z
         3JsJHO7KDZ2vP0Z9T+MzsdmK4S0LV/tdB4a+2isRTXwMS/Z9zTGi27QFu+aM1X/5o66V
         cQGZQcRnRMbJDERNz+B0qPhIBWNnOFiYEv0EE3lIreK0neR2S9TrzbQKsA5JSlUKjpvy
         T0/g74zT81+1AZwVCfBSvpVBinytcgp0kf6GOw74l+riqFMrDnvFfNndiDLSQzrSt6IB
         Tdene97olenuZOGqDenoEQGvDzGrLrFfgVMgJvCB9O1FhHYniOwRqTbKd3Txxk8Z1asL
         IG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717041115; x=1717645915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VA1gl8TIpMoLBk0w1BVpi1wdfkjOtO6Y8etGq9qzYY=;
        b=p631IFZTiOHw1tMQAPS55hvodYJRjSK7hFYfkhIlMFKYL1ePWr7eePU76xHN2pB74t
         It4qzqpXv+0Zps6yA8MOcszRYFF9rDVU6QtLf3CfjlFtoi/QOJZaN9dPJhyJ9LpPvHt/
         n1D+Yja0s9N2oiwAEtFa25gqEjdjXDI0SuoSTAfyKFoztZDkCYnWUA0h05griqln6GU+
         +ov30zXht/BTnIXDgqeOj6gRceGTllO/WOwF4QgWqV7tuS1xMXpkrC46CPt5XhM/cFiI
         /v/UR5w9qoOoI6bXTMykcgnl3RzGhW4nUcd7rbiPoNJYyRIQuKtbjwES8/zonosOO/q5
         mMXA==
X-Forwarded-Encrypted: i=1; AJvYcCV2GYkOCMosHx9XGh/cXRwzA55TwWCyXBNi05HnWTiWgjRUK/TQUdIjLrfebMfoCZ0kFOfupIW3bu7DUJkqsVIRm6bR4GmQ78aP+74=
X-Gm-Message-State: AOJu0YxuTTtcXByMx/KY9oCyzXVavdceNXT6AtuZCdbFQbX38ODAcb1g
	TvvtZVQPmZqjbk0Cis4WXyXikFVmqUt5vvt0Ya9rS/PnNUahPCxnvTBAZLC6L6cDoMQPAKtRzCa
	TbJHP67Krn+WXy5mWEPwbAr5e/6Q=
X-Google-Smtp-Source: AGHT+IFsSBhuSAW4rjhLz2a4p5B7rn2wRo1TZ+eIoEiRCwVUXV+YFQRirlfO3WWSrGWiqC0bekqMi/NcQFVRNwgffUw=
X-Received: by 2002:a50:aa96:0:b0:572:6af5:1b61 with SMTP id
 4fb4d7f45d1cf-57a177e5139mr625911a12.6.1717041114991; Wed, 29 May 2024
 20:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528062343.795139-1-sunjunchao2870@gmail.com>
 <42631f4d-97ca-4f7b-a851-c06383b35065@gmx.com> <CAHB1NaidZ1WjkpshMC3zWwX1_3nL3AULG46fc4gmygb9TAa82A@mail.gmail.com>
 <20240529151207.GK8631@twin.jikos.cz>
In-Reply-To: <20240529151207.GK8631@twin.jikos.cz>
From: JunChao Sun <sunjunchao2870@gmail.com>
Date: Thu, 30 May 2024 11:51:43 +0800
Message-ID: <CAHB1NajXE07g1zi3wJR8GCuHyB9--EK8e1v7uXSAV8Lt2VxZyQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: qgroup: delete a todo about using kmem cache to
 alloc structure
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org, clm@fb.com, 
	josef@toxicpanda.com, dsterba@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David Sterba <dsterba@suse.cz> =E4=BA=8E2024=E5=B9=B45=E6=9C=8829=E6=97=A5=
=E5=91=A8=E4=B8=89 23:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, May 29, 2024 at 09:11:05PM +0800, JunChao Sun wrote:
> > Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2024=E5=B9=B45=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=BA=8C 14:42=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > >
> > >
> > > =E5=9C=A8 2024/5/28 15:53, Junchao Sun =E5=86=99=E9=81=93:
> > > > Generic slub works fine so far. And it's not necessary to create a
> > > > dedicated kmem cache and leave it unused if quotas are disabled.
> > > > So let's delete the todo line.
> > > >
> > > > Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
> > >
> > > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > >
> > > My bad, at the time of writing I didn't notice that qgroup is not alw=
ays
> > > enabled.
> > >
> > > > Furthermore nowadays squota won't utilize that structure either, ma=
king
> > > > it less meaningful to go kmemcache.
> > Thank you for your further explanation. By the way, is there anything
> > meaningful todo? I saw some in code, but I can't ensure if they are
> > still meaningful. I'd like to try contributing to btrfs and improve my
> > understanding of it.
>
> You could find TODO or XXX marks in the sources but I'm against tracking
> todos like that and the one you saw and all the others are from old
> times. All are to be removed, though with evaluation if they apply and
> are still worth to be tracked by other means.
>
>
> > We don't have one place to track todos also things are more like an ide=
a
> > than a full fledged task with specification and agreement that this is
> > what we want to do. This means it's better to talk to us first if you'd
> > like to implement something, either privately by mail or you can join
> > slack.
> >
> > Otherwise generic contributions are always welcome, with perhaps a
> > friendly warning that the code base is old and there are several people
> > working on it so the style and coding patterns are kind of alwyas
> > standing in the way. Reading code first to get the idea is recommended.
I see. Thanks for your detailed explanation.
>
> > Also, is it a meaningful to view the contents of snapshots without
> > rolling them back? The company I work for is considering implementing
> > it recently...
>
>
> > This sounds like a use case that's above the filesystem, eg. rollback o=
f
> > snapshot I know of is done by snapper, what btrfs does is just to
> > provide the capability of snapshots. Viewing snapshots is possible,
> > either going to its directory or mounting it to some path and examining
> > it.

