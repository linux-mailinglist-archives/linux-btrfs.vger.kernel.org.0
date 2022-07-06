Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8045685C1
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiGFKii (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 06:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiGFKig (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 06:38:36 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D0B64F9;
        Wed,  6 Jul 2022 03:38:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so10909466wmc.1;
        Wed, 06 Jul 2022 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YU7/aTVmwMw1xiBrffIxn8qMUTw+gm+umroriH5I92o=;
        b=ghSozxp8QV21TAro3RolO4UMKa+ccDr5PJ59lVX3tlVeCT7KTpO1FEbFAWdQL9A9Q/
         Vulcqud9QeYF5LlhpGGu5zFNVp7E0Pw1H5AKFUDG2J0sEw8BNJTPrOLa23xwxFGdYjKf
         If5VMtxoBF9DKYqHHkC2gisg2D1nGqpEv3ZjaQf+aDUmlgQG8PyPmHQ+p87NZ5pL+DU2
         tsWjcMEmSKV+k8rV0ibunpSkVo4CpOltRtd0xY3hltVRq/6bETrZpMViQfqwdm2LZJvt
         ozlHQfX4HjQlurVfc5cKdfTFBC0fE5p4WvIIqSK2UZfiEAdpOcjGjgmTgMXFZg9Ud90k
         DzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YU7/aTVmwMw1xiBrffIxn8qMUTw+gm+umroriH5I92o=;
        b=uJtSFpx5B/Cli1bD+7gHQL9eS3jlQSI6P0UMXxWGRCqWKvA1Yh/LASR5s2FWD3Yhse
         3LuG7jIgzAofQoyJ+mCvnD6WVjEP+8uElqCnDCTFsCohNfEYZaJWxfGJwnpUKHJuNztH
         SOWEGIKHiH/SwcqCrQGX+azYbn+pi1WeqXgg1iZyEUimFgUQBbD5gC2MqObTgqLXQ//m
         2exhvtMgth4jwUL93gGOwJhDfz80qtX+v0HpdVpfMXT6z9Fwv3buR8nkjlNnCWm+lTMM
         l1yy5ejy8UIxkYZWp9U5a3w+z79oeiOQeRbkXAdZBrRbERg8WRSOgvOjWkOYtst1Kpu0
         h6gA==
X-Gm-Message-State: AJIora/mhFm4KLIdifXqu2G+74T1nkv6ES+lC0mBBqZUytz6TaFDodIb
        oI094RcXjLGbAfNgwMNbIws=
X-Google-Smtp-Source: AGRyM1t7dpxKdmG7n71wWdoedPFPmkmnYg17fxZqQSno2zFUho02OLAK4wpsuebRyha/rsbvmeEh0Q==
X-Received: by 2002:a7b:c4cb:0:b0:3a2:b45a:e344 with SMTP id g11-20020a7bc4cb000000b003a2b45ae344mr12785004wmk.157.1657103914353;
        Wed, 06 Jul 2022 03:38:34 -0700 (PDT)
Received: from opensuse.localnet (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id g1-20020adffc81000000b00213ba3384aesm36323831wrr.35.2022.07.06.03.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:38:32 -0700 (PDT)
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
Date:   Wed, 06 Jul 2022 12:38:29 +0200
Message-ID: <2250236.ElGaqSPkdT@opensuse>
In-Reply-To: <YsSLJBzwB5bCyuNR@iweiny-desk3>
References: <20220704152322.20955-1-fmdefrancesco@gmail.com> <20220704152322.20955-3-fmdefrancesco@gmail.com> <YsSLJBzwB5bCyuNR@iweiny-desk3>
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

On marted=C3=AC 5 luglio 2022 21:04:04 CEST Ira Weiny wrote:
> On Mon, Jul 04, 2022 at 05:23:22PM +0200, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page().=20
With
> > kmap_local_page(), the mapping is per thread, CPU local and not=20
globally
> > visible.
> >=20
> > Therefore, use kmap_local_page() / kunmap_local() in zstd.c because in=
=20
this
> > file the mappings are per thread and are not visible in other contexts.=
=20
In
> > the meanwhile use plain page_address() on pages allocated with the=20
GFP_NOFS
> > flag instead of calling kmap*() on them (since they are always=20
allocated
> > from ZONE_NORMAL).
> >=20
> > Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
> > booting a kernel with HIGHMEM64G enabled.
> >=20
> > Cc: Filipe Manana <fdmanana@kernel.org>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  fs/btrfs/zstd.c | 34 ++++++++++++++--------------------
> >  1 file changed, 14 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> > index 0fe31a6f6e68..78e0272e770e 100644
> > --- a/fs/btrfs/zstd.c
> > +++ b/fs/btrfs/zstd.c
> > @@ -403,7 +403,7 @@ int zstd_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> > =20
> >  	/* map in the first page of input data */
> >  	in_page =3D find_get_page(mapping, start >> PAGE_SHIFT);
> > -	workspace->in_buf.src =3D kmap(in_page);
> > +	workspace->in_buf.src =3D kmap_local_page(in_page);
> >  	workspace->in_buf.pos =3D 0;
> >  	workspace->in_buf.size =3D min_t(size_t, len, PAGE_SIZE);
> > =20
> > @@ -415,7 +415,7 @@ int zstd_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >  		goto out;
> >  	}
> >  	pages[nr_pages++] =3D out_page;
> > -	workspace->out_buf.dst =3D kmap(out_page);
> > +	workspace->out_buf.dst =3D page_address(out_page);
> >  	workspace->out_buf.pos =3D 0;
> >  	workspace->out_buf.size =3D min_t(size_t, max_out, PAGE_SIZE);
> > =20
> > @@ -450,9 +450,7 @@ int zstd_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >  		if (workspace->out_buf.pos =3D=3D workspace->out_buf.size)=20
{
> >  			tot_out +=3D PAGE_SIZE;
> >  			max_out -=3D PAGE_SIZE;
> > -			kunmap(out_page);
> >  			if (nr_pages =3D=3D nr_dest_pages) {
> > -				out_page =3D NULL;
> >  				ret =3D -E2BIG;
> >  				goto out;
> >  			}
> > @@ -462,7 +460,7 @@ int zstd_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >  				goto out;
> >  			}
> >  			pages[nr_pages++] =3D out_page;
> > -			workspace->out_buf.dst =3D kmap(out_page);
> > +			workspace->out_buf.dst =3D=20
page_address(out_page);
> >  			workspace->out_buf.pos =3D 0;
> >  			workspace->out_buf.size =3D min_t(size_t,=20
max_out,
> >  						=09
PAGE_SIZE);
> > @@ -477,15 +475,15 @@ int zstd_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >  		/* Check if we need more input */
> >  		if (workspace->in_buf.pos =3D=3D workspace->in_buf.size) {
> >  			tot_in +=3D PAGE_SIZE;
> > -			kunmap(in_page);
> > +			kunmap_local(workspace->in_buf.src);
> >  			put_page(in_page);
> > -
> >  			start +=3D PAGE_SIZE;
> >  			len -=3D PAGE_SIZE;
> >  			in_page =3D find_get_page(mapping, start >>=20
PAGE_SHIFT);
> > -			workspace->in_buf.src =3D kmap(in_page);
> > +			workspace->in_buf.src =3D=20
kmap_local_page(in_page);
> >  			workspace->in_buf.pos =3D 0;
> >  			workspace->in_buf.size =3D min_t(size_t, len,=20
PAGE_SIZE);
> > +			workspace->out_buf.dst =3D=20
page_address(out_page);
>=20
> Why is this needed?

Sorry. This initialization is not needed at all.
Probably made a mistake with copy-pasting snippets of code.

I'm going to send ASAP the fifth version of this series.

> The rest looks good,

Thanks,

=46abio

> Ira
>=20
> [snip]
>=20



