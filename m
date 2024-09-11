Return-Path: <linux-btrfs+bounces-7930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3946974DB1
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 10:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6A71F25F1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 08:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E45153820;
	Wed, 11 Sep 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="wq7zMyGw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A5A33086
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045120; cv=none; b=ILqFeNiGhkCwSTn6vIW/9c0/AW7Qi/eKReJ+Ynv7rBDSi0zp2HiI1TjpOXaet07+4aWO3SqPt8wDRRT9b4edMxIocw0oHnDPq/fq2ajxC6RdzOjhhI1Ga/f2R4+xxpmECR4UTsPcQ7xqAwzEYx9oCI8A4rZQlcTMmtVZMg83Hb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045120; c=relaxed/simple;
	bh=Z91jde/+jUINpi3w6G9vyDyieb+WP+GCN1BOqonp3HY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrfEvkDX/s+dCW8JCGYdg4Pgnt47cgprc92ygncNJi8WSyAm1kIIQ7tXuf3lUFjdUO4QGzhST7C00Nago3iDtkR/0EKmEzbDFbvVCNnifB3/4qkDSe9/VT9VQ9c4t0DOe25pKuwbaK40QbJoGbNWJBFX0zekb+s/F+Wi9lhTmGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=wq7zMyGw; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 1303960DDB
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 10:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-transfer-encoding
	:content-disposition:content-type:content-type:mime-version
	:references:message-id:subject:subject:from:from:date:date; s=
	dkim; i=@rus.uni-stuttgart.de; t=1726045109; x=1727783910; bh=Z9
	1jde/+jUINpi3w6G9vyDyieb+WP+GCN1BOqonp3HY=; b=wq7zMyGwno0OLq1mPx
	cyVVr8mB87S7bfJcramYtha8hAouZsFYrWK4XRRIIPLl7G+c9H7krNm2NYvTooZa
	BCVepjHzK8jrEHaykzgPLylsUeiYOrC+nfRIlCnTWTNLwdgmMgDJLkv2YWIX8afH
	ngaImGQWb6zXeqfvgNGemxGDBezQ40H2yfBtglqiN8E8aiBrTdNYoPmVSsTuSU8z
	nMzcQqVNi54mFTH76/k9bsWE1J/pF07+4J9RN7NQN2pgcPjnfA2rp8yfGeHBHU7m
	L1UcDW+xCVkfotdPyw4uo5uG8UmAZ1GFRVeoIG9KHgMusa1TNgQkoV99yrMm4rMi
	NAnA==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id kVp_EnXjKryQ for <linux-btrfs@vger.kernel.org>;
 Wed, 11 Sep 2024 10:58:29 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Wed, 11 Sep 2024 10:58:29 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: Btrfs balance broke filesystem
Message-ID: <20240911085829.GC218002@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <b9b86b32095ba924fb8c7eec4d8ec024113d9ff4.camel@beware.dropbear.id.au>
 <5fdb905b-20ee-4978-ba81-10b1fc4ac475@gmx.com>
 <20240911080004.GA218002@tik.uni-stuttgart.de>
 <79e83450-098a-4e09-bfcb-625b6346525d@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79e83450-098a-4e09-bfcb-625b6346525d@gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Wed 2024-09-11 (17:41), Qu Wenruo wrote:

> 在 2024/9/11 17:30, Ulli Horlacher 写�":
> 
> > On Sun 2024-09-01 (19:15), Qu Wenruo wrote:
> >
> >> Convert/balance is only recommended if you have unallocated space (shown
> >> in `btrfs fi show`) to fulfill at least a metadata block group (1G in
> >> size for most cases).
> >
> > How can I detect this "unallocated space"?
> 
> My bad, the more correct usage should be "btrfs fi usage"

I see, it is just "free space"!


> In your case, "btrfs dev usage" is also fine, and that already shows the
> problem:
> 
> /dev/mapper/cryptroot-1, ID: 1
>     Device size:           915.01GiB
>     Device slack:            3.50KiB
>     Data,single:           842.97GiB
>     Metadata,single:        72.01GiB
>     System,single:          32.00MiB
>     Unallocated:             1.00MiB  <<< Only 1MiB, not enough

Mismatch-error :-)

It is not "my case". The thread starting mail was not from me, I have had
just an addon question regarding btrfsmaintenance.



> This multi-device problem is a long existing known problem, I guess it's
> really time for us to properly fix it.
> 
> The unallocated space is only a workaround, to prevent hitting the
> situation.

> For your use case, RAID1 with unbalanced disk size, there is really no
> good way to fix it until we fix the root bug.

If there are no btrfs RAID filesystems balancing is not an issue? 

My storage is a hardware RAID (Netapp), the btrfs filesystems are on single
virtual disks (/dev/sdX)

I can riskless continue using "btrfsmaintenance"?
(I just should switch to the official Ubuntu package)


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<79e83450-098a-4e09-bfcb-625b6346525d@gmx.com>

