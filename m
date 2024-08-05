Return-Path: <linux-btrfs+bounces-6975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03B99474D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 07:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99E7528155C
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 05:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43794143888;
	Mon,  5 Aug 2024 05:49:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ekdawn.com (mail.ekdawn.com [159.69.120.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF816D53B
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.120.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722836952; cv=none; b=T9wjE0b3PVDtGLcST9cVq0heI5yPhnzMF5XwQp5XxiP9n17hmyA+K9PaHVaOvlPrd62QlItd4vzBJv4ue4/FzyxighVSt3g+NH2R2pqzRB3m23adsxBVolw0Tmxm/+KTeClIfdT2ZCHawW0/wxD1yq8+Kd7VMZm9UXxlYVU/10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722836952; c=relaxed/simple;
	bh=HA2vIXW39YanMb0xayg7lCjlbcGLqXb3w47pte/u2jA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=KyFUvxRnmAVqOnnExsA6IMzc9kJYo3cuHWnxnJA5ZMiqW5GoYFt3yZlLWQb28TBuFKvuiMAXKPJc5zdkQi88254Hl5Pqh2DnMAyOmRjhtE6KPb2GHNn/g3WDZzUIWSn5ct/+vjpsfnLzLvzKC7w2SWHFVcSMeXTf88FvC1Fyh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=mail.ekdawn.com; arc=none smtp.client-ip=159.69.120.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ekdawn.com
Received: from [10.42.0.125] (dynamic-176-003-136-062.176.3.pool.telefonica.de [176.3.136.62])
	by mail.ekdawn.com (Postfix) with ESMTPSA id 75818180689
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 05:39:19 +0000 (UTC)
Message-ID: <9b4f0e79-6e77-48a4-b87d-b27454ffb399@horse64.org>
Date: Mon, 5 Aug 2024 07:39:20 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: ellie <el@horse64.org>
Subject: btrfs corruption issue on Pine64 PinePhone
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear kernel list,

I'm hoping this is the right place to sent this. But there seems to be a 
btrfs corruption issue on the Pine64 PinePhone:

https://gitlab.com/postmarketOS/pmaports/-/issues/3058

The kernel is 6.9.10, I wouldn't know what exact additional patches may 
be used by postmarketOS (which is based on Alpine). The device is the 
PinePhone revision 1.2a or newer 
https://wiki.pine64.org/wiki/PinePhone#Hardware_revisions sadly there 
doesn't seem to be a way to check in software if it's 1.2a or 1.2b, and 
I don't remember which it is.

This is on an SD Card, so an inherently rather unreliable storage 
medium. However, I tried two cards from what I believe to be two 
different vendors, Lexar and SanDisk, and I'm seeing this with both.

The PinePhone had various chipset instability issues before, like
https://gitlab.com/postmarketOS/pmaports/-/issues/805 which I believe 
has however been fixed since. I have no idea if that's relevant, I'm 
just pointing it out. I also don't know if other filesystems, like ext4 
that I used before, might have also had corruption and just didn't 
detect it. Not that I ever noticed anything, but I'm not sure I 
necessarily ever would have.

Regards,

Ellie


