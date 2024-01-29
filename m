Return-Path: <linux-btrfs+bounces-1921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD79B841534
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 22:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3791F2455E
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 21:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD2E1586E8;
	Mon, 29 Jan 2024 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b="nAmvl0+M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.bitfolk.com (use.bitfolk.com [85.119.80.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF3158D68
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 21:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.119.80.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706564489; cv=none; b=basEti2u6LZYszHi96krm1OvmLcdLJBNxIRKzTdzKx6tSgNJswejiCCD4Gohq7/wsXIA7iLFEOFdabeO248y6fQEK8LjFY8x9MMLLlmWSFp0TUFPKWWhBvIhGrOW2izY4yxbrq4cX31tV/0bmRyX7g58rZ22QVr2Pp95tAseRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706564489; c=relaxed/simple;
	bh=exEcmYBx11MSji3/dVeI7KM0I+DiCd/9IFl4XYUYO1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmFC3VwDNIKJEoNgCUY+CVGyq25b7EnnN3r3a+Reqv1oyh+UFwkQnOG5j3yLr4gJgIEmTFDaDwAszYaZgfC6GP6eEU5Va6JAf6J93D92WAxGfX0F6+fqpac/TZTID4JiYxxLh0TmEQaVT0S1mJ6o7A3U80tooLr8GcaoDXBcoWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net; spf=pass smtp.mailfrom=strugglers.net; dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b=nAmvl0+M; arc=none smtp.client-ip=85.119.80.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strugglers.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=strugglers.net; s=alpha; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-To;
	bh=19Rbv/K9gnDwd9JLIc+ipug6ieJB8xCB/UdtY7SnIqY=; b=nAmvl0+Mru842QEpWi15Z9yCnp
	+pz7w+a0j6iodiLTpI6UYlpwwd0yI9mckyMimrx/h4ccHZwxrviS1SGznobMYmT4oRi8KpxRfe/Qd
	cBiw6BYOCFf3QRQ1btWmKW0aDwBrb4/rFbzxV5MO+8sa/PjriW7ngCq2aLcT9iviYvNjPFZitnCmj
	X+pHSDbuCKI0pdqCRCV0+/1uqxdiBJIdbi/IUaZxk4MBXsnKkwT6q7yceFNIrxGX9QTROuYn29zJF
	2dB+ghF9kmg4EQ5P+6HrvBAVHCTFZg2CXFwa6ELR/qzdaRbF7qr5j72pcMkkssEXeuyIiyC8bNSB8
	bOsVjRZw==;
Received: from andy by mail.bitfolk.com with local (Exim 4.94.2)
	(envelope-from <andy@strugglers.net>)
	id 1rUZNc-0003YC-E5; Mon, 29 Jan 2024 21:41:24 +0000
Date: Mon, 29 Jan 2024 21:41:24 +0000
From: Andy Smith <andy@strugglers.net>
To: Remi Gauvin <remi@georgianit.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: One missing device = fs not detected; upgrade things first?
Message-ID: <ZbgbhHDCtiNHSlQL@mail.bitfolk.com>
References: <ZbfkaXaX0Wmef0VW@mail.bitfolk.com>
 <3f3dcc01-6d23-4490-7b8d-98eff520bc85@georgianit.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f3dcc01-6d23-4490-7b8d-98eff520bc85@georgianit.com>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL: http://strugglers.net/wiki/User:Andy
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false

Hi Remi,

On Mon, Jan 29, 2024 at 01:24:09PM -0500, Remi Gauvin wrote:
> That is what lsblk output looks like to me.  There is no filesystem
> information in the output.  Are you confusing lsblk and blkid?

Maybe. But see later…

> > Should I build new btrfs-progs and then a new kernel and just boot
> > with those to see what happens, and then try the check --repair? Or
> > should I just build the new kernel and see what that makes of the
> > devices first, then build new btrfs-tools if I am still to run
> > check?
> 
> I would suggest the output of btrfs filesystem show, as well as the
> exact mount command and any dmesg output when mount command is run.

Hmm,. strange. Now:

# btrfs fi sh 
Label: 'tank'  uuid: 472ee2b3-4dc3-4fc1-80bc-5ba967069ceb
	Total devices 7 FS bytes used 3.72TiB
	devid    5 size 2.73TiB used 2.44TiB path /dev/sdj
	devid    6 size 1.82TiB used 1.53TiB path /dev/sdf
	devid    8 size 931.51GiB used 839.00GiB path /dev/sdh
	devid    9 size 931.51GiB used 857.00GiB path /dev/sde
	devid   10 size 1.75TiB used 1.67TiB path /dev/sdg
	devid   12 size 1.75TiB used 548.50GiB path /dev/sdi
	*** Some devices missing

# mount -t btrfs -odegraded /dev/sde /srv/tank

(long pause, but eventually worked)

Logged:

2024-01-29T21:14:01.748805+00:00 specialbrew.localnet kernel: [19014.852866] BTRFS info (device sdj): allowing degraded mounts
2024-01-29T21:14:01.748874+00:00 specialbrew.localnet kernel: [19014.852873] BTRFS info (device sdj): disk space caching is enabled
2024-01-29T21:14:01.768772+00:00 specialbrew.localnet kernel: [19014.866523] BTRFS warning (device sdj): devid 11 uuid 296b4aa0-434d-408e-8b8b-f11d93186a11 is missing
2024-01-29T21:14:01.768772+00:00 specialbrew.localnet kernel: [19014.866523] BTRFS warning (device sdj): devid 11 uuid 296b4aa0-434d-408e-8b8b-f11d93186a11 is missing
2024-01-29T21:14:03.512856+00:00 specialbrew.localnet kernel: [19016.615549] BTRFS info (device sdj): bdev (null) errs: wr 1, rd 0, flush 0, corrupt 0, gen 0

Admittedly I did not try "btrfs filesystem show" before, as the
complete lack of spotting an fs on there, and "btrfs dev scan"
seemingly doing nothing threw me a bit. But I DID try a mount
before, which failed saying it couldn't find a superblock. Yet now
it seems to have worked okay.

Everything seems alright, I just need to work out what happened with
that one drive.

As for lsblk, it now says:

# lsblk
sde                     8:64   0 931.5G  0 disk   
sdf                     8:80   0   1.8T  0 disk   
sdg                     8:96   0   1.8T  0 disk   
sdh                     8:112  0 931.5G  0 disk   
sdi                     8:128  0   1.8T  0 disk   
sdj                     8:144  0   2.7T  0 disk   /srv/tank

but I suppose only because that is now mounted.

Thanks!
Andy

