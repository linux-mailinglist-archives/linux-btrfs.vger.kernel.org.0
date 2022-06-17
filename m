Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7839454F7DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 14:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiFQMvc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 08:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbiFQMva (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 08:51:30 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB96538780;
        Fri, 17 Jun 2022 05:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655470272;
        bh=5htkplcF4F9jY0hICWYsBVaqM9r4Ph8IdK4+8iBQrkc=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=BuAdKOOPAUvGIhcMHeDrfa7p9qO5ZdWidICK71LGRCOE7p/0O2CrvqCeSPIBy7FMm
         kghLz6Gmk1QMxcotmyi9gk7KunY9AhUFnk71J5f+lKQVBInBL1Y+Jj+WdqoGm7rotA
         4XjmcILBW/mFHFRPwSoHZ3Pv9MDGd9Z9eRxRbe2M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N8XPn-1ngTfl07v7-014QWl; Fri, 17
 Jun 2022 14:51:12 +0200
Message-ID: <f1e0383b-b68e-2044-8e1c-22ea4950c3c6@gmx.com>
Date:   Fri, 17 Jun 2022 20:51:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v2 1/3] btrfs: Convert zlib_decompress_bio() to use
 kmap_local_page()
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
 <20220617120538.18091-2-fmdefrancesco@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220617120538.18091-2-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SLOy9b2EodUCeXP6dSzjSCbswIltA/we9/OUbDG4cllVXWtQSNm
 t5H5aDxD8m+HCHKWYkPwtkLOj0R3bsW+MDm/1JyxS4NtftvugN8Ob+ld9pfg26ScfPlR3Aj
 U5YwndNpYmqBUqSofqkHzelAJBB2Tllqd2ICz8B4VDKWGL8I7hMsf4IbdBEOS9nt69bQGea
 EhPvod7U10c3YCZ0q0DjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m5D3u91EPuk=:szyHD9+W3Ma/+a8HjFJk62
 VbW7iyIGcV5p8xK+j30ZlhBdsES30FveVXYV+5lmaBaG2cShcN6CLe98ozhpewHuDUzOyOzNy
 voSeAx9DI1TwlUujEwGBB6UvnzLHsEX7CzEdUh+a9bl+sl13EpilX8/AxtiQt8anay0VfUKDa
 EnOC9/CKPNLl73dOvYIhogvSQ2lB4WXqeJOqYdyvPQ1f2ceX+4xqirWRY9OExNYS8+jbhhnAL
 XyYLWYtSOXustja+JU6ESOlfHg2BXsn3FJxGH9+Zsfc35MpH08JGPx4dGEIZVGoEfuBIuHjyX
 kqf/x6eJR/NsrCjH6jV5StvnxS0rIrvs7d4j+84Hi5TCthq7EwWzH/tdkkcX34bjHU6siD3sN
 kWQHfin9XMf9FocX0ysYgHDGrKoBuCMT8gnLFMzAAN/c43Obigb+1VmbK/OgbT8ORSpNtQnWP
 MNRJ2O64Y7y8I7NgjeVvd3URHs5BtREJFMCv2Pbr3yx5SzwOU5TLuBKIeldzcwNZXNs7v5WJ3
 1SBWwiZI++U6K++Xi1IsRkFjdKPaVqRfC0jSziBt1PvA3s1PCM+ZhXWat6eykX1jeu8hsHyc3
 4TXsX2ALSJEc3SZcy16emkEABitkTfMRl1Op3D3jTR5zp/q+9Ebk/LDXdKd3pR88J6FdUcS5j
 iMUkLlA99vrCohcSB3tZc2e4vSnfHPYQ5X9oOboLip9uzGgsGb5Ev+kzUT6HWh9L/3Gm2CfqS
 /S7BjyLVr3rtweeFZwS20B8szNv94cd+Xi//1wYhUJEcYmz9LjF8TPLxU9UJXU14xjeOh99Nc
 oesXlCdPCnI1qMNK3DTZPWCz/id+N+kAwy80WQkpU1QAIRC/P1p8dBNksYlLp3GfamIz2dF1l
 jdS6yn8ja54EPOHu5s9KZTl01WhSaq5r32nWoKya/4E7ZkKxs2RSqSesPsJStFAPSKBsES+YJ
 MpOtLXpFdlZfvX6xtx3S++pDNAKxoGluwLImSksIKFcFpPrNtXq0Kw0JIvhfO0alxRI75PEPL
 HNXLXCDloUrzsqX4pzR3wh82dRPr9QD2jO8I0WWmnM2Ue4WbLHi4LV5xcq+NgW+VUr76woBR6
 vSZrdZ5D38o1D1OjCNGPhGKdFibWSpLHhzxi0QnegIRJmc/GgTK1WZPLQ==
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
> Therefore, use kmap_local_page() / kunmap_local() in zlib_decompress_bio=
()
> because in this function the mappings are per thread and are not visible
> in other contexts.
>
> Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
> HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".
>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/zlib.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index 767a0c6c9694..770c4c6bbaef 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -287,7 +287,7 @@ int zlib_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>   	unsigned long buf_start;
>   	struct page **pages_in =3D cb->compressed_pages;
>
> -	data_in =3D kmap(pages_in[page_in_index]);
> +	data_in =3D kmap_local_page(pages_in[page_in_index]);
>   	workspace->strm.next_in =3D data_in;
>   	workspace->strm.avail_in =3D min_t(size_t, srclen, PAGE_SIZE);
>   	workspace->strm.total_in =3D 0;
> @@ -309,7 +309,7 @@ int zlib_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>
>   	if (Z_OK !=3D zlib_inflateInit2(&workspace->strm, wbits)) {
>   		pr_warn("BTRFS: inflateInit failed\n");
> -		kunmap(pages_in[page_in_index]);
> +		kunmap_local(data_in);
>   		return -EIO;
>   	}
>   	while (workspace->strm.total_in < srclen) {
> @@ -336,13 +336,13 @@ int zlib_decompress_bio(struct list_head *ws, stru=
ct compressed_bio *cb)
>
>   		if (workspace->strm.avail_in =3D=3D 0) {
>   			unsigned long tmp;
> -			kunmap(pages_in[page_in_index]);
> +			kunmap_local(data_in);
>   			page_in_index++;
>   			if (page_in_index >=3D total_pages_in) {
>   				data_in =3D NULL;
>   				break;
>   			}
> -			data_in =3D kmap(pages_in[page_in_index]);
> +			data_in =3D kmap_local_page(pages_in[page_in_index]);
>   			workspace->strm.next_in =3D data_in;
>   			tmp =3D srclen - workspace->strm.total_in;
>   			workspace->strm.avail_in =3D min(tmp, PAGE_SIZE);
> @@ -355,7 +355,7 @@ int zlib_decompress_bio(struct list_head *ws, struct=
 compressed_bio *cb)
>   done:
>   	zlib_inflateEnd(&workspace->strm);
>   	if (data_in)
> -		kunmap(pages_in[page_in_index]);
> +		kunmap_local(data_in);
>   	if (!ret)
>   		zero_fill_bio(cb->orig_bio);
>   	return ret;
