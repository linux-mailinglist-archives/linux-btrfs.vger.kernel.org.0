Return-Path: <linux-btrfs+bounces-1775-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5371783BD79
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 10:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E807C1F2F1AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 09:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0356D1CA86;
	Thu, 25 Jan 2024 09:35:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD81CD02;
	Thu, 25 Jan 2024 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175315; cv=none; b=G1hkcX6ljDWLSm4Yy53ZbHL5a1HfX4UyChPeVuADxSN6/NyWmUj1EMbuA78FLz3H7ZKZC5/1C36hNsY0qFLOW6cuEZ1aPA7TG9+lYeDP5NmyuJRRSCK28TR00APoIVHHYweBXAAMjqcdBuZDhBkScQjPpaU3lTUBm+4UwQQDYDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175315; c=relaxed/simple;
	bh=AQSN9Q1PAAbubUBGX8oG4cbN7iB2kdSOPlTunpFpCxk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKzNjnvOhAq+2ToXNGiLnBqQvEaIWzNqh0+VX7+fqHKDe+OWKu4hQJnRhDv3fdmj2j2tkH/UIWkVghE3xwdW9Ba3layRyyNYFo6k6MtGiIIziiE+6HwiJ+gnxpK9G9y3xYNZeSDR3CaSFoIXlsSyPukqRMtrpSYCdJW/bDlj8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 0701552038C;
	Thu, 25 Jan 2024 10:35:09 +0100 (CET)
Received: from lxhi-087 (10.72.93.211) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Jan
 2024 10:35:08 +0100
Date: Thu, 25 Jan 2024 10:35:04 +0100
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Qu Wenruo <wqu@suse.com>
CC: <linux-btrfs@vger.kernel.org>, <erosca@de.adit-jv.com>, Filipe Manana
	<fdmanana@suse.com>, Rob Landley <rob@landley.net>, <stable@vger.kernel.org>,
	David Sterba <dsterba@suse.com>, Maksim Paimushkin
	<Maksim.Paimushkin@se.bosch.com>, Eugeniu Rosca <eugeniu.rosca@de.bosch.com>,
	Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 5.15] btrfs: fix infinite directory reads
Message-ID: <20240125093504.GA2625557@lxhi-087>
References: <88ce65d61253e3474635c589a7de9e668108462e.1706153625.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <88ce65d61253e3474635c589a7de9e668108462e.1706153625.git.wqu@suse.com>
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

Hello Qu,

On Thu, Jan 25, 2024 at 02:17:08PM +1030, Qu Wenruo wrote:
> From: Filipe Manana <fdmanana@suse.com>

Many thanks for the backport!
Conflict resolution looks surprisingly clean!
Please, give some time for verification.

> [ Upstream commit b4c639f699349880b7918b861e1bd360442ec450 ]

PS: Not sure the "Upstream commit" is the right one.
Should it be 9b378f6ad48cfa195ed868db9123c09ee7ec5ea2 ?

BR, Eugeniu

