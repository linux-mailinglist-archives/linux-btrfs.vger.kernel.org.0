Return-Path: <linux-btrfs+bounces-1172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68012820C32
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Dec 2023 18:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C051F21AA8
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Dec 2023 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C398F6A;
	Sun, 31 Dec 2023 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="vOKuWTbv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3E58F42;
	Sun, 31 Dec 2023 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 419BF80A59;
	Sun, 31 Dec 2023 12:26:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1704043620; bh=rBePiq3m19xLDYg1NFE6jjWigazxJvjaHtlPnRE8KQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vOKuWTbv1uVpzjAVEcMw8DcLgEbWU3WJmkaVOO7tr8HLtA55nKeK2ACIhRU541JT/
	 6+a2Kn2wuBlI19NsYzCdD5n0YdhORpAluSGO9jUJ49JzJWA1ZH8RccCakllvPPFRc8
	 tcsz3zlHPCw2KZnz8d5AvjsVrQ5mvgEC/ciziHN36ClgzbLDKmjjPt2+T+8V0f0Uid
	 LqlFoSOLDKGs/D1yMMBgrBnOVjYA8E669Wqo5zym9PH7bNlb8Mg1SC5607/CK9rCan
	 DQxLabPoYRn3a6t26e3eDw40jrB0X5DONmQW0Hk2i2v/vayotvMvj5tId6vRppL23Z
	 yJ6cdkqAbaoIA==
Message-ID: <4c402f0f-1298-4dbb-b593-79e7e5233694@dorminy.me>
Date: Sun, 31 Dec 2023 12:26:57 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC v2 00/16] btrfs: fscrypt integration status
To: Stephen Andary <stephen@jamminmusic.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, kernel-team@fb.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 osandov@osandov.com
References: <CAH6pm79WsviF-L3kq+peAiSgZsrHbNfPzeYWNEE6KU=TRhiyVw@mail.gmail.com>
Content-Language: en-US
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <CAH6pm79WsviF-L3kq+peAiSgZsrHbNfPzeYWNEE6KU=TRhiyVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/30/23 10:26, Stephen Andary wrote:
> Happy Holidays. I stumbled on this public mailbox in an article, and 
> would love to follow encryption progress in the new year.
> Where is the best place to follow the current progress of fscrypt BTRFS 
> integration?
> 
> Best,
> Stephen

Current version of the patchset is 
https://lore.kernel.org/linux-btrfs/cover.1697480198.git.josef@toxicpanda.com/ 
-- the patches are mailed to linux-btrfs and linux-fscrypt, I would 
suggest subscribing to a mailing list linux-fscrypt (less traffic) andor 
linux-btrfs at https://subspace.kernel.org/vger.kernel.org.html for 
email updates.

(You could also try using lei as described at 
https://josefbacik.github.io/kernel/2021/10/18/lei-and-b4.html to look 
for only relevant emails, but I don't personally know how to use lei to 
do that.)

Thanks for the interest!

Sweet Tea

