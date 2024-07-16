Return-Path: <linux-btrfs+bounces-6504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFBD932762
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 15:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526521C21FF1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DAF19AD6B;
	Tue, 16 Jul 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EB27mymI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F9A17CA05
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136333; cv=none; b=bhH1/dpYayI3YnT5wb6snNV0jJgf9K9g/2jzw4HBF5DH9jJ8clEDHWwpzTQyI1QOxGG3H2TnFLclZuBhiscjvsjTVxzXcHKqPkDnwnYm06pPy2MdQ5OZG58WiEjwrvg7zD19fsDSdPPp7qn1TJwXFa/OTibYMUneAWsR6Sy3eBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136333; c=relaxed/simple;
	bh=mCPPr3m8npabtsKXs1hFWGFoLkYb0WNJjgyqRrFMeFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLt6tl/mOcv2bWE8FHoxU+ZyvPyiovLfSlYOuccAZ7HXWufEp5IjxgzJylVciCxzq12+gfZyyVV/KZJ7hRkMGh2o8vVUkpihXC6deaslcTXySHIIeRTuhYcMRjK7PhG4N3pIsFS5vaxETSFykSEvIn7WI0QnZp3GQnqsvzG060Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EB27mymI; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-79ef7ecc7d4so337308985a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721136330; x=1721741130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCPPr3m8npabtsKXs1hFWGFoLkYb0WNJjgyqRrFMeFY=;
        b=EB27mymI8WDMJP+Sz9So8TkR2lk7JjgO1WkITHAVnUVnyRxlkDW3uWwsDwHKZZIrV+
         aY7eZ2xYJQyIAC71bsAVIkjBVuwWoDssENfJJqNCiYXwiuofUcHvXDUGrevsDkoSfNI/
         d1xVi7mu/uc0tZoAG6tyVcjApFHb8wBgZbaUnlQoiV+8oCk3kUotVyvWxarUF/MSrW+d
         DLVB6bMtXF7fkEBTr165fz/mnaazJ6DuJHbp7Bti+eNGCjiutKSQUZBdlBZtz3EMp/IB
         UA6Pw3IIlT9lsPlMf6z7OEAx9YTtW8sH18qg1yGWwzjlNbs58GGRG731WNNZ/9R+ADLX
         Hf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136330; x=1721741130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCPPr3m8npabtsKXs1hFWGFoLkYb0WNJjgyqRrFMeFY=;
        b=e03ScUa0pm4Y2/aLXRbYwdQdf4hMPwEADNBX/YGipADjbLGwf1y3WqUMntyKm2hzwP
         3pfK3uMnx/Pglkqk2LhJKR0JTqGDFGoRCo3hQ0oF74dcok+JnkV5lKuFSNnfTZNXQ+sX
         ZptrCUbNS2GMtovukStUbrpu1GNMan/JvgAsJe8S0OciqGm5mIpxwlcK/eGfTqJZGtfd
         rKd2oFYReXTKXrQaJmm7iIVlB3Fvqzy53Dg7YLtZEtjJB/Zt69Nm+pjbU7tHjTV10ZZ/
         TmBQTyA6u5vOpk9w9kvtGBNSWyIF1SJnXihP0qzawmxaqAtmLGRPwEsm/iIpAwRL9ZxU
         3AjA==
X-Forwarded-Encrypted: i=1; AJvYcCUzn9FvTASCYKhK4X4RBqJgX1/bGLwiNN66TllR5E5i929KKL+jQoiCyXbxlXCGoH6y958V3OTbybepbLNt1F7wvCeOzt/9ja8kXj0=
X-Gm-Message-State: AOJu0YxJQfC8faChPu5ImbwlMdHVZZxPC+xia8RVmpcNBXB79MGO32B2
	x1e284VpOzleU6XqDye6EJs3mndoFUDLzd0FvNNzZT/FBLBaSPEUsBcxtHRxBk0mPxwDXE444Gb
	8lf8JycsZDkiW/IW4OJIrsQk/bUInRIs5
X-Google-Smtp-Source: AGHT+IF1uSPNXVYkapPcdAMDsOuBCfEPvncCt6kkgCZJPILDZpCn9UE5rpi5g5KTHQ+fjrwnSGXF/WfAgBil1joSX5I=
X-Received: by 2002:a05:620a:4041:b0:79e:f878:2654 with SMTP id
 af79cd13be357-7a17b70121bmr226748685a.41.1721136330028; Tue, 16 Jul 2024
 06:25:30 -0700 (PDT)
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
 <71256c6e-c584-48e8-bce6-c04aff0d0496@gmx.com>
In-Reply-To: <71256c6e-c584-48e8-bce6-c04aff0d0496@gmx.com>
From: Kai Krakow <hurikhan77@gmail.com>
Date: Tue, 16 Jul 2024 15:25:03 +0200
Message-ID: <CAMthOuN_wo0AYZw3DNP2NXALrXTt9YArpeXh+0Vza_XLNCxfKg@mail.gmail.com>
Subject: Re: btrfs crashes during routine btrfs-balance-least-used
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Qu!

Am Di., 16. Juli 2024 um 11:09 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.co=
m>:
>
> =E5=9C=A8 2024/7/16 16:21, Kai Krakow =E5=86=99=E9=81=93:
> > Hello Qu!
> >
> >[...]
> >>
> >> And we're also enhancing our handling on bad hardwares (except when th=
ey
> >> cheat on FLUSH), the biggest example is tree-checker.
> >>
> >> But I really run out of ideas for such a huge corruption.
> >> Your setup really rules out almost everything, from out-of-tree (Nv*di=
a
> >> drivers) to bad hot memory migration implementation.
> >>
> >> I'll let you know when the new tree-checker patch come out, and
> >> hopefully it can catch the root cause.
> >
> > I've got your patch from linux-btrfs git (which you've sent to the
> > list yesterday). It looks like this cannot be applied to 6.6 LTS. Is
> > it part of a larger patch series and will be backported?
> >
> > Is it safe to just cherry pick all patches saying "tree-checker" to
> > the 6.6 tree?
>
> The conflicts are caused by the missing commit 1645c283a87c ("btrfs:
> tree-checker: add type and sequence check for inline backrefs") and a
> cleanup patch.
>
> So I manually backported those two patches, just give them a try.

Yes, they apply. Thanks. I will be testing this first on two different
machines before applying to the server.

Also, I wanted to update you about the VM host environment, I got
replies from our datacenter operator:

* 2 x Intel Xeon E5-2680 V4, 2.4Ghz 14-Core 35MB 9.8GT 2400Mhz HT&TB
* 16 x 64 GB, ECC reg. DDR4-2400 LRDIMM
- this hardware exists twice and VMs can be migrated

The qemu host process of our VM has been up since May, 26th 2024. This
is when we did a shut down to attach a third btrfs pool disk to the
system. No VM migration has been done since then, and there probably
hasn't been a migration before for at least one year. Our operator
says it has probably never been migrated since it has been taken into
production. So, a VM migration before May 26th is unlikely but not
impossible, and there has been no migration since May, 26th.

And some other observations:

Also, while the issue existed, I could mount the FS fine in ro mode
and copy data (I've did a full borg backup, it only reads changed
files). But if I mounted rw, it would take anything from 2 min to 30
min before the kernel complained again, even if the FS was completely
idle. I cancelled the previous (failed by crashing) balance job before
doing anything else with the FS.

Not sure if anything matters for your analysis in the afterthought,
just wanted to update you.


> Meanwhile the missing commit looks like a good candidate for stable 6.6
> branch, I can definitely send it to stable later.
>
> Thanks,
> Qu

Thanks,
Kai

