Return-Path: <linux-btrfs+bounces-6981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F73947662
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 09:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273061C20E8D
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 07:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29906149E0B;
	Mon,  5 Aug 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b="DMEDQ/hy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zero.acitia.com (zero.acitia.com [69.164.212.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E31442E3
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.212.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722844467; cv=none; b=bM5WmjIikpDutOE2WGW+Jr6jIcDMAmcAo09rSKyVbPNYlhluaoOoBT3Zn2891HohiGUb1DaHYHLYuiKBLqyV97QI8liEI8E5k7qp6sbVPAAGYsOOaOHhJKUtiCC3KwefA8suk1QxTW3F5tQptN/tC414pRGBS+EtCVoFD865PoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722844467; c=relaxed/simple;
	bh=LRJ0AVB8y3MFt8qbyhxg39ujxGDJ+vGkw9uiieQ4w8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=neVNlT+vUrD07a5q0QDI1FS8B5RFgatPJKsAdSXMFuFdm+M451AO5Z7kNAzqFokLaamYKC06jXdWN+8YsLFrWU4Tt7WC1K80EadYfwaTg1b4N9vMlQ/BsX3lZbLrwst1V4atrQYziSIIWtbSfg8DJj7KqijmrcyKEpXa4fcqkfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com; spf=pass smtp.mailfrom=zetafleet.com; dkim=pass (2048-bit key) header.d=zetafleet.com header.i=@zetafleet.com header.b=DMEDQ/hy; arc=none smtp.client-ip=69.164.212.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zetafleet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetafleet.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=zetafleet.com; s=20190620; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XvkLzTxahKP3mpMXDc8cSdInWoFjCU/yIam+qW+Lolk=; b=DMEDQ/hynlZBKAhOy15Xj5qDbe
	ONVhchAa68AbnbTXd3kjESqOB3uSwtDk7yNtE2zErWH/MbZAE5MXvofzxHWt+wRGTfAj8pPqUkbZ+
	iyr1Koy0e1JRcIKtFALqvKBwDIA4EBGv4QtABABLb1lySJjpOsTytKhbaocdJvnTOt9mlPFwl8hTt
	IB4Zf99oxNAyf98zWoywFUUn29veiPaoff7O4UYy+8oaLwBkahuOp6CkDCpDe+pvCvl696W582m3b
	BkQnPcN8bABRUtjVCOh9xMqjVnv5bILVdtag1uCA6aUDc7wH+Y775BOqLiB81uWPiIQUsSQ+NPrpB
	WOn0PlcA==;
Received: from authenticated by zero.acitia.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(envelope-from <linux-btrfs-ml@zetafleet.com>)
	id 1sasXp-0001Pw-G3
	for linux-btrfs@vger.kernel.org; Mon, 05 Aug 2024 07:54:17 +0000
Message-ID: <02afb6b7-e566-474e-80ff-3ace99693553@zetafleet.com>
Date: Mon, 5 Aug 2024 02:54:17 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Handling recovery from 2-device btrfs raid1 with bad generation
 on one device due to partial hardware failure
To: linux-btrfs@vger.kernel.org
References: <113200b0-7584-4ada-ba40-0637478ac390@zetafleet.com>
 <ba51784b-ba20-4bf4-865a-2670a9ddde74@zetafleet.com>
Content-Language: en-GB
From: Colin S <linux-btrfs-ml@zetafleet.com>
In-Reply-To: <ba51784b-ba20-4bf4-865a-2670a9ddde74@zetafleet.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.9
X-Spam-Report: No, score=-1.9 required=5.0 tests=BAYES_00=-1.9,NO_RELAYS=-0.001 autolearn=ham autolearn_force=no version=3.4.2

Hi list,

I have another (hopefully final, or at least penultimate) follow-up on 
this issue. The headline here is that btrfs does not appear to have lost 
any data or actually damaged the filesystem. As such, I want to first 
give a big thanks and kudos to everyone who has worked on btrfs over the 
years to ensure this outcome. Filesystems are hard, and this one is 
certainly doing better than most.

For the rest of this email, please understand that if it feels as though 
I am speaking too strongly or with excessive authority, it is only 
because these issues are very important to me, and so I am using direct 
language in order to be as clear as possible. I am deeply appreciative 
of all the work that has gone into making btrfs, and nothing I say is 
ever intended as an insult toward anyone, or any of the work on btrfs, 
or as a demand. I do not believe that I know better than anyone else and 
so some of this feedback may simply be wrong, and I am happy to be 
corrected.

1. btrfs-send tries using bad metadata only from the failed device. This 
is very bad since it means that right now emergency snapshot transfer 
off a failing filesystem using btrfs-send is not possible, and 
reinforces to the user that the filesystem is irreparably damaged, when 
it is not.

2. btrfs-check and btrfs-inspect-internal also try using metadata only 
from the failed device. This is very bad because these utilities 
*require* the user to pass a specific block device path instead of 
filesystem path, and therefore cause a totally misleading situation 
where it appears fatal filesystem corruption exists on *all* devices 
when it is not because btrfs is ignoring the user’s explicit input and 
not even giving a notice about it.

3. Due to the previous mentioned issues with the other btrfs programs, 
*only* the per-device statistics from btrfs-scrub, plus the fact that 
the system continued to operate normally with error correction messages 
in the syslog, provide any evidence to users that the filesystem is 
actually in a recoverable state. This is contradicted by all of the 
other tools. btrfs-scrub also reinforces that there is a fatal 
filesystem corruption because it does not show per-device scrub results 
by default, only the overall filesystem scrub result. Unless no errors 
are found on any device, btrfs-scrub output should always show 
per-device results by default.

4. btrfs-scrub claimed that there were “uncorrectable” errors on the 
failing device, but btrfs-scrub in read-write mode corrected all errors 
and now reports “no errors found” and btrfs-check is clean. btrfs-scrub 
should not lie like this about whether there are uncorrectable errors. 
Either this value is miscalculated, or it has a bad name and needs a 
better one, or it is only valid for non-redundant filesystems but is 
being applied to redundant ones too.

5. The troubleshooting documentation about “parent transid verify error” 
urgently needs updating to clarify that this is only a permanent error 
for filesystems *without redundancy*, and that btrfs-scrub *will* 
correct transid verify errors for filesystems that still have sufficient 
redundancy. There may need to be added caveats around split-brain 
situations, but right now it sounds like all hope is lost whenever you 
see “transid verify” errors and that the only chance from there is to 
try using btrfs-recover, and this is simply not true. In my case, 
btrfs-scrub fixed everything.

6. btrfs-scrub gives wrong “Total to scrub:” value when scrubbing a 
single device in a multi-device filesystem. This appears to be reporting 
the total combined size of all devices in the filesystem. This causes 
scrub of a single device in a 2-device filesystem to finish at “50%” and 
suggests some kind of corruption or issue with the filesystem, either 
because it looks like the scrub aborts midway, or because there’s way 
more data on-disk than expected.

7. The documentation for btrfs-scrub has a large note at the top that 
obscures and contradicts the first paragraph and makes it sound like it 
will not fix most metadata errors. This note needs to be less fatalistic 
and much clearer about what specific kinds of “structural damage” is not 
detected or fixed by scrub and in what conditions. There needs to be 
much clearer language about what risks exist, if any, by running 
read-write scrub in the presence of a degraded filesystem. For me, this 
single misleading note block is responsible for almost all the trouble I 
encountered, as it implied that running btrfs-scrub in read-write mode 
was the wrong thing to do, when actually, running btrfs-scrub was the 
*right* thing to do and healed the filesystem. It seems like I am not 
the first person to notice this as there is a Reddit thread about this, 
but they provided evidence by linking to a page on the old btrfs wiki 
which has been blanked out with no viewable history.

8. One of the potential nightmare scenarios that was raised in IRC when 
I was asking for help on this was the possibility of getting into a 
split-brain situation by mounting the failing device in the absence of 
the good device. I do not know if it is possible for kernel drivers to 
add arbitrary variables to EFI NVRAM, but if so, one possible extra 
defence mechanism I thought about to avoid such a split-brain nightmare 
would be to write the last known maximum generation id for a given 
filesystem UUID there, and then check and refuse to mount read-write 
without user intervention if it does not match enough of the devices in 
the filesystem that is being assembled at mount time.

9. The documentation does not seem to provide clear points of contact 
for reporting issues or seeking assistance. There are references to this 
mailing list, but mostly it just says “mailing list” rather than 
pointing to the specific place to subscribe to the list. There are also 
references to IRC, but not the actual address of the IRC channel. There 
is also the btrfs-progs GitHub issues tracker, which I literally only 
just now realise exists, and where the current latest ticket starts with 
“Not sure if this is the right bug tracker”. Some projects can be 
incredibly nasty when users solicit help in the wrong place, so each 
contact point and its intent should be made very clear in the 
documentation if only to make people feel less afraid of reaching out 
for assistance.

I will be replacing my failing device with a new device shortly and 
anticipate that there may be additional concerns with this process which 
I will document as well. In particular I am concerned about the lack of 
step-by-step documentation on how to handle various different scenarios 
for offlining or replacing failing devices. The typical use case 
documentation for taking raid1 to single seems to suggest taking steps 
that would potentially cause data to be placed on the failing device and 
when the filesystem is the root filesystem there is no clear direction 
on what steps to take to be able to replace a failing device without 
having to boot to a separate recovery image.

Please let me know if you have any feedback on these issues, otherwise I 
may begin to submit some documentation changes for review, or open/add 
to issues in the btrfs-progs GitHub if that seems most appropriate.

Apologies again for the length of all of these messages and I hope they 
provide some value for future.

Best regards,

