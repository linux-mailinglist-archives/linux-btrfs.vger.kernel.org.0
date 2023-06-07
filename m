Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860197257D8
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 10:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbjFGIel (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 04:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbjFGIeh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 04:34:37 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73894170E
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 01:34:27 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso6415102a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 01:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686126866; x=1688718866;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FaCBDDPNKFb+ty6ZuTuULQ3gufLeR9Ns0/duLSCNXoA=;
        b=cdEllhBhCA0AcdopnCrk2hTttjJnaNbS2N8w3AD6FSKokydaksou9N2Hry5rB64p8w
         To3DUSFxqIPmx09gt+CfN6Pf5DMUG3vV4JvVpV6rUhavN1QwzlXsw9tuFylA0cHot+Nx
         bwmJprTouAkaJc4K6h4FRVrrIyLzmwtbbonfsdH30AIqcE4E7DkDeF529K1/KSMiX47K
         7kZ06qV+YblI0E0ChKj64to5+lt5c1K9RpQBEndyCUjCCnamQAZekUhbosHW/rfaQJNq
         sSVzB9F/eEn5+rZrevbPjVxDoHqbVQpRhAwtqUzQeNcisGKcqvQtORl15XdawwGWaR9u
         f3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686126866; x=1688718866;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FaCBDDPNKFb+ty6ZuTuULQ3gufLeR9Ns0/duLSCNXoA=;
        b=EBkAzKbigPEi8xX7m0hzkRPJByPKr/KhV4kxHzoOfAiMp0IgqetvcbGzQEj9fJ3yPf
         M6OAlVd4q/pMrA9pNTih0oAv1AWktiNb9uv+dzjPNYA7hXpVywtKzeDmplJUoWGXCJmf
         BAtTYsjxf4VzEZkz2Gd0kC0WsRM2c8cx3jSxvuEc76mqf+iq3QtcoUaf/ehhUyDzmeZq
         RjaznsXxyqLxtRmye0VorTsGMNZbtUkdM06IYg9oxpDWe+fVhgFiV5m/YQRkf64Q+cLp
         n4tGsqFAY4YVmqBYU4ZW3+TaD3yoaUOxVZPwDueHwBAbqowdFfBxDIf1R1vkZxvJcoGO
         6XNw==
X-Gm-Message-State: AC+VfDykSU//rvgO6Yz07703Vud1KLF+c00iYFt70etabLxLHZYQMpGm
        Q1Yu7/pkkxPBfNXW/ouMz3acOW1ScnKxHc2NXoiqKJ5r
X-Google-Smtp-Source: ACHHUZ41FMoyzyJ4aVUIHa+viG/vtNEXVzlzDyFMs6M4uWE9McfFdm6KZx8E+fCGyEdCqalGC8xU3ZQ3FOz9AiU3wyQ=
X-Received: by 2002:a17:90a:598b:b0:253:26e5:765a with SMTP id
 l11-20020a17090a598b00b0025326e5765amr3640467pji.48.1686126866582; Wed, 07
 Jun 2023 01:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <CALgeF5=8Www=aG8=6XXTYsiD-A=dBdGUN8Drj=h4d92yoZNXHw@mail.gmail.com>
 <cf225ad6-69f4-a339-2e7b-42f094a7b5fb@gmx.com> <CALgeF5ksBx0+0v8yGu3XECPkDZJZB0tBAeHt+1MUAXLEa67QPw@mail.gmail.com>
In-Reply-To: <CALgeF5ksBx0+0v8yGu3XECPkDZJZB0tBAeHt+1MUAXLEa67QPw@mail.gmail.com>
From:   Massimiliano Alberti <xanatos78@gmail.com>
Date:   Wed, 7 Jun 2023 10:34:13 +0200
Message-ID: <CALgeF5k_HjZnt4+YkqzCs9ggq9_HnF1jnn57Vxvp8oyeD_dJrw@mail.gmail.com>
Subject: Fwd: parent transid verify failed + Couldn't setup device tree
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Kernel 6.3.6 (just upgraded)

root@ebuntu:~# mount -t btrfs -o rescue=all /dev/sdb1 /mnt/sdb1
mount: /mnt/sdb1: wrong fs type, bad option, bad superblock on
/dev/sdb1, missing codepage or helper program, or other error.

I can use the btrfs rescue (no hypen), but how? The superblock is ok,
so the options that seems promising are the chunk-recover and the
zero-log
