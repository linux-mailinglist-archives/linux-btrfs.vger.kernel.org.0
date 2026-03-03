Return-Path: <linux-btrfs+bounces-22168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOWnBLKQpmnxRAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22168-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 08:41:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DE61EA474
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 08:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D215304889D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 07:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C88379ECC;
	Tue,  3 Mar 2026 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owLZKP10"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A1352FBA
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772523676; cv=none; b=dWPaVS+LukDYuLJqufEfcW428SB/2ZlHPvcUrpjC+BVZmP0SHQueCVvmiw8SxqNMB2ZBHskj2JF9aOU4Z05ghkTM4Kw62T3FfmfE4hmn4ieS6K+q/jNz5XICv0GtcWp/5q2M16nSShIsIBulVHsVPDWaegS2drT0KlXwASpczMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772523676; c=relaxed/simple;
	bh=EZTnyUw7WQ18g3uJEFqtXLGZ+swrpsJETRUR44nAY8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+9SoWe97Twbq1TSgD0NwmjAiXqRPBBtSwDUZYOCv9rRhwwsapWvkyNhlTKjL6T8vmQC9EyNrlak25RIL5Ik0VMayHVC1HecslYX18LifGXVLhIeb14sMp8dVSeW4Q02l1SdQLhllp+I+R+4GYzPxbsxHQ2zEhKjGr1ch9cotIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owLZKP10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542ACC116C6;
	Tue,  3 Mar 2026 07:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772523675;
	bh=EZTnyUw7WQ18g3uJEFqtXLGZ+swrpsJETRUR44nAY8A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=owLZKP10q0meE39PduXHRspWN7RNTY0l1l5d0bVSoFbJC5vR5gxIoYo9jd86X/XUP
	 OuUy9QZn4j62N6MJ84eP+d8Sid1oYUUuVBLP052HlvIF50D8bPmMV4Z4zIykxo0HWr
	 fDRla+4vLVgZAoOg0c3zDl4fPlGXtfRK8pyiztExNVT5qbnNYuSXSFYbUld4liZPHc
	 oXTy+Um+8BnIr9g45DbffregHtwpryCUQnkPWygUBEbmicFNmLm4M8SHiACtBGcuUx
	 GxRLRr7uJZ7pRF0ALeDXEFtbvvMbj0OAYk0VUvt0fyPGjPs7Tt/9bJslZr/mFDiegr
	 BLjMUAP5H1CfA==
Message-ID: <75b7fcfe-f8d5-47ae-abbb-871e418cbda0@kernel.org>
Date: Tue, 3 Mar 2026 16:41:13 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: zoned: limit number of zones reclaimed in
 flush_space
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
References: <20260302143942.115619-1-johannes.thumshirn@wdc.com>
 <20260302143942.115619-4-johannes.thumshirn@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260302143942.115619-4-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 72DE61EA474
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22168-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 23:39, Johannes Thumshirn wrote:
> Limit the number of zones reclaimed in flush_space()'s RECLAIM_ZONES
> state.
> 
> This prevents possibly long running reclaim sweeps to block other tasks in
> the system, while the system is under preassure anyways, causing the

s/preassure/pressure

> tasks to hang.
> 

[...]
> 
> To prevent these long running reclaims from blocking the system, only
> reclaim 5 block_groups in the RECLAIM_ZONES state of flush_space(). Also

5 seems very arbitrary. For a device with very large zones, this could still
take some time and cause the problem again. Why not iterate the block groups one
by one ? Is there any benefit to batching like this ?

> as these reclaims are now constrained, it opens up the use for a
> synchronous call to brtfs_reclaim_block_groups(), eliminating the need
> to place the reclaim task on a workqueue and then flushing the workqueue
> again.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


> -static int btrfs_reclaim_block_group(struct btrfs_block_group *bg)
> +static int btrfs_reclaim_block_group(struct btrfs_block_group *bg, int *reclaimed)
>  {
>  	struct btrfs_fs_info *fs_info = bg->fs_info;
>  	struct btrfs_space_info *space_info = bg->space_info;
> @@ -2036,15 +2036,17 @@ static int btrfs_reclaim_block_group(struct btrfs_block_group *bg)
>  	if (space_info->total_bytes < old_total)
>  		btrfs_set_periodic_reclaim_ready(space_info, true);
>  	spin_unlock(&space_info->lock);
> +	(*reclaimed)++;

If ret != 0, it means that btrfs_relocate_chunk() failed. So in that case,
shouldn't you skip incrementing the reclaimed counter ?

>  
>  	return ret;
>  }



-- 
Damien Le Moal
Western Digital Research

