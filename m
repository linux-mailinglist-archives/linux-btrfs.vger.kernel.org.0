Return-Path: <linux-btrfs+bounces-15833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C66B19D8A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 10:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF8C1896BDA
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 08:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C00824166D;
	Mon,  4 Aug 2025 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p54OXi8R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qpEhkXzg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p54OXi8R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qpEhkXzg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F01DE8A0
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295893; cv=none; b=Aoov1i5u5E3o3Px6gK2j2BSIEM+7KdlHm03DYMWSXZY2EQS6xJ0v5w3KTLm0nf7OXLJPWnPBDcbRdkkjDXVWFSSZjfeAeLXwMZAFjnwIJLX9koLYLYeglRsWoj87/n8Yodgb9TGdLSj5RNEpzmKriylnYDVHLbqV5cZqlfbjLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295893; c=relaxed/simple;
	bh=xtSTNdqZWsSW1qJQeyyDz68gUEuTqsFweasGTdnJ5EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VvOFjQQ+Ar9Qd2kCD8x/w29z6HyypMPzDo1sMGHd1ZPItyh8gsVeAZ6mdfGTMhYI7/eMOcBG6/vyKRLBGPNtMUq+XM4krQzHAYWdXVhk+O+lnJh/ZVXUQY/m09MPjL+MQeh37+K0LIbZpP0b4w5yc41/ccg7ktoEYCkC4LflClQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p54OXi8R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qpEhkXzg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p54OXi8R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qpEhkXzg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 967B21F38F;
	Mon,  4 Aug 2025 08:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754295888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9X6whm3w9ap+5qNqrSxcYBHv2mc9RiInpBUSHMTjKjg=;
	b=p54OXi8RoskNrjxKmAXCJikdg8nMQdqQrmr8fcog6AxYjETfbh6pH6DI2YJWw4Dz10CerW
	gWzzXLETq0OJ40oVS1Yl6olHbYI9Owfy4rhyTkq4fjtGqfBcwkfj0ykcGAjs6v71nRt0Is
	HuL8qVzpcgWLaoVW1zoDVXWnEEDJPrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754295888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9X6whm3w9ap+5qNqrSxcYBHv2mc9RiInpBUSHMTjKjg=;
	b=qpEhkXzgmDSN2KLxhP8di4Gb03G/K1BXrJLYVDU2AC+NsOVsQKJIbhGr2Z0nTrBBmLYjw0
	OPv+ot7DI9SPrMDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754295888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9X6whm3w9ap+5qNqrSxcYBHv2mc9RiInpBUSHMTjKjg=;
	b=p54OXi8RoskNrjxKmAXCJikdg8nMQdqQrmr8fcog6AxYjETfbh6pH6DI2YJWw4Dz10CerW
	gWzzXLETq0OJ40oVS1Yl6olHbYI9Owfy4rhyTkq4fjtGqfBcwkfj0ykcGAjs6v71nRt0Is
	HuL8qVzpcgWLaoVW1zoDVXWnEEDJPrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754295888;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9X6whm3w9ap+5qNqrSxcYBHv2mc9RiInpBUSHMTjKjg=;
	b=qpEhkXzgmDSN2KLxhP8di4Gb03G/K1BXrJLYVDU2AC+NsOVsQKJIbhGr2Z0nTrBBmLYjw0
	OPv+ot7DI9SPrMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88E1B133D1;
	Mon,  4 Aug 2025 08:24:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tob8Ek9ukGgQbwAAD6G6ig
	(envelope-from <wqu@suse.de>); Mon, 04 Aug 2025 08:24:47 +0000
Message-ID: <bddc796f-a0e0-4ab5-ab90-8cd10e20db23@suse.de>
Date: Mon, 4 Aug 2025 17:54:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Should seed device be allowed to be mounted multiple times?
To: Anand Jain <anand.jain@oracle.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>
References: <aef03da8-853a-4c9f-b77b-30cf050ec1a5@suse.de>
 <4cdf6f5c-41e8-4943-9c8b-794e04aa47c5@suse.de>
 <8daff5f7-c8e8-4e74-a56c-3d161d3bda1f@oracle.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.de>
In-Reply-To: <8daff5f7-c8e8-4e74-a56c-3d161d3bda1f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30



在 2025/8/4 17:09, Anand Jain 写道:
> 
> 
> On 3/8/25 07:35, Qu Wenruo wrote:
>>
>>
>> 在 2025/8/2 16:41, Qu Wenruo 写道:
>>> Hi,
>>>
>>> There is the test case misc/046 from btrfs-progs, that the same seed 
>>> device is mounted multiple times while a sprouted fs already being 
>>> mounted.
>>>
>>> However after kernel commit e04bf5d6da76 ("btrfs: restrict writes to 
>>> opened btrfs devices"), every device can only be opened once.
>>>
>>> Thus the same read-only seed device can not be mounted multiple times 
>>> anymore.
>>>
>>> I'm wondering what is the proper way to handle it.
>>>
>>> Should we revert the patch and lose the extra protection, or change 
>>> the docs to drop the "seed multiple filesystems, at the same time" part?
>>
>> BTW, reverting will not be that simple anymore.
>>
>> The problem is we're now using unique blk dev holder (super block) for 
>> each filesystem.
>>
>> Thus each block device can not have two different super blocks.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Personally speaking, I'd prefer the latter solution for the sake of 
>>> safety (no one can write our block devices when it's mounted).
> 
> 
> This is expected to work- it's a key feature.
> ------------
> $ mount /dev/sda /btrfs
> mount: /btrfs: WARNING: source write-protected, mounted read-only.
> $ btrfs dev add -f /dev/sdb /btrfs
> $ mount -o remount,rw /btrfs
> 
> 
> $ mount /dev/sda /btrfs1
> mount: /btrfs1: /dev/sda already mounted or mount point busy.
>         dmesg(1) may have more information after failed mount system call.
> 
> [130903.161395] BTRFS error: failed to open device for path /dev/sda 
> with flags 0x23: -16
> 
> $ mount -o ro /dev/sda /btrfs1
> mount: /btrfs1: /dev/sda already mounted or mount point busy.
>         dmesg(1) may have more information after failed mount system call.
> 
> [130943.678745] BTRFS error: failed to open device for path /dev/sda 
> with flags 0x21: -16
> ------------
> 
> 
> One workaround is to mount all devices first, then add the sprout.
> But that's not practical, as the full list of mount points may not be 
> known ahead of time.
> 
> ------------
> $ mount /dev/sda /btrfs
> mount: /btrfs: WARNING: source write-protected, mounted read-only.
> $ mount /dev/sda /btrfs1
> mount: /btrfs1: WARNING: source write-protected, mounted read-only.
> $ btrfs dev add -f /dev/sdb /btrfs
> $ mount -o remount,rw /btrfs
> $ btrfs dev add -f /dev/sdc /btrfs1
> $ mount -o remount,rw /btrfs1
> ---------------
> 
> 
> BLK_OPEN_RESTRICT_WRITES appears to apply per block device or possibly
> per FSID (I'm not sure).?

That's one factor, but not all.

The problem is the new block dev holder. One can only open the bdev 
multiple times if the new holder is the same as the existing one.

Now since the block device will have a super block as the holder, it 
means it's impossible to have one block device belonging to two or more 
different filesystems.

> 
> Since seed devices are read-only, a second read-only mount should have
> been allowed.!!

I'd say the original design is too naive, allowing all mounted btrfs 
devices to share the same holder (fs type, which is never a common thing).

Previously we do not even properly implement all the device event 
handler, but now consider a situation, that the block device is going to 
be frozen.

Now which filesystem should be frozen?

> 
> After sprouting (device add), the FSID changes.
> Looks like we need to inform the VFS of this update (guessing)?
> 
> Will work on a fix, appreciate the report.

Good luck, a good fix won't come up so easily.

> 
> Thanks.
> 
> PS:
> I remember this (some other aswell) patch on the mailing list,
> it went in pretty quickly (3 days).
> I couldn’t keep up with the pace. I suggest 2 weeks sock time.

The problem is not the new patches breaking the behavior, but the old 
behavior is never solid.

Let me be clear again, there is no fs except btrfs, allowing a block 
device belonging two different mounted fs.

We're abusing the block device holder, and just never realize it.

Now it's time for us to do the choice, continue the abuse and never act 
like a normal fs, or accept the behavior change and become a more normal fs.

Thanks,
Qu

