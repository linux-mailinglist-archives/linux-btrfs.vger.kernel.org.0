Return-Path: <linux-btrfs+bounces-15695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3A1B13103
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 19:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6543A175C1C
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8A3221704;
	Sun, 27 Jul 2025 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="gPPln7S8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1126C1E260A
	for <linux-btrfs@vger.kernel.org>; Sun, 27 Jul 2025 17:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753638988; cv=none; b=ZyNNOA4rfUisDGKO2c3m/tsmPxZOEyA5BmZET/mVGGrURQX2UrtVmi7R6bMk/pawR/uFtBdoILXy9c5geKG1ItlfDvf9ojhT6fCCfUEFFRcJljwXObcPuKdHitz943EBCeCK3eT8odHDOBT1KjXM6pBd58k+3E+AyGjs25oZOL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753638988; c=relaxed/simple;
	bh=ZbM0a2MDbngldYq1ovj44uxR0CCjjR9q+mfPgIQ9R7w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kT2Tn4BXhemGeP3izkklA2wkgu5f5Kg8k5l+5aF4zG56vwi+13AVLj954n10dalcTx+/b83BbVkV2InRj3x9DbSg6QJ7QZeJx5o28jC9gHnPErS1RLV/mOBVSjr7pU3s1qDbdzjj5NKbqVWXvhIIj0L9MqZt8BjEye1neLD7l0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=gPPln7S8; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 3420460A29
	for <linux-btrfs@vger.kernel.org>; Sun, 27 Jul 2025 19:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1753638378; x=
	1755377179; bh=ZbM0a2MDbngldYq1ovj44uxR0CCjjR9q+mfPgIQ9R7w=; b=g
	PPln7S82aUDce+4+kIFx9O1g1pxvaIePWxnXqwu8mxSyV1ssMhP5cEo1Or0muIi+
	GZBHmqd5+AmNdc7mMRU1QI/4dp4UaAtN0y80XGdUiVZ2qDdQhJbPtumCqXsVAja+
	TQGGQwuXEfzVERSqlfTvTb2jOtLkuJOSXYaAUZIucBxw5rFyL1GYc/8uOhKyBjyA
	Wyve2sxhhTU5nFYyjEfDJhfsHF/UXapGG0Fdwz6Lj2sqhIjcKji5O/pd6syH6XN3
	G8zocvOFFGv0RUDtBU+zJ/BqJZes9WUvg9YawduFUkxZrP4mtUeznXYlJLdZBlSk
	BD/KYnW/hdl78+DJVosCQ==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id r6J_CfuIQe5T for <linux-btrfs@vger.kernel.org>;
 Sun, 27 Jul 2025 19:46:18 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Sun, 27 Jul 2025 19:46:18 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: cannot read default subvolume id?
Message-ID: <20250727174618.GD842273@tik.uni-stuttgart.de>
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
X-Mailer: smtpsend-20240729


Why is there a "cannot read default subvolume id"?

tux@quak:~: btrfs sub create xx
Create subvolume './xx'

tux@quak:~: btrfs sub del xx
WARNING: cannot read default subvolume id: Operation not permitted
Delete subvolume 292 (no-commit): '/home/tux/xx'

tux@quak:~: df -H .
Filesystem                   Size  Used Avail Use% Mounted on
/dev/mapper/nvme0n1p5_crypt  2,0T   64G  1,9T   4% /home

tux@quak:~: mount | grep /home
/dev/mapper/nvme0n1p5_crypt on /home type btrfs (rw,relatime,ssd,discard=async,space_cache=v2,user_subvol_rm_allowed,subvolid=257,subvol=/@home)

tux@quak:~: btrfs version
btrfs-progs v6.6.3

tux@quak:~: uname -a
Linux quak 6.14.0-24-generic #24~24.04.3-Ubuntu SMP PREEMPT_DYNAMIC Mon Jul  7 16:39:17 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20250727174618.GD842273@tik.uni-stuttgart.de>

