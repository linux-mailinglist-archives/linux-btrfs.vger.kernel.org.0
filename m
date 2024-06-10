Return-Path: <linux-btrfs+bounces-5613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186A490296D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 21:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AAC1C21DAC
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 19:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BE614D6E9;
	Mon, 10 Jun 2024 19:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTMNH22V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA51EB5B
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048316; cv=none; b=RgREPl2RAZY5Tp//4rbeRqPovLNdMNgNH+lJ6Yhn+pd0isq/yrbSfvwbhQB0bVvmwYmr7sCdweDyS/8Wrz1UYEghLG6TAEEWhnharADPwQrTWnFw8Wem1h4Ovgz/IQZtCukLg2jsx6hZfeFNyghzPwp9hvu4+H5x2MsUzVplYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048316; c=relaxed/simple;
	bh=0iZt9CPNhUqSS+AKJVHbUoFx+O0b7cjnOUkpNp+ILX8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=N9iGp3CZ2SHbpTcsyNR2NkIVC6zynmR7By00XDd28VsANB6p1zKYbfuoCSnwVIwziIdA10n7ULAqUjmU22y19w+VcSFcUePlG9vIiO8uZQdG+cfJCB+vddvld5AWNrKA3L1q+kefANsK9PaPzqqCv8OvIaMINWn+YfDspt76mUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTMNH22V; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d229baccc4so706841b6e.1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jun 2024 12:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718048313; x=1718653113; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tY0Pp4qtsf7uLiHhxOgjZnhx3DE3zz6i2inXY35FHJ0=;
        b=UTMNH22ViJt6xUpVBkivxEzZNHhi3NFHr+CiKBbbbsG6B0ahgk/RZVHPU7K2hb0wTr
         ldMumwypN5a5MoxDZufSr4YET2efShSz0Vx+uz0WaZ9lFAwDpZF9n1/ETXFxM3ojgYiT
         Ah4sFKGPwf/+LAa0+S18YQN+/Hxp4R+g/TIAi/11uJdRZDBISTBghT2vghKB4XFcI++w
         eNYM3Deq5+qrCm1A925TRHEYoGmnsp4FH7I97Eekw49g2pDafx9YGefkf5YNggT/FBxL
         Y5zB4Mkv9oshyvGpOGkb6aNQ3xm7dYFuwo6Krq7e0xdeB4MgTSxdS2xheIgg6oGKB70Z
         Tb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718048314; x=1718653114;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tY0Pp4qtsf7uLiHhxOgjZnhx3DE3zz6i2inXY35FHJ0=;
        b=LWweOAYDNYgw6ju3Xo1fwn9QGRr5qpQM9Har5EeYNfxelZA9fi7MAyfVPq48GtpDbN
         K9P/Pkseah7V+TyQvRaob7Ko9IfzCXpFXT3Z0639MFj167ZYvXc3gE+tKgHr/aG6w0mO
         q6gbi9VFk7SP8Vx1RocflLV4TJ4Vxq5UIeV8wNgd2qnEfFXt1cMAQjtcuJl6MEDYd9RS
         i+kmTnDs0vypSPEwKAh8rZb5fKzPF0vg4CMk5IHoMNjMb98JSEWOb8MeSChCFXd5B2NB
         5ZQiSUvHNpX0i+dLfOkmoD5XwfKxrWAQlO/TnBW684kiy2580Pt6UcYMqOXXiSK8xDcT
         r0wA==
X-Gm-Message-State: AOJu0YwuGX4pH+fwRXtdRnh6gv7pSuUHDl6fjUpE1gZR8MriMGfkfz3i
	BnwsmCb3328ur3SBkijmZA8gdfDcbc9JF5LvX297vwymT8Q9xCFS/THtzw==
X-Google-Smtp-Source: AGHT+IHc5Iu4RccNTp/K3gv7VrysUDN//ook5aG1aVDphHLZOebV9Ywe/Q24QJovbFiJHyBvhZ5FSg==
X-Received: by 2002:a05:6808:15a1:b0:3d1:4261:6450 with SMTP id 5614622812f47-3d210f24e03mr13140806b6e.39.1718048313187;
        Mon, 10 Jun 2024 12:38:33 -0700 (PDT)
Received: from [192.168.0.92] (syn-070-123-236-219.res.spectrum.com. [70.123.236.219])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d23299ebd9sm154745b6e.58.2024.06.10.12.38.32
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 12:38:32 -0700 (PDT)
Message-ID: <35e67c45-b0da-49ff-99e5-8393b93bd2d0@gmail.com>
Date: Mon, 10 Jun 2024 14:38:31 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: btrfs-6.9 misc-tests.sh failures
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

failed: /build/btrfs/btrfs-progs-v6.9/btrfs balance start -mconvert=single 
-sconvert=single -f /build/btrfs/btrfs-progs-v6.9/tests/mnt
test failed for case 004-shrink-fs

The misc-tests-results.txt gives:

====== RUN CHECK /build/btrfs/btrfs-progs-v6.9/btrfs filesystem resize 8091860992 
/build/btrfs/btrfs-progs-v6.9/tests/mnt
Resize device id 1 (/dev/loop0) from 7.54GiB to 7.54GiB
====== RUN CHECK /build/btrfs/btrfs-progs-v6.9/btrfs balance start -mconvert=single 
-sconvert=single -f /build/btrfs/btrfs-progs-v6.9/tests/mnt
ERROR: error during balancing '/build/btrfs/btrfs-progs-v6.9/tests/mnt': No space 
left on device
There may be more info in syslog - try dmesg | tail
failed: /build/btrfs/btrfs-progs-v6.9/btrfs balance start -mconvert=single 
-sconvert=single -f /build/btrfs/btrfs-progs-v6.9/tests/mnt
test failed for case 004-shrink-fs

How much space is needed?  On my /build partition:

SOURCE         TARGET    FSTYPE     SIZE   USED AVAIL USE%
/dev/nvme0n1p7 /build    ext4       245G 141.2G 91.3G  58%

Disabling case 004-shrink-fs the next issue is

====== RUN MUSTFAIL /build/btrfs/btrfs-progs-v6.9/btrfs subvolume delete 
/build/btrfs/btrfs-progs-v6.9/tests/mnt/snap1
Delete subvolume 257 (no-commit): '/build/btrfs/btrfs-progs-v6.9/tests/mnt/snap1'
succeeded (unexpected!): /build/btrfs/btrfs-progs-v6.9/btrfs subvolume delete 
/build/btrfs/btrfs-progs-v6.9/tests/mnt/snap1
unexpected success: deleting default subvolume by path succeeded
test failed for case 041-subvolume-delete-during-send

I do not have any insight into this issue.

After disabling 041-subvolume-delete-during-send all other tests pass.

-----

Note, the reason we run tests in linuxfromscratch it to give users confidence in the 
packages built.  We can just disable some tests and label them as known errors,
but it seems that an important package like btrfs should test clean.   If the test 
failures are something we have done wrong, we would like to fix it.

   -- Bruce Dubbs
      linuxfromscratch.org

