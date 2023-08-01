Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C57276C074
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 00:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjHAWeX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 18:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjHAWeW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 18:34:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DF51BE3
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1690929252; x=1691534052; i=quwenruo.btrfs@gmx.com;
 bh=LcRHKC0bwIZaGGhWc2pRWlJJ9xaCfwWGM8BCyOM+HlY=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=jXONPHllSZ8bXGSgxPqBGjVEDU/yofOlJ635a4lOe50QVYO5T4oNTw6nc6NoNJscHVvVFXa
 aMBqGAtzklkxIfi/ZyigI56lb54lQ+MAqN9xdKIm2d6bD7gWEdDgymS5wW5ia4RO4IJnqCGHa
 1MOkA/IXMAIwCMUX+dyD5tjNsydWHmXkx2+o9KLONR2mDQrmqSpFZ0l2BoHgmwp/ITdYLF1Sz
 dX9IGMpiHy5uZ9+kI28R0If4lDBHtYmvymcRQTGsNz2GPbdXPQNZiPF0lkRiab+mVHPnYgvh6
 tjHagtob882oEmd+MWMj+R2Ab1rjduZzCEj6nZX6SAkInVJtwtPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYvcG-1qMgb51sm0-00UoQu; Wed, 02
 Aug 2023 00:34:12 +0200
Message-ID: <2b6e479a-8d56-58fc-651a-d0bdb8b53881@gmx.com>
Date:   Wed, 2 Aug 2023 06:34:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Btrfs: only subtract from len_to_oe_boundary when it
 is tracking an extent
Content-Language: en-US
To:     Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, josef@toxicpanda.com, hch@lst.de
References: <20230801162828.1396380-1-clm@fb.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20230801162828.1396380-1-clm@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:14VTHGeX8x08H7/4AzIQIzK3n2F/tJWVCGWAlUynrdPrzd1HTmP
 g00uheYveH55P/k5rf29lyMOXTQfPA29d2++h2xXYyuJgyftpknZKkin0yud3mC2LYtF8Yu
 cAxnQxBEOZMGd5hrTgEGTADe5VUwZe9M9kTYjf0PSRIIx7DvBmGPtuk9OGAbdOK7LrDaB0B
 DP9uP8i2wE1KJ7oxiO+hg==
UI-OutboundReport: notjunk:1;M01:P0:jn8nk2TtKNY=;sUOltvcM/m2f5fci9FopgaCYU/+
 kksJgOGNk7gLNRio7/Taszy0fbjn9RAwk4bwqp86n2D4apCe7Rd9E/LzTDcIygm8xXcuGP7jY
 z5F8xnsvAVAUJEcaUAJcqwnQJYrwzedPphYmdAs3UD944NCBy/YAAzFonmM4dybMwMlrAh0Bk
 JdJPd4V2maC2QJeC0SslDIZ6X3sfAyNjEiTAZGFXS+GHe0WNB8j/f65SEkIjQcw9wTn2dK1bY
 gOpKs8Nr2mCpGt/KKw62WW8g0P4mkQgHVaBrsApmFWHF4bAghUD4tttSpHFSjRzQGb5Hl26NN
 GDYNCcEbtp7aGpf7CiJ9dmYr74tOm1ABLsqG1ksbRh+LmB+cwwpdjz76i7v1YjrlLWirto10m
 nNPtg4J1tYPY64xTN06xrNOdJUGv41FaQDSpw7lx234Wm8mFVSeKYOSfFOg9M3aoE8/19/oZd
 nNth+BJuDGZ25YHX1o+Bt2E1OOZMR6741OGha4zEKYD2ycfNuQbndpBI/k6ahl0ztoOu6O43p
 Fm3ymrTdrZEtcs/tMR1gbSEU83/tGeehkY7sLyY3azJ/6WtpNTHSMWboTlgW2Baqrz+nT+qNu
 Erhk3b5k9RVjLtzGK3xDuVjFSLpru3mFnGPX1DSqWkenIF9MX3jnNYvIyy9kSwdXwPCdTtaoF
 erE1UBf1oXxvP4lpr0kJ9EU2xTFxa2u/ffZpaz13SBsd9Eigu1oLJqVnfYMQs8PGQS3Bgf+UW
 HX6lhgp49t7K/q57lzhvEAKG6H8sgDihf69JarN8+B5nBCcDhPp6oYmtC44JBkLpqpuLoFG+j
 +9jilk6mU9x5Kks/iCyjSEbZGbcj7RwmxQ+XSs3BZckDmauqrKgE2CenjbkZbpwbtlOcFyl49
 a0NdNnbmdZnzGiAApQ7xFR8mdpFutPtI5zI3uJTQXhbjw4i+6pGjaX7vbsho/l3uNdVNBOTpt
 nEX29VRIfuU5mvMZnPliuEk6/XY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/8/2 00:28, Chris Mason wrote:
> [Note: I dropped the RFC because I can now trigger on Linus kernels, and
> I think we need to send something to stable as well ]
>
> bio_ctrl->len_to_oe_boundary is used to make sure we stay inside a zone
> as we submit bios for writes.  Every time we add a page to the bio, we
> decrement those bytes from len_to_oe_boundary, and then we submit the
> bio if we happen to hit zero.
>
> Most of the time, len_to_oe_boundary gets set to U32_MAX.
> submit_extent_page() adds pages into our bio, and the size of the bio
> ends up limited by:
>
> - Are we contiguous on disk?
> - Does bio_add_page() allow us to stuff more in?
> - is len_to_oe_boundary > 0?
>
> The len_to_oe_boundary math starts with U32_MAX, which isn't page or
> sector aligned, and subtracts from it until it hits zero.  In the
> non-zoned case, the last IO we submit before we hit zero is going to be
> unaligned, triggering BUGs and other sadness.
>
> This is hard to trigger because bio_add_page() isn't going to make a bio
> of U32_MAX size unless you give it a perfect set of pages and fully
> contiguous extents on disk.  We can hit it pretty reliably while making
> large swapfiles during provisioning because the machine is freshly
> booted, mostly idle, and the disk is freshly formatted.  It's also
> possible to trigger with reads when read_ahead_kb is set to 4GB.
>
> The code has been clean up and shifted around a few times, but this flaw
> has been lurking since the counter was added.  I think Christoph's
> commit ended up exposing the bug.
>
> The fix used here is to skip doing math on len_to_oe_boundary unless
> we've changed it from the default U32_MAX value.  bio_add_page() is the
> real limit we want, and there's no reason to do extra math when Jens
> is doing it for us.
>
> Sample repro, note you'll need to change the path to the bdi and device:
>
> SUBVOL=3D/btrfs/swapvol
> SWAPFILE=3D$SUBVOL/swapfile
> SZMB=3D8192
>
> mkfs.btrfs -f /dev/vdb
> mount /dev/vdb /btrfs
>
> btrfs subvol create $SUBVOL
> chattr +C $SUBVOL
> dd if=3D/dev/zero of=3D$SWAPFILE bs=3D1M count=3D$SZMB
> sync;sync;sync
>
> echo 4 > /proc/sys/vm/drop_caches
>
> echo 4194304 > /sys/class/bdi/btrfs-2/read_ahead_kb
>
> while(true) ; do
>          echo 1 > /proc/sys/vm/drop_caches
>          echo 1 > /proc/sys/vm/drop_caches
>          dd of=3D/dev/zero if=3D$SWAPFILE bs=3D4096M count=3D2 iflag=3Df=
ullblock
> done
>
> Signed-off-by: Chris Mason <clm@fb.com>
> Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> CC: stable@vger.kernel.org # 6.4
> Fixes: 24e6c8082208 ("btrfs: simplify main loop in submit_extent_page")

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
>
> v1 -> v2: update the comments, add repro to commit log
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6b40189a1a3e..c25115592d99 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -849,7 +849,30 @@ static void submit_extent_page(struct btrfs_bio_ctr=
l *bio_ctrl,
>   		size -=3D len;
>   		pg_offset +=3D len;
>   		disk_bytenr +=3D len;
> -		bio_ctrl->len_to_oe_boundary -=3D len;
> +
> +		/*
> +		 * len_to_oe_boundary defaults to U32_MAX, which isn't page or
> +		 * sector aligned.  alloc_new_bio() then sets it to the end of
> +		 * our ordered extent for writes into zoned devices.
> +		 *
> +		 * When len_to_oe_boundary is tracking an ordered extent, we
> +		 * trust the ordered extent code to align things properly, and
> +		 * the check above to cap our write to the ordered extent
> +		 * boundary is correct.
> +		 *
> +		 * When len_to_oe_boundary is U32_MAX, the cap above would
> +		 * result in a 4095 byte IO for the last page riiiiight before
> +		 * we hit the bio limit of UINT_MAX.  bio_add_page() has all
> +		 * the checks required to make sure we don't overflow the bio,
> +		 * and we should just ignore len_to_oe_boundary completely
> +		 * unless we're using it to track an ordered extent.
> +		 *
> +		 * It's pretty hard to make a bio sized U32_MAX, but it can
> +		 * happen when the page cache is able to feed us contiguous
> +		 * pages for large extents.
> +		 */
> +		if (bio_ctrl->len_to_oe_boundary !=3D U32_MAX)
> +			bio_ctrl->len_to_oe_boundary -=3D len;
>
>   		/* Ordered extent boundary: move on to a new bio. */
>   		if (bio_ctrl->len_to_oe_boundary =3D=3D 0)
