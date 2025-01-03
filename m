Return-Path: <linux-btrfs+bounces-10702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1F5A00A01
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 14:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB77188488E
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273031FA245;
	Fri,  3 Jan 2025 13:46:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from nt.romanrm.net (nt.romanrm.net [185.213.174.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399C71F9F73
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.213.174.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735911963; cv=none; b=plvwrwrCptvg54E3a/PZJlFU/YNPfmr1NVxexz8lztzo11nZRtgSSVDCmuP9th0/slDwTs7aKWrz12Rse1sHaJasYuBUbu1/53tZ4Vxv4at+pxHhD9SKmiKiW+yHB4Gg8LdQxkBbyOJG3MrK1hhKqQYhc6mh/nT70zw+GGRj9yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735911963; c=relaxed/simple;
	bh=NrbmV6J0y45BWgqIva1M+TQ6WLwUz1GejhIqXLZQs7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJ6F87fAW8ppMOXff4KlDqGeUnPqMkzIIl889LKQ6HevLHT+2Qr4JBJuEItoFQnwDFKZMaOX2r0PHocp/S8BcAa0oViQotJpU/eZGqoo6lA8dm9kNpBOmj+IpnbQgYQ/V1jaKqDOkwC9TztvPpxqgbaWa45GEEZ6az4oqRJ7M3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=185.213.174.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.2.romanrm.net [IPv6:fd39:a37d:999f:7e35:7900:fcd:12a3:6181])
	by nt.romanrm.net (Postfix) with SMTP id 49F2C403F1;
	Fri,  3 Jan 2025 13:45:50 +0000 (UTC)
Date: Fri, 3 Jan 2025 18:45:49 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Victor Banon <banon.victor@gmail.com>
Cc: remi@georgianit.com, linux-btrfs@vger.kernel.org
Subject: Re: BTRFS errors following bad SATA connection
Message-ID: <20250103184549.78c383b0@nvm>
In-Reply-To: <032d71e6-954e-4fc6-bf43-18a6762d08b9@gmail.com>
References: <9443ea9c-08dc-4d08-81a6-cb91940e791e@gmail.com>
	<76294f4a-9e29-4d57-aff3-3fc5ca3ebf27@gmail.com>
	<f70c5a74-08c3-4eb7-bbde-723aff840b3d@app.fastmail.com>
	<a0dbac20-475c-4e40-84a6-8f0e9159ec8f@gmail.com>
	<20250102183329.35047254@nvm>
	<5c4c4b31-af93-475c-a130-8faa5c61cac1@gmail.com>
	<02affeaa-aafa-4225-94f6-bee621a9a4b6@gmail.com>
	<20250103170900.7016c4c4@nvm>
	<032d71e6-954e-4fc6-bf43-18a6762d08b9@gmail.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jan 2025 13:42:25 +0100
Victor Banon <banon.victor@gmail.com> wrote:

> Absolutely! But I'm a bit worried because I've already identified and 
> deleted thousands of files, and errors persisted, and new corrupted 
> files kept popping up. It's possible I've been doing it wrong, so I'll 
> give it a go.
> 
> How do I identify which 3900 files are mismatched so that I can delete 
> them?

One way that comes to mind:

find . -type f -not -exec cat "{}" > /dev/null \; -exec mv "{}" "{}.bad" \;

Then you just find or delete all files with the *.bad extension.

> > The problem is, it could be that the transid mismatch errors won't go away
> > even if you replace all the files, or you might not be able to do so. Attempt
> > to delete or otherwise manipulate some of them might fail with the same errors
> > in dmesg.
> So far I have had no issues deleting files, with the sole exception of 
> the file in the trash bin I mentioned above. I'm not sure what to do 
> about that one, apart from hoping it goes away if I fix everything else. 
> Do you have any advice?

If the trash bin would be in a subvolume, you could delete the subvolume. But
then that could put the FS into read-only again, and moreover, into a state
where it goes read-only each time shortly after mounting (as the cleaner
process tries to finish the job), with no way to solve that.

-- 
With respect,
Roman

