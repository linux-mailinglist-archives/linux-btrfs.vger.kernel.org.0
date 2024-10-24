Return-Path: <linux-btrfs+bounces-9120-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3919ADB48
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 07:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B20E1C21AF9
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 05:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A551741DC;
	Thu, 24 Oct 2024 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sHPFmfVC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80127170822
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 05:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729746871; cv=none; b=Y4lKhJcSjUPVSOXj2zq1bKE4t/CXCPX7Vb+BoT9Verjxa4zIPHJzBmmza2Dg2iMww/q+TSVZyz2GgEDg6rJz1aBM8+nhaJarmeQvF4qYRtDtvh/x6tUIlwmZ/nz+VxG0r7IPGJZDLgNZv/f0Hww1lhXnuJAeu9NnZKAAglX3goc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729746871; c=relaxed/simple;
	bh=USJHqduBqx6xC8cRR4ReCyoUFRxc4ZzYxRHRz6uqmSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvzcAyTJkNII4vCtp5UVpAoDkCh35M2vj+RnOMR8ADnVI9sVtXYXbtGFYWLfnV0EN7cnbGDuBxFoL5efOF3Dr9BUOyGnPgIQQOcuM24zbOzlElTvdbqoQgFRoOgo0bm76E7w8LaKBDSdysKtBBBRmovwJ1mNt0t9v6zsNBxwp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sHPFmfVC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=USJHqduBqx6xC8cRR4ReCyoUFRxc4ZzYxRHRz6uqmSs=; b=sHPFmfVCSddS01rQBXcrNFdk5d
	sBH3JeBZOdHTBfNQ1O9lr5vKm2yLAM8rVoiMkP1vFch3CiGI94ikg7V9wg/DyWD83YcmZqubJxyPf
	/kYQYPPP2TMhg4GkIb1qktzQTN/PNAG6/e3ombY99rc64MqR82geAdGM5W2N7/e0MjkNVyQSIiewT
	IcL3ygHNlLEkQ6jqYivt7I3p7rENdgBhmiAnQNTHQEJdJDgUfGjooGqVxnW18yVs5pGd8O0Jh8QHj
	8sBxgo7f4angcFd//sY20hv17xRBAoGTjyL+m2OfX2UqqcPGiW75ccklBX5DsTW5dNH92h95+inkS
	JrN2y9RA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3qB2-0000000GmB3-0HqT;
	Thu, 24 Oct 2024 05:14:28 +0000
Date: Wed, 23 Oct 2024 22:14:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: avoid deadlock when reading a partial uptodate
 folio
Message-ID: <ZxnXtI_6HCwvCvLT@infradead.org>
References: <62bf73ada7be2888d45a787c2b6fd252103a5d25.1729725088.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62bf73ada7be2888d45a787c2b6fd252103a5d25.1729725088.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 24, 2024 at 09:43:47AM +1030, Qu Wenruo wrote:
> There is also the minimal fio reproducer extracted from that test case
> to reproduce the deadlock:

Please add this to xfstests.


