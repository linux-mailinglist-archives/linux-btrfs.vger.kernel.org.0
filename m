Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345B14CD6E7
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 15:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbiCDO5u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Mar 2022 09:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbiCDO5f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Mar 2022 09:57:35 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33721BD9BA
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Mar 2022 06:56:44 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id n185so6583212qke.5
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Mar 2022 06:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UmeUZijcz1dVuxx3LK80xrFul1z7te6GU3Yzq3ywY18=;
        b=zlz9hSyUhcTY/ZHtxAw01v3nOquUfaNZEnvMAWwxVPXP/qJ/WW8EKtp8zZ2+BSa166
         Szn1LuxnM6nLgxwZzDr9DpCsdS1m82Moj4WBG9uBjrU+FPnJMhPc0FuRPrNpTsEFung1
         xFUmZmiAovQyO6OoZvRkalTmOo2dlDaqdyxkHFb6KeSgQpqZ3Fq7mXc4siQ2/iOhWIi6
         0X6t1VsiGYH04NFB5Nv31Ikb0fdKAHvZ7eGwm0DfBMXUswl7TzoCk0Qa3FTzxVL7SYFH
         JsJzz4sUfYScdR//ICAl1AjMiG3RkJl4+vHNiFP7yKegVf+UNVleT0AjsmCgb3DSL7vo
         //dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UmeUZijcz1dVuxx3LK80xrFul1z7te6GU3Yzq3ywY18=;
        b=PG2siULoQ2dCzuXbmeT2mLOd/89gPDgKQKs9dEJgBSzP3hBS2+mxCo0yhSSxLfSBaq
         IZC0qowfviZg58uPuPpIX/t75NWt5VyrfwinHkijM0We9lFLoAbmAlqN+H0TmvrjKrcg
         vNrNLWm5eZ4Pqc12DPquQOSCxwhV84SbPdXAkJKzb8O3j6/IRQrws3whTfN7xVvUZnui
         V3Re0nkaxDCTIYCFUAPc8/Os25Ul49YYzaTPt8r7AefMcZbyLJfj7k2sXEWI9o+p6kIf
         uMUNWGC0YRkV/2ONchGLJ19bIH/JTGUSFx5n8G8CoZXOF9BVCCDI82WOPNXVJFJuep9c
         tpJQ==
X-Gm-Message-State: AOAM530N9kv2m/zhwY2IcNSKiZF4zh2ZpLtmd55mGy0n9NOhRwNSabgD
        u6WZzWMMTkWQdrD9RabZECTmQA==
X-Google-Smtp-Source: ABdhPJxkljnqof1rXx0tDnvKrbE+PwQAz6QXUPN4PzsLPs8tojGNRQD9S5dbDeT1vLQXlRv9bIRLCw==
X-Received: by 2002:a37:415:0:b0:649:8109:ccfa with SMTP id 21-20020a370415000000b006498109ccfamr2706500qke.485.1646405803771;
        Fri, 04 Mar 2022 06:56:43 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b1-20020a05622a020100b002de94100619sm3589597qtx.81.2022.03.04.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 06:56:43 -0800 (PST)
Date:   Fri, 4 Mar 2022 09:56:42 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
Message-ID: <YiIoqhq4uVfa1oyf@localhost.localdomain>
References: <cover.1643228177.git.kreijack@inwind.it>
 <Yh0AnKF1jFKVfa/I@localhost.localdomain>
 <c7fc88cd-a1e5-eb74-d89d-e0a79404f6bf@libero.it>
 <Yh42nDUquZIqVMC0@localhost.localdomain>
 <e8d1a33a-a75a-1a25-b788-a2da5019e6c4@inwind.it>
 <Yh6Tit2dKcLt7xJP@localhost.localdomain>
 <90407af0-57bb-9808-7663-6feb56fa7b20@inwind.it>
 <Yh/gWL983TFzcObT@localhost.localdomain>
 <d9d6f8a6-044c-648a-c677-d4258fc70154@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9d6f8a6-044c-648a-c677-d4258fc70154@inwind.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 03, 2022 at 08:01:00PM +0100, Goffredo Baroncelli wrote:
> On 02/03/2022 22.23, Josef Bacik wrote:
> > On Wed, Mar 02, 2022 at 08:30:22PM +0100, Goffredo Baroncelli wrote:
> [...]
> > > 
> > > For simple filesystem (e.g. 1 disk), it is trivial (and not useful); for more complex
> > > one (2, 3 disks) it is easy to make mistake.
> > > 
> > > btrfs-progs relies on major_minor; it is possible to used the BTRFS_IOC_DEV_INFO
> > > but it requires CAP_ADMIN....
> > > 
> > 
> > Well this just made me go look at the code and realize you don't require
> > CAP_ADMIN for the sysfs knob, which we're going to need.  So using
> > BTRFS_IOC_DEV_INFO shouldn't be a problem.  Thanks,
> 
> I am not sure to be understood completely your answer, so I recap what I am doing:
> - replace the "int" interface in favor of a "string" interface (not "echo 123 > allocaton_hint"
>   but "echo DATA_ONLY > allocaton_hint") [DONE]
> - remove the "kernel" patch related to "major_minor" [DONE]
> - update the btrfs-progs patch to use BTRFS_IOC_DEV_INFO instead of <devid>/major_minor [WIP]
> 
> 
> This will have the following consequences:
> - any user is still capable to read <devid>/allocaton_hint
> - only root is able to use "btrfs prop get allocaton_hint <devname>" (before any user)

Ah yeah I see how this is annoying, oh well it can't be helped.

> - only root is able to update <devid>/allocaton_hint
> - only root is able to use "btrfs prop set allocation_hint <devname>"
> 
> The 2nd point may be relaxed allowing to use BTRFS_IOC_DEV_INFO even to not root user (
> I don't think that there is any sensitive data exported by BTRFS_IOC_DEV_INFO); but this will
> be done as separate patch.

Agreed, I think that's a reasonable thing, and yes separately please.

This is all good, thanks Goffredo!

Josef
