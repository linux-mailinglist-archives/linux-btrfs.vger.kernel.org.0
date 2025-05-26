Return-Path: <linux-btrfs+bounces-14236-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C91AC395B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 07:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858033A6FC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 05:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7741C54A2;
	Mon, 26 May 2025 05:40:50 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out198-178.us.a.mail.aliyun.com (out198-178.us.a.mail.aliyun.com [47.90.198.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0552A282F5
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748238050; cv=none; b=SsOR5A0SI5h24Ni74dmjHFxREgTgxMTfSuWTJPy365yG0XUx21FQnlwnc+99PKfpbkQO/3qmlZ0V0kwIgNanP08HU+jgg/DZ+Dcvo/T8IocLJmo3+k9EIdj9wRGgxI78QhH9eRoZ5xKl3afqwvgCCsOUeE9+taD9RlXi2+s/OWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748238050; c=relaxed/simple;
	bh=mlERa1fVMAo1pIDISl7hTJESu3hDbRlJZkQnFF270BM=;
	h=Date:From:To:Subject:Cc:Message-Id:MIME-Version:Content-Type; b=kr3b3YWiMdV2BP0YmKyYEbgx+wTLiHK72Xk1Kt5KtAGoC+NbTfcXVNSvRQsqXt2kbm/HVq/sjTLNM2zU4RcsTTdDeqfOf7C8LdgARjHLfT35NIZRhpglwJk+23ukfGP6bGh2OtFQeav77UDJikJSK+DLTy6KTL9Vj+zxofR60TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.d.M7jPv_1748238026 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 26 May 2025 13:40:27 +0800
Date: Mon, 26 May 2025 13:40:28 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-btrfs@vger.kernel.org
Subject: 6.1.140 build failure(fs/btrfs/discard.c:247:5: error: implicit declaration of function 'ASSERT')
Cc: Filipe Manana <fdmanana@suse.com>
Message-Id: <20250526134027.187C.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.08 [en]

Hi,
Cc: Filipe Manana

I noticed 6.1.140 build failure(fs/btrfs/discard.c:247:5: error: implicit declaration of function 'ASSERT')

fs/btrfs/discard.c: In function 'peek_discard_list':
fs/btrfs/discard.c:247:5: error: implicit declaration of function 'ASSERT'; did you mean 'IS_ERR'? [-Werror=implicit-function-declaration]
     ASSERT(block_group->discard_index !=
     ^~~~~~
     IS_ERR

It seems realted to the patch(btrfs-fix-discard-worker-infinite-loop-after-disabling-discard.patch).

I walked around it with the following patch.

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 98bce18..9ffe5c4 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -7,6 +7,7 @@
 #include <linux/math64.h>
 #include <linux/sizes.h>
 #include <linux/workqueue.h>
+#include "messages.h"
 #include "ctree.h"
 #include "block-group.h"
 #include "discard.h"


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/05/26



