Return-Path: <linux-btrfs+bounces-8780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB17B9985F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 14:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5DC1C22B01
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 12:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA8E1C463B;
	Thu, 10 Oct 2024 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="jfIeThOP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141761C5782
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563387; cv=none; b=AE7oowOp7+a81EnGJ4y3WvwqgbYCWhqsNs+HZKfs/o1kIQ0gmRqF7SbRjRdM45TiuQxBzmuYyJO1xeS2eO2vu2h6rabv3QSUusGv8z/jCW/xVbvCLEd8KRI+s12CHwQY7neHQEaoHM9oDdV5stjNksNk/JO91zCXqMT/uN0m6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563387; c=relaxed/simple;
	bh=cZycsmxtCy+tEd5tMCHanYnlsEHFVthMbB5UT7EEGkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pRRRzEDQCvn44CFBHqjUIqHRWp8NJLUzyeNLe1daekIfvBdDWiZIG1waBI6jQaW/BXCrwnrnAQOJOKJMO4tJxwFK4UxxAvGqIGFcNkfO0xANxoujuqx1+kppgKatN5Jdpwn9Ud7XJBM04ZyX7dkINhQAiXxAQoTN+tGznCy3lEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=jfIeThOP; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1728563358;
	bh=MYL2Wqn/y8Xg7blReMmRtW4wgQDjh2p5WZPXlRCbFSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=jfIeThOPMctEllDiASG9bLSfLFCUft04Ev071awrV3cNGtXOaI3tCawUtMTZ6MW8O
	 ugq1WfaS5KptDa6sG05Rzqq3BEbbJHEx7Wgv5skLvMDoTLqWqkMrTn7n/ThVQLgANe
	 rIYq2RkFDA8Ph/R9BslkTB6aaj5at1/FVu+2EMYE=
X-QQ-mid: bizesmtpip3t1728563355tr1ig88
X-QQ-Originating-IP: h6TxiSgJuz9LXxGwaJU/x8Z3evn6mOF47moUTSPx+58=
Received: from [IPV6:2408:8214:5911:6ac0:4a3a: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Oct 2024 20:29:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7796492335846993160
Message-ID: <308CF1DDC38EE68A+91e40dff-783f-43f4-9e49-a5cd4fa0b7a8@bupt.moe>
Date: Thu, 10 Oct 2024 20:29:14 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New ioctl to query deleted subvolumes
To: dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20241009180300.GN1609@twin.jikos.cz>
Content-Language: en-US
From: Yuwei Han <hrx@bupt.moe>
In-Reply-To: <20241009180300.GN1609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M182XWJxg1fq3qEpPGmClA4qkgghuTl2cWP3zCZKpQZ/RicrCDG9AVTt
	u+/uBe13n28r9hAakYE/udcZU1Cg8gISzCqPTqJBx7tKeTtrkGJw2IICMR2JtK3jwsmKtcC
	VQJeed65phWZtrJcbhKIpCCTqUoetTvK8/w1vIIKzCLSal0r52bmULZCjwuKDj79ntmbp67
	r0imuPAlXAB6qWStnLwrGB8qAQCLV/ZObEubL/BN16tFjKCGEVGeJBvLobPcQV7ki3wv/HC
	w6LuN3Su38b+QEto7zdnQkq1fDJFs1GxfLfUncqCFwI621xHikenJYeagat7W2+FhHHaxye
	QiX8dCisYQ8VRxvhg5K74Aj+O/7zoiWkdLrcvRKce0Ehcz2mQzA32vMEZu05YzIqiNnLBKX
	W1RxEzfDRsMHe/jOkboFEg/VweUbT9+GvByq/08qUemU1bJ4k5SJEN3Fh3ivhS5wIqDGx9/
	lkBjCxDkMR+LQYgI2FaHh1gylGrQ48w6K8nLpRjQYvBCq9cAqgGUs1ZYeHpVI89RS+Bl6M0
	eEQ9QtZJRstRqbmQrgJ34WG5/NqxYI+Jx0w+u5WKMX4nIKNZZG/k0LQddpTK9JhID0ETjmb
	UWDSf4C1svxbNTIRbHN6jY0GOPCtCr9MxIUYHmLYhxlVpPrHC5F60P3UPiExRCHuiobWWxc
	UIBNIy5aBpfb3wDAWt4e7B13/eeOka98NSpdQWed534W3U1vcM8Yf+8Cy+06kyHPKINHkvB
	RaYhccRSgBZCJkz8M1CaitcZavGM3CZIBt3Ywz069osePRp88WfC6gzuB1D2KF3cY/XalKG
	0mnrwVdnF2HDH3POb8V8g5xhOMWfUPzmL1a2JgbCLFHIHaT1ReOAUCekfq+IfQdDwBEPVRC
	6+qE1nvTp9DO/aCiWYlYcyKNhqJubRpRC6jZ6KLvb/ZY6uTlKavacA==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0



在 2024/10/10 02:03, David Sterba 写道:
> Hi,
> 
> I'd like some user feedback on a new ioctl that should handle several use cases
> around subvolume deletion. Currently it's implemented on top of the privileged
> SEARCH_TREE ioctl, it's not possible to do that with libbtrfsutil or
> unprivileged ioctls.
> 
> The use cases:
> 
>    1) wait for a specific id until it's cleaned (blocking, not blocking)
> 
> This is what 'btrfs subvol sync id' does. In the non-blocking mode it checks if
> a subvolume is in the queue for deletion.
> 
>    2) wait for all currently queued subvolumes (blocking)
> 
> Same as 'btrfs subvol sync' without any id.
> 
>    3) read id of the currently cleaned subvolume (not blocking)
> 
> Allow to implement sync purely in user space.
> 
>    4) read id of the last in the queue (not blocking)
> 
> As the subvolumes are added to the list in the order of deletion, reading the
> last one is kind of a checkpoint. More subvolumes can be added to the queue in
> the meanwhile so this adds some flexibility to applications.
> 
>    5) count the number of queued subvolumes (not blocking)
> 
> This is for convenience and progress reports.
I don't understand why we need to get the status about subvolume 
deletion. Can you provide some real world usage?
> 
> There are some questions and potential problems stemming from the general
> availability of the ioctl:
> 
> - the operations will need to take locks and/or lookup the subvolumes in the
>    data structures, so it could be abused to overload the locks, but there are
>    more such ways how to do that so I'm not sure what to do here
Since it's privileged operation. I think it is up to users. But we can 
have some hints like balance do.
> - deleted subvolume loses it's connection to path in directory hierarchy, so
>    querying an id does not tell us if the user was allowed to see the subvolume
> 
> - the blocking operations can take a timeout parameter (seconds), this is for
>    convenience, otherwise a simple "while (ioctl) sleep(1)" will always work
> 
> 
> My questions:
> 
> - Are there other use cases that are missing from the list?
> 
> - Are there use cases that should not be implemented? E.g. not worth the
>    trouble or not really useful.
> 
> I have a prototype for 1 and 2, the others would be easy to implement
> but the number of cases affects the ioctl design (simple id vs modes).
> 
> Thanks.
> 
Overall I am confused about this message. Did I miss something before?

HAN Yuwei


