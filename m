Return-Path: <linux-btrfs+bounces-16438-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E64DFB38230
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 14:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99AA97C7CF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4774212B0A;
	Wed, 27 Aug 2025 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsLZG+Ar"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A73019C2
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297483; cv=none; b=fcQ7VugXlDdCJ6oqfJnlU2GskKoclZox1nIVoM5uk2Le+6UawfQEPNSvnNzMsPEdmMJVazZ2/C2gA2VGccgE+BK2PEuUBRHOZkcqQqvh4jfypAyQ//DGdFLI8oqiX3YEyloUzJaVsPJ7aVpXphyGuDFFyo3x8S3A3M7SyAWNVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297483; c=relaxed/simple;
	bh=mfRjCaJOh3Ltbl2a6EvjQuYVOI1O4L9LaZm0TnFCwIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=q33aZflFvhNuG+vnHOrkqutL5Rw4LYDPT7Nzp8EIhiUTHzx8wRYjqFjcG+R+3hwOJwsDSvMgKnuUWBU6dti8gnrpP0JDFjTbHElciADLzitxgnkbyzXB9dgBjNncDPL1uLoao/gk+pDJwH1I8FOTQELU0p73cNf7Os6+ZAwwFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsLZG+Ar; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b4716f9a467so964312a12.0
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756297481; x=1756902281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfRjCaJOh3Ltbl2a6EvjQuYVOI1O4L9LaZm0TnFCwIc=;
        b=KsLZG+ArU8P2w2TGfcOUPvT70LjyQLh93/+9k0FPUYVnWf4AXoK+2BK9td8pauBFLH
         g6KwEJqH0KQMLHWCTA8eBw2EMOaeBzfgp5jmbCRZqjXQycvDgjK0WFYqKXoUrthhGPSG
         eYEOwk14Jj/pBB5LFgd6unbuA2iCeoecvq7FBUQS/YfxKFSmBgJ4X1+Vla5aVF+B6uBD
         D/YTOrHuANWHECPpUxbOGWfktl8DxIQzIU3obwmP2ZmnDiXQ2r4l3AE1jNSdsq6qHPB9
         h+Jva3Elm76mJB/9KsuRo4Hdgnip9zs7a0D2I8uQpfNDu8Bw+qDy5P8qjHfutdkLEVG8
         Gjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756297481; x=1756902281;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfRjCaJOh3Ltbl2a6EvjQuYVOI1O4L9LaZm0TnFCwIc=;
        b=iIwWQNioQIEXw5YxXyyHLD8iMnVvnhSPrTpXxOj0rqtx7WDlS9hlMVBiXrXSt0rwQ0
         J1CeAPKmeIvyvhrXwLcA70RssoA0pVsj5nIdwsAnK1rACrDXng6DBj3Np+eL60KHbh9h
         8/tDaewsJF/ooz8+Efb0AQ4YLW5h71dmpVWm8caJz/pu610Cv7XgY17s/cIhB0xA0JhH
         AGLKt6fTLl/rkhOfWttHCTAf6cBrSXOi6VGZElWMakaxyGlupBZaC/Ayq0Jgs83YtvxW
         xlF1zlBbRlhegQYNN2NPU9X3HtwMvltwozHTjA748VI1ow1gfL7N5PhaZfgK3PwTw0Co
         zMWw==
X-Gm-Message-State: AOJu0YwUNB4SXOQRjRBS8Ahllyatig+Sl1U39ThRbjB9IGglkN+4YjIm
	irkhbtuNijhlEEQrL2Meaqt29SPcatBcE4OceKYhZtQ3Su44a0xu9rd8vdVbf2/QOuf8rQ==
X-Gm-Gg: ASbGnctKRiJwkwDFsQI39nvWmppGOYgVoeDmlITr7P53tO75CxKJlj4k8o6aGD+xQ4J
	F+SXv4vQT/x3nXpVYYt+PLva04387TZGCziPdCEPo9+i71AHC4nyTSq9dKbg1QG+Hw1O+p5PhLw
	JjAreCVnuGuXEhgp+eQwZDx/a0m7uIaxX1Dc8z8cTA/EllaOl0ay5KyNIgGW1GthPhAOsGyyueb
	ijmsi9XDOTlFc7M4icyV/95lRUQBXn2kCHcn6EK8aaZDezcHSTVZXyVBKo00n9fMzrAudTqZKVS
	BZz6GFsOnjhHyOZy05CQZSX1AC4FQGmGnyP7kX1Fx/MVu2lA7cobgq3/XW1+HsF6mCshOKV0xbU
	tSUfplftzb6jBJyQLW+IF+KcT+y7XTxcZ47zuChvvSw8Y
X-Google-Smtp-Source: AGHT+IFKJtSEtW6Xy+p+broGBX5gITf2aQ85aDxA9tpbXz8yR0CjAbrGJblHfPs6z+g8sBdwYYC+Ag==
X-Received: by 2002:a17:902:da8b:b0:246:b41d:252e with SMTP id d9443c01a7336-246b42c6bbamr97080165ad.2.1756297480650;
        Wed, 27 Aug 2025 05:24:40 -0700 (PDT)
Received: from saltykitkat.localnet ([160.22.143.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668781500sm120355845ad.13.2025.08.27.05.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:24:40 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Date: Wed, 27 Aug 2025 20:24:33 +0800
Message-ID: <5006600.GXAFRqVoOG@saltykitkat>
In-Reply-To: <20250826165619.GC29826@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

> On Fri, Aug 22, 2025 at 11:51:18PM +0800, Sun YangKai wrote:
> > > Please split the patch to parts that have the described trivial chang=
es,
> > > and then one patch per function in case it's not trivial and needs so=
me
> > > adjustments.
> >=20
> > After learning more about the auto-free/cleanup mechanism, I realized t=
hat
> > its only advantage is to eliminate the need for the goto out; pattern.
> > Therefore, it seems unnecessary to apply this conversion in non-trivial
> > cases.
> I wouldn't say it's the only advantage, the code readability is also
> improved. The path is an auxiliary object and if the freeing is handled
> automatically then it reduces the cognitive load and the error cleanup
> paths.
>=20
> > Moreover, if the cleanup code contains other logic, it might be better =
to
> > leave it unchanged even in trivial cases.
>=20
> Depends on what we want. So far we've started with the path auto
> cleaning but there are more possibilities like using the raw __free
> cleanup with kfree. If this is combined and leads to simpler exit and
> cleanup blocks I think it's worth. In the trivial cases it's clear it
> does not interfere with the rest of the code and does not complicate any
> logic there.
>=20
> > > The freeing followed by other code can be still converted to auto
> > > cleaning but there must be an explicit path =3D NULL after the free.
> >=20
> > I'm sorry, I didn't understand. If the freeing is followed by other cod=
e,
> > maybe we could just leave them untouched?
>=20
> Maybe yes, this is up to consideration on a per site basis, I've seen
> examples where conversion to auto path cleaning would not hurt.
>=20
> Let me know if you want to continue with this because I think you don't
> seem to see the value in the conversions (which is fine of course).

I apologize if my previous comments came across as unclear =E2=80=94 I cert=
ainly see=20
the value in the conversions. My intention was actually to discuss in which=
=20
specific scenarios these conversions would be most proper, so that we can a=
lign=20
on how to apply them.

Based on your suggestions, I'll restrict the conversions to the following=20
scenarios:

1. Cases where there are no operations between btrfs_free_path and the=20
function return.
2. Cases where only simple cleanup operations (such as kfree, kvfree,=20
clear_bit, and fs_path_free) are present between btrfs_free_path and the=20
function return.

Please let me know if these criteria align with what you had in mind.

Thanks,
Sun Yangkai




