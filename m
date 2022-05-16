Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E560528503
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 15:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbiEPNK2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiEPNK1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 09:10:27 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4195013E83;
        Mon, 16 May 2022 06:10:26 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id l16so18519550oil.6;
        Mon, 16 May 2022 06:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CaF92eBKzl8YhqaTS1Tzg7cnBN+wgBVFhVH+tqOT7PI=;
        b=q0OW4Ll0d1esJg4Bsi1gSdlTXNns+dyRXpjhWwy3TYP4n4qr8/NV4nZJZKjjduBKRi
         cA/1ac5Z/Sme7x9B3srXyZPtmX5SKG2ovm3cO9mWg1RmnkOoPJ3oT1jhhOpvYVxSxOtK
         EETC7rAwge3lFdAza0DWk9nk5BgdUO+u4Mgw7bEh4ZYJNK3Aeh9oPPg2Ig7eRjDoosqU
         UzYV1++XIwCfe0WO0MlnNE9IF9nupMaem9yK2ia5n1v/9WBmbIxEnxV0yjVXGEaFXtPd
         F/Q36d9JPkZFcTSysTH5PQ0es9AeN0p4TfoGPkBlB9oAT02H+Hc1mjA9INBnW3qT0TLE
         TCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=CaF92eBKzl8YhqaTS1Tzg7cnBN+wgBVFhVH+tqOT7PI=;
        b=7TmJduZbUEHSqwC6DA75Om5r7KUL4xteBvFna1nsjVqNcEvNXsfw2eoDswjTK8JOsC
         n1HTVKPZbgpS9KCGTxtfhw7dcVVnKTV4Scrmawb9dFIXNUyGrqtzvoVymeKKpQ60M3tz
         JjyVhsdr7LyHudh8PdrrQejIUiJTZwZi/4oy/nnE88PhmhgAuktM+WYpTs8gJskOjbF4
         ciWFS8OnVk2L9yAMH6/RlJ0TOj0P796XFI6NE1El0LvMI2nRrlKninTVOBFEGvWLZzTJ
         mCT5uA7OSNsaYsq79HTlrz9Ao3PSpAYXr8nf/jjeu7QC06XaOYjr2ixHgw+8S4iVjLpL
         PyeA==
X-Gm-Message-State: AOAM533T1UxYQtBz0aW5iXGa2TXNWdyISHGp2k8/vs1LuVX9bERFbpyx
        Ec1FDzvWJ+B0SJ68AvbmRfs=
X-Google-Smtp-Source: ABdhPJzuSlHddEfPdlSooNCiKn9gKqW9iethwrrpTKVRacgUq5xfLq0fJvrzlLVkrWbJmB72AUE4Hw==
X-Received: by 2002:a05:6808:148a:b0:326:c71a:f33c with SMTP id e10-20020a056808148a00b00326c71af33cmr12758233oiw.153.1652706625572;
        Mon, 16 May 2022 06:10:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r3-20020acac103000000b00325cda1ff95sm3795450oif.20.2022.05.16.06.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 06:10:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 16 May 2022 06:10:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res@email.cn>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] [v2] Kbuild: move to -std=gnu11
Message-ID: <20220516131023.GA2329080@roeck-us.net>
References: <20220228103142.3301082-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228103142.3301082-1-arnd@kernel.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 28, 2022 at 11:27:43AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> During a patch discussion, Linus brought up the option of changing
> the C standard version from gnu89 to gnu99, which allows using variable
> declaration inside of a for() loop. While the C99, C11 and later standards
> introduce many other features, most of these are already available in
> gnu89 as GNU extensions as well.

The downside is that backporting affected patches to older kernel branches
now fails with error messages such as

mm/kfence/core.c: In function ‘kfence_init_pool’:
mm/kfence/core.c:595:2: error: ‘for’ loop initial declarations are only allowed in C99 or C11 mode

Just something to keep in mind when writing patches.

Guenter
