Return-Path: <linux-btrfs+bounces-10700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128FFA0090C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 13:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B1D7A0511
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194B61F9F60;
	Fri,  3 Jan 2025 12:09:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from nt.romanrm.net (nt.romanrm.net [185.213.174.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968863CF
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.213.174.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735906151; cv=none; b=LCY+0/Tcl9V7Fo5gdhTHR3vM0C64YozuP1DsHhjxPa+Ftpy667ppar2pUmlV4DDPvDLc0nhaw5MMpKGzOHhC5G2ngYw9hGeootVP+vMIMsGoV8mVog0DO3rdZOlbCnC4fem8hVStjpTC1FlYGSAA/+6Gk624DEdhJx/vWMHoQi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735906151; c=relaxed/simple;
	bh=/Nz/Ffqd/Nhy3Sxse5E+E4hi3TPleHDBOsau0FJdzgY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMPHJU5bKJJocZnk0WIIfwjXOzqCBKqouRb3yhIhh8K7MOyWynMRlK9ufrv5mrJbfCe2kr0LJFkrQ3aTQ5NLVwR7txyaH3Zc6enQMrYEumx58y/S3tDhCjUaDQ4WoviLZZI3KIa24JYJMKx0axCxvMy3OHF7Cn2GYcFgKEINJHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=185.213.174.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.2.romanrm.net [IPv6:fd39:a37d:999f:7e35:7900:fcd:12a3:6181])
	by nt.romanrm.net (Postfix) with SMTP id 2FDEC406D4;
	Fri,  3 Jan 2025 12:09:01 +0000 (UTC)
Date: Fri, 3 Jan 2025 17:09:00 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Victor Banon <banon.victor@gmail.com>
Cc: remi@georgianit.com, linux-btrfs@vger.kernel.org
Subject: Re: BTRFS errors following bad SATA connection
Message-ID: <20250103170900.7016c4c4@nvm>
In-Reply-To: <02affeaa-aafa-4225-94f6-bee621a9a4b6@gmail.com>
References: <9443ea9c-08dc-4d08-81a6-cb91940e791e@gmail.com>
	<76294f4a-9e29-4d57-aff3-3fc5ca3ebf27@gmail.com>
	<f70c5a74-08c3-4eb7-bbde-723aff840b3d@app.fastmail.com>
	<a0dbac20-475c-4e40-84a6-8f0e9159ec8f@gmail.com>
	<20250102183329.35047254@nvm>
	<5c4c4b31-af93-475c-a130-8faa5c61cac1@gmail.com>
	<02affeaa-aafa-4225-94f6-bee621a9a4b6@gmail.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jan 2025 09:21:45 +0100
Victor Banon <banon.victor@gmail.com> wrote:

> `find . -type f -exec cat {} >/dev/null +` returns over 5,000 entries 
> now. After `echo check > /sys/block/md0/md/sync_action`, `cat 
> /sys/block/md0/md/mismatch_cnt` returns over 3,900.
> 
> When is it time to call it quits and reformat everything?

When it stops mounting :)

As is, surely it is easier to restore 3900 files from the backup rather than
everything?

The problem is, it could be that the transid mismatch errors won't go away
even if you replace all the files, or you might not be able to do so. Attempt
to delete or otherwise manipulate some of them might fail with the same errors
in dmesg.

> By the way, once I inevitably restore from a backup, is there any risk 
> that I backed up invisibly corrupted files? I'm pretty sure my latest 
> complete backup was after the SATA issues had started.

Should not be, unless your backup system silently stores half-copied files
into the backup until the point it got an I/O error, and does not warn you of
the error, or you miss the warning.

-- 
With respect,
Roman

