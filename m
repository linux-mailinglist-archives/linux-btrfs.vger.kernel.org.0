Return-Path: <linux-btrfs+bounces-19336-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC289C8578D
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 15:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2673AF8CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF36E32694D;
	Tue, 25 Nov 2025 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="Ttj060nU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7454A32571B
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081748; cv=none; b=ajx8S18YnAQVXEIPKCVkuUoKGQIoQEnqWaCzY/G3Df130qZ3hkkqSRlCBS+G2eFG9COFxhTQqxA3k+xco5vVkrkfdBFBk6owUe5k5oI73f4hb1GCmRD8nqzd2EOhUYiwWtKddvY24TgknT8JP3U7/Td0Ngzv7ZQXo8gc9Lu3pbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081748; c=relaxed/simple;
	bh=47pokBKKEFg7fqMU6ZymUGp2WYqWOxlE3HZsS2pZ6FM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=I80TfvyFooKTV94/c4koNPI4y/j+RbwR6NN44TWi8TPrlN5cPQkBdda2DsuIkqN/b550ZKIrwq3lUK6SIsr4CzTmahsew3J8GsZvdhbS0Zbw6GxScl8UqFGgW0ijbOOQUaIQeH7AHqs1Q7Mprhn7InBhHUmpmfsXENY+F3LqeMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com; spf=pass smtp.mailfrom=lucidpixels.com; dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b=Ttj060nU; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucidpixels.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c77fc7c11bso4035015a34.1
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 06:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1764081745; x=1764686545; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KaxA4URZMnkQPOL5VrfQqCvsZMWSgJ6OMNVogesAF0M=;
        b=Ttj060nUzPe5Flz67AQ9OHJrHYzCRtTN78tE8HsuVcNv5zA2VeSYhocquv+Vz3Exn5
         U8Wy8UJ2c8WzHStZq9heAppTq+SwvY1XsA55hcwWvehqFa1agmlxwCklvMa3DDkTm7vQ
         72sweFQkJfnwlWuWojFJ2EhuNjyYtsWvb0QDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764081745; x=1764686545;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaxA4URZMnkQPOL5VrfQqCvsZMWSgJ6OMNVogesAF0M=;
        b=MCvrnGiCTZKJrdPP8VVwPGozEIRQR9U0fUsdT79u8NX/67CHxnMXEJZKsh7t2QmOSk
         RDomrCJtTpRS9OWJ2WnPlcph6WqiuDm+cxQNUp+xnOEl2CqgZSEFZsK7jZPQcN6rWBie
         x8K30D+qJpt8V3aAG3VPmyziKH17rMirpEVhNO74jjyA3lV8Tmn3aZC7pbwhmUNZXiqd
         HTBmxNa8xfSb1Ne0oEtdAUELAlThmRVh3pZnja711+NxnO1RXz1IVLkeYfuA32S2lNKX
         DuOqX2aMmImJS9RRGGrBYZlFUTYwH0NIW2p1iZoaJT5u/3O4iiGtxZBqZ3vY9IC0053m
         pKyg==
X-Forwarded-Encrypted: i=1; AJvYcCVDEl5h9NJy/Fknw7reysQq7e+zVNhulryh8N6gq34pBk1suhxjEb4JNAY/pBUuAHFe0qgVRHv/nVPWmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ESjwC5OC5ZWp29es5NxUh+lklvRcB85MLN1NFv6ET7UVcHct
	8prC7Zc/RA72pO288wizEDGLNCMFMi58hcjPKcRIcSgs4Krgm/E0xqIxwaM/Pvh60jLOQ4bcHip
	vyXUM4S2pRLoB6bYcYenSgVLRhKEJ15Kh7qTCrSpX5A==
X-Gm-Gg: ASbGncu5eMaZzeNfBVPYhvlNk0WOIhLBspzqeSnswUruIzNYsLdkCIdhf6a2yO4vP6a
	sHsLSxk1KIxDf5drbqXGucTVl3G2/bLYzzMXL8ISW/pr3UdT5yiYGnZ1fxq5YsaQOeRpEWnh4Bf
	aXKFwl3HUjOHGhBPmtNtgX7yLA0+oZdcTahh/OYU7MTDoGEOCKQl3RWLC2mp9EzTJjtdKqDIYB+
	QLU9qTfI04HMN8pQfKjvcSnhDbueR1++ZqoVilyN/2Rner2nGQ7n/1RSG/GfMM6zLeTERUl+mC0
	Rnv6cYBafOqV0RbpJG/laOjPQHzq1PFrD+LkEmRAugldeOgP0DdTUmL6Id5wp4k=
X-Google-Smtp-Source: AGHT+IF6nb0XFEY4hvcPmD684X1LLVnE8WIkq4uAC1EOIPxVrPDPf3pSobV7ttGqY8U/2wHv22LJA0oZ+NuEWodb+x4=
X-Received: by 2002:a05:6830:252:b0:7c7:1a6:6a09 with SMTP id
 46e09a7af769-7c798bf2716mr5653494a34.17.1764081745530; Tue, 25 Nov 2025
 06:42:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Tue, 25 Nov 2025 09:42:11 -0500
X-Gm-Features: AWmQ_bk5BLfGjtbuPG45HuYMv-wNYW6cT8NjghdCxB7iHGsDTxTzucuMonB00cg
Message-ID: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
Subject: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting reset, CSTS=0x1)
To: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-raid@vger.kernel.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

Issue/Summary:
1. Usually once a month, a random WD Red SN700 4TB NVME drive will
drop out of a NAS array, after power cycling the device, it rebuilds
successfully.

Details:
0. I use an NVME NAS (FS6712X) with WD Red SN700 4TB drives (WDS400T1R0C):
1. Ever since I installed the drives, there will be a random drive
that drops offline every month or so, almost always when the system is
idle.
2. I have troubleshot this with Asustor and WD/SanDisk.
3. Asustor noted that they did have other users with the same
configuration running into this problem.
4. When troubleshooting with WD/SanDisk's it was noted my main option
is to replace the drive, even though the issue occurs across nearly
all of the drives.
5. The drives are up to date currently according to the WD Dashboard
(when removing them and checking them on another system).
6. As for the device/filesystem, the FS6712X's configuration is
MD-RAID6 device with BTRFS on-top of it.
7. The "workaround" is to power cycle the FS6712X and when it boots up
the MD-RAID6 re-syncs back to a healthy state.

I am using the latest Asus ADM/OS which uses the 6.6.x kernel:
1. Linux FS6712X-EB92 6.6.x #1 SMP PREEMPT_DYNAMIC Tue Nov  4 00:53:39
CST 2025 x86_64 GNU/Linux

Questions:
1. Have others experienced this failure scenario?
2. Are there identified workarounds for this issue outside of power
cycling the device when this happens?
3. Are there any debug options that can be enabled that could help to
pinpoint the root cause?
4. Within the BIOS settings, which starts 2:18 below there are some
advanced settings that are shown, could there be a power saving
feature or other setting that can be modified to address this issue?
4a. https://www.youtube.com/watch?v=YytWFtgqVy0

[1] The last failures have been at random times on the following days:
1. August 27, 2025
2. September 19th, 2025
3. September 29th, 2025
4. October 28th, 2025
5. November 24, 2025

Chipset being used:
1. ASMedia Technology Inc.:ASM2806 4-Port PCIe x2 Gen3 Packet Switch

Details:

1. August 27, 2025
[1156824.598513] nvme nvme2: I/O 5 QID 0 timeout, reset controller
[1156896.035355] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
[1156906.057936] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
[1158185.737571] md/raid:md1: Disk failure on nvme2n1p4, disabling device.
[1158185.744188] md/raid:md1: Operation continuing on 11 devices.

2. September 19th, 2025
[2001664.727044] nvme nvme9: I/O 26 QID 0 timeout, reset controller
[2001736.159123] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
[2001746.180813] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
[2002368.631788] md/raid:md1: Disk failure on nvme9n1p4, disabling device.
[2002368.638414] md/raid:md1: Operation continuing on 11 devices.
[2003213.517965] md/raid1:md0: Disk failure on nvme9n1p2, disabling device.
[2003213.517965] md/raid1:md0: Operation continuing on 11 devices.

3.  September 29th, 2025
[858305.408049] nvme nvme3: I/O 8 QID 0 timeout, reset controller
[858376.843140] nvme nvme3: Device not ready; aborting reset, CSTS=0x1
[858386.865240] nvme nvme3: Device not ready; aborting reset, CSTS=0x1
[858386.883053] md/raid:md1: Disk failure on nvme3n1p4, disabling device.
[858386.889586] md/raid:md1: Operation continuing on 11 devices.

4. October 28th, 2025
[502963.821407] nvme nvme4: I/O 0 QID 0 timeout, reset controller
[503035.257391] nvme nvme4: Device not ready; aborting reset, CSTS=0x1
[503045.282923] nvme nvme4: Device not ready; aborting reset, CSTS=0x1
[503142.226962] md/raid:md1: Disk failure on nvme4n1p4, disabling device.
[503142.233496] md/raid:md1: Operation continuing on 11 devices.

5. November 24th, 2025
[1658454.034633] nvme nvme2: I/O 24 QID 0 timeout, reset controller
[1658525.470287] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
[1658535.491803] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
[1658535.517638] md/raid1:md0: Disk failure on nvme2n1p2, disabling device.
[1658535.517638] md/raid1:md0: Operation continuing on 11 devices.
[1659258.368386] md/raid:md1: Disk failure on nvme2n1p4, disabling device.
[1659258.375012] md/raid:md1: Operation continuing on 11 devices.


Justin

