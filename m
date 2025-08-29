Return-Path: <linux-btrfs+bounces-16529-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897FAB3C4B1
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 00:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4702616AD83
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 22:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB99D2727EB;
	Fri, 29 Aug 2025 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b="mwqgZtmt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.bitfolk.com (use.bitfolk.com [85.119.80.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202341D61BB
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.119.80.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756505834; cv=none; b=GaD6kcp0/AmS6WJKbAWV9/53i6QmyyfMnxzJRF7QojYbCo8ZJw57rg1l14AgZKqY8aoX9qDyt/FSFWm8tn01lovNo1j1FJO4k2Br1va6fVUgTxrrbzv/q6WixbgISMGxYw1ftEwNq1PjptR3iUPxJR0BKD5Cd43eBMGLjFsUx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756505834; c=relaxed/simple;
	bh=xFx3k6HNx8RT35raoHg5V/SlWAONt6zudncXlTSERqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cdy3eaC9gdlMroptank0Tqh0hga/rZiyHl20vyZZMRVG1+hiSeqbB1e/H534ym8A8sKWwv9OZRZTMdsW8cfarnvoTYXECtkmOaUlw3E1noD6k5KsmdXVtWy3PIIBZLoA3jqSE+F1gKTR9Y0dUdUYnGaxu5A/UzhhOyUkGhozbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net; spf=pass smtp.mailfrom=strugglers.net; dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b=mwqgZtmt; arc=none smtp.client-ip=85.119.80.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strugglers.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=strugglers.net; s=alpha; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-To;
	bh=srZX1MW5OmqgGVWecpsEFq/+tiU1RHX1lreR0RjZ3Ws=; b=mwqgZtmtQOm7bBiz1ugdd6r89y
	NmHlTW7ADLUsM8nY2OvE57DGn3aEVPZHtZUnbtfXm7EAspQff2TDpqrTAdkNBZsgZpyxPZ2gI8tSr
	aOqgVFX5WReSPmop6hNtBLFkdx5vZXr9LQn+zulOEGdpv/G07obNeeIVpSmkaY9iUOTjlv2M+8VDS
	ooYg8Z8FWPUtmPx1y2mCie/ZAw97IISsf1YTFwWgBTyOFqG7K0jkb6Tf4fxuZX6nhffI2+LMGZzRC
	fD4J3+3vAsXQ9tQB9M3hIEO8BlyB5KuvRTwrxtvEALrn8T8vFoMWmpzDq4lTz5T8KPHdJ2I0+fme3
	wqpm70pA==;
Received: from andy by mail.bitfolk.com with local (Exim 4.94.2)
	(envelope-from <andy@strugglers.net>)
	id 1us7PB-00026J-Uv; Fri, 29 Aug 2025 22:17:09 +0000
Date: Fri, 29 Aug 2025 22:17:09 +0000
From: Andy Smith <andy@strugglers.net>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Mysterious disappearing corruption and how to diagnose
Message-ID: <aLIm5djb6Ee4T1ot@mail.bitfolk.com>
References: <aLIRfvDUohR/2mnv@mail.bitfolk.com>
 <a48ac216-38f1-4a69-970e-f2ddee2ae8f2@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a48ac216-38f1-4a69-970e-f2ddee2ae8f2@suse.com>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL: http://strugglers.net/wiki/User:Andy
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false

Hi Qu,

Thanks for your reply.

On Sat, Aug 30, 2025 at 06:45:15AM +0930, Qu Wenruo wrote:
> 在 2025/8/30 06:15, Andy Smith 写道:
> > After the second of the new SSDs was added in I started receiving logs
> > about corruption on the newest added device (sdh):
> 
> Is this during dev replace/add/remove?

I have been mistaken about the order of operations. The one that
introduced sdh was:

2025-08-25T00:13:22.804904+00:00 strangebrew sudo:     andy : TTY=pts/9 ; PWD=/home/andy ; USER=root ; COMMAND=/usr/bin/btrfs replace start /dev/sdb /dev/sdh /srv/tank

> Would it be possible to provide more context/full dmesg for the incident?

There's just thousands of the message I gave and nothing else, but for
context:

2025-08-25T00:16:13.551484+00:00 strangebrew kernel: [15845362.486304] BTRFS info (device sdh): dev_replace from /dev/sdb (devid 9) to /dev/sdh started

2025-08-25T02:31:55.547470+00:00 strangebrew kernel: [15853504.586725] BTRFS info (device sdh): dev_replace from /dev/sdb (devid 9) to /dev/sdh finished

So actually these errors appear not during the replace that introduced
sdh but later on. I guess that makes sense since sdh is not being read
from when it's empty!

Let me see what other operations were done after this…

2025-08-25T02:58:36.452870+00:00 strangebrew sudo:     andy : TTY=pts/9 ; PWD=/home/andy ; USER=root ; COMMAND=/usr/bin/btrfs replace start /dev/sdf /dev/sdb /srv/tank
2025-08-25T03:01:29.103489+00:00 strangebrew kernel: [15855278.164899] BTRFS info (device sdh): dev_replace from /dev/sdf (devid 12) to /dev/sdb started
2025-08-25T04:52:36.719565+00:00 strangebrew kernel: [15861945.864876] BTRFS error (device sdh): bad tree block start, mirror 1 want 18526171987968 have 0
2025-08-25T04:52:36.719578+00:00 strangebrew kernel: [15861945.867728] BTRFS info (device sdh): read error corrected: ino 0 off 18526171987968 (dev /dev/sdh sector 238168896)
2025-08-25T05:44:42.139479+00:00 strangebrew kernel: [15865071.325433] BTRFS error (device sdh): bad tree block start, mirror 1 want 18526179364864 have 0
2025-08-25T05:44:42.139493+00:00 strangebrew kernel: [15865071.328345] BTRFS info (device sdh): read error corrected: ino 0 off 18526179364864 (dev /dev/sdh sector 238183304)
2025-08-25T11:34:15.115468+00:00 strangebrew kernel: [15886044.574930] BTRFS info (device sdh): dev_replace from /dev/sdf (devid 12) to /dev/sdb finished

I have not omitted any "read error corrected" messages between these
times so during replace of sdf with sdb in fact only two of the
corrupted reads occurred.

The vast majority of the "read error corrected" messages happen later
between:

2025-08-26T01:15:18.179736+00:00 strangebrew kernel: [15935308.276936] BTRFS info (device sdh): read error corrected: ino 0 off 18526369787904 (dev /dev/sdh sector 238555224)

and

2025-08-27T04:37:04.973808+00:00 strangebrew kernel: [ 6683.406728] BTRFS info (device sdb): read error corrected: ino 450 off 981975040 (dev /dev/sdh sector 56445920)

(last one ever)

There was also a reboot in between those times.

After seeing the read errors I had made a drive bay available and
re-attached one of the old devices:

2025-08-26T20:52:58.644481+00:00 strangebrew sudo:     andy : TTY=pts/9 ; PWD=/home/andy ; USER=root ; COMMAND=/usr/bin/btrfs dev add /dev/sdf /srv/tank

I then removed sdh:

2025-08-26T21:03:32.781261+00:00 strangebrew sudo:     andy : TTY=pts/9 ; PWD=/home/andy ; USER=root ; COMMAND=/usr/bin/btrfs dev remove /dev/sdh /srv/tank

2025-08-27T04:50:16.085385+00:00 strangebrew kernel: [ 7474.522398] BTRFS info (device sdb): device deleted: /dev/sdh

Except for a scrub no further management is done of the btrfs filesystem
at /srv/tank after this. After this is only my investigations of what is
going on with sdh.

So thousands of the corrected read errors happen after
2025-08-26T01:15:18.179736+00:00 but there was no btrfs management
operation happening until 2025-08-26T20:52:58.644481+00:00 therefore a
large number of them happened during normal operation of the filesystem,
long after the replacement in of both sdh and sdb.

These look slightly different in that the number after "ino" isn't 0:

2025-08-26T01:15:18.823475+00:00 strangebrew kernel: [15935308.917636] BTRFS warning (device sdh): csum failed root 534 ino 17578 off 524288 csum 0x8941f998 expected csum 0xec2689f0 mirror 1
2025-08-26T01:15:18.823486+00:00 strangebrew kernel: [15935308.917652] BTRFS warning (device sdh): csum failed root 534 ino 17578 off 655360 csum 0x8941f998 expected csum 0xf3ada24a mirror 1
2025-08-26T01:15:18.823487+00:00 strangebrew kernel: [15935308.918200] BTRFS error (device sdh): bdev /dev/sdh errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
2025-08-26T01:15:18.823488+00:00 strangebrew kernel: [15935308.918928] BTRFS error (device sdh): bdev /dev/sdh errs: wr 0, rd 0, flush 0, corrupt 2, gen 0

> And what's the raid profile?

It is RAID1 profile for data, metadata and system.

Sorry, I realised just after sending that I did not give that
information.

> > Debian 12, kernel 6.1.0-38-amd64, btrfs-progs v6.2 (all from Debian
> > packages).
> 
> And the kernel version is not that ideal, it's still supported and receiving
> backports, but I'm not really sure how many big refactor/rework/fixes are
> missing on that LTS kernel.

Okay. Yes it is still supported by Debian so they are still publishing
updates for the related LTS kernel but I am relying here on fixes going
in to LTS kernel in the first place.

Thanks,
Andy

