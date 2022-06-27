Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDAA55D5E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbiF0SMV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 14:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbiF0SMU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 14:12:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55832B7C1
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 11:12:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i18so18007282lfu.8
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 11:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FEWhdgO9U2fAfNcwa/xWIgpBfcyCApf94d4QkJD9l5w=;
        b=BsAI0XRsyaRzPprCjOehTPdVAPCQdg2AiyMJoe21aQl1hLX2p/AJkhO3zKYDe7UurI
         vPoKhKuouEHkc4ciHJmlU9YGIciHPn5oyBmkwNAwZBG9Kq4Tmt2TTtBs55oDoEPrhas0
         xpuFEtD+fO3U1IatdHqY7U7Q+xvszohTialzKKG5MuloiAJCGatEESaBdadJIOmEloU/
         HHhnX3BYTFV2NYDhRQQqaK4z1DEmRQ7h2EqChdoK1fm6RtSgm38/KQXXu9zgxqRvUiKO
         Z3qI6QB3E26nvBO22vXvW0z9nniYrdF6WteGFc/Y8iZYgJlViNt4Zs6vllUNhXwDACLY
         NlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FEWhdgO9U2fAfNcwa/xWIgpBfcyCApf94d4QkJD9l5w=;
        b=0FkS6ebzax9JWhnErZbzwGR7LGXuTYH577IPn9AVUGPkQ6D1J/CTrSjzz5mrbFKmSX
         Yx7B5QKkzaKDy64mYEg0hRNjxV6+TVJhX/Jm8z1cOZ+/zlntiYkX+bLIJL5+1qOYvChi
         15CTi9c4Z7HBhb1IizPZ0s65nJLE1hDBRMXHlN66biBK3wtezmYSHBSAXZwi8DVgdg0W
         bo0lknegLVLRv5ws/Knth8V+24yYPmqjxp3Onxmc6s6j9He/pCmsbGPgBsDJoAyNjLsY
         h812FyihlUvBdaTGQgyl7Zi/9Z669z5GPSf5xwgBP2uEoIOdr56xvx2BGJ5sU4U42Klb
         z6Vw==
X-Gm-Message-State: AJIora+1XY/aRZEh/Ypxc0HG5l5X7S1ILA2N6hv2AIWMcKZNEo269D7Q
        5ob+CFisBJ1l2Lm+7GXo4T1Ob/AJBpLFWDLDuvIMXQ==
X-Google-Smtp-Source: AGRyM1tS0MdpYBjgyJA3/fY21CAbJQYzSVy5Kc597vh73NUsrqrriUMF5fSMFpLZbiBGflVDEPQK++CPAfNMog4SVCA=
X-Received: by 2002:a05:6512:3f84:b0:47f:673c:31b7 with SMTP id
 x4-20020a0565123f8400b0047f673c31b7mr9847905lfa.473.1656353537496; Mon, 27
 Jun 2022 11:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <8415b7126cba5045d4b9d6510da302241fcfaaf0.camel@bcom.cz>
 <42e942e3-a6d9-1fcd-cd9b-5c22ee3f2e1f@gmx.com> <f9b7e2fea36afefaec844c385d34b280f766b10b.camel@bcom.cz>
In-Reply-To: <f9b7e2fea36afefaec844c385d34b280f766b10b.camel@bcom.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 27 Jun 2022 12:12:01 -0600
Message-ID: <CAJCQCtQ3qrLTbbXx7KiiU=ZH7NFTFsJVZA0fbKf+EHyCDkJ3Tg@mail.gmail.com>
Subject: Re: Question about metadata size
To:     =?UTF-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "quwenruo.btrfs@gmx.com" <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 27, 2022 at 4:23 AM Libor Klep=C3=A1=C4=8D <libor.klepac@bcom.c=
z> wrote:

> Yes, we use zstd compression - filesystem is mounted with compress-
> force=3Dzstd:9

compress-force means even uncompressed extents are 512KiB max, so this
could be the source of the problem

If you use just compress, then uncompressed extents can be 128MiB max.

So it's a set of tradeoffs depending on how compressible the files are.



--=20
Chris Murphy
