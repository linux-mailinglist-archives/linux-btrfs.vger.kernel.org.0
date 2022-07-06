Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D0F568615
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiGFKs5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 06:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbiGFKs4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 06:48:56 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53979240A3;
        Wed,  6 Jul 2022 03:48:53 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i126so19496690oih.4;
        Wed, 06 Jul 2022 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ewXVGM5pcJQ/1oCIdyUacMELFTqjftWEiEU6+TD2I4=;
        b=l8LhmeiCFiIQ3zw/H8LykNHRNThsdFhVLrfaxCPsB48WNv2mB+g4AuO3iO20jnmlwc
         R+oxZROuokUbHCc2BLePYPnMvrLu6EC8Q48tGfz3XSEfDjC35EKw4mQr2r5EDKNymaei
         kCWEacGY69jEgdwjLxRH5xpaJ6d07wp9jaMTajWFouVDSoB26eaiBE3wYtiFMy98QZvx
         baF4+q7mBEtEHJ047EerVpeyhR/ElY9w6wphx3k+XzEPuiub6DJ8XFofYZwekSGTucrk
         d2Ujrjwpa9ZzHmfouHgaZUtqLtow3add7Dpp5Zi1c+htlLkJQYzAziLp/WxyXfgeqq4/
         8o0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ewXVGM5pcJQ/1oCIdyUacMELFTqjftWEiEU6+TD2I4=;
        b=GKUJ+LEDHC7pEfgro/s28giA9ZHLBxVLbHibOGKYJJbrZ36cDwRoz0daPcuAqME31e
         daD+WvHtQ8k5DnqGorcHHniXOFpshwK0sE++Z4YgU5doyVWexCD+elroWpemv1IZ5LlG
         wTPjI/rPWTfYNltIxc5kMbeyQvqtc3StzCDsubx2AagJ5ln8EXbF4lJmu7NxJKBSCyj/
         1cuVUZxES+gv1jrYaD0ypCA94f7kr22Mc4PmYczDCBLJrHelUQE5VGg6uGVdNyNDczkl
         +6BOnEBHmPjculnGoVV339lcxugq+sPiAAC9kpK69zZu4tpKSUyAfGvYdCJZ00utzWcc
         9uFQ==
X-Gm-Message-State: AJIora+71N0ne4FB6UVtZwHXpURK4RkZ/UgAG0UkTYVVw1ivYqIHR7ye
        TxgGm1z5BoQDhEbUYPbElJo=
X-Google-Smtp-Source: AGRyM1txiXE8vAwrRVxegQt6dZ6/JJJEtUcPyH6KnE3awClSZtN5U9+ofB/jQVtGMDlK4PBTitY+dA==
X-Received: by 2002:a05:6808:1815:b0:337:9464:85d with SMTP id bh21-20020a056808181500b003379464085dmr14778873oib.203.1657104532606;
        Wed, 06 Jul 2022 03:48:52 -0700 (PDT)
Received: from opensuse.localnet (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id q10-20020a056830232a00b0060b1f3924c3sm17411265otg.44.2022.07.06.03.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:48:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "James E. J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        linux-parisc@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>
Subject: Re: [PATCH v5 2/2] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Wed, 06 Jul 2022 12:48:46 +0200
Message-ID: <1826872.tdWV9SEqCh@opensuse>
In-Reply-To: <2250236.ElGaqSPkdT@opensuse>
References: <20220704152322.20955-1-fmdefrancesco@gmail.com> <YsSLJBzwB5bCyuNR@iweiny-desk3> <2250236.ElGaqSPkdT@opensuse>
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

On mercoled=C3=AC 6 luglio 2022 12:38:29 CEST Fabio M. De Francesco wrote:
> On marted=C3=AC 5 luglio 2022 21:04:04 CEST Ira Weiny wrote:
> > On Mon, Jul 04, 2022 at 05:23:22PM +0200, Fabio M. De Francesco wrote:
> > > The use of kmap() is being deprecated in favor of kmap_local_page().=
=20
> With
> > > kmap_local_page(), the mapping is per thread, CPU local and not=20
> globally
> > > visible.
> > >=20
> > > Therefore, use kmap_local_page() / kunmap_local() in zstd.c because=20
in=20
> this
> > > file the mappings are per thread and are not visible in other=20
contexts.=20
> In
> > > the meanwhile use plain page_address() on pages allocated with the=20
> GFP_NOFS
> > > flag instead of calling kmap*() on them (since they are always=20
> allocated
> > > from ZONE_NORMAL).
> > >=20
> > > Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
> > > booting a kernel with HIGHMEM64G enabled.
> > >=20
> > > Cc: Filipe Manana <fdmanana@kernel.org>
> > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >  fs/btrfs/zstd.c | 34 ++++++++++++++--------------------
> > >  1 file changed, 14 insertions(+), 20 deletions(-)
> > >=20
> > > diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> > > index 0fe31a6f6e68..78e0272e770e 100644
> > > --- a/fs/btrfs/zstd.c
> > > +++ b/fs/btrfs/zstd.c
> > > @@ -403,7 +403,7 @@ int zstd_compress_pages(struct list_head *ws,=20
> struct address_space *mapping,
> > > =20
> > >  	/* map in the first page of input data */
> > >  	in_page =3D find_get_page(mapping, start >> PAGE_SHIFT);
> > > -	workspace->in_buf.src =3D kmap(in_page);
> > > +	workspace->in_buf.src =3D kmap_local_page(in_page);
> > >  	workspace->in_buf.pos =3D 0;
> > >  	workspace->in_buf.size =3D min_t(size_t, len, PAGE_SIZE);
> > > =20
> > > @@ -415,7 +415,7 @@ int zstd_compress_pages(struct list_head *ws,=20
> struct address_space *mapping,
> > >  		goto out;
> > >  	}
> > >  	pages[nr_pages++] =3D out_page;
> > > -	workspace->out_buf.dst =3D kmap(out_page);
> > > +	workspace->out_buf.dst =3D page_address(out_page);
> > >  	workspace->out_buf.pos =3D 0;
> > >  	workspace->out_buf.size =3D min_t(size_t, max_out, PAGE_SIZE);
> > > =20
> > > @@ -450,9 +450,7 @@ int zstd_compress_pages(struct list_head *ws,=20
> struct address_space *mapping,
> > >  		if (workspace->out_buf.pos =3D=3D workspace->out_buf.size)=20
> {
> > >  			tot_out +=3D PAGE_SIZE;
> > >  			max_out -=3D PAGE_SIZE;
> > > -			kunmap(out_page);
> > >  			if (nr_pages =3D=3D nr_dest_pages) {
> > > -				out_page =3D NULL;
> > >  				ret =3D -E2BIG;
> > >  				goto out;
> > >  			}
> > > @@ -462,7 +460,7 @@ int zstd_compress_pages(struct list_head *ws,=20
> struct address_space *mapping,
> > >  				goto out;
> > >  			}
> > >  			pages[nr_pages++] =3D out_page;
> > > -			workspace->out_buf.dst =3D kmap(out_page);
> > > +			workspace->out_buf.dst =3D=20
> page_address(out_page);
> > >  			workspace->out_buf.pos =3D 0;
> > >  			workspace->out_buf.size =3D min_t(size_t,=20
> max_out,
> > >  						=09
> PAGE_SIZE);
> > > @@ -477,15 +475,15 @@ int zstd_compress_pages(struct list_head *ws,=20
> struct address_space *mapping,
> > >  		/* Check if we need more input */
> > >  		if (workspace->in_buf.pos =3D=3D workspace->in_buf.size) {
> > >  			tot_in +=3D PAGE_SIZE;
> > > -			kunmap(in_page);
> > > +			kunmap_local(workspace->in_buf.src);
> > >  			put_page(in_page);
> > > -
> > >  			start +=3D PAGE_SIZE;
> > >  			len -=3D PAGE_SIZE;
> > >  			in_page =3D find_get_page(mapping, start >>=20
> PAGE_SHIFT);
> > > -			workspace->in_buf.src =3D kmap(in_page);
> > > +			workspace->in_buf.src =3D=20
> kmap_local_page(in_page);
> > >  			workspace->in_buf.pos =3D 0;
> > >  			workspace->in_buf.size =3D min_t(size_t, len,=20
> PAGE_SIZE);
> > > +			workspace->out_buf.dst =3D=20
> page_address(out_page);
> >=20
> > Why is this needed?
>=20
> Sorry. This initialization is not needed at all.
> Probably made a mistake with copy-pasting snippets of code.
>=20
> I'm going to send ASAP the fifth version of this series.

"fifth" -> "sixth".

>=20
> > The rest looks good,
>=20
> Thanks,
>=20
> Fabio
>=20
> > Ira
> >=20
> > [snip]
> >=20
>=20
>=20
>=20
>=20




