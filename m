Return-Path: <linux-btrfs+bounces-2758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02895862D5E
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 23:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50292B21060
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 22:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A511BC36;
	Sun, 25 Feb 2024 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="HVCQ5bWz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out3.mxs.au (h1.out3.mxs.au [110.232.143.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C6F53AA
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708899180; cv=none; b=VHE2bdZjAfddgj+a4e5+kKCBz0aYm4U2I42IdW3NYJFPe6s9jBlFe3TH95J/zOmEJ72kZPiuEaoFHQ0wc8EIn89yMA1uU3Mu2X4HsBGhbWO40G52yeKIhoGlOZocJrYZMQpZURncDHAwxA9h7MHqDQJVyvoUsZJQIyw/c8q1kDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708899180; c=relaxed/simple;
	bh=/Uqg3DJ9pgzYo8aVc76pQXIHFdPI+I5vcYkiakeZ9Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=emy3mtQkkZQMriDmN5KpMakMzynhH9Rrxt8APVZIesdD041SXna4t6E+su92i0hRaCVpNmcsNI+wLsuj5NacVOp1rXlffwJvr+9JvQnGnzdHyVLnU6vwUD8oLxnJWXvOBeBpAwmw00AGEzv1tMdQlOM1OJK42EyghGIZJskQfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=HVCQ5bWz; arc=none smtp.client-ip=110.232.143.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out3.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id 00621770-d42b-11ee-990f-00163c573069
	for <linux-btrfs@vger.kernel.org>;
	Mon, 26 Feb 2024 09:12:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=I6DldoqwN70OCEVrhcia6qLcFmxmNHfsXFkymnjVjDI=; b=HVCQ5bWzDUMR+ZNFsU3jvmmxSL
	3BQAP6FOcKuskTX7I6+8kd7GJHiBOm2nnki9TvMrcNP0PnF6LHlNnk5ehzA+u4lXIYK30QLxy+s0b
	MqclzNG02MI+4ioDPyCXKzr9R8nVXZUTcFINBkyToi8n2rYEtHBKvmY9DjNErBGizd+FVW5bRv/63
	3z3BiwvaHAL+EtPgOyHYqIOszaQDhsTWvY4EDfkvsvPb+qnjOZPhwH1v+EMz2xjhNcOCU8PzwQ7h5
	Z5CT77HfQ4tS5lJLDgGkIHI8fHjPAeidur2gFmb7nO4RMc1B/hp1es6PBxQ+I1YcEEE0UoyvMqzl/
	EgTA1bQw==;
Received: from [159.196.20.165] (port=24778 helo=[192.168.2.80])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <mjurgens@edcint.co.nz>)
	id 1reMjk-004AHZ-2v;
	Mon, 26 Feb 2024 09:12:44 +1100
Message-ID: <ef994ad0-c5b7-4991-a71b-e54feb70c6e0@edcint.co.nz>
Date: Mon, 26 Feb 2024 09:12:44 +1100
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
From: Matthew Jurgens <mjurgens@edcint.co.nz>
In-Reply-To: <706e9108-fd37-497d-9638-44cfb64e0365@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s02bd.syd2.hostingplatform.net.au
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - edcint.co.nz
X-Get-Message-Sender-Via: s02bd.syd2.hostingplatform.net.au: authenticated_id: mjurgens@edcint.co.nz
X-Authenticated-Sender: s02bd.syd2.hostingplatform.net.au: mjurgens@edcint.co.nz
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
tree extent[20647087931392, 16384] root 5 has no backref item in extent tree
backpointer mismatch on [20647087931392 16384]
owner ref check failed [20647087931392 16384]
repair deleting extent record: key [20647087931392,168,16384]
adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
Repaired extent references for 20647087931392

Is it actually fixing anything?

