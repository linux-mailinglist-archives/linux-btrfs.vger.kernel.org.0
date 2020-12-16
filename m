Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5022DC42B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgLPQ2Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgLPQ2Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:24 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1445BC0611CD
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:18 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z3so17577156qtw.9
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o1a/i2ebfj7XryAaYFFfCcSOcCjKuzkVEMBMoJ5ESD8=;
        b=WA96J8ZPIWDVsQYRymZqh2avDdyUeCX7XAoZmcrkOlcoi09q58tIfddj38loWwWgzY
         XboInPm2fntYyKDy8g/w6bLtA3+zXT1JvBL3O1gPjdSX94FO41vTEn/eLYegVw14oCy6
         dnJH43xOqg60V8CB3Tk5NPwsEgTv8Exk6E6VoEP3/HA/zQXd8AyfMStCLf+GQRj0eSwQ
         SsZyIR0z7EvQyW+Ul6poohUxWu5P1mzbKW/h8cqjSMYE7/SgW9zUamnYjOTADef+mTuc
         18gxGgL8zuxw0tzL+De4R/nrxQveqeptsWT/D9B5F5iqSGgb65DwhsyEOiNahk+/4ZIN
         TfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o1a/i2ebfj7XryAaYFFfCcSOcCjKuzkVEMBMoJ5ESD8=;
        b=eYWpGKuWSn0Vqd3+MSFTuRv7lOGvSW4SpWa/2byz4SXzUITOKjy5lqstzQw9wWWp2a
         jrQ/DRDYoVCGDzcWwpZVijsBFLcVHUU83NTlsJALs67pGNb6OAr4hZFOy/OdgoXT5Mp+
         m7KYAQnenVZTVKvsKxkltk/4+ImmW1IxGNvIFWnysJalaGxRQc0oUBXQ9aKLGF+j+BW7
         DA58bFuKuZC4tRDi1hQtDUcmjaFDSyAEbk7FH/jO8qmxOK+Q4riWTnkexyovHTpJ8gvM
         7FfnNRNuJp0YQKAgx7gmA76yrdMJHL97vPskjQD795k77JC15ieDc+eO1CpooQXyyTWX
         UiYQ==
X-Gm-Message-State: AOAM532n6JpOK8PRsbFjJWLa34FKhTOYT6pKVZE4Y5epb9+biZX8WRlx
        GBnbNh7XGqQRB1ZGKz6/d6S8Fw4UObO5dxMs
X-Google-Smtp-Source: ABdhPJwzw7swUbl/AmpOkJhe3WPo5R1QZakPp4FDSXu68LQMhHpBn+oAY2RltWKXU1AOsb4TSGXFWw==
X-Received: by 2002:ac8:4648:: with SMTP id f8mr42708666qto.5.1608136037005;
        Wed, 16 Dec 2020 08:27:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l1sm1247927qtb.42.2020.12.16.08.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 12/38] btrfs: btrfs: handle btrfs_record_root_in_trans failure in relocate_tree_block
Date:   Wed, 16 Dec 2020 11:26:28 -0500
Message-Id: <ea269924a2b4c607005796736324308e4c454d7c.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_record_root_in_trans will return errors in the future, so handle
the error properly in relocate_tree_block.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0eea27d9e3cf..7e3305aca6ac 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2548,7 +2548,9 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 				ret = -EUCLEAN;
 				goto out;
 			}
-			btrfs_record_root_in_trans(trans, root);
+			ret = btrfs_record_root_in_trans(trans, root);
+			if (ret)
+				goto out;
 			root = root->reloc_root;
 			node->new_bytenr = root->node->start;
 			btrfs_put_root(node->root);
-- 
2.26.2

