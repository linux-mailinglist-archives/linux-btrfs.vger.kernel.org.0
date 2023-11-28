Return-Path: <linux-btrfs+bounces-425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F35E7FC7E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4CA1C20E4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BDE44C67;
	Tue, 28 Nov 2023 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0173A84
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 13:25:08 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c72e275d96so80218891fa.2
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 13:25:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701206705; x=1701811505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmxS5DBFoTg5GQNf3Vd7mws9a9zrp/m1jCwPRvpR82Q=;
        b=qwWgmCgnRLxRlLggyalCZ/6OyQC+bKGk8/02kxMkrJPa5YHbGg6tXcf0Qa3kANyYA4
         8yWAEy9cpCFH2OeI8XySllQV1GxJEHa/T/xTS+H4/o/Z90YpxMRPy5LXmErzknw0DUD7
         n3iJR4CvqBE6Vi+F6OCAJlJYxCxkZGAEHSNIe8WIN8GZoxcNopcdYMgfHzBHbR74Wl3k
         Y4D1yNdw+ivVvbOIQSK5/pIcHlNWkC5hCjTTNHEulfi2qWD80tlY1upHVf4ZaYHJjpyy
         msTsogqpFommsYuQPFF3x0d1LXhYY/xQ18/S/4GYl5pOSu+9EFLApLZwqxPWxMFt3Z2S
         gujA==
X-Gm-Message-State: AOJu0YwNBSzpQnzUJMqPbSjZ3T3Uva6PAv3Zk9RucKWTCGOP4qt2EAPU
	NaYwn/gxMmxixrVG2u7N1QGqj8392I3hai3X
X-Google-Smtp-Source: AGHT+IFK9ZYuG4+pMgTmDeGndOwBe0/Jv2TVOMF0ggrb8GhKsxtjVpJr7k2KrbM1MB9/4C9tJcPOiA==
X-Received: by 2002:a2e:b5b6:0:b0:2c9:9a20:f496 with SMTP id f22-20020a2eb5b6000000b002c99a20f496mr6651864ljn.29.1701206705265;
        Tue, 28 Nov 2023 13:25:05 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906191200b009e6cedc8bf5sm7166765eje.29.2023.11.28.13.25.04
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 13:25:04 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54a945861c6so8299756a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 13:25:04 -0800 (PST)
X-Received: by 2002:a17:906:209c:b0:a12:231f:65d with SMTP id
 28-20020a170906209c00b00a12231f065dmr3886214ejq.48.1701206704110; Tue, 28 Nov
 2023 13:25:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116160235.2708131-1-neal@gompa.dev> <20231127160705.GC2366036@perftesting>
 <fb78d997-cb99-4b98-8042-bdcdbff22b88@marcan.st> <f229058e-4f5d-4bd0-9016-41b133688443@suse.com>
In-Reply-To: <f229058e-4f5d-4bd0-9016-41b133688443@suse.com>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 28 Nov 2023 16:24:27 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8r0K0k8UMcAafxXyrNuxJrxJbGhkwvo10pUw+rxhCa8g@mail.gmail.com>
Message-ID: <CAEg-Je8r0K0k8UMcAafxXyrNuxJrxJbGhkwvo10pUw+rxhCa8g@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] Enforce 4k sectorize by default for mkfs
To: Qu Wenruo <wqu@suse.com>
Cc: Hector Martin <marcan@marcan.st>, Josef Bacik <josef@toxicpanda.com>, 
	Linux BTRFS Development <linux-btrfs@vger.kernel.org>, Anand Jain <anand.jain@oracle.com>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.cz>, 
	Sven Peter <sven@svenpeter.dev>, Davide Cavalca <davide@cavalca.name>, Jens Axboe <axboe@fb.com>, 
	Asahi Lina <lina@asahilina.net>, Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 2:57=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2023/11/29 01:31, Hector Martin wrote:
> >
> >
> > On 2023/11/28 1:07, Josef Bacik wrote:
> >> On Thu, Nov 16, 2023 at 11:02:23AM -0500, Neal Gompa wrote:
> >>> The Fedora Asahi SIG[0] is working on bringing up support for
> >>> Apple Silicon Macintosh computers through the Fedora Asahi Remix[1].
> >>>
> >>> Apple Silicon Macs are unusual in that they currently require 16k
> >>> page sizes, which means that the current default for mkfs.btrfs(8)
> >>> makes a filesystem that is unreadable on x86 PCs and most other ARM
> >>> PCs.
> >>>
> >>> This is now even more of a problem within Apple Silicon Macs as it is=
 now
> >>> possible to nest 4K Fedora Linux VMs on 16K Fedora Asahi Remix machin=
es to
> >>> enable performant x86 emulation[2] and the host storage needs to be c=
ompatible
> >>> for both environments.
> >>>
> >>> Thus, I'd like to see us finally make the switchover to 4k sectorsize
> >>> for new filesystems by default, regardless of page size.
> >>>
> >>> The initial test run by Hector Martin[3] at request of Qu Wenruo
> >>> looked promising[4], and we've been running with this behavior on
> >>> Fedora Linux since Fedora Linux 36 (at around 6.2) with no issues.
> >>>
> >>
> >> This is a good change and well documented.  This isn't being ignored, =
it's just
> >> a policy change that we have to be conservative about considering.  We=
 only in
> >> the last 3 months have added a Apple Silicon machine to our testing
> >> infrastructure (running Fedora Asahi fwiw) to make sure we're getting =
consistent
> >> subpage-blocksize testing.  Generally speaking it's been fine, we've f=
ixed a few
> >> things and haven't broken anything, but it's still comes with some ris=
ks when
> >> compared to the default of using the pagesize.
> >>
> >> We will continue to discuss this amongst ourselves and figure out what=
 we think
> >> would be a reasonable timeframe to make this switch and let you know w=
hat we're
> >> thinking ASAP.  Thanks,
> >
> > Reminder that the Raspberry Pi 5 is also shipping with 16K pages by
> > default now. The clock is ticking for an ever-growing stream of people
> > upset that they can't mount/data-rescue/etc their rPi5 NAS disks from a=
n
> > x86 machine ;)
>
> As long as they are using 5.15+ kernel, they should be able to mount and
> use their RPI NAS with disks from x86 machines.
>
> The change is only for the default mkfs options.
>

Right, and the thing is, it's fairly common for the disks to be
formatted from a Raspberry Pi. So until some kind of support for using
any sector size on any architecture regardless of page size lands,
this is going to be a big problem.



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

