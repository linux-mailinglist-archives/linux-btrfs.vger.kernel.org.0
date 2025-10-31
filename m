Return-Path: <linux-btrfs+bounces-18477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55550C26C5F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 20:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90461A22771
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 19:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FB02F1FF1;
	Fri, 31 Oct 2025 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxOox6bg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B82F1FC7
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939216; cv=none; b=lWPo0G3sTauMG4zqWEOhD5hkaVZkOpks2LF39jlnZju10KpkR3FFilzoEz8tQsQ7LLw9uCiNj3syIZgG1xPA7sL7NTddNsKoFfQoNdrLOCTRtTEBdOgGT54q93zy65CB8UhqvGsafqFX01YqtYYdBF7fnUlj5kUiRY1RFJkqCVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939216; c=relaxed/simple;
	bh=QNL0UH3E+r0b3k8V+qcD0myYYTx/rQY7w6DVMtD8AYo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aq1NhxaU4efjXxbD33m1zub37YvNFbSCxyZDloQSLaEke0IbHD9rPkKzVAdCzaDN9vl3QIuTktkDBT0ykNSsMujaQBFWgOSgPbZ8ZY7a5MT2JrPN7luOBtbvESTKIVurzThYwN33izcaazgFwNin4QrIl+9zAVX4FX35RZrtyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxOox6bg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761939213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aX/UYGyfT3leoZk+snX0p7Zlv8DRsK4nDYm1uUOo7Pc=;
	b=HxOox6bgKqACMoQ4GheKT28ssEoMg6nMvg1we08moxRAEN2YgVRrBIKbbiWjpPbGkTZNGM
	NmA6RLoh9Y042Sj7qo6EKsx4CX7LvaOhVNqcJz0bP+8PG/KEsV2N8ymtxLK8smnlIh1P3Q
	qj2vWTdp4+N9Y1iKb2r0LJVemMChkrk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-F_Jq7KkVMGSxVN2YOi909g-1; Fri,
 31 Oct 2025 15:33:22 -0400
X-MC-Unique: F_Jq7KkVMGSxVN2YOi909g-1
X-Mimecast-MFC-AGG-ID: F_Jq7KkVMGSxVN2YOi909g_1761939195
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE8CA18001E2;
	Fri, 31 Oct 2025 19:33:12 +0000 (UTC)
Received: from [10.45.225.163] (unknown [10.45.225.163])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE1A51800591;
	Fri, 31 Oct 2025 19:33:05 +0000 (UTC)
Date: Fri, 31 Oct 2025 20:33:03 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Askar Safin <safinaskar@gmail.com>
cc: Dell.Client.Kernel@dell.com, brauner@kernel.org, dm-devel@lists.linux.dev, 
    ebiggers@kernel.org, kix@kix.es, linux-block@vger.kernel.org, 
    linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org, 
    linux-lvm@lists.linux.dev, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
    linux-raid@vger.kernel.org, lvm-devel@lists.linux.dev, agk@redhat.com, 
    msnitzer@redhat.com, milan@mazyland.cz, mzxreary@0pointer.de, 
    nphamcs@gmail.com, pavel@ucw.cz, rafael@kernel.org, ryncsn@gmail.com, 
    torvalds@linux-foundation.org
Subject: [PATCH 1/2] pm-hibernate: flush disk cache when suspending
In-Reply-To: <de1f0036-84f9-2923-2c0a-620e702d850b@redhat.com>
Message-ID: <c44942f2-cf4d-04c2-908f-d16e2e60aae2@redhat.com>
References: <03e58462-5045-e12f-9af6-be2aaf19f32c@redhat.com> <20251027084220.2064289-1-safinaskar@gmail.com> <de1f0036-84f9-2923-2c0a-620e702d850b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

[PATCH 1/2] pm-hibernate: flush disk cache when suspending

There was reported failure that suspend doesn't work with dm-integrity.
The reason for the failure is that the suspend code doesn't issue the
FLUSH bio - the data still sits in the dm-integrity cache and they are
lost when poweroff happens.

This commit fixes the suspend code so that it issues flushes before
writing the header and after writing the header.

Note that the system may lose power during suspend - in this situation,
we don't want to attempt to resume with invalid data. So, we flush the
cache before writing the header (with REQ_PREFLUSH) and after writing the
header (with REQ_FUA).

The call to flush_swap_writer was moved up in swap_writer_finish, so that
it writes the data before mark_swapfiles writes the header.

REQ_FUA is also needed on resume, when marking resumed image with the
original swap header.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Askar Safin <safinaskar@gmail.com>
Link: https://lore.kernel.org/dm-devel/a48a37e3-2c22-44fb-97a4-0e57dc20421a@gmail.com/T/

---
 kernel/power/swap.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6/kernel/power/swap.c
===================================================================
--- linux-2.6.orig/kernel/power/swap.c
+++ linux-2.6/kernel/power/swap.c
@@ -320,7 +320,7 @@ static int mark_swapfiles(struct swap_ma
 		swsusp_header->flags = flags;
 		if (flags & SF_CRC32_MODE)
 			swsusp_header->crc32 = handle->crc32;
-		error = hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC,
+		error = hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH | REQ_FUA,
 				      swsusp_resume_block, swsusp_header);
 	} else {
 		pr_err("Swap header not found!\n");
@@ -486,11 +486,12 @@ static int flush_swap_writer(struct swap
 static int swap_writer_finish(struct swap_map_handle *handle,
 		unsigned int flags, int error)
 {
+	if (!error)
+		error = flush_swap_writer(handle);
 	if (!error) {
 		pr_info("S");
 		error = mark_swapfiles(handle, flags);
 		pr_cont("|\n");
-		flush_swap_writer(handle);
 	}
 
 	if (error)
@@ -1587,7 +1588,7 @@ int swsusp_check(bool exclusive)
 			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
 			swsusp_header_flags = swsusp_header->flags;
 			/* Reset swap signature now */
-			error = hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC,
+			error = hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC | REQ_FUA,
 						swsusp_resume_block,
 						swsusp_header);
 		} else {
@@ -1641,7 +1642,7 @@ int swsusp_unmark(void)
 	hib_submit_io_sync(REQ_OP_READ, swsusp_resume_block, swsusp_header);
 	if (!memcmp(HIBERNATE_SIG,swsusp_header->sig, 10)) {
 		memcpy(swsusp_header->sig,swsusp_header->orig_sig, 10);
-		error = hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC,
+		error = hib_submit_io_sync(REQ_OP_WRITE | REQ_SYNC | REQ_FUA,
 					swsusp_resume_block,
 					swsusp_header);
 	} else {


