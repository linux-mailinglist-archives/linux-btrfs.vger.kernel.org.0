Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F74371375
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 12:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhECKOL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 06:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhECKOL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 May 2021 06:14:11 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4092DC06174A;
        Mon,  3 May 2021 03:13:17 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n205so2114697wmf.1;
        Mon, 03 May 2021 03:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZIiigzczc2DpeF5+8WBfchZtQVOjuSNAlSlfWiT/G4k=;
        b=AlutymW/j+Tc7Xu+7nbANQTfOfTahhAHdoRNLk7zt/APz2ydNtFK/f8OVe3smXk0rW
         smEhFR+/xAfkGMWmAWN1IPztixOVXjvrzj8ynDaB0CNGH66HjeF3Ui8JkBGiZvvCqYBy
         vRVK1OaDyf845ADQro0/ZmXarztafc6XVFV/eWCI3kEE2scvAU1WpoGpZVG8ENuIJ/b8
         wZ183Ovs0NHI05Z1Z81R6mtDbWyz+LAkYqRqFk6CCSFOoOvel7EUn23QPa1VtxvX4dO0
         O5ZAJdUIC26apYi9CeWJcPX+p+qmp1irc6qieReieCNaGGfg9Bm42HldZeKZ8/ncHp12
         OW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZIiigzczc2DpeF5+8WBfchZtQVOjuSNAlSlfWiT/G4k=;
        b=NQQq13m9aqtAZsVMGbQYXugD08c8/jJsbS3K46CgAWIikiYySErXF1JhQdGBWZ6vce
         TPg1ZWhsbyMALWhnzRQY2FM5bCiqtrn+oZGdQg3jtuR3ybacFWhuUnbwPPMyfwCez9nQ
         yp+n0Y489yiYwpFUVcLgsButssdeprEZT0ugLp71xa5BvNGrTwDcGb7Oya1LrdDQl493
         yjlXFt2wEEXWHQPIHubhj9yD5hgYgRIwtrWuS12YmnzhSSbQGaux+QLopmY+8mibmV/N
         Ojgn6IhiAh6FB4NSbLQ1vv3R8AtBCB7ShdriKLJ84nzpAHXOASTVcac2QBq3Nv6xx2Pz
         d4tQ==
X-Gm-Message-State: AOAM533TyMUe3v6YULVZpi0MT10PkOp7ot22Ro8nk0B1/QjUaVkCPT0Z
        bdC31CMmP73bA0/MQXtrZlWbN2gGncCi7qPo
X-Google-Smtp-Source: ABdhPJwBldsGw//teJhYUukFMq+NmABbXP9lBHI0ZZbtaikmZZuXhmpKSia/IU6cTw2JF9JwRZyQGA==
X-Received: by 2002:a05:600c:2e42:: with SMTP id q2mr21044097wmf.64.1620036795973;
        Mon, 03 May 2021 03:13:15 -0700 (PDT)
Received: from ard0534 ([41.62.186.65])
        by smtp.gmail.com with ESMTPSA id g13sm7484718wrd.41.2021.05.03.03.13.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 May 2021 03:13:14 -0700 (PDT)
Date:   Mon, 3 May 2021 11:13:12 +0100
From:   Khaled Romdhani <khaledromdhani216@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/btrfs: Fix uninitialized variable
Message-ID: <20210503101312.GA27593@ard0534>
References: <20210501225046.9138-1-khaledromdhani216@gmail.com>
 <20210503072322.GK1981@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210503072322.GK1981@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 03, 2021 at 10:23:22AM +0300, Dan Carpenter wrote:
> On Sat, May 01, 2021 at 11:50:46PM +0100, Khaled ROMDHANI wrote:
> > Fix the warning: variable 'zone' is used
> > uninitialized whenever '?:' condition is true.
> > 
> > Fix that by preventing the code to reach
> > the last assertion. If the variable 'mirror'
> > is invalid, the assertion fails and we return
> > immediately.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
> > ---
> 
> This is not how you send a v4 patch...  v2 patches have to apply to the
> original code and not on top of the patched code.
> 
> I sort of think you should find a different thing to work on.  This code
> works fine as-is.  Just leave it and try to find a real bug and fix that
> instead.
> 
> regards,
> dan carpenter
>

Sorry, I was wrong and I shall send a proper V4.

Yes, this code works fine just a warning caught by Coverity scan analysis. 
So the idea behind the patch is to fix the warning. To do that and as suggested by 
David Sterba, it would be rather to add a default case. So we fix the warning 
through the enhancement of the switch statement (some sort of 2*1).

Yes, I will always try to find other bugs. It is a pleasure for me to do that.

Thanks.
