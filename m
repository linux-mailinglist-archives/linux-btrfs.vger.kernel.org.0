Return-Path: <linux-btrfs+bounces-10716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E81A00F3D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 22:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C567A21C3
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 21:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A791BD9E4;
	Fri,  3 Jan 2025 21:04:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from nt.romanrm.net (nt.romanrm.net [185.213.174.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382311CA0
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.213.174.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938276; cv=none; b=ZYepTJgYRK3LO6T+E5Obo8yhhPI9Z3nA+wFi8/cMK/j1cDm5tC9b7qUzetgYYVK8tWtYQ1ovuBtabcziWZA3d00YsdhPTIl7gUmSagEh/6rA5vzgC2rHpK8ZSOXQol61UCh9nsXpk4P6riLYkf76I9ezuZMiE+cJV845YT+PS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938276; c=relaxed/simple;
	bh=gLteac21uSB0fjdBzvBfL7QTGg5x1XVJCTcPUFCZox4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzhfC9VIWwIdQl03T+p/az2mVlwVXLW2CDYplv5TXVoVYxp3R7eH+RJCh+gzJebMJmRgWH42xUdHKPmh9yt3cDDVyPf6D1y+Bc7iViBfYzKxegS79f5Jf1us5DPbCAxjv/QrJpZL5bY4tZecZCaezHoSUUsTjKp1DP+wrcDTfVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=185.213.174.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.2.romanrm.net [IPv6:fd39:a37d:999f:7e35:7900:fcd:12a3:6181])
	by nt.romanrm.net (Postfix) with SMTP id D131D40EE3;
	Fri,  3 Jan 2025 21:04:27 +0000 (UTC)
Date: Sat, 4 Jan 2025 02:04:26 +0500
From: Roman Mamedov <rm@romanrm.net>
To: Victor Banon <banon.victor@gmail.com>
Cc: remi@georgianit.com, linux-btrfs@vger.kernel.org
Subject: Re: BTRFS errors following bad SATA connection
Message-ID: <20250104020426.3899f4c8@nvm>
In-Reply-To: <2ff268f4-8565-45e1-b752-3ca85c736841@gmail.com>
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
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jan 2025 19:47:59 +0100
Victor Banon <banon.victor@gmail.com> wrote:

> My optimism was short-lived. I can't make meaningful progress deleting 
> the files because the filesystem keeps going read-only (see attached 
> log) soon after initiating a scan. This wasn't a problem before. I'm not 
> sure what the standard procedure for bypassing this (rw remount after 
> error is not allowed), so I've just been rebooting when this happens.

You mean a scan as suggested previously, trying to rename unreadable files to
"bad", or just a read-only pass too? It is probably way too broken after all,
so you might as well start planning backup+recreate.

> I'm also noticing that some files that resulted in i/o errors (when 
> being cat'd to /dev/null) yesterday are fine today. And the other way 
> around too: there seemingly are files that were fine yesterday but are 
> bad today.

Not sure what to make of it, if you had mdadm raid1 underneath, this could
have been explained by differing mirror contents, and the randomness of which
one is used for reads today. With RAID5 data can differ when read from data
disks to when reconstructed from parity, but in a clean array there shouldn't
be any reconstruct reads.

> Thank you for the information. What does this mean in practice? Do I 
> just ignore this file forever?

In a remote possibility if you could figure out all the other corruptions,
delete/replace all the affected files, and the only thing remaining would be a
small undeletable file somewhere, moving the containing directory away
somewhere and ignoring it for the time being could have been an option. But it
appears you are still a long way from that and might not reach that stage at
all.

> What about the corrupted files that are /not/ in my trash bin, can I never
> restore them either?

I believe you should be able to move or rename the directory they are in
freely (such as the trash bin itself), or at least one which is another level
above from that.

-- 
With respect,
Roman

