Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBEC543F6B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 00:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiFHWrG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 18:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiFHWrF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 18:47:05 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652C511045F
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 15:47:04 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n11so589215iod.4
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jun 2022 15:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jWl3k2iPjxscB5nzJbo/aXjzGrC81mINNRCXPmFYq1k=;
        b=oFVqwbGD4IIf6jo6AzY29eNBHKMyJ2knbg4b9Cmphi2gxmVOlK+hMxWREhBMcjgnOy
         FsaWEP5ZvP6sMFcGohETYPS88XXI7UxAAj9YEBzl2eYOTsoZ8Brkosz/Wah2ugb4Ujf/
         0f71RvphLmtgUJsxr0cSICxXlFec69c5eFIKK4i+fy9GZwrHcnJE2VCITF1nC8TRe1e/
         Wn/7xgBWsU7pqFZ5nhflKDyh1NpejPYUtmgAjSyOk9X18rW4Ojs5grNIWzVwhnXgZEjP
         vZFU7Co0XZSz4JQmUsaWZUg94dnOXzaWhijMhF/Qp2Pyx8qBotnJ9ffFJQqE7oEO2FNO
         T/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWl3k2iPjxscB5nzJbo/aXjzGrC81mINNRCXPmFYq1k=;
        b=Os45j8tv4UTVlnmALmNEQhXwE8YDtB4JzcQaVf0UNWvKWBwfh8dlLK/G/gSXPW6OTS
         SJ8uzuYG1raym2vbttwoXxXh31GabtEJZDWZ6ncpyHKBvyjG8VK0qqFRa6JN6SePqQGU
         3KxEjEV+DLOQt9RwPpKntbT24BX3K3dGk25Tm+lhQwVZq4ZUALQ6TwqQvk4epscqLPHh
         Ry9HYMUlmGNkpeEntkCQliM1yvpNM3DbBre/xRAXMJ07U35d0GWMAtynG+B6AX+3VvBj
         OzSCiwArSv2WZJwQE/BdElb7K60T5k/8HJRDs3Ull8QWeW/gFZLD9LcSbl9QlUkAAh0T
         23oA==
X-Gm-Message-State: AOAM531YCXf6QCoE99nyU14J5DLDwAGmpdPEOa8feaIbWR0GM1XdUEhQ
        F2GwpLUqZS4en1PCNS3eysFSTDktrUBMv0GU0n3h0gYR45Q=
X-Google-Smtp-Source: ABdhPJwwBOqprWsC2gE3SUc32ti6eea5iE/MrlsoL7Nzglq0SO5TDivVdCeYTSLSUg5gG+uhhRs5h36ctC89rE9HO3E=
X-Received: by 2002:a05:6638:2585:b0:331:fbb9:669c with SMTP id
 s5-20020a056638258500b00331fbb9669cmr856276jat.313.1654728423735; Wed, 08 Jun
 2022 15:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220607233734.GA22722@merlins.org> <CAEzrpqcVO99HbrhmtABUENRCm4HEsyg3+T3oK33DZFuXamwqgA@mail.gmail.com>
 <20220608000700.GB22722@merlins.org> <CAEzrpqe79F=-0T7Q3dqb62J6+kcisOjnWP+aLkkY0z+EJY-m9Q@mail.gmail.com>
 <20220608004241.GC22722@merlins.org> <CAEzrpqdq8zTBQaw_VneL4rfZn0JseUiwvtfwXQx0jq=DYBCFFw@mail.gmail.com>
 <20220608021245.GD22722@merlins.org> <CAEzrpqeFFiHjbQ+VQ7zy9ZbV1MgaMT-V4ovJhB9iOan8Ao-cXg@mail.gmail.com>
 <20220608213030.GG22722@merlins.org> <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
 <20220608213845.GH22722@merlins.org>
In-Reply-To: <20220608213845.GH22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 8 Jun 2022 18:46:53 -0400
Message-ID: <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
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

On Wed, Jun 8, 2022 at 5:38 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 08, 2022 at 05:33:42PM -0400, Josef Bacik wrote:
> >
> > Just check, no --repair.  I want to make sure the only thing that is
> > missing is the corresponding device extents for the chunks we
> > recovered.  I'm going to start writing the code to do that now, but if
> > there's any errors other than missing device extents then we need to
> > figure out what those problems are and what to do about them.  Thanks,
>
> woah, it ran in less than 1 minute, that's amazing (I remember when it
> took days)
>

Ok I've added some stuff to fix the device extents.  Go ahead and run
with --repair and lets see how that goes.  After that finishes run
again without --repair so we can see what's still broken, I imagine
I'll have to clean some other stuff up.  Thanks,

Josef
