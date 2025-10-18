Return-Path: <linux-btrfs+bounces-17998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D994BED462
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 19:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29B540842B
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD00F24A067;
	Sat, 18 Oct 2025 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTuNCrrG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE471D618C
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807263; cv=none; b=PaiC46/4/WS9kU6MXgz9sZwG4djXMb4JBPjojMcwUz7DRd9YY6BN0euRDdUla0QzRfuYIsgoXhmLqmY2D1+M1dkgK5jpZCNhZKYN0XF44HAPmhEq2cIAQOrs/fqisPC7aBf0QLRwxeArAlaHrMbHmqNe/3ueewgSsvs5gQctvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807263; c=relaxed/simple;
	bh=iPUmTh3tC5kprevGI4qtnDWtdFkhVEcglc1971nZY7M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=qx2KKOFyCCWzfUso/RjapBmXmjXPg8FthZrLcgsRc5ez4u26uchTszVUHZDVt5ImUFEfEw2QhOURfZ0K7Nr8Ce7mjTsDzXZ/P6wr+W205vdPWImtLfH9qHgd/vjI//XipIN1+52wgGEbv4REAR159xQVky2qO7XcBWTOxnqNY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTuNCrrG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47117f92e32so16154895e9.1
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760807260; x=1761412060; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPUmTh3tC5kprevGI4qtnDWtdFkhVEcglc1971nZY7M=;
        b=bTuNCrrGGStynvjU9ASsYb5XHmn82GlF6AsLBZ2/vv0Hh5DEej9wucRlB9YkSt5nT9
         vlF2U3/LbgWFHkB1tw7V7FzLxnbuH4qG6ngWr8f3PSippZxHauXNEphd5wjAyEwyj8gI
         0UfOkTUkybBu8nzk6nouGz9SULl2/2qb+hqJq63LQELXqWNVrVRLhz880v9jHvh2m1YD
         OPBNRoEr+HKrbHBmPktSgVHpfsOmbMhUceBbYg5bDwInsK2k1fKRv9awUP33tsRl/ktr
         0HSjhZo4qgWz04AJY4E0zmbT3YNfmH0XLvXlftENxEdvg9rbcQo4nyxl07F5cX3b6c4Z
         TmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807260; x=1761412060;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iPUmTh3tC5kprevGI4qtnDWtdFkhVEcglc1971nZY7M=;
        b=t2oakFcNJ0O4i2L7VH3Pj8Ro9hCqk3pwJ1zkMTUrSBgKn3Yy+pHGp8zREyvxqD6hEh
         4HkDc6ms/Vl65VlOb1SX6vrzvoKj1cFOT+i9AQKG9mlL6qXB4S3u4mQziohkVpftVCHJ
         Yncae3PBORySqUnAOu2vWneDemGUDgilFxDDLXoyyLeNm3Cxr6N9GtwZZGmZlBo8WLsb
         1n3TR0xXZVuNtmUBc7jm9H49i0hnJzSwBI8YcIvBHUwRrtCvRmjS9s0xHYWZcSqCWu6/
         Ce3IdoJHLd0/T/wYpDQ2CYmhAJYstJFHdqs0tL8F5xFgUmKzSi5KirRUl/OlxcHBRpV5
         j0uA==
X-Forwarded-Encrypted: i=1; AJvYcCUdQiHSVsQTcVSy0FU9XDbLDt7mTrXVaG4DlYOw0sRgUtfos+qCGA2bUJOhmCQw7fL3fGiLMrOTrQV+nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwD/AzUhDfD3bI01YQNqsgh8gYw8+EAB+sdoiCegUnINn1+vIEP
	FV65X/1ZqxigfBz35wOW6AdbdA63T5xn1ue+msdtVNdeLCrNJzBFBtiB
X-Gm-Gg: ASbGnctrORUn5/xQKR6YqyLcCSDTdo4osauCSMr0/tmvPvkbV1G9uZ5/NqdG8p5u6oJ
	2GqPGMHCCnSAqARt4yQaFxuKsYHxrjhS2I7XvWCb/zep7nenLYLcYisZJVufCdzXgthcUlgIkqn
	mVXkn5bvaTIjFaTqCCRvLpds4vFW9wCkP3Ul3oefEKvToVSNnaFTTQGEib/yFkWjNxYTQSi/65B
	L9gTgWF6EMAUk7opCuNodQwk9JqujhF5u8gQVTV0uXw25C/YQauev+/HAkhnc514//Xmr82HxXZ
	YvIzp8HzzXrmfYEfwh+XKdYt4EGHeWNxZd+/AbW4TisnKS72Y0vezD91DXj4enXLWorluHmz89s
	ZywSIHQe8SkJVUR7cWOaoMB4pgvk2eRlXHK93Ym407Sfm2bBZbzIcrf1CVsUpO0UtW39XRK/G88
	e4UR961MBcffhxLryww4+RF289oYf3TXtpl+CBEO8utKcGjMvOBMpnt5Kk78rNEw==
X-Google-Smtp-Source: AGHT+IEX65PMiwboz+Os84FqRfTaC+bA5+AvBv2mRHFudUrmHUTrwTFMbjx7utgxfwf1v//H/0p3zg==
X-Received: by 2002:a05:600c:3b8d:b0:46e:4883:27d with SMTP id 5b1f17b1804b1-4711791c8d3mr60187925e9.30.1760807259469;
        Sat, 18 Oct 2025 10:07:39 -0700 (PDT)
Received: from localhost (host-87-8-168-238.retail.telecomitalia.it. [87.8.168.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce178sm5593196f8f.46.2025.10.18.10.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 10:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Oct 2025 19:07:38 +0200
Message-Id: <DDLM2VDARRDZ.1G6RL1GDDDSL5@gmail.com>
Subject: Re: high space usage after ext3 btrfs-convert
From: "koraynilay" <koray.fra@gmail.com>
To: "koraynilay" <koray.fra@gmail.com>, <linux-btrfs@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <a1307c8d-2c6c-4fc7-968a-4101465e62a0@gmail.com>
In-Reply-To: <a1307c8d-2c6c-4fc7-968a-4101465e62a0@gmail.com>

Update on this issue:

> which should've been fixed by the defrag
After asking on #btrfs on irc I found the solution, which was actually
to use defrag, but with -t 4G and forcing compression/no compression by
using -czstd/--nocomp.
By running a defrag on the full fs and on some folders/files that still
appeared as <UNREACHABLE>, I was able to get the <UNREACHABLE> space to
~4 GiB (and hopefully it will go to 0 after defragging those remaining
folders/files).

Thanks to Forza for telling me the solution and for multicore and eyeoh
for taking some of their time to help me.

P.S.
> that I had 488 GiB free, but when I deleted ~215 GiB, the free space=20
This was actually ~86 GiB, but irrelevant I think.

