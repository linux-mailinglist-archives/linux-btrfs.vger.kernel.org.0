Return-Path: <linux-btrfs+bounces-17419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3614BB7BF9
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 19:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A903AD9FE
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01652DAFA9;
	Fri,  3 Oct 2025 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="mWU/sOY7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DAA19D880;
	Fri,  3 Oct 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512736; cv=none; b=TwKmjlPoLSEFT18aX5X1QQ9NROcHVB0vYj6ZUR7xei8XUv8gkq7MtMiCCwvbqjEtOqJqmjcrmip5wpw9nPR6sGr0dh1qyJwS8wTd1JKex1dLn8I9PbmMUMUI4gbZGuNX158rqpyxFrFq5tW0B2CKFCC4t0q0HT5ogNCa7XTKToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512736; c=relaxed/simple;
	bh=KUXQDUaLpGTyUaeCV6NkTrwXChz9uX7wllKFZMxDMEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Za4Jk5vUnWFrfQsvTWju7MqKlB1JokJXKvz5rsnuiIceFIEb9x1kMxWc23WJBfI+F6pugpayUdxaQgKY9dZgOICsM5DV8vpbrvVI4K13v4RBFaqgUEXTcpwbjhSrP7QaV+s6lQSlWhh/ENMdtJm9fo0AwNLHmG00DgPjQgNsN44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=mWU/sOY7; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id 4fOFvaOCGKXDJ4jdWvALPd; Fri, 03 Oct 2025 17:32:06 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 4jdVvl6csrMH54jdWvfJQX; Fri, 03 Oct 2025 17:32:06 +0000
X-Authority-Analysis: v=2.4 cv=eaE9f6EH c=1 sm=1 tr=0 ts=68e00896
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=4oHATN8Nx7vVUZJYxp75bA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7T7KSl7uo7wA:10
 a=UzAz_WlB0G74hqp-NeEA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wk/lJ0/YkwWz5LRniSBr0fOTkRttbOb5TobwP/F87mM=; b=mWU/sOY7n7kfeq+tXJdqvl4Vpb
	QS6ivMrZU8yEKS+TsZAaKzMukht/960Bn9p3Kepari0pCP+L053Qfmz8j4spATH0ZGjYQWamLcER9
	DrOaWnTJbxDBgaK+30+6xPtvKVOK/VJGRPwND7MEOaifd867NRTqTaWvplCA+OB/tpOECuy6nlC89
	VGcJQjvNNzR+5IwbK+JB3vYC0sXYAi3QUcHKU4jkUmJfz2CkuJ6Vu2a/aXqcpbR975uV7MhyUVU6o
	OP3+JRrTP/lZubY9tXCJUJHIlA76Qb4vRP9gMdlCGz7r+/KYWyI1HOD8ca5Nq/J0/WuWxYaRnlenr
	5AZWa0og==;
Received: from [185.134.146.81] (port=52182 helo=[10.21.53.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v4hb3-00000002K6A-0MN0;
	Fri, 03 Oct 2025 10:21:25 -0500
Message-ID: <10762d3f-361a-48b7-8e46-5e5b8a9887fb@embeddedor.com>
Date: Fri, 3 Oct 2025 16:21:17 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] btrfs: Avoid -Wflex-array-member-not-at-end warning
To: dsterba@suse.cz
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aN_Zeo7JH9nogwwq@kspp> <20251003143502.GJ4052@suse.cz>
 <b59ed01f-d9d5-4de8-8a12-1e506962b2d9@embeddedor.com>
 <20251003151509.GK4052@suse.cz>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251003151509.GK4052@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.134.146.81
X-Source-L: No
X-Exim-ID: 1v4hb3-00000002K6A-0MN0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([10.21.53.44]) [185.134.146.81]:52182
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfK4M9m0pbIowg9FlJnFFGQEUZ1OtocPOx4fqCdf1MmuES91rpOTIJ/lcXIfg7GnHA1Or97wRORieh8rn6mdA1F09CNT4mFeRy0WRKPHx7xviRLVhO7Ki
 azRIugbcBHctVzgjUD33JZUZR+hSii8mY/TfMQ6X1WqPKIBoZR2+EuAIp3ZqfrnmsxE6rTTk0UdGS153o5ZuT5Az737DGcYGVr9oOjDWYwrDLNl72tlL8fBi
 uJZIqdnp1U6IxrRAbrQjq4n4LCmgG/yf1vmQyzPWT2v5TzO60GYfXcX7xXxOut+gNNqK+7Wf1axs4JhsDV3J3Q==



On 10/3/25 16:15, David Sterba wrote:
> On Fri, Oct 03, 2025 at 03:51:24PM +0100, Gustavo A. R. Silva wrote:
>>>>
>>>> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
>>>> index 9230e5066fc6..2b7cf49a35bb 100644
>>>> --- a/fs/btrfs/send.c
>>>> +++ b/fs/btrfs/send.c
>>>> @@ -178,7 +178,6 @@ struct send_ctx {
>>>>    	u64 cur_inode_rdev;
>>>>    	u64 cur_inode_last_extent;
>>>>    	u64 cur_inode_next_write_offset;
>>>> -	struct fs_path cur_inode_path;
>>>>    	bool cur_inode_new;
>>>>    	bool cur_inode_new_gen;
>>>>    	bool cur_inode_deleted;
>>>> @@ -305,6 +304,9 @@ struct send_ctx {
>>>>    
>>>>    	struct btrfs_lru_cache dir_created_cache;
>>>>    	struct btrfs_lru_cache dir_utimes_cache;
>>>> +
>>>> +	/* Must be last --ends in a flexible-array member. */
>>>                           ^^
>>>
>>> Is this an en dash?
>>
>> Not sure what you mean.
> 
> En dash is a punctuation mark not typically used in comments, nowadays
> found in AI generated code/text. I was just curious.

Ah yes, I've been using this punctuation mark for this sorts of comments,
but this is not AI generated code/text.

-Gustavo


