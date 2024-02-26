Return-Path: <linux-btrfs+bounces-2763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F082866959
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 05:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE601F24E3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 04:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97A61AACC;
	Mon, 26 Feb 2024 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="QETQo5S5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out3.mxs.au (h1.out3.mxs.au [110.232.143.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A9E4C91
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 04:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921533; cv=none; b=LQ0B5kIrW37405fvjrbdDZOM85hZ4RzmFOgrSTEsPNon/IS9cU/dG36dHXPvChGlMrICwHG9pj5N94/uGvv2hC9WPZO6An3yTCyA2vbKv4Xg+UzI4xNP2jWRD3rzlrDoedvZKWFodrshpUaxkT+lAwVIAtA73iIc/I/5qcJsXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921533; c=relaxed/simple;
	bh=qJy06pm/9/HSGTwKX+FgoEZaEoDuKxUQCqiZ2jdKg48=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lMzdSr2WRPepLu97sj/gaL9gvRMtqBEjhu7ZP5xBJvb94dozVsUJ2odCSvxNOlnV2di7uxjxcuSWd/jmNXQCq0H00j3Ny073JEjEEW5P491CL1SbYsiEVpgswhmOq5Nyjmya2IdYEdYVCxOwWN5AIDJo+cZbycoU1otucswY1Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=QETQo5S5; arc=none smtp.client-ip=110.232.143.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out3.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id 0e736899-d45f-11ee-990f-00163c573069
	for <linux-btrfs@vger.kernel.org>;
	Mon, 26 Feb 2024 15:25:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9nian9Po1+R1eKYM2Es8zBkhAxERiYjQxJLyriu7qfo=; b=QETQo5S5noNEtNLmRctcrQTFmN
	jFKPzfEUWdmbnP7KbmdLfUFPrteiW1XQRltaWGhgudPi0yNu5Vpg4POBSpc1oxRijk8pRNbPG9Nuh
	ZBiTc1UBbM1dNIYTZCyvr+ehnxn/F1KdcVsIs71aD2fQPT7u0hdMehWCrHvVlTnv5alYwnYLfboIp
	dePqc0pypWISiCtoAu0zqKsiLij69IEo69KG9nc5kHQAJqQCBsJcIigDC2tLCL2aNVGglv0JlLtOb
	oQ/np0XYNQjhqr5yOgGUiHcK902pwTHF1v4GERUEN/mU1aPzHQrPvX9BcYMPTu+v5liF7vvnefjAB
	Z/2dSOhA==;
Received: from [159.196.20.165] (port=10871 helo=[192.168.2.80])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <default@edcint.co.nz>)
	id 1reSYM-002fDP-15;
	Mon, 26 Feb 2024 15:25:22 +1100
Message-ID: <ad42e7ca-ff37-443f-8469-bec718ba6b80@edcint.co.nz>
Date: Mon, 26 Feb 2024 15:25:21 +1100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
Content-Language: en-US
To: Matthew Jurgens <default@edcint.co.nz>, Qu Wenruo
 <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
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


On 25/02/2024 8:03 am, Matthew Jurgens wrote:
>
>>>
>>> Is it safe to run "btrfs check --repair" now?
>>>
>>
>> OK, not hardware problem, then not sure how the problem happened.
>>
>> You can "try" --repair, but as mentioned, you may want to run it
>> multiple times until it reports no error or no new repair.
>>
>> Thanks,
>> Qu
>
>
> Repair has been going for many hours now. I take it that even though 
> the repair looks like it is repeating itself a lot, that it is expected?
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
The repair completed after about 36 hours. I started another one

It seems to repeat itself a lot and, if I pick one specific example, 
this line is still appearing in the 2nd --repair run

"ERROR: tree block 20647087931392 has bad backref level, has 227 expect 
[0, 7]"

The exact same line appeared 28 times in the first run

Here is a sample extract:

Repaired extent references for 20647087931392
super bytes used 4955205607424 mismatches actual used 4955205623808
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
Csum didn't match
metadata level mismatch on [20647087931392, 16384]
owner ref check failed [20647087931392 16384]
repair deleting extent record: key [20647087931392,168,16384]
adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
Repaired extent references for 20647087931392
super bytes used 4955205607424 mismatches actual used 4955205623808
ERROR: tree block 20647087931392 has bad backref level, has 227 expect 
[0, 7]
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
Csum didn't match
ref mismatch on [20647087931392 16384] extent item 0, found 1
tree extent[20647087931392, 16384] root 5 has no backref item in extent 
tree
backpointer mismatch on [20647087931392 16384]
owner ref check failed [20647087931392 16384]
repair deleting extent record: key [20647087931392,168,16384]
adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
Repaired extent references for 20647087931392

Is it actually fixing anything?

