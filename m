Return-Path: <linux-btrfs+bounces-15291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5646AFB51C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 15:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB40F1AA5D0F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652432BDC19;
	Mon,  7 Jul 2025 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="JYd/cWQG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138C02BE035
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751895976; cv=none; b=qvmINWbtg4SGxjsNg6f7XBRW+qJUZQirxiuF9p/uY1tx3EPNCyETajmCiuoLPXuFrmgdPTUBzbvb6qrqaGVrQrIle+F2Std7S5QBFyPKcCdHCv4e8GcAw4OJLZLNfgrPCvg6hWnB6O28m07PmfMtx4qHox5tCtcWdl5K8ixiKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751895976; c=relaxed/simple;
	bh=hL3uorr2pxsmAQr3SGuHUPHUY7SgN8WZ688L2kjBmzw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOTS2W79qTf7BXStdWykIT2rd0qTMifSEJYRaq8XjYOmDXvvFRWp8DD2sUJU7kH2C9pRoDFre2wj3FtYDlcWUAYYCohz2B7jHT/3fKHkuwkr+abSsIWfhGjZh7TbJyoe1bdxDI79jGi0bUlkDYzaPBt1VEEeU+brL6fxwh1rRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=JYd/cWQG; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 3D5E460CAA
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 15:46:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1751895961; x=1753634762; bh=hL3uorr2px
	smAQr3SGuHUPHUY7SgN8WZ688L2kjBmzw=; b=JYd/cWQGPf8KvF9RE+A4r6x/3Z
	D9N33HT8xbrFGaxWR883Khl8LB1neherMhNdBML1u2klpWwwyFyVcx5nK0z6MW2a
	R4XXw9jJaCp7K3KVG5j19HcGkTjcFbj/7ii9rC8vEvpHtAav4lBuB0QLVt5AJ2RX
	cj9sI1D7jYu7gVK6p5yUVx+R177BomUYSwqI++8hzXr9fApRTanZVbifQApP6Bqw
	Py+gDxNRsKEAqxz6DX/7/kMJjg1slr1IPk8yfnmzbUnMGIWWVowpyBNRBzDiqv0t
	PK763+nEbSpE/BjEAqgMi/rZazIPCBo7q3n+UYm2AnxZuhWfYTyI8ktzFvjA==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id Hd1gDDIGikvj for <linux-btrfs@vger.kernel.org>;
 Mon,  7 Jul 2025 15:46:01 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 7 Jul 2025 15:46:01 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: restic backup with btrfs /
Message-ID: <20250707134601.GA538398@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20250628173308.GB847325@tik.uni-stuttgart.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628173308.GB847325@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Sat 2025-06-28 (19:33), Ulli Horlacher wrote:

> My idea is now: I do not backup the original /, but do:
> 
> mount --bind / /backup/restic
> restic backup /backup/restic
> umount /backup/restic
> 
> Next evolution step: 
> I could recursivly mount-bind other filesystems into /backup/restic/
> For example:
> 
> mount --bind /local /backup/restic/local
> mount --bind /data /backup/restic/ldata
> 
> That I would have a "all in one backup".

Meanwhile I haved implemented it and also use of (temporary) snapshots!
Instead of /backup/restic I am using /__ (just another name).

restix-backup does:

- create recursive snapshots of all rw subvolumes
- bind-mount the toplevel snapshots on /__
- run restic backup on /__
- umount everything below /__
- delete all temporary snapshots

Example (I have typed only the first line, all other lines are output): 

root@fex:~# restix-backup -s //

# btrfs_rsnapshot -w /
Create a snapshot of '/' in '/.snapshot/_'
Create a snapshot of '/test' in '/.snapshot/_/test'
Create a snapshot of '/tmp' in '/.snapshot/_/tmp'

# mount --bind /.snapshot/_ /__

# btrfs_rsnapshot -w /local
Create a snapshot of '/local' in '/local/.snapshot/_'
Create a snapshot of '/local/home' in '/local/.snapshot/_/home'
Create a snapshot of '/local/home/framstag/blubb' in '/local/.snapshot/_/home/framstag/blubb'
Create a snapshot of '/local/home/smc/test' in '/local/.snapshot/_/home/smc/test'
Create a snapshot of '/local/test' in '/local/.snapshot/_/test'
Create a snapshot of '/local/test/sv1' in '/local/.snapshot/_/test/sv1'
Create a snapshot of '/local/test/sv1/sv1_1' in '/local/.snapshot/_/test/sv1/sv1_1'
Create a snapshot of '/local/test/sv1/sv1_1/ss' in '/local/.snapshot/_/test/sv1/sv1_1/ss'
Create a snapshot of '/local/test/sv1/sv1_2' in '/local/.snapshot/_/test/sv1/sv1_2'
Create a snapshot of '/local/test/sv2' in '/local/.snapshot/_/test/sv2'
Create a snapshot of '/local/tmp/test' in '/local/.snapshot/_/tmp/test'

# mount --bind /local/.snapshot/_ /__/local

# cd /

# findattr __ > __/.chattr

# restic backup -v -e /tmp -e /backup -e .cache -e .del -e tmp/\* -e \*.tmp -H fex --tag __ __
RESTIC_ENV=/root/.restic/s3tik.env
SG_TENANT=fex
RESTIC_REPOSITORY=s3:s3.tik.uni-stuttgart.de/fex.restic

# /opt/s3tik/restic backup -v -e /tmp -e /backup -e .cache -e .del -e 'tmp/*' -e '*.tmp' -H fex --tag __ __
open repository
repository 13e662d4 opened (version 2, compression level auto)
using parent snapshot 20b48e38
load index files
[0:02] 100.00%  36 / 36 index files loaded
start scan on [__]
start backup on [__]
scan finished in 4.728s: 254436 files, 46.446 GiB

Files:           1 new,   105 changed, 254330 unmodified
Dirs:            2 new, 18860 changed,  2765 unmodified
Data Blobs:     37 new
Tree Blobs:    168 new
Added to the repository: 35.310 MiB (7.926 MiB stored)

processed 254436 files, 46.446 GiB in 0:32
snapshot 1624348b saved

# restic unlock
SG_TENANT=fex
RESTIC_REPOSITORY=s3:s3.tik.uni-stuttgart.de/fex.restic

# /opt/s3tik/restic unlock

# umount /__//local

# btrfs_rsnapshot -d /local
Delete subvolume (no-commit): '/local/.snapshot/_/tmp/test'
Delete subvolume (no-commit): '/local/.snapshot/_/test/sv2'
Delete subvolume (no-commit): '/local/.snapshot/_/test/sv1/sv1_2'
Delete subvolume (no-commit): '/local/.snapshot/_/test/sv1/sv1_1/ss'
Delete subvolume (no-commit): '/local/.snapshot/_/test/sv1/sv1_1'
Delete subvolume (no-commit): '/local/.snapshot/_/test/sv1'
Delete subvolume (no-commit): '/local/.snapshot/_/test'
Delete subvolume (no-commit): '/local/.snapshot/_/home/smc/test'
Delete subvolume (no-commit): '/local/.snapshot/_/home/framstag/blubb'
Delete subvolume (no-commit): '/local/.snapshot/_/home'
Delete subvolume (no-commit): '/local/.snapshot/_'

# umount /__//

# btrfs_rsnapshot -d /
Delete subvolume (no-commit): '/.snapshot/_/tmp'
Delete subvolume (no-commit): '/.snapshot/_/test'
Delete subvolume (no-commit): '/.snapshot/_'

# restic forget --prune --tag __ --host fex --keep-daily 7 --keep-weekly 4
SG_TENANT=fex
RESTIC_REPOSITORY=s3:s3.tik.uni-stuttgart.de/fex.restic

# /opt/s3tik/restic forget --prune --tag __ --host fex --keep-daily 7 --keep-weekly 4
Applying Policy: keep 7 daily, 4 weekly snapshots
keep 2 snapshots:
ID        Time                 Host        Tags        Reasons                 Paths  Size
------------------------------------------------------------------------------------------------
20b48e38  2025-07-07 13:53:14  fex         __          oldest daily snapshot   /__    46.446 GiB
                                                       oldest weekly snapshot
1624348b  2025-07-07 14:05:42  fex         __          daily snapshot          /__    46.446 GiB
                                                       weekly snapshot
------------------------------------------------------------------------------------------------
2 snapshots


# restic check
SG_TENANT=fex
RESTIC_REPOSITORY=s3:s3.tik.uni-stuttgart.de/fex.restic

# /opt/s3tik/restic check
using temporary cache in /tmp/root/restic-check-cache-988330367
create exclusive lock for repository
load indexes
check all packs
check snapshots, trees and blobs
[0:12] 100.00%  35 / 35 snapshots
no errors were found


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20250628173308.GB847325@tik.uni-stuttgart.de>

