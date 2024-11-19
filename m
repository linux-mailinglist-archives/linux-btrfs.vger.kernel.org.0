Return-Path: <linux-btrfs+bounces-9767-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579759D313F
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 01:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A55CB24F3F
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 00:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADD31C6F55;
	Tue, 19 Nov 2024 23:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b="j2kSXUHX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from h1.out4.mxs.au (h1.out4.mxs.au [110.232.143.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4281C3F0E
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=110.232.143.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732060776; cv=none; b=iiJ5O9/aZ389Yc64ZyyZQEv0eS81MM5swXBScvllLrNkkgRMIISLjI1W6tgWUj1mwcZ/Wm+S+sDfJbjQ3PVb+fu2tD0eVOeVpMbmHTmn6d2nTn74OI9tXuPJZyUh7DkitueemAtqj8wE5gq/bOetl06cTMcNXg2g/DWW2CSRYdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732060776; c=relaxed/simple;
	bh=A8YX4g9zb1Z8kn2cqV39s5LplD7/OH0q6XnucOqwKno=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=afqzdH1ZXU/BENcw5za2AABIcAGDNn57f9dCGXxk4YMi1zC/PR4qzjFyFX95xwgQax64wKqmgAis18bJVa2zgqd/znjwIy1QBK52esa4UyTnHxp40OMLURuhIkhcT2/4LQIOzIjFlbK95XkZa/kuE2aEXL41wZROK/z9i4jHVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz; spf=fail smtp.mailfrom=edcint.co.nz; dkim=pass (2048-bit key) header.d=edcint.co.nz header.i=@edcint.co.nz header.b=j2kSXUHX; arc=none smtp.client-ip=110.232.143.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edcint.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=edcint.co.nz
Received: from s02bd.syd2.hostingplatform.net.au (s02bd.syd2.hostingplatform.net.au [103.27.32.42])
	by out4.mxs.au (Halon) with ESMTPS (TLSv1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	id 26fea2f2-a6d2-11ef-991c-00163c87da3f
	for <linux-btrfs@vger.kernel.org>;
	Wed, 20 Nov 2024 10:58:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=edcint.co.nz; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4jQXdPBZSpoAiWhmwrwclU6dK8ESLGFenPDmAIW7Be4=; b=j2kSXUHXE6n/xVjCrFjopO8iAg
	lEKnMDDmc6F0klnqsFlIpxZGOkA55X71t3j6vut3dVIVjsTgAN+qEbskRynP3g+XvSPVZhMCKLLtX
	AklutWpYuW2WgX5Rteeqg2Ix1Mh3/1MtGwly/dojSBPkpGQSjDBe1wcuiosglYHfmX+TP3qN6yBRW
	lxJEk7oSO283GgHeBWcgAkqLD0SB7h9AzjxoOazgH1rAJJlYPd+JiYf6vSnFPwk5ymRAOz7MWC2Lp
	TB7idojVgvMUuXDwFy5VdNwd/PoC9xCKQVOTDWFZn5NMyvFS+jamIuloh8QdZGWnbQn6qZ1nTN75s
	ECgRbakQ==;
Received: from [159.196.20.165] (port=49635 helo=[192.168.2.80])
	by s02bd.syd2.hostingplatform.net.au with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <btrfs@edcint.co.nz>)
	id 1tDY6t-003nd8-2Z;
	Wed, 20 Nov 2024 10:58:19 +1100
Message-ID: <540bdbc7-5aa3-4e19-a0f2-4a817eb7cd71@edcint.co.nz>
Date: Wed, 20 Nov 2024 10:58:19 +1100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mount forced read only
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <e011fe62-5ac4-46d5-82fc-bc9e508f546a@edcint.co.nz>
 <3fc3f378-b241-4f34-9101-542ddb4e1a27@gmx.com>
Content-Language: en-US
From: Matthew Jurgens <btrfs@edcint.co.nz>
In-Reply-To: <3fc3f378-b241-4f34-9101-542ddb4e1a27@gmx.com>
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
>> Is there a likely cause for the error?
>
> So far it looks like random memory corruption.
>
> What's your kernel version? And more specific, is this an AMD laptop?
> Recently there is a known regression of amd_sfh module that corrupts
> random memory ranges:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=2314331
>
> If so, please either blacklist that module or just update the kernel (I
> guess you're also using Fedora?)
>
>
I am on kernel 6.11.7

I ran a memtest and it found one error in the first 5-10 minutes. I 
guess that is the culprit.

I will look to replace the RAM


