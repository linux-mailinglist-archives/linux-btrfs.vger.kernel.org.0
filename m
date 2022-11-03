Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839C86188B4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 20:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiKCTZG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 15:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiKCTYm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 15:24:42 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FC81FCC7
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Nov 2022 12:22:33 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r83so3067546oih.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Nov 2022 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TYtqQYx2cQnY0A6XfAYrD5ztP0rjImGcDImVfTNb6uA=;
        b=K0yql6C73V7iwwOfXaiFH4g9UX8QPqhgpdwg2TOsPlCgl9kV7eaq5mZkiGVc2ghQ1P
         EHlRNPqA9u2bw+HqCox4qGvaXRL5rFVtWLb88tpGvjq3DEuVMG44t7B/BjHV80/Vqev/
         S4641kmOMzPu57GWywfdDLe7QtioGQTm5S+Rs9Rjopb0kOY+/xGT1ZqKcfsd+WuUFkqa
         4bjPFBrVW6KReX29P+zzFj5qGzvfFUs22AfwDBqY8MhU+NAMBWpbkxYDeCABeZIz+xoI
         9TxOrxAR3aDev3BBBkLKhu9AMHaar0Y3SGFoecTBjrIMjU3e7P+uN/aScha3/CKSfsLo
         85bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYtqQYx2cQnY0A6XfAYrD5ztP0rjImGcDImVfTNb6uA=;
        b=BG1H0m3fadyMWwk5+Pd8YJV5z0iie0TMwvIJLLUVQO0wD9Vdleh0piU8Q0EYzx3Rbu
         /830Y+/OvLbt59a62elf8mPDEkIzMwN9+Ya3ZwwQg197o5xobFydundL3Wl3s5w7vlNd
         /fvvXG7gHMow1xWUidMVfYrsoBSb+3GVlAmClzn1Lf7x69z9dgPhYaqo43X91jilwuUT
         OSordRHKCfWMjGzKWqSLTf/bFjOnbCzqCa9amVQzxnw4wf6Mh0zJJOxq572Vi7amHb0k
         HwWSaVL7fNsXBMCMGna/y/rCw61AbaaiezNTYFDqrjTI5VbEtIs1poSMowBlaodGf+B/
         U3hA==
X-Gm-Message-State: ACrzQf2hlngzw0zmTdb3A6fRDF5u/TXvyU7NO9CmE5/a8RFY2Cnl/bQT
        h+8rF2Uj6c6DJZFf85rr6B/3DXXupW0Xbqs8RMtmPQ==
X-Google-Smtp-Source: AMsMyM63FWPX3pP1ce1+lrFgUZQB8IPUH7zlERXn3R2BkuKoOUy1q07Q0CBe9YRG/m5g1lzo3qUJJo334by/nMMuIYY=
X-Received: by 2002:aca:ba07:0:b0:35a:4940:f332 with SMTP id
 k7-20020acaba07000000b0035a4940f332mr3496301oif.42.1667503352704; Thu, 03 Nov
 2022 12:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1667389115.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1667389115.git.sweettea-kernel@dorminy.me>
From:   Paul Crowley <paulcrowley@google.com>
Date:   Thu, 3 Nov 2022 12:22:21 -0700
Message-ID: <CA+_SqcAFMXjW6V2u1NZzGwBe4na4m_FBspgP0Z6Q0oTvT+QJVQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] btrfs: add fscrypt integration
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you for creating this! I'm told the design document [1] no
longer reflects the current proposal in these patches. If that's so I
think it's worth bringing the design document up to date so we can
review the cryptography. Thanks!

[1] https://docs.google.com/document/d/1iNnrqyZqJ2I5nfWKt7cd1T9xwU0iHhjhk9ALQW3XuII/edit
