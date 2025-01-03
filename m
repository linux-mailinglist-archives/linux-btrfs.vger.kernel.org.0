Return-Path: <linux-btrfs+bounces-10714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE69A00D5B
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 19:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5883A4327
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 18:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7781FC7D9;
	Fri,  3 Jan 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=online.de header.i=rewolf-kernel-mail@online.de header.b="MgHSCyhw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF71FC7C6
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735927591; cv=none; b=Kj7GeeAJ8fWfZS9QmvyP3ePpWhf3swQlfxEEhdU8q9cijkIMmVRPM+nl+dAc0h/vERBI1USmFwCEXwPOClEaqjuuGabc/75Q3SxIzt+t2qQDWtCF/3l/+Qp0EwjJuwb4u/31sEi2NvPVBebvu5W0fA9B6X8SeP6XeklJJL8ujD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735927591; c=relaxed/simple;
	bh=XhO7DNu80XOMyY4dVT63c5ip/ynzDIkszGrFOiwqVAI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HoalcMEgxhQv9xzTj2ovNR9ckXlcC//p3mitB+17jFfMHzOw/YWYgAA5zlKwiPRGytoGk46OzTIr02AvKA21XhfAWwhoDrkBeVC9LVlOsHvutCgP7k7SNeq4oZNbwcKgmaW1nOJKCq7CbkWAs3+Zv+qIUCSe0j1EjBNtsdDQj0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de; spf=pass smtp.mailfrom=online.de; dkim=pass (2048-bit key) header.d=online.de header.i=rewolf-kernel-mail@online.de header.b=MgHSCyhw; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=online.de;
	s=s42582890; t=1735927587; x=1736532387;
	i=rewolf-kernel-mail@online.de;
	bh=GdJvNZbQwJan2YzXVFO7Moo5Msekw4oTMdGVS2S8b0A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MgHSCyhwkmb68ktKCHcAL1AN4yGDkir0crIfHsygxK4HajtLE3tX0P/2dJ95llXC
	 /dmI0wRSDiyXctbIFFkIMUbD1R7byYVIfStEmXMtKZxYLE1BJGGX4vl9Dl8gXt7/m
	 MAQk3bQstqHR32e5YtlsQOGiR5tG+3p4nqjBh2bH508cwKOCYE5umBVbrcesZuZq3
	 XYmx86FwkPbUg2sn20LDN9wq6taTYqUW1oZXyxXtr1v3n8sGQA6zII1tCHeBaPn3e
	 Qa1lyFYshPVPYJTOwusYf8yZcq6oWv4xJjICrzAmdma8YO3Ab3pVOr8NKSFkweJ/6
	 njGV1TfIc9r3kl6ofw==
X-UI-Sender-Class: 6003b46c-3fee-4677-9b8b-2b628d989298
Received: from [192.168.6.211] ([92.117.233.153]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MRC7g-1t8xQl1712-00QXQt for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2025
 19:06:27 +0100
Message-ID: <8fc3f4fd-7b24-4367-9685-4b14598ce098@online.de>
Date: Fri, 3 Jan 2025 19:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-btrfs@vger.kernel.org
From: Rene Wolf <rewolf-kernel-mail@online.de>
Subject: btrfs scrub fails / __btrfs_free_extent:3257: errno=-5 IO failure
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:goDb17O9I6CFUTgWhNmLfbOtRjdg+aNboeeHo+QRjucHmwEcZGT
 lOUbfbgAvNYmCtZ2vaJ8X+w+Jw2P6gCWk6eSLjGEWU8pQ/n14oPzkX+NJ03mkoW9VcDnOWW
 t4zLzLv0z6O+H6X8EpbQEtFDtXHivCuYX/RJaPeSHGdrSTdfGknXs952F7n0quSfkuSE1YY
 4d3NxZ9aVSUhAjKTZd/5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uKt0qOiXt1Y=;7+M6DEAPn9x5HlsWtU0IhJi+9Nm
 kh8CvEBWoggTbtMMuSnt6aSmLGNCaX3DbBeVS/9Rm9bCXeZGND7xNNxXb0Lg9OsvgvdErbZCS
 x0V2MUlR3ZKyhLiByL77mAU//A5MNYek6zxCzuTWITB23JWLSfU3Bf48AEOMHEw2wD3bk+Ubd
 r/tmepN1a21NPj6n/zk8+5BF1GSKM1CRPe9jZGQhqw+rcs1CL4PfQuefgeY6G0VU/J3eQQ1zh
 bULLbNvszAxyQp8L1ONzwPauPkaiVXz1HeGNS2SLVAFYrnpzusnLtLjwLqt6YSNrP7ozmeTOZ
 Uq6yy569kALW0KxQEgooxPZZ6WWfJF/NQ4rSYq50pkS6Hijr/2KaMwdyyF0D8o6/hbaTvdQ/Z
 KxWtvrrTWYV0z/ORu1uvIlkQKn9pf08/2n3PNMmJo60h2fqiM438cyZgQfLpekT+0//SwLY+/
 AjU4/DibTG3YiKLnNTo8g0nN7LKCLWPy/63SNcasHYwBlEBNMI7VN4kJmCSxA2T8GFhQovaCC
 nG1Mh6v5fABRtMR7Xuo5uNny4kU/paXZv4BAJVg6XKi9ArKwiUy3rA4ZSH4QegnBEGYQBdMgd
 hKwBXbziyNz8NfeFRJi87Fbxp0lBBvMLDrlDxIq7nFANEyPzSZXQTkvZHWL0n9KLNTJGjgBHX
 r6mqwfLi35La88788YpnsXvxI1zQAqSmo7gm1g0efkNky+jeC+9FDmlaWwDOdhPhjdwN2Y114
 yOGW6yT4O1ZFO7ERfBUzMxNnk834ExNx5F9W7aFC/+7C583cfl4LM37fDa5vmWnLwl4N4RT2T
 P8eOa9NF8HqO4E02pldrzPNr030bhop7zayQk/Q2wA8dQByFL7lODF/X5McRMvg/A8YyiHMKY
 uhnO1M37wStpw3W7nPYrKPyvt7eIFxxnpfV78RKc1NTPIx7lapdEYFx7KQuI0XjeCspYFShMc
 mgUf5ZYiD9b/uoL3o/z5Jf8qDnEjHusFyi2NrORDFtmC08xnLeasv13US3NIXLzYQ7ochKCDx
 spXycj88IC8okaa4jY=

Hi everyone!


I'm having some trouble with a btrfs file system.

First here's my setup:

- 8TB SATA spinning HDD
- connected via USB-to-SATA
- full disk encrypted (cryptsetup / LUKS)
- the encrypted device directly contains a btrfs file system (no partitions etc)
- filesystem is SYS/META=DUP, DATA=Single
- raspberry pi 4, running ubuntu 24.04 / Linux host 6.8.0-1017-raspi #19-Ubuntu SMP PREEMPT_DYNAMIC Fri Dec  6 20:45:12 UTC 2024 aarch64 aarch64 aarch64 GNU/Linux
- btrfs-progs v6.6.3

Here's what happened: the file system was mounted, and being written to, when the USB device was lost / disconnected. I'm 95% certain at this point that this was not caused by the USB-to-SATA bridge, but a power failure, leading to a reset on the SATA bus / HDD side. I connected the HDD to a regular desktop PC, running the same OS and btrfs progs.

The file system can be mounted normally, but a subsequent scrub ends in an abort (and read-only filesystem). Here's dmesg:
[76435.918828] BTRFS info (device dm-0): scrub: started on devid 1
[76435.957252] BTRFS error (device dm-0): super block at physical 274877906944 devid 1 has bad generation 6079 expect 6080
[76469.312326] BTRFS error (device dm-0): parent transid verify failed on logical 2070681747456 mirror 1 wanted 6080 found 6062
[76469.320886] BTRFS error (device dm-0): parent transid verify failed on logical 2070681747456 mirror 2 wanted 6080 found 6062
[76469.320945] BTRFS error (device dm-0: state A): Transaction aborted (error -5)
[76469.320968] BTRFS: error (device dm-0: state A) in __btrfs_free_extent:3257: errno=-5 IO failure
[76469.320981] BTRFS info (device dm-0: state EA): forced readonly
[76469.320986] BTRFS error (device dm-0: state EA): failed to run delayed ref for logical 4170042540032 num_bytes 16384 type 176 action 2 ref_mod 1: -5
[76469.321002] BTRFS: error (device dm-0: state EA) in btrfs_run_delayed_refs:2261: errno=-5 IO failure
[76469.321016] BTRFS warning (device dm-0: state EA): Skipping commit of aborted transaction.
[76469.321021] BTRFS: error (device dm-0: state EA) in cleanup_transaction:2020: errno=-5 IO failure
[76469.349885] BTRFS info (device dm-0: state EA): scrub: not finished on devid 1 with status: -125
[76469.350407] BTRFS error (device dm-0: state EA): scrub: failed to start transaction to fix super block errors: -30

I used "btrfs rescue super-recover -v /dev/mapper/backup" which did fix the super block problem. A subsequent scrub however gave the same result (minus the super block error). Next I used "btrfs inspect-internal dump-tree --block 2070681747456 /dev/mapper/backup" to take a look at that block, here's the output with the first 4 items (remaining items are similar):

btrfs-progs v6.6.3
leaf 2070681747456 items 502 free space 3253 generation 6062 owner FREE_SPACE_TREE
leaf 2070681747456 flags 0x1(WRITTEN) backref revision 1 csum 0xbed7400f
fs uuid 29783eed-dc2f-443e-b2ab-842e1162a4a8
chunk uuid cb1864e7-e501-4c5d-a0b6-50f9eedfebc7
     item 0 key (4106019143680 FREE_SPACE_INFO 1073741824) itemoff 16275 itemsize 8
         free space info extent count 1 flags 0
     item 1 key (4107092791296 FREE_SPACE_EXTENT 94208) itemoff 16275 itemsize 0
         free space extent
     item 2 key (4107092885504 FREE_SPACE_INFO 1073741824) itemoff 16267 itemsize 8
         free space info extent count 1 flags 0
     item 3 key (4108166463488 FREE_SPACE_EXTENT 163840) itemoff 16267 itemsize 0
         free space extent

So the way I understand the dmesg output and the tree dump, is that the block itself is consistent (checksum matches), and both mirrors contains the same content. However the path taken to reach that block, expects generation 6080, but the block is actually 6062 (an older revision). At first this seemed rather odd, but then I though this could "make sense" in combination with the block encryption layer provided by LUKS. Due to encryption it has to cache and then write rather large blocks of encrypted data to disk. So the power outage caused a large chunk of data not to be written at all, and the data that should have been overwritten with the updated revisions, was not. This would explain why the existing (old) data is consistent in itself, but other parts of the filesystem pointing to it, expect to find newer revisions. So far my theory at least :D

I ran a "btrfs check --readonly --progress" on the unmounted FS next and there is a lot of those cases it seems:
[1/7] checking root items                      (0:00:04 elapsed, 196409 items checked)
parent transid verify failed on 2070549184512 wanted 6080 found 6062
parent transid verify failed on 2070888857600 wanted 6080 found 6063
parent transid verify failed on 2070888923136 wanted 6080 found 6063
parent transid verify failed on 2071091200000 wanted 6080 found 6063
parent transid verify failed on 2071091200000 wanted 6080 found 6063
parent transid verify failed on 2071091200000 wanted 6080 found 6063
...

I was wondering why scrub was bailing and not continuing as it does with regular checksum errors. So I though what would scrub do if the checksum was wrong. I tried to find the physical location of the two mirrors of block 2070681747456, which was surprisingly hard. Ultimately I ran the above dump-tree via strace and just looked for the read offsets. Then I zeroed out the checksum on each of the mirrors (as per https://btrfs.readthedocs.io/en/latest/dev/dev-btrfs-design.html ). Then mounted and ran scrub again:

[88213.289377] BTRFS info (device dm-0): scrub: started on devid 1
[88247.339677] BTRFS warning (device dm-0): checksum verify failed on logical 2070681747456 mirror 1 wanted 0x00000000 found 0xbed7400f level 0
[88247.348274] BTRFS warning (device dm-0): checksum verify failed on logical 2070681747456 mirror 2 wanted 0x00000000 found 0xbed7400f level 0
[88247.348305] BTRFS error (device dm-0: state A): Transaction aborted (error -5)
[88247.348324] BTRFS: error (device dm-0: state A) in __btrfs_free_extent:3257: errno=-5 IO failure
[88247.348337] BTRFS info (device dm-0: state EA): forced readonly

So the checksum errors are detected as a warning but scrub still bails. I also reran "btrfs check --readonly" and it did find the checksum errors:
"checksum verify failed on 2070681747456 wanted 0x00000000 found 0xbed7400f"

I ran a long ATA self-test, which passed, and the other SMART values also look fine, so I guess the drive is OK.

My goal is to get the file system back into a consistent state, (some) data loss is expected of course. This system contains backup data, and can be restored from other sources, but this takes a long time to do, so any amount of data that can be reused from that FS is a win.

Which leads me to a couple of questions:
- Why does scrub bail in that case and not continue with the older revision, or is the problem not actually that block but something else?
- Should I try the "btrfs check --repair" route?
- Is there another way to fix those generation mismatch errors?
- Could taking a ro-snapshot before writing to the FS help with such power failure scenarios?
- If it is due to the LUKS setup is there anything I can change here? Or is something like "ecryptfs" a better choice?

Feel free to ask for any additional info of course, any help appreciated!

Thanks and best regards
Rene

