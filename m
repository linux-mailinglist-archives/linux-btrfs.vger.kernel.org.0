Return-Path: <linux-btrfs+bounces-17467-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99858BBED3D
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 19:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 951594EEDC1
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B0F246799;
	Mon,  6 Oct 2025 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSFjNWMq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3BA221F1A
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772295; cv=none; b=dQgb56RHDOpT0HmgBOB1yO1wDCG24xhfxkql2Gftt8QmshpSRrO+AzrC7PinmsYLTt7i/9mxCDr2dexmoODJHP7mOget+2vlbaIL4lq50Fl8HenSncjvEOBTdT+zw4PcKwxcexeU8TRSPsiqQfNgxA7zzAMOuIgrnjl3P5MiRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772295; c=relaxed/simple;
	bh=QnFXC5zW6cJCdtb/gGaLtSphm2wouXQIppnYFbVFrK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYb037WnJ5Wu1ClOc4xknOSwnu0uRtPpYdLSCFEanroxjt+4XWfu62bS8Z6e/divKLn9QQQHmb7HbifGAR7tpM9o8AojT5nBZJzBsZ4VL80MovqvPXI6/TKrK05gw0chvViUeX06XP/SxIPmebyJwbW1N2REGUTpP5SwPzOEqcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSFjNWMq; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-71d60110772so53000227b3.0
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Oct 2025 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759772292; x=1760377092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ebqmr5rKLRyhSXCzWYO8AedjCpJ3xXFZUe7FSLwQDLU=;
        b=YSFjNWMq/7GFMPkLfem70lo0gIlUkS6p0DCnmLSK1pbto2slAJUb1mG6t5tnJhaHz9
         TBzqR0OdD7DwtKVOVMUijGj7rJFsbIEQQUhcBc3GoW4Fjnqmp+0h3HFLa4RFNspoyNqr
         pFYeLKdKdgh6x668Feq2/Ubx4TCaS8nVu806754huir237rj1TcySfzR0oBycnQJBk1X
         b/qCia9u1lZ60kAXSV/W3utFl6g8BzrfKmGFCUlugy7N3xy+sYwq/NMtpUo2E6Hn9+gt
         3pcRQ1mt7304PaBd8VNGtSQ2gG53EdLbSxEEhpT19V0dlUCZGWk1VGTOloBRslId7nG4
         gzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772292; x=1760377092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ebqmr5rKLRyhSXCzWYO8AedjCpJ3xXFZUe7FSLwQDLU=;
        b=XG+VRBmYoq9xnUvuWDkftXjH2ykNpWtXzrA5eg7jOeieZGFrUkeJu8HqKBFMoROhnV
         AsP4l0fI6n6ZW98d5fcufIDlXS6cQM56RXESX8q24TfNjPyTV9v2uJwmKkjL8PVtSMlU
         zU0SKh+CMAQAMvOaYdGTAN0CjztjlwDklXZGv3W3ZVgc35L1i6xaQ0aOUMJ7gq4tnZqy
         hZvUHFZfXO9Hi96AHvNAuXaRPqmsEZo/jCTrpN0KuGTcMZmj6e9nGuGUFlWRaciq8WD2
         tvQAZP1gYSXFfiz8bFfgFXl1+gZwfYIuYXXCD87NRDVwnLPz4j2feWBIHD2mcl0DEx74
         nb8w==
X-Gm-Message-State: AOJu0Yw0qrVXrkjVGOrih1cJ9ygnN8Yjf/SD681S6seb9MHvJLtSceyL
	NyNygZDBrE9/9jGj6lBrf/APbkTh+ZTpsDAy6L19b5YnBypvjMd8cTwh
X-Gm-Gg: ASbGnct0R5QCps+U5uoJ41u7//G7r5AMdtdmKfVXRRBXSfOF3ggkpBqa6ut1GDH2XJY
	ULCynteeueu+6s3fi/teYmkduqL5bA0+AHH68+xWpHiGAlTxqQwcbOm742SlQO3KhV8BNcObT9H
	IHVgMloy0Ckfx0OfuKdK1Y6KHftvigKapEOkAtqtxn8Tp7ik1eb5qEJ9Iw9Fe0gWwzXzrYrLknB
	Sqe0R6iFeG7o787arF/KcyVF+mtnsAgFApoBLio0QnoWkKuaKyraF4zvQuVo9vtwk6um5bFuF0G
	nz0DaN83nbtHXuti005jCzQZQ+55SnG3/ceBVvZltVysgwhiv8ghm2CrYcksvQTGhWSnt2ORJU7
	QUBQKlcFQtYFphPpQMex/38GbpdOjDiBo9FoQXMqhtIG/m1tR3mtI03OVRu82YPM=
X-Google-Smtp-Source: AGHT+IGy3sJJ1NWx+Evgv6lnBzDFvoHdGCSaAHyLtLpyhpqlmQ4Ie6WjNK9or+TiujwoFWeIiKEgrg==
X-Received: by 2002:a05:690c:f0f:b0:773:a86d:7662 with SMTP id 00721157ae682-77f946d9d87mr248418497b3.26.1759772292229;
        Mon, 06 Oct 2025 10:38:12 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77f81c06465sm45199607b3.6.2025.10.06.10.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:38:11 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2 3/3] fstests: btrfs: test RAID conversions under stress
Date: Mon,  6 Oct 2025 10:37:51 -0700
Message-ID: <20251006173757.296087-1-loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <55d549d2-fec1-442f-ad9f-875d2ec6c864@suse.com>
References: 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 4 Oct 2025 11:24:27 +0930 Qu Wenruo <wqu@suse.com> wrote:

> 
> 
> 在 2025/10/4 09:11, Leo Martins 写道:
> > Add test to test btrfs conversion while being stressed. This is
> > important since btrfs no longer allows allocating from different RAID
> > block_groups during conversions meaning there may be added enospc
> > pressure.
> > 
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> 
> Please do not mix patches for different projects into the same patchset.
> 
> A lot of us are using b4 to merge (kernel/progs) patches, which will 
> merge the whole series, including the one intended to fstests.
> 
> Thanks,
> Qu

Got it, sorry about that. Should I resend the patches?

