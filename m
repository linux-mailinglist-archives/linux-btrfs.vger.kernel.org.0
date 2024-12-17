Return-Path: <linux-btrfs+bounces-10450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4029F4350
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 07:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E061889A08
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 06:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAB0156C76;
	Tue, 17 Dec 2024 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFzhuc91"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C1F18E20
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734415863; cv=none; b=byutvayn2cckATKB37+FaXti+gywqgb8tg3Cwc/IeizU+SL03SMcUQv+aylzR2OdyF6nDbip8US7SkTg6PBdjqUevgR2Ynl0+wqRnOF8DriygKqBjWgM+Iy0L6NEafgtu0yhHx0AHtMEGwwetAu+i0TY1F96xlQqPPOLEg7lqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734415863; c=relaxed/simple;
	bh=zDx5d5ogiG+TCS92zLjsbZ5W7BEOx0wUAQitsxY6WOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lc1W49WkiNZWAyuuaJJwOtt7k02BLkXvnz7kkm9Ot0JPvBiQQ98TocmqNSFTIgIlFesoHOXDR7rvsbigiz7YMa/YfWv/oWzZ6xrcygl+ewwI/2f6wMDQZJr4GB9a8WmR1fFePEfZtk4XD9niRVF7TFStV0tITRqZxytPG0Vg9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFzhuc91; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30229d5b21cso43704441fa.1
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 22:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734415858; x=1735020658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awre10K9N6cVGDNhUaq4i5NBc0EHmWK6YPHGHwhyVMw=;
        b=TFzhuc91WuWNnCW2Hmjqj41dESyIqyliFVFyAOyOE5VIA+wx/0A2UqjXuVYtal3JFL
         8Y9g9n6LEsWtYYqw3P0HjBIdhSW8/hls34o9v+LUED3YcQYpccywRGsMQI372s8cQnzb
         BENu7OWOLbXjZiZg+lM++zFMDwCgAUqX2CNhtvxjM/10Vx4BBLkJpxENUE7gYtj7u+UK
         YZG70nhaaESK6GL53wKW6KWX67ox/NuKgPIXPzPV7mwMJPAP2jT3u/6EVLWPXE1qQqDs
         BcEg0DFTPqoDHGtraPL5EBRy7c10QBtBnxJomRfJw6NX84j+NtsR+TSbWiaT1pG8uU8z
         51zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734415858; x=1735020658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Awre10K9N6cVGDNhUaq4i5NBc0EHmWK6YPHGHwhyVMw=;
        b=VhcaACqcL5qMjcAYcuRca4aSki9mrYs81UbLMVl6DxcP0Q82F6mdSaaXmEQRRvM5dX
         D9p7p81PEC8l411caGNh7kchgCGCrVyotsRc0D9eT59oreCi1Ewer1Odxm9Uc+jSbYbC
         qhyEeGXmN5/IcswTh9tZnitnD5N5GH658ZLz/7cmGikodYfdxnTYBG+FZPhduTSsjfHU
         X6RZELkJph3W9d/yIw/ddqD5VFl5A3pN1zCwbSn+PxlNlFK1qpBtg9x0n17Zln5/W5rO
         vB/J/FbtKvImvUC9XeYK8Wku9rBxEKabmuKpyKyJpIAfMzKteVkmB4X0zBDSTtdgCNTH
         D2kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo6/hBzkpX3ng8o+xxJRUzZgiCieQl09kzQ5QQqzHIFRtvXMFuNvdoZkDU47vFGXjW9K0CAn6B45JS6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxgfoSlfj+imQM1D1MzH7DJAOdYTyRGpx89xFnTRuyaPbRIrj0
	0RtYdU01nkdLzDq1MG0HjUBWuJHBF7KfR2YF+YnvpWekz7NK6pgGr3ZUWI22H/t0qK5Lmf7dqFf
	LfkOMqcnZoRkHLHAuLlv8gvMKi7Q=
X-Gm-Gg: ASbGncvjc1ssMra6gfjML5tpNBqHJH2rIgil1ZjjwHj6VYc+ZUTHnoGOIRdlMIzdz5A
	Lic6lO8ZlB5OwsPqft14q+8Ppjfi6rDkt+DTzqOM=
X-Google-Smtp-Source: AGHT+IGZM8T9yo905+svoPfKWGTANySJT1DFk/HP8cJBxvLcO6+mlAPoEYkf8Lerq8PZWIA35ZuFBv0ktmKk8UqSy3w=
X-Received: by 2002:a2e:9f13:0:b0:300:38ff:f8de with SMTP id
 38308e7fff4ca-3025444ae89mr39697011fa.16.1734415858307; Mon, 16 Dec 2024
 22:10:58 -0800 (PST)
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
 <CADhu7iD+kKsvxZtnX9q94tuJzS6z=zs3B7Xc9Bb4G+mnQ6_UhQ@mail.gmail.com> <2e3d5a0b-4cc5-48e7-80a6-7cc5454d54e3@suse.com>
In-Reply-To: <2e3d5a0b-4cc5-48e7-80a6-7cc5454d54e3@suse.com>
From: j4nn <j4nn.xda@gmail.com>
Date: Tue, 17 Dec 2024 07:10:47 +0100
Message-ID: <CADhu7iDkie++6DhJD7e1Ce2LqeS57VnOhX-fDAhPFXJ13yyPpw@mail.gmail.com>
Subject: Re: clear space cache v1 fails with Unable to find block group for 0
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Dec 2024 at 06:50, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2024/12/17 16:01, j4nn =E5=86=99=E9=81=93:
> > On Mon, 16 Dec 2024 at 19:52, j4nn <j4nn.xda@gmail.com> wrote:
> >>
> >> This is unrelated, but as you have been interested in the hung task
> >> backtrace, I got two more when using "btrfs send ... | btrfs receive
> >> ..." to copy 7TB of data from one btrfs disk to another one (still in
> >> progress, both rotational hard drives):
> >> [81837.347137] INFO: task btrfs-transacti:29385 blocked for more than
> >> 122 seconds.
> >> [81837.347144]       Tainted: G        W  O       6.12.3-gentoo-x86_64=
 #1
> >> [81837.347147] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >> disables this message.
> >> [81837.347149] task:btrfs-transacti state:D stack:0     pid:29385
> >> tgid:29385 ppid:2      flags:0x00004000
> >> [81837.347154] Call Trace:
> >> [81837.347156]  <TASK>
> >> [81837.347161]  __schedule+0x3f0/0xbd0
> >> [81837.347170]  schedule+0x27/0xf0
> >> [81837.347174]  io_schedule+0x46/0x70
> >> [81837.347177]  folio_wait_bit_common+0x123/0x340
> >> [81837.347184]  ? __pfx_wake_page_function+0x10/0x10
> >> [81837.347189]  folio_wait_writeback+0x2b/0x80
> >> [81837.347193]  __filemap_fdatawait_range+0x7d/0xd0
> >> [81837.347201]  filemap_fdatawait_range+0x12/0x20
> >> [81837.347206]  __btrfs_wait_marked_extents.isra.0+0xb8/0xf0 [btrfs]
>
> This is from the metadata writeback.
>
> My guess is, since you're transfering a lot of data, the metadata also
> go very large very fast.
>
> And the default commit interval is 30s, and considering your hardware,
> your hardware memory may also be pretty large (at least 32G I believe?).
>
> That means we can have several giga bytes of metadata waiting to be
> written back.
>
> What makes things worse may be the fact that, metadata writeback
> nowadays are always in nodesize, no merging at all.
>
> Furthermore since your storage device is HDD, the low IOPS performance
> is making it even worse.
>
>
> Combining all those things together, we're writing several giga bytes of
> metadata, all in 16K nodesize no merging, resulting a very bad write
> performance on rotating disks...
>
> IIRC there are some ways to limit how many bytes can be utilized by page
> cache (btrfs metadata is also utilizing page cache), thus it may improve
> the situation by not writing too much metadata in one go.
>
> [...]
> >
> > The destination btrfs filesystem has been freshly created (single
> > device, no raid) and thus empty before starting the transfer.
> > This is output of destination 'btrfs filesystem df' after the transfer:
> > Data, single: total=3D7.10TiB, used=3D7.06TiB
> > System, DUP: total=3D8.00MiB, used=3D768.00KiB
> > Metadata, DUP: total=3D8.00GiB, used=3D7.53GiB
> > GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> >
> > The btrfs is on a luks device (cryptsetup -h sha512 -c aes-xts-plain64
> > -s 256), but cpu has been idle the whole time (ryzen 5950x).
>
>
> Considering the transfer finished, and you can unmount the fs, it should
> really be a false alert, mind to share how large your RAM is?
> 32G or even 64G?

Yes, you are right, using both :-)
That is 96GB of RAM...

Thank you for the explanations, particularly the "16K nodesize no
merging" metadata chunks.
The reported 'time' of the transfer included a 'sync' command after
the btrfs receive.

