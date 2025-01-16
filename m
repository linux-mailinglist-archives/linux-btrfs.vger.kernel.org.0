Return-Path: <linux-btrfs+bounces-10981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABCEA1375B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 11:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3AB188A619
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2025 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EE31DDC1F;
	Thu, 16 Jan 2025 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+LUdMcW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAEF1991CF;
	Thu, 16 Jan 2025 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021883; cv=none; b=fjkGr22ETS2fRhudb7TlahR52/Og1P1woGwvGF70TO3Ftr+YqgKuPFrjbiyDFY1Gfvnc97bTlKpnA2BUntyUmHpY5FaVD9XHwVNF9fv+DIR6wRXjcD2WGNEFkbGhnw73Jh2l1CR2Q/lURNphSDlafp8mj41oaUU67fTeFGy7/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021883; c=relaxed/simple;
	bh=umRE6v25xluhGP765JX3qQKm9iDvOyK2b54s+f7mP5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKpEu7mMRSQRuJ6WKG0IyUtGvZ7bddsqPCEhuGYuM+8dCIRRF1lNdQGX2+99L+Gg/eNpA5s943EWzCa29StZhb0zNeNS8/U3Eiani8IcuAgId+THsSI6rOLbylGs25wJaA4V6cl9umQFVxzkxEsOzbfhdPB/BfXk/smWPtF3V+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+LUdMcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18E2C4CED6;
	Thu, 16 Jan 2025 10:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737021882;
	bh=umRE6v25xluhGP765JX3qQKm9iDvOyK2b54s+f7mP5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+LUdMcWSz6X0NwN2VNwxC18SbqevUZzZF8qtF5uuMwgUobfeARBDRExAA/Br6LLU
	 4RsBrAC6sLgqV4uEtwS4uppHqkaEzEC95BuWO7NUpiHoE2oUkB551WKoQ9SyGe1XQ0
	 SZKt8/9g0nHClUkYXBbbM0EdANZO63jSgVd4nQHIKPRujdjEeX4gneeDTnKMDqa5VH
	 0WBDUV/bn4GRzPALGj2rB1j2hxX4yjdcjGBesXzU1cssKtpp01fQ0O/GSGIplAgcxg
	 Xy6WqJUVqPMl0FzVExkqFy0HG96UvxihmvbWRrr3k5EbYsVv9eYI3hGgiVhV/5D3AE
	 jFbIznUVIvk2g==
Date: Thu, 16 Jan 2025 11:04:36 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	linux-btrfs@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z4jZtH2lhsZ3JTZ9@ryzen>
References: <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
 <Z3ZhNYHKZPMpv8Cz@ryzen>
 <20250103064925.GB27984@lst.de>
 <Z3epOlVGDBqj72xC@ryzen>
 <Z3zlgBB3ZrGApew7@xsang-OptiPlex-9020>
 <Z35VVvuT0nl0iDfd@ryzen>
 <Z4DD1Lgzvv66tS3w@xsang-OptiPlex-9020>
 <Z4efKYwbf2QYBx40@ryzen>
 <Z4ipFFdAppraxrmA@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4ipFFdAppraxrmA@xsang-OptiPlex-9020>

On Thu, Jan 16, 2025 at 02:37:08PM +0800, Oliver Sang wrote:
> On Wed, Jan 15, 2025 at 12:42:33PM +0100, Niklas Cassel wrote:
> > 
> > Looking closer at the raw number for stress-ng + none scheduler, in your
> > other email, it seems clear that the raw values from the stress-ng workload
> > can vary quite a lot. In the long run, I wonder if we perhaps can find a
> > workload that has less variation. E.g. fio test for IOPS and fio test for
> > throughout. But perhaps such workloads are already part of lkp-tests?
> 
> yes, we have fio tests [1].
> as in [2], we get it from https://github.com/axboe/fio
> not sure if it's just the fio you mentioned?

Yes, that's the one :)


> 
> our framework is basically automatic. bot merged repo/branches it monitors
> into so-called hourly kernel, then if found performance difference with base,
> bisect will be triggered to capture which commit causes the change.
> 
> due to resource constraint, we cannot allot all testsuites (we have around 80)
> to all platforms, and there are other various reasons which could cause us to
> miss some performance differences.
> 
> if you have interests, could you help check those fio-basic-*.yaml files under
> [3]? if you can spot out the correct case, we could do more tests to check
> e70c301fae and its parent. thanks!
> 
> [1] https://github.com/intel/lkp-tests/tree/master/programs/fio
> [2] https://github.com/intel/lkp-tests/blob/master/programs/fio/pkg/PKGBUILD
> [3] https://github.com/intel/lkp-tests/tree/master/jobs

I'm probably not the best qualified person to review this, would be nice if e.g.
Jens himself (or others block layer folks) could have a look at these.

What I can see is:
https://github.com/intel/lkp-tests/blob/master/jobs/fio-basic-local-disk.yaml

seems to do:
    - randrw

but only on for SSDs, not HDDs, and only on ext4.



https://github.com/intel/lkp-tests/blob/master/jobs/fio-basic-1hdd-write.yaml

does test ext4, btrfs, and xfs,
but it does not do randrw.


What are the thresholds for these tests counting as a regression?
Are you comparing BW, or IOPS, or both?

Looking at:
https://github.com/intel/lkp-tests/blob/master/programs/fio/parse

It seems to produce points for:
bw_MBps
iops
total_ios
clat_mean_ns
clat_stddev
slat_mean_us
slat_stddev
and more.

So it does seem to compare BW, IOPS, total IOs, which is what I was looking
for.

Possibly even too much, as enabling too much logging will actually affect
the results, since you need to write way more output to the logs.

But again, Jens (and other block layer folks) are the experts.


Kind regards,
Niklas

