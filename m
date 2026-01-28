Return-Path: <linux-btrfs+bounces-21186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM3qM1VTemnk5AEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21186-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 19:20:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6F8A7B16
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 19:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A36430A9045
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382D371040;
	Wed, 28 Jan 2026 18:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="brSErAfP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BAC36F436
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623761; cv=none; b=TGd36d+MQiQyy2Jp8MweyHSJcTmnoVwZUAQOTrwuIdC06wIkdkzhEo6qZLN4DHpqpB3tVEnnsOXyCkI3MsQ3APSMlM0397abHfdGPuvrEEMeHpxWnQxwQPaTxgmwbLHnVZeQYtG0cbY2liPmhredwEywqOymSANKtcnmbyS/DtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623761; c=relaxed/simple;
	bh=GegAOqVWroyP090TauJ+/s3tWN/wA/KcIAIKK9tVXhk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=t/mSMmTMSPVKWkA0QTn9kDeQkDmKWxhv5fVwb1Y/SIIRkpv3LzvXoXZyHO9EnxNCHBB+4MXPFPIcRdcOlNkVpaWhZFdDVY1Ytu6QzwHO5auPIiL2WUbpAbCgmFD4GpktsNdzEEpnxFmMV3HHjhvoo8cOLxELdYDUusUW+eeDF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=brSErAfP; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:27a5:0:640:93ca:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 5C69FC0048
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 21:09:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 89n1Kp2G5W20-XAlr7fcD;
	Wed, 28 Jan 2026 21:09:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1769623749; bh=o0gyHaWl/XOONAdo/uH1YM3wgTqHpXWib4HXFCKBUBs=;
	h=Subject:From:To:Date:Message-ID;
	b=brSErAfP0admQwaVtd3YLQ+YTty54rJYpXZvRKk52orhBEepcHFokE2Cdcn/85x8H
	 j7E6qjzybIO5VwtOctxFa+0d14LH1btgVI1znbRpfEReJQYon7E0RPjxhDmnA4jbxV
	 s8pmFLQ6CxFQFrIYvO0k3S3iK40pAaybDWsse5rU=
Authentication-Results: mail-nwsmtp-smtp-production-main-72.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <1a81cfb5-d3da-4179-8cca-3a108a53895a@yandex.ru>
Date: Wed, 28 Jan 2026 21:09:08 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, ru
To: linux-btrfs@vger.kernel.org
From: Aleksey M Boltenkov <padrebolt@yandex.ru>
Subject: btrfs device replace vs btrfs device scrub
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[yandex.ru:+];
	TAGGED_FROM(0.00)[bounces-21186-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yandex.ru];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[padrebolt@yandex.ru,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B6F8A7B16
X-Rspamd-Action: no action

Hello.

I have an error or misunderstood on btrfs device replace and scrub.

uname -a
Linux bxM0 6.18.1-gentoo-dist #1 SMP PREEMPT_DYNAMIC Sun Dec 14 16:46:52 
-00 2025 x86_64 AMD Ryzen 9 5950X 16-Core Processor AuthenticAMD GNU/Linux

btrfs --version
btrfs-progs v6.17.1
+EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED 
CRYPTO=builtin

For now i have(don't look at mountpoint name):

btrfs replace status -1 /data/raid1
67.4% done, 0 write errs, 0 uncorr. read errs

btrfs scrub status /data/raid1
UUID:             ca4b7cda-2b9a-4bae-97d8-c491f25b8f67
Scrub started:    Fri Jan 23 13:07:52 2026
Status:           running
Duration:         3:21:19
Time left:        10:08:01
ETA:              Thu Jan 29 06:06:11 2026
Total to scrub:   1.99TiB
Bytes scrubbed:   506.29GiB  (24.87%)
Rate:             42.92MiB/s

It is a today second try, first replace attempt was unexpectedly 
cancelled by 'btrfs scrub cancel'.

Unfortunately, can't remember a cancellation cause of scrub on Jan 23. 
3:21:19 duration time does not change.


btrfs fi us -T /data/raid1/
Overall:
     Device size:                   6.02TiB
     Device allocated:              2.82TiB
     Device unallocated:            3.21TiB
     Device missing:                  0.00B
     Device slack:                    0.00B
     Used:                          2.63TiB
     Free (estimated):              2.54TiB      (min: 1.20TiB)
     Free (statfs, df):             1.10TiB
     Data ratio:                       1.33
     Metadata ratio:                   3.00
     Global reserve:              512.00MiB      (used: 0.00B)
     Multiple profiles:                  no

                                                             Data 
Metadata System
Id Path                                                     RAID5 
RAID1C3  RAID1C3   Unallocated Total   Slack
-- -------------------------------------------------------- --------- 
-------- --------- ----------- ------- -----
  0 /dev/mapper/vg01_ssd02_02TB_KingFast_04282223D0057-raid1         - 
      -         -     1.00TiB 1.00TiB     -
  1 /dev/dm-18                                               704.00GiB 
15.00GiB  32.00MiB   304.97GiB 1.00TiB     -
  2 /dev/dm-15                                               704.00GiB 
16.00GiB  32.00MiB   342.98GiB 1.04TiB     -
  3 /dev/dm-24                                               704.00GiB 
23.00GiB  64.00MiB     1.24TiB 1.95TiB     -
  5 /dev/dm-21                                               704.00GiB 
15.00GiB  64.00MiB   343.95GiB 1.04TiB     -
-- -------------------------------------------------------- --------- 
-------- --------- ----------- ------- -----
    Total                                                      2.06TiB 
23.00GiB  64.00MiB     3.21TiB 6.02TiB 0.00B
    Used                                                       1.93TiB 
19.57GiB 192.00KiB


The second question is path names.

`btrfs fi us` gives /dev/dm*, but `btrfs dev stats` gives lvm(?) names?


--

BR,

Alexey M Boltenkov

