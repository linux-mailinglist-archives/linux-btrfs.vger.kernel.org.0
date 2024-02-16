Return-Path: <linux-btrfs+bounces-2450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD41857BA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 12:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CC5283106
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 11:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F7577636;
	Fri, 16 Feb 2024 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inix.me header.i=@inix.me header.b="vrQEdnd1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.inix.me (mail.inix.me [93.93.135.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E75627FF
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.135.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082970; cv=none; b=Db9b2VcEmbInHseRozRdSs57Em278BsgcW7+gf8djBco98ghewLRM2TmRAuGb864U1nrlYChjXLt3Vm/IQk/ieqxnU1+ynwKpwuYQVNfXSuCHN8a7caQBisxj7dWMvJpESum0JSsiNz06V5UXJRGG8v53yhfmG50ZCKVqMdZW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082970; c=relaxed/simple;
	bh=eLbtyVsM52ldmbdSnhslox/XLh/g/YHzooUbvIVzKO8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WlaOOZdTOSDEfhQeTBRaUw8WgDRMtQzkrGzNjj6oxmuTg5yqUjKcTan2pizYY8snlgreZUX8KyWcbiYQ8IgdpBj2xCTYFWKyjNAOntN8RHNKGSyb1RPDaWgMIBoSlxBLIPCSuqf+Fm7UZ6iPOyuTolQALh3SdEnZ0ufueroA8bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me; spf=pass smtp.mailfrom=inix.me; dkim=pass (1024-bit key) header.d=inix.me header.i=@inix.me header.b=vrQEdnd1; arc=none smtp.client-ip=93.93.135.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inix.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inix.me;
	s=primary; h=Sender:Content-Transfer-Encoding:Content-Type:Subject:From:To:
	MIME-Version:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KeFFQjVvuZD2YNR2NZYPB1RshEEoLQxU0CCv9paPhqA=; b=vrQEdnd1bDAQ+HkCFDSCMcHeWu
	YKp9O7TjWIKe5daTe3wSHdvwstP+e30fVP7FkvKv8rkLfpH83p/bO+mPNXX5vtlpSzbYxJVOLuupE
	WTSjTRqhy3nLVVdkqREN4ckqP/jFEd+BXM/FaGlp/u6M08PlwPEdTs2WjVnlPUq/NUPU=;
Received: by mail.inix.me with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.96)
	(envelope-from <dash.btrfs@inix.me>)
	id 1rawaL-00A5B0-1p
	for linux-btrfs@vger.kernel.org;
	Fri, 16 Feb 2024 11:40:53 +0000
Message-ID: <c0bf7818-9c45-46a8-b3d3-513230d0c86e@inix.me>
Date: Fri, 16 Feb 2024 16:59:20 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Dorai Ashok S A <dash.btrfs@inix.me>
Subject: incremental stream after fstrim on thinly provisioned disk file
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: dash.btrfs@inix.me

Hello All,

In a scenario where btrfs send is used to incrementally backup a thinly 
provisioned disk file, with fstrim used to discard unused blocks on the 
file, every change seems to cause the btrfs send stream to be about the 
total size of the file. This is only if fstrim was ever done.

I am able to reproduce this consistently, but I am not sure if I am 
missing something here.

# Create Disk
truncate -s +3G thin-disk && mkfs.btrfs thin-disk >& /dev/null
mkdir thin-mount && mount thin-disk thin-mount/

# Run fstrim
fstrim thin-mount

# Create Snapshots
btrfs subvolume snapshot -r $(stat --format=%m .) 1.s
btrfs subvolume snapshot -r $(stat --format=%m .) 2.s
seq 10000000 > thin-mount/76mb.file
btrfs filesystem sync thin-mount/
btrfs subvolume snapshot -r $(stat --format=%m .) 3.s

Output:-

# btrfs send 1.s | wc -c | numfmt --to=iec
At subvol 1.s
1.3M

# btrfs send 2.s | wc -c | numfmt --to=iec
At subvol 2.s
1.3M

# btrfs send 3.s | wc -c | numfmt --to=iec
At subvol 3.s
77M

# btrfs send -p 1.s 2.s | wc -c | numfmt --to=iec
At subvol 2.s
178

# btrfs send -p 2.s 3.s | wc -c | numfmt --to=iec
At subvol 3.s
2.5G

Any idea why the last incremental stream from 2.s to 3.sis 2.5GB, is 
this expected behavior?

The above test was run on debian 12 (kernel 6.1.0-18 & 
btrfs-progs-6.2-1). I am also able to reproduce it on fedora 39 (kernel 
6.7.3-200 & btrfs-progs-6.7-1)

Regards,
-Ashok.




