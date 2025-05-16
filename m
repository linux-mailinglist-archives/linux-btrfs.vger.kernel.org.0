Return-Path: <linux-btrfs+bounces-14094-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F38ABA3E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 21:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C526F7B430A
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 19:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1170280006;
	Fri, 16 May 2025 19:37:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4509722B59A
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424243; cv=none; b=qVlMlvti0V1MV9jhowy9F38ZyHoIqkjXfqcm+YJ5OgoSgd9Nm8b1nEtELad0m9/SA8Yv176Aporlg6LTqckZIDm9TcOMc9q6seUHLcHREAfsd7G8m5x6zRBbQn68qJf+cHaqQMhsPv68oxzWMM/oWmSEP7f7VGN7CTzjJiTO1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424243; c=relaxed/simple;
	bh=sQMnmn7qbrpFngiMEVuvWflvtAxmMfT0RzN5muuyvkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKVnwUqWUz1cd0qxWzo5BRCJxWZ5W1RorT6tVeUMKm7iwvB4xj0EtBQZd5wt3cxGa5p+ga59x5ZR6LlNfp6hWHLUjSa0HaGRkmrjMfGMinxMheG7V2KYmvMHJWOYsF22R9PtttOnBXoHGEB7JunQHrYNy2hlJYMFKXsVbOtx/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id B82ACC06CD6;
	Fri, 16 May 2025 21:37:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DRwIYsbHJ7NQ; Fri, 16 May 2025 21:37:14 +0200 (CEST)
Received: from [192.168.36.35] (176.100.193.184.studiowik.net.pl [176.100.193.184])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 06354C06CD3;
	Fri, 16 May 2025 21:37:13 +0200 (CEST)
Message-ID: <af5ad9ce-6c14-421f-9896-28e34a8d7b26@dubiel.pl>
Date: Fri, 16 May 2025 21:37:12 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Snapshot send, modify, receive ->
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>
References: <5bd5b9b8-10f9-41de-9bc3-b511482bbc34@dubiel.pl>
 <CAA91j0XWdnZmjqcF15s=AAGgzbuSRWtvYGT0byt41w+DNFWxXg@mail.gmail.com>
Content-Language: en-US, pl-PL
From: Leszek Dubiel <leszek@dubiel.pl>
In-Reply-To: <CAA91j0XWdnZmjqcF15s=AAGgzbuSRWtvYGT0byt41w+DNFWxXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



W dniu 16.05.2025 o 14:16, Andrei Borzenkov pisze
>> # ssh backup-server 'btrfs send -p "bak-first" "after-modif"' | btrfs
>> receive ./
>> At subvol after-modif
>> At snapshot after-modif
>> ERROR: clone: did not find source subvol
>>
>>
>> Source subvol is "bak-first" if I understand correctly.
>>
>> # ssh backup-server 'btrfs sub show "bak-first"' | grep UUID
>>       UUID:             9ad9ede3-f11e-b144-ba12-3f69dd14e665
>>       Parent UUID:         b84b0730-c76f-0448-9f7a-e9b5ac288411
>>       Received UUID:         3241acf1-44ef-f641-8b7f-c9ae8ccbf41c (5)
>>
>> root@lip24:/mnt/root/mylap_snaps# btrfs sub show "bak-first" | grep UUID
>>       UUID:             3241acf1-44ef-f641-8b7f-c9ae8ccbf41c (5)
>>       Parent UUID:         586996e9-8dea-454d-9a21-ddb414e90ce7
>>       Received UUID:         -
>>
>>
>> "bak-first" on remote server is the same as "bak-first" on local server
>> — same UUID as Received UUID.
>>
>>
>>
>> Is there any solution I can transfer "after-modif" to main server?
>>
> What you do should work. You may consider running
>
> btrfs receive --dump
>
> to see the actual UUID that is sent.





# ssh backup-server "btrfs send -p 'bak-first' 'after-modif'" | btrfs 
receive --dump | head
At subvol after-modif
snapshot        ./after-modif uuid=e7cfb051-10c9-424f-87d8-28b9d5dd6caa 
(*1*)   transid=513 parent_uuid=3241acf1-44ef-f641-8b7f-c9ae8ccbf41c 
(*2*) parent_transid=428
utimes          ./after-modif/ atime=2025-05-14T00:21:15+0200 
mtime=2025-05-13T23:23:49+0200 ctime=2025-05-13T23:23:49+0200
utimes          ./after-modif/boot atime=2025-05-14T00:30:30+0200 
mtime=2025-05-13T23:19:00+0200 ctime=2025-05-13T23:19:00+0200
utimes          ./after-modif/boot/efi atime=2025-05-14T00:28:10+0200 
mtime=2023-11-19T13:12:48+0100 ctime=2025-05-14T00:16:20+0200
utimes          ./after-modif/etc atime=2025-05-13T23:18:59+0200 
mtime=2025-05-13T23:20:23+0200 ctime=2025-05-13T23:20:23+0200
utimes          ./after-modif/var/lib/apt/lists 
atime=2025-05-13T23:03:38+0200 mtime=2025-05-13T23:03:38+0200 
ctime=2025-05-13T23:03:38+0200
utimes          ./after-modif/var/lib/apt/lists/partial 
atime=2025-05-13T23:20:25+0200 mtime=2025-05-13T23:20:25+0200 
ctime=2025-05-13T23:20:25+0200
utimes          ./after-modif/var/cache/apt 
atime=2025-05-13T23:20:27+0200 mtime=2025-05-13T23:20:27+0200 
ctime=2025-05-13T23:20:27+0200
utimes          ./after-modif/bin atime=2025-05-14T00:28:10+0200 
mtime=2023-11-19T13:12:59+0100 ctime=2025-05-14T00:16:20+0200
utimes          ./after-modif/usr atime=2025-05-14T00:30:30+0200 
mtime=2024-02-14T23:42:44+0100 ctime=2025-05-14T00:16:20+0200



on main server:

# btrfs subv show 'bak-first' | grep UUID
     UUID: 3241acf1-44ef-f641-8b7f-c9ae8ccbf41c           (*2*)
     Parent UUID:         586996e9-8dea-454d-9a21-ddb414e90ce7
     Received UUID:         -



on backup server:

# ssh backup-server "btrfs subv show 'bak-first'" | grep UUID
     UUID:             9ad9ede3-f11e-b144-ba12-3f69dd14e665
     Parent UUID:         b84b0730-c76f-0448-9f7a-e9b5ac288411
     Received UUID: 3241acf1-44ef-f641-8b7f-c9ae8ccbf41c      (*2*)

# ssh backup-server "btrfs subv show 'after-modif'" | grep UUID
     UUID:             e7cfb051-10c9-424f-87d8-28b9d5dd6caa (*1*)
     Parent UUID:         79370999-3114-e545-af15-f1b6b9d74506
     Received UUID:         -


UUID-s match (*1*) and (*2*).



Error occurs after 4.73 MiB (pv used):

# ssh backup-server "btrfs send -p 'bak-first' 'after-modif'" | pv 
-rafbt | btrfs receive ./
At subvol after-modif
At snapshot after-modif
ERROR: clone: did not find source subvol
4,73MiB 0:00:00 [6,44MiB/s] [6,44MiB/s]



Here is full output "receive --dump" filter out of typical operations:


# ssh backup-server "btrfs send -p 'bak-first' 'after-modif'" | pv 
-rafbt | btrfs receive --dump | grep -Ev 
'^(write|utimes|rename|rmdir|unlink|chown|mkfile|mkdir|chmod|link|set_xattr) 
'
At subvol after-modif
snapshot        ./after-modif uuid=e7cfb051-10c9-424f-87d8-28b9d5dd6caa 
transid=513 parent_uuid=3241acf1-44ef-f641-8b7f-c9ae8ccbf41c 
parent_transid=428
truncate ./after-modif/home/leszek/.config/variety/history.txt size=7542
clone ./after-modif/home/leszek/.cache/mesa_shader_cache/index 
offset=32768 len=4096 
from=./after-modif/home/leszek/.cache/mesa_shader_cache/index 
clone_offset=32768
clone ./after-modif/home/leszek/.cache/mesa_shader_cache/index 
offset=40960 len=8192 
from=./after-modif/home/leszek/.cache/mesa_shader_cache/index 
clone_offset=40960
clone ./after-modif/home/leszek/.cache/mesa_shader_cache/index 
offset=339968 len=8192 
from=./after-modif/home/leszek/.cache/mesa_shader_cache/index 
clone_offset=339968
clone ./after-modif/home/leszek/.cache/mesa_shader_cache/index 
offset=352256 len=4096 
from=./after-modif/home/leszek/.cache/mesa_shader_cache/index 
clone_offset=352256
clone ./after-modif/home/leszek/.cache/mesa_shader_cache/index 
offset=581632 len=8192 
from=./after-modif/home/leszek/.cache/mesa_shader_cache/index 
clone_offset=581632
clone ./after-modif/home/leszek/.cache/mesa_shader_cache/index 
offset=921600 len=4096 
from=./after-modif/home/leszek/.cache/mesa_shader_cache/index 
clone_offset=921600
clone ./after-modif/home/leszek/.cache/mesa_shader_cache/index 
offset=1232896 len=4096 
from=./after-modif/home/leszek/.cache/mesa_shader_cache/index 
clone_offset=1232896
5 len=8 0:00:03 [4,28MiB/s] [7,55MiB/s]
truncate 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system@0006350af7c9c02a-10d146c7a9f065d1.journal~ 
size=8388608
5 len=8
truncate 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/user-1000.journal 
size=8388608
5 len=8 0:00:46 [10,2MiB/s] [8,69MiB/s]
truncate 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system.journal 
size=8388608
symlink         ./after-modif/o343645-507-0 dest=/tmp
mksock          ./after-modif/o343667-507-0
mksock          ./after-modif/o343670-507-0
mksock          ./after-modif/o343672-507-0
mksock          ./after-modif/o344580-509-0
mksock          ./after-modif/o344581-509-0
  569MiB 0:01:03 [8,99MiB/s] [8,99MiB/s]










