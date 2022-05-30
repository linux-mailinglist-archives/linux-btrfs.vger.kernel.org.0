Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E74E538857
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 22:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbiE3Ux1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 May 2022 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbiE3UxZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 May 2022 16:53:25 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA47172E2D
        for <linux-btrfs@vger.kernel.org>; Mon, 30 May 2022 13:53:24 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id s19so4405939ioa.6
        for <linux-btrfs@vger.kernel.org>; Mon, 30 May 2022 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kmz+iSP3KAknwhkQkjQbGM5mvql53iQEN5yTHhcQov8=;
        b=R8dC5MzFYW8633F/l4dAb6YAtdwtYQRMw4CDL+61hAHxMn9I+ZFtBtIGLeiI2L5uTr
         j3dUUeaXVqiR1Et7oCvob37NUxzzSmtI59PNdfqyT/Z/knDT5YN2ryCneAnECYQdBXqn
         0CNvOZkv2qixXG4pqm8aufeWidBS9w/zo7wbx7jgnmJfQwt6mpOurahj7cAwv8xhb9qY
         lIvXm7PslNsy64zznRpmDRacW3kvuD+GcDZsoaBQaeMakkCLlKg+dQ7dYQcTdqDdNZBp
         +P3PlyfL2yYZA4xX4gdHXgw01RpEGtnu6+c+ONv3fL8Kz0L53Zlj/ccyDzT9xsI6kDAu
         Diew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kmz+iSP3KAknwhkQkjQbGM5mvql53iQEN5yTHhcQov8=;
        b=C8obS/6Vh2aGifAya6Rco/DXSkdh7P3knNBtf0CHh9dfaFxmHwJjvKER1l3Palqy3h
         DNhb4ZRZ5YY2XOct5sC1K06pWP3dnlxT94ZMdbKHJv1bkHKsYzmqoRDw6PjXrFTqbG8+
         RzFngaV/PZczWm9aUZVFXYYfnUtULfbkB6KfGvpQZrBLiZ1gBzoVx6NwFw2Zac/kVMWG
         PHt5nZ4g2Il8vde3bx1PCRDwRZ3NmweQYOxIeAiH54etqEoEOdfdGRjo028m81TL3mQL
         o4QRzZpyewHNONGqCuVJreM065GrnSR42MZK9wqUgEDJ3fDaiK2X2myh25010p28N+rh
         b5+A==
X-Gm-Message-State: AOAM5307p+GY8Q04bqtl/aWd2JbxqBcotISjJQ9+RxKrnGeHV20h3tRk
        aL/hMkQe1DPsBpp6lFnYYuACLf5abBt5l+WVXlS9szlcUBw=
X-Google-Smtp-Source: ABdhPJxZteD0trrKTBqwVnJ68quNeMArpm/k5FgPP96tr2NzTQCAUAzkRcSGjBDQW0wyW0kINDuoUSaLlP6pND52mLM=
X-Received: by 2002:a05:6638:238b:b0:32e:e939:fee6 with SMTP id
 q11-20020a056638238b00b0032ee939fee6mr17692934jat.281.1653944004075; Mon, 30
 May 2022 13:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220529153312.GF24951@merlins.org> <CAEzrpqdEk-j2bMfBLEdkhHcq1hWLmHv_Nx-0mj1vh0yJgZuCZQ@mail.gmail.com>
 <20220529180510.GG24951@merlins.org> <CAEzrpqfqD8jkznVQR1SL-YpF0ALx7Pbg+ptz7dVgRecOXeDtPg@mail.gmail.com>
 <20220529194235.GH24951@merlins.org> <CAEzrpqfd2jPWxUayfqyYRDN25-etc4_jgzcHmZ3LhGkb4e7Tsw@mail.gmail.com>
 <20220529200415.GI24951@merlins.org> <CAEzrpqdpvnbzaH1gxWnvWLMWEKtOAdYsH25mBWhkF-urf7Zw3g@mail.gmail.com>
 <20220530003701.GJ24951@merlins.org> <CAEzrpqcPirk3AOi1vy+N_V3VY49mvUCiwYL4A_0XoT_jxjgOrg@mail.gmail.com>
 <20220530191834.GK24951@merlins.org>
In-Reply-To: <20220530191834.GK24951@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Mon, 30 May 2022 16:53:13 -0400
Message-ID: <CAEzrpqdRV8nYFshj85Cahj4VMQ+F0n6WOQ6Y8g7=Kq7X_1xMgw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 30, 2022 at 3:18 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, May 29, 2022 at 09:14:23PM -0400, Josef Bacik wrote:
> > Ah ok that makes sense, fixed it, sorry about that.  Thanks,
>
> Same?

Bah my bad, we fail earlier than I realized, should work now.  Thanks,

Josef
