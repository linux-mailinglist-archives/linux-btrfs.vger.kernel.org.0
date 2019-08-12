Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D42EB89721
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 08:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfHLGTf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 02:19:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbfHLGTe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 02:19:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D5700AC63
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2019 06:19:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs-progs: fsck-tests: Add test case for invalid root generation
Date:   Mon, 12 Aug 2019 14:19:08 +0800
Message-Id: <20190812061908.21002-4-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190812061908.21002-1-wqu@suse.com>
References: <20190812061908.21002-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The image contains a fs tree whose generation is over 100 larger than
super block generation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../041-invalid-root-generation/default_case.img | Bin 0 -> 3072 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 tests/fsck-tests/041-invalid-root-generation/default_case.img

diff --git a/tests/fsck-tests/041-invalid-root-generation/default_case.img b/tests/fsck-tests/041-invalid-root-generation/default_case.img
new file mode 100644
index 0000000000000000000000000000000000000000..4a2c8d88a1a885fb9bcae56adc98dcbe75681441
GIT binary patch
literal 3072
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

literal 0
HcmV?d00001

-- 
2.22.0

