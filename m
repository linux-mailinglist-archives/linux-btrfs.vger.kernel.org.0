Return-Path: <linux-btrfs+bounces-3100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6C0876457
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 13:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420EFB227D6
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 12:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E931429E;
	Fri,  8 Mar 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md3a5Z3w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF1367;
	Fri,  8 Mar 2024 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901091; cv=none; b=DD9d+UOoLseAtZVuJEKhQaHVxNJqlMhiFIracBNDEljXupsobgz0EKGb9MuJO9m2YlbOoYxnEuaKnESIFUACqA51WVJnN25Kxo24SU3f/5Rws8ZQEbZJWLgZArEGPfJNmp3CtiwG801aBlluRK/r1ZHdQINmSyAvMIKLkqrqTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901091; c=relaxed/simple;
	bh=5XTrm4lguEBL/XFBb/zp/fSTLV30tkBmBXZetK/+SZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mw3wiIUe+FNa6JhoHxYxR13/QzDusY04zdn5XMZQjdrFvhZ5b2ZS/8O/2/Fts8jvsdXjqO2kuG2mx4FQVbq5A7L2O+0RYSF+PoqtvkYRc+4Msp9rWNwvooNcuzImGXbo4jE7C6H2zLejiIUPGCWqwBqle9qtDZ//FKjQwb6wDGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md3a5Z3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CFBC43390;
	Fri,  8 Mar 2024 12:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709901091;
	bh=5XTrm4lguEBL/XFBb/zp/fSTLV30tkBmBXZetK/+SZQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=md3a5Z3wWGeZNJWnUmwqZARKHIU1elqG0LKs5PM30K8zX6yZrNHuSa6HPSpzCUcUI
	 OPdPBM9xBEL8kRkLjt1eW5TqtOO4Qf/RwR3IixH55SQCrmoT95tsxHzXFww6DiC9Tj
	 EggYlTcAKV0Q2vhjfAwQeN8Wcf7yXObofkDkImtLqIhE0gLLxiIpfgBNBPop8VjJZa
	 nA1K5pj8pFDDqpSUaa0/AVPqBUeKzEGVWaC95UjyktN5widZkX6qDnOFM+xNLX3iRK
	 HwEnRtFOnl89gzYBIu3TO45lk6u9A6g2lsPf/hJHACvZdDGSzuieRlzL3/iv61IATB
	 dCPuRxScMhwtQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4429c556efso102957366b.0;
        Fri, 08 Mar 2024 04:31:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAGinhKwbrYekC5UqyUb0Rc8wEF52ELkvXFPhz3jwz0dwKL7sWOj2t3R5nC9zonRzZjgtkzXXAhdlHxG7azCGgKuMkKxQWBG9rg9U=
X-Gm-Message-State: AOJu0YyNUvoAWNBRjU3GF/kFYv1ET+DoKxGU1EyoxvS+KYDkvAZclXHD
	T0FKry1YRgAXaiAAgyn3xwvmy65S3ePl3OdBAdOVssyNc4tM1iHDo/yP6lsbUjdlmVBv9d4vGeG
	zX5y/ZUAEun8apzv52Uraae+yyd8=
X-Google-Smtp-Source: AGHT+IGpBzlAaFqCRv7lpoJwZA1a9VTZgHuaZerSI0uaRBsD/B40ZLcIOYBEWZuT7agnTXuFSLtRzUpGyapAMitMKIM=
X-Received: by 2002:a17:906:6455:b0:a45:7ce3:d239 with SMTP id
 l21-20020a170906645500b00a457ce3d239mr8092183ejn.48.1709901089828; Fri, 08
 Mar 2024 04:31:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709806478.git.anand.jain@oracle.com> <c68878cb99025b8c8465221205d5de9e40777b18.1709806478.git.anand.jain@oracle.com>
 <CAL3q7H5NgJ3hpFFk8GcESX0n61=r_J7=daAbDqZjpEHek=2djA@mail.gmail.com> <5c4ca62b-a448-42bf-a196-6365af832889@oracle.com>
In-Reply-To: <5c4ca62b-a448-42bf-a196-6365af832889@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 8 Mar 2024 12:30:53 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4HV-UBd9hEKB1+isH2H4TThsx0DnvfYxsY+=BB64PqqA@mail.gmail.com>
Message-ID: <CAL3q7H4HV-UBd9hEKB1+isH2H4TThsx0DnvfYxsY+=BB64PqqA@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: test mount fails on physical device with
 configured dm volume
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 4:46=E2=80=AFPM Anand Jain <anand.jain@oracle.com> w=
rote:
>
>
> > I'm also not convinced that we need this test, because the bug could
> > be reliably reproduced by running all existing tests or just a subset
> > of the tests as I reported there.
>
> This test case was motivated by btrfs/159; and recent report;
> yep, most of the lines here are taken from btrfs/159.

Ok, so it's motivated by what I reported, triggered by btrfs/159 but
only when other tests are run before it.

> However, I wanted a test case in the tempfsid group which
> exercises multi-node-same-physical;

Sure. It's just that we could trigger the issue simply by running all
existing tests, or just a subset as I reported before [1].
It was fully deterministic and David could reproduce it after the report to=
o.

What surprises me is that no one noticed this before and at some stage
the faulty patch was about to be sent to Linus.

>
> If there are no objections, I am going to add the tempfsid group to
> btrfs/159 for now.

That is confusing, please don't.
btrfs/159 doesn't test tempfsid, it existed for many years before the
tempfsid feature (introduced in the 6.7 kernel),
it just happens that it triggers the issue if other fstests are run before =
it.

That would also be pointless because running btrfs/159 alone doesn't
trigger the bug, so running "./check -g tempfsid" wouldn't cause 159
to fail.

Between that and a new test case that is somewhat redundant, I'd
rather have the new test case with proper documentation/comments.

Thanks.

[1] https://lore.kernel.org/linux-btrfs/CAL3q7H5wx5rKmSzGWP7mRqaSfAY88g=3D3=
5N4OBrbJB61rK0mt2w@mail.gmail.com/

>
> Thanks, Anand

