Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F0C21B7C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 16:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgGJOFR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 10:05:17 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44323 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGJOFR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 10:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594389916; x=1625925916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rnAETHzLMqNUS56Z28XS8eltITTdw1huUTKiqmi/caQ=;
  b=OLR2DGxlRvpGzowXX+E2hfALMRTi3z8dUtvB5ScvlFDDj15J5wfi2tuQ
   DFPqG7A7lGU0iSb/ATJixPjthItJ1I26uXYqtPpXIZG3+FmcNUV4oAx1H
   VGjZlm/0ipEuB2Pxikvg3c2CEh+U9+FQ6zc+ZrT7kp4hh9JF3pUpUOFJT
   xZaYWK5WEPGpa8qcB2v3YabYsN0ucKEhsnh/W3UgK9ZLISwkUsA00bR4i
   DWTq0j7Tt4HhpvY1+3hIeJCN7JWJKfwbXBPTqSKIT8B7nXsCcPRTjsUeu
   D1tl6jRPhp5F7shX5YAAWVzm+C8aWy0LUTY9i02/8Jl7PYo07X4nCniGf
   w==;
IronPort-SDR: Uo95mnw+zu2yKLQcfP0L16Z0qtbn7XOIJyHi3Z9XQMNwTfjLUQ9KsGdv6+GysC1/Rki1ymPejN
 dYex2JM1EdMsLj8rY4QHGu9AO1qtxI6yidpJggnLD5K5Su1eow0c35DG8MbOVJJCgtTKh/pecW
 CtXNQ/bDo4wvVSIGyQrtbNFuFRXha3u6/kH8b4l5LLTuAjvYTdLWFaf/fHO5Ut/3IE5AhThmnP
 pGu839pOyLwyhvtWrRZRHvd6jIuJAV1FGe99OSv0fPM2Dd1Y0aKf2gM1agOI7YM1k7b/yRkA5W
 +BA=
X-IronPort-AV: E=Sophos;i="5.75,336,1589212800"; 
   d="scan'208";a="143458171"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2020 22:05:16 +0800
IronPort-SDR: YgRWKMWG/fz2SCSQilXYKQo8iLngOEZz5CWW4YqXZJFMIyf9ulSMZxRYRAuac5qOnL71Rdydvz
 y9xgNbyfXOBhVAWDCwVJ1oFCd/lbSkem0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 06:53:50 -0700
IronPort-SDR: nXBQNiyjDroa3yrDa/j9nTBQQUtI4S5+zOCqZADp55Iyv8J379a5UtDwDxSBwAY9lW6Dt/J0Be
 0vRugre6BUCw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jul 2020 07:05:15 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 0/3] Two furhter additions for fsinfo ioctl
Date:   Fri, 10 Jul 2020 23:05:08 +0900
Message-Id: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
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
	__u32 flags;                            /* out */
	__u16 csum_type;
	__u16 csum_size;
	__u32 generation;
	__u8 metadata_uuid[BTRFS_FSID_SIZE];
	__u8 reserved[952];                    /* pad to 1k */
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
	printf("\tflags: 0x%x\n", args.flags);
	if (args.flags & BTRFS_FS_INFO_FLAG_CSUM_TYPE_SIZE) {
		printf("\tcsum_type: %u\n", args.csum_type);
		printf("\tcsum_size: %u\n", args.csum_size);
	}
	if (args.flags & BTRFS_FS_INFO_FLAG_GENERATION)
		printf("\tgeneration: %u\n", args.generation);
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

Johannes Thumshirn (3):
  btrfs: add filesystem generation to fsinfo ioctl
  btrfs: add metadata_uuid to fsinfo ioctl
  btrfs: assert sizes of ioctl structures

 fs/btrfs/ioctl.c           | 11 +++++++++++
 include/uapi/linux/btrfs.h | 19 +++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.26.2

