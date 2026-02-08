Return-Path: <linux-btrfs+bounces-21509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFv/FzQGiWnD1AQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21509-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 22:55:00 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D6C10A4A0
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 22:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7F9E300D95C
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 21:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A684341AB6;
	Sun,  8 Feb 2026 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMV4UZJQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3225524E4A1
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587692; cv=none; b=LkYmkPtfCudycvbX2EM4wd9e6harlWHmXYL2kwRQQEG0jfqPyeF+A7bNczYwxw+n1Cbc1pgadQzCapxKPQ5e5VKi/f+YQXx4ru8dNWNO1ZlediVJ/zrP7c17NEipkRBM94LPKHcD/USVR1ozqyLIbe3zziL/d7sfix1mliU+SJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587692; c=relaxed/simple;
	bh=PN7/ACZp3vLlIx+uqP6Fr7sKgy/e5+clmeWbLYowRrY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=IkTBDFYMT3AJAkFk3S9x1R3alkuVjK1xVKhyP8OJhNNm5PeCb33B1CL9iNmFgDDxvREEmFro8JAiOQvV+72qGRGTq8wyWtaVlC1uykdtEtJw44NfN/RSez88+G2+NbLapb10VmIX2FEZ8LCfqbDHmmhGO7B34bBAqLyOu48pFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMV4UZJQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-482f454be5bso39756595e9.0
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Feb 2026 13:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587690; x=1771192490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pXxvcyTTar8xzbZ64V1bAWpEzH2cYLNMQ5SoFwWNmXQ=;
        b=WMV4UZJQxn2PxA34J61lPiFBNt+x6bLAFpyDUKtLbChfB+utrHE8ULc4DhjvWImna8
         d43/TxbrVtLUOQ5J6qgMLzdXIHpSpfyDvIx5kMSzpW8NoGyp8XyFq0RwQHSoB7SQimQC
         IX2PwyvkXz4YUck6Y7DA+U7qwMG0pMfu83m8/44JsltLfSGtWZdv3qFZGUAnoaBkvKpp
         J2THIsIywBsCtQZ0t0+qyC2SCJ1Uiusro72iZiqWcNvY22aH1fUcW0BJmnCCzuG+Kujt
         uWt4SCBq0KXKgjPMel06LQk0F7b8Q1bc4gJPcVVXDVLqrCFJMe2kRZ4Zq6kcRYUCkuu0
         jUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587690; x=1771192490;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXxvcyTTar8xzbZ64V1bAWpEzH2cYLNMQ5SoFwWNmXQ=;
        b=G2rd3XBODpcfVgvJWbOjlcQt529pfDY81j24o/KlnQ9UjqXlHRWlO/UDp8O8rmawI6
         4pivG0zSfeCrgUayfj/L2iBuizs+Q3PGD2zVkUudwfqIWcIuWv6XXaArrtLjTlSG9ZeR
         l283Efgf2AdE6Mbls5X2qUqYluBC1BM1kYq53AIJKcUUlRA/JK3rms3GXHbb7pyS9vHY
         6KoFmKYS86K1lvNm+nrx5OwjC43mI4PIdUIJ/+OhRisu27Llb7oS1BAzM+l4xXYjVqj5
         eHfqfEoMAUVmdQd4YSvjfA+sZyjmvc19VUYZaW/+x0jImsmXfrrrONFyX9JK3ibn2C+L
         TQ+g==
X-Gm-Message-State: AOJu0YzhYy1ZrC+je7U2qFWsktYvjuF0vDuiBGwv9jx55zaD+/NbgBj7
	JhqIh/jyeVpYTCgqJPKpEQLdKd/Aq14p+2vptEdT/SfIh9AoPi2SwpBHKsnESQ==
X-Gm-Gg: AZuq6aJKTWaieouGvAzYse3mD1ujYc9KAq0kKzST9G9zdy+YNR7I9i4XpPM5RJlwgnW
	7s8xOxjn7zBY3SFvgKce/d6FMUVgeXZFGjQnlmBGWNj75KTXdZf0PE7JaddWeHIlgpBygAOLv8r
	l6f5HBhbJf+JvBxNjrNpueHkYT43hXREEI0Uy4JreT4zbYQbn35SRbIKbFwWsKP0/siFnZVTusC
	zclcI3uGTJMECf9YTDFhlZqHFXOvTLZ7Rze2oQBrolWgk7knrINNno7YeLJ2DxmQ7tgNqCKe5Nb
	Es/XX6/ut737y4s8sRXEP4tGzA0k5wAJ+gSQgGiTijjr7k51zIGk9SNZOosYcNJYsZJvg1F+FvP
	GEeuriOO7ZpE9BjczhSVLYWFmimTj4P6DhDikK2/i06N6h1pft2QO2BI+nLmpeVOcXuzkT8J/n/
	6eZxI2vgY4e7dfnrJLU3xHLI4Z6/xnVfe/sEZo7gZEdW4sNuOf6p9CgN5VvDeKJP3Fbzzn51M=
X-Received: by 2002:a05:600c:4e44:b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-483203de739mr149820875e9.17.1770587689852;
        Sun, 08 Feb 2026 13:54:49 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1978:7401:8935:e471:7003:e5cc? ([2a0a:ef40:1978:7401:8935:e471:7003:e5cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206ced0dsm190673245e9.6.2026.02.08.13.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 13:54:49 -0800 (PST)
Message-ID: <8da0df04-0dfb-4eb8-a3af-4f06a0eba01f@gmail.com>
Date: Sun, 8 Feb 2026 21:54:48 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [BUG] btrfs_commit_transaction error -11 on ZONED device
From: Qiyu Yan <yanqiyu01@gmail.com>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0c33ef9a-24b1-43a6-9f93-72249b1cceac@gmail.com>
 <5c1a41f2-e8fc-417e-87a0-debca44b56ec@gmail.com>
Content-Language: en-US
Autocrypt: addr=yanqiyu01@gmail.com; keydata=
 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
 0/GqXYttz/srV15jCiDuGPfZQbeDq0BQ3sM=
In-Reply-To: <5c1a41f2-e8fc-417e-87a0-debca44b56ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21509-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanqiyu01@gmail.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6D6C10A4A0
X-Rspamd-Action: no action

failed with different reason after some writing

[  624.632595] I/O error, dev vda, sector 0 op 0x1:(WRITE) flags 0x800 
phys_seg 0 prio class 0
[  624.642790] BTRFS error (device vda): bdev /dev/vda errs: wr 0, rd 0, 
flush 1, corrupt 0, gen 0
[  624.645172] BTRFS warning (device vda): chunk 536870912 missing 1 
devices, max tolerance is 0 for writable mount
[  624.645189] BTRFS: error (device vda) in write_all_supers:4037: 
errno=-5 IO failure (errors while submitting device barriers.)
[  624.648010] BTRFS info (device vda state E): forced readonly
[  624.648016] BTRFS warning (device vda state E): Skipping commit of 
aborted transaction.
[  624.648019] BTRFS error (device vda state EA): Transaction aborted 
(error -5)
[  624.649789] BTRFS: error (device vda state EA) in 
cleanup_transaction:2021: errno=-5 IO failure
[  626.360832] BTRFS error (device vda state EA): failed to run delalloc 
range, root=257 ino=3248 folio=0 submit_bitmap=0 start=0 len=4096: -30
[  626.362794] BTRFS error (device vda state EA): failed to run delalloc 
range, root=257 ino=3249 folio=0 submit_bitmap=0 start=0 len=4096: -30
[  626.364833] BTRFS error (device vda state EA): failed to run delalloc 
range, root=257 ino=3250 folio=0 submit_bitmap=0 start=0 len=4096: -30
[  626.366758] BTRFS error (device vda state EA): failed to run delalloc 
range, root=257 ino=3251 folio=0 submit_bitmap=0 start=0 len=4096: -30
[  626.370235] BTRFS error (device vda state EA): failed to run delalloc 
range, root=257 ino=3254 folio=0 submit_bitmap=0 start=0 len=4096: -30
[  626.372178] BTRFS error (device vda state EA): failed to run delalloc 
range, root=257 ino=3255 folio=0 submit_bitmap=0 start=0 len=4096: -30
[  626.374828] BTRFS error (device vda state EA): failed to run delalloc 
range, root=257 ino=3257 folio=0 submit_bitmap=0 start=0 len=4096: -30
[  626.377104] BTRFS error (device vda state EA): failed to run delalloc 
range, root=257 ino=3258 folio=0 submit_bitmap=0 start=0 len=4096: -30
[  626.379755] BTRFS error (device vda state EA): failed to run delalloc 
range, root=257 ino=3260 folio=0 submit_bitmap=0 start=0 len=4096: -30
[  626.382389] BTRFS error (device vda state EA): failed to run delalloc 
range, root=257 ino=3262 folio=0 submit_bitmap=0 start=0 len=4096: -30

cat /sys/fs/btrfs/02b4934e-9807-43d3-b28b-f9ca7d055391/commit_stats
commits 5
last_commit_ms 34011
max_commit_ms 34011
total_commit_ms 45217

在 2026/2/8 21:51, Qiyu Yan 写道:
> The same issue did not happen with kernel 6.16 (mainline, I tried 6.17 
> and the issue happens), I tried to mount with the 6.16 kernel and can 
> observe that at least one commit made it through
>
> cat /sys/fs/btrfs/02b4934e-9807-43d3-b28b-f9ca7d055391/commit_stats
> commits 1
> last_commit_ms 70
> max_commit_ms 70
> total_commit_ms 70
>
> And I am trying to copy file via rsync and check what happens. But 
> anyway, this issue looks like a regression since 6.17


