Return-Path: <linux-btrfs+bounces-18275-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1D1C05919
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63153B7DB6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 10:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44F330F94F;
	Fri, 24 Oct 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2xT8fdS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8930C36D
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301426; cv=none; b=CASLCOwiF9vccmGqk+IUqmqoX1dnI6UnZYRcimFb2HfMKM4ywgkfgV/PpRXAbvOtrnP1eNOmDzI/14lfceXZCEB/0QxZnzpm2MOEIGZGqadPPeXs/gkqq7y+9aA62Bq4hiB4v5OM1rHnkIms/lRtlv616zyzomIxiSjgccvkGPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301426; c=relaxed/simple;
	bh=EgK+kcfj+z1f7cW/gci4+KX2Dl6IQeAZ1As7DQcKk4s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MUj3OG5+3Tv4OftjcbxDnt5pkyZ/sPh95726tzy6F4mf1k2rl3FgPq/0Wt8py4HUKGxoldkjWuYzfAEoVf3ErcR54UYOhXNgvEQSPSae4tDNuJGCC5FGgNvkjnkLxClOE2mdnIcyQXUz004LFmdNZ+xrX5XiMXIaKOrDwcZRDQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2xT8fdS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761301424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dTfuG7mkwdAcHRX5d7idU5PTbdJ+nPsDJiTr0D0zK8s=;
	b=J2xT8fdSPNdBOpL/yUJo/LfWPUs+qCHLC7vM9oDj3+yF92tF8gXdjCxLHw9twsDS4q1gEu
	0JDxn/TJpsclWQF3wAxwHHyiJVU7PUlzs0fmmxwUTonUZraCGW9+vM1M2aNnGmCRPLwb4l
	hVq/3HSPk8YpIXziGfPQzmuwehP0D9s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-xMjsaOJWPMeaC3MMh3OPgw-1; Fri,
 24 Oct 2025 06:23:40 -0400
X-MC-Unique: xMjsaOJWPMeaC3MMh3OPgw-1
X-Mimecast-MFC-AGG-ID: xMjsaOJWPMeaC3MMh3OPgw_1761301418
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0EB25196F742;
	Fri, 24 Oct 2025 10:23:36 +0000 (UTC)
Received: from [10.44.32.37] (unknown [10.44.32.37])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57711195398C;
	Fri, 24 Oct 2025 10:23:29 +0000 (UTC)
Date: Fri, 24 Oct 2025 12:23:20 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Askar Safin <safinaskar@gmail.com>
cc: linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-block@vger.kernel.org, 
    linux-crypto@vger.kernel.org, linux-lvm@lists.linux.dev, 
    lvm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
    DellClientKernel <Dell.Client.Kernel@dell.com>, dm-devel@lists.linux.dev, 
    linux-btrfs@vger.kernel.org, Nhat Pham <nphamcs@gmail.com>, 
    Kairui Song <ryncsn@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
    =?ISO-8859-15?Q?Rodolfo_Garc=EDa_Pe=F1as?= <kix@kix.es>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Eric Biggers <ebiggers@kernel.org>, 
    Lennart Poettering <mzxreary@0pointer.de>, 
    Christian Brauner <brauner@kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Milan Broz <milan@mazyland.cz>
Subject: [PATCH] pm-hibernate: flush block device cache when hibernating
In-Reply-To: <4cd2d217-f97d-4923-b852-4f8746456704@mazyland.cz>
Message-ID: <03e58462-5045-e12f-9af6-be2aaf19f32c@redhat.com>
References: <20251023112920.133897-1-safinaskar@gmail.com> <4cd2d217-f97d-4923-b852-4f8746456704@mazyland.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On Fri, 24 Oct 2025, Askar Safin wrote:

> Hi.
> 
> Hibernate to swap located on dm-integrity doesn't work.
> Let me first describe why I need this, then I will describe a bug with steps
> to reproduce
> (and some speculation on cause of the bug).

Hi

Does this patch fix it?

Mikulas


From: Mikulas Patocka <mpatocka@redhat.com>

There was reported failure that hibernation doesn't work with 
dm-integrity. The reason for the failure is that the hibernation code 
doesn't issue the FLUSH bio - the data still sits in the dm-integrity 
cache and they are lost when poweroff happens.

This commit fixes the suspend code so that it issues flushes before 
writing the header and after writing the header.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Askar Safin <safinaskar@gmail.com>
Link: https://lore.kernel.org/dm-devel/a48a37e3-2c22-44fb-97a4-0e57dc20421a@gmail.com/T/
Cc: stable@vger.kernel.org

---
 kernel/power/swap.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/power/swap.c
===================================================================
--- linux-2.6.orig/kernel/power/swap.c	2025-10-13 21:42:48.000000000 +0200
+++ linux-2.6/kernel/power/swap.c	2025-10-24 12:01:32.000000000 +0200
@@ -320,8 +320,10 @@ static int mark_swapfiles(struct swap_ma
 		swsusp_header->flags = flags;
 		if (flags & SF_CRC32_MODE)
 			swsusp_header->crc32 = handle->crc32;
-		error = hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC,
+		error = hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH,
 				      swsusp_resume_block, swsusp_header);
+		if (!error)
+			error = blkdev_issue_flush(file_bdev(hib_resume_bdev_file));
 	} else {
 		pr_err("Swap header not found!\n");
 		error = -ENODEV;


