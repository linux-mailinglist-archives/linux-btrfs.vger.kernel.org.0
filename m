Return-Path: <linux-btrfs+bounces-18294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61241C07523
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 18:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CED5835C8BC
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 16:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657184414;
	Fri, 24 Oct 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baeGrPtx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EB124BBFD
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323514; cv=none; b=ft1P0XtcF9CziyTnjzwU72Qtws7rkQqK4Kn8Jvj+HpUN3ofrgdMcKwjvrkzhIm13sCN26WXt75HdXxfTIk9EjpKWvHEpOIavEuUcJu/CyPlHfsGvahBW+jN0gMftdKhHP1f/wUlxgG0xEXrxJxeKBzPh8yy8/A4EjN7v73DvdOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323514; c=relaxed/simple;
	bh=2sni659oKETAt3mg4JWKS26aiVXJeHNTGhbFaOETvpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsL/67CnWLZ04ik8JbSXV5UeRTmWgVPNHZTa6npkJODUMzNUFZxrmdrhCnKFxprvKPYCFMUnNUAsH10u1/QrafyPYWjooEslwxEPZW659K7+FzTlKixRj5Osl+ASuMlQr7tHSMIFRBWIRxCtPe6Lub9SbpaoqvsTN9v6rnDBN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baeGrPtx; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so3527140a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761323510; x=1761928310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OU6+xLScjAoCvkgYL37muGkf8RRryUsuClOGQPNvZ0U=;
        b=baeGrPtxRl9Zf/t4igHdLAfWz7seyMy2nyivr30g2fvYihwprt8qlhOJ9DJtSB1hBN
         TYLvarvSWtjgZgxIFPLdBYl4+zOt6KrUsmyze798Y9YVrE4BJz0upn4uZAdQ0Qm/C69Y
         73LY1yYKOXRCr1VXZQAMZHTQGiaqwXIQl+XOrqPkJ6DJ3WbI8Lxosftc+V1hDcagxFE+
         Mv+ER1/NPEMnCHB5T/HRmKAwwHUaJG509q9O5YZGfQ2xoBy9R407zdmitycuDi0eGZZ4
         4CdnBpGwx2duUok2tRLKfKZLcZlsr35nVFeaUcTiP2b6iztLXtbn99MOpppdextVXb3r
         L0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761323510; x=1761928310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OU6+xLScjAoCvkgYL37muGkf8RRryUsuClOGQPNvZ0U=;
        b=YaYJZNhPaTPKm7TbAWXk/Ux3Ec1mFR3Je85tjlFl9JibS9URNZaCWTEoWDhcimvu06
         1SlkV5Bidv6WFI3ncH/k1KM902gvDb/qfIcyvcQVRrZjudeAQywVT/1/srzIJZ979n2x
         w/h2bsTVeBk+KFvYu8Rs9FIjP/HVx8fAsuQVqu1AS4sXaYtw2ejX4VRFkSbMdAiQZYr9
         txyyiZ8hk3gx4ULgHqSLmdpZFWCBayV0Q8Av4N46+bAYVFh1QED4RDGY20c0RwZ0WwAA
         sboONVdlqBXhfwf0d/N5kpomV0CYxY7k8s0DncT6HEtPDSTK208HQAlaVH23ztyxiSq+
         7FwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4D7BjJfieFLIV8MeoKk8NlwS1CYfYamY0IeoMhKUSZSkHPKbGVTkg+FWF7afYXrIAJcib94S6qyxLOA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3S15eaanfhxgA9qin+0O2jSL7+y1XBxzZPtuXyFbnPnYtchyK
	vdT1DodorZbBOu22Q/7wdLtOyJT5gd2/+3eoJJS2uLCHczuU1qzbbZT1
X-Gm-Gg: ASbGncuNfmPTT3jf78C7K0L3UnU6Evc8j+PyT8eyx6K69Boq5tbtNYuCH4kL7LNJaN3
	Jr1tit7rrshsvixgfgnTQy79w82v+3jc+08rqO+BxKtvF5dQx5f8yPM8WgAutg95kErCKst2hlM
	kZLGuIaqGr8KAFSG6ODc57LKneq9ussTW6Exk8TXcUo/dMMqISANFe5ERNY6F3Lu58A8g1ZqjRh
	Regu6zODUFm5+FuY1373E5NSIQhKsfKfANXMW+YlDO8Fwv+nVVGSa1HZPZ4Y7RgDIpJISUoKxsn
	1ONZ70NUN4uym9Y6FP3iFm9romHvMmw1M34rwc7thaVmt9w0fLk5HX9yO0qUtYvkSIOlsW4KRWf
	D6wPv8QAVLJRuYyh7zJMtCzdKki7F0qxwF9hugJQPEC5pdVEQYEv4CzSgssiRSUihKSHnPVb6fb
	QF
X-Google-Smtp-Source: AGHT+IGJrzUB5n97Ss2T/JTlLzP7kGDtRqESJivToHOWW6+qmykXupmsLuZ+wNfM3MQ1VRw6GaGwKg==
X-Received: by 2002:a05:6402:42ca:b0:63b:fbd9:3d9c with SMTP id 4fb4d7f45d1cf-63e6002459emr2596805a12.15.1761323509904;
        Fri, 24 Oct 2025 09:31:49 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63e3f316b64sm4717822a12.22.2025.10.24.09.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 09:31:49 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: gmazyland@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	brauner@kernel.org,
	dm-devel@lists.linux.dev,
	ebiggers@kernel.org,
	kix@kix.es,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	mzxreary@0pointer.de,
	nphamcs@gmail.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	ryncsn@gmail.com,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: dm bug: hibernate to swap located on dm-integrity doesn't work (how to get data redundancy for swap?)
Date: Fri, 24 Oct 2025 19:31:42 +0300
Message-ID: <20251024163142.376903-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a48a37e3-2c22-44fb-97a4-0e57dc20421a@gmail.com>
References: <a48a37e3-2c22-44fb-97a4-0e57dc20421a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milan Broz <gmazyland@gmail.com>:
> Hi,

I just wrote script for reproduction of this bug in Qemu:
https://zerobin.net/?4e742925aedbecc6#BX3Tulvp7E3gKhopFKrx/2ZdOelMyYk1qOyitcOr1h8=

Just run it, and you will reproduce this bug, too.

Also, I just reproduced it on current master (43e9ad0c55a3).

Here is output of this script on master:
https://zerobin.net/?68ef6601ab203a11#7zBZ44AaVKmvRq161MJaOXIXY/5Hiv+hRUxWoqyZ7uE=

As you can see, hibernate succeeds, but resume fails so:

+ blkid --match-tag TYPE --output value /dev/mapper/early-swap
+ TYPE=swap
+ echo 'Type: swap'
Type: swap
+ echo /dev/mapper/early-swap
[    0.446545] PM: Image not found (code -22)

Also, I just noticed that the bug sometimes reproduces, and sometimes not.
Still it reproduces more than 50% of time.

Also, you will find backtrace in logs above. Disregard it. I think this
is just some master bug, which is unrelated to our dm-integrity bug.

I will answer to rest of your letter later.

Also, I saw patch, I will test it later.

-- 
Askar Safin

