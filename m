Return-Path: <linux-btrfs+bounces-33-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A03D7E5D26
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 19:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3D11C20AE3
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 18:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6045536AFE;
	Wed,  8 Nov 2023 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGw67X5M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401F358A2
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 18:25:11 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8685C2101
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 10:25:11 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc209561c3so11305ad.0
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 10:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699467911; x=1700072711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC/6qhrPU03mDp/kTli/yNT2tn8rEseETDX1nC6wox8=;
        b=EGw67X5MiD6H3JBdSATKzNavOXwLP4i2t9tP/rOF5jYHsTYK0TirhnySq5O27YAixd
         YkjPoeOUmDoVuAGBXAw44EXOxP6lqc8WdQP0T8eSK1EppWGFOXr5GwHJqxjNx8GDDTGm
         JyuuCpYj7cFUhU959QXI4CgWER/fw/KwdlB4DUr4qxD7clzsUXPATvVrFoLqyTEAEGmo
         gxluJGGAOHKvg9+u+5y87KTE5uy0Hw+DoB2WsuAAi5YMa5/WNJpuPLqF2e0dINjOPCYQ
         3yPgHLh8k4lqsMKYJWhf4v1CQx34kB26jrUgU7vBTYNGB4JCYm8YMtGmFUxnRgVCGb6M
         3R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699467911; x=1700072711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PC/6qhrPU03mDp/kTli/yNT2tn8rEseETDX1nC6wox8=;
        b=vQsZqN7tCZzEJjn+E86x3nHDaY4+AVEomDJAB7Hs820+2ictOocnvbb1MctvYOPCoM
         qJmumlO2wvuV3I5Azs88N8VlwvY7BRp6ODBGOAhXpLaNjuS4oPyeCOG0Y/opVToqoyc3
         C603lxx4nQKvZsR3S3FXhH2MUe9GrMcGqtIT0u0NoXrfASJOfeCKv+yrRjTZbtac3Jkv
         hX8C6cHeDshH1ZcGEDIXe5cnE9NPQehhMrrTvEZUCk4rFVQCShQpXcm2hXUJZj2YBvwQ
         V6PN3Nmkyw0DEbD6BehWJr/eBl4EvDkXCWoYvZeYye0uM1EvKQY3H2WtAYc/Oi4ndWDo
         P06g==
X-Gm-Message-State: AOJu0YyPbq3WUu3KcvkeCAAZhg8U4ek8+96sY2JJuyTpwMLw3KJJ2mJy
	BaWY9wTGhqhYxDF1kdTzYQ6ko/ZAd5f/PB6CgJEaoA==
X-Google-Smtp-Source: AGHT+IHxrKjsunYtwCVlQDJt85desOtieZLQtrnV8TYRwbsiFMuy8DBOb0CrFp15j+2/TxH5dCjYOFdEPQBtv0jPj4Y=
X-Received: by 2002:a17:902:d4cc:b0:1c9:b5cf:6a78 with SMTP id
 o12-20020a170902d4cc00b001c9b5cf6a78mr8503plg.27.1699467910689; Wed, 08 Nov
 2023 10:25:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230704122727.17096-1-jack@suse.cz> <20230704125702.23180-1-jack@suse.cz>
 <20230822053523.GA8949@sol.localdomain> <20230822101154.7udsf4tdwtns2prj@quack3>
 <CANp29Y6uBuSzLXuCMGzVNZjT+xFqV4dtWKWb7GR7Opx__Diuzg@mail.gmail.com>
 <20231024111015.k4sbjpw5fa46k6il@quack3> <20231108101015.hj3w6a7sq5x7x2s4@quack3>
In-Reply-To: <20231108101015.hj3w6a7sq5x7x2s4@quack3>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 8 Nov 2023 10:24:59 -0800
Message-ID: <CANp29Y7DuDDkVBwsU_xhBSAug7q7vTsrS6jogF61CYEi85jGcw@mail.gmail.com>
Subject: Re: [PATCH 1/6] block: Add config option to not allow writing to
 mounted devices
To: Jan Kara <jack@suse.cz>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>, 
	Ted Tso <tytso@mit.edu>, syzkaller <syzkaller@googlegroups.com>, 
	Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

Thanks for letting me know!

I've sent a PR with new syzbot configs:
https://github.com/google/syzkaller/pull/4324

--=20
Aleksandr

On Wed, Nov 8, 2023 at 2:10=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> Hi!
>
> On Tue 24-10-23 13:10:15, Jan Kara wrote:
> > On Thu 19-10-23 11:16:55, Aleksandr Nogikh wrote:
> > > Thank you for the series!
> > >
> > > Have you already had a chance to push an updated version of it?
> > > I tried to search LKML, but didn't find anything.
> > >
> > > Or did you decide to put it off until later?
> >
> > So there is preliminary series sitting in VFS tree that changes how blo=
ck
> > devices are open. There are some conflicts with btrfs tree and bcachefs
> > merge that complicate all this (plus there was quite some churn in VFS
> > itself due to changing rules how block devices are open) so I didn't pu=
sh
> > out the series that actually forbids opening of mounted block devices
> > because that would cause a "merge from hell" issues. I plan to push out=
 the
> > remaining patches once the merge window closes and all the dependencies=
 are
> > hopefully in a stable state. Maybe I can push out the series earlier ba=
sed
> > on linux-next so that people can have a look at the current state.
>
> So patches are now in VFS tree [1] so they should be in linux-next as wel=
l.
> You should be able to start using the config option for syzbot runs :)
>
>                                                                 Honza
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=3D=
vfs.super
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

