Return-Path: <linux-btrfs+bounces-19551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EADF9CAB0D0
	for <lists+linux-btrfs@lfdr.de>; Sun, 07 Dec 2025 04:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E67CF304639A
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Dec 2025 03:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAF327B357;
	Sun,  7 Dec 2025 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="BdmP2azz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CVg07fB1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84628269CE6
	for <linux-btrfs@vger.kernel.org>; Sun,  7 Dec 2025 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765077631; cv=none; b=dNtxDZWavFjBbrrbaAwTJiwhZq3sMeiGE6i61zIqLUSTZCKrOSG7ijQZ1vvQ5CMlTGNH7ih4iV3Tbi8KjDMMsc8oSOKdu3mKptQa9sRRH109qFAVJvFI3yJ2a/bCxyrmnoM8rTVn/xo3PnkUfOv761bI3KGqXYFblVzchoBuVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765077631; c=relaxed/simple;
	bh=anIZI55vvmOroIK7YsxITa63nb684+4B80jlRfMMKnQ=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JjH3Y2NFM1bmqTsmkkfPyrwwbFEUyVGURH55gn49eJRMYr6xQYiYAtnmIJyCAWiH5+ISrirX2gkW49/3pYL+6lIGn8tWZMAohNo4ouWNUnUJTdMOxdZLrlP+J6nm/UeKGh2qR0+Zw0pVWFsrAwC6mdJwQqlalcIbsZzMq1jRphc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=BdmP2azz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CVg07fB1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D23BEC008A;
	Sat,  6 Dec 2025 22:20:27 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Sat, 06 Dec 2025 22:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1765077627; x=1765164027; bh=jDnGo1H/IOCmRN8yBOOBj
	VFwCjinuIpX8XfB/dCimcM=; b=BdmP2azz3HdHKpLD00fT2VPrhmk3Feunl48Sq
	NoygXiRZ38yuD5hzFsgS+sKVl+ucCP26fBqHrf+kk91e79xY+TJmcaF2FaoHYa9o
	bAZekZk0s6DguM/cGV0Ujcgz/Hgs4LNSR/UcJjrM5y2C96VUSjH2mUnpjeRHMMZs
	TXp4W0KTjRP03jcPMvGq1jDFUhZ/WI61UegDtKd3ztp06u+5HCRmCMFp7meVM/KD
	S5NMn9i7pVcS8RC6F4LP+zjxd4xni7umAs5x/5qiQyKtiVOCEqUM0yuVtq9F4rQi
	MpuKu5bVh7wHgPiPrLUlPBjZJhRJLTE1TlFSvcMgQP0f7T5ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765077627; x=1765164027; bh=j
	DnGo1H/IOCmRN8yBOOBjVFwCjinuIpX8XfB/dCimcM=; b=CVg07fB1XL5bppOfb
	wOOcG3oBYzr1WYs6vG88gqgAxHkx1gjZ80Vfqk+j1jRcC1KvIff6icYQjsBAQVPm
	oft6VycvzE9ZM/kG2SYVdbAjqLpgP9uFjzBHToC0XGtPvOKa9dFILKdJDw/afN2r
	cdncwmbio9cRR8JyG6tjKztQpFs03Scnr89in5GS2rfjfTCMpt0p5gFFH51CjXL6
	46/q4rQOKrTP6E/q0QXZdjVnSywxxeptarR+Gz+yjAp4IQhj9sr7z9ZlXrcCTIkV
	tqFC6rvxv1vQT6rJtS3q6nsGOE0AY2e4UxQcL27jAvIePKFX3qq6O+/cgMF+Iruk
	6xKmw==
X-ME-Sender: <xms:e_I0aXwxTwezszsqGtCrRq6OG_yCDRA_u70lvhCJ8UqlV9Mt6FknTg>
    <xme:e_I0aaFNDEUTdM6Odw2ECCt3ywJVW_JVf3zkh-8d4-fLqOEnl0OpMmKHNNcAdfLXK
    wbcdsny7jkaOsOgPdPp9HfVsY8q3y1gChLsE1AplwSmvT7vdK2N7SM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhishcu
    ofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeetfeduheekheegkefhvdeghfejvdevuefhtdfgjefgveeiveei
    vdefvdfhvedvgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgtphht
    thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgtjhgvfhhfghhushes
    iihimhgrghgvrdgtohhm
X-ME-Proxy: <xmx:e_I0aafv-GC8wc0P7V7F1T6lKeq81rfGQLH87SCjhMxaHk6xzGFIzw>
    <xmx:e_I0aSJdHNmgJcq933eN4Uz90-jqDqshiGR8EEY_a5JUl1-TIJE37g>
    <xmx:e_I0aTGx3i0QR65YD1MggaYuiCGmA8cscaVyO7Xq-8YdBt5AXujcJg>
    <xmx:e_I0aUpjxw9KqrFJp210MPvKEJwY2G1aKBe7YWhYYJftlp-mt7LsHA>
    <xmx:e_I0aSjMKdstnoNBTi0h8q77HrQHTBW0ZMh_XVHkswyIx1wFu_Bp4iYo>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3B28F18C004E; Sat,  6 Dec 2025 22:20:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOREISIjUGws
Date: Sat, 06 Dec 2025 20:20:05 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Jeff Gustafson" <ncjeffgus@zimage.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <3b151c8a-d31f-439e-8631-309e636fd488@app.fastmail.com>
In-Reply-To: <a92b9d5be3ffa6fd88962c369ecc92472afb3cb0.camel@zimage.com>
References: <a92b9d5be3ffa6fd88962c369ecc92472afb3cb0.camel@zimage.com>
Subject: Re: Requesting guidance on no space left issue
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Nov 25, 2025, at 7:35 PM, Jeff Gustafson wrote:
> Hello,
> I've been on the btrfs IRC channel seeking advice for my issues getting
> the volume mounted again.
>
> I haven't had issues with my btrfs volume until now. It has been
> growing for years, until a couple of weeks ago. I didn't get ahead of
> the growth and the volume went into read only.

Looks like maybe more than one problem is going on, multiple devices with corrupt metadata, and at least one transid mistmatch. Both kernel and btrfs check have complaints.

I think you should mount -o ro,rescue=all, and extract any important data before you do anything else.

Note that you should embargo these files somehow because rescue=all includes `ignoredatacsums` therefore corrupt files are handed over to user space. Normal operation, corrupt data blocks result in EIO and the corrupt data never makes it to user space.

It's optional to do a read-only scrub while mounted read-only using 'btrfs scrub start -Bdr`  (I use tmux or screen when using -B since the command doesn't return until after the scrub completes). And then any corrupt data blocks will result in a path to file message in dmesg - at least this way you will have a pretty strong assurance whether any data you copy out while using rescue=all mount option needs to be treated with suspicion.


> I've been reluctant to run any rescue yet until I get some guidance. 

It's safe to use the rescue mount options since the fs is read only. And also btrfs restore is also read only but not nearly as straight forward as rescue mount option.

But it's best to not change anything with the file system (no writes) until there's advise from a developer or someone who knows more about what these messages mean.



-- 
Chris Murphy

