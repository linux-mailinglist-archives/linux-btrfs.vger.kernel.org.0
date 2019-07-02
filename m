Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFC75C795
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 05:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfGBDKt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jul 2019 23:10:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45172 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfGBDKt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Jul 2019 23:10:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so7505286pfq.12;
        Mon, 01 Jul 2019 20:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qBzA8EczuD3348ecJI29hXjW3DrArL1vFtQRztYBPjs=;
        b=fRvYez1lO4TaRoT+244gk1rO9gTLKr9mSpN6AiZq5ETNaEikk5g2cnuY4HId7XZcma
         1qbyvb0RNTTopf91ve7MXTuxP4VpdH2Ba6VAmbf5Mgda82jljjtPegflkRcmOztkiS3G
         bU5a88rUfiu+25qi9bhvsybzBImqiXGmmo+ZJHa1h2qZqp4s6/l/XV6z88kpkTVmnwqG
         9bEhaUzua58UHSNhAaldimGHi5taAndkzgUYSBwdNVeBVXTcA3TEM9uzP3MK5wSnTS19
         vsJVYzkB+rHhVtqAFpqLIkZUXufLwH/TOIozIQEpA2U/+4epYdPCvUPS+EzleJJfjuOq
         d8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qBzA8EczuD3348ecJI29hXjW3DrArL1vFtQRztYBPjs=;
        b=XopvEt9UwKob6DegJHqzCSYD8YFugsvqjWynWkOzDDe6oxr1NJmXHRp5G3eMeLPsiF
         ttwF2PFfSC4kcjZ6gT1jabJsyGZOD/tVC3IWU2TAjNI3ADzElkhhNUzWWK+lFqlftYtD
         bjn7GP0zaznLg/O52Gn/tPKMb/e9zAevnpB2xdGoWJ6ghE+cHC7lh1RCGiha4jR3N4eP
         C7KWl4XTKtzCm4olayQX7VufOW0h98HL0FtsjlX3kJ+0zhgJCCod7k2817JY5kNtZ8TA
         vU/00r+IPn7RmcZmXFKLh573tLeBsPqc+6abvyaXd3WNVas7541JaDOD4d0t0gE1vB1l
         t2EQ==
X-Gm-Message-State: APjAAAVqaAlzYyeGByDppubsjMSBlGh1zNCGU/Ijljzaboc0aHC9uOov
        AMSFzKoKN3F1T7wa/dkX23c=
X-Google-Smtp-Source: APXvYqxvioSgACsFQVT2hUwgNbvLXKb6Hdh7EcLnmFquo+d6vd7JMzZhXeZ53g4tiK23wwTPAlvYig==
X-Received: by 2002:a63:224a:: with SMTP id t10mr28035908pgm.289.1562037048555;
        Mon, 01 Jul 2019 20:10:48 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id b15sm11965592pfi.141.2019.07.01.20.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 20:10:47 -0700 (PDT)
Date:   Tue, 2 Jul 2019 08:40:43 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: btrfs: extent_map: Change return type of
 unpin_extent_cache
Message-ID: <20190702031043.GA24334@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As unpin_extent_cache never fails and Caller does not expect return
value we can change return value from int to void.

Issue identified with coccicheck
fs/btrfs/extent_map.c:284:5-8: Unneeded variable: "ret". Return "0" on
line 316

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 fs/btrfs/extent_map.c | 5 +----
 fs/btrfs/extent_map.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 9558d79..2b0eaa1 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -278,10 +278,9 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
  * to the generation that actually added the file item to the inode so we know
  * we need to sync this extent when we call fsync().
  */
-int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
+void unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 		       u64 gen)
 {
-	int ret = 0;
 	struct extent_map *em;
 	bool prealloc = false;
 
@@ -313,8 +312,6 @@ int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len,
 	free_extent_map(em);
 out:
 	write_unlock(&tree->lock);
-	return ret;
-
 }
 
 void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em)
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 473f039..9d752ce 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -96,7 +96,7 @@ struct extent_map *alloc_extent_map(void);
 void free_extent_map(struct extent_map *em);
 int __init extent_map_init(void);
 void __cold extent_map_exit(void);
-int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len, u64 gen);
+void unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len, u64 gen);
 void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em);
 struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
-- 
2.7.4

