Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1E3599F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 11:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfFEJ0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 05:26:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:45375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbfFEJ0H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 05:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559726737;
        bh=MEn/M/ub4VrghRC1LEzE04RJBpRqiorISsJ1OBD0dRI=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=QIwjdAtnqeJG4pGWJ6ihog25KDdrLo8LNp1bbV2TlguaCZqJ6A2qH3O5WrOvedaEW
         lKMbmxIjtKYnYnAv3ydcl2+uW3a2juqVkqDWlHREQ1ccoIz35loqL6ot96f4Rh9/Yl
         iBQ+NzSAwQjy8qw1NUjLWf20ioWzWEHa9gFs07zs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx002
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MQ2zr-1hTFEx1SNP-005M1y; Wed, 05
 Jun 2019 11:25:37 +0200
Subject: Re: [PATCH 4/4] btrfs: Don't trim returned range based on input value
 in find_first_clear_extent_bit
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190603100602.19362-1-nborisov@suse.com>
 <20190603100602.19362-5-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <93efd342-4187-4fda-a1c1-563c8faf1541@gmx.com>
Date:   Wed, 5 Jun 2019 17:25:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603100602.19362-5-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ykTZ8Y2xjH7tZVP2m7x8WbXhP9E+PGLB+2vo3QNXx6CB03fjY++
 Hvvu10opYj3jn3r8vXTniAMf/3oEwX6AdIyDkUYjASdUg5F51sAG1gLwiDaVZ+zpwjY+4iw
 bqxkJ0biCBMOUCZSTPqiK758W1o4vOCDKMhqNWQF2bB0b8Lk34yKsphhYlZ7/EQ+w2muPte
 bGz0OTZ0t774WhTVRpSqw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JTDWReMjiSI=:uQIAJ8BoI1+BPxxLO6AtpP
 7SUjanMn+TiLy//scGAXNxswvEBMPKfMGCj+ESJZjNUITO5aZ7JpUVAdVg5ccELLNtVKzZPKv
 9GM6A28NzXRXhe7oCQwcfLCDdbX7Ef6XT0dD5aqtfxbNIuVs6OLL6IDmZ0AYjse9Rk6PwD/Wy
 9WDsWDTIHPhTEsINcCMBNFjQPloajMGUuI2tnb38MYYKjykcj+ywSe8HBHEqguSHIroSIHw6v
 hDVhUTKLrYf8uSqUBJZAwgF5PPtkqm+JGYZhfeGaRQCXYpD6ELWA7sRee3v+l5WFArFEin8XN
 r2nXWhRO7pt1JBR6gL7Agdgal3qG3tRE621UrigBuy39OVEM2FPQ3Ez9WWQiSn21+ItITqt4i
 szUDu4hTDaK+GN4wz0zLWaUbFYpQ807reIlD/ydCR1ZtLvbgE7SEbO6Jd9LxnGs7JzfaRLyK5
 hGXvHaZGn+PgDEgWi1frqXSpOUNh91t70HmQKdzykHAcdbpX324/4U1D3KK9+CKARFOY6cWNS
 6z2a9wohkLhPfVBBwihlaFQ8KYegDUVn5c/dom0L88eMA+4sNOn994zXtcuQijiZnAZqXL02Y
 iDBnPaBmbS22cojUa1EmBCFEeocOASY4Mw/tdfLAfb+1lcFmxqUBH+y0Lo1OnoIbBrq6I0WSa
 dYXo2+BgFs82X9kfwT/ISYOuenT/9KV/N57VnuTFiUvfOe9iaCkFBKkZaelmEx/mIxGCVhrLy
 cc8cPkdMnlR9R5AksHMTktHfbYFz5eGlY9vsvsF0Yc7LP7yc91clszbDCYRh7oTaftbR8InvP
 /pw04/2hgIquBQO/5ali2dIE6BrDADXAUWmQapB0A4mkbpGL+1DQbRglb1PucVwJuDKCJjvhM
 dCMiICN//8g5y6iTLbTaYEbD+x2bdmVEnmh28rsRW1nrSK+34FFEyUQ3svYmDPh0Ts3uz5QDO
 +bK+SFt017lMsd9/20sujJsRoT4NFGX4pU4e1XZcKgnlUFz4uom4LLEoXBJyzSEXtCAvGtitP
 BOJUyGrWebD2AMqgxCenqhE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/6/3 =E4=B8=8B=E5=8D=886:06, Nikolay Borisov wrote:
> Currently find_first_clear_extent_bit always returns a range whose
> starting value is >=3D passed 'start'. This implicit trimming behavior i=
s
> somewhat subtle and an implementation detail. Instead, this patch
> modifies the function such that now it always returns the range which
> contains passed 'start' and has the given bits unset. This range could
> either be due to presence of existing records which contains 'start'
> but have the bits unset or because there are no records that contain
> the given starting offset.
>
> This patch also adds test cases which cover find_first_clear_extent_bit
> since they were missing up until now.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/extent_io.c             | 51 +++++++++++++++---
>  fs/btrfs/tests/extent-io-tests.c | 89 ++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d5979558c96f..1dd900cfb7ea 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1553,8 +1553,8 @@ int find_first_extent_bit(struct extent_io_tree *t=
ree, u64 start,
>  }
>
>  /**
> - * find_first_clear_extent_bit - finds the first range that has @bits n=
ot set
> - * and that starts after @start
> + * find_first_clear_extent_bit - finds the first range that has @bits n=
ot set.
> + * This range could start before @start.

What about using the same expression of previous patches? E.g.
Such range would have range->start <=3D start  && range->start +
range->len > start.

Despite that, I think the ascii chart is pretty good, along with
selftest case it should be OK.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>   *
>   * @tree - the tree to search
>   * @start - the offset at/after which the found extent should start
> @@ -1594,12 +1594,51 @@ void find_first_clear_extent_bit(struct extent_i=
o_tree *tree, u64 start,
>  				goto out;
>  			}
>  		}
> +		/*
> +		 * At this point 'node' either contains 'start' or start is
> +		 * before 'node'
> +		 */
>  		state =3D rb_entry(node, struct extent_state, rb_node);
> -		if (in_range(start, state->start, state->end - state->start + 1) &&
> -			(state->state & bits)) {
> -			start =3D state->end + 1;
> +
> +		if (in_range(start, state->start, state->end - state->start + 1)) {
> +			if (state->state & bits) {
> +				/*
> +				 * |--range with bits sets--|
> +				 *    |
> +				 *    start
> +				 */
> +				start =3D state->end + 1;
> +			} else {
> +				/*
> +				 * 'start' falls within a range that doesn't
> +				 * have the bits set, so take its start as
> +				 * the beginning of the desire range
> +				 *
> +				 * |--range with bits cleared----|
> +				 *      |
> +				 *      start
> +				 */
> +				*start_ret =3D state->start;
> +				break;
> +			}
>  		} else {
> -			*start_ret =3D start;
> +			/*
> +			 * |---prev range---|---hole/unset---|---node range---|
> +			 *                          |
> +			 *                        start
> +			 *
> +			 *                        or
> +			 *
> +			 * |---hole/unset--||--first node--|
> +			 * 0   |
> +			 *    start
> +			 */
> +			if (prev) {
> +				state =3D rb_entry(prev, struct extent_state, rb_node);
> +				*start_ret =3D state->end + 1;
> +			} else {
> +				*start_ret =3D 0;
> +			}
>  			break;
>  		}
>  	}
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io=
-tests.c
> index 7bf4d5734dbe..36fe720fc823 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -432,6 +432,91 @@ static int test_eb_bitmaps(u32 sectorsize, u32 node=
size)
>  	return ret;
>  }
>
> +static int test_find_first_clear_extent_bit(void)
> +{
> +
> +	struct extent_io_tree tree;
> +	u64 start, end;
> +
> +	test_msg("Running find_first_clear_extent_bit test");
> +	extent_io_tree_init(NULL, &tree, IO_TREE_SELFTEST, NULL);
> +
> +	/*
> +	 * Set 1m-4m alloc/discard and 32m-64m thus leaving a hole
> +	 * between 4m-32m
> +	 */
> +	set_extent_bits(&tree, SZ_1M, SZ_4M - 1,
> +			CHUNK_TRIMMED | CHUNK_ALLOCATED);
> +
> +
> +	find_first_clear_extent_bit(&tree, SZ_512K, &start, &end,
> +				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
> +
> +	if (start !=3D 0 || end !=3D SZ_1M -1)
> +		test_err("Error finding beginning range: start: %llu end: %llu\n",
> +			 start, end);
> +
> +	/* Now add 32m-64m so that we have a hole between 4m-32m */
> +	set_extent_bits(&tree, SZ_32M, SZ_64M - 1,
> +			CHUNK_TRIMMED | CHUNK_ALLOCATED);
> +
> +	/*
> +	 * Request first hole starting at 12m, we should get 4m-32m
> +	 */
> +	find_first_clear_extent_bit(&tree, 12 * SZ_1M, &start, &end,
> +				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
> +
> +	if (start !=3D SZ_4M || end !=3D SZ_32M - 1)
> +		test_err("Error finding trimmed range: start: %llu end: %llu",
> +			 start, end);
> +
> +	/*
> +	 * Search in the middle of allocated range, should get next available,
> +	 * which happens to be unallocated -> 4m-32m
> +	 */
> +	find_first_clear_extent_bit(&tree, SZ_2M, &start, &end,
> +				    CHUNK_TRIMMED | CHUNK_ALLOCATED);
> +
> +	if (start !=3D SZ_4M || end !=3D SZ_32M -1)
> +		test_err("Error finding next unalloc range: start: %llu end: %llu",
> +			 start, end);
> +
> +	/*
> +	 * Set 64M-72M with CHUNK_ALLOC flag, then search for CHUNK_TRIMMED fl=
ag
> +	 * being unset in this range, we should get the entry in range 64m-72M
> +	 */
> +	set_extent_bits(&tree, SZ_64M, SZ_64M + SZ_8M - 1, CHUNK_ALLOCATED);
> +	find_first_clear_extent_bit(&tree, SZ_64M + SZ_1M, &start, &end,
> +				    CHUNK_TRIMMED);
> +
> +	if (start !=3D SZ_64M || end !=3D SZ_64M + SZ_8M - 1)
> +		test_err("Error finding exact range: start: %llu end: %llu",
> +			 start, end);
> +
> +	find_first_clear_extent_bit(&tree, SZ_64M - SZ_8M, &start, &end,
> +				    CHUNK_TRIMMED);
> +
> +	/*
> +	 * Search in the middle of set range whose immediate neighbour doesn't
> +	 * have the bits set so it must be returned
> +	 */
> +	if (start !=3D SZ_64M || end !=3D SZ_64M + SZ_8M - 1)
> +		test_err("Error finding next alloc range: start: %llu end: %llu",
> +			 start, end);
> +
> +	/*
> +	 * Search beyond any known range, shall return after last known range
> +	 * and end should be -1
> +	 */
> +	find_first_clear_extent_bit(&tree, -1, &start, &end, CHUNK_TRIMMED);
> +	if (start !=3D SZ_64M+SZ_8M || end !=3D -1)
> +		test_err("Error handling beyond end of range search: start: %llu"
> +			 " end: %llu\n", start, end);
> +
> +	return 0;
> +
> +}
> +
>  int btrfs_test_extent_io(u32 sectorsize, u32 nodesize)
>  {
>  	int ret;
> @@ -442,6 +527,10 @@ int btrfs_test_extent_io(u32 sectorsize, u32 nodesi=
ze)
>  	if (ret)
>  		goto out;
>
> +	ret =3D test_find_first_clear_extent_bit();
> +	if (ret)
> +		goto out;
> +
>  	ret =3D test_eb_bitmaps(sectorsize, nodesize);
>  out:
>  	return ret;
>
