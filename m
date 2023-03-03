Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EA36A9264
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 09:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCCI2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 03:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCCI2G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 03:28:06 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EA259E71
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 00:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677832051; x=1709368051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B5kjq+w9kbSOQ+W/tZCQALC4zbKIZ3LaM60ogawDrqg=;
  b=mgqdrnZ2YPIlSXa+eg3lx5dXx9Qsn5udENwfb2wNQ+zeNqdw5JaaMxja
   qDGVG0pOnTO9v3k7E/C/hPfGuAbdBGI9nYX9ciYBg8Tl7ivoRPA/HLgTH
   SXh4gdFcOUxOFL7rGzaQSRaAGIlLUpgzvYI7XAgWCVxrZYzktQO2cMMXp
   ytdnDgVVdXzjqCbHzUXC3U+7uaM3vEYYTE+hJnPvcdEzvhr+HtnwcO3k2
   R7QR13XLPVCkEgyIDM0SR7dFxCkD6RRl5lVs5ngfbjfBZecHDvbASHcaU
   rJBg473hcmA2oyWxcITMTme/GM1RqrRB36m1GKg7FYnQo9WK7rk4jRr4t
   w==;
X-IronPort-AV: E=Sophos;i="5.98,230,1673884800"; 
   d="scan'208";a="329040642"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2023 16:26:52 +0800
IronPort-SDR: KmiLXwTyOauNUKaHsycV713VWOz0u4gdivvnlpmK9D/3L4tNqug+DSTTJ4wKLvZKqL+AvBMRzT
 SXseilaQyaAGn7sfTVv7mof0J9NKDZlnY63kIaBJiWt1ccG0Jc8XRotxfm//r43b7Miv0vgMFB
 iNOmYfJwaPhVuGdnNht+2WN8q13HdB2Si0CMk8lWIxcRI0xhBaxoe9oMdaA7mZ52nlDlAOWxmU
 0sSvcearIh11hIBW/9C/SonTJIOlUx9wAKA3beG/o6yv2X4vN/5Yvji/8h+IQOteUidQA1rU8S
 b+Y=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 23:43:36 -0800
IronPort-SDR: BZP5dvnTqKlUsRuBj4urdvZDALjKI6SL8r0NTkx9HPDIunxTKxKDvZ/EDTVaJpOxQ/qtfjZdtC
 Vez9E3sVUzs73ITwmZBf2iYDSxw3svzezzqeXJ+KBBfxofKD8A9ohr1MBGLU1lfHR6+iK5qY2y
 d6QHDfexLGY3HF7whs7DjgMJOE+qPTjqONTrsa7K4d4wRYafuaLMPS2ndqsFXV1LZAA5XMZ3IP
 Dw6p/0h/EpRdlHUw1/NE3vR4c9AsKpcMHcnb2jvd87LwWoaZR6MomDyZfL94AYb8A+ko2+iSqC
 PLU=
WDCIronportException: Internal
Received: from 5cg21741p5.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.181])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Mar 2023 00:26:51 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [RFC PATCH 0/2] btrfs: zoned: replace active_total_bytes system
Date:   Fri,  3 Mar 2023 17:26:42 +0900
Message-Id: <cover.1677831912.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series is still not well tested. Please don't merge right now.

The space_info->active_total_bytes is misleading. It counts not only active
block groups but also previously active but now inactive (full BGs, due to
fully written) ones. That results in a bug not counting the full BGs into
active_total_bytes.

Instead, we can count a newly allocated block group's region as
zone_unusable. Then, once that block group is activated, subtract [0
.. zone_capcity] from the zone_unusable counters. With this, the regualr
space_info's accounting code will align naturally for zone activation
support.

Naohiro Aota (2):
  btrfs: zoned: count fresh BG region as zone unusable
  btrfs: zoned: drop space_info->active_total_bytes

 fs/btrfs/block-group.c      |  6 ------
 fs/btrfs/free-space-cache.c |  8 +++++++-
 fs/btrfs/space-info.c       | 40 +++++++++----------------------------
 fs/btrfs/space-info.h       |  2 --
 fs/btrfs/zoned.c            | 26 ++++++++++++++++--------
 5 files changed, 34 insertions(+), 48 deletions(-)

-- 
2.39.2

