Return-Path: <linux-btrfs+bounces-16179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72017B2E2F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD0816AECC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 17:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715B933436A;
	Wed, 20 Aug 2025 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="wQYhRETr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488C10F2
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Aug 2025 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709595; cv=none; b=V9CmkpKVnAbv/6iGSzAubfQHZmCN9wg3QmXiYrN1WrPKmP+GCCvKEEYrdk8yqd4ZJnLvv+kUP/OYIg87Xb5fRmCLo0nw+67mz5HX9Fv41Li/A8//MJXccya+b6lMCeK0xf6cOzZrtQocOZ1l/xPF/pSP3kmbwf4715sh7n8/27A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709595; c=relaxed/simple;
	bh=fkUY3YrlnUOoHR0Wfi8lBtkHzMPzQyWy3sO0NSw2NBQ=;
	h=Message-ID:Date:Mime-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iYVjJMzobiTIRivNdek7NWwyIIIQXnK4JTc5ncRKGjnqGrAxZ2oDmCSq5SYOz4eqdTZBPZKicci2u0Sj/WRlCdHutG936UNkgaXs8Rs36Zw/qL/fzgpMWXPg2ZFsSS1PDmoh/cG5GAGpxJR2pQsXjquSWj46SmXp6pLD8EnU0CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=wQYhRETr; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from [IPV6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2] (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "hellas", Issuer "burntcomma.com" (verified OK))
	by mail.burntcomma.com (Postfix) with ESMTPS id 51C6F2AAC54;
	Wed, 20 Aug 2025 18:06:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755709582;
	bh=Ws5MylnCpRZRDWamv59ChMkbcm0d3Fjs+pb5zeYxSIQ=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=wQYhRETr8oTw4sNqjvymMwLAAApj1bXU0ml57ULPuDOCgOa0H9sT6vtzmarvtGCFD
	 DYMiFzRwso3kW7IqXLmsJ0U4KAwSdvLqIvUogKYzpt/9thOCcsDnextgPh6nKnOq9z
	 stuLTU8Hu8c+ESnoYFJ+hus40SIUvf2yAjLBPaVo=
Message-ID: <cefd585a-0934-436d-b65f-5ec729ea99f3@harmstone.com>
Date: Wed, 20 Aug 2025 18:06:22 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: Newbie questions about DIR_ITEM and DIR_INDEX design
To: Sun YangKai <sunk67188@gmail.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <12726025.O9o76ZdvQC@saltykitkat>
Content-Language: en-US
From: Mark Harmstone <mark@harmstone.com>
Autocrypt: addr=mark@harmstone.com; keydata=
 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
In-Reply-To: <12726025.O9o76ZdvQC@saltykitkat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sun,

On 20/08/2025 2.59 pm, Sun YangKai wrote:
> Hello btrfs developers
> 
> I am a beginner studying the implementation of btrfs. While examining the
> structures of DIR_ITEM and DIR_INDEX, I noticed that both store similar
> content but differ in their offset values. This led me to two questions:
> 
> 1. The offset field in DIR_ITEM is computed as a CRC32 hash of the filename. In
> practice, is there a risk of hash collisions? If so, how does the current
> implementation handle such collisions?

I think the mathematics is something like for a hash of n bits, you need
approximately 2^(n/2) instances for a 50% chance of a collision. So 65,536
filenames in this case.

If we have a collision, we append a second DIR_ITEM after the first, in
the same slot. So it'd only be an issue if you could generate enough hash
collisions to fill a 16KB leaf, but I think coming up with such a list
would be difficult enough in itself.

The collisions in /usr/share/dict/words, if you want to play around with
this yourself:

dolent, Tang
dunghill, fricatrice
accusable, aggrandizement
acarodermatitis, unfallacious
hydrotical, hylomorphist
gratillity, radiobserver
creophagist, machinability
boomdas, Loxiinae

> 2. The offset field in DIR_INDEX appears to be an auto-incrementing number,
> possibly indicating the creation order of entries within a directory. Why is
> this necessary, given that DIR_ITEM already exists?

Well, the collisions are one reason: each dentry is a directory has to have
a unique d_off value. I wouldn't be surprised if it also simplifies the
implementation of readdir.

Mark

> I would greatly appreciate any insights or references to relevant
> documentation or code snippets to help me understand these design choices.
> 
> Thank you for your time and guidance.
> 
> Best regards,
> Sun YangKai



