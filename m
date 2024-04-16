Return-Path: <linux-btrfs+bounces-4293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7974E8A6582
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 09:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F9A1C223DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Apr 2024 07:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFED15689F;
	Tue, 16 Apr 2024 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b="CWIrUAgy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1D2131BC0
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Apr 2024 07:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254149; cv=none; b=qcze9c8rXg1A3YuwH3bkKj+lHAJscI31iOXfrmoMuKcWIPxMYy6GfnfiBJ0PsJErJW0hrcphKm3W2VixBY56p2oR+s52bCsC2X0KABumQJNGug/eFi/10vRN9CA21Ue/kcWK5VE5MDAEEFNRZH52ng4MoDiCSO691N2Vc35MOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254149; c=relaxed/simple;
	bh=b/M/ovsEUIREi3RM8O6Vq1PvL4sE8HlffTeIZ5x5g54=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=dTMtQxKjTGyWrUzeP2Tta7mjBhUyO6B2JwFTPUgJxy0uDUzuu4zAf4A4ruRzLJWnNNf3LUHGrX95KPL+vpEbk4tByQ3UMUz7b+QpAuV3+nzpYeBWyrvZ85ZAo4WkEc9U5U3uFspRHC0jmXSuWZFtWrYkaYEkmVZY1OE0j9mCh/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe; spf=pass smtp.mailfrom=bupt.moe; dkim=pass (1024-bit key) header.d=bupt.moe header.i=@bupt.moe header.b=CWIrUAgy; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bupt.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.moe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bupt.moe;
	s=qqmb2301; t=1713254143;
	bh=Zmfy7Vv9xBADETAp/G5o5ofR7H7TjA1lxeQouhoh8KQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=CWIrUAgy1S6GdARAEHjKgkL6QX/KTFJ2c3fEW3DDnrFGw5nxV8x8Wua7z8fdlg50C
	 oOz3T7QVud1HWs8SXUYQrN6omU6ic180N0C9Oi5l4ulSzwEq8bsBp+zibsJQxOZLLd
	 rBnfKQIVC8mOYuNdvGc8XA6cChxnhnd+Ej+tjACE=
X-QQ-mid: bizesmtpsz12t1713254041tddhnh
X-QQ-Originating-IP: s86qaB6cwdKB/76OeoRYvQORGxfBPgl0Y4CRNKD75+o=
Received: from [192.168.1.5] ( [223.150.235.89])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Apr 2024 15:54:00 +0800 (CST)
X-QQ-SSF: 00100000000000E0Z000000A0000000
X-QQ-FEAT: ZEnvGE/eP1XIYW8noFZR0d5ntxt4UeL1mjkNGsyUWBR+Ji3MluRRtyVFLw5et
	gdKPrrYBHYzdpBwnP9xii1IH1xHqfNEfFIvMIwKu7Gsg2SKuPLGdHf3vqaK81RaMYXLUUMJ
	vK6u07u3mvGmxR9sQB+2UAnKl3WieA2nD04vlrDGVOS3pVZUAoO58XSMD8IZSEg8WnS0S0B
	kiLgzgyJYbBuSRTt01O8JTmNNkAEllTP3G1SLIWePVjS8F1x7tKmvcarbpYRAFiZ4ibwSIb
	Hsnvu+itg9V6PCEPLWhxUvr5olnC9m6W7HdkR8jJNRN1aDxp+GHvlGnD4yDelV7tIFGpQRi
	JkHyjQtUfRC1qnma5ZndoWvP2p0yQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1866792012989948778
Message-ID: <79D2FA23B59927D1+bde927bc-1ccf-4a5d-95fb-9389906d33f6@bupt.moe>
Date: Tue, 16 Apr 2024 15:54:00 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: HAN Yuwei <hrx@bupt.moe>
Subject: =?UTF-8?Q?Re=3A_enospc_errors_during_balance_=E2=80=94_how_to_preve?=
 =?UTF-8?Q?nt_out_of_space?=
To: Leszek Dubiel <leszek@dubiel.pl>, linux-btrfs@vger.kernel.org
References: <47e425a3-76b9-4e51-93a0-cde31dd39003@dubiel.pl>
Content-Language: en-US
In-Reply-To: <47e425a3-76b9-4e51-93a0-cde31dd39003@dubiel.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:bupt.moe:qybglogicsvrgz:qybglogicsvrgz5a-1

在 2024/4/16 14:09, Leszek Dubiel 写道:
>
>
> Hello :) :)
>
>
>
> My disk got full, so I have removed snapshots and
> now it has plenty of free space, see:
>
>
> # df -h /
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/sdc3       8.2T  7.2T  1.1T  88% /
>
>
> # btrfs fi show /
> Label: none  uuid: ec3525ef-b73a-452a-a4ee-86286252d730
>     Total devices 3 FS bytes used 7.11TiB
>     devid    1 size 5.43TiB used 5.42TiB path /dev/sdc3
>     devid    2 size 5.43TiB used 5.42TiB path /dev/sda3
>     devid    3 size 5.43TiB used 5.43TiB path /dev/sdb3
>
>
> # btrfs fi df /
> Data, RAID1: total=8.09TiB, used=7.07TiB
> System, RAID1: total=32.00MiB, used=1.38MiB
> Metadata, RAID1: total=45.04GiB, used=39.08GiB
> GlobalReserve, single: total=512.00MiB, used=32.00KiB
>
>
>
>
>
> But i got error  NO FREE SPACE.
>
>
>
>
> # btrfs device usage /
> /dev/sdc3, ID: 1
>    Device size:             5.43TiB
>    Device slack:            3.50KiB
>    Data,RAID1:              5.39TiB
>    Metadata,RAID1:         39.04GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             1.00MiB
>
> /dev/sda3, ID: 2
>    Device size:             5.43TiB
>    Device slack:            3.50KiB
>    Data,RAID1:              5.39TiB
>    Metadata,RAID1:         38.03GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             1.00MiB
>
> /dev/sdb3, ID: 3
>    Device size:             5.43TiB
>    Device slack:            3.50KiB
>    Data,RAID1:              5.41TiB
>    Metadata,RAID1:         13.00GiB
>    Unallocated:             1.00MiB
>
>
>
>
>
> I noticed 1Mb for Unallocated space, so
> I have run multiple times balance (data usage filter):
>
>          btrfs balance start -dusage=XX,limit=1 /
>
>
> and it didn't help.
You can try add a small device (USB stick) and rebalance.
> It even got error no space when balancing:
>
> syslog-2024-04-15T14:20:41.498301+02:00 zefir kernel: [161213.968020] 
> BTRFS info (device sdc3): balance: start -dusage=70,limit=3
> syslog-2024-04-15T14:20:41.510297+02:00 zefir kernel: [161213.978076] 
> BTRFS info (device sdc3): relocating block group 31021491027968 flags 
> data|raid1
> syslog-2024-04-15T14:20:46.118283+02:00 zefir kernel: [161218.585833] 
> BTRFS info (device sdc3): relocating block group 30657484161024 flags 
> data|raid1
> syslog-2024-04-15T14:20:50.406268+02:00 zefir kernel: [161222.874987] 
> BTRFS info (device sdc3): relocating block group 30654262935552 flags 
> data|raid1
> syslog:2024-04-15T14:21:01.270284+02:00 zefir kernel: [161233.739112] 
> BTRFS info (device sdc3): 3 enospc errors during balance
> syslog-2024-04-15T14:21:01.270305+02:00 zefir kernel: [161233.739119] 
> BTRFS info (device sdc3): balance: ended with status: -28
>
>
>
>
>
> Then multiple times both for data and metadata:
>
>             btrfs balance start -musage=XX,limit=1 /
>
>             btrfs balance start -dusage=50,limit=1 /
>
>
>
>
> Unallocated space increased:
>
> # btrfs device usage /
> /dev/sdc3, ID: 1
>    Device size:             5.43TiB
>    Device slack:            3.50KiB
>    Data,RAID1:              5.39TiB
>    Metadata,RAID1:         39.04GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             1.00MiB
>
> /dev/sda3, ID: 2
>    Device size:             5.43TiB
>    Device slack:            3.50KiB
>    Data,RAID1:              5.39TiB
>    Metadata,RAID1:         38.03GiB
>    System,RAID1:           32.00MiB
>    Unallocated:             1.00MiB
>
> /dev/sdb3, ID: 3
>    Device size:             5.43TiB
>    Device slack:            3.50KiB
>    Data,RAID1:              5.41TiB
>    Metadata,RAID1:         13.00GiB
>    Unallocated:            21.57MiB
>
>
>
> and now I have:
>
> /dev/sdc3, ID: 1
>    Device size:             5.43TiB
>    Device slack:            3.50KiB
>    Data,RAID1:              5.36TiB
>    Metadata,RAID1:         40.00GiB
>    Unallocated:            31.06GiB
>
> /dev/sda3, ID: 2
>    Device size:             5.43TiB
>    Device slack:            3.50KiB
>    Data,RAID1:              5.36TiB
>    Metadata,RAID1:         36.00GiB
>    System,RAID1:           32.00MiB
>    Unallocated:            28.06GiB
>
> /dev/sdb3, ID: 3
>    Device size:             5.43TiB
>    Device slack:            3.50KiB
>    Data,RAID1:              5.38TiB
>    Metadata,RAID1:         12.00GiB
>    System,RAID1:           32.00MiB
>    Unallocated:            31.02GiB
>
>
>
> Should I run balance quite often to prevent Unallocated space to go as 
> low as 1.00MiB?
>
> How to prevent "NO SPACE ERROR" when there is pleny of space left?
>
> Run balance regularly to keep Unallocated space high?
>
If you have zabbix or other monitoring mechanism, you can try monitoring 
"Unallocated" and reserve at least 2 block group (2GiB). Or you can have 
a weekly timer to rebalance your btrfs volume.
kdave/btrfsmaintenance should helps you.

>
>
> Thank you.
> I am using BTRFS in production many, many years (since 2010 maybe?).
>


