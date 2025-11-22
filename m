Return-Path: <linux-btrfs+bounces-19271-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF53C7D72F
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 21:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C192B3A95EC
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 20:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0DB2848A8;
	Sat, 22 Nov 2025 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFKUqDUt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE951298CA3
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Nov 2025 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763843639; cv=none; b=Vbwvb0nD/WGyZOWCbNOcHZ1ydjcw45p0KbUSBPnHUOFR80t3Qik01qwFrHDj1zXxVS1UCJc0S5DsWXtu0NPQFgBPzVYsLUZ9LHM/g9xlYLkmhVP35GEqtds+6cpsFcpL9o/kE7aiIipN42RIbLe/9yvwaiKmMpp8OgXugRTcRAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763843639; c=relaxed/simple;
	bh=NHaFMiF6dxiCU0vMg8q5qTDPlG31ZZujzGUesGhT5hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OqfgAr3RYcKzHUABmOWlCvPUI0/O/bFzkefjEdQbJ3n0+4N/46mLO4PWdpZfzjHMh2bY4a5pzJpyhxAEY8KdtVnnyRlbLjdbAKcbw8Z4urXckjrHl4Ivz1VxlnYSr3JFRP38J9PcnB0u9DWKsQhlakNwSULZs6ycOX7kdrEWbpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFKUqDUt; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37b9728a353so32507731fa.0
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Nov 2025 12:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763843636; x=1764448436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFn2EwqFqpnjkFoKzC+88UIKZbJzPZxsjNZNiF3KFj4=;
        b=WFKUqDUtK3N3S7kIr3lO0eVi0KSOTQ4CydlfEdvVVcgXR93bkGwTgp1Eb7U5KxZPcS
         CD+7IjinJCUKmvDPuMH1fYHjY5ywfX3qpRyuYmRbVawon+BnkzIwUB+m3+XVisxkjFi0
         IPRbCVqbx5Bj+nEE53y0vsBITf5zXsktmqFFqy6VC+x5OistRVdLc8HXaI3peXm/eQWj
         s9BWR3rS3vX+AcP81cogkDA+RU9tXthlONdwZ7+IVUu4f2n8g48xSoVWlKfFhU5vcoGj
         LQYRUw6l1SUBaboWt6sMFdoUEKtVZPRgwVMiRhbv8PPgMRTZwn49bvlbr2+6bdrDZVFJ
         DAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763843636; x=1764448436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dFn2EwqFqpnjkFoKzC+88UIKZbJzPZxsjNZNiF3KFj4=;
        b=cPTI1CbOmAfmQ/CAP5T7301NmGUqR7Y9ng/vkslItsC30KgIVzayH4xtDdNrrVIPAU
         WCgcJnpKMeU1U7C2sa0LpFpxQuH0TPU6QBWDp4UDDc9wnvRDFcABhz1l1sb2uhXUdd/V
         ksJM6ZMOUZ0QoZ3dxfYWc5Jf98Ty7gzdVHc3R9mwdWah9bEjH0a+BJhSJA3IXRs+mLex
         DhvWVmsz/6UMNFXHcl+arlmRnc9Mpcv21RJhq4a5ZB0YJgvv8CbgUnYV6uSNZpt4FBoc
         4jvedkFUkyIpzloPI8aBhWd+r385grPeasCncjlrJKdnZB0/jDv77yykLhOJu7UnhQFL
         4FpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfExmGDn3O8Dc/KU/qM2PN4QCcFSMJiyfkANQshHSgTEN5LtdeU7/ehq8Bkh+4b19EDXPNSvtfSIvcJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZITFxvhOv/cNdxWDTEOaGPQqnECmcUvzM7fxG/uUkYAfHT9ot
	fdW48uKDBBz+hsc4PtH3TfOIdwhxjm21LduOwt9NtJX9sB+/YIPGCF2l
X-Gm-Gg: ASbGncuVklLU+1fUoLDiUJADwRPiFBP28su7KwybOKfDqex8mv9LOytzvcobxKpFbPy
	e/sBHqRdPQrH/D7hmGf8NXoHWWlcxhTkxDxxBJbISDmKIY6wQAwyFsMvnLVFZcOyJEqO4vWLC3w
	nZ5Ykc+tJzjBsXkoQpg5FbjRM+Xt4tEdpjp0O14MFRbsjJ2pyJe+0Ba4TMd/kLWe5o9qGz6ictZ
	ej0zOXzlGtfTAt2wqrUnZPzVuQsi5ReMtuq8YlAyvyC/9ybAQWNsHB+wAVHXbA+UDoWZVM3Qm2j
	WSDWxUbqF/GaonPBVMkuMYVRkaQwNMUv11PGO+ZpSBMHo+xNisXMSOkLXll7YTJ+I0k4f9Y4OJP
	+QFb+WcHcPiiSy7Y8pmEGZITxTzeKto1+2h5XEndBIFDDLUGvlunV20rEZwDbYoaUfQeWVu2g2N
	XwyxezZVS6
X-Google-Smtp-Source: AGHT+IFhSsUjwtf7XXEFFhGewe4/WzYwa1EvQXhZvrF755UE0d1dYIej0yvrkJ/oBfshVizcRSlPOQ==
X-Received: by 2002:a05:651c:4416:10b0:37b:aac1:282e with SMTP id 38308e7fff4ca-37cd9287c95mr16773881fa.28.1763843635543;
        Sat, 22 Nov 2025 12:33:55 -0800 (PST)
Received: from localhost ([109.167.240.218])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-37cc6b597b2sm19299711fa.12.2025.11.22.12.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 12:33:55 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: mpatocka@redhat.com
Cc: Dell.Client.Kernel@dell.com,
	agk@redhat.com,
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
	milan@mazyland.cz,
	msnitzer@redhat.com,
	mzxreary@0pointer.de,
	nphamcs@gmail.com,
	pavel@ucw.cz,
	rafael@kernel.org,
	ryncsn@gmail.com,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 1/2] pm-hibernate: flush disk cache when suspending
Date: Sat, 22 Nov 2025 23:33:42 +0300
Message-ID: <20251122203347.3484839-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
References: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Mikulas Patocka <mpatocka@redhat.com>:
> [PATCH 1/2] pm-hibernate: flush disk cache when suspending
> 
> There was reported failure that suspend doesn't work with dm-integrity.
> The reason for the failure is that the suspend code doesn't issue the
> FLUSH bio - the data still sits in the dm-integrity cache and they are
> lost when poweroff happens.

Your patchset is impossible to apply using "b4 shazam".

Here is what I get when I try to apply it using "b4 shazam":


d-user@comp:/tmp$ git clone --depth=1 git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
Cloning into 'linux'...
remote: Enumerating objects: 96577, done.
remote: Counting objects: 100% (96577/96577), done.
remote: Compressing objects: 100% (93936/93936), done.
remote: Total 96577 (delta 7530), reused 20945 (delta 1607), pack-reused 0 (from 0)
Receiving objects: 100% (96577/96577), 267.21 MiB | 1.85 MiB/s, done.
Resolving deltas: 100% (7530/7530), done.
Updating files: 100% (91166/91166), done.
d-user@comp:/tmp$ cd linux
d-user@comp:/tmp/linux$ b4 shazam 'c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com'
Grabbing thread from lore.kernel.org/all/c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 15 messages in the thread
WARNING: duplicate messages found at index 1
   Subject 1: pm-hibernate: flush block device cache when hibernating
   Subject 2: pm-hibernate: flush disk cache when suspending
  2 is not a reply... assume additional patch
WARNING: duplicate messages found at index 2
   Subject 1: swsusp: make it possible to hibernate to device mapper devices
   Subject 2: pm-hibernate: flush disk cache when suspending
  2 is not a reply... assume additional patch
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH] pm-hibernate: flush block device cache when hibernating
    ✓ Signed: DKIM/redhat.com
  ✓ [PATCH RFC 2/2] swsusp: make it possible to hibernate to device mapper devices
    ✓ Signed: DKIM/redhat.com
  ✓ [PATCH 1/2] pm-hibernate: flush disk cache when suspending
    ✓ Signed: DKIM/redhat.com
  ERROR: missing [4/3]!
---
Total patches: 3
---
WARNING: Thread incomplete!
Applying: pm-hibernate: flush block device cache when hibernating
Applying: swsusp: make it possible to hibernate to device mapper devices
Patch failed at 0002 swsusp: make it possible to hibernate to device mapper devices
error: patch failed: kernel/power/swap.c:1591
error: kernel/power/swap.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"


It seems you should send patches not as a reply.

But I will apply your patches anyway, no need to resubmit.

-- 
Askar Safin

