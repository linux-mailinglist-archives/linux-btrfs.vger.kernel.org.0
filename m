Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489856A7B8C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 08:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCBHBM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 02:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBHBL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 02:01:11 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9CE113E9
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 23:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677740469; x=1709276469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dqeEsZrOBWho5CF2/8p5b9sahw5n+11g7e1sNC7g3iw=;
  b=ls+YxNsNcpZvwvU/oPOrJ/l9PwE+YJFIHoUu3fqIL94BE35Pe81MF4Cp
   DneDD41AZtHPjFthftxIw9db1qX20MbIYlL0M5gErRx2m9jjVB4JpaZlf
   OGxiwGJJ9LgKRaFgAQa/lc4SHG/e8YIouDmGSnCVbzAAtvQHTl5eouLcP
   8/iWfyNL2NvdSAhRyKx6od5wZGSpEDRZ/2TOYvKIWfep5cTkY0oF7SF6g
   IyCpzh8bUB0RWeZXrYBggRUeD/TgyFRryuArbX2AdNYYe8rS/PBWxIZOZ
   OE0GsAqwSZONYmWA8PgHWF6r6CzSVjVAVgt0AKJ7UkwmF64EFC/wLNZaB
   A==;
X-IronPort-AV: E=Sophos;i="5.98,226,1673884800"; 
   d="scan'208";a="336581189"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 15:01:08 +0800
IronPort-SDR: yweuhS7uk1z0o0EdvpadzxCuUlidkNKJ4qFjiI165JQrjDaTXDJRTJ5ttqmHKVUHQBx7vckwjS
 z0Emv9exIoMYMlLSd9qYWB2CfiWA/4BX7Xc+JjtJw17M/zBMA1W8Vx4ZsFF6F2/fbQzAgtyeVM
 mkMJw0Jt2/sajqSKROXtSHb8Bwx2SIoiI39zDwzSO/VGwnJyYhxe95j8u4S/GjLl3rY4z5en5q
 UOZuKdzWOrXK5FH+/jmrFUGr+cV4ohZNCl44iTzJKxmlhWRpPFFsLKDoRTUSlCwjYWT5HiJZZK
 4jU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2023 22:17:58 -0800
IronPort-SDR: GxglR0RCEw0H+pfmMQptvGs2I1R65vNJtks3sx+u4V52lxi2WSEnaboin3ZGZdUmxlq+ECiQUI
 KKTDycmY5umZ6hPZGMfeG5eGxxxlSC0CBC07JwDc5Bb6bdllmQwGJVSQdYtKtq0t0lvl1A//jw
 cOX3Vsios6boGnvqKVA4xxKkirswMfZ5DieeLe9HB40/xpu/NDrKbgsoZ8rLt8o8a04H6hl/ml
 x8CxcX3z6Vc0zD1aqwzufbUN+EXvutkmZFT1CB6q7EalyvYiiRmWSlyoToDBxqdvd+W3jKwyA9
 jrA=
WDCIronportException: Internal
Received: from 5cg217420n.ad.shared (HELO naota-xeon) ([10.225.50.90])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2023 23:01:09 -0800
Date:   Thu, 2 Mar 2023 16:01:07 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/3] btrfs: handle active zone accounting properly
Message-ID: <20230302065600.iu4idhfddygxczkk@naota-xeon>
References: <cover.1677705092.git.josef@toxicpanda.com>
 <ed93f2d59affd91bf2d0582b70c16d93341600e4.1677705092.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed93f2d59affd91bf2d0582b70c16d93341600e4.1677705092.git.josef@toxicpanda.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 01, 2023 at 04:14:44PM -0500, Josef Bacik wrote:
> Running xfstests on my ZNS drives uncovered a problem where I was
> allocating the entire device with metadata block groups.  The root cause
> of this was we would get ENOSPC on mount, and while trying to satisfy
> tickets we'd allocate more block groups.
> 
> The reason we were getting ENOSPC was because ->bytes_zone_unusable was
> set to 40gib, but ->active_total_bytes was set to 8gib, which was the
> maximum number of active block groups we're allowed to have at one time.
> This was because we always update ->bytes_zone_unusable with the
> unusable amount from every block group, but we only update
> ->active_total_bytes with the active block groups.
>
> This is actually much worse however, because we could potentially have
> other counters potentially well above the ->active_total_bytes, which
> would lead to this early enospc situation.
> 
> Fix this by mirroring the counters for active block groups into their
> own counters.  This allows us to keep the full space_info counters
> consistent, which is needed for things like sysfs and the space info
> ioctl, and then track the actual usage for ENOSPC reasons for only the
> active block groups.

I think the mirroring the counters approach duplicates the code and
variables and makes them complex. Instead, we can fix the
"active_total_bytes" accounting maybe like this:

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d4dd73c9a701..bf4d96d74efe 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -319,7 +319,8 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	ASSERT(found);
 	spin_lock(&found->lock);
 	found->total_bytes += block_group->length;
-	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags))
+	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags) ||
+	    btrfs_zoned_bg_is_full(block_group))
 		found->active_total_bytes += block_group->length;
 	found->disk_total += block_group->length * factor;
 	found->bytes_used += block_group->used;

Or, we can remove "active_total_bytes" and introduce something like
"preactivated_bytes" to count the bytes of BGs never get activated (BGs #1 below).

There are three kinds of block groups.

1. Block groups never activated
2. Block groups currently active
3. Block groups previously active and currently inactive (due to fully written or zone finish)

What we really want to exclude from "total_bytes" is the total size of BGs
#1. They seem empty and allocatable but since they are not activated, we
cannot rely on them to do the space reservation.

And, since BGs #1 never get activated, they should have no "used",
"reserved" and "pinned" bytes.

OTOH, BGs #3 is OK, since they are already full we cannot allocate from them
anyway. For them, "total_bytes == used + reserved + pinned + zone_unusable"
should hold.

> Additionally, when de-activating we weren't properly updating the
> ->active_total_bytes, which could lead to other problems.  Unifying all
> of this with the proper helpers will make sure our accounting is
> correct.

So, de-activating not reducing the "active_total_bytes" should be OK
... but I admit its name is confusing. It should be
"active_and_finished_total_bytes" ? "once_activated_total_bytes" ? I still
don't have a good idea.

> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c | 29 +++++++++++++--
>  fs/btrfs/disk-io.c     |  6 +++
>  fs/btrfs/extent-tree.c | 13 +++++++
>  fs/btrfs/space-info.c  | 83 ++++++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/space-info.h  | 20 +++++++++-
>  fs/btrfs/zoned.c       | 14 +++++--
>  6 files changed, 152 insertions(+), 13 deletions(-)
