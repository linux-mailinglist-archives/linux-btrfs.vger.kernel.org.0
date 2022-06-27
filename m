Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5646655CD58
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbiF0SBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 14:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiF0SBg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 14:01:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C8EB7CA;
        Mon, 27 Jun 2022 11:01:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cf14so14178755edb.8;
        Mon, 27 Jun 2022 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwEhp9Xv9rongHC1qnO1cBomEmnStSyCV7TDMuunF9g=;
        b=AWYhjfCLkGMyI1hYkQDJgd32k04jzz+MR9ISAgxv0PNT/uAsrjdHcitLVrQhbZiEzd
         7CCAvXF+ZmEMSd9zU+saUZYCWp4SpHdhX/hziZ2oiENgodFGR84fWJVYeWMQkGh8HAH8
         pG165mH/Vgk2ymRVylbuMs0gRKkvexq53o5e1+mLHWIwT3d5D2bajXVG3/A0wB8nMjV1
         UMFYAhXu5U+3G5zhs/vPthAvvknGrBlsl4hQlcLw0P8wTRbhpNhOwEkuwoRBO/oorVbb
         FnsBtUeZKeOsEXAwvHnv9wBBByYwx9c1NWUU4GDrTUEpwb5c5Y0Rg5yQ2G9lV7uo+6UZ
         A70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwEhp9Xv9rongHC1qnO1cBomEmnStSyCV7TDMuunF9g=;
        b=5Zhek5BPN4LkXZd5qE3JtdpCC6iFTKVmThyAQdwIGbSJ+0Apab6VRiv5UiBq2J0H6l
         0tfghR95P/Yg51GG0SUlzc527+dNoUn5lpVz/zfaEQHI2HvbvzecNAW4dGqJS5VYk7oj
         BEktGdYNaFk9iKtTve7X+Bjc9NCPXHFeRPXzSeVN3WTfJg0ujEDY2QC7KrM3CLjteVgl
         UQz9eUUPKr1N2b1jHWSI0KDgmHs05TB2ECXFCLY4vvnCnVnMqAsrZPs08MIj1XAziT+p
         KyD238Z7NgBN0cDmh4UqinUcbS+DaKEOeAb7f/eXS2sxiqBqdaA7He9okJyEb/uDSpDt
         xNbg==
X-Gm-Message-State: AJIora+wNvQ7NTYRN2R/xaC2Kgag8QPF2k4b8/tM7bY5WAGXYW1+pZ6T
        Wv3rA14ZoNliNv0REvEeXwI=
X-Google-Smtp-Source: AGRyM1tBMYRlO1nnXM5PucZjyvxj1gsIhGMabn0rfkuaG81mTWAtt40Q0ba7BlIeDyDoQblVEDqvsA==
X-Received: by 2002:a05:6402:43c7:b0:435:8a92:e8d0 with SMTP id p7-20020a05640243c700b004358a92e8d0mr18461674edc.174.1656352893923;
        Mon, 27 Jun 2022 11:01:33 -0700 (PDT)
Received: from opensuse.localnet (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id bh25-20020a170906a0d900b00722e1635531sm5309891ejb.193.2022.06.27.11.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:01:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.cz>
Subject: Re: [RFC PATCH] btrfs: Replace kmap_atomic() with kmap_local_page()
Date:   Mon, 27 Jun 2022 20:01:31 +0200
Message-ID: <8960694.CDJkKcVGEf@opensuse>
In-Reply-To: <20220624084215.7287-1-fmdefrancesco@gmail.com>
References: <20220624084215.7287-1-fmdefrancesco@gmail.com>
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

On venerd=C3=AC 24 giugno 2022 10:42:15 CEST Fabio M. De Francesco wrote:
> kmap_atomic() is being deprecated in favor of kmap_local_page() where it
> is feasible. With kmap_local_page() mappings are per thread, CPU local,
> and not globally visible.
>=20
> As far as I can see, the kmap_atomic() calls in compression.c and in
> inode.c can be safely converted.
>=20
> Above all else, David Sterba has confirmed that "The context in
> check_compressed_csum is atomic [...]" and that "kmap_atomic() in inode.c
> [...] also can be replaced by kmap_local_page().".[1]
>=20
> Therefore, convert all kmap_atomic() calls currently still left in fs/
btrfs
> to kmap_local_page().
>=20
> This is an RFC only because, testing with "./check -g quick" (xfstests)=20
on
> a QEMU + KVM 32-bits VM with 4GB RAM and booting a kernel with=20
HIGHMEM64GB
> enabled, outputs several errors. These errors seem to be exactly the same
> which are being output without this patch. It apparently seems that these
> changes don't introduce further errors, however I'd like to ask for
> comments before sending a "real" patch.
>=20
> With this patch, there are no more call sites for kmap() and=20
kmap_atomic()
> in fs/btrfs.
>=20
> [1] https://lore.kernel.org/linux-btrfs/
20220601132545.GM20633@twin.jikos.cz/
>=20
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/btrfs/compression.c |  4 ++--
>  fs/btrfs/inode.c       | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>=20

Please discard this RFC.

I've just submitted a real patch:

https://lore.kernel.org/lkml/20220627174849.29962-1-fmdefrancesco@gmail.com/

Thanks,

=46abio


