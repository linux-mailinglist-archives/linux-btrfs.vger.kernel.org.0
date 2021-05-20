Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0458389D8B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 08:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhETGNB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 02:13:01 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48851 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhETGNB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 02:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621491099; x=1653027099;
  h=date:from:to:subject:message-id:mime-version;
  bh=kjckl+ZpuGwWW2o9irOq1/L2eY78zm1I/kyxtt6PpGA=;
  b=AaI1l6GAko0I2jTTuU18ndYoiWmCaaiA4bp6pVXPm95+8+4KpdWEUecc
   qunQGC+pCx7Qq3hhViG03Que7cTICU3rEyEri0ShcY2i6Xvf7RVKgk4zT
   qoFnS41yf22obVMSYMFbz9XmcHJQnTrf/uCeMs4N5tT10qR3D5Zx+VaJF
   jCUfsDFrkTx9pJ6Ew0GI9aCA+I7uFYpHU2XBAZ5koh/rVjErK5CBBqEBi
   4eZvfdVpeq9vpTNZ1sb7Byv1UdXe3090Wh5OH0gVnvxcdXjIyTJsmzDFM
   hI/ikHZp15F+RPi8qn6cfVR0LhkKuw23S6hFCNjImm0QHR9SYfcRW5QO8
   A==;
IronPort-SDR: HP9eKgO8pK6hhVpNVKe2iloo564pDV5Lls9vlrQ/q3cRqsvwl1F36uWRk1PZ30lbG46KOzjo1K
 yFd2uBVGOYShgJA10e/SlruHy0jxPyFSyd1cpjglEqixg9lRYr/AIv6pqezS/DsH3SGqDxFqrn
 Ih6qmYMxktrh1kGUwO2u9qLWnQOWDzOc6qbhvNFisIMNOHu59zKKcdcG3jNI2IcbFSn22BsR4I
 ym57WRUjWuU3EQckkwKYMEm4WDxZK36JglO3i6Uu3faW+dyF+zcpBFzL5XbVfoQyUZT43vXKG/
 C/4=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="173438661"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 14:11:39 +0800
IronPort-SDR: hhuMeQHHWNgqeeiNXdsFaIDT16gCTnK+4K9INlAIxtcrl51L9rJyLVhEN2+ntd8V3Yn5VtTVgu
 1V44rHaxACB//oG8hBM1dc5gPJLod/WqgazS+0yxtlZJ1+eSsX0s2ANxTCL3X9fFadclM3yJjl
 lwMeIEMIA9f8vIYfRxrv9cY5kkTZdB/QsE7PX5iWng3mD367IeS5o+7Szd0kbUK6zLvwdCYPOn
 vUuj23z0O9jK8pmmgJ6MX6QziPeV9YkAaGcWx3dNdAlSTU//U0/PNcfZLtdTVVhYUFowof3cx4
 N83TxcBU12dQzDW8ngvfgJOo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 22:51:17 -0700
IronPort-SDR: oscezB1JNbp/L8SRnNUmw2ekh2FplU99wl1mJf0knCjtqgBF4vJfdPqtDNeSJ18DhkGsUlmuKh
 0vbZC4pnZHYJjBH9mm2R1ZLLU0ze/ohcIwzmVtG/GiX+2oId9o9Sx2wb2EL93t61JtgZXAJGfX
 cEXf+zmnSJDIDMRYFQ2ZfFferjqbyFTBbF3MBeLt+xsMkAYHdUDnmCD6GuVaTPgKT4V1sbtnVQ
 6ejwHwW0Us8huBJEG6z4dMIWC5//HafQd+Reby9QCwIYidR+pKXQLcn12tV4a09WAY3EikmDe5
 dts=
WDCIronportException: Internal
Received: from jpf010043.ad.shared (HELO naota-xeon) ([10.225.52.46])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 23:11:39 -0700
Date:   Thu, 20 May 2021 15:11:38 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Subject: Behavior of btrfs_io_geometry()
Message-ID: <20210520061138.d775gajnfj7h2xu4@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a few questions about btrfs_io_geometry()'s behavior. 

While I'm testing zoned btrfs on ZNS drive with 2GB zone size, I hit
the following ASSERT in btrfs_submit_direct() by running fstests
btrfs/017.

static blk_qc_t btrfs_submit_direct(struct inode *inode, struct iomap *iomap,
		struct bio *dio_bio, loff_t file_offset)
{
...
	start_sector = dio_bio->bi_iter.bi_sector;
	submit_len = dio_bio->bi_iter.bi_size;

	do {
		logical = start_sector << 9;
		em = btrfs_get_chunk_map(fs_info, logical, submit_len);
...
		ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(dio_bio),
					    logical, submit_len, &geom);
...
		ASSERT(geom.len <= INT_MAX);

		clone_len = min_t(int, submit_len, geom.len);
...
		bio = btrfs_bio_clone_partial(dio_bio, clone_offset, clone_len);


On zoned btrfs, we create a SINGLE block group whose size is equal to
the device zone size, so we have a 2 GB SINGLE block group on a 2 GB
zone size drive. Then, on a SINGLE single block group,
btrfs_io_geometry() returns the remaining length from @logical to the
end of the block group regardless of the @len argument. Thus, with
@logical == 0, we get geom->len = 2 GB, which is larger than INT_MAX,
hitting the ASSERT.

I'm confusing because I'm not sure what the ASSERT wants to do. It
might want to guard btrfs_bio_clone_partial() (and bio_trim()) below?
But, since bio_trim() takes sector-based values, and the passed
"clone_offset" and "clone_len" is byte-based, we can technically allow
larger bytes than INT_MAX. (well, we might never build such large bio,
though). And, it looks meaningless to check geom->len here. Since, it
can be much larger than bio size on a SINGLE block group.

So, in summary, below are my questions.

1. About btrfs_bio_clone_partial()
  1.1 What is the meaning of geom->len?
      - Length from @logical to the stripe boundary? or
      - Length [logical, logical+len] can go without crossing the boundary?
  1.2 @len is currently unused in btrfs_bio_clone_partial(), is this correct?
  1.3 What should we fill into geom->len when the block group is SINGLE profile?

2. About the ASSERT
  2.1 Shouldn't we check submit_len (= bio's length) instead of geom->len ?
  2.2 Can't it be larger than INT_MAX? e.g., INT_MAX << SECTOR_SHIFT?

3. About btrfs_bio_clone_partial()
  3.1 We can change "int" to "u64" maybe?

