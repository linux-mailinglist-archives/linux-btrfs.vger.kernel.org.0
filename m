Return-Path: <linux-btrfs+bounces-14790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A4DAE08C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 16:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421241767CE
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jun 2025 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C121D3E8;
	Thu, 19 Jun 2025 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laKHZDW+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2FF17E0
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Jun 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343515; cv=none; b=PxVjdOQpn3wh6s8yqsHlxSC3mMngwBxQPqnmwHApNnaTTiJ9hj0vaGYElurmxcyEOUxNl6Qq5B/9Oq1f+cbsjGw3miYCEsHAegsZTFXyzn3MmP7Kr+722I1FfxXWEZoUicI6b+abxgmxZ18SKYnFwjkhWEvKoY/QrktQNPcP7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343515; c=relaxed/simple;
	bh=5Wxwi1M3RwtEZ4dYs/EZEYqyFiV++dltEmaue1ccCaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bd5UT+opTnPRdNTyqehAHMmDG1N26yrcggW1pbgkQBNNW9yGmEcz3SSpwNw7e3mobjj0wym5g7m4kOFBF58l5B42+ph5FCtg2dENV5K/VZpWRC6UEyvFP1/pVWv+XiWGSUrI9PjRJAAuRsyeKZdZZxqCH1JH8h7WQDCFTejEUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laKHZDW+; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b31c9132688so98586a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jun 2025 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750343513; x=1750948313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GvHPi8Lm0jscGsujRLa7DeAlT7NAfqkDAI3AUij/6k=;
        b=laKHZDW+6l2IkPBd4armU18pY7neu9Di5ksQ0fSvyQhqDwxz05jdCt0rtpIbPFSQCe
         lPL+5BTVlgPOTNYaj76nmhqdIoBfvRUguREThmgux0K91n3ItHKPb2sipl1mMh9h2Kv2
         EdC4jsaYJdx6bIQ8EgUw3uJq+ctrKUKEPlzYiacugIWnyOO+LTn8pLDAyiS6kti8pkUC
         Ia7T0t9OdxtkILHaHmkbNMReDqQv+Gs5PcbFzuZuQkc0tKbVRJEupGpfj7JcWlhwSouB
         ma4HEYBQ38r3X94B+yAAnmj7D7pLW319Cd6+2rOnvRHizqML+pTf/ytDcmJYWGv6zs3m
         94SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750343513; x=1750948313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8GvHPi8Lm0jscGsujRLa7DeAlT7NAfqkDAI3AUij/6k=;
        b=kkr2bcuca2J7fNyHrfcQ9Q5a+nU51RyWEne7ZZRc0uOTho++WWqX87dm0uMY0FOrG7
         9ojNBRRXgmkryLKsk/aYFJTqE8mwFih9OMTGXAYnRfbpcQS1HoR/1qcQYlbNJRWjBk5/
         t+Yefrqg3WkGAZ20BGoUIqGXe6SYpfZPZeRcNjNoYfyV9w+5jk8mN+ppiSQMgc0TXE/G
         Unjez5m09o4KlZfTC8r9aKNAA2XRGDdpJVI34dyvXsC9/WXvb+IQWkJ44TDPkuV3Yijo
         JSwyV5yMe/l+nfRnJxWhPUnTnydZpDPOvpL3StA/Hr5xfvAl+b5LTQ/SbmdpLB5+4RLi
         0fpQ==
X-Gm-Message-State: AOJu0YxsSf2MZi9GPH1piYAf5Erl09xbD5Gfv1MshVxkiucBPo1WhVpk
	e/G90uOIQDjHOFN8tSSLW7iFwz+pJ1WNOWanZ/KT9tOxoIJ4VrCoY2H9ggi50tjDknrwYQ==
X-Gm-Gg: ASbGnctT2CZVZ+2g5fKWPEOvpWaBUYmOmIc90fgc4/tbnNQ40WLZ0F5zXviUJzpcTJF
	DtGMSs3O7I/Sg6ObiG+DgI90IemkyCV79cZBtKG9lDaK0U7Olgk7tgDbyTiXY258s1JxRLJx3lf
	ftfwgGY1H1MtWg/qaJ2Bmy0F85WPvCDpJ2wZAIcVZaNaNnyG4noQ9TuBsvkE/Ej9vzAHxhdIF8y
	l90vZkAxcBCLA5hoPbzrVrM11yLYOHGxLKMyjXvN3ZXFCRrcgQi9unfa1Ke+sDlGFn4T5u0ciok
	nAvrIf57F6gplyvL3OmsAz1Yhlfem01viQ2PlfIRgXsEO2Kx4tXVoRk82aOSR1X6vsXoNw8=
X-Google-Smtp-Source: AGHT+IFf1xKK8zReqd6zpspvpxQSUg8GyM24DcLQB+UYFkC4qghs0jHO6JJHUhg9ByKBfz6UbLfXRw==
X-Received: by 2002:a17:90b:4a07:b0:313:151a:8653 with SMTP id 98e67ed59e1d1-3158c004765mr1852867a91.8.1750343513041;
        Thu, 19 Jun 2025 07:31:53 -0700 (PDT)
Received: from saltykitkat.localnet ([154.3.36.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2450e6sm2270486a91.19.2025.06.19.07.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:31:52 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Subject:
 Re: [PATCH 3/3] btrfs: replace key_in_sk() with a simple btrfs_key compare
Date: Thu, 19 Jun 2025 22:31:48 +0800
Message-ID: <22744172.EfDdHjke4D@saltykitkat>
In-Reply-To: <20250619134329.GM4037@twin.jikos.cz>
References:
 <20250612043311.22955-1-sunk67188@gmail.com>
 <20250612043311.22955-4-sunk67188@gmail.com>
 <20250619134329.GM4037@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> I'd rather use a DEBUG_WARN or ASSERT here. If it's a runtime error that
> can otherwise happen then it should be handled as and error.
> 
> One way or another it's good to have it here as we want to verify the
> assumptions of btrfs_search_forward().

I've just done some tests on my laptop and the result shows we don't need to 
worry about performance here.

And I totally agree that ASSERT is better than WARN_ON.

So I think we can use ASSERT instead of WARN_ON here.

Thanks.

-----

Sorry. Resend with CC.




