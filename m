Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D028929951E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 19:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789486AbgJZSSP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 14:18:15 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43786 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784008AbgJZSSO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 14:18:14 -0400
Received: by mail-qk1-f195.google.com with SMTP id q199so9263294qke.10
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3ahfNN9QuxC7SHKPYaBqHBjZ0n+GHMQfJFONYc9vCQI=;
        b=JuYcyugJF2SmbedEhVlM8K9tZ/Gg7dJQEY8krfvkmisAOLn/VZA7Yl001yk6XRK749
         GsFdWRM+s2cpke42n3oi5xhF8z1EtwO1kw/PpInrITtuthjPc6t8AgSFI7cdD5fiHZAE
         IDhFbWatWlKI9w9HGBZ0s3s4EzQ9CPb+OgxVseRXrCk/StkzemN0eklAqLqcRu/zLV6t
         gdYreAi4cjUZf89dvj3H8bt3BmYKckKiZqvdfrdggfmeYTgt8zASigd33y/GjMMPnlpO
         xmPsEMAFdtG5qizcxasYqzrKs+j6VkwBouo3GugfQUeJXiZWb0B7P11jVZM/MShFmg7k
         1kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ahfNN9QuxC7SHKPYaBqHBjZ0n+GHMQfJFONYc9vCQI=;
        b=ZyJPguyPrBMS3d/vh0i9GC6esFxjTEVpwZuuEyDDE7aKVplYcfkMrydjeyMPjiUN0/
         brP8OQLK1NRX78GZkDhQPO0uVB5NswCabi7wuPVdjMiICavCA/qVotAIK2FBGyH941nT
         PSpSvjNhQH5psP9UF0gqueV7aMHdXDTdQPi058ycb8I8LX1AIjf7sLU7QBXkyTgGptGF
         1wHpoeg81grmAOPb2DU33tV9axro1aksFL0JFchPDZ9KdTm0D2j3nDkY68DnrDnhIguB
         4hGydmebHEPViDlCJuwfD8htu69GnBbX1BaxFFrzYaFg0lrFSON4vdRS4PbGw+xITA6N
         XB0A==
X-Gm-Message-State: AOAM532R1tqIHzO9zr35zGm+0ihMaY/7NLNizbpraIS0v3P707jeFCY0
        bPEn9KywIoIINDsOBlfWTjkOjypJE6uJpFAt
X-Google-Smtp-Source: ABdhPJzisrDEAMskrsN59p20OuAVTfYIeO+QqHPzdMoInLS6zNfWyOlXF44Swf+gfbpDdZweAtKk4w==
X-Received: by 2002:a37:a407:: with SMTP id n7mr18151302qke.248.1603736292039;
        Mon, 26 Oct 2020 11:18:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d73sm7215235qkb.8.2020.10.26.11.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:18:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: fix min reserved size calculation in merge_reloc_root
Date:   Mon, 26 Oct 2020 14:18:06 -0400
Message-Id: <30d88cac24cfe0a2aa2a334a3648e9e940ecf3ec.1603736169.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603736169.git.josef@toxicpanda.com>
References: <cover.1603736169.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The minimum reserve size was adjusted to take into account the height of
the tree we are merging, however we can have a root with a level == 0.
What we want is root_level + 1 to get the number of nodes we may have to
cow.  This fixes the enospc_debug warning pops with btrfs/101.

44d354abf33e ("btrfs: relocation: review the call sites which can be interrupted by signal")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3602806d71bd..e1332f78d618 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1696,7 +1696,8 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 	 * Thus the needed metadata size is at most root_level * nodesize,
 	 * and * 2 since we have two trees to COW.
 	 */
-	min_reserved = fs_info->nodesize * btrfs_root_level(root_item) * 2;
+	min_reserved = fs_info->nodesize *
+		(btrfs_root_level(root_item) + 1) * 2;
 	memset(&next_key, 0, sizeof(next_key));
 
 	while (1) {
-- 
2.26.2

