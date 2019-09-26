Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 550A3BEF3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 12:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfIZKG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 06:06:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:49236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfIZKG4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 06:06:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CEFEBAEB8;
        Thu, 26 Sep 2019 10:06:53 +0000 (UTC)
Subject: Re: [PATCH v5 5/7] btrfs-progs: add xxhash64 to mkfs
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190925133728.18027-1-jthumshirn@suse.de>
 <20190925133728.18027-6-jthumshirn@suse.de>
From:   Johannes Thumshirn <jthumshirn@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=jthumshirn@suse.de; prefer-encrypt=mutual; keydata=
 xsFNBFTTwPEBEADOadCyru0ZmVLaBn620Lq6WhXUlVhtvZF5r1JrbYaBROp8ZpiaOc9YpkN3
 rXTgBx+UoDGtnz9DZnIa9fwxkcby63igMPFJEYpwt9adN6bA1DiKKBqbaV5ZbDXR1tRrSvCl
 2V4IgvgVuO0ZJEt7gakOQlqjQaOvIzDnMIi/abKLSSzYAThsOUf6qBEn2G46r886Mk8MwkJN
 hilcQ7F5UsKfcVVGrTBoim6j69Ve6EztSXOXjFgsoBw4pEhWuBQCkDWPzxkkQof1WfkLAVJ2
 X9McVokrRXeuu3mmB+ltamYcZ/DtvBRy8K6ViAgGyNRWmLTNWdJj19Qgw9Ef+Q9O5rwfbPZy
 SHS2PVE9dEaciS+EJkFQ3/TBRMP1bGeNbZUgrMwWOvt37yguvrCOglbHW+a8/G+L7vz0hasm
 OpvD9+kyTOHjqkknVJL69BOJeCIVUtSjT9EXaAOkqw3EyNJzzhdaMXcOPwvTXNkd8rQZIHft
 SPg47zMp2SJtVdYrA6YgLv7OMMhXhNkUsvhU0HZWUhcXZnj+F9NmDnuccarez9FmLijRUNgL
 6iU+oypB/jaBkO6XLLwo2tf7CYmBYMmvXpygyL8/wt+SIciNiM34Yc+WIx4xv5nDVzG1n09b
 +iXDTYoWH82Dq1xBSVm0gxlNQRUGMmsX1dCbCS2wmWbEJJDEeQARAQABzSdKb2hhbm5lcyBU
 aHVtc2hpcm4gPGp0aHVtc2hpcm5Ac3VzZS5kZT7CwYAEEwEIACoCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AFCQo9ta8FAlohZmoCGQEACgkQA5OWnS12CFATLQ//ajhNDVJLK9bjjiOH
 53B0+hCrRBj5jQiT8I60+4w+hssvRHWkgsujF+V51jcmX3NOXeSyLC1Gk43A9vCz5gXnqyqG
 tOlYm26bihzG02eAoWr/glHBQyy7RYcd97SuRSv77WzuXT3mCnM15TKiqXYNzRCK7u5nx4eu
 szAU+AoXAC/y1gtuDMvANBEuHWE4LNQLkTwJshU1vwoNcTSl+JuQWe89GB8eeeMnHuY92T6A
 ActzHN14R1SRD/51N9sebAxGVZntXzSVKyMID6eGdNegWrz4q55H56ZrOMQ6IIaa7KSz3QSj
 3E8VIY4FawfjCSOuA2joemnXH1a1cJtuqbDPZrO2TUZlNGrO2TRi9e2nIzouShc5EdwmL6qt
 WG5nbGajkm1wCNb6t4v9ueYMPkHsr6xJorFZHlu7PKqB6YY3hRC8dMcCDSLkOPWf+iZrqtpE
 odFBlnYNfmAXp+1ynhUvaeH6eSOqCN3jvQbITUo8mMQsdVgVeJwRdeAOFhP7fsxNugii721U
 acNVDPpEz4QyxfZtfu9QGI405j9MXF/CPrHlNLD5ZM5k9NxnmIdCM9i1ii4nmWvmz9JdVJ+8
 6LkxauROr2apgTXxMnJ3Desp+IRWaFvTVhbwfxmwC5F3Kr0ouhr5Kt8jkQeD/vuqYuxOAyDI
 egjo3Y7OGqct+5nybmbOwU0EVNPA8QEQAN/79cFVNpC+8rmudnXGbob9sk0J99qnwM2tw33v
 uvQjEGAJTVCOHrewDbHmqZ5V1X1LI9cMlLUNMR3W0+L04+MH8s/JxshFST+hOaijGc81AN2P
 NrAQD7IKpA78Q2F3I6gpbMzyMy0DxmoKF73IAMQIknrhzn37DgM+x4jQgkvhFMqnnZ/xIQ9d
 QEBKDtfxH78QPosDqCzsN9HRArC75TiKTKOxC12ZRNFZfEPnmqJ260oImtmoD/L8QiBsdA4m
 Mdkmo6Pq6iAhbGQ5phmhUVuj+7O8rTpGRXySMLZ44BimM8yHWTaiLWxCehHgfUWRNLwFbrd+
 nYJYHoqyFGueZFBNxY4bS2rIEDg+nSKiAwJv3DUJDDd/QJpikB5HIjg/5kcSm7laqfbr1pmC
 ZbR2JCTp4FTABVLxt7pJP40SuLx5He63aA/VyxoInLcZPBNvVfq/3v3fkoILphi77ZfTvKrl
 RkDdH6PkFOFpnrctdTWbIFAYfU96VvySFAOOg5fsCeLv9/zD4dQEGsvva/qKZXkH/l2LeVp3
 xEXoFsUZtajPZgyRBxer0nVWRyeVwUQnLG8kjEOcZzX27GUpughi8w42p4oMD+96tr3BKTAr
 guRHJnU1M1xwRPbw5UsNXEOgYsFc8cdto0X7hQ2Ugc07CRSDvyH50IKXf2++znOTXFDhABEB
 AAHCwV8EGAECAAkFAlTTwPECGwwACgkQA5OWnS12CFAdRg//ZGV0voLRjjgX9ODzaz6LP+IP
 /ebGLXe3I+QXz8DaTkG45evOu6B2J53IM8t1xEug0OnfnTo1z0AFg5vU53L24LAdpi12CarV
 Da53WvHzG4BzCVGOGrAvJnMvUXf0/aEm0Sen2Mvf5kvOwsr9UTHJ8N/ucEKSXAXf+KZLYJbL
 NL4LbOFP+ywxtjV+SgLpDgRotM43yCRbONUXEML64SJ2ST+uNzvilhEQT/mlDP7cY259QDk7
 1K6B+/ACE3Dn7X0/kp8a+ZoNjUJZkQQY4JyMOkITD6+CJ1YsxhX+/few9k5uVrwK/Cw+Vmae
 A85gYfFn+OlLFO/6RGjMAKOsdtPFMltNOZoT+YjgAcW6Q9qGgtVYKcVOxusL8C3v8PAYf7Ul
 Su7c+/Ayr3YV9Sp8PH4X4jK/zk3+DDY1/ASE94c95DW1lpOcyx3n1TwQbwp6TzPMRe1IkkYe
 0lYj9ZgKaZ8hEmzuhg6FKXk9Dah+H73LdV57M4OFN8Xwb7v+oEG23vdsb2KBVG5K6Tv7Hb2N
 sfHWRdU3quYIistrNWWeGmfTlhVLgDhEmAsKZFH05QsAv3pQv7dH/JD+Tbn6sSnNAVrATff1
 AD3dXmt+5d3qYuUxam1UFGufGzV7jqG5QNStp0yvLP0xroB8y0CnnX2FY6bAVCU+CqKu+n1B
 LGlgwABHRtLCwe0EGAEIACAWIQTsOJyrwsTyXYYA0NADk5adLXYIUAUCWsTXAwIbAgCBCRAD
 k5adLXYIUHYgBBkWCAAdFiEEx1U9vxg1xAeUwus20p7yIq+KHe4FAlrE1wMACgkQ0p7yIq+K
 He6RfAEA+frSSvrHiuatNqvgYAJcraYhp1GQJrWSWMmi2eFcGskBAJyLp47etEn3xhJBLVVh
 2y2K4Nobb6ZgxA4Svfnkf7AAdicQALiaOKDwKD3tgf90ypEoummYzAxv8MxyPXZ7ylRnkheA
 eQDxuoc/YwMA4qyxhzf6K4tD/aT12XJd95gk+YAL6flGkJD8rA3jsEucPmo5eko4Ms2rOEdG
 jKsZetkdPKGBd2qVxxyZgzUkgRXduvyux04b9erEpJmoIXs/lE0IRbL9A9rJ6ASjFPGpXYrb
 73pb6Dtkdpvv+hoe4cKeae4dS0AnDc7LWSW3Ub0n61uk/rqpTmKuesmTZeB2GHzLN5GAXfNj
 ELHAeSVfFLPRFrjF5jjKJkpiyq98+oUnvTtDIPMTg05wSN2JtwKnoQ0TAIHWhiF6coGeEfY8
 ikdVLSZDEjW54Td5aIXWCRTBWa6Zqz/G6oESF+Lchu/lDv5+nuN04KZRAwCpXLS++/givJWo
 M9FMnQSvt4N95dVQE3kDsasl960ct8OzxaxuevW0OV/jQEd9gH50RaFif412DTrsuaPsBz6O
 l2t2TyTuHm7wVUY2J3gJYgG723/PUGW4LaoqNrYQUr/rqo6NXw6c+EglRpm1BdpkwPwAng63
 W5VOQMdnozD2RsDM5GfA4aEFi5m00tE+8XPICCtkduyWw+Z+zIqYk2v+zraPLs9Gs0X2C7X0
 yvqY9voUoJjG6skkOToGZbqtMX9K4GOv9JAxVs075QRXL3brHtHONDt6udYobzz+
Message-ID: <24e53bb4-7dd0-7016-8e06-ba271cdeb6c1@suse.de>
Date:   Thu, 26 Sep 2019 12:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925133728.18027-6-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/09/2019 15:37, Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  Makefile                  |  3 ++-
>  cmds/inspect-dump-super.c |  1 +
>  crypto/hash.c             | 17 +++++++++++++++++
>  crypto/hash.h             | 10 ++++++++++
>  ctree.h                   |  3 ++-
>  disk-io.c                 |  3 +++
>  mkfs/main.c               |  3 +++
>  7 files changed, 38 insertions(+), 2 deletions(-)
>  create mode 100644 crypto/hash.c
>  create mode 100644 crypto/hash.h
> 
> diff --git a/Makefile b/Makefile
> index 370e0c37ff65..45530749e2b9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -151,7 +151,8 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
>  	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
>  libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o btrfs-list.o \
>  		   kernel-lib/crc32c.o common/messages.o \
> -		   uuid-tree.o utils-lib.o common/rbtree-utils.o
> +		   uuid-tree.o utils-lib.o common/rbtree-utils.o \
> +		   crypto/hash.o crypto/xxhash.o
>  libbtrfs_headers = send-stream.h send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
>  	       kernel-lib/crc32c.h kernel-lib/list.h kerncompat.h \
>  	       kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
> diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
> index bf380ad2b56a..73e986ed8ee8 100644
> --- a/cmds/inspect-dump-super.c
> +++ b/cmds/inspect-dump-super.c
> @@ -315,6 +315,7 @@ static bool is_valid_csum_type(u16 csum_type)
>  {
>  	switch (csum_type) {
>  	case BTRFS_CSUM_TYPE_CRC32:
> +	case BTRFS_CSUM_TYPE_XXHASH:
>  		return true;
>  	default:
>  		return false;
> diff --git a/crypto/hash.c b/crypto/hash.c
> new file mode 100644
> index 000000000000..58a3890bd467
> --- /dev/null
> +++ b/crypto/hash.c
> @@ -0,0 +1,17 @@
> +#include "crypto/hash.h"
> +#include "crypto/xxhash.h"
> +
> +int hash_xxhash(const u8 *buf, size_t length, u8 *out)
> +{
> +	XXH64_hash_t hash;
> +
> +	hash = XXH64(buf, length, 0);
> +	/*
> +	 * NOTE: we're not taking the canonical form here but the plain hash to
> +	 * be compatible with the kernel implementation!
> +	 */
> +	memcpy(out, &hash, 8);
> +
> +	return 0;
> +}
> +
> diff --git a/crypto/hash.h b/crypto/hash.h
> new file mode 100644
> index 000000000000..45c1ef17bc57
> --- /dev/null
> +++ b/crypto/hash.h
> @@ -0,0 +1,10 @@
> +#ifndef CRYPTO_HASH_H
> +#define CRYPTO_HASH_H
> +
> +#include "../kerncompat.h"
> +
> +#define CRYPTO_HASH_SIZE_MAX	32
> +
> +int hash_xxhash(const u8 *buf, size_t length, u8 *out);
> +
> +#endif
> diff --git a/ctree.h b/ctree.h
> index f70271dc658e..144c89eb4a36 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -166,7 +166,8 @@ struct btrfs_free_space_ctl;
>  
>  /* csum types */
>  enum btrfs_csum_type {
> -	BTRFS_CSUM_TYPE_CRC32   = 0,
> +	BTRFS_CSUM_TYPE_CRC32	= 0,
> +	BTRFS_CSUM_TYPE_XXHASH	= 1,
>  };
>  
>  #define BTRFS_EMPTY_DIR_SIZE 0
> diff --git a/disk-io.c b/disk-io.c
> index 72c672919cf9..59e297e2039c 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -34,6 +34,7 @@
>  #include "print-tree.h"
>  #include "common/rbtree-utils.h"
>  #include "common/device-scan.h"
> +#include "crypto/hash.h"
>  
>  /* specified errno for check_tree_block */
>  #define BTRFS_BAD_BYTENR		(-1)
> @@ -149,6 +150,8 @@ int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
>  		crc = crc32c(crc, data, len);
>  		put_unaligned_le32(~crc, out);
>  		return 0;
> +	case BTRFS_CSUM_TYPE_XXHASH:
> +		return hash_xxhash(data, len, out);
>  	default:
>  		fprintf(stderr, "ERROR: unknown csum type: %d\n", csum_type);
>  		ASSERT(0);
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 04509e788a52..da40e958fe0a 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -393,6 +393,9 @@ static enum btrfs_csum_type parse_csum_type(const char *s)
>  {
>  	if (strcasecmp(s, "crc32c") == 0) {
>  		return BTRFS_CSUM_TYPE_CRC32;
> +	} else if (strcasecmp(s, "xxhash64") == 0 ||
> +		   strcasecmp(s, "xxhash") == 0) {
> +		return BTRFS_CSUM_TYPE_XXHASH;
>  	} else {
>  		error("unknown csum type %s", s);
>  		exit(1);
> 

This one lost this hunk in ctree.c:

diff --git a/ctree.c b/ctree.c
index 5ad291d0f4ac..91d685ff90a4 100644
--- a/ctree.c
+++ b/ctree.c
@@ -43,6 +43,7 @@ static const struct btrfs_csum {
        const char name[14];
 } btrfs_csums[] = {
        [BTRFS_CSUM_TYPE_CRC32] = { 4, "crc32c" },
+       [BTRFS_CSUM_TYPE_XXHASH] = { 8, "xxhash64" },
 };

 u16 btrfs_super_csum_size(const struct btrfs_super_block *sb)

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany
(HRB 247165, AG München)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
