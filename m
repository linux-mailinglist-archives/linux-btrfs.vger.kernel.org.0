Return-Path: <linux-btrfs+bounces-18600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F39AC2E535
	for <lists+linux-btrfs@lfdr.de>; Mon, 03 Nov 2025 23:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE0E3B3C04
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Nov 2025 22:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1452FD7C3;
	Mon,  3 Nov 2025 22:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfL7WxQU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0586F2E6CD7;
	Mon,  3 Nov 2025 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210392; cv=none; b=hNLGQieQRN8a3XJ0Mfh5nSLFWCaUSjZA8aikExDuQUVO/tzCV+ui56onMe3+OjFWpp+j11oh1tWb8X4hLBOEqd8ahMs0VSclEoOUDu2LFHxEUuc261I/Kz+OpqtckCwPon9jbkFRYC7hpZAKGmBu+ovNmxumxZymsZCbwE80I4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210392; c=relaxed/simple;
	bh=WBARSNQ3hEr+eRuvUGl99YKoORdWOJ7tKJ/JcvFjW9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfxQmBWpLski9spwRPS3qrlaC+Kc5Byl7noXRCEhKWvCQnuR+FceGtrGhUbS3Gh0VTtdvyxH/8wfGOUIM1F1T4l/90k8DTG8kEwncS//9QJi0n2Gq7E1E9ahvDtJtdYLnsLeKJw1sOhJgK6ABVt8vGymYmDLzalSCYZ8bBlXnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfL7WxQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADADC113D0;
	Mon,  3 Nov 2025 22:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762210390;
	bh=WBARSNQ3hEr+eRuvUGl99YKoORdWOJ7tKJ/JcvFjW9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FfL7WxQUONNlpa4nEEOXvIhPEK0lBNXlpobuGYqGSsSI1z4jeDdjk2KYJbNGZ3NpD
	 ob6S+2ECZP8KGF0zPzUYND+Zn3Z4EXHcxH2AMU5gzr0vcfnrdhYztxSQyveFbmZm7A
	 HX58Z6PSx92EksOvIDwz1TJ/tleVhPfFbW269buZ/US3nfkZEjhnfIUF9olXtJaNMU
	 VoEGdOf4+rj+YIYsmRh4ZqtElLP0FS32u9xyxzaSgrO/9Ba2HKZz9Y1OS6BuKb/CwV
	 85rsZFrcHMVD+66BJHwY2UfevZyV/+t+I96bj3IUdj9tN3AQywDx1TZkJY61efArra
	 OUBKzxVfk0MXg==
Message-ID: <83b60505-64a4-40fe-aa50-02a56ca7ad8c@kernel.org>
Date: Tue, 4 Nov 2025 07:53:07 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] block: track zone conditions
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
 Mike Snitzer <snitzer@kernel.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 Carlos Maiolino <cem@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 David Sterba <dsterba@suse.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-8-dlemoal@kernel.org>
 <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org>
 <93215b7c-80bd-4860-8a77-42cdd4db1ec6@kernel.org>
 <95c729d6-fd73-4480-af1c-68075b31cd1d@acm.org>
 <6008fbc8-b556-46d9-98a5-a4622731d206@nvidia.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <6008fbc8-b556-46d9-98a5-a4622731d206@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/25 01:34, Chaitanya Kulkarni wrote:
> Adding Keith's current email address :
> 's/Keith Busch <keith.busch@wdc.com>/kbusch@kernel.org/g'
> 
> On 11/3/25 7:48 AM, Bart Van Assche wrote:
>> On 11/2/25 10:05 PM, Damien Le Moal wrote:
>>> On 11/1/25 06:17, Bart Van Assche wrote:
>>>> On 10/30/25 11:13 PM, Damien Le Moal wrote:
>>>>> Implement tracking of the runtime changes to zone conditions using
>>>>> the new cond field in struct blk_zone_wplug. The size of this 
>>>>> structure
>>>>> remains 112 Bytes as the new field replaces the 4 Bytes padding at the
>>>>> end of the structure. For zones that do not have a zone write plug, 
>>>>> the
>>>>> zones_cond array of a disk is used to track changes to zone 
>>>>> conditions,
>>>>> e.g. when a zone reset, reset all or finish operation is executed.
>>>>
>>>> Why is it necessary to track the condition of sequential zones that do
>>>> not have a zone write plug? Please explain what the use cases are.
>>>
>>> Because zones that do not have a zone write plug can be empty OR full.
>>
>> Why does the block layer have to track this information? Filesystems can
>> easily derive this information from the filesystem metadata information,
>> isn't it?
>>
>> Thanks,
>>
>> Bart.
>>
> 
> In case current file systems store this, isn't that a code duplication for each
> fs ? perhaps having a central interface at block layer should help remove the
> code duplication ?

catch 22: You cannot ask the file system without first knowing the zone layout
and conditions of zone to check the file system metadata.


-- 
Damien Le Moal
Western Digital Research

