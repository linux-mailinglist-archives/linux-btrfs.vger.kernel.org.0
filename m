Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF57B539A4E
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 02:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbiFAAOl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 20:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244193AbiFAAOk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 20:14:40 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4C4286D0
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 17:14:39 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id d3so144045ilr.10
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 17:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D26owbANSAwdQmxwF6jCJJHMkDjlD4cuyRG1tGs+gNg=;
        b=PVbxoqp6Z598W93DhuY1rBE8slG9isfVwJgd10rKXTNbv+kkPnOXt44ShTsifJbD7h
         Qw2POmljsBIBFJulIK14JgH7KN64YbQKMmKgd0EEKWo5ZSKGXOQb/KwbgqyJxIhWjSkG
         6WM31okuja+QX44lw6L5bytAaWjlXyxlYPtKkdy3a51i6LD6J5xwiM+w+WsfRGJxKhrJ
         +XOJcqsJoiaL9ahtZlicT0vni9Xn2wcBy4IjDNfJMXUexZ6GASf0WzgL+4QZyA9lYAY8
         O8YrL+PsoOtRREbYE6hKuhCEAXEjnkoPXtD7fZ/1m6jOVgoOyiaCkXQ/obbvIiZXDSfa
         rSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D26owbANSAwdQmxwF6jCJJHMkDjlD4cuyRG1tGs+gNg=;
        b=ubKmOVKVaa5E/frgS00696dy/zxlvPuyjy2fg51fzvB8VDMNQo/ODD1Q8U5OEMPnaa
         iCxScc4ku3xIWOyiYt12zuDk3dcWtKk3gS3GeQZAqTVfvNR2AZsCwC79Qepl7Gn2XLQA
         +s76kKLpT4tvSd5+FYoqHJjUE4WbzoaUu0rjNYf79+nY8di/nLFLvXAiLgoXCnOTlhxJ
         RCpO+chsXP717LvrjfHxbRY+GxFuVaPjv1dWqvNxVAcjpV3NalbB1r6uKgoshchHxUio
         hRCJzkRmu5GVzorLX4Bvc+LSMt/P+JrKD1xpDu6PSiORBkF9DdxT5/c94NJwobvoC0vK
         Iv6w==
X-Gm-Message-State: AOAM530bjd2Y5gFd4QfZGsGmFSJH1K8lvB9GXSjnskuHeaH19NJq5vj9
        UdsW2BAK/E5N+05R1d9+/xupXPSFDPM/8kE1MnoGDvctzL0=
X-Google-Smtp-Source: ABdhPJxqC+9PVrSPy+ud6068pFJLuM+xxbENnl7GDCfycEida5MxtIQKpwvSystyw6LmDuH5eLAbo21I/X8J1qfeDBo=
X-Received: by 2002:a05:6e02:198e:b0:2cf:4a7a:faf8 with SMTP id
 g14-20020a056e02198e00b002cf4a7afaf8mr31042473ilf.206.1654042478717; Tue, 31
 May 2022 17:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220529194235.GH24951@merlins.org> <CAEzrpqfd2jPWxUayfqyYRDN25-etc4_jgzcHmZ3LhGkb4e7Tsw@mail.gmail.com>
 <20220529200415.GI24951@merlins.org> <CAEzrpqdpvnbzaH1gxWnvWLMWEKtOAdYsH25mBWhkF-urf7Zw3g@mail.gmail.com>
 <20220530003701.GJ24951@merlins.org> <CAEzrpqcPirk3AOi1vy+N_V3VY49mvUCiwYL4A_0XoT_jxjgOrg@mail.gmail.com>
 <20220530191834.GK24951@merlins.org> <CAEzrpqdRV8nYFshj85Cahj4VMQ+F0n6WOQ6Y8g7=Kq7X_1xMgw@mail.gmail.com>
 <20220531011224.GA1745079@merlins.org> <CAEzrpqco_RyUBK=dngrv54u8WE2uhSGrJaB9aRY5nUmKNzN32Q@mail.gmail.com>
 <20220531224951.GC22722@merlins.org>
In-Reply-To: <20220531224951.GC22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 31 May 2022 20:14:27 -0400
Message-ID: <CAEzrpqcui3A42ogkas9pQfMqX0qE+MApPuiUw12uwpqhNq2RHg@mail.gmail.com>
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

On Tue, May 31, 2022 at 6:49 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, May 31, 2022 at 04:57:17PM -0400, Josef Bacik wrote:
> > I hate myself so much.  It looks like it recovered the chunk tree, so
> > you should be able to run
> >
> > btrfs rescue recover-chunks <device>
> >
> > to see if it can find the mapping's we're missing.  If it does then
> > I'll wire up the code to insert them, and then we can go about finding
> > the other roots and getting this thing fixed.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# git pull
> Already up-to-date.
>

Wtf, we're clearly writing the chunk root properly because I have to
re-open it to recover the tree root, and that's where it fails, but
then the chunk restore can't open the root, despite it being correctly
read in the tree recover.  I've pushed new code, try tree-recover and
then recover-chunks again and capture the output please.  Thanks,

Josef
