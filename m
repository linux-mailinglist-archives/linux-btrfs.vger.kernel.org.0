Return-Path: <linux-btrfs+bounces-2474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E95858F57
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 13:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487B81F22A42
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 12:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8290579DD1;
	Sat, 17 Feb 2024 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inix.me header.i=@inix.me header.b="vXP1Id11"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.inix.me (mail.inix.me [93.93.135.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7731A66
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.135.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708173283; cv=none; b=SHzfIMGryecEv+brfTA7ki3cyxzt6SAIei/X0J7PqQO7nIewCLCjensGE1PeRX34/oOrHesd8yIq9zf/6PG8vDVMe/FSxDYNQKCAv+V+qCRkeuE2GPehiyu7XWO7yPmq/Fk4aGEDevzHRjahLz4aueqqm2X3A3blvZkLfA9DOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708173283; c=relaxed/simple;
	bh=X1adEu1wT5rj1pGMXdjFUt5VsJ+2Y1mcD49gBh5ddD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHC/MpRfehcw4WdniTz89ULzJcj2dppRSmNWeyhtXHCAepDJb6MGxsHQUa7QYK7ZEkofqaIs+0liEaJFLk7XMv+Vhzo6yQhYoXqCA/yHyD4HBU3CEFiQ7Fi8U3UC0anwn8swTCwzXw3UyW7tw1HDqLWj5t4UH05w5F771UnL5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me; spf=pass smtp.mailfrom=inix.me; dkim=pass (1024-bit key) header.d=inix.me header.i=@inix.me header.b=vXP1Id11; arc=none smtp.client-ip=93.93.135.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inix.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inix.me;
	s=primary; h=Sender:Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rGv5z2uJvd8dz2pRmT4wOKoXJO+Ql8qgbYRTQ/wKTqw=; b=vXP1Id11hPSvQBvZ4DHWF6UXHF
	SshXQGq1trsmitoDgXj4rkvY5AdQer4Wv+sR+0vj0WqEWF7aHME+9gH3mwZ97mnAbG4AQahUMUw/i
	Jjmw8K3kiY+6mlyBud1YcG4zXVoGc9Tt6Svrymhl+SFD1tiBkUcspOrIJuWIYkmsgurA=;
Received: by mail.inix.me with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.96)
	(envelope-from <dash.btrfs@inix.me>)
	id 1rbK4w-00A7uO-0t;
	Sat, 17 Feb 2024 12:46:02 +0000
Message-ID: <e1ca1af6-7222-4f33-870b-a5e1acea2315@inix.me>
Date: Sat, 17 Feb 2024 18:04:32 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: incremental stream after fstrim on thinly provisioned disk file
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <c0bf7818-9c45-46a8-b3d3-513230d0c86e@inix.me>
 <CAL3q7H6tvCTdwrCXZ0tgOfkHhF=VWEW05_u3vr_rVv0u_PvvXg@mail.gmail.com>
 <20b3b98b-b165-4fd7-b026-8f3c8440a631@inix.me>
 <29b50a95-025d-41c3-bee6-f51888b28487@inix.me>
 <CAL3q7H41FJ1KV281OQKpozbtONLcEFoaMpZ2nCKhgTNR36GUCg@mail.gmail.com>
 <762c0677-56d9-4a02-bfc2-581b9f3309c9@inix.me>
 <CAL3q7H7-iO_CqR5PPaqTM2GdpsNtV2-EeSU=mxOwE2++Ggg1EA@mail.gmail.com>
From: Dorai Ashok S A <dash.btrfs@inix.me>
In-Reply-To: <CAL3q7H7-iO_CqR5PPaqTM2GdpsNtV2-EeSU=mxOwE2++Ggg1EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: dash.btrfs@inix.me

 >> One surprise is, for any change to the disk file, such as I could just
 >> do `touch thin-disk` and it will still be a large send stream.
 >>
..snip..
 >>
 >> # btrfs send -p 5.s 6.s | wc -c | numfmt --to=iec
 >> At subvol 6.s
 >> 2.4G
 >>
 >> Is this expected?
 >
 > There are a few cases where we send the writes with zeroes where it's
 > actually not needed.
 > I just noticed an hour ago about one such case triggered by that use 
case.
 >
 > So that can be improved, I'll send a patch for that on monday and let 
you know.

Sounds good. Thanks.

 >> If we could support send/receive holes, it will be useful for
 >> incremental backup of disk images.
 >
 > Yes indeed. That however requires a change to the protocol to support
 > a new command (hole punching), and changing the kernel and
 > btrfs-progs' receive implementation, not something that can be easily
 > and quickly done, but has been on hold for years.
 >

Makes sense. Thanks for clarifying.

Regards,
-Ashok.


