Return-Path: <linux-btrfs+bounces-1910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B27184111E
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 18:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9D21F271E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F24F6F06F;
	Mon, 29 Jan 2024 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b="JTTFaE6k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.bitfolk.com (use.bitfolk.com [85.119.80.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DE6F06A
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.119.80.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550388; cv=none; b=A7u916sUc25I2Yegg/KKW3tYsctYKIw7p2e3/KJ4lN2Rfx/ImDJaFMm6gASXWYoFQUJFh/la0WNqYib7wFJzw0GfJ9UIGvCGDlft2YknQrHNwKZHsXn1TA7fmKmmzeU6jYWFIxeRlXnxXihiRnH8E8uX6H0tVd6+93Xqo4ptWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550388; c=relaxed/simple;
	bh=xdWU2lZXc2MXoWw3LnzQe+L5ZxubEravrhVIgpNEomY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pDu5oMXsKUW0yfoX5LjWEl0YW2LDxxwppH7zDisGeBfafmWkZ3ncIDLDwVJnBqjPiQ1BbiouB3pHDy0qWoo71TNE3M6AfEo9RIkM7fIo0hvTnO2VIUKtuzN+F6cnxWXm3TTSiNhJMnJ0k6lkXn/vJPAbkdcO4Wqq2BFtNRwnMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net; spf=pass smtp.mailfrom=strugglers.net; dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b=JTTFaE6k; arc=none smtp.client-ip=85.119.80.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strugglers.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=strugglers.net; s=alpha; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Subject:To:From:Date:In-Reply-To:References:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-To;
	bh=q6xKKRPNxTCEf47FHoTjMCt2E8OukPzk+5nJ06rpMyo=; b=JTTFaE6kyRIPmVmOqOUxYQUX/I
	BtMM7dzV08bhkN8dvzWHnE/NqMZSK/VXn7Co31SLWLjUTg1RbehvchCrTH4pxiYEJSIhiTayvwbZj
	zP4RzZmsM76lKKcKffy8jHWN5GLsGHNbPtkp2AoAyW4aq3Ggzur7KXtEj60Km3qzYobiRSGKI0aBC
	Ddx/bXSkJ4IJbgI+nOj8dx4Q6T1C58mbYxDKTAVjkU88TdtqpyPLBnPrDqR0dp0nYqXU70ImoAWQK
	Bb3hsdjO4N++tpGg/3Cwogys17zXcERgzghOzy/jvDTiiH7Zqs51MM/43jR7HI/ZDp3GHceGYSh9Z
	dhoEX8GQ==;
Received: from andy by mail.bitfolk.com with local (Exim 4.94.2)
	(envelope-from <andy@strugglers.net>)
	id 1rUVi5-0005KA-2C
	for linux-btrfs@vger.kernel.org; Mon, 29 Jan 2024 17:46:17 +0000
Date: Mon, 29 Jan 2024 17:46:17 +0000
From: Andy Smith <andy@strugglers.net>
To: linux-btrfs@vger.kernel.org
Subject: One missing device = fs not detected; upgrade things first?
Message-ID: <ZbfkaXaX0Wmef0VW@mail.bitfolk.com>
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

I cleanly shut down a machine and powered it off, then upon powering
up two things happened.

Firstly, one of the drives no longer responds or registers with the
OS in any way. As in there;s no device node for it and nothing in
the kernel logs.

Secondly, the btrfs filesystem that is spread across 7 of the
drives (including the missing one) also does not appear. As in,
Linux does not detect a btrfs filesystem on any of the remaining
drives, though the drives themselves appear to be there all fine.

Here's lsblk:

# lsblk
NAME                  MAJ:MIN RM   SIZE RO TYPE   MOUNTPOINT
sde                     8:64   0 931.5G  0 disk   
sdf                     8:80   0   1.8T  0 disk   
sdg                     8:96   0   1.8T  0 disk   
sdh                     8:112  0 931.5G  0 disk   
sdi                     8:128  0   1.8T  0 disk   
sdj                     8:144  0   2.7T  0 disk   

(I've omitted details of sd{a,b,c,d} as these are system drives and
not involved here.)

The btrfs fs is directly on those drives so it is expected that
lsblk shows no partitions, but it is not expected that it doesn't
show an fs.

Normally that would be e-k, but as I say, one appears dead. I am
wondering why this has affected my (raid1 profile for data and
metadata) btrfs filesystem though.

I did a "btrfs check" just to see what could be seen. That is still
progressing. It hasn't yet said anything other than a lot of
instances of "failed to load free space cache for block group
…":

# btrfs check -p /dev/sde
Opening filesystem to check...
Checking filesystem on /dev/sde
UUID: 472ee2b3-4dc3-4fc1-80bc-5ba967069ceb
[1/7] checking root items                      (0:07:57 elapsed, 3055030 items checked)
[2/7] checking extents                         (0:08:54 elapsed, 1334143 items checked)
failed to load free space cache for block group 15011172843520d, 1 items checked)
failed to load free space cache for block group 15012246585344
[lots more of that]
[3/7] checking free space cache                (0:05:04 elapsed, 4220 items checked)
[4/7] checking fs roots                        (0:51:38 elapsed, 126792 items checked)
[5/7] checking csums (without verifying data)  (0:13:45 elapsed, 2123139 items checked)

(still going)

If this completes without saying anything else of interest, should I
dare running it in repair mode? I do have backups.

If I should, then I know I should run this with more up to date
tools, because this is a Debian 10 machine with kernel
4.19.0-26-amd64 and btrfs-progs v4.20.1.

Should I build new btrfs-progs and then a new kernel and just boot
with those to see what happens, and then try the check --repair? Or
should I just build the new kernel and see what that makes of the
devices first, then build new btrfs-tools if I am still to run
check?

I did try mount -odegraded but no btrfs superblock is found, so
there is something up besides the missing drive.

Thanks,
Andy

