Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3127962739C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 00:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiKMXwc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Nov 2022 18:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKMXwb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Nov 2022 18:52:31 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1945B1E2
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 15:52:29 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f27so24655366eje.1
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Nov 2022 15:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NAzZT3La/4um2A9mq1qkmpc1VAed/+adyd3P61nvrQI=;
        b=D0V6VATbyuCwCfDHDMs/j4NwjprBISheaSNa0F8DqBFf1GqcKn3H+H9Fnj0D6irVlk
         98cz/oDxY6J1WBdI/XIQifHV9p0uDE9AMYjr1kHrpA8Rs1GQz5z4xlJh2RbSSiFpFwnc
         c/NWHqNlt5bo6rTjBTptR76kmZ3gWvD+F32XTU2hACy8EZ/Mk2TyN4bmmWqQUxqqFFSy
         nThHBMwUAdXuUd+RVmDh2qxiGwKAI+sl9iPO3T/D84IQweupquZVb7xPC6zulswugZsp
         kXM30UHDazeZZ4g1UyEqxCehRvKxeUUSVZ3TPV9TqH8NvXedbl58v2YD8nxi5tEhbfLa
         oS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAzZT3La/4um2A9mq1qkmpc1VAed/+adyd3P61nvrQI=;
        b=RMqMrlaJ5efevnMUf28qCfX9bE0TbM1G7NN+TiFZF/MEPz76hedx0qzzNealB6S/Nt
         iQAxWCWIZa0rBPZHoMda+1hgr2S3OtDCwpNFOfEuw+aboFEjCT+nKfFABHssuxHVPY/H
         VFPEo9jegX+qlVrVyyZ4o2ZZTVxGaCQWpPFdkUIGyVIFskvnfR5WqNTrKSVp77mg28DD
         dtoorf3+GvsiYY77tPMLkf9lhwR3yMYAOlJkgL7kXs4EGoeEhMC1mj1dXZOl0aAcNvIL
         OxhW8k0Q/2koy17oMKqGybt6CBpMUlj66BhKYHUChfDU7zlPIZohM/eEj/5PUzsQyEBL
         lVcQ==
X-Gm-Message-State: ANoB5pl2NWMN1GFlVjK6J1Ip7/Ve8bWnukbm0E5tEwKkVFk7uY/PlMCA
        bGg3Gslhj1lMP9DLk0VxFVTt0ihL75PMqfbWdvcokxxYRQRKcA==
X-Google-Smtp-Source: AA0mqf7CUUP0RBMG+PsiXMqRJcQrAAMnkGZNkB3nSV9+msigPSeBOr7At065wRn1gjO0PaixZ4+0zQeTfUdSJAe0iuQ=
X-Received: by 2002:a17:906:4d95:b0:783:7020:53a7 with SMTP id
 s21-20020a1709064d9500b00783702053a7mr8332542eju.736.1668383547563; Sun, 13
 Nov 2022 15:52:27 -0800 (PST)
MIME-Version: 1.0
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Sun, 13 Nov 2022 18:51:51 -0500
Message-ID: <CAEg-Je87KMSRWREjRYin_ZUbp0W7vk0OnATxZbLYckoVrPZP_g@mail.gmail.com>
Subject: Buttery Shufflecake (or is a Btrfs-style Shufflecake possible?)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Chris Mason <clm@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey all,

Today, I read about this interesting project from Kudelski Security
called Shufflecake[1].

The interesting thing about it is that it enables plausibly invisible
encrypted volumes, which can be very useful in specific circumstances.
The implementation that Kudelski Security created works by creating a
new device-mapper module (which is unfortunately GPLv3+[2]) and
pairing it with user space software to manage the DM targets.

While of course we can just live on top of DM for this, I was
wondering how difficult it would be to incorporate something similar
directly into Btrfs' subvolume management capability, especially once
we get native encryption[3].

Thanks in advance and best regards,
Neal

[1]: https://research.kudelskisecurity.com/2022/11/10/introducing-shuffleca=
ke-plausible-deniability-for-multiple-hidden-filesystems-on-linux/
[2]: https://codeberg.org/shufflecake/dm-sflc/issues/12
[3]: https://lore.kernel.org/linux-btrfs/cover.1667389115.git.sweettea-kern=
el@dorminy.me/

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
