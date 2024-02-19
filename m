Return-Path: <linux-btrfs+bounces-2488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789EF859EFD
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 10:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8561F23633
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C88922EED;
	Mon, 19 Feb 2024 09:00:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF35D224C9;
	Mon, 19 Feb 2024 09:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708333224; cv=none; b=c3mrwaTHURszlQwozebOxffKAkG7hn0sznXjvo1W/8rX9TbrCelH26reg07gdu6PAmpMcB+UvfAm6ysaXN3rbsnzizzGuiFjHIp2pq7PcBjySZGlS0WWzZZBGjBCbQbKu5Gd+uVAgncGjtqUoReFwk9WEwSVY93KqFFErzVXYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708333224; c=relaxed/simple;
	bh=nSb6XHx2/zI87e1tk4aJrr8VJruF2aMxjFXTo0hIwH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgaeRHloUfC18WIUPwB6qHLnT6483Y6Tp5rXK86z0Lu6OrspteDEaAeGhaAArQ3w+h0IYuWrvGWaTgIX2Q5z+IsA0BCQiX1AuXX/LN64DZTl0Sh9LSgG7I3V8a3uP3Jezq8TM2cg0qOI9EvWIJxgiSs3gSxFg7gaW6MJpKJBiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7501471c6266470e83269b0895df3d3b-20240219
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:535af910-ba26-4e2c-990e-91c69d53e1bc,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:535af910-ba26-4e2c-990e-91c69d53e1bc,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:f0d58d80-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2402191700187VGM1H17,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|64|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 7501471c6266470e83269b0895df3d3b-20240219
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1889806446; Mon, 19 Feb 2024 17:00:15 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 188BEE000EBC;
	Mon, 19 Feb 2024 17:00:15 +0800 (CST)
X-ns-mid: postfix-65D3189E-972373193
Received: from [172.20.15.254] (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id E7725E000EBC;
	Mon, 19 Feb 2024 17:00:13 +0800 (CST)
Message-ID: <c3c6b650-6156-4ee4-89d0-2c8033ae26eb@kylinos.cn>
Date: Mon, 19 Feb 2024 17:00:13 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: Simplify the allocation of slab caches in
 btrfs_delayed_inode_init
Content-Language: en-US
To: dsterba@suse.cz
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 Johannes.Thumshirn@wdc.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240201084406.202446-1-chentao@kylinos.cn>
 <20240205160408.GI355@twin.jikos.cz>
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <20240205160408.GI355@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for your reply.

On 2024/2/6 00:04, David Sterba wrote:
> On Thu, Feb 01, 2024 at 04:44:06PM +0800, Kunwu Chan wrote:
>> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>> to simplify the creation of SLAB caches.
>> Make the code cleaner and more readable.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>> Changes in v2:
>>      - Update commit msg only, no functional changes
> 
> Please convert all kmem_cache_create calls where the KMEM_CACHE macro is
> suitable, ie the cache name and the structure name match.
I'll do this by a patch series.
-- 
Thanks,
   Kunwu


