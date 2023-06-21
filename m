Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AED7380F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 13:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjFUJUe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 05:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjFUJUb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 05:20:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3261706
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 02:20:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AE7C614B2
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 09:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED00AC433C0
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687339229;
        bh=7aZDnwgX0YLBfnmN4jXp8H8vvlyk67huT9YugqNi7JY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RoJEnEsiiX6m1Yd/Ybe+9vYBMsTekTcy/YtzgZIIi6SCI0DH9Z6qo1Ywv1AUOOurE
         xSQ43F5tst2+GkeU3FTmqrNjOCSsCQxfJYGvFvbvk1okiQPl1wyx6Zl+v1lw/3VR6Y
         ZqcKCyyRdxVqFKZlfoMOY/xBsUkBU7o3BSP6GWgVupSqZ3dCq9Xhv+T8vj9BRHl2BS
         WVECrzbuIfxwOBRZFrC8fbHcft5opmMbTJ1sYlc3yuOjPpNTybRGhZ3B67VEp9TTDT
         4kxVFuO0h3PFIuQgld1kAZv2mgSuHN23qwfiSzFXAFP8U9X4vM2sEH1pGdzIdSkBFK
         qaBivGSjoqRhQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-55e11f94817so3389086eaf.2
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jun 2023 02:20:28 -0700 (PDT)
X-Gm-Message-State: AC+VfDw55M5anRvwfnc52Sa8oJgA8NGHH+fL7pbPbvCoOQSoe9ZEk5a3
        pJYd7SvBkPAgtHPlkwx/AkEGJy2/k4tiv1ABRFs=
X-Google-Smtp-Source: ACHHUZ7yVNS6K5Ts/eZvmc899lvG9VfcTmSWoLCITg7jkbgxHtAsE0DyF2GKPmoJAtm6T9ng9hztOEQzKs/CXQgRM84=
X-Received: by 2002:a4a:e6cd:0:b0:55d:beb5:c789 with SMTP id
 v13-20020a4ae6cd000000b0055dbeb5c789mr7730194oot.0.1687339228134; Wed, 21 Jun
 2023 02:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <SYCPR01MB4685ABD2A45F14C694BC68DA9E5DA@SYCPR01MB4685.ausprd01.prod.outlook.com>
In-Reply-To: <SYCPR01MB4685ABD2A45F14C694BC68DA9E5DA@SYCPR01MB4685.ausprd01.prod.outlook.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 21 Jun 2023 10:19:51 +0100
X-Gmail-Original-Message-ID: <CAL3q7H65vzvsATJSeS5YeX-ADEdJ6JDXY8H1XfiCQgDhPAhkmA@mail.gmail.com>
Message-ID: <CAL3q7H65vzvsATJSeS5YeX-ADEdJ6JDXY8H1XfiCQgDhPAhkmA@mail.gmail.com>
Subject: Re: btrfs replace without size restriction?
To:     Paul Jones <paul@pauljones.id.au>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 21, 2023 at 8:33=E2=80=AFAM Paul Jones <paul@pauljones.id.au> w=
rote:
>
> Hi all,
>
> Would it be possible to modify btrfs replace to have the ability to force=
 replace with a smaller disk than the original? One of my disks just failed=
 in a raid1 setup so I tried to replace it with a disk of a different brand=
, but it was rejected as the new disk is a few sectors smaller than the old=
 one! I have 20% free space so no issue there.
> Adding a new disk and deleting the old one seems significantly slower tha=
n replace.

It may sound simple but it's not.
The only way to do it would require doing a lot of extra IO, and in
case the device that needs to be replaced is not healthy anymore, it
may lead to a roadblock.

See the discussion about this at:

https://lore.kernel.org/linux-btrfs/CAL3q7H60gNBC_zzU8gjZ_s=3D7MnN23yFzQqYx=
anhvzMO50qtXJg@mail.gmail.com/

>
> Thanks,
> Paul.
