Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EF954FC3F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 19:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiFQRfs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 13:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiFQRfr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 13:35:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39DC30F41;
        Fri, 17 Jun 2022 10:35:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so4704754wma.4;
        Fri, 17 Jun 2022 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JG77Ksbzsb/soeJQl99bCmVn0dTePRvjgtOFZMKADWs=;
        b=K0EEoUiVJhGlmmb8ZIN/qFl3TgrxIXsVx4kyMEdM9q0/VQW83XmFrf7+OdvUu135wY
         eFsO1+7DMrn0a+2k8ZY5T/CHzQA+f7zSElUXunY3yZMZnrIzx1ey9KcdLQGgU97VWHY4
         iu+w3eBm5zF3ZzcF06ZADuSHMNQ/PpbE1z1/GGsH3ur993sQzepFitZX99CdevdNFRys
         atiG+yinZe00Uw3IPJHUywFsD4gQRJfobQ28X54S9liwHdQBax9E1YnTpQbSrpZe6gRl
         swf1aNDXYom8nhe+LrLnqUeJ/0qekOow3NFkEZoyR0Gq6ppP+9u758evRvBDITILXApY
         Xuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JG77Ksbzsb/soeJQl99bCmVn0dTePRvjgtOFZMKADWs=;
        b=HFEGXAcGO50vqiMMt5loRecEVvZEZZEE+vXHAAn4Z6TgUZvSEEHn17lNEV3RlLAtZT
         nttNDDa8GBUNlJd+Nh+byqwxLIpldZ+EXvPK09vGPZLu4mrJFq2ZEWk3hWizMG5YZhIz
         +8XcYn/1ozpPfKOiZAkjn5GIatAHZgiy3f/L1VZ+qI4P8ROYpRF72SBHdZBpM09uX2ti
         mjHDZ7MriJ2yk9/+5z/pxrTnseqjW6GVWAJ/4fd85YLNrMbixgfLff8FNOnuKVFMj/m0
         PllRonHm2StgmPM584YJA8+/mM834h8rjZvL3SyluTnuZWTHdnESESjGxMW06Hqsdp72
         +K6A==
X-Gm-Message-State: AJIora+Ec0lgAew/Mvka8Hwp0yvSmbIN2E8ba+1L9rbCLoeFeTcHNZkD
        f8cgQuc/GtxiB31KTGZafEw=
X-Google-Smtp-Source: AGRyM1tcRXSihy2cVSX0Bv7/8meK7ya5nROrEvlxxw49JC0IujTSpp9Vomy3YWuKr/tr6C146pptxg==
X-Received: by 2002:a05:600c:4982:b0:39c:3c0d:437c with SMTP id h2-20020a05600c498200b0039c3c0d437cmr11308649wmp.38.1655487345146;
        Fri, 17 Jun 2022 10:35:45 -0700 (PDT)
Received: from opensuse.localnet (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c359300b0039c54bb28f2sm6572999wmq.36.2022.06.17.10.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 10:35:43 -0700 (PDT)
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
Subject: Re: [RFC PATCH v2 1/3] btrfs: Convert zlib_decompress_bio() to use kmap_local_page()
Date:   Fri, 17 Jun 2022 19:35:42 +0200
Message-ID: <13038994.uLZWGnKmhe@opensuse>
In-Reply-To: <f1e0383b-b68e-2044-8e1c-22ea4950c3c6@gmx.com>
References: <20220617120538.18091-1-fmdefrancesco@gmail.com> <20220617120538.18091-2-fmdefrancesco@gmail.com> <f1e0383b-b68e-2044-8e1c-22ea4950c3c6@gmx.com>
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

On venerd=C3=AC 17 giugno 2022 14:51:03 CEST Qu Wenruo wrote:
>=20
> On 2022/6/17 20:05, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page().=20
With
> > kmap_local_page(), the mapping is per thread, CPU local and not=20
globally
> > visible.
> >
> > Therefore, use kmap_local_page() / kunmap_local() in=20
zlib_decompress_bio()
> > because in this function the mappings are per thread and are not=20
visible
> > in other contexts.
> >
> > Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
> > HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".
> >
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>=20
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>=20

Thanks for your review.
I'll forward your tag on to the "real" patch.

=46abio

> Thanks,
> Qu
> > ---
> >   fs/btrfs/zlib.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> > index 767a0c6c9694..770c4c6bbaef 100644
> > --- a/fs/btrfs/zlib.c
> > +++ b/fs/btrfs/zlib.c
> > @@ -287,7 +287,7 @@ int zlib_decompress_bio(struct list_head *ws,=20
struct compressed_bio *cb)
> >   	unsigned long buf_start;
> >   	struct page **pages_in =3D cb->compressed_pages;
> >
> > -	data_in =3D kmap(pages_in[page_in_index]);
> > +	data_in =3D kmap_local_page(pages_in[page_in_index]);
> >   	workspace->strm.next_in =3D data_in;
> >   	workspace->strm.avail_in =3D min_t(size_t, srclen, PAGE_SIZE);
> >   	workspace->strm.total_in =3D 0;
> > @@ -309,7 +309,7 @@ int zlib_decompress_bio(struct list_head *ws,=20
struct compressed_bio *cb)
> >
> >   	if (Z_OK !=3D zlib_inflateInit2(&workspace->strm, wbits)) {
> >   		pr_warn("BTRFS: inflateInit failed\n");
> > -		kunmap(pages_in[page_in_index]);
> > +		kunmap_local(data_in);
> >   		return -EIO;
> >   	}
> >   	while (workspace->strm.total_in < srclen) {
> > @@ -336,13 +336,13 @@ int zlib_decompress_bio(struct list_head *ws,=20
struct compressed_bio *cb)
> >
> >   		if (workspace->strm.avail_in =3D=3D 0) {
> >   			unsigned long tmp;
> > -			kunmap(pages_in[page_in_index]);
> > +			kunmap_local(data_in);
> >   			page_in_index++;
> >   			if (page_in_index >=3D total_pages_in) {
> >   				data_in =3D NULL;
> >   				break;
> >   			}
> > -			data_in =3D kmap(pages_in[page_in_index]);
> > +			data_in =3D=20
kmap_local_page(pages_in[page_in_index]);
> >   			workspace->strm.next_in =3D data_in;
> >   			tmp =3D srclen - workspace->strm.total_in;
> >   			workspace->strm.avail_in =3D min(tmp,=20
PAGE_SIZE);
> > @@ -355,7 +355,7 @@ int zlib_decompress_bio(struct list_head *ws,=20
struct compressed_bio *cb)
> >   done:
> >   	zlib_inflateEnd(&workspace->strm);
> >   	if (data_in)
> > -		kunmap(pages_in[page_in_index]);
> > +		kunmap_local(data_in);
> >   	if (!ret)
> >   		zero_fill_bio(cb->orig_bio);
> >   	return ret;
>=20




