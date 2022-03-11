Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A764D5A37
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 06:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiCKFGe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 00:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiCKFGe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 00:06:34 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBFD18FAE1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 21:05:31 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so5578649oti.5
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 21:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWyx7riSUOWmQj61vG/kkQEorPiA+7iW6wW2kEskjNw=;
        b=ooXT/iaXvMCbnq6FBqErwneUd2rLc4TwXF6QLpqQzWer+9SxA5xnWQ0XK2NEKcZR/s
         xYAL2Mr9p8vAKbS/o2NM9ZON1RRCcHWsGCNdWTkbzAt33YWpOxSg329fxi4Gu/tCtPp9
         g3AnSzHTVIHh5zXitALQpVwLkM4fLaRvHnrQ90ds+3xu+/2yQnCy6pyGIcjncSeHq2cL
         w9dxrbt58qbgqXtmgYGp/OdXWQNODBsb6szxehH1uZxvrqJPBCUxsYfAPTI8mGKBcPiF
         esIrQCx0GQVYx7irx5+0hbZ5N0juvcQAWHLyzZMTyMmomqsZlVYrNwd7ynyG6anKOc3w
         RZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWyx7riSUOWmQj61vG/kkQEorPiA+7iW6wW2kEskjNw=;
        b=PG5sh7bDKEmBZtN8kGjQIVxxB97q8skNUCl4ygRqv+jc1R8cM1+bDdeUa+7+Gip8uB
         U/Hai/qsuinB8x1YHSAE1zLO+7Mi4vxrRbm5IMo/SOR1AyyP1ujovw/JsYxJezQfbiQ7
         ZaK0e0v1WPKyOaET9JCDGF3kQ5Yr3aM9k5TuqZ9QlQRl5XSJiVQqRir3sr9v9tQMCtV6
         jeAc5pJsRFDWxEAemkenjT5D+vsG2oEO7MmVsImzLkqFDUAE4RdqyA8qyro/c/7j5cOT
         4zTVBFYlVPJ+CWZEstgrsK+TEGaZstdmdSlhvLbFaWNQTHi7j+Lff3Mdbcc1S94hpLFM
         9Fhw==
X-Gm-Message-State: AOAM530UwDT4/UIHNhwz3XqQJN4I8ASodFITqMfNR71vShfPtP+EqQ8L
        /WJXbIh3nsaSVn/26SHJ1kytzxLd3FZG5Z0M7MwldpaV2zk=
X-Google-Smtp-Source: ABdhPJxjwZN7E2krQxYORGLZO8Hhm99uwTntzBXJ2jeIEIcfNRqBHrcZMbM00QIJlywvm/R/XbNxcj+uMuC+v+4QnNY=
X-Received: by 2002:a05:6830:11d6:b0:5b2:5a37:3cc7 with SMTP id
 v22-20020a05683011d600b005b25a373cc7mr4068213otq.381.1646975130701; Thu, 10
 Mar 2022 21:05:30 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com> <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com> <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
 <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
 <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com> <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com> <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
 <7fc9f5b4-ddb6-bd3b-bb02-2bd4af703e3b@gmx.com> <CAODFU0oj3y3MiGH0t-QbDKBk5+LfrVoHDkomYjWLWv509uA8Hg@mail.gmail.com>
 <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
In-Reply-To: <078f9f05-3f8f-eef1-8b0b-7d2a26bf1f97@gmx.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Fri, 11 Mar 2022 06:04:54 +0100
Message-ID: <CAODFU0q+F2Za=pUVsi1uz9CLi4gs-k1hAAndYmVopgmF9673gw@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 11, 2022 at 3:59 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> A few outliners can also be fixed by a upcoming patch:
> https://patchwork.kernel.org/project/linux-btrfs/patch/d1ce90f37777987732b8ccf0edbfc961cd5c8873.1646912061.git.wqu@suse.com/
>
> But please note that, the extra patch won't bring a bigger impact as the
> previous one, it's mostly a small optimization.

I will apply and test the patch and report results.

-Jan
