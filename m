Return-Path: <linux-btrfs+bounces-8130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AAC97CCDC
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 19:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64AA1C2222A
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32BB1A0B10;
	Thu, 19 Sep 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="trK5m2Xu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235519E7F0
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Sep 2024 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765583; cv=none; b=giMtUYdPVerXdh8lQI6oc1clbOhHD8tyFHsmmYEQXzVcTK1UoX27OHXhgxOW2NOyMupxwGWaDn7DJufURdHEGD6NPExKm/qcJiLJNE1IjEaV3Qvn0lddDWuxwC4rgLmDDQENe/3/aeK0yn9aY69CJVtF3XtmOR6JytVTqF/Tf/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765583; c=relaxed/simple;
	bh=DV1Rq7r3QKipw7M2S+DR+V2gABUjLbuy3biveiSnJcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YO+bavuDFCAYS042T39H6cps11TcmCWcuIp6xxTMAr+2lG3hA3XaI+WFBWVKq7lvAPRhsPBa2jQ2OOle+la8uFpj6dGUIodqFRFi7RpDDP9o9lNzpIahRn1I1BbYaWe6a4wMLTp49G359EoUivH+Qs9es60Tj8K41EKzNGINQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=trK5m2Xu; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id F0C719F255;
	Thu, 19 Sep 2024 18:57:50 +0200 (CEST)
Received: from [192.168.0.63] ([192.168.0.63])
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 48JGvT9t414706
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 19 Sep 2024 18:57:49 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 48JGvT9t414706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1726765070;
	bh=LBR0lNZSYMClZ+pY6qErm64mZtv05/RNihmv+t6EwV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=trK5m2Xu61+afS54/STU8e/+7oHx7e7bxq4SlApDDKMXz6kf1zinkHuq259cvV4xw
	 Z60B2qvbqzqsC+iR1Y3YKnNpi02NgSfuHD0Jf4KATngYJrYU87hwq89wR/44OTdFo1
	 Mc15NGb+ADz8aQ/7w5J8Bba7BlkHpDK5rLhoYdBSU1/uJ9YI7yanebELWfuQesWrKk
	 ZSYKyoh2WRkkzveUdnEJfFmRXnvkVpmvfxiWZwdS9yeIijll3TLOlJjSVHmskj8slm
	 SarYzUUnmkNxnIm4nRljkUa21tzUNmzSn3wcgSAgLIgeRveDpPlhOWFzKOZQBgQgBX
	 W7vPpkT2PyJGQf9D3FRoMr79ppJBeZYM5ZFsMwVgWILt+Z1U9pB6VCQkQ6hdnqTPpl
	 3MRot+/lO6XaY7V9OekmD89MsqQAkGTEiu0z4PWvkDcAQ3EaL8Z2IoV01YTzLNc8DY
	 adHjr21Qk5aOUl3kIIKqeNWqZyYLD2QSvM2APGrJa+LmevP4eE0sMjxCdaWW4yzL6D
	 ayqu/vw9aceISMe9qvEE5o0rbjehr8lz2allX7xEgP/jW3/SQpvHEpb90gaIdQfOUt
	 9NM97Q9+G9bDm3idR5MC6HsXiouu+V9HdPYoSHlrW62owdBzKJMArzXTW2qgRzg+Wp
	 7PUQP++/NSDWchDdt/Eiw9rc=
Message-ID: <5924fc09-8abb-4163-854e-5cdac28f47d6@wiesinger.com>
Date: Thu, 19 Sep 2024 18:57:29 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [RFC 0/2] Add dummy RAID stripe tree entries for PREALLOC data
To: Johannes Thumshirn <jth@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <85888aaa-c8f5-453b-8344-6cabc82f537e@gmx.com>
 <20240918140850.27261-1-jth@kernel.org>
Content-Language: en-US
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <20240918140850.27261-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.09.2024 16:08, Johannes Thumshirn wrote:
> This is an RFC implementation of Qu's request to be able to
> distinguish preallocated extents in the stripe tree for scrub.
>
> It's not 100% working yet but only showing the basic "how it's going to
> look like".
>
> I'm not really sure this is a better solution than returning ENOENT
> and ignoring it in scrub.
>
> A third possibility would be to do a full backref walk on
> btrfs_map_block() error and then check if it's a preallocated extent.
>
> Johannes Thumshirn (2):
>    btrfs: introduce dummy RAID stripes for preallocated data
>    btrfs: insert dummy RAID stripe extents for preallocated data
>
>   fs/btrfs/inode.c                | 47 +++++++++++++++++++++++++++++++++
>   fs/btrfs/raid-stripe-tree.c     | 47 +++++++++++++++++++++++++++++++++
>   fs/btrfs/raid-stripe-tree.h     |  2 ++
>   include/uapi/linux/btrfs_tree.h |  1 +
>   4 files changed, 97 insertions(+)
>
Will this also solve the compression topic (see subject "BTRFS doesn't 
compress on the fly") for e.g. PostgreSQL (which preallocates)?

Thnx.

Ciao,

Gerhard


