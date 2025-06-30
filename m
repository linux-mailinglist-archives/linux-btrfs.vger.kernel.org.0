Return-Path: <linux-btrfs+bounces-15127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B8AAEE5DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 19:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C311BC2015
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 17:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A07B2E54B3;
	Mon, 30 Jun 2025 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="iodWJX2m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92B293C61
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304649; cv=none; b=VVdNFA1hg2lbQSWus+xIFuFnUVqUXk9v/FNPu4aWZhKs3LrvM5AfvG/6dd+cTryDPueSK0vvnOwh8M/tAxOjg/Z/3trX8m/3Pm8msWKbX8T1lIhlcfaxdJ7bnTMgLNXCFAz+mrNk5qotZ2dOHRBOaYHwaGU2xJxJDQ3XbboR/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304649; c=relaxed/simple;
	bh=MdY9wGRGcr1+mgEILLo7g08KRxszKZO7m+nDRas9SQI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUjfxlCpeScKUhaJ8vzmBuk0rWI/8WL7LINw8Xs0Y7DWxNe+49wM+7CdsfiCrinkyP5JmWiLOJKYQqXuKVf5iOYdecfc7Qgd4e8A/33ChkCGFl5wZfGT+9vmiN09xGyIYoiMUtL6oyRFtWvQlrWMkxonH8T3rCkkFbTW9jSwEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=iodWJX2m; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id F196C60A1C
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 19:30:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1751304642; x=1753043443; bh=MdY9wGRGcr
	1+mgEILLo7g08KRxszKZO7m+nDRas9SQI=; b=iodWJX2mE+X5P0GG8S6ZFxrCWj
	Y4f36XeLAqrAHb7bSLFnQm+0jKnVZPDQhcA4daBlc7ocBM896VJhHRmqoRC5cD4g
	XzU41+H+2xm03gGPjoFsQfcKXY9SgwTlCUF4LPJP1WYP29yLLX6oet2rd4QmmkLz
	z10195xEc6VcyeDq6kW/WbfhkKTY66pvrn4X0dnwOvchtfLBMwx6r9Mz29RInwrK
	oyQp2a3LsczC285GwmipBeAoPXobQrnTqxKoGwW6W2d1WAT4dbvXCBBEcIvl8J+0
	M+dEwZa98TwvQjn734MjFlRDb31UYMEc4ypqOpGoum8Tx+pSY/xL4CGZs8jA==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id JS0UaOH-PKFU for <linux-btrfs@vger.kernel.org>;
 Mon, 30 Jun 2025 19:30:42 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 30 Jun 2025 19:30:41 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: restic backup with btrfs /
Message-ID: <20250630173041.GA1048979@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20250628173308.GB847325@tik.uni-stuttgart.de>
 <82b6ddab-0eef-47b8-8010-9b09fcb70444@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82b6ddab-0eef-47b8-8010-9b09fcb70444@harmstone.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Mon 2025-06-30 (11:07), Mark Harmstone wrote:
> On 28/06/2025 6.33 pm, Ulli Horlacher wrote:
> 
> > restic (https://restic.net/) is a great backup tool but has some
> > limitations or design flaws: one is, it believes that any subvolume is on a
> > different filesystem. This means: "restic backup --one-file-system /" will
> > only backup the root subvolume, but no other subvolumes like /home
> > /var/spool etc...
> 
> This is a bug in Restic that needs to be fixed

I have reported this already at the restic bug tracker, but the restic
developpers say, it is a btrfs problem and they will not fix it.


> > My idea is now: I do not backup the original /, but do:
> >
> > mount --bind / /backup/restic
> > restic backup /backup/restic
> > umount /backup/restic
> >
> > Next evolution step:
> > I could recursivly mount-bind other filesystems into /backup/restic/
> > For example:
> >
> > mount --bind /local /backup/restic/local
> > mount --bind /data /backup/restic/ldata
> 
> This is unlikely to work, as bind mounts will also be seen as different
> filesystems.

No problem here, because I will will use the option --one-file-system
See above.

"restic backup /" vs "restic backup /backup/restic" !
The first one includes EVERYTHING: /proc /nfs /mnt/tmp ...


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<82b6ddab-0eef-47b8-8010-9b09fcb70444@harmstone.com>

