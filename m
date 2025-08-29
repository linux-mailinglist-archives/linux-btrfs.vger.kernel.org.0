Return-Path: <linux-btrfs+bounces-16527-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CFBB3C40D
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 23:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E608C7B9515
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 21:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707FD27B33A;
	Fri, 29 Aug 2025 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b="fvkGAN+w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.bitfolk.com (use.bitfolk.com [85.119.80.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB71EEA49
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.119.80.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756501509; cv=none; b=Q40nIEbhWhSBr50rGZOZb8s4TW1ejh2lTGpl+M0yW/QwqB8UhB/cvp5XyD1EAB5ILTS5saLRrqsHTSDZ8n44140EJGbYTUc3LUN6OvfbCryQVBOdmex8iIPtbEhfsnWFYOnhyiWHjOcL5n/Te1xrSfQftxhB+awvm568LVSIhio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756501509; c=relaxed/simple;
	bh=cFtMcw1GY88rH4OIwJfB+3ScknoUTI6o+Q4SzcAKlxk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EMMyVb1f2V40TuiUwfex4B3PfRjul7lOPTN1VbHZrCtudirjVxcaXCcb9/++CSQ6TgEP+KpXzScl33cGbURp5/V9YeuMvB1iF2H6ok6zV3QSsPiRocU/v8iL1qjp+Gr6UxQMz47mLnla5h3+vwy2RjXDNk+f2G0EUSIyC6N/rEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net; spf=pass smtp.mailfrom=strugglers.net; dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b=fvkGAN+w; arc=none smtp.client-ip=85.119.80.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strugglers.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=strugglers.net; s=alpha; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Subject:To:From:Date:In-Reply-To:References:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-To;
	bh=83HK0cZpx8jlKIOO8X2buY0HY88H/QmthA7pnmjADZY=; b=fvkGAN+w8DkKnXu2b8wqmntotc
	F08ryoqWmRjt6zg76QuHrxAgySZBjSJykuEEWyNa5hpDZkOoRPPhWFcV1pXvko6CFS3KcGkXymHzh
	LA4DM5oD11chLBWTVI3JkEvaJpmnyQ3jtAyWYacW4qxKt4EkK2cgyIRE6LHOL+AqtmDapUvJ1bMik
	aJcOLoA2Kp8JeoTmEdG0y3v1c6sxpL1Kezdj7SZy4OpaVqqg7EYfC6rHFgWSoRPr0y4EsQ8lMs8O/
	tnhiFWSczgKd2IaCAiVJ5pWOyJIkJXrydmrlsHbBmM6/aefuow1B4LJaeGJqlApv6GwLQTNN/hm9g
	1i41e4fQ==;
Received: from andy by mail.bitfolk.com with local (Exim 4.94.2)
	(envelope-from <andy@strugglers.net>)
	id 1us5yo-0006AY-21
	for linux-btrfs@vger.kernel.org; Fri, 29 Aug 2025 20:45:50 +0000
Date: Fri, 29 Aug 2025 20:45:50 +0000
From: Andy Smith <andy@strugglers.net>
To: linux-btrfs@vger.kernel.org
Subject: Mysterious disappearing corruption and how to diagnose
Message-ID: <aLIRfvDUohR/2mnv@mail.bitfolk.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL: http://strugglers.net/wiki/User:Andy
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false

Hi,

I have a btrfs filesystem with 7 devices. Needing a little more
capacity, I decided to replace two of the smaller devices with larger
ones. I ordered two identical 4TB SSDs and used a "btrfs replace …" for
the first and then a "btrfs device remove …" plus "btrfs device add …"
for the second to get them both in there.

After the second of the new SSDs was added in I started receiving logs
about corruption on the newest added device (sdh):

2025-08-25T04:52:36.719565+00:00 strangebrew kernel: [15861945.864876] BTRFS error (device sdh): bad tree block start, mirror 1 want 18526171987968 have 0
2025-08-25T04:52:36.719578+00:00 strangebrew kernel: [15861945.867728] BTRFS info (device sdh): read error corrected: ino 0 off 18526171987968 (dev /dev/sdh sector 238168896)
2025-08-25T05:44:42.139479+00:00 strangebrew kernel: [15865071.325433] BTRFS error (device sdh): bad tree block start, mirror 1 want 18526179364864 have 0
2025-08-25T05:44:42.139493+00:00 strangebrew kernel: [15865071.328345] BTRFS info (device sdh): read error corrected: ino 0 off 18526179364864 (dev /dev/sdh sector 238183304)

These messages were seen 19,207 times with sector numbers ranging from
2093128 to 556538024.

Upon seeing this I did a "btrfs device remove …" for sdh, shuffled
things about so I could attach an extra device, added back one of the
older SSDs and used "btrfs device add" to add that one back in. So at
this point the filesystem still has 7 devices, sdh is still in the
machine but not part of the filesystem and the filesystem just has
slightly less capacity than it could have.

I did a scrub of the filesystem. This came back clean, as expected (all
of the error logs said errors were corrected).

A "long" SMART self-test of sdh came back clean, which wasn't surprising
because at no point has there been an actual I/O error, only notices of
corruption.

I put an ext4 filesystem on sdh, mounted it and did a run of stress-ng:

$ sudo stress-ng --hdd 32 \
  --hdd-opts wr-seq,rd-rnd \
  --hdd-write-size 8k \
  --hdd-bytes 30g \
  --temp-path /mnt/stress --verify -t 6h

After more than an hour this hadn't detected a single problem so I
aborted it.

I put a btrfs filesystem on sdh and did stress-ng again. No issues
reported.

As mentioned, this was a pair of new SSDs and the other one is already
part of the filesystem and not giving me any cause for concern. They are
Crucial model CT4000BX500SSD1 (4TB SATA SSD).

It may be difficult to get a replacement or refund if I can't
reproduce broken behaviour.

The shuffling of devices that I had to do can only be temporary, so I
need to decide what I am going to do. The smaller device I had intended
to remove (but now had to add back in for capacity reasons) is 1.7T and
is currently /dev/sdg. I could "btrfs replace /dev/sdg /dev/sdh …" and
assuming no errors seen do a scrub, but if errors were seen I'd want to
remove sdh again quickly. replace then wouldn't be an option since sdg
is smaller than sdh. "btrfs remove sdh …" takes a really long time.

Maybe I should make a partition on sdh that is only 1.7T of the device
and replace that in, so I could still replace it out if errors are seen?
Though if it behaves I am then going to want to replace it out anyway in
order to replace the full device back in!

Basically I'm totally confused as to how this device was misbehaving
but now apparently isn't. I had thought just maybe it could be the slot
on the backplane that had gone bad but it's still in that slot and I
can't reproduce the problem now.

Any ideas?

Debian 12, kernel 6.1.0-38-amd64, btrfs-progs v6.2 (all from Debian
packages).

Thanks,
Andy

