Return-Path: <linux-btrfs+bounces-18825-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED93C47679
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 16:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9696E3B3178
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCF6314B8B;
	Mon, 10 Nov 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="RFfe2ZWV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8516831283C
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762787156; cv=none; b=fqnaUYClWGvU66HZdhX+cD0ZXh4vRQVJmtznPrGcv2qx7H6DyWCzVfziHySWb4SO4PAuDGjXn12DHIvV6xZxkIqOuBDuf6JDM1yNzvcxmKTp0DphDZCUFUkaReMFFRO9x7yk7Jrebli6w8oizNgyuiq1GIjITPG3Wg+1Roa4pC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762787156; c=relaxed/simple;
	bh=ttMGV4ji7PEauoV/o1iK6oxHp8qZmD2Kij9bYr2V9XE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rkNctzBtul67YJAZaxukUdsOm1cOP1QLntRaIH0anUh13BX3Wws47B8aRzs8bjuUU6N4P71JwTYDeGGA42KZ2DOYgB3oLoKsHyMTQrX6cUDLlY858RZXsXI1McM7PNyh3QqPNXGQLRWcuVi72SvxT2m8us55wLaYAgYAhrBkTmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com; spf=pass smtp.mailfrom=lucidpixels.com; dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b=RFfe2ZWV; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucidpixels.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c707e11e01so1205379a34.0
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 07:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1762787153; x=1763391953; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1lipY9QbVC+MroILyK555ciCKhF20zonjS3pDPXtaDU=;
        b=RFfe2ZWVUgZFY0nfHB3CT0roOQw9iXxEGr7W0AxhxjYWBCksrTC0NlqBm/vglYZOE6
         P1FZD7sQ0jCCC5Dfv5+temeztaeA6nW2RXL5MKC/5APUAcf0SLO71/0KH15wHAOBVTX3
         MdeDGXO3wUUtDG2H/bTlFWjI0P37PmN4tRTCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762787153; x=1763391953;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lipY9QbVC+MroILyK555ciCKhF20zonjS3pDPXtaDU=;
        b=slnABggEGXvAr9Sc7sv140z0Z1hVODPMTvUtho1GvwbLovi2d6xTUQ7rhxttvUcozh
         QiAqBi0iLT+ZagZVOi2t69feiPyKm/sKG9Atre9we2IWPanE+0MiXZs5NT7XNMkyytsQ
         9KdUt/2nN4VVqp5POcRfJrh0wEw4IrFPb5jzCbClZ2Oysu9oqM0c8hWmAdkplNkEfRL7
         lovNm4GCiVXQQngP9ms5WkCVxzt5IrchY2VPeHOPbEs3X4T5cqktm7sKDeHrRr47O0A2
         foKmY4JVD9yMhEJRUDlDmGddJJ+NVma2kNlt+tdewHtsfCQagEAJKbvruOe7CqMFmhmg
         kP1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8n1hHWcmixIyViucpezawXsmr924GNs5++s19p798LLYLvRUenjiwCw2LLtgsxA50qgouA05nSRnl2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YysFUZ7uARQQUVNPEstq1pCiZdfRVNcprLes+p0PWtRKVuk3Q/Y
	Tw7OUe5vGB1EAiZjk5KR8ufrsVfwnDd7QIEySYqkeihMzbrg8RiVDj0w+fY0O09QSR1Qco5KcJ0
	BCojskd6sNMK2iZrkkiIOmPZrQV6jJYIhHdp80jjezwHUiZV98PDqOlJWUg==
X-Gm-Gg: ASbGncvOYqQgyjX/E6L0nhL+Lq8jkxrhg0Wk4WxKsVkO+lcLFj+W6BioxIj9HYUxNFG
	ht0AiFJV40vPFaYfnWLnpLi4bsGfnoyq2/hrmIq9NveZoiPVd6UU+548ZE8Tcfcf6wWbgwW7nGG
	y+/0GLPqrWIJGrA4oEa1S0d6tpBIqbV/R5IUzels6oUVdM0RdQMz/CQViVtNYNCZWkFzKXTZ6CU
	PYUssJGNG5SNcUF4ViyjUgEVGZp7TXLN+c3sN/nO064b6jXX8+DwDx1SU9anMCT3NKxz3IpuIMJ
	WP5sPgPQnYkDLA3A+QWB10NMjn6Kfm74a9xP8Rq24/ygo4YMHv1l
X-Google-Smtp-Source: AGHT+IFan1SKZkegWjFipuqrmBsPPn1L4WMTGDRVH9+b6sgbYyCnCxve3NhDkBtS0E0yYGbrdldI8CiLci1LPoz0e9Q=
X-Received: by 2002:a05:6808:1a14:b0:450:c09:92aa with SMTP id
 5614622812f47-4502a170764mr4818520b6e.12.1762787153521; Mon, 10 Nov 2025
 07:05:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Mon, 10 Nov 2025 10:05:42 -0500
X-Gm-Features: AWmQ_bmOZ6GPZybsHZWCOdfXcI4U6R6JmF1g-mPLfzn0Y85G-uzU-0CE5bPwbtk
Message-ID: <CAO9zADwMjaMp=TmgkBDHVFxdj5FVHtjTn_6qvFaTcAjpbaDSWg@mail.gmail.com>
Subject: BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 37868055...
To: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am using an ASUS Pro WS W680-ACE motherboard with 2 x Samsung SSD
990 PRO with Heatsink 4TB NVME SSDs with BTRFS R1.  When a BTRFS scrub
was kicked off this morning, suddenly BTRFS was noting errors for one
of the drives.  The system became unusable and I had to power cycle
and re-run the scrub and everything is now OK.  My question is what
would cause this?

Distribution: Debian Stable
Kernel: 6.12.48+deb13-amd64

Drive information (for both drives)
-------------------------------------------------
Drive1:
Model Number:                       Samsung SSD 990 PRO with Heatsink 4TB
Firmware Version:                   4B2QJXD7
Drive2:
Model Number:                       Samsung SSD 990 PRO with Heatsink 4TB
Firmware Version:                   4B2QJXD7

btrfsd scrub configuration:
-------------------------------------------------
stats_interval=1h
scrub_interval=1M
balance_interval=never

Errors:
-------------------------------------------------
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868055, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868056, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868057, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868058, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868059, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868060, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:29 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868061, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:30 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868062, rd 39712434, flush 583, corrupt 0,
gen 0
Nov 10 02:00:30 machine1 kernel: BTRFS error (device nvme1n1p2): bdev
/dev/nvme0n1p2 errs: wr 37868063, rd 39712434, flush 583, corrupt 0,
gen 0

Prior to reboot:
-------------------------------------------------
[/dev/nvme0n1p2].write_io_errs    0
[/dev/nvme0n1p2].read_io_errs     0
[/dev/nvme0n1p2].flush_io_errs    0
[/dev/nvme0n1p2].corruption_errs  0
[/dev/nvme0n1p2].generation_errs  0
[/dev/nvme2n1p2].write_io_errs    130766017
[/dev/nvme2n1p2].read_io_errs     137924767
[/dev/nvme2n1p2].flush_io_errs    5054
[/dev/nvme2n1p2].corruption_errs  2216
[/dev/nvme2n1p2].generation_errs  0

After reboot + scrub + clear counters & second scrub:
-------------------------------------------------
[/dev/nvme0n1p2].write_io_errs    0
[/dev/nvme0n1p2].read_io_errs     0
[/dev/nvme0n1p2].flush_io_errs    0
[/dev/nvme0n1p2].corruption_errs  0
[/dev/nvme0n1p2].generation_errs  0
[/dev/nvme2n1p2].write_io_errs    0
[/dev/nvme2n1p2].read_io_errs     0
[/dev/nvme2n1p2].flush_io_errs    0
[/dev/nvme2n1p2].corruption_errs  0
[/dev/nvme2n1p2].generation_errs  0


Smart tests (short/long are showing successful for both drives)
-------------------------------------------------
Drive1:
Self-test Log (NVMe Log 0x06)
Self-test status: No self-test in progress
Num  Test_Description  Status                       Power_on_Hours
Failing_LBA  NSID Seg SCT Code
 0   Extended          Completed without error               16373
       -     -   -   -    -
 1   Short             Completed without error               16373
       -     -   -   -    -
Drive2:
Self-test Log (NVMe Log 0x06)
Self-test status: No self-test in progress
Num  Test_Description  Status                       Power_on_Hours
Failing_LBA  NSID Seg SCT Code
 0   Extended          Completed without error               16369
       -     -   -   -    -
 1   Short             Completed without error               16368
       -     -   -   -    -

Justin

