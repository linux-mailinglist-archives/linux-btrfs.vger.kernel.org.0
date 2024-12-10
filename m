Return-Path: <linux-btrfs+bounces-10195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 132519EB750
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 18:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2AA1885A3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5976222FE17;
	Tue, 10 Dec 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b="oEkMD1o7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.scoopta.email (mx.scoopta.email [66.228.58.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6B1AA1E5
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.228.58.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850120; cv=none; b=WYww2sj5sDIOpoA05Z1o5rokPfRBxxv+Xw49OO040M4YGA991ln9ue9rvphCI9zS7gPAo0UZZ3VW22MaZdnEeRqlYf6NTS/AuqRNeHpc/+aN+wP3sxKagBwJJ6NjgYI/cWhuU+pRKc5jkxvcW2JvhFcV1L6nhvz6eze4tMq1PRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850120; c=relaxed/simple;
	bh=euNXeYH+wSCF1Q2pJsYyw5XuNLgF/NxoDoyteVe2pKQ=;
	h=MIME-Version:Message-ID:Date:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QPaof3pC4mhPgTW5ZGR+18Epl4i7ra0aBHBRqtP+0SvMES0xhZja6/QoOONJR1zmcEs4NJNZ9bU/1TtrSLasENhLi9GICWnVJxdWfDWhfkua1Yiw4mcHVf8LwRWm5GtQTuXExdF6OOesNaygSgV58WfT4c+XqFw4A1RfLTnImPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email; spf=pass smtp.mailfrom=scoopta.email; dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b=oEkMD1o7; arc=none smtp.client-ip=66.228.58.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scoopta.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scoopta.email
DKIM-Signature: a=rsa-sha256; b=oEkMD1o7Lft2a7EcAY5u49Qv8ptUGF6QI3NEA1+NwPNlmx/hiA+kxOMpvpmsM9Z9BSSfNHaOBx+NJawBhY5W3SWXq4kP9US8r3y5wfykrhNulDMVnm5hVLyBOXO/35smCfv+9KPApQW+ZYd+bem8Rp9IiXlKONN1JLmfERXEH2kVGDnRTLp8ZRaRW0ekNWzDQqvipBhCQEqriLRSPSjRn6E1xYEdgiAHdL0k6qraJqF8sSCpG3fvsyTannjK4thVgnsTlC5T1C7CtpozKx9pzFB2VvrWKMWW2HHWB6L3gGIgGDp8bsCp4H6aoTpPziBKXRsWCpLRNgLShz6nW0VIxUr5WO4FMbn2j9WoPiQ9FzX7L6UYa8wgYrkOWZF8CUy16+FVs8KFQ4l4HryuI1zKqQQyX5vngyJ0Ff5sInxQttKksGC9zaK3hsiNN6Z9V2mQUJUEjdTRLyqzXezDGu/U2Cjn8WRNHcc0g21msQqIvfioOcm+kRdKN6EpLz8zn26EKDVFeAUwUPNEpEmXLqLb0t8GhrYcMBCI3ol9AvSXodymTkdNMjh9XwutMYnkCMdls1dOstxTv9jkW/IqtEin03Uv1iSAvaaZOVE2+cOy6J4Q7VJCUpf5pBrlkA479z9rQ5veewIMd/y1AzwDaawabHnQwW9892Wwe6Tyg2zn18kzqYhOwsGISA9ksicY7LQtgVjhlAlmJwntcab6ocIWPQR8zjwUfElZEirKQ+5/I3MYGVTC4aNNxzKNPtelCUETeOY/wzuCt+Z9EmMOEu5+PhrQxBO/b8tuzvGR9PuYqkBwNVnL+8FWjqUc2TI4Dj4Zi0ZM6viV/yUjJb6Wx3VoxFOx9W5mQIxpBeQ5CfwDLzCOImd9YZBc19B3czH95IdJbayNBDPAom884vAsIlR6mr26Gqf+hj/NCO8D0eNGgbOsMWA6adrjSBZtFdx67pKmWP7MwS
 NGg/EG4/nF4h2G1lmbGcCSy4qj5yRlDQg2DDoacfT27NHEUcX/Y1e3ZvtYW7J464HbtPE7hmuA2FLH21mklmUNscJyN8+/WF+d50AZAAu7MxjKrkxcaegbuvVbRrR3X3UnOAv3exa1Eb1x60h1CT3bdDcb/usXmE5xpg/3gOJtO753MBXlTrgB1J9f2MoI+SinqfdSe0BBJ7JFXikC3QDM1ecOTpXt6biv8UVOPCi0p5BVxJKrkUlGNAJBjcvJj8/eQ8OLAz3khm0lGWiQc0FELieRP6vON2D6rXYAlgDpywOzuSQ+ByKR6fPwz/2R6myoSbOvGhdCJGXWT4GwsFc2ubANF+xTDydL/9NRve7+LAmfMcAP4ZojIqqDGYNhI0u3+yITrekUYTJPwQ==; s=20190906; c=relaxed/relaxed; d=scoopta.email; v=1; bh=uTwlt4x6yUEiegi4P+oOW5EPVbr4Rmd9y2daRmqSno4=; h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type;
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-UserIsAuth: true
Received: from 2a0d:5600:8:23:1011:1b28:a068:2804 (EHLO [IPV6:2a0d:5600:8:23:1011:1b28:a068:2804]) ([2a0d:5600:8:23:1011:1b28:a068:2804])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID -840158826;
          Tue, 10 Dec 2024 09:01:56 -0800 (PST)
Message-ID: <f534be92-5cb1-4dd4-accd-020333cdb703@scoopta.email>
Date: Tue, 10 Dec 2024 09:01:55 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: Safety of raid1 vs raid10
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <a7f1781b-6ae8-4e71-ba00-6c1c11c4901d@scoopta.email>
 <74c8536a-3108-4e6c-941a-5d7b9c697862@suse.com>
 <67fe97da-be53-4dc3-8537-1a39ff49503c@scoopta.email>
 <d737ead8-dccc-4a52-8166-08c5cc2c8dca@suse.com>
Content-Language: en-US
From: Scoopta <mlist@scoopta.email>
In-Reply-To: <d737ead8-dccc-4a52-8166-08c5cc2c8dca@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hmmmm, very interesting. I do love this rabbit hole I've ended up down 
although the data structures involved with modern filesystems hurt my 
head a bit. My experience implementing a filesystem starts and ends with 
ext2 as it's pretty simple data structure wise. I'll give some of the 
code a read and see if I can get my head around it.

On 12/9/24 11:54 PM, Qu Wenruo wrote:
>
>
> 在 2024/12/10 17:06, Scoopta 写道:
>> Yeah, that makes a lot of sense. Given what I know about btrfs it 
>> seemed very unlikely it would pair up drives consistently. This 
>> actually gives me an interesting side question. With raid1, which is 
>> not striped, is there any guarantee that a file will be placed 
>> contiguously on a given drive or is the only guarantee for chunks 
>> while files over 1GiB, and therefore occupying more than one chunk, 
>> could be spread across multiple drives so long as each chunk is 
>> mirrored?
>
> For a file, there is no guarantee at all that it will be placed on a 
> given drive.
>
> As you mentioned, a file can exist on multiple chunks, thus it can be 
> spread across different devices.
>
> And the guarantee is, as long as all the file extents are all on raid1 
> chunks, all of these file extents will have two copies on different 
> devices.
>
>
>
> And to be more accurate, a file is consisted of zero or more file 
> extents.
> The file extent size can vary, from the block size (usually 4K for 
> btrfs, and we normally call it sector size), to as large as 128M 
> (non-compressed extent) or 128K (compressed one).
>
> And the extent size is determined by various factors, from the free 
> space of the fs, to the write pattern (worst case like checker board 
> writes, 4K write then 4K hole, will definitely result 4K sized extents).
>
> So even for a file smaller than chunk size, it can have multiple file 
> extents on different chunks.
>
> Thus there isn't really any guarantee on how a file is stored where, 
> due to all the layers involved:
>
>   file -> file extents -> chunks
>
>
> And I forgot a corner case, inlined file extents, which is fully 
> stored inside a tree block, can have a different profile than the data 
> profile completely.
>
> That's why we have fiemap ioctl, to show the file extents layout 
> (inside btrfs logical address space), then only with the chunk layout 
> (btrfs ins dump-tree or btrfs-map-logical) info, one can really 
> determine where the data is.
>
> And if you want to dig this deep, welcome to the rabbit whole of how 
> to read a file on btrfs, and there is also a small project explaining 
> the whole process: https://github.com/adam900710/btrfs-fuse
>
> Thanks,
> Qu
>
>>
>> On 12/9/24 8:36 PM, Qu Wenruo wrote:
>>>
>>>
>>> 在 2024/12/10 12:56, Scoopta 写道:
>>>> I've read online that btrfs raid10 is theoretically safer than 
>>>> raid1 because raid10 groups drives together into mirrored pairs 
>>>> making the filesystem more likely to successfully survive a 
>>>> multi-drive failure event.
>>>
>>> It's only theoretically possible, but hardly possible in the real 
>>> world.
>>>
>>>
>>> For one single RAID10 chunk, btrfs can tolerant as many as half of 
>>> the devices being missing, as long as each sub stripe (the RAID1 
>>> pair) has one device standing.
>>>
>>> E.g. for chunk at bytenr X, we have 4 stripes:
>>>
>>>  stripe 0 devid 1 physical X1
>>>  stripe 1 devid 2 physical X2
>>>  stripe 2 devid 3 physical X3
>>>  stripe 3 devid 4 physical X4
>>>
>>> We can have either devid 1+3 or devid 2+4 missing, and btrfs is 
>>> totally fine with that chunk.
>>>
>>> But the real problem is, one btrfs has more than 3 chunks, and 
>>> normally one chunk is only 1GiB in size, so for a btrfs with 1TiB 
>>> used space, it will have at least 1024 chunks.
>>>
>>> Good luck all the chunks have the same stripe layout.
>>>
>>> If there is another chunk at bytenr Y, also 4 stripes but a 
>>> different layout:
>>>
>>>  stripe 0 devid 1 physical Y1
>>>  stripe 1 devid 3 physical Y2
>>>  stripe 2 devid 2 physical Y3
>>>  stripe 3 devid 4 physical Y4
>>>
>>> Then the devid 1+3 missing is fine for chunk X, but not for chunk Y.
>>>
>>> In really, the chunk layout is never ensured, and I just did the 
>>> same RAID10 assumption in my btrfs-fuse project, until it failed 
>>> selftest (missing two devices for a RAID10 btrfs) on a recent 
>>> kernel, exactly due to the device rotation.
>>>
>>> Thanks,
>>> Qu
>>>
>>>> I can't find any documentation that says this to be the case. Is it 
>>>> true that btrfs pairs drives together for raid10 but not raid1, if 
>>>> this is the case what's the reasoning for it?
>

