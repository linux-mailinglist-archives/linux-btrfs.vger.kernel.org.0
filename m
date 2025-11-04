Return-Path: <linux-btrfs+bounces-18676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAD5C325C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 18:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CC7188578F
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D817233A021;
	Tue,  4 Nov 2025 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=friedels.name header.i=@friedels.name header.b="RIALO8ak"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sm-r-011-dus.org-dns.com (sm-r-011-dus.org-dns.com [84.19.1.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E558334363
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.19.1.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277513; cv=none; b=taDZ7DbFjHB8vJoB9cJrXQcaMWQW40kkErZjePRvhY1jJ3guT4XE7r6izZ1hP2wJPjs862gMz8e/uXxZ4kbC7e3gYiGlAIvplwbyWlf4Z+/VYQPHQCgbUxsHXaV4KpxsMeffhNDJAROtOSQySV+WXC50Vidw0lW8mRF/bSCC/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277513; c=relaxed/simple;
	bh=Dl+V11Kmkoc1loQaQb9POCUUfhibRBvPlR0053OaGso=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=s6BfSZeufacDlikVNzna4mded4uEawSMcQSIMvYCN2tmr545eOCHGMye6A91c8HaxcnbC4VIn57e42gTxsgnmFbVH8zeH7OgMYH6UpjEPQOvAgUohG96D7PU2hwnmW4hHGZmThP8Q8TZ5QfeGg2D+VsZU4uTS4qweyTX3YZ5n7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=friedels.name; spf=pass smtp.mailfrom=friedels.name; dkim=pass (1024-bit key) header.d=friedels.name header.i=@friedels.name header.b=RIALO8ak; arc=none smtp.client-ip=84.19.1.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=friedels.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=friedels.name
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
	by smarthost-dus.org-dns.com (Postfix) with ESMTP id 3F02AA11B3
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 18:26:15 +0100 (CET)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
	id 3139DA0AE5; Tue,  4 Nov 2025 18:26:15 +0100 (CET)
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by smarthost-dus.org-dns.com (Postfix) with ESMTPS id 7719FA0A53;
	Tue,  4 Nov 2025 18:26:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=friedels.name;
	s=default; t=1762277228;
	bh=KDQzWE6kWa4jDe1BsM8/qff+MMgi2oAcI7C/JWMRQro=; h=Subject:From:To;
	b=RIALO8akI7s74Vc74rnyn13zUb7akQzCL9FmyYKaGPA/J7pQQk5LgUum7IipprXAN
	 6V0tQOo708tZwU6tWzvVYPDuXZEs/c1vAhXmewG1sO+jHSCSazvIGH2Ca8G/3eywAF
	 AU/RlSG+w4ePoGZa0YXuG0MwEtW2TvMGsJ4xMC1Y=
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 88.65.226.178) smtp.mailfrom=hendrik@friedels.name smtp.helo=[192.168.177.137]
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
Message-ID: <9b9fffc2-7a95-492b-8ef0-39195b1cdb61@friedels.name>
Date: Tue, 4 Nov 2025 18:26:13 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Corrupt Filesystem (Mirror) despite previously successful scrub
From: Hendrik Friedel <hendrik@friedels.name>
To: Chris Murphy <lists@colorremedies.com>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <cfc7539c-a0c5-45d2-a781-89c2e0cb2c62@friedels.name>
 <12716866-2ffe-4cbb-8e2f-8b2e4abd0237@app.fastmail.com>
 <a37cea05-f77f-41f1-8763-a28311b72790@friedels.name>
In-Reply-To: <a37cea05-f77f-41f1-8763-a28311b72790@friedels.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176227722823.911836.5177977809593350023@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK

Hello,

any further suggestions on this one?


Greetings,

Hendrik

Am 31.10.2025 um 10:05 schrieb Hendrik Friedel:
> Hi Chris,
>
> thanks for your reply!
>
> FYI: I am now running "badblocks" on SDA (Serial Number: Y5J6YGLC) 
> since 2 days without errors. It is not complete yet (it does four 
> different patterns), but two patterns are passed already.
>
>>> The history:
>>> - a raid 1/mirror of data and metadata. 12TB identical WD Drives
>>> - some issues with bad sata cables, causing related dmesg messages
>>>      https://pastebin.com/Z0T3fhcv
>> This ends after the bus error, so we have no idea what happens next, 
>> including whether Btrfs became aware of the problem or what it did next.
>
> This was expemplary. I had them "occasionally" (every few days, 
> probably when there's more data transfer). There were no btrfs errors 
> shown after that.
>
> Here you see a grep for btrfs and ata of my kernel log. I had a script 
> mailing me that output once per day (so each log covers one day). I 
> post several logs in a reverse-chronological order. I add an 
> AI-Generated chronology at the end of my mail, which is easier to read 
> (but we know AI limitations..)
>
> https://pastebin.com/sKWvQa37
>
> this one includes the balance.
>
> You can see that there are no errors after the ata cable issues.
>
> Here you have the same a few days earlier and including the scrub
>
> https://pastebin.com/fXgrYSi0
>
> And this one includes some read error corrected: ino 1219881 off 
> 524288 (dev /dev/sda1 sector 5043988088)
>
> https://pastebin.com/FMShKU0F
>
> This one includes some errors found on my Boot-Drive (nvme). I think 
> it is not related
>
> https://pastebin.com/uAqijjQh
>
> I ran a scrub
>
> Okt 16 00:47:32 homeserver kernel: BTRFS info (device sdb1): scrub: 
> finished on devid 1 with status: 0
> Okt 16 02:37:59 homeserver kernel: BTRFS info (device sdb1): scrub: 
> finished on devid 2 with status: 0
>
> Here are quite some errors two weeks earlier, that I was not aware of:
>
> https://pastebin.com/EYcAc2hB
>
> Here a scrub and many errors:
>
> https://pastebin.com/mNYDTGpr
>
> [many days with ata but without btrfs errors]
>
> And a last one, with some "odd" errors. But much earlier
>
> https://pastebin.com/Yv4pAbxg
>
>
>>> -UDMA_CRC_Error_Count: 1237 on one device. It remained stable since I
>>> replaced the cables, also during one successful scrub run. Also I 
>>> run now
>>>     for host in 
>>> /sys/class/scsi_host/host*/link_power_management_policy;
>>> do echo max_performance > "$host"; done
>>>     during boot - not sure whether this or the cables did the trick.
>> But were both drives affected at the same time?
> Yes, the logs show a clear instance where ATA errors occurred on two 
> different drives at almost the same time.
> This happened on October 26 https://pastebin.com/sKWvQa37
> First Drive (ata5): A series of interface fatal error events started 
> at 14:31:34 and ended with the link speed being limited at 14:31:44 .
>
> Second Drive (ata4): A new series of interface fatal error events 
> started just one minute later at 14:32:47 and ended with the link 
> speed being limited at 14:32:54
>
> But this did not cause (visible) btrfs errors.
>
>>
>> [So Okt 26 18:30:23 2025] BTRFS critical (device sda1): unable to 
>> find logical 15401206349824 length 16384
>> [So Okt 26 18:30:23 2025] BTRFS critical (device sda1): unable to 
>> find logical 15401206349824 length 16384
>>
>> Well that seems bad. Both copies? And scrub didn't detect this problem?
>>
>> I guess that means writes to both drives were lost, but then Btrfs 
>> should know this, and not write a super block update pointing to a 
>> root tree with metadata write failures.
> But normally that should not occur, when an error on the SATA Cable is 
> found. It should be repeated.
>> It should, but I'm not following the sequence. You scrubbed *after* 
>> the cable problem was resolved, and that scrub comes up clean.
> Correct
>>   But then you balance and the file system reports missing logical 
>> blocks, goes read only?
> Yes
>> scrub checks for csum mismatches, not file system consistency
>>
>> check checks for consistency
> But in order to scrub, the Filesystem must be consistent and fully 
> readable, I thought. TBH, when you read about btrfs, the message is: 
> do scrubs, but do not touch btrfs check. Apparently, you should do 
> both regularly, and it is only --repair that you should avoid.
>>
>> But to scrub, btrfs needs to read the chunk tree, and metadata. I'm 
>> confused how it can scrub without error, but then run into a problem 
>> with balance.
> My thinking.
>> I think wait for a developer or more experienced user to respond. 
>> Your confusion makes sense to me. Unless the hardware issue occurs 
>> *exactly identically* for both drives (they'd have to share the cable)
> They do not share a cable.
>> at the same time, then your expectation that raid1 on separate drives 
>> is correct, it should protect against this case.
>>
>> So I have to wonder if it's a bug. Hence, what kernel version?
>
> Me too. That (and to learn that I should do btrfs check regularly) is 
> why I reach out instead of using a backup. It is 6.3.3 (I had been 
> 6.5.0 for a while).
>
> Best regards,
>
> Hendrik
>
> Here the AI-generated chronology
>
> Sep 20 (Yv4pAbxg.txt)
> - ATA: Interface fatal error and hard link reset on ata4 and ata6. 
> Link speeds limited to 3.0 Gbps [cite: 417-429].
> - BTRFS: No corruption errors. Minor warning about deprecated space 
> cache v1[cite: 431].
>
> Oct 14 (mNYDTGpr.txt)
> - ATA: Interface fatal error and hard link reset on ata5 [cite: 524-527].
> - BTRFS: "tree first key mismatch" on nvme0n1p3 [cite: 529-542]. 
> "parent transid verify failed" on sdb1, corrected by sda1[cite: 591].
> - SCRUB: Started on sdb1 and sda1[cite: 595]. Finished successfully on 
> nvme0n1p3 and nvme0n1p5, though skipping swapfile blocks [cite: 542-591].
>
> Oct 15 (EYcAc2hB.txt)
> - ATA: No ATA errors in this log.
> - BTRFS: Numerous "parent transid verify failed", "bad generation", 
> and "checksum/header error" on sdb1. All were successfully corrected 
> using data from sda1 [cite: 24-46].
>
> Oct 18 (uAqijjQh.txt)
> - ATA: Multiple interface fatal errors and hard link resets on ata5. 
> Link speed limited to 3.0 Gbps [cite: 3-9].
> - BTRFS: Many "tree first key mismatch" and "qgroup scan failed" 
> errors on nvme0n1p3 [cite: 12-23].
>
> Oct 19 (FMShKU0F.txt)
> - ATA: Multiple interface fatal errors and hard link resets on both 
> ata4 and ata5. Link speeds for both were limited to 3.0 Gbps [cite: 
> 441-458].
> - BTRFS: "read error corrected" on sdb1 (using data from sda1)[cite: 
> 461]. Unrelated "tree first key mismatch" on nvme0n1p3[cite: 460].
>
> Oct 20 (fXgrYSi0.txt)
> - ATA: No ATA errors in this log.
> - BTRFS: Multiple "csum failed" errors on nvme0n1p5 [cite: 465-473].
> - SCRUB: Finished successfully on nvme0n1p3 and nvme0n1p5[cite: 500, 
> 521].
>
> Oct 26 (sKWvQa37.txt)
> - ATA: Multiple interface fatal errors and link resets on ata4 and 
> ata5. Link speeds limited to 3.0 Gbps [cite: 49-61].
> - BTRFS: "open_ctree failed" on sda1[cite: 62]. A balance operation 
> was started and failed with a critical "unable to find logical" error, 
> which caused an I/O failure and forced the filesystem into a read-only 
> state [cite: 63, 413-414].
>
>
>
>>

