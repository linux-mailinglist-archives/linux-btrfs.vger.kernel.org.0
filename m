Return-Path: <linux-btrfs+bounces-8727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A691B996F18
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 17:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80131C21E5E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 15:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F012E1C0DF3;
	Wed,  9 Oct 2024 15:00:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from freki.datenkhaos.de (freki.datenkhaos.de [23.88.67.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87741537FF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.67.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486052; cv=none; b=c8H87VMAx1kULSskKDvanrJSEf/i7OPMuG+40YPkRpMQ+j5gE6g+fVvdXTBYttAoidTXjvmjblLDBB9/rukDhI2NCRK5EDsf3nNSn5sqgs3rXvSietByedkmu5ao3TC556bZM/Iicy0dO102F99+W2zb16jDeLoESeur3dKx670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486052; c=relaxed/simple;
	bh=QoXIkl3VC1q13p7qS6WP6f9hBmQrpsLuESijpJqKg3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqETwtoMAUWEVcCK1V5wckEeMVpZSw1IHIFNdLBrMZ84rizoxalzR5s6POxJ+DIpvd9pEk/ORzb1I3gQIABfTeY4MPt3NtmQpDdZE+ODMvAjJqrfn/4/h2+Inadb36VELqOHLU8AFn9mkAd2ud+7BdWFtX6C5DJ/Az98/+OjS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=datenkhaos.de; spf=pass smtp.mailfrom=datenkhaos.de; arc=none smtp.client-ip=23.88.67.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=datenkhaos.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenkhaos.de
Received: from elitebook (unknown [134.19.35.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by freki.datenkhaos.de (Postfix) with ESMTPSA id 0DD68D7DC20;
	Wed, 09 Oct 2024 17:00:43 +0200 (CEST)
Date: Wed, 9 Oct 2024 17:00:38 +0200
From: Johannes Hirte <johannes.hirte@datenkhaos.de>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "cwalou@gmail.com" <cwalou@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: mount: can't read superblock on - corrupt leaf - read time tree
 block corruption detected
Message-ID: <32s5sdlmlz2jhqweoyvrync734f7rn4goqfka3nie4epa6ltvm@dfrz37wefhc6>
References: <492c06c3-5e37-4026-96a8-cacc8eb28f51@gmail.com>
 <e040f6b8-6775-4b87-a345-6f6fb56aab26@gmx.com>
 <cuab5thyorquonghaxpqwxkfhog7lgrxzv3a5kdjs2zfw4ulaj@gutzirf5ipiv>
 <6a11b718-4d72-4422-ae08-7af7598a9403@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a11b718-4d72-4422-ae08-7af7598a9403@gmx.com>

On 2024 Okt 09, Qu Wenruo wrote:
> 
> 
> 在 2024/10/9 06:02, Johannes Hirte 写道:
> > On 2024 Okt 03, Qu Wenruo wrote:
> > > 
> > > 在 2024/10/3 17:02, cwalou@gmail.com 写道:
> > > > Hello.
> > > > 
> > > > A 4TB drive taken out of a synology NAS. When I try to mount it, it
> > > > won't. This is what I did :
> > > 
> > > Synology has out-of-tree features that upstream kernel doesn't support.
> > > 
> > 
> > Hello,
> > 
> > I've noticed similar errors on my server too. It's a gentoo box with
> > vanilla kernel. It happend first with linux-6.10.9 and happens with 6.11
> > too:
> 
> This is a different one from the original report.
> 
> > 
> > [   67.310316] BTRFS: device label bigraid1 devid 1 transid 98985 /dev/sdd1 (8:49) scanned by mount (4069)
> > [   67.313109] BTRFS info (device sdd1): first mount of filesystem 83a02224-c807-4e70-a2cd-8b7156bfbbd2
> > [   67.313137] BTRFS info (device sdd1): using crc32c (crc32c-generic) checksum algorithm
> > [   67.313156] BTRFS info (device sdd1): using free-space-tree
> > [   67.527088] page: refcount:4 mapcount:0 mapping:000000004bf8c7c2 index:0x2ffb1be8 pfn:0x11b55c
> > [   67.527114] memcg:ffff8881174ab800
> > [   67.527120] aops:0xffffffff8206c960 ino:1
> > [   67.527129] flags: 0x2000000000004000(private|node=0|zone=2)
> > [   67.527144] raw: 2000000000004000 0000000000000000 dead000000000122 ffff8881022c9678
> > [   67.527152] raw: 000000002ffb1be8 ffff88811b5304b0 00000004ffffffff ffff8881174ab800
> > [   67.527157] page dumped because: eb page dump
> > [   67.527162] BTRFS critical (device sdd1): corrupt leaf: block=3297221967872 slot=47 extent bytenr=2176663552 len=36864 invalid data ref objectid value 259
> 
> This is caused by the long deprecated inode_cache feature.
> 
> Newer btrfs-check can report it as an error.
> 
> You can fix it by "btrfs rescue clear-ino-cache <device>" on the
> unmounted fs, using btrfs-progs v6.11 (the command is there for a long
> time, but has some small bugs).
> 
> Thanks,
> Qu

Thank you, this fixed it. Just one question, can't this be done automatically
at mount-time? Would be much more convenient than a system that doesn't come
back after kernel update.

regards,
  Johannes

