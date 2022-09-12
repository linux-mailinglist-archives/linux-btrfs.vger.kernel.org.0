Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FB05B588F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 12:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiILKkl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 06:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiILKkk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 06:40:40 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398022495D
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 03:40:38 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3378303138bso94887517b3.9
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 03:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=mPPVJWjfkik1hdH0HVBiaM0wn6a8AR4xJuu2VFZhBc8=;
        b=V8yQgB5jaiClcWlw/fFT0BMXcBOZ3ZRkzHo6Kghm+ClP0r3pmH7DewEcaFF8sDvEgy
         olTA0fmJg2ttGdeh0IRK7IvFINxMdRgUABoALF1f5202FYMWQOe7dX1leTZViQqDOp6Q
         YSbnDjCd7Enhhrh1edOv1uNMuW7J1KFxhm4r8+kHZFt1sGDcJVzYA3nUWceE4Rys3H3k
         tDIWquwFD34qDcnrL6K6sVWNCje6Em0sayk+rWOUD7QJZ7Tk2YpFqCbhsvgBlH8hdsnS
         frvIoyg5VNOuSI4o36oLTezc8lefq9NchcOubdHFHEOfAyHbk29cS8MIFr6eUFlVTlQJ
         9hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mPPVJWjfkik1hdH0HVBiaM0wn6a8AR4xJuu2VFZhBc8=;
        b=rnB51TFihAhi+FKlrLDB6WZblS64SPZLWj15JI+b9c4tOAjRZkSeyGcuz7BNKvuppR
         ThP11ngL0qmYC30oq6C9GMBB4BanroOEBUE+dLKwkQQHpI+1n0dH2jXKICBkGdVVDeYO
         AybgSrVSx6oKBBGaca/93lgpmEyAwv/5Uo7rVlpGWSTjAx61NBFZMjn7ks3CPAXOrgRO
         /OYg9aq1ur2HqwniAiFUWkDf9ByyxZ9g/X5dQQGtnDaWO3gr7WdfGSBLLy7Es6zp0h32
         0r2NFk4nYb42+9fBlQ3pTJkzjp2I/UGapoM68bw4thOT3CI1Z+h7gBNtc4Y5HnnsSdzu
         RZ4w==
X-Gm-Message-State: ACgBeo3Z1PVe1UBaa89xJ2O1s5cn+iw0tuCyZlfd66SEJI2OzPhhUnqz
        ReyO5UB00A/G8iZoGjQ+VyGqCA1xyOEuhyxkgxpljvMZ
X-Google-Smtp-Source: AA6agR7gKg14GyTR5kG+FmwpC8hkBZJ9vsngIgUWgBX+OPSHElSNF199RKTZH7zTV59CkUWU579tm0zn8WxG8T8qxLU=
X-Received: by 2002:a81:6756:0:b0:345:525e:38 with SMTP id b83-20020a816756000000b00345525e0038mr21667328ywc.47.1662979237352;
 Mon, 12 Sep 2022 03:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <d1da73f6ed291d53d4cc7dcab142ebfb0541f06e.1662730491.git.josef@toxicpanda.com>
In-Reply-To: <d1da73f6ed291d53d4cc7dcab142ebfb0541f06e.1662730491.git.josef@toxicpanda.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 12 Sep 2022 06:40:01 -0400
Message-ID: <CAEg-Je9gb-aj-e=48z__jnw1+7z1qT18mUZWk_f51hnJTvs+7g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: introduce BTRFS_RESERVE_FLUSH_EMERGENCY
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 9, 2022 at 9:52 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> This is a decent stop gap until we can work out a more wholistic
> solution to these two corner cases.

You mean "holistic" here. :)

Otherwise, wow.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
