Return-Path: <linux-btrfs+bounces-22276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M+9Hm8TrGkujwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22276-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Mar 2026 13:00:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC69F22BA34
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Mar 2026 13:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C8E4302D53C
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Mar 2026 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741A62FE05C;
	Sat,  7 Mar 2026 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="uTl2QVEB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A90C2836E
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Mar 2026 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772884837; cv=none; b=RWOdNrGRTPEUn3i8WEKhICcjX7bKUlyX5zhFA9Y85uArWwUWZTtrlmMBt3CvwN7ZdARXqPYi8t1bd9e/cCxGv0mokTcnChEzoSHBDe3vgSeWkVMl3V+H5vdlb8fJ+dt5hWO0u2YJ9tkvl12F2zHvTALpZjdn88zYH0vrPU86JPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772884837; c=relaxed/simple;
	bh=D9VJ2ti0pNR4HYiYrnXnlrSrWQH7bfnn/vp8X6oUOCQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc8IotmT8/gucXan+3pX+mpdb1QuQk/wR9UaaQel/CCoxbtDvOfQsAy1B7ZYp4b4a5DXrtc/u4R++WjeKLnLd1YjyAzMutGsjYYfxrA9K/BqjEVcTgUSeGH4+ZVNxYxyiOXKM5aSbzTA5eoZuFrJl54VRm/aI33iGjsaK4wT9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=uTl2QVEB; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 9EF86611CE
	for <linux-btrfs@vger.kernel.org>; Sat, 07 Mar 2026 12:54:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=user-agent:in-reply-to:content-disposition:content-type
	:content-type:mime-version:references:message-id:subject:subject
	:from:from:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=
	1772884477; x=1774623278; bh=D9VJ2ti0pNR4HYiYrnXnlrSrWQH7bfnn/vp
	8X6oUOCQ=; b=uTl2QVEBGVwCKjCYc2O5UJTFSLbe/zy9pk5EAGo6Vb3IMQ2b6yc
	gUc/ckn694pX7m6az+m8eO+dJMerw5GTQfdNnX87pBUF2P6mKuZ+GWYRsPicynox
	JJC4NVIhgckW8WL1VtHqLLJKaZH2iMvzN8YbkJRBDeD2+nr4wDI60XjUVYzvL2X9
	OucJQJwpzo6GtXIVsadnXpFXleoxUhwEfyZvfveodU2lEh8zckQj7GOYrT7XiJCw
	j2zbKC4XtcEizRAZno9oxo9A+YlQwFQl2P9bd8m0FDkfHUzpP1I2oiqVP6ccZN9v
	l9JHQN0OrGCFVSyKAotY6tAke8Nu4K5s/GQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id 4jdIcX1oZr2m for <linux-btrfs@vger.kernel.org>;
 Sat,  7 Mar 2026 12:54:37 +0100 (CET)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Sat, 7 Mar 2026 12:54:37 +0100
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: workaround for buggy GNU df
Message-ID: <20260307115437.GA796190@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20240621065709.GA598391@tik.uni-stuttgart.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621065709.GA598391@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Rspamd-Queue-Id: DC69F22BA34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[uni-stuttgart.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22276-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[uni-stuttgart.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[uni-stuttgart.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[framstag@rus.uni-stuttgart.de,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,belwue.de:url,fex:email]
X-Rspamd-Action: no action

On Fri 2024-06-21 (08:57), Ulli Horlacher wrote:
> 
> The GNU tool df does not work correctly on btrfs, example:
> 
> root@fex:/test/test/test# df -T phoon.png
> Filesystem     Type 1K-blocks     Used Available Use% Mounted on
> -              -     67107840 16458828  47946692  26% /test/test
> 
> root@fex:/test/test/test# grep /test /proc/mounts || echo nope
> nope
> 
> The mountpoint is wrong, the kernel knows the truth.
> 
> Therefore I have written fst:
> 
> root@fex:/test/test/test# fst phoon.png
> path:       /test/test/test/phoon.png
> mountpoint: /
> subvolume:  /test/test
> volume:     /dev/sdd1
> filesystem: btrfs
> 
> 
> https://fex.belwue.de/linuxtools/index.html#fst

I have now extended fst to fstat :

framstag@fex:/local/test/.snapshot/.latest/test: fstat zz
      File: "zz"
 Directory: /local/test/.snapshot/2025-09-05_1917.test/test
      Size: 40 B
Allocation: 4 kB
      Type: regular file
      Mode: rw-r--r--
       UID: root
       GID: root
    Device: /dev/sde1
   FS-Type: btrfs
Mountpoint: /local (rw)
 Subvolume: /local/test/.snapshot/2025-09-05_1917.test (ro)
     Inode: 5107
     Links: 1
    Access: 2025-06-18 10:22:51
    Modify: 2024-05-20 02:02:08
    Change: 2024-06-03 10:58:22
     Birth: 2024-06-03 10:58:22

fstat also shows the btrfs subvolume and its rw/ro status.


framstag@fex:/local/test/.snapshot/.latest/test: df --version
df (GNU coreutils) 9.4

framstag@fex:/local/test/.snapshot/.latest/test: df -T .
Filesystem     Type  1K-blocks     Used Available Use% Mounted on
-              -    1073740800 82884012 989711428   8% /local/test/.snapshot/2025-09-05_1917.test

framstag@fex:/local/test/.snapshot/.latest/test: grep /local /proc/mounts
/dev/sde1 /local btrfs rw,relatime,space_cache,user_subvol_rm_allowed,subvolid=5,subvol=/ 0 0

==> df cannot handle btrfs!


https://fex.belwue.de/fstools/fstat.html

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20240621065709.GA598391@tik.uni-stuttgart.de>

