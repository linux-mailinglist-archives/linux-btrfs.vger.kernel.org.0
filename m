Return-Path: <linux-btrfs+bounces-1987-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6028452CF
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 09:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB04C292A7B
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1242415AAB6;
	Thu,  1 Feb 2024 08:34:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549DE15A4A0;
	Thu,  1 Feb 2024 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776473; cv=none; b=tyPQTXiE3+EVswxWt5plrKbRkB6stI+GvTmsEuyR151dVN3zfeU+6VY/b+NOqPxk2xZ6kf3dgc2FquC1Yr3Vf/W0yGpT+QodVMiRWZu16XE7nBXEOOTgkANRSr7LBoguxlCZb1p2I4I44On+MHd894rw0mG1sZGVlK5//VevGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776473; c=relaxed/simple;
	bh=effHG4dkWLbLYL5i2tCnHyIRw3vMCpBMGQWiyMAoyKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6Znm9yEg3oh9+lFpNL+7ydFi/qXbhRi18y6lyFGBVb0ClUmDVlhrecZJLHm+H5RhlAzIpljnnjbPrI694/8S854UYBNi3FGyu/m2yPIJIBiJjMt8O5V94yLT9swaS+eQYLLaBkTHwj6oizJ3dXXBzodEaTx1bWxmDZU6yHN7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1358d7cff6e846d89fb7572343b25de6-20240201
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:ea8af4cb-f568-4118-81b8-69e36e9275a9,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:1
X-CID-INFO: VERSION:1.1.35,REQID:ea8af4cb-f568-4118-81b8-69e36e9275a9,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:5d391d7,CLOUDID:0e978083-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2401311820519VSXH2RO,BulkQuantity:10,Recheck:0,SF:19|42|74|64|66|38|
	24|17|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:40,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_OBB,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,
	TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 1358d7cff6e846d89fb7572343b25de6-20240201
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1100704219; Thu, 01 Feb 2024 16:34:20 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B4E7BE000EB9;
	Thu,  1 Feb 2024 16:34:20 +0800 (CST)
X-ns-mid: postfix-65BB578C-668365887
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id BF489E000EB9;
	Thu,  1 Feb 2024 16:34:17 +0800 (CST)
Message-ID: <a6ed9030-8d48-4f9c-8504-9a5308813791@kylinos.cn>
Date: Thu, 1 Feb 2024 16:34:16 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Simplify the allocation of slab caches in
 btrfs_delayed_inode_init
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, "clm@fb.com"
 <clm@fb.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "dsterba@suse.com" <dsterba@suse.com>, dsterba@suse.cz
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240131061924.130083-1-chentao@kylinos.cn>
 <1706776227363553.10.seg@mailgw>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <1706776227363553.10.seg@mailgw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/31 18:20, Johannes Thumshirn wrote:
> On 31.01.24 07:20, Kunwu Chan wrote:
>> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
>> introduces a new macro.
>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> 
> That commit is 17 years old. Why should we switch to it _now_? I
> wouldn't call it a new macro.
> 
> Don't get me wrong, I don't oppose the patch, but I'd prefer a better
> explanation why now and not 17 years ago when the macro got introduced.
> 
Thanks for your attention.
Like David say in 
https://lore.kernel.org/all/20240131183929.GP31555@twin.jikos.cz/#t.

The main reason is 'it hides all the 0 or NULL parameters', makes the 
code cleaner and more readable.

So i'll update the commit msg to this:

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.
Make the code cleaner and more readable.

And resend a v2 patch.
Thanks again.
>> to simplify the creation of SLAB caches.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>    fs/btrfs/delayed-inode.c | 6 +-----
>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
>> index 08102883f560..8c748c6cdf6d 100644
>> --- a/fs/btrfs/delayed-inode.c
>> +++ b/fs/btrfs/delayed-inode.c
>> @@ -28,11 +28,7 @@ static struct kmem_cache *delayed_node_cache;
>>    
>>    int __init btrfs_delayed_inode_init(void)
>>    {
>> -	delayed_node_cache = kmem_cache_create("btrfs_delayed_node",
>> -					sizeof(struct btrfs_delayed_node),
>> -					0,
>> -					SLAB_MEM_SPREAD,
>> -					NULL);
>> +	delayed_node_cache = KMEM_CACHE(btrfs_delayed_node, SLAB_MEM_SPREAD);
>>    	if (!delayed_node_cache)
>>    		return -ENOMEM;
>>    	return 0;
> 
-- 
Thanks,
   Kunwu


