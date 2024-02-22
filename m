Return-Path: <linux-btrfs+bounces-2623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3703985EFB1
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 04:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56FF288092
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 03:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA4D17560;
	Thu, 22 Feb 2024 03:10:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF1828EF;
	Thu, 22 Feb 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571432; cv=none; b=EXCnPfc3912ytgTZP2b0q3u8kyoVxPDRK0ieLonhIY1NZw8E2Q1ab0K5gspXQJj1+us3G8fYrVpylQrXCmbOM0oj31zdfnvCBK1XwVY+24kyT0pCHDXNe2l177S47sLUsxv9Rli6Pc0n6XcrM7rx91j0Ab59nyaoYeMiuESRfFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571432; c=relaxed/simple;
	bh=pNvK4W4frFwecBIJ1eApe6zX+NJ8P2bgljcbML4h0ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJw5TXtnOMCQDOmUFDViwh8OFX7O/Ib39WB1E7C8r8tFSuiM0vaRpgBbNtEBWXErp26ePj2Hbg1OhGmTdVnK2iDWUSopUywKwv6pCFtMhmTAVh5fb8gCJWWCZBxW9BVW2tLnszQgjhXAd30DvUyHlnAmeKiI8BBBPTnfPMmzneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 93d72cbe477e4e478c6f879952b6d78d-20240222
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:5ddc4006-ddf4-44f1-ac59-e642fbaa7fcd,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:5ddc4006-ddf4-44f1-ac59-e642fbaa7fcd,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:18eb2b84-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240221200127QCK9AEFP,BulkQuantity:5,Recheck:0,SF:64|66|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 93d72cbe477e4e478c6f879952b6d78d-20240222
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2047731242; Thu, 22 Feb 2024 11:10:22 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 25B05E000EBC;
	Thu, 22 Feb 2024 11:10:22 +0800 (CST)
X-ns-mid: postfix-65D6BB1E-63643304
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 48675E000EBC;
	Thu, 22 Feb 2024 11:10:20 +0800 (CST)
Message-ID: <43434831-48de-42d1-9f2c-04520ea54534@kylinos.cn>
Date: Thu, 22 Feb 2024 11:10:20 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] btrfs: Use KMEM_CACHE instead of kmem_cache_create
Content-Language: en-US
To: dsterba@suse.cz
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240220090645.108625-1-chentao@kylinos.cn>
 <20240221120030.GI355@twin.jikos.cz>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <20240221120030.GI355@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/21 20:00, David Sterba wrote:
> On Tue, Feb 20, 2024 at 05:06:39PM +0800, Kunwu Chan wrote:
>> As David Sterba said in
>> https://lore.kernel.org/all/20240205160408.GI355@twin.jikos.cz/
>> I'm using a patchset to cleanup the same issues in the 'brtfs' module.
>>
>> For where the cache name and the structure name match.
>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>> to simplify the creation of SLAB caches.
>>
>> Kunwu Chan (6):
>>    btrfs: Simplify the allocation of slab caches in
>>      btrfs_delayed_inode_init
>>    btrfs: Simplify the allocation of slab caches in ordered_data_init
>>    btrfs: Simplify the allocation of slab caches in
>>      btrfs_transaction_init
>>    btrfs: Simplify the allocation of slab caches in btrfs_ctree_init
>>    btrfs: Simplify the allocation of slab caches in
>>      btrfs_delayed_ref_init
>>    btrfs: Simplify the allocation of slab caches in btrfs_free_space_init
> 
> Added to for-next, thanks. I've edited the changels so the name of the
> structure is mentioned rather than the function where it happens, and
> did some minor formatting adjustments.
It's ok, thanks for your adjustments.
-- 
Thanks,
   Kunwu


