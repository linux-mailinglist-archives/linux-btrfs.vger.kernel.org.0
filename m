Return-Path: <linux-btrfs+bounces-14530-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4310AD03EE
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 16:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258B07AA663
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378856F06A;
	Fri,  6 Jun 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b="RwtFuDBG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A46027453
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749219719; cv=none; b=hFkEEBy/JJIs5cGpbp/jZWK42R4ymi8s3A+vt5Bid4Zun7KqqzhKJvRXWDQOs8Au6DxkA/jhTC0kgTRVH1Gvu2Sn2Kt8TNn3FGQ6Lj4G1DR6m41YofEFYRTVTeidczXJRCff2GEIuN2Nsik8j+juScxZ4PJ0J4EooRUODKORUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749219719; c=relaxed/simple;
	bh=zd6fxaJI08Nl6Z4DVvCKDVQpo4SvrzoGxD6E2eUf7pU=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=msTOCU5FI1qu1oeVfNn7h35uyieuwAR+iC/Ij/baSDHhiJNv3/++fpFMDJAFTWii+nuNPA/Mq9vr8ZesaBgikyX5klyr/UxzxPbnjATX/vZZdleNr7B1PueHYbbYZrPnopRCaJIXQOs63Clzkq8c1nEE0oeIuKTUos3vOT5OaD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net; spf=pass smtp.mailfrom=dirtcellar.net; dkim=pass (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b=RwtFuDBG; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dirtcellar.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=dirtcellar.net; s=ds202412; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=imYM43QBa/SY3O0bQfkNuTlZksxlmBukgs9FUJHxTIU=; b=R
	wtFuDBGnfoqjK7rRHTGlIazrfr8GorNHgrGwZDvJT32W1QpUaQQeiLv7I+akvEXB4oE7rRirx0MBy
	UmWOqHxvvhhsF7mZv3WfACw19H4d/RNYeGdm1sEvdXYCv2Pkc+X0PbyWpOEgMB89LMIasJD8AMVA+
	Uyiaa0O1CH5OctzsJ01G9T2qmcUaVEqGKOtHbCuGCxXWSCWgfu3uK0fFplgnxr29bHuAHiaZB0vv5
	BzDvkHxu8qucWgavGCUsUk/zRlkW0iEKPvXbsDBtP+rhnQQ34oIPriGJ7WMRkKlMai1dl8F1ZOaHL
	35zV2Tn7SdTl7hRcuRDjp+8DSt8zMB49g==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1uNXx6-009Q8D-C8;
	Fri, 06 Jun 2025 16:21:48 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH RFC 00/10] btrfs: new performance-based chunk allocation
 using device roles
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1747070147.git.anand.jain@oracle.com>
 <d513c850-c3cf-f570-247a-7b29c6376234@dirtcellar.net>
 <0643837b-5a64-483a-9cab-8c127bcf4b30@oracle.com>
From: waxhead <waxhead@dirtcellar.net>
Message-ID: <8ef386bd-05c0-5be3-36c8-10b9a006c5de@dirtcellar.net>
Date: Fri, 6 Jun 2025 16:21:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.20
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0643837b-5a64-483a-9cab-8c127bcf4b30@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Anand Jain wrote:
> On 23/5/25 02:19, waxhead wrote:
>> Anand Jain wrote:
>>> In host hardware, devices can have different speeds. Generally, faster
>>> devices come with lesser capacity while slower devices come with larger
>>> capacity. A typical configuration would expect that:
>>>
>>>   - A filesystem's read/write performance is evenly distributed on 
>>> average
>>>   across the entire filesystem. This is not achievable with the current
>>>   allocation method because chunks are allocated based only on device 
>>> free
>>>   space.
>>>
>>>   - Typically, faster devices are assigned to metadata chunk allocations
>>>   while slower devices are assigned to data chunk allocations.
>>>
>>> Introducing Device Roles:
>>>
>>>   Here I define 5 device roles in a specific order for metadata and 
>>> in the
>>>   reverse order for data: metadata_only, metadata, none, data, 
>>> data_only.
>>>   One or more devices may have the same role.
>>>
>>>   The metadata and data roles indicate preference but not exclusivity 
>>> for
>>>   that role, whereas data_only and metadata_only are exclusive roles.
>>
>> As a BTRFS user I would like to comment a bit on this. I have earlier 
>> mentioned that I think that BTRFS should allow for device groups. E.g. 
>> assigning a storage device to one or more groups (or vice versa).
>>
>> I really like what is being introduced here, but I would like to 
>> suggest to take this a step further. Instead of assigning a role to 
>> the storage device itself then maybe it would have been wiser to 
>> follow a scheme like this:
>>
>> DeviceID -> Group(s) -> Group properties
>>
>> In this case what is being introduced here could easily be dealt with 
>> as a simple group property like (meta)data_weight=0...128 for example.
>>
>> Personally I think that would have been a much cleaner interface.
>>
>> Setting a metadata/data roles as originally suggested here would be 
>> fine on a low number of devices, but on larger storage arrays with 
>> many devices it sounds (to me) like it would quickly become difficult 
>> to keep track of.
>>
>> With the scheme I suggest you would simply list the properties of a 
>> group and see what DeviceID's that belong in that group... perhaps 
>> even in a nice table if you where lucky.
>>
>> (And just for the record: other properties I can from the top of my 
>> head imagine that would be useful would be read/write weight that 
>> could (automatically) be set higher and higher if a device starts to 
>> throw errors, or group_exclusive=1|0 (to prevent other groups owning 
>> that DeviceID etc... etc...)
>>
>> And this would of course require another step after mkfs, but 
>> personally I do not understand why setting these roles (or the scheme 
>> I suggest) would be very useful at mkfs time. It might as well be done 
>> at first mount before the filesystem gets put to use.
>>
>> Great to see progress for BTRFS for things like this , but please do 
>> consider another scheme for setting the roles.
> 
> 
> Thanks for the feedback.
> 
> The question is: which approach handles large numbers of devices
> better, Mode Groups or Direct Modes?
> 
> Let’s try to break it down.
> 
> Both approaches need to manage the following:
> 
> Five role types (preferences):
>     metadata_only, metadata, none (any), data, data_only
> 
> Fault tolerance (FT) groups:
>     2 to n device groups
> 
> Four allocation strategies:
>     linear-devid, linear-priority, round-robin, free-space
> 
> Pros and Cons:
> Direct Modes are simpler and work well for small setups. As things
> scale, complexity grows, but scripts or tooling can manage that.
> 
> Mode Groups are better organized for large setups, but may be overkill
> for small ones. They also require managing an extra btrfs key, which
> adds some overhead.
> 
> Did I miss anything?
> 
Not really, you are spot on as far as I am concerned, but if you 
acknowledge that the direct approach is really not very suitable for 
large arrays without additional scripts or extra tooling anyway, I would 
personally lean towards the "overkill" approach myself.

And as a user I especially lean towards something that I can count on 
that will work out of the box and will not require scripts and/or 
tooling that may lag behind if something changes.

There may be debugging benefits as well by having the configuration 
stored in metadata on the filesystem instead of scripts and tools that 
may be located on another filesystem.

> So far, I'm leaning toward Direct Modes. But if there's enough interest
> in Mode Groups, we can explore that too. Alternatively, we could start
> with Direct Modes and add Mode Groups later if needed.
> Does that sound reasonable?
> 
I agree that it sounds reasonable, but it is also a matter of taste and 
I am obviously biased. Admittedly I must say that I would personally 
really like to see this feature on my filesystem preferably today, right 
now!! , but I can't help to think that the "overkill" solution would be 
the cleaner and beyond all the less messy solution in the long run. I 
hope you are willing to rethink this a bit. In any case thanks for 
working on a great feature.

> I’ve put up a draft work in progress version of the proposal here:
> 
>    https://asj.github.io/chunk-alloc-enhancement.html
> 
> Thanks, Anand

Brilliant, thanks!

