Return-Path: <linux-btrfs+bounces-21545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF+vJP7ciWkGCwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21545-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 14:11:26 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A90710F770
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 14:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 724393013AA3
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D8B363C59;
	Mon,  9 Feb 2026 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKjRxruw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC212459D4
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642538; cv=none; b=oRFgBZ1Tf7mtz2ZKkDSxRkE3fZtlNki4gRDfwnRNVhCDX0xOu7SYkO8sWnFjtzmhcW/pymQV6Zkj+e3BkuxfnUWmKPTSmVIL50x669VyXoDdewuKya+QO+hWhoaHQBLADFk9xRWLwyUCSVtJZbLRjgNoVxwVKVNMJ/W/ZVlXswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642538; c=relaxed/simple;
	bh=DD/xN1r2DNkIESd5vA22P2HVTs4khH9TIm4MinDilGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEZdT0ChvjnFypJkkQ7ewhSB4zZO4KNVhASIIP2b+KRx3JoCEMXfemBD974xexl9ZH7uF2ALoFM9IkMdG16OmDr+erx2Z+iJ0YkIEk3vS+kP0PqjVIB9+WbftnlhssXd7tRmcuYbBKxsisFkLH8fn/uwLVY6xY/qEOE+ibiojBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKjRxruw; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4806fd9033bso7588395e9.3
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 05:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770642536; x=1771247336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gfVUHBLq2V0DlEYvd+j5bfxGmVxl6keyc6Qg/YDIXU=;
        b=YKjRxruwo9k1+YJTEmiW9+XNibakQHsALFD48TO9iJA+gea0BTmg1vwRiFkJGYO/NZ
         k+seeJULHDzoc9ceI0XWSck4DJWyvsOpL7Z8Vu4H4lmWOutT2cYGIR03sGN8MGn8V8Q3
         uxndPhg4+UzKj4PPwzwPmCSEbDAl2+smSfXKp9O+vDIfLS14kMBsxi7aw10c4RWheFKn
         RN7poBNpYyo5iqjkQgIJp2tns8xAUOqiaFsWjAasOmSPiS+c1c+/NwquWMM6NCdKhwx5
         ytCOOfUzpTOHxDVneSRg5QyI7+viA+FO5qtWdDeTmqgv16lHypUE9MI4cbzzdJSGECQZ
         At4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770642536; x=1771247336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gfVUHBLq2V0DlEYvd+j5bfxGmVxl6keyc6Qg/YDIXU=;
        b=C/wilH9M/s00rNlos/PUEEcPVF9U1NmdgCLDZ2aBObqjLqEOi2u3n68CDvvqy/fYwT
         7tPypvlqccFtxcV/uN/fYFdFMFPvo5IEGi1X4laY0KuJ8he9IL29ZUDGZMOI20wEp+ZK
         7FXt37/zmS513c646gdc5sFwpSSr+/QYo3jrhoBCtx+0ZhAb9vDoRyiGfalKy8xKJJ+q
         h9AIJUT4BIkDzCwTHGHqiFUmjDqT2BXvC7RofuWQiNsNFtP6GZ2Vyt06ZgAgApIlFm53
         CqmdSTq6b6sTCIK6LQ4YPcK8YC+AbR8XJQAdxMPt2Jde22DWM+QlHplRRUomEQjCcaUK
         gf6A==
X-Gm-Message-State: AOJu0YzhYSxhnrlSQ7T+fY3kFGxIe2dxXupPSsiSbP84z/jhHLAdXrG/
	WN0l7E70L101dCCNNfp57ECCjzUlurJjYWPvNsZrBE79r2zAmwGxwr0vYEDsNVwp2g0=
X-Gm-Gg: AZuq6aLTpDo5zo+odNIjGYRUkl8ZYa6959yWiw71MlPvF23SRXbQIJxlwuL+GCfdv+y
	JPAqs3x5LboO4xiu7Gpv21X79LxR5XRjC82eCDkKs8rNPe3awkipMk2kRM9XrJB4AngA9GFmpRb
	09NvLrz6HZaVCBKs+K93GjtGwdNJGsvVlZ5YqsqVlUWb8XPeiQDFPpVfn02hIo6oWDz23dFLrR5
	moq8dbY7Oku29bS7Sw5DpOwqAxZTLgcK+JYlfCtR/OZPWoKDs/lD70RFJucwLH3IUd2Hjh06XZf
	Bg+FkvusuQemXmMZwccCN7S5k8xwx+G0Uu+scCgFWv32sh/pi2KMfAYm6Fzyc+Muk3QvByg9BJc
	ODjEGIv8FGYBEb2MkTNnFnW7bwhtlu5GhPTfmnDKSdvY7yQffoumrkJ3SJXbu2C2Ueigexz3n3z
	Y0riMPcAKkXzkZShJAELh9H43Ftocvjfo0i+Le4vK+8AuAIDhMMD9W+ygcmen71fyVuQ==
X-Received: by 2002:a05:600c:1549:b0:477:a16e:fec5 with SMTP id 5b1f17b1804b1-48320195de3mr93182325e9.0.1770642536070;
        Mon, 09 Feb 2026 05:08:56 -0800 (PST)
Received: from ?IPV6:2408:8239:502:5512:c2bb:652f:431b:5e28? ([140.238.217.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d2bab2sm559194875e9.3.2026.02.09.05.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 05:08:55 -0800 (PST)
Message-ID: <88ae0d71-e128-40b5-8f78-076ae5128b6e@gmail.com>
Date: Mon, 9 Feb 2026 21:08:48 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] btrfs: fix periodic reclaim condition
To: Chris Mason <clm@meta.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
References: <20260114035126.20095-1-sunk67188@gmail.com>
 <20260114035126.20095-2-sunk67188@gmail.com>
 <20260208182556.891815-1-clm@meta.com>
Content-Language: en-US
From: Sun YangKai <sunk67188@gmail.com>
In-Reply-To: <20260208182556.891815-1-clm@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21545-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunk67188@gmail.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A90710F770
X-Rspamd-Action: no action



On 2026/2/9 02:24, Chris Mason wrote:
> Sun YangKai <sunk67188@gmail.com> wrote:
>> Problems with current implementation:
>> 1. reclaimable_bytes is signed while chunk_sz is unsigned, causing
>>     negative reclaimable_bytes to trigger reclaim unexpectedly
>> 2. The "space must be freed between scans" assumption breaks the
>>     two-scan requirement: first scan marks block groups, second scan
>>     reclaims them. Without the second scan, no reclamation occurs.
>>
>> Instead, track actual reclaim progress: pause reclaim when block groups
>> will be reclaimed, and resume only when progress is made. This ensures
>> reclaim continues until no further progress can be made. And resume
>> perioidc reclaim when there's enough free space.
>>
> Hi everyone,
> 
> I'm running the btrfs for-next branch, along with the encryption patch set
> through my AI review prompts:
> 
> https://github.com/masoncl/review-prompts
> 
> I'm working on some btrfs specific instructions, but hopefully these reviews
> are already useful.  I've kept the headers to make it easier to double check
> that I'm actually replying to the right email, but please let me know if any
> parts of this are incorrect:
> 
> commit 19eff93dc738e8afaa59cb374b44bb5a162e6c2d
> Author: Sun YangKai <sunk67188@gmail.com>
> 
> btrfs: fix periodic reclaim condition
> 
> This commit fixes issues with periodic reclaim by tracking actual reclaim
> progress rather than relying on the assumption that space must be freed
> between scans. The patch addresses problems with signed/unsigned comparison
> and ensures reclaim continues until no further progress can be made.
> 
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index ebe97d6d67d3a..bc493243f777d 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
> 
> [ ... ]
> 
>> @@ -2098,11 +2098,11 @@ static bool is_reclaim_urgent(struct btrfs_space_info *space_info)
>>   	return unalloc < data_chunk_size;
>>   }
>>
>> -static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>> +static bool do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>>   {
>>   	struct btrfs_block_group *bg;
>>   	int thresh_pct;
>> -	bool try_again = true;
>> +	bool will_reclaim = false;
>>   	bool urgent;
>>
>>   	spin_lock(&space_info->lock);
> 
> [ ... ]
> 
>> @@ -2137,12 +2137,13 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>>   	 * If we have any staler groups, we don't touch the fresher ones, but if we
>>   	 * really need a block group, do take a fresh one.
>>   	 */
>> -	if (try_again && urgent) {
>> -		try_again = false;
>> +	if (!will_reclaim && urgent) {
>> +		urgent = false;
>>   		goto again;
>>   	}
>>
>>   	up_read(&space_info->groups_sem);
>> +	return will_reclaim;
>>   }
> 
> [ ... ]
> 
>> @@ -2179,7 +2181,6 @@ static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
>>
>>   	spin_lock(&space_info->lock);
>>   	ret = space_info->periodic_reclaim_ready;
>> -	btrfs_set_periodic_reclaim_ready(space_info, false);
>>   	spin_unlock(&space_info->lock);
>>
>>   	return ret;
>> @@ -2193,8 +2194,10 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
>>   	list_for_each_entry(space_info, &fs_info->space_info, list) {
>>   		if (!btrfs_should_periodic_reclaim(space_info))
>>   			continue;
>> -		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++)
>> -			do_reclaim_sweep(space_info, raid);
>> +		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
>> +			if (do_reclaim_sweep(space_info, raid))
>> +				btrfs_set_periodic_reclaim_ready(space_info, false);
>> +		}
>>   	}
>>   }
> 
> Does btrfs_reclaim_sweep()->btrfs_set_periodic_reclaim_ready() violate
> locking requirements? The function btrfs_set_periodic_reclaim_ready() has
> lockdep_assert_held(&space_info->lock) at line 2163, but at the call site
> above (line 2199), no lock is held.
> 
> Looking at do_reclaim_sweep(), it releases space_info->lock via
> up_read(&space_info->groups_sem) at line 2145 before returning. Similarly,
> the old code had btrfs_should_periodic_reclaim() release the lock with
> spin_unlock(&space_info->lock) at line 2184 before returning.
> 
> In the original code, btrfs_set_periodic_reclaim_ready() was called from
> btrfs_should_periodic_reclaim() while holding space_info->lock (acquired
> at line 2182, call to btrfs_set_periodic_reclaim_ready, then release at
> line 2184). This patch moves the call to btrfs_reclaim_sweep() but doesn't
> acquire the lock at the new call site.
> 
> Should space_info->lock be acquired before calling
> btrfs_set_periodic_reclaim_ready() at line 2199?

Yes! Thanks a lot for the report and I've sent the fix:
https://lore.kernel.org/linux-btrfs/20260209130248.29418-1-sunk67188@gmail.com/


