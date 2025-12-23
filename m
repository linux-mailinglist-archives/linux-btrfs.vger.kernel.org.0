Return-Path: <linux-btrfs+bounces-19989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED34CD8C9D
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 11:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E970301B813
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7273612F7;
	Tue, 23 Dec 2025 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="VhrmHOBz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDEC17A303
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485574; cv=none; b=UV04xDlrlQrprNV6ut9+vEGLwO0z3SWGgep1ZTJ7P7A3ri7ZZALt9po/5FvtQSPoI3UzKu/FwpuaRtx53p3R8eKaeOWif4g6uxTOfTit2Fkz4nGIsGUF7rAAujESaO56U5BWVVmVdoSZ14Cj9lF4oDr2KgP+IYp6xkD6PBBOn9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485574; c=relaxed/simple;
	bh=aK3vU1zZKyx2t2edps5bSn3kA5Ka3+RFrY11loNDCjc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=JwVs4QN/cwUeGSfjdAqaMxIMmFpq7aipgGph9LaU4m+Ar8b0WHDaohEUc0c91Y8BW29TPTIOSnIIw/X5qtFtNjCJHc8P5N4tr7L67zbbZSLOQfKMLkkPwpZtGRhQRA1byCPPL6ydpBDGehRL7Ud+Ecdzz+lAs0vPzrl2VTAAObQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=VhrmHOBz; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4FA27240101
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 11:26:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1766485570; bh=+0Ht2DDlEnK+uuTsZxIAAxrABisnM11a87lgexq4Fd0=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=VhrmHOBzYwHvDMJ6t37X8HIZbrXsRsdPu7oeNji+JYvfLzfQK4hITy/4R7bQcKntM
	 Xwnt3YyGtTmrhwhXsBbH1XzCACdT9TPgUu6FJLJ1BFVSLyUqB2KxKPFscLeGfOTuZK
	 8vQFSxBr23eS5mPhWMA1bqyOTdNJZmaMHCpEMp6C27EaW09ED6zaOnmvJOOfDQUraX
	 ZV6loZv2jFVVZNZ16wxVhA6KcdXy4CUEPuoR2OLfe4lteYdor4sEENB9I58CjLoO7W
	 RGfm8TKQFUs8ZXqfyzVAZsHmKWS3DLvmmYCq3AEIAisW+Nkw1KdFgG8Risd99lAEx2
	 KhNTa+vanYXfA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dbB4K6FW7z9rxS;
	Tue, 23 Dec 2025 11:26:09 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Dec 2025 10:26:10 +0000
From: BP25 <bp25@posteo.net>
To: Roman Mamedov <rm@romanrm.net>
Cc: Linux btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Snapshots of individual files
In-Reply-To: <20251223125647.6626b266@nvm>
References: <79ae6c26545c107010719ee389947c1c@posteo.net>
 <20251223125647.6626b266@nvm>
Message-ID: <1403c713e107106e18e000d7b0f81eaf@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Dear Roman,
Thanks for your informative answer. But this is precisely the wrong 
solution: btrfs snapshots shouldn't and in fact don't clutter the 
filesystem with previous versions of the files because such ghost 
versions materialise when the snapshot is mounted. In my original 
message I seek for the analogous behaviour. Also I don't want to 
generate more and more copies...

On 23.12.2025 08:56, Roman Mamedov wrote:
> On Tue, 23 Dec 2025 00:43:25 +0000 wrote:
> 
>> Hello,
>> Can any of you guys help me understand why it hasn't been made 
>> possible
>> to snapshot individual files? Because technically it's trivial to
>> implement therefore I suspect there must be some abstract reason... 
>> The
>> only thing I can think of is the case where some file which was
>> snapshotted is then deleted hence there is no way to 'select such 
>> file'
>> and ask btrfs for the snapshotted versions... but even in this case I
>> see no problem: either the convention is that when you delete a file
>> then all snapshots of such individual file are also deleted, or better
>> there is a command that shows all files who have been deleted but have
>> have been snapshotted in the past.
>> Any ideas?
>> Please CC or BCC me cause I'm not subscribed.
> 
> You can make "snapshots" of a file with:
> 
>   cp -a --reflink filename filename.snap
> 
> from what I tested this appears to be atomic (entire file is reflinked 
> at
> once), someone might correct me if I'm wrong.
> 
> Works on modern XFS too.


