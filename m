Return-Path: <linux-btrfs+bounces-3079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DEF875890
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 21:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA0D283DC0
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 20:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20425136995;
	Thu,  7 Mar 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1tAazbf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC23664AB6
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Mar 2024 20:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843856; cv=none; b=Ulxtr3l0NFUnJ8ru6z/Cn27kGJlyAZWZXQiumvzRhAJzE6XTOIuFPm+1DemjOtqTfLA+hcljBEjIaw0wVfcuOxcQ9Af/kN3j83GYNdcJZGNy5ZnLCvTWO0qn1V9pPlhV1OSXqDB88SDyKBHtDmcLGjrU53Awa+7PecNpwUG7bCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843856; c=relaxed/simple;
	bh=p3t9+cwf9pEemZLnhuOJq46ihKLiDNOEt27ZojVAqsE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bXDi8MtWAIGRYsCAmjbPO2sQ/XIWQOxcAcC6EgqYbjYR6+sreMaHfOOC97/fKghoBV7Rkogz101zpPFmAA9DrSiXijRE2AIAqylybd5yNVbAojI3na+2RIPOTf86PUnSxLgIJ5n5ncqwzTl0nXXSiUF6i5o30xeg4dHQZRIb+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1tAazbf; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so2392264276.0
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Mar 2024 12:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709843853; x=1710448653; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5O+Uuz0kcQH0BBNc9HRlRsJtmLUt60xUSB/INR2Qu6g=;
        b=m1tAazbfuAFusBrLsXQF6/CVMImBjwsVLaVGk6GBi7LGDls7ixbo+hA37spz1DikGT
         aRFomJRBuqn4nHNygBUpim/p2B9X/tK+cBJsYCFJ2Wy27ibi8O2FjWxbxWdb2XrVJ9X6
         K0vllKvP7qAja5K4OkCXIQ5GZlXQT+jCiaCXeZJSN5w7VDnefnn78UPE+GJQotMR2Fm5
         7hqsHBim3qNRl/BCE6e/Qu6U4F4/3x3cYtc10C2H3TvR++unc7isYJYicy6xxvDs7s+k
         Is3tR2MKR0i9pD97H9/IHTLVB1l+Y7jekv3/O4/+2u94LS8Kz9sSn4u+h4Ja5hfcTkgf
         YlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709843853; x=1710448653;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5O+Uuz0kcQH0BBNc9HRlRsJtmLUt60xUSB/INR2Qu6g=;
        b=YCkxrGkNpt1/VQQg1jJ6ZzWrXY3JzWGiq6M9vlPX/u/+jKx5zeBclAP4cqAPfe2+me
         uTz3OTQaImXn9lZkJy16A8E8cSJTTtjLhtA7taTZoI8Q9q8/DAlvZGTUmKLkvp05r88J
         aapl7mSjskWkbMrNq8mnLB/kuEQwWowvTewboi2uBHeKo9RzbuvjOI3uppIUJfuJrTS8
         kXFIXKyLuZ/EX40eNKVHD9KIOWcgjWDWNPcC2PWTznRIQtLbttTypRVPVhY/UDtd88Ai
         Fcuf5XXszg70Y8UY4ZK1mkYK3a1hDXV/65TL6UjxMDEIV6a7n+Lb5lYn4O+XzEf5nV+4
         0wrA==
X-Gm-Message-State: AOJu0YwN+v41Scz3y/12QYgWdxrD81bHdmNsmr168bb+hRJQHU1FxOZu
	hWl4ZnX9O2kfgObT3XwgLQoy5oXrbTXsAZPsqFzWqKV0JBUfIqtmEoB0cPqjOO4WfO1EGe+us7p
	3jvf0+bBZVBgwOEodtKl0jOT1ZFGUhNZyNQQ=
X-Google-Smtp-Source: AGHT+IHNSM+hJ0ObcAqlFnJlwTkYbHLL1fHox6dAgo9MCRql5axptT0lFjFJvwzkpP8jfSQWPzCG5Z9DtI4TxjvAxJY=
X-Received: by 2002:a25:2003:0:b0:dc6:daa4:e808 with SMTP id
 g3-20020a252003000000b00dc6daa4e808mr1861169ybg.12.1709843853428; Thu, 07 Mar
 2024 12:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michel Palleau <michel.palleau@gmail.com>
Date: Thu, 7 Mar 2024 21:37:22 +0100
Message-ID: <CAMFk-+igFTv2E8svg=cQ6o3e6CrR5QwgQ3Ok9EyRaEvvthpqCQ@mail.gmail.com>
Subject: scrub: last_physical not always updated when scrub is cancelled
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

While playing with the scrub operation, using cancel and resume (with
btrfs-progs), I saw that my scrub operation was taking much more time
than expected.
Analyzing deeper, I think I found an issue on the kernel side, in the
update of last_physical field.

I am running a 6.7.5 kernel (ArchLinux: 6.7.5-arch1-1), with a basic
btrfs (single device, 640 GiB used out of 922 GiB, SSD).

Error scenario:
- I start a scrub, monitor it with scrub status and when I see no
progress in the last_physical field (likely because it is scrubbing a
big chunk), I cancel the scrub,
- then I resume the scrub operation: if I do a scrub status,
last_physical is 0. If I do a scrub cancel, last_physical is still 0.
The state file saves 0, and so next resume will start from the very
beginning. Progress has been lost!

Note that for my fs, if I do not cancel it, I can see the
last_physical field remaining constant for more than 3 minutes, while
the data_bytes_scrubbed is increasing fastly. The complete scrub needs
less than 10 min.

I have put at the bottom the outputs of the start/resume commands as
well as the scrub.status file after each operation.

Looking at kernel code, last_physical seems to be rarely updated. And
in case of scrub cancel, the current position is not written into
last_physical, so the value remains the last written value. Which can
be 0 if it has not been written since the scrub has been resumed.

I see 2 problems here:
1. when resuming a scrub, the returned last_physical shall be at least
equal to the start position, so that the scrub operation is not doing
a step backward,
2. on cancel, the returned last_physical shall be as near as possible
to the current scrub position, so that the resume operation is not
redoing the same operations again. Several minutes without an update
is a waste.

Pb 1 is pretty easy to fix: in btrfs_scrub_dev(), fill the
last_physical field with the start parameter after initialization of
the context.
Pb 2 looks more difficult: updating last_physical more often implies
the capability to resume from this position.

Here are output of the different steps:

# btrfs scrub start -BR /mnt/clonux_btrfs
Starting scrub on devid 1
scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
Scrub started:    Thu Mar  7 17:11:17 2024
Status:           aborted
Duration:         0:00:22
        data_extents_scrubbed: 1392059
        tree_extents_scrubbed: 57626
        data_bytes_scrubbed: 44623339520
        tree_bytes_scrubbed: 944144384
        read_errors: 0
        csum_errors: 0
        verify_errors: 0
        no_csum: 1853
        csum_discards: 0
        super_errors: 0
        malloc_errors: 0
        uncorrectable_errors: 0
        unverified_errors: 0
        corrected_errors: 0
        last_physical: 36529242112

# cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
scrub status:1
4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:1392059|tree_e=
xtents_scrubbed:57626|data_bytes_scrubbed:44623339520|tree_bytes_scrubbed:9=
44144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:1853|csum_disc=
ards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|corrected_erro=
rs:0|last_physical:36529242112|t_start:1709827877|t_resumed:0|duration:22|c=
anceled:1|finished:1

# btrfs scrub resume -BR /mnt/clonux_btrfs
Starting scrub on devid 1
scrub canceled for 4c61ff6d-a903-42f6-b490-a3ce3690604e
Scrub started:    Thu Mar  7 17:13:07 2024
Status:           aborted
Duration:         0:00:07
        data_extents_scrubbed: 250206
        tree_extents_scrubbed: 0
        data_bytes_scrubbed: 14311002112
        tree_bytes_scrubbed: 0
        read_errors: 0
        csum_errors: 0
        verify_errors: 0
        no_csum: 591
        csum_discards: 0
        super_errors: 0
        malloc_errors: 0
        uncorrectable_errors: 0
        unverified_errors: 0
        corrected_errors: 0
        last_physical: 0

# cat scrub.status.4c61ff6d-a903-42f6-b490-a3ce3690604e
scrub status:1
4c61ff6d-a903-42f6-b490-a3ce3690604e:1|data_extents_scrubbed:1642265|tree_e=
xtents_scrubbed:57626|data_bytes_scrubbed:58934341632|tree_bytes_scrubbed:9=
44144384|read_errors:0|csum_errors:0|verify_errors:0|no_csum:2444|csum_disc=
ards:0|super_errors:0|malloc_errors:0|uncorrectable_errors:0|corrected_erro=
rs:0|last_physical:0|t_start:1709827877|t_resumed:1709827987|duration:29|ca=
nceled:1|finished:1

Best Regards,
Michel Palleau

