Return-Path: <linux-btrfs+bounces-6976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6174B9474E8
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 07:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E687281593
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 05:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F260143C6C;
	Mon,  5 Aug 2024 05:55:40 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBB21109
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 05:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722837339; cv=none; b=R8Ag34D897baZ2jJcdEM/ku6vFbM1r5P/dEkqXAvbWuBAQ/su15BbjJfBHqYfdGF+k7vmOpu+KAAHtLixSFvB8fQ/Y1Y4bKnD3472B8nHs6DBwFQkFXSZvgwmYL2jV42nIoUC6MzGLk2K0/MmBNMPnMvH2OsXcqgJmG18dzQliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722837339; c=relaxed/simple;
	bh=9Iz0z/WP64pPYBSnNhcUAB982woTtcmvad3kMfPNlKo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=czLTw7KMRpuA4z0ibUlgIvWdYRmbdwUViIAH2kMLabRrtL0aU+Sc09C7Gwo3IawnJsFhacCR7o/cLGSN2BhPzo0kDQINOH66Jv2+vdijs75/3f/8YrhiAsvWlBvOMabA8mxnUkGDp+SC9uoI4s2YhsaoTjqHQcQKyJJ3S47+/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=mail.ekdawn.com; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ekdawn.com
Received: from [10.42.0.125] (dynamic-176-003-136-062.176.3.pool.telefonica.de [176.3.136.62])
	by mail.ekdawn.com (Postfix) with ESMTPSA id D062B180689
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 05:55:33 +0000 (UTC)
Message-ID: <b9103729-c51a-487f-8360-e49d3e9fc5e4@horse64.org>
Date: Mon, 5 Aug 2024 07:55:35 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs corruption issue on Pine64 PinePhone
From: ellie <el@horse64.org>
To: linux-btrfs@vger.kernel.org
References: <9b4f0e79-6e77-48a4-b87d-b27454ffb399@horse64.org>
Content-Language: en-US
In-Reply-To: <9b4f0e79-6e77-48a4-b87d-b27454ffb399@horse64.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 07:39, ellie wrote:
> Dear kernel list,
> 
> I'm hoping this is the right place to sent this. But there seems to be a 
> btrfs corruption issue on the Pine64 PinePhone:
> 
> https://gitlab.com/postmarketOS/pmaports/-/issues/3058
> 
> The kernel is 6.9.10, I wouldn't know what exact additional patches may 
> be used by postmarketOS (which is based on Alpine). The device is the 
> PinePhone revision 1.2a or newer https://wiki.pine64.org/wiki/ 
> PinePhone#Hardware_revisions sadly there doesn't seem to be a way to 
> check in software if it's 1.2a or 1.2b, and I don't remember which it is.
> 
> This is on an SD Card, so an inherently rather unreliable storage 
> medium. However, I tried two cards from what I believe to be two 
> different vendors, Lexar and SanDisk, and I'm seeing this with both.
> 
> The PinePhone had various chipset instability issues before, like
> https://gitlab.com/postmarketOS/pmaports/-/issues/805 which I believe 
> has however been fixed since. I have no idea if that's relevant, I'm 
> just pointing it out. I also don't know if other filesystems, like ext4 
> that I used before, might have also had corruption and just didn't 
> detect it. Not that I ever noticed anything, but I'm not sure I 
> necessarily ever would have.
> 
> Regards,
> 
> Ellie

I forgot to specify one testing detail: testing this seems to require 
writing a couple of gigabytes to the SD Card. So that's an additional 
difficulty, since I assume doing that too often will simply kill the 
card for real, which limits how quick and often this can be tested.

Regards,

Ellie


