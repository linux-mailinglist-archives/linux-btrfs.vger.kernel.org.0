Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D60954FC5B
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 19:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383263AbiFQRq2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 13:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382906AbiFQRq0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 13:46:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCAD41F82;
        Fri, 17 Jun 2022 10:46:25 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o16so6644821wra.4;
        Fri, 17 Jun 2022 10:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bWqqhzg6EDH00FkWstlgA6aypOxQd9TqmRWDoRnYtAA=;
        b=BjUe1vDdSoqAoUz7VKFaZlaAuJqbPvDhtjlCiFmCs5aldjM/cpMQRko1WEDwJfHsCn
         BhDgi7IvRl70EsZCbU9r5UI9YRZDZ0wSvrabZCJUW4F2I6gOWYGpinOjaukhYwSiGp+Z
         N9J+A43vw0ED2ZmN/SjKlgPPQz5f3mycBms2wt7yAJFjXdE8lvvx5KfjKMnRaITTmAnY
         JR99GrblUKBeGzAgjzcwWl7HhXo9X4uNMNMrP+9C+PUyffflK1bnuGqzbjLzQCTqZz4w
         7LKbO9opOD3JgeeZSjPP0Pl86bsyhkCtRHMlV/MqN1yqu+bWxPWsbug9NMgiAECQ1ee0
         e5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bWqqhzg6EDH00FkWstlgA6aypOxQd9TqmRWDoRnYtAA=;
        b=NYM/D713kirHNF8m3jCaJN7C3hLt2spLmWJF/dUxWuGufqCksZalqFoLYJSBSRPMVt
         VyqWotk0MLvaS4MCC+1epN7NJmE2j025Khuf8cQ7Bs4Z3sUGWc9tZF7+54q57SFdz7qB
         c7gfVh4aT9C8guxGlSAl7Lw2OtQUu6/4igIlwJMMCzltw7LHkiYXVWrC7ztb+VOnFdK4
         smr+P3mhQoLaQnAnNtvKfKLnE+mv5rHHFtsVg3rCD/KuDm/RAhVEkYL/b1w43Gd2WnRX
         1I75bw7uIfxPk+4Bn6Y916Yok21F8oyFiAdmDBdW4Id3bxWm0czAznPWOZCQC9/NFJ6X
         JJJQ==
X-Gm-Message-State: AJIora/QjMAFc1IrAsUQoNvSFwXUSyeb+TYQnvLj0tMFbcB4ZbG5gXQ2
        LqcMd83HgF3yVCextPWkX6Q=
X-Google-Smtp-Source: AGRyM1tExtV/lxMedWBAAy0JdD+Lh0chvwQwP7+ESOWY0szbxjA8PRETbF2ZWnbeHydIZ4wNrXCJbA==
X-Received: by 2002:a05:6000:2cf:b0:212:27f4:5f80 with SMTP id o15-20020a05600002cf00b0021227f45f80mr10221380wry.545.1655487984108;
        Fri, 17 Jun 2022 10:46:24 -0700 (PDT)
Received: from opensuse.localnet (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b0020fe35aec4bsm5485017wrr.70.2022.06.17.10.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 10:46:22 -0700 (PDT)
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
Subject: Re: [RFC PATCH v2 2/3] btrfs: Use kmap_local_page() on "out_page" in zlib_compress_pages()
Date:   Fri, 17 Jun 2022 19:46:21 +0200
Message-ID: <3674366.kQq0lBPeGt@opensuse>
In-Reply-To: <e2376a4f-2c9b-9aa6-4358-513fa6a30e67@gmx.com>
References: <20220617120538.18091-1-fmdefrancesco@gmail.com> <20220617120538.18091-3-fmdefrancesco@gmail.com> <e2376a4f-2c9b-9aa6-4358-513fa6a30e67@gmx.com>
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

On venerd=C3=AC 17 giugno 2022 14:54:22 CEST Qu Wenruo wrote:
>=20
> On 2022/6/17 20:05, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page().=20
With
> > kmap_local_page(), the mapping is per thread, CPU local and not=20
globally
> > visible.
> >
> > Therefore, use kmap_local_page() / kunmap_local() for "out_page" in
> > zlib_compress_pages() because in this function the mappings are per=20
thread
> > and are not visible in other contexts.
> >
> > Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
> > HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".
> >
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>=20
> Looks good to me.
>=20
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>=20

Again, thanks.

> The change is just to use @cpage_out to indicate if it's mapped (NULL =3D
> not mapped).
>=20

Most of the conversions are quite easy, I would say "mechanical".
As you already noted in 3/3, there are cases where it's not that simple :-(

> Just a small nit inlined below.
>=20
> > ---
> >   fs/btrfs/zlib.c | 20 +++++++++++---------
> >   1 file changed, 11 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> > index 770c4c6bbaef..c7c69ce4a1a9 100644
> > --- a/fs/btrfs/zlib.c
> > +++ b/fs/btrfs/zlib.c
> > @@ -97,8 +97,8 @@ int zlib_compress_pages(struct list_head *ws, struct=
=20
address_space *mapping,
> >   {
> >   	struct workspace *workspace =3D list_entry(ws, struct workspace,=20
list);
> >   	int ret;
> > -	char *data_in;
> > -	char *cpage_out;
> > +	char *data_in =3D NULL;
>=20
> I didn't see any diff touching @data_in, any idea why it's initialized
> to NULL?
>=20

I suppose it's a relic of RFC v1 that I overlooked when I split it into=20
three patches. I will remember to avoid initialization in the "real" patch.

=46abio

>
> Thanks,
> Qu
>=20
> > +	char *cpage_out =3D NULL;
> >   	int nr_pages =3D 0;
> >   	struct page *in_page =3D NULL;
> >   	struct page *out_page =3D NULL;
> > @@ -126,7 +126,7 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >   		ret =3D -ENOMEM;
> >   		goto out;
> >   	}
> > -	cpage_out =3D kmap(out_page);
> > +	cpage_out =3D kmap_local_page(out_page);
> >   	pages[0] =3D out_page;
> >   	nr_pages =3D 1;
> >
> > @@ -196,7 +196,8 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >   		 * the stream end if required
> >   		 */
> >   		if (workspace->strm.avail_out =3D=3D 0) {
> > -			kunmap(out_page);
> > +			kunmap_local(cpage_out);
> > +			cpage_out =3D NULL;
> >   			if (nr_pages =3D=3D nr_dest_pages) {
> >   				out_page =3D NULL;
> >   				ret =3D -E2BIG;
> > @@ -207,7 +208,7 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >   				ret =3D -ENOMEM;
> >   				goto out;
> >   			}
> > -			cpage_out =3D kmap(out_page);
> > +			cpage_out =3D kmap_local_page(out_page);
> >   			pages[nr_pages] =3D out_page;
> >   			nr_pages++;
> >   			workspace->strm.avail_out =3D PAGE_SIZE;
> > @@ -234,7 +235,8 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >   			goto out;
> >   		} else if (workspace->strm.avail_out =3D=3D 0) {
> >   			/* get another page for the stream end */
> > -			kunmap(out_page);
> > +			kunmap_local(cpage_out);
> > +			cpage_out =3D NULL;
> >   			if (nr_pages =3D=3D nr_dest_pages) {
> >   				out_page =3D NULL;
> >   				ret =3D -E2BIG;
> > @@ -245,7 +247,7 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >   				ret =3D -ENOMEM;
> >   				goto out;
> >   			}
> > -			cpage_out =3D kmap(out_page);
> > +			cpage_out =3D kmap_local_page(out_page);
> >   			pages[nr_pages] =3D out_page;
> >   			nr_pages++;
> >   			workspace->strm.avail_out =3D PAGE_SIZE;
> > @@ -264,8 +266,8 @@ int zlib_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >   	*total_in =3D workspace->strm.total_in;
> >   out:
> >   	*out_pages =3D nr_pages;
> > -	if (out_page)
> > -		kunmap(out_page);
> > +	if (cpage_out)
> > +		kunmap_local(cpage_out);
> >
> >   	if (in_page) {
> >   		kunmap(in_page);
>=20




