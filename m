Return-Path: <linux-btrfs+bounces-15070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A49AED1AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 00:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD69163FC6
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 22:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3343423F40A;
	Sun, 29 Jun 2025 22:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="bgimZJLW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD13B7A8
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Jun 2025 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751237455; cv=none; b=Cl4G2aXYG0+v7Xnsa/125UqShaAn3Sj++BOPUS5GUYDViDykj70al3T6U4Fo0lp3nzkv1jUMOlKpkk/sMnfUaihrzQBcjEMrheMva3pQTvm3l/1FVa0X2yQdAq7oJKmlTDzmV+2vmzCRrwVGGcjjPDTw0DGDPDIW+tRmLsHDXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751237455; c=relaxed/simple;
	bh=vTVMerAyqtkC0kuo5wyVf93wLJxp3UIu9aDoioIjPzo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0ZdjZGdN2iukGMbEHJ+n5z11Wej4NFJYnFQEuve9HrRIRLflGaTERxHDnlyF9J+FatnGXqrzZX3LBIOX0DRuZHWpeUA4XM37Z19k6M7PxcJ73HvrsyfZStWxpma23nAO213dfMrojnv0XFWwBemVCPhkJaXzdE3gxrZK9+H4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=bgimZJLW; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id BFA1A60B37
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 00:50:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1751237441; x=1752976242; bh=vTVMerAyqt
	kC0kuo5wyVf93wLJxp3UIu9aDoioIjPzo=; b=bgimZJLWiX2RBtw15q3uJiaU9a
	6kazxh7h8fOuj9nUKfN2qIxvkZEYDlmTpt4RXFlU+qg/svqbKBSGJUEsItdY90vG
	sENd0dsfTp6X0nrLxPoJ/8g5SoeboYXpVJparggqEj92qg1JinGwRtfEvVSSvnxe
	p9SkP780QUWGtpgDxgAgc0YPLM1KF8hFdSzIpg4yGoHmmJoIeVnGVR5tZQy+lX4h
	8GQA8Id7qv3k+Wl69vkCMuZhNf0YxmfqN90HbQZSe9a3fDaXkDUMG2tUDM3Ng63w
	fjxcWBhZc1C9BCVKAS91f2+vD0nI3wX2I/EuYc1GZvHnOvrs7+2kD2OWtlMg==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id t87IzMJilI94 for <linux-btrfs@vger.kernel.org>;
 Mon, 30 Jun 2025 00:50:41 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 30 Jun 2025 00:50:41 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: using snapshot for backup: best practise?
Message-ID: <20250629225041.GA967706@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20250626114345.GA615977@tik.uni-stuttgart.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626114345.GA615977@tik.uni-stuttgart.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Thu 2025-06-26 (13:43), Ulli Horlacher wrote:

> Using snapshots seems a better idea for backups :-)
> 
> But snapshots do not include subvolumes.
> 
> When I run the command:
> 
> btrfs subvolume snapshot / /.snapshot/_
> 
> the snapshot will contain only the root subvolume.

Mewanwhile I have written some (more) tools to handle nested subvolumes
and snapshots.

Example:

root@fex:~# btrfs_list /local/test
ACCESS-MODE SUBVOLUME <- SNAPSHOT-PARENT
rw /local/test
rw /local/test/sv1
rw /local/test/sv1/sv1_1
rw /local/test/sv1/sv1_1/ss <- /local/test/sv1/sv1_1
rw /local/test/sv1/sv1_2
rw /local/test/sv2

root@fex:~# btrfs_rsnapshot /local/test
Create a snapshot of '/local/test' in '/local/test/.snapshot/test'
Create a snapshot of '/local/test/sv1' in '/local/test/.snapshot/test/sv1'
Create a snapshot of '/local/test/sv1/sv1_1' in '/local/test/.snapshot/test/sv1/sv1_1'
Create a snapshot of '/local/test/sv1/sv1_1/ss' in '/local/test/.snapshot/test/sv1/sv1_1/ss'
Create a snapshot of '/local/test/sv1/sv1_2' in '/local/test/.snapshot/test/sv1/sv1_2'
Create a snapshot of '/local/test/sv2' in '/local/test/.snapshot/test/sv2'

root@fex:~# btrfs_list /local/test
ACCESS-MODE SUBVOLUME <- SNAPSHOT-PARENT
rw /local/test
ro /local/test/.snapshot/test <- /local/test
ro /local/test/.snapshot/test/sv1 <- /local/test/sv1
ro /local/test/.snapshot/test/sv1/sv1_1 <- /local/test/sv1/sv1_1
ro /local/test/.snapshot/test/sv1/sv1_1/ss <- /local/test/sv1/sv1_1/ss
ro /local/test/.snapshot/test/sv1/sv1_2 <- /local/test/sv1/sv1_2
ro /local/test/.snapshot/test/sv2 <- /local/test/sv2
rw /local/test/sv1
rw /local/test/sv1/sv1_1
rw /local/test/sv1/sv1_1/ss <- /local/test/sv1/sv1_1
rw /local/test/sv1/sv1_2
rw /local/test/sv2

root@fex:~# btrfs_rsnapshot -d /local/test
Delete subvolume (no-commit): '/local/test/.snapshot/test/sv2'
Delete subvolume (no-commit): '/local/test/.snapshot/test/sv1/sv1_2'
Delete subvolume (no-commit): '/local/test/.snapshot/test/sv1/sv1_1/ss'
Delete subvolume (no-commit): '/local/test/.snapshot/test/sv1/sv1_1'
Delete subvolume (no-commit): '/local/test/.snapshot/test/sv1'
Delete subvolume (no-commit): '/local/test/.snapshot/test'

root@fex:~# btrfs_list /local/test
ACCESS-MODE SUBVOLUME <- SNAPSHOT-PARENT
rw /local/test
rw /local/test/sv1
rw /local/test/sv1/sv1_1
rw /local/test/sv1/sv1_1/ss <- /local/test/sv1/sv1_1
rw /local/test/sv1/sv1_2
rw /local/test/sv2


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20250626114345.GA615977@tik.uni-stuttgart.de>

