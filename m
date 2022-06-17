Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151C254F831
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 15:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380804AbiFQNKt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 09:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379989AbiFQNKq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 09:10:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F44448E4F;
        Fri, 17 Jun 2022 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655471396;
        bh=YaJ8bLBkrwyzbP/aElktjaUrsA6RVWTHjOalYcezXRo=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=Kl/uMo/6FQyu8wPt+q22KeTpMbe3Cz0ot/IFLMkew+wr9lVaDg5tQ4VccsK3zZSYL
         tON5GydOj//RNp/EqCSE5hQgop3uqNOgeucVhEroh3xo6YRXfK2K8QzHGc4KrZBhsS
         e2+yzA5/3jmP44pAMm4QJ8AuOCn9rkc4gMtUAG4c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVN6t-1oAbfJ3xAd-00SP2M; Fri, 17
 Jun 2022 15:09:56 +0200
Message-ID: <8cbfc1ff-f86d-f2cc-d37e-ef874f4600bc@gmx.com>
Date:   Fri, 17 Jun 2022 21:09:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
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
 <20220617120538.18091-4-fmdefrancesco@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [RFC PATCH v2 3/3] btrfs: Use kmap_local_page() on "in_page" in
 zlib_compress_pages()
In-Reply-To: <20220617120538.18091-4-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wEeXBUT/i5ZKYtb2kv03/nfxvEiBvUNIL+e3tMKLS72M3UXA2Y6
 txaR4V9iFchWGXPm+b3/zMHy7gm5Dm4hKfoF3FDlM4wpnBjtfE6iHXnavTYeVBzxNx54MNO
 wwJ6clkqRRtO6YSI55A3WEN9D4qsh3BVhYnZbbUFWgp+LBpvIDAdowDEpzh4hcHWigGAFRF
 G0eRv3S7KBRP2qvOigo0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bPkVB7Eahdk=:aqAh7SVocAKyvgsgIXrEFM
 xPGG211eYUEvOXx1B7FneybpfHd/ShKjGsuYNaNNgN3TJtyuIjgO5b/odKirPOnuwzneG9ez/
 QAfQFjIndh6LVy+t6n4rf9+PgRrHHsoh/yxmEPG0GhvKTgQxoFDArldi/9vMn662tmMY0UdX9
 X2hZbw/qqRNPuOhtmlUhFJzSmJIs/kX3QQnQ7iNgr5ZFOvd8XZUf3A9uI8978iAgaz1k4lCkW
 Tjp37kuBPL3Gr+iloP+YtLCGRJw37e08k54SbwkPnT8Ja1hK0arSTqXIxfXgCkgkAvK9hup7M
 XMUwAgqJKw70b4tbkyj9+UgGpI9dUjzni55vsEysp9mi7T7SEykVOC2sqeI5r8e8AVAH86tjV
 WuTK1ymrg7Ru7WCTOMzouyZi/9K+IU6ZwoYXwRONwdUxDVpipmrr77abKs+iNFo23AiPSiT2I
 FUCi8m40hNgQ4hSvZVI4Qezix9znJAzUpm+w5npe5BunxA3pCaOSfZv19Pr0AZ5l5VwJjX57y
 C4//gGKjFp4Nlm2/8hSqdFwPieyjYDcCDXwlOoTcT3FtWfJMJmwX0I4JjBuQpCRna2sDu1ub0
 QTA3Es2hhR08gJBK82wm06xvRwm9iorAF2E9pGqbER/aKIZ6aZNuciKd+qbIMVfG8Eoa2FScS
 OFZIqBitkcSmx8c/xEFDrs9g/qqVXWoDBZrjXhZdfThLsMGv7RqRG/OSulZ6QcQct1A/MTSKb
 dSMK2RJScmAwc/LuX1yMdmNqV269ZDgUPFX8BPrOMG7fyBhADtw0WUDHqrmCRHubClbufFUuI
 stFCegOTLmBbRS0d6jjskC1/htu/l+1ierT/hXOn0cKc/PXvwczlne3iEvxacIhsWsgpaewGj
 9tpdOu/DdAWIG0JkLPS+eDMqErg2ZK83Vg1iCCC/pinxgePVcAoM0HoL8q7cGgDou4EaQXgQx
 J0cnilvSsgQgl4LuDCyWNxkbubPtbZjGnZC/FKMeBwlFH4vSHJJjarZjIPFKq7PYOzXGZo6rx
 mlGVfIODjQ1YsDl2xGfeCNO9sE0RdwxplccdQyVkwowpmITD/Jk9VjpATnMFzIzQbQoi8aQuQ
 HNUIJs+etF2LsyfFtkOoXAEGDDM+wOv6/sZn1GGI/2c5euJrOpBvoccbg==
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
> Therefore, use kmap_local_page() / kunmap_local() on "in_page" in
> zlib_compress_pages() because in this function the mappings are per thre=
ad
> and are not visible in other contexts.
>
> Use an array based stack in order to take note of the order of mappings
> and un-mappings to comply to the rules of nesting local mappings.

Any extra comment on the "rules of nesting local mappings" part?

>
> Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
> HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".
>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>   fs/btrfs/zlib.c | 65 ++++++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 53 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index c7c69ce4a1a9..1f16014e8ff3 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -99,6 +99,8 @@ int zlib_compress_pages(struct list_head *ws, struct a=
ddress_space *mapping,
>   	int ret;
>   	char *data_in =3D NULL;
>   	char *cpage_out =3D NULL;
> +	char mstack[2];
> +	int sind =3D 0;
>   	int nr_pages =3D 0;
>   	struct page *in_page =3D NULL;
>   	struct page *out_page =3D NULL;
> @@ -126,6 +128,8 @@ int zlib_compress_pages(struct list_head *ws, struct=
 address_space *mapping,
>   		ret =3D -ENOMEM;
>   		goto out;
>   	}
> +	mstack[sind] =3D 'A';
> +	sind++;
>   	cpage_out =3D kmap_local_page(out_page);
>   	pages[0] =3D out_page;
>   	nr_pages =3D 1;
> @@ -148,26 +152,32 @@ int zlib_compress_pages(struct list_head *ws, stru=
ct address_space *mapping,
>   				int i;
>
>   				for (i =3D 0; i < in_buf_pages; i++) {
> -					if (in_page) {
> -						kunmap(in_page);

I don't think we really need to keep @in_page mapped for that long.

We only need the input pages (pages from inode page cache) when we run
out of input.

So what we really need is just to map the input, copy the data to
buffer, unmap the page.

> +					if (data_in) {
> +						sind--;
> +						kunmap_local(data_in);
>   						put_page(in_page);
>   					}
>   					in_page =3D find_get_page(mapping,
>   								start >> PAGE_SHIFT);
> -					data_in =3D kmap(in_page);
> +					mstack[sind] =3D 'B';
> +					sind++;
> +					data_in =3D kmap_local_page(in_page);
>   					memcpy(workspace->buf + i * PAGE_SIZE,
>   					       data_in, PAGE_SIZE);
>   					start +=3D PAGE_SIZE;
>   				}
>   				workspace->strm.next_in =3D workspace->buf;
>   			} else {

I think we can clean up the code.

In fact the for loop can handle both case, I didn't see any special
reason to do different handling, we can always use workspace->buf,
instead of manually dancing using different paths.

I believe with all these cleanup, it should be much simpler to convert
to kmap_local_page().

I'm pretty happy to provide help on this refactor if you don't feel
confident enough on this part of btrfs.

Thanks,
Qu

> -				if (in_page) {
> -					kunmap(in_page);
> +				if (data_in) {
> +					sind--;
> +					kunmap_local(data_in);
>   					put_page(in_page);
>   				}
>   				in_page =3D find_get_page(mapping,
>   							start >> PAGE_SHIFT);
> -				data_in =3D kmap(in_page);
> +				mstack[sind] =3D 'B';
> +				sind++;
> +				data_in =3D kmap_local_page(in_page);
>   				start +=3D PAGE_SIZE;
>   				workspace->strm.next_in =3D data_in;
>   			}
> @@ -196,23 +206,39 @@ int zlib_compress_pages(struct list_head *ws, stru=
ct address_space *mapping,
>   		 * the stream end if required
>   		 */
>   		if (workspace->strm.avail_out =3D=3D 0) {
> +			sind--;
> +			kunmap_local(data_in);
> +			data_in =3D NULL;
> +
> +			sind--;
>   			kunmap_local(cpage_out);
>   			cpage_out =3D NULL;
> +
>   			if (nr_pages =3D=3D nr_dest_pages) {
>   				out_page =3D NULL;
> +				put_page(in_page);
>   				ret =3D -E2BIG;
>   				goto out;
>   			}
> +
>   			out_page =3D alloc_page(GFP_NOFS);
>   			if (out_page =3D=3D NULL) {
> +				put_page(in_page);
>   				ret =3D -ENOMEM;
>   				goto out;
>   			}
> +
> +			mstack[sind] =3D 'A';
> +			sind++;
>   			cpage_out =3D kmap_local_page(out_page);
>   			pages[nr_pages] =3D out_page;
>   			nr_pages++;
>   			workspace->strm.avail_out =3D PAGE_SIZE;
>   			workspace->strm.next_out =3D cpage_out;
> +
> +			mstack[sind] =3D 'B';
> +			sind++;
> +			data_in =3D kmap_local_page(in_page);
>   		}
>   		/* we're all done */
>   		if (workspace->strm.total_in >=3D len)
> @@ -235,10 +261,16 @@ int zlib_compress_pages(struct list_head *ws, stru=
ct address_space *mapping,
>   			goto out;
>   		} else if (workspace->strm.avail_out =3D=3D 0) {
>   			/* get another page for the stream end */
> +			sind--;
> +			kunmap_local(data_in);
> +			data_in =3D NULL;
> +
> +			sind--;
>   			kunmap_local(cpage_out);
>   			cpage_out =3D NULL;
>   			if (nr_pages =3D=3D nr_dest_pages) {
>   				out_page =3D NULL;
> +				put_page(in_page);
>   				ret =3D -E2BIG;
>   				goto out;
>   			}
> @@ -247,11 +279,18 @@ int zlib_compress_pages(struct list_head *ws, stru=
ct address_space *mapping,
>   				ret =3D -ENOMEM;
>   				goto out;
>   			}
> +
> +			mstack[sind] =3D 'A';
> +			sind++;
>   			cpage_out =3D kmap_local_page(out_page);
>   			pages[nr_pages] =3D out_page;
>   			nr_pages++;
>   			workspace->strm.avail_out =3D PAGE_SIZE;
>   			workspace->strm.next_out =3D cpage_out;
> +
> +			mstack[sind] =3D 'B';
> +			sind++;
> +			data_in =3D kmap_local_page(in_page);
>   		}
>   	}
>   	zlib_deflateEnd(&workspace->strm);
> @@ -266,13 +305,15 @@ int zlib_compress_pages(struct list_head *ws, stru=
ct address_space *mapping,
>   	*total_in =3D workspace->strm.total_in;
>   out:
>   	*out_pages =3D nr_pages;
> -	if (cpage_out)
> -		kunmap_local(cpage_out);
> -
> -	if (in_page) {
> -		kunmap(in_page);
> -		put_page(in_page);
> +	while (--sind >=3D 0) {
> +		if (mstack[sind] =3D=3D 'B') {
> +			kunmap_local(data_in);
> +			put_page(in_page);
> +		} else {
> +			kunmap_local(cpage_out);
> +		}
>   	}
> +
>   	return ret;
>   }
>
