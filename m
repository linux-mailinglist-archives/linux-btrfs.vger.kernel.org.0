Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1A54A2D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 01:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiFMXmP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jun 2022 19:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbiFMXmL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jun 2022 19:42:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08C22DA85;
        Mon, 13 Jun 2022 16:42:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c21so8986957wrb.1;
        Mon, 13 Jun 2022 16:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BqLPgnt38XK3+1flx+cJ50K0T5w1aKxXxWvixx4crk=;
        b=bLC/ckf8aVxfDXk31aCezh66sdJFhknQhLFJ0q1v/dlhrNPwlu9SnRYihDRnAXpKkG
         na3N4485QvOLlYzk5xTEafsOuNwHONoTc2WYWmGnKSMOeEDEdsI1KhvKJqYix+ExwIZW
         Xfm+radbdGi3BrGWb0ILzQYgnwwt4JlxTGVqSvfNUgkLk6dfvS4IE6UM4LWclLpZTTVw
         voU7y3SVYSjYoMizEwzCkkMMr63U0McWSCZ18OPxjzmELtd4Z53OBbyH6+oMz4+6SMBp
         WGoCJjyCNE8Fsy3XajX7BSZRlhdGmBwZWCxwTBnMfrEsv1arCHaboBSJXOLT73yEMsGe
         a1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BqLPgnt38XK3+1flx+cJ50K0T5w1aKxXxWvixx4crk=;
        b=iqMJulwnrPAHzKsk0UdCMynhtgyKRCh6If1dlpsjOc9qlBcZGH8vVkw5WLhWnaYw6Z
         Ex39CoodLEpa//u/Q6QSc9nM9qNZCZkvKWU4KZGi/BEbH8pCcpB6XOGyAZIyzMd0jT0j
         zACnO59TBeKS5oRux5tmpRo6/fPVNjT5+6UsT2Tcp/hBvzmhlnpWV/dvyuo5MRSOFbIO
         +SHQgkJONQENfq7xmfXpp7SWoKlECn1ZjqKrtAW/J6O6dQFJCtMAud3Glp+UVyfbB+v7
         j3Q7GYVgKbkcHfpf64qDRX7WJWE2v3P2os7uk4GqVdHGrUfsN2uZDLPLjaa49SCeStHi
         JUWw==
X-Gm-Message-State: AJIora/BcIE0J5N0/A8MHz/n/foIV7DkbMF9NhOsY1Tt+fKQFNbttdUM
        7FC2iZ5Co1dIXa6QNIemuBY=
X-Google-Smtp-Source: AGRyM1t624Q/IT0+30IWscJwCycdczT3rfyc82nN1SCMVcuyfrfbpyx9+3I0gXF9JjS/bGXdfUv16g==
X-Received: by 2002:a05:6000:2ab:b0:211:7fef:7730 with SMTP id l11-20020a05600002ab00b002117fef7730mr1905418wry.533.1655163729466;
        Mon, 13 Jun 2022 16:42:09 -0700 (PDT)
Received: from opensuse.localnet (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d50cc000000b0020d0c9c95d3sm9972067wrt.77.2022.06.13.16.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 16:42:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     dsterba@suse.cz
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Tue, 14 Jun 2022 01:42:06 +0200
Message-ID: <11997068.O9o76ZdvQC@opensuse>
In-Reply-To: <1936552.usQuhbGJ8B@opensuse>
References: <20220611135203.27992-1-fmdefrancesco@gmail.com> <20220613183913.GD20633@twin.jikos.cz> <1936552.usQuhbGJ8B@opensuse>
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

On marted=C3=AC 14 giugno 2022 01:22:50 CEST Fabio M. De Francesco wrote:
> On luned=C3=AC 13 giugno 2022 20:39:13 CEST David Sterba wrote:
> > On Sat, Jun 11, 2022 at 03:52:03PM +0200, Fabio M. De Francesco wrote:
> > > The use of kmap() is being deprecated in favor of kmap_local_page().=
=20
> With
> > > kmap_local_page(), the mapping is per thread, CPU local and not=20
> globally
> > > visible.
> > >=20
> > > Therefore, use kmap_local_page() / kunmap_local() in zstd.c because=20
in
> > > this file the mappings are per thread and are not visible in other
> > > contexts; meanwhile refactor zstd_compress_pages() to comply with=20
> nested
> > > local mapping / unmapping ordering rules.
> > >=20
> > > Tested with xfstests on a QEMU + KVM 32 bits VM with 4GB of RAM and
> > > HIGHMEM64G enabled.
> > >=20
> > > Cc: Filipe Manana <fdmanana@kernel.org>
> > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >=20
> > > @@ -477,15 +479,16 @@ int zstd_compress_pages(struct list_head *ws,=20
> struct address_space *mapping,
> > >  		/* Check if we need more input */
> > >  		if (workspace->in_buf.pos =3D=3D workspace->in_buf.size) {
> > >  			tot_in +=3D PAGE_SIZE;
> > > -			kunmap(in_page);
> > > +			kunmap_local(workspace->out_buf.dst);
> > > +			kunmap_local((void *)workspace->in_buf.src);
> >=20
> > Why is the cast needed?
>=20
> As I wrote in an email I sent some days ago ("[RFC PATCH] btrfs: Replace=
=20
> kmap() with kmap_local_page() in zstd.c")[1] I get a series of errors=20
like=20
> the following:
>=20
> /usr/src/git/kernels/linux/fs/btrfs/zstd.c:547:33: warning: passing=20
> argument 1 of '__kunmap_local' discards 'const' qualifier from pointer=20
> target type [-Wdiscarded-qualifiers]
>   547 |   kunmap_local(workspace->in_buf.src);
>       |                ~~~~~~~~~~~~~~~~~^~~~
> /usr/src/git/kernels/linux/include/linux/highmem-internal.h:284:17: note:=
=20
> in definition of macro 'kunmap_local'
>   284 |  __kunmap_local(__addr);     \
>       |                 ^~~~~~
> /usr/src/git/kernels/linux/include/linux/highmem-internal.h:92:41: note:=
=20
> expected 'void *' but argument is of type 'const void *'
>    92 | static inline void __kunmap_local(void *vaddr)
>       |                                   ~~~~~~^~~~~
>=20
> Therefore, this is a (bad?) hack to make these changes compile.
> A better solution is changing the prototype of __kunmap_local(); I
> suppose that Andrew won't object, but who knows?
>=20
> (+Cc Andrew Morton).
>=20
> I was waiting for your comments. At now I've done about 15 conversions=20
> across the kernel but it's the first time I had to pass a pointer to=20
const=20
> void to kunmap_local(). Therefore, I was not sure if changing the API=20
were=20
> better suited (however I have already discussed this with Ira).
>=20
> > I see that it leads to a warning but we pass a
> > const buffer and that breaks the API contract as in kunmap it would be
> > accessed as non-const and potentially changed without warning or
> > compiler error. If kunmap_local does not touch the buffer
>=20
> Yes, correct, kunmap_local() does _not_ touch the buffer.
>=20
> > and 'const
> > void*' would work too, then it should be fixed.
>=20
> I'll send an RFC patch for changing __kunmap_local() and the other
> functions of the calls chain down to kunmap_local_indexed().
> Furthermore, changes to kunmap_local_indexed() prototype require also=20
> changes to __kunmap_atomic() (if I recall correctly...).
>=20
> Thanks for your review,
>=20
> Fabio
>=20
Sorry, I forgot to paste a link:
[1] https://lore.kernel.org/lkml/20220611020451.28170-1-fmdefrancesco@gmail=
=2Ecom/

=46abio


