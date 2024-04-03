Return-Path: <linux-btrfs+bounces-3846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591A4896187
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 02:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52A32854CA
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 00:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C02FC01;
	Wed,  3 Apr 2024 00:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vO1S4Lh6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359081BF20;
	Wed,  3 Apr 2024 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104436; cv=none; b=F0JKjC2SDNCT1ya+k1rd6witCei6I/v83TXfGNY1X6UL1i5sMRd3gUER/oDfWl7atSnCkUE6bI5YAQIq4H2A/FvLv2mqBD1n2fO6ImR+sV4Nbl4Nl8+FySPY2GPfjcJuo5FFNH7ozwMDbBvIvGP1eKq44x4wisv7PFyYohSAvTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104436; c=relaxed/simple;
	bh=klEagrQlHOJ1VL1CB6eLV3nxtQjaEnWxsl/7W0ysDw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kczTzB6meSU8R4BW+ltaUggQzI8M74mWnzotRYAOpvAxNXz4+9Kq7UXIOgDwwWfV5iY5rZvNygWaRt6YYcBlgSEGcUJ3bv7cZ1wAZ1ggdQEUc7f3JpMlnzP+s5RB2QDDv2mUofntIojPO00bcdBPViEwz5O3tDyUH+MLu/em/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vO1S4Lh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79852C433F1;
	Wed,  3 Apr 2024 00:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712104435;
	bh=klEagrQlHOJ1VL1CB6eLV3nxtQjaEnWxsl/7W0ysDw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vO1S4Lh634Pax1oTwLdDx6S5jW3ZVFRdYxDuYmRJGt2ZKUhwopatIM4xd08+gM8v/
	 UGYsV3kVODscJOa3s+1uNpg5IaDy2Z9ddRGk5eR8MHWDCUYGG80o4wYJ6MHX0Gz/+o
	 f96ItQ2rhj3AGJqAC453khLk/OgbUX57RalalUMpdS7AQG6xrtFH+sMPmk4O3TuqsE
	 CSJkNKi8RkehUxJlxemMhgutDKb2bm9ShZaJK/A/RO5wUFUe/0SYzLyPOqPNteQDEw
	 9W2z9lCVOeNOyTd1N4gef/QTqm1lO11eZBmL8BwGlC1F+/jjdCOtP3PBGqdX1u/jMd
	 apcI3Nq7JvI/A==
Date: Tue, 2 Apr 2024 20:33:55 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	clm@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 59/68] btrfs: preallocate temporary extent
 buffer for inode logging when needed
Message-ID: <Zgyj800yVkeKmbmq@sashalap>
References: <20240329122652.3082296-1-sashal@kernel.org>
 <20240329122652.3082296-59-sashal@kernel.org>
 <20240402133518.GD14596@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240402133518.GD14596@suse.cz>

On Tue, Apr 02, 2024 at 03:35:18PM +0200, David Sterba wrote:
>On Fri, Mar 29, 2024 at 08:25:55AM -0400, Sasha Levin wrote:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> [ Upstream commit e383e158ed1b6abc2d2d3e6736d77a46393f80fa ]
>>
>> When logging an inode and we require to copy items from subvolume leaves
>> to the log tree, we clone each subvolume leaf and than use that clone to
>> copy items to the log tree. This is required to avoid possible deadlocks
>> as stated in commit 796787c978ef ("btrfs: do not modify log tree while
>> holding a leaf from fs tree locked").
>>
>> The cloning requires allocating an extent buffer (struct extent_buffer)
>> and then allocating pages (folios) to attach to the extent buffer. This
>> may be slow in case we are under memory pressure, and since we are doing
>> the cloning while holding a read lock on a subvolume leaf, it means we
>> can be blocking other operations on that leaf for significant periods of
>> time, which can increase latency on operations like creating other files,
>> renaming files, etc. Similarly because we're under a log transaction, we
>> may also cause extra delay on other tasks doing an fsync, because syncing
>> the log requires waiting for tasks that joined a log transaction to exit
>> the transaction.
>>
>> So to improve this, for any inode logging operation that needs to copy
>> items from a subvolume leaf ("full sync" or "copy everything" bit set
>> in the inode), preallocate a dummy extent buffer before locking any
>> extent buffer from the subvolume tree, and even before joining a log
>> transaction, add it to the log context and then use it when we need to
>> copy items from a subvolume leaf to the log tree. This avoids making
>> other operations get extra latency when waiting to lock a subvolume
>> leaf that is used during inode logging and we are under heavy memory
>> pressure.
>>
>> The following test script with bonnie++ was used to test this:
>>
>>   $ cat test.sh
>>   #!/bin/bash
>>
>>   DEV=/dev/sdh
>>   MNT=/mnt/sdh
>>   MOUNT_OPTIONS="-o ssd"
>>
>>   MEMTOTAL_BYTES=`free -b | grep Mem: | awk '{ print $2 }'`
>>   NR_DIRECTORIES=20
>>   NR_FILES=20480
>>   DATASET_SIZE=$((MEMTOTAL_BYTES * 2 / 1048576))
>>   DIRECTORY_SIZE=$((MEMTOTAL_BYTES * 2 / NR_FILES))
>>   NR_FILES=$((NR_FILES / 1024))
>>
>>   echo "performance" | \
>>       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
>>
>>   umount $DEV &> /dev/null
>>   mkfs.btrfs -f $MKFS_OPTIONS $DEV
>>   mount $MOUNT_OPTIONS $DEV $MNT
>>
>>   bonnie++ -u root -d $MNT \
>>       -n $NR_FILES:$DIRECTORY_SIZE:$DIRECTORY_SIZE:$NR_DIRECTORIES \
>>       -r 0 -s $DATASET_SIZE -b
>>
>>   umount $MNT
>>
>> The results of this test on a 8G VM running a non-debug kernel (Debian's
>> default kernel config), were the following.
>>
>> Before this change:
>>
>>   Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
>>                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
>>   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>>   debian0       7501M  376k  99  1.4g  96  117m  14 1510k  99  2.5g  95 +++++ +++
>>   Latency             35068us   24976us    2944ms   30725us   71770us   26152us
>>   Version 2.00a       ------Sequential Create------ --------Random Create--------
>>   debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>>   files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>>   20:384100:384100/20 20480  32 20480  58 20480  48 20480  39 20480  56 20480  61
>>   Latency               411ms   11914us     119ms     617ms   10296us     110ms
>>
>> After this change:
>>
>>   Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
>>                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
>>   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>>   debian0       7501M  375k  99  1.4g  97  117m  14 1546k  99  2.3g  98 +++++ +++
>>   Latency             35975us  20945us    2144ms   10297us    2217us    6004us
>>   Version 2.00a       ------Sequential Create------ --------Random Create--------
>>   debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>>   files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>>   20:384100:384100/20 20480  35 20480  58 20480  48 20480  40 20480  57 20480  59
>>   Latency               320ms   11237us   77779us     518ms    6470us   86389us
>>
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> Reviewed-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This is a performance improvement, how does this qualify for stable? I
>read only about notable perfromance fixes but this is not one.

No objection to dropping it. Description of the commit states that it
fixes blocking for "significant amount of time".

-- 
Thanks,
Sasha

