Return-Path: <linux-btrfs+bounces-2454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76B857DB2
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 14:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 395CAB21F32
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Feb 2024 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9A4129A9B;
	Fri, 16 Feb 2024 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inix.me header.i=@inix.me header.b="NvE7Jm7x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.inix.me (mail.inix.me [93.93.135.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4D7868D
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Feb 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.135.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090387; cv=none; b=By9EZsur+RB7aW8exV7ZzSGR1z4UizLTPfQsXrS8u+mo+w1OYYjdO7S+h67ECQSN10SjjcGnoPJsvB7FOyd7974x/dj8n+zoitwc7IsxIV/LsEv+9B4GSyFOdJEwtXSnTUZVo166dveVjrym+xI1i0ZOJybhdKe/MELQEhUwntw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090387; c=relaxed/simple;
	bh=cK35MNe1D/QOUWUmerskFVfxcnb0MV5GHNJx5ouweFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSnhYBxGAL1tePDopnSg8SWJpa9amb/lgxjg44IbdZEElGdnOjmxk5qeyPNWk6uxu1+3epTezXWv/voCjTnEbftZVnGKqj90SzQAH1mQT/zSA/2BGjjmN/S5ZGp1LfG1hVFarqAPAs+57oTsq0oV0lfexuEpEu6SGUdLx9uOljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me; spf=pass smtp.mailfrom=inix.me; dkim=pass (1024-bit key) header.d=inix.me header.i=@inix.me header.b=NvE7Jm7x; arc=none smtp.client-ip=93.93.135.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inix.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inix.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inix.me;
	s=primary; h=Sender:Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0/WUL3IIkOBOSy71De3KEzfnNxbDSZ/FZoKKXM7EKaI=; b=NvE7Jm7xRYED8WL+AB/qyBAhim
	W+JDLOYC59YEFoVNydm78RCDcDOYclZv8dFWFrzBLh6yZXuFQ3sKpTY3/MY+LGuFD3zuNUj2qaNM8
	aMTBPAgCQEs8KjtpPHzCcmjmHutsjz3tg0NKqHB/wS1xnFXASvz5vf0ZSJAqygZ+iE8Y=;
Received: by mail.inix.me with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.96)
	(envelope-from <dash.btrfs@inix.me>)
	id 1rayVx-00A5Pm-32;
	Fri, 16 Feb 2024 13:44:30 +0000
Message-ID: <20b3b98b-b165-4fd7-b026-8f3c8440a631@inix.me>
Date: Fri, 16 Feb 2024 19:02:56 +0530
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
Content-Transfer-Encoding: 8bit
Sender: dash.btrfs@inix.me

[Sorry about the garbled reply before]


 > I turned your reproducer into this script:
 >

Thanks.

 > $ cat test.sh #!/bin/bash
 >
 > truncate -s +3G thin-disk mkfs.btrfs thin-disk >& /dev/null mkdir
 > thin-mount mount thin-disk thin-mount/
 >
 > fstrim thin-mount
 >
 > cd thin-mount/

I am taking snapshots on the main filesystem where `thin-disk` file is 
present (ie., not on thin-mount/).

 > Well, I'm unable to reproduce that on a 6.8-rc4 kernel, but nothing
 > changed since 6.7 regarding send, and using a thin provisioned disk
 > or fsstrim is irrelevant from a send perspective.
 >

I have modified the script to reproduce the issue, kindly try it again. 
The modified script is below,

$ cat test-modified.sh

#!/bin/bash

truncate -s +3G thin-disk
mkfs.btrfs thin-disk >& /dev/null
mkdir thin-mount
mount thin-disk thin-mount/

fstrim thin-mount

btrfs subvolume snapshot -r $(stat --format=%m .) 1.s
btrfs subvolume snapshot -r $(stat --format=%m .) 2.s
seq 10000000 > 76mb.file
btrfs filesystem sync thin-mount
btrfs subvolume snapshot -r $(stat --format=%m .) 3.s

btrfs send 1.s | wc -c | numfmt --to=iec

btrfs send 2.s | wc -c | numfmt --to=iec

btrfs send 3.s | wc -c | numfmt --to=iec

btrfs send -p 1.s 2.s | wc -c | numfmt --to=iec

btrfs send -p 2.s 3.s | wc -c | numfmt --to=iec

btrfs subvolume delete *.s
umount thin-mount
rm -f thin-disk
rmdir thin-mount


Output:-

# ./test-modified.sh
Create a readonly snapshot of '/mantyl-backup' in './1.s'
Create a readonly snapshot of '/mantyl-backup' in './2.s'
Create a readonly snapshot of '/mantyl-backup' in './3.s'
At subvol 1.s
77M
At subvol 2.s
77M
At subvol 3.s
77M
At subvol 2.s
178
At subvol 3.s
2.8G
Delete subvolume (no-commit): '/mantyl-backup/playarea/1.s'
Delete subvolume (no-commit): '/mantyl-backup/playarea/2.s'
Delete subvolume (no-commit): '/mantyl-backup/playarea/3.s'


# ./test.sh
Create a readonly snapshot of '/mantyl-backup/playarea/thin-mount' in 
'./1.s'
Create a readonly snapshot of '/mantyl-backup/playarea/thin-mount' in 
'./2.s'
Create a readonly snapshot of '/mantyl-backup/playarea/thin-mount' in 
'./3.s'
At subvol 1.s
202
At subvol 2.s
202
At subvol 3.s
76M
At subvol 2.s
170
At subvol 3.s
76M


Diff of my changes to the script are below,

# diff -u test.sh test-modified.sh
--- test.sh    2024-02-16 18:32:56.272000000 +0530
+++ test-modified.sh    2024-02-16 18:22:31.176000000 +0530
@@ -7,12 +7,10 @@

  fstrim thin-mount

-cd thin-mount/
-
  btrfs subvolume snapshot -r $(stat --format=%m .) 1.s
  btrfs subvolume snapshot -r $(stat --format=%m .) 2.s
  seq 10000000 > 76mb.file
-btrfs filesystem sync .
+btrfs filesystem sync thin-mount
  btrfs subvolume snapshot -r $(stat --format=%m .) 3.s

  btrfs send 1.s | wc -c | numfmt --to=iec
@@ -25,7 +23,7 @@

  btrfs send -p 2.s 3.s | wc -c | numfmt --to=iec

-cd ..
+btrfs subvolume delete *.s
  umount thin-mount
  rm -f thin-disk
  rmdir thin-mount



Regards,
-Ashok.




