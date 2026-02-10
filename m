Return-Path: <linux-btrfs+bounces-21611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ8/B7xTi2kMUAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21611-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 16:50:20 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9076B11CB97
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 16:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99FB93006122
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E754935E526;
	Tue, 10 Feb 2026 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phys.ethz.ch header.i=@phys.ethz.ch header.b="BeoMLPcb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from phd-imap.ethz.ch (phd-imap.ethz.ch [129.132.80.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E46F2F2
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.132.80.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738616; cv=none; b=jUGZv5x650e8Ccnxu84sW5/alnClvHpgAKucjGTmETz6h4rexji+2i/9yNqxDcSg9Qn18Cn3v9Kqh4nQJoUJrLN3BNJ2BF4WkRG0spwW4MfKCzC9sD92U0X7VQTuWj/xjVbicsbpqVAj1jewoVdaQtZh3uY/fc587ADPtAHL7gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738616; c=relaxed/simple;
	bh=ha7emgPsx/bX+znVl2vlLiTmaxkADys7s1T1C/9uEgs=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=OK+WrVn/aLLDEEtRxOq/pvSMOvZjX5N7hnIfpy3P6LrXVWF5eGm7KC4KEYhxg6QlyMiDxBO0N9O7wFR7C3X4kpx4einysLrBbvLD+1S19O2U0YvpvNIKN5vQTqX5mO70wBys7P69Y+0JOUJIIIqlkNh6TSPUbJRguHxCRMH4WgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phys.ethz.ch; spf=pass smtp.mailfrom=phys.ethz.ch; dkim=pass (2048-bit key) header.d=phys.ethz.ch header.i=@phys.ethz.ch header.b=BeoMLPcb; arc=none smtp.client-ip=129.132.80.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phys.ethz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phys.ethz.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phys.ethz.ch;
	s=2023; t=1770738216;
	bh=i55TgnIFXOE7Q1pam6SFnp3C8eyQhuPyQ/OD2UJNWcY=;
	h=Date:From:To:Subject:From;
	b=BeoMLPcbV3AT1fZRA44Njb2/H0mRUcEYl563DJarD/JOrn6dqK8HNrL43z9jb4UV2
	 LvhgqvDuJPB0cMI30czTjl7vErryJEVHg1BuuCsW9VauBe87qCyRYdxwKlYe6sYobC
	 tlqa/iZb4IgTfaowhu35pvL5u+7bCgrNRLFDpVjZ+lEvEpGxdLFpMwSwdqubjqf3oY
	 VPHgzz0qEriW3k8zqa7udo1GLNCm7HwsmUfn56ZqifSsPC2S1ExaRmYTHIBMb9WQp6
	 Zf+79hFbOIueEt5NpxGQk8EX37s/GMcU/U86+2DKqgbkTXOG9/CSL9aPTs8gmKrYzM
	 9gwylAxn6Tm8w==
Received: from localhost (192-168-127-49.net4.ethz.ch [192.168.127.49])
	by phd-imap.ethz.ch (Postfix) with ESMTP id 4f9Qp03s6FzBm
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 16:43:36 +0100 (CET)
X-Virus-Scanned: Debian amavis at phys.ethz.ch
Received: from phd-mxin.ethz.ch ([192.168.127.53])
 by localhost (phd-mailscan.ethz.ch [192.168.127.49]) (amavis, port 10024)
 with LMTP id kODdONF5WN-S for <linux-btrfs@vger.kernel.org>;
 Tue, 10 Feb 2026 16:43:36 +0100 (CET)
Received: from webmail.phys.ethz.ch (192-168-127-51.net4.ethz.ch [192.168.127.51])
	by phd-mxin.ethz.ch (Postfix) with ESMTP id 4f9Qp02xwVz9f
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 16:43:36 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Feb 2026 16:43:36 +0100
From: Stephan Mueller <stepmueller@phys.ethz.ch>
To: linux-btrfs@vger.kernel.org
Subject: Lots of tiny writes without merging
Message-ID: <8825adec963bc5dbf8c8c745289dab15@phys.ethz.ch>
X-Sender: stepmueller@phys.ethz.ch
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[phys.ethz.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[phys.ethz.ch:s=2023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21611-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[phys.ethz.ch:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stepmueller@phys.ethz.ch,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9076B11CB97
X-Rspamd-Action: no action

Hello

I have an rsync writing a (new) large file to a btrfs, the rates are 
pretty slow around 5MB/s. I know my 12 devices are not the fastest, 
iscsi imported raid6 luns. But I am worried about something else.

Starring at a btrace on the devices, I see a lot of tiny writes: 88 * 
512B = 44KB each.
In my understanding, rsync fills the page cache quite fast and pid 
4126276 (kworker/u82:7+btrfs-delalloc) writes out the dirty pages. I see 
writes to sectors 14023466344, 14023466432, 14023466520, ... all are 88 
sectors apart. The mq-deadline scheduler should be able to merge all 
these requests, right? However the requests are separated by plug and 
unplugs. I guess this makes them unmergable. Am I totally misreading the 
btrace or does this sound reasonable. How can I investigate this 
further?

I think the think the 44K are compressed 128K blocks, does this make 
sense? The file compresses (zstd:3) actually quite well, compsize 
reports 40%.

The System is a Debian with a 6.18.4 kernel and the mount options are 
rw,noatime,compress=zstd:3,space_cache=v2,skip_balance,subvolid=5,subvol=/

Bonus: the very first line, the complete event on a different cpu, is 
probably just an btrace oddity. According to the time stamp it should be 
together with the other completions. This pattern, 4 plug separated 
writes + completions, repeats all the time. Sometimes the writes go up 
to 120 instead of 88, though. Does any of this ring a bell for you?

Bonus 2: Sometimes I do see some merges of 32 sector writes to a larger 
request. I guess this is metadata, because it goes to devices holding 
the metadata raid. So the scheduler and nomerges=0 are effective.

Any pointers and help is welcome.

   Have a nice day
   Stephan

btrace /dev/sdfk /dev/sdfc /dev/sdey /dev/sddj /dev/sddc /dev/sdcx 
/dev/sdct /dev/sdcr /dev/sdci /dev/sdcg /dev/sdez /dev/sdeo
[...]
129,176  6        2     2.536153684 4172873  C   W 14023466344 + 88 [0]
129,176  0        1     2.535593727 4126276  Q   W 14023466344 + 88 
[kworker/u82:7] # queue an 44K write at sector 14023466344
129,176  0        2     2.535599088 4126276  G   W 14023466344 + 88 
[kworker/u82:7]
129,176  0        3     2.535600754 4126276  P   N [kworker/u82:7]
129,176  0        4     2.535601170 4126276  U   N [kworker/u82:7] 1
129,176  0        5     2.535602068 4126276  I   W 14023466344 + 88 
[kworker/u82:7]
129,176  0        6     2.535608586 4126276  D   W 14023466344 + 88 
[kworker/u82:7]
129,176  0        7     2.535645786 4126276  Q   W 14023466432 + 88 
[kworker/u82:7] # queue an 44K write at sector 14023466344 = 14023466344 
+ 44K
129,176  0        8     2.535646590 4126276  G   W 14023466432 + 88 
[kworker/u82:7]
129,176  0        9     2.535646766 4126276  P   N [kworker/u82:7]
129,176  0       10     2.535646882 4126276  U   N [kworker/u82:7] 1
129,176  0       11     2.535647112 4126276  I   W 14023466432 + 88 
[kworker/u82:7]
129,176  0       12     2.535648715 4126276  D   W 14023466432 + 88 
[kworker/u82:7]
129,176  0       13     2.535678884 4126276  Q   W 14023466520 + 88 
[kworker/u82:7] # queue an 44K write at sector 14023466520 = 14023466344 
+ 44K
129,176  0       14     2.535679583 4126276  G   W 14023466520 + 88 
[kworker/u82:7]
129,176  0       15     2.535679718 4126276  P   N [kworker/u82:7]
129,176  0       16     2.535679922 4126276  U   N [kworker/u82:7] 1
129,176  0       17     2.535680163 4126276  I   W 14023466520 + 88 
[kworker/u82:7]
129,176  0       18     2.535681631 4126276  D   W 14023466520 + 88 
[kworker/u82:7]
129,176  0       19     2.535713385 4126276  Q   W 14023466608 + 88 
[kworker/u82:7] # queue an 44K write at sector 14023466608 = 14023466520 
+ 44K
129,176  0       20     2.535714105 4126276  G   W 14023466608 + 88 
[kworker/u82:7]
129,176  0       21     2.535714420 4126276  P   N [kworker/u82:7]
129,176  0       22     2.535714653 4126276  U   N [kworker/u82:7] 1
129,176  0       23     2.535714781 4126276  I   W 14023466608 + 88 
[kworker/u82:7]
129,176  0       24     2.535716200 4126276  D   W 14023466608 + 88 
[kworker/u82:7]
129,176  0       25     2.536346556 4126276  C   W 14023466432 + 88 [0]  
            # write complete
129,176  0       26     2.536598810 4126276  C   W 14023466520 + 88 [0]  
            # write complete
129,176  0       27     2.536740142 4126276  C   W 14023466608 + 88 [0]  
            # write complete
129,176  0       28     2.579774641 4126276  Q   W 14023466696 + 80 
[kworker/u82:7]
129,176  0       29     2.579778279 4126276  G   W 14023466696 + 80 
[kworker/u82:7]
129,176  0       30     2.579780071 4126276  P   N [kworker/u82:7]
129,176  0       31     2.579780441 4126276  U   N [kworker/u82:7]  1
129,176  0       32     2.579781159 4126276  I   W 14023466696 + 80 
[kworker/u82:7]
129,176  0       33     2.579786115 4126276  D   W 14023466696 + 80 
[kworker/u82:7]
129,176  0       34     2.579825607 4126276  Q   W 14023466776 + 88 
[kworker/u82:7]
129,176  0       35     2.579826206 4126276  G   W 14023466776 + 88 
[kworker/u82:7]
129,176  0       36     2.579826401 4126276  P   N [kworker/u82:7]
129,176  0       37     2.579826471 4126276  U   N [kworker/u82:7] 1
129,176  0       38     2.579826578 4126276  I   W 14023466776 + 88 
[kworker/u82:7]
129,176  0       39     2.579827737 4126276  D   W 14023466776 + 88 
[kworker/u82:7]
129,176  0       40     2.579854059 4126276  Q   W 14023466864 + 88 
[kworker/u82:7]
129,176  0       41     2.579854691 4126276  G   W 14023466864 + 88 
[kworker/u82:7]
129,176  0       42     2.579854814 4126276  P   N [kworker/u82:7]
129,176  0       43     2.579855039 4126276  U   N [kworker/u82:7] 1
129,176  0       44     2.579855301 4126276  I   W 14023466864 + 88 
[kworker/u82:7]
129,176  0       45     2.579856473 4126276  D   W 14023466864 + 88 
[kworker/u82:7]
129,176  0       46     2.579882377 4126276  Q   W 14023466952 + 88 
[kworker/u82:7]
129,176  0       47     2.579883069 4126276  G   W 14023466952 + 88 
[kworker/u82:7]
129,176  0       48     2.579883373 4126276  P   N [kworker/u82:7]

