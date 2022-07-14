Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103DA5745F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 09:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbiGNHqp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 03:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbiGNHqd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 03:46:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D661633E29;
        Thu, 14 Jul 2022 00:46:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r10so1417210wrv.4;
        Thu, 14 Jul 2022 00:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WP8vsC0djH13BuLUfO8CNF1zHIKJgVkdP/OdU4QSZmk=;
        b=cnMAEq16PoJAGsLjSM2uZ43do/usUveKIyn90xkkVwsKe8x/yJzW1zkXMwKwMLsj6Y
         UAM6Yp1FXBLtKcXFO2avGAv1eNGSA84TOIQJJ1n83S9O4t9dQQYdCE3Tfd3G4c9G4Plp
         jC6PG0FwAju4QrKEoRBXjlMKh+ZUKN4G0w9mxmrnr7ku8gtpLbgbKGEpd64SpDlSwjUK
         BP3WQ4aplDKAcoqFRtd/82bCYMo6gRw3dSWwAtmoHlXSgj42jGikGz+LRYIJfjZuzFUd
         +Cdzx5af+0e0XATXF/cch6ODuEEtzlhRUfb8ZkCmWMoR9RCmsivuBFpqzsfVUElEKyJS
         45+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WP8vsC0djH13BuLUfO8CNF1zHIKJgVkdP/OdU4QSZmk=;
        b=X2DTmJrqQJajhrEIQAtmw3e64pd7mx4MvatFNjzX+DFjcsSz3CVugoAJXHvBNZRHIV
         vBdbatNtVovX1Dzmerx3ojTZANIx/0q97g4A3EgGiDyTnI7I/OYcZa1jQOW/4GA9VzDH
         eEttli65QIzT/4DF+XQTRUDbh7s1/8DIHvgrkTBDBWv9KOrWTt9JyPboTBuJWF5jvzzX
         Lb7Morrf3TTdkyXxfabeksGMM0pEQ6YdIfvvQBruy10isW5L2Yyxn1phpbAnsMfWeh70
         pQq60L8/2w1rhZ8x9RVrCH74Q9Jc+yGlw17rcktRRXEfeMm9m9IreavpoGd3ueJmD4Gq
         rP1w==
X-Gm-Message-State: AJIora+rlzuvEBv0zwuaQhCuxK246t9UNv47x+rOk+99U6ti1VpnSjES
        hmiBfWxUd8Q+B3MyUxH4Svk=
X-Google-Smtp-Source: AGRyM1uVaSY/5zS4RYSxzuJVo59yqfkIv03Rr7wEpYc1QZy4fpXJTnL9Md9QIGLkk/Y+PHgXez4wFg==
X-Received: by 2002:adf:e503:0:b0:21d:6d98:a92a with SMTP id j3-20020adfe503000000b0021d6d98a92amr6977853wrm.62.1657784791285;
        Thu, 14 Jul 2022 00:46:31 -0700 (PDT)
Received: from opensuse.localnet (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id h8-20020adff4c8000000b0021d887f9468sm765579wrp.25.2022.07.14.00.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 00:46:29 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] btrfs: Replace kmap() with kmap_local_page() in zstd.c
Date:   Thu, 14 Jul 2022 09:46:00 +0200
Message-ID: <8091114.T7Z3S40VBb@opensuse>
In-Reply-To: <20220714082519.A7C9.409509F4@e16-tech.com>
References: <20220611135203.27992-1-fmdefrancesco@gmail.com> <20220714082519.A7C9.409509F4@e16-tech.com>
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

On gioved=C3=AC 14 luglio 2022 02:25:20 CEST Wang Yugui wrote:
> Hi,
>=20
> Compiler warning:
>=20
> fs/btrfs/zstd.c:478:55: warning: passing argument 1 of =E2=80=98__kunmap_=
local=E2=80=99=20
discards =E2=80=98const=E2=80=99 qualifier from pointer target type [-Wdisc=
arded-
qualifiers]
>   478 |                         kunmap_local(workspace->in_buf.src);
> ./include/linux/highmem-internal.h:284:24: note: in definition of macro=20
=E2=80=98kunmap_local=E2=80=99
>   284 |         __kunmap_local(__addr);                                 \
>       |                        ^~~~~~
> ./include/linux/highmem-internal.h:200:41: note: expected =E2=80=98void *=
=E2=80=99 but=20
argument is of type =E2=80=98const void *=E2=80=99
>   200 | static inline void __kunmap_local(void *addr)
>       |                                   ~~~~~~^~~~
>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/07/14

Thanks for the build test, but you're a little late :)

This patch is superseded by a series of two: please see
[PATCH v6 0/2] btrfs: Replace kmap() with kmap_local_page() in zstd.c
at https://lore.kernel.org/lkml/20220706111520.12858-1-fmdefrancesco@gmail.=
com/

In that series, patch 1/2 changes __kunmap_{local,atomic}() prototypes to=20
take pointers to const void.

Regards,

=46abio

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


