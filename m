Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 670F415114E
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBCUuF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:05 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34194 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBCUuF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:05 -0500
Received: by mail-qk1-f194.google.com with SMTP id g3so7100234qka.1
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H3pIC+bnbkgII+mVE/UJab4aPnDhaKqXCIVAENLNJPw=;
        b=P2fHiWQDDlVMa2zPga7y4NTd794gHXgX+2nNQWVO+Sb9MuJtf8qzaCahg2XroPozLK
         6soV/VsiCQ+aktNsOZwgNRm3e2orJo74iH8shSDSTzybRWJNdqDYaj3fhOHr4HySFxJZ
         MtZYW1F+ZDnZDi/5X+wB6NT5WH3DtnZ5uebe62A6jG6bFLYqgyu7qcZoQROMLT0n8xru
         20j95GzkF0Ah4YixkIa+8ktP9dt3I442IgisYf8EOTqNfgq9XmenPFrfHFp0jKBb2gbX
         oW/+7VEIxFYsFxBTSAgN1v//nEfl32cRwDS5d0ECQNZQQiZKDktclbNbcfhPNk+2QIcl
         2kFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3pIC+bnbkgII+mVE/UJab4aPnDhaKqXCIVAENLNJPw=;
        b=Ai59/PulBLigTFTV0VoIPSrCsjNOgNqwxUVKoEIPh6k3MLyq2BX36cdzF27EomPZq6
         1qIkh1xBD5wKBNTQgTPrbHB9zMgTgNuaJypfHwvMpM489jA/n9MVbUem/7RY/TjUrvVf
         PTx3M0/cUInV7GhQZAvYAYoEucDTd9SdZauUuZRcM1quRrsg64TLr1bH9iPrGyxoDvap
         r1bnpMtlbm88lwvrpYFlKgktpL0gt8IbqiiFrJGPRq8j9j4RFQ/aSxkJ6QxXi8RJleUJ
         A97jAm1iZAMhuzRYCZ3sd/dwnwdVb66pa18JGv6ySzAhJdaoaRRx9IOVxWHQYnn522Dg
         IT8g==
X-Gm-Message-State: APjAAAX+KeZyMfJzsNdPI7ftSc24KW/8+gjJK5hGxFhycjCku5XiAoJj
        FZnC+WbWpkGF5lSS0Dj9bW0ukKiIBmeVRg==
X-Google-Smtp-Source: APXvYqyitH8t7tmj95MdW9OjkErLFjAYPqR8TmowZM3O97VU3/nhSIw4ElMgrKG+NTP3nX8P76eUyg==
X-Received: by 2002:ae9:ea08:: with SMTP id f8mr23605007qkg.489.1580763002786;
        Mon, 03 Feb 2020 12:50:02 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v10sm10341394qtq.58.2020.02.03.12.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/24] btrfs: make ALLOC_CHUNK use the space info flags
Date:   Mon,  3 Feb 2020 15:49:32 -0500
Message-Id: <20200203204951.517751-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have traditionally used flush_space() to flush metadata space, so
we've been unconditionally using btrfs_metadata_alloc_profile() for our
profile to allocate a chunk.  However if we're going to use this for
data we need to use btrfs_get_alloc_profile() on the space_info we pass
in.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 17e2b5a53cb5..5a92851af2b3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -604,7 +604,8 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 			break;
 		}
 		ret = btrfs_chunk_alloc(trans,
-				btrfs_metadata_alloc_profile(fs_info),
+				btrfs_get_alloc_profile(fs_info,
+							space_info->flags),
 				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
 					CHUNK_ALLOC_FORCE);
 		btrfs_end_transaction(trans);
-- 
2.24.1

