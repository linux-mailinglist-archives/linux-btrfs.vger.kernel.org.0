Return-Path: <linux-btrfs+bounces-1552-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DE98315F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 10:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22EDE1C24D9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B31208C2;
	Thu, 18 Jan 2024 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="NdwqCdpY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9E20338;
	Thu, 18 Jan 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570637; cv=none; b=SrvPe6RjtnV3LpM0tyKcS8wMCuuy12ENZG1Vg+4fSi6HkFKJCWuJccEvFfbtf5MpkKLPrt7xUHOY3mfCw79eru+S54GMBapOxnn8AcMLJst/jVurOsIANCSfnJPmZJYLk7Zbyv0cw1WEqYNIIEMOcGcaNu6K4b2Go4TeKLsSC+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570637; c=relaxed/simple;
	bh=j1IM6kx/S6e3w4O8Y/YVTb2bwuhEq1mGoMZ97TRZ+O4=;
	h=DKIM-Signature:Received:X-QQ-mid:Message-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-OQ-MSGID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=bxlamy3nVwYUiwpxDW5rzGH/mD3V46VY9qUSqQvh5Qw55uNhVlhtJIast4dsyZJk1cBTTeyev+7AmWvaZ6YsMvvp9XLfSNj66iyWRjRMfGlXmJiz9jwj4Poo67UxXnAiqVJn3VvVtFVDg6yzoV9bm7ZQv+tTMaNpg3aLHQUjdps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=NdwqCdpY; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1705570630;
	bh=OHHFr4eFMtLac4mxhRpFxzeXOjNZQrmZY4/3HTOAjJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NdwqCdpYYuLUh6bVvETvwPHz40E2JwwCYjwGfZmnLJf1bDMpkhU/3OVZMPSPdE433
	 trkP/bIIxJyn0WZo23prvJK6Xn6S/e0IZsaYl0xkYkQPu0Y0sDFUdFEC9RJtMFiDM4
	 RSVY8PiPuvKuAWIlCSNeGTEAu4IkHOislRINfLc8=
Received: from [192.168.3.231] ([116.128.244.171])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 946B4E95; Thu, 18 Jan 2024 17:37:06 +0800
X-QQ-mid: xmsmtpt1705570626tsau54ncz
Message-ID: <tencent_0D3574DAB98883D88196B3F24D2D379D7D0A@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBn9bc+b2WisgDI4ycQTYIvQtaPNDBGYaVL5E4baRu5QhtW04HwFr
	 /yT9xKS6t9zPEgsOiaL4U60YPv5HeLj7P+5i40GM99Gi7TdpxU6shG1KPLQy12rTsqrlIZaWeaie
	 QnNf9ihKBKF/HG0WWghyXZXHeoMNIpwOUdofRmPjsTRF7KOoPN3QoqqVdm0V0IWs80nGhZ6tOC/8
	 xyNtLdI4/VE3Zd9whe/fbt54udzgJqaHXt+aPIjy48uqwOp/e62XDxdN4xmUHD3WezWtsfI4RBzJ
	 0CtR27hkDg/917+ICZw7x6ZGq23LLgd1eVSYLU0RwHI9UbLpnegTLIBBFp2nVUGEpxOyPmN8792N
	 7+d2p1WwIYSCYSwsIUPM/2BsqCd3E73SHBjQaz+AqYu2EHDLtLC6XUsjKG/t3vdk+VQpjoE6bduG
	 3etl54dNb8yEFLFoy+QoMAm4gie5h0ddR5SXXtYgk1TwjpsPgeiUtI939pMcM5YWF29j4tuojMTb
	 HDkmYSBTJhHTg0+nxstzv1tAJTT8uwLMqyAiOPcONU2etEkyYpWlUHTJ7viS9fgO10dbm+5noT48
	 Hr/KD9y6PuuWgnHsIyr2z6RUHcI3ta3H2IpZpo8K9Q6Yot7Cxzyt37WQJAktmQ8xUIMRiY2w99Q0
	 RjZzFKoXVveK4pTITgEcfGE7L3NlkI8AK9Dnc6s11Zv46wFNvU2sG+rWtrh27blF+qlKrh4TC3FP
	 oEOOT3/lijeXogbMhyIPFsfgkF5h3W3DrfTjnHdfxXLwSBN04VgkllsoTWkqmDlYFZ4BP59P9w2g
	 trQQISVF7PyYU9k3Tq7XLZP5Db1Ybm6lvoK+2X4DhGydYLwWpWp8I8IMkUbbmvy0LLYxl4Hz13NQ
	 e7uRjhsVEkLA0MrS55cWR7aGMfR6XD1AHxrs31ytQ0DpPR1UAW6hTtyJPv03tgtHwO0/aM5oOpla
	 VvYk0g5pIihVUqThNyFBD46qiOP0TlT7RBTBGw6yij3KksoRunqwXItD0M/pn6QzQa7Bv0dOM=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <fcf1838f-3103-49c2-b9a0-0a5195a73c2c@foxmail.com>
Date: Thu, 18 Jan 2024 17:37:06 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question about btrfs no space left error and forced readonly
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: chenxiaosong@kylinos.cn, liuzhengyuan@kylinos.cn, huhai@kylinos.cn,
 liuyun01@kylinos.cn, zhangduo@kylinos.cn, liuzhucai@kylinos.cn,
 zhangshida@kylinos.cn
References: <tencent_0C621A54ED78C4A1ED4ECA25F87A9619CE09@qq.com>
 <2870e41e-c0a8-4ab4-baaa-bbffbcd1e6a4@gmx.com>
 <tencent_0681F9CE96CDCF741BD6ECA4C401EC4CCB09@qq.com>
 <ef3e57f4-297a-4c26-a232-fb255dfa3867@gmx.com>
From: ChenXiaoSong <chenxiaosongemail@foxmail.com>
In-Reply-To: <ef3e57f4-297a-4c26-a232-fb255dfa3867@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/18 16:48, Qu Wenruo wrote:
> 
> 
> On 2024/1/18 18:03, ChenXiaoSong wrote:
>> On 2024/1/18 15:07, Qu Wenruo wrote:
>>>
>>> And `btrfs fi usage`, `btrfs fi df` output, along with `btrfs check
>>> --readonly` if possible.
>>
>> The environment has been restored by rebooting the system, and there is
>> enough disk space after rebooting the system.
> 
> Still those output can be helpful.
> 
> And if possible, full dmesg please, just in case if there is something
> related.
> 
> Thanks,
> Qu
>>
>>

Full dmesg can be found on 
http://chenxiaosong.com/tmp/btrfs-forced-readonly-log.txt

I will try `btrfs fi usage`, `btrfs fi df` output, `btrfs check 
--readonly` commands when this issue reproduce next time.

Thanks,
ChenXiaoSong.


