Return-Path: <linux-btrfs+bounces-6514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3278293389A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2024 10:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AFA1C227D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2024 08:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D0822625;
	Wed, 17 Jul 2024 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpondEZg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65774224FA
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2024 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203801; cv=none; b=kidlajpE7QubSxNNebj9DI7xr+4g46CAu8BzuuVjnqmxXH0Z46AHnAAlI+3+7c89xAeHwmgPN/GG42Dp5RiLDqjVhExTtdf13zsutzPCmOvkgC1Ll7FkdQxy0bVN0iDXRskLNs1uNZi9OFrmdJMTFmlcOW+WFFKRp30uRxNRf3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203801; c=relaxed/simple;
	bh=+8+Qki1FyYyGHgj0iBSlvf3Irj3dB+tvJ/NKMt1RUKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGs/+SsPwU2c3KG2uYuFJ0bn4FtZSe236QUUPitMdbTpVHKQv8bvXF28jnAs2XExm6t9UIHIVxl9crT1DhVsq/fhbbVcyNjNBQPc/oK8U8yoqiviLfuF6ccvdDK0vsDFQdd9mYhgFwVZDlEJmpcOyhuLJdf2rx+u5+BJXvoFHNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpondEZg; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79ef82c6344so376732885a.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2024 01:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721203799; x=1721808599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8+Qki1FyYyGHgj0iBSlvf3Irj3dB+tvJ/NKMt1RUKU=;
        b=dpondEZggCIFOdzRMosQowKlGK7F6DwdvQ7MV9kN74i1lMvBWTzipr51TjCO1ZHROX
         5vmAMYBH91G74xo03JoTapVPtVKe26nYYSlECru+AGPr52q3fHRXQVIYUxX2NO3C0cbv
         1ZVEJb8vOs+MiSuKkuly6k6QMWj7bcmtUWeLxhM0c5Nq1eQUiMH5ILIdNPTnbsVrWhJs
         ajp+NY9XKVUMuIXuz8X8BPqiW1ho1op3goDwb3c+yroVkVTQ4HbzHVaFLVXub+mpdcps
         QpVHJf0BZH7/aYoyqMh+SbpAXLNNNWlf057lR3fDPyVAni7lFjoNo3TtuNsa2qmk0U0c
         WpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721203799; x=1721808599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8+Qki1FyYyGHgj0iBSlvf3Irj3dB+tvJ/NKMt1RUKU=;
        b=WZ+rmwxUkjK4KL8RsyWhZ8AD+RQifxYSaYZ5NXRA0lykIqPe/pwStDm5e8qHa3fHzz
         gTSinfAonT98KKvc0Xgi2abBz5KXvwl534fSX+4k4wf/k+RoyZ0XxLJq7HyMNJSoQKHx
         1h8lFIAwA6P03Nvc2qAPlq2sQJXvnFHBwjigY8zkZ/CK6wOzXVu1mBS/CoiW8dSQ8aAZ
         vB38Xnza2mSqqoQMiAtUD4LMoT0c4bZWh5sbWzmg0Jhj+gCB8pZlNZgHC57zy+psvszv
         1wZHk6M6nDbff/P1s/OLySkdcP1lWf5rvkrTvuLk5fqTMXv2qj75jscfBPVMD+Gxf7ht
         EcAA==
X-Forwarded-Encrypted: i=1; AJvYcCXl1sF2LhWVbBpVZsu0TbziYBaaWtql471WTmF9I/zUKz6tc4b1BreWtEe6Fv6AVsKilFOe0dxG+Epeadq6GuPADDKHh2IWu6Sr6qo=
X-Gm-Message-State: AOJu0YzMO1IDAjXMY13GeOfGhJpqbz6hwfg7mrix6VSC7mitldvYI2PA
	n+3lWCQ3ERxkM1NsJRH2LaQ7UgVaMRAdwcTgaO4iU4wsuWFT3zACBHp6TMt9qoWxwz9cVGz1I6W
	Wne5EPU9OJXbxD0q7PMQotythIcM=
X-Google-Smtp-Source: AGHT+IGbv64cw6/y/we4TNFJFdGmWQYaaveshEPScW9iCxoFZXQHjsQh1K5K/AhChI2i6pOpzF6ZcI9UiqTKneaVZho=
X-Received: by 2002:a05:620a:bc6:b0:79f:4a8:df46 with SMTP id
 af79cd13be357-7a187513f05mr105705885a.69.1721203799078; Wed, 17 Jul 2024
 01:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=JywF+D1_h+JYxe=WKp-Q@mail.gmail.com>
 <0bedfc5f-4658-4d01-98b3-34bc14f736f3@gmx.com> <CAMthOuNk273pZUSU1Npr-Zx7LscBxOsXeyWcQCgbYP=82TfreA@mail.gmail.com>
 <d30126ba-a9fc-44ea-bba8-1f42b242ca91@suse.com> <CAMthOuMWvFWNEJkOWQiP2eNwWap8H4z7Gb6qzS8M-WkTUk2=Mw@mail.gmail.com>
 <1728bb6e-9dd0-4a2c-be16-41cd01231484@gmx.com> <CAMthOuNqaKoJGYWNDdV33hWkG1oa77vuEt0gxxYVbW+KNrtnaw@mail.gmail.com>
 <71256c6e-c584-48e8-bce6-c04aff0d0496@gmx.com> <CAMthOuN_wo0AYZw3DNP2NXALrXTt9YArpeXh+0Vza_XLNCxfKg@mail.gmail.com>
 <ac00e986-922c-4b57-b0a4-31e21b928313@gmx.com>
In-Reply-To: <ac00e986-922c-4b57-b0a4-31e21b928313@gmx.com>
From: Kai Krakow <hurikhan77@gmail.com>
Date: Wed, 17 Jul 2024 10:09:32 +0200
Message-ID: <CAMthOuOCKT9vYg_3czYKWk4sgxSVf2phis+AOpxhdvyEFVTmOQ@mail.gmail.com>
Subject: Re: btrfs crashes during routine btrfs-balance-least-used
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mi., 17. Juli 2024 um 00:18 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.co=
m>:
>
> =E5=9C=A8 2024/7/16 22:55, Kai Krakow =E5=86=99=E9=81=93:
> > Hello Qu!
> >
> > Am Di., 16. Juli 2024 um 11:09 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gm=
x.com>:
> [...]
> >
> > Yes, they apply. Thanks. I will be testing this first on two different
> > machines before applying to the server.
>
> I doubt if you will hit anything like that again.

Yes, but it's not about that. It's to see if there are no other
side-effects before pushing it to production. I don't expect any
side-effects, tho.


> Even if there is some hidden cause of memory corruption, it may not hit
> extent tree again.
>
> But at least enhanced sanity checks are always a good thing.
>
> >
> > Also, I wanted to update you about the VM host environment, I got
> > replies from our datacenter operator:
> >
> > * 2 x Intel Xeon E5-2680 V4, 2.4Ghz 14-Core 35MB 9.8GT 2400Mhz HT&TB
> > * 16 x 64 GB, ECC reg. DDR4-2400 LRDIMM
> > - this hardware exists twice and VMs can be migrated
> >
> > The qemu host process of our VM has been up since May, 26th 2024. This
> > is when we did a shut down to attach a third btrfs pool disk to the
> > system. No VM migration has been done since then, and there probably
> > hasn't been a migration before for at least one year. Our operator
> > says it has probably never been migrated since it has been taken into
> > production. So, a VM migration before May 26th is unlikely but not
> > impossible, and there has been no migration since May, 26th.
> >
> > And some other observations:
> >
> > Also, while the issue existed, I could mount the FS fine in ro mode
> > and copy data (I've did a full borg backup, it only reads changed
> > files). But if I mounted rw, it would take anything from 2 min to 30
> > min before the kernel complained again, even if the FS was completely
> > idle. I cancelled the previous (failed by crashing) balance job before
> > doing anything else with the FS.
>
> The problem of that specific corruption is (despite the mysterious
> reason), it won't be detected until that offending data extent at
> 402811572224 got some updates.
>
> And if the updates on that extent doesn't touch the corrupted entry it
> will still be fine.
>
> So the corruption can exist for quite some time, until triggered recently=
.
>
> At least the generation when the data extent is created is not that new,
> the latest generation is 3933860, meanwhile the generation of that
> extent is 3678544, and considering the indirect ref should always be the
> first to be created, I guess the corruption is there for a while.
>
> With the new tree-checker, your scrub routine should be able to catch
> any similar existing problems now.
>
> Thanks,
> Qu
>
> >
> > Not sure if anything matters for your analysis in the afterthought,
> > just wanted to update you.
> >
> >
> >> Meanwhile the missing commit looks like a good candidate for stable 6.=
6
> >> branch, I can definitely send it to stable later.
> >>
> >> Thanks,
> >> Qu
> >
> > Thanks,
> > Kai

