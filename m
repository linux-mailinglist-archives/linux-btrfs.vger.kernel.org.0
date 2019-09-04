Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF5A7DE8
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 10:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfIDIcL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 04:32:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:45400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727544AbfIDIcL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Sep 2019 04:32:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BAD06AE89;
        Wed,  4 Sep 2019 08:32:09 +0000 (UTC)
Subject: Re: [PATCH v4 11/12] btrfs-progs: move crc32c implementation to
 crypto/
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190903150046.14926-1-jthumshirn@suse.de>
 <20190903150046.14926-12-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 mQINBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABtCNOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuY29tPokCOAQTAQIAIgUCWIo48QIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQcb6CRuU/KFc0eg/9GLD3wTQz9iZHMFbjiqTCitD7B6dTLV1C
 ddZVlC8Hm/TophPts1bWZORAmYIihHHI1EIF19+bfIr46pvfTu0yFrJDLOADMDH+Ufzsfy2v
 HSqqWV/nOSWGXzh8bgg/ncLwrIdEwBQBN9SDS6aqsglagvwFD91UCg/TshLlRxD5BOnuzfzI
 Leyx2c6YmH7Oa1R4MX9Jo79SaKwdHt2yRN3SochVtxCyafDlZsE/efp21pMiaK1HoCOZTBp5
 VzrIP85GATh18pN7YR9CuPxxN0V6IzT7IlhS4Jgj0NXh6vi1DlmKspr+FOevu4RVXqqcNTSS
 E2rycB2v6cttH21UUdu/0FtMBKh+rv8+yD49FxMYnTi1jwVzr208vDdRU2v7Ij/TxYt/v4O8
 V+jNRKy5Fevca/1xroQBICXsNoFLr10X5IjmhAhqIH8Atpz/89ItS3+HWuE4BHB6RRLM0gy8
 T7rN6ja+KegOGikp/VTwBlszhvfLhyoyjXI44Tf3oLSFM+8+qG3B7MNBHOt60CQlMkq0fGXd
 mm4xENl/SSeHsiomdveeq7cNGpHi6i6ntZK33XJLwvyf00PD7tip/GUj0Dic/ZUsoPSTF/mG
 EpuQiUZs8X2xjK/AS/l3wa4Kz2tlcOKSKpIpna7V1+CMNkNzaCOlbv7QwprAerKYywPCoOSC
 7P25Ag0EWIoHPgEQAMiUqvRBZNvPvki34O/dcTodvLSyOmK/MMBDrzN8Cnk302XfnGlW/YAQ
 csMWISKKSpStc6tmD+2Y0z9WjyRqFr3EGfH1RXSv9Z1vmfPzU42jsdZn667UxrRcVQXUgoKg
 QYx055Q2FdUeaZSaivoIBD9WtJq/66UPXRRr4H/+Y5FaUZx+gWNGmBT6a0S/GQnHb9g3nonD
 jmDKGw+YO4P6aEMxyy3k9PstaoiyBXnzQASzdOi39BgWQuZfIQjN0aW+Dm8kOAfT5i/yk59h
 VV6v3NLHBjHVw9kHli3jwvsizIX9X2W8tb1SefaVxqvqO1132AO8V9CbE1DcVT8fzICvGi42
 FoV/k0QOGwq+LmLf0t04Q0csEl+h69ZcqeBSQcIMm/Ir+NorfCr6HjrB6lW7giBkQl6hhomn
 l1mtDP6MTdbyYzEiBFcwQD4terc7S/8ELRRybWQHQp7sxQM/Lnuhs77MgY/e6c5AVWnMKd/z
 MKm4ru7A8+8gdHeydrRQSWDaVbfy3Hup0Ia76J9FaolnjB8YLUOJPdhI2vbvNCQ2ipxw3Y3c
 KhVIpGYqwdvFIiz0Fej7wnJICIrpJs/+XLQHyqcmERn3s/iWwBpeogrx2Lf8AGezqnv9woq7
 OSoWlwXDJiUdaqPEB/HmGfqoRRN20jx+OOvuaBMPAPb+aKJyle8zABEBAAGJAh8EGAECAAkF
 AliKBz4CGwwACgkQcb6CRuU/KFdacg/+M3V3Ti9JYZEiIyVhqs+yHb6NMI1R0kkAmzsGQ1jU
 zSQUz9AVMR6T7v2fIETTT/f5Oout0+Hi9cY8uLpk8CWno9V9eR/B7Ifs2pAA8lh2nW43FFwp
 IDiSuDbH6oTLmiGCB206IvSuaQCp1fed8U6yuqGFcnf0ZpJm/sILG2ECdFK9RYnMIaeqlNQm
 iZicBY2lmlYFBEaMXHoy+K7nbOuizPWdUKoKHq+tmZ3iA+qL5s6Qlm4trH28/fPpFuOmgP8P
 K+7LpYLNSl1oQUr+WlqilPAuLcCo5Vdl7M7VFLMq4xxY/dY99aZx0ZJQYFx0w/6UkbDdFLzN
 upT7NIN68lZRucImffiWyN7CjH23X3Tni8bS9ubo7OON68NbPz1YIaYaHmnVQCjDyDXkQoKC
 R82Vf9mf5slj0Vlpf+/Wpsv/TH8X32ajva37oEQTkWNMsDxyw3aPSps6MaMafcN7k60y2Wk/
 TCiLsRHFfMHFY6/lq/c0ZdOsGjgpIK0G0z6et9YU6MaPuKwNY4kBdjPNBwHreucrQVUdqRRm
 RcxmGC6ohvpqVGfhT48ZPZKZEWM+tZky0mO7bhZYxMXyVjBn4EoNTsXy1et9Y1dU3HVJ8fod
 5UqrNrzIQFbdeM0/JqSLrtlTcXKJ7cYFa9ZM2AP7UIN9n1UWxq+OPY9YMOewVfYtL8M=
Message-ID: <575fd0d7-eb2a-e896-170f-96a5a6b195d5@suse.com>
Date:   Wed, 4 Sep 2019 11:32:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903150046.14926-12-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.09.19 г. 18:00 ч., Johannes Thumshirn wrote:
> With the introduction of xxhash64 to btrfs-progs we created a crypto/
> directory for all the hashes used in btrfs (although no
> cryptographically secure hash is there yet).
> 
> Move the crc32c implementation from kernel-lib/ to crypto/ as well so we
> have all hashes consolidated.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>


> ---
>  Android.mk                      | 4 ++--
>  Makefile                        | 4 ++--
>  btrfs-crc.c                     | 2 +-
>  btrfs-find-root.c               | 2 +-
>  btrfs-sb-mod.c                  | 2 +-
>  btrfs.c                         | 2 +-
>  cmds/inspect-dump-super.c       | 2 +-
>  cmds/rescue-chunk-recover.c     | 2 +-
>  cmds/rescue-super-recover.c     | 2 +-
>  common/utils.c                  | 2 +-
>  convert/main.c                  | 2 +-
>  {kernel-lib => crypto}/crc32c.c | 2 +-
>  {kernel-lib => crypto}/crc32c.h | 0
>  disk-io.c                       | 2 +-
>  extent-tree.c                   | 2 +-
>  file-item.c                     | 2 +-
>  free-space-cache.c              | 2 +-
>  hash.h                          | 2 +-
>  image/main.c                    | 2 +-
>  image/sanitize.c                | 2 +-
>  library-test.c                  | 2 +-
>  mkfs/main.c                     | 2 +-
>  send-stream.c                   | 2 +-
>  23 files changed, 24 insertions(+), 24 deletions(-)
>  rename {kernel-lib => crypto}/crc32c.c (99%)
>  rename {kernel-lib => crypto}/crc32c.h (100%)
> 
> diff --git a/Android.mk b/Android.mk
> index e8de47eb4617..8288ba7356f4 100644
> --- a/Android.mk
> +++ b/Android.mk
> @@ -32,10 +32,10 @@ cmds_objects := cmds-subvolume.c cmds-filesystem.c cmds-device.c cmds-scrub.c \
>                 cmds-inspect-dump-super.c cmds-inspect-tree-stats.c cmds-fi-du.c \
>                 mkfs/common.c
>  libbtrfs_objects := send-stream.c send-utils.c kernel-lib/rbtree.c btrfs-list.c \
> -                   kernel-lib/crc32c.c messages.c \
> +                   crypto/crc32c.c messages.c \
>                     uuid-tree.c utils-lib.c rbtree-utils.c
>  libbtrfs_headers := send-stream.h send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
> -                   kernel-lib/crc32c.h kernel-lib/list.h kerncompat.h \
> +                   crypto/crc32c.h kernel-lib/list.h kerncompat.h \
>                     kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
>                     extent-cache.h extent_io.h ioctl.h ctree.h btrfsck.h version.h
>  blkid_objects := partition/ superblocks/ topology/
> diff --git a/Makefile b/Makefile
> index 45530749e2b9..c241c22d1018 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -150,11 +150,11 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
>  	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
>  	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
>  libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o btrfs-list.o \
> -		   kernel-lib/crc32c.o common/messages.o \
> +		   crypto/crc32c.o common/messages.o \
>  		   uuid-tree.o utils-lib.o common/rbtree-utils.o \
>  		   crypto/hash.o crypto/xxhash.o
>  libbtrfs_headers = send-stream.h send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
> -	       kernel-lib/crc32c.h kernel-lib/list.h kerncompat.h \
> +	       crypto/crc32c.h kernel-lib/list.h kerncompat.h \
>  	       kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
>  	       extent-cache.h extent_io.h ioctl.h ctree.h btrfsck.h version.h
>  libbtrfsutil_major := $(shell sed -rn 's/^\#define BTRFS_UTIL_VERSION_MAJOR ([0-9])+$$/\1/p' libbtrfsutil/btrfsutil.h)
> diff --git a/btrfs-crc.c b/btrfs-crc.c
> index bcf25df8b46a..c4f81fc65f67 100644
> --- a/btrfs-crc.c
> +++ b/btrfs-crc.c
> @@ -19,7 +19,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "common/utils.h"
>  
>  void print_usage(int status)
> diff --git a/btrfs-find-root.c b/btrfs-find-root.c
> index e46fa8723b33..741eb9a95ac5 100644
> --- a/btrfs-find-root.c
> +++ b/btrfs-find-root.c
> @@ -32,7 +32,7 @@
>  #include "kernel-lib/list.h"
>  #include "volumes.h"
>  #include "common/utils.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "extent-cache.h"
>  #include "find-root.h"
>  #include "common/help.h"
> diff --git a/btrfs-sb-mod.c b/btrfs-sb-mod.c
> index 105b556b0cf1..348991b39451 100644
> --- a/btrfs-sb-mod.c
> +++ b/btrfs-sb-mod.c
> @@ -24,7 +24,7 @@
>  #include <string.h>
>  #include <limits.h>
>  #include <byteswap.h>
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "disk-io.h"
>  
>  #define BLOCKSIZE (4096)
> diff --git a/btrfs.c b/btrfs.c
> index 6c8aabe24dc8..72dad6fb3983 100644
> --- a/btrfs.c
> +++ b/btrfs.c
> @@ -20,7 +20,7 @@
>  #include <getopt.h>
>  
>  #include "volumes.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "cmds/commands.h"
>  #include "common/utils.h"
>  #include "common/help.h"
> diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
> index f9f38751f429..ef3d9094e661 100644
> --- a/cmds/inspect-dump-super.c
> +++ b/cmds/inspect-dump-super.c
> @@ -32,7 +32,7 @@
>  #include "kernel-lib/list.h"
>  #include "common/utils.h"
>  #include "cmds/commands.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "common/help.h"
>  
>  static int check_csum_sblock(void *sb, int csum_size, u16 csum_type)
> diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
> index 329a608dfc6b..bf35693ddbfa 100644
> --- a/cmds/rescue-chunk-recover.c
> +++ b/cmds/rescue-chunk-recover.c
> @@ -36,7 +36,7 @@
>  #include "disk-io.h"
>  #include "volumes.h"
>  #include "transaction.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "common/utils.h"
>  #include "check/common.h"
>  #include "cmds/commands.h"
> diff --git a/cmds/rescue-super-recover.c b/cmds/rescue-super-recover.c
> index ea3a00caf56c..5d6bea836c8b 100644
> --- a/cmds/rescue-super-recover.c
> +++ b/cmds/rescue-super-recover.c
> @@ -31,7 +31,7 @@
>  #include "disk-io.h"
>  #include "kernel-lib/list.h"
>  #include "common/utils.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "volumes.h"
>  #include "cmds/commands.h"
>  #include "cmds/rescue.h"
> diff --git a/common/utils.c b/common/utils.c
> index f2a10cccca86..fa49c01ad102 100644
> --- a/common/utils.c
> +++ b/common/utils.c
> @@ -47,7 +47,7 @@
>  #include "ctree.h"
>  #include "disk-io.h"
>  #include "transaction.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "common/utils.h"
>  #include "common/path-utils.h"
>  #include "common/device-scan.h"
> diff --git a/convert/main.c b/convert/main.c
> index 5eb2a59fb68a..fdbddc846e39 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -102,7 +102,7 @@
>  #include "mkfs/common.h"
>  #include "convert/common.h"
>  #include "convert/source-fs.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "common/fsfeatures.h"
>  #include "common/box.h"
>  
> diff --git a/kernel-lib/crc32c.c b/crypto/crc32c.c
> similarity index 99%
> rename from kernel-lib/crc32c.c
> rename to crypto/crc32c.c
> index 36bb6f189971..bd6283d5baeb 100644
> --- a/kernel-lib/crc32c.c
> +++ b/crypto/crc32c.c
> @@ -8,7 +8,7 @@
>   *
>   */
>  #include "kerncompat.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include <inttypes.h>
>  #include <string.h>
>  #include <unistd.h>
> diff --git a/kernel-lib/crc32c.h b/crypto/crc32c.h
> similarity index 100%
> rename from kernel-lib/crc32c.h
> rename to crypto/crc32c.h
> diff --git a/disk-io.c b/disk-io.c
> index ce0b746f4db9..4093982cf3dc 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -29,7 +29,7 @@
>  #include "disk-io.h"
>  #include "volumes.h"
>  #include "transaction.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "common/utils.h"
>  #include "print-tree.h"
>  #include "common/rbtree-utils.h"
> diff --git a/extent-tree.c b/extent-tree.c
> index 932af2c644bd..a8f57776bd73 100644
> --- a/extent-tree.c
> +++ b/extent-tree.c
> @@ -26,7 +26,7 @@
>  #include "disk-io.h"
>  #include "print-tree.h"
>  #include "transaction.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "volumes.h"
>  #include "free-space-cache.h"
>  #include "free-space-tree.h"
> diff --git a/file-item.c b/file-item.c
> index c6e9d212bcab..64af57693baf 100644
> --- a/file-item.c
> +++ b/file-item.c
> @@ -24,7 +24,7 @@
>  #include "disk-io.h"
>  #include "transaction.h"
>  #include "print-tree.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "common/internal.h"
>  
>  #define MAX_CSUM_ITEMS(r, size) ((((BTRFS_LEAF_DATA_SIZE(r->fs_info) - \
> diff --git a/free-space-cache.c b/free-space-cache.c
> index 8a57f86dc650..6e7d7e1ef561 100644
> --- a/free-space-cache.c
> +++ b/free-space-cache.c
> @@ -22,7 +22,7 @@
>  #include "transaction.h"
>  #include "disk-io.h"
>  #include "extent_io.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "kernel-lib/bitops.h"
>  #include "common/internal.h"
>  #include "common/utils.h"
> diff --git a/hash.h b/hash.h
> index 5398e8869316..51e842047093 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -19,7 +19,7 @@
>  #ifndef __BTRFS_HASH_H__
>  #define __BTRFS_HASH_H__
>  
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  
>  static inline u64 btrfs_name_hash(const char *name, int len)
>  {
> diff --git a/image/main.c b/image/main.c
> index 1265152cf524..92ee28d7fe1a 100644
> --- a/image/main.c
> +++ b/image/main.c
> @@ -28,7 +28,7 @@
>  #include <getopt.h>
>  
>  #include "kerncompat.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "ctree.h"
>  #include "disk-io.h"
>  #include "transaction.h"
> diff --git a/image/sanitize.c b/image/sanitize.c
> index 9caa5deaf2dd..cd2bd6fe2379 100644
> --- a/image/sanitize.c
> +++ b/image/sanitize.c
> @@ -18,7 +18,7 @@
>  #include "common/internal.h"
>  #include "common/messages.h"
>  #include "common/utils.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "image/sanitize.h"
>  #include "extent_io.h"
>  
> diff --git a/library-test.c b/library-test.c
> index c44bad228e50..e47917c25830 100644
> --- a/library-test.c
> +++ b/library-test.c
> @@ -21,7 +21,7 @@
>  #include "version.h"
>  #include "kernel-lib/rbtree.h"
>  #include "kernel-lib/radix-tree.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "kernel-lib/list.h"
>  #include "kernel-lib/sizes.h"
>  #include "ctree.h"
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 64806dac7706..a46205e7237f 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -45,7 +45,7 @@
>  #include "common/rbtree-utils.h"
>  #include "mkfs/common.h"
>  #include "mkfs/rootdir.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "common/fsfeatures.h"
>  #include "common/box.h"
>  
> diff --git a/send-stream.c b/send-stream.c
> index 08687e5e6904..3b8ada2110aa 100644
> --- a/send-stream.c
> +++ b/send-stream.c
> @@ -21,7 +21,7 @@
>  
>  #include "send.h"
>  #include "send-stream.h"
> -#include "kernel-lib/crc32c.h"
> +#include "crypto/crc32c.h"
>  #include "common/utils.h"
>  
>  struct btrfs_send_stream {
> 
