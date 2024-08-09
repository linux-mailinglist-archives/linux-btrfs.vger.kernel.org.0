Return-Path: <linux-btrfs+bounces-7067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F15A94CC84
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 10:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DDB1C21397
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Aug 2024 08:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A9218F2C4;
	Fri,  9 Aug 2024 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b="hIudad5H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95F918C329
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Aug 2024 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193094; cv=none; b=pb4a+A4P55RLcTYc/Rtpo+BVOtja4dEQ+j2l4pI/jFEjOPRRiMBBqtQBYwDp+ibQQPlJSZaneggqHmxJe0hftORzPbJU8xDsASLetj3+1Af5v8kM98x8A8cg7bIJMw3CS4JMLw0VQv7+zCk1mfViIaIPbilV9JQcP4HY+mrx4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193094; c=relaxed/simple;
	bh=H0pzJ+L+pnM49vhccXd11dslMHmjaJobNHsuNthlaF8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FGu4wt5c+UXymrXsS4FEviA93RvnSj8Lp4B7JUfRtTb9hwoxVtqepWLPoCdcrfUDw1gZ+S9K0nNaD+SHalYCMnBy8IVtX6bftQDFJTMJVrIlKnYK73CmWLJ8kieHR+Mk/jufM785ehpFwhaX6/pNieOrbH0Xebn7BMhYeZGfluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net; spf=pass smtp.mailfrom=dirtcellar.net; dkim=pass (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b=hIudad5H; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dirtcellar.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=dirtcellar.net; s=ds202312; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
	Reply-To:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=epwmmS3rAXTzWq/YmMrAHUTJSvxhZVLt0TcB9pUQUi0=; b=hIudad5HL+hvZxoq3lLCNzJ/MJ
	85GSIVVMC4D1FmEmBc8KTkHKrQK5y8wWqNhxvYv/PKwoYbQyXTyNXgPn0PGrySb2fYUEL5pBnXXX3
	H6Sz3TnY4fnpt2Tn+SRl3gmqj0ONYqF39QMVwFOPq5NIZRvZkBZhJQ1V5IK9791FYiIEFUNvow3if
	FX7kBPVXzO3n9cN0PXWc0Vjg62zRwbfJGBeYa3Y5O4gC/JoI6xhIuavjHfL5AmFLnKEczSGdoEpzo
	d1UvsCX0muJB2xHOGcJr0YWC4Tivp1I/EvJp1SatQ0Xznq3Tgb32z0S8SeFNQKpIV2CzSIjDzM/jx
	jd3ozpVg==;
Received: from 203.92-220-130.customer.lyse.net ([92.220.130.203]:58652 helo=[10.0.0.100])
	by smtp.domeneshop.no with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <waxhead@dirtcellar.net>)
	id 1scLEv-001c9a-4N;
	Fri, 09 Aug 2024 10:44:49 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: Round robin read policy?
To: Anand Jain <anand.jain@oracle.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <87c646e8-c27e-6853-feaa-38b480892d60@dirtcellar.net>
 <54cf8c1c-b333-432c-bf37-0029ba0bf0e4@oracle.com>
From: waxhead <waxhead@dirtcellar.net>
Message-ID: <330190f8-b421-82ae-5819-69707eb29745@dirtcellar.net>
Date: Fri, 9 Aug 2024 10:44:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <54cf8c1c-b333-432c-bf37-0029ba0bf0e4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Anand Jain wrote:
> 
> There are patches for other types of read-balancing already, like
> round-robin and commands-inflight, and there are also patches
> based on dynamically benchmarking devices—some of which are in my
> local repo.
> 
> PID or round-robin perform fairly well when devices are of the same type
> and there are multiple threads generating I/O. However, this is not the
> case in defrag, where there is only one thread.
> 
> Neither PID nor round-robin helps if the underlying devices have
> unequal read performance. Both methods can result in lower read
> performance if data is read from slower devices.
> 
> Another approach is to benchmark the devices during `mkfs`, but this
> lacks accuracy and carries the risk of performing unnecessary writes.
> Good read performance on some devices doesn't necessarily translate
> to good performance for read-modify-write workloads.
> 
> When trying to base decisions on the dynamic performance of devices,
> earlier patches became complicated because we needed to know the read
> performance of devices at the block layer. Calculating these performance
> numbers wasn’t readily available, and doing it in the filesystem layer
> was expensive.
> 
> Finally, I tried basing it on theoretical expected read performance,
> but the necessary information wasn’t available, and it seems that
> those patches were rejected by disk vendors.
> 
> So, I concluded that manually telling Btrfs which disks are preferred
> for reading and how to allocate metadata/data chunks is a better 
> approach. And balance reads across only those devices.
> 
> Thanks, Anand
> Thanks for the (much needed) recap, but my question about considering a 
round robin based approach really had nothing to do with performance at 
all. In fact lower performance is perfectly acceptable for the reasons I 
described.

...And since the topic is interesting (and I am getting carried away a 
bit) - if a performance oriented read profile is to be considered, would 
not simply maintaining a fixed queue length (and/or size) to the 
underlying block devices be enough?!

A fast device will clear its queue faster and therefore more jobs gets 
assigned to that device (as you are trying to keep the queue length/size 
constant). Likewise a slow device will take longer to clear it's queue 
and less jobs will get assigned. E.g. solving the need for complexities 
such as performance benchmarking / dynamic magic.

