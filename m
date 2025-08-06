Return-Path: <linux-btrfs+bounces-15888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F28E8B1C056
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 08:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3792A7A9510
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 06:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04971F1315;
	Wed,  6 Aug 2025 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ9z2Phk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3601FBE80
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460616; cv=none; b=MXH5OE2L925D7/rXQ53EOK1wiohtYYgMG+5wsUJlfD7X6D625uz7s3xzpA6GOBI+/woU4Pq4rlNi8V998cLmaSeMoh+d6jOfAnw979q6EXW650kdCcYH1Y7i3gpXe6O81uLZPgCIyoHXMskg0gVOwuvsw380mGscfSEjPZ6wVYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460616; c=relaxed/simple;
	bh=7bAouPkEe6Uyj7mAUmdr5DiE8H2hp54pE1MZdXya+Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+3rjpUM96v3HBWgKKP118rlc2ubw+fsEXlY2NxfgFMYqPrG1Pemdz7+utVUZPNKZ3T2GEmmZmhqwCLtSKs8jTA+aw/2e3QL45a8jxpsXPXiBQfc6nLpUrkHbESOSq/YdXLzSkzWa8nn4rIVAOI7wwYzXAWcgoKRMR6XqTHb9zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJ9z2Phk; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76ba6200813so424086b3a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Aug 2025 23:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754460614; x=1755065414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dJlUvIlNc1hc6RHmaZkiZXRJbckQabBXpG02+wbCw4=;
        b=AJ9z2PhkD3ATOhKLEPIwvcq8n13VXOgWmBb/w9DN2cAj3zcCsB3zsBG4s2jNgaafCt
         cQQbsltKVrVUqrg6kFGjofL3O5MYkdkvN3cQgOJ7oY1aWTl69hIMg/O3SooGf052pGLt
         4UNX96NaSZ6xyWhakdz3dH/pkIBRKPxNDNnL+cLlQzvwMBmVkC6wd1m2SvAzaNSjPn1X
         dPS2lotSYEo4dADqhqrH2dnFe8HXCigQoPO9zZT7smJDQJxU1BgpG1bcZ+plKLQIYPx1
         U5fdSpSlp1Ye8kyrspU5p48BBvvIPXZsSJNxktq6b9yzYBKRzQwphi3i9JxyXLES5tGR
         lKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754460614; x=1755065414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dJlUvIlNc1hc6RHmaZkiZXRJbckQabBXpG02+wbCw4=;
        b=ea5XOR2bn1KiQWihw0+1j2m21Jw2FsruhZcsraM07LqaI/kPSWsKrKWOYBLFCdc+gs
         di8BJQeX+TnLmWsMrPXn6fC6S0d2Qn1t0TBu4YVX4LOhA3Cn83wTgVbsJsVFUQuDBHcY
         navmRXU76M3l3n2tm10bkIKrJH04FW7vTYlyEjtpDz64xWLSuy3KaIiyGMotMIdP8Wi6
         VYOEkpyI7rbQg5bvvyBkhT3uboC4nrK/pMLuL2eyHjiDGgqLqL36BcFMGgJRTd+mgKWM
         MJAZalCNHU2hZVpKaLygvbeMATzrHIYbg5Q3HLIBc42vRY0i/rAAjs6yMVpcmej5gNpZ
         0L/w==
X-Gm-Message-State: AOJu0YzAK7FRib2byZbwI0esNNQee1pFIjBxHtZSzNuQDnOGEA+fRVJm
	3gn9M6um6P7EYq2myV4IS+uhm4XFEK6+59a1SvB+MxE6oVsw1ca+LxV6QxBOJYl7Pn1lVg==
X-Gm-Gg: ASbGncvLqELa/vWdSQavYpCsF1MpqtU70zN5st9/xFsHpeeUxPXmPQbDFSryRYG7qZt
	0R3X2JNRO5CzqtVA93yhI/LdFV3VzcsvOvTK+OB8Iwuf4Dsp8N6B3T44OEns62Eit8L8xVne7JZ
	DhJdJ18JkWzdb/DOPMm0lxU+OIRJuRyFNMgX4cRyWn1hpNMZBKE90uWYFSPiGS0EkIcEVJyTx8Z
	rurgVD0VfaWbKP6iCsfYeZY7tWEV5olbjvH+Pp/mVPBwXKMZbt6Gl7RfZPIARfzrjpVi3D7tmrd
	zUyeS+ynknAn/08/FgeKPYi6p8zLrH+5oxnxb+HADDk6HaMa+7uNOidraAYYiiPgy20BSE8bhj8
	9ufETIbT7LNhWXfAAPgeiyBV6BJ4gGWcztjO7gSyc
X-Google-Smtp-Source: AGHT+IGufvDBHdbG44d5iT9syQu5NjbHIUYZHBrRk2GTlO+YMMKrflXrw1zlpv4ArzZIENgIY2B2oQ==
X-Received: by 2002:aa7:888e:0:b0:726:380a:282f with SMTP id d2e1a72fcca58-76c2a15b5e4mr1193349b3a.2.1754460614043;
        Tue, 05 Aug 2025 23:10:14 -0700 (PDT)
Received: from saltykitkat.localnet ([154.3.38.40])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd6aacc4fsm13371599b3a.118.2025.08.05.23.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 23:10:13 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix node balancing condition in balance_level()
Date: Wed, 06 Aug 2025 14:07:06 +0800
Message-ID: <2384779.ElGaqSPkdT@saltykitkat>
In-Reply-To: <20250805184615.GD4088788@zen.localdomain>
References:
 <20250805035718.16313-1-sunk67188@gmail.com>
 <20250805184615.GD4088788@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> This is interesting, good catch.
> 
> However, we don't really have any evidence one way or the other which is
> better. For better or worse, this logic has been around since ~2007, so
> to change it I think requires more justification than the reasoning on a
> 
> faulty patch from 2009. Do you have any evidence for your #3:
>   > Improve btree performance by more frequent node compaction
> 
> I would advise that you run:
> - fsperf for generic benchmarking.
> - a targeted workload that would get compacted more now that you removed
>   the surprising check.
> 
> Thanks,
> Boris

Hi Boris.

The performance might get better because we will have less nodes and even 
lower trees, if we compact nodes when they are 50% full instead of 25% full. 
But I've not benched yet and there's some problem in it.

I come up with a drawback. This patch will make it more frequently to 
split a nearly full node into two and merge them back later again and again if 
item count changes slightly and its neighbors cannot help balance some items, 
which happens when:

1. left node is full or null and we are always operating the left-half part of 
the mid node
2. right node is null

The leaf merge related code choose (cap/3) instead of (cap/2) to prevent 
similar cases. I have no idea how often this could be triggered in real world 
workload. But if it really hurts, we should try some other method to merge/
split the nodes to get better performance.

Anyway, thank you for your advice. And I'm working on fsperf.

Thanks,
Sun YangKai






