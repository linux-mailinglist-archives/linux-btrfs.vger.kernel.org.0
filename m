Return-Path: <linux-btrfs+bounces-883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE5A80F296
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 17:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F2F1F21321
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8BE7A22E;
	Tue, 12 Dec 2023 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="G3QoH3Nb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32C0E3
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 08:30:36 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-550dd0e3304so4736264a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 08:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1702398635; x=1703003435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=myMRBPovP/7/r8peG8VTqC6y7u4an2akYPL/sNmZaYA=;
        b=G3QoH3NbI8T+HBVFThHszhnVRfb2EdVEVFGEUkAFmY7/IGZNwZgq/yzGqa2w8dV5x5
         BO3uZHt+8DejQrny2xSMhgIXBNOiUPHsi3BDJchcV6zlPsHZ1FApNXxzHoIQH8IA6uid
         yn0jZjtiVFNe7Gn6s6IoB7/CCRSYJmIvoyXx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702398635; x=1703003435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myMRBPovP/7/r8peG8VTqC6y7u4an2akYPL/sNmZaYA=;
        b=MWIZ7elgycchjWawP23KOiRjwqxjhXlxDRi1hoDXD0bw2MiNJA77A5GRzxCOb7rd5y
         WFC1LvkiU8t1XEG6o//lvS5OfSClVgmbgHlzDTWsMl5if75SmqfCh7s2RgNE3kMF4RV4
         Q0/G4Jhs6p01CG0GvCN31gHGJ+JidPw84Mh0RigtBxJ48Fk+fn3c3ECWWJgFiflHupgv
         ALRPgkgV1mmVUyaHD73e0Zoyaxz/FyPPlskQY/BN3pP8MH8zUQJ8Stym/RD6f14yQXDg
         DBjlDC1N7XheW6Z/hPnIhLVXSXsjTJ/VLNALkKka3UfG8bq/3rNwedSxuU20NKP8/E4Q
         OvGA==
X-Gm-Message-State: AOJu0YwLNapr4cSXHtBDYT+aNiCtvoof+Ubard8mA4vHBF9Lw9rCRMEm
	QmuOyVquLkZ6AhKycOmfp/1q9ly06tkHuJzHF/LZag==
X-Google-Smtp-Source: AGHT+IHKcYuqeFb/mTcEp+89My9A5o5DC0pPHMZ/0Mo4P/b66szo7CfzlcRIbubca3sB3z+pXUMRaKo1lev9HEbsqsQ=
X-Received: by 2002:a17:906:d8b7:b0:a18:e2b8:ff1b with SMTP id
 qc23-20020a170906d8b700b00a18e2b8ff1bmr3369726ejb.1.1702398634711; Tue, 12
 Dec 2023 08:30:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area> <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <20231212-impfung-linden-6f973f2ade19@brauner> <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>
 <20231212-neudefinition-hingucken-785061b73237@brauner> <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>
 <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>
 <20231212154302.uudmkumgjaz5jouw@moria.home.lan> <CAJfpegvOEZwZgcbAeivDA+X0qmfGGjOxdvq-xpGQjYuzAJxzkw@mail.gmail.com>
 <20231212160829.vybfdajncvugweiy@moria.home.lan>
In-Reply-To: <20231212160829.vybfdajncvugweiy@moria.home.lan>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Dec 2023 17:30:23 +0100
Message-ID: <CAJfpegvNVXoxn3gW9-38YfY5u0FLjXTCDxcv5OtS-p0=0ocQvg@mail.gmail.com>
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Dave Chinner <david@fromorbit.com>, NeilBrown <neilb@suse.de>, 
	Donald Buczek <buczek@molgen.mpg.de>, linux-bcachefs@vger.kernel.org, 
	Stefan Krueger <stefan.krueger@aei.mpg.de>, David Howells <dhowells@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Dec 2023 at 17:08, Kent Overstreet <kent.overstreet@linux.dev> wrote:

> In short, STATX_ATTR_INUM_NOT_UNIQUE is required to tell userspace when
> they _must_ do the new thing if they care about correctness; it provides
> a way to tell userspace what guarantees we're able to provide.

That flag would not help with improving userspace software.

What would help, if said software started using a unique identifier.
We already seem to have a unique ID in the form of file handles,
though some exotic filesystems might allow more than one fh to refer
to the same inode, so this still needs some looking into.

The big problem is that we can't do a lot about existing software, and
must keep trying to keep st_ino unique for the foreseeable future.

Thanks,
Miklos

