Return-Path: <linux-btrfs+bounces-7476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8A495E0C7
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2024 05:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54892B20A81
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2024 03:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF16AD39;
	Sun, 25 Aug 2024 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="J5zw1i02"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9232576F
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Aug 2024 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724554801; cv=none; b=FYJzYUqJaQFn3ILkMLYdxI9yy0AehQjX3nYWhg4I/wyS4HXiUfgyWsb9wLgAtyiUN9HoUxiRRGHvYw3Hb8lzj+FFN/zc9Xhb5vGFnMMw84G0+E1tMm+JbRs9qxgdfBWvqdO8uBXHSqkjBIhwuRIimHlNxOQYVxuNXdrTV3kzLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724554801; c=relaxed/simple;
	bh=KTlXlnkbM5EyE7Fq1s2LhAh0XdYaHH5PaTzbxERt3Ts=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bR7kOb9J76FhEcw0yn2qUXk3rJ4hxmUzAtXCRZc+ybqqC8DxTUGjl4ImzwpBc2ln1Pphjb1TGRB6JPrBJLBZ9TKeeIH8v7DZiJ9+ROOIL2yEEwm3ulb1dfHlSZKlVpbdaqeUJmS2qlWprhZQUrOWnJQbbJV6xOYXahOcHl4MZyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=J5zw1i02; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1724554791;
	bh=ZnWdEpVKnOJBGdTHYa8KhctzjUQ9M499DMjiazB2oBM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=J5zw1i02h9qBDds5Mbvb+nu4cM/PzpJsyvJBrNp6atqDKNEZ9thFUJ0VZ1I9L9e2J
	 suB1gTvEefaWWtOWM22EVy4n1Wa2n6GT9lm7XSir5gSzFcZzgFQPERTZ2T5iwdpCq2
	 9GPfZr1uWdqw9Tjtu8L2KMeun8v4THoq8Vlg2UN4=
X-QQ-mid: bizesmtpip3t1724554791tri49qq
X-QQ-Originating-IP: ACNDHoMYAVH6JCZtJsCrHIqTLtDmI2DcwoZIA1XIA14=
Received: from [IPV6:2409:8a3c:5937:7b50:aeeb: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Aug 2024 10:59:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11087308676701543882
Message-ID: <65B7F79F09D5083C+d0bb90c4-ba72-4b8e-8275-9ee8bfdbd3dd@bupt.moe>
Date: Sun, 25 Aug 2024 10:59:49 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Yuwei Han <hrx@bupt.moe>
Subject: Can't set RAID10 on zoned device using experimental build
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi,
I am using btrfs-progs experimental build to create RAID10 volume on 
zoned device. But it didn't succeed.

# ./btrfs version
btrfs-progs v6.10.1
+EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED 
CRYPTO=builtin

# ./mkfs.btrfs -f -O bgt,rst -mraid10 -draid10 /dev/sda /dev/sdb 
/dev/sdc /dev/sdd
btrfs-progs v6.10.1
See https://btrfs.readthedocs.io for more information.

Zoned: /dev/sda: host-managed device detected, setting zoned feature
Resetting device zones /dev/sda (52156 zones) ...
Resetting device zones /dev/sdb (52156 zones) ...
Resetting device zones /dev/sdc (52156 zones) ...
Resetting device zones /dev/sdd (52156 zones) ...
ERROR: zoned: failed to reset device '/dev/sdd' zones: Remote I/O error
ERROR: zoned: failed to reset device '/dev/sdb' zones: Remote I/O error
ERROR: zoned: failed to reset device '/dev/sdc' zones: Remote I/O error
ERROR: zoned: failed to reset device '/dev/sda' zones: Remote I/O error
ERROR: unable prepare device: /dev/sda

related dmesg:
[ 479.729281] sd 0:0:2:0: [sdc] tag#953 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_OK cmd_age=0s
[  479.729930] sd 0:0:1:0: [sdb] tag#184 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_OK cmd_age=0s
[  479.729944] sd 0:0:3:0: [sdd] tag#12 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_OK cmd_age=0s
[  479.729949] sd 0:0:3:0: [sdd] tag#12 Sense Key : Illegal Request 
[current]
[  479.729951] sd 0:0:3:0: [sdd] tag#12 Add. Sense: Invalid field in cdb
[  479.729954] sd 0:0:3:0: [sdd] tag#12 CDB: Write same(16) 93 08 00 00 
00 00 00 00 00 00 00 01 00 00 00 00
[  479.729956] critical target error, dev sdd, sector 0 op 0x3:(DISCARD) 
flags 0x800 phys_seg 1 prio class 0
[  479.729960] sd 0:0:0:0: [sda] tag#597 FAILED Result: hostbyte=DID_OK 
driverbyte=DRIVER_OK cmd_age=0s
[  479.729963] sd 0:0:0:0: [sda] tag#597 Sense Key : Illegal Request 
[current]
[  479.729966] sd 0:0:0:0: [sda] tag#597 Add. Sense: Invalid field in cdb
[  479.729968] sd 0:0:0:0: [sda] tag#597 CDB: Write same(16) 93 08 00 00 
00 00 00 00 00 00 00 01 00 00 00 00
[  479.729970] critical target error, dev sda, sector 0 op 0x3:(DISCARD) 
flags 0x800 phys_seg 1 prio class 0
[  479.738363] sd 0:0:2:0: [sdc] tag#953 Sense Key : Illegal Request 
[current]
[  479.747438] sd 0:0:1:0: [sdb] tag#184 Sense Key : Illegal Request 
[current]
[  479.756425] sd 0:0:2:0: [sdc] tag#953 Add. Sense: Invalid field in cdb
[  479.763338] sd 0:0:1:0: [sdb] tag#184 Add. Sense: Invalid field in cdb
[  479.769733] sd 0:0:2:0: [sdc] tag#953 CDB: Write same(16) 93 08 00 00 
00 00 00 00 00 00 00 01 00 00 00 00
[  479.779152] sd 0:0:1:0: [sdb] tag#184 CDB: Write same(16) 93 08 00 00 
00 00 00 00 00 00 00 01 00 00 00 00
[  479.788656] critical target error, dev sdc, sector 0 op 0x3:(DISCARD) 
flags 0x800 phys_seg 1 prio class 0
[  479.797730] critical target error, dev sdb, sector 0 op 0x3:(DISCARD) 
flags 0x800 phys_seg 1 prio class 0

drive info: WDC HC620 (HSH721414ALN6M0)



