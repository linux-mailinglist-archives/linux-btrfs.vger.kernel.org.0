Return-Path: <linux-btrfs+bounces-7356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAB2959613
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 09:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4372228A362
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6BC15747C;
	Wed, 21 Aug 2024 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wpkg.org header.i=@wpkg.org header.b="gRNwG6aY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.virtall.com (mail.virtall.com [46.4.129.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5411B81B8
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Aug 2024 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.129.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225222; cv=none; b=Dr3jD6CJdxK1j4Q5NjvrpJpjIOX4zmzCalDFL9F0dnwwkvK/5UQdV/xFRatlqAv18DIbKF9xvtabFe7yD0fAErG/W20bw5gShId5DkSrfgciCtQgip85DoUAL0rrhHLFJjRwCQZn0GlnByUsilRGRS9GaLqNzOqpzPxWaBEdsXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225222; c=relaxed/simple;
	bh=kvOl9rQMMnrSefp7hG1yeIDQi9ZDHU6rutCkCO3yCoA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HW8aMM4mdt4QJB5GEnMjnc8dmTaL4haMal7CLZx3mSHmhKexqlWHC4IPRy/DfyIRLEDetIrjZQ0cMtddCZL4fMHO4YP3koRP7dE1XeNfOoZewBjLXth6uQqXqBXCF/3jsgBc3I3GrrRW0O6oEJtbxhWIv1o0RHB42Nx+wsNxMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wpkg.org; spf=pass smtp.mailfrom=wpkg.org; dkim=pass (2048-bit key) header.d=wpkg.org header.i=@wpkg.org header.b=gRNwG6aY; arc=none smtp.client-ip=46.4.129.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wpkg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wpkg.org
Received: from mail.virtall.com (localhost [127.0.0.1])
	by mail.virtall.com (Postfix) with ESMTP id 7984113F063D6;
	Wed, 21 Aug 2024 07:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wpkg.org; s=default;
	t=1724225210; bh=PYCcfCyowPKmAbMAF2yBgVqahQToKC+29Tb0sT/ynH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gRNwG6aYTxOm77ab7jFQ7+UzqW70QRtjA1VTF/IQCO7FNTu7nMYhNkVUNhd0LRXOZ
	 PDO2Ow7qWPoALZfygiP+mGHvgpPfNkCnTMfgeSYR8cSlBAAuWnqoAzQfW8nWmpSjYV
	 YiR4AAjuJqvNqk9XQk4Xt4SzWVclXDDAPLLX7bUVwPOzbPCpjfIjcRK+oggUd7R2Tl
	 XxejntJUP8cecsBv1T/vm3iyNymHPZSEgks519nlZvAkvZfoSKMcHBoYUWOoWTf+ft
	 euY34jF4QQcbEiSqN3G5B0sMpoipdYJSeapEw46/+ExZT8TbF2onhrZIzQqg54pNOy
	 DS6sludILVltA==
X-Fuglu-Suspect: 5098512da23c44f8aacdf1e977bee163
X-Fuglu-Spamstatus: NO
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: tch@virtall.com)
	by mail.virtall.com (Postfix) with ESMTPSA;
	Wed, 21 Aug 2024 07:26:43 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 21 Aug 2024 09:26:42 +0200
From: Tomasz Chmielewski <mangoo@wpkg.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: out of space (>865 GB free), filesystem remounts read-only - how
 to recover?
In-Reply-To: <6b17f157-49c3-4874-898f-68541b2dce0a@gmx.com>
References: <f11daee5026d303e673d480f3f812b15@wpkg.org>
 <6b17f157-49c3-4874-898f-68541b2dce0a@gmx.com>
Message-ID: <6505eaf6b2bdaefa835944c7617d2725@wpkg.org>
X-Sender: mangoo@wpkg.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-08-21 00:09, Qu Wenruo wrote:
> 在 2024/8/20 23:07, Tomasz Chmielewski 写道:
>> My 44 TB filesystem was getting full (~865 GB free out of 44 TB in
>> total), so I thought removing some old data would be a good thing to 
>> do.
> 
> btrfs fi usage output please.
> 
> I bet it's some btrfs RAID setup, maybe RAID1/10 or RAID1C3/C4 for 
> metadata.
> And the disk usages got unbalanced, the metadata overcommitment did a
> wrong estimation and cause the ENOSPC.

# btrfs filesystem usage /data1
Overall:
     Device size:                  43.75TiB
     Device allocated:             43.66TiB
     Device unallocated:          100.00GiB
     Device missing:                  0.00B
     Used:                         42.51TiB
     Free (estimated):            951.71GiB      (min: 926.71GiB)
     Free (statfs, df):           876.71GiB
     Data ratio:                       1.33
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 64.00KiB)
     Multiple profiles:                  no

Data,RAID5: Size:32.63TiB, Used:31.78TiB (97.38%)
    /dev/sdc1      10.88TiB
    /dev/sdd1      10.88TiB
    /dev/sde1      10.88TiB
    /dev/sdf1      10.88TiB

Metadata,RAID1: Size:73.00GiB, Used:71.89GiB (98.48%)
    /dev/sdc1      37.00GiB
    /dev/sdd1      37.00GiB
    /dev/sde1      36.00GiB
    /dev/sdf1      36.00GiB

System,RAID1: Size:8.00MiB, Used:2.30MiB (28.71%)
    /dev/sde1       8.00MiB
    /dev/sdf1       8.00MiB

Unallocated:
    /dev/sdc1       1.00MiB
    /dev/sdd1       1.00MiB
    /dev/sde1       1.00MiB
    /dev/sdf1       1.00MiB
    /dev/loop0    100.00GiB
# btrfs filesystem usage /data1
Overall:
     Device size:                  43.75TiB
     Device allocated:             43.66TiB
     Device unallocated:          100.00GiB
     Device missing:                  0.00B
     Used:                         42.51TiB
     Free (estimated):            951.71GiB      (min: 926.71GiB)
     Free (statfs, df):           876.71GiB
     Data ratio:                       1.33
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 64.00KiB)
     Multiple profiles:                  no

Data,RAID5: Size:32.63TiB, Used:31.78TiB (97.38%)
    /dev/sdc1      10.88TiB
    /dev/sdd1      10.88TiB
    /dev/sde1      10.88TiB
    /dev/sdf1      10.88TiB

Metadata,RAID1: Size:73.00GiB, Used:71.89GiB (98.48%)
    /dev/sdc1      37.00GiB
    /dev/sdd1      37.00GiB
    /dev/sde1      36.00GiB
    /dev/sdf1      36.00GiB

System,RAID1: Size:8.00MiB, Used:2.30MiB (28.71%)
    /dev/sde1       8.00MiB
    /dev/sdf1       8.00MiB

Unallocated:
    /dev/sdc1       1.00MiB
    /dev/sdd1       1.00MiB
    /dev/sde1       1.00MiB
    /dev/sdf1       1.00MiB
    /dev/loop0    100.00GiB


# btrfs filesystem df /data1
Data, RAID5: total=32.63TiB, used=31.78TiB
System, RAID1: total=8.00MiB, used=2.30MiB
Metadata, RAID1: total=73.00GiB, used=71.89GiB
GlobalReserve, single: total=512.00MiB, used=64.00KiB


# btrfs filesystem show /data1
Label: 'data'  uuid: a80ce575-8c39-4065-80ce-2ca015fa1d51
         Total devices 5 FS bytes used 31.85TiB
         devid    1 size 10.91TiB used 10.91TiB path /dev/sdc1
         devid    2 size 10.91TiB used 10.91TiB path /dev/sdd1
         devid    3 size 10.91TiB used 10.91TiB path /dev/sde1
         devid    4 size 10.91TiB used 10.91TiB path /dev/sdf1
         devid    5 size 100.00GiB used 0.00B path /dev/loop0


Tomasz

