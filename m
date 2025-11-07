Return-Path: <linux-btrfs+bounces-18803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD099C40DEA
	for <lists+linux-btrfs@lfdr.de>; Fri, 07 Nov 2025 17:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80C01897E9A
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Nov 2025 16:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B57E286426;
	Fri,  7 Nov 2025 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="TvaWI+Oc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YB3wznPr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED02777E0
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532814; cv=none; b=KocLbbjY7LAysFlm0NvoYKmSRVj34vNHU+mD+IgzJLvY9wAnZ6Y4eNrVKp6XHfsD6iOUl+/UtQ+zkBFsxZf4qrvnXYBgPbYKJ1vxZhFAVXyYPbg/S8uHR7yLBoXSuFfW1R7zHDXPXXre39QUOKeHDA6X6VrjD8VEF1PFXsC8q1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532814; c=relaxed/simple;
	bh=107CN98M4xjmmCN5Oyc56bQy7D2kix1UCC6rEO1Bm24=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bY3OQw9oPcLMVQho2+3DcN+BXYzCMFx6r5nRt7xbXH4A2H8jBzx8ttAI2/ue6wvHN3rEiMbRF+JPkHWfrBzt5wTCIBcTr7fHSKoGb2p50UPDSshyPDX9f1RWRr7/nIZoKCLvhXJVoq3d3rfXxjSyt9Ka2WjYfXdbrGLmFUGABFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=TvaWI+Oc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YB3wznPr; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EE3DDEC025B;
	Fri,  7 Nov 2025 11:26:50 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Fri, 07 Nov 2025 11:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1762532810; x=1762619210; bh=w+8LqeMCwcdu/NoQbc0Ur
	prDGmd1c/G5K78gC82lUBo=; b=TvaWI+Ocbfdpzn1VP1K/Zu5G7hPfyZN49LPBn
	rYGK4vlCZaFDk0pLV4RfqmIQju7zPKkYflNuqH1MVsHshPvzM1sWrBLhC7qhIQTZ
	Q/tNMJeZzzPV9qyaLooUDosdYKtaLA/TzvHvnGmA9ivh72MUjf82ONSEhu+35C67
	Qez7wL8psW/HiyuhVUk3JFXGnJQy1sZQtc0CBY/YbzHKPnNkkTYHFGT0PSy9UiZW
	7KqugSC03U4Jwo/CQZC0LsyUV2e7FsVeYSYGrgp5UDVsJ6IJexSJpqtUx8MiwzwF
	yndvG8/cnmcZuLtJ0wNDuft9HFkpwtG9eLiTGECLCHCFObCFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762532810; x=1762619210; bh=w
	+8LqeMCwcdu/NoQbc0UrprDGmd1c/G5K78gC82lUBo=; b=YB3wznPrqAVDONnzR
	3KeiHjUF65yunYQ9iwvxoH23gpIm+Ig37Ivq97cIn4JMWcpJXJ5ss92fUkaxiUCq
	BbwpkNunoo1DRT5BNphC1nkYHNLa+OqU+C98nvVIHrEuJCbwNgjlFM3m2PpBTgCE
	yD0fmEklIKRQxer5Ur8niiyC8uvQ7U1U/Oq97x0Luj8jEfRK1QpEKzBDGt3wZQVR
	sW4dJGhdi4eLtGy52lGytTcReRs6iPbxxnXP9lBbsg7AWkPdXdUgVrF/I9nv5lWv
	Ql+lkDCIdFUqo/F0pchr2hH/+bzQXkbX7gEInM+OHqxsqfVYy0k9lZ/M9BIplaHk
	SKADQ==
X-ME-Sender: <xms:yh0OaSYSOoDZa5IycK4eKUXM1xNWNibIwf5jlOI68T312Zcf7D0EHg>
    <xme:yh0OaQOynk-tlGzd-e-37krvX4vUB_AMDmRjHDvcJm_Pih3gdoBa7aidZI5cwcfgC
    ygBKa8afgAza16Diu47P3_2kXdAG0cBgVqiG88xXQl4Mx5K5baEUauT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhepteefudehkeehgeekhfdvgefhjedvveeuhfdtgfejgfevieev
    iedvfedvhfevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvnhgurhhikhesfh
    hrihgvuggvlhhsrdhnrghmvgdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yh0OadFOZXd-ps3IA2QgXkfOY2PSbukZJZTAXs_Y12ZChWZy_UzKxw>
    <xmx:yh0OaQSeeOltFYqq2-kiVsI6FjQ3UIgZ4TBMbg63xIYLIYTOx26pvA>
    <xmx:yh0OaWtdydNd7F5ZwRYtGXU3pufo4n5iRTYk1mAt5vKM7dneDhdQgA>
    <xmx:yh0OafzT5pzgrHaBgXibJiVGnBice8nQenyyQL-8zteYp0TFyYtUJg>
    <xmx:yh0OaXpuCNbMdjdckKRaHz-zHNmGgrP55c5tQsaP14SGSYgScQKpVglE>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8FBE118C0066; Fri,  7 Nov 2025 11:26:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 07 Nov 2025 11:26:29 -0500
From: "Chris Murphy" <lists@colorremedies.com>
To: "Hendrik Friedel" <hendrik@friedels.name>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <c9247ee9-a056-4454-a3c1-31e28824f9c6@app.fastmail.com>
In-Reply-To: <4d1f7b69-78cf-48eb-8006-f7634fece104@friedels.name>
References: <cfc7539c-a0c5-45d2-a781-89c2e0cb2c62@friedels.name>
 <12716866-2ffe-4cbb-8e2f-8b2e4abd0237@app.fastmail.com>
 <a37cea05-f77f-41f1-8763-a28311b72790@friedels.name>
 <f6858f97-1fe2-49d7-b1ad-dc688142fdcb@app.fastmail.com>
 <eddf3273-d7f9-4bef-865d-dfec1d7ffb66@friedels.name>
 <27964904-b200-46d1-87c6-0dc5d8174036@app.fastmail.com>
 <4d1f7b69-78cf-48eb-8006-f7634fece104@friedels.name>
Subject: Re: Corrupt Filesystem (Mirror) despite previously successful scrub
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Nov 6, 2025, at 2:26 AM, Hendrik Friedel wrote:
> Hello Chris,
> 
> thanks for your reply. Much appreciated.
> 
> By the way: badblocks and smart long test on sdb passed. 
> 
> My main worry is still whether the copy I made two weeks ago (with no errors I spotted on the commandline) is good or not.
> 

How was the copy made? If it's cp or rsync, again Btrfs will not replicate corrupt data. If it's dd/ddrescue block copy, then sure the copy should be identical so it will have whatever issues the original has.


> ok, what would I have to search for?
> 
> I found 
> 
> Okt 14 11:39:26 homeserver kernel: BTRFS warning (device sda1): i/o error at logical 24389920346112 on dev /dev/sdb1, physical 23264022528, root 1382, inode 5800, offset 277139456, length 4096, links 1 (path: Mavic/GranCanaria/DJI_0019.MOV)
> but I am not sure, whether it would always be i/o error.
> 

This error looks like it's from scrub, because it shows path to file, which passive read doesn't show, just the root, inode, offset, length, probably also logical and physical block numbers. 

But this error is in isolation so it doesn't tell the whole story. We would need to see more to know if the other copy is bad too. If not, then this bad block should get fixed up with the good copy. If both are bad, then there's more than one way to properly handle it:

 1. you have a backup or archived copy of that file, so use that, ignore this copy entirely
 2. you need to copy this file with a utility that will continue reading subsequent blocks after it receives EIO -  you will know this because the resulting file is either the same size as the original (it will contain zeros where the bad block is) or it will be short by the number of bad blocks - error handling is up to the application that copies and I'm not sure what those behaviors are for cp and rsync (I think they truncate and stop at the bad block, but I'm not certain). I know dd and ddrescue can be instructed to continue reading additional blocks, and vaguely recall there's a way to tell ddrescue to replace IO error blocks with zeros rather than omit the block (shorten the file).
 3. you need to copy the file out with the defect intact - for this you use `mount -o ro,rescue=all` and this disables checksum verification and permits you to get the corrupt file entirely out of the file system. This might be the best option because you can modify reflink copies of this file however you want to find a solution that will work best for recovery - such as it is. But you need to include with this embargoed file, the fact it's corrupt, and all the corruption errors from btrfs so you know what blocks are corrupt.
 4. You decide the file isn't worth recovery and you let it go.


> The problem is, that these errors do not become visible to the user - unless he searches. And he does once there is a problem. And that is too late. Not a problem of btrfs, but one of linux. 
> 
> Your car gives you a master-warning if something is wrong and does not rely on you regularly browsing logs...
> 

That's why I mentioned nagios. There are other such tools that can monitor logs and send notifications to email whenever certain errors occur. Certainly storage stack errors resulting in Btrfs checksum verification mismatches, read errors, write errors, flush errors, generation errors - are a problem.


>>> - what could have caused it / what can I do better in future
>> Manual or automatic detection of errors so you can start troubleshooting sooner. I'm vaguely familiar with nagios for this. It might be overkill for your purposes. 
> yes. But how to get the hints...

I don't understand the question.


>> There's so many errors it's really tedious for anyone to go through them to find out what happened. But for sure both drives dropping writes at the same time is fatal for any setup.
> We have no evidence for simultaneous errors. On the contrary we did not find any.
> 

I didn't see all the logs. And I'm not volunteering to go through the logs. Those logs have *millions* of errors just for writes. I assume many are duplicates but I don't know that, it would take a lot of work.


> [thanks for the other recommendations. Understood]
> 
>>> - was my data corrupted before I transferred it to the new machine
>> I think the data isn't corrupt, I think the file system is inconsistent. 
> I still do not understand the difference. But I think it means: What can be read is ok.
> 
It's possible the file system has lost track of some files. I don't know that this is the case but I also don't understand the consequences of some of the error messages - in particular the ones from btrfs check. 


> So if I do a cp -R /old/ /new/ and do not get any errors, then I am fine.
> 
That should be true, yes. No user or kernel space errors. Both need to be checked.


> The problem is, that I do not know when the last clean mount was. I went through the logs until Oct 14th and filtered for btrfs (though I understand that most do not like filtering)
> 
> Interestingly the first btrfs error is on another device
> Okt 14 11:33:52 homeserver kernel: BTRFS error (device nvme0n1p3): tree first key mismatch detected, bytenr=570949632 parent_transid=9572251 key expected=(38580,96,2) has=(38
> 581,96,2)

It's a separate drive and file system. So that should be a separate thread or it's too confusing. Again here is one error message in isolation so I have no way of knowing if it self healed or not, and if not why not.



> then the first on sda/sdb: 
> so that was during a scrub. But no scrub that I did showed errors in the scrub output.
> Okt 14 11:34:24 homeserver kernel: BTRFS info (device sda1): scrub: started on devid 1
> Okt 14 11:34:24 homeserver kernel: BTRFS info (device sda1): scrub: started on devid 2
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 0, rd 1, flush 0, corrupt 0, gen 0
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 0, rd 2, flush 0, corrupt 0, gen 0
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 2, flush 0, corrupt 0, gen 0
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 3, flush 0, corrupt 0, gen 0
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 4, flush 0, corrupt 0, gen 0
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 5, flush 0, corrupt 0, gen 0
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 6, flush 0, corrupt 0, gen 0
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 7, flush 0, corrupt 0, gen 0
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 8, flush 0, corrupt 0, gen 0
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 1, rd 9, flush 0, corrupt 0, gen 0
> Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740143616 (dev /dev/sda1 sector 1238556704)
> Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740143616 (dev /dev/sda1 sector 1238556704)
> Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740147712 (dev /dev/sda1 sector 1238556712)
> Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740147712 (dev /dev/sda1 sector 1238556712)
> Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740151808 (dev /dev/sda1 sector 1238556720)
> Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740151808 (dev /dev/sda1 sector 1238556720)
> Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740155904 (dev /dev/sda1 sector 1238556728)
> Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 7995740155904 (dev /dev/sda1 sector 1238556728)
> Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 16465591336960 (dev /dev/sda1 sector 15306398848)
> Okt 14 11:37:05 homeserver kernel: BTRFS info (device sda1): read error corrected: ino 0 off 16465591341056 (dev /dev/sda1 sector 15306398856)


Is the above filtered for just Btrfs?

The file system is complaining about read errors and we need to know why there are read errors. This seems like not a Btrfs problem, but an underlying problem in the storage stack. That has to be figured out and fixed before anything else. Btrfs cannot work around all possible storage stack problems. It's a very limited assurance for e.g. raid1 which is two copies of data and metadata. If both copies are bad, the file system is probably screwed and that's the end. So if the use case is very important, you might need to use raid1c3 or raid1c4 to make sure you can tolerate more errors.

raid1 can't tolerate more than one device error for a btrfs logical block. If both copies are bad or one is bad and the other falis to read - it's the same problem, it's not available. And the file system falls over.




> Okt 14 11:37:05 homeserver kernel: BTRFS warning (device sda1): i/o error at logical 24386345566208 on dev /dev/sdb1, physical 19689242624, root 1382, inode 5846, offset 3276
> 800, length 4096, links 1 (path: Mavic/Jana/DJI_0003.MOV)
> Okt 14 11:37:05 homeserver kernel: BTRFS warning (device sda1): i/o error at logical 24386345172992 on dev /dev/sdb1, physical 19688849408, root 1382, inode 5846, offset 2883
> 584, length 4096, links 1 (path: Mavic/Jana/DJI_0003.MOV)
> Okt 14 11:37:05 homeserver kernel: BTRFS warning (device sda1): i/o error at logical 24386345041920 on dev /dev/sdb1, physical 19688718336, root 1382, inode 5846, offset 2752
> 512, length 4096, links 1 (path: Mavic/Jana/DJI_0003.MOV)
> Okt 14 11:37:05 homeserver kernel: BTRFS warning (device sda1): i/o error at logical 24386329051136 on dev /dev/sdb1, physical 19672727552, root 1382, inode 5844, offset 1820
> 721152, length 4096, links 1 (path: Mavic/Jana/DJI_0002.MOV)
> Okt 14 11:37:05 homeserver kernel: BTRFS warning (device sda1): i/o error at logical 24386345304064 on dev /dev/sdb1, physical 19688980480, root 1382, inode 5846, offset 3014
> 656, length 4096, links 1 (path: Mavic/Jana/DJI_0003.MOV)
> Okt 14 11:37:05 homeserver kernel: BTRFS warning (device sda1): i/o error at logical 24386328920064 on dev /dev/sdb1, physical 19672596480, root 1382, inode 5844, offset 1820
> 590080, length 4096, links 1 (path: Mavic/Jana/DJI_0002.MOV)
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): unable to fixup (regular) error at logical 24386345041920 on dev /dev/sdb1
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): unable to fixup (regular) error at logical 24386345172992 on dev /dev/sdb1
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): unable to fixup (regular) error at logical 24386345566208 on dev /dev/sdb1
> Okt 14 11:37:05 homeserver kernel: BTRFS error (device sda1): unable to fixup (regular) error at logical 24386345304064 on dev /dev/sdb1

Suggests sdb1 failed to retrieve the data but it's speculation because this has only btrfs messages. But then also sda1 must not have a good copy either because of the unable to fixup messages. The messages that might explain the reason why sda1 also has issues for the same btrfs logical blocks, weren't provided. So I have no idea what's going on.


> On the filtering: 
> That's a good information. I would have felt horrible to just dump a bunch of logs onto you.

It's worse to have excerpts. All bug reports need full complete dmesg or it's just impossible to get a clue what's going on. If it's too much then that person can filter it or just decide to not help. *shrug* but with excepts it's a big guess why I'm not seeing any of the other possible messages so I can't say in isolation  what's really going on.

Anyway, I would use a current kernel, do a scrub, see if it sees  the same or different problems, and if it's able to do anything about it. Again, especially metadata, if two mirror copies are bad or missing, then the file system stops. It's very difficult for Btrfs to even repair these cases, good chance the file system isn't repairable and you have to extract what you can. And that's why so many problems at once with multiple drives used in the btrfs array is a big problem.


--
Chris Murphy

