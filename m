Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D3597EBF
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 08:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241568AbiHRGk5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 02:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiHRGk4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 02:40:56 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D22CAEDAC
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 23:40:53 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m2so754639pls.4
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 23:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=kXjh+oBhiEn9Ji0wHsA4tl8yjbLivCCs0CYl7qZz7jA=;
        b=xn7MDOQUqcpzfCJzPgT3cDG6oqZPjf74HpAXKrPnEXWJ1yYHwm1resLlBXaydL9LGc
         /8UghDv8oVR2RnpWF9kSMD9w+zub1xGk+cbEmaybnHT/l5MF65LsKZ6n1FUbji2wrJW2
         ++cZXNx1eJmOsZZyAScDC8A9D5umMlAIHSz7Ez3W1yqIo5653pk6/aKUVFEqwtO6cQ61
         fxIqaDXzsVhaDjOv4Pb4JdYnYRqgB6kWN1a0N9zoHNLM6i2vG9fMsB+gu2BH2I3a3kRq
         kbweW3pNNr/ayseX6+SF23J2dIDCw9kwFMcO6yFwB14ovVPlZMjO+l2p4Wl0fqClBker
         dMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=kXjh+oBhiEn9Ji0wHsA4tl8yjbLivCCs0CYl7qZz7jA=;
        b=bjnyfc3bj2K1y1YT5AVJ9hu8VruCgfoCjlK7NUajq+Pzv28NFVtpfyHLuzulBxsI3/
         6PhwacADn7Z4oK+Ggj/dHPLFiuJGVkMTVOr9n49ZFyPUyPCS5f5ZFtjWqRa1Fa7uR9AD
         HUMwBeGb1alIcbOiOm9IpQn/JtY/RC/YevakaDLbssD3SPJ4ElBTO3NbkMHWwBExi9k7
         9FqYaamF4v6cpfyYS435k14cZqgFKTLs1gJNb9vPdDD1UGnh4Q+2UKD9tKbnEtIReacn
         y5X+8IFnWuJTSP0BtmchvIuyuAE2ADkar6Gnb13itEAu7fvEYJWumZGGshX+ORJhNQ7K
         fYFw==
X-Gm-Message-State: ACgBeo0rDQ/lpjhAPylw5RFCGI73PFkQQC7UzIbXFYPeB7PhSMQazgAd
        ni1Hb+0tUZVRDAHoQd69tFRebQ==
X-Google-Smtp-Source: AA6agR6DKIxddQyYfBexn7zRBdmQAlTFluHv6oDE21IpTWkGIsQ31pCtrZjofy4phu8hMWI2f6hv6Q==
X-Received: by 2002:a17:903:228c:b0:16e:df74:34e5 with SMTP id b12-20020a170903228c00b0016edf7434e5mr1460843plh.49.1660804852741;
        Wed, 17 Aug 2022 23:40:52 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:a300:cc0::f972])
        by smtp.gmail.com with ESMTPSA id f20-20020a63f754000000b0041b823d4179sm578961pgk.22.2022.08.17.23.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 23:40:52 -0700 (PDT)
Date:   Wed, 17 Aug 2022 23:40:51 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Andrea Gelmini <andrea.gelmini@gmail.com>
Cc:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Linux BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: fix space cache corruption and potential
 double allocations
Message-ID: <Yv3e8/82qugMFUSJ@relinquished.localdomain>
References: <cover.1660690698.git.osandov@fb.com>
 <9ee45db86433bb8e4d7daff35502db241c69ad16.1660690698.git.osandov@fb.com>
 <CAK-xaQZYDBuL2DMeOiZDubujSmZTcNJfkgqa03Q+24=nhCmynw@mail.gmail.com>
 <dbc8b0ee60b174f1b2c17a7469918a32a381c51b.camel@scientia.org>
 <Yv2A+Du6J7BWWWih@relinquished.localdomain>
 <CAK-xaQZh4DJf=6oxK2SVuodxE_bhUxEjAJXmYd6KfXGdg_9PEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK-xaQZh4DJf=6oxK2SVuodxE_bhUxEjAJXmYd6KfXGdg_9PEw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 18, 2022 at 08:21:30AM +0200, Andrea Gelmini wrote:
> Il giorno gio 18 ago 2022 alle ore 01:59 Omar Sandoval
> <osandov@osandov.com> ha scritto:
> > From what I've found, it's much more likely to happen if you delete a
> > lot of data soon after boot with space_cache=v2/nospace_cache and
> > discard/discard=sync. I can't say that it'd never happen outside of
> > those conditions, but I suspect that it's much harder to hit otherwise.
> 
> Thanks a lot for details.
> 
> If "discard" is a necessary condition, does it mean that on HDD we
> don't have the problem?
> 
> Do you think is enough for the moment to disable "discard" on nvme/ssd?

Discard is not necessary, but it does make the race window larger. So it
wouldn't hurt to disable it for now.
