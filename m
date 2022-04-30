Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D86515F50
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Apr 2022 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383165AbiD3QoV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Apr 2022 12:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383167AbiD3QoU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Apr 2022 12:44:20 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4253192AB
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 09:40:57 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id l15so381318ilh.3
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 09:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9lnCrfPtzzooc7ibEgZP8W09SlBsPb47lWHSuDaVr4=;
        b=BMTpL/MimGYeI5J2xebf6bNeDL53+bvIyd9dLYVq7NPKpjMsm0XcebNQtTLX3hGCOi
         HUdsZk0FZGU690X2zkf62p7O9BiyosXA1PrWRaRCnoNy6iNFyaifv39oiloNLwEHJMwW
         cyzf94huPMGH8ciWEduzwp/HQCDFrhmv7N7BdKWgUKr2m+Z1Ovz/hBNbDFSFOL1zrNeq
         qUrhXVZde7t9HyE4Hbdzhkv0deu9/WLYmWS8WypubNzMRa4kddpPRVnlZb0zx9o2zzCr
         eI9sZEJD4IEc6X24jovsoJaGdGj1utruSQ4KpQi1Ef1IqOT84UZmpmexZZ9ZyVpfEkoP
         JR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9lnCrfPtzzooc7ibEgZP8W09SlBsPb47lWHSuDaVr4=;
        b=w/24SrN0JET3JypFHKM70SrjnHaQbsGMoWyC6YpYmCKZEuwGOvwg+ThUpbEJ43qwpB
         CR954ofwP7GIksfM9GwmdRrN4VPekuf1f387DtaPiG5j4BksITPCcwqa5qRsHTLw9Isn
         bMIVEPZZXzPXwkELXBj6X8y5SiMS11z+R2oY0BK3r9gVHTHFVy2Z2blzk7jMHw9SMO3m
         tCrJzZ9XoDkIy6QACTa4/PceTJHFrVNqZ0yqbTteIOsju/uGiDrOz+cRUwAKCTsCOyu4
         1nYLukOYccKCc6Dc+j7ZLt4vtsTP5YxlE7M4Z87E3lAwnQjkB/2ClfOiUA36c6X38tca
         9XnA==
X-Gm-Message-State: AOAM533q7PwRM65kakIGPkEPAimbuwZ9pk1zov+lqbc6Yx6a6UcE/kmq
        mGRTD5LG+m6I0ECUsLuw7H2JtP7mYiXEZc6RsyBdg5EzPU0=
X-Google-Smtp-Source: ABdhPJyupC6qqkXza8ba0h3B6MLDZZt/LYTMu8ZgypEY69ZowkrqgXYKU6rafX17FxBo7EASGl2LxIolDmb7Ku7dW2s=
X-Received: by 2002:a92:d6c9:0:b0:2c7:aba1:6231 with SMTP id
 z9-20020a92d6c9000000b002c7aba16231mr1712514ilp.206.1651336857071; Sat, 30
 Apr 2022 09:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220429040335.GE12542@merlins.org> <CAEzrpqewAfxi9hK+vwK+Df3iziXBZZEmXhzgJdJDqTj-JXvFQw@mail.gmail.com>
 <20220429151653.GF12542@merlins.org> <CAEzrpqfjzzQ4KcHPJmwnaGLNO8-gYp_bcO8HtpGdPC7SctacrA@mail.gmail.com>
 <20220429171619.GG12542@merlins.org> <CAEzrpqdTzbpUZR-+UV1_fx9p_pq188cQbGOqraHP=2Vpdi89Mw@mail.gmail.com>
 <20220429185839.GZ29107@merlins.org> <CAEzrpqdpTXvDCmo-7H6QU1BKXM+fcG6ZdfHzQj0+=+7kcgkuOw@mail.gmail.com>
 <20220430022406.GH12542@merlins.org> <CAEzrpqdiYrbG4FDyoR1=HFZ-d12kD6mF-szxE-e+M-9ahKWd8A@mail.gmail.com>
 <20220430130752.GI12542@merlins.org>
In-Reply-To: <20220430130752.GI12542@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sat, 30 Apr 2022 12:40:46 -0400
Message-ID: <CAEzrpqc3jBA4gRiLuYWFgs8zu_XrNDZ_JS+d2J_TN2a-sivO=w@mail.gmail.com>
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

On Sat, Apr 30, 2022 at 9:07 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Fri, Apr 29, 2022 at 11:13:08PM -0400, Josef Bacik wrote:
> > Hooray we're at the data reloc root.  It should have been cleared tho,
> > so I've fixed it up to see if it's doing the right thing, it should
> > clear it this time, if it doesn't let me know.  Thanks,
>
> Great
>

Ok this is easier, the transaction commit stuff doesn't work quite
right in progs, I've fixed the code and it should succeed this time.
Thanks,

Josef
