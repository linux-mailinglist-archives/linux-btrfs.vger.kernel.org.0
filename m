Return-Path: <linux-btrfs+bounces-943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC3E812036
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 21:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCA71F218E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 20:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030397E577;
	Wed, 13 Dec 2023 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="RcAb1aGQ";
	dkim=pass (1024-bit key) header.d=mail.ch header.i=@mail.ch header.b="GD79lSPl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9181CAF
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 12:51:53 -0800 (PST)
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout02.mail.de (Postfix) with ESMTP id 0F943240E35
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 21:51:52 +0100 (CET)
Received: from smtp01.mail.de (smtp03.bt.mail.de [10.0.121.213])
	by postfix01.mail.de (Postfix) with ESMTP id EBD0380151
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 21:51:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1702500712;
	bh=JAiudoA8iqdlhd7QiptyuCZqMHGqzXBAFcHpnTYnyd4=;
	h=Message-ID:Date:Subject:From:To:From:To:CC:Subject:Reply-To;
	b=RcAb1aGQnMFW5CjcABdgSjjdq0Q1SabkhX4TYZ7JBw/PG+7CVDKA3yoHQz2gKgB7n
	 rgmonRMXy7MiVCW/5/W2KLvrYGGtCixE6a/mPTuvmvwdEapIkRCLQGWO9sCHVrWnGP
	 4vv2yLJSwpJmYJcoNOWKBkctWdQhIjTRbi1HjU9tUi4SC+uA8y7WxA7NxMT9joKjev
	 yNoQLdBK78T33NhCB6awp/GoFssyLaVssADYbP8vYfElMNpGhENKPovT7NsWIEYEQe
	 aNk+5yqPF2ZZ4S0WPAXrYyjVDNQaYQNf5Tf3KT1ate8yCIs76pZTn5ZiGvfkbMWY1z
	 SvFUp2G2tcXCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.ch;
	s=mailch201610; t=1702500712;
	bh=JAiudoA8iqdlhd7QiptyuCZqMHGqzXBAFcHpnTYnyd4=;
	h=Message-ID:Date:Subject:From:To:From:To:CC:Subject:Reply-To;
	b=GD79lSPlKVaoIC8vhTl0WZNNoT/25aiR1jRlTRlBNw9P9ZrVSlzdleGmBWXp/V5zX
	 VDR086aTs8K30mHdNvOW7rvWAc8t2w9jbjJbxMPWa6+KtZm6CIwh3tfux9xfqOUNEd
	 /kGad5seE80NKvWwlhdFbK2Gq/9h4NmAEYnsPfX0=
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp03.mail.ch (Postfix) with ESMTPSA id B9376240ADA
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Dec 2023 21:51:51 +0100 (CET)
Message-ID: <142c1495-3aef-48ca-b9f1-4a33b03038fd@mail.ch>
Date: Wed, 13 Dec 2023 21:51:50 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: checksum verify failed, bad tree block start - doesn't mount
Content-Language: en-US
From: thomas <thomas85@mail.ch>
To: linux-btrfs@vger.kernel.org
References: <99bfe2b6-92d1-4acf-b9c4-d45b3e521db7@mail.ch>
Disposition-Notification-To: thomas <thomas85@mail.ch>
In-Reply-To: <99bfe2b6-92d1-4acf-b9c4-d45b3e521db7@mail.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1075
X-purgate-ID: 154282::1702500711-BE62D1F9-E50C3CAF/0/0

Hi there, even though because of the lack of any response in the last 2 
days (despite ample activity on this mailing list) it feels like I'm 
talking to myself - I'm gonna report on my success so at least other 
people stumbling upon the same annoying problem in the future can learn 
from my experience:

I've found I can successfully mount my partition in read-only mode with 
option recover=all to enable data recovery:

mount -t btrfs -o ro,rescue=all /dev/disk /mnt/

I've found out about the existence of that mount option here:
https://btrfs.readthedocs.io/en/latest/Administration.html#mount-options

I guess my next steps are to copy over complete subvolumes to another 
btrfs disk where possible (probably won't be for the damaged one with 
the failed writing) and alternatively copy over the files themselves 
where a subvolume copy is not possible - afterwards reformat the first 
disk anew and copy the data back.

Thanks for reading!
I would sure love a reply, even if just to acknowledge each others 
existence ;)
Kind regards, Thomas

