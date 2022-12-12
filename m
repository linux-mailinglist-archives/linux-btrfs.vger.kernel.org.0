Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F2D649A95
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Dec 2022 10:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiLLJDB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Dec 2022 04:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiLLJC5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Dec 2022 04:02:57 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0691C3C
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Dec 2022 01:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670835776; x=1702371776;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EfmdNIBSyvXhVt5452pDOu02J5xNrs96ojRW93ex67A=;
  b=fgZnkcCp4UI0SmBivMMv0vihOPTLu39wPc6hIcHfZe+1EUpjLgKoPF+Q
   noiGztEFmmIFOAiVxL9Y9/S1ZVwYQapj4R/+xxQDfJ+/djYifc0vKXF/v
   XCppHI+/D/kkJ6C6xDGQnOwwpTHqNxIJxX6O/lpW8HixGjAyo3vF0qqFy
   95DRZh2WMtLva1HoXoubmx5lOse+NEkQJj1qZAfUYahYpARovdH3bGR+T
   NwHqD1PM/rtYhilPfmYEMxqUIcOKtozYbODMIDC55uWVQGXadHZh69Q+4
   577VklWtmU+TxJbePZPICsIlt99CDBn/0mTVEtHw0En+XFSCx/c7eNvkc
   w==;
X-IronPort-AV: E=Sophos;i="5.96,237,1665417600"; 
   d="scan'208";a="322792936"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2022 17:02:55 +0800
IronPort-SDR: jhRWxaYi/Io6ZyOKZo63toKbNccPjwb4XF8Pjddcgy0Cz0T+hpYvdGRH2qcXsh28jtI6gzVzSt
 At7vRvdPCdZ7OiNURzeC2DiAjmtYLEMZ7uLJFyLgQcZTiIauzSKd/NDWVTIcJkDUHK7ql0kSOH
 +eHc9FYSslE5b+Jz27bMXFKMA+gN278zjSVWfGWd9EKxuj/kNJA64lcp/MyEcdOdoiHLF6cxQ6
 rC3s2my2wWjMw8/pRKiIfOCMUV8Zlo2FnOmhrCrpeFGDY81SftTnWxDs7iglv4EzWOpALU6FCC
 3ww=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2022 00:21:20 -0800
IronPort-SDR: EdGPa40h29S0f8j4BnlfcPaX9PMm4jhYgvHtxH8vJ6sCC/cuvMCCxtCBFuWPTt5voNASiRH+yP
 T6mQozY6EOhpLBh79OF12I69qIBTDQe8lYIUwN/eTQGYTc8aBZ/owmQpRWMNATa30Fma2mHWl/
 1LxZ9eL7vSYheX6KmBDh4CRrMnomj+MVyk9Zv1MnV/hKKk381u648gzSr3q02xltoFSFmvoGXo
 9pkyhL2yG7QotJgzklKQKkKgb5yT05b+OzwZkJS8PMYx7FyDlpTkOoqQobQdJG9aupyyoVchKg
 3IQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2022 01:02:56 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/4] btrfs: delayed_ref parameter cleanup
Date:   Mon, 12 Dec 2022 01:02:45 -0800
Message-Id: <cover.1670835448.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.38.1
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

While looking at the delayed_ref code for the RST series I've discovered, that
drop_delayed_ref is using a btrfs_trans_handle without even using it. After
having it removed I've identified more uses of the trans in the callchain that
are unused after drop_delayed_ref got rid of it.

Johannes Thumshirn (4):
  btrfs: drop unused trans parameter of drop_delayed_ref
  btrfs: remove trans parameter of merge_ref
  btrfs: drop trans parameter of insert_delayed_ref
  btrfs: directly pass in fs_info to btrfs_merge_delayed_refs

 fs/btrfs/delayed-ref.c | 24 ++++++++++--------------
 fs/btrfs/delayed-ref.h |  2 +-
 fs/btrfs/extent-tree.c |  4 ++--
 3 files changed, 13 insertions(+), 17 deletions(-)


base-commit: b7af0635c87ff78d6bd523298ab7471f9ffd3ce5
-- 
2.38.1

