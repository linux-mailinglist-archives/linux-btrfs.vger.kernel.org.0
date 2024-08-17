Return-Path: <linux-btrfs+bounces-7301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835A99554CC
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 04:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D289E283FD3
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Aug 2024 02:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F51B79DE;
	Sat, 17 Aug 2024 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b="ehcKSzyJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zero.acitia.com (zero.acitia.com [69.164.212.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704313D66
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Aug 2024 02:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.212.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723860700; cv=none; b=TRQ5cOWGnvz57zqcv1w8ZlrJv0LHGUCq88LxhokOHe6YPGpWt0m5TNj9CfoytY+AM+S+cjGc8pCbMisAziB98qIt8L585sEqm2XHQ7BPEYahyb84RluB9S90zxLklxNq3d+e0TbjKK6vxdyn7GWSoZwGFtkKGyg7iZdz3AqDWds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723860700; c=relaxed/simple;
	bh=RKQiKD7dQfOWBCbjaYGJPN022hVrGqi7+GPG9PKpQMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ewiSeNLIGCjO60mHNBxJUvPIrhFSKCFUyrtKpA5rcqsqsKj23pxdodNPi/MkrONYNMZTnAc/rbJfd9DtJAfrItBEPHPOWQG+W4uduhxObbNB6Ybs1OHIx+/2txBNG4OrvqX7phHpKjGw+Ege74ck1XkjTcs7Js+LLLGTBF+d4Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com; spf=pass smtp.mailfrom=zetafleet.com; dkim=pass (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b=ehcKSzyJ; arc=none smtp.client-ip=69.164.212.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetafleet.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zetafleet.com; s=20190620; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F1W3h3YMMrLnYgEDKf3n20Oy7t6W/pznY0aEA1KwDbE=; b=ehcKSzyJncGVv2TugW7sbkrd8t
	Is+TUSO9DxrEoi45+3ObH92b8CRgAKQ4291lIIrtGqj+Hx4zpzBddBmydZNDeku9HemvhWLkl7Kf9
	gg852GqstDf22L634oLyspslbKoWhJthKSyDnz6SF3h0H1fXlNO/32aWrg7VcuFF+4OWJRJu+c9a5
	cit6pRseTmj3QKAHoR72fGP9WRqJ+F2ETACCRE6LgDfgYwB6qqxhDQlBAaFU4v21Y5YJXQ3Z12FlM
	YODRXlzWT/q/LylEPkE2P/k3dRbomPTvJryaqUrKGb96QGOn3ymotzfcXX+ki1uDFlluPlhClbPHa
	TjQGyNug==;
Received: from authenticated by zero.acitia.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(envelope-from <linux-btrfs-ml@zetafleet.com>)
	id 1sf8uf-0000tx-NL
	for linux-btrfs@vger.kernel.org; Sat, 17 Aug 2024 02:11:31 +0000
Message-ID: <77d9d082-2d7f-41a7-a546-0dad8c1bbc78@zetafleet.com>
Date: Fri, 16 Aug 2024 21:11:29 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-transaction generates high disk write
To: linux-btrfs@vger.kernel.org
References: <CA+Zc76WnsF2jZn35tAhtdqapem5W3bJeHd17SZ4dsRHCf1bxHw@mail.gmail.com>
 <b2fa9121-5af3-45d8-a31a-787acef0979a@gmx.com>
Content-Language: en-GB
From: Colin S <linux-btrfs-ml@zetafleet.com>
In-Reply-To: <b2fa9121-5af3-45d8-a31a-787acef0979a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.9
X-Spam-Report: No, score=-1.9 required=5.0 tests=BAYES_00=-1.9,NO_RELAYS=-0.001,T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no version=3.4.2

On 16/08/2024 17:49, Cody wrote:
>> The process btrfs-transaction generated 440MB writes within 3 hours on
>> an idle machine running only the "iotop -a" command in a Bash shell.
>> On another occasion, it generated 4.86GB (gigabytes) a day. Is this
>> level of writing beyond normal? Does that hurt NVMe lifespan?

It does not sound like a totally crazy number to me, but I am basing 
this on my personal btrfs experience with total disk writes rather than 
just the btrfs-transaction process. Snapshots during idle time on my 
workstation are usually between 50–100MiB/hr, which excludes caches. My  
average writes is ~4GB/hr according to the SSD firmware (Data Units 
Written divided by Power On Hours. Note that some SSD firmware do not 
count POH in low power state, so if POH seems too low for the SSD age, 
guesstimate based on the date the SSD entered service instead).

All writes hurt NVMe lifespan but question is whether it really matters 
to you. Start by checking TBW endurance rating of your drive and then 
extrapolate whether it will run out before you plan to replace the 
computer. For example, with my current workload, I expect my drive will 
need replacing in about 46 years due to write wear, so I don’t worry too 
much about it. :-)

You may consider mounting with noatime instead of relatime to cut down 
even more on metadata updates before making any other change as it is 
reversible and highly unlikely to break anything ever.

On 16/08/2024 18:15, Qu Wenruo wrote:
> If this behavior bothers you, I would recommend to make the firefox user
> directory $HOME/.mozilla and the systemd-journal directory to have NOCOW
> flag set, or even set systemd-journald to run in volatile mode.

As someone who just went through some unnecessary drama because systemd 
enables No_COW by default on its journal directory, I would suggest to 
include a reminder that No_COW implies nodatasum when advising random 
users to enable it.

Also, the chattr documentation has this ominous note:

 > Note: For btrfs, the 'C' flag should be set on new or empty files. If 
it is set on a file which already has data blocks, it is undefined when 
the blocks assigned to the file will be fully stable.

I have no idea what “fully stable” means, but it doesn’t sound good.

Best,

