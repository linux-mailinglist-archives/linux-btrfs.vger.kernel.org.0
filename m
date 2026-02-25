Return-Path: <linux-btrfs+bounces-21914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I9UL8nRnmnwXQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21914-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 11:41:13 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 208C4195E4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 11:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9941F3113F6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 10:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C37392C55;
	Wed, 25 Feb 2026 10:37:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD5392C34
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 10:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015827; cv=none; b=RNj2uIslXCWsLPRJUxv38sIkfka0bNwTHHzakrDSCvUSLQwEU9C1T1wsEnQvJu3y5pRM8zs31VmHYz8uLGycxvpkGW+vuCSwvcxfiE+1sm5ymXF2GXUxqbh50SOnCX8Dwk3FXXL1nwytwWxyg9Z2xhYDzCRfdQFZjfatppHhq2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015827; c=relaxed/simple;
	bh=tbV3YfbrQAloDj/XkfmsxHQln2UKfBKBlyAJ9+YQPGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CrqgFJfgv6/kFaBm5dUdImEZk/7Fx+Upo6t2bxK1WKW8bAD6cCywqSZ/STrnnsVhhgOidpRuV2BnlXIQj3ScNG6yuTawCneExktCKLR3PBTozYW9NdosRzW270AbEajYbtzCwoGTAWelSdvAmA408kDtXXZrsypn/gFrfwi3JAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [IPV6:2a01:e0a:156:6850:7018:89ff:fecb:6f21] (unknown [IPv6:2a01:e0a:156:6850:7018:89ff:fecb:6f21])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 6EC0E19F574;
	Wed, 25 Feb 2026 11:37:02 +0100 (CET)
Message-ID: <0205907a-9dec-4f7c-a62e-f825a25ee178@free.fr>
Date: Wed, 25 Feb 2026 11:37:02 +0100
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
 <2f7fe549-676d-45fb-b97a-82096027c89c@free.fr>
 <72eece35-d5f3-476a-ae0f-5fbd99cb2d60@free.fr>
 <fa9cfd2f-1e9d-4713-9e2b-9399076f8aba@free.fr>
 <b05f77cb-200c-4a68-8184-d5965490278a@suse.com>
Content-Language: en-US, fr
From: Phako <phako@free.fr>
In-Reply-To: <b05f77cb-200c-4a68-8184-d5965490278a@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[free.fr : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21914-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 208C4195E4C
X-Rspamd-Action: no action

Le 25/02/2026 à 10:37, Qu Wenruo a écrit :

> 
> In this particular case, since the checksum matches with the correct 
> data, it shows at least btrfs is seeing the correct data just before 
> submitting it to the RAID controller.

I also thought about the controller being the problem, but then why it 
has not reproduced the problem when this specific LBA is written with 
dd? Could it be VFS? I really don't get it.
> 
> So I'd say there may be something weird inside that RAID controller.
> 
> 
> If possible, please try a btrfs RAID1 without that RAID controller to 
> rule that out.
> 

I don't see how I could materially do that, I don't have 2*16 TB HDD in 
spare.
I think I'm gonna try to correct the 4 other corrupts blocks, and wait 
and see if this behavior persist.

> Thanks,
> Qu

Thank you

