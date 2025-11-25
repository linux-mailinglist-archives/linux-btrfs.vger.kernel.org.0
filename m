Return-Path: <linux-btrfs+bounces-19348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCA5C86D2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 20:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 539234E9E66
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18B733A705;
	Tue, 25 Nov 2025 19:33:48 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A42C21C7;
	Tue, 25 Nov 2025 19:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.233.160.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764099228; cv=none; b=KqmAsChmGxyF1uXZ/BoBZfm5BlblCGYhb1ItVB30ur7MuMLPaAqBk2EM2h7PN774iLBIdq2iqYqyjPQwDnzuXRQYHe5gcc+9tEwsqn+ZBgXqpGkE8vlI1eID1FgzYy7xaLot1a0REiOcTQutb6gIFDLxfHc/9xXLucJqBLmmP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764099228; c=relaxed/simple;
	bh=Z8d8L6t2ZQbsqUZOaECLuvsJzlawxs9TeUIbzgV4MZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hX9gpsRawHRbtODVBF2vovhjvUs65LHZEjIsZ9q54qP8SqYZJJjSH/vVctXQcvzDSjM2PglLjarKrfac5m7gx+Go6msQEK95v4VMZox1mzYFxm+TwyBzsM1Lhv2huwWkno58QPRVdDgD+kda/G57tmrNniNW/sKsizuoR95CtpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=youngman.org.uk; spf=fail smtp.mailfrom=youngman.org.uk; arc=none smtp.client-ip=85.233.160.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=youngman.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=youngman.org.uk
Received: from host51-14-94-149.range51-14.btcentralplus.com ([51.14.94.149] helo=[192.168.1.171])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <antlists@youngman.org.uk>)
	id 1vNxi2-000000001rw-87yg;
	Tue, 25 Nov 2025 18:24:15 +0000
Message-ID: <07500979-eca8-4159-b2a5-3052e9958c84@youngman.org.uk>
Date: Tue, 25 Nov 2025 18:25:41 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
To: Justin Piszcz <jpiszcz@lucidpixels.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 linux-raid@vger.kernel.org, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
Content-Language: en-US
From: Wol <antlists@youngman.org.uk>
In-Reply-To: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Probably not the problem, but how old are the drives? About 2020, WD 
started shingling the Red line (you had to move to Red Pro to get 
conventional drives). Shingled is bad news for linux raid, but the fact 
your drives tend to drop out when idling makes it unlikely this is the 
problem.

Cheers,
Wol

On 25/11/2025 14:42, Justin Piszcz wrote:
> Hello,
> 
> Issue/Summary:
> 1. Usually once a month, a random WD Red SN700 4TB NVME drive will
> drop out of a NAS array, after power cycling the device, it rebuilds
> successfully.
> 
> Details:
> 0. I use an NVME NAS (FS6712X) with WD Red SN700 4TB drives (WDS400T1R0C):
> 1. Ever since I installed the drives, there will be a random drive
> that drops offline every month or so, almost always when the system is
> idle.
> 2. I have troubleshot this with Asustor and WD/SanDisk.
> 3. Asustor noted that they did have other users with the same
> configuration running into this problem.
> 4. When troubleshooting with WD/SanDisk's it was noted my main option
> is to replace the drive, even though the issue occurs across nearly
> all of the drives.
> 5. The drives are up to date currently according to the WD Dashboard
> (when removing them and checking them on another system).
> 6. As for the device/filesystem, the FS6712X's configuration is
> MD-RAID6 device with BTRFS on-top of it.
> 7. The "workaround" is to power cycle the FS6712X and when it boots up
> the MD-RAID6 re-syncs back to a healthy state.
> 
> I am using the latest Asus ADM/OS which uses the 6.6.x kernel:
> 1. Linux FS6712X-EB92 6.6.x #1 SMP PREEMPT_DYNAMIC Tue Nov  4 00:53:39
> CST 2025 x86_64 GNU/Linux
> 
> Questions:
> 1. Have others experienced this failure scenario?
> 2. Are there identified workarounds for this issue outside of power
> cycling the device when this happens?
> 3. Are there any debug options that can be enabled that could help to
> pinpoint the root cause?
> 4. Within the BIOS settings, which starts 2:18 below there are some
> advanced settings that are shown, could there be a power saving
> feature or other setting that can be modified to address this issue?
> 4a. https://www.youtube.com/watch?v=YytWFtgqVy0
> 
> [1] The last failures have been at random times on the following days:
> 1. August 27, 2025
> 2. September 19th, 2025
> 3. September 29th, 2025
> 4. October 28th, 2025
> 5. November 24, 2025
> 
> Chipset being used:
> 1. ASMedia Technology Inc.:ASM2806 4-Port PCIe x2 Gen3 Packet Switch
> 
> Details:
> 
> 1. August 27, 2025
> [1156824.598513] nvme nvme2: I/O 5 QID 0 timeout, reset controller
> [1156896.035355] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
> [1156906.057936] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
> [1158185.737571] md/raid:md1: Disk failure on nvme2n1p4, disabling device.
> [1158185.744188] md/raid:md1: Operation continuing on 11 devices.
> 
> 2. September 19th, 2025
> [2001664.727044] nvme nvme9: I/O 26 QID 0 timeout, reset controller
> [2001736.159123] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
> [2001746.180813] nvme nvme9: Device not ready; aborting reset, CSTS=0x1
> [2002368.631788] md/raid:md1: Disk failure on nvme9n1p4, disabling device.
> [2002368.638414] md/raid:md1: Operation continuing on 11 devices.
> [2003213.517965] md/raid1:md0: Disk failure on nvme9n1p2, disabling device.
> [2003213.517965] md/raid1:md0: Operation continuing on 11 devices.
> 
> 3.  September 29th, 2025
> [858305.408049] nvme nvme3: I/O 8 QID 0 timeout, reset controller
> [858376.843140] nvme nvme3: Device not ready; aborting reset, CSTS=0x1
> [858386.865240] nvme nvme3: Device not ready; aborting reset, CSTS=0x1
> [858386.883053] md/raid:md1: Disk failure on nvme3n1p4, disabling device.
> [858386.889586] md/raid:md1: Operation continuing on 11 devices.
> 
> 4. October 28th, 2025
> [502963.821407] nvme nvme4: I/O 0 QID 0 timeout, reset controller
> [503035.257391] nvme nvme4: Device not ready; aborting reset, CSTS=0x1
> [503045.282923] nvme nvme4: Device not ready; aborting reset, CSTS=0x1
> [503142.226962] md/raid:md1: Disk failure on nvme4n1p4, disabling device.
> [503142.233496] md/raid:md1: Operation continuing on 11 devices.
> 
> 5. November 24th, 2025
> [1658454.034633] nvme nvme2: I/O 24 QID 0 timeout, reset controller
> [1658525.470287] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
> [1658535.491803] nvme nvme2: Device not ready; aborting reset, CSTS=0x1
> [1658535.517638] md/raid1:md0: Disk failure on nvme2n1p2, disabling device.
> [1658535.517638] md/raid1:md0: Operation continuing on 11 devices.
> [1659258.368386] md/raid:md1: Disk failure on nvme2n1p4, disabling device.
> [1659258.375012] md/raid:md1: Operation continuing on 11 devices.
> 
> 
> Justin
> 


