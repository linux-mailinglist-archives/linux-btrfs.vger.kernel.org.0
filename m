Return-Path: <linux-btrfs+bounces-2910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54D586C7A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB15A1F21BA4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 11:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454E47AE43;
	Thu, 29 Feb 2024 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="M5/rsquQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out2.mxs.au (h1.out2.mxs.au [110.232.143.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D01E7A71D
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204490; cv=none; b=crOjBm3aThBv1pYeVtuuJQzYrKjTeInnvzKPTeMYQuiQUqAdkZxm5KjLLw+tnkyHEWom2/DVA5bH3lqvAX+1FzeCj0RF1/twCGv3mn9FBaybmhSrHZiEvpAmDj1wXV2F6Dr6YZGk/C0/HejvulvGobuwmoDhQArYxoTBFKhsMg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204490; c=relaxed/simple;
	bh=svQwMy0Z5dyISeZrhVTwMM2q4GlgIsGb/NTjRBaJaxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WxzA4o3a3UmR7O8lDC2Grk8fdXENynnoSqJsBk+Ayz48iiQeNHFbaQY1NlfMMk8LmC/taEeNxyG2cmXYFh5y8GEAhbVvr+ikd9qRGW+oK9DnT+oxMWWHpwZU/juWO5oJJbpYUALPjB4J8Bp6tjAywKrRm1+sDkd+uScVWnJJxSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=M5/rsquQ; arc=none smtp.client-ip=110.232.143.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out2.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id ddf91112-d6f1-11ee-9817-00163c1ebd60
	for <linux-btrfs@vger.kernel.org>;
	Thu, 29 Feb 2024 22:01:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ahVPhYpKlmdYi9xnTEAedRaT3zN+RyypsPVlaWi7ohA=; b=M5/rsquQSIRSiBicy40MSItJS/
	J7siet83l6ihfdQeZ29B7cHosnj9MqzEyktd9ATTS1WdcTOOK0xQ4hm9lMhMGSBUW67EDAzvcmJrd
	LLd3rh3nnJ+c0aExGCEwIhQS4Fde8tj1w3YpFTH+DDV7J7XQbAwY05n4nKkYROE7zXvUFhZ8lt1zN
	l/egUiKXau/4KtQZDtu9naYZ6xTODOKSYlnvqfVr/noWDONDNG8jw3qdfcvbaYAGkoSSpEhmuNQAW
	8mtPX8746k/GAYDGzvSSeAqJkLi8Kk92HZ7+ROHGZc5DR/t2p+7cS9AJSvB24aYSY+CTAT8IKPxHq
	oka3rxbA==;
Received: from [159.196.20.165] (port=47632 helo=[192.168.2.80])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <default@edcint.co.nz>)
	id 1rfeAB-002yrQ-1B;
	Thu, 29 Feb 2024 22:01:19 +1100
Message-ID: <ae2bae85-40b1-467e-b467-18632e0e0cfa@edcint.co.nz>
Date: Thu, 29 Feb 2024 22:01:19 +1100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, Matthew Jurgens <default@edcint.co.nz>
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
 <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
 <be5917ba-4940-4800-9fbf-c1a24f4d82be@edcint.co.nz>
 <7382a5c8-726f-41b3-9cbf-b2c67f0a5419@suse.com>
 <0dd56988-e191-45c7-a3d7-60f43fc4b7fd@edcint.co.nz>
 <2b2d37d2-d618-44eb-97f8-549b99b7b4d1@edcint.co.nz>
 <4e2faa16-3021-4d53-9121-f41d86b428fd@gmx.com>
 <cf9db9ba-96cf-440c-8ce0-d1caf7afa1c9@edcint.co.nz>
 <09cfb22a-597c-4fbe-939f-aa10d8d461a6@gmx.com>
 <706e9108-fd37-497d-9638-44cfb64e0365@edcint.co.nz>
Content-Language: en-US
From: Matthew Jurgens <default@edcint.co.nz>
In-Reply-To: <706e9108-fd37-497d-9638-44cfb64e0365@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s02bd.syd2.hostingplatform.net.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - edcint.co.nz
X-Get-Message-Sender-Via: s02bd.syd2.hostingplatform.net.au: authenticated_id: default@edcint.co.nz
X-Authenticated-Sender: s02bd.syd2.hostingplatform.net.au: default@edcint.co.nz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Repair has been going for many hours now. I take it that even though the 
repair looks like it is repeating itself a lot, that it is expected?
>
> Sample below:
>
> [2/7] checking extents
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> metadata level mismatch on [20647087931392, 16384]
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> ERROR: tree block 20647087931392 has bad backref level, has 59 expect 
> [0, 7]
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> ref mismatch on [20647087931392 16384] extent item 0, found 1
> tree extent[20647087931392, 16384] root 5 has no backref item in 
> extent tree
> backpointer mismatch on [20647087931392 16384]
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> checksum verify failed on 20647087931392 wanted 0x97fa472a found 
> 0xccdf090b
> Csum didn't match
> metadata level mismatch on [20647087931392, 16384]
> owner ref check failed [20647087931392 16384]
> repair deleting extent record: key [20647087931392,168,16384]
> adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
> Repaired extent references for 20647087931392
> super bytes used 4955205607424 mismatches actual used 4955205623808
> ERROR: tree block 20647087931392 has bad backref level, has 116 expect 
> [0, 7]
>

Sorry to reply an old message and mess up the thread but I am having 
trouble with my mail client or my mailbox or something and I can only 
see replies in the web page archive. I can't even see messages to myself 
when I am directly addressed. Anyway, you said

"I don't think btrfs check --repair is really able to handle mismatched
tree blocks.

Thus I recommend to go "-o ro,rescue=all" mount option to salvage data
first.

Thanks,
Qu"

In reply to that:
I have already salvaged everything, so what now? Are you saying that the filesystem just needs to be rebuilt and I have to recover from backups?


