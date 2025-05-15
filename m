Return-Path: <linux-btrfs+bounces-14056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9280EAB922A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 00:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE32169BD1
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 22:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8992D289828;
	Thu, 15 May 2025 22:06:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F790270552
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747346768; cv=none; b=qkGcfTEvgm87p3tAjDLQeGZkwOPJxZqnh1cdewMYZ2xRVEMP7egBbEJdwqjOGcc7CS+ZpfzSyvc7cipgB0ysIes6/KrYMyg3vQwg/BVkkTP/eRfChvZ6D94Qxt2W8rhW3qLjfztRHdkhtsbWCJ6Z7ioLOAjMGWE5MMgJFA5Fmx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747346768; c=relaxed/simple;
	bh=8BJZwmthXlRBSjK8hKI3xYAFXrV/1Isq+eOqC4voVnU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=AUgwZqjzEtZJBEJ5C/4UKZeokZjtKxhsxMUErHFdpOpTKYg9iRdTyjfUGxElN3QV+KaVgbNpEkLLcAspiT2WzZn2FphU1/AawcH1s8Z9Ao6V5dZYmftFqVa5YaTUX/2jdZK8/pJxnIE7dYPV01RuTWWT1Xn1alBWp8dhaUSaWjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id 6DDEDC0F5CE
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 00:00:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pxaDon3pvbhQ for <linux-btrfs@vger.kernel.org>;
	Fri, 16 May 2025 00:00:35 +0200 (CEST)
Received: from [192.168.36.216] (176.100.193.184.studiowik.net.pl [176.100.193.184])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id B77DBC0F5AF
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 00:00:35 +0200 (CEST)
Message-ID: <5bd5b9b8-10f9-41de-9bc3-b511482bbc34@dubiel.pl>
Date: Fri, 16 May 2025 00:00:34 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, pl-PL
From: Leszek Dubiel <leszek@dubiel.pl>
Subject: Snapshot send, modify, receive ->
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On main server there is a subvolume "mylap" (as my laptop):

# btrfs sub show ../mylap | grep UUID
     UUID:             586996e9-8dea-454d-9a21-ddb414e90ce7     (1)
     Parent UUID:         8879b3b8-dc33-4941-bd0a-4f1ab1d1fbf3
     Received UUID:         -

it was snapshoted read-only:

# btrfs sub show 'bak-first' | grep UUID
     UUID:             3241acf1-44ef-f641-8b7f-c9ae8ccbf41c (2)
     Parent UUID:         586996e9-8dea-454d-9a21-ddb414e90ce7 (1)
     Received UUID:         -



and transfered to backup server btrfs send/receive.



On backup server it looks like this:

# btrfs sub show 'bak-first' | grep UUID
     UUID:             9ad9ede3-f11e-b144-ba12-3f69dd14e665     (3)
     Parent UUID:         b84b0730-c76f-0448-9f7a-e9b5ac288411
     Received UUID:         3241acf1-44ef-f641-8b7f-c9ae8ccbf41c (2)

See the same (2) of "Received UUID" on backup server same as UUID on 
main server.



On backup server,
subvolue 'bak-first' was snapshoted read-write as "mytest":

# btrfs sub snap 'bak-first'../mytest

# btrfs sub show ../mytest | grep UUID
     UUID:             79370999-3114-e545-af15-f1b6b9d74506     (4)
     Parent UUID:         9ad9ede3-f11e-b144-ba12-3f69dd14e665  (3)
     Received UUID:         -


"mytest" was modified, then snapshoted read-only as "after-modif":

# btrfs sub snapshot -r ../mytest   'after-modif'

# btrfs sub show 'after-modif'
     UUID:             e7cfb051-10c9-424f-87d8-28b9d5dd6caa
     Parent UUID:         79370999-3114-e545-af15-f1b6b9d74506 (4)
     Received UUID:         -





Now I want to transfer 'after-modif' back to main server,
and I get error "did not find source subvol":

# ssh backup-server 'btrfs send -p "bak-first" "after-modif"' | btrfs 
receive ./
At subvol after-modif
At snapshot after-modif
ERROR: clone: did not find source subvol


Source subvol is "bak-first" if I understand correctly.

# ssh backup-server 'btrfs sub show "bak-first"' | grep UUID
     UUID:             9ad9ede3-f11e-b144-ba12-3f69dd14e665
     Parent UUID:         b84b0730-c76f-0448-9f7a-e9b5ac288411
     Received UUID:         3241acf1-44ef-f641-8b7f-c9ae8ccbf41c (5)

root@lip24:/mnt/root/mylap_snaps# btrfs sub show "bak-first" | grep UUID
     UUID:             3241acf1-44ef-f641-8b7f-c9ae8ccbf41c (5)
     Parent UUID:         586996e9-8dea-454d-9a21-ddb414e90ce7
     Received UUID:         -


"bak-first" on remote server is the same as "bak-first" on local server 
— same UUID as Received UUID.



Is there any solution I can transfer "after-modif" to main server?



Thank you.













