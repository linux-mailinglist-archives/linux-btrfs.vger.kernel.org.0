Return-Path: <linux-btrfs+bounces-1825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF5A83E226
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 20:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28744284F12
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 19:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D61422339;
	Fri, 26 Jan 2024 19:06:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B801DDEA;
	Fri, 26 Jan 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295987; cv=none; b=kgMNJyuRJz9pKsl+vYWmbjKv/oDPvNBftDmmMG4VEDtXAWitxSOQzooSfDRfQxSv7UYjPpsbjb6kHGqZsHnjazFsZxVFYCSBfS1iq5uJjzXonNPosyNeKnAPyScdwCpy/fIRuFDhmukgX/GQTZcQXI109UsyuJjHlgfaJ+ySwgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295987; c=relaxed/simple;
	bh=xXPQsqC3MkXQGgBs0nSx8hmzWKCEUoHFpXhEPIdqpQI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q49sBG+Q/SAJwEuH8Cgq0M90OaW6vQBMSpMR65YiU8xYtLTTpouYdQLepDzePcnosQtmCB9oGWE9tNecJUnVhuaAm+IMWMAKwTiejFF6QECtJrxiGyFQL7GMQi7LnsLgYFW5Wmy0DVJW4+kcshtD3dAQWLQ584EmmrOdACcRkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 38ED6520153;
	Fri, 26 Jan 2024 20:06:22 +0100 (CET)
Received: from lxhi-087 (10.72.93.211) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jan
 2024 20:06:22 +0100
Date: Fri, 26 Jan 2024 20:06:21 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: <fdmanana@kernel.org>
CC: <linux-btrfs@vger.kernel.org>, <erosca@de.adit-jv.com>,
	<Maksim.Paimushkin@se.bosch.com>, <Matthias.Thomae@de.bosch.com>,
	<Sebastian.Unger@bosch.com>, <Dirk.Behme@de.bosch.com>,
	<Eugeniu.Rosca@bosch.com>, <wqu@suse.com>, <dsterba@suse.com>,
	<stable@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>, Rob Landley
	<rob@landley.net>, Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 1/4 for 5.15 stable] btrfs: fix infinite directory reads
Message-ID: <20240126190621.GB2668448@lxhi-087>
References: <cover.1706183427.git.fdmanana@suse.com>
 <f1e33797054fcea8b61d88878e67b8c007b5d5f5.1706183427.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f1e33797054fcea8b61d88878e67b8c007b5d5f5.1706183427.git.fdmanana@suse.com>
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

On Thu, Jan 25, 2024 at 11:59:35AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> commit 9b378f6ad48cfa195ed868db9123c09ee7ec5ea2 upstream.

[..]

> CC: stable@vger.kernel.org # 5.15
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> [ Resolve a conflict due to member changes in 96d89923fa94 ]
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Based on https://lore.kernel.org/stable/20240126185534.GA2668448@lxhi-087:

Reviewed-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>

