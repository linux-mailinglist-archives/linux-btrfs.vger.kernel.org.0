Return-Path: <linux-btrfs+bounces-1828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E2183E236
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 20:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86611F27646
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 19:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56A9224CC;
	Fri, 26 Jan 2024 19:09:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB9B224C7;
	Fri, 26 Jan 2024 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296170; cv=none; b=qitKqZ2A5+CId+FVksVeSP8kqPKkp6M+kQsnuNhnsyfwatF4gKYz9vl14Bf++6uTahpyHsxyoGkwx4PZw2nqwmHdG16v++2K988JAkyk7HYk0r6yTDFmW+enErxufIpMvvoeUVnBfGlcvf4IBhJV6HeEjirJpLldLcO8hAFIIXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296170; c=relaxed/simple;
	bh=JgDi5qGtpWQPVw6NhvojZ4mYsZouYXZ6IanLD2Lq1Xc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCnHSfpA/wxUrVhlJSwgWbrWXZ1LiY3Ac8r1hJrFilYWEDtdrvId0fUBQAp+MPCMZF5nl5URbQACiTmPPGYLTvuNGWRevitCzyiOHmL09UcwnEdmH7qhQrVFb0d5vJ5jL33JF2kN825Gj+NlxakQiChSy8XQu0+sy9L8H3oVIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id C5E9852040C;
	Fri, 26 Jan 2024 20:09:26 +0100 (CET)
Received: from lxhi-087 (10.72.93.211) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jan
 2024 20:09:26 +0100
Date: Fri, 26 Jan 2024 20:09:26 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: <fdmanana@kernel.org>
CC: <linux-btrfs@vger.kernel.org>, <erosca@de.adit-jv.com>,
	<Maksim.Paimushkin@se.bosch.com>, <Matthias.Thomae@de.bosch.com>,
	<Sebastian.Unger@bosch.com>, <Dirk.Behme@de.bosch.com>,
	<Eugeniu.Rosca@bosch.com>, <wqu@suse.com>, <dsterba@suse.com>,
	<stable@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>, ken
	<ken@bllue.org>, <syzbot+d13490c82ad5353c779d@syzkaller.appspotmail.com>,
	Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 4/4 for 5.15 stable] btrfs: fix race between reading a
 directory and adding entries to it
Message-ID: <20240126190926.GE2668448@lxhi-087>
References: <cover.1706183427.git.fdmanana@suse.com>
 <1fd8f27289a8608c77f66c065d6fda87a7d89628.1706183427.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1fd8f27289a8608c77f66c065d6fda87a7d89628.1706183427.git.fdmanana@suse.com>
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

On Thu, Jan 25, 2024 at 11:59:38AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> commit 8e7f82deb0c0386a03b62e30082574347f8b57d5 upstream.
> 
> When opening a directory (opendir(3)) or rewinding it (rewinddir(3)), we
> are not holding the directory's inode locked, and this can result in later
> attempting to add two entries to the directory with the same index number,
> resulting in a transaction abort, with -EEXIST (-17), when inserting the
> second delayed dir index. This results in a trace like the following:

[..]

> Fixes: 9b378f6ad48c ("btrfs: fix infinite directory reads")
> CC: stable@vger.kernel.org # 6.5+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Based on https://lore.kernel.org/stable/20240126185534.GA2668448@lxhi-087:

Reviewed-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>

