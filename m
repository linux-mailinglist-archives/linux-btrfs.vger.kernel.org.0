Return-Path: <linux-btrfs+bounces-11218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E70A2523A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 07:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C5A1627B8
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 06:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BDD42A94;
	Mon,  3 Feb 2025 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b="D7ptQmEr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zero.acitia.com (zero.acitia.com [69.164.212.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87914A4F0
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 06:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.212.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738562773; cv=none; b=OPZq0S86v7Lx8wCrApW2/8V1WZhfJQHxTAmH9z9NiAA/K6eu9AS88TezLWpok6yXR1GI4d9IsOb3c5j0Lq0SMAx1p3YeE6CpmCWNbUA3PTYVBz0boCGq+wBsKqOvcMMNXFN5Zce2RslaFLUSbEp73fYBP1eFDV3vXBjJrVpN5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738562773; c=relaxed/simple;
	bh=YnvslVgS/HEs9nVWrc5hEok7S1gpVbtnLer1bdg+QHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dnwCX5fU+pHssUH5Mz29RvoV2t7LJCck2Gue1pANQwC6trUks5xptjPJKPNDTCDldtTk/7iMpKjO7G98BjpqIaOgox9aBNBgSqFyM3FxSYeQ6swuXbxTXyt/LmevcpbRBnpHisAS2NrQ6ufMvrEvTAR0IpcoPz9mpm94R5eL9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com; spf=pass smtp.mailfrom=zetafleet.com; dkim=pass (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b=D7ptQmEr; arc=none smtp.client-ip=69.164.212.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetafleet.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zetafleet.com; s=20190620; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wKJLEOwKFip76yWOBcM+HfPIYHxdvfjEQuf6ZDHelGI=; b=D7ptQmErGJYFeA/iG5S89ah73k
	T82U7bYQHsEFFnpg5Oa6bUm0i90alx9S85mzffrgVbZRv5pVItAFTuMaVzZVpBUEML0mBep3SroKW
	VTXrVMj7LZIISIVqSOB9DNN9OIwB+EqQPxqI3+Ruur6dOCfjAnyPWiUVq6IkCcbGNVHGr0RtoJ/Ct
	dKMWXdyTkrcsVucURqkXJwOp2bXK14G0Q3AyR0MZcP862MRKyu3MjyutKpKDCghWegxTU22YcjN+T
	uh1OYE1Qqo6nRit6K+uRgdecNoglrntwgk3JOQLLzUQqw00guEgIrhjfUGA54JDlRr/G5mKJwPbj/
	suCnsmBA==;
Received: from authenticated by zero.acitia.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(envelope-from <linux-btrfs-ml@zetafleet.com>)
	id 1teoui-0003zo-T8
	for linux-btrfs@vger.kernel.org; Mon, 03 Feb 2025 05:22:29 +0000
Message-ID: <ef9dfa64-63f8-47ad-9857-d40aecb20546@zetafleet.com>
Date: Sun, 2 Feb 2025 23:22:28 -0600
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Converting RAID1 to single fails if RAID1 is missing device
To: linux-btrfs@vger.kernel.org
References: <2cb1d81e-12a8-4fb1-b3fc-e7e83d31e059@siddall.name>
 <d300d923-ed8c-4671-9694-6850d8c9b572@gmx.com>
 <92dbe939-46a6-4142-b6be-3ef69fffce1b@gmail.com>
 <23f97ef3-5d4e-411e-abb3-9725d7f92238@gmx.com>
Content-Language: en-GB
From: Colin S <linux-btrfs-ml@zetafleet.com>
In-Reply-To: <23f97ef3-5d4e-411e-abb3-9725d7f92238@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.9
X-Spam-Report: No, score=-1.9 required=5.0 tests=BAYES_00=-1.9,NO_RELAYS=-0.001 autolearn=ham autolearn_force=no version=3.4.2

On 02/02/2025 20:32, Qu Wenruo wrote:
>
> But I think the ultimate solution is to make btrfs to properly detect
> and support device shut down request.

Yes. How many years and how many more users need to have this problem 
before it’s given some priority?

> Although that would also introduce new complexity, e.g. what if the
> missing devices show up again after missing several writes? 

Since I see you wrote a patch in 2022 to add write-intent bitmap for 
raid5/6, don’t you already understand the answer is a write-intent 
bitmap? Further, did you not see any of the several messages I have sent 
to the mailing list talking about exactly this in the last year? I am 
genuinely confused.

