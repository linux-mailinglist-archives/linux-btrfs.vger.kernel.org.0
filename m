Return-Path: <linux-btrfs+bounces-18750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F368C38E29
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 03:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E83B6054
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 02:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7A71F1513;
	Thu,  6 Nov 2025 02:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="tF3UjDfl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CAF19D07E
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396659; cv=none; b=bHuH/o6fnp/Dwi/SqxdWjbYLRa+5Gt2YqwXAVQwdfqkHGryJ7kZW1OAwz9MEUUA53ecrvBojsUXIRkMya2ka185NHyhz7ScVjoD9hftm0GKV+M8w65kjJGMg4AfG9rixFA30TWp/WWMyZJjd1L71PT7BZ+4VqVH6qT5NheHyxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396659; c=relaxed/simple;
	bh=84yVhO4YOwy7McOUfNihgVUCDl1jZUc8MXppenE6hH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhrFIqcvcYjFBX57VaEzlNvbg81CR4m9YRTaoPZo16vxVxhn0ZbIfw11Y65LnPNsMEQF/fjAYZZ021gZDUeh4BjtDkTRX/fhuwloO3MnvXZjJCQpW0Q5Apg3sfQ7c9Mwb9MR3s1MIY9hN6MqzELPePtZcaU6QELT3jLvAMaWaWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=tF3UjDfl; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762396651;
	bh=swnUrd0MeXSi9bZIvDS2KXEraWlxYd+GnPUoFbIY99o=;
	h=From:Subject:Date:Message-ID;
	b=tF3UjDflxvvKtuR7Fp225dLcOpmwb6u5lR7/Xb05DeovOvtlCCd1DCAx+RmdwLBQx
	 ZonMQlVu1lEGSYqMj7JcECacj1CtFkxfuGKLdY3p9lY0aN3C2DW/CxpShFvHV7BUpO
	 G9qiQWXPBmksJHI9QJEpUXJ+AG5dGnlvsXXTdaTo=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 690C095500000D97; Thu, 6 Nov 2025 10:35:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5734166816353
X-SMAIL-UIID: 1F066F0A0E2B4467A1ADB457BFC95624-20251106-103503-1
From: Hillf Danton <hdanton@sina.com>
To: Qu Wenruo <wqu@suse.com>
Cc: Calvin Owens <calvin@wbinvd.org>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [QUESTION] Order-4 allocation failures on reads with 256bit csums
Date: Thu,  6 Nov 2025 10:34:51 +0800
Message-ID: <20251106023454.8888-1-hdanton@sina.com>
In-Reply-To: <0f137e3f-7b9b-4fbe-a8f7-2c90dad1a5fc@suse.com>
References: <20251105180054.511528-1-calvin@wbinvd.org> <cc115783-7b1c-4196-a06d-08008277141c@suse.com> <0f137e3f-7b9b-4fbe-a8f7-2c90dad1a5fc@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thursday 11/06 at 07:31 +1030, Qu Wenruo wrote:
> 在 2025/11/6 07:24, Qu Wenruo 写道:
> > 在 2025/11/6 04:30, Calvin Owens 写道:
> > > Hello all,
> > > 
> > > I'm seeing order-4 allocation failures reading from btrfs filesystems
> > > with blake2b/sha256 checksums, on a couple different machines.
> > > 
> > > I don't think I'm doing anything interesting: in both cases they were
> > > idle except for a single-threaded file reader doing buffered I/O. The
> > > first one was an x86 QEMU VM, the second was a raspberry pi 4b (below):
> 
> Another thing is, although the order 4 allocation is indeed large, it's not
> that unreasonable large.
> 
> The problem is still that we're requiring physically contiguous range which
> greatly reduce the chance to get one.
> 
> Another point contributing to this is the order 4, which is beyond the
> PAGE_ALLOC_COSTLY_ORDER (3), thus no more retry is done thus can fail here.
> 
And the flag GFP_NOFS, though correct, in this report that makes any high order insane.

> In fact for your aarch64 case, you can configure the kernel to use 64K page
> size and in that case such allocation will only be one page thus will almost
> never fail.
>
> This leads to my final question, what's the memory size of the RPI4 and your
> qemu VM?
> My guess is there is a very limited amount of memory (1GiB?), but still a
> lot of large buffered IOs.
> I guess enlarging the VM RAM size will hugely reduce the chance of memory
> allocation failure.

