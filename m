Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9ECA7AF7F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 04:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjI0CBe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 22:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjI0B70 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 21:59:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD88121
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 18:13:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 76ACC2186E;
        Wed, 27 Sep 2023 01:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695777199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CDgTEtjitPv+9/3VDosfEzNTm/Ny62abXjBLGMPGajY=;
        b=WJxtww0FHLYLaFV0VvgcNQa/xC2Pm2bbuGHv5JHE/UBmkNQcV/kA+rsrU9khQsMVhBi/tc
        CrL6oap3owQZwyqIpCU1FsIMXga8RU0w/uBRnvRevB+VPAQ+3/7X1XHAbX+phthBHI+Q3I
        zf5SRbpGTUrtHryw9TsvX2VcsErgahQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E0EF1390B;
        Wed, 27 Sep 2023 01:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +zOpC66BE2U8FAAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 27 Sep 2023 01:13:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: reject unknown mount options early
Date:   Wed, 27 Sep 2023 10:43:15 +0930
Message-ID: <5c33940976b7f970836d8c796f92330e5072ffdc.1695777187.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following script would allow invalid mount options to be specified
(although such invalid options would just be ignored):

 # mkfs.btrfs -f $dev
 # mount $dev $mnt1		<<< Successful mount expected
 # mount $dev $mnt2 -o junk	<<< Failed mount expected
 # echo $?
 0

[CAUSE]
For the 2nd mount, since the fs is already mounted, we won't go through
open_ctree() thus no btrfs_parse_options(), but only through
btrfs_parse_subvol_options().

However we do not treat unrecognized options from valid but irrelevant
options, thus those invalid options would just be ignored by
btrfs_parse_subvol_options().

[FIX]
Add the handling for Opt_error to handle invalid options and error out,
while still ignore other valid options inside
btrfs_parse_subvol_options().

Reported-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 5c6054f0552b..574fcff0822f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -911,6 +911,10 @@ static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
 
 			*subvol_objectid = subvolid;
 			break;
+		case Opt_err:
+			btrfs_err(NULL, "unrecognized mount option '%s'", p);
+			error = -EINVAL;
+			goto out;
 		default:
 			break;
 		}
-- 
2.42.0

