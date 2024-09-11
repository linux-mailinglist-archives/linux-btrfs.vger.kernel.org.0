Return-Path: <linux-btrfs+bounces-7923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 786AE974BF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 10:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0025B24D63
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 08:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA88213C9C7;
	Wed, 11 Sep 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="ScbCBA9D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04EE13C8F9
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041624; cv=none; b=RIP09C1ZKeCHj5t5k2xLF4e2gC/GSVbrCpJAE2fwJD3DQYlx2apZL9/cuGt+qvaIer6efOo05mw1ToSEzzpgJWPCmUPu+ub+4uJDliD0PHMD1RYzLM1AyjhrMx/YfzLF2bM9TIEbnrT54GScG2pM46XZF8AMJIyMpfJ2EJvkXI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041624; c=relaxed/simple;
	bh=aG9TGV22DI/Fj2VDQMPDIid70+6OKJJVlWlw6OwRTKM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtYyow4cA9ODho/umKGlRqeblCj5xg99PSZWwAlI7wbduCtS2WPOIl0XOwOeJpM9wWA0PVLrft1+ZcL3iNObBE8ooXJSHioEn/7e/eXL0Jb/w1I3F9osOx/wdcQu+sf8suiElleaIUGnK71CD02Nm82FG1vJ42tA2LnAC1gIBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=ScbCBA9D; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 0E70561089
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 10:00:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1726041605; x=1727780406; bh=aG9TGV22DI
	/Fj2VDQMPDIid70+6OKJJVlWlw6OwRTKM=; b=ScbCBA9DkRsiiZJE4aVP7R0Oho
	+q8lxi93FRcTNukFh531dDRunfsg5HIKol8KLn4KIsmYD0+VpY+EAyKRib+qUBN9
	SSxr7DCn93F53+IEapiamCQwEy4nMS7a/3q4ZH1Wm6kjXrL56ymO04Ap1F4cU47/
	xchS41FsP9ASpc1dNAhImMTmujMpQfu4QJN+kADpH+mnF6pYoOwk05Vj7SwB06Lk
	+DHkr8WtkNQ/tkwiv8bgREjjvPRf4jwMBlQwYJlKtDBVelK2qjD0fkGFLsgU6k8T
	yMNXafiRpiTPi2ckxWxwiuOFI6mnO7Dg1oZL9lTg28WrpfR/jVLHzdDdvMUQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id GAUloJ7IQHnd for <linux-btrfs@vger.kernel.org>;
 Wed, 11 Sep 2024 10:00:05 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Wed, 11 Sep 2024 10:00:04 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: Btrfs balance broke filesystem
Message-ID: <20240911080004.GA218002@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <b9b86b32095ba924fb8c7eec4d8ec024113d9ff4.camel@beware.dropbear.id.au>
 <5fdb905b-20ee-4978-ba81-10b1fc4ac475@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fdb905b-20ee-4978-ba81-10b1fc4ac475@gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Sun 2024-09-01 (19:15), Qu Wenruo wrote:

> Convert/balance is only recommended if you have unallocated space (shown
> in `btrfs fi show`) to fulfill at least a metadata block group (1G in
> size for most cases).

How can I detect this "unallocated space"?
I have eg:

root@fex:# btrfs fi show /
Label: 'U22'  uuid: 3a37b060-8d05-402a-83b9-16690588a070
        Total devices 1 FS bytes used 11.91GiB
        devid    1 size 64.00GiB used 15.07GiB path /dev/sdd1


I am using btrfs-balance.sh, which came originally with SLES 14. I have
copied it to my Ubuntu systems, too.

In default configuration btrfs-balance.sh does a btrfs balance on all
mounted btrfs filesystems once a week via crontab.

See:

https://fex.rus.uni-stuttgart.de/fop/Gjo5Y0BX/btrfs-balance.sh

https://fex.rus.uni-stuttgart.de/fop/bKWs8Gx4/btrfsmaintenance

root@fex:# grep BALANCE /etc/default/btrfsmaintenance 
BTRFS_BALANCE_MOUNTPOINTS="$BTRFS_ALL"
BTRFS_BALANCE_PERIOD="weekly"
BTRFS_BALANCE_DUSAGE="1 5 10 20 30 40 50"
BTRFS_BALANCE_MUSAGE="1 5 10 20 30"

Should I disable it?

So far I have had no problems.


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<5fdb905b-20ee-4978-ba81-10b1fc4ac475@gmx.com>

