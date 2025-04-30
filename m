Return-Path: <linux-btrfs+bounces-13564-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C36AA5406
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 20:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D251893D30
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D636D26562F;
	Wed, 30 Apr 2025 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dccxPhkB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E20828399;
	Wed, 30 Apr 2025 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038766; cv=none; b=ETe8daHYGqA0UKEPa+7g/YP3r63cIN9NKcQAHZMrFdH7i2hnGO03smQ7iJ1jCffYsfZCR6NhwV/KH4xP0BbgPHP6DbM9eExcHwg8SvnR9z3QPw8WeYVgA8Jvq6p0f2fXBhVzSnCDDME2OM62Cc69oHunnZ0oo2TpoceRCLbXQbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038766; c=relaxed/simple;
	bh=1O6KGRH/0QIrWe0dsHMNySQNbxcnTurVGj2hFZCyst8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UreOWHD9z8xZwe/3CfJQ+MbFOFZzfFNjrphtiA0xZ1B5PfqQroxBQSRgqakLGmdg3E/FN4gzRSrnZS2WZeWj5JJu+du9D4OUlfMbumLZDaUrcqu0STlBshKvp9fS3CG63H+cjLwSn9Z5po2tVEqHBhQ9qVvriZ0TDI18dC7oaR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dccxPhkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C669C4CEE7;
	Wed, 30 Apr 2025 18:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746038765;
	bh=1O6KGRH/0QIrWe0dsHMNySQNbxcnTurVGj2hFZCyst8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dccxPhkB//3NUIpEDCVkI1xz9KngrZsorqdcU/O8PtxtutYRdvIv7oYIE0gUv+3Gf
	 +8TlzieaWZYUdqXA6EYvFtc1zFU5l2J9Pp5D+cnGwDJFmHW72LZhsvZSdCdXT2UzGR
	 SovcRtslzTl+6CpgeWH1hsfgMTnJsLzOGkzCcOU4AWwKoIcWuPD5Xu984hORYy1j5y
	 JdtzuXktKYQ++05RJ7SCftgb0f+LJhNIeyLJeXuBq2G0w9hu+wK02CghtA0mAohLNM
	 n70D0nS2WKWWQ7KC/+xGxv2QkYQx+0QkkG07MPzHC753vsHiMB70pq+L7YCf1h5Bqt
	 VEDBaGjv3AbiQ==
Date: Wed, 30 Apr 2025 08:46:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Junxuan Liao <ljx@cs.wisc.edu>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: btrfs thread_pool_size logic out of sync with workqueue
Message-ID: <aBJv7AuXubBDQNIq@slm.duckdns.org>
References: <5ee9b1d7-4772-4404-b972-93b01ed1e033@cs.wisc.edu>
 <aBEWmCB5Ofr5lCp7@slm.duckdns.org>
 <476f9bf7-2cd2-4c26-b55f-b42b9fe7eafc@cs.wisc.edu>
 <aBEb3kjVKcqzNBov@slm.duckdns.org>
 <ea32d8f1-e96a-48ff-92b6-ffeb996b0823@cs.wisc.edu>
 <53a8e583-f3bf-4efc-afa5-fe9d8af287a9@cs.wisc.edu>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a8e583-f3bf-4efc-afa5-fe9d8af287a9@cs.wisc.edu>

On Tue, Apr 29, 2025 at 04:26:52PM -0500, Junxuan Liao wrote:
> On 4/29/25 4:15 PM, Junxuan Liao wrote:
> > So versions from 6.6 to 6.8 do have the bug, right? I guess the
> > performance regression isn't easy to trigger so no one noticed and
> > reported it.
> 
> My bad. I missed that it has already been reported in 2023.
> https://lore.kernel.org/all/dbu6wiwu3sdhmhikb2w6lns7b27gbobfavhjj57kwi2quafgwl@htjcc5oikcr3/

Yeah, the changes were too invasive to backport through -stable especially
at the time as I didn't know how well the new scheme would work. There have
been some updates afterwards but it seemed to have held up fine, so if some
distros wanna backport them, this should be pretty safe now. However, I
think the window has already passed for -stable backports.

Thanks.

-- 
tejun

