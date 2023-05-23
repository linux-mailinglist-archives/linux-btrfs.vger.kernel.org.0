Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4DE70D529
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 09:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjEWHfp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 03:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbjEWHfH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 03:35:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97212198B;
        Tue, 23 May 2023 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1684827209; i=quwenruo.btrfs@gmx.com;
        bh=rbIFKKCzS4t5jTtygiYWt65IGWrnyMXej2VNiWhCEWw=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=qqqqFSo8K8RJUuHwuHhpX5TeYf+IHIE9K55k1C/4+enOj0ACSgG5uKLPxys2Wvn/W
         Er7AoJJBY2weiJqRa3D7MbqHVA3y/oSJSEgReWoY7FmMrdgR/h5SYMqUa0ZbblH9bq
         8/ClYzJzvJMe/FilWN6kpHwApJ4AlXe1CL4/+eMElOmFlTUGkW85nraJu6wZ5I73Rv
         itNJfcAxziU9AzJ0pWt3O8WG3fxgAZr7xvg1JyVAbEScVqMb9DlguVETp5UiXmTTUC
         7Sszb0h4jOPqkaNnE9bMpM0OdM5pgrrE0tHKZdId2GxDFmk/NBO9DmD9Ag/pQn5J8F
         OHHyeFzl5UIgQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MybKf-1qKPVl1VpF-00yzr1; Tue, 23
 May 2023 09:33:29 +0200
Message-ID: <a79a7e9d-f6b5-00c8-65c8-f914cf0be0b2@gmx.com>
Date:   Tue, 23 May 2023 15:33:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     pengfuyuan <pengfuyuan@kylinos.cn>, Chris Mason <clm@fb.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230523070956.674019-1-pengfuyuan@kylinos.cn>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: Fix csum_tree_block to avoid tripping on
 -Werror=array-bounds
In-Reply-To: <20230523070956.674019-1-pengfuyuan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7pj/xCElzet/SKv7H0rdW3CTXt3m3NicTrBpOpT+xVcMjPRGFhc
 qOCAcNZPKRyuUvbIH/Z1sUEwFM/YOXhZZNV48P7A3vsjO/X3/LUEGofMgLuhTHFFhNNkfyj
 254dl1ylvXtehtIcc0VhvTJiUIZt7Z0Sg/FxYgznnL52qxCIP0JFI5ZUSqzGimoSsa5CwlQ
 Jg+EviMBwi5uywbRZAriQ==
UI-OutboundReport: notjunk:1;M01:P0:Pz6QD/3PJ3g=;idCT2xoG6e7JJRookhiLA5Wf8kc
 KLVdGjjnXwR2XNgYhhWi8De7FFwwV5u8vDYNfIgtrxaqqiTh0IkZw222qufDTcUjz8/fRlafm
 E/c3Dn8VYfrKSOwtF3AIXiBqNVr0f3J0a4pkd17rP98cEsSQVHGIHOZi1m8LF79s6WRjw3Lrh
 /h87D+qOZY8TTG4eZHx0akIQe4sgFUsY9KgHhvFGi6u9cYYfhhLaPs1zGMbLDhSO8MpeSTLZ2
 5RLUKlIRrjUbVAxGGu6TzkW5ljoLuuEfN3OXpNW3iBL6JfTpTF4au7gooVgKCJYBHi5KVi0os
 U5gJMAFlVmLqLLq+1A92O2xxbBdJKBykN8HmQJV5BYmf/llcJXmanyMtEjPbPw4itV1b6acYH
 CBAAAa8ecIZYka1xDDvD9UhD+CRWzN6pJCKA1MqYfhVJ07UKvFwpbGS6xT7fc8bbTt3Nc6/1k
 eQIsiM+sX4pl5rzfA75rPRD3k/nkgBIN4dR2DgULo73WyXKa/2PoL3AH+8C269sYh+ovzw3nG
 4dtAvQSJEjwKoRm06aNfOurZ/ct3Mlt9864S8VuT3TZp/FzCWf87mO4CIEbZt7TO/MdXJtZO+
 UsGLnR1CiakHYvvuPWaER3iliFDbLH8ckasXv+IeImn684edlYLfU16rZlgbpmvh83xcCneiq
 UygGscMQ0T+kgr7BqV7I3RvV/6U7Rp4N1yUZLG2NnDoErIs6N26e+8iVpLZwp1/33qcAYBA5B
 0GU34NcQHqFwp2LMYpUyC3taZl1kADsNQNM0pLYosk32mdhYoF0zki7222IiNUqI7a3Ty9iui
 zpH8XpWjNAqfQMnQfuhX+lZaj3jV1D+nUQt+R0mdbZKeCcxIkxi8Sw1vkSpoP3dq1sw5yCAfJ
 Lxp3+qaaJVcI3gPaRUky52TUug+WfT1+JYRqHxVeka7s8I1y5RJerSo4DyIcuUpdMkCFiN9s4
 D/tfjRXBFjbsAeNd+SPlXwQBVdM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/23 15:09, pengfuyuan wrote:
>
> When compiling on a mips 64-bit machine we get these warnings:
>
>      In file included from ./arch/mips/include/asm/cacheflush.h:13,
> 	             from ./include/linux/cacheflush.h:5,
> 	             from ./include/linux/highmem.h:8,
> 		     from ./include/linux/bvec.h:10,
> 		     from ./include/linux/blk_types.h:10,
>                       from ./include/linux/blkdev.h:9,
> 	             from fs/btrfs/disk-io.c:7:
>      fs/btrfs/disk-io.c: In function =E2=80=98csum_tree_block=E2=80=99:
>      fs/btrfs/disk-io.c:100:34: error: array subscript 1 is above array =
bounds of =E2=80=98struct page *[1]=E2=80=99 [-Werror=3Darray-bounds]
>        100 |   kaddr =3D page_address(buf->pages[i]);
>            |                        ~~~~~~~~~~^~~
>      ./include/linux/mm.h:2135:48: note: in definition of macro =E2=80=
=98page_address=E2=80=99
>       2135 | #define page_address(page) lowmem_page_address(page)
>            |                                                ^~~~
>      cc1: all warnings being treated as errors
>
> We can check if i overflows to solve the problem. However, this doesn't =
make
> much sense, since i =3D=3D 1 and num_pages =3D=3D 1 doesn't execute the =
body of the loop.
> In addition, i < num_pages can also ensure that buf->pages[i] will not c=
ross
> the boundary. Unfortunately, this doesn't help with the problem observed=
 here:
> gcc still complains.

So still false alerts, thus this bug should mostly be reported to GCC.

>
> To fix this, start the loop at index 0 instead of 1. Also, a conditional=
 was
> added to skip the case where the index is 0, so that the loop iterations=
 follow
> the desired logic, and it makes all versions of gcc happy.
>
> Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
> ---
>   fs/btrfs/disk-io.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index fbf9006c6234..8b05d556d747 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -96,9 +96,13 @@ static void csum_tree_block(struct extent_buffer *buf=
, u8 *result)
>   	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
>   			    first_page_part - BTRFS_CSUM_SIZE);
>
> -	for (i =3D 1; i < num_pages; i++) {
> -		kaddr =3D page_address(buf->pages[i]);
> -		crypto_shash_update(shash, kaddr, PAGE_SIZE);
> +	for (i =3D 0; i < num_pages; i++) {
> +		struct page *p =3D buf->pages[i];
> +
> +		if (i !=3D 0) {
> +			kaddr =3D page_address(p);
> +			crypto_shash_update(shash, kaddr, PAGE_SIZE);

Unfortunately this damages the readability.

If you really want to starts from page index 0, I don't think doing this
is the correct way.

Instead, you may take the chance to merge the first
crypto_shahs_update() call, so the overall procedure looks like this:

static void csum_tree_block()
{
	for (int i =3D 0; i < num_pages; i++) {
		int page_off =3D whatever_to_calculate_the_offset;
		int page_len =3D whatever_to_calculate_the_lengh;
		char *kaddr =3D page_address(buf->pages[i]) + page_off;

		crypto_shash_update(shash, kaddr, page_len);
	}
	memset();
	crypto_shash_final();
}

Although even with such change, I'm still not sure if it's any better or
worse, as most of the calculation can still be bulky.

I'll let David to give the final call.

Thanks,
Qu
> +		}
>   	}
>   	memset(result, 0, BTRFS_CSUM_SIZE);
>   	crypto_shash_final(shash, result);
>
>
> Content-type: Text/plain
>
> No virus found
> 		Checked by Hillstone Network AntiVirus
