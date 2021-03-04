Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB56332CD62
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Mar 2021 08:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbhCDHKz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Mar 2021 02:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbhCDHKw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Mar 2021 02:10:52 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0399C061760
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Mar 2021 23:10:11 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id s23so6237298pji.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Mar 2021 23:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AeihSpJXX9lCKiqylX0kP4DDHGMNjeTAdUfEN6WQrhE=;
        b=qsS8FBxUN27KvoeZY2otdvMvSoCnVvfPRK/jY6yrMZZiGb2R7ebwV3CYDs05wq4qud
         7aK5ZJxOpiBeeMiumyV+qVgmBTh2pNKuuVsKD32IKAYlIWhNcbFdvXaGGYRnIuEEplGM
         VdZxs4pDnDLs6RHtwLUzR2/WGA5vO56C9INOIX+RrudmzgdjL323y79ho165ekl2LsGm
         WY0RqTSyh1sMVsWCuWdNGDyo/13GdtS+O0gR7rdO5keKDBPWVoWxHTxv1bAzbMXxMRRm
         jcy2j28q7KKWjWn222ODSgqLUu0q6QSqHtjq6Y4YHkvSYo0nYUq2q3+0J5b28YdgUDPB
         ETpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AeihSpJXX9lCKiqylX0kP4DDHGMNjeTAdUfEN6WQrhE=;
        b=gkFvVfPqBliFE0UBwJPW4pBWvVxCZnRj6UD6gN/HiQaVGP0jSLByDaYnHgruhThD2g
         EpXMF+m+cOxLAifZ2NMll8N8qmU+y8R6jVupr3COkdFzw0cFfwheKkcHvMypri3nLAs+
         MWCNFJGlAZrEl9etUIlEq4CL794L9+YxzvpYRxrW+taG4ey8FWZmJXFpUBN9C2dSjr1j
         fF3j3g/YE+sdfuGrsey1kWJNugmfiSwjCfnHHaCYBfTg0NNsm6pjyqHApzLjTqQeg8/1
         C2EW14pHlsbX9ZPLshWfGjcr6Ymlib4uxamdEi71G7d8ey5H2RxUYh3Ctv6rJvGfkYkl
         l89g==
X-Gm-Message-State: AOAM5301gHuR6WoAv0qPHPvRnM0zZRzDfcLZ8RgqVIukm2wfoFX697y2
        sAOEvyMX99CifstQoRaaBmX5XG2tEfPw3w==
X-Google-Smtp-Source: ABdhPJwCWZ8oZJfXV2liwQIpQpeDY1oRE4Zb3SMgGgYN+7e0Ciq9sID9vqqBPkroaoyWV8AKUGbLug==
X-Received: by 2002:a17:90a:2f22:: with SMTP id s31mr3001976pjd.99.1614841811571;
        Wed, 03 Mar 2021 23:10:11 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id w25sm26612027pfn.106.2021.03.03.23.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 23:10:11 -0800 (PST)
Date:   Thu, 4 Mar 2021 07:10:04 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: docs: add seeding device section for
 btrfs-man5
Message-ID: <20210304071004.GA1159@realwakka>
References: <20210214171738.23919-1-realwakka@gmail.com>
 <20210301205746.GE7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301205746.GE7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 01, 2021 at 09:57:47PM +0100, David Sterba wrote:
> On Sun, Feb 14, 2021 at 05:17:38PM +0000, Sidong Yang wrote:
> > This patch adds a section about seeding device for btrfs-man5.
> > Description and examples are from btrfs-wiki page.
> 
> Sorry, but the contents of the wiki page are useless as documentation.
> There's no explanation of the usecase just a bunch of commands.
> Meanwhile I've written something that I consider good enough for
> documenation, it's now in devel. Feel free to proofread it and enhance
> with additional updates or examples if you think they're missing.

Okay, thanks for review.

Thanks,
Sidong
