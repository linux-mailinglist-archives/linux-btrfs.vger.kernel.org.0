Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FCF7CB0A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 18:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjJPQ5A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 12:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjJPQ4o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 12:56:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C33D421D;
        Mon, 16 Oct 2023 09:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697475260; x=1729011260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7i3ajq8w9Jvfj033rvnxtzh/FOZ1MH5dwoazmxDInTE=;
  b=SAvlkDUFiY9zuz4mQD2BFeaWMcItlpw4E42o2gacQhStF6MJz7Ar9z0i
   WD3yihf55GDuWAbFafVpPaYKT+PueErA5C+Zt3rBsChxqQpGOuMUjFhz7
   2VQUK/H0EIZl80UGFMWCMD68V7cgM+hU/tSGn17cRDB0ILfNL0XB6IpnL
   mRqaB8XIxpyLyYVpiV58As2sqeB5E7598OLSBjpwFRc6GoYQXHwYPyJbt
   Iha6u8HTq4yJREHtIOm0jhp0XwcqY0jx68fJITJd3542LzK+vSmjPb+bV
   JzHqQh7kjzYtNVHFN3JrMSS+xxQYorfqJWGTr6peLzEzo1g8ABLyw1PQn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="364937021"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="364937021"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 09:54:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="826083922"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="826083922"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2023 09:54:16 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/13] bitops: add missing prototype check
Date:   Mon, 16 Oct 2023 18:52:35 +0200
Message-ID: <20231016165247.14212-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016165247.14212-1-aleksander.lobakin@intel.com>
References: <20231016165247.14212-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 8238b4579866 ("wait_on_bit: add an acquire memory barrier") added
a new bitop, test_bit_acquire(), with proper wrapping to try optimize it
at compile-time, but missed the list of bitops used for checking their
prototypes a bit below.
The functions added have consistent prototypes, so that no more changes
are required and no functional changes take place.

Fixes: 8238b4579866 ("wait_on_bit: add an acquire memory barrier")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..f7f5a783da2a 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -80,6 +80,7 @@ __check_bitop_pr(__test_and_set_bit);
 __check_bitop_pr(__test_and_clear_bit);
 __check_bitop_pr(__test_and_change_bit);
 __check_bitop_pr(test_bit);
+__check_bitop_pr(test_bit_acquire);
 
 #undef __check_bitop_pr
 
-- 
2.41.0

