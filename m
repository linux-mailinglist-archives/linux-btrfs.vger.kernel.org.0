Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E597F6E564E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 03:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjDRBSU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 21:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjDRBSR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 21:18:17 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6153349F2
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 18:18:01 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 3816DC022; Tue, 18 Apr 2023 03:18:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681780680; bh=o8ahh+GkkNunS6bzuWieQkRWIvaKeN5a/F4HG1+hJKE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=XLkKVDRX5TSIgD6ksDWir4ZPfMis07n5tkrKulRTW8wvCKLNSCtJ7WIdY/02oFvc0
         HsRYhtumQvcZniK1LXl5vjv5y2JpKEgCiXqt+Yd6ehggt//jSTEICoCCFjwxvkrpHA
         J6hp7w3bn8IRidRQ8c73axKm5RgC45e5oMLrHmKbTbLEgG0JE6x/4i3zDIb/5Nlsq6
         KD1I5NF1zPkELf/Glz9TlgjNrbkvUfjLjZqy/nJYh5n2uGpeFT4ALooIfXEWoSQ1Dr
         4rTTCMpSlRMNus4O9mohJ8ZXaqeRsNLvb+k9StDjgIgNGU2OnD7Abua19DUAkR3ZAw
         gbqmXKix7eXiQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 77D68C020;
        Tue, 18 Apr 2023 03:17:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1681780679; bh=o8ahh+GkkNunS6bzuWieQkRWIvaKeN5a/F4HG1+hJKE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=xToj4DEmsFmSsy186tuKzL3ZV9lBDAadwRg1hazrpGNm00kJ14VzUCoBvBOtK658s
         lhdAC9oNNX7o01oHPuV7bb/7KSrROfKWpv8lJqKlX4JcXgzmmuesA78YxiVW2qXhkH
         vXcVyxUFl9WQH6Ci/G7TVnSfG/uiY9hL+CuYl5bv39BbvFgdF8snPQwdVbzDpmENac
         HK9g80IS4rUuDiveTdczJjmmc5n5I0dJUHT7NKlldwq7dMeq8we3WNOXNorFSTL8R0
         mtXgXYZnSnV9f1ncTADJuKoC+am2Dc1g1IHBYj6Tr/n4g7TX+FVWuOeDe1UDdj9Iz9
         a/b3vpdXeL80Q==
Received: from [127.0.0.2] (localhost [::1])
        by odin.codewreck.org (OpenSMTPD) with ESMTP id ed1adae2;
        Tue, 18 Apr 2023 01:17:47 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
Date:   Tue, 18 Apr 2023 10:17:34 +0900
Subject: [PATCH U-BOOT 2/3] btrfs: btrfs_file_read: allow opportunistic
 read until the end
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230418-btrfs-extent-reads-v1-2-47ba9839f0cc@codewreck.org>
References: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
In-Reply-To: <20230418-btrfs-extent-reads-v1-0-47ba9839f0cc@codewreck.org>
To:     =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
X-Mailer: b4 0.13-dev-f371f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=BghhxjYbg3uvl/WVD9A/qmvqlstJ4ddaxDDM+2P4agE=;
 b=owEBbAKT/ZANAwAIAatOm+xqmOZwAcsmYgBkPe+7GNMSAPRdHeAhmheOKpt8wygY3fgQYinEl
 K1dI5bt+r2JAjIEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZD3vuwAKCRCrTpvsapjm
 cEZbD/jvhcW1iJVfJlFTg4wvPzxXpqTKJ51dOC7i0NAl1cGb9fJvL84RGYcL8KU8Tu7YW5Y5Jxx
 LYTvfty7XZYNVCoabpHhPnLP+XWF+QaUOkdMnphHvjLEauWCGbPBqplr1Zei0eHuCdDEztIS5Wp
 h7Ie09OD+CVAANvziJCrQMe+Y3fi/eB9VOFs0r7LZPtFo7esdauIbObPD5pKaZnjD+15MpOZ+2/
 1+DgirE90VlhdSHjmMmhyj0/O3GA0apfSPSha/QVfBZ8JvLUhcRn3JWzZ+Q842dKTbYm59yD0DD
 M11wl2SYP6psUXVHmJH5lfTzepW3Ns9b+s/cQY5LZLNRDXCQVvSU9j3Kev5t8JofjTj5EAxyfQK
 YL0R3Wumcot/17Pgk0+GqdEm0eFpoCYcTp/gC/9SsRoOGzckkK973Pi3PYrTbcp74c48E66Y0IG
 zuWcGIMfl+kxccMxI+EPS794Kf0MQxOjfU85rlxdLFAx3DgGusViHz2gYFtvLJ5B3bqxs8qViKB
 FKGSyCDlZV2+d/8ZWI/9FMj+xxY51XnpU/La1Xn2ExAd12fE6L+4m/P62FjDeNEE959nw+bKMB/
 jXtl2hH6Ywojj4WATRVkbLo4x5JArpvu7yT1/+Y5HnOgFKBgKkf6lQK8j7Uznym3ZSrITNIltD3
 F7neRhv6H4bXj
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

btrfs_file_read main 'aligned read' loop would limit the last read to
the aligned end even if the data is present in the extent: there is no
reason not to read the data that we know will be presented correctly.

If that somehow fails cur only advances up to the aligned_end anyway and
the file tail is read through the old code unchanged; this could be
required if e.g. the end data is inlined.

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
 fs/btrfs/inode.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3d6e39e6544d..efffec0f2e68 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -663,7 +663,8 @@ int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
 	struct btrfs_path path;
 	struct btrfs_key key;
 	u64 aligned_start = round_down(file_offset, fs_info->sectorsize);
-	u64 aligned_end = round_down(file_offset + len, fs_info->sectorsize);
+	u64 end = file_offset + len;
+	u64 aligned_end = round_down(end, fs_info->sectorsize);
 	u64 next_offset;
 	u64 cur = aligned_start;
 	int ret = 0;
@@ -743,26 +744,26 @@ int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
 		extent_num_bytes = btrfs_file_extent_num_bytes(path.nodes[0],
 							       fi);
 		ret = btrfs_read_extent_reg(&path, fi, cur,
-				min(extent_num_bytes, aligned_end - cur),
+				min(extent_num_bytes, end - cur),
 				dest + cur - file_offset);
 		if (ret < 0)
 			goto out;
-		cur += min(extent_num_bytes, aligned_end - cur);
+		cur += min(extent_num_bytes, end - cur);
 	}
 
 	/* Read the tailing unaligned part*/
-	if (file_offset + len != aligned_end) {
+	if (file_offset + len != cur) {
 		btrfs_release_path(&path);
-		ret = lookup_data_extent(root, &path, ino, aligned_end,
+		ret = lookup_data_extent(root, &path, ino, cur,
 					 &next_offset);
 		/* <0 is error, >0 means no extent */
 		if (ret)
 			goto out;
 		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
 				    struct btrfs_file_extent_item);
-		ret = read_and_truncate_page(&path, fi, aligned_end,
-				file_offset + len - aligned_end,
-				dest + aligned_end - file_offset);
+		ret = read_and_truncate_page(&path, fi, cur,
+				file_offset + len - cur,
+				dest + cur - file_offset);
 	}
 out:
 	btrfs_release_path(&path);

-- 
2.39.2

