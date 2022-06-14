Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7A54B629
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jun 2022 18:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245574AbiFNQ3U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 12:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbiFNQ2x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 12:28:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166BF3B55C;
        Tue, 14 Jun 2022 09:28:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fu3so18211174ejc.7;
        Tue, 14 Jun 2022 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6qfDtSXs9OqxRo/jCj6xMRG73jakKwzYEZi/1ZOdNaM=;
        b=HPTld2LBY55iN7ZFL7mgFi2MYdG2sue6TaTU/2ruqz9ikJLTY4ai/BVufuM2kOgu10
         74la0chLxmh+gtPG9NtBV/EIC6X9vJbDDmon1vsyrsT7pl/3c/BbeWWxD/BxM77Bh9eR
         2HY4elXMNVGfEPr94ovNVfXUxKr+tN1OHabzeZ7SfbpJfs2rybQnGoltoP9o6BREGnfk
         Wk2QmPG0+bSswko1aZGnhGtQ/EkJUDTtRNqbJDL8jcfIqasBDuPC27tyTflMsgTx8hL8
         uim2nK2gCdHdfMc7TnMo7DFtIw9IN0MXqkketeACq7+Y2hhePesNXCGulzqAN+6R/usU
         z1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6qfDtSXs9OqxRo/jCj6xMRG73jakKwzYEZi/1ZOdNaM=;
        b=stdi3IRqMyijrAZ+nAh1Qr/hPsZ0iS4IN2v0gwmQCMkaPmLRWIrMMFYp8R97f5sgMS
         2v9689VJTffQSWMhwGfWdLkKHk2CVoynRa47daIfTGSpmzWttN0IdBS0x7KMzO7JdCj+
         aAr+YpdfKRGw4G0W/lr83vKL0wBHdFf/Pzll/mkWJdlBxNBSwrTqbQHM347nEWM3IBzR
         qQGQDWkCgkIhiXf8ZBEq+rR5Xn/5AkxBboIIHWpuapacVKB0vio7pFUY9kwyaoBkpDRM
         EMP01qotl/uqIg6Iq2PVha+/9J/nWa0TWqyK+TPoBOvdGNOfIpXNso/NpYmZY0KTv8sE
         R5FQ==
X-Gm-Message-State: AOAM533DTnmDU6Eyrrzd3jnfAHLHPa4W77cA8fTZ1VWDVAMI9Wa3zrWs
        IZU7A3tNnkU5iRTJ9/pTj+g=
X-Google-Smtp-Source: ABdhPJwUzFFqBeRn7wsp/CnmC2zU43ZmExw7tMrSdKGZIdD1pdjQK+36NRg0VZQLQkHrNuNVf4o4MA==
X-Received: by 2002:a17:906:99ce:b0:711:c6b6:1d95 with SMTP id s14-20020a17090699ce00b00711c6b61d95mr4890265ejn.339.1655224130517;
        Tue, 14 Jun 2022 09:28:50 -0700 (PDT)
Received: from opensuse.localnet (host-87-16-96-199.retail.telecomitalia.it. [87.16.96.199])
        by smtp.gmail.com with ESMTPSA id fs36-20020a170907602400b00705f6dab05bsm5192721ejc.183.2022.06.14.09.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 09:28:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     dsterba@suse.cz, "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Tue, 14 Jun 2022 18:28:48 +0200
Message-ID: <8952566.CDJkKcVGEf@opensuse>
In-Reply-To: <20220614142521.GN20633@twin.jikos.cz>
References: <20220611135203.27992-1-fmdefrancesco@gmail.com> <1936552.usQuhbGJ8B@opensuse> <20220614142521.GN20633@twin.jikos.cz>
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

On marted=C3=AC 14 giugno 2022 16:25:21 CEST David Sterba wrote:
> On Tue, Jun 14, 2022 at 01:22:50AM +0200, Fabio M. De Francesco wrote:
> > On luned=C3=AC 13 giugno 2022 20:39:13 CEST David Sterba wrote:
> > > On Sat, Jun 11, 2022 at 03:52:03PM +0200, Fabio M. De Francesco=20
wrote:
> > > > The use of kmap() is being deprecated in favor of=20
kmap_local_page().=20
> > With
> > > > kmap_local_page(), the mapping is per thread, CPU local and not=20
> > globally
> > > > visible.
> > > >=20
> > > > Therefore, use kmap_local_page() / kunmap_local() in zstd.c because=
=20
in
> > > > this file the mappings are per thread and are not visible in other
> > > > contexts; meanwhile refactor zstd_compress_pages() to comply with=20
> > nested
> > > > local mapping / unmapping ordering rules.
> > > >=20
> > > > Tested with xfstests on a QEMU + KVM 32 bits VM with 4GB of RAM and
> > > > HIGHMEM64G enabled.
> > > >=20
> > > > Cc: Filipe Manana <fdmanana@kernel.org>
> > > > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > >=20
> > > > @@ -477,15 +479,16 @@ int zstd_compress_pages(struct list_head *ws,=
=20
> > struct address_space *mapping,
> > > >  		/* Check if we need more input */
> > > >  		if (workspace->in_buf.pos =3D=3D workspace->in_buf.size) {
> > > >  			tot_in +=3D PAGE_SIZE;
> > > > -			kunmap(in_page);
> > > > +			kunmap_local(workspace->out_buf.dst);
> > > > +			kunmap_local((void *)workspace->in_buf.src);
> > >=20
> > > Why is the cast needed?
> >=20
> > As I wrote in an email I sent some days ago ("[RFC PATCH] btrfs:=20
Replace=20
> > kmap() with kmap_local_page() in zstd.c")[1] I get a series of errors=20
like=20
> > the following:
> >=20
> > /usr/src/git/kernels/linux/fs/btrfs/zstd.c:547:33: warning: passing=20
> > argument 1 of '__kunmap_local' discards 'const' qualifier from pointer=
=20
> > target type [-Wdiscarded-qualifiers]
> >   547 |   kunmap_local(workspace->in_buf.src);
> >       |                ~~~~~~~~~~~~~~~~~^~~~
> > /usr/src/git/kernels/linux/include/linux/highmem-internal.h:284:17:=20
note:=20
> > in definition of macro 'kunmap_local'
> >   284 |  __kunmap_local(__addr);     \
> >       |                 ^~~~~~
> > /usr/src/git/kernels/linux/include/linux/highmem-internal.h:92:41:=20
note:=20
> > expected 'void *' but argument is of type 'const void *'
> >    92 | static inline void __kunmap_local(void *vaddr)
> >       |                                   ~~~~~~^~~~~
> >=20
> > Therefore, this is a (bad?) hack to make these changes compile.
>=20
> I think it's a bad practice and that API that does not modify parameters
> should declare the pointers const. Type casts should be used in
> justified cases and not to paper over fixable issues.
>=20
> > A better solution is changing the prototype of __kunmap_local(); I
> > suppose that Andrew won't object, but who knows?
> >=20
> > (+Cc Andrew Morton).
> >=20
> > I was waiting for your comments. At now I've done about 15 conversions=
=20
> > across the kernel but it's the first time I had to pass a pointer to=20
const=20
> > void to kunmap_local(). Therefore, I was not sure if changing the API=20
were=20
> > better suited (however I have already discussed this with Ira).
>=20
> IMHO it should be fixed in the API.
>=20
I agree with you in full.

At the same time when you sent this email I submitted a patch to change=20
kunmap_local() and kunmap_atomic().

After Andrew takes them I'll send v2 of this patch to zstd.c without those=
=20
unnecessary casts.

Thanks for your review,

=46abio



