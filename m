Return-Path: <linux-btrfs+bounces-848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B47780E793
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 10:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD2B282B96
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3664219F2;
	Tue, 12 Dec 2023 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="N0uDapW6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897A1DB
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 01:28:26 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a22ed5f0440so32246266b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 01:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1702373304; x=1702978104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v8w2DwEyvYKracClfw9CEOFvn8+9KoSunQeNFqFlh1M=;
        b=N0uDapW6yifgomL+7ROuyd7tGB4wAk6qJp8pFYOOy7dMV+8Xri0Kko3/y37YNDFV4f
         1aN4YfFBQ150QRDQ0pjG8AZmcYX4JDJ0O1+gKs8YjenRWIKy9EZswoZ/i+yntyZMIMpW
         YdQP9MxwjVUfa4XsIbTNojmCkAD7IC7ghM4U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702373304; x=1702978104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8w2DwEyvYKracClfw9CEOFvn8+9KoSunQeNFqFlh1M=;
        b=Tc55Q9KUpusAi8QqyI/e7eNnpBpufHGbrH1n6iMHjvj/0vOsuavUCnqoYT+KLuiqbE
         DCx7acZspidyd6X5ShQNYMPILAqK6MJu4DK3XJke9hoJ5eFmR0AgOg3hz3NqX1TMgZ6G
         qrfL96zjYnOrF03mbselBB066veugzN7QOPnHVwkNKshRaznDZv7cQLbE7N9jpe2tcsj
         l8L/UVp5LhCvmcevn+AzzyWWDkoslkxxrU99MWv5X7gIYvc/5w+D/uTp+JuMhIis3zOa
         nDAUA5+F91ZGMU77H//zIyFkyCqFSPcU2qshE7TG9opw/z2EeKXda4GRUjbXIu1BskXZ
         oy6g==
X-Gm-Message-State: AOJu0Yxylle0MR/BXWCSy5TnSj1Be3+7gGORN2LvyOMEWA0BsQR1glAF
	qKt+lw4jrB56uC79rqmR876PHorvQDR6DJcS8l58+A==
X-Google-Smtp-Source: AGHT+IHsaD4tkKxSGXJcV+/dBgYe9jb2cQ4Y9xYAoGt8h3rcQqxsQi/f5q0HnXFIs+Mg01St5Y7xiifj+LYb4UZ4R8M=
X-Received: by 2002:a17:907:7ba0:b0:a1a:c370:2218 with SMTP id
 ne32-20020a1709077ba000b00a1ac3702218mr2398708ejc.83.1702373304544; Tue, 12
 Dec 2023 01:28:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <630fcb48-1e1e-43df-8b27-a396a06c9f37@molgen.mpg.de>
 <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan> <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan> <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan> <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area> <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <2810685.1702372247@warthog.procyon.org.uk> <20231212-ablauf-achtbar-ae6e5b15b057@brauner>
In-Reply-To: <20231212-ablauf-achtbar-ae6e5b15b057@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Dec 2023 10:28:12 +0100
Message-ID: <CAJfpegvL9kV+06v2W+5LbUk0eZr1ydfT1v0P-Pp_KexLNz=Lfg@mail.gmail.com>
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
To: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Donald Buczek <buczek@molgen.mpg.de>, 
	linux-bcachefs@vger.kernel.org, Stefan Krueger <stefan.krueger@aei.mpg.de>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Dec 2023 at 10:23, Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Dec 12, 2023 at 09:10:47AM +0000, David Howells wrote:
> > Christian Brauner <brauner@kernel.org> wrote:
> >
> > > > > > I suggest:
> > > > > >
> > > > > >  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
> > > > > >                               same inode number
> > >
> > > This is just ugly with questionable value. A constant reminder of how
> > > broken this is. Exposing the subvolume id also makes this somewhat redundant.
> >
> > There is a upcoming potential problem where even the 64-bit field I placed in
> > statx() may be insufficient.  The Auristor AFS server, for example, has a
> > 96-bit vnode ID, but I can't properly represent this in stx_ino.  Currently, I
>
> Is that vnode ID akin to a volume? Because if so you could just
> piggy-back on a subvolume id field in statx() and expose it there.

And how would exporting a subvolume ID and expecting userspace to take
that into account when checking for hard links be meaningfully
different than expecting userspace to retrieve the file handle and
compare that?

The latter would at least be a generic solution, including stacking fs
inodes, instead of tackling just a specific corner of the problem
space.

Thanks,
Miklos

