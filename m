Return-Path: <linux-btrfs+bounces-14095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A3ABA47B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 22:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFECF5052EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C911326FA78;
	Fri, 16 May 2025 20:09:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from naboo.endor.pl (naboo.endor.pl [91.194.229.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180DD22B8AA
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.194.229.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426172; cv=none; b=KLAzg9U0xk2wfg4pbq5nfj3a3De8TV0qz9ZjbKsV41GYm9bAAn1AlhfKzVtz10HBuPmj4N+zWAyc5wev3csCwsV9WS1B8MLALrLRvwM8ENaLfVV49bWq4xOfu6Gif5n5vjD1epMdjZST99cFobqNqSZhEDRiYs3+jb6Z4BxAJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426172; c=relaxed/simple;
	bh=wjygVlEHs16Qzw7eX9KMpDYDTKE2cegdsN2srNhKllo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VH+6/ixdX4rr+g5DLScGZjm3z6gPI1gXSmuz2pi9O4h2nCgEIaJcKW8Plrvdr4YasGBOBOka0q3FuCv5Nuuf9A52D+z9a1SjlsxOKPTmt5sYgR3ztGiwQ5Jbzf/GiLXDeW4K1eZAKjePl8rQdtFhNBnuSLSYhi+TAcIusGh1/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl; spf=pass smtp.mailfrom=dubiel.pl; arc=none smtp.client-ip=91.194.229.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubiel.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubiel.pl
Received: from localhost (localhost.localdomain [127.0.0.1])
	by naboo.endor.pl (Postfix) with ESMTP id D6331C06CEB;
	Fri, 16 May 2025 22:09:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.15])
	by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EuoKPw0LCXZ6; Fri, 16 May 2025 22:09:24 +0200 (CEST)
Received: from [192.168.36.35] (176.100.193.184.studiowik.net.pl [176.100.193.184])
	(Authenticated sender: leszek@dubiel.pl)
	by naboo.endor.pl (Postfix) with ESMTPSA id 8E0CBC06CE9;
	Fri, 16 May 2025 22:09:24 +0200 (CEST)
Message-ID: <5b0b737e-ddd0-490a-877d-73346b4446a1@dubiel.pl>
Date: Fri, 16 May 2025 22:09:23 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leszek Dubiel <leszek@dubiel.pl>
Subject: Re: Snapshot send, modify, receive ->
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc: Andrei Borzenkov <arvidjaar@gmail.com>
References: <5bd5b9b8-10f9-41de-9bc3-b511482bbc34@dubiel.pl>
 <CAA91j0XWdnZmjqcF15s=AAGgzbuSRWtvYGT0byt41w+DNFWxXg@mail.gmail.com>
Content-Language: en-US, pl-PL
In-Reply-To: <CAA91j0XWdnZmjqcF15s=AAGgzbuSRWtvYGT0byt41w+DNFWxXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Full output "receive --dump" filtered out of typical operations (no pv 
this time):


# ssh backup-server "btrfs send -p 'bak-first' 'after-modif'" | btrfs 
receive --dump | grep -Ev 
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
5 len=8
truncate 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system@0006350af7c9c02a-10d146c7a9f065d1.journal~ 
size=8388608
5 len=8
truncate 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/user-1000.journal 
size=8388608
5 len=8
truncate 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system.journal 
size=8388608
symlink         ./after-modif/o343645-507-0 dest=/tmp
mksock          ./after-modif/o343667-507-0
mksock          ./after-modif/o343670-507-0
mksock          ./after-modif/o343672-507-0
mksock          ./after-modif/o344580-509-0
mksock          ./after-modif/o344581-509-0




I don't understand that lines "5 len=8".



Grep with context on this line:


# ssh backup-server "btrfs send -p 'bak-first' 'after-modif'" | btrfs 
receive --dump | grep -a '^5' -C3
At subvol after-modif
rename          ./after-modif/o311485-436-0 
dest=./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system@0006350af7c9c02a-10d146c7a9f065d1.journal~
utimes ./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b 
atime=2025-05-14T00:30:30+0200 mtime=2025-05-13T23:18:03+0200 
ctime=2025-05-13T23:20:18+0200
set_xattr 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system@0006350af7c9c02a-10d146c7a9f065d1.journal~ 
name=user.crtime_usec data=X�`O
5 len=8
set_xattr 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system@0006350af7c9c02a-10d146c7a9f065d1.journal~ 
name=system.posix_acl_access data= len=44
write 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system@0006350af7c9c02a-10d146c7a9f065d1.journal~ 
offset=0 len=4096
write 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system@0006350af7c9c02a-10d146c7a9f065d1.journal~ 
offset=4096 len=49152
--
rename          ./after-modif/o311486-436-0 
dest=./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/user-1000.journal
utimes ./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b 
atime=2025-05-14T00:30:30+0200 mtime=2025-05-13T23:18:03+0200 
ctime=2025-05-13T23:20:18+0200
set_xattr 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/user-1000.journal 
name=user.crtime_usec data=�oaO
5 len=8
set_xattr 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/user-1000.journal 
name=system.posix_acl_access data= len=52
write 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/user-1000.journal 
offset=0 len=4096
write 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/user-1000.journal 
offset=4096 len=49152
--
rename          ./after-modif/o339385-496-0 
dest=./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system.journal
utimes ./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b 
atime=2025-05-14T00:30:30+0200 mtime=2025-05-13T23:18:03+0200 
ctime=2025-05-13T23:20:18+0200
set_xattr 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system.journal 
name=user.crtime_usec data=����
5 len=8
set_xattr 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system.journal 
name=system.posix_acl_access data= len=44
write 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system.journal 
offset=0 len=4096
write 
./after-modif/var/log/journal/40d884e2227544829ccabadefcfe028b/system.journal 
offset=4096 len=49152








