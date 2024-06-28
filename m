Return-Path: <linux-btrfs+bounces-6046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B0E91C6DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 21:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B969FB25990
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 19:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3429674059;
	Fri, 28 Jun 2024 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="nQixRKfX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD64CB37
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604170; cv=none; b=hQk0hMYglOJcLjH1On7ti5580qf+FlHophb2qsxPu1nCbLVZPQ4QKsFfcM00HK5byCI3XNLeBwMK224++4AnKK8QiR+DVLEQj83jydT4sQlqg28+PflUcBw1xZuEq0S14a7q4sHrN+meqBSftsCGdpHuLd4T8Z0no21ENUiFvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604170; c=relaxed/simple;
	bh=PvKADmlVxYjqa/jS+nYo6X4Pq6FKFwD+kdm0Bh5GnQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZvcwzWLLa7OMe3TKYcZCHriQ+U0MyGmN+dVww1JdQe6eeSLUaGmNleNGeEi5NuQQcKE5dt1jFv6pmPGEcZe/gKkvh9+4V1EpxZSi9VpZiBzcQj5InVQ1JfZt6uuJj+4YUmD8p3bAAJgDyR06loXm2go5ZKJSoc3jpbx/9dP0h3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=nQixRKfX; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d5616d7273so491693b6e.1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 12:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1719604168; x=1720208968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnU/wpo+CTk7TlX1X7oRr3+ubP/Z6xnbR/bzwJcprKA=;
        b=nQixRKfXT0Qx9BCsxkk+A23hFZgbtM5LG1ijxztX/8dpieV++h+kg9REpaY1hMN3zT
         dDIM+Z/lP9uyIWDpnjiq9Xiy3VDa9jmV6M23oSYolVSVBdwG2dn+oT6dJENZbdU3PQuR
         AwDuN5IunhHlVvkvlBpvBGrBN/vv4ag0buok0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719604168; x=1720208968;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnU/wpo+CTk7TlX1X7oRr3+ubP/Z6xnbR/bzwJcprKA=;
        b=B0tD3CcQJNF/xn+/EEM/lDQWPve+CQ9qJUC5wwz3LRCibp8xSPddhQi0a9d2S3JoUI
         atZ7mVtC3zso1+/uHnC/G9B7CzIO0dzHNln5oz/NYjsMjOp6yk6F6qKol18qx9M7RoyR
         LiGCnAeDm82kru+shmBbVhUekMv0n87r0yTh2sdSJGwmju6JmPo3LSe9PotV1smxvl2g
         UEM4TGZeqUzxFZc078g/uj1UO341SY4Xvr9omkfsQP9Yo9vBMfI4tUcjCaSnYcf0TdCg
         CAiMAEPLh7Gfch07qg3Q0NhCL1c48FDOrPfTys9cQOczTnT8EAJ/BJsAZ8MTiUxWmLmI
         DhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa+Nr4IIVEv0geUEfg9Cj3Ihi3jV7CN1mjyPTPHtlQLDo8+ZZ+9djC6sxjX47XmpO+NwzAGhLfAdlQAgNEo5VKUFIpQfmGyNwXMF0=
X-Gm-Message-State: AOJu0YykMFXpuO61xGYnfcQRR3A9WYhYZbpeLTqd06Q6ymUYsouV1Bnx
	00upJnEVC8qQMCKM3Kd2Wg7Q1lBUDFiQeydp8GOlYgqUNS2NDUgEFwnZSMdLT/g=
X-Google-Smtp-Source: AGHT+IGtyVi9x7bMQN+HWJFbl+FolrY5Tseim8OaoalrIJ0xSmV4bjcezWKfETaUmEetGgP+kYNY6g==
X-Received: by 2002:a05:6808:3021:b0:3d5:5cd4:5a1e with SMTP id 5614622812f47-3d55cd45b05mr12923350b6e.1.1719604167500;
        Fri, 28 Jun 2024 12:49:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net. [187.190.197.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62f9e5fd5sm414579b6e.22.2024.06.28.12.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 12:49:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Alex Shumsky <alexthreed@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>, 
 linux-btrfs@vger.kernel.org
In-Reply-To: <20240618214138.3212175-1-alexthreed@gmail.com>
References: <20240618214138.3212175-1-alexthreed@gmail.com>
Subject: Re: [PATCH v2] fs: btrfs: fix out of bounds write
Message-Id: <171960416664.3614069.18406891022167257775.b4-ty@konsulko.com>
Date: Fri, 28 Jun 2024 13:49:26 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 19 Jun 2024 00:41:38 +0300, Alex Shumsky wrote:

> Fix btrfs_read/read_and_truncate_page write out of bounds of destination
> buffer. Old behavior break bootstd malloc'd buffers of exact file size.
> Previously this OOB write have not been noticed because distroboot usually
> read files into huge static memory areas.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom



