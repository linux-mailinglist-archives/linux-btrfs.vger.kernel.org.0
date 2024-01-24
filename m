Return-Path: <linux-btrfs+bounces-1764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6B783B55C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 00:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90ECD283394
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 23:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB26213664F;
	Wed, 24 Jan 2024 23:01:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FE47CF1B;
	Wed, 24 Jan 2024 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706137281; cv=none; b=ktLjjpuyhHWbPZxSSf4I0EdEgKWH93RfC1bR0IJtv3AT3rF3mH3ES5Sc7UJrMacqdusdMK5PFA6jk5g/UngELqaKNkgnLTAK/RL0vl5SyPvO4TNS6Q1OOpg7TVLJrS5aLA0YeAGVcpX7EuBmO94tbi+JIOj+6uGtXd5PEzG0NEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706137281; c=relaxed/simple;
	bh=eKY+oHIVvHDg+PVbaeCYicVv75uCECCrmtNaERMLBjs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ+sVTj0q43aKQ5rC2diPmTYEkOA7drzoFSQ0/1NWX3uJ7GWmu7QPw6Pk5OsH9iudWcO+MjiuQ1ApPda6JDM0SRz6/Sd4lygx+WB46+S9MwNMWfFcmPuAyzEAGZ8K0Cq+XUM555tCGWMZ+tGSp2Q2VecTG6CUakCb6A2dN/xw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id A4689520203;
	Wed, 24 Jan 2024 23:55:28 +0100 (CET)
Received: from lxhi-087 (10.72.93.211) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Jan
 2024 23:55:28 +0100
Date: Wed, 24 Jan 2024 23:55:22 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: <fdmanana@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-btrfs@vger.kernel.org>, <stable@vger.kernel.org>, Maksim Paimushkin
	<Maksim.Paimushkin@se.bosch.com>, Matthias Thomae
	<Matthias.Thomae@de.bosch.com>, Sebastian Unger <Sebastian.Unger@bosch.com>,
	Dirk Behme <Dirk.Behme@de.bosch.com>, Eugeniu Rosca
	<Eugeniu.Rosca@bosch.com>, Eugeniu Rosca <erosca@de.adit-jv.com>, Eugeniu
 Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] btrfs: fix infinite directory reads
Message-ID: <20240124225522.GA2614102@lxhi-087>
References: <c9ceb0e15d92d0634600603b38965d9b6d986b6d.1691923900.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c9ceb0e15d92d0634600603b38965d9b6d986b6d.1691923900.git.fdmanana@suse.com>
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

Hello Greg,
Hello Filipe,

On Sun, Aug 13, 2023 at 12:34:08PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The readdir implementation currently processes always up to the last index
> it finds. This however can result in an infinite loop if the directory has
> a large number of entries such that they won't all fit in the given buffer
> passed to the readdir callback, that is, dir_emit() returns a non-zero
> value. Because in that case readdir() will be called again and if in the
> meanwhile new directory entries were added and we still can't put all the
> remaining entries in the buffer, we keep repeating this over and over.
> 
> The following C program and test script reproduce the problem:

This crucial fix successfully landed into vanilla v6.5 [1] and stable
v6.4.12 [2], but unfortunately not into the older stable trees.

Consequently, the fix is missing on the popular Ubuntu versions like
20.04 (KNL v5.15.x) and 22.04.3 (KNL v6.2.x). For that reason, people
still experience infinite loops when building Linux on those systems.

To overcome the issue, people fall back to workarounds [3-4].

The patch seems to apply cleanly to v6.2, but not to v5.15
(v5.15 backport attempt failed miserably).

Is there a chance for:
 - Stable maintainers to accept the clean backport to v6.2?
 - BTRFS experts to suggest a conflict resolution for v5.15?

[1] https:// git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9b378f6ad48cfa
[2] https:// git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=5441532ffc9c8c
[3] https:// android-review.googlesource.com/c/kernel/build/+/2708835
[4] https:// android-review.googlesource.com/c/kernel/build/+/2715296

Best Regards
Eugeniu

