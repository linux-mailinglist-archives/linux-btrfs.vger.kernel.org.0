Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AEE53D6DA
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Jun 2022 14:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343710AbiFDMuA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Jun 2022 08:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241052AbiFDMt6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Jun 2022 08:49:58 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCD6366A7
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Jun 2022 05:49:56 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r200so2154607iod.5
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Jun 2022 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P6ph24DhNVzPLrQZeXrBkpAG5/OcTUz6PA08AXGPWjE=;
        b=l6/2YscvBZkhWTtvnPPw+tu4by77Dy+F/r7OeGjSomF1aTwHQHLeUSojv3xEJ+wP28
         LH8KDVXc381Qdjma+WTFc4XDrbOJRENfhJof8G7ukmYQdnP22ihGVh0qV3Mxm26Ne4IO
         kDvTiRtb6v3sIyUNyDzGbUeTTuRBTFWxyxVkwbRhf2H5f4go+yk6D/6xJnGM5Idg6c6y
         RVcLoPxLJCshrycwaIwlSIsMogZxX/+rWb/Z2sZak4+08WEPTl/zQenbVZ3HOJwU1cpp
         QDEs1QhU5cSFxW0euC8njcrHoMguMQ6bWUTnyMfbFyiv3Jdlm42JK90O+PQW+SIaoQ6y
         sPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P6ph24DhNVzPLrQZeXrBkpAG5/OcTUz6PA08AXGPWjE=;
        b=qLxDSEIOUJg9JNIjDQxOPlXykzSnuy6/bg++AO7/AqNFuA0QG8lekSXam0jFaQBM+B
         Ul7sd2AsLHjad2QAU7nsif0DdofmgIfHtGRLFBzXOVa6Zp+iKcsuNZ2Lbk/t2eyUjFis
         j8MQWcqfa/uqWg2l6YDtuUI8KA1PnmmBPKhwIJXxON1lddcZtnjDNkEim+3qlmAMYv+Y
         4gv7C0XJNMenU5C2JG8tK9xsKMk0cvqOYEz9D8E51j5YUUntNXW60AiQsHZmUeFuxQS9
         DTEUKPHXX2W4SRsxBoiEZfYMDn72cIdw8yF9yLDpW7e+rPINF+p6nJLQmib9m15c//hF
         noag==
X-Gm-Message-State: AOAM5308epuza5qXJ8TBQXpCwLSlRmFBIRX0pgrtwwnW2kkLYaH+8uZP
        KEsgHgWMyovolFQy0CeXH/LLEFpI/s8hbf/IDCyaOCuZmvA=
X-Google-Smtp-Source: ABdhPJy5McpVk5HQKWdykWgc2aoIm2b6IqK7oGxKoiqva8ZQ5DSXMCgE4SDfwLkpTAkvFZzKlEob6mE5+/i7BSIAFFo=
X-Received: by 2002:a05:6638:1383:b0:331:80f0:c842 with SMTP id
 w3-20020a056638138300b0033180f0c842mr3103603jad.313.1654346995719; Sat, 04
 Jun 2022 05:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqciXfV0NZMTJoMjX_E_TzQ-j5sEpsACnEhnJdAXzbVOEg@mail.gmail.com>
 <20220602195623.GU22722@merlins.org> <CAEzrpqd6CHi2s5B7WPtRo+N0b++F95Qr-nrjYbx2NrD4xxMN=A@mail.gmail.com>
 <20220602203224.GV22722@merlins.org> <CAEzrpqdBHuJr85+TfSyRbXEOVY6jqKqZNJo42d8afATr=b9Gow@mail.gmail.com>
 <20220603144732.GG1745079@merlins.org> <CAEzrpqez1Ct8xrtCOaFtPxWQZ-0R6BUSYm2k=PN9pqChoKNMSw@mail.gmail.com>
 <20220603164252.GH1745079@merlins.org> <20220603170700.GX22722@merlins.org>
 <CAEzrpqf122toMdEAx2audiusW3kKM6d36df13ARJ+SjbVf7TFw@mail.gmail.com> <20220603183927.GZ22722@merlins.org>
In-Reply-To: <20220603183927.GZ22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sat, 4 Jun 2022 08:49:44 -0400
Message-ID: <CAEzrpqdzU7nugcLoTzKy-=tsikX=dUx5xMb2iKe+wR=69=H4yA@mail.gmail.com>
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

On Fri, Jun 3, 2022 at 2:39 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Fri, Jun 03, 2022 at 02:34:37PM -0400, Josef Bacik wrote:
> > Hmm tree-recover is supposed to catch this, can you re-run
> > tree-recover and see if it finds this block and gets rid of it?
> > Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> FS_INFO IS 0x55eaff09dbc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55eaff09dbc0
> Checking root 2 bytenr 15645019570176
> Checking root 4 bytenr 15645019078656h
> Checking root 5 bytenr 15645018161152
> Checking root 7 bytenr 15645018275840
> Checking root 9 bytenr 15645740367872
> Checking root 161197 bytenr 15645018341376
> Checking root 161199 bytenr 15645018652672
> Checking root 161200 bytenr 15645018750976
> Checking root 161889 bytenr 11160502124544
> Checking root 162628 bytenr 15645018931200
> Checking root 162632 bytenr 15645018210304
> Checking root 163298 bytenr 15645019045888
> Checking root 163302 bytenr 15645018685440
> Checking root 163303 bytenr 15645019095040
> Checking root 163316 bytenr 15645018996736
> Checking root 163920 bytenr 15645019144192
> Checking root 164620 bytenr 15645019275264
> Checking root 164623 bytenr 15645019226112
> Checking root 164624 bytenr 15645019176960
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 block=15645019471872 physical=15054973173760 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
> corrupt node: root=164624 block=15645019471872 physical=15053899431936 slot=25, bad key order, current (7819 1 0) next (7819 1 0)
> scanning, best has 0 found 0 bad

Ok we're finding the corrupt blocks and scanning, but for some reason
we're not getting the updated root?

I've pushed a debug patch, can you re-run tree-recover and capture the
output?  Thanks,

Josef
