Return-Path: <linux-btrfs+bounces-3572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A58788B48D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 23:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028B01F644CD
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 22:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284B880606;
	Mon, 25 Mar 2024 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="c7XvgGlg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C64D9F5
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407289; cv=none; b=XuP6xTvQY++IS++SW4332ICL8pQ419kMpJr0Gqnst9TSol0OMllKyButnPasP2hbpeoYdVrEjN09Qu+BvN7G/l9f3XPk/2RQHyJ6y8ifT0jRFcskc9nNutpFtgd2K4QkEkGvnWdAxyNWfd8jESr1RWycAA9ql25DwcxWPQbiVJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407289; c=relaxed/simple;
	bh=YVQ4dqg8r08yRCHvsSLQUq61oFv1XMRt7KqUsxG+fyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUwb3KsdhpO9l6AyDwz2jF1hJVNyV5Qra1OK3tY0tIQAsisZyijDSode9StG0tKy+0LDxmStRid49/64XwKPr9UBQt5cOwA/fJ6cNnyWcYqAGWv/LkrnV5Q10U2ORhn91GGo2sY6c/cPG0R5hT+OU13nqtU+Imwr0ELIUDByvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=c7XvgGlg; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 1A7C8827F7;
	Mon, 25 Mar 2024 18:54:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1711407287; bh=YVQ4dqg8r08yRCHvsSLQUq61oFv1XMRt7KqUsxG+fyU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c7XvgGlgeWo1KVmQ5OfM5fTbrBqMB3aOGSwbqEjUbylwcYfv8ax6Synv7dvzNPrWD
	 VZLVfjnmjIbjzjxi6LsGCBvcA30NOBu0YOCUcA15ZwYxiNUqIe42AJEWYQP65QAtaI
	 cbvrqGwa7RNOzT1hdTVCetDMLqAHiMMp7lMyJlwfqvubeSP29UF5PmATOqFoXsKNas
	 N4+BG9FeAa8GAkH18bUXQUe7pIMC463f+kCrxI3aQr3l+2IkAtusKH5irQMZLu6GiU
	 aE8vTxOcuiln8PX0dJRzpq1EFlPEvI1wFfs3oqYVv34K8FiAxeZ/Ol27xqFB/QuTVS
	 nEu2RAG3OZzCg==
Message-ID: <66e93ad4-f751-41ab-8881-a88bfb02d45e@dorminy.me>
Date: Mon, 25 Mar 2024 18:54:39 -0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: fallback to single page allocation to avoid bulk
 allocation latency
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: Julian Taylor <julian.taylor@1und1.de>
References: <9ec01e023cc34e5729dd4a86affd5158f87c7a83.1711311627.git.wqu@suse.com>
 <a4fa315e-294f-4649-9315-629648e15de3@dorminy.me>
 <3a7d64b1-f8d9-4a8f-a795-39eaaed21ab4@suse.com>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <3a7d64b1-f8d9-4a8f-a795-39eaaed21ab4@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> 
> The reporter is hitting this during compression, meanwhile no other 
> major fs (until recent bcachefs?) supports compression.
> 
> Thus I guess we have a corner case where other fses don't?

Makes sense. And since read success depends on it, it's latency 
sensitive, so I think that could be a justification if we did eventually 
want to throw GFP_RETRY_MAYFAIL in the flags.

> 
> My question is, I don't have a good reference on why we should retry 
> wait even for successful allocation.
> 
> In f2fs/ext4/XFS, the memalloc_retry_wait() is only called for page 
> allocation failure (aka, no allocation is done at all), not after each 
> bulk allocation unconditionally.
> 
> Thus I'm wondering if it's really a policy/common practice to do the 
> wait for successful allocation at all.

You make a good point. 
https://elixir.bootlin.com/linux/latest/source/include/linux/sched/mm.h#L267 
seems to indicate one should use it on every retry of mem allocation, 
but in practice it does appear that it's only done for a complete 
fialure to allocate.

 >
> 
> In that case, I'm totally fine to only call retry wait if we are unable 
> to allocate any page, other than unconditionally.
> 

Okay, I agree that that's a good plan and appreciate your discussion. I 
don't know if it's worth giving-up-and-freeing if we fail to make 
progress twice, but I don't think it matters.

Thank you very much!

Sweet Tea

