Return-Path: <linux-btrfs+bounces-19847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A944CC9C9E
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 00:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94359305845D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 23:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446FA330305;
	Wed, 17 Dec 2025 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBaT4sxa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39632311C32
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766013528; cv=none; b=Yes9BdDMbuZ3l1luYvCyDIXlPY8R5BpxUb0tkwyMANOrfdsY5YG/ilApTUVg3JEx2RbnWmshq72B+4Kkfv+TqTRwqtWlrgfH6aYd8kT5ROrPbQZ0XDbVfph8+fe7neEZhdA7RDCVxctdfDj/h839cZYyJpc/GSPnVcKGNbrTZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766013528; c=relaxed/simple;
	bh=C1X5R0T9A6CrUnxpIm/QVXVuRULmzTp597QRk97zyjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OX2bq2e0Cn+5T4JfYY83/QUXoQU0tS86k8eY7YP5kd93XhDiLcqmAzEEYvvkn/oi5VbD0o1WxEj4zgqW3zxCzaNvklOdgH8hdlqbPOUHLNiPgnPpJQDvt62Y+UzznHFEmEfREZVPMvKBBco6pFZQh9aUpJ3cFDJXBTtG2sURikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBaT4sxa; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-594270ec7f9so12136e87.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 15:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766013524; x=1766618324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZvc3rVI0di0d/Re6Le5Bvc+vMvJtdhpmIxMnxjb6tA=;
        b=VBaT4sxaHFvfVHw/0PNR0mma9L9CQCE0t1LZsPF9klP2ecyZEgzKiX754iClqRnz0f
         GmmYZH9YBVrmYyy8S74MtCYaKuLLOE2twPEfhgrGbfkH8UXctcxVy2vj9OV5ntO4+YDt
         N24t/STd7wbl7G92s0Ny+GD1Htd8YjaiuuS7DGr+Iv8Q9IUwNUEXilozkJvTMnE86WQu
         MnZ+OnIJvOTufXzIWehEwX5Rn+kCV2O/NoVJ2bWPv2EgbMUdijMRcUlXoqnDdN/RqdV2
         qtSKWp2M81Sd6yvPFFJro9CHX/HMKbmz3BzLch4xdn6FHJrroyI4t4EVNBxfQxTI6t+V
         6rDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766013524; x=1766618324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AZvc3rVI0di0d/Re6Le5Bvc+vMvJtdhpmIxMnxjb6tA=;
        b=WDIRqOq43BE7BMtUA3nTLtg9VEXEo0PgiotSMmtx8yaBe1hRn0t1RbTUSShkK3GfUE
         JyFkA36XZhtYKGDwewchZK9z2bo/sjRGNq9tCzzM57eZE4SpzbWQkVuY6agWnYRerhVm
         opx2DwUMbD/jKghHxGUdagGtqqDnIY5QALBmprfrGND4bLN1kLTNLfAnautN4RJzJnMQ
         Ds2HVl/8+VcgVSOqB+efjt3aehNDF9LbkMNiXBEPJJUNpdBF8gS9wJyetGShH2BMvlhR
         QnIk8rztN5+0Dym+iWJscVs8fhHCuofqVkhUnxEblJgl5VeDbq9bJ4Z9bbaA+hsANMjZ
         Em5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSEInaCrp0Q5m0Y9rBtf4O7I24y0YeW1Br70PYbwAVnYd1uZYbgI8fmbdwBhN4hZndENwJQxgJosTEAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKoEDB7fjwZs4jGcxWZQBXzELijmSBkPzPnX2hMcIN0r5ZZW2
	ITQllOf9mbBL0YeyDkZIhkw8k4b+CnvnVIM26ZMLEVj6FO2jZwdv9o6G
X-Gm-Gg: AY/fxX5W7R5QdxiCGknc4QX1HJnK3UojkIpLFFiQ0UEuGYAJfwE2+8xmwEIc/64ZoGO
	JX6gU7lfwqMQ347NoW3w+1Z+rEoQK4V/bvlKZ9pFsnwiPHak+gd6FMnDKee60zsNmHEmp2ibLxn
	o5xLRtQrLeQGCzRa6EOQrwW264zrzxQZUwrJQU3km5hsveuAZjItZxxSTyUwx/4yhlH7PmvKJt0
	FcVPJaJcmuyJOuWySBVkpEZX8r/in2qq2N6E+zngBrw48+6H3jDSg2dOKxGev6zAjyZw8FTYwQ4
	VMltly2hT34ip7c78n+H+QngsvVUTi5d4MOJFHxfbjFIhrXoegvEPEJYWd6PkHwRQlBeIvdvJdR
	fF5zjORrDM5F08CEcb6goU4C0lIeV1TAT2clNaM7c+HgUQN2TV7ca4TxIg1KXxKRWH4TWLUEWpc
	XQdy9rfMOJ
X-Google-Smtp-Source: AGHT+IFoFgIAi9PMNEfIKCxeozWxswujwd1S6MJvMAmdk00BzJYAqN7Mqo6fE4Jz6OZ88KHyEwKy2w==
X-Received: by 2002:a05:6512:3ba2:b0:598:edd4:d68 with SMTP id 2adb3069b0e04-598faa5a3bamr5789014e87.28.1766013524025;
        Wed, 17 Dec 2025 15:18:44 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-381134b5011sm2807821fa.3.2025.12.17.15.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 15:18:42 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: mpatocka@redhat.com
Cc: Dell.Client.Kernel@dell.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	pavel@ucw.cz,
	rafael@kernel.org,
	gmazyland@gmail.com
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device mapper devices
Date: Thu, 18 Dec 2025 02:18:37 +0300
Message-ID: <20251217231837.157443-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b32d0701-4399-9c5d-ecc8-071162df97a7@redhat.com>
References: <b32d0701-4399-9c5d-ecc8-071162df97a7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mikulas Patocka <mpatocka@redhat.com>:
> Askar Safin requires swap and hibernation on the dm-integrity device mapper
> target because he needs to protect his data.

Hi, Mikulas, Milan and others.

I'm running swap on dm-integrity for 40 days.

It runs mostly without problems.

But yesterday my screen freezed for 4 minutes. And then continued to work
normally.

So, may I ask again a question: is swap on dm-integrity supposed to work
at all? (I. e. swap partition on top of dm-integrity partition on top of
actual disk partition.) (I'm talking about swap here, not about hibernation.)

Mikulas Patocka said here https://lore.kernel.org/all/3f3d871a-6a86-354f-f83d-a871793a4a47@redhat.com/ :

> Encrypted swap file is not supposed to work. It uses the loop device that 
> routes the requests to a filesystem and the filesystem needs to allocate 
> memory to process requests.

> So, this is what happened to you - the machine runs out of memory, it 
> needs to swap out some pages, dm-crypt encrypts the pages and generates 
> write bios, the write bios are directed to the loop device, the loop 
> device directs them to the filesystem, the filesystem attempts to allocate 
> more memory => deadlock.

Does the same apply to dm-integrity?

I. e. is it possible that write to dm-integrity will lead to allocation?

-- 
Askar Safin

