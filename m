Return-Path: <linux-btrfs+bounces-2452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05049857D71
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 14:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938261F21955
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ACB129A73;
	Fri, 16 Feb 2024 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inix.me header.i=@inix.me header.b="cPnjvdNd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.inix.me (mail.inix.me [93.93.135.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE0B129A6B
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.135.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089280; cv=none; b=SGI85qiJ4smgPQd1pl9iWm34gGbeg/2Tv+FsG9vketM0HmB1V0vkk3mKfzXEMjOw7Qq8/UyCx+d5qtNg8EQoVPPS90JfFLGo8lVMJKSNO2NtQD5jSY0jqjufIVOQ6muVdG6icBVMeo40lW1OBr5+eaEL9/3GddvIz9e34hrKeRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089280; c=relaxed/simple;
	bh=brePYn6SMNwoRvMiMZB9ro2uh4WzeuVUYWn6Ghg50SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLLJq3/6zVJ2bBmkGJyif5Yhyb6IJ5IL9WaH8/ALrkDDozREDP/WrTmE0R0z92b85pvaAvYIopDhKS0GJZHdxOeo/qIVfTMwEmpeGUpjclr4gmwvMK4V/Y+g5YrSW2nyYkfkgmS/ZxKEJlJYLjWroB00lIxBEKny8qPjuiqE0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me; spf=pass smtp.mailfrom=inix.me; dkim=pass (1024-bit key) header.d=inix.me header.i=@inix.me header.b=cPnjvdNd; arc=none smtp.client-ip=93.93.135.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inix.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inix.me;
	s=primary; h=Sender:Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VAu49sG+xLC0iF2+vzk+z3ZD/3HOMv83nlkBg7bAxw0=; b=cPnjvdNd8yiLFTR1DUf/CSdm7C
	Oohi2XE+IqvvEiC73pQ/DNzLpWbZnjkuquXey2ai5PTfNQgNoHc5w5D29zDBc+VCS5ZelSCGJvu8z
	m8WIi8mRCbjtWulSV3MrM6uQCnXDxLXk5OKIHNZiFAsnjUYzbHjyZCpq7KvwQUHXlFCk=;
Received: by mail.inix.me with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.96)
	(envelope-from <dash.btrfs@inix.me>)
	id 1rayE6-00A5Ne-1X;
	Fri, 16 Feb 2024 13:26:02 +0000
Message-ID: <f8e83db1-cf04-469b-9579-e86de5a9a76e@inix.me>
Date: Fri, 16 Feb 2024 18:44:29 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: incremental stream after fstrim on thinly provisioned disk file
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <c0bf7818-9c45-46a8-b3d3-513230d0c86e@inix.me>
 <CAL3q7H6tvCTdwrCXZ0tgOfkHhF=VWEW05_u3vr_rVv0u_PvvXg@mail.gmail.com>
From: Dorai Ashok S A <dash.btrfs@inix.me>
In-Reply-To: <CAL3q7H6tvCTdwrCXZ0tgOfkHhF=VWEW05_u3vr_rVv0u_PvvXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: dash.btrfs@inix.me

> I turned your reproducer into this script:  Thanks.
> truncate -s +3G thin-disk mkfs.btrfs thin-disk >& /dev/null mkdir  > thin-mount mount thin-disk thin-mount/ > > fstrim thin-mount > > cd 
thin-mount/
I am taking snapshots on the main filesystem where `thin-disk` file is 
present (ie., not on thin-mount/).

> Well, I'm unable to reproduce that on a 6.8-rc4 kernel, but nothing  > changed since 6.7 regarding send, and using a thin provisioned disk > 
or fsstrim is irrelevant from a send perspective. I have modified the 
script to reproduce the issue, kindly try it again. The modified script 
is below, $ cat test-modified.sh #!/bin/bash truncate -s +3G thin-disk 
mkfs.btrfs thin-disk >& /dev/null mkdir thin-mount mount thin-disk 
thin-mount/ fstrim thin-mount btrfs subvolume snapshot -r $(stat 
--format=%m .) 1.s btrfs subvolume snapshot -r $(stat --format=%m .) 2.s 
seq 10000000 > 76mb.file btrfs filesystem sync thin-mount btrfs 
subvolume snapshot -r $(stat --format=%m .) 3.s btrfs send 1.s | wc -c | 
numfmt --to=iec btrfs send 2.s | wc -c | numfmt --to=iec btrfs send 3.s 
| wc -c | numfmt --to=iec btrfs send -p 1.s 2.s | wc -c | numfmt 
--to=iec btrfs send -p 2.s 3.s | wc -c | numfmt --to=iec btrfs subvolume 
delete *.s umount thin-mount rm -f thin-disk rmdir thin-mount Output:- # 
./test-modified.sh Create a readonly snapshot of '/mantyl-backup' in 
'./1.s' Create a readonly snapshot of '/mantyl-backup' in './2.s' Create 
a readonly snapshot of '/mantyl-backup' in './3.s' At subvol 1.s 77M At 
subvol 2.s 77M At subvol 3.s 77M At subvol 2.s 178 At subvol 3.s 2.8G 
Delete subvolume (no-commit): '/mantyl-backup/playarea/1.s' Delete 
subvolume (no-commit): '/mantyl-backup/playarea/2.s' Delete subvolume 
(no-commit): '/mantyl-backup/playarea/3.s' # ./test.sh Create a readonly 
snapshot of '/mantyl-backup/playarea/thin-mount' in './1.s' Create a 
readonly snapshot of '/mantyl-backup/playarea/thin-mount' in './2.s' 
Create a readonly snapshot of '/mantyl-backup/playarea/thin-mount' in 
'./3.s' At subvol 1.s 202 At subvol 2.s 202 At subvol 3.s 76M At subvol 
2.s 170 At subvol 3.s 76M diff of my changes to the script are below, # 
diff -u test.sh test-modified.sh --- test.sh 2024-02-16 
18:32:56.272000000 +0530 +++ test-modified.sh 2024-02-16 
18:22:31.176000000 +0530 @@ -7,12 +7,10 @@ fstrim thin-mount -cd 
thin-mount/ - btrfs subvolume snapshot -r $(stat --format=%m .) 1.s 
btrfs subvolume snapshot -r $(stat --format=%m .) 2.s seq 10000000 > 
76mb.file -btrfs filesystem sync . +btrfs filesystem sync thin-mount 
btrfs subvolume snapshot -r $(stat --format=%m .) 3.s btrfs send 1.s | 
wc -c | numfmt --to=iec @@ -25,7 +23,7 @@ btrfs send -p 2.s 3.s | wc -c 
| numfmt --to=iec -cd .. +btrfs subvolume delete *.s umount thin-mount 
rm -f thin-disk rmdir thin-mount
Regards,
-Ashok.


