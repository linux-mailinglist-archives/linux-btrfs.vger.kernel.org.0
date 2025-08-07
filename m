Return-Path: <linux-btrfs+bounces-15906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FF9B1DA8C
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 17:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E6556275A
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B289262FFC;
	Thu,  7 Aug 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bxxn65Kz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52B22C339
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Aug 2025 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754579220; cv=none; b=u8UNcANyw61AxVf6P6wKA5SiS4hh6XS+gMVm7MRtSCnl33ZlgufSj83aHFLexvDgIt6UKnoqX2WyUgSJ2laMtDaOoj81dnjf+vp+pnX4ajam4foPh8j83U9Ezk3JwxH3TzPxKNajExlppX2iUwC2cwvuHvE0b5bcdKH7V7LjLUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754579220; c=relaxed/simple;
	bh=ZklnTbrMreeXfv9dx9BgOVgwJSczoLq59Vj3CBg62Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5c4/URLvxkMXejX5yLudDQhT8BSJys1lXstxCaj9cH5QalvnEXZUemHfw7LyhjsKJm1wq33R0dGA8In5a++KCMeNHNfbT5mB0cZpWcXbJ4BG4GJpy3Xb3nPuSKACrUMW4MWpIdvaWi3eO+aPL19avCMYhpnWnpxk7k63Z/LSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bxxn65Kz; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-31e863a05f4so87895a91.3
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Aug 2025 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754579219; x=1755184019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/9WX8lghGwYTUlY3eRCphOLo22bnl31r8dwNtb2wcc=;
        b=Bxxn65KzF8P97DT+dAdOl6OE6AIuIVP9ioIxg1lItdp2P/kKN8cCv6I+Uq9r3iUlY7
         v2ktSPyWb599hAeEhCL726hIHRoFDiO/uaq5GsUIokENyomY3t4Tjzzt3S93x6BePxnB
         +kHNwCWJ+bj/Xy6IaqYuuD7DhIwu4EIXwg11G/vCpjtf5rL89F3Z0wYxWokRRXGHskgn
         TAplbfgXBTQjiic1VjOgLxI5lO8FqgdyFZbrCxDUF7Enp7LquGh2CRGj2REHaTkrjWiu
         k+5BswCerzr7CnMYQekjMzr27IJmGkGr7HDjmaVzoMdQJp916qWDlZVVTNq4mFH/BzG6
         bD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754579219; x=1755184019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/9WX8lghGwYTUlY3eRCphOLo22bnl31r8dwNtb2wcc=;
        b=a1UC/7C2Wfy57qt0C8syuuwQjevSN735s4CpoQ19LPvsbyB7Z392lw9BPWiuW2LEqU
         UAmPkZEO9vAccWsfaso1x/gjemYiLqJBvNY7o4gYr2v7aD6l5lA/+IyqJ2OzFw9Bi/97
         UW3WBMloYPcr9IJJYJNQk3HEj1aEsJhcLfInOTTOMH+UOqXcgD0CcYRb1Wu10uXbQt+q
         opseP6+DEFtg0LpJ5gaOTWETL7ddyqGooURMGM3gGguZ9sYfak+7QAlLrdPbzfzFkMlO
         5W5k35xS/h4GOsUvTn+40GmobuMO0O2jJyD0qHAKtMM6rPEmqLuRPxmNEMyGFmDBKPtK
         R0Gw==
X-Gm-Message-State: AOJu0Yzwq+TGxstaZNhedH22uvw+THZ3RAzEjbLFU7XtxTsbpivrvhr8
	MCJZ1djB5GW4lfrIhPD5Yejd3u3+a0/UnVp7yqobaTa7SKSaXRF3+Rs1SC2avVoQixtq6A==
X-Gm-Gg: ASbGncu0lg97ffNtiOZKp3Lc3LS62rFRsPxPEmKM4acycrcNMbNHklJTcfzW3bzCRJM
	RnvqAjl9Lsht7lOD+qnR+pa+8WMp6/SIGi1XLl03BV6GwfmrgHNCUS24PdsGt4KpAYmwGllDXD2
	6iNlHGZQ9VG9RYnKTR2xphuqrLpbIanCcepiSvb/wK8hmDalwkcx6g+gZY0jJmEwRu0NXHVrR2X
	UsgwdtD19l7gVPgKLBijM6x3wYDChI4D1/zyqeqQm1DXdYY8Eq4ErksTYCtF5wmdWXcvlA+G+0D
	fqvuE2QwYCMdk5W1M9kiH0X/xk7UW2NPY5Q65xTGCTed6RB/T9LhwSa9CjZ1RWJwcRxZEca/PHq
	bE6CiZnK7z7HEpZux1OZsT3785JCSj4OXcutdPeoywnYa
X-Google-Smtp-Source: AGHT+IH/s8RfA+cWqurOO/+OQbkvW54Ip1LA97UnJNTcYaIXcoxIdVuXDv7KM0yy9C8wGrm6mn+/Aw==
X-Received: by 2002:a17:90b:3e8b:b0:31f:16ee:5ddf with SMTP id 98e67ed59e1d1-32166cc0198mr4409818a91.5.1754579218661;
        Thu, 07 Aug 2025 08:06:58 -0700 (PDT)
Received: from saltykitkat.localnet ([156.246.92.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102a7949bsm10542867a91.2.2025.08.07.08.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 08:06:58 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix node balancing condition in balance_level()
Date: Thu, 07 Aug 2025 23:06:52 +0800
Message-ID: <15559164.tv2OnDr8pf@saltykitkat>
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

Hi, Boris.

After working on node balance related code and fs_perf for days, I found that 
current node balancing is not good enough with or without this patch. And I 
come up with a different way to balance the nodes without adding much 
complexity, which will takes me some days to implement and test it. I believe 
it will be much better than the current one if I didn't mess things up.

BTW, I'm not familiar with fs benchmark, so I need some advice about how can I 
get a reasonable benchmark result that can reflect the metadata operation 
performance since I only have a 128G SSD can be used to benchmark, and it's 
speed seems not stable enough. Currently I use kprobe to trace node balance 
related functions to measure if the balance code works well.

Thanks,
Sun YangKai



