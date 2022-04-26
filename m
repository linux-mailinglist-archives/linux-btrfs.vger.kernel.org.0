Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14510510B2B
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 23:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiDZVYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 17:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355400AbiDZVXu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 17:23:50 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE6475E76
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 14:20:41 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h8so147643iov.12
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 14:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0AhAeQomXfHLcn2++Lb+aEk61/lqunQVh7XPFws3Qg=;
        b=Rfii7LZm3p3Nb2FKPjcWmC0PQgZSPzOhW5OYvCmoab2MTI/twu9a6P/Pabtyb/kUdP
         mQcQxohMrR9nzctj/fHcngCcGXisQ/eQcFpX7xZYzHXWHS6fGu5Ogx9cYMusFkQaI+uU
         tmrGYqxE+j9M+FC6ko0WieC10hwlTX3EvN7to1lMq0r6wNvMh+z7e6Ftgdt53WbDJ8B4
         R7VXZO3zQEzKwoeUdeZWIWdOAydEK7dcVGroIyKdpgE1pX0Mhj1guGJVlb3cWbTc4Tx9
         CVndETufqIbCLbuTKHvzIkbCCfopKHpA+4nCSSHaSYA6t7vo92fncJRwm6URkhOBGj4a
         y1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0AhAeQomXfHLcn2++Lb+aEk61/lqunQVh7XPFws3Qg=;
        b=uhyRC6cmZfR9UKRaADpIZRvKBr9O5ePqbqm0U9johd/zLEtQDQrgzew5XwiA+2wJRU
         yfG6LcadUwbExsjAuScTO13mF0N5qmOFvf6kz7nn6RBd1auMG/iyOJyqStCHlU3lijPg
         HlQPneuR15TaZ+87mbrUHlloIX1giFWXMl/jHlYazkzDq3Mg55LlRmetB54baQlu0YnP
         87Rr+ew7z+xWItVYJHZRzHVtepA0MRm7yzD/AdobGsi2sD/BMy3EnQ0g9XsOfCY726bB
         aKD0+uSYFKye1EUroqCRewVMiIvnToI+xlOO3wm0cudiuWgj95GXhLlbNjbuG2YRIftC
         3c9A==
X-Gm-Message-State: AOAM531zSU61Ky9UzeyGPYQDlpcjE1UeyDU8r6SopOCLr9LgkQ1ljgGe
        cnBCgZBTSEvq6Ba/Ww+ITJ6NmKDe9qJLcWGwpauGgbDTIZA=
X-Google-Smtp-Source: ABdhPJzR8msayUYrv48HX1ObgGN816ZDMYg9JHQxiZvQnm1GIb/bkgCgcroI20F8L4lgL/chP2E6teIkfSqU1HDYals=
X-Received: by 2002:a05:6602:2d55:b0:657:a28c:26bd with SMTP id
 d21-20020a0566022d5500b00657a28c26bdmr2287313iow.134.1651008041297; Tue, 26
 Apr 2022 14:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqcMV+paWShgAnF8d9WaSQ1Fd5R_DZPRQp-+VNsJGDoASg@mail.gmail.com>
 <20220424212058.GD29107@merlins.org> <CAEzrpqcBvh0MC6WeXQ+-80igZhg6t68OcgZnKi6xu+r=njifeA@mail.gmail.com>
 <20220424223819.GE29107@merlins.org> <CAEzrpqdBWMcai2uMe=kPxYshUe8wV0YX3Ge1pZW8aG_BSO-i-w@mail.gmail.com>
 <20220424231446.GF29107@merlins.org> <CAEzrpqcGy3aac6Lb7PKux+nA2KzDgbPSMyjYG6B-0TbgXXP=-A@mail.gmail.com>
 <20220425002415.GG29107@merlins.org> <CAEzrpqcQkiMJt1B4Bx9NrCcRys1MD+_5Y3riActXYC6RQrkakw@mail.gmail.com>
 <20220426002804.GI29107@merlins.org> <20220426204326.GK12542@merlins.org>
In-Reply-To: <20220426204326.GK12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 26 Apr 2022 17:20:30 -0400
Message-ID: <CAEzrpqcFewMWJ0e2umXNBdTkH32ehNi6_bnMQORAnGUg0nqFkw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 26, 2022 at 4:43 PM Marc MERLIN <marc@merlins.org> wrote:
>
> Generally would you say we're still on the right path and helping your
> recovery tools getting better, or is it getting close or to the time
> where I should restore from backups?
>

Yup sorry for the radio silence, loads of meetings today, but good
news is I've reproduced your problem locally, so I'm trying to hammer
it out.  I hope to have something useful for you today.  Thanks,

Josef
