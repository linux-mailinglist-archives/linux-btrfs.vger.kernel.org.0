Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C17146339
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 09:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgAWIS4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 03:18:56 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43985 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWIS4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 03:18:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579767536; x=1611303536;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jcLZBbvfhWy3rYdG/4Qj+FusaqmCn/9B1rKr6Dy0bNg=;
  b=qRGFCI/IyGNKW5/Sh658eTepzCnAODEuxh4d795cNB2m7oefE9XTYGY/
   HehSTQsY3ct4CN28JmP4B7k03TP3RvqhEOOpuxk+r5eirRouZVNVPgvcs
   a8gLILmnSn49SAl+kUShXsp5dNdoNsAFEH69zBaPlkXoZo3uEPjDWkTJ9
   KAp2zerKqXdBzvjXU9VDe+G62wDLNuAlNjPvspm94QAdnNUAPyuItFlDk
   8H6WMEu09fzgWdzgAN/YqqEvr2E8QUMpeh8SfS0YUKrAnvUXGTY4Uw6PD
   sMWlcnDGbGCVQdVpIHJFIxSAeuHfni2dB/oHtM6gull0oTEmdJ71fmn6F
   w==;
IronPort-SDR: aYpoH5HDN0rUzLcrXI8VI6jSCBJdZ3RQtDgX5QakaFku6UvKzAi9BdYbthKzdnDuP9U9KNswIT
 ys2duth2/gZwyHFtaDt3cILyu2BK+GgXbbLIsZ0EJ5LLOlnqYct8QIfK/HRFRbxbKJALMtFj7R
 QNIjLL2Jf3FQDGEvojvHQZCLCiEUYjMuhfgMP0puwzVpCkjODbyV4vyOvFbVcaXMDYGlQrCZO8
 y8bzHrgoh2gr4hh6NXtmsbgujDqDALx+OX+2MXLt06y7tAqQ2tGLsEC2GQGw7RfRFG7WO4kff4
 hUs=
X-IronPort-AV: E=Sophos;i="5.70,353,1574092800"; 
   d="scan'208";a="129708686"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2020 16:18:56 +0800
IronPort-SDR: kH2f+qYK0dfqDrfZ2xeawdsgtZ3bhF2co+sxrZ4WSpec/2FwFRo2SAWZFVxFtIp4wK12TpKR8I
 dZhGbV0ej93paxtQFRO1GLKvgcOyJxoVjMCbgpmP1EJRjvP7D+QDTc2nfglHWdqTLDUpemDAhV
 fIBk6zPJUDxEdL5CqbGn8dFUQmPBt2DgYfT6QcoJXi8z7nLk0lnOrOa15a2Dww062gzFV8zF2W
 6MHOB0EtUZRdP2f6QB1sry2H6fVNCxBAqGlXNbZxpevrlDpenYGz3uI0Tqyy75QJca6xSdlcNl
 m7fVQE/1eDfH6GCHCdHB9kiS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 00:12:18 -0800
IronPort-SDR: EVOAiHvxnYBtNR774alBoKoRXW95sEiqbb1/yTDc+uq1d1xAgmTDEu2PaL/QhJmAZ4Yfsl9Nax
 nx+DgdfWq2CE/c+uezTORieYz6zBetw0n5EJjUe9l8/1Kzrfvx/StSvHovXtTMdC0ylvFewjJa
 HfLENniH7v6c5Lr6YyNh6hIRahYvAwYhyDY6TPS9L1dCULZyOouF7hDXN/qsKeXb1WEJNHCCTu
 vmNONSO81rUBfbotcJK0sofRWDTeUuEjGT0mkj3qH+6G4ry+N0+zwkAeR1jINUyX2A3ta8c5v7
 2JA=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2020 00:18:55 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/6] btrfs: remove buffer heads form superblock handling
Date:   Thu, 23 Jan 2020 17:18:43 +0900
Message-Id: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch series removes the use of buffer_heads from btrfs' super block read
and write paths. It also converts the integrity-checking code to only work
with pages and BIOs.

Compared to buffer heads, this gives us a leaner call path, as the
buffer_head code wraps around getting pages from the page-cache and adding
them to BIOs to submit.

The first patch is from Nikolay and exports btrfs_release_disk_super(), so it
can be used in the patchews follwing in this series.
The second patch removes buffer_heads from superblock reading.
The third from super_block writing and the subsequent patches remove the
buffer_heads from the integrity check code.

It's based on misc-next from Wednesday January 22, and doesn't show any
regressions in xfstests to the baseline.

Cahnges to v1:
- Added patch #1
- Converted sb reading and integrity checking to use the page cache
- Added rationale behind the conversion to the commit messages.
- For more details see the idividual patches.

Johannes Thumshirn (5):
  btrfs: remove buffer heads from super block reading
  btrfs: remove use of buffer_heads from superblock writeout
  btrfs: remove btrfsic_submit_bh()
  btrfs: remove buffer_heads from btrfsic_process_written_block()
  btrfs: remove buffer_heads form superblock mirror integrity checking

Nikolay Borisov (1):
  btrfs: export btrfs_release_disk_super

 fs/btrfs/check-integrity.c | 204 ++++++++++---------------------------
 fs/btrfs/check-integrity.h |   2 -
 fs/btrfs/disk-io.c         | 194 +++++++++++++++++++++--------------
 fs/btrfs/disk-io.h         |   4 +-
 fs/btrfs/volumes.c         |  64 +++++++-----
 fs/btrfs/volumes.h         |   3 +-
 6 files changed, 216 insertions(+), 255 deletions(-)

-- 
2.24.1

