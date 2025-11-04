Return-Path: <linux-btrfs+bounces-18705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AE3C3350E
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 00:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6462818C015C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 23:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2039D1FA272;
	Tue,  4 Nov 2025 23:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=friedels.name header.i=@friedels.name header.b="Trh/booP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sm-r-010-dus.org-dns.com (sm-r-010-dus.org-dns.com [84.19.1.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20662DA774
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.19.1.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297306; cv=none; b=IUNKAgnt+aKfGPR7oNQK236c4YGbG2aJsrpb/pAoxBq92TIt1VKxHlMRZ8WnKOU9776CluwXisdf8oAFNEkyw1D+Nb5cGrCzpayRca57KlA3wfgIzgmI/I66RtCPB7KLM5Ilql+sgo2DwT07SuzbWCLVXRj/k/A3PuMkMi1qaHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297306; c=relaxed/simple;
	bh=xA5AxH3M8PuHwcNdpWa5Cc92+Rpfy9basQX9vCLAnVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A5kJKTK604ISj0h7Ubkij1H0lv6OKZBHIpscMDVm08dGbupIdc/ixxMfoGNnoxTuOnT8WWBvioHhBKl6SXf3dq+NJ1FFx4Kqy5J39FSwwC4NNWo1DrvJdJxn5/2AfMnug0AJp3AH1Q5st500oAiTOGapIKAKleQq0pILVo4ZNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=friedels.name; spf=pass smtp.mailfrom=friedels.name; dkim=pass (1024-bit key) header.d=friedels.name header.i=@friedels.name header.b=Trh/booP; arc=none smtp.client-ip=84.19.1.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=friedels.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=friedels.name
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
	by smarthost-dus.org-dns.com (Postfix) with ESMTP id CB855A1795
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 23:50:08 +0100 (CET)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
	id BE9E4A17C2; Tue,  4 Nov 2025 23:50:08 +0100 (CET)
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by smarthost-dus.org-dns.com (Postfix) with ESMTPS id C81BEA1795;
	Tue,  4 Nov 2025 23:50:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=friedels.name;
	s=default; t=1762296661;
	bh=hNPIdIiuwPzKtRj5LVu7vQiHMzYHrywQVCHcscJsrNA=; h=Subject:To:From;
	b=Trh/booPB3CJl7sCc3lbT3lfBWDvLU6QUpruhm8/PoZHqcjM9BkEaww18fC+qLW+Q
	 iP0uadrGUaeJZnm5aYie70H/2pyIgoNxvEoa+syWJB5uQB95t41iFAnX7ffY6DveAr
	 r/1E+lvcTPfDvbwCEl6c3fWIgANaELhHa7y3EBk8=
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 88.65.226.178) smtp.mailfrom=hendrik@friedels.name smtp.helo=[192.168.177.137]
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
Message-ID: <eddf3273-d7f9-4bef-865d-dfec1d7ffb66@friedels.name>
Date: Tue, 4 Nov 2025 23:50:07 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Corrupt Filesystem (Mirror) despite previously successful scrub
To: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cfc7539c-a0c5-45d2-a781-89c2e0cb2c62@friedels.name>
 <12716866-2ffe-4cbb-8e2f-8b2e4abd0237@app.fastmail.com>
 <a37cea05-f77f-41f1-8763-a28311b72790@friedels.name>
 <f6858f97-1fe2-49d7-b1ad-dc688142fdcb@app.fastmail.com>
From: Hendrik Friedel <hendrik@friedels.name>
In-Reply-To: <f6858f97-1fe2-49d7-b1ad-dc688142fdcb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176229666169.1015906.3658468288478824603@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK

Hi Chris,

thanks for your reply. Indeed, I missed it.

I checked STC ERC vs kernel command timer:

SCT Error Recovery Control:
            Read:     70 (7.0 seconds)
           Write:     70 (7.0 seconds)


root@homeserver:~# cat /sys/block/sdb/device/timeout
30

That is on both drives, so it seems ok.

>> Okt 14 23:33:36 homeserver kernel: BTRFS error (device sdb1): balance: reduces metadata redundancy, use --force if you want this
> Hopefully this is a mistake and the command was not reissued with -f

It was. This is because I do not need this Filesystem anymore. But I am 
a bit worried now that I had corrupt data before.

The history:

1) I did run this as my main home-server until two weeks ago.

2) I copied all data over to another, new machine

3) I want to use these drives in that new machine as (onsite) backup

4) I do have an offsite backup

The problem is: If my data has been corrupted earlier - before two weeks 
ago - then the data on my new machine is also corrupt.

Can we find out?


> Over 2 million dropped writes on sda1? That doesn't tell us for sure they're missing, they might have gotten fixed later. But it's so many missing writes, that if there is even 1 copy wrong, corrupt, or missing on sdb1 then Btrfs can't fix itself.
This is what was causing me to be worried.
> No the file system could be inconsistent.

So, the file system would point to a wrong chunk which in itself has 
correct data and csum?

Why would not the metadata redundancy spot this? Would this be caused by 
a bug that corrupts both copies (rather than some hardware error)?

Message on outdated kernel is understood.


My main worries now are:

- what could have caused it / what can I do better in future

- was my data corrupted before I transferred it to the new machine

- is there some bug in btrfs that we could find


Thanks and best regards,

HEndrik



