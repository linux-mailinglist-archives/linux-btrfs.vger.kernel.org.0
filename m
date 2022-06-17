Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB1054FCC1
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 20:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbiFQSOL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 14:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383241AbiFQSOE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 14:14:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C701116B;
        Fri, 17 Jun 2022 11:14:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n185so2697659wmn.4;
        Fri, 17 Jun 2022 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JRZ9ND+W85bKm+29tfahrU3jMySLHwYVz7qltd8SlqY=;
        b=qjQHfuXv5OQbaYuLrME4rcZ70qkdPbMROqDXSmLp7TEi0yS6u7pEBSV2YSIQ8irMl9
         iN6amz9sRZvBQpIEtM8ZKAdSwoyjtsRCQHr4XKHRq9sdr0ySWxbwQ4Q2MTHPoIDZXsrC
         HIdY5fOttmuZIbURdkxww548LAY5v4h/Nhu9zAYQJTwoJsXhnZU/w56fj0nxuKxIthSX
         fAuOKAWl58rYPrBtzhqY01g8X4T1wQLMYCf7DAE/SEpcV2BDSUIo6RO8OIPWOT8lcZFo
         7/fDoUcFHWElQUi2ts/2KLuRHfinNeQjPVXaF3LB4TKA19pd06/+8IFx08kFzv15YJiL
         4h+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRZ9ND+W85bKm+29tfahrU3jMySLHwYVz7qltd8SlqY=;
        b=uB5dHoO2Zpg5iw+IqSKIXU+kgvP9GiytSfiQZRQP4NaCiPKhE97hXL5Q0+PEDSZbMx
         duF2TI89lEUgHmmyK92zpXijoB2LIWUZrDOTRLHzGYOOa8Mz45ODpT3pHUkerVhZfSsa
         kNOTbfyIq2Aei4H+OWJ1a2870WfupMu5OiRI2J0VIrJFJbiQmOVa9hpXmPxUhb+dV6wW
         yR+jBk25eMcLiPYqwm2hXF/XNi0fZCTZCktMgQw6MX7yW60qaqfSvTkbivWT0xnr58ME
         x8D0NFn7pqcplB15RraemFNy1VHVF5X6HxTb440qfrbZS/eUipMvZUqatlR0X/ZDD2Bh
         4dhQ==
X-Gm-Message-State: AOAM530NXk6QfeVZtth5CG2e3Vb4DfWopSothqwK1RvAPfr50pwfRcyH
        MjhIJd5RoBTcEWU5+Q1JQ+I=
X-Google-Smtp-Source: ABdhPJym7VobZpHZNq625Gjf3bIfqzzi47DC+KW5xctMVi6rEzx5kVkkX+iFQNGQPPK3rPf6zfc3nQ==
X-Received: by 2002:a05:600c:2d94:b0:39c:7cb9:5f1d with SMTP id i20-20020a05600c2d9400b0039c7cb95f1dmr21658734wmg.26.1655489641884;
        Fri, 17 Jun 2022 11:14:01 -0700 (PDT)
Received: from opensuse.localnet (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d4201000000b0021a36955493sm5160969wrq.74.2022.06.17.11.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 11:14:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [RFC PATCH v2 3/3] btrfs: Use kmap_local_page() on "in_page" in zlib_compress_pages()
Date:   Fri, 17 Jun 2022 20:13:59 +0200
Message-ID: <14654011.tv2OnDr8pf@opensuse>
In-Reply-To: <8cbfc1ff-f86d-f2cc-d37e-ef874f4600bc@gmx.com>
References: <20220617120538.18091-1-fmdefrancesco@gmail.com> <20220617120538.18091-4-fmdefrancesco@gmail.com> <8cbfc1ff-f86d-f2cc-d37e-ef874f4600bc@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On venerd=C3=AC 17 giugno 2022 15:09:47 CEST Qu Wenruo wrote:
>=20
> On 2022/6/17 20:05, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page().=20
With
> > kmap_local_page(), the mapping is per thread, CPU local and not=20
globally
> > visible.
> >
> > Therefore, use kmap_local_page() / kunmap_local() on "in_page" in
> > zlib_compress_pages() because in this function the mappings are per=20
thread
> > and are not visible in other contexts.
> >
> > Use an array based stack in order to take note of the order of mappings
> > and un-mappings to comply to the rules of nesting local mappings.
>=20
> Any extra comment on the "rules of nesting local mappings" part?
>=20

Actually, I'm not sure about what to add. I thought that whoever need more=
=20
information about LIFO mappings / un-mappings can look at highmem.rst. I've=
=20
changed that document and now it contains information on why and how to use=
=20
kmap_local_page() in place of kmap() and kmap_atomic().

Am I misunderstanding what you are trying to say? If so, any specific=20
suggestions would be greatly appreciated.

> >
> > Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
> > HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".
> >
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >   fs/btrfs/zlib.c | 65 +++++++++++++++++++++++++++++++++++++++
+---------
> >   1 file changed, 53 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> > index c7c69ce4a1a9..1f16014e8ff3 100644
> > --- a/fs/btrfs/zlib.c
> > +++ b/fs/btrfs/zlib.c
> > @@ -99,6 +99,8 @@ int zlib_compress_pages(struct list_head *ws, struct=
=20
address_space *mapping,
> >   	int ret;
> >   	char *data_in =3D NULL;
> >   	char *cpage_out =3D NULL;
> > +	char mstack[2];
> > +	int sind =3D 0;
> >   	int nr_pages =3D 0;
> >   	struct page *in_page =3D NULL;
> >   	struct page *out_page =3D NULL;
> > @@ -126,6 +128,8 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >   		ret =3D -ENOMEM;
> >   		goto out;
> >   	}
> > +	mstack[sind] =3D 'A';
> > +	sind++;
> >   	cpage_out =3D kmap_local_page(out_page);
> >   	pages[0] =3D out_page;
> >   	nr_pages =3D 1;
> > @@ -148,26 +152,32 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >   				int i;
> >
> >   				for (i =3D 0; i < in_buf_pages; i++)=20
{
> > -					if (in_page) {
> > -					=09
kunmap(in_page);
>=20
> I don't think we really need to keep @in_page mapped for that long.
>=20
> We only need the input pages (pages from inode page cache) when we run
> out of input.
>=20
> So what we really need is just to map the input, copy the data to
> buffer, unmap the page.
>=20
> > +					if (data_in) {
> > +						sind--;
> > +					=09
kunmap_local(data_in);
> >   					=09
put_page(in_page);
> >   					}
> >   					in_page =3D=20
find_get_page(mapping,
> >   							=09
start >> PAGE_SHIFT);
> > -					data_in =3D kmap(in_page);
> > +					mstack[sind] =3D 'B';
> > +					sind++;
> > +					data_in =3D=20
kmap_local_page(in_page);
> >   					memcpy(workspace->buf + i=20
* PAGE_SIZE,
> >   					       data_in,=20
PAGE_SIZE);
> >   					start +=3D PAGE_SIZE;
> >   				}
> >   				workspace->strm.next_in =3D=20
workspace->buf;
> >   			} else {
>=20
> I think we can clean up the code.
>=20
> In fact the for loop can handle both case, I didn't see any special
> reason to do different handling, we can always use workspace->buf,
> instead of manually dancing using different paths.
>=20
As I said in a recent email, I'm relatively new to kernel development,=20
especially to Btrfs and other filesystems.

However, I noted that this code does different handling depending on how=20
many "in_page" is going to map. I am not able to say why...

>
> I believe with all these cleanup, it should be much simpler to convert
> to kmap_local_page().
>=20
> I'm pretty happy to provide help on this refactor if you don't feel
> confident enough on this part of btrfs.
>=20

Thanks for any help you can provide, but let me be clear about what my goal=
=20
is. I've been assigned with the task to convert kmap() (and possibly also=20
kmap_atomic()) to kmap_local_page() wherever it can be done across the=20
entire kernel.=20

=46urthermore, wherever it cannot be done with the API we already have,=20
changes to the API will be required. One small change has already been=20
carried out upon David's suggestion to make kunmap_local() to take pointers=
=20
to const void. However I'm also talking of much larger changes, if they are=
=20
needed.=20

This is to say that I cannot spend too much on Btrfs. There is lot of work=
=20
to be done in other subsystems where I don't yet know which kinds of=20
difficulties I'm going to find out.

Any help with clean-ups / refactoring of zlib_compress_pages() will be much=
=20
appreciated for the reasons I've tried to convey in the paragraphs above.

Thank you so much,

=46abio=20

> Thanks,
> Qu
>=20
> > -				if (in_page) {
> > -					kunmap(in_page);
> > +				if (data_in) {
> > +					sind--;
> > +					kunmap_local(data_in);
> >   					put_page(in_page);
> >   				}
> >   				in_page =3D find_get_page(mapping,
> >   							start=20
>> PAGE_SHIFT);
> > -				data_in =3D kmap(in_page);
> > +				mstack[sind] =3D 'B';
> > +				sind++;
> > +				data_in =3D kmap_local_page(in_page);
> >   				start +=3D PAGE_SIZE;
> >   				workspace->strm.next_in =3D data_in;
> >   			}
> > @@ -196,23 +206,39 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >   		 * the stream end if required
> >   		 */
> >   		if (workspace->strm.avail_out =3D=3D 0) {
> > +			sind--;
> > +			kunmap_local(data_in);
> > +			data_in =3D NULL;
> > +
> > +			sind--;
> >   			kunmap_local(cpage_out);
> >   			cpage_out =3D NULL;
> > +
> >   			if (nr_pages =3D=3D nr_dest_pages) {
> >   				out_page =3D NULL;
> > +				put_page(in_page);
> >   				ret =3D -E2BIG;
> >   				goto out;
> >   			}
> > +
> >   			out_page =3D alloc_page(GFP_NOFS);
> >   			if (out_page =3D=3D NULL) {
> > +				put_page(in_page);
> >   				ret =3D -ENOMEM;
> >   				goto out;
> >   			}
> > +
> > +			mstack[sind] =3D 'A';
> > +			sind++;
> >   			cpage_out =3D kmap_local_page(out_page);
> >   			pages[nr_pages] =3D out_page;
> >   			nr_pages++;
> >   			workspace->strm.avail_out =3D PAGE_SIZE;
> >   			workspace->strm.next_out =3D cpage_out;
> > +
> > +			mstack[sind] =3D 'B';
> > +			sind++;
> > +			data_in =3D kmap_local_page(in_page);
> >   		}
> >   		/* we're all done */
> >   		if (workspace->strm.total_in >=3D len)
> > @@ -235,10 +261,16 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >   			goto out;
> >   		} else if (workspace->strm.avail_out =3D=3D 0) {
> >   			/* get another page for the stream end */
> > +			sind--;
> > +			kunmap_local(data_in);
> > +			data_in =3D NULL;
> > +
> > +			sind--;
> >   			kunmap_local(cpage_out);
> >   			cpage_out =3D NULL;
> >   			if (nr_pages =3D=3D nr_dest_pages) {
> >   				out_page =3D NULL;
> > +				put_page(in_page);
> >   				ret =3D -E2BIG;
> >   				goto out;
> >   			}
> > @@ -247,11 +279,18 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >   				ret =3D -ENOMEM;
> >   				goto out;
> >   			}
> > +
> > +			mstack[sind] =3D 'A';
> > +			sind++;
> >   			cpage_out =3D kmap_local_page(out_page);
> >   			pages[nr_pages] =3D out_page;
> >   			nr_pages++;
> >   			workspace->strm.avail_out =3D PAGE_SIZE;
> >   			workspace->strm.next_out =3D cpage_out;
> > +
> > +			mstack[sind] =3D 'B';
> > +			sind++;
> > +			data_in =3D kmap_local_page(in_page);
> >   		}
> >   	}
> >   	zlib_deflateEnd(&workspace->strm);
> > @@ -266,13 +305,15 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >   	*total_in =3D workspace->strm.total_in;
> >   out:
> >   	*out_pages =3D nr_pages;
> > -	if (cpage_out)
> > -		kunmap_local(cpage_out);
> > -
> > -	if (in_page) {
> > -		kunmap(in_page);
> > -		put_page(in_page);
> > +	while (--sind >=3D 0) {
> > +		if (mstack[sind] =3D=3D 'B') {
> > +			kunmap_local(data_in);
> > +			put_page(in_page);
> > +		} else {
> > +			kunmap_local(cpage_out);
> > +		}
> >   	}
> > +
> >   	return ret;
> >   }
> >
>=20




