Return-Path: <linux-btrfs+bounces-19360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D208DC89DD5
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 13:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3ECC4E2B6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 12:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FCF328B52;
	Wed, 26 Nov 2025 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLWu8TKE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E252DCBF2
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Nov 2025 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764161495; cv=none; b=RkMwgLlZidSkaxwGmdxMO3HIuT0jGsC1zjK8E/CP5x/hlHOPb5Z28bZdG//ICPZlWz2Med98gz+GBoMFR+AMBOm1QJF5tk+SXG6p/yLIRRtd/qA4nvvvkGcp4DAlN3k++yv/xrARHYX1EVfmDmvV1FScizllSJArvhiMd89J2yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764161495; c=relaxed/simple;
	bh=+yhdGxDT8/FxwW8mMSJ4ztUo9kxr7Tbq3tBd5Rjb3FA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4z1vU+JSVWe7wHWsIAFyoaPcSQA6vDO4QtRXZXM/2i+4Az7fH3b2nfST+VRO2fY3iqHs+G5BabbHJVB1KTKqcfw1vE9vdCfvz5wHkoy1frPknYRQBnv0IwOFKOzQrXUwtUxX1bP+QyX4+bxTRYD/XAvSp+kwr9OavmWeSeka80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLWu8TKE; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-949031532f9so40240039f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Nov 2025 04:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764161493; x=1764766293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IftgS+SqRiORt75QLzOlSBI34TvyfdYZdE/tNo4H79o=;
        b=nLWu8TKExr5DkegN5p0HKUvHPQib7fD6icWwLvuJ/UN7HWFJ/0iKbdItq5887NQJYK
         LppJjd43ayGwjBItd6CUCsn2yqQGhzsWFdV+GqgxrFqsQi7OcZF+kSBCDE/KxHxNbsS1
         GIqaTketoNw6hkZVOH1fRkrOWjr6UrbZacr54Q8sI15bWYDsx2I8L9mdthI5cG+btzDX
         nj0ffmElUuYGNSObzpEoZTDLCoNnsnEHv3RRY+zcrPdFh25/55RfotViVlfDIfYXsnuk
         Vg362xi9aB+IVh7lDs5kx/VaG6B8mdMXhKarBOHYZ2Yqze9baBjaTFXvfWRNq+18lb8c
         YSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764161493; x=1764766293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IftgS+SqRiORt75QLzOlSBI34TvyfdYZdE/tNo4H79o=;
        b=k2Y3bzUAfXM4bRqqI5Sb3E2YuW6M0+68We4JoF/yYmOVG3JHLi1m9YsEs0Jehcxyol
         haN5xBn966/yDS4YpC7TSqB1KESdZxSZyJrLDciMznufUTpbKS57xOpp3c0XYfy3aDUM
         YrRPSbconiEZCyxqy1qcaOLSInB0UZ8fAX0ox6DL77tmUcOqx5C5tIftFk5ZPwwqWzPQ
         NkVa4Sj60TpMSpzjOHSAIldmLZqt0div6pmeMkaHxObcExL0TO+TUfr5s944oFpBe4sL
         Cl6QNZNzpJphNyP4BD6uFux/CJbQSnN1fGEi1IBiyNg89jCbZQIgvskQFQ7ke0gyKb5B
         EZjw==
X-Forwarded-Encrypted: i=1; AJvYcCWfEt7nuZQrLwPn/A29qt6nxu1HzhXT3+cC7DXw7KT/xz/piioI2lliqq3VYlG3DDAo6Ek/y4m3xaQCng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwveadmXRiD0IISNHcIPM/D2zzBiUMWmGS5+C6TZghVe7LgXTHZ
	K87LyPtLbQLVTJu5EnpwzCCVJYnpct0HxJucgnOtHoqGY9pMv6fzL3wqWzd4WS1WB2FNdAyLWXt
	g4lRwKfv4xYmTZ/9fLQWONW6UetXch/A=
X-Gm-Gg: ASbGncvVXmTM3FHHyfRlwqqaNFnvjPYYiTYy3+HQ0DjeGMJ9SgGgWISeb7UF0jDkN8V
	WnK8mQCogQIXqm5Nu99IlQT5LYo2n9qtf4qsM6LRnaNBgQTsc1rMMmuSGhXDj6XzHusroK8Lqr5
	x++O0jWfgDfZaDy3E86L/K4ixuIZ4PLvVQCaWFTo3jb1O3DhEwCNJ0cG6wa3Row4tyQ4RCesedW
	/vqrAGVGCgsDc2Wi4EwM0YGDe1HYnNH+xA1d9Vt1oRQ/zL1RYX1jmuw1ry87Fc9QaAorQ==
X-Google-Smtp-Source: AGHT+IHhS34m+1SD8tJpx138zZD3EsRZi3N15GwK1gcW6eip8X0EM83IiyMjYmPSNpcESushN3pe3bG8ne7Hpsjh5vQ=
X-Received: by 2002:a05:6638:8721:b0:5b7:10ea:e2a7 with SMTP id
 8926c6da1cb9f-5b965b1af7bmr16025724173.8.1764161492726; Wed, 26 Nov 2025
 04:51:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
 <07500979-eca8-4159-b2a5-3052e9958c84@youngman.org.uk> <20251126001526.GA13846@twin.jikos.cz>
In-Reply-To: <20251126001526.GA13846@twin.jikos.cz>
From: Roger Heflin <rogerheflin@gmail.com>
Date: Wed, 26 Nov 2025 06:51:21 -0600
X-Gm-Features: AWmQ_bntz_i1QiEa4TH0U930vkLMkc6r-_qhym5yOt8grjTnHgC7kUI2p-Jq3qw
Message-ID: <CAAMCDefgRUH5ygs10_=x75tOybvPPsYC-Q+KCFPP+9Le-x5RBQ@mail.gmail.com>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
To: dsterba@suse.cz
Cc: Wol <antlists@youngman.org.uk>, Justin Piszcz <jpiszcz@lucidpixels.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-raid@vger.kernel.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 6:15=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Tue, Nov 25, 2025 at 06:25:41PM +0000, Wol wrote:
> > Probably not the problem, but how old are the drives? About 2020, WD
> > started shingling the Red line (you had to move to Red Pro to get
> > conventional drives).
>
> The WD SN700 is an NVMe, though one can imagine how they could be
> actually shingled with slightly tilted overlapping sockets.
>

You have to get a red plus or red pro in spinning disk to be conventional.

On the nvme: I would check for a firmware update.  I have seen
multiple SSD drives from several manufacturers that had timed
housekeeping processes where something went badly wrong with that
housekeeping process and locked the drive up.    Some of the issues
lock the drive up until a reset and then when it fires again (hours or
days later after the reset) it locks up again, and some of those
firmware bugs brick the drive.    If the timed housekeeping it would
likely be some set time after you powered it up.

