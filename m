Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CCB1D4377
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 04:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgEOCRr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 22:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgEOCRq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 22:17:46 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAFBC061A0C;
        Thu, 14 May 2020 19:17:46 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so311763pls.8;
        Thu, 14 May 2020 19:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dP2dgHJL+/ZZAyIJxLUBe2ULDQdO+RZITSQnrYFRs8k=;
        b=Ut1seaLFauwVnQHgW/+30SJULYTJuUnde7WoEdAECG6S+bjjEqZYspgxBjp4Tuelzf
         LYsRNO/vSHPNcUPEWDrJQ0AWifCWK0QcHVrQpiE/iNNeMT8fhAVSYvgFwdA+XRDa4o/T
         IK1YdH4t8OJq4aWYiUEd/E6VPaYHp0DiRjdEVPAfF+OF6xnSnLH1WPi4cfgusm+gj/pO
         ukVboi+pOr1pjfBUrFbILXGce3ALXsjR0ZxkKY4Crq15bk5naKbH2V2x/CSqs5LAdZui
         TLTY96B9fpUrvv7ucIQgqN7xnnQ1NLMIorsxqGNV9skzOeC1MBzHLnfU6+dkWP5vqKxm
         2tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dP2dgHJL+/ZZAyIJxLUBe2ULDQdO+RZITSQnrYFRs8k=;
        b=DhkcOBW58VP/FKDSAJ4CthmQ6rKTW5MhUHwIpz4VdqLD28vpOyDNmrkA9IAYCMc8fT
         t1NO09mZY942Jo9HEH22JmmG9YVbYW58KHCyCtTZh2P7vt/YFz1wMAA09Ea7rg4UE6O8
         6IAkF8JJYqmOHuk1zMqI7FcsgsYIjFxWoKAyFbXj0/XdOw9X8ByUgtztg6iDubWI5QoZ
         6kaLhfXw4xU3EkLT1wJQZr0AKuHyC3LtheeAeR7TWeEl0xsZU80KjTclC6mfsKAdadpn
         iGdG24L/+M083oQwxl0UUo+2F/jnB95kvoiSxb7PvjfSh0nzG8pVNc+f/dOJlBIHFa5+
         /1yw==
X-Gm-Message-State: AOAM532KszpmjbHtsT57vhz0UlYcdZC7s96Lm0WGlMK4suME104m6+Je
        Ba8bTJfloFMQLBgMz4lOc48=
X-Google-Smtp-Source: ABdhPJxXbdIBZIjwkn7ZbY+hGsjbDKfIfe1ZdO9VXxwzM1xJNTPv8EDLt6su+DiiWRPBkEf4kiwP3Q==
X-Received: by 2002:a17:902:328:: with SMTP id 37mr1557483pld.35.1589509065945;
        Thu, 14 May 2020 19:17:45 -0700 (PDT)
Received: from debian.debian-2 ([154.223.71.34])
        by smtp.gmail.com with ESMTPSA id d2sm439366pfa.164.2020.05.14.19.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 May 2020 19:17:44 -0700 (PDT)
Date:   Fri, 15 May 2020 10:17:40 +0800
From:   Bo YU <tsu.yubo@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, sterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsu.yubo@gmail.com
Subject: [PATCH -next] fs/btrfs: Fix unlocking in btrfs_ref_tree_mod
Message-ID: <20200515021731.cb5y557wsxf66fo3@debian.debian-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It adds spin_lock() in add_block_entry() but out path does not unlock
it.

Detected by CoversityScan, CID# 1463343:(Missing unlock)

Fixes: fd708b81d972a (Btrfs: add a extent ref verify tool)
Signed-off-by: Bo YU <tsu.yubo@gmail.com>
---
 fs/btrfs/ref-verify.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 7887317033c9..8f644511006d 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -894,8 +894,10 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 out_unlock:
 	spin_unlock(&fs_info->ref_verify_lock);
 out:
-	if (ret)
+	if (ret) {
+		spin_unlock(&fs_info->ref_verify_lock);
 		btrfs_clear_opt(fs_info->mount_opt, REF_VERIFY);
+	}
 	return ret;
 }

--
2.11.0

