Return-Path: <linux-btrfs+bounces-4659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4CA8B8F76
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 May 2024 20:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC611F22451
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 May 2024 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3944A1474BB;
	Wed,  1 May 2024 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="o0CrFkEK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5012FF8E
	for <linux-btrfs@vger.kernel.org>; Wed,  1 May 2024 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714587559; cv=none; b=PWEI8RfkExwMLiJUKFXFmQQVoE7Z8i6M1SjfSdLX3I69+84R4w+MOfUppBgkFAe1/PDP6OLIj/wBShXQhdVo/x3UkNgL/grCjHFMQncr+0NyycZH/O3sF4UQCq9/Ex/ZqIALMQIa7of0XfsebLYp7SjlwoubRqUHFtkWPvgps00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714587559; c=relaxed/simple;
	bh=5rW6No9OSgsgOFmwcqH41jc+l6XvGhTkNOvuhh8nHdI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5/xdbGUK8SuogEUF9LROiwbirO/VBdjyMvGGCFdabwFF4e7SfVmWvgBnUNjS1h5VqL1Ncsc/fM7p+/hMaNz2XAikdE89+GrbB3YrjbeUzZYHk5XN9WzVOWmm4IHQsDhdHdpHVn+8AKLHXko+d3xSpcwVBhte2NAChyaXVrR1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=o0CrFkEK; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 33A8260EEE
	for <linux-btrfs@vger.kernel.org>; Wed,  1 May 2024 20:19:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1714587543; x=1716326344; bh=5rW6No9OSg
	sgOFmwcqH41jc+l6XvGhTkNOvuhh8nHdI=; b=o0CrFkEK+dV6zEb5H35gB4ag/n
	UjvpzHryNvo2blYeJVruj3RjOXQURYKNtdwdDt35F+bsVcWdT2OVfWuaFVw7t93i
	E0fiGskw5Y2El6WskTvGUin2ktkGSYpVoQ5xRJ3gu5o0bITTv2KTGAYxnW8A3J4t
	moYIDkvTojyXKjKvuYytdw3fgbDeNfG4A842T5jZAGc0iIjfRYoRaox8VYt0VQYs
	ng4yFVF0fRfguS/IWQjanHNS5BI/UnGjp61CI/jB1fsrztRcdaTZSS8H8axCJPyT
	5L2rTC2qY38/CghUZD6sKXP6SwOGsSNKdhf0YoWSwbOTGoRFjzbUTAk7YY5Q==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id 0Sf0YbI9EoT9 for <linux-btrfs@vger.kernel.org>;
 Wed,  1 May 2024 20:19:03 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Wed, 1 May 2024 20:19:03 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: 2 PB filesystem ok?
Message-ID: <20240501181903.GB393383@tik.uni-stuttgart.de>
Mail-Followup-To: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20240428233134.GA355040@tik.uni-stuttgart.de>
 <6609017e-8931-4559-b613-4b3e28d9fb48@wdc.com>
 <20240501085012.GA393383@tik.uni-stuttgart.de>
 <ZjJOuiu0o1PqV3jA@ws>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjJOuiu0o1PqV3jA@ws>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20230822

On Wed 2024-05-01 (16:16), Tomas Volf wrote:
> On 2024-05-01 10:50:12 +0200, Ulli Horlacher wrote:
> 
> > On Mon 2024-04-29 (12:34), Johannes Thumshirn wrote:
> >
> > > I have used 2PB filesystems in my RAID Stripe Tree test environment, but
> > > for practical uses, I suggest you to enable the block-group tree feature
> > > during mkfs time.
> >
> > I cannot find such an option in man-page for mkfs.btrfs
> 
>     $ mkfs.btrfs  -O list-all
>     Filesystem features available:
>     mixed-bg            - mixed data and metadata block groups (compat=2.6.37, safe=2.6.37)
>     quota               - quota support (qgroups) (compat=3.4)
>     extref              - increased hardlink limit per file to 65536 (compat=3.7, safe=3.12, default=3.12)
>     raid56              - raid56 extended format (compat=3.9)
>     skinny-metadata     - reduced-size metadata extent refs (compat=3.10, safe=3.18, default=3.18)
>     no-holes            - no explicit hole extents for files (compat=3.14, safe=4.0, default=5.15)
>     free-space-tree     - free space tree (space_cache=v2) (compat=4.5, safe=4.9, default=5.15)
>     raid1c34            - RAID1 with 3 or 4 copies (compat=5.5)
>     zoned               - support zoned devices (compat=5.12)
>     block-group-tree    - block group tree to reduce mount time (compat=6.1)
> 
> So I believe it would be `mkfs.btrfs -O block-group-tree ...'.

root@fex:~# mkfs.btrfs  -O list-all
Filesystem features available:
mixed-bg            - mixed data and metadata block groups (0x4, compat=2.6.37, safe=2.6.37)
extref              - increased hardlink limit per file to 65536 (0x40, compat=3.7, safe=3.12, default=3.12)
raid56              - raid56 extended format (0x80, compat=3.9)
skinny-metadata     - reduced-size metadata extent refs (0x100, compat=3.10, safe=3.18, default=3.18)
no-holes            - no explicit hole extents for files (0x200, compat=3.14, safe=4.0, default=5.15)
raid1c34            - RAID1 with 3 or 4 copies (0x800, compat=5.5)
zoned               - support zoned devices (0x1000, compat=5.12)

root@fex:~# btrfs --version
btrfs-progs v5.16.2


This is Ubuntu 22.04



-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<ZjJOuiu0o1PqV3jA@ws>

