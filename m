Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3267F53BDB1
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiFBSBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 14:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiFBSBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 14:01:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6352516646D;
        Thu,  2 Jun 2022 11:01:08 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id s12so4216639ejx.3;
        Thu, 02 Jun 2022 11:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=p3iuoupi5OIufRvTzvnvj7CU1oGzEzI4mMlu1hqkF0U=;
        b=lrNE3CZMyiAwIx/oP3gMV7VvAJBXsR+CCtn+O9i3H31Pg+49EWexgvMKtbTQx3gbPY
         5cvWS84JoqXXN+8cNvZDybtw7nXBvXY85qKQ5c0vO5ZG8dXpzhQCXp+pluHe8nk9Ruj2
         cd80KLevz+L+urvgs1E7TM8p6yB11LEi3CsxVO3exMclPX92qAj1a7sWOSSufRclKoWf
         2GqBgwmQ0d7kXVA04ySRON8cWIOLPxwE6i2UdfU8PI1ozfuAyJPoC8VtC3EI/iWL+aC0
         bLGpyzb5NYiIZY5Vu8O9o+w98PbOnriNFmQPc9lm/jkZSF2kbIuWuWMwMhpKF4iAHr9f
         qMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3iuoupi5OIufRvTzvnvj7CU1oGzEzI4mMlu1hqkF0U=;
        b=2dd7r8ZH7N5k/D+5X0JMcg/Alwrt+z8D2i5tP7vxy7lE7SWJbNwMOMbcoeIbF6S0rD
         q7FuRV0ArozodTAk6luMx7QRAwmZG6NWSqqIKmyC65HHlt4XjRyjsmTvfPLGcnw3eX7u
         i9UGQfmpivMU1Cbh9HuV8yP2+R0mqAj9n9QeVZ/sEXU49zWKbfkq448aeohiwWd+ZQxp
         Gn2Lrl4oh1dCYm7Dcdz1vsuaRvhqA1vWDkpvm8m6jIyPPR2wOqzfhqOL8UakbKmh0cl7
         9r/SIgoDXiwZ3QGw6HZaEQ0gcKmnQu85ULnl6fcAevYzwpuTWOVs1kkpB4aEU4TxvpFW
         Ad+w==
X-Gm-Message-State: AOAM530EloTTu/BRLSnyhqtJhCgYVxI9Q9ebBcFEN0BMRQYKz0wLtmTR
        UiOFjcGF1nO069pqTJXxvrM=
X-Google-Smtp-Source: ABdhPJzwSHXcTkfoRJoj4vmI8FjXnV0p8zzU55gxF9/t4dKL+W39eCSFWLN2vTtLEbbrVO2By6yh7w==
X-Received: by 2002:a17:906:3c9:b0:6fe:f893:ce1c with SMTP id c9-20020a17090603c900b006fef893ce1cmr5389490eja.137.1654192866863;
        Thu, 02 Jun 2022 11:01:06 -0700 (PDT)
Received: from opensuse.localnet (host-79-44-17-68.retail.telecomitalia.it. [79.44.17.68])
        by smtp.gmail.com with ESMTPSA id kx16-20020a170907775000b00706e8ac43b8sm1972149ejc.199.2022.06.02.11.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 11:01:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     dsterba@suse.cz, "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/3] btrfs: Replace kmap() with kmap_local_page()
Date:   Thu, 02 Jun 2022 20:01:04 +0200
Message-ID: <4713391.F8r316W7xa@opensuse>
In-Reply-To: <20220601132545.GM20633@twin.jikos.cz>
References: <20220531145335.13954-1-fmdefrancesco@gmail.com> <20220601132545.GM20633@twin.jikos.cz>
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

On mercoled=C3=AC 1 giugno 2022 15:25:45 CEST David Sterba wrote:
> On Tue, May 31, 2022 at 04:53:32PM +0200, Fabio M. De Francesco wrote:
> > This is the first series of patches aimed towards the conversion of=20
Btrfs
> > filesystem from the use of kmap() to kmap_local_page().
>=20
> We've already had patches converting kmaps and you're changing the last
> ones, so this is could be the last series, with two exceptions.
>=20
> 1) You've changed lzo.c and zlib.

and inode.c.

> but the same kmap/kunmap pattern is
>    used in zstd.c.

I thought that these mappings I had worked on were safe to convert.

Instead I wasn't sure that the others I left untouched in zstd.c could so=20
easily and mechanically be converted without prior code inspection and=20
proper tests.

I did see those in zstd.c, but I decided to postpone those conversions=20
because I'm not yet sure if and how the virtual addresses we get currently=
=20
from kmap() are re-used.

I saw assignments like "workspace->in_buf.src =3D kmap(in_page);". Is=20
"in_buf" re-used across different contexts? (I see that Btrfs uses a dozen=
=20
workqueues).=20

I also see that kunmap() is called in the same functions that assign=20
virtual addresses to "in_buf" and this makes me think that those addresses=
=20
are not handled across contexts, otherwise you already have bugs. But may=20
very well be that somewhere in the calls chain the code flushes workqueues=
=20
before returning to the callers (it would mean that when kunmap() is called=
=20
we can be sure that those workqueues are done with using those addresses).=
=20

=46urthermore, what can you say about the tens of page_address() spread=20
across the whole fs/btrfs?=20

If those page_address() take pages from HIGHMEM which were mapped using=20
kmap_local_page(), the filesystem will oops the kernel...

About this issue, please see a bug fix ("[PATCH v2] fs/ext2: Avoid=20
page_address on pages returned by ext2_get_page") at=20
https://lore.kernel.org/lkml/
20210714185448.8707ac239e9f12b3a7f5b9f9@urjc.es/#r

Do they only use physical memory from ZONE_NORMAL?

Can you please confirm that it is safe to convert those left kmap() to=20
kmap_local_page() and that those page_address() are safe?

If so, I have no problems to convert what I had left for later. Otherwise=20
I'll need to carefully inspect the code.

> 2) kmap_atomic in inode.c, so that's technically not kmap but it's said
>    to be deprecated and also can be replaced by kmap_local_page. The
>    context in check_compressed_csum is atomic (in end io) so the kmap
>    hasn't been used there.

I was not 100% sure about the preemption requirements for those call sites=
=20
so I had not converted them yet. Are you saying that there is no need for=20
preempt_disable() at the following sites?

# git grep kmap_atomic fs/btrfs
fs/btrfs/compression.c:                 kaddr =3D kmap_atomic(page);
fs/btrfs/inode.c:                       kaddr =3D kmap_atomic(cpage);
fs/btrfs/inode.c:               kaddr =3D kmap_atomic(page);
fs/btrfs/inode.c:       kaddr =3D kmap_atomic(page);

> > tweed32:~ # btrfs check -p ~zoek/dev/btrfs.file
>=20
> That won't verify if the kmap conversion is OK, it's a runtime thing
> while 'check' verifies the data on device. Have you run any kind of
> stress test with enabled compression before running the check?

Ah, thanks. I didn't know this thing.

I installed (x)fstests a couple of days ago. I think it helps to test this=
=20
and other conversions to local mappings, but I haven't yet had time to=20
learn how to use it.

Does (x)fstests cover the compression code? Are there any specific tests I=
=20
should target?

> Please send patches converting zstd.c and the remaining kmap_atomic
> usage in inode.c, otherwise the 3 patches are now in misc-next, thanks.

New version is required in any case because LKP reported four uninitialized=
=20
variables in patch 3/3.=20

I'm just reading the reports that both you and Christoph hit. At first=20
sight they seem to be due to page_address() calls (but I may be wrong, just=
=20
had few minutes to reply so late) :(=20

I was wrong in thinking that these call sites could be converted safely.=20
I'll do the tests before posting v2.

Thanks,

=46abio

P.S.: I've just read a message from Ira Weiny about something he saw in the=
=20
unmapping order in zstd_compress_pages(). We must think how to address=20
mapping /unmapping order properly.




