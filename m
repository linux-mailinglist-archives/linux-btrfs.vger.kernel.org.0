Return-Path: <linux-btrfs+bounces-11440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB4A337B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 07:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B6047A4B13
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 06:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33196207651;
	Thu, 13 Feb 2025 06:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="X18uaEsp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B894A01
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2025 06:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426999; cv=none; b=HfP54t0EGeYvjFsGgUeqykTyiU1Ifqnz/RXG5PGurX+BSWmkkIv5/xQO7JYtUmYwokkiv1hAIlo3rmapfmrPRw5X1cLwDOWzqPgPsFQsHA9RqVT2luOOHnLCGlhTvtqpUCyNAGb8siKLoAdnp5ctq1hoatScj5tEtlN17GJv2mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426999; c=relaxed/simple;
	bh=maRI+9H2yYGgWhKs/KD78eTX2twhjBHxhqGY8qxSjUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6a8nCYjuB+pcwHDN6IojEV0iUcpSQ5n40GDXw4cMsHW2ojcuAhuicrGuFsBi8K0Tc5nf1phobIURlzngxYVedryDltA7EXUh7js06UaqcmO9Dmf0cW1La+YswZ4PZdOg8iuvBkZjuUaIrdDQSDKnpwsp1RNWMabCrLhndjZuIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=X18uaEsp; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Message-ID: <5bc29d35-2eef-407e-9e71-761c05c0d6e2@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1739426994; bh=maRI+9H2yYGgWhKs/KD78eTX2twhjBHxhqGY8qxSjUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=X18uaEspjz7AnjBPZxnLfc3+x/wEtZsT/U1m/bHTNShl/s73ruuxBwUwRpE8BIjEU
	 Lui9q8vRGeqC3LUKg2zBwaHjyaf0Dj3C5zORebZmma0aPdRMjxAyCsPf+H/NAiL2M4
	 0oASpaB40f9XqfsAA73j3fiW291jDE3lovfzpHgI=
Date: Thu, 13 Feb 2025 14:09:53 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs-progs: Preserve first error in loop of
 check_extent_refs()
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250212064501.314097-1-tchou@synology.com>
 <cac8d40a-b631-4c58-b8b8-70db3ab58443@gmx.com>
 <20250212232927.GA5777@twin.jikos.cz>
Content-Language: en-US
From: tchou <tchou@synology.com>
In-Reply-To: <20250212232927.GA5777@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no

David Sterba 於 2025/2/13 07:29 寫道:
> On Wed, Feb 12, 2025 at 05:44:57PM +1030, Qu Wenruo wrote:
>> 在 2025/2/12 17:15, tchou 写道:
>>> Previously, the `err` variable inside the loop was updated with
>>> `cur_err` on every iteration, regardless of whether `cur_err` indicated
>>> an error. This caused a bug where an earlier error could be overwritten
>>> by a later successful iteration, losing the original failure.
>>>
>>> This fix ensures that `err` retains the first encountered error and is
>>> not reset by subsequent successful iterations.
>>
>> SoB line please, otherwise looks good to me.
> 
> For btrfs-progs teh SoB line is optional, I think it's mentioned in the
> README. It makes sense for kernel to insist on the attribution and some
> trace to real people but btrfs-progs are much smaller and I think it's
> better to lower the contribution barriers.

Thanks, I will add it next time send patch.

> 
>> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks, feel free to add the commit to devel.
> 

Do I need to send PR in github of btrfs-progs, or maintainer will add
the commit directly?

>> And if it's a case you hit in real world, mind to extract or craft a
>> minimal image as a test case?
> 
>  From my experience, casual contributors will rarely write tests and I do
> not do that when I'm sending a fix or reporting a problem to other
> projects. In order to keep the track of that it may be best to open an
> issue, unless you or me will write the test case.

Not the real case, but fake case by modifying the bytenr of extent to
wrong number when test the correctness of function we develop with
backref check. I think every backpointer mismatch case can test it.

Thanks, TCHou

