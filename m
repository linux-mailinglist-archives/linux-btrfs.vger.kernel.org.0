Return-Path: <linux-btrfs+bounces-17953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE3CBE7E2C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 11:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528D8582BD5
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932BC2DAFBB;
	Fri, 17 Oct 2025 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgUp1n6S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335022DC35F
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694480; cv=none; b=JccjVVxZ1orNPJXccubGzwCQQHo6TQlKdueoEUgGj6ccO1jhORYQrDWeRmxOEPpvgu2hJbw1g86ET/RVWDE+M7UfJD5QbgrHeAGMDWCslC1Z6YGdF7GaGuoTEwDAF2UQvwGld8GMEcstDBrsR2mcyGyUkZE/3ud4cwjOF1xIuQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694480; c=relaxed/simple;
	bh=2qef4Dg/EYUXtmUA8ak1qqQonP9U+75kcC+XzKvNo98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0MokPXvWUG3D8eODjtkyNKXQ1APwVuyeDDog6F+RCfV2bA+oMKVC5grm0fPj8I//Kfa4vSfV8rHX60ZK5GKpfw7PwEHYelRZIgyUSZ3jlA82NfvpBtv2NIeRgtJqm7KEgE9Yiny3XxcR9WWT6Hq9U6SUwISjnmNbJlkqS7WjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgUp1n6S; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4711b95226dso4197325e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760694477; x=1761299277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sy0yRAP95BHj2yzNXIG4IFb4N7T6aaF0gqCQs98l4vQ=;
        b=SgUp1n6Sd3NIlY/4NkJgG/jKwq90XzvjKZIc0BchRussjS/LKbbhirbDcut1HxQh5c
         v1ebHVZpG4u3y+t9ys1af7WqXLJcoHqgxmH2i/1T/mZad0fEoPbwvsWyb+q+8Zt65rIV
         3zYJMMKErhEjqQY1CozhYKEhmB/8p0g959XNvqeuYE69C4uOlgAthYtOrJiiLOJDoNtF
         3IlnEkW3PFaKQgP4rY8olmQ7TDUD+KDU+y5l664BqOTD+yzYU5N9SvvB9IPitwbPAfHx
         jmCMvqUQueGmO7CkdNIr0tYRxqiqCf8qZC1cgxTGekK8yqqC3a7YI/frtyVjGJn5TqNH
         2hjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694477; x=1761299277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sy0yRAP95BHj2yzNXIG4IFb4N7T6aaF0gqCQs98l4vQ=;
        b=cRNp9pXCGgrp9B/xjbWLldLxgxVmJ3h4RIOcqncMiBHyOz8V0RVDwaKnibXHDk35Ba
         /7/uNBDpnpV/wod/9EOjMYmU6WbhLaaEVGwuSkpjQd5TzxuLkD+Mu+zY3CKvCvAXcfh9
         ukk13vQzbBPOWb0g1DNuOD4tNXtDQTbC90WgZPbXTwlRxHbpuMLCJG6fw8R/PzvW9JAF
         3fi2e0HJwxshxseygtT08415Ep9bv29MkFdkkapvPOOFpnMYnLXsS5cS2EocpqzVM7nP
         5azUyUdH520HSOSeCuxYdaI0NYxdj6uXl8q+Hu1SQvR4cOBFNiE/UdVV9AQzHvqu6wJi
         8jOA==
X-Forwarded-Encrypted: i=1; AJvYcCXZNc5BvQuL4gtolqWii+USdjZKhFZ7F/lgAOMoHnt1dyOQpzHr2kIMlZldWGoNxcVRcHCIsos5iza5WA==@vger.kernel.org
X-Gm-Message-State: AOJu0YylpBYdBxSzT4dqK4nPTqbI0fvW+FzV+NoE4T8x9GjdZ59RD5rb
	w/DMB+9KoT7pgWe8Ri5UoWT+Lab4PPecmVpJXV5uRuCb59nt5mKYEZXS
X-Gm-Gg: ASbGncvWuywMLWGj3pYHlgAYGAQYbtNlKMVRAU96XdXWeQWqll8SRffj4eFvP7HO1lu
	rQfk+FGhDZ4yIahSwlxpmEC6shfmIx2Y3GV5tq5EWtr7xy4tc8nY1i1YrZLC2v7TG1Yv1R1hy5e
	wgSk5000siX8c4Nm2SlKH3R5OL3HjN7x0yd7ungA27VwIHrPUHbQDdwHyPBTOmp5JPjU1rEHhyh
	0xr1pEv5D0lKbVdHbV4iToaS19Yv5GI/6o7aOZQpzBR8NsUAKdcTTAqWbrE/fZzaMa+WbQ7HPzu
	jcliP0XH2DD661VtBaGbXmg4hNu1wY8TFv0rboEhz7KrzkQtqnJ/Ori5YdvpSp3HPfhmnW21USX
	1m1Y2aw3TVqHxZQwfL4w1acCN0VVUmHBji/WLoDh30KSVvTDMRr1y6qHP+kA2O26ijjU16Dx8bU
	G2
X-Google-Smtp-Source: AGHT+IEEX+Z84/rmgncN9dwcIvVYwxueW70ptCkurzteL5x+sCPvVdVFO0CpBGKQ36u/v5tqT/GgVQ==
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr25608945e9.33.1760694477158;
        Fri, 17 Oct 2025 02:47:57 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4711441f66dsm74496485e9.2.2025.10.17.02.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 02:47:56 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: wqu@suse.com
Cc: fdmanana@suse.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] btrfs: scrub: cancel the run if there is a pending signal
Date: Fri, 17 Oct 2025 12:47:52 +0300
Message-ID: <20251017094752.1171803-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <395c1ee665584f092c089d73895d3f316730c6e8.1760607566.git.wqu@suse.com>
References: <395c1ee665584f092c089d73895d3f316730c6e8.1760607566.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qu Wenruo <wqu@suse.com>:
> +	/*
> +	 * Signal handling is also done in user space, so we have to return
> +	 * to user space by canceling the run when there is a pending signal.
> +	 * (including non-fatal ones like SIGINT)
> +	 */

SIGINT is bad example here. "btrfs scrub" somehow is already able to catch
SIGINT on unpatched kernel.

-- 
Askar Safin

