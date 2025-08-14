Return-Path: <linux-btrfs+bounces-16070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54404B259C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 05:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03CF47AF4C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 03:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEDB221D88;
	Thu, 14 Aug 2025 03:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXWCkcDm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3862FF65E
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141708; cv=none; b=lpNhigPH9NcwktE2HsRbTr5aJ9znNWpV+Yxfshp+GwNSdZZn3MhmTyqffQGZn0Mxs65dhJAjbP/tG8NZa7nVyCfZBzfoxWk6uzdl+ORpQvXpfJzDv1eKTaqzB1ECTQr4XJV9EQwYkFnEgEExfAlDXAlzoLdL0wbOuLQe+c0hVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141708; c=relaxed/simple;
	bh=CuskIcfKfXGnDOfq5IS0T4YTTGdnx6kA1stqCYkdY5o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ELk7d46Y4ohRZlqx2oZbW7zKQ0JQwTEmuf7EIARjghat2UzT0INIw+K9UXu42w5bxhkk2acvjhSibBrZynmRYSCSrKCvq+t4Qc8257vFtenfhk/KGgQMt7KPC4C4+5M+SyNBLL5aFHh8/cLJysxFaTcaKCKLR77mq8s0eVpFtug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXWCkcDm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445806e03cso6628675ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 20:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755141705; x=1755746505; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CuskIcfKfXGnDOfq5IS0T4YTTGdnx6kA1stqCYkdY5o=;
        b=lXWCkcDmAuvcYul+IpjruXj+o6sOC6atH7DXDRTxsP9HwIp5vtLMBB8owj/dkkWMZL
         4XAxDIVdc5+nelrtRgmhbYP42wvr+YttYVQJQU15x64zx3f65Poua9gxnsImTnOHOVJz
         AjmpWQijTUp5HMAAqV9wjouJ3nRRr7xYzKGjDDYKDJwL6eprzdDq198YdfvoPNBYmT8k
         UFEIsAU7rc2BagMVrvz2DT+nv9wnz31u4Z/sbfkPa8SwqJWGJ+ynYCHoFScQbAGbwET5
         YOgcwF0VZujAzwIY6HGXonW37VUs2UoXrr6gOxwefnlVd199opDyACoiOgqnlG0kfq0B
         RWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755141705; x=1755746505;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CuskIcfKfXGnDOfq5IS0T4YTTGdnx6kA1stqCYkdY5o=;
        b=WWMwg+5BaHgKcjpvHsqEqZN3d4CbB4P1LDRg7IFx+KMqH7mdQxm9JZiq0aTA8NyfUQ
         uJBDbju7rIikzAszRtRCmBxXe/aH+020VlbqJffPSzPvqk5Vyb9Al/1eagcsvCjUKHbM
         jHo6ZINOL7nGCplszdBmB32itJSPoq3ZaQEldmFsk2jwyWBetIoKrFMVWlXjfoBAe2CP
         Y/xaV+/NsGDXxM0APPkktcZDtBsVEKt5YKTm0gxzwDF7nPJwnANyiIWJZABU0OTwUB7k
         tP+xV5QXkGdFjghBaxpJPxgXEtcPqAitzZ42Q/gbFvfDjtnYzluRqwDXCQwsEe0nL1nB
         s/VQ==
X-Gm-Message-State: AOJu0Yyu3Px0x8WObyUe7yn0pFK77cGeDjGET1uPBaGhm2wLPzuanbCS
	S849hwOOKCyb38QL3jha4lbaKu4R2rGxdU6xljR+orukyuZj3Lb8ZSwHIRyXLqosX5xOLrq+2+b
	Nifs7f+MWC8Qu1m+DUgLcxa7vAZhLMsvuRSk7
X-Gm-Gg: ASbGncuXhtX1F9eoDC/bURapMDVPkvdFuKhWMIWiN4EIQkRZJSG1f2bSUTtQU6HHHu6
	5R/uuMgkInHanrdfD6hFAc3X0D+4yZoYXn9ro71cP0ZT+F4Y42cJTjjapUFS5Xe9ys9VAakxyM8
	XmikRKLF/c3HwIpehTZx0qtHk/omhzefvhTDdro+MjPKq83e8Pc+zFVrYq46NYcAq8v2deD9tXQ
	03KjA==
X-Google-Smtp-Source: AGHT+IGfNhahjvH4Fh4Ren2CQK6DocpR90H4VAmnA2cU8aFU67JJGdgzL+JEFBDp2P6om1LkkJL9kCp8WM+RFLzTxLg=
X-Received: by 2002:a17:903:1c7:b0:240:aba:fe3b with SMTP id
 d9443c01a7336-24458503d07mr20592575ad.16.1755141704911; Wed, 13 Aug 2025
 20:21:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: AccSwtch50 <accswtch50@gmail.com>
Date: Thu, 14 Aug 2025 03:21:33 +0000
X-Gm-Features: Ac12FXwbRZfMeNxwX6RW9jO6gjGOp_ne42FlbN3LKkrTNuMwHztCWVHijy4osaw
Message-ID: <CAHR-kGg0K71gJsYkWK-0hpbEH3NZObxXHc3CJ=R-g79iP=99Cw@mail.gmail.com>
Subject: Broken BTRFS Partition
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, How do I fix my broken btrfs partition?

This is the dmesg log when I tried to mount it:
[22709.506970] BTRFS info (device sda21): first mount of filesystem
853da0a7-a25b-423a-8b42-4ef0cec712fe
[22709.506989] BTRFS info (device sda21): using crc32c (crc32c-x86)
checksum algorithm
[22709.506997] BTRFS info (device sda21): using free-space-tree
[22709.809320] BTRFS error (device sda21): level verify failed on logical
205872398336 mirror 1 wanted 1 found 0
[22709.809395] BTRFS error (device sda21): failed to load root free space
[22709.810018] BTRFS error (device sda21): open_ctree failed: -5

And here's the output of btrfs check:
Opening filesystem to check...
ERROR: root [10 0] level 0 does not match 1

ERROR: could not setup free space tree
ERROR: cannot open file system

