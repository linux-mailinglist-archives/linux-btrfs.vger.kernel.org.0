Return-Path: <linux-btrfs+bounces-17638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B83BCFE0A
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Oct 2025 02:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D080D349101
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Oct 2025 00:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5517515E5DC;
	Sun, 12 Oct 2025 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIbr3+TR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8952118C31;
	Sun, 12 Oct 2025 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760229382; cv=none; b=ikO5TYz2vllDSxUovtWd6z+9BYMU/JsjqzAXic11wWBqH23twsWl2QtoZA6jz6B6uvdxyg/ZtCv0EdzRPb1m2DYR1blqJd5E6E0cF7hjXqf2YsCRI4PKSiTxfSVVjcqeXpHkY3axwfWCrsQgjk9P0vsNADRGKNun+71j2XxO/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760229382; c=relaxed/simple;
	bh=d5IeSn7VzI5lxZXVELh6tC/WwuTU9ey1cyw4wcNRIWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKF3UprUH8VH12Gl3Bs1vvjW3u/J+P9C9oVKdgOwzSBJV8CRFPjK0Xfonw/BprOSGLbmIYXRw4FNBOM5ER7upMJVxyGL4UAW729FzI03Dd7fIgr7nEq3toXC5axqPibf0X5t929anPnnFSMH3AjsnKI1PCnRX93f0zpLCkRoiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIbr3+TR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC98C4CEF4;
	Sun, 12 Oct 2025 00:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760229381;
	bh=d5IeSn7VzI5lxZXVELh6tC/WwuTU9ey1cyw4wcNRIWA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SIbr3+TRALoto027wUlzOJ+P9ouNtZPiyRxqzXcNOYx5zire+7xIOv3dehZKxPjYb
	 lIfclvc6Umx9C/8v/X/rvCVytoc/pBkr4kO6+NBhSiFTE6mAPb+Vtv2yAmnVLyD/gn
	 iCHzpeoLO8LaAPoLVzKQaLdvcsweFhweuA9WlW/NKOtD8IyedxSuSU2TMfjgv4ASGk
	 nWxs/kHXEn99u47XVqUyiViub5FAk4+IekyI7imJBZhbbp4pGlW1lByP2G3iSjG6pb
	 Vj0krbNe3/VRgIABNrAjJ7QBsV6ysCGiNNnAnG56DW+qhWMZ9fr/iy0L+9BMvV5eHS
	 w8wFuRHddzgMQ==
Message-ID: <14046f78-e1e9-4188-8405-16055520513f@kernel.org>
Date: Sun, 12 Oct 2025 09:36:18 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] common/zoned: add _create_zloop
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, hch <hch@lst.de>,
 Naohiro Aota <Naohiro.Aota@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
References: <20251007125803.55797-1-johannes.thumshirn@wdc.com>
 <VGGoqK-5ZWJTAAy5zOK2QgRfnghNzWtGFoBwL6Sw9bqE7moL7lyTr43XUUgtMM54gKwCKIpC1Jz9u5ZcnpNATg==@protonmail.internalid>
 <20251007125803.55797-3-johannes.thumshirn@wdc.com>
 <hrht5llavtcgd5bb6sgsluy3vs2m6ddzzshkhwqb4fjgujgrli@6px7vpsk7ek3>
 <20251008150806.GA6188@frogsfrogsfrogs>
 <f0713993-cebf-4e42-9c1a-26706a52be4d@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <f0713993-cebf-4e42-9c1a-26706a52be4d@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025/10/11 18:34, Johannes Thumshirn wrote:
> On 10/8/25 5:08 PM, Darrick J. Wong wrote:
>> On Wed, Oct 08, 2025 at 04:38:16PM +0200, Carlos Maiolino wrote:
>>> On Tue, Oct 07, 2025 at 02:58:02PM +0200, Johannes Thumshirn wrote:
>>>> Add _create_zloop a helper function for creating a zloop device.
>>>>
>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>> ---
>>>>   common/zoned | 23 +++++++++++++++++++++++
>>>>   1 file changed, 23 insertions(+)
>>>>
>>>> diff --git a/common/zoned b/common/zoned
>>>> index 41697b08..33d3543b 100644
>>>> --- a/common/zoned
>>>> +++ b/common/zoned
>>>> @@ -45,3 +45,26 @@ _require_zloop()
>>>>   	    _notrun "This test requires zoned loopback device support"
>>>>       fi
>>>>   }
>>>> +
>>>> +# Create a zloop device
>>>> +# useage: _create_zloop [id] <base_dir> <zone_size> <nr_conv_zones>
>>>> +_create_zloop()
>>>> +{
>>>> +    local id=$1
>>>> +
>>>> +    if [ -n "$2" ]; then
>>>> +        local base_dir=",base_dir=$2"
>>>> +    fi
>>>> +
>>>> +    if [ -n "$3" ]; then
>>>> +        local zone_size=",zone_size_mb=$3"
>>>> +    fi
>>>> +
>>>> +    if [ -n "$4" ]; then
>>>> +        local conv_zones=",conv_zones=$4"
>>>> +    fi
>>>> +
>>>> +    local zloop_args="add id=$id$base_dir$zone_size$conv_zones"
>>>> +
>>>> +    echo "$zloop_args" > /dev/zloop-control
>> Hmm, so the caller figures out its own /dev/zloopNNN number, passes NNN
>> into the zloop-control devices, and then maybe a new bdev is created?
>> Does NNN have to be one more than the current highest zloop device, or
>> can it be any number?
>>
>> Source code says that if NNN >= 0 then it tries to create a new
>> zloopNNN or fails with EEXIST; otherwise it gives you the lowest unused
>> id.  It'd be nice in the second case if there were a way for the driver
>> to tell you what the NNN is.
>>
>> The _create_zloop users seem to do an ls to select an NNN.  At a minimum
>> that code probably ought to get hoisted to here as a common function (or
>> maybe just put in _create_zloop itself).
>>
>> Or maybe turned into a loop like:
>>
>> 	while true; do
>> 		local id=$(_next_zloop_id)
>> 		err="$(echo "add id=$id$base_dir..." 2>&1 > /dev/zloop-control)"
>> 		if [ -z "$err" ]; then
>> 			echo "/dev/zloop$id"
>> 			return 0
>> 		fi
>> 		if echo "$err" | ! grep -q "File exists"; then
>> 			echo "$err" 1>&2
>> 			return 1;
>> 		fi
>> 	done
>>
>> That way test cases don't have to do all that setup themselves?
>>
> Unfortunately the user has to create the zloop directory (e.g. 
> BASE_DIR/0 for zloop0) beforehand (might be a bug though).

Not a bug. It is by design since the user can specify the ID of the zloop drive
to create. And there is no fixed association between device ID and directory
path to keep things flexible for the user/distro.

> What I could do is  encapsulate the find the next zloop and mkdir -p for 
> the user (and call in _create_zloop if no id is supplied?)

Yes. Do that. The zloop directory si not something that the tests should touch
anyway, so you should just define your own id <-> dir path mapping in the helpers.



-- 
Damien Le Moal
Western Digital Research

