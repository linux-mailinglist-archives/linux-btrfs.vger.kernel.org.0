Return-Path: <linux-btrfs+bounces-4925-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD588C3860
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 22:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C225B1C20E5C
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 20:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652402E3F2;
	Sun, 12 May 2024 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="vE44QZ2Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F915380
	for <linux-btrfs@vger.kernel.org>; Sun, 12 May 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715546873; cv=none; b=SVT7Pznird1XWMoCMlPVb25subWK3C8sMpOMB0/6jHr1gbMW8wA/JYdbnG2XNXwCqzEmYJXFHpxp6rK90tYsywbUuSeRxqud4x/JxN1OUr92L8GungHLf1+mB42TpmvqXwyyaBixX3jhw8iaxbwI0KSWS/7DLN1dg67rOUDa6FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715546873; c=relaxed/simple;
	bh=zE+zH8tLgISmnq5xo6neaMdOlOyM9S5L9Qg+cdk+Mx0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nq846zRc69LplAkoyBL02WydPSuM1nuhpRP5fkZYCrd0VRbYaxyvaDmAGF1gDnsAomu2UHgtFRn8ZaxoJD5Q22j/wFEHiSstwlN72gA8Np+ijAc8k17aFwvy0Cv1UwQIM7Ka9EFaMkmqM0qc9/AHzQouWNy32PIV9cBHfEpbY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=vE44QZ2Z; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id DD89060BC6
	for <linux-btrfs@vger.kernel.org>; Sun, 12 May 2024 22:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1715546361; x=
	1717285162; bh=zE+zH8tLgISmnq5xo6neaMdOlOyM9S5L9Qg+cdk+Mx0=; b=v
	E44QZ2Zwy3pDvyntpkVNJWeD8y/xXjJfA8nxOSIDGHmcY9V33nAcODJW4Rv5Ebd4
	JMppZgeLX5uxLjOcnW11fRpgelPqN/BqCsXpnapjG5ls5WwikYb5OVw0MzsBWGnI
	rhFv7tEtGXqjk3TNX4Re12Mgp1Sr1xhe02M1yCVvMIskvvhvGHRBxLe+kIgGG6o7
	buAuqC2rm8ulK3oAWAYIVtz2ZNJjWqghxb1opZ0STtDUfgrkipJIytpovdY5ycmQ
	EvgVpwlRD3BruXAhtMde/5ZXZOWr5nOihBt9iOfhwBuVsRN+GLma27Js+XtLp/Lt
	UI7YYryWfrhKmLVTbeO2g==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id FkunUvqndK2t for <linux-btrfs@vger.kernel.org>;
 Sun, 12 May 2024 22:39:21 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Sun, 12 May 2024 22:39:21 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: snapshots of subvolumes recursivly?
Message-ID: <20240512203921.GA83909@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20230822


I have asked a similar question 2019-07-05, but maybe meanwhile there is a
solution...

I want to backup btrfs filesystems with IBM Spectrum Protect and restic,
both are file based.

Copying files which are in write-open state will lead to file corruption.
Therefore my idea is: create a snapshot and run the backup on the snapshot.

The problem now is: some of the btrfs filesystems have subvolumes and
even sub-subvolumes. 

When I create a snapshot it does not contain subvolumes. Example:

root@fex:/local/test# btrfs subvolume list .
ID 350 gen 6075947 top level 5 path home
ID 62530 gen 6075904 top level 5 path test
ID 62531 gen 6075894 top level 62530 path sv1
ID 62532 gen 6075895 top level 62530 path sv2
ID 62533 gen 6075894 top level 62531 path sv1/sv1_1
ID 62534 gen 6075894 top level 62531 path sv1/sv1_2

root@fex:/local/test# ll -R
drwxr-xr-x  root     root                       - 2024-05-12 20:42:02  sv1
drwxr-xr-x  root     root                       - 2024-05-12 20:42:10  sv1/sv1_1
-rw-r--r--  root     root                      20 2024-05-12 20:42:10  sv1/sv1_1/zz
drwxr-xr-x  root     root                       - 2024-05-12 20:42:17  sv1/sv1_2
-rw-r--r--  root     root                      20 2024-05-12 20:42:17  sv1/sv1_2/zz
-rw-r--r--  root     root                      20 2024-05-12 20:42:02  sv1/zz
drwxr-xr-x  root     root                       - 2024-05-12 20:42:25  sv2
-rw-r--r--  root     root                      20 2024-05-12 20:42:25  sv2/zz
-rw-r--r--  root     root                      20 2024-05-12 20:40:58  zz

root@fex:/local/test# btrfs sub snap . backup
Create a snapshot of '.' in './backup'

root@fex:/local/test# ll -R backup
drwxr-xr-x  root     root                       - 2024-05-12 20:40:58  backup
drwxr-xr-x  root     root                       - 2024-05-12 20:47:58  backup/sv1
drwxr-xr-x  root     root                       - 2024-05-12 20:47:58  backup/sv2
-rw-r--r--  root     root                      20 2024-05-12 20:40:58  backup/zz

root@fex:/local/test# btrfs subvolume list .
ID 350 gen 6075947 top level 5 path home
ID 62530 gen 6075904 top level 5 path test
ID 62531 gen 6075894 top level 62530 path sv1
ID 62532 gen 6075895 top level 62530 path sv2
ID 62533 gen 6075894 top level 62531 path sv1/sv1_1
ID 62534 gen 6075894 top level 62531 path sv1/sv1_2
ID 62535 gen 6075903 top level 62530 path backup

As you see: the snapshot /local/test/backup does not contain the sv*
subvolumes, only empty directories backup/sv1 backup/sv2

I could write a script which creates snapshots of the subvolumes
(recursivly), but maybe there is already such a program?
Or another solution for this problem?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20240512203921.GA83909@tik.uni-stuttgart.de>

