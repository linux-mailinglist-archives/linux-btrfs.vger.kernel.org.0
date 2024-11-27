Return-Path: <linux-btrfs+bounces-9933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A15009DA2F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 08:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30969B21B8A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 07:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298B014A0B3;
	Wed, 27 Nov 2024 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbD6a+4b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C51114
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732691996; cv=none; b=bBWXQnQ6oHO8+jBc+K23z65Be/9XCNNnVUuD4rft87CdssbjLanz/LMZpPfgCbbb3nZdgtmH1DwsT5/X2TJ2pC9DBihFJTCVRzZ/Ixsn5epJRexj6hPt6p4oDy8V40zWd6GoqJIKFe3ctGrOLuz0zoaF3/gjxyYU0/7L3U3y9Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732691996; c=relaxed/simple;
	bh=HFq+uqWEj126zlSPegQQSXm4ff8G3zBnDUl2AfXL6P8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jse8thdQFQZZtAwH7twn+FqTYYt4aYIKMw5U9wPggR1WMWM42R9Wr08BnzgbaD7TLVle6u4rjVOo1QyHzonD5LtK/o0UYccrEasvJfppXP6WYg89RjMUEVAo1SXk1+fYTCqcD6Kx0qsKjyWEC30JmTX34Wby6mHelhA6HQ7oLW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbD6a+4b; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e3824e1adcdso6103209276.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Nov 2024 23:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732691994; x=1733296794; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tVVb4SLlKr8883TE+CZqF+3tLMm51q7pBFSOiEzDKQo=;
        b=BbD6a+4bS/YbrRwOT4SGrF1HLsPpvnupXI2XLx2croGsgmtk1SruyNG6eGLldPPuWw
         awj1/fV5RI6B7eGS95E38Uu9Qvaz1An8hWZV2QAzoZEINhJcCngQMQyjtgObzdACf6kR
         NgBYvA13nq7FTaMNh3aPqVRojKGMRx8jGl5dbUhroLj+az7RU7Sn3fQgqoHBeqdYP42g
         IuWNpoNlp2McBhDv+NJoGqjwbWocZf7S5DE9O4LslHTvxI6/gVDOHWRBu1hR4p2mzXg2
         /tk4REGUVq3u7QbwyFP1uN9cbi+SJpq8zZoO3AhTFdFc9E14Gu47azmAJ9kDCLNcrVvl
         6/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732691994; x=1733296794;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVVb4SLlKr8883TE+CZqF+3tLMm51q7pBFSOiEzDKQo=;
        b=nVmxp5E903Tsml2NXkXbYtggI0dWB17A81fND+pncquqcxRrdKrsY6eKFz933m1LZZ
         HfkqvmnqBc9JYo1sAEVnij3AWj84UMhp+3GaBRnhRjWXWgJEWeL1elxL1zaJ2M7mTxAq
         uxEpbF2iTUHvYKOUFJEIQdQE7BHdygZFhzvs34CbZOzPxotfU1su3SL5SU4cWLg4skpY
         vsxjwRgfpZYu/XkzU8WRptCfUPbMB1yi4Ls0qm8ibNVXY/DLbVd45lekNTcSPRpQCE3N
         J1221WlaQYQS7MPSHaS2UXAbqwsZmE2YHqUOk7DX51vS3wTRvRGNjW5AkMATgT2NEGgN
         A6qg==
X-Gm-Message-State: AOJu0YwZOFIPkRyR2zYcsq7DMyUIAaQic7CDU8PTh2YXzusOWQDVE851
	cdwU1zcMP5Xx9VYvd7KMnvaHPi3ue/c9KNmXW9Ho5wzgHeTkjOMNdiMUlmrEvrzHfue5vOwUB01
	hFjg9gI5+UYbp3tuoFR4ymxqDZPemMMR9JNp+BQ==
X-Gm-Gg: ASbGncsJcUWSo1PmWEaov/dz55V1iwz7HCrvYpk+Qfo2WhJnTbVbBjIWvp8SBXPa9tl
	dszpgNM9e5jN2CL3NuwK3LOs46k/1kTL12dxnufFERa9B11KduWmXs7OUJJyogIDx
X-Google-Smtp-Source: AGHT+IEWpA0Tie/2O2t3iMr16MNW7HVJk5kXt6meWwsntpbIWHrwUz0U/6E9DsungswxRjBQ7+Pk5K0l6xUd4hcYOTM=
X-Received: by 2002:a05:6902:120b:b0:e28:f03e:fc2b with SMTP id
 3f1490d57ef6-e395b8d761amr1623325276.25.1732691993749; Tue, 26 Nov 2024
 23:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Wed, 27 Nov 2024 08:19:42 +0100
Message-ID: <CAFvQSYRxZ80O6cEVnU5_qG0HP2Lwn0LnBYmyy5EuCvX=Pa8ukQ@mail.gmail.com>
Subject: "fixed up error" during scrub reported multiple times for same logical
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

My raspberry pi 3 started to report "fixed up error" during its daily scrubs.

It first happend a week ago and was reported twice:

[842808.255024] BTRFS info (device mmcblk0p3): scrub: started on devid 1
[843029.896557] BTRFS error (device mmcblk0p3): fixed up error at
logical 10461577216 on dev /dev/mmcblk0p3 physical 7416512512
[843029.896603] BTRFS error (device mmcblk0p3): fixed up error at
logical 10461577216 on dev /dev/mmcblk0p3 physical 7416512512
[843065.684027] BTRFS info (device mmcblk0p3): scrub: finished on
devid 1 with status: 0

so I thought maybe some single-bit corruption of some sort.
In the following few days the error did not appear, up until today
when saw it reported 3 times:

[1534011.639564] BTRFS info (device mmcblk0p3): scrub: started on devid 1
[1534222.124239] BTRFS error (device mmcblk0p3): fixed up error at
logical 10461577216 on dev /dev/mmcblk0p3 physical 7416512512
[1534222.124291] BTRFS error (device mmcblk0p3): fixed up error at
logical 10461577216 on dev /dev/mmcblk0p3 physical 7416512512
[1534222.124302] BTRFS error (device mmcblk0p3): fixed up error at
logical 10461577216 on dev /dev/mmcblk0p3 physical 7416512512
[1534237.709186] BTRFS info (device mmcblk0p3): scrub: finished on
devid 1 with status: 0

I tried to find what is at the reported logical, but no luck:

btrfs inspect-internal logical-resolve -o 10461577216 /
ERROR: logical ino ioctl: No such file or directory

 the device stats still look harmless:
root@raspberrypi:~# btrfs dev stats /
[/dev/mmcblk0p3].write_io_errs    0
[/dev/mmcblk0p3].read_io_errs     0
[/dev/mmcblk0p3].flush_io_errs    0
[/dev/mmcblk0p3].corruption_errs  0
[/dev/mmcblk0p3].generation_errs  0

root@raspberrypi:~# btrfs fi df /
Data, single: total=8.01GiB, used=3.71GiB
System, DUP: total=32.00MiB, used=16.00KiB
Metadata, DUP: total=768.00MiB, used=284.06MiB
GlobalReserve, single: total=28.67MiB, used=0.00B

Does "fixed up" mean it was corrected with no corruption left?
And why is the same logical reported multiple times during a single scrub run?

Thanks & best regards, Clemens

