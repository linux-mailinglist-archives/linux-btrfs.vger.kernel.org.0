Return-Path: <linux-btrfs+bounces-10044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CFE9E3036
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 01:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB04A28389B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 00:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE853D64;
	Wed,  4 Dec 2024 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BP8u6wFl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6D10F7
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Dec 2024 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733270542; cv=none; b=XW7bDDamkl52ziva+hBLE9QhoA7R3kbyrByrMpjVKw5dKKxo/5yxSi6Sv7kBQAc9SUsBFoEQKzlOFo8qYmz7T8InM309MJwL4RcZKoVdnsNPTqxkMAjXI1KL3Sk3/95e0gvQXghpIgnfGxnnB7P3pfyRvy+6luwqacGSdLlW2lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733270542; c=relaxed/simple;
	bh=W+iZW4Gl3eBBt89xbJYHZm9n2hZpW010nvn3jjeBTEQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SxA+jZJVExUCEyrEN9WOGm5HXtWuHqUf1kjk5CftYu1nxg63IuEF0DeP8guoEYikVR/WDLaRBcna1+h+7gqXVWBP432ZnYWEFr+Xtoi+xmKnczRlp+yavt2x9nNYwb3J/KpKsBkcM8NPiM4KAQ8hPmXHvxbFFwknB/AhCWZmNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BP8u6wFl; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b667d2fb9dso383384085a.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Dec 2024 16:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733270539; x=1733875339; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Um/5wHQRHWcMewe2NNCxJgCUTLolK2thWvdy8gpBCeI=;
        b=BP8u6wFlrfng5DsiD9MiBwsPB5/qCEtrHPIM/ETthhl6Y6aO4O8Kj8EtjCXALcOM4A
         PmwGGTnDseyxwnO1RfmaPQuFf9Wqt02yqL2s6xNpKVVS0FrYk82u/T3gO6GMA8ER7Ldu
         ib0hg5bLRQvR7/x364PVQytkr7pWwrxlkhuotfE8iqVHt7zoF0hnFItY0pFq5mP4hDc4
         tfQLd0OOiBcNbR6yILKPOX9y0Gzu5ioiAYH2bNNAKGulZ8FksQHZb80G5exDlomyxhou
         c8BSgqlaTL5+BrBfpuJwn3TKEkc2jVzX/KQgjNubCJ4lLajtQmxrAKST5skNE+X88T+1
         PP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733270539; x=1733875339;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Um/5wHQRHWcMewe2NNCxJgCUTLolK2thWvdy8gpBCeI=;
        b=KFV55/FH5MfWpjWkyAbpKYBve9FeVEcOK43eQ5rlV7AHZW6fz6WNmEK33KHPZof7gl
         1cEsBHoFVOIMO6eOC9DbQYHfbPemsU3CiLko06EITdUW5Jb+Fm5UhklZmaa8lRcPt+mO
         HDkQRHetpAIXQ0KiZGMXBRBsuHc9EGSo59ZG+hV3NoUjQlug+FAT9nuAx07PRXy1gSkk
         gtowHoVIokn2m+FqZ7AfH9Oh0ImaC6YHFRXHOMwevaXh7Ih91GXN8CxYWDJlmmexpCgW
         wwN1RrNjP2UeWUMj5E16i6/NTZtS7H4+fAaN9C3LjDZqxXTQR6ZK52hCwtAUeHuGf4n0
         oNTw==
X-Gm-Message-State: AOJu0YxuY4jM0lThtdkghFgAcQwpav0R6XHi/EqWH0eGsDZ0msizvqPB
	HO5Y3ku4S2M5/Tmwv4JlhQPoO4s3hVn8W0bEk316Re+OR892aaPQ7vr4FA==
X-Gm-Gg: ASbGnctWLqJ9ZuNTCtdNPSKt1RpBbv5EFXJGTHtfRX7axM8nwwuhqwUgdPc3W486E2D
	27PklygC3ahgSz8SWFgleiX9im2vhPRPTEPtL3qHXK5+68pO+7tO4b1DxtXg+/tKG6yEzC2xxrG
	z00gMlrO05J6fvQLTu3NY53c1C01pQERcN5/vpwSChTqIFTVptQBfFAEVFKJS/wYsQF1EwWxcEu
	KFhGhvEWa/FKU1SWKK7ekZjIlhK6xsZMIKjjOmRd6H913ocpKMm9QBK2eMzj6/oXuTaJWLYLHRJ
	NG8sCucwe8/A63OQjLJeGS431PDVM1o1Iy2+
X-Google-Smtp-Source: AGHT+IH+VH155YqHbI1xxmXlnvjBFtrnD9l/GEr9Ab1UQkmobdI7Dpqp7A0iZV6YFxHNMAzu3+tnvA==
X-Received: by 2002:a05:620a:192a:b0:7b6:73f5:2865 with SMTP id af79cd13be357-7b6a61eae40mr465719885a.42.1733270538482;
        Tue, 03 Dec 2024 16:02:18 -0800 (PST)
Received: from ?IPV6:2607:fea8:c1df:ffe5:49ff:c562:46ac:7af6? ([2607:fea8:c1df:ffe5:49ff:c562:46ac:7af6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b684946f16sm557554185a.61.2024.12.03.16.02.17
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 16:02:18 -0800 (PST)
Message-ID: <207033eb-6e59-45f1-9ec5-09e63eaa4c70@gmail.com>
Date: Tue, 3 Dec 2024 19:02:17 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: fr, en-CA
To: linux-btrfs@vger.kernel.org
From: Nicolas Gnyra <nicolas.gnyra@gmail.com>
Subject: Errors found in extent allocation tree or chunk allocation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I seem to have messed up my btrfs filesystem after adding a new (3rd) 
drive and running `btrfs balance start -dconvert=raid5 -mconvert=raid1c3 
/path/to/mount`. It ran for a while and I thought it had finished 
successfully but after a reboot it's stuck mounting as read-only. I 
seemingly am able to mount it as read/write if I add `-o skip_balance` 
but if I try to write to it, it locks up again. I managed to run a scrub 
in this state but it found no errors.

Kernel logs: https://pastebin.com/Cs06sNnr (drives sdb, sdc, and sdd, 
UUID dfa2779b-b7d1-4658-89f7-dabe494e67c8)
`btrfs check`: https://pastebin.com/7SJZS3Yv
`btrfs check --repair` (ran after a discussion in Libera Chat, failed): 
https://pastebin.com/BGLSx6GM

I'm currently running btrfs-progs v6.12 but the balance was originally 
run on v5.10.1. Is there any way to recover from this or should I just 
nuke the filesystem and restart from scratch? There's nothing super 
important on there, it's just going to be annoying to restore from a 
backup, and I thought it'd be interesting to try to figure out what 
happened here.

Thanks!

