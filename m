Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36687372393
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 01:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhECX0d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 19:26:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:49465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhECX0c (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 May 2021 19:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620084327;
        bh=KB0Oh6XPX8oJH+pi7jDCLfhvFyY1EB2+NrSHLWL/Sg8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UC94bpyK/CcAf7s9nJuLYDYEZFZFGXRhx6hLcbn4l8FeOuv5yAyFWrGHHBYYhEvjy
         z9PZjnHXF8exwe14Swb8oApKG2fICf5m3BYvrD6pFa/TR6ed6ptsXDismuFcPDK9kZ
         kEtiQ0OTSDFJXoKXh8krB0oZbteC6F7AwomWViBg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEUz4-1lkuo02ciA-00G19t; Tue, 04
 May 2021 01:25:27 +0200
Subject: Re: [PATCH 04/49] btrfs: Use U-Boot API for decompression
To:     Simon Glass <sjg@chromium.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>
Cc:     Tom Rini <trini@konsulko.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Bin Meng <bmeng.cn@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Andre Przywara <andre.przywara@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Marek Behun <marek.behun@nic.cz>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210503231136.744283-1-sjg@chromium.org>
 <20210503171001.4.I7327e42043265556e3988928849ff2ebdc7b21e6@changeid>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <42a9733a-75d2-07f8-4ee3-08946e015546@gmx.com>
Date:   Tue, 4 May 2021 07:25:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503171001.4.I7327e42043265556e3988928849ff2ebdc7b21e6@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k+vP6NTzJaQQh11U7mkFx3RNb4dySmrU3B1H6uE29QzCZlON38Y
 +M6V6e8rky51zho3AvXe6sE+cHOwSG1TOV1NrBnm0QYwRMtOWOv8mzEFoK8z8NCSj+eoRWQ
 DpAlyFVh4jDnqa25b1jxtYs2xoANZk08TUbQ8+D3kWDEovoLMmYVgVdOqhQ32pyWifNxF+A
 EfTVSWG6VVmZ+sFToCyTg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+TtxWNDjtFI=:aYv6MH2lsNGNuCVzjgVoV4
 HoF6LsQJSgmgybsEwHuOQOTrVf2rB9jhdmcn5PzqUgyvQcD0mnnePUr83/AX+ODM9Susylrsq
 MQkvGX9qQvjRB4/gjoJ30h8t9ooUc9hjx0EVrCjedP1MuRN6YoVxTCzaoX3XJ69mlvRqTrvCb
 bcZhH63rmLb/CwfPC6qaUaQpF872taKfk91NNql/+10+PZqSleH/x09tlLCe3TDn9jHcPETEv
 ZW5EaEX6y7vzM4jnS5tQEWMu4IuAhbs+HKtZBnQQOIzMplKBXz/l3kVql+tLsDFkcbPOBXPBE
 e+nqMD70gCKRb38DFMLrsAmMfDMGoBXpaxUWK8CFa8x7HiHsPzRPjWFcyeTcOI4zNz7DGyGxt
 mccPcIkfmuvuOPRAp/4iwiLE50l54s6O3HMS56W8u0afJUt/yGQtOm1T4Ui3A86CNnKLbGlJt
 dxL3/it19vCtwmBnre4PoJf3SOrDcZ+To3WjVSeVs5ngRD91XfDS21Ny0Z2p8Gtd72XsAQ6rk
 Su/RkriuUsaGHknZEMtr+YRxBo/N7MtMWRCpgiwDhNZesfjVDTgK2eJa911H3c1BNdNz/UxSK
 +Ytwgac+96um6OVRc5bJgKXv7UKfi0V+R5xOLnVhGK086VN1AamGqJxlU0Z0Fm+ZjTGvVmszS
 JgPI95s5+swB3zdd5mFZ9SIgsX5cl6zXwLH3MuRd94fMZ/CmNnMDoxr/whFii5zF38XIMPnpi
 sFiWEGq6GzbANM48ob1kV0j7zATuQO1iSFyO3UzX7Y+QV4BJpQy3YxS+WBOb05Uc7Go7o+MS2
 Bytg0ryTXzeWByrbAMZmD6ojR00xo0Fiqjk1yEjvs/DB4LiwDXh6VzbKKN4oKkRdwMAuNtJRY
 wUVo06V8GVMasic6ScOJFyMkt4OO/hcucHkb7aQa2jG/ktAUQYzMM3/YNKQoeME+wOpUB6Cve
 mDwx/ELzqRk7KeKcSzVzO6OI8D8OOkjTzghTfNNlU3iCG77gsrSR4mokWGQPv+regJOhRG9+/
 /l4NUiWqY1/IsGng5yKNPIMYCggbynosN1r3ILa1TRbPdpeTLkGLDEGt6FXNbletovU3RYzjH
 0NTrBq3v4rnmIvg3lCgc5EeMIw8RenBj5tZ4gyxA1y5LoZCaO7cNw/ezEauV3UmUXPEBdLkm4
 8sFVwQpx7wVybjA1OUwxHyZNF/3e8FjT3X8niAUPTpFv/5OXmyo7UUA5r4nWo0FsfuVk9WIgd
 vSA8zhGupSxJlvUcE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/4 =E4=B8=8A=E5=8D=887:10, Simon Glass wrote:
> Use the common function to avoid code duplication.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Acked-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> (no changes since v1)
>
>   fs/btrfs/compression.c | 51 +++++-------------------------------------
>   1 file changed, 5 insertions(+), 46 deletions(-)
>
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 23efefa1997..7adfbb04a7c 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -6,6 +6,7 @@
>    */
>
>   #include "btrfs.h"
> +#include <abuf.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <linux/lzo.h>
> @@ -136,54 +137,12 @@ static u32 decompress_zlib(const u8 *_cbuf, u32 cl=
en, u8 *dbuf, u32 dlen)
>
>   static u32 decompress_zstd(const u8 *cbuf, u32 clen, u8 *dbuf, u32 dle=
n)
>   {
> -	ZSTD_DStream *dstream;
> -	ZSTD_inBuffer in_buf;
> -	ZSTD_outBuffer out_buf;
> -	void *workspace;
> -	size_t wsize;
> -	u32 res =3D -1;
> -
> -	wsize =3D ZSTD_DStreamWorkspaceBound(ZSTD_BTRFS_MAX_INPUT);
> -	workspace =3D malloc(wsize);
> -	if (!workspace) {
> -		debug("%s: cannot allocate workspace of size %zu\n", __func__,
> -		      wsize);
> -		return -1;
> -	}
> -
> -	dstream =3D ZSTD_initDStream(ZSTD_BTRFS_MAX_INPUT, workspace, wsize);
> -	if (!dstream) {
> -		printf("%s: ZSTD_initDStream failed\n", __func__);
> -		goto err_free;
> -	}
> +	struct abuf in, out;
>
> -	in_buf.src =3D cbuf;
> -	in_buf.pos =3D 0;
> -	in_buf.size =3D clen;
> +	abuf_init_set(&in, (u8 *)cbuf, clen);
> +	abuf_init_set(&out, dbuf, dlen);
>
> -	out_buf.dst =3D dbuf;
> -	out_buf.pos =3D 0;
> -	out_buf.size =3D dlen;
> -
> -	while (1) {
> -		size_t ret;
> -
> -		ret =3D ZSTD_decompressStream(dstream, &out_buf, &in_buf);
> -		if (ZSTD_isError(ret)) {
> -			printf("%s: ZSTD_decompressStream error %d\n", __func__,
> -			       ZSTD_getErrorCode(ret));
> -			goto err_free;
> -		}
> -
> -		if (in_buf.pos >=3D clen || !ret)
> -			break;
> -	}
> -
> -	res =3D out_buf.pos;
> -
> -err_free:
> -	free(workspace);
> -	return res;
> +	return zstd_decompress(&in, &out);
>   }
>
>   u32 btrfs_decompress(u8 type, const char *c, u32 clen, char *d, u32 dl=
en)
>
