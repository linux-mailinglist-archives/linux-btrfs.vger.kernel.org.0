Return-Path: <linux-btrfs+bounces-12959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 387F0A8624D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 17:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35CB1BA1893
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Apr 2025 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2B920E03F;
	Fri, 11 Apr 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=olstad.com header.i=@olstad.com header.b="Cvvp3FnP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.domeneshop.no (smtp.domeneshop.no [194.63.252.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4ED82572
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Apr 2025 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.63.252.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386521; cv=none; b=t1Vk6tHkuHMqGb0cEgEPpHnG2+1b/dHkajKRW4p/khXO9m3Zt5zuuo/VWXGM8vks+dMnwB6jXzYSzbYpU6by4TyGZl8UIY3CZ7w/eFPZT31O7cezoowi8PcwtXksDkRTwMzhC7lOyEOWwUpNXf+8mCBg2HeNFdmNH1rOh9d4aqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386521; c=relaxed/simple;
	bh=43XrR95bv9HUHkFVwmP2wC/D6xMTCdpbtJ5Lk89xsN0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N73pGPwUiM9hKZy7cCedqwKdc3WDWVWQFUtUvBx1EnXMwdv6rnmkdedJSW8ULm1K900FsX0pU4wfmQ/z0+xB5jMXOfXY00IhiTsy0H+NbhizGReqipZpIxQDIiNRpHOzxsCaqRSlTASFILA288XKKxK7dXWyEI2nWzBj/VE1Z1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=olstad.com; spf=pass smtp.mailfrom=olstad.com; dkim=pass (2048-bit key) header.d=olstad.com header.i=@olstad.com header.b=Cvvp3FnP; arc=none smtp.client-ip=194.63.252.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=olstad.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=olstad.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=olstad.com;
	s=ds202407; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=cFipaOkSM/somI9HyFHj8aS3wkrf+nuCqyOaBeF66NA=; b=C
	vvp3FnPcIXeWNPItHe7qPYMejb4PmgQUH/gIDdTeYBZcEaitGTah8LZj6/OSPdMeT432O7kkUpOTE
	+a2iaYOzS0QPSNt8WDKDqDAFWZvIoTrrtTwHkj2HUnABLMPqaQ656fsjSq+LuCbS8nqAdMqE/Qam1
	TBBk5bRkEGfnmta9GbxEr23OdhIBS7h7M+H0iROBdM5plcREpCQWIOguplCKecMWmZfenWGZ0pDLs
	jHOOCjH0EwEo727AAw6Bnirsxbi9olR8OMlfsCyK62KrqnUAynsDov1kCYF1YvSZSUxkrxzaT4Bw4
	BGjXB/OBusnsjWduyflUVVkblPsdgUbuQ==;
Received: from smtp
	by smtp.domeneshop.no with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	id 1u3GcJ-00Avnx-5b
	for linux-btrfs@vger.kernel.org;
	Fri, 11 Apr 2025 17:48:31 +0200
Date: Fri, 11 Apr 2025 17:48:30 +0200
From: Kai Stian Olstad <btrfs+list@olstad.com>
To: linux-btrfs@vger.kernel.org
Subject: How to fix "BTRFS error (device dm-3): error writing primary super
 block to device 1"?
Message-ID: <n2evrtemnyldsra4jh3442h36v2tgi4pem5p7ramknkkabkooe@fre6ayihkaie>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Kubuntu 24.04
Kernel 6.8.0-57-generic

2 day ago I got a sector error on one of the BTRFS disk

$ journalctl -k -S 2025-04-09 | grep -A 20 mpt3sas_cm0
Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000): originator(PL), code(0x08), sub_code(0x0000)
Apr 09 03:16:26 cb kernel: mpt3sas_cm0: log_info(0x31080000): originator(PL), code(0x08), sub_code(0x0000)
Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=6s
Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Sense Key : Illegal Request [current]
Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 Add. Sense: Logical block address out of range
Apr 09 03:16:26 cb kernel: sd 4:0:1:0: [sdd] tag#5552 CDB: Write(16) 8a 08 00 00 00 00 00 00 10 80 00 00 00 08 00 00
Apr 09 03:16:26 cb kernel: critical target error, dev sdd, sector 4224 op 0x1:(WRITE) flags 0x23800 phys_seg 1 prio class 0
Apr 09 03:16:26 cb kernel: BTRFS warning (device dm-3): lost page write due to IO error on /dev/mapper/cdisk20 (-121)
Apr 09 03:16:26 cb kernel: BTRFS error (device dm-3): bdev /dev/mapper/cdisk20 errs: wr 2, rd 1, flush 0, corrupt 0, gen 0
Apr 09 03:16:26 cb kernel: BTRFS error (device dm-3): error writing primary super block to device 1
Apr 09 03:17:02 cb kernel: BTRFS error (device dm-3): error writing primary super block to device 1
Apr 09 03:17:02 cb kernel: BTRFS error (device dm-3): error writing primary super block to device 1
Apr 09 03:17:02 cb kernel: BTRFS error (device dm-3): error writing primary super block to device 1
Apr 09 03:17:02 cb kernel: BTRFS error (device dm-3): error writing primary super block to device 1
Apr 09 03:17:08 cb kernel: BTRFS error (device dm-3): error writing primary super block to device 1
Apr 09 03:17:10 cb kernel: BTRFS error (device dm-3): error writing primary super block to device 1
Apr 09 03:17:10 cb kernel: BTRFS error (device dm-3): error writing primary super block to device 1
Apr 09 03:17:27 cb kernel: BTRFS error (device dm-3): error writing primary super block to device 1
Apr 09 03:17:58 cb kernel: BTRFS error (device dm-3): error writing primary super block to device 1

And after that I constantly get "error writing primary super block to device
1". Tried to run "btrfs scrub status /data" but that didn't help

$ sudo btrfs scrub status /data
UUID:             6554e692-6c1c-4a69-8ff8-cb5615fb9200
Scrub started:    Thu Apr 10 19:40:56 2025
Status:           finished
Duration:         18:54:46
Total to scrub:   25.08TiB
Rate:             386.23MiB/s (some device limits set)
Error summary:    no errors found

/dev/sdd is /dev/mapper/cdisk20, it's running LUKS on top off sdd.

Does anyone know how to fix this?


Some output that might be useful:

$ sudo btrfs filesystem usage /data
Overall:
     Device size:                  29.11TiB
     Device allocated:             25.09TiB
     Device unallocated:            4.01TiB
     Device missing:                  0.00B
     Device slack:                    0.00B
     Used:                         25.08TiB
     Free (estimated):              2.01TiB      (min: 2.01TiB)
     Free (statfs, df):             2.01TiB
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)
     Multiple profiles:                  no

Data,RAID1: Size:12.52TiB, Used:12.52TiB (99.96%)
    /dev/mapper/cdisk20     4.45TiB
    /dev/mapper/cdisk21     4.45TiB
    /dev/mapper/cdisk22     8.08TiB
    /dev/mapper/cdisk23     8.08TiB

Metadata,RAID1: Size:23.03GiB, Used:19.93GiB (86.56%)
    /dev/mapper/cdisk20     8.03GiB
    /dev/mapper/cdisk21     8.03GiB
    /dev/mapper/cdisk22    15.00GiB
    /dev/mapper/cdisk23    15.00GiB

System,RAID1: Size:64.00MiB, Used:1.80MiB (2.81%)
    /dev/mapper/cdisk22    64.00MiB
    /dev/mapper/cdisk23    64.00MiB

Unallocated:
    /dev/mapper/cdisk20     1.00TiB
    /dev/mapper/cdisk21     1.00TiB
    /dev/mapper/cdisk22     1.00TiB
    /dev/mapper/cdisk23     1.00TiB


$ sudo btrfs device stats /data | grep -v " 0$"
[/dev/mapper/cdisk20].write_io_errs    2
[/dev/mapper/cdisk20].read_io_errs     1
[/dev/mapper/cdisk21].write_io_errs    1
[/dev/mapper/cdisk21].read_io_errs     1


-- 
Kai Stian Olstad

