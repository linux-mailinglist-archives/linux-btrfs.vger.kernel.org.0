Return-Path: <linux-btrfs+bounces-2458-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECF285850C
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 19:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717581C21692
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282EA1350C8;
	Fri, 16 Feb 2024 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inix.me header.i=@inix.me header.b="KBpnVwxC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.inix.me (mail.inix.me [93.93.135.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C68130E5E
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.135.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107882; cv=none; b=EPGU2Jshau/KEZUkaszwVw0JtupY6oEWKAhBor+hGVfk5vFiXBivE1y3I1qCyCK9dGoOl2B7sTVZQ6hBeeD1Hhuriy5szRwmsx7BJMc5sZAiMjpIQ8sLnPJDChkkp1N4zyi2C5kURqxWvDfCFsPryDfR3pK5vo9uBKqjhMK7LJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107882; c=relaxed/simple;
	bh=1cNtaAyMy71A30oOTjf6QAIFE62ZC5XIr/v0RcYg0I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMDLqbU/B8jz0hHUuxORU3bTuY4B50ZngiAb5YTQT8kHfjlLIflVckG8Wy/LeY9Vo6CNsNelrKKRoV9sIIJEj9GkquqhdB2Gt3hXDrkCN+l2FH2oOL286uRQ3KeLhIMH6cSi+/uLvoU8v4FAiIWVkDby8Ej634+KBk1A3F4/TTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me; spf=pass smtp.mailfrom=inix.me; dkim=pass (1024-bit key) header.d=inix.me header.i=@inix.me header.b=KBpnVwxC; arc=none smtp.client-ip=93.93.135.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inix.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inix.me;
	s=primary; h=Sender:Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=riFzUFSI1UUPYBtmRF5nvhMbeRpAVxB9r2xlOmyUhmk=; b=KBpnVwxCVJkTXkVDGN469ClQz3
	7tvqFGAci07jvGNSkxyqPHqAqoKcXf77R3OooRbNIT+cFJvM9U4JmZge+ng3Y9VTW4R0LFXGpTERv
	H6eDiisPc9CytmiwM+EtLT4T2grdumdGAIlZwAj1x2D+kQFptONp3xyIn+6gScFQoanc=;
Received: by mail.inix.me with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.96)
	(envelope-from <dash.btrfs@inix.me>)
	id 1rb348-00A60F-38;
	Fri, 16 Feb 2024 18:36:05 +0000
Message-ID: <762c0677-56d9-4a02-bfc2-581b9f3309c9@inix.me>
Date: Fri, 16 Feb 2024 23:54:29 +0530
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
From: Dorai Ashok S A <dash.btrfs@inix.me>
In-Reply-To: <CAL3q7H41FJ1KV281OQKpozbtONLcEFoaMpZ2nCKhgTNR36GUCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: dash.btrfs@inix.me


On 16/02/24 21:05, Filipe Manana wrote:
 >
 > Ok, now I understand your use case.
 > So I simplified the script to:
 >
...snip...
 >
 > Which reproduces the 2.5G stream:
 >

Thanks. I am glad to hear you could reproduce this.

 > So this is normal, because the file backing the thin device has holes,
 > its size is 3G but only about ~77M are used.
 > The thing is send doesn't support hole punching, so holes are sent as
 > writes full of zeroes in most cases.

That makes sense, it also explains why receive creates files that take 
up lot more space on disk.

One surprise is, for any change to the disk file, such as I could just 
do `touch thin-disk` and it will still be a large send stream.

# Touch
umount thin-mount
btrfs subvolume snapshot -r $(stat --format=%m .) 4.s
btrfs subvolume snapshot -r $(stat --format=%m .) 5.s
touch thin-disk
btrfs subvolume snapshot -r $(stat --format=%m .) 6.s

Output:-

# btrfs send -p 4.s 5.s | wc -c | numfmt --to=iec
At subvol 5.s
178

# btrfs send -p 5.s 6.s | wc -c | numfmt --to=iec
At subvol 6.s
2.4G

Is this expected?

This all happens only after running fstrim. If I never do a fstrim, this 
doesn't happen. Also, I am able to avoid the large send stream by 
removing the holes with `dd if=thin-disk of=full-disk` and using 
`full-disk` instead of `thin-disk`. This approach will work for me at 
the moment.

If we could support send/receive holes, it will be useful for 
incremental backup of disk images.

Thanks for the help so far.

Regards,
-Ashok.



