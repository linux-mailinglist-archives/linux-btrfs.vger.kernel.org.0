Return-Path: <linux-btrfs+bounces-21846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFDnHzB2nGmwHwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21846-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 16:45:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E2C178F9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 16:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B5B230967EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Feb 2026 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC072F2910;
	Mon, 23 Feb 2026 15:41:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D781E2F25F4
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861277; cv=none; b=eo5onzAq72Uc9Xkga5mlMyjs0MYmWxaep+r0zL342SZa96tCKR6dCAQiVfyNx3asZp6ehNe7H3Ki0L8pnfItBl3y8oULkHXOD5gGzvZVZZjyNF9Xucx61NATwy8E3ZAuwL6d4pcdpXKatauk3zMNbZ4cBaE97PKekGPnT6FgS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861277; c=relaxed/simple;
	bh=GV5nPSP4TqRJKHL+PXwFjhUZsD0r3/3Jnb3dq3tZ3i4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=WJEoxN3cYHFC5rMTMZA1ZFkRsd1Djm77HLSh9wbBYoJGoxN2kelH8RvSpHupddAzV1vLLa1n2NKbUfjxwOEZ1dG5HhKlmsIx+y9IaHBYKm2iVgFm6rD7XnWpxKqn+Y0LJXE80nJP9hZ5cdppmmIxBt/IcxzmJHepfDTOS0cnsL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [IPV6:2a01:e0a:156:6850:7018:89ff:fecb:6f21] (unknown [IPv6:2a01:e0a:156:6850:7018:89ff:fecb:6f21])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 33DBD19F5C6;
	Mon, 23 Feb 2026 16:41:12 +0100 (CET)
Message-ID: <deb56ee2-b5d6-4beb-9554-05da125dde54@free.fr>
Date: Mon, 23 Feb 2026 16:41:11 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phako <phako@free.fr>
Subject: Re: Stuck on a BTRFS problem
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <77535c20-da3e-4dfb-b3d7-9426c25b5da3@free.fr>
 <0211658c-8d28-46d1-8e41-21dc02cab276@suse.com>
 <b1c1247f-df00-4045-a508-fb9a5666114a@free.fr>
 <cb183999-6a95-456a-80f4-f703da298d74@suse.com>
Content-Language: en-US, fr
In-Reply-To: <cb183999-6a95-456a-80f4-f703da298d74@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[free.fr : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[phako@free.fr,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[free.fr];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21846-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: E8E2C178F9F
X-Rspamd-Action: no action

Le 23/02/2026 à 08:32, Qu Wenruo a écrit :
>> Here is the scrub error output concerning the corrupted file_A.mp4 
>> (now deleted)
> 
> So it's really physical address, and your "btrfs ins dump-tree" call on 
> whatever bytenr doesn't make any sense.
> 
> No matter if you're using logical nor physical bytenr, there is no 
> metadata block group for them, thus csum mismatch is expected.

I'm sorry I wasn't more clear, I run the dump-tree command on the 
corrupted file that is not deleted, still not sure if it's wrong or 
useful though.

> I have already submitted a patch to prevent end users passing wrong 
> numbers into "btrfs ins dump-tree":
> 
> https://lore.kernel.org/linux- 
> btrfs/56d383400ae8a0ff20b5141baa1ab4068c5603ef.1771798449.git.wqu@suse.com/
> 
> 
> Now let's go back to the original problem.
> 
> Firstly according to your kernel version, it looks like upstream v6.12 
> doesn't have the upstream commit 968f19c5b1b7 ("btrfs: always fallback 
> to buffered write if the inode requires checksum") backported.
> 
> That means if your nas has some direct IO workload and the program 
> doesn't properly wait for the direct IO to finish before updating the 
> buffer in user space, it can lead to such data checksum mismatch.
> 
> This is a long known problem and finally worked around upstream, but 
> unfortunately not backported to v6.12 yet.
> I'll need to submit it for backport soon.
I've seen this issue but the fact that the errors happen on the same 
physical address made me discard this possibility.
The fact that I run the same software on the same OS and that I didn't 
have those bad checksum before the disk swap also make me think that.

> If that's not the case, and you always hit the same corruption at the 
> same physical address, it may really be the HDD.

I tend to agree, but the neither the kernel nor the RAID controller nor 
SMART data report I/O errors  with any of the disks


> Then add the HDD to the existing fs, re-balance all data to RAID1, do 
> some extra writes, and wait to see if the problem happens again.

Sorry again, the RAID1 array is hardware, it's not a BTRFS RAID
The BTRFS profile is METADATA=DUP, DATA=SINGLE.

> If the problem happens that both copies have data checksum mismatch thus 
> unable to repair, it will be more like the direct IO bug.
> 
> If only sda3 keeps throwing out errors but the other one is totally fine 
> (and btrfs can automatically use the correct copy to over-write the bad 
> one on sda3), then we know it's sda3 to blame.
> 
> Thanks,
> Qu
> 

I get that you might think this issue is not BTRFS related, but I'm 
still not 100% sure of what is the cause of the error. So I'm still 
having a couple of questions to rule out wrong hypothesis or direct me 
on the right track:

Do you think that if I copy a good copy of file_B.mp4 over the corrupt 
file_B.mp4 (eg: cat b.mp4 > b_corrupt.mp4) it will overwrite the 
metadata and the same physical LBAs?
Are there any btrfs commands I could run before and/or after to check if 
it worked, and to map this reported corrupt logical blocks with actual LBAs?

To be 100% sure that there is no read error, I would like to read 
directly the LBA concerned, I'm wrong when I think that the physical 
address reported by the scrub is in bytes and can be read by a command 
of the like "dd if=/dev/sda3 skip=(physical/block-size) ... " ?

And for your information (maybe you will see something I can't) here the 
log of the csum error I got with the corrupt old and new files when I 
opened them where we can see that several blocks have the same bad 
checksum on both files (0x8941f998), I tend to interpret this as an 
evidence of a hardware problem (blocks with the same erroneous pattern, 
maybe all zero or all one, I don't know how to check that), but I'm not 
sure either if that could be the result of the direct I/O bug discussed 
above.

file A
Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e 
mirror 1
Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 40442 off 46104576 csum 0x8941f998 expected csum 0xab595bcc 
mirror 1
Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 40442 off 46108672 csum 0x8941f998 expected csum 0x1486c38f 
mirror 1
Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 40442 off 46112768 csum 0x8941f998 expected csum 0xc28892df 
mirror 1
Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 40442 off 46116864 csum 0xf43cb1df expected csum 0xb62dc162 
mirror 1
Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e 
mirror 1
Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 11, gen 0
Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e 
mirror 1
Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 12, gen 0
Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e 
mirror 1
Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 13, gen 0
Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e 
mirror 1
Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 14, gen 0
Feb 09 16:18:02 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 40442 off 46100480 csum 0xc9e01f9a expected csum 0xb20f9f0e 
mirror 1
Feb 09 16:18:02 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 15, gen 0



file B
Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 230235 off 31494144 csum 0x6741cf10 expected csum 
0xca5f6f32 mirror 1
Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 46, gen 0
Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 230235 off 31498240 csum 0x8941f998 expected csum 
0xee146cb6 mirror 1
Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 47, gen 0
Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 230235 off 31502336 csum 0x8941f998 expected csum 
0x4dd93576 mirror 1
Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 48, gen 0
Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 230235 off 31506432 csum 0x8941f998 expected csum 
0x2876e5c4 mirror 1
Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 49, gen 0
Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 230235 off 31510528 csum 0xf43cb1df expected csum 
0xb6436c41 mirror 1
Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 50, gen 0
Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 230235 off 31494144 csum 0x6741cf10 expected csum 
0xca5f6f32 mirror 1
Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 51, gen 0
Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 230235 off 31494144 csum 0x6741cf10 expected csum 
0xca5f6f32 mirror 1
Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 52, gen 0
Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 230235 off 31494144 csum 0x6741cf10 expected csum 
0xca5f6f32 mirror 1
Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 53, gen 0
Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 230235 off 31494144 csum 0x6741cf10 expected csum 
0xca5f6f32 mirror 1
Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 54, gen 0
Feb 22 06:45:48 soleil kernel: BTRFS warning (device sda3): csum failed 
root 257 ino 230235 off 31494144 csum 0x6741cf10 expected csum 
0xca5f6f32 mirror 1
Feb 22 06:45:48 soleil kernel: BTRFS error (device sda3): bdev /dev/sda3 
errs: wr 0, rd 0, flush 0, corrupt 55, gen 0


Meanwhile, I'm gonna run a memtest, because I've no idea what else to do.

Thank in advance.


