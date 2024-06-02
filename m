Return-Path: <linux-btrfs+bounces-5403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8DA8D7774
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 20:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8410C1F2132B
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 18:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE0B6D1B2;
	Sun,  2 Jun 2024 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unixindia.com header.i=@unixindia.com header.b="N8x7vlFB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF45F47D
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717352632; cv=none; b=rbc+5IyFnMy5pLgE8IbtJQgO5AnlAA+SfRXclQoQ8TZXbYAf8jm9/xJPPmvPweEHC3niWvYe4Fx8BzIreBdoGxk8/3IbctjH0n+u6oTRP0zLT2d+lncGoHd21w5fQODvgO7SBw0Ny+8Rp2gRESRfDAbDxv4nWx/FWC4ZQXl1J2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717352632; c=relaxed/simple;
	bh=ihceLOVvR0nwHjgBARBH+l/TYW+SsN4lOD+imSWmAAc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qEEFcz04198Y8yel8E7GHK+Qo6d1yVbqpm2vHy9SgqGmjhjaf4B3LIhzVTbm3YXg9bM0f1dwDC9lh+zU/k88McG3mWta0EG3S6Yxc63IQT835oy5LR0JNz2n5Uevm39p5OUQyooK0IhqjAnCJu1GUkyzjcjMuAAez+NIZ3JaMsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unixindia.com; spf=pass smtp.mailfrom=unixindia.com; dkim=pass (2048-bit key) header.d=unixindia.com header.i=@unixindia.com header.b=N8x7vlFB; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unixindia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unixindia.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b90038cf7so1914849e87.0
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Jun 2024 11:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unixindia.com; s=mail; t=1717352629; x=1717957429; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dR0Cjhp5oEh5LjLKNirJaCQgU633cRhv38LAJrvoru4=;
        b=N8x7vlFBeTVrAFa9EZ45GwHVNjmyhHQiCxh63qhaczBcFDcKmF4moqF3bFOunWn2xR
         przNMtE6gUwA0upxcZqsVNbtpa2AlZee4AXqWAbU8K4jXfY4GCkpHW5bxMhccRGVvIIO
         CYyEcbCz7tUW+HOhtjoKX03tPjYDSwLJIjf8lcdscPQkSYhe1p1zqevYpBGe6gxIrwwl
         ms7N8MczweYD0LwZRSRHXpzv1YKhAl1NV48hAl98NZvz8bpP0aCX2MsccqAEXQgz/Q77
         cryxhIla+5ea7TrvCChfGHtYnSsDX6l4UYhxzTUVitcIkE2NP/wHCURWW798pHiXq1RS
         uC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717352629; x=1717957429;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dR0Cjhp5oEh5LjLKNirJaCQgU633cRhv38LAJrvoru4=;
        b=DTpJIClz7tmFVs+CKL1MJ03kRZzoN/kRI2gc5goRH59thg9LaDRrD+zr5ShWTFOPOV
         vDjFtAAQBuksV16ekLa9QdKbJsTK22lY6GCDSkE91AHUyM9rcOz++eygdITtSZrNfKAo
         eNFv0aZavSkWqH0Q3wbi4jbqD2JEcMNrJ6kPm/u/UpcRxbquFY1HN2+kVdKGvIHnnopq
         sIAhY6AT7SeCa+qdDzUC9EhdzbADgR+b86khjED5A9+iewbdzok8F9cFJpcvtTO4OYvK
         k2TUt2RtX3gtJf9GLvXVrgrRvtvZ8cm7rdGRYHWdMnTANKQhyzyIufn4LWsyGetg/JMI
         fc8w==
X-Gm-Message-State: AOJu0Yy9fim74Iwi0YaiXk27K/bi6zvDqDGFYr+ulZ8wSx7udJ4C6HiI
	pNdkACbQ41fVAS/nyQb02Fvsh7ffY5c9W5oIllT2PJI/ZY724QdXbxcSFOwoGtbbKJGThaGKUF+
	p2MhWJGJY0EGm9m+zfeHs08X3szSlPAAeMgxZqtWTU6C0JktgKps=
X-Google-Smtp-Source: AGHT+IEkI2pYUglViyt9rxbJT+DEYWlCku6PhcHZUWJMFqZeqiwOTJABddb7iy9oLa2y6Lr/NAQF9wS7M3TffGMfxXs=
X-Received: by 2002:a19:e052:0:b0:52b:307e:45bb with SMTP id
 2adb3069b0e04-52b8956b0bbmr3937549e87.15.1717352628551; Sun, 02 Jun 2024
 11:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bhasker C V <bhasker@unixindia.com>
Date: Sun, 2 Jun 2024 19:23:37 +0100
Message-ID: <CAPLCSGAAUMp4-xhcJ3hdFU1HCR-Uf+9q_i7OMr7Zpb+ybTRg0Q@mail.gmail.com>
Subject: several GB freespace missing
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Below is the status


$ sudo btrfs fi df .
Data, single: total=139.01GiB, used=136.63GiB
System, DUP: total=32.00MiB, used=48.00KiB
Metadata, DUP: total=1.00GiB, used=191.61MiB
GlobalReserve, single: total=169.20MiB, used=0.00B
$ sudo df -h .
Filesystem                Size  Used Avail Use% Mounted on
/dev/mapper/datafs        160G  138G   22G  87% /tmp/user/1000/data
$ sudo du -hs .
90G     .
$ sudo btrfs su li .
$

I have tried a btrfs balance with --dusage=90
I have scrubbed the data
I have done a full csum

I am not sure how to recover from the 48GB discrepancy

Please could someone tell me what is happening and how i can get back
my disk space ?

