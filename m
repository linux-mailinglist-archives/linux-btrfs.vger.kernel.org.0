Return-Path: <linux-btrfs+bounces-11181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79392A23027
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 15:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B283A6621
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484F1E7C27;
	Thu, 30 Jan 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="L59Kx8DF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1AE1E6DCF
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247356; cv=none; b=SNu/Al99o0KfJqucRIvFsl0+oLjUYQoEvG+LhaPdwkG2p0sDhuR1BszUQvcMjO6+W/fRw+Yi2zmNmxVm6h0zpIj6Cji40cDJ9UBfxa/SkALFxUjnoCTftAnV4kvIufOmS+4+IbGQHzQSvYH5RspC0WGcIinVUVMJj1jTaXkefdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247356; c=relaxed/simple;
	bh=TB8rkidUprAZce/0uRE2RtxtIg2DEg5hLYqfvl4yowk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHeR+oqnpyZNg6DzhBjboQ1sdXzM+vE+qE67DTlGPKx5poR8B/Rw97dcPA1hvFmZDwz1u2lR9EXhhOfXdo0JSiEsrOzwz3EArypWrEZQ7/JXzVgucejKi0tuyVvVMV/qarDup/Af29el0/iZw7tmus4aaERwVQ+YxEAHduipSvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=L59Kx8DF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([12.221.73.181])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 50UESvQI005998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 09:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1738247341; bh=qsthqpO7eT/PN4h6zfRCZRC0k8LPYXxQFOt5Xt6pPl8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=L59Kx8DF9Ed5Y2eTvdXfoE/6o8wmClyKDv+ynISKDMYdJvTiGCf5SwK9vP8TtFcjR
	 WOA+q+/DMs6ngERetvncxFYIvZtCmnkzEz+v+GI7l4LGPN0A8F9G//O3IUx/T68N9a
	 tnTlWQmplKXqq+Spsb0PGzkJIshxphZkfmF1wj+iLHTtgvH2BBGcTqx0Q4e45tLtEd
	 oICFQ+Apmxkny8WRh7ZKQbYDygSz8m2LMTabL3utUTeWHDChwCutrvflMkBt6jeO/6
	 F+o4GDxFWHf2fXs+oLbhZ5G9OHnOio1+RQ9aYy84/0mQwOi1EKDp9sMPyym2of0jPk
	 Rs9z+Az+1jz3Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0C9853404C7; Thu, 30 Jan 2025 06:28:57 -0800 (PST)
Date: Thu, 30 Jan 2025 06:28:57 -0800
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <20250130142857.GB401886@mit.edu>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130091545.66573-1-joshi.k@samsung.com>

On Thu, Jan 30, 2025 at 02:45:45PM +0530, Kanchan Joshi wrote:
> I would like to propose a discussion on employing checksum offload in
> filesystems.
> It would be good to co-locate this with the storage track, as the
> finer details lie in the block layer and NVMe driver.

I wouldn't call this "file system offload".  Enabling the data
integrity feature or whatever you want to call it is really a block
layer issue.  The file system doesn't need to get involved at all.
Indeed, looking the patch, the only reason why the file system is
getting involved is because (a) you've added a mount option, and (b)
the mount option flips a bit in the bio that gets sent to the block
layer.

But this could also be done by adding a queue specific flag, at which
point the file system doesn't need to be involved at all.  Why would
you want to enable the data ingregity feature on a per block I/O
basis, if the device supports it?

We can debate whether it should be defaulted to on if the device
supports it, or whether the needs to be explicitly enabled.  It's true
that relative to not doing checksumming at all, it it's not "free".
The CPU has to calculate the checksum, so there are power, CPU, and
memory bandwidth costs.  I'd still tend to lean towards defaulting it
to on, so that the user doesn't need do anything special if they have
hardware is capable of supporting the data integrity feature.

It would be enlightening to measure the performance and power using
some file system benchmark with and without the block layer data
integrity enabled, with no other changes in the file system.  If
there's no difference, then enabling it queue-wide, for any file
system, would be a no-brainer.  If we discover that there is a
downside to enabling it, then we might decide how we want to enable
it.

Cheers,

					- Ted

