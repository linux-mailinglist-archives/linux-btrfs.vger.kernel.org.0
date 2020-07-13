Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C8321D5ED
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 14:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgGMM3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 08:29:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19768 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbgGMM3I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 08:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594643346; x=1626179346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q5X8joau2jxAKMReWzvzMyP9nZGN3ttToFkOyvybTvM=;
  b=L0QJErhpLhoAR3EAQ5qtG+CEn07p+LsxodEHgWzRdsNbMDNX2eJ8Aprx
   /gX7KWxOrGbevhD5F0GXsVvNOENdn6lC0F91d5W1YBgkhxnCbjwavaiQG
   hHGm8HiBoMlr5FD98nf81oZWrzdUnalxaVeLnVDfniiceV10b0tVD27gX
   3WObva4kfijKs8GsApUtcEhfd8SzFaxJMprVsdstAag3wu77ne5hRtgNJ
   Ij2azuTFUeeg7JpSX+OFK3ua/wJNIjosFBcT+z6kQmJF58sanuYpUNQ5U
   UE33/wv8XJ6EVUQAkC72HYrZWuuuUSlkfVo/SFbZpVgyEQbVYjb5sA9zl
   w==;
IronPort-SDR: 9+eKftKQ4chte5Qy58oNaK3ULE8HNy7N16Un4P4W2cuKs1URqymW+e8O8zo7SYHnsW5k0Ht+Ow
 ib8b/d8WU0W61X3L/rSkmgAMGbaNDCzXjSRYKWnZjaj/wXqoeYeLHDP0dOerIW9OyfM7meUOdO
 PwJOf66cRQuhGk2FnF5mEK9DhTbEod1kRcZabtFsuaPF8GI+l9DNDQc3ymFeksiyDIUjWYryBt
 Vv3Gn5qjKFLjPirlA0PZ6aD1phKe4jbw5MCG1+hVZykfS0M5b+eGlYQTQtEVZbUyj7aAO3rCKv
 AgE=
X-IronPort-AV: E=Sophos;i="5.75,347,1589212800"; 
   d="scan'208";a="142312948"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2020 20:29:06 +0800
IronPort-SDR: mgROrtDtYzuvIIxzj9Z0aaxA2tNSj0T864d4J1oihIXV4BDy3CPD0wyNMkMrDTJtqILcKNNtHW
 Mf7u8rNf9qyelMhC89dRFP08PpZXzjLCo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 05:17:36 -0700
IronPort-SDR: QRdYNQrxQXRyrcvw3SBEBFyPD3iruigWuY/gYyhQCUmhbCMnYNlgAeSjK2ho31z1lsZbG5OIkR
 B6dj7PTTx6Tg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 05:29:06 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 0/4] Two furhter additions for fsinfo ioctl
Date:   Mon, 13 Jul 2020 21:28:57 +0900
Message-Id: <20200713122901.1773-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series extents the fsinfo ioctl by adding two new often requested
members, the filesystem generation and the metadata UUID. Both can be
retrieved from the kernel by setting the appropriate flag in the ioctl
structure.

The last patch adds a compile time assertion on the structure sizes, so we're
not accidentally breaking size assumptions.

The series was tested using the following test tool, strace support will be
written once the kernel side is accepted.

--- 8< ---
#include <linux/types.h>
#include <linux/btrfs.h>

#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

struct btrfs_ioctl_fs_info_args_new {
	__u64 max_id;                           /* out */
	__u64 num_devices;                      /* out */
	__u8 fsid[BTRFS_FSID_SIZE];             /* out */
	__u32 nodesize;                         /* out */
	__u32 sectorsize;                       /* out */
	__u32 clone_alignment;                  /* out */
	__u16 csum_type;
	__u16 csum_size;
	__u64 flags;                            /* out */
	__u64 generation;
	__u8 metadata_uuid[BTRFS_FSID_SIZE];
	__u8 reserved[944];                    /* pad to 1k */
};

#define BTRFS_FS_INFO_FLAG_CSUM_TYPE_SIZE	(1 << 0)
#define BTRFS_FS_INFO_FLAG_GENERATION		(1 << 1)
#define BTRFS_FS_INFO_FLAG_METADATA_UUID	(1 << 2)


static const char hex_chars[16] = "0123456789abcdef";
# define BYTE_HEX_CHARS(b_) \
	hex_chars[((uint8_t) (b_)) >> 4], hex_chars[((uint8_t) (b_)) & 0xf]

void format_uuid(const unsigned char *uuid, char *buf) 
{                                                                                                                                                                                    
	const char str[] = {                                                                                                                                                         
		BYTE_HEX_CHARS(uuid[0]),                                                                                                                                             
		BYTE_HEX_CHARS(uuid[1]),                                                                                                                                             
		BYTE_HEX_CHARS(uuid[2]),                                                                                                                                             
		BYTE_HEX_CHARS(uuid[3]),                                                                                                                                             
		'-',                                                                                                                                                                 
		BYTE_HEX_CHARS(uuid[4]),                                                                                                                                             
		BYTE_HEX_CHARS(uuid[5]),                                                                                                                                             
		'-',                                                                                                                                                                 
		BYTE_HEX_CHARS(uuid[6]),                                                                                                                                             
		BYTE_HEX_CHARS(uuid[7]),                                                                                                                                             
		'-',                                                                                                                                                                 
		BYTE_HEX_CHARS(uuid[8]),                                                                                                                                             
		BYTE_HEX_CHARS(uuid[9]),                                                                                                                                             
		'-',                                                                                                                                                                 
		BYTE_HEX_CHARS(uuid[10]),                                                                                                                                            
		BYTE_HEX_CHARS(uuid[11]),                                                                                                                                            
		BYTE_HEX_CHARS(uuid[12]),                                                                                                                                            
		BYTE_HEX_CHARS(uuid[13]),                                                                                                                                            
		BYTE_HEX_CHARS(uuid[14]),                                                                                                                                            
		BYTE_HEX_CHARS(uuid[15]),                                                                                                                                            
		'\0'                                                                                                                                                                 
	};                                                                                                                                                                           

	sprintf(buf, "%s", str);
}                                                      

int call_ioctl(int fd, bool csum, bool gen, bool meta)
{
	struct btrfs_ioctl_fs_info_args_new args = { 0 };
	char fsid[37], meta_uuid[37];
	int ret;

	if (csum)
		args.flags |= BTRFS_FS_INFO_FLAG_CSUM_TYPE_SIZE;
	if (gen)
		args.flags |= BTRFS_FS_INFO_FLAG_GENERATION;
	if (meta)
		args.flags |= BTRFS_FS_INFO_FLAG_METADATA_UUID;

	ret = ioctl(fd, BTRFS_IOC_FS_INFO, &args);
	if (ret < 0) {
		perror("ioctl");
		return ret;
	}

	format_uuid(args.fsid, fsid);
	format_uuid(args.metadata_uuid, meta_uuid);

	printf("\tfsid: %s\n", fsid);
	printf("\tmax_id: %llu\n", args.max_id);
	printf("\tnum_devices: %llu\n", args.num_devices);
	printf("\tnodesize: %u\n", args.nodesize);
	printf("\tsectorsize: %u\n", args.sectorsize);
	printf("\tclone_alignment: %u\n", args.clone_alignment);
	printf("\tflags: 0x%llx\n", args.flags);
	if (args.flags & BTRFS_FS_INFO_FLAG_CSUM_TYPE_SIZE) {
		printf("\tcsum_type: %u\n", args.csum_type);
		printf("\tcsum_size: %u\n", args.csum_size);
	}
	if (args.flags & BTRFS_FS_INFO_FLAG_GENERATION)
		printf("\tgeneration: %llu\n", args.generation);
	if (args.flags & BTRFS_FS_INFO_FLAG_METADATA_UUID)
		printf("\tmetadata UUID: %s\n", meta_uuid);

	return 0;
}

int main(int argc, char **argv)
{
	int fd, ret;

	if (argc != 2) {
		printf("Usage: %s file\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	fd = open(argv[1], O_RDWR);
	if (fd == -1) {
		perror("open");
		exit(1);
	}

	printf("%s: (old)\n", argv[1]);
	ret = call_ioctl(fd, false, false, false);
	if (ret)
		goto close_fd;

	printf("%s: (new)\n", argv[1]);
	ret = call_ioctl(fd, true, true, true);

close_fd:
	close(fd);
	exit(EXIT_SUCCESS);
}
--- >8 ---

Changes to v1:
- Fix "generation" to be u64 (Anand)
- Swap flags and csum_* and make flags u64 to not have holes (David)

Johannes Thumshirn (4):
  btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
  btrfs: add filesystem generation to fsinfo ioctl
  btrfs: add metadata_uuid to fsinfo ioctl
  btrfs: assert sizes of ioctl structures

 fs/btrfs/ioctl.c           | 27 ++++++++++++++++++++++++---
 include/uapi/linux/btrfs.h | 30 ++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 5 deletions(-)

-- 
2.26.2

