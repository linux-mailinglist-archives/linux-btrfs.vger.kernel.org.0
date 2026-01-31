Return-Path: <linux-btrfs+bounces-21261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMc9FL1PfmlRXAIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21261-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 19:53:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE93C398C
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 19:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 811DA302F710
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Jan 2026 18:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC02236826F;
	Sat, 31 Jan 2026 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejBehB6V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C0536657F
	for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769885614; cv=none; b=e/oyLo//PYj0uIOIliDKBL2hHJmSoEYLZYow/4nMyjQLTz2UV00gB3qKbIPDb1VwBr4B3YEeexqjoP3EqnQV5yx+ghAyLZ+NSPczXzL3Eb6nxFEkkqcVsrPZ/eRQYbGxEyswd/ar/h6XkHovDkeB4283gKcGpMCAfsOCAeA9RTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769885614; c=relaxed/simple;
	bh=wh6dwyOK65vXco2DnUxJD8gVlLo8aKzPrBzTy084jhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cs0979i3SZCCR+mSPGCmoy9/IoXgEA2m/3dUj4TSoTd/bRegH0Rg3k6Ftxh5IwDpgBJHSYfX5LY+wmkP6J1Aah/udOeFwywngIHCAAmfx4WGfyjokH4Rxjx/D+qEzLCMQtPwe+RYLUHosJMxaZoeEYAzQ/LVm6VUl/z3GSHyYKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejBehB6V; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12331482b8fso5229103c88.1
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Jan 2026 10:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769885612; x=1770490412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJ6jwnBsN5HSgQ/q53Q17HnchEXJ2COGzLZNDl6Dcw8=;
        b=ejBehB6VsD4rGswfXuyXJlWPRhFvpgVe9FB3qEZbygWxgEZ/7m2CNEZ1POpn3HCk9x
         o342ixkEef1voQvCJhazcgHQj2in0+bQvhf+nL5BM2WUbZFw7IMCKAvuIt2G5aJfzjsA
         lQ1QasprXpik2H3rGtK2XdBfbV4XrQvIFtHxShYaaglybDYGFf3riqyhXHCuGH5dyffq
         YaK0V6YyNLHz+pd1NE7/sUJOx33V9r3UO9ETiEsbwxxARG80k02yjnZfWAKROZ03yoxN
         3Nmo4H8+h26NrmC4b9qfKElDT9kAVrp1WvRui/8p7cctNVDIwIT94xnHVVsaAWvT5r8E
         UiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769885612; x=1770490412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJ6jwnBsN5HSgQ/q53Q17HnchEXJ2COGzLZNDl6Dcw8=;
        b=PyHqVqAo8spvIOk+3l9pij1UAj+IT5CQBQfzMGhgjmJGV5IonLHZgLwfn6HcTOYn+2
         s/aJDlUAlYsa+i6UQHQfN33HwNkCOulYgjXFORktL2HB0SVVSSVx7jxuS/7ch/6+6ipj
         jpMrrFwde6FfcUuwxE/9e50NKPYhLV0fu9CMyzBRnD06RnRpjlMETl2LRFy1UCk7lPPt
         b1hpFLNP4GQJPxY6SqdNC85IMUQtEmBcqa9789VRGxW7EYcdcIpnhZxcvUZddgPET4WA
         nLrCewtZwYlUPILvjXQOrlz10aqdqUiMeACZCtYWxekL9m1TnLwWzOZYV3E3x+OeI40R
         JYkw==
X-Gm-Message-State: AOJu0YxMz5h+O4zvSBVNnAev/3JB7BF81P4wkTmhX25EP2n+758ZNGX5
	43Z59sgUaOaDvJNOv7Sj9cVhL8rjk+4xalbvK432LOnkQYjpDZm+jWA0
X-Gm-Gg: AZuq6aJvrxx4yPqmlXfE1k3dG/qkY1e4QMrM4o7Fwl7vBj//VlpJiqdaA9HVjo6JIDZ
	9hEiMXOGWUocsQOIUUdVh0cF9KRyBFlYGviea0cj2BwnWUb4xujq0kOkG9R5YIEnezL87sXqLQm
	4YIxFnFpcBFrBIGvAsro3AEzjA7tYjxvyq4LQbSBlwmcQXpBE6ssuargFwjzSGD4Rqn06CroS/I
	WOL/1VARrv70NETF+N7QZkctKjU2RnJNhy99oNR5jcPElcS+6Ykbepc5XrYeiGx+mg3ralUMtlt
	E6EcLUSTeP58zXkwQ8+k6zu2Y5eiqDS76B2rfCOAzsUihOj+TxSfYEtXAMc+LPVj1oOOFuffRZe
	wye7dYXvpfx14HncPGi/W+NBA3VHXGz4Q538AZ6U7LB1ZuCUwN2WTV6RMkNdIZ34XYrgYXRsjvg
	CzxPkFtaa2C2rDfzlBzIBdoQcgVKQfKH4=
X-Received: by 2002:a05:7022:2513:b0:119:e56b:9581 with SMTP id a92af1059eb24-125c0f79782mr3575827c88.6.1769885611747;
        Sat, 31 Jan 2026 10:53:31 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9df97d0sm14784523c88.13.2026.01.31.10.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 10:53:31 -0800 (PST)
Message-ID: <2929917f-fd2b-41d5-a6b0-709c9cd826d0@gmail.com>
Date: Sat, 31 Jan 2026 10:53:30 -0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: guard against missing private state in
 lock_delalloc_folios()
To: Qu Wenruo <wqu@suse.com>, boris@bur.io, clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
References: <20260131013438.286422-1-inwardvessel@gmail.com>
 <9e1bf022-730d-4b93-872a-259490eb4946@suse.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <9e1bf022-730d-4b93-872a-259490eb4946@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-21261-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFE93C398C
X-Rspamd-Action: no action

On 1/30/26 6:15 PM, Qu Wenruo wrote:
> 
> 
> 在 2026/1/31 12:04, JP Kobryn 写道:
>> Users of filemap_lock_folio() need to guard against the situation where
>> release_folio() has been invoked during reclaim but the folio was
>> ultimately not removed from the page cache. This patch covers one 
>> location
>> which may have been overlooked.
>>
>> After acquiring the folio, use set_folio_extent_mapped() to ensure the
>> folio private state is valid. This is especially important in the subpage
>> case, where the private field is an allocated struct containing bitmap 
>> and
>> lock data.
>>
>> Failing calls (with -ENOMEM) are treated as transient errors and 
>> execution
>> will follow the existing "try again" path.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>> ---
>>   fs/btrfs/extent_io.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 3df399dc8856..573b29f62bc1 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -332,6 +332,18 @@ static noinline int lock_delalloc_folios(struct 
>> inode *inode,
>>                   folio_unlock(folio);
>>                   goto out;
>>               }
>> +
>> +            /*
>> +             * release_folio() could have cleared the folio private data
>> +             * while we were not holding the lock.
>> +             * Reset the mapping if needed so subpage operations can 
>> access
>> +             * a valid private folio state.
>> +             */
>> +            if (set_folio_extent_mapped(folio)) {
>> +                folio_unlock(folio);
>> +                goto out;
>> +            }
> 
> If the folio is released meaning it will not have dirty flag.
> Then the above folio_test_dirty() should be triggered and exit with - 
> EAGAIN. We will re-search the extent io tree to re-grab a proper 
> delalloc range.
> 

Thanks for ruling that one out. It seems that there are no other
vulnerabilities in mainline at the moment. Stand by for one more patch
at a different location targeting the 6.12 stable tree.


