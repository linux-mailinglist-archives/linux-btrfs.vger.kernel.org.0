Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11F06DE1D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Apr 2023 19:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDKRCn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 11 Apr 2023 13:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDKRCb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Apr 2023 13:02:31 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB356A77
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 10:02:02 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id dm2so22214326ejc.8
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 10:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232498; x=1683824498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIFNu8175hjn5qTBwd6pZV/nUyUwcr8nNrjL+p+KKg8=;
        b=62BAFtF9kwr0UyDJ7M8mPMQW3fYIKEqZypw4SQEki1f71evB7iXqKJVRwGnSAiCMuu
         VtpoID1fug9rvd3fzXwGf9NLQj2ruC+O5MUyN5OPx2tLJy/kn+wbapH40J4smoU97CpZ
         5avsCc7jGBIMcQsfIVno1ND2R7hFg8wvjdbC8BWNVhwLfar0ux5kdJoLIDf0p6+rSWtT
         brS3HVv13jpHUqZgBYw6e86kMPBzbisoKpKbqyJGH7VYi5wn5k1ULq0jB9LLLCYo0DHQ
         WdcSh/cCt1k3xcvVWOIoXJpJSrHGzfIElc6DgwEmyPwjU4DFO6JKxIQSY/HIkYcXe2cm
         lRCA==
X-Gm-Message-State: AAQBX9emrM+ZSUUKSo+9ux+5n5LM+S2GXa3fO4oUcDVpsT6vkgNtofhx
        UCakhn6JrOsZE6JTEZdA++BcnejgQqMQyA==
X-Google-Smtp-Source: AKy350YqH7gzLNtE4xuTG8DBSrKMb6AHS03NUcA//eO/05d3HmJXeAyHtMY8SD3jdq9nQhmJf587Mw==
X-Received: by 2002:a17:907:6e06:b0:930:6c71:64eb with SMTP id sd6-20020a1709076e0600b009306c7164ebmr12004355ejc.29.1681232497829;
        Tue, 11 Apr 2023 10:01:37 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906504300b00947a6d84fefsm6364845ejk.75.2023.04.11.10.01.37
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 10:01:37 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94a39f6e8caso211106666b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Apr 2023 10:01:37 -0700 (PDT)
X-Received: by 2002:a50:8713:0:b0:4fa:3c0b:74b with SMTP id
 i19-20020a508713000000b004fa3c0b074bmr5320699edb.3.1681232497562; Tue, 11 Apr
 2023 10:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681150198.git.josef@toxicpanda.com>
In-Reply-To: <cover.1681150198.git.josef@toxicpanda.com>
From:   Neal Gompa <neal@gompa.dev>
Date:   Tue, 11 Apr 2023 13:00:00 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8yuZo1Z4ZHB5+z+KgHz83ao_3zpRt=Fc=64gDpQWxdsA@mail.gmail.com>
Message-ID: <CAEg-Je8yuZo1Z4ZHB5+z+KgHz83ao_3zpRt=Fc=64gDpQWxdsA@mail.gmail.com>
Subject: Re: [PATCH 0/4] btrfs-progs: make some of the fsck-tests run without root
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 10, 2023 at 2:13 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Hello,
>
> While running tests on my ctree sync patches I noticed these tests were failing
> when I ran as a normal user.  Most of them are just needing to call
> setup_root_helper before calling the loop device helpers, some need a
> $SUDO_HELPER added to a few places.  With these patches in place I can run make
> test-fsck as a normal user.  Thanks,
>
> Josef
>
> Josef Bacik (4):
>   btrfs-progs: fix fsck-tests/056 to run without root
>   btrfs-progs: fix fsck-tests/057 to run without root
>   btrfs-progs: fix fsck-tests/059 to run without root
>   btrfs-progs: fix fsck-tests/060 to run without root
>
>  tests/fsck-tests/056-raid56-false-alerts/test.sh | 6 +++---
>  tests/fsck-tests/057-seed-false-alerts/test.sh   | 8 ++++----
>  tests/fsck-tests/059-shrunk-device/test.sh       | 4 ++--
>  tests/fsck-tests/060-degraded-check/test.sh      | 4 ++--
>  4 files changed, 11 insertions(+), 11 deletions(-)
>
> --
> 2.39.2
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>



--
真実はいつも一つ！/ Always, there's only one truth!
