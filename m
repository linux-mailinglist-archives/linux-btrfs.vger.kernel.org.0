Return-Path: <linux-btrfs+bounces-2599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D932485CA5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 23:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED7D1F234BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 22:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338DE153510;
	Tue, 20 Feb 2024 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XPVG6Jov"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84E4152DFA
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708466744; cv=none; b=kQSol+YPbWp19ORb0Jx8AhYbiUQxSkWYFWEEhRYqv/CbO9Qe2dERLg1l6Ck5R2aGrJK0LBdfeSenjNsgl9CIu8A0yjfgE/0OtkeNG14r7MVkNruBI+KFRXNva3Gb5YOMCvCznObDLK7Xwj2DM21H5/fwBr2t3kJ7qCBzxomafGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708466744; c=relaxed/simple;
	bh=75lg/qgBc/1j5MphW+ZyZV+N/b+e3l+xbuclvUi/Usk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+5nXekOKkedxay/NRqOllqMzKWkcl7fNHoh+NJHtSrWOmdPXtfEP0ToS0x7cOj821EJzGU4KFsRse36YZyM2phAV8RyihQb5Bu9t//6z/zspV8FyF6Sm2bm5+s0PmHVjMS87amquvEloogPMpMWPk2zi75kwCcLWPEsd4oP/2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XPVG6Jov; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so6149339276.2
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Feb 2024 14:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1708466741; x=1709071541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/2G51AsG1bsr7uNPjzTnaLkotIbnpZerEq4UgFBBh8Y=;
        b=XPVG6JovKC9CY+2GSudesJR7CxWcxo/zPRICCCAXvK9kIKY8YbEvrcr5I73XkD4Mo1
         He672605Qs2pfVjyTlbiJeFjz1Kzkb6uwnGUdMpk484OEcianEDi6tOxjipfl2BQYP8r
         BKlVwjebKWlE6hPW0s3sxHURiZRVU/r5OnJHuktJnYry9Fn33yQ/j4vFmgt2kixiFap+
         lID5GgmZEnR4hb18zZ2MnZXh+UtnApjYtRk+pEw8e3RkT7LNVcp0C0upzcEOxgMOgsJl
         Jn52R3ugynKDSwMq0xV4zkF4IbmX/dQnwezzN7XBYmbpAKkQsB+lPgkHJNlyyDY/8dqN
         Lqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708466741; x=1709071541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2G51AsG1bsr7uNPjzTnaLkotIbnpZerEq4UgFBBh8Y=;
        b=GEPioKuwooyZZl7aqbAlg1BwtNQa+AGzbk7J9jJ+8sPgIOWbYDgvPSI6FfLMT9+S5V
         vHqJyEKdWqnJF6spIAmlK1GYAssAfIv0Zf0rZtJHBISwhX0dQw2gPcQk4iWO7rEame2I
         TRktjAIGo8CrcBqS1P3ydAvtMDdL2wMYo1NOsdfukL06FQEg7GckEmwVGJGl+dCiXO1K
         FBBBWOIdFAROIiUEbZYUVg9CqT/H0oHKvUeCbOjuqlVGY2hOyLEjJUbNqHzj455+wGRJ
         +Kb9TwWhg46FK4mzfa+9KGYeiMgdfBKKUXN1tAX3pCUZftb+b2wHGqMh3UHEvcu+GPfV
         3bTw==
X-Forwarded-Encrypted: i=1; AJvYcCWcns9j+fzzpDPfZxTqQyNZ+PcuP6Hy53N0CO7pebDMtnwmO0DNQVc9BhKUgQyw+oCsitrdKfTGdu7jw6CqW+35rB5Rt+5dHQx45Ns=
X-Gm-Message-State: AOJu0Yy+33mCeFme4j26vl5ldl3fdMalVgwosw/RN/5QHbOHN48Wa1gB
	Yat4cF6LJxYkIykFnYJqIT3QJHfinuUAbiHs6onVbP2PSmZNGRZD7Vt73aC2PRU=
X-Google-Smtp-Source: AGHT+IFQefU52rW3ziQGRz3HvFf4dJ6Y8GbBr7zStkqZDySZmn+wNkoA3854WKjBfwe3a5vPfkOPWw==
X-Received: by 2002:a25:4155:0:b0:dcc:e854:d453 with SMTP id o82-20020a254155000000b00dcce854d453mr6794480yba.1.1708466740883;
        Tue, 20 Feb 2024 14:05:40 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v192-20020a252fc9000000b00dc74efa1bb4sm2191779ybv.13.2024.02.20.14.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:05:40 -0800 (PST)
Date: Tue, 20 Feb 2024 17:05:39 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test incremental send on sparse file with
 trailing hole
Message-ID: <20240220220539.GA1024959@perftesting>
References: <fdf9b90760477ef48547efa1a5eecf273deaa09b.1708261420.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdf9b90760477ef48547efa1a5eecf273deaa09b.1708261420.git.fdmanana@suse.com>

On Mon, Feb 19, 2024 at 12:01:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that an incremental send does not issue unnecessary writes for a
> sparse file that got one new extent between its previous extent and the
> file's size.
> 
> This exercises a fix by the following patch:
> 
>   "btrfs: send: don't issue unnecessary zero writes for trailing hole"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Made sure it ran with the patches applied and all of our CI test variations,
also reviewed the code obviously, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

