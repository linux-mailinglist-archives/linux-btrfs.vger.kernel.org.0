Return-Path: <linux-btrfs+bounces-1827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB0A83E233
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 20:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C381F27113
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 19:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780C0224CA;
	Fri, 26 Jan 2024 19:08:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC332231C;
	Fri, 26 Jan 2024 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296102; cv=none; b=UoR72C9dzp5v8/iYdMVtHwDrgz4UBQM1XNAp3Zz6KdPhv2RFuUbzrzhos4n9/j6dZpim2vqnWsccjw4JEy35X3z4M94YF8nTXDcKs4R7s1vUNOXXf0VtR+h2U2Gth/fkUjNnuEN9ABo6LsqIgnhLCu1Y8Q9SOBVL8C9AffqJKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296102; c=relaxed/simple;
	bh=Bwsa7UoqDBd2mqJcIgpCltivMesRoCLIq1WJhSeuahU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0NUL5q/FrzQ6GnysJ8jmkEer5/SwVZPsTThcoXYoaA8h1wSjW/arnN4jsOILcLC2zc/6EU4L3hQ13sOkEKfJEvbRYn+updKWI9kydRGnW+zzcqfjPurrJCNZFXFEbcWIUJ/U1rGrCUgJnZgS3+BE/4HGfcCuCxiS3R94plShO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id DFF15520153;
	Fri, 26 Jan 2024 20:08:17 +0100 (CET)
Received: from lxhi-087 (10.72.93.211) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jan
 2024 20:08:17 +0100
Date: Fri, 26 Jan 2024 20:08:17 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: <fdmanana@kernel.org>
CC: <linux-btrfs@vger.kernel.org>, <erosca@de.adit-jv.com>,
	<Maksim.Paimushkin@se.bosch.com>, <Matthias.Thomae@de.bosch.com>,
	<Sebastian.Unger@bosch.com>, <Dirk.Behme@de.bosch.com>,
	<Eugeniu.Rosca@bosch.com>, <wqu@suse.com>, <dsterba@suse.com>,
	<stable@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>, Ian Johnson
	<ian@ianjohnson.dev>, Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 3/4 for 5.15 stable] btrfs: refresh dir last index during
 a rewinddir(3) call
Message-ID: <20240126190817.GD2668448@lxhi-087>
References: <cover.1706183427.git.fdmanana@suse.com>
 <acbd885da4e8e7076c11bbcc31e0f6090cc10201.1706183427.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <acbd885da4e8e7076c11bbcc31e0f6090cc10201.1706183427.git.fdmanana@suse.com>
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

On Thu, Jan 25, 2024 at 11:59:37AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> commit e60aa5da14d01fed8411202dbe4adf6c44bd2a57 upstream.
> 
> When opening a directory we find what's the index of its last entry and
> then store it in the directory's file handle private data (struct
> btrfs_file_private::last_index), so that in the case new directory entries
> are added to a directory after an opendir(3) call we don't end up in an
> infinite loop (see commit 9b378f6ad48c ("btrfs: fix infinite directory
> reads")) when calling readdir(3).

[..]

> Fixes: 9b378f6ad48c ("btrfs: fix infinite directory reads")
> CC: stable@vger.kernel.org # 6.5+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>

Based on https://lore.kernel.org/stable/20240126185534.GA2668448@lxhi-087:

Reviewed-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>

