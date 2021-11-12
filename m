Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C5744E909
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 15:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhKLOhc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 09:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhKLOhb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 09:37:31 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C716FC061766
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Nov 2021 06:34:40 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id j63so4878814qkd.2
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Nov 2021 06:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ooE0frV4e4BZQ6DGEscixRebQUga5YpWwjUvIc6rw+Y=;
        b=td8rxrKEUWNG1MaDADBMoBNb3rRn9vIgA6mG+TdBxWU/5A3JDWkgK5CVrau3+dyPIW
         TQ8DbqLfGeWn4Zxu9Vwl69xaMo9+nkwYu0Zrbiz5x7OAnRvhG/MP24UVtp1yG4/v3eCr
         rMcFTpHpIJ+dMVv5zmCevxkGKaUaMbd4bABZiZki0jnxRxll0TM9cg4FTKq594iMsMFp
         Nk+fet9+pm2bZQ+dqzRKzTuX7wLibmoQsGl3VDBctvvKk6PkyV07ATWdIVGHDNUOBbrQ
         HUWQ2Gt39oi9KiQPUYoQuiBUWqb+Wg67VI/X+SLRyyWYnwb5iPDCIFnFBTGlamenPLUL
         Bp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ooE0frV4e4BZQ6DGEscixRebQUga5YpWwjUvIc6rw+Y=;
        b=bJ/fwyARdiCUu4OEJMv+Tgehymj/Zmn/y981wr4CSWA41tPRDtgBpLmMZorkxcQwg8
         /mDYQlyT3nsRrZegjiCiAk8HXmXFgHBOqAHV9OkCKAsZz2SoI2rhW82aqLKCxYE/O0+a
         NFoinWch/bEkaoQdQ+YKJGvLzfVq/x72zKylXTU+mYK1eCkhzUpTXMTm1XC4ezSvR1et
         GN8PVrmdFQew0v6XJjIWdp88KgsnhyQ+nzHSedncOP/L4Bl3iABRZwbXb2aLlRmbEG9S
         IDz7mysmZlYJs+NaHWmQg0jCvgWrh1SPhs4gWezAAOUCPkR4kKU43fpSNLAYm4o5dhaV
         C+MA==
X-Gm-Message-State: AOAM5305REtpNslt6O7fL7lHx2DLS/06KgGD4nEypDS6Lmw+EkT9eBOD
        VlDoEqJ2fMeGZQKhe7XY6x9idg==
X-Google-Smtp-Source: ABdhPJz5Ng9itOBnsl552VMbygxMj+ALRUt00flYD/Ata/pKssfyII0VKg5l3IqzzlG81iJ3QrLDTQ==
X-Received: by 2002:a05:620a:708:: with SMTP id 8mr13250683qkc.316.1636727679885;
        Fri, 12 Nov 2021 06:34:39 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v125sm2816321qki.63.2021.11.12.06.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 06:34:39 -0800 (PST)
Date:   Fri, 12 Nov 2021 09:34:38 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3 RFC] fsperf: enhancements supporting read policy
 benchmark
Message-ID: <YY57fpO88z4I0irk@localhost.localdomain>
References: <cover.1636678032.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1636678032.git.anand.jain@oracle.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 12, 2021 at 04:04:36PM +0800, Anand Jain wrote:
> I am sending this early to seek feedback on the best way to benchmark 
> more than one read policy.
> 
> Patch 1,2 adds helpers to support a new setup.
> Patch 3 adds a generic readonly dio fio benchmark script.
> 

This looks reasonable to me, the only thing is I'd want a way for the setup()
part of the test to see that we don't have readpolicy support and simply skip.
Right now there's no mechanism for skipping a test, so add that and it'll be
good.

Also you can just do PR's through github if you want.  Thanks,

Josef
