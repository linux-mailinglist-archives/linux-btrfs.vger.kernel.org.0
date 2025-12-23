Return-Path: <linux-btrfs+bounces-19985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3266CCD86A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 08:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E99B43017F29
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 07:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3234E3090EE;
	Tue, 23 Dec 2025 07:57:00 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from nt.romanrm.net (nt.romanrm.net [185.213.174.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA2C19C54E
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.213.174.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766476619; cv=none; b=HHld3I1HYZAOFiuebbztrqd2Vm+m29SNcAx2s1U2Wi+98Y8h2Tm93h1G0Y1PKZWSrSEf9WkaUMlChJg4u0rOiPbEHbEC6EsG6xTOjkRZMmSCnBJxiZ6AcGFdzXQPRctH5WfugSILwHpE7BVi1+EJ1/F6hK7cQZ1USGXiYLFzefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766476619; c=relaxed/simple;
	bh=mh5GYixBp6s0JbqWlPBh7Ho/PKp2/ALD7/lrcMFuxBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdIRd6jEy4l1WDau1Wxxd8svDH04lxVMkiJgh7ipAjJYaC14HKPSGt2Um3VTNov0S7eNX5dLRBAggNqFVJfXtvGRFVyPzxnX0N3Fmjdej9U12ly7LSMDTbPNT2xBuUnPh+4CzlOH4/EN133xu+Lf9d+d3l7Bpo8ItEQI1lZbS8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=185.213.174.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from nvm (umi.0.romanrm.net [IPv6:fd39:ade8:5a17:b555:7900:fcd:12a3:6181])
	by nt.romanrm.net (Postfix) with SMTP id 005A740F5E;
	Tue, 23 Dec 2025 07:56:47 +0000 (UTC)
Date: Tue, 23 Dec 2025 12:56:47 +0500
From: Roman Mamedov <rm@romanrm.net>
To: BP25 <bp25@posteo.net>
Cc: Linux btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Snapshots of individual files
Message-ID: <20251223125647.6626b266@nvm>
In-Reply-To: <79ae6c26545c107010719ee389947c1c@posteo.net>
References: <79ae6c26545c107010719ee389947c1c@posteo.net>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Dec 2025 00:43:25 +0000
BP25 <bp25@posteo.net> wrote:

> Hello,
> Can any of you guys help me understand why it hasn't been made possible 
> to snapshot individual files? Because technically it's trivial to 
> implement therefore I suspect there must be some abstract reason... The 
> only thing I can think of is the case where some file which was 
> snapshotted is then deleted hence there is no way to 'select such file' 
> and ask btrfs for the snapshotted versions... but even in this case I 
> see no problem: either the convention is that when you delete a file 
> then all snapshots of such individual file are also deleted, or better 
> there is a command that shows all files who have been deleted but have 
> have been snapshotted in the past.
> Any ideas?
> Please CC or BCC me cause I'm not subscribed.

You can make "snapshots" of a file with:

  cp -a --reflink filename filename.snap

from what I tested this appears to be atomic (entire file is reflinked at
once), someone might correct me if I'm wrong.

Works on modern XFS too.

-- 
With respect,
Roman

