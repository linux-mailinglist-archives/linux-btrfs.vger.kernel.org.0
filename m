Return-Path: <linux-btrfs+bounces-10723-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC21DA0151B
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2025 14:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43C95188442B
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jan 2025 13:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AA61B4F14;
	Sat,  4 Jan 2025 13:57:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from nt.romanrm.net (nt.romanrm.net [185.213.174.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7502BCF5
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Jan 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.213.174.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735999064; cv=none; b=u/olg3kAQ5Rlb5HVSgdhN8EKlOiFMq8mSehvH1WYxbIngcugNg/duiNqGvdgGKxO6dHDJfI3AZVcwxyS7yi4VznsPgeAw1gGiGB1eE/YX7AVItzAfMr8Mk684lI1bg+/Aji1xV6ReXYZAWAocEBvB/qj8ufVN498wJat8+KysiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735999064; c=relaxed/simple;
	bh=KZSk8EBgEJZzHvpufyQOYnI4iIRsQQw4KNcOKjjvHl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vc1mgRmLeCBvGcZ3FyboQKDA17feJVmfEjPL7jUBbARadxZr32WGxByblTJYiXPfcr0W1bc/Ds3E3o0tWddoDRB5g1yWARVHT548xK0VlnZf4WLZdbhjiMkuhnAD9ERejKFPYEQhB5xyCPIykLZlrwb6EmIi+m02m0TiwRSXeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=185.213.174.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.2.romanrm.net [IPv6:fd39:a37d:999f:7e35:7900:fcd:12a3:6181])
	by nt.romanrm.net (Postfix) with SMTP id 9FFE1402E4;
	Sat,  4 Jan 2025 13:57:27 +0000 (UTC)
Date: Sat, 4 Jan 2025 18:57:27 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Victor Banon <banon.victor@gmail.com>
Cc: remi@georgianit.com, linux-btrfs@vger.kernel.org
Subject: Re: BTRFS errors following bad SATA connection
Message-ID: <20250104185727.56d9fbb6@nvm>
In-Reply-To: <70008910-2c6f-4fcd-ba36-68ff16992504@gmail.com>
References: <9443ea9c-08dc-4d08-81a6-cb91940e791e@gmail.com>
	<76294f4a-9e29-4d57-aff3-3fc5ca3ebf27@gmail.com>
	<f70c5a74-08c3-4eb7-bbde-723aff840b3d@app.fastmail.com>
	<a0dbac20-475c-4e40-84a6-8f0e9159ec8f@gmail.com>
	<20250102183329.35047254@nvm>
	<5c4c4b31-af93-475c-a130-8faa5c61cac1@gmail.com>
	<02affeaa-aafa-4225-94f6-bee621a9a4b6@gmail.com>
	<20250103170900.7016c4c4@nvm>
	<032d71e6-954e-4fc6-bf43-18a6762d08b9@gmail.com>
	<20250103184549.78c383b0@nvm>
	<2ff268f4-8565-45e1-b752-3ca85c736841@gmail.com>
	<20250104020426.3899f4c8@nvm>
	<70008910-2c6f-4fcd-ba36-68ff16992504@gmail.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jan 2025 22:24:19 +0100
Victor Banon <banon.victor@gmail.com> wrote:

> It just occurred to me that I might have a way to have enough space to 
> retrieve most of the un-backed up files. The 4th disk of the RAID was a 
> recent addition (that's probably when the SATA issues appeared), so I 
> have closer to 24 TB of data than 36 TB. So I'm thinking I may be able 
> to leverage up to 2 extra disks. Can I get your input on how dumb the 
> following ideas are:
> 
> A. Delete some files then shrink the array (4x12TB RAID5 aka 36 usable 
> TB -> 3x12 TB RAID5 aka 24 usable TB). Remove 1 drive, use it for extra 
> storage.
> 
> B. Degrade the array (4x12TB RAID5 aka 36 usable TB -> degraded 3x12 TB 
> RAID5 aka 36 usable TB). Remove 1 drive, use it for extra storage.
> 
> C. Do both (4x12TB RAID5 aka 36 usable TB -> degraded 2x12 TB RAID5 aka 
> 24 usable TB) . Remove 2 drives, use them for extra storage

If gaining 1 free drive is enough, I'd avoid reshaping and put it in degraded
(--fail, --remove in mdadm), so option B. I remember you said it was not super
important data anyway, and in this state you'd have like a RAID0 of 3
remaining drives, reliability-wise.

> It doesn't seem smart to do any of this while the array is in this 
> precarious state, but I feel like I don't have a whole lot to lose by 
> trying this-- even if it fails catastrophically, the alternative is to 
> do nothing and reformat anyway. But I'd like to have some idea of what 
> to expect before I do that... Is it even possible to shrink or degrade 
> the array?

You'd need to shrink the Btrfs first, and I am not sure if it would let you,
or run into the same transid errors as during other operations.

-- 
With respect,
Roman

