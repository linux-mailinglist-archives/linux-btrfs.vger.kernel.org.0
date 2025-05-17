Return-Path: <linux-btrfs+bounces-14099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE75ABA904
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 10:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900B2168527
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 May 2025 08:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7721DE4C4;
	Sat, 17 May 2025 08:54:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F5D1DE2CF
	for <linux-btrfs@vger.kernel.org>; Sat, 17 May 2025 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747472042; cv=none; b=K5VfMow9XmBtXMaqXKT9GS6mRBMK2v0ZZiA46G+SS2CyCSI5GB+T9iWgCUkjbZACTSa//bQo1yH+f1a1TIR3gI/SRPPG1N6AytFpCNZHWKdnMNXsKSlPkGmlmszYWrLnF8aRk7qt9kGh7wenrAlxPKU4dr+J5Vt1znec+IlvKd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747472042; c=relaxed/simple;
	bh=J909eVqszy5mFGynCOdnS3ZexmW+1ZNsj/hWJvcCfq0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d1yxYSnUeTNd6/EXo+bmZtdbhp0yTZSSXbGQOUBa50VL56DMr6bbHinHzFpTyuhiAwWVa+b7NZYgGO/kFnom/oCrTOd8nkOzRiUnz3kKQRJPSMG+6JzxQ6fe4d9GKmXW6R3H19VJkgvSOFiZGo3vi1GSvvmGTDMRPvzji83Dnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id D4E71C06EB7;
	Sat, 17 May 2025 10:53:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ec_1wliEmvmj; Sat, 17 May 2025 10:53:48 +0200 (CEST)
Received: from [192.168.36.35] (176.100.193.184.studiowik.net.pl [176.100.193.184])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 655B7C06E9F;
	Sat, 17 May 2025 10:53:48 +0200 (CEST)
Message-ID: <de9c92bc-dbdc-4af9-aeaf-a95592f5b62a@dubiel.pl>
Date: Sat, 17 May 2025 10:53:47 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Snapshot send, modify, receive -> SOLVED :)
From: Leszek Dubiel <leszek@dubiel.pl>
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>
References: <5bd5b9b8-10f9-41de-9bc3-b511482bbc34@dubiel.pl>
 <CAA91j0XWdnZmjqcF15s=AAGgzbuSRWtvYGT0byt41w+DNFWxXg@mail.gmail.com>
 <5b0b737e-ddd0-490a-877d-73346b4446a1@dubiel.pl>
Content-Language: en-US, pl-PL
In-Reply-To: <5b0b737e-ddd0-490a-877d-73346b4446a1@dubiel.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




W dniu 16.05.2025 o 22:09, Leszek Dubiel pisze:
 >
...
 > clone ./after-modif/home/leszek/.cache/mesa_shader_cache/index 
offset=32768 len=4096 
from=./after-modif/home/leszek/.cache/mesa_shader_cache/index 
clone_offset=32768
 >
 > ERROR: clone: did not find source subvol
 >


Other people have had same problems:

https://www.mail-archive.com/linux-btrfs%40vger.kernel.org/msg94239.html

https://lore.kernel.org/linux-btrfs/87mt5y4uyj.fsf@fsf.org/



also with mesa-shader_cache/index.



It was solved here:

https://github.com/kdave/btrfs-progs/issues/606




Case closed.
Thank you for help.




