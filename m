Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CBC6012E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 17:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJQPry (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 11:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJQPrx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 11:47:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C02C5B062
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 08:47:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e18so16660848edj.3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 08:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N2LXM6bVG5cmmOOXtD0LEdNWnibuhLi5ao+pKFX39Ss=;
        b=ErPr9nLi4IgseCX8/2GrkhbQEgdeBkuFOsnydsLK+Ff0IdaO2Z1BB3ZTGr89fkZ0e6
         wrcqmg6VICBTW02XstWjDFEBHb7RSDQqvBm+WAiielykyZTAgul180S5t1a21bFHQvP5
         O3IrZHE91M0gDpzsOTQ6enjUSnlQZQ7z9YVLyHyLOjoR1YWLi5fzWhxeCNlax0/OsFEn
         L2YbVxZojeovIL+z8aII3tWXwZp3GzVqf0dAwp9i5m/0+ASEdV8Nv0809azyiMBbSpTZ
         fJzOSHirfcK0UPD7Ji69o0kH57iWp/dgBvZ1AUgsmyzoIZKcbQWrzxP8qQN38pBO3/ja
         d5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2LXM6bVG5cmmOOXtD0LEdNWnibuhLi5ao+pKFX39Ss=;
        b=ugIvYwVWY8xKCWVIvX85ZfgbCFxULBNJ+oOT1erHtxZHJtQmVniZfhv25fAgGN+ZUX
         tpzW+TmtY/l5sZapW6bBsxn17klgD4LAD7monIqA3RdzZZidoPgPzWhnRTBVV/dsQy9k
         770FfO01dSd9d+QNSOxcAlvvuD/yNTIfmok6nfoGjgjOobY85AQle2l5Yg4MMlvJfX70
         lBDmKFz5K7GZSiECuEDiVeSWvXofncQRZ/PSZOJkokuzTNl8YjH3BZ0S2BQkAoFvLr+7
         fVyzqNXSs53pfmiAa27sgWXRVofo+r1vLNIDT/C6N4s/XftlExIuSBsur9rX25180elr
         QgeQ==
X-Gm-Message-State: ACrzQf0SwU9EJzcGXGutVVPVWr1uubLi4UoI/bPbdtfDzLXAOFtqC+WJ
        TFESmUQgXAUxp/imX9+VD+5oO6bz6+eizBV/LSk1r8QaEf4=
X-Google-Smtp-Source: AMsMyM4X+Xrqmi6+Qdb5jVc7mOpdmvH2D+T/d1LIflLm5fXNpFKarXbKYdvYH5lAAmkeL0SPP3IeKAmXqzNoeX6wVNs=
X-Received: by 2002:a05:6402:ea8:b0:456:d188:b347 with SMTP id
 h40-20020a0564020ea800b00456d188b347mr10865103eda.15.1666021671529; Mon, 17
 Oct 2022 08:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <e1cf9a2c-71e7-0bb6-7926-1c5952de02f7@bouton.name>
In-Reply-To: <e1cf9a2c-71e7-0bb6-7926-1c5952de02f7@bouton.name>
From:   Patrik Lundquist <patrik.lundquist@gmail.com>
Date:   Mon, 17 Oct 2022 17:47:40 +0200
Message-ID: <CAA7pwKMmiTkfUq19ey+bWY3f3f1B90sWs926a18ifBYQG7WNdg@mail.gmail.com>
Subject: Re: [btrfs-progs] btrfs filesystem defragment now outputs processed
 filenames ?
To:     Lionel Bouton <lionel-subscription@bouton.name>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, 17 Oct 2022 at 14:00, Lionel Bouton
<lionel-subscription@bouton.name> wrote:
>
> I just noticed a change in behavior for btrfs-progs (at least in 6.0-1
> on Arch Linux). It now outputs the filenames it defragments and I can't
> find a command line option to disable it.

I just noticed it too. You can silence it with --quiet:

btrfs --quiet filesystem defragment ...

/pLu
