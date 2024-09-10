Return-Path: <linux-btrfs+bounces-7912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE5974480
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 23:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D771C20D8D
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 21:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1CF1AAE07;
	Tue, 10 Sep 2024 21:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="H5F3gnRX";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="M/2aGShl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4361F951
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.189.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002332; cv=none; b=Af88cxo9ZMMml6IkQCYba0usM2t0PhFGTBU2TyDyd+r9mRYoFKe8Q33D+XZRe0rGhoryBLE6YA2CtflfoS6WRbp7r8DMdzN+uX+amNmQ9R0ZaHXpl0bBkXgXGvf5c0l8Ss0M+YImEVQ7Zm/ybCcENIJsnE6vdV2OWSXNfa2jnco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002332; c=relaxed/simple;
	bh=vhLXWC9L7Rsu03a7hqR5NmEuUdELAmw0qNX3lqKqw6U=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Y/KBFwACyewqUmQn9G3F6pM6rxwoPssODD0qhcJKWwQUq9natz1csr+/ErU5TAcNxO5ls4cDaRA/c/jVnyK2SEA5TH7cNzRslIA/TYFDHVy8+jwhEUAvqwswl2SVMfl3JKrLYC7XhzAHhs766CdAPAheDI+1P4UtkVgsAvE+Zjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org; spf=pass smtp.mailfrom=archlinux.org; dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=H5F3gnRX; dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b=M/2aGShl; arc=none smtp.client-ip=95.216.189.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=archlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archlinux.org
Message-ID: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1726002326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y/bBrmcMvgmPHcFsqr3KZbp2X6DNuWIMbSWtOlnTwD4=;
	b=H5F3gnRXJbw/vnXMJwWFBG4TWH5W6E/Cn7zUOrJmt5zAD9QI12q4VY+EXcIZtaS04AtDd5
	0UPcYafljVe9DgqRHrSBHad3pXkCNrOO2w34s9wFYoqXxxAa2U5AebRfSEXc9h85NVfixJ
	hfXNvtU/jySRXc8sYeceNLUU6kTyuXMZjqoGEVcAnf835JoREZNZhgh18qfS0trQ9szaek
	klSh1+gMu6+S77gue/P94x198tyR72mjzQHKElesYIpTzG9fzjcjQv9dR7YMmStaHQfeAp
	uRh0YNyiumO/ibfj3cSkmK3hVChZHcjO3etabA8TY4g767BQKNvIGKiHl+yo0shs8VI1J6
	3C45VoKRl5YjS1JbkfXWidLMfave82h+2iYowidFb0/zuS4fLLoALUpM8D3lGcjMf+XFXm
	Guhkr09fqVsQu2lGoLBeWJ+ut7Ftu4/LK1myb28NpKJBXPHCu7s4aiYlB/zk4HV947H4uK
	z8Nnw2GV/HfxdvVk+KYl+7KEgcQac9dljIMBbs09c9X7+3DB+Qgw+fQEoANCDCNQgR0eeb
	h2RZwBRg6IG9FrLONt1n2wv6nSZv7n1RDBtNGJQnqktHtfXbabMI3JdQHrwwrHQT5qHRWo
	FR2IzL2XyMJfeO8aSg6YZTGuovtr4/daeVjBqYjKmASnZPxgod/JM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1726002326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y/bBrmcMvgmPHcFsqr3KZbp2X6DNuWIMbSWtOlnTwD4=;
	b=M/2aGShl5NrxYqgYG9uHhwV3wANuUAOqNYZiC5rYTKAiOTjvlCJFWD13JU625epsKsIOxQ
	7Aty7Vl2wBhZWvAA==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=archange smtp.mailfrom=archange@archlinux.org
Date: Wed, 11 Sep 2024 01:05:17 +0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: fr-FR, en-GB-large
To: linux-btrfs@vger.kernel.org
From: Archange <archange@archlinux.org>
Subject: Critical error from Tree-checker
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi there,

Since today, my system started randomly becoming read-only. At that 
point I can still run dmesg in an open terminal, so I’ve seen it was 
related to a btrfs error, but did not try anything since I could not 
open a web browser anymore. But I’ve seen the error to be “BTRFS 
critical” and related to a “corrupt leaf”.

I’ve tried to run `btrfs scrub` on the device after rebooting, and in 
fact it aborted almost right away triggering the same error in dmesg 
(but not turning the system read-only, so I can copy paste it here):

[  365.268769] BTRFS info (device dm-0): scrub: started on devid 1
[  385.788000] page: refcount:3 mapcount:0 mapping:00000000d0054cae 
index:0x9678888 pfn:0x11ce15
[  385.788015] memcg:ffff9fc94db8f000
[  385.788021] aops:btree_aops [btrfs] ino:1
[  385.788235] flags: 
0x2ffffa000004020(lru|private|node=0|zone=2|lastcpupid=0x1ffff)
[  385.788248] raw: 02ffffa000004020 ffffea9a8574ff88 ffffea9a847385c8 
ffff9fc95b8365b0
[  385.788255] raw: 0000000009678888 ffff9fc9ae554000 00000003ffffffff 
ffff9fc94db8f000
[  385.788259] page dumped because: eb page dump
[  385.788264] BTRFS critical (device dm-0): corrupt leaf: 
block=646267305984 slot=92 extent bytenr=1182031872 len=106496 invalid 
data ref objectid value 257
[  385.788283] BTRFS error (device dm-0): read time tree block 
corruption detected on logical 646267305984 mirror 1
[  385.796803] BTRFS info (device dm-0): scrub: not finished on devid 1 
with status: -5

According to https://btrfs.readthedocs.io/en/latest/Tree-checker.html 
this is not really expected, and the last paragraph says to report 
troubles here. So here I am, in the search for advice about this error 
(web searches returned nothing with this specific error except the 
commit/ml messages that added the code for it) and how to fix my random 
lockups.

Regards.

P.S.: I’m not subscribed to the list, so please keep me in copy when 
answering.


