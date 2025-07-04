Return-Path: <linux-btrfs+bounces-15258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C54AF8EDC
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 11:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FA556060A
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BE92E9EAB;
	Fri,  4 Jul 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="EDyDg+PG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB5328A71E
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Jul 2025 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621963; cv=none; b=eoGFlBDCeWZk7U+3/trV+7vp3hfH5xVHkRZH3kJADqpSKFaYto90cBXoLgpVDJUd82aqhsgqfRxOPAfz3I1QyrhYfF6yMGnxQoa4zZRm7JcM2YFFEtBwBi+rB5LtQDyD/ozDflZPUh4xJD14wm+hLCOaMWHnnfg7sAunUXnT14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621963; c=relaxed/simple;
	bh=kZsfPG0ZY3wunHF2DFduez6kwCfspGHEBN9Jo2i6u2g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5ym4vZbd7T3Pwxy/Yp4dA4veBTvvvFQAISCJUajMSs9k1lZ+0ZrYeAwilqNSSyvaE2Gy8pLuJPJyx4RhPCg9KRTjjcynCzFVnMDDloYrIqhyHl02qwH1f+1o/1Lk97PnJ1OKCdMTnQ5NvCFyJyE0tet9KxHiSc1joqxofvpUuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=EDyDg+PG; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 9A72F60C0C
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Jul 2025 11:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1751621947; x=1753360748; bh=kZsfPG0ZY3
	wunHF2DFduez6kwCfspGHEBN9Jo2i6u2g=; b=EDyDg+PG6Ap4TCJGO0ISFDRndT
	kb45K8QfKs/sBCKx6WdFSp4uLAjdUh1Lcxr30hqGXR3fbpCQxfJ4cVhUfxdZbD/j
	37zIgXA329hJpFZcAf9kTtGht47Hz46eb48F0Ogj841mxpcjlRLwHk3WHbFA1zmd
	gw189efrXwR05cyMmTzUktx0C8FKqmIwiQhanUoc5hWCE9dGNRdWd7R7jhjVOBwT
	scYX6q7w+VZqxNYx3nDVtpoPkBDUtHDsBH/L36HP4iZNFIP/sAM8KAT5Q9bT0L5u
	3Z8fKnzIH6eroxrbZwDSAkMFgUIQFVkibgua7uer4scMvobdrfW4eUvO8AJQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id K6xejwGqka3b for <linux-btrfs@vger.kernel.org>;
 Fri,  4 Jul 2025 11:39:07 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Fri, 4 Jul 2025 11:39:07 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: restic backup with btrfs /
Message-ID: <20250704093907.GA215813@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20250628173308.GB847325@tik.uni-stuttgart.de>
 <d882ddfe-b0a2-4b1f-ac28-145652ace126@render-wahnsinn.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d882ddfe-b0a2-4b1f-ac28-145652ace126@render-wahnsinn.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Thu 2025-07-03 (10:00), Robert Krig wrote:

> Why don't you just create a backup script, where you create a list of
> subvolumes dynamically and then back those up, rather than hardcode
> specific subvolumes?

Indeed, this is my plan :-)
I have used "harcoded subvolumes" only as a simple example to demonstrate
my idea.


> I would use btrfs tools to get a list of subvolumes and their paths,

With standard btrfs commands this is not easy, but I have already written
btrfs_list which does this job:

root@fex:~# btrfs_list /local/test
ACCESS-MODE SUBVOLUME <- SNAPSHOT-PARENT
rw /local/test
ro /local/test/.snapshot/2025-06-29_1414.test <- /local/test
ro /local/test/.snapshot/2025-06-29_1416.test <- /local/test
ro /local/test/.snapshot/2025-06-29_1418.test <- /local/test
rw /local/test/sv1
rw /local/test/sv1/sv1_1
rw /local/test/sv1/sv1_1/ss <- /local/test/sv1/sv1_1
rw /local/test/sv1/sv1_2
rw /local/test/sv2


> create snapshots and mount them in a similar directory tree and point
> restic at the snapshot and backup up from there.

In this case ".snapshot" is in the restic path, which I do not like.
Therefore I will use mount --bind ...

Meanwhile I have written btrfs_rsnapshot to create and delete snapshots of
nested subvolumes recursivly. Example:

root@fex:~# btrfs_rsnapshot /local
Create a snapshot of '/local' in '/local/.snapshot/_local'
Create a snapshot of '/local/home' in '/local/.snapshot/_local/home'
Create a snapshot of '/local/home/framstag/blubb' in '/local/.snapshot/_local/home/framstag/blubb'
Create a snapshot of '/local/home/smc/test' in '/local/.snapshot/_local/home/smc/test'
Create a snapshot of '/local/test' in '/local/.snapshot/_local/test'
Create a snapshot of '/local/test/sv1' in '/local/.snapshot/_local/test/sv1'
Create a snapshot of '/local/test/sv1/sv1_1' in '/local/.snapshot/_local/test/sv1/sv1_1'
Create a snapshot of '/local/test/sv1/sv1_1/ss' in '/local/.snapshot/_local/test/sv1/sv1_1/ss'
Create a snapshot of '/local/test/sv1/sv1_2' in '/local/.snapshot/_local/test/sv1/sv1_2'
Create a snapshot of '/local/test/sv2' in '/local/.snapshot/_local/test/sv2'
Create a snapshot of '/local/tmp/test' in '/local/.snapshot/_local/tmp/test'

root@fex:~# btrfs_rsnapshot -d /local
Delete subvolume (no-commit): '/local/.snapshot/_local/tmp/test'
Delete subvolume (no-commit): '/local/.snapshot/_local/test/sv2'
Delete subvolume (no-commit): '/local/.snapshot/_local/test/sv1/sv1_2'
Delete subvolume (no-commit): '/local/.snapshot/_local/test/sv1/sv1_1/ss'
Delete subvolume (no-commit): '/local/.snapshot/_local/test/sv1/sv1_1'
Delete subvolume (no-commit): '/local/.snapshot/_local/test/sv1'
Delete subvolume (no-commit): '/local/.snapshot/_local/test'
Delete subvolume (no-commit): '/local/.snapshot/_local/home/smc/test'
Delete subvolume (no-commit): '/local/.snapshot/_local/home/framstag/blubb'
Delete subvolume (no-commit): '/local/.snapshot/_local/home'
Delete subvolume (no-commit): '/local/.snapshot/_local'


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<d882ddfe-b0a2-4b1f-ac28-145652ace126@render-wahnsinn.de>

