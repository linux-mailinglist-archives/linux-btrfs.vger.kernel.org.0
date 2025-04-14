Return-Path: <linux-btrfs+bounces-13001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0EEA88A7B
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 19:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D995E17C1B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8869284682;
	Mon, 14 Apr 2025 17:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="Hkd4Wk0g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5482019CC0A
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653451; cv=none; b=SiFh0SpoqW9FPoXRsjaOtC7tL4eIC4uN48NzVPuYEKvFem9tvfL/RIxvpK2RKUcWxaQhhAuy7j3EaSH9GiOqZZIs621xPR+KOZcIQgTElCeDmTIxBNHW+rfoGXZfhjCflTY3Bli+PXVoEUhpY2LZcPuAdpBohwM8iHhi6mRsOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653451; c=relaxed/simple;
	bh=0HgFDxA6BkP2O8fI1Mj033dqZuvTYhWDM38jDxllJAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Jcsdo6/ebl1V4skrpLa4NeEA43PUNAQGFI0LPOhf2OUcPdjikLggtlAZeSi55ADK8Cm6Swtcxj4qXAiuIEv/ifqUy6xKr0+9Tg7k03/E3VtGt1NlbZLGhua2Cmqe9X/6TGepy9seye36VPBLPhhoTDrqqXszNyyV6j8DGYGmSzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=Hkd4Wk0g; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id 4O1AuiRK2jT0M4O1AuW9Xc; Mon, 14 Apr 2025 19:54:49 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1744653289; bh=GFaXFUP+3JSTW3pEpHl1gHpTocUF6ngEUNYhoNekmfk=;
	h=From;
	b=Hkd4Wk0gu447l02l2VUhGdMAO8do9Y74Y9ZWjGIWNcQXyHGzgOCc6L1cVOnsbFyB6
	 3otqpdY7Hb0VKk+T8qpoJ1ilN4H25La1mSowh7Vzu9DzFa0judLZm7BA+EATOqWP2u
	 HNW6FTUmm5U88f5TMXEOeUxHHymN68WWw+FHjSJXSz1mBILhkG38ZVlDeRwFtUDaJg
	 r1SVK1fn6jDiEcFXD0ehyPQyEhR+XV2Yh9kuOu8UVOJa8rhOIiit+xZR02Oouhk5lp
	 eR8ovzz9f+S4mix5o7vjeDHzc/3Q6UOHwZkDF3toP0MoLNlyzdDK7qnfHfs/xmYkMu
	 aobCiAoekCHUg==
X-CNFS-Analysis: v=2.4 cv=ffZmyFQF c=1 sm=1 tr=0 ts=67fd4be9 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=xNf9USuDAAAA:8 a=ZUCP2Ffm6_Y72WasXr8A:9 a=QEXdDO2ut3YA:10
Message-ID: <72d7150b-4e0b-4e15-bd3f-ab410be4a767@libero.it>
Date: Mon, 14 Apr 2025 19:54:48 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: P.S. Re: Odd snapshot subvolume
To: Nicholas D Steeves <sten@debian.org>
References: <dea3861ab4b85f2dffc5bbc9864b290f03c430f4.camel@interlinx.bc.ca>
 <87friais1a.fsf@navis.mail-host-address-is-not-set>
 <87cydeirkl.fsf@navis.mail-host-address-is-not-set>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
Cc: "Brian J. Murrell" <brian@interlinx.bc.ca>, linux-btrfs@vger.kernel.org
In-Reply-To: <87cydeirkl.fsf@navis.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFjZai35WDfaz4OgCRw9yPO3IURPWVGd3Fod4YVpaDTx1dNb0WwWV5gpTXPnIAMNHvAllf8TtezUObFqL3C2KPeirLc6qr56K+KMoAlJ+Af/0mpgjmas
 OA9W7/NqqBaW8ALp2XQNMxMA9c6FaHqHv4bm3vKcBTiSL0hh8niK4K/y/3c/e2mEikqd/bsEc7wfCc6+Zb9dTQhINGBKG/INi/7MYLG4LrJAS6Wh2URAY6Fn
 eHlFCHqmTjhYJ09EaexD4A==

On 14/04/2025 19.24, Nicholas D Steeves wrote:
> P.S.
> 
> Nicholas D Steeves <sten@debian.org> writes:
> 
>>> just remove it?
>>
>>    # mkdir -p /btrfs-admin
>>    # mount -o subvolid=5 /dev/disk/by-uuid/c08a988c-ddd5-164e-b01e-51ac26bf018b /btrfs-admin
> 
> Oops!  This /\ is wrong, because btrfs subvolume show / returns the
> filesystem UUID, and the command above uses the disk UUID.

I have to correct you: "btrfs sub show" shows the *SUBVOLUME* uuid, where
/dev/disk/by-uuid/XXXX refers to the *FILESYSTEM* uuid.
Apart that, it is correct that you can't take the UUID from "btrfs sub show"
to mount a filesystem. You need the UUID from "btrfs fi show"

BR

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

