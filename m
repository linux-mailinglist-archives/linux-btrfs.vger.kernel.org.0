Return-Path: <linux-btrfs+bounces-2724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9FE8627A6
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 22:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16DA282A02
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 21:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D835481C6;
	Sat, 24 Feb 2024 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="YicxPdZG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out2.mxs.au (h1.out2.mxs.au [110.232.143.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E93F9DE
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Feb 2024 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708808608; cv=none; b=m2lJZ+ZOHK8Q2LizNJmggEyG+x3RAyJaMelS439jyyZL5qDdotAKTXXXI7k0Cnb7ew8Cdd9TP3ZNwClZ2fX4LKqP0OgJzEb/Mkd9wFHC6fTp/3uutQ+SU7nSxxV5K3Tyfaq3S24nzH1PG3yeZXkJRgq7GT9QkN5z7+giCs5TLHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708808608; c=relaxed/simple;
	bh=xgnQmwWyv8Vn/JBb+KPzpSp0CJ/ITxlAHLJDkcXZYm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IXlhQ3hNItkSewGgVcGUvp9C2F4m9d7v4p4eZ+GzD4hTGWwzcarNbtrlG5rolR4c3RcxT1Cnk7k5XNCLMrpEtYrY3Oq5QqhUO1QAATUAMYmB64FWj9MH9DTSCFEncfdC12OVOGTVk5wJ0wzdcin1Zs10Nt33oCK6RP93LnkDsKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=YicxPdZG; arc=none smtp.client-ip=110.232.143.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out2.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id 21b8c496-d358-11ee-9817-00163c1ebd60
	for <linux-btrfs@vger.kernel.org>;
	Sun, 25 Feb 2024 08:03:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qiFrd2dz0uN2hztBOD1VwU0HmQMm/5KU+NSyFdzLhPU=; b=YicxPdZGpcaKnnEWA90UieE+yw
	DEhVRpCxJJ/HXqtE9x2tpUbMUyKa8QGKRb0q8f9uSfy7rFl65B86FwYs7CScIxLqojX2xB/o6oQsb
	1WZz4cqylEVjAlDWIstLK71dY+Wgl+7/jm9PAd/bF+H1jS+JFgPP+vn4BgGRZm53rBQCDuhlm1oGw
	S2m2bDAE7A8MduO6TmhfV21BcuAkYuhYYO/WEQjEQiyn2tIQFGrWoA0o7/EKUS5gOKQfBUJFGQt/U
	Kwnc9Uclm8uZ2rSyJY90vyc/lJLlPQE18eK+9RDcjA8CcRrq+G25elEH2zXI6OJVtXETNGOYPBwaL
	RLlVJwmQ==;
Received: from [159.196.20.165] (port=6941 helo=[192.168.2.2])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <default@edcint.co.nz>)
	id 1rdzAz-0028fz-04;
	Sun, 25 Feb 2024 08:03:17 +1100
Message-ID: <706e9108-fd37-497d-9638-44cfb64e0365@edcint.co.nz>
Date: Sun, 25 Feb 2024 08:03:14 +1100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Matthew Jurgens <mjurgens@edcint.co.nz>, Qu Wenruo <wqu@suse.com>,
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
Content-Language: en-US
From: Matthew Jurgens <default@edcint.co.nz>
In-Reply-To: <09cfb22a-597c-4fbe-939f-aa10d8d461a6@gmx.com>
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


>>
>> Is it safe to run "btrfs check --repair" now?
>>
>
> OK, not hardware problem, then not sure how the problem happened.
>
> You can "try" --repair, but as mentioned, you may want to run it
> multiple times until it reports no error or no new repair.
>
> Thanks,
> Qu


Repair has been going for many hours now. I take it that even though the 
repair looks like it is repeating itself a lot, that it is expected?

Sample below:

[2/7] checking extents
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
Csum didn't match
owner ref check failed [20647087931392 16384]
repair deleting extent record: key [20647087931392,168,16384]
adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
Repaired extent references for 20647087931392
super bytes used 4955205607424 mismatches actual used 4955205623808
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
Csum didn't match
owner ref check failed [20647087931392 16384]
repair deleting extent record: key [20647087931392,168,16384]
adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
Repaired extent references for 20647087931392
super bytes used 4955205607424 mismatches actual used 4955205623808
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
Csum didn't match
owner ref check failed [20647087931392 16384]
repair deleting extent record: key [20647087931392,168,16384]
adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
Repaired extent references for 20647087931392
super bytes used 4955205607424 mismatches actual used 4955205623808
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
Csum didn't match
owner ref check failed [20647087931392 16384]
repair deleting extent record: key [20647087931392,168,16384]
adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
Repaired extent references for 20647087931392
super bytes used 4955205607424 mismatches actual used 4955205623808
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
Csum didn't match
owner ref check failed [20647087931392 16384]
repair deleting extent record: key [20647087931392,168,16384]
adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
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
ERROR: tree block 20647087931392 has bad backref level, has 59 expect [0, 7]
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
super bytes used 4955205607424 mismatches actual used 4955205623808
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
Csum didn't match
owner ref check failed [20647087931392 16384]
repair deleting extent record: key [20647087931392,168,16384]
adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
Repaired extent references for 20647087931392
super bytes used 4955205607424 mismatches actual used 4955205623808
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
checksum verify failed on 20647087931392 wanted 0x97fa472a found 0xccdf090b
Csum didn't match
owner ref check failed [20647087931392 16384]
repair deleting extent record: key [20647087931392,168,16384]
adding new tree backref on start 20647087931392 len 16384 parent 0 root 5
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
ERROR: tree block 20647087931392 has bad backref level, has 116 expect 
[0, 7]


