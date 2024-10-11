Return-Path: <linux-btrfs+bounces-8852-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7374F99A35B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 14:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2DB285EA4
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 12:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC64219CA1;
	Fri, 11 Oct 2024 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="NIs/S/tE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA682178F1
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648391; cv=none; b=Biao2EhVeugXvk+2VT/YTt/DgfOgFnGYm1z+u1HgNtmGQMACmBXTDWvlGPnSVxGIGVQvL9pR1Yr+KPQBwCd39G1fg7b+C3/Pc57RBYarnAfS3s9x2V9M4wjMweLtqJpuBCQZsdL3NkG5fOpgzZfd2tMHkC0HlLdMZNykl/1AZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648391; c=relaxed/simple;
	bh=VEE/rWJtskInelpB/ZT0Bu5Sm+5eCEjZsdzxYc8Wb34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ni63mVYuk6yh9p4QRkyUv7ObjKSVY0WiXblrr8iffZKCOVlgIIoj5ly+8S88zEo85KywVs0JKByfYq8KIJoQfCBxUk7dXdmZqCWYAFXrrOjXuJxL/6UFIAsoZnAHncKEFS8GGaau/Qm+ur5HTEaZ/o7X3j6yvwR/gBdcB4yVxro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=NIs/S/tE; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1728648369;
	bh=Km0Pzq4ICZzYtjfLdYBpsaT9cTx8a8THD7COZHt4sxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NIs/S/tEMLuxHcd6PanHsYowOlcIqr784XROUGqhMHaL+iH5bu79s9QoGzLe+YtcZ
	 GRNLbdIZR67OeNE4MV9fLkS8Usm/2HK2SOEZf4pt6idnYxLsAvFIWwUkPXmqT4mOQe
	 FhjjeH3UZuDswqhwklXLJRzL89LaUot7gWDVSSEg=
X-QQ-mid: bizesmtpip3t1728648366tbpp94i
X-QQ-Originating-IP: 18xc1fGi/eTnBzzMX2RF4/gYBgy/7viYkCQA9jC9JHY=
Received: from [IPV6:2408:8214:5911:6ac0:4a3a: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Oct 2024 20:06:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12403152577380842381
Message-ID: <E2F46BD92527EA46+29cb502c-a5ee-48db-a439-ab692a3747b9@bupt.moe>
Date: Fri, 11 Oct 2024 20:06:00 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] New ioctl to query deleted subvolumes
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <20241009180300.GN1609@twin.jikos.cz>
 <308CF1DDC38EE68A+91e40dff-783f-43f4-9e49-a5cd4fa0b7a8@bupt.moe>
 <20241010170841.GR1609@twin.jikos.cz>
Content-Language: en-US
From: Yuwei Han <hrx@bupt.moe>
In-Reply-To: <20241010170841.GR1609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M182XWJxg1fqtdGZajePTgWNS0g09/CqVoaEgHn8JdrdrNhan+CNYFEf
	fPZmzKNobVFmhwI986Ch2HsalO+HSgazB1aInxOfZ7OA2Bj0Bd8X1i7nyIN+vWHhQ7AXz75
	9HYOY0dlPnoNZocBhKOQUQFrpaXti/P2MImmxFpDMVVDu6dOyRn86muemkTxY1olaD6e3vY
	OvwGySKdU9VUFfz1WQ6fnZDZQJS36CNVE1uKzONrdydltR/AzZmc5ASeldb77hdVWKEi4jv
	jj5h0BBAN2XVHzIksTJPQ40tEuz7YB/yFtX6Vwg0nAiFmi248r7d5A6K0nTzXg9Fi3dBm4K
	2xpDuJPelhMKvIzfqbX6C8wS/cCm5YHiNGkEygHmM2JfXfjssPA8vxS5EHkg1VAbb3Ls4hb
	RFvEtPX/uCITZqf2Xv+sy3mWor93Ojv3Uc0kblW+6DFk5aycd6wdzjWAdbnytCvAl+ibu68
	WS3l2inYc2mSqrxAHgeddI/HDsB5xaA1/WQfBUWrc5cAMtZXzVoZQ5+WCjQcb3HxArp0d7O
	Al2k/L9NFLX+fx4cV4BWQEP9p6gWbPJDE8GNxAlYVjSQN7a/gQN5qH+rkh6x32r6N3jxrD0
	oh4ffFR4QE2FlaFZfnwthjLsYq7CULs9NArK4XjcgtaXFyWFGQjEUcx+0jLM6J3ZvZ0Vdpr
	dabfpf02NPm5ZbeHKX1XxHD2XiDcjJtU1BdtmI/P+VVJqpaUPK5k68ZgOfLEHoABe3iEHh+
	tAvlJPpVY/zTyc2eSRROsw9Cx1Q0t6kEZ86H302mIx1i5WCvK4wagRxJ7oSJR2H4+CPu6Q+
	dzUiVmqqTyvz3bNYIqfX5Ebhqgdlpl2oLGqYT+ahfSxPZFYXE8mFKMD+nvLAZ9cgzjIvFEG
	IwOSMmK6TTF7PHb7BA3yMnuvyA2w7PHyethVJmcnsGjIzszQy9uEFQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0



在 2024/10/11 01:08, David Sterba 写道:
> On Thu, Oct 10, 2024 at 08:29:14PM +0800, Yuwei Han wrote:
>>
>>
>> 在 2024/10/10 02:03, David Sterba 写道:
>>> Hi,
>>>
>>> I'd like some user feedback on a new ioctl that should handle several use cases
>>> around subvolume deletion. Currently it's implemented on top of the privileged
>>> SEARCH_TREE ioctl, it's not possible to do that with libbtrfsutil or
>>> unprivileged ioctls.
>>>
>>> The use cases:
>>>
>>>     1) wait for a specific id until it's cleaned (blocking, not blocking)
>>>
>>> This is what 'btrfs subvol sync id' does. In the non-blocking mode it checks if
>>> a subvolume is in the queue for deletion.
>>>
>>>     2) wait for all currently queued subvolumes (blocking)
>>>
>>> Same as 'btrfs subvol sync' without any id.
>>>
>>>     3) read id of the currently cleaned subvolume (not blocking)
>>>
>>> Allow to implement sync purely in user space.
>>>
>>>     4) read id of the last in the queue (not blocking)
>>>
>>> As the subvolumes are added to the list in the order of deletion, reading the
>>> last one is kind of a checkpoint. More subvolumes can be added to the queue in
>>> the meanwhile so this adds some flexibility to applications.
>>>
>>>     5) count the number of queued subvolumes (not blocking)
>>>
>>> This is for convenience and progress reports.
> 
>> I don't understand why we need to get the status about subvolume
>> deletion. Can you provide some real world usage?
> 
> https://github.com/kdave/btrfs-progs/blob/devel/cmds/subvolume.c#L85
> 
> 'btrfs subvol sync' prints at the beginning number of subvolumes
> 
>    "Waiting for 123 subvolumes"
> 
> And then prints the progress like
> 
>    "Subvolume id 456 is gone (1/10)"
> 
> So the ioctl mode is there to emulate that, for the common case of "wait
> for all subvolumes currently queued for deletion".
> 
There is a misunderstanding. What I mean is that why users need to 
"confirm" subvol is deleted? I can't come up with actual usage. Hope you 
can help me with that.
>>>
>>> There are some questions and potential problems stemming from the general
>>> availability of the ioctl:
>>>
>>> - the operations will need to take locks and/or lookup the subvolumes in the
>>>     data structures, so it could be abused to overload the locks, but there are
>>>     more such ways how to do that so I'm not sure what to do here
>> Since it's privileged operation. I think it is up to users. But we can
>> have some hints like balance do.
>>> - deleted subvolume loses it's connection to path in directory hierarchy, so
>>>     querying an id does not tell us if the user was allowed to see the subvolume
>>>
>>> - the blocking operations can take a timeout parameter (seconds), this is for
>>>     convenience, otherwise a simple "while (ioctl) sleep(1)" will always work
>>>
>>>
>>> My questions:
>>>
>>> - Are there other use cases that are missing from the list?
>>>
>>> - Are there use cases that should not be implemented? E.g. not worth the
>>>     trouble or not really useful.
>>>
>>> I have a prototype for 1 and 2, the others would be easy to implement
>>> but the number of cases affects the ioctl design (simple id vs modes).
>>>
>>> Thanks.
>>>
>> Overall I am confused about this message. Did I miss something before?
> 
> Sorry, without the code it could be cryptic.  In the simplest version,
> the ioctl could be defined to take only the a u64, the id of the
> subvolume to wait for, or 0 to wait for all.
> 
> #define BTRFS_IOC_SUBVOL_SYNC_WAIT _IOW(BTRFS_IOCTL_MAGIC, 65, u64)
> 
> and implemented like (schematically):
> 
> btrfs_ioctl_subvol_sync_wait(struct btrfs_fs_info *fs_info, void __user *argp) {
> 	u64 subvolid;
> 
> 	copy_from_user(&subvolid, argp);
> 
> 	if (subvolid == 0)
> 		subvolid = btrfs_root_id("last root in the dead_roots list");
> 
user may delete more subvol after sync wait. Is this ok?
> 	while (1) {
> 		root = lookup_root(subvolid)
> 		"if exists, continue looping"
> 		"if gone, exit"
> 	}
> }
> 
> So my question is if this is sufficient for all what's needed or if the
> argument passed to the ioctl should be a structure with flags, modes,
> timeout and such:
> 
> struct btrfs_ioctl_subvol_wailt {
> 	u32 mode;
> 	union {
> 		u32 timeout;
> 		u32 count;
> 	};
> 	u64 subvolid;
> };
> 
Seems good to me. I have no more suggestions.

HAN Yuwei

