Return-Path: <linux-btrfs+bounces-17979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66586BEC713
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 06:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6A5435300A
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 04:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4DB27FD5A;
	Sat, 18 Oct 2025 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAKxszOJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7B8F6F
	for <linux-btrfs@vger.kernel.org>; Sat, 18 Oct 2025 04:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760761023; cv=none; b=j+bopEd0Ww+DkVw+r0jLbHJtuwXW25+Gr0P6j5VPtkODGzRWC+h77cXVsrg1JV+Op7hXxDEThrxV1/kiet4UmwqXvjgBltOsQR2TCmF6dbe7KrHj+qIa2OJMca7LTwydZN/Mhyv7s4M3MXZNxCchrBaBrWP2GLqWRHZJQ0X4eNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760761023; c=relaxed/simple;
	bh=xB/aHk8Q+susr7fQF//xdmo3UGXFOuXF3YGFmG8x4e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCJ1fA2LPl4bS6AdNH0M/2SZrvrTLbm3I7tMSxESby9gs5/1lDOirq8/H98bwmDM6hw8SnQXI6aM2Br9jUMtn1YhrpcXDUl90s43paewVNh0F9bHdffPyoacBMuSSE20JDCOLVOSTyQjFVMXMQhhErtQN0m0iVf0S4fHOdB+sWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAKxszOJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4711b95226dso12350195e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 21:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760761018; x=1761365818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvE85BYqWj0Tku7HsHAZ5O6jVmItc+XNsLX3RVWGWks=;
        b=UAKxszOJtTgG7hYYFulWNLo1cwAIiVXCmF0eEog4smDtNBc5t5ZZelKYMN3RRd20a1
         Cl2uySDHTyos3SEITXRF+rtRAJi4FJA50d0N5ZqI3bpE9QPWLFlAxQf5jq3+db0zQHPl
         0asvqlFJqkFjkAAaza8tGYz7iddcevSsby0omvpPqxoOVAZp8sp/XyDQU4WG4ROoyu5V
         c7wYu+ab1mqoXBsosEuZKhsh+vIwmOezcs/qmfjqN02Ikl0xScnRCAQzVJX8aKgIKGJo
         rBRfcFT8hSNcJZDqvuVjaA7O1m/55vuWhUYWU+18SaVjRkvrocRBcANDcNrA98zX9/jD
         J2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760761018; x=1761365818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvE85BYqWj0Tku7HsHAZ5O6jVmItc+XNsLX3RVWGWks=;
        b=K2Knrj/xD8kUDJfZIIhfF+X5sFPnnU0RMPeiTOAdk9+VRTzsm8gsoCFmbDn/PWnU0i
         13RWDiVYe1+F9gFKwVS8iI2e4xvXys99xeST3mEHIlRYNh9WI4DoeMuxp6FV2effWgXg
         rtBF21zsCg0IZ8Xk5zo14ldjufKO/mPKCFI9Qser7oeMXEu1dbLNCq5CLYmHWydmLWPF
         0PFmVJS4aKBtKCRh7j6UKz5fLCAJQ94ODrfTPmbFC7SWQcw4WUQ5t5hM/h6ph5WYP1/U
         azNZerCOakLVcCkzzLA6X+44mrNvZcb+nXBsGO4hE8cW7SuATLG9qKjBHpdHLZNixTdh
         Pi9w==
X-Gm-Message-State: AOJu0YxHAKRSBG1JxPYh+4yEtJqUuYF4GKOm/fgmj1I0662dXnCakJpC
	lfxqMF8Z+4ttH0I/HNK4tT7RSnXXtvLxT2DS0wOLH2lwFLLZ/tUt7Fl1Ojv7qeRB
X-Gm-Gg: ASbGncui3lu8KHb2bXc1cVxo7NGkgpbWasaxXn1/izUrqBKNVorYuZQYUeDEX3HGhFo
	RRwSE6GWTGc38NAvOMLW7zkken8oXoIWR60U7wb1/hqTXLDBDLkzgYfcDumzQZSqDqScUpd1GWO
	GapT7YABWUeD/krQag6lnIb/wWFciSFn9goWpb5B7Mcg/9YCZ5u+NriABpDnZeGojxRKT5fxauQ
	3eydVHqD7Z/ZGyH4Vuf1IfeeD1Re5Qy3J0WVaSb9r2Pk9ZbQMJiA8pPKJxrn9/ROMMDvGrCD4po
	yrDgdE+kSetCSEDEKJoYOL7/L2CuXJEVlWfokpIv4nsVvRgy7R8gnInndwJqcOg0v44MX62dlcf
	S67oNDZLePmGJIsNhqBms5jTei8wFZeyFLjnRIZhLz1tWXuskTMp6/ySpwesq+a2mLs8S10fOfv
	10
X-Google-Smtp-Source: AGHT+IHyIiyJ0Ha66IwJXWxi/Q4P8LhxoTBm/WTxS/urT5jSEhhW4k2QrviZDby/B3Vq4UKU9ao84Q==
X-Received: by 2002:a05:600c:3b8d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-471179176b9mr52492125e9.28.1760761017841;
        Fri, 17 Oct 2025 21:16:57 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47112bdf6c2sm56156045e9.1.2025.10.17.21.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 21:16:57 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: wqu@suse.com
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: scrub: enhance freezing and signal handling
Date: Sat, 18 Oct 2025 07:16:53 +0300
Message-ID: <20251018041654.1144286-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1760607566.git.wqu@suse.com>
References: <cover.1760607566.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, please, add "Fixes" and cc stable to these patches. They should be
backported to stable.

-- 
Askar Safin

