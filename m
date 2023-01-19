Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B3E6745A2
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 23:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjASWOZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 17:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjASWNe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 17:13:34 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7463B95186
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:29 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id s4so2734931qtx.6
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfHIN8/bXamC0Vj0TM8XlhpoKocT6VORG+dBFhB+38s=;
        b=6kj+6spLIFfIfZae6Dulb+4Rc6EpfbrgIhYTsAC81SA2nHMc7eW7IWcgp5pj+JxjSa
         8fbYtXhleuu7KqRUm7b8Ld6je/kU2q/iaCRExwY/es6pmzyNTe7A3FhGbPamlBQsCMD1
         W2VOfH+nEhxLQvoSvAU+X0ZBWDz6D6y8Sa1cg7AoM3KclBmG9Zje08D5UIlInckmpm30
         HA75LZs9NJfS/GEC/wT84LRBU4KK1UdGvpufPObAEk28rWPDot78NA+AUUuTSfCXAbxZ
         UmVCmdDSJUI9+HT/izREzUqbXYkQfYE4EpPQpC/HgXCpDAUw0pWuQcJn4eCWhQCDMEs6
         zTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfHIN8/bXamC0Vj0TM8XlhpoKocT6VORG+dBFhB+38s=;
        b=ZYjFzGlMf28tlsyN9uOPlp1/lvX5vsDPU5ooEHf0SiaC7V/MMscSE4g/AHosQOg+nk
         mgSnRAosYHU3gTRYoRH2FbdZtYDlwDsQm+BChzf4NB9KxKSYYlVzRfL6By92ZlhsAanH
         DkkMYbI8t/OdvNQ/Ar4fhZYrpp+o2mF/41t6aNBUtGOg6qIs5ECTvrODULP0DU/wKLAQ
         dnZZJPfZbfqQew7YB6EgaKZKMXs9qGNVKieNIVyc+6uhAfH2RzNPiEVgfYN2HyybfnxF
         5Ld2DweUa2/80jJ/pnU8Ia9aNipKIl6l+ru56EL5YoZgn98d6GPKBrg908TmHIrkNmIv
         Y/dg==
X-Gm-Message-State: AFqh2kqzIfnlJ9eR+ZP5HftgV/Tf1vnoChXmlTt9qEYv2NixIXZUOKhg
        ug6UVqpWUQocWT3VAsjdvGEKul6mLZtGhou+ReE=
X-Google-Smtp-Source: AMrXdXukOAybmkL3/rvZD6glX1ogLfDHcJ7lVPG1CCD+o0gAoszWZ19ya6POQPgFaP+f9tGs5tQr1A==
X-Received: by 2002:ac8:6f09:0:b0:3b6:3468:8417 with SMTP id bs9-20020ac86f09000000b003b634688417mr18984804qtb.17.1674165208554;
        Thu, 19 Jan 2023 13:53:28 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d12-20020a05620a240c00b006fcc3858044sm25681581qkn.86.2023.01.19.13.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:53:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/9] btrfs: do not call btrfs_clean_tree_block in update_ref_for_cow
Date:   Thu, 19 Jan 2023 16:53:17 -0500
Message-Id: <ff064f6f4cf17cc5eafc127dadfc3474d46869ad.1674164991.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674164991.git.josef@toxicpanda.com>
References: <cover.1674164991.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My series cleaning up the btrfs_clean_tree_block usage uncovered a
pretty nasty problem, we weren't writing out metadata that was getting
cow'ed away before the transaction commit was able to write out the
block.

This was because I changed btrfs_clean_tree_block() to unconditionally
clear the EXTENT_BUFFER_DIRTY flag, whereas before it was only doing it
if the header generation == the transid of the currently running
transaction.  This check exists purely for update_ref_for_cow's benefit,
as we only really want to call this when we're sure we won't use the
block again.  In the case of update_ref_for_cow() we're only truly
wanting to avoid using the block if we're in the same transaction that
dirtied it originally.  However we only get into update_ref_for_cow()
with refs == 1 if we already wrote the block to disk via memory pressure
or something, which means we won't have EXTENT_BUFFER_DIRTY set anyway.

Remove this usage in update_ref_for_cow(), as it doesn't make sense, and
is actually harmful with my other cleanups.  We want to reserve the use
of this function for when we free a block in the current transaction,
like with delete's or balances.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 5476d90a76ce..ac33dbb08263 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -459,7 +459,6 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 			if (ret)
 				return ret;
 		}
-		btrfs_clean_tree_block(buf);
 		*last_ref = 1;
 	}
 	return 0;
-- 
2.26.3

