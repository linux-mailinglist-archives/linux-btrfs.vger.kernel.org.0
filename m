Return-Path: <linux-btrfs+bounces-7911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64CE973E41
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 19:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23082B27F96
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 17:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436A91A3BB8;
	Tue, 10 Sep 2024 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB77Q/IR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D181A0AFE
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988122; cv=none; b=saKnXPSDwnlzllGK3fPVW4PxfS4vMM8bJ14bdNzH1Uz0rchp9jfTK8jChzTQd3Y6ku9AYiUh1L8NjSQe6ZWeeS2ie1+lvi8ZZpyDX5i7kYHg1N+YcXl0w3IJkSfyHtP4aoc3dcXQgvnKA4q7gMX7+HW2eNU9dz5w2ZckQGg9DB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988122; c=relaxed/simple;
	bh=Z48ezSxKf0+UuMeOJFJ158Rwoi61MU7ffsKGXCd/WX0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CQnqvP4HdDeDcLKAINX3jxer6+1Pl7PvJrgS97AG2c0nrpveUj6VkoirAWIvdVAB283EZKgT6rfdaBBcUbrqeK3KAO7Ltz9pQmVXMFpsNJEIPcoJRHfELoyd47g1J8/t3d+fbnMTR5cjdTs6Hja4qcyelbEk/z0lVl+j1LN1sOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AB77Q/IR; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a99e4417c3so305994485a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725988120; x=1726592920; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ofHhAhpttLP7KYmISLjRSUVzBEHIW7LXq9lu+MS6pX0=;
        b=AB77Q/IRnP3xgfGufBN3PDMpFD3XD+S+qL4lKfO26e7krDa886uuVqGN+OCIYdWwmY
         nzLLBbreyfh/bIIJM3+z/1D486Vs86sgMT63qdowqfTsCZ+Yr3Bjgjgz7azvS8m68itf
         U8pOhkFg1Yy3FXt2Ymh2h3EWMfpAtWK2x6YzWwlxdVrkiDDJ+9ltN89RvlDoFobJTSWu
         I+p+ap35QWM1TfHOwybFzfl1udhhZvS37z4/KIZKNLfAomrxCzOa83Ly9tpnTyN6LPvo
         9j6VeiLyny5uKg3D7ZXNGwIHlvQz92Pft1z49wXIMmV3pnqmHgoIO+SX/bA+lwWQFiLU
         4vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725988120; x=1726592920;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ofHhAhpttLP7KYmISLjRSUVzBEHIW7LXq9lu+MS6pX0=;
        b=DUxCbEEASf54rKOcKuthVX2bdb4hCMfEgw6DTL8Np6Kaofzs9S+xWuMpZrSRwXdKnC
         6GVoaM1NFccmpJQqGNLRtcsMzZlk/w1rck+SpkZvVcrjyXVhWZwT0RfGKHSqJmus+wIy
         nhy8Q8F1MK7hdkLukJ5XBVdwUqtyX4dZdDcNemVxXP4cdm7W2jqCX4NAx6WWTzqQfe+i
         +GVr5/+RmD7OhDMMu98Poy4DP4PWGo+80lWBrbSm0SqTXu5eUyCXneJsMfdFeIAScJTO
         xpWck+s2yZusT/wTwc6sDkY0naBw8oOV+Gec6JIQTPR8hTE4k7uKTlVle0nMb0ucf4UB
         iP2g==
X-Gm-Message-State: AOJu0YwPGbUwAcXzsG7mkcypSZxqbBZKxq8WPWshHEIU0RVbn+//R6Wm
	EPrh5oMd5BkeyJRwXF1pMUgVw6zfb8XjiOyzcIFd8FTVWLSkDLnpktVDEvaP5lTAeHHZvYD7chC
	yPcKXjzopiqoylspOeDnDhzO9/hKjIeO9
X-Google-Smtp-Source: AGHT+IFiqbrvwmCA7EMWRyDhiSP6kfM25ziAZQIbK7hlKxH3gDam5xn0/Wf7QiMHTWxqk+YxCEVTEd6r5Le0m3A2FC8=
X-Received: by 2002:a05:620a:29cb:b0:7a9:b744:fc41 with SMTP id
 af79cd13be357-7a9b744fe37mr1326899185a.14.1725988119928; Tue, 10 Sep 2024
 10:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Neil Parton <njparton@gmail.com>
Date: Tue, 10 Sep 2024 18:08:29 +0100
Message-ID: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
Subject: Tree corruption
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Arch LTS system (kernel 6.6.50)

Cannot mount a raid1 (data) raid1c3 (metadata) array made up of 4
drives as I'm getting corrupt leaf and read time tree block corruption
errors.

mount -o recovery /dev/sda /mountpoint   didn't help

If I blank the log on what seems to be the affected drive I can get it
to mount but it will give out the same errors after a few sec and turn
the file system read only.

If I pull the affected drive and mount degraded I get the same errors
from another drive.

Trying to work out if I'm shafted or if there are steps I can take to repair.

Critical data is backed up off site but I also have a tonne of
non-critical data that will take me weeks to re-establish so nuking
not my preferred option.

I've managed to ssh in and here are some lines from dmesg:

[   14.997524] BTRFS info (device sda): using free space tree
[   22.987814] BTRFS info (device sda): checking UUID tree
[  195.130484] BTRFS error (device sda): read time tree block
corruption detected on logical 333654787489792 mirror 2
[  195.149862] BTRFS error (device sda): read time tree block
corruption detected on logical 333654787489792 mirror 1
[  195.159188] BTRFS error (device sda): read time tree block
corruption detected on logical 333654787489792 mirror 3

[  195.128789] BTRFS critical (device sda): corrupt leaf:
block=333654787489792 slot=110 extent bytenr=333413935558656 len=65536
invalid data ref objectid value 2543
[  195.148076] BTRFS critical (device sda): corrupt leaf:
block=333654787489792 slot=110 extent bytenr=333413935558656 len=65536
invalid data ref objectid value 2543
[  195.157375] BTRFS critical (device sda): corrupt leaf:
block=333654787489792 slot=110 extent bytenr=333413935558656 len=65536
invalid data ref objectid value 2543

advice needed please

