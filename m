Return-Path: <linux-btrfs+bounces-13154-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4538A92F7D
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 03:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55984A4E7C
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 01:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB4E2222CA;
	Fri, 18 Apr 2025 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwet6RSY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017C221564;
	Fri, 18 Apr 2025 01:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940645; cv=none; b=EFFc2f35vRLFT45VN770XEvWfnuIk8gEJUdTe1HwZwsV6h0a7t0DCBFZrcUx8rCu+wFlziJsDlxNA1aw0gPHV/RQvV60vmf1Pq0JqfMXbHauSfq7ICTXRVPpPwe4qKwKPzPL0wrg0kZq4I5CM8dCbaBtflDJ9MX70by/bFMpGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940645; c=relaxed/simple;
	bh=3xtx0zvPv0++l1qHx9p/OcpGhc7KyeyMRsiCaL9lrPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxWoW7YKBvBDa9ib4aBAA9pjBb9GTR+0pF44uREcoa1TyW2GDuSfaGV23TUGDLLcjj9yObL/dO5i4Z+uStCDg1sy4PdvWgEEvw8FWV1vGF7bLK6C8YS9XmVf7OrqjjzyhiAxKRs3gxZ2CDDCUAc3k29ih6ospKk3b20mA/FO6Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwet6RSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287C4C4CEE4;
	Fri, 18 Apr 2025 01:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744940645;
	bh=3xtx0zvPv0++l1qHx9p/OcpGhc7KyeyMRsiCaL9lrPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwet6RSYdaOcUwbIkW9zBAkHI8EBMmFaFUxGv+7L6sWzvoidK+jEwnNf3PsyltKzX
	 SEBZ3Ntk0leyQuUYx7qr2DgBUSUTegFGXivGpC5Rw6cDKQbfuwwx0Cml5w2LcLUp+q
	 wychBoK41djQ2mDlBZFMAha97FofJfnGFRysKazYWnJlrVeDt6Ibb9VXAb9TWmumZn
	 /Bht8F88cfpYimtH0sObRgRUmomifdCk+LdyupuRcRdBS1Q0D2V3tlqMnZEn+JzUlD
	 IGYeMIKLZ4XrnApvmM0j+2hELU2riMP/LLLEAc3cu/Qse2srcuFitCn03sH2Z2SAM5
	 gXueOr07kPtyw==
Date: Thu, 17 Apr 2025 18:44:03 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"kdevops@lists.linux.dev" <kdevops@lists.linux.dev>
Subject: Re: btrfs v6.15-rc2 baseline
Message-ID: <aAGuYx2b9cXTQPfF@bombadil.infradead.org>
References: <Z__4Fu6VsCVDFKkO@bombadil.infradead.org>
 <8cf1f475-2f3f-40ca-8551-9310e6085691@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf1f475-2f3f-40ca-8551-9310e6085691@wdc.com>

On Thu, Apr 17, 2025 at 09:04:20AM +0000, Johannes Thumshirn wrote:
> On 16.04.25 20:34, Luis Chamberlain wrote:
> > Few questions:
> > 
> >   - Is this useful information?
> >   - Do you want results for each rc release posted to the mailing list?
> 
> YES and YES!!

Great. Well so it is very easy to submit these.

> > [0] https://github.com/linux-kdevops/kdevops/blob/main/playbooks/roles/fstests/templates/btrfs/btrfs.config
> 
> Soemtimes it'll help to finish reading, yep it's SCRATCH_DEV_POOL.

Indeed :)

> > [1] https://github.com/linux-kdevops/kdevops/blob/main/workflows/fstests/btrfs/Kconfig

Dashboard:

https://kdevops.org/btrfs/v6.15-rc2.html

  Luis

