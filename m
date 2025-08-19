Return-Path: <linux-btrfs+bounces-16148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8B5B2B772
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 05:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AAE1B28798
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 03:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854152D2494;
	Tue, 19 Aug 2025 03:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqPH4HyV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830C8188906
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755573204; cv=none; b=ZzNf1HE0hT3xH2coQ5b+LD2UUPPjAUVf4m9KNvRrXw1qyFoXLBwLZ5e8eeJjKN5XG5WI3u54sONAh/s0e4lmljmZD0gvb6pR/D1lkVYw7j6G6M6y4iCxKvQ4/ZYfhFHds8++KYEsS4ACrBYUw6HkfAgOzDuuxeJWuxmrIORlCTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755573204; c=relaxed/simple;
	bh=VChNtWO3JMPbbAEmtHalCnhdp8QnonSgFHMXBd4KFAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVnq2pKJ/DRGGKQ/uKfmvsk+7YzjYZvbPWOuMsGyK2gY11ZKNZ7Fx/GDJNmZIBDHGzwlXMgVhMMNY2M4Q9W/VuneAS61edL8pds7oUehWk1TnvY4YQuYlgnJFF5y1zN9T2oZs5FQpLWpj0iWObNSaEniYi9LIIYQm6BSms4rTNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqPH4HyV; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-76e2eb49cb4so111465b3a.3
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Aug 2025 20:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755573203; x=1756178003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tDf6bwvqrAPEPuLZCBIcMSaXLD1Ewuz0JzLRTRJGF0=;
        b=DqPH4HyVqnOoF0UUJRJHSoQA7kmFlRNeXiB98z9P02zypxDgLunwmvtcLORMTfdg4S
         eyWBryVEXh5tt02V7R6gBzzsKg4ZMLa20lHUitXVKU+5NGlBUylI+qSUauw8Hymf9VVC
         cJzUlQuQp3TbaUNwv/2C0VQBs8aZzYL12nCXg0OsgK8qsmvkYqNNU4Y8aCaiQaw/w/Wg
         fVPAUMXqLI/OxJ2VZKitArpJYOPHrqK+8WAY/N5hyUV5QgzDIjnKFZoykQB4T8HG7E5z
         DEew+B2qrgrQuRAgLFQDouDFKjPg09bqZ8JbGspAV3smP0Fvjr9kPwApEAiBonXZ64be
         YRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755573203; x=1756178003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tDf6bwvqrAPEPuLZCBIcMSaXLD1Ewuz0JzLRTRJGF0=;
        b=neRGlrcbXPObTuyDIPD8NEMBr2qhKn0djv/C8GKHVs7+0T6JBIvK2i76fsPdWdQIrf
         B3k1RFO+SsAJYmN5MyKUeBqwoZB13u6YO3IWDqas7/QvZjYKaWluMf76vR/pjQBFNi4F
         J9o1EcLz264rFdt/FbAXmO+ztAnJxC/n4hpI1FScrA7NgZ9mgO+gLbbWl2YErbSJZGGF
         KD0Ax7hajB6MtZMmO2MZo2xD6Jx8+5hS1JGdFMDBUJqi1sC+mPtjoH2B8rkIrHhQH9Op
         +lpyCOWaPT8MEW8f49FJT2jecdb+9urHjoG6DqSrHB0s2Fsdoh2j8yU/6Kw0G4YDag0t
         kDug==
X-Gm-Message-State: AOJu0YyLxB9TITO1KiWjN4qESp1dMR0rhOVBzs+mrm61gO+KZn1sqXpw
	wL28aKpe5kp9dXCPLqfG6MKNXilPi7+SBd391ZzP1fIj5XJUnxpG7yHV
X-Gm-Gg: ASbGnct7/tQYqkV6hdcfc70QIqtQyq+p0WAuJoF+EoD2WXF3h8ZQxBuPeLXySlsCeEF
	HlLOKiBSLIYWu/M4bdhJ5qI3Ep6qf29BPDlVzkerENjPFEQJ390ksUqyGEd6l/SpvxzlIVxsQRM
	pCN7xmuaa6zUWMieX4H50IJILkt0jFBIcpMzNQVt35cffXUaq8qiAtmGLaoX9rjDYagrlOUNmWs
	4Dyi+e3imqXRkRnQLQKWmX/NNzOIr9yRCDX9w5kj5VxJJDi8qvaI4haOeG0foR+YlNokcf06k+E
	1nc63QjSfZRL5NUekA9q4WVqciDzb+56pZXYvufD6TnEhfflry3X3g4KA5PlRtqZz01G4XCZQ0h
	WZfaKEqloUxXM29Rvv5aSWe8K0JApnAYr6NP8Kcr/RIetiX721fFtanE=
X-Google-Smtp-Source: AGHT+IE1M1AFlC+ScRcow19JxIPCStQT5XiQMgQ8vWkP2+duoaf8spLOCj0Ai6CPmDz/3llhF+vULw==
X-Received: by 2002:a05:6a00:3904:b0:76e:34fb:a806 with SMTP id d2e1a72fcca58-76e81176b26mr609207b3a.6.1755573202795;
        Mon, 18 Aug 2025 20:13:22 -0700 (PDT)
Received: from saltykitkat.localnet ([156.246.92.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d546484sm974559b3a.96.2025.08.18.20.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:13:22 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Remaining BTRFS_PATH_AUTO_FREE work
Date: Tue, 19 Aug 2025 11:13:17 +0800
Message-ID: <2231129.irdbgypaU6@saltykitkat>
In-Reply-To: <6181995.lOV4Wx5bFT@saltykitkat>
References: <6181995.lOV4Wx5bFT@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> There's no such pattern in files beginning with p, and files beginning with
> z has been converted. So files beginning with [r-x] need this work. I'm
> doing this on files beginning with r.
Also for files beginning with s and t.
> 
> BTW, should we also do this for files in the test dir?





