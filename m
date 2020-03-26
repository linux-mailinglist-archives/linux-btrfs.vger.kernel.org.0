Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2279193B72
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 10:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgCZJDX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 05:03:23 -0400
Received: from mail.nic.cz ([217.31.204.67]:34918 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgCZJDX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 05:03:23 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id A9CC4142F70;
        Thu, 26 Mar 2020 10:03:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1585213401; bh=B+yrrJyOjQAzfO3LFkEcPEy0hFVSrWmIa3NVGHnCHq4=;
        h=Date:From:To;
        b=sRyDoPXZV1rwYwRWynvcF1U1918e1nRs/c+aCz2bs3R83WHwPZomuGNgRi/ftGtlp
         bS5Q3hpcqDLv8sUGHf5XAY0p1Am4KzbwolvadNKHYHAsPDRT6RDiRYA8gcCguXdaaW
         IHEvI1IixRn8wF+q+CzFrisqEaDSiktQ5AWqJg08=
Date:   Thu, 26 Mar 2020 10:03:21 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH U-BOOT v2 3/3] fs: btrfs: Fix LZO false decompression
 error caused by pending zero
Message-ID: <20200326100321.6a854808@nic.cz>
In-Reply-To: <20200326053556.20492-4-wqu@suse.com>
References: <20200326053556.20492-1-wqu@suse.com>
        <20200326053556.20492-4-wqu@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,URIBL_BLOCKED,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 26 Mar 2020 13:35:56 +0800
Qu Wenruo <wqu@suse.com> wrote:

> For certain btrfs files with compressed file extent, uboot will fail to
> load it:
>=20
>   btrfs_read_extent_reg: disk_bytenr=3D14229504 disk_len=3D73728 offset=
=3D0 nr_bytes=3D131
>   072
>   decompress_lzo: tot_len=3D70770
>   decompress_lzo: in_len=3D1389
>   decompress_lzo: in_len=3D2400
>   decompress_lzo: in_len=3D3002
>   decompress_lzo: in_len=3D1379
>   decompress_lzo: in_len=3D88539136
>   decompress_lzo: header error, in_len=3D88539136 clen=3D65534 tot_len=3D=
62580
>=20
> NOTE: except the last line, all other lines are debug output.
>=20
> Btrfs lzo compression uses its own format to record compressed size
> (segment header, LE32).
>=20
> However to make decompression easier, we never put such segment header
> across page boundary.
>=20
> In above case, the xxd dump of the lzo compressed data looks like this:
>=20
> 00001fe0: 4cdc 02fc 0bfd 02c0 dc02 0d13 0100 0001  L...............
> 00001ff0: 0000 0008 0300 0000 0000 0011 0000|0000  ................
> 00002000: 4705 0000 0001 cc02 0000 0000 0000 1e01  G...............
>=20
> '|' is the "expected" segment header start position.
>=20
> But in that page, there are only 2 bytes left, can't contain the 4 bytes
> segment header.
>=20
> So btrfs compression will skip that 2 bytes, put the segment header in
> next page directly.
>=20
> Uboot doesn't have such check, and read the header with 2 bytes offset,
> result 0x05470000 (88539136), other than the expected result
> 0x00000547 (1351), resulting above error.
>=20
> Follow the btrfs-progs restore implementation, by introducing tot_in to
> record total processed bytes (including headers), and do proper page
> boundary skip to fix it.
>=20
> Please note that, current code base doesn't parse fs_info thus we can't
> grab sector size easily, so it uses PAGE_SIZE, and relying on fs open
> time check to exclude unsupported sector size.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Cc: Marek Behun <marek.behun@nic.cz>
> ---
>  fs/btrfs/compression.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 4ef44ce11485..b1884fc15ee0 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -9,6 +9,7 @@
>  #include <malloc.h>
>  #include <linux/lzo.h>
>  #include <linux/zstd.h>
> +#include <linux/compat.h>
>  #include <u-boot/zlib.h>
>  #include <asm/unaligned.h>
> =20
> @@ -16,7 +17,7 @@
>  #define LZO_LEN		4
>  static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dlen)
>  {
> -	u32 tot_len, in_len, res;
> +	u32 tot_len, tot_in, in_len, res;
>  	size_t out_len;
>  	int ret;
> =20
> @@ -24,9 +25,11 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8=
 *dbuf, u32 dlen)
>  		return -1;
> =20
>  	tot_len =3D le32_to_cpu(get_unaligned((u32 *)cbuf));
> +	tot_in =3D 0;
>  	cbuf +=3D LZO_LEN;
>  	clen -=3D LZO_LEN;
>  	tot_len -=3D LZO_LEN;
> +	tot_in +=3D LZO_LEN;
> =20
>  	if (tot_len =3D=3D 0 && dlen)
>  		return -1;
> @@ -36,6 +39,8 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 =
*dbuf, u32 dlen)
>  	res =3D 0;
> =20
>  	while (tot_len > LZO_LEN) {
> +		u32 rem_page;
> +
>  		in_len =3D le32_to_cpu(get_unaligned((u32 *)cbuf));
>  		cbuf +=3D LZO_LEN;
>  		clen -=3D LZO_LEN;
> @@ -44,6 +49,7 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8 =
*dbuf, u32 dlen)
>  			return -1;
> =20
>  		tot_len -=3D (LZO_LEN + in_len);
> +		tot_in +=3D (LZO_LEN + in_len);
> =20
>  		out_len =3D dlen;
>  		ret =3D lzo1x_decompress_safe(cbuf, in_len, dbuf, &out_len);
> @@ -56,6 +62,18 @@ static u32 decompress_lzo(const u8 *cbuf, u32 clen, u8=
 *dbuf, u32 dlen)
>  		dlen -=3D out_len;
> =20
>  		res +=3D out_len;
> +
> +		/*
> +		 * If the 4 bytes header does not fit to the rest of the page we
> +		 * have to move to next one, or we read some garbage.
> +		 */
> +		rem_page =3D PAGE_SIZE - (tot_in % PAGE_SIZE);
> +		if (rem_page < LZO_LEN) {
> +			cbuf +=3D rem_page;
> +			tot_in +=3D rem_page;
> +			clen -=3D rem_page;
> +			tot_len -=3D rem_page;
> +		}
>  	}
> =20
>  	return res;

Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
