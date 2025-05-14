Return-Path: <linux-btrfs+bounces-14007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8DBAB6A50
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 13:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CC11B652D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 11:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCFB2777ED;
	Wed, 14 May 2025 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUbizagv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC252749FD
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222721; cv=none; b=klZuS9T7sv7cP+unDVSyefyjQH/QqD5Ayto5pSEvyQIqwvkf9197T1Oeq7OtQSbIRy2bWR5rQ93pg8hMe1pBEsqZ9h+vMa5OV6NRBBIkIzla7cDVnbm0k0doDFBlWR63+Qyq+MWIJKZudjBHOUAhTzesS6rjm7oY82qi1k5clCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222721; c=relaxed/simple;
	bh=BVDUP4pzATkYlaKsPLAF0u3ETPu6KtcY4IpVFvVkyFg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VTA3/ABBdIHB6yKSb0PZIZ3kFNyXsKXjb8PSmzyssc9/O9YpRdtaKeA8vTKpb0bhK0ksqkGqa77tThBU07Jjrv3WGn6ItnUDwJjQ+IOWDCF5wk5BQiDyLocYBSLrsvLc0cymnizZubYtdppwBvpe7diN/Y6L6neeQulZw8Q1iac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUbizagv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE4FC4CEE9
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 11:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747222721;
	bh=BVDUP4pzATkYlaKsPLAF0u3ETPu6KtcY4IpVFvVkyFg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tUbizagv5a4G+Y4ZONV6osSjFJr+jGcthTAPZGsP/BXU+ZoeAtPl4QAZEa1jMTu3s
	 9mRprPrv8OjLiFkdgewrM+b+asDdYMX3ke3t80SeuSzG0nw9jlCumfFlqed2x/cpzo
	 4YEd0ulOplURiJNrJz2wpfCFnWLRH8oehTUs251ms6fjQ9SR5x/6FE4ovOtaqeKSoO
	 pwL+RPQAuCYQVfeeTtSC+XpNNwxAkRzrZOsXkPcBal6MzX7/5E9bbIBmJkNdeSe6vB
	 Z5uL+nRRhEIQBr8Bg/RDRrVzlNJfMETLkwbzXgDQ8ttV9bhOwXa+Teu4W5wa0ebrcc
	 kMk8qaDPLe+Iw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/5] btrfs: fix wrong start offset for delalloc space release during mmap write
Date: Wed, 14 May 2025 12:38:33 +0100
Message-Id: <21e10da9d0408e818957f0c18956fcae7fbcdd74.1747222631.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747222631.git.fdmanana@suse.com>
References: <cover.1747222631.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we're doing a mmap write against a folio that has i_size somewhere in
the middle and we have multiple sectors in the folio, we may have to
release excess space previously reserved, for the range going from the
rounded up (to sector size) i_size to the folio's end offset. We are
calculating the right amount to release and passing it to
btrfs_delalloc_release_space(), but we are passing the wrong start offset
of that range - we're passing the folio's start offset instead of the
end offset, plus 1, of the range for which we keep the reservation. This
may result in releasing more space then we should and eventually trigger
an underflow of the data space_info's bytes_may_use counter.

So fix this by passing the start offset as 'end + 1' instead of
'page_start' to btrfs_delalloc_release_space().

Fixes: d0b7da88f640 ("Btrfs: btrfs_page_mkwrite: Reserve space in sectorsized units")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 660a73b6af90..32aad1b02b01 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1918,7 +1918,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		if (reserved_space < fsize) {
 			end = page_start + reserved_space - 1;
 			btrfs_delalloc_release_space(BTRFS_I(inode),
-					data_reserved, page_start,
+					data_reserved, end + 1,
 					fsize - reserved_space, true);
 		}
 	}
-- 
2.47.2


