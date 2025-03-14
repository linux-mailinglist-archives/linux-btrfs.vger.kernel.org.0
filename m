Return-Path: <linux-btrfs+bounces-12285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24A8A616D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 17:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCDC19C52B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Mar 2025 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB7020408C;
	Fri, 14 Mar 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b="vEMpqtdb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.sws.net.au (smtp.sws.net.au [144.76.186.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B7A18B494
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Mar 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.186.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741971274; cv=none; b=COiax7G8f1SvhTGm+1v8c0Ucr+7L2kOhMHySk4hsmdLXuMgMd5m8Lt8SVBF5DqIuGDhzSTWRaoj7S4mQ97fw50mhBFuECsXsGMg8csyy5mCbJ7MTsRYEbciR4c5WqjRaPgLZF8z3iiK/Rv0vrLAdOn9YhgitI4ILatuyJ1oKAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741971274; c=relaxed/simple;
	bh=Q7F2J16rrXERSb3brgcQbmxBlfAUOE/YWzMfIV3Ho8w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7s+XeKaK8RYv9jc8jXOnRIOdbKxB91gSist2C4Gz8xsOjtR96JoftBC/VzgzF2A/lulkTCarqCuW8JX3q/X/fKKt8FMXH7XDzV3KIeBHuAgn0PiRYlF0YircGlOEMnLzoHJgomNEh0Rr9jZPvjBUbMTy4jkClq3uJJjh17qmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au; spf=pass smtp.mailfrom=coker.com.au; dkim=pass (1024-bit key) header.d=coker.com.au header.i=@coker.com.au header.b=vEMpqtdb; arc=none smtp.client-ip=144.76.186.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coker.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coker.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=coker.com.au;
	s=2008; t=1741971269;
	bh=XDD1+Hn46sdTrqNc0cM0GSvrE8o0yby8eXGcrs6bQi8=; l=2230;
	h=From:To:Reply-To:Subject:Date:In-Reply-To:References:From;
	b=vEMpqtdbiRFPFVlG1W4Q/Kx5iqFF6N17e/ohR1tfscgjGEwKIZ6Uw22f4G1LeM4Do
	 JDxixDw6ZQO60uZZmv6FXQh9o/LJlmnppIAg49ewnKv4hA3pTEQ4vk2cde/7gvTcWL
	 p9uf3Kso1t/NuG9KO5zhNHIsUZXv0HIirPXZehF8=
Received: from xev.localnet (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.sws.net.au (Postfix) with ESMTPS id 7C1B912041;
	Sat, 15 Mar 2025 03:54:28 +1100 (AEDT)
From: Russell Coker <russell@coker.com.au>
To: linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Reply-To: russell@coker.com.au
Subject: Re: strangely uncorrectable errors with RAID-5
Date: Sat, 15 Mar 2025 03:54:22 +1100
Message-ID: <3349775.aeNJFYEL58@xev>
In-Reply-To: <1924801.tdWV9SEqCh@xev>
References:
 <23840777.EfDdHjke4D@xev> <0bedb9d8-0924-4c19-a5d1-9951b04f2781@suse.com>
 <1924801.tdWV9SEqCh@xev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 14 March 2025 23:27:51 AEDT Russell Coker wrote:
> Just to see if anything had changed I ran the same tests with RAID-5 data
> and metadata again with the Debian kernel 6.12.17-amd64 and this time got
> properly uncorrectable errors in less than a minute.  I don't know if the
> error happened faster and worse than before because of some kernel
> difference, luck, or some timing difference when running on different
> hardware.

I did it again but with RAID-5 data and RAID-1 metadata and it took a few 
hours this time but again got to an uncorrectable state.

[15653.298999] BTRFS warning (device vdc): checksum error at logical 
5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) in 
tree 5
[15653.299001] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 5157748736 on dev /dev/vdc physical 1673199616
[15653.299002] BTRFS warning (device vdc): checksum error at logical 
5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) in 
tree 5
[15653.299003] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 5157748736 on dev /dev/vdc physical 1673199616
[15653.299005] BTRFS warning (device vdc): checksum error at logical 
5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) in 
tree 5
[15653.299006] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 5157748736 on dev /dev/vdc physical 1673199616
[15653.299007] BTRFS warning (device vdc): checksum error at logical 
5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) in 
tree 5
[15653.299009] BTRFS error (device vdc): unable to fixup (regular) error at 
logical 5157748736 on dev /dev/vdc physical 1673199616
[15653.299010] BTRFS warning (device vdc): checksum error at logical 
5157748736 on dev /dev/vdc, physical 1673199616: metadata leaf (level 0) in 
tree 5

Below is the script that broke it.

#!/bin/bash
set -e
while true ; do
  for DEV in c d e f ; do
    dd if=/dev/zero of=/dev/vd$DEV oseek=$((20+$RANDOM%3*1000)) bs=1024k 
count=1000
    sync
    btrfs scrub start -B /mnt
    sync
  done
  date
done

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/




