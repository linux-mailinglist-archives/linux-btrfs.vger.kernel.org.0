Return-Path: <linux-btrfs+bounces-14181-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7035AC134C
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 May 2025 20:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3831BA72DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 May 2025 18:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A6A1A841B;
	Thu, 22 May 2025 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b="fjA8+nMA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA46618DB14
	for <linux-btrfs@vger.kernel.org>; Thu, 22 May 2025 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938310; cv=none; b=FtN1uAThcjMKAofdh7/MiTlzqkra19RQ8Zmube0d76YwtOdSesfF4UeiWEwz7+Ct2Tigc3m0sP0ccts8v1+ssShRUdEY7bu+y6XIEB0ILly9QG96SrySWmp9GKVAwl1+yQIpNWjAdG+8Z9Ki4uJXU3VtfGwcXcOdG+4W8QhFpGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938310; c=relaxed/simple;
	bh=TwGZwsmEgnIgTTBj4XKGLpirpqryAcPIpTHKmv3xPGo=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=twIvfMk0RVxcOt8lOffWGSh7rZscE/E7DsduZgtZM4gbEMn6oEGEVEw/ZpnlrUivSo1V0r8FCDzzAwIJ6RNz30bbB5G8m/Rf8kmxnYP4Z4janJD1DoeHG6AB0po1wRGIN5YyHbnB0WUsaRln5mD89dA8zVcdalZ8CrOejHs5Ito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net; spf=pass smtp.mailfrom=dirtcellar.net; dkim=pass (2048-bit key) header.d=dirtcellar.net header.i=@dirtcellar.net header.b=fjA8+nMA; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dirtcellar.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dirtcellar.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=dirtcellar.net; s=ds202412; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Reply-To:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=XstmK46quUGP5stbOGp7KiEj3UjW/XuX6TzbUab3aCg=; b=f
	jA8+nMAfYb2/I4mnN1CvmEmKSbqE1TNnsVpDMgxK0/2XFiL1cggtrrtzMIttvwV9HiIGsDDyfgxWV
	sKrlele7i1oESr5B4sOWwKL0es/5PeCIxi4+NMJ0Td2PT7OGKgfI93ems/mz+myfZTgY5K0aUMbfy
	mz9wqeDbYfNKSgvipfo1FKfgxBSOdZjr9QxgzZwqgmB2wvECD6U9PP1q7bFyaXDlE7gwzfpAkVwRy
	1IEsw0DdXfjuvFpb8mOjuDfNA3j9Sq7IxsdZmosBXODIHirU1i7ug2K2uDZzi3AjFUtStlkdrE6YS
	0tniVrIL6vzWAKSnJ2PdmoaLufc+mBFKA==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1uIAVw-00477W-Vv;
	Thu, 22 May 2025 20:19:33 +0200
Reply-To: waxhead@dirtcellar.net
Subject: Re: [PATCH RFC 00/10] btrfs: new performance-based chunk allocation
 using device roles
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1747070147.git.anand.jain@oracle.com>
From: waxhead <waxhead@dirtcellar.net>
Message-ID: <d513c850-c3cf-f570-247a-7b29c6376234@dirtcellar.net>
Date: Thu, 22 May 2025 20:19:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.20
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Anand Jain wrote:
> In host hardware, devices can have different speeds. Generally, faster
> devices come with lesser capacity while slower devices come with larger
> capacity. A typical configuration would expect that:
> 
>   - A filesystem's read/write performance is evenly distributed on average
>   across the entire filesystem. This is not achievable with the current
>   allocation method because chunks are allocated based only on device free
>   space.
> 
>   - Typically, faster devices are assigned to metadata chunk allocations
>   while slower devices are assigned to data chunk allocations.
> 
> Introducing Device Roles:
> 
>   Here I define 5 device roles in a specific order for metadata and in the
>   reverse order for data: metadata_only, metadata, none, data, data_only.
>   One or more devices may have the same role.
> 
>   The metadata and data roles indicate preference but not exclusivity for
>   that role, whereas data_only and metadata_only are exclusive roles.

As a BTRFS user I would like to comment a bit on this. I have earlier 
mentioned that I think that BTRFS should allow for device groups. E.g. 
assigning a storage device to one or more groups (or vice versa).

I really like what is being introduced here, but I would like to suggest 
to take this a step further. Instead of assigning a role to the storage 
device itself then maybe it would have been wiser to follow a scheme 
like this:

DeviceID -> Group(s) -> Group properties

In this case what is being introduced here could easily be dealt with as 
a simple group property like (meta)data_weight=0...128 for example.

Personally I think that would have been a much cleaner interface.

Setting a metadata/data roles as originally suggested here would be fine 
on a low number of devices, but on larger storage arrays with many 
devices it sounds (to me) like it would quickly become difficult to keep 
track of.

With the scheme I suggest you would simply list the properties of a 
group and see what DeviceID's that belong in that group... perhaps even 
in a nice table if you where lucky.

(And just for the record: other properties I can from the top of my head 
imagine that would be useful would be read/write weight that could 
(automatically) be set higher and higher if a device starts to throw 
errors, or group_exclusive=1|0 (to prevent other groups owning that 
DeviceID etc... etc...)

And this would of course require another step after mkfs, but personally 
I do not understand why setting these roles (or the scheme I suggest) 
would be very useful at mkfs time. It might as well be done at first 
mount before the filesystem gets put to use.

Great to see progress for BTRFS for things like this , but please do 
consider another scheme for setting the roles.

