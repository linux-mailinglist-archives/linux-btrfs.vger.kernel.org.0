Return-Path: <linux-btrfs+bounces-6700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A13393CA87
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 00:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496CC1C21759
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2024 22:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA7C13CFBB;
	Thu, 25 Jul 2024 22:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandnabba.se header.i=@sandnabba.se header.b="m2Z0LBhs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from r08.out1.gmailify.com (r08.out1.gmailify.com [45.153.89.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0084690
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.153.89.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721944858; cv=none; b=qoNBWessCJcejNqQoBSdKbL1vBV7YtgvWJmJbyhL+wfaKycSnE0bAG9cbT7OmwEmkmF5rSOuitpJym9+05EttgntwA/BPoi/huMuyGfM8DB1zOTPRte8GE4qpiQb4OokbtS4ps5TjNSs5yxR9XCEFq7yzVH2z91z9U8NRnQ+MPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721944858; c=relaxed/simple;
	bh=c3CVDZyGGuip4e8cCEghAcx5zWbOt+mOWl9/7rPmJww=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=RgspUFyAyK7lMJvN9ta63nerooQAcoN0AjMTf7TkSC9q7n0zQzFnLrLQl6pZmNYBcNBvdYTVokuB4raaLOpBknjAXxAUXDCPbTDocMhwWkuQhzdoqOtkRF7BruUvLwP8CyRb32yXOSyBzvW8pTmu9JX60tEMvwkcSGxgCDSu//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandnabba.se; spf=pass smtp.mailfrom=sandnabba.se; dkim=pass (2048-bit key) header.d=sandnabba.se header.i=@sandnabba.se header.b=m2Z0LBhs; arc=none smtp.client-ip=45.153.89.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sandnabba.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandnabba.se
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.gmailify.com (Postfix) with ESMTPSA id 9AF74184103B
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 21:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandnabba.se;
	s=gm0; t=1721941573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=c3CVDZyGGuip4e8cCEghAcx5zWbOt+mOWl9/7rPmJww=;
	b=m2Z0LBhsTZ/OyA5rYJ+O03YM96e7DdXYalXK6Z10pNJ5CLNwQkEyX69libKSCnL+IerR4H
	53Qenk0KuZghRwy7Ruc2QZle5q5FaJdIQ/Mndjdm6dMtQmph55df6/tGq2cn7yFcr7Vclx
	9vfONX5ApmyBEmoYydp8CEmfFMUYtn+qGfYSmaKTBaUsvRLO1DTBxIqE7EjiTOybwZ+7R7
	EMiQfEd5zDPWjL5l2+WS9ki5Ipi22j6jNrCqH6nfddlpJadJyS3FbCppfOYKyeHkanOEBy
	Hm7VhcTMH4Kdp6nRKDLpjRYHsPD6MFpijR8T8HLM1Eq7FDrkhVXf/3blHxVZXw==
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b78c980981so7156316d6.2
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2024 14:06:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YznZsc0ndQrdOuveH47DuO9A3LZ6FBSrNM3HJGOwJ2ZchJPc291
	2CGuKdMf3HTfsJ4izKgnSgzexYgAEc8B/gmyuafZWUHEBT+0VmbmqoRFza13nigNNMlHJ7Ej9nI
	nEEpmhg/s9rAJNZKJ3o69Epm2XW8=
X-Google-Smtp-Source: AGHT+IHorkkBHAvYmxfxb1dzWZ985eBq1YcjB2ProAHPR1liQt77Dd3Z8LltrtyEhZyqyVGD1E0p1CnJ8Diyu7axx7c=
X-Received: by 2002:a05:6214:d6a:b0:6b5:e3ee:f804 with SMTP id
 6a1803df08f44-6bb3c9ebab3mr52133266d6.16.1721941571744; Thu, 25 Jul 2024
 14:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@gmailify.com and include these headers.
From: "Emil.s" <emil@sandnabba.se>
Date: Thu, 25 Jul 2024 23:06:00 +0200
X-Gmail-Original-Message-ID: <CAEA9r7DVO8gCRz-9vbwaNWznz9AOFxOyPLO0ukOJh-6Ef0o5Bw@mail.gmail.com>
Message-ID: <CAEA9r7DVO8gCRz-9vbwaNWznz9AOFxOyPLO0ukOJh-6Ef0o5Bw@mail.gmail.com>
Subject: Force remove of broken extent/subvolume? (Crash in btrfs_run_delayed_refs)
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Gmailify-Queue-Id: 9AF74184103B
X-Gmailify-Score: -0.10

Hello!

I got a corrupt filesystem due to backpointer mismatches:
---
[2/7] checking extents
data extent[780333588480, 942080] size mismatch, extent item size
925696 file item size 942080
backpointer mismatch on [780333588480 925696]
---

However only two extents seem to be affected, in a subvolume only used
for backups.

Since I've not been able to repair it, I thought that I could just
delete the subvolume and recreate it.
But now the btrfs_run_delayed_refs function crashes a while after
mounting the filesystem. (Which is quite obvious when I think about
it, since I guess it's trying to reclaim space, hitting the bad extent
in the process?)

Anyhow, is it possible to force removal of these extents in any way?
My understanding is that extents are mapped to a specific subvolume as
well?

Here is the full crash dump:
https://gist.github.com/sandnabba/e3ed7f57e4d32f404355fdf988fcfbff

Best regards

Emil Sandnabba

