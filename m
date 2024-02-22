Return-Path: <linux-btrfs+bounces-2627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFDF85F411
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 10:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F00A1C23921
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 09:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C22B376FB;
	Thu, 22 Feb 2024 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MHGrapzX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6611E36B02
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593275; cv=none; b=MbgAiDmoDEdq5IlXdShNijqJJYfMgjF1BkfEXDzhPZ6pDM+a+7Vkrv48HjFIFAn8VMRc8CZuA/QpoZ9B82XKHAt8eX7JML6256mT77HCgVUAvuafYv3KOoRlI0g1rV7dDQWVzFKqs09bVDqpeXrDNvXuaj8ykyzLX7BM0ovItM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593275; c=relaxed/simple;
	bh=uUWc5RNTkFfpyT5Z/DVXQaEG0/4OqVb6v3u3ZqsaAqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8CtS/Z02EffgCAQwBLXfSmUqd61xJ4j5Xf98w+TM51ynknM7zL9V5Qttg9FUXd2fmP4ynHp2t9yCyT2GgkVGDhM23UmPGFR9X6jsscHDZzaYAgqfuPJWa33mltaheMYja9t7UHvlKb0cGSJRZC1QWV5EUfjMoS7NQ2wA/lEwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MHGrapzX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3d484a58f6so213638566b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 01:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1708593271; x=1709198071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc5x5ZGyO9TbIPJPv7CPAQCydXuBeN2qMipJ6fk1Xss=;
        b=MHGrapzXNv6OEvLADjXsEF9bA1TSt3eg4xjXEcj7B4na49MVlX67c1ur67BLNo81jT
         AoEa6XNuI3P2MHTI8uvwrkWvX6fostIAwOzB7mtG10/Q3MV4wBB1C3Uph1CitugzbIiP
         ZmglV9Pzqeav8U1sR6L55D5YOodQ9NUdFmynw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708593271; x=1709198071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xc5x5ZGyO9TbIPJPv7CPAQCydXuBeN2qMipJ6fk1Xss=;
        b=nLTgi6c5rd83QnOPge+VUC5kLreME+JTplUO4E3dKc2mi2+enKA2nWq8YpPyyC9H7F
         0NPNvNvzbTyyBhIBRmx4AW1oEDbWBT845YJMisEKmwxoVZ9JNceSkIgeASOJylRQ3/dg
         oRJCPqvkJ5/N8lFtvq20LkjmAQtbMj+0Us9AxlWHX6YJnEzvBEee4337CF44oe0G+pty
         zV8McA6QEFctmpS9PYuczMOXOlGyqLxtvM3/6lPh42BuDWt/VA14JPBDhOd4HvJ7W90n
         A1GAnhtYUBFju8pRKMQOZeCtNV07HxEjLeiQkc4Yhicvt8rdBvRWX4tM1vo6iomL2TkM
         u+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMmQWfVRtQeaPER8420gNCx9dEJOgnvfyvSzwyPiFK+iGb2ZDUdw/kIMbwlL20G343J6/QWWkEECGsiix8rz2gNDBvtLaHdy2jd6w=
X-Gm-Message-State: AOJu0YzLQ/DZticmdcZw3XxfDTmBEY68SjkQ418FsKED/12UHN3DB9RV
	IkSkrvG12Vl7v+zdebW/iRFbnIvjtrId/KHYEFa+5+S0m9S6Yup4mo9aVgJuNSDLqvf/JgpYDAi
	0nJ1XDXmROovC/m1tEjkiLgGd1JDIhKHhjDSHjA==
X-Google-Smtp-Source: AGHT+IE9m7eSBXIsG0RYQV1/BmpISngFJzXpbBr8sSfB1MyQJIhhTzUnde3eNlafKq+TqpYf5GXCHV/9hf/7NgCkKqU=
X-Received: by 2002:a17:906:1cd3:b0:a3e:e04c:45c with SMTP id
 i19-20020a1709061cd300b00a3ee04c045cmr5495887ejh.14.1708593271453; Thu, 22
 Feb 2024 01:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com> <20240221210811.GA1161565@perftesting>
In-Reply-To: <20240221210811.GA1161565@perftesting>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Feb 2024 10:14:20 +0100
Message-ID: <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
Subject: Re: [LSF TOPIC] statx extensions for subvol/snapshot filesystems & more
To: Josef Bacik <josef@toxicpanda.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 22:08, Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Wed, Feb 21, 2024 at 04:06:34PM +0100, Miklos Szeredi wrote:
> > On Wed, 21 Feb 2024 at 01:51, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > >
> > > Recently we had a pretty long discussion on statx extensions, which
> > > eventually got a bit offtopic but nevertheless hashed out all the major
> > > issues.
> > >
> > > To summarize:
> > >  - guaranteeing inode number uniqueness is becoming increasingly
> > >    infeasible, we need a bit to tell userspace "inode number is not
> > >    unique, use filehandle instead"
> >
> > This is a tough one.   POSIX says "The st_ino and st_dev fields taken
> > together uniquely identify the file within the system."
> >
>
> Which is what btrfs has done forever, and we've gotten yelled at forever for
> doing it.  We have a compromise and a way forward, but it's not a widely held
> view that changing st_dev to give uniqueness is an acceptable solution.  It may
> have been for overlayfs because you guys are already doing something special,
> but it's not an option that is afforded the rest of us.

Overlayfs tries hard not to use st_dev to give uniqueness and instead
partitions the 64bit st_ino space within the same st_dev.  There are
various fallback cases, some involve switching st_dev and some using
non-persistent st_ino.

What overlayfs does may or may not be applicable to btrfs/bcachefs,
but that's not my point.  My point is that adding a flag to statx does
not solve anything.   You can't just say that from now on btrfs
doesn't have use unique st_ino/st_dev because we've just indicated
that in statx and everything is fine.   That will trigger the
no-regressions rule and then it's game over.  At least I would expect
that to happen.

What we can do instead is introduce a new API that is better, and
thankfully we already have one in the form of file handles.  The
problem I see is that you think you can get away with then reverting
back st_dev to be uniform across subvolumes.  But you can't.  I see
two options:

 a) do some hacks, like overlayfs does

 b) introduce a new "st_dev_v2" that will do the right thing and
applications can move over.

Thanks,
Miklos

