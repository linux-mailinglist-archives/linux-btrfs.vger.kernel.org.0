Return-Path: <linux-btrfs+bounces-1824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8F183E207
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 19:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D113DB24B5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 18:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CD622313;
	Fri, 26 Jan 2024 18:55:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6605E21A06;
	Fri, 26 Jan 2024 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295351; cv=none; b=u/wXDv4tCiPN+q5WfUOq1P8xs7+e0+bw1LghnbjfZKKh37TTDYJaMmzQQZl9azyEcnlrWRo/NJlRZVg0mOFLfEnzngeoahVOqPWq9246veSwkEvjkjpaPOcOu+ytZ1rpHV/CiHkrs8J1Z7SaXSICxquQxg64XpzTkbvhQtDQeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295351; c=relaxed/simple;
	bh=MSP2Xu4IClU6Gp7Cqh5YtfFjmLibUU78vLoORLdv3so=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMs9Urj3ReTJLA6Mkg/FypPUJWsVfebHQFfK1ooU5WoFAG+tekBFR3jqwSvzCSm0+n5FXldNBNkyPuWZlbHddblny0qPoWtvCt/Wbe6GN9bE8H+MjnCpcxJMx+056NjWZkjzly3wEQs62L8Y2x5KyI9sc1u2MMpZRkAk+Qhyn1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 6FE9B520153;
	Fri, 26 Jan 2024 19:55:39 +0100 (CET)
Received: from lxhi-087 (10.72.93.211) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jan
 2024 19:55:39 +0100
Date: Fri, 26 Jan 2024 19:55:34 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: <fdmanana@kernel.org>
CC: <linux-btrfs@vger.kernel.org>, <erosca@de.adit-jv.com>,
	<Maksim.Paimushkin@se.bosch.com>, <Matthias.Thomae@de.bosch.com>,
	<Sebastian.Unger@bosch.com>, <Dirk.Behme@de.bosch.com>,
	<Eugeniu.Rosca@bosch.com>, <wqu@suse.com>, <dsterba@suse.com>,
	<stable@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>, Eugeniu Rosca
	<roscaeugeniu@gmail.com>
Subject: Re: [PATCH 0/4 for 5.15 stable] btrfs: some directory fixes for
 stable 5.15
Message-ID: <20240126185534.GA2668448@lxhi-087>
References: <cover.1706183427.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1706183427.git.fdmanana@suse.com>
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

Hello Filipe,

Thanks for your participation/support.

On Thu, Jan 25, 2024 at 11:59:34AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Here follows the backport of some directory related fixes for the stable
> 5.15 tree. I tested these on top of 5.15.147.
> 
> These were recently requested at:
> 
>    https:// lore.kernel.org/linux-btrfs/20240124225522.GA2614102@lxhi-087/
> 
> Filipe Manana (4):
>   btrfs: fix infinite directory reads
>   btrfs: set last dir index to the current last index when opening dir
>   btrfs: refresh dir last index during a rewinddir(3) call
>   btrfs: fix race between reading a directory and adding entries to it
> 
>  fs/btrfs/ctree.h         |   1 +
>  fs/btrfs/delayed-inode.c |   5 +-
>  fs/btrfs/delayed-inode.h |   1 +
>  fs/btrfs/inode.c         | 150 +++++++++++++++++++++++++--------------
>  4 files changed, 102 insertions(+), 55 deletions(-)

The conflict resolution looks accurate to a non-expert eye.

I can also confirm there are no new findings reported by:
 - make W=1
 - make C=2
 - cppcheck --enable=all --force --inconclusive
 - PVS-Studio

PS: Could you help me out how (and if at all possible) to preserve the
Author date of the original patch when downloading and applying the
'raw' file provided by lore.kernel.org ?

Thanks,
Eugeniu

