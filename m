Return-Path: <linux-btrfs+bounces-15285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3C4AFB1EC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 13:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C91189F5DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 11:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70323286420;
	Mon,  7 Jul 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="Mjt91ubL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575101F8BCB
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886288; cv=none; b=bnkGeJwVdwtpCipPj9Ws4SNo37XAX5b8oULrRCvslziN5wGUqSO+VAV+EaWsU8XaAw3zElb2BCTUY1qMN9OYNWZ91bpOq2QV/eOzOFoVQUf+vYhqI23Kxs3kLA4vHaCzZhG9eCtY8A6BhXZFBjVALQViqSt5cZbmjth0gOnyy5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886288; c=relaxed/simple;
	bh=GbH+mFqC4s0LGNDg8mIkUZXRVXk+HaehzlkZOB/8/tU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rI12Dfhw9R3RNkhRiRWJyGGlpPw9MoRwA8ES17Wdjr9tvKclDmZm8lMTBG+On00C6Migweh6KkeObOPvGRYtyTl/2kzgTAyTMvP+LTxDu6A/Um6y53CgQyhckWgItG7Om1QWqlPzhOI19OV+LhShmA0EEmcosDI77w2kK9Dmm5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=Mjt91ubL; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1751885712;
	bh=bAVIFJ0nHTxybQvyBi6AEPBFLtOV7Epn00FWnS+5/MM=; l=7564;
	h=From:To:Subject:Date:From;
	b=Mjt91ubLcloQ8dOLRw+/9UQo2ItP9vfC3qqsin3tGkm6q4dTCK/pSKLKnX+oPl45L
	 VD3jEgpwNjcCyZ4TQaSP18kOQx165Ca1RtofVSwFJH4lOZrpFylke25S9fWMEZNHEH
	 cWjjUmMAR8B5rvg7wG6oPwHMUJVc8sj/XWa/HdXc=
Received: from liv.coker.com.au (n175-33-172-140.sun22.vic.optusnet.com.au [175.33.172.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: russell@coker.com.au)
	by smtp.sws.net.au (Postfix) with ESMTPSA id 8F0F018252
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 20:55:11 +1000 (AEST)
From: Russell Coker <russell@coker.com.au>
To: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Scrub problem with Debian kernel 6.12.33+deb13-amd64
Date: Mon, 07 Jul 2025 20:55:07 +1000
Message-ID: <3036994.e9J7NaK4W3@dojacat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

I ran a scrub on my laptop running the latest Debian/Testing setup.  It's a 
Thinkpad X1 Carbon Gen6 that has just been updated to the latest firmware 
(Thinkpad BIOS, management engine, and some 3rd thing on the motherboard).  It 
had crashed a few times before which I think has been fixed by the firmware 
update, it is plausible that the crashes caused some corruption.

The system is running LUKS encryption.  After the monthly btrfs scrub I got 
the following in the cron output:

ERROR: there are 1 uncorrectable errors
Starting scrub on devid 1
scrub done for d90583c8-9284-48b4-9444-abd00924002a
Scrub started:    Mon Jul  7 02:30:01 2025
Status:           finished
Duration:         0:02:46
Total to scrub:   226.35GiB
Rate:             1.36GiB/s
Error summary:    csum=110693
  Corrected:      0
  Uncorrectable:  110693
  Unverified:     0

I ran the following commands to get more data and got the below output.  It 
seems that we have a clear problem of btrfs dev sta reporting 0 errors when 
there were apparently many errors!

root@dojacat:/var/log# btrfs dev sta /
[/dev/mapper/root].write_io_errs    0
[/dev/mapper/root].read_io_errs     0
[/dev/mapper/root].flush_io_errs    0
[/dev/mapper/root].corruption_errs  0
[/dev/mapper/root].generation_errs  0
root@dojacat:/var/log# btrfs scrub status /
UUID:             d90583c8-9284-48b4-9444-abd00924002a
Scrub started:    Mon Jul  7 02:30:01 2025
Status:           finished
Duration:         0:02:46
Total to scrub:   226.34GiB
Rate:             1.36GiB/s
Error summary:    csum=110693
  Corrected:      0
  Uncorrectable:  110693
  Unverified:     0


[190966.907320] BTRFS info (device dm-0): scrub: started on devid 1
[191057.409078] scrub_stripe_report_errors: 110553 callbacks suppressed
[191057.409081] scrub_stripe_report_errors: 110576 callbacks suppressed
[191057.409084] BTRFS error (device dm-0): unable to fixup (regular) error at 
logical 327469629440 on dev /dev/mapper/root physical 147760480256
[191057.409138] BTRFS error (device dm-0): unable to fixup (regular) error at 
logical 327469563904 on dev /dev/mapper/root physical 147760414720
[191057.409300] _btrfs_printk: 290 callbacks suppressed
[191057.409303] BTRFS warning (device dm-0): checksum error at logical 
327469629440 on dev /dev/mapper/root, physical 147760480256, root 540, inode 
1826602, offset 2087845888, length 4096, links 1 (path: home.old/tv/Foo.
2024.S01E08.1080p.WEB.H264-SuccessfulCrab.mkv)

[many more about similar files]

[191057.410987] BTRFS warning (device dm-0): checksum error at logical 
327469629440 on dev /dev/mapper/root, physical 147760480256, root 522, inode 
174508, offset 2087845888, length 4096, links 1 (path: tv/Foo.
2024.S01E08.1080p.WEB.H264-SuccessfulCrab.mkv)
[191057.411281] BTRFS error (device dm-0): unable to fixup (regular) error at 
logical 327469629440 on dev /dev/mapper/root physical 147760480256
[191057.411285] BTRFS error (device dm-0): unable to fixup (regular) error at 
logical 327469563904 on dev /dev/mapper/root physical 147760414720
[191057.411458] BTRFS error (device dm-0): unable to fixup (regular) error at 
logical 327469432832 on dev /dev/mapper/root physical 147760283648
[191057.411461] BTRFS error (device dm-0): unable to fixup (regular) error at 
logical 327469367296 on dev /dev/mapper/root physical 147760218112
[191057.411907] BTRFS error (device dm-0): unable to fixup (regular) error at 
logical 327469498368 on dev /dev/mapper/root physical 147760349184
[191057.413012] BTRFS error (device dm-0): unable to fixup (regular) error at 
logical 327469629440 on dev /dev/mapper/root physical 147760480256
[191131.353819] BTRFS info (device dm-0): scrub: finished on devid 1 with 
status: 0

# md5sum Foo.2024.S01E08.1080p.WEB.H264-SuccessfulCrab.mkv
md5sum: Foo.2024.S01E08.1080p.WEB.H264-SuccessfulCrab.mkv: Input/output error

The files in question had been subject to "cp -a --reflink=auto", across 
subvols.  When I deleted them from one subvol and deleted the snapshots of 
that subvol I ran another scrub and now I see the following:

# /bin/btrfs scrub start -B /
Starting scrub on devid 1
scrub done for d90583c8-9284-48b4-9444-abd00924002a
Scrub started:    Mon Jul  7 20:33:18 2025
Status:           finished
Duration:         0:03:01
Total to scrub:   220.04GiB
Rate:             1.21GiB/s
Error summary:    csum=110693
  Corrected:      0
  Uncorrectable:  110693
  Unverified:     0
ERROR: there are 1 uncorrectable errors
# btrfs dev sta /
[/dev/mapper/root].write_io_errs    0
[/dev/mapper/root].read_io_errs     0
[/dev/mapper/root].flush_io_errs    0
[/dev/mapper/root].corruption_errs  689
[/dev/mapper/root].generation_errs  0

So it looks like the failure to report error counts in btrfs dev sta may be 
related to cp --reflink=auto across subvols.  The csum=110693 doesn't match to 
the "corruption_errs  689" but at least it's not 0.

I removed another file that was listed as having uncorrectable errors and now 
I get the following:

# /bin/btrfs scrub start -B /
Starting scrub on devid 1
scrub done for d90583c8-9284-48b4-9444-abd00924002a
Scrub started:    Mon Jul  7 20:46:05 2025
Status:           finished
Duration:         0:02:17
Total to scrub:   173.88GiB
Rate:             1.27GiB/s
Error summary:    csum=7137
  Corrected:      0
  Uncorrectable:  7137
  Unverified:     0
ERROR: there are 1 uncorrectable errors

Below are the kernel messages.  No mentions of files or directories so the 
scrub doesn't seem to be doing it's job well here.  It should either fix 
things or tell me what rm command I can use to replace things that can't be 
fixed!

Jul 07 20:47:20 dojacat kernel: scrub_stripe_report_errors: 7116 callbacks 
suppressed
Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fixup 
(regular) error at logical 327893450752 on dev /dev/mapper/root physical 
148184301568
Jul 07 20:47:20 dojacat kernel: scrub_stripe_report_errors: 7117 callbacks 
suppressed
Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fixup 
(regular) error at logical 327893450752 on dev /dev/mapper/root physical 
148184301568
Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fixup 
(regular) error at logical 327893450752 on dev /dev/mapper/root physical 
148184301568
Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fixup 
(regular) error at logical 327893450752 on dev /dev/mapper/root physical 
148184301568
Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fixup 
(regular) error at logical 327893450752 on dev /dev/mapper/root physical 
148184301568
Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fixup 
(regular) error at logical 327893450752 on dev /dev/mapper/root physical 
148184301568
Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fixup 
(regular) error at logical 327893450752 on dev /dev/mapper/root physical 
148184301568
Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fixup 
(regular) error at logical 327893450752 on dev /dev/mapper/root physical 
148184301568
Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fixup 
(regular) error at logical 327893450752 on dev /dev/mapper/root physical 
148184301568
Jul 07 20:47:20 dojacat kernel: BTRFS error (device dm-0): unable to fixup 
(regular) error at logical 327893450752 on dev /dev/mapper/root physical 
148184301568

I don't think that BTRFS is responsible for the data loss here, I think that 
is entirely due to the system crashing.  But BTRFS really isn't handling the 
recovery as well as I think it should and could.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




