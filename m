Return-Path: <linux-btrfs+bounces-21884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNamBXDJnWl9SAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21884-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 16:53:20 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4FE1895D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 16:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80470304FF59
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 15:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594C53A6403;
	Tue, 24 Feb 2026 15:53:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A3D299931
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948393; cv=none; b=qg2dsJf5qJFJhrWszOHthe2Y4j47y814nrUG7s+uKS9M0fQdIhW/jQfiQSN0xAXdvTs88Y1011VkGzEsESybrAa3z9kkMUnM7ferzKYqAXvK730ibsyQb/jTXgJxAHTCu7GHJk9A/8h0/tnP0jLV3O+08AoYmgWNeHitOzEHCvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948393; c=relaxed/simple;
	bh=Mp7sz3ZuBmVmXm5wWFNe4I0wlyo3gqdi2THO9KHYwQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bgJ/wJAceg+wUjyTUmcL7ZD1RI+e+xKsnheVFJS/PM+0cGoG+lf+hT27ieeVcc3CXb8LWwdSnxqJuHJzAVS/tD0+AV1F2DKV6DTPuaeeto8wbHtjLIHujSVDOrwN72ELgG924yTkYf+wsEY5dNQionJWdrZq8iNL4x4fYIrG8fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [IPV6:2a01:e0a:156:6850:7018:89ff:fecb:6f21] (unknown [IPv6:2a01:e0a:156:6850:7018:89ff:fecb:6f21])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 3EC4419F5B2;
	Tue, 24 Feb 2026 16:53:08 +0100 (CET)
Message-ID: <2f7fe549-676d-45fb-b97a-82096027c89c@free.fr>
Date: Tue, 24 Feb 2026 16:53:08 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck on a BTRFS problem
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <77535c20-da3e-4dfb-b3d7-9426c25b5da3@free.fr>
 <0211658c-8d28-46d1-8e41-21dc02cab276@suse.com>
 <b1c1247f-df00-4045-a508-fb9a5666114a@free.fr>
 <cb183999-6a95-456a-80f4-f703da298d74@suse.com>
 <deb56ee2-b5d6-4beb-9554-05da125dde54@free.fr>
 <51597107-5a23-4f15-9481-b4d58e18bbe1@suse.com>
Content-Language: en-US, fr
From: Phako <phako@free.fr>
In-Reply-To: <51597107-5a23-4f15-9481-b4d58e18bbe1@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[free.fr : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21884-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[free.fr];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phako@free.fr,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB4FE1895D6
X-Rspamd-Action: no action

Le 23/02/2026 à 22:35, Qu Wenruo a écrit :
> 
> 
> 在 2026/2/24 02:11, Phako 写道:
>> Le 23/02/2026 à 08:32, Qu Wenruo a écrit :
> [...]
>>
>> I get that you might think this issue is not BTRFS related, but I'm 
>> still not 100% sure of what is the cause of the error. So I'm still 
>> having a couple of questions to rule out wrong hypothesis or direct me 
>> on the right track:
>>
>> Do you think that if I copy a good copy of file_B.mp4 over the corrupt 
>> file_B.mp4 (eg: cat b.mp4 > b_corrupt.mp4) it will overwrite the 
>> metadata and the same physical LBAs?
> 
> The metadata is not involved. It's fully the data part (and its checksum).
> 
> And unfortunately, a full over-write doesn't not guarantee the new data 
> will be written into the same the location.
> 
>> Are there any btrfs commands I could run before and/or after to check 
>> if it worked, and to map this reported corrupt logical blocks with 
>> actual LBAs?
> 
> But if you have the correct original file, you can try to manually over- 
> write the data, using "btrfs-map-logical" command to calculate the on- 
> disk physical LBA, then using whatever tool (dd for example) to directly 
> write the content into that physical address.
> 
> Using your previous scrub dmesg as an example:
> 
>  > Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed
>  > root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e
>  > mirror 1
> 
> 
> The first line of "csum failed" shows exactly where the corruption is in 
> the file (subvolume 257, inode number 40442, file offset 46100480).
> 
> Then you can use fiemap to map the file offset to the btrfs logical 
> address:
> 
>   $ xfs_io -c "fiemap 46100480 4096" <path_to_the_file>
> 
> It would show something like this (just an example, not matching your 
> output):
> 
> Filesystem type is: 9123683e
> File size of /mnt/btrfs/foobar is 1048576 (256 blocks of 4096 bytes)
>   ext:     logical_offset:        physical_offset: length:   expected: 
> flags:
>     0:        0..     255:       3328..      3583:    256: last,eof
> /mnt/btrfs/foobar: 1 extent found
> 
> The "logical_offset" part is the offset inside the file, the 
> "physical_offset" is the logical address inside btrfs.
> The unit is a block (4096 bytes shown after the filesystem type line).
> 
> The range should cover your 46100480 file offset.
> 
> You need to grab the btrfs logical address by converting the number.
> 
> Then with the logical bytenr, you can convert it to the physical address 
> by using "btrfs-map-logical"
> 
>   $ btrfs-map-logical -l <logical> <device>
> 
> It will output something like this:
> 
>   $ btrfs-map-logical -l 13635584 test.img
>   mirror 1 logical 13631488 physical 13635584 device test.img
> 
> The number 13631488 is 3329 * 4096, corresponding to the file offset 4K 
> of my previous example.
> 
> 
> The resulted physical bytenr and device is where you should write the 
> data into.
> 
> 
> This can be very complex, so please paste the output of "$ xfs_io -c 
> "fiemap 46100480 4096" <path_to_the_file>" first, then we can figure the 
> exact command to use in the next step.

The output I get is quite different, more terse:
$ xfs_io -c "fiemap 31494144 4096" 'file_B.mp4'
file_B.mp4:
         0: [0..87103]: 6658490256..6658577359

And when I do 6658490257*4096=27273176092672
I get an error.
$ btrfs-map-logical -l 27273176092672 /dev/sda3
ERROR: failed to find any extent at [27273176092672,27273176109056)




