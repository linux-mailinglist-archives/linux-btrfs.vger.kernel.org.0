Return-Path: <linux-btrfs+bounces-6221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54859281FA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 08:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EBCEB23EC9
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 06:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE8313BAC4;
	Fri,  5 Jul 2024 06:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/xtKinn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F271E494
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 06:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160544; cv=none; b=Nhma0wDnPEf6Dv7mKKmlurEa3HIIFUxkFLnBH8T4uPZ8c50e8LegklbrMRBSAfgWAICM6P0pvEm88jSA/QRhf4UzbblUJKxqG3QSOgYZSQL8tzOux3yiT5Tu3bORX/XxSv6rgNwBnMXMCNuqnc6rA5jSnsd8UmtC6ts92Mj1iIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160544; c=relaxed/simple;
	bh=u+rinPr4BOovizYI+iNCL7vm3vGJIFs4hXjaBA9DMyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQAPF7pKVQUs26bkgW+ORUoCUuU/s+4Lz9+Kt6VdK5MQ8iCxhGH7iBctoogQmy8RozhkCGRPsx/rtCcFqXiSZpzBYraWzgc3r1K/R6WSQ13jJzLgs+DbZNIqRgEkr9+nfGlxc3eihiNZ8lfCk1k37GTsf9+w8OVhqMWVjmkW0Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/xtKinn; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6519528f44fso13002917b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 04 Jul 2024 23:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720160542; x=1720765342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jwBPY5tlgk6sPT4ggjtLuqpin6NEGE9yOx7XXL7vQYE=;
        b=Z/xtKinnl6ruSSiCUC3Ob7OmhF2CGBpHlajs9PsVo3KaBP3E726ri7U2QE/ZvR2kiQ
         OZmRW8VLx5LUaB12R/L80HDfn/U3B3QZZwrfPp6q0NszSbx7tAqh3o6/QA6QZbRIgJaB
         eQVGGCD0CteLshVQ/Z54lzmb596O72JZv5vWFecswvujbwRx+pKyk45obHU2JC38qxCH
         8lYlXbCybrttUq2OPn/suZ0HlcThISy2zkHzrEnCB3Jd5VkQ+mh75joXIaBjKnwcrS2q
         PAv5wkWLekrPq7Gl7t2UmJcpzGQhYoDnKyHMVOGhVmGwdX1aE2R6Wi3hZQYq04KoBMXH
         p/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720160542; x=1720765342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwBPY5tlgk6sPT4ggjtLuqpin6NEGE9yOx7XXL7vQYE=;
        b=ASF1yJEzTt4yrh3TVCbgqmXF1zDvR6uLIDtdraORoBpDFb+thCUZfqV2GnXDyO55+W
         6eU04Kvhh/emaFHeSjPxQCfcebqZx7PRghg9PHN1LpxeO5X9RMycmd+Y9eWT/sC+ODtq
         0rBbQP8mbZ0xQSSvFxys9Um+ToNTlriy1Tj5RWdmNGeYbH0OIbPp7tefYW0lebvewUjp
         LpeN0mtiyJ7e8Q+xvTNfZxuqeHBF3MbIC+dKvmnAlDT6Uk8/yJ2TDusLEbmeC/3r89X8
         mow6s0hQTT4VULW0X2nHMSL+CfWFJP8aZYU/ssWKomUtRBaffJ+Qh9D9mI0YhdrTHD9N
         5PLg==
X-Gm-Message-State: AOJu0YzVpYa0Zfe6wMxevhkpSNxnbjR/9sZyc399SR0mZBxLAgvrQBm3
	zW6JMPpyxYUegg0/NhPIvq8zjL7t3V69GM4+2Pc+e1iXL83G9fR5839T3CMdo+TNKSv2XhbvD3/
	1N4v5rp/E56nh9ld628/aH6OQGU/gSg==
X-Google-Smtp-Source: AGHT+IFdXYceWAk45VaUEcIsEGYzXzjB9FrVI0yMLiNe3mWIXIkZeMd6Kye2g/xSvqqxZdbFzK9qjEeSQId5NlttF2A=
X-Received: by 2002:a05:690c:fc9:b0:64a:8d78:f2a3 with SMTP id
 00721157ae682-652d7c538fbmr38632127b3.30.1720160541949; Thu, 04 Jul 2024
 23:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0163b37d7cdb31ed39e0eff2f61cdb4f3cd90272.1720137702.git.wqu@suse.com>
In-Reply-To: <0163b37d7cdb31ed39e0eff2f61cdb4f3cd90272.1720137702.git.wqu@suse.com>
From: Andrea Gelmini <andrea.gelmini@gmail.com>
Date: Fri, 5 Jul 2024 08:22:06 +0200
Message-ID: <CAK-xaQZLYvyb-ktrKHBf_yPLY3eF9b+mM1wCW_4UB5MXW=9s=Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: skip name hash check for image dump
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno ven 5 lug 2024 alle ore 02:02 Qu Wenruo <wqu@suse.com> ha scritto:
> Just allow image dump to skip the name hash mismatch.

Thanks a lot Qu!

> +                * mismatch since "-s" can generaete different names.

Just a stupid note: "generaete".

Thanks again,
Gelma

