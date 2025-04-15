Return-Path: <linux-btrfs+bounces-13049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAB3A8AC46
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 01:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A5E57A5E4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 23:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244B32918F5;
	Tue, 15 Apr 2025 23:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtQf6y8+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A42DFA36;
	Tue, 15 Apr 2025 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744760140; cv=none; b=o+pj/U3OfFyzBhUJM5pU8UnGA2SqU4q7s7doTbf0w6+x5LLMtf8zjy/BM5O0v3c41+qcfEOSEuPWvniY4HGjl7f3uOznvSBeQFTmc3k2vauYBsNOyPm8hj6FoTr1/no2jboiCj1SeB5NrJl23K4Rs1tn+4wRrV9qGfTlXLTq2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744760140; c=relaxed/simple;
	bh=VifUAGqXrpve7MyJF1/JPgmu1YmdA3mVV7mluhkV/pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=nd4HZXEUIFgC68TezSG9J9tsOIx729XVeIoGiy+nTAz2B9GYfKdt3iypGWDCKDpkO59TP6a5I/67Djxo415VPm1MARfgySTRdG/j6fu5UulFMukP3KMvuEVTZgUAFFcZ4uY5b8NWmKdQ/Cs+GoOUx6D606botcGtB8RW+jged+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtQf6y8+; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-736c8cee603so331732b3a.1;
        Tue, 15 Apr 2025 16:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744760138; x=1745364938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k9ng36k6+89lBeYxXggLCEbUf1f1fC/eR9HgAYWHI7o=;
        b=PtQf6y8+JmXGTGy4ylmW6CCg4CH2npD+yuAQCH6+QuGxNxsZGOGB2wmVCZKojCLd3c
         yFxFrh6Buld8xOHNfDHJ6EDgrzRr14QQlglA5YmfC/X+Be7uGM5CuiW74yPRSbZyeqqT
         vGNUJkwoAUQYpEoftPLdEsPBWWgn12EzBoC0axFxApOO9Gt38FSVRZ8AarC7yQ3xNiHO
         FL3AH7hKbA1Z3C8i8lOklC1ylYctYwEibzEKyMB1uHo02f8fn+q4lQuz3zxlKY2BWfUo
         6pH51hmJWb3a38dAqnD042FizY9vRHU8q58SkHKrs+6zpI2Mg5+vfBL9XFY6bQtQ47/O
         SuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744760138; x=1745364938;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9ng36k6+89lBeYxXggLCEbUf1f1fC/eR9HgAYWHI7o=;
        b=EXEasI5Y2iN8Q2pxTovGbRj6CQ4hMQpgaQv+sWcOy4iHm2WSrbi3zth32Ag9pbCLv5
         mUveCDC1Yqq3XNhnHA5Nmgu3mq1wMxwGANHv+BX+AqTLEuV8sHC4+cxTKPirEtLzxn2D
         v+hG+P0fEtlokVSgKxvgeRcbbwboXlm44o1GbcTmiO4V39lHph5bWWvEXyh822kofc9I
         S0mD+48QTmR+5ptB1Czaot68FVrHsmhNc4sWDo78w11JVcuw085VBINvCBN1NoRIAfiq
         k7Wwn3EEYYD0e9yvc8r9l9I+N23/w1pL2/91SX3u6iMeCRNVm84SLya8Xp5VjgIDotWC
         rcHg==
X-Forwarded-Encrypted: i=1; AJvYcCUYebKGQUvsfDmjCsbIoUjzyjySy7VfDaiT5WgIMvFXL/2tz4Bjd1qS+nJtWh+e5PfU9SEaannqAs5iJHCQ@vger.kernel.org, AJvYcCWUdnKrNHAiuNZhlsXWHFC/MbIosEdJdbJJxeXGpJ/SCVzDPyxZds6AaikEtCayU14wUz7e0yu1qmtmKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoONT96DDXJh6P8QLCshsy2xhp8jbYWHGqwZEGc2NIv8mBENSI
	34KemPWFfdEha0XNYjPxWIpOtTMF0cunvKW75XxhSkwYWeY7AnPy
X-Gm-Gg: ASbGncvRgYV1I0Nj0xUJM6lHNigScn1OgL/IoTBnfbsES2MXorV18q9QBvUSsrIyMVb
	gwnikDg3vpfKDC3xbN/pFzwp3SlKbmr5XXAF6sj0SKX54gaRDr0n3ALclpeB4fnt0yNx7s+Y0ar
	SIZ1On4jvNlCR/zet4KgKPL+TLwZtPuSrHNIaXssJGr7JFNNC++DAx5o73QuB5Ej+5Qwyj5wlqX
	xwX2/oEQdm5krFRPCsfxOh0h469sujVkvMeyexo3ysOGOQKuQ2tPOzLym758SuL0Gd641quaYoE
	9GVH3e+ImFMyHZRO0XnnV/A9BL661K+p+5TLRmm7QQ0iQqh3uYg=
X-Google-Smtp-Source: AGHT+IGSUk93ONxqBp1dzfwfyCWEi1dgTVpzffVT+KxtevWfkF4sr+4niImOf3F3T9QKwwByVsyv+w==
X-Received: by 2002:a17:902:ea04:b0:223:659d:ac66 with SMTP id d9443c01a7336-22c31b01559mr6906725ad.12.1744760138248;
        Tue, 15 Apr 2025 16:35:38 -0700 (PDT)
Received: from saltykitkat.localnet ([154.31.114.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33fc831csm1010995ad.181.2025.04.15.16.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 16:35:37 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: quwenruo.btrfs@gmx.com
Cc: clm@fb.com, dsterba@suse.com, frank.li@vivo.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 sunk67188@gmail.com
Subject: Re: [PATCH] btrfs: remove BTRFS_REF_LAST from btrfs_ref_type
Date: Tue, 15 Apr 2025 23:46:15 +0800
Message-ID: <9442545.CDJkKcVGEf@saltykitkat>
In-Reply-To: <2e158208-4914-4bfb-984a-0d35e8b93225@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> >> History please.
> > 
> > Did you mean change commit msg to below?
> > 
> > 	Commit b28b1f0ce44c ("btrfs: delayed-ref: Introduce better documented
> > 	delayed ref structures") introduce BTRFS_REF_LAST but never use it, So
> > 	let's remove it.
> 
> It's the common practice to leave a last entry for sanity checks.
> 
> But since it's not utilized for anything, I'm fine to remove it.
We can also add comments for all this kind of codes,
so that further readers will understand this common practice better.
> 
> >> The _LAST or _NR suffix can be utilized to do sanity checks, and this is
> >> not part of the on-disk format.> > 
> > IIRC, delayed ref belongs to the extent tree memory kv cache.
> > 
> >> And if this exposed by some automatic tools, please also mention it.
> > 
> > I'm just looking at this code.
> > 
> > Thx,
> > Yangtao



