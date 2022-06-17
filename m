Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2439054F7E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 14:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381771AbiFQMzY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 08:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiFQMzX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 08:55:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F44947AEF;
        Fri, 17 Jun 2022 05:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655470470;
        bh=7BRS71ChBYD2L3k3PQnuQ5OPSIws9+M6hVpBWNCF9NA=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=LPKiV8jqgex+Kp1pCq00lax0YPnktqjyCYafAxCkTZODYpVr6y3cZdPHOUX70uI66
         jOaYC2o1mDvMRU+RCxY6ROcj6mFBPThbiI4Y65ezB83HDwjpiU96bKgHcerB29sJki
         hHm1+aLaUj9t3Ot53gt7Y8rxcWKf8Ygy16ThvjJ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MaJ81-1oERSi23d7-00WHXE; Fri, 17
 Jun 2022 14:54:30 +0200
Message-ID: <e2376a4f-2c9b-9aa6-4358-513fa6a30e67@gmx.com>
Date:   Fri, 17 Jun 2022 20:54:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v2 2/3] btrfs: Use kmap_local_page() on "out_page" in
 zlib_compress_pages()
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220617120538.18091-1-fmdefrancesco@gmail.com>
 <20220617120538.18091-3-fmdefrancesco@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220617120538.18091-3-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n28pe/lUHFb3Mo/rGFJtqZSf/V+dwsTSqM3Hh3ZhnaOaUGH17K/
 aFxLySOOCecER0tQObg4hedp13/wW5ay5yzfLZFx5/1sMpgHcTIY0CjIYHKg3Bfl9Evy7/V
 GCkWbHsrPr7rMj8J3tPTt/Atum0m61Pzimvji+LMuhzo1GEXgTcfcyjjFpTO2LdPF6z1YTx
 TW8vMLJj/zG/3DXvTo2ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:if33/dilUFQ=:i9ewU7V0IfcxQ+Z4xjpo7H
 Aoon/PynTFYj/eqAkInuNYIAlUo1ijCYQ3RpCOe4BDtl9RDKkymS2ri+jbJ/sfuiDP0Z/RO1h
 5QRIHVZbbh0DBT3IYf0b/wSL2cx0XgPnzu9D6zCTX2XA7dLXF20KSha3pgBL9nfkeumr4dCAm
 9UnEb4yiMsghwkyWviA3DJDPE2tsQXzUdvE7J/sDnoihtaqxZHVwFoXF+vzJJIMF5f/kwiwzf
 +0bxE98nZMyUMQ1yNHNoyD8GbCdUOUMlKJmrZKObrFRIcy/63JauNJTPaDiYnoFxFuDAqij+i
 +oNkh9Bko6wcR/IX6im+8/8vL/makQZ0hFkwI5xfxC/RQlMtV6uo33SpG7SVfNoCjvqE73yRr
 YwytiujyzAQAuSVKumDE08fZ/3xkHn88Jefm/Ae9zSUhUihLvJsCiD99WSjLwCcxOO0Xutkqc
 sDW3KjBV05DcUO6dqTcxwGfyKrymq9KPkdH2Q1ugNwGAVtvk8JWhhu4VJ9kQfYxOorEP06UFB
 FIYCpDdMH4Ctpz30AfSUtj/N5hX6ciVTTGA3UZo+Yc5Tgk3dC+oiWtxQMTfTtUd7qh3ISJjYL
 FyZAjt+QmP2QD2NPgApdxXyCbS0m5mWbHIZMq0xMtvTRgHKOszW0NT2Dqs3ES2j+FUMLvht6m
 rHGRbFzbuUIhYZlgy56k9wUsUJJozSGX8QT/frerTQiiiyYSG/P47d8UubzfLq0g8naaQI+vz
 RS9yFQdGD0s965PGPO3rcB3iBh2Aogh1VgDWpjPHv/L9TA/bD64D/4Dz5+F2864eFxlfgPQfq
 kPDw69e+aC6DYeVr7X8eeWUHYpaMXXsJIUT2euDAFeorJGkDpNULCnblWQHn5sirEPc7LZsmM
 AKfGxuzzffovdGCggabDYH3528E04R1odYTIFPoWRgjOhwIigx+VgAtLQS+gQnZ9moWHBqcop
 wH0hGgPA/LyYlrphDef7mNKn2feou5Uhdjdgjhbn8KKYPOzI7nHp4ZLA1r68QNS7W6kSBhxZS
 IZb6sBfUF0vrkLVf07O6BMwxoNuwzuFP6OUWi9NcnF/py5HOE5nCNECZJeui9sM0BmjuaoLPC
 xiLhId+rzJ9r2pLff7JkHNto4VQ3qfnetQKe4HK3upxm7CpUrGyEnbsyg==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/17 20:05, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page(). Wit=
h
> kmap_local_page(), the mapping is per thread, CPU local and not globally
> visible.
>
> Therefore, use kmap_local_page() / kunmap_local() for "out_page" in
> zlib_compress_pages() because in this function the mappings are per thre=
ad
> and are not visible in other contexts.
>
> Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
> HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".
>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

The change is just to use @cpage_out to indicate if it's mapped (NULL =3D
not mapped).

Just a small nit inlined below.

> ---
>   fs/btrfs/zlib.c | 20 +++++++++++---------
>   1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index 770c4c6bbaef..c7c69ce4a1a9 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -97,8 +97,8 @@ int zlib_compress_pages(struct list_head *ws, struct a=
ddress_space *mapping,
>   {
>   	struct workspace *workspace =3D list_entry(ws, struct workspace, list=
);
>   	int ret;
> -	char *data_in;
> -	char *cpage_out;
> +	char *data_in =3D NULL;

I didn't see any diff touching @data_in, any idea why it's initialized
to NULL?

Thanks,
Qu

> +	char *cpage_out =3D NULL;
>   	int nr_pages =3D 0;
>   	struct page *in_page =3D NULL;
>   	struct page *out_page =3D NULL;
> @@ -126,7 +126,7 @@ int zlib_compress_pages(struct list_head *ws, struct=
 address_space *mapping,
>   		ret =3D -ENOMEM;
>   		goto out;
>   	}
> -	cpage_out =3D kmap(out_page);
> +	cpage_out =3D kmap_local_page(out_page);
>   	pages[0] =3D out_page;
>   	nr_pages =3D 1;
>
> @@ -196,7 +196,8 @@ int zlib_compress_pages(struct list_head *ws, struct=
 address_space *mapping,
>   		 * the stream end if required
>   		 */
>   		if (workspace->strm.avail_out =3D=3D 0) {
> -			kunmap(out_page);
> +			kunmap_local(cpage_out);
> +			cpage_out =3D NULL;
>   			if (nr_pages =3D=3D nr_dest_pages) {
>   				out_page =3D NULL;
>   				ret =3D -E2BIG;
> @@ -207,7 +208,7 @@ int zlib_compress_pages(struct list_head *ws, struct=
 address_space *mapping,
>   				ret =3D -ENOMEM;
>   				goto out;
>   			}
> -			cpage_out =3D kmap(out_page);
> +			cpage_out =3D kmap_local_page(out_page);
>   			pages[nr_pages] =3D out_page;
>   			nr_pages++;
>   			workspace->strm.avail_out =3D PAGE_SIZE;
> @@ -234,7 +235,8 @@ int zlib_compress_pages(struct list_head *ws, struct=
 address_space *mapping,
>   			goto out;
>   		} else if (workspace->strm.avail_out =3D=3D 0) {
>   			/* get another page for the stream end */
> -			kunmap(out_page);
> +			kunmap_local(cpage_out);
> +			cpage_out =3D NULL;
>   			if (nr_pages =3D=3D nr_dest_pages) {
>   				out_page =3D NULL;
>   				ret =3D -E2BIG;
> @@ -245,7 +247,7 @@ int zlib_compress_pages(struct list_head *ws, struct=
 address_space *mapping,
>   				ret =3D -ENOMEM;
>   				goto out;
>   			}
> -			cpage_out =3D kmap(out_page);
> +			cpage_out =3D kmap_local_page(out_page);
>   			pages[nr_pages] =3D out_page;
>   			nr_pages++;
>   			workspace->strm.avail_out =3D PAGE_SIZE;
> @@ -264,8 +266,8 @@ int zlib_compress_pages(struct list_head *ws, struct=
 address_space *mapping,
>   	*total_in =3D workspace->strm.total_in;
>   out:
>   	*out_pages =3D nr_pages;
> -	if (out_page)
> -		kunmap(out_page);
> +	if (cpage_out)
> +		kunmap_local(cpage_out);
>
>   	if (in_page) {
>   		kunmap(in_page);
