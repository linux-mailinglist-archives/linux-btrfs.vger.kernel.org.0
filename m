Return-Path: <linux-btrfs+bounces-991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B558159F0
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Dec 2023 15:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C33A51C218E4
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Dec 2023 14:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C234030654;
	Sat, 16 Dec 2023 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="Ujopa9xC";
	dkim=pass (1024-bit key) header.d=mail.ch header.i=@mail.ch header.b="LPtOtNJ4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from shout02.mail.de (shout02.mail.de [62.201.172.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E830641
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Dec 2023 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ch
Received: from postfix03.mail.de (postfix03.bt.mail.de [10.0.121.127])
	by shout02.mail.de (Postfix) with ESMTP id 09204240D3F
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Dec 2023 15:47:40 +0100 (CET)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
	by postfix03.mail.de (Postfix) with ESMTP id E249E80297
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Dec 2023 15:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1702738059;
	bh=HR/3ijSP+STrSZpiK4CSM52mZMVtuejeGd4xdnM5Wgw=;
	h=Message-ID:Date:From:Subject:To:From:To:CC:Subject:Reply-To;
	b=Ujopa9xC0NCuYAZJiUMtg/I1EfoE3Y/SlqIza0TP73SAfr+jcF0xdy9u3crNZrxcc
	 tr6Nb78/vadJTpq44CGvrr5TZ8UgoEqps3J6c0HvvqBfB1zJHj+4/LtNo9DEsf6CCm
	 lr2v14SRW8AIvPenvql6+cy6JFsegk686rDG/UVy/NhiEQQrH7cUcwQVkh9rIuUvcl
	 rbcKI4uwrS7I/4O5tW1gRjz0+jNHpB8ROVPTxeTqyBZPmW4mBr5u+zklkjYCqByM0G
	 n7kK40XJHIDLeSLmohTR1sIpU3tKHImi30nLHaQB1o4mRzBcsGMs6Mmo6bbACMgAHp
	 XRjGZ2G+w1DuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.ch;
	s=mailch201610; t=1702738059;
	bh=HR/3ijSP+STrSZpiK4CSM52mZMVtuejeGd4xdnM5Wgw=;
	h=Message-ID:Date:From:Subject:To:From:To:CC:Subject:Reply-To;
	b=LPtOtNJ4TRHZNhYwDS2KGK5lJ5oJ2wUQqSRVcBfSzG+cTvKYA6Fch22W64F919OTt
	 oy/w1dDzaKN1rqiiWvPteHM4wA8FJPfSS3PDD4yDTr3fYni5VIvHQAj6d1sst3PFfG
	 NHTzFCjEbjkeZSUfMr2ChfWYD4pZCVZv6pPh/XNU=
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.ch (Postfix) with ESMTPSA id A5C31240C83
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Dec 2023 15:47:39 +0100 (CET)
Message-ID: <a41a77e3-95aa-450f-9712-c5681f8a8912@mail.ch>
Date: Sat, 16 Dec 2023 15:47:37 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
From: thomas <thomas85@mail.ch>
Subject: btrfs send subvolume from read-only mount with missing ro=true flag?
To: linux-btrfs@vger.kernel.org
Disposition-Notification-To: thomas <thomas85@mail.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 912
X-purgate-ID: 154282::1702738059-23DBA670-F7B560F4/0/0

I have a btrfs volume damaged (it seems beyond repair..) by writing to 
it via an unstable USB connection which disconnected at a particularly 
bad time it seems.

I found I can still mount said volume in read-only mount using:

|mount -t btrfs -o ro,rescue=ignorebadroots,rescue=ignoredatacsums 
/dev/ice /mnt/point |

Now I would have liked to copy some of the subvolumes from that damaged 
volume over to a new one, but sadly |`btrfs send||`| disallows using 
subvolumes that don't already have a ro=true flag on them, so only 
read-only snapshots are allowed as source.

Can I somehow make |`btrfs send||`| believe that on a read-only mount 
everything is guaranteed to be read-only, even if the subvolume does not 
have that read-only flag? Sadly because I can only mount said damaged 
btrfs volume in read-only mode I can't add the read-only flag to the 
subvolumes I'd like to copy..


