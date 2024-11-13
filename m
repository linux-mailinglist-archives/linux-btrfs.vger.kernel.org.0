Return-Path: <linux-btrfs+bounces-9605-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461D89C794B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 17:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A10E284B07
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 16:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B141FBF7F;
	Wed, 13 Nov 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opsone.ch header.i=@opsone.ch header.b="cCaoB8uo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.opsone.ch (mail.opsone.ch [185.17.70.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955DC1F80BB
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.17.70.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516620; cv=none; b=lZE3vj7ShvcXBi5F0gCSvJEDsg5H516TfICoE5OrPLtLGLdDeP2mxJ6CO/TJnPQhvOxQKx13u1BeWubsK0jrrRv4uBaUCiOTRXIO1slGhcyXOUFpWUn+uZZrFPwq19UUxJvQHoyfAEm3mv/FFRTkV+64BvOOuvIV6pKhHgHmjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516620; c=relaxed/simple;
	bh=uebfwi1vlkxw8yIVD6D1puZEU5V/+OoqwxucdcOPdF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrMwjT8OnmcBAsqmXXbmuSqxI2hebPo6Vb70riPsfnWkEsF1WZ+3hxFq/j/lsPcdzCSNMmevh2DDQBaBMJSGiqpiIG0tAIeErIL6QAbTJMRO65isYADpo9eLCoehmRFF3Uv6nuBbmVgskkuqvKF8iG5ijN8/xiV8QIUizO+5wRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opsone.ch; spf=pass smtp.mailfrom=opsone.ch; dkim=pass (2048-bit key) header.d=opsone.ch header.i=@opsone.ch header.b=cCaoB8uo; arc=none smtp.client-ip=185.17.70.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opsone.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opsone.ch
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB66515B8B1D;
	Wed, 13 Nov 2024 17:50:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opsone.ch; s=dkim;
	t=1731516616; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=vL2/aSBNjJ5tCri0AxPJ93K5g9JsGvekGoXzOZ2aHW0=;
	b=cCaoB8uoRSNpA7WwnMpS1loqDIHsFmAHwHfCP6T95zfrCJaKnoLaF1VfgKxUkaN6+E4qkM
	zAigDmGhFJtxxUk5Wg4Mkeadq97ggIplm0T4t9tbc2UVoAhtMArKveye/4k0PSypE9XYVP
	flHrK9roDe+1L7xafXSGHYL6GFX9llX33t1cX97D1mHKmPPCKhf4uJ72N9zpy2iHBTKXA8
	k7rBvGIeEPhHs+umKevre1cv/v4qUi93Cj3ZhwH33Ct1fZPeY2x/sCO49jxrk1AfpZRJcm
	lj3+L8stRpPNJeTSS04gF0kvxJl0tXllwrXhkpj2h+4wNrLQO0NjnhVWNn/sAg==
Message-ID: <7ea5aa7f-2591-4fd2-b07f-9c47661a8e5a@opsone.ch>
Date: Wed, 13 Nov 2024 17:50:15 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: send: fix invalid clone operation for file that
 got its size decreased
Content-Language: de-CH
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <5a406a607fcccec01684056ab011ff0742f06439.1727432566.git.fdmanana@suse.com>
 <794af660cbd6c6fc417a683bfc914bbf9fb34ab0.1727434488.git.fdmanana@suse.com>
 <42062cf0-e5fd-430f-9aff-51a4bb9ca3ae@opsone.ch>
 <CAL3q7H4ufOCatWrsMoDLCfMmZNddFirO6P+WwDBJjV3Y+=cSAg@mail.gmail.com>
From: Markus <markus@opsone.ch>
In-Reply-To: <CAL3q7H4ufOCatWrsMoDLCfMmZNddFirO6P+WwDBJjV3Y+=cSAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Am 13.11.24 um 16:01 schrieb Filipe Manana:
> On Wed, Nov 13, 2024 at 1:07 PM Markus <markus@opsone.ch> wrote:
> 
> I don't know what Debian's 6.1.0-27 matches, but upstream the fix went
> into 6.1.113, and the bug first appeared in 6.1.107.
> So for 6.1 kernels, it only affected releases between 6.1.107 and 6.1.112.
> 
> So check if that kernel corresponds to 6.1.113+, and if the issue
> still happens, run 'btrfs receive' with -vv and provide the output to
> help figure out if it's the same issue or something else.

Debian Linux Kernel 6.1.0-26-amd64 is 6.1.112. However, my problem has
just been solved with Debian 12.8 [1] released on 9 November 2024.

After the installation, I am on 6.1.115, now I can no longer reproduce
the problem with the instructions from the patch.

[1] https://lists.debian.org/debian-announce/2024/msg00008.html

> Balance doesn't make aligned extents become aligned and vice-versa (if
> so it would change file sizes and cause corruption), doesn't make
> extents that were not shared become shared and vice-versa, and doesn't
> do any changes to the extent layout of a file. So, no, balance is
> totally unrelated.

Many thanks for your explanations!

Thanks,
Markus

