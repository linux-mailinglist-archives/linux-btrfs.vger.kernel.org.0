Return-Path: <linux-btrfs+bounces-17098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B21B9391F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 01:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FD81906E5D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 23:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689FB3164C5;
	Mon, 22 Sep 2025 23:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="OkEN5Vdq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974C83148AF
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583559; cv=none; b=p4kec26n+s52CAy9OSzuH8/fe45luR7A8zYjQMSXxg5j71ZosOGyuC2z1Za1jXaTgBWc523NlmYS3ecbwJe2tvgh9jXyNwFUzdO5J3OxAqNI1RKkiFvdwsKc8lOwFmHYWbZk/Clfm8Ls56kUauze2Nww62IjNFK2d5oQLGPi69Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583559; c=relaxed/simple;
	bh=TdLuxJvjkzX53GtgGvBmkxqSEwD7NKMTiUcpFjTrSgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVll6K3YHjYBVgwyUufH4rD4hNy1wN3ojmUcaI5zsrQRG01KE5TdU/++gfYiMelxAcgb2ABVEB8KJwPfh1l03IH1J3CyxizF3rfM3y1krGPxRR1YpscAxfsoJQLXIGhLj6JRbsD/hcyJQ5ezP5cbDF3d25+XMFTHE1QJg4Qoz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=OkEN5Vdq; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 6B7DE240101
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 01:25:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1758583548; bh=NHfrq8mpVmgNfY2uT9PRy7ZHQy0Dodod6SPfv/pshaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:From;
	b=OkEN5VdqJtTY9QJ+b3az25xP8cR1wN0/0lw4/CW07gOrN0p/YlWcXYEnGBVkmROQW
	 TSsNOwXN6tORZaSzT/Ndasj76u/4n8CEe2SZgKcOB0c43DHMeyO41F5f/GXonizXgK
	 4NIovxGggu0ZusRFYTxTv32zDdAaiDdjPM+IXgmybTAjL1tYxPyAFrOA3QRGmdnhuf
	 7+AH9tyRYBr+QuNdJEHh8PRjVN3qUpt1QmDAPIGbF0ZhBIQTY5f9UGorDYdYuPra/+
	 IdL4uVD8no1v/sBplgwl86S8rKAjY9HEIV0Nzwa+Mvm3DmioU43vs3majT4C4dPmp+
	 TP+dtsUKohFfw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cVzkM0rgdz6tvx;
	Tue, 23 Sep 2025 01:25:46 +0200 (CEST)
Message-ID: <d14d26ce-3176-4cd4-989e-cdbda30be98e@posteo.net>
Date: Mon, 22 Sep 2025 23:25:48 +0000
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
To: Christoph Hellwig <hch@infradead.org>,
 Demi Marie Obenour <demiobenour@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
 <aNF9xH30pAEq5y4r@infradead.org>
 <38f350b0-9a71-4627-9d36-57bf2f85e67a@gmail.com>
 <aNGFdxq6Xqduoj6w@infradead.org>
Content-Language: en-US
From: Chris Laprise <tasket@posteo.net>
Autocrypt: addr=tasket@posteo.net; keydata=
 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
In-Reply-To: <aNGFdxq6Xqduoj6w@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 13:20, Christoph Hellwig wrote:
> On Mon, Sep 22, 2025 at 01:18:52PM -0400, Demi Marie Obenour wrote:
>> Is it safe on XFS if there is no RT device and both files have been
>> fsync'd and are not modified by userspace?  I believe this is the case
>> here: reflinks are used to snapshot the files before they are looked at.
> 
> No.  Yo ucan still have defragementation or garbage collection going on
> underneath.
> 

Hi, Wyng developer here...

The overall procedure is:

1. Get subvolume's Generation ID

2. Read FIEMAP data

3. Get subvolume's Generation ID again

4. Check that the Generation ID hasn't changed: No match skips the file 
or raises an error

I believe with those steps it is safe to use FIEMAP data for a read-only 
use case (backup), even when online maintenance is occurring. That has 
certainly been my experience after years of daily use and verification 
with no incidents of related data corruption. Ironically, this has been 
more reliable than using 'thin_delta' output from thin-provisioned LVM 
volumes.

I should clarify that in this application we are not interested in 
physical mappings, but the logical representation of data. It is also 
understood that for some other applications FIEMAP would not be 
sufficient; however Wyng is not fetching or manipulating data at a low 
level.  Also, there is a lack of accuracy in the form of false 
positives, where unchanged data show up as deltas, but this only results 
in longer processing time not data corruption; false negatives are the 
only thing that must be avoided.

Other concerns upthread appear to be addressed by Wyng.  For instance 
NODATACOW files are not an issue because the snapshots are reflink 
based; Wyng uses a conventional "full scan" sans snapshot in those cases.

-- 
Chris Laprise, tasket@posteo.net
https://codeberg.org/tasket
PGP: BEE2 20C5 356E 764A 73EB  4AB3 1DC4 D106 F07F 1886

