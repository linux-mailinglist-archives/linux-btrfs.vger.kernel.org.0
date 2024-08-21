Return-Path: <linux-btrfs+bounces-7359-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7DE9596AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 10:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688122822D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DC81A286F;
	Wed, 21 Aug 2024 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wpkg.org header.i=@wpkg.org header.b="M3U4nvzl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.virtall.com (mail.virtall.com [46.4.129.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798453F9C5
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.129.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227538; cv=none; b=EcvXMiSZIkYwlnFD4uKdBV+vatH+yGeSTsL9bG1mK8kVGUmUSE9yrhyMNskkDku9oiYApianfZYKvhypHBQ1rKKGEVTZJhzAfJQaWtu2zgocXLYtq1yhLSUZXxZcuySFAPs4V+2C1LV0XBuwp7oOGSgZWEYIkeMnQp2lg/yWWOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227538; c=relaxed/simple;
	bh=6NNEIuurzyrFYijvXPFwfEfSLdrGD3GRFAIE2Bcl/1k=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IY1rPZzNvB9GzDOHHxtMUlp8v+9M/Y+/7QjjoznxQS5AT5S/8sibzPkFk5Wwlf8lFEzYTxnbh/JImcBjeCf+CdeTk2iXkIUd5Z8HqUD6ngdZDYVF/vYPPdWZqUIlOaStPhFRYAB5Yaxnhj0FrZgrTul1fXGVeaMQmV9MR2Y3+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wpkg.org; spf=pass smtp.mailfrom=wpkg.org; dkim=pass (2048-bit key) header.d=wpkg.org header.i=@wpkg.org header.b=M3U4nvzl; arc=none smtp.client-ip=46.4.129.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wpkg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wpkg.org
Received: from mail.virtall.com (localhost [127.0.0.1])
	by mail.virtall.com (Postfix) with ESMTP id 23CF213F06835;
	Wed, 21 Aug 2024 08:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
	t=1724227529; bh=X0HmimLJ+/osF4JPiaRbYREYvjA1hWrf8M+ZUc6c/r4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M3U4nvzlINs100/4LqXBYwiOcxvF5lAdBbbnnEJGpsbjggZMFufrSR0c9ugYvCnVW
	 Yccls+X3lrL1LotuO9Z3tP9wDN0pptmFh4gs//2XJXg8K56Y2AlQbilIhmLPaL8RDP
	 xOSKki97bYqOZE/gwxP78399Vat2EsyitO4NnKda4V+5Tbjzso1HWdUX3lUt0XKRUM
	 O7HB0JUD3+G8W3Z75cebJaET+c0Iuhobk1P3D6b0/EfxTuIcxOi9WrTzIMs4e/8rmI
	 NfEHzOFa4yNkG7RzdPn1I6RhvL8eBB15yQMTeHDuz8DVvEFvp6SDSeYlPVg5i8+uVH
	 c3JjbmLDduhTw==
X-Fuglu-Suspect: 6558d0ac8e1c4c328c778721670e8f63
X-Fuglu-Spamstatus: NO
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
	by mail.virtall.com (Postfix) with ESMTPSA;
	Wed, 21 Aug 2024 08:05:28 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 21 Aug 2024 10:05:28 +0200
From: Tomasz Chmielewski <mangoo@wpkg.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: out of space (>865 GB free), filesystem remounts read-only - how
 to recover?
In-Reply-To: <ef2bec82-8ae1-493e-8f56-5aca164db8bd@suse.com>
References: <f11daee5026d303e673d480f3f812b15@wpkg.org>
 <6b17f157-49c3-4874-898f-68541b2dce0a@gmx.com>
 <6505eaf6b2bdaefa835944c7617d2725@wpkg.org>
 <ef2bec82-8ae1-493e-8f56-5aca164db8bd@suse.com>
Message-ID: <1084e651c874e828ba117c58e1d2211e@wpkg.org>
X-Sender: mangoo@wpkg.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-08-21 09:59, Qu Wenruo wrote:

>> System,RAID1: Size:8.00MiB, Used:2.30MiB (28.71%)
>>     /dev/sde1       8.00MiB
>>     /dev/sdf1       8.00MiB
>> 
>> Unallocated:
>>     /dev/sdc1       1.00MiB
>>     /dev/sdd1       1.00MiB
>>     /dev/sde1       1.00MiB
>>     /dev/sdf1       1.00MiB
> 
> At least one good news is, all your four devices are usage are very 
> balanced.
>>     /dev/loop0    100.00GiB
> 
> You just need to add another device to fulfill the RAID1 requirement.

So, for example, one more loop device of 100 GB?


> Then you will still need to remove enough data to get at least 1GiB for 
> two devices, then you can go balance data to free some space for your 
> metadata.


Tomasz

