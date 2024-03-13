Return-Path: <linux-btrfs+bounces-3259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E4F87AFF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 19:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D528BE98
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 18:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154384A33;
	Wed, 13 Mar 2024 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="PsC8qfKv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E668E63410
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 17:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350909; cv=none; b=RpUQfZSNR0mbFSIZ+8Yz+2j/kNs/uLu6gcviY8eF4N9hsI/ZTo6wXJXHAbePmHdrsBLfScPFqCti1IV5yTRUqqOa7Bc3ngbFqyzgYBX8rYD8BEJZW+J0iGBaxcoJ5K1HH5tvAr5Z2RGeL3ya3RsmmmCP6JZt6Q5KmSZYy1n8dAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350909; c=relaxed/simple;
	bh=06Noxf5EIYXk0dje/xJdxPZMIIIkMvf+PbQD/GFD7PU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmuamlJpCmN8plzD7AGEnOCZKV52qBSTUPmGvxhfOH5aNEkbEK+ncJlSbXoyd8RCvlvgGK2AxDmu0xIOA4fgtbc9wJv+IB0jcaHK8l97s1Yxq2CfOkOWbtHFksiHoqV+K0J91YuO+roqcxNXu5LXmJIkHWti8TULsL87qJETRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=PsC8qfKv; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id D79B760B45
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Mar 2024 18:28:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1710350890; x=1712089691; bh=06Noxf5EIY
	Xk0dje/xJdxPZMIIIkMvf+PbQD/GFD7PU=; b=PsC8qfKvytgQRhhZMs+UHPqgO4
	2t7IsJi6IWOHYKxbKDmBKROmYDr48nkaRRHdnu/rggzZ9KHF79SCn+jyfc1cyXSL
	fCgdfYQRsMCg71NzogVXvHXbvN70uRVzQdCxcVO+EL7bc9e2dv1hsEBSR75gWZYS
	bk1sT4HEDVYJKlctjSYY9iyh90cg1+TWeaelMokZdAFOZZ5DhUvI33zI5xNCtNx4
	xK0zwLYncL0kMjh7JsNVgqLIr4SOsWRUcoHQZyU/eFIXRy2PTOaYodT4m5nBIOw3
	EHMBOzPlw/zSMFv7hFhmq3UkXZ9PwQlZYwIhr0zVP1voeC+LLj/bFUwMNhZg==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id UbSjIqOyGHRN for <linux-btrfs@vger.kernel.org>;
 Wed, 13 Mar 2024 18:28:10 +0100 (CET)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Wed, 13 Mar 2024 18:28:10 +0100
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: mount ... or other error?
Message-ID: <20240313172810.GA394502@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20240312103918.GA374710@tik.uni-stuttgart.de>
 <CAA91j0XZGSA1oNTDZXm_PRTjnaFcYbf5F+gXTSJ9kCivPuZ1gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA91j0XZGSA1oNTDZXm_PRTjnaFcYbf5F+gXTSJ9kCivPuZ1gQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20230822

On Tue 2024-03-12 (15:24), Andrei Borzenkov wrote:

> dmesg output would be useful.

root@fextest:~# dmesg | tail
[110309.184692] BTRFS: device label spool devid 1 transid 15334 /dev/sdd1 scanned by mount (5281)
[110309.190879] BTRFS info (device sdd1): using crc32c (crc32c-intel) checksum algorithm
[110309.190886] BTRFS info (device sdd1): disk space caching is enabled
[110309.190886] BTRFS info (device sdd1): has skinny extents
[110309.196830] BTRFS error (device sdd1): devid 3 uuid 24b0f302-ada1-41fe-8aec-0b353b592046 is missing
[110309.196834] BTRFS error (device sdd1): failed to read the system array: -2
[110309.196940] BTRFS error (device sdd1): open_ctree failed

Ahhh.. I have an idea:

root@fextest:~# lshd sdd
Device    Size Type      Label               Mountpoint
sdd     13824G SCSI:GPT  "NETAPP_LUN_C-Mode"
 sdd1   13824G btrfs     "spool"

This is probably an iSCSI device which was part of a RAID0 btrfs
filesystem and has been retired some years ago.

My storage admin gave me on my request a "new LUN" which is indeed this
old retired LUN. Some meta data like filesystem id and label are still
there but I cannot mount it anymore, because the second part of the RAID0
is missing.

Could this be an explanation?

I do not need the data any longer, I just want to know what happend.

Addon question:

Why does the mount command not also display the error messages from dmesg? 
Or at least say something like "for more information, call dmesg"?



-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<CAA91j0XZGSA1oNTDZXm_PRTjnaFcYbf5F+gXTSJ9kCivPuZ1gQ@mail.gmail.com>

