Return-Path: <linux-btrfs+bounces-7361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A4C9598E0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 13:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770BA1C20F9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C81F3768;
	Wed, 21 Aug 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wpkg.org header.i=@wpkg.org header.b="CQoNj01u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.virtall.com (mail.virtall.com [46.4.129.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2001F3742
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.129.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232678; cv=none; b=BQZuaVICSHKExV/ftYrirKx6zl5rcOs7PyN9Nkci4r/jZesCM7oMBnmXXtzPd6GFtHKQPpetGN7oUMmR7yeO17ESKUxCqvXeeSw1VRl9PrFcqEZ9+G1wXduo88uI2Xost+W2sYwPLynGLApD1Pw5rgUkVSVLKn9tSphlL0Jg7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232678; c=relaxed/simple;
	bh=hxa5/Sao790xGBKeFWYpad3P2ENUIVDTh2lRIlwYBZ8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sQmYhoc3Cu2GtHGPubq2mOy6Z/1p9GgC3IE7l0+pRFCXzT7oSYyLSF7eqjXIFI+AWu6jWRUxcDP45FrRDSkNhPBQpjYlKeZ0bTLdOpuzUHQLglZg6v2i8bok+Tsmmyv9MSZPrHBzjNSXcUt7RuCnZInuq9wMryAfLaaouyN3izk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wpkg.org; spf=pass smtp.mailfrom=wpkg.org; dkim=pass (2048-bit key) header.d=wpkg.org header.i=@wpkg.org header.b=CQoNj01u; arc=none smtp.client-ip=46.4.129.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wpkg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wpkg.org
Received: from mail.virtall.com (localhost [127.0.0.1])
	by mail.virtall.com (Postfix) with ESMTP id 5C5AB13F06C1A;
	Wed, 21 Aug 2024 09:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
	t=1724232672; bh=h+eA8ZKfHB+1SBGmcAKCl8gh+jlXWYALYysVOjKE4ag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CQoNj01uLEqHE7W1RH9KSdwhUKOIa+KhKQoBz2BYlxZtw3lhJniTIIUPmp9DALIJf
	 LcRINndQCoANp07/9gQ5BWd0WNsb8gRQB+DKUbW6jClXxJ3zKPMmD2HLmwBVN85voG
	 +ZSsDdtYeEt4f0YOhecv5hz6vHExvXg3YvfozM7D13Pv4AnQKOsynqRs+MGHgFmle6
	 odjOBezMEM32EIQNZxkJVqFw9XVgZaXVsIKZpC4RmqtDIeOFscldEVRFGk1p9r1vOR
	 YVQ2Yxs68ZWrzWg6FN6rL0QTAQ0AlFwd+mFwwigkyYEhuM/1pY3+YjaW7IxtaMTbAA
	 HgkDMWpGQQe8A==
X-Fuglu-Suspect: d9a1b62efe3e4b7aab566dcdf977e4da
X-Fuglu-Spamstatus: NO
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
	by mail.virtall.com (Postfix) with ESMTPSA;
	Wed, 21 Aug 2024 09:31:11 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 21 Aug 2024 11:31:11 +0200
From: Tomasz Chmielewski <mangoo@wpkg.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: out of space (>865 GB free), filesystem remounts read-only - how
 to recover?
In-Reply-To: <4d281726-0156-4b56-aa7a-399d8fb1c4da@suse.com>
References: <f11daee5026d303e673d480f3f812b15@wpkg.org>
 <6b17f157-49c3-4874-898f-68541b2dce0a@gmx.com>
 <6505eaf6b2bdaefa835944c7617d2725@wpkg.org>
 <ef2bec82-8ae1-493e-8f56-5aca164db8bd@suse.com>
 <1084e651c874e828ba117c58e1d2211e@wpkg.org>
 <4d281726-0156-4b56-aa7a-399d8fb1c4da@suse.com>
Message-ID: <ff1ccaf1ec63b997d4d224c161508a97@wpkg.org>
X-Sender: mangoo@wpkg.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-08-21 10:08, Qu Wenruo wrote:
> 在 2024/8/21 17:35, Tomasz Chmielewski 写道:
>> On 2024-08-21 09:59, Qu Wenruo wrote:
>> 
>>>> System,RAID1: Size:8.00MiB, Used:2.30MiB (28.71%)
>>>>     /dev/sde1       8.00MiB
>>>>     /dev/sdf1       8.00MiB
>>>> 
>>>> Unallocated:
>>>>     /dev/sdc1       1.00MiB
>>>>     /dev/sdd1       1.00MiB
>>>>     /dev/sde1       1.00MiB
>>>>     /dev/sdf1       1.00MiB
>>> 
>>> At least one good news is, all your four devices are usage are very 
>>> balanced.
>>>>     /dev/loop0    100.00GiB
>>> 
>>> You just need to add another device to fulfill the RAID1 requirement.
>> 
>> So, for example, one more loop device of 100 GB?
> 
> Yep.

It worked, thank you!


Tomasz

