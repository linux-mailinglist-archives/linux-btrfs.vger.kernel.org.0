Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547AC54F75C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 14:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381241AbiFQMSf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 08:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380246AbiFQMSd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 08:18:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9154B4579A;
        Fri, 17 Jun 2022 05:18:32 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w17so5531556wrg.7;
        Fri, 17 Jun 2022 05:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+G31uT06WoW4tlb6zba61kwJ7xhmKBjRgwtOizzQjP0=;
        b=ciSp+1o/FIEJmCZB6+KEx8Pz6OUJ46FuPUc0mMlTeYRWLaDHUnvXB7EdUDrHWHPulo
         MyUebrRymzqP+nSLU8BQ8X1qKTyxhOh4xKmk5KawagpLKYPx46XKreRbT6nTV7FNCj5r
         Qm0mupGQG5xccYtGMXBdoa4WEfPlGNViYfsQqIthPksRyR1HRisMGItWrequmj4N2aeg
         A+WzrRhvnIyBGxP/uH2+j0eErs4fjZLTQqMNQWLA/jnkhAhIwwHhqDjKfTQV1x1FoqVE
         uEAaU/6VBGkOHJ12LTEr0PaJQHwn09oYdhnjIRkvdufY8F8K5ZVMELso9WMwG78HWs0C
         qnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+G31uT06WoW4tlb6zba61kwJ7xhmKBjRgwtOizzQjP0=;
        b=jXc3Tc8kFrksNxYIjFua3UqpzSKwK0j3sceb4afENkzZ8FFKyU3G8HWm7PgWlNVLNs
         YLy5qXMAZwVR28lK+vmQ9fYEpcVOEJwpkcvt6MCTLJbLd81v0zU0yhD+OuOO5CIMExsq
         Icr/inSob1DVTzhYNVL08HlEh6533RlTBBoTBWYS9xwo0IjiXYwiOSjrzMroW3W26rcp
         +SqBXuWtWZZ7oxJe3WMuNp2xEM6ZHHSLRK2TrygXKlPu8g9PGXKpbctGFAH3V6jOs65Y
         A0de4Eb4iVWEeoXrP/oSGM0eBAgsvmt8JPlNWypOP5b6C3ueq2fcqC+qY/Snc+5SNyfF
         oUFg==
X-Gm-Message-State: AJIora99ge6kS9cTTV4LiEUeFvlXUMWQxRQJg3SnJH+Eyc0egPjxbNXn
        tNCu5Y7G2AJiNCdRAY1hl0Q=
X-Google-Smtp-Source: AGRyM1vVLih+aaVvtNT7+YXGP0SWhuOOxhe5g5L9OJv3uEORBxHf5qEKqRor4gqVlIoCJxKlJ1LswA==
X-Received: by 2002:a05:6000:381:b0:219:b9dd:af2b with SMTP id u1-20020a056000038100b00219b9ddaf2bmr9414110wrf.75.1655468311047;
        Fri, 17 Jun 2022 05:18:31 -0700 (PDT)
Received: from opensuse.localnet (host-87-6-98-182.retail.telecomitalia.it. [87.6.98.182])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b0039c50d2d28csm9250704wmq.44.2022.06.17.05.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:18:29 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH] btrfs: Replace kmap() with kmap_local_page() in zlib.c
Date:   Fri, 17 Jun 2022 14:18:23 +0200
Message-ID: <2243807.ElGaqSPkdT@opensuse>
In-Reply-To: <20220614104718.9193-1-fmdefrancesco@gmail.com>
References: <20220614104718.9193-1-fmdefrancesco@gmail.com>
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

On marted=C3=AC 14 giugno 2022 12:47:18 CEST Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page(). With
> kmap_local_page(), the mapping is per thread, CPU local and not globally
> visible.
>=20
> Therefore, use kmap_local_page() / kunmap_local() in zlib.c because in
> this file the mappings are per thread and are not visible in other
> contexts; meanwhile refactor zlib_compress_pages() to comply with nested
> local mapping / unmapping ordering rules.
>=20
> Tested with xfstests on QEMU + KVM 32 bits VM with 4GB of RAM and
> HIGHMEM64G enabled.
>=20
> This is an RFC PATCH because it passes all tests of the "compress"
> group, with the only two exceptions of tests/btrfs/138 (it freezes the
> VM) and tests/btrfs/251 (it runs forever but doesn't freeze the VM).
>=20
> Can anyone please take a look and tell me what I'm still overlooking
> after days of code inspections?
>=20
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  fs/btrfs/zlib.c | 75 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 50 insertions(+), 25 deletions(-)
>=20
Please don't respond to this RFC and drop it. I've just split it into three=
=20
new versions and send a series of RFC PATCH(es) which seems to work=20
properly.=20

They can pass all tests of the group "compress", but I decided to implement=
=20
some questionable solutions. Therefore, I'd like to hear about them:

https://lore.kernel.org/lkml/20220617120538.18091-1-fmdefrancesco@gmail.com=
/T/#t

Thanks,

=46abio


