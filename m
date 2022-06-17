Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF46B54FCE4
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 20:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiFQSZM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 14:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiFQSZJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 14:25:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC993054F;
        Fri, 17 Jun 2022 11:25:08 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v14so6753798wra.5;
        Fri, 17 Jun 2022 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DaTMv7c0fnBp0Uut3i7PQTEWmBA8wJbUlANhDqS83eQ=;
        b=DURYDGHkjZbouNuuv4WYmc1kJPZsA00Mp/iXDF6TosQM+mEA9XpV7xBQ1rjSF+qoYL
         FhgreG3fSqp2xU7p1CsmI8fQGgsdA7UmTx60E2L/ZJ3zW5+evjZ6UGbu4vUqh58t89BO
         RKgOU/LjJ+a/Lyns0jvoMLi9TayT95hbywAHe3eHlQXveBvzt2xKCGhxDhqo9+1g+FmH
         /l7gExhJG8I59Dfm9dJj+9wpNb/GhFlqjTsWutlAopmUyIQGUYN32+yyaQ3YuKpKB3oW
         IANZi8eYM+/N/9IAozljNNMzK3JuWvQK7O+lxTEk0qVGda/DtzJjwUzQFWqIy1HGNYjN
         HKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaTMv7c0fnBp0Uut3i7PQTEWmBA8wJbUlANhDqS83eQ=;
        b=wjrXSk1C2i/w910nzU4lkEzUR8sHhhdajoH+auOIg2HcGoMqrkmOGXIYRNZetWp4mZ
         oST410tOgoPFq78HYAeqJieHHvUYWlxGua6OZkOmThPgALgAFYhhU1KSiZ9evUGX4d5K
         9evWIHuweh+6sPlMl/c6HK4by3xbsZgNmETaAL23Zsd8xB60zv+BjGD6dLxBQtv7z8La
         8PljWbmoSv5yqUg/F4b2OVJ5p2bDTKthUqzW7NOnDEsVxx3f0WUsByKDh7ywtIKGiPrz
         u1Ks3a9hnZvQMvCObeL09b/LJ4k2hWdei8zHyUq9yaScQWcavEQTPRpKxrb2/cPvGnzh
         Uc/Q==
X-Gm-Message-State: AJIora+dicPsDxceQXH2EhrQTQTO3hUMSiZkGIjbZvzlDPps8zpYPKDM
        noX6Sy0yBD74AWETFLW1QZ0=
X-Google-Smtp-Source: AGRyM1taEDkld2LWuGVvoLrZKZOf4p2VD51INQh1wtDLrGLcwPwhIElFvAamCZZCtQVarVSRrwt89Q==
X-Received: by 2002:a5d:414a:0:b0:21b:81fd:6b7f with SMTP id c10-20020a5d414a000000b0021b81fd6b7fmr2770533wrq.309.1655490307225;
        Fri, 17 Jun 2022 11:25:07 -0700 (PDT)
Received: from opensuse.localnet (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id a14-20020a5d508e000000b002102d4ed579sm5490887wrt.39.2022.06.17.11.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 11:25:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/3] btrfs: Use kmap_local_page() on "in_page" in zlib_compress_pages()
Date:   Fri, 17 Jun 2022 20:25:04 +0200
Message-ID: <2037432.KlZ2vcFHjT@opensuse>
In-Reply-To: <20220617142024.GL20633@twin.jikos.cz>
References: <20220617120538.18091-1-fmdefrancesco@gmail.com> <8cbfc1ff-f86d-f2cc-d37e-ef874f4600bc@gmx.com> <20220617142024.GL20633@twin.jikos.cz>
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

On venerd=C3=AC 17 giugno 2022 16:20:24 CEST David Sterba wrote:
> On Fri, Jun 17, 2022 at 09:09:47PM +0800, Qu Wenruo wrote:
> > On 2022/6/17 20:05, Fabio M. De Francesco wrote:
> > > @@ -126,6 +128,8 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> > >   		ret =3D -ENOMEM;
> > >   		goto out;
> > >   	}
> > > +	mstack[sind] =3D 'A';
> > > +	sind++;
> > >   	cpage_out =3D kmap_local_page(out_page);
> > >   	pages[0] =3D out_page;
> > >   	nr_pages =3D 1;
> > > @@ -148,26 +152,32 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> > >   				int i;
> > >
> > >   				for (i =3D 0; i < in_buf_pages; i++)=20
{
> > > -					if (in_page) {
> > > -					=09
kunmap(in_page);
> >=20
> > I don't think we really need to keep @in_page mapped for that long.
> >=20
> > We only need the input pages (pages from inode page cache) when we run
> > out of input.
> >=20
> > So what we really need is just to map the input, copy the data to
> > buffer, unmap the page.
> >=20
> > > +					if (data_in) {
> > > +						sind--;
> > > +					=09
kunmap_local(data_in);
> > >   					=09
put_page(in_page);
> > >   					}
> > >   					in_page =3D=20
find_get_page(mapping,
> > >   							=09
start >> PAGE_SHIFT);
> > > -					data_in =3D kmap(in_page);
> > > +					mstack[sind] =3D 'B';
> > > +					sind++;
> > > +					data_in =3D=20
kmap_local_page(in_page);
> > >   					memcpy(workspace->buf + i=20
* PAGE_SIZE,
> > >   					       data_in,=20
PAGE_SIZE);
> > >   					start +=3D PAGE_SIZE;
> > >   				}
> > >   				workspace->strm.next_in =3D=20
workspace->buf;
> > >   			} else {
> >=20
> > I think we can clean up the code.
> >=20
> > In fact the for loop can handle both case, I didn't see any special
> > reason to do different handling, we can always use workspace->buf,
> > instead of manually dancing using different paths.
> >=20
> > I believe with all these cleanup, it should be much simpler to convert
> > to kmap_local_page().
> >=20
> > I'm pretty happy to provide help on this refactor if you don't feel
> > confident enough on this part of btrfs.
>=20
> My first thought was "why to clean up zlib loop if we want to just
> replace kmap" but after seeing the whole stack and fiddling with the
> indexes I agree that a simplification should be done first.
>=20
I'm afraid that cleaning up that loop won't be enough.

My major problem with this conversion were about the ordering of nested=20
mappings / un-mappings (especially when the code jumps to the "out" label=20
from different paths. Different paths may require different un-mappings=20
orders to not break the stack (LIFO) nesting rules: map(A), map(B),=20
unmap(B), unmap(A), and further variations on this fundamental requirement.=
=20

OK, I might very well be wrong... but I think that what led to the=20
introduction of that horrid hack, I mean that array based stack, seem to=20
have very little to do with the different handling of assignments of=20
kaddr's in that loop.

If I'm missing the point, I'd appreciate clarifications and suggestions=20
about how to work out this task with a much more elegant strategy.

Thanks so much,

=46abio


