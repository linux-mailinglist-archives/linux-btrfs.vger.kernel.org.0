Return-Path: <linux-btrfs+bounces-9739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D179CF91D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 23:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C4D283C41
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 22:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E181FF04A;
	Fri, 15 Nov 2024 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="ilsHGchk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9AA189B91
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706763; cv=none; b=gdiHrp/CJ2eOjpKUG7NBkoGXuNDNr7CHXXH79sVPPSK0LpUfztgkQ8hSlQUIGldQXMiJdZoimYKfPvopWffLJL5/ctXIyAdclWpO7ktVuhwxp6JweuvP2E80ISp/gRmF9qaL8ubWt5jYjQjcK+/v88voIu7h/fWjAOrDdqpSCxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706763; c=relaxed/simple;
	bh=IIHt58njkRxzbPWPD2LYQfAuooobm0nLitnUnooKcpg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AzLN67avSA4T+4rA1En5cZBIhTd5gVKjfWJvAm+ewI7Xe40Rgk1hKLnAryVln5QT1zBypEqxqCPJjy1fo8GVBmShqXjuVuBpbkbQLe+WNDYSa+0tJzijNg4DikWV9zpqGmr+ZxiUepL1vujl99kcY2cM8QHlBi7vi1O9hiMr7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com; spf=pass smtp.mailfrom=konsulko.com; dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b=ilsHGchk; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=konsulko.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4613162181dso451761cf.3
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 13:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1731706760; x=1732311560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hm8gyQ6carZfqA1UxuPCB9E2frscgKdGqZLxGMT0g0=;
        b=ilsHGchkK1cm4s37qzoapEo/TDfJ57xuUWOgpI0I5hb4OFyBDeJoLXdcSmGHm+FwQU
         bVtZdau9YU39F1V9QMiy2Ih2C9WlEstGpeJzNYQzSE/tI9df/wmoQ+lAE1EPxJLBmoX5
         3qT4T3wdp7KCOWCmKOkYyye6cuZVMm3ocsMRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731706760; x=1732311560;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hm8gyQ6carZfqA1UxuPCB9E2frscgKdGqZLxGMT0g0=;
        b=lPKu9xRUTZxPm6GdHzIiFKfODYMRRlkVS48xEVBaaLPUrjeoc621yK9Z5BnkeqXKgE
         4WhSCSKw5HGmBzaAcHuvRLg0iJIP/J6nmnrzM1ORgZj+P+BjAfY34+50Y3daM6boJKzO
         I8k7Yjow0ruQZz5meZNPVpsk9KK7bOVQJFIOQYqK2Y1qzOayXeY/mc7RXyYJKjBRsJMT
         wYifxbLQZfMimBpmNEOqWEuAxUrEdgQ8jKgtlKgWBrFMl2aBsCJxv9hCQtfI5vt9mV4y
         7dbBSzPynH1gMAuBtkrBr7+RqkfI5UIyDATQVSBHba8DiVkEjBfuWU/qcRraBtNMi4LB
         WKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3GYrGJ9IsBx7VCYzrMmDhBIEhZl9HXDOBJCiRGSdPVmN/Xp7pOrUeBvWUn4P5arH3OJsHK4VUhV9cGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9j8LrmKg31XH5CrjT66/TsTDE1LmXtru+AlOtsDs198GntWou
	l1e4alCPjVgyAvYdXdf6i7eZT2oURpAgx6CGIkTGEI9C/in/+24o3Q8zVPgu9wU=
X-Google-Smtp-Source: AGHT+IGfk9G8PoTPySKrCQBPuzkdP4jCr2rcaGZCfabomz6xGDBpBnHelXBYPZjtIsPJ+bCK7yupAg==
X-Received: by 2002:ac8:5753:0:b0:460:a037:edba with SMTP id d75a77b69052e-46363eb2747mr54904631cf.46.1731706760511;
        Fri, 15 Nov 2024 13:39:20 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca68b71sm201771885a.125.2024.11.15.13.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 13:39:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Qu Wenruo <wqu@suse.com>, Dominique Martinet <asmadeus@codewreck.org>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>, 
 linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
In-Reply-To: <20241115021549.671932-1-asmadeus@codewreck.org>
References: <20241115021549.671932-1-asmadeus@codewreck.org>
Subject: Re: [PATCH u-boot v2] fs: btrfs: hide duplicate 'Cannot lookup
 file' error on 'load'
Message-Id: <173170675838.2851979.15988769611030245565.b4-ty@konsulko.com>
Date: Fri, 15 Nov 2024 15:39:18 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 15 Nov 2024 11:15:47 +0900, Dominique Martinet wrote:

> Running commands such as 'load mmc 2:1 $addr $path' when path does not
> exists will print an error twice if the file does not exist, e.g.:
> ```
> Cannot lookup file boot/boot.scr
> Failed to load 'boot/boot.scr'
> ```
> (where the first line is printed by btrfs and the second by common fs
> code)
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom



