Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB7CDFF3
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 13:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfJGLLa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 07:11:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:36541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfJGLLa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 07:11:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570446683;
        bh=l5ySSMr60TLF1NU82YNgGFZFchi9AmOC3IHEIJjxsIo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jEIMkUvlYgzV9eEn/coLQlm4RJCtzFXMkHT57m8r4p9TBrT57JDvvTtSgprtgRnhX
         AlznVAaCLfAOMNUsm6FD8JRgVmiadSTLXzldnAiBFh3EWzb8kwUK3bhYWcx4PW9Xy+
         HSvni8tTKeN+DEh7306A/uhEQ0NDfrgHFEbrbzEg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mkpf3-1hpGqb1irn-00mNZW; Mon, 07
 Oct 2019 13:11:23 +0200
Subject: Re: [PATCH v6] btrfs-progs: add xxhash64 to mkfs
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
References: <20190925133728.18027-6-jthumshirn@suse.de>
 <20190926101123.19486-1-jthumshirn@suse.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <493f3622-e650-59bd-0684-b79a2cb263d4@gmx.com>
Date:   Mon, 7 Oct 2019 19:11:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190926101123.19486-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YVXxmKxGVDb8ifHRErGKZWKllIvRMrjMS2HABnMZSE5hIAL/fdM
 sju6w6CHKB2w62Djvq6+ehrR+dxLgRwrPXJ9xDjsKZEzob/5f3QVrOmB/BUJeEhwviUdI40
 NYDwyzzNBUOz6GPXhrcHEQ2kkaTfbfKjibBVP2QWpfjtK4FOGIe7dLZXNu3ZBU5H/6Lw7DI
 6HRX1peneJts/sKhh7w1g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gaqSe6UXw+w=:yJgk2H2iBqEa2o28m76uIB
 v6ZSIaUMtO2wUJ93xuC0sS1llTMnuZVAMvFu97JzrYfG+7CoXaiKBa/Rf7KUm/VDyt/LsrS60
 tuJrJTNkDjNY/ZWnkTBHk4zbZeVxOZvvldBf+QFLj6SLYJuedGnUQA2lFS3GxePHDI9YdXD5G
 6bC8fQs+KGYbCyPsSNZITO7PaQzicugceoBRXKZv988FMS1aWsAqnjglr5clfvQ8+eRStfoBX
 5h9boIkgIl6nT2FyCCnSfoPwCsH0I3ArEqEKbLy0CeHMBTfDvD2ARfoJZqBTrz8yx8Xh4VeuQ
 8jVeBGK7ZsZiVDjwVLayhWPR5pZYpzbBDztz2q9AgMC9w7DT6em03lilnl5ZStC+Qn6kRXho1
 nDqB71GUIDLfjRHVI1Wp8E81mWHnxwxU1fFqAjlReywMsJEez24o5iLOOLLaZhBL5AgDVb3Nj
 SnsF/vQZbF2k1WnL2lF78cpMnfXBfDU0NiSc0yIJ3wyCfioHwPqNc4UcHpQJU5wS3OorXlr1e
 l9zdmg/vCvTuXWNMRMBoTU0g4AQFiE2W8sigKR9Rk+WXqRPTyR57N4ly3B8AMy0WP0prGlWe2
 ZgwG7SLwHMVnZLM7n011vuKnRG3VNm0OP6hGwOWG8/OxCkE1SWmjQ+RB6J3FzK72Pu+rEwrWl
 q0WZwdHoFWs8sDFKSbbAuhfFaxVIn/9lJD8NGqUv3FUA2lLdCk6PXTHTItOb61XdyLf6UBSIA
 WcuAbd9UXcO8mokBBwnDepME6yNuvebik699t9wSw3YO+eQkMoLjuJf2NNFbyICh8UsKw36nh
 LJAM2bfpmHpptr9N5Y0+LQix/IVWjQM07VObPqngPxFHTqj+riYHqGzWsGl8Pvuyr0JQXDqVv
 0wCuW8JqzpCL9b+2rrj/5joGuXrX955JcvrZCu0x4sjD83yJImtfVN57Tg3uE0zi9KCwyeBy1
 JgEJ7E2bbCK6bU4OKzcfsKabHLe91c304kWzBOEJp8JbkSLH6xgXZbDUthogP0qBY/umjIcd7
 RK6A2oy7Fzh5eGkOpE/eiz+/Btua1WvUNifgtctIgU94xgcoTqo68ybcqO15v7N0AhWcod2eh
 PSosgbOImstGqaGpHiEUcHLWcFRPXc9327r5uNDpLHDq/RHlhJemZufrxZ6gbx2pJcNUaVigP
 IPf9II1BPeKvNnE48W+jMc1x/YqG+r5LGUxb6XKFA8he6cRds3QyvnUAVjVIakgQ5QS6dcrQt
 XDXawkRE6jHos05ZafSUmQMmrzLWj7Z9HUZ6hyq18jfSMx8NpgxWkKrYv3qo=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/9/26 =E4=B8=8B=E5=8D=886:11, Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---

Not related to the patchset itself, but it would be pretty nice if we
check the sysfs interface to guess if we can mount the fs.

And if not supported, a warning (at stdout) will not hurt.

Thanks,
Qu

>
> Changes since v5:
> - add xxhash64 to hash table
>
>  Makefile                  |  3 ++-
>  cmds/inspect-dump-super.c |  1 +
>  crypto/hash.c             | 16 ++++++++++++++++
>  crypto/hash.h             | 10 ++++++++++
>  ctree.c                   |  1 +
>  ctree.h                   |  3 ++-
>  disk-io.c                 |  3 +++
>  mkfs/main.c               |  3 +++
>  8 files changed, 38 insertions(+), 2 deletions(-)
>  create mode 100644 crypto/hash.c
>  create mode 100644 crypto/hash.h
>
> diff --git a/Makefile b/Makefile
> index 370e0c37ff65..45530749e2b9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -151,7 +151,8 @@ cmds_objects =3D cmds/subvolume.o cmds/filesystem.o =
cmds/device.o cmds/scrub.o \
>  	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
>  libbtrfs_objects =3D send-stream.o send-utils.o kernel-lib/rbtree.o btr=
fs-list.o \
>  		   kernel-lib/crc32c.o common/messages.o \
> -		   uuid-tree.o utils-lib.o common/rbtree-utils.o
> +		   uuid-tree.o utils-lib.o common/rbtree-utils.o \
> +		   crypto/hash.o crypto/xxhash.o
>  libbtrfs_headers =3D send-stream.h send-utils.h send.h kernel-lib/rbtre=
e.h btrfs-list.h \
>  	       kernel-lib/crc32c.h kernel-lib/list.h kerncompat.h \
>  	       kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h =
\
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
> index 000000000000..8c428cba11f0
> --- /dev/null
> +++ b/crypto/hash.c
> @@ -0,0 +1,16 @@
> +#include "crypto/hash.h"
> +#include "crypto/xxhash.h"
> +
> +int hash_xxhash(const u8 *buf, size_t length, u8 *out)
> +{
> +	XXH64_hash_t hash;
> +
> +	hash =3D XXH64(buf, length, 0);
> +	/*
> +	 * NOTE: we're not taking the canonical form here but the plain hash t=
o
> +	 * be compatible with the kernel implementation!
> +	 */
> +	memcpy(out, &hash, 8);
> +
> +	return 0;
> +}
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
> diff --git a/ctree.c b/ctree.c
> index a52ccfe19f94..139ffd613da5 100644
> --- a/ctree.c
> +++ b/ctree.c
> @@ -43,6 +43,7 @@ static struct btrfs_csum {
>  	const char *name;
>  } btrfs_csums[] =3D {
>  	[BTRFS_CSUM_TYPE_CRC32] =3D { 4, "crc32c" },
> +	[BTRFS_CSUM_TYPE_XXHASH] =3D { 8, "xxhash64" },
>  };
>
>  u16 btrfs_super_csum_size(const struct btrfs_super_block *sb)
> diff --git a/ctree.h b/ctree.h
> index f70271dc658e..144c89eb4a36 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -166,7 +166,8 @@ struct btrfs_free_space_ctl;
>
>  /* csum types */
>  enum btrfs_csum_type {
> -	BTRFS_CSUM_TYPE_CRC32   =3D 0,
> +	BTRFS_CSUM_TYPE_CRC32	=3D 0,
> +	BTRFS_CSUM_TYPE_XXHASH	=3D 1,
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
> @@ -149,6 +150,8 @@ int btrfs_csum_data(u16 csum_type, const u8 *data, u=
8 *out, size_t len)
>  		crc =3D crc32c(crc, data, len);
>  		put_unaligned_le32(~crc, out);
>  		return 0;
> +	case BTRFS_CSUM_TYPE_XXHASH:
> +		return hash_xxhash(data, len, out);
>  	default:
>  		fprintf(stderr, "ERROR: unknown csum type: %d\n", csum_type);
>  		ASSERT(0);
> diff --git a/mkfs/main.c b/mkfs/main.c
> index f52e8b61a460..a6deddc47c69 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -392,6 +392,9 @@ static enum btrfs_csum_type parse_csum_type(const ch=
ar *s)
>  {
>  	if (strcasecmp(s, "crc32c") =3D=3D 0) {
>  		return BTRFS_CSUM_TYPE_CRC32;
> +	} else if (strcasecmp(s, "xxhash64") =3D=3D 0 ||
> +		   strcasecmp(s, "xxhash") =3D=3D 0) {
> +		return BTRFS_CSUM_TYPE_XXHASH;
>  	} else {
>  		error("unknown csum type %s", s);
>  		exit(1);
>
