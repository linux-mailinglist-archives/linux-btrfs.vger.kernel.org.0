Return-Path: <linux-btrfs+bounces-13005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F35AA88BF8
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 21:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC777177476
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 19:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CF028BABD;
	Mon, 14 Apr 2025 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b="a/pnzI+4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3103A1990C7
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657780; cv=none; b=t2b/tXHnEszxGuoUjAIm+/b9e5VMRgZDlZMR7ufUmca8sajNePcacUnBSw/xX4pSIWL0Fhvs4fOvUJ4g1OQLa0FCJslZiib4FANJz6M5M4cqAXzMdamnp9TxMwVHPuuImqe2uWFebHCjzoIg1eI58G4k0D2ESlGBMeXtiwTkzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657780; c=relaxed/simple;
	bh=Blx4GhHhEs9ZCMWxGuyOEQxQNl0Arj4Ursl9vMsC/CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieTdWPe68HCwI5GsRvvaOCxphesyNZdMDV+m+nqGP/R2Px2RQYlRuo+gBu45/cPm388NbcJedZdKcEdflSX/gjZmxMqss97SpuLtW5zg8COKj4z44o079dUOICbzQ9ExYB3ewU+fAcKLk8oJ02TSdeNxeJX5qoJfib1ptZemEkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it; spf=pass smtp.mailfrom=inwind.it; dkim=pass (2048-bit key) header.d=inwind.it header.i=@inwind.it header.b=a/pnzI+4; arc=none smtp.client-ip=213.209.10.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=inwind.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inwind.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-16.iol.local with ESMTPSA
	id 4P8yuAHElrFho4P8zuhE7s; Mon, 14 Apr 2025 21:06:58 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
	t=1744657618; bh=Xxd1RustZcMlrjWV1SE1/FaNA6/yjvPoGvd9nAcXaqM=;
	h=From;
	b=a/pnzI+4YdLNx7+4kCAai38X8/bWMGYD66wEDzDmlTNdCCMDSEPjlraVdfBho1Bol
	 jMGJ3e/p6VQeeIhUYDQULR3tJA19O6lQVe9dYJIv802MASbZGQCttPuzPyJmNEohTB
	 SnqfbfGYhPH7mfXF3XEGlmfHTih6EQRzYVBCFnJ6+hz6Lcp4SxRVqArskwQVh8XPuo
	 F+QHI4S0P0C0aH3FRi9cltNOgo72mKgODoracQY8XQ38UXizQOXJlXgNK0dYajydhz
	 pBrtSrZYRqXyjbyA7Fz53EQz2qYvMZBQr2gYa7vtaXJueIgs+PPCXLp0qvjgeanH2C
	 +KCNys2lqdpag==
X-CNFS-Analysis: v=2.4 cv=UPIWHzfy c=1 sm=1 tr=0 ts=67fd5cd2 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=2Le3lMjJWC0ys_BYqFoA:9 a=QEXdDO2ut3YA:10
Message-ID: <93a7fd2e-d667-4b9c-b2b9-dc4f05e7055d@inwind.it>
Date: Mon, 14 Apr 2025 21:06:56 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: P.S. Re: Odd snapshot subvolume
To: Nicholas D Steeves <sten@debian.org>
Cc: "Brian J. Murrell" <brian@interlinx.bc.ca>, linux-btrfs@vger.kernel.org
References: <dea3861ab4b85f2dffc5bbc9864b290f03c430f4.camel@interlinx.bc.ca>
 <87friais1a.fsf@navis.mail-host-address-is-not-set>
 <87cydeirkl.fsf@navis.mail-host-address-is-not-set>
 <72d7150b-4e0b-4e15-bd3f-ab410be4a767@libero.it>
 <87tt6q1tn3.fsf@navis.mail-host-address-is-not-set>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <87tt6q1tn3.fsf@navis.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCw/k7K2EMYPNxaKUkSt0GQ8KwSyTNgqwSR/blLrn4tCkLk9DnqCKQ6SGDl6J9CDNFh+tTDIOEgNdzle/cPhQSmbD0VpPdNMKTEqswtX1RKQuKl42xrh
 5GacQ40ZjlGMaa5KQsRsu4k9gi9turPjdOd/a1ugcQZbCXpDRVj01NdemizA/I3xDFxkQMh2e+R9BzgkbgczvQ2y32bGib0Msv4yLYgCOfA7hpyF5hM6b3+t
 0N+Qi+UTlUyo+7xJTBAfdA==

On 14/04/2025 20.32, Nicholas D Steeves wrote:
> Of course 'subvolume show' gets subvolume UUID, 'filesystem show' gets
> filesystem UUID, and this is too complicated.  Yes, it's logical, once
> one understands btrfs, but multiple of my colleagues have looked at
> stuff like this, thrown up their arms, and exclaimed things to the
> effect of "I have more important things to think about".

:-)

> To encourage btrfs adoption I think we need to do better.  After
> considering alternatives, I wonder if there is anything simpler/better
> than
> 
>    # findmnt -n -o SOURCE /foo | cut -d[ -f1
> 
> to get the device suitable for mounting -o subvolid=5 | subvol=/ ?  Ie:
> "Just let me see everything with as little fuss as possible. Make it
> simple!", without relying on fstab.

Below a bit simpler command options set

     # findmnt -n -v -o SOURCE /foo

However I have to point out that this is not a specific BTRFS problem. See below

	ghigo@venice:/tmp/test$ mkdir t
	ghigo@venice:/tmp/test$ mkdir t2
	ghigo@venice:/tmp/test$ truncate -s 1G disk.img
	ghigo@venice:/tmp/test$ sudo losetup -f disk.img
	ghigo@venice:/tmp/test$ sudo mkfs.ext4 /dev/loop0
	ghigo@venice:/tmp/test$ sudo mount /dev/loop0 t/
	ghigo@venice:/tmp/test$ sudo touch t/a
	ghigo@venice:/tmp/test$ sudo mkdir t/b
	ghigo@venice:/tmp/test$ sudo touch t/b/c
	ghigo@venice:/tmp/test$ sudo mount -o X-mount.subdir=b /dev/loop0 t2

	ghigo@venice:/tmp/test$ ls t2/
	c

	ghigo@venice:/tmp/test$ findmnt t2/
	TARGET       SOURCE         FSTYPE OPTIONS
	/tmp/test/t2 /dev/loop0[/b] ext4   rw,relatime

	ghigo@venice:/tmp/test$ findmnt -n -o FSTYPE,SOURCE t2/
	ext4 /dev/loop0[/b]

For *any* filesystem, it is possible to mount a subdir of a filesystem as root.
BTRFS subvolume has some special properties (e.g. it is a "barrier" for the snapshot).
However the possibility to be mounted is not one of these BTRFS special properties.

If you want to know which subvolume is mounted, you have to look to the "subvol"
option in the mount command. However even a sub directory of a subvole can be mounted


	ghigo@venice:/tmp/test$ sudo mount -o X-mount.subdir=b,subvol=/subb /dev/loop1 t5
	ghigo@venice:/tmp/test$ findmnt t5
	TARGET       SOURCE              FSTYPE OPTIONS
	/tmp/test/t5 /dev/loop1[/subb/b] btrfs  rw,relatime,ssd,discard=async,space_cache=v2,subvolid=256,subvol=/subb

This to say that event for the common case "findmnt -n -v -o SOURCE <path>" may be
overkilling, there are some corner case where it is needed. To understand the situation I suggest to use

	ghigo@venice:/tmp/test$ findmnt -o FSTYPE,FSROOT,SOURCE -v t5
	FSTYPE FSROOT  SOURCE
	btrfs  /subb/b /dev/loop


> 
> Cheers,
> Nicholas
> 

Ciao
Goffredo

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

