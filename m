Return-Path: <linux-btrfs+bounces-10972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED5A122EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 12:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918D23AB729
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5107E241689;
	Wed, 15 Jan 2025 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK1UM+rf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A741E98F2;
	Wed, 15 Jan 2025 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941359; cv=none; b=t6HqSAZgv01Ey5lrALKlXPSyr+lyx5uYjDMqQdueZdq/yuTWx+ZIvYCJqOahM5hSsEIjMr5CK/isqAfb1YT9sbnexHOK3jeiWzeSINVF+jYSU2VSDzSpoqmdHpqjM54bn18CCvT6zrSRLT/gPISUP8UFRYxYsGnUzWZ2TqF0OWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941359; c=relaxed/simple;
	bh=pq/v0VSJ9VsZQn33S7S7wvNcGH+oudGNlgIaUU4DpJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4yg66guxVSbb9RfULqrHZ245e/xlLmveEGvj0O6QKNtByWlbQ9wS5wYhIBcS7Y29YRamjtUNHgWSPMedb4+Hzc+5SsqTFo1MAEc3LwFBQvMv4Q0b93FLw/sYHTsOLjIPO6UBlgj7te9TNxPAhUqti8AX0pfyvJ1FkCb8Kxgqkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SK1UM+rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562EAC4CEE6;
	Wed, 15 Jan 2025 11:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736941358;
	bh=pq/v0VSJ9VsZQn33S7S7wvNcGH+oudGNlgIaUU4DpJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SK1UM+rfoqKh/h3BU5ce3vIkS003NTSuW+v6diKDwjMb+JbyjOu6hOcQ4NbQfqUJN
	 94c5rc6AwA+9T1Vy+2lvYgfbl+d62DXYW9tNBrP9p8znN6P96ewJ7Wyys4JPP3EJrd
	 Tx92bEk2LuC3tN50gYqtCXmFbwoq8BA0L2jMNdx3E5n6Q9B3D6V7f6xpO7LGAanP4t
	 rKrNSLjQcpmSGj3fQD9UCpBUoi7+cHw5KwxrVZ+S0noeNhLliYvjdIkBIKEdA89flU
	 YJ9F9cJat63XgK20QD2vguEaHDAf6dEsfajhwp08RlohMxVkDV//k28maTUzgDi4o/
	 HfCCCKF5ZhMpQ==
Date: Wed, 15 Jan 2025 12:42:33 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	linux-btrfs@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z4efKYwbf2QYBx40@ryzen>
References: <20241213143224.GA16111@lst.de>
 <20241217045527.GA16091@lst.de>
 <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
 <20241217065614.GA19113@lst.de>
 <Z3ZhNYHKZPMpv8Cz@ryzen>
 <20250103064925.GB27984@lst.de>
 <Z3epOlVGDBqj72xC@ryzen>
 <Z3zlgBB3ZrGApew7@xsang-OptiPlex-9020>
 <Z35VVvuT0nl0iDfd@ryzen>
 <Z4DD1Lgzvv66tS3w@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4DD1Lgzvv66tS3w@xsang-OptiPlex-9020>

Hello Oliver,

On Fri, Jan 10, 2025 at 02:53:08PM +0800, Oliver Sang wrote:
> On Wed, Jan 08, 2025 at 11:39:28AM +0100, Niklas Cassel wrote:
> > > > Oliver, which I/O scheduler are you using?
> > > > $ cat /sys/block/sdb/queue/scheduler 
> > > > none mq-deadline kyber [bfq]
> > > 
> > > while our test running:
> > > 
> > > # cat /sys/block/sdb/queue/scheduler
> > > none [mq-deadline] kyber bfq
> > 
> > The stddev numbers you showed is all over the place, so are we certain
> > if this is a regression caused by commit e70c301faece ("block:
> > don't reorder requests in blk_add_rq_to_plug") ?
> > 
> > Do you know if the stddev has such big variation for this test even before
> > the commit?
> 
> in order to address your concern, we rebuild kernels for e70c301fae and its
> parent a3396b9999, also for v6.12-rc4. the config is still same as shared
> in our original report:
> https://download.01.org/0day-ci/archive/20241212/202412122112.ca47bcec-lkp@intel.com/config-6.12.0-rc4-00120-ge70c301faece

Thank you for putting in the work to do some extra tests.

(Doing performance regression testing is really important IMO,
as without it you are essentially in the blind.
Thank you guys for taking on the role of this important work!)


Looking at the extended number of iterations that you've in this email,
it is quite clear that e70c301faece, at least with the workload provided
by stress-ng + mq-deadline, introduced a regression:

       v6.12-rc4 a3396b99990d8b4e5797e7b16fd e70c301faece15b618e54b613b1
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    187.64 ±  5%      -0.6%     186.48 ±  7%     -47.6%      98.29 ± 17%  stress-ng.aiol.ops_per_sec




Looking at your results from stress-ng + none scheduler:

         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
    114.62 ± 19%      -1.9%     112.49 ± 17%     -32.4%      77.47 ± 21%  stress-ng.aiol.ops_per_sec


Which shows a change, but -32% rather than -47%, also seems to suggest a
regression for the stress-ng workload.




Looking closer at the raw number for stress-ng + none scheduler, in your
other email, it seems clear that the raw values from the stress-ng workload
can vary quite a lot. In the long run, I wonder if we perhaps can find a
workload that has less variation. E.g. fio test for IOPS and fio test for
throughout. But perhaps such workloads are already part of lkp-tests?


Kind regards,
Niklas

