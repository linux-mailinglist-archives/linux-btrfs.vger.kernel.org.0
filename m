Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473A44D53A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 22:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbiCJVdF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 16:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245745AbiCJVdD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 16:33:03 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC2D194159
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 13:32:02 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id d15-20020a05683018ef00b005b2304fdeecso4984995otf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 13:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyNF06kNh/mqKu9J/ahHeo0WYrtbNttlabu4NXmxij0=;
        b=pjGVzfqAUCoMKDMcE1PYSStllmW+EkTDVjq04fE/ZNEbMRS+YG/TdQo/vGkTOw66Zk
         77lieILcGiyBnvMP6thAPhbsqVhDe5CoJ7j/bknJa0xgOvynmv+kc0kljMxkHkzC1Yxe
         4CBzIWIl/ncbC6dPLJuaA1RuVopEFqMCluv7Rxt6pW/caflyjcyvaU9M3XgnQxpLfe9j
         hq26fcZSpjQ8tw/iBYHGHzpJF+QailqANzmDQqnMq84gSvL8TGYrKlmj31wynDuQmlPg
         nibzzZtPm7WR0iHTfAwjI0Bd83xWAYVtS/k/iCb4xQKhRAvQjh4l0DD8h6PTX2JnI86B
         UUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyNF06kNh/mqKu9J/ahHeo0WYrtbNttlabu4NXmxij0=;
        b=w9hj8rPAjOz2Em/49OK6SGuk/jUb5JH9qn34ZYjoPzTPgqXfVcn38BAgZNds23Kj9O
         1w2DX1JybfGxPupLS7AaGiXpWoYhWkQGa4ooVkvjo3Wu3oeOOM/KoSs6wFLp/o6h8JFI
         hEK0+rjrLL1tiuzOj/KzBtWEt5jztEvjNVhnyLMOrYcUn2VwX2pbxTFSgaw5aHdVZiLM
         s6qsICYles6Cjt2zGTPjuI+Wfa1zTR0MaJPCMLHPUF4AKytrzKSYI2EYg4oQYjuhWofY
         pVrdGblGLSOtEqFqTdAEk0NTkYdgsFvjgWZYQJeXsWAgcQBUBc7MOiq310HRhYyGKUWJ
         /lRQ==
X-Gm-Message-State: AOAM532v2/Ee1+WB52wWQAyHG+BGodxEfxWayjz+JQ+XQVyYTBbmKVat
        3KwttPFCs+r3fmYcE/RaV/d3aePCacvUqS9F4QqMNHTvIgQ=
X-Google-Smtp-Source: ABdhPJz0D5iVsTKOmblym2rXzLSf9rSxuMkn1g1U/h6uwRtf7jl5mueQ6gZ1EB4XPgsWjp8GOlvqlgoyRKoT3eiU4Ns=
X-Received: by 2002:a05:6830:11d6:b0:5b2:5a37:3cc7 with SMTP id
 v22-20020a05683011d600b005b25a373cc7mr3394568otq.381.1646947921303; Thu, 10
 Mar 2022 13:32:01 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com> <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com> <3c668ffe-edb0-bbbb-cfe0-e307bad79b1a@gmx.com>
 <CAODFU0pcT73bXwkXOpjQMvG0tYO73mLdeG2i4foxr6kHorh1jQ@mail.gmail.com>
 <70bc749c-4b85-f7e6-b5fd-23eb573aab70@gmx.com> <CAODFU0q7TxxHP6yndndnVtE+62asnbOQmfD_1KjRrG0uJqiqgg@mail.gmail.com>
 <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
In-Reply-To: <a3d8c748-0ac7-4437-57b7-99735f1ffd2b@gmx.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Thu, 10 Mar 2022 22:31:25 +0100
Message-ID: <CAODFU0rK7886qv4JBFuCYqaNh9yh_H-8Y+=_gPRbLSCLUfbE1Q@mail.gmail.com>
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

On Thu, Mar 10, 2022 at 7:42 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > The compressed trace is attached to this email. Inode 307273 is the
> > 40GB sqlite file, it currently has 1689020 extents. This time, it took
> > about 3 hours after "mount / -o remount,autodefrag" for the issue to
> > start manifesting itself.
>
> Sorry, considering your sqlite file is so large, there are too many
> defrag_one_locked_range() and defrag_add_target() calls.
>
> And the buffer size is a little too small.
>
> Mind to re-take the trace with the following commands?

The compressed trace (size: 1.8 MB) can be downloaded from
http://atom-symbol.net/f/2022-03-10/btrfs-autodefrag-trace.txt.zst

According to compsize:

- inode 307273, at the start of the trace: 1783756 regular extents
(3045856 refs), 0 inline

- inode 307273, at the end of the trace: 1787794 regular extents
(3054334 refs), 0 inline

- inode 307273, delta: +4038 regular extents (+8478 refs)

Approximately 85% of lines in the trace are related to the mentioned
inode, which means that btrfs-autodefrag is trying to defragment the
file. The main issue, in my opinion, is that the number of extents
increased by 4038 despite btrfs's defragmentation attempts.

-Jan
