Return-Path: <linux-btrfs+bounces-819-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBE780D820
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 19:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E7F1F21760
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Dec 2023 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836C051C47;
	Mon, 11 Dec 2023 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="nJoNLDlG";
	dkim=pass (1024-bit key) header.d=mail.ch header.i=@mail.ch header.b="Zzb3UqOx"
X-Original-To: linux-btrfs@vger.kernel.org
X-Greylist: delayed 342 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 10:42:45 PST
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495A6AC
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 10:42:45 -0800 (PST)
Received: from postfix01.mail.de (postfix01.bt.mail.de [10.0.121.125])
	by shout02.mail.de (Postfix) with ESMTP id 389C5240D47
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 19:37:00 +0100 (CET)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
	by postfix01.mail.de (Postfix) with ESMTP id 1F7A28010F
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 19:37:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1702319820;
	bh=GjDAdt1ymZZXCHtJwLk3IuK8G+TmGxJ1H7xZza2wr0k=;
	h=Message-ID:Date:To:From:Subject:From:To:CC:Subject:Reply-To;
	b=nJoNLDlGU++GZu7rlfa78JuHr0Fyeq2nWbDWkQOKc9ghEE8zOTlzzxUmvnw3qLBYA
	 4OPA1Glt8VH7Yf+mdoJN401dpHkX6/Knsr+BBVYosL7ItBqqVir2nx2zvDGpGXnr7t
	 6nMZkLSYRDEf0OlA43ff1kbDhFvKHPHd4xIPZIcUXkWp6vbONyOxzMOjgPWd7Szoc+
	 fd2NPh7mCu0Bpa3kB0CAyw7FkND4qQNVe+Lv27ZsHVOx3n+36sjDSynnMvnEawj0QU
	 mteibFkHd9+sE2GHa4BdEXaAikH4KfgHuh/pqFZBDs7NN0/FR9q3kbZqcIiHanRne5
	 vHRwXZP4I9kkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.ch;
	s=mailch201610; t=1702319820;
	bh=GjDAdt1ymZZXCHtJwLk3IuK8G+TmGxJ1H7xZza2wr0k=;
	h=Message-ID:Date:To:From:Subject:From:To:CC:Subject:Reply-To;
	b=Zzb3UqOxvyfEK9i79NjjbLQeP5l9TpiCAWBIxKa/rdBWoriXHICXFslvZAYUO8mmC
	 Du2hazhoDo4/3sq9Z1DSJj7p4yU/nD1ZH1FEEBnixL6uLROTcaKcpmdT9dZW1/8X1D
	 84D/VR988AG/DVzWbWwvvBR1dzZX2DYI73UkmOPM=
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.ch (Postfix) with ESMTPSA id E51CD240CA5
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 19:36:59 +0100 (CET)
Message-ID: <99bfe2b6-92d1-4acf-b9c4-d45b3e521db7@mail.ch>
Date: Mon, 11 Dec 2023 19:36:58 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: thomas <thomas85@mail.ch>
Subject: checksum verify failed, bad tree block start - doesn't mount
Disposition-Notification-To: thomas <thomas85@mail.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1824
X-purgate-ID: 154282::1702319820-CEDB8670-E883FAE9/0/0

Hello!

I have a btrfs partition that suddenly threw errors while / after trying 
and failing to writing a few 100.000 tiny files to. I also applied a big 
batch of updates to my Manjaro (arch based) host system at the same 
time. The partition resides on an external USB3 disk, so maybe there 
where problems with the USB connection or controller.

When I try to mount the disk, I see those errors in my dmesg output:
bad tree block start, mirror 1 want a have b
bad tree block start, mirror 2 want a have c
failed to read block groups: -5
open_ctree failed

btrfs check prints this:
checksum verify failed on 2406422577152 wanted 0x54664506 found 0x09b440d2
checksum verify failed on 2406422577152 wanted 0xc9ae9ee7 found 0xa48e4be0
checksum verify failed on 2406422577152 wanted 0xc9ae9ee7 found 0xa48e4be0
bad tree block 2406422577152, bytenr mismatch, want=2406422577152, 
have=3078578726591466187
ERROR: failed to read block groups: Input/output error
ERROR: cannot open file system

btrfs rescue chunk-recover ran for around 26 hours and ended with this:
Scanning: DONE in dev0
corrupt node: root=1 block=2407012663296, nritems too large, have 3 
expect range [1,0]
corrupt node: root=1 block=2407012663296, nritems too large, have 3 
expect range [1,0]
Couldn't read tree root
open with broken chunk error

But sadly that changed nothing either. I'm at the end of my wits, what 
else can I do to repair this partition or at least get a read-only mount 
of the data currently on there so I can copy the important parts to 
another disk before reformatting?

Please help!
I've posted my experience here first:
https://www.reddit.com/r/btrfs/comments/17z0dtd/btrfs_error_device_sda_bad_tree_block_start/
but haven't gotten any reply so far.

Thank you,
kind regards,
Thomas

