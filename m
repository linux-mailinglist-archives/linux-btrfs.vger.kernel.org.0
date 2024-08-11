Return-Path: <linux-btrfs+bounces-7102-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8743194E218
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 17:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C68281467
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D4914D444;
	Sun, 11 Aug 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kota.moe header.i=@kota.moe header.b="KrXJ5g+E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C214C59C
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723391886; cv=none; b=KJ4dfcJMz910V+5ymAiMRZsYDQJol1AMKTz642nOB0brP+Od7U2EtZ4n1U3x4+xkI/j0FbfDXnR6OLo4EEQVhwuOeB5G62kmz7tsRT2Kvk5q1IuFaJNniHNELMkTTBysG0UJBOcOh3Eerk1w4b8/4p7dd9s4+ZRRk9YuPnU0d0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723391886; c=relaxed/simple;
	bh=2NDFBHQXUWdtBXQ2N1BKX4DHXbTA2UU8ej4SQ99qBUs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SCn4UzTdvMJs/VcRC8lQH9X0m/5kGKk8iJfYT4gk5OwJrZub/wtnQZI7A7sCQPvmXx9Hyc7/NLgr1qZT42xrvacrOmR3ZyrUHM5Ic2koYkAVNC3c4H/sxHW9nSXfS4OkXryH7veej8T1bVnz5iADJQNZmrAi3Y0PmECbmsUFRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kota.moe; spf=pass smtp.mailfrom=kota.moe; dkim=pass (1024-bit key) header.d=kota.moe header.i=@kota.moe header.b=KrXJ5g+E; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kota.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kota.moe
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b7b349a98aso27197786d6.3
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 08:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kota.moe; s=google; t=1723391881; x=1723996681; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vnRl62dITUETaiWLECsYE+STgn5RVQBZTrV5BmWaoUk=;
        b=KrXJ5g+EG4F+K5wTR8FIO49R49Yx4uPR+6YSuLLknDPX43IGSpSIV0mrh5MnKEwdSl
         gazyoeX39SIujAeoASG+ACa70gTNLGODVCOJjGmTsPUvGX6qYiORwTPwXE4Qh7XYVBrc
         ZRVqyCoo8grwhAmAqucthtUNARgkU+keQOSs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723391881; x=1723996681;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnRl62dITUETaiWLECsYE+STgn5RVQBZTrV5BmWaoUk=;
        b=Dzp24Nxdd3E1nnztJctt15ifdEs73VNuOfIkkrWPuBavreApkOaSkvyj/0F12wobLN
         ehKcEH1x7bq2aUhXMKVvh6KlJifciVMU8bQU7XHYv+UpLNWdZqhsy78cOMGhCAKgeyyq
         Ryt+4JxtqyoGkZ/XPzivs+ZdRlXuvCSCFk3AxqyR5flPEL64HB0qeBLap031kR0pr0DJ
         r04t12Hl7p8zkYNdnFSbcJqdemPRmoyYnpwsAX3Q/pHRgWZ4Bcw+lf0AewCm4XpDa4Vn
         /neEo540dns1oJlo6tyopVqQNos3cK9wanq+gGiPwIfRpvc3B7TR6dSQnkvFrFZkBHRT
         V74g==
X-Gm-Message-State: AOJu0YzgCHLv1Jy1A+jrCVDxDjFHx3Naj1r6K4gpOd5GYFal9twjSRQ3
	BdEJeCMEMu+gGGha7uKPJhntxFvyuGyFbpGV/6RpN4YGAfrxpk2HxAOQd1JOdKI5L0u6BgBbx/7
	b3mHWIH3Ixi375893zRfnXJK2TJc3bcQEpno1G/JRNvScrvtPbpc=
X-Google-Smtp-Source: AGHT+IEQtG6NnvuV+7EmzMUMt1dtPmH7kXF0xTvkZAY2kmDTkEE59bXo/f6hWbkS80HhcduR5CvnqYVUg8ANCRESNrI=
X-Received: by 2002:a05:6214:4308:b0:6b7:b277:dd12 with SMTP id
 6a1803df08f44-6bd78e9ae00mr86115486d6.49.1723391881328; Sun, 11 Aug 2024
 08:58:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?4oCN5bCP5aSq?= <nospam@kota.moe>
Date: Mon, 12 Aug 2024 01:57:24 +1000
Message-ID: <CACsxjPYnQF9ZF-0OhH16dAx50=BXXOcP74MxBc3BG+xae4vTTw@mail.gmail.com>
Subject: "inode mode mismatch with dir" error on dmesg
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I've been encountering this error for a specific directory on
my filesystem:

kota@home:~/.cache/mozilla/firefox-esr/a5h8u08v.default$ uname -a
Linux home.kota.moe 6.9.12-amd64 #1 SMP PREEMPT_DYNAMIC Debian
6.9.12-1 (2024-07-27) x86_64 GNU/Linux
kota@home:~/.cache/mozilla/firefox-esr/a5h8u08v.default$ ls -l
ls: cannot access 'safebrowsing': Structure needs cleaning
total 0
?????????? ? ? ? ?            ? safebrowsing
kota@home:~/.cache/mozilla/firefox-esr/a5h8u08v.default$ stat safebrowsing
stat: cannot statx 'safebrowsing': Structure needs cleaning
kota@home:~/.cache/mozilla/firefox-esr/a5h8u08v.default$ sudo dmesg | tail
[ 1881.553937] BTRFS critical (device dm-0): inode mode mismatch with
dir: inode mode=040700 btrfs type=2 dir type=0

It's been happening for a long time now (months? years?) but I've
never bothered to try to fix it because it's not data I cared about,
so was simply a minor annoyance when scanning the filesystem

But is there a way to fix this?
I'm happy to just delete the directory rather than try to recover
anything inside.
btrfs check also found the issue, but seemed unable to fix it.
btrfs scrub does not find the issue.

