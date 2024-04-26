Return-Path: <linux-btrfs+bounces-4562-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A198B428B
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Apr 2024 01:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C611C21BA7
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 23:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45A3B781;
	Fri, 26 Apr 2024 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="WEojP0mB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254513839C
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Apr 2024 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173247; cv=none; b=JHZoQv61qtx6DV3phiJ5LFOj1C7kLcP1+NLJLlhqsJP8dN3/DO/enOQLgFox+taUfMrXBklpN8mOqZP9lS/+c3Yxw8W9/5RBYeq8NvMI4WqijRof45VFQCXy7U/MM6Ed3yR+m92JupIWkwqYzzy5mxl9geAXyXX2NYV1AuPjUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173247; c=relaxed/simple;
	bh=Lka0BQxzVmU2VRnnK9kwU9yWThtJ3vTzXyoA5468Zo0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ot0SSJMMZpQ9/VqVsy7stZYnNiQwvJ3mh8CqUp7VxT1ay5gpslFAbFBpUzpgqPqiqmYCEoANqNrnmrIKyLvUX+Coacmh6UTOMlRmcDy3j/mvz+lQ8VnQ+2UWiVEM+IDOw4AUSUqYyicMsA0BWVWCKlpihb4dkUZKURW6HDzBJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=WEojP0mB; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5176f217b7bso4595127e87.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Apr 2024 16:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1714173243; x=1714778043; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lka0BQxzVmU2VRnnK9kwU9yWThtJ3vTzXyoA5468Zo0=;
        b=WEojP0mBDh7jMcUb0KjIHDo+Av2f7GWP+J60zupogdmJtZzUzjhEzXX493ZLhtmVUp
         ovO8TsM4wvFa4cO7YX3BfVsreF4CZva+x4v1DCP/KdHhQNdRQLbOdtmKA27EU6/sN+pP
         DZ7C79XtG2y1EnS3xBrRfU7hErvcsks2omJgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714173243; x=1714778043;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lka0BQxzVmU2VRnnK9kwU9yWThtJ3vTzXyoA5468Zo0=;
        b=AqsFhXHfjldLrribg6F0zgNFuA1z249RD7FjeO5pRwY+PAG5DDjkpQXV6TQDiy9DUX
         ZLCs14pisJ/46MSjEeQmBc4D5tY/EfTnG47rS74UMcrcpkINuVsjBBI1PjFJcHPGx0eh
         xv/hkurwXWD3HnVKBWTrcLxemm2o2n5xKeEvl5svboFxXhz0rs8RmqEffTVnLmI/t35N
         1/oH3YCNQ9drhJskAeJCWCWse4HiS81fJx1J8pVTbhmWxhE6+lqwQtNH7GFnSoW14TBj
         FfJPkZo+TMOT8caKIOjiQ1jTm1xqragiwtBkUYSMXkFRYkNQhPnGZz1jfpVplpN7+cmi
         TOkA==
X-Forwarded-Encrypted: i=1; AJvYcCW504OrfHqcro6SA2tr/27fzH+kRAdJY0SP9wNwTo/isaJlicX3NO0HBiCLcUc2Cqrdi6K1U1GGGaI3j17ANdrQ+uHyYg3AgJT/4HA=
X-Gm-Message-State: AOJu0YzH9dU1c9+ATYdIZSGOkxaZ3PoiLH786fhFwmRv276vLctg2KO9
	EzicPZ69RvQiRdlqMgLiaM0bCpbFaJP+ZvD8si4RfePh3fxPXDxsoD3xARIBPAb2KPrY8auJMlw
	G42c=
X-Google-Smtp-Source: AGHT+IFfTgF53iEwoGDTPPyTnXQh/dfVy11NUA8DuZiYRrE8jpnW6QGKLVFUxBjYyfbS+k1rR+IPTA==
X-Received: by 2002:a19:ca54:0:b0:516:d09b:cbe4 with SMTP id h20-20020a19ca54000000b00516d09bcbe4mr3295981lfj.53.1714173243065;
        Fri, 26 Apr 2024 16:14:03 -0700 (PDT)
Received: from able.exile.i.intelfx.name ([109.172.181.47])
        by smtp.gmail.com with ESMTPSA id r18-20020a17090638d200b00a589ce6803asm3191195ejd.110.2024.04.26.16.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 16:14:02 -0700 (PDT)
Message-ID: <c8bac058c40b15a242d4598172d6a89c2f97608b.camel@intelfx.name>
Subject: Re: What's the difference between `btrfs sub del -c` and `btrfs fi
 sync`?
From: intelfx@intelfx.name
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date: Sat, 27 Apr 2024 01:14:01 +0200
In-Reply-To: <71f2d380-9b11-4ed5-949c-0edc1ed56c60@gmx.com>
References: <63a537d0467f3bb7683bd412c25c006f8d092ced.camel@intelfx.name>
	 <71f2d380-9b11-4ed5-949c-0edc1ed56c60@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 2024-04-27 at 08:36 +0930, Qu Wenruo wrote:
>=20
> =E5=9C=A8 2024/4/27 08:22, intelfx@intelfx.name =E5=86=99=E9=81=93:
> > Hi,
> >=20
> > I've been trying to read btrfs-progs code to understand btrfs ioctls
> > and one thing evades my understanding.
> >=20
> > A `btrfs subvolume delete --commit-{after,each}` operation involves
> > issuing two ioctls at the commit time: BTRFS_IOC_START_SYNC immediately
> > followed by BTRFS_IOC_WAIT_SYNC. Notably, the relevant comment says
> > "<...> issue SYNC ioctl <...>" and the function that encapsulates the
> > two ioctls is called `wait_for_commit()`.
> >=20
> > On the other hand, a `btrfs filesystem sync` operation involves issuing
> > just one ioctl, BTRFS_IOC_SYNC (encapsulated in a function called
> > `btrfs_util_sync_fd()`).
> >=20
> > I tried to look at the kernel code for the three ioctls but to my
> > untrained eye, they look like they are doing different things with
> > different side effects.
> >=20
> > What is the difference, and why is it needed (i.e. why are there two
> > sets of sync-related ioctls)?
>=20
> IIRC --commit-after/each only commit the current transaction, and it's
> just doing the same `btrfs fi sync` after all/each subvolume deletion.
>=20
> The reason is to ensure the unlinking (not fully deleting) of the target
> subvolume fully committed to disk, so a sudden powerloss after the
> deletion won't lead to the re-appearing of the target subvolume(s)
>=20
>=20
> However there is a another behavior involved, `btrfs subvolume sync`,
> which is to wait for a deleted subvolume to be fully dropped.
> In the case of btrfs subvolume deletion, it can be a heavy load, thus
> btrfs only unlink the to-be-deleted subvolume, and mark it for
> background deletion.
> `btrfs subvolume sync` would wait for any such orphan subvolume to be
> deleted.
>=20
> Thanks,
> Qu
>=20
>=20
> >=20
> > Cheers,

Thanks for the fast reply!

Yes, I'm aware about `btrfs sub sync`. I understand that's a totally
different operation.

What I was asking about was specifically the difference between
`btrfs _filesystem_ sync` and the operation that happens at the end of
a `btrfs subvolume delete --commit-after`.

Or, in kernel terms: what exactly is the difference between issuing a
BTRFS_IOC_SYNC and issuing a BTRFS_IOC_START_SYNC immediately followed
by a BTRFS_IOC_WAIT_SYNC?

It is not immediately obvious that the kernel code for the three ioctls
is equivalent (even if it is). For instance, BTRFS_IOC_SYNC begins with
a call to btrfs_start_delalloc_roots() whereas BTRFS_IOC_START_SYNC
begins with a call to btrfs_orphan_cleanup(), and the subsequent
transaction handling code seems subtly different.

--=20
Ivan Shapovalov / intelfx /

