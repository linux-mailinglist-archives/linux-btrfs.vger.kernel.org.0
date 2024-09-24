Return-Path: <linux-btrfs+bounces-8200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FE89847CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 16:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E13FB223CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645D01A76B0;
	Tue, 24 Sep 2024 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gYKFzvv/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84071A4F04
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188797; cv=none; b=G54MTgVrLmrooEzABV7JV3n8wQGVpTYNShOAYm4V725KfPD342rbDt9hZAguo/TXqLoAlkpth5e8YyWIDq15GHGC/JgXJWneHkjgHqwvzcVCVF2wL7JARiGLIDltfh80lvSyLoYlBuRij8rnBbHT63HbcgkxguI9FOc8ZWNgSok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188797; c=relaxed/simple;
	bh=wLI6yRTYpcCIuWAC5PoweuW9Nla+XSX2hAotTzUS6EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HY4IMB2+X2iVx5KoyoXFrkAx5S83XK28c7lSMpQceoA9wiro8hRxUmVvkrDblajTawv9fDso73myfs45K7V3q+yQ5Prd6DCFamc6SeichGrLHfHAq/ng+smG5RUCfJKxHZugbe9KjPZHxno3gmljjDfv05WPUCcOkSi3lNh/Wy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gYKFzvv/; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6c351809a80so40413016d6.1
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2024 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727188794; x=1727793594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BuDemD8gTlEaAsk8/5vD8oPUbVPzsyK/XdXTI7MpT9Y=;
        b=gYKFzvv/YJwUAk/HaNIyoScyzMUZVZdfUZiOr4mM8HjTeoeeNDJRzwajp/q0vecXnM
         hyxCfaFX3asD5hcb01Vo9f5a5OYYVs4dAfQzPAq1M8kGKxzZzpGPybc3kf1SpCbdSQ6K
         OSYdfnI6Sy5DQR+KxyVwTrRy5b2atZ2pSmWImXUarsUjuDCezSTx3lICmAkaKuYo0uVD
         /DBM/pY0hupNXUa/zmnJWR+Qlgs2HNr/chNiuag8x/xzUv5zPi40W6Al9LKRb1M1QNyl
         mChubvswJojCIpNRQYVAuVeAlgXjV3R9iHd1dXzqn4xBb5S79qr5etOj8bsYGJkOz+Gn
         rcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727188794; x=1727793594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuDemD8gTlEaAsk8/5vD8oPUbVPzsyK/XdXTI7MpT9Y=;
        b=SpS5YY4Kq3AV3oKXVsaqIkkj6DHMYWzYsFncQ1cTt7EokZ8D4stybhSdm5PBv0+lwl
         pbFoODWCzZn6UdPxPEXN62af6X74LEshwdTxVtGVy/klIEvcBhLZw0PuH6yQCUi394/z
         kFTd7z8xw6DbKwi+EclWoYntQLBGudz+DI53lIF8xkPC931LenmVHY1oz30g2m1610Iv
         aRB9wBkqcAKrwUTXokvfHVHpcum/FmBiUdTf5qLjXaNSv+boyQBhrQZlwzGpY7E7cxEF
         feGhaZRRAE/Wipo2A0W5+Zmzk6TNtR+dZJWF1WHPEdf8WVwdU18FTdhgdGlo0iskruTZ
         0T4w==
X-Forwarded-Encrypted: i=1; AJvYcCUJTsb8h1cIxwpl8s5/KP5UC75rIetpBbYBXvMz5jl9pj3Ygh6J69iLrpFXmWNX/CjDozeUTAELMGlrJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNWDLwBDxiBPFop1Yi0Vqndw/Zvc9nogFThggd6Onl1SQcQ18b
	yr/aSSCMT6hd6ALLCyIpjnpYKj1D+d5IuePOort0MtGoTDTu4HR4tBtBl3TXg4g=
X-Google-Smtp-Source: AGHT+IELdbrs0UMWs8mpHf9kgrpUtyfYDYVpan7tLS4ZZ3wt8yrHWFPmKR2jpJj9QCUkq7npUPisJQ==
X-Received: by 2002:a05:6214:4349:b0:6c5:5418:a055 with SMTP id 6a1803df08f44-6c7bd58551bmr240228246d6.30.1727188794516;
        Tue, 24 Sep 2024 07:39:54 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4eb817sm7120046d6.71.2024.09.24.07.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 07:39:53 -0700 (PDT)
Date: Tue, 24 Sep 2024 10:39:52 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Chris Murphy <lists@colorremedies.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS critical, corrupt node, unaligned pointer, should be
 aligned to 4096
Message-ID: <20240924143952.GA183026@perftesting>
References: <47636de6-8270-4a24-b97a-df9c267439c7@app.fastmail.com>
 <2ffd987f-f767-4fd2-b684-0c95d418a977@gmx.com>
 <8fcfe0e4-5db1-4cd1-8f94-5ce049086f9b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fcfe0e4-5db1-4cd1-8f94-5ce049086f9b@app.fastmail.com>

On Mon, Sep 23, 2024 at 06:02:31PM -0400, Chris Murphy wrote:
> New comment in the bug report: https://bugzilla.redhat.com/show_bug.cgi?id=2312886#c4
> 
> Except kernel messages. What's interesting:
> -  multiple arches (also s390x but I don't have any kernel messages for it);
> -  single workload (koji composes)
> -  the btrfs error is different for each, this makes me think we're not dealing with a btrfs bug
> 
> But how can we get more information about why this is happening? Is running a KASAN enabled kernel useful?

Yeah try KASAN.  I'm in the middle of a different investigation, once I wrap
that up I'll dig into this some more with Qu.  Thanks,

Josef

