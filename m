Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6949054A2A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 01:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiFMXW5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 19:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245007AbiFMXW4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 19:22:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED6331DF7;
        Mon, 13 Jun 2022 16:22:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so5324153wms.5;
        Mon, 13 Jun 2022 16:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N6LCBec1W8ZWJCovHT0K9vDII0S3kSkxQgIBwwCRgLY=;
        b=meIQyKG3JMG/oYSUKrWK+xDlvmc0UzfQSZi4U06ahLbbBnQGpIz+3GIP2sfyajmjhK
         Tpxl9xXlPiIrE7rTPIqTxxo1RTD8Pt8jgosvRzA7OmMXVWAsCTns2aJ1rXcdGhDtwttC
         7WgRZOM2BsFGTpqYMfXr2vwTBNNFm2sx1Dq3gxpTfVwCZbva5JH8dm9wa93pg+SChGQZ
         7jPlnDcI52R2M8T505nWuG4iPjyKDSer6ax8fGLMhdCbJDwesd5OYAbgS9BQzW39XUWz
         BnuRFkVdPdVoxgC6zGb1qKfLNLUG8pAC+ILxrk369Qbns0o8bKi2NxT9bnXNR4xN7oep
         XqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6LCBec1W8ZWJCovHT0K9vDII0S3kSkxQgIBwwCRgLY=;
        b=5VF9PevWyGDoowqp1c/gMmwheizC4yl5IsFFmxW7kX+HLfqK4AXxdXLQzBSdMZyzfI
         4FBU6AJAsuOEBqBOEsQSoDQzi9dJxZyc37woCS5hzF1XlnV1uD88J5EgjgRQvWyuIRFK
         3qgqAlnXPROjwMAnbjdlkxIAs21SOvAwXCqyJQz+PiqxbZ3AnZ+Vk9mq6/L07CghZmGQ
         kKQ+7Sr6l6IiSK8yjver7bqFZKotABk3BD5bhIBDFoVVyu9eYhaU5RKu1yaDO6TvucH4
         aR6xGfy0ARgIg0AFMQczMhzvXzIuaFl5OmuB5d02gP0Ou+mfzUFQeElvD3L02bI8Tm4v
         X0Tw==
X-Gm-Message-State: AOAM532LkUNQvy7DwMseEO39c+jxncxA6EuBqLMxSaGdWlP5ktG7zBYl
        KTkIWEzyV1kaFyLv5lYAZ/k=
X-Google-Smtp-Source: ABdhPJxh9f7PwyRxtKu1GN1I22pEHEnqpSxoBB3/oxueimhNH50jAQKvLfwGDxDG5FyBY66ah+U20A==
X-Received: by 2002:a1c:cc07:0:b0:39c:7416:6a52 with SMTP id h7-20020a1ccc07000000b0039c74166a52mr1060917wmb.119.1655162573167;
        Mon, 13 Jun 2022 16:22:53 -0700 (PDT)
Received: from opensuse.localnet (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id m3-20020a7bcb83000000b0039c95b31812sm4564479wmi.31.2022.06.13.16.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 16:22:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     dsterba@suse.cz
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Tue, 14 Jun 2022 01:22:50 +0200
Message-ID: <1936552.usQuhbGJ8B@opensuse>
In-Reply-To: <20220613183913.GD20633@twin.jikos.cz>
References: <20220611135203.27992-1-fmdefrancesco@gmail.com> <20220613183913.GD20633@twin.jikos.cz>
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

On luned=C3=AC 13 giugno 2022 20:39:13 CEST David Sterba wrote:
> On Sat, Jun 11, 2022 at 03:52:03PM +0200, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page().=20
With
> > kmap_local_page(), the mapping is per thread, CPU local and not=20
globally
> > visible.
> >=20
> > Therefore, use kmap_local_page() / kunmap_local() in zstd.c because in
> > this file the mappings are per thread and are not visible in other
> > contexts; meanwhile refactor zstd_compress_pages() to comply with=20
nested
> > local mapping / unmapping ordering rules.
> >=20
> > Tested with xfstests on a QEMU + KVM 32 bits VM with 4GB of RAM and
> > HIGHMEM64G enabled.
> >=20
> > Cc: Filipe Manana <fdmanana@kernel.org>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >=20
> > @@ -477,15 +479,16 @@ int zstd_compress_pages(struct list_head *ws,=20
struct address_space *mapping,
> >  		/* Check if we need more input */
> >  		if (workspace->in_buf.pos =3D=3D workspace->in_buf.size) {
> >  			tot_in +=3D PAGE_SIZE;
> > -			kunmap(in_page);
> > +			kunmap_local(workspace->out_buf.dst);
> > +			kunmap_local((void *)workspace->in_buf.src);
>=20
> Why is the cast needed?

As I wrote in an email I sent some days ago ("[RFC PATCH] btrfs: Replace=20
kmap() with kmap_local_page() in zstd.c")[1] I get a series of errors like=
=20
the following:

/usr/src/git/kernels/linux/fs/btrfs/zstd.c:547:33: warning: passing=20
argument 1 of '__kunmap_local' discards 'const' qualifier from pointer=20
target type [-Wdiscarded-qualifiers]
  547 |   kunmap_local(workspace->in_buf.src);
      |                ~~~~~~~~~~~~~~~~~^~~~
/usr/src/git/kernels/linux/include/linux/highmem-internal.h:284:17: note:=20
in definition of macro 'kunmap_local'
  284 |  __kunmap_local(__addr);     \
      |                 ^~~~~~
/usr/src/git/kernels/linux/include/linux/highmem-internal.h:92:41: note:=20
expected 'void *' but argument is of type 'const void *'
   92 | static inline void __kunmap_local(void *vaddr)
      |                                   ~~~~~~^~~~~

Therefore, this is a (bad?) hack to make these changes compile.
A better solution is changing the prototype of __kunmap_local(); I
suppose that Andrew won't object, but who knows?

(+Cc Andrew Morton).

I was waiting for your comments. At now I've done about 15 conversions=20
across the kernel but it's the first time I had to pass a pointer to const=
=20
void to kunmap_local(). Therefore, I was not sure if changing the API were=
=20
better suited (however I have already discussed this with Ira).

> I see that it leads to a warning but we pass a
> const buffer and that breaks the API contract as in kunmap it would be
> accessed as non-const and potentially changed without warning or
> compiler error. If kunmap_local does not touch the buffer

Yes, correct, kunmap_local() does _not_ touch the buffer.

> and 'const
> void*' would work too, then it should be fixed.

I'll send an RFC patch for changing __kunmap_local() and the other
functions of the calls chain down to kunmap_local_indexed().
=46urthermore, changes to kunmap_local_indexed() prototype require also=20
changes to __kunmap_atomic() (if I recall correctly...).

Thanks for your review,

=46abio


