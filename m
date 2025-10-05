Return-Path: <linux-btrfs+bounces-17440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D95BBB9583
	for <lists+linux-btrfs@lfdr.de>; Sun, 05 Oct 2025 12:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1DDF4E2191
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Oct 2025 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F381526980B;
	Sun,  5 Oct 2025 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b="VZImS3bl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.ab3.no (mail.ab3.no [176.58.113.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA323815D
	for <linux-btrfs@vger.kernel.org>; Sun,  5 Oct 2025 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.58.113.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759660545; cv=none; b=Tix0N3NkePBQp3lktO5qbmHwA4Qk4sguEr9a8Ctd38p+nTwLVnfWleHfI25yU24pxoCUXSS6k4ll25jWecsbnn0efa5ZW6hLKusDw2DMOO3/aRWYkyp5fB6iqzEOmwdmuDwxkm2TUngj/WOmstGNtT8gNii2V7x+FVfcN6HiEK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759660545; c=relaxed/simple;
	bh=2fjQWSEUyiGJW8UyzpNDdVvkBcPIAANU3lImeJ17XjM=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=CwSQjt3LjPSVnpcbLmS1PXnRzAZTKN/HK2y8DiM3Jg0ZmKp2ZBotGKBJphCdXVmssiGpWcYpt4bSIwDIGeKoYnVh+ASaaJ6AwLaIv/ezBf0YMDLnR//lDyOWzNwBPMbYASL7ycRzXtMsCi881mZDelGorIbTGhwQC/KZVo8B65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ab3.no; spf=pass smtp.mailfrom=ab3.no; dkim=pass (1024-bit key) header.d=ab3.no header.i=@ab3.no header.b=VZImS3bl; arc=none smtp.client-ip=176.58.113.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ab3.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ab3.no
X-Virus-Scanned: amavisd-new at ab3.no
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ab3.no A16984DAB20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ab3.no; s=default;
	t=1759659958; bh=2fjQWSEUyiGJW8UyzpNDdVvkBcPIAANU3lImeJ17XjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VZImS3bl41r9X7maeLghlwdju5RCq/3cZcwNVcU4Bh/YSZA1umyfsVUtEda1+ZkBN
	 fY4YiDETR6Q8sqydi5RV8sI4FKdVt9rHpRZLREZ0F0DpvxcC/VKbk6dkY+jYp0n6WW
	 guKyTd6l31Sv39PfV3r6whzb5JAx9I6VkcJwjvqM=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sun, 05 Oct 2025 12:25:56 +0200
From: Mads <mads@ab3.no>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, jth@kernel.org
Subject: Re: BTRFS critical (device sda): bad key order, sibling blocks, left
 last (4382045401088 230 4096) right first (4382045396992 230 4096)
In-Reply-To: <6ced26e8-ffae-488f-b910-f332f1190430@wdc.com>
References: <c00b7f69-6a21-455b-aab2-dafcd1194346@ab3.no>
 <6ced26e8-ffae-488f-b910-f332f1190430@wdc.com>
Message-ID: <1686db22f997609b3cbdc3923a1e9a5b@ab3.no>
X-Sender: mads@ab3.no

On 2025-05-05 11:25, Johannes Thumshirn wrote:
> On 05.05.25 11:00, Mads wrote:
>> Hi!
>> 
>> Tested out creating a raid1 with raid stripe tree enabled on 6.14.5
>> (aarch64):
> 
> Thanks for the report.
> 
> Please be aware RAID stripe tree is an experimental feature and should
> not be used in production yet.
> 
>>> # mkfs.btrfs -d raid1 -m raid1 -O raid-stripe-tree,raid56 /dev/sda
> 
> Out of pure curiosity, why raid56? It's not supported with RST yet. I 
> do
> have a prototype but that's only supports full stripe size writes yet.
> 
> [...]
> 
>> You can find the complete dmesg here:
>> http://cwillu.com:8080/92.220.197.228/1
> 
> Thanks a lot, I'll see if I can come up with a minimal reproducer for 
> it.
> 
>> I don't know if this is related to enabling raid stripe tree, or
>> something else.
> 
> Yes this is a RAID stripe tree bug and I thought I had it fixed 
> already.
> Apparently not.

Just thought I should check in on this - do you remember if there's been 
any work done on RST that might do something about this bug? I haven't 
updated the kernel since I reported this, so I just thought I should 
check in and hear if there's any point to testing out a new kernel or 
not.

- Mads

