Return-Path: <linux-btrfs+bounces-17835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E57D8BDE395
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 13:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D3B44F65E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 11:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454D831D375;
	Wed, 15 Oct 2025 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K46mM6Wk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D058C31CA50
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526746; cv=none; b=NaxzqVm8ANU0JIKMEmUbXZ+cATDvEZNZDjEmQDd8BBZQvfmBMPpbjSYGwoxvbnrz8jxg9L8QeOUMXggSEkxuGp9on3BeSjXkCdnZYO6U8b2wJyLgFTNb1zXyoXVWjR3eM/yRwitSyRryoy8DUF0ngFMJLvJGC2LuoSxa7mpIIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526746; c=relaxed/simple;
	bh=VLmWsWGrl1DxKEYncJ9MrJvC8lEhSuvCj2ifK2ALXk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T298jfAyX1o//h7NtKE4SeJcaVAsLdZFKfgpYnOUKqj+0fnBZpsynSIz9jBysAF9IkA0seIOjzfHG7uGAnfHo4S91vL/2UT9X/kzoJ5aLD/r5b2wHy3vOwk1LXow2yNY3EDU1Pmp0Vx9jCNcomBXatf4LpiwrM67/rgYurl6Rnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K46mM6Wk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so51763485e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 04:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760526743; x=1761131543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egLSNL4PvdhTQzYReM4pfZWKdlDJpPH8aB48GbvKF18=;
        b=K46mM6Wk7CQL32yC9e/rXc/sW7Vt/sG06U03b1Di4qIQ7WMbjZDmjqkM7UYfSi+SPh
         dVM1jAFzYqOxQCV1MjUUJbe6iFZ9HpltnOpfJtr4b2IUAOymNpl2q0tPtoXSIeXNWuIZ
         wjlW45RNPxflBT0itF1HLkakKftoJzKI43y1zBvq65OjDUTKCTQ48ymNiQbTEVqawObh
         ZksaC73yAYR7wecPjYBci6JPOTeEKyTmbSl4ru09CqBXFAqXVGIglEDi24VuZjs76m7Y
         p9Ki7u+gh4r1hvZ1333yLEUiQO9dh8UlTxC4UAV47rTP6Nckz5s2e8TdwHmFFTU8YCWZ
         gTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760526743; x=1761131543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egLSNL4PvdhTQzYReM4pfZWKdlDJpPH8aB48GbvKF18=;
        b=KAa1nqLTmMxb1kMpa/XAuWEEXy+pPKAdpOvvxs1hlPfCHhlL0fREcyS3AI0qexuPH7
         8d+n7lPqjVj7gh3vfXnRmaE/qnyfwoHHivzUKsFqPLesWLZeOKrfO+1kj0M6wEKTd+lF
         9S+WUxkZ5TEUX/z1nhcN7bl9ysHwRNuMQPzG+A50nhB9EiK+VIx0IEbZO+qzztAkLrJ6
         O+QmPJdPpg0cyzN4/3pkHfPUglV4+xlwmxigQKIfjA2LMbX3XzijBRTeB9KgzNyhg+mU
         V8bt6ISSvpJ10F8Qq9nJTOTk/lxGvltM+dRqNLMqjlV0RC3J66IcQbr1+BfUw3ZiCm+w
         0DIw==
X-Forwarded-Encrypted: i=1; AJvYcCWLpI8DQu/DoE1yQXzjZ1yNGm0AXXCqDkDRBnIvyCZy6cJeP/PIRmRmKFl9eGiYEQCMHv9tcKCmiSgWFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrh01PPgCK6MQPsJ1uw84hxZwNdrdSnlD0BAJUK8dwLq7m62pq
	GBPJZzuAo7zSeerVZoyOojMhJcH+MDX0Xn9x/UOUxt/5oi3qgdxjVVOX
X-Gm-Gg: ASbGncuoe7132p1lDfI9OXey7OCepv9lTtvHZBACIO0WPDoliGqTHjRbkK9QppUPigu
	3hpwg7IiHKXDj6r4+x6PYDslmixh3GjnRp5MMPHKJpPbfoLNysVn9ZLH6Dl0tK6IeWvuqKFb5AN
	5cLm2mrlGRlzZTKqAGB3frhdGh8QumVGgPkcjEdndDW10vXFomHEFprdBcgBZGeVM8ugiplpdPs
	myMgD/ydWeqxCXYnnaKmYWdhO5NS8fGikHPNDiGAzxR+4NJFFae/CWIAgjOG22fnE8d63fKVQf2
	9c/VpBMdbdeu95YKgm4MBrT4lldDebazibcJqHWq4h8+RMpz6Q1jqpKW7aSGVtNVNwX7wH8fXRX
	BZBs6n1avCtw+VEOJRy09pVjsv09Nm+8HG44T5xspuuQ=
X-Google-Smtp-Source: AGHT+IHWLJPppaB2GkF2ep+qcrPMm5qJf5y6pSk51HDAkPE/e1FNGciJGIXDoFAqAX+3R0PCfuphcg==
X-Received: by 2002:a05:600c:3b07:b0:46e:1fb9:5497 with SMTP id 5b1f17b1804b1-46fa9af84fdmr198331535e9.18.1760526742746;
        Wed, 15 Oct 2025 04:12:22 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce583316sm28275784f8f.20.2025.10.15.04.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 04:12:22 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: quwenruo.btrfs@gmx.com
Cc: dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	lists@colorremedies.com,
	wqu@suse.com
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is being frozen
Date: Wed, 15 Oct 2025 14:12:17 +0300
Message-ID: <20251015111217.5538-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <8c3628d5-8fce-45a1-b29c-65c2c52f1c06@gmx.com>
References: <8c3628d5-8fce-45a1-b29c-65c2c52f1c06@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I just noticed that suspend behavior depends on whether "btrfs scrub" is
started in terminal window or as a systemd service. I think this is because
systemd tries to freeze user session when suspending, but doesn't freeze
services.

So I retested everything.

All tests were done with my distro's version of btrfs-progs (6.14-1).
My distro is Debian Trixie.
I have btrfs raid-1, which spans two actual partitions, 3.5 TiB each.

Let's start with unpatched v6.18-rc1.

- scrub in win, freeze_filesystems=0 - suspend doesn't work

- scrub as a service, freeze_filesystems=0 - suspend doesn't work

- scrub in win, freeze_filesystems=1
suspend takes 6-10 mins. I. e. the system hangs for 6-10 mins and then
suspends. I suspect this is time needed to complete scrub

- scrub as a service, freeze_filesystems=1 - the same

Also: on unpatched kernel "btrfs scrub" terminates instantly if it receives
INT, but doesn't terminate if it receives KILL, TERM or HUP.

Now v6.18-rc1 with your old 7 Jul 2025 patch
( https://lore.kernel.org/linux-btrfs/9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com/ ).

- scrub in win, freeze_filesystems=0 - suspend doesn't work

- scrub as a service, freeze_filesystems=0 - suspend doesn't work

- scrub in win, freeze_filesystems=1
suspend takes 1 min. I. e. the system hangs for 1 min, then suspends

- scrub as a service, freeze_filesystems=1
suspend works perfectly. I. e. the system instantly suspends. I don't even
notice 19s delay you are talking about

Now v6.18-rc1 with your new 15 Oct 2025 patch
( https://lore.kernel.org/linux-btrfs/8c3628d5-8fce-45a1-b29c-65c2c52f1c06@gmx.com/ ).

- scrub in win, freeze_filesystems=0 - hangs for 60s, then suspends

- scrub as a service, freeze_filesystems=0 - works perfectly, i. e. suspends instantly

- scrub in win, freeze_filesystems=1 - hangs for 60s, then suspends
here is journalctl: https://zerobin.net/?7b394069a9050b8d#7PrnCDJV2t9inNFS3/EhxHJUS24iSGX7FAmjUstKKr4=

- scrub as a service, freeze_filesystems=1 - works perfectly, i. e. suspends instantly

-- 
Askar Safin

