Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D6733FD2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 03:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhCRCWv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 22:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhCRCW2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 22:22:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA30C06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 19:22:28 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j25so2432244pfe.2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Mar 2021 19:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TGgQZQU+8sbQ5/aAdrgi6EODbW//Nnppo0uXJCUoFEQ=;
        b=PmydZvH4DDdFd5lms2AKCVgL9k8z3stVLhr2Os8VZqKpT+1VZUezGhjEbHZ6iTZ3Bv
         h7ZAl/sCavgR+2YvAsbM/6DCWH9mFdKcuzjX2hVpQvLycxhSc3aOnFSG3p1XKJzYFbK4
         MryhkB+3NCcfrrB1Y86F7nnT1TM87KOaNR901UuNgI+sMQSlyMqVnvdQhTooYYwlpLHx
         6C5bCj21aFuQmfsI4Myyun2xKR87tljPZKdMcCKwVR0kmZ5erP6HU8NXemn8RTsNxumc
         fC17SbukLdbAV+p21bEktpwuTfayRG1X/IrUhlT2QPWGsoo4ZI1mN6meBRK3rQTNkKJg
         6/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TGgQZQU+8sbQ5/aAdrgi6EODbW//Nnppo0uXJCUoFEQ=;
        b=oBroECNNJaxwNhfRbBqpYJDxtLNmMFn8VFOdT4+1FxlIXh+4aFWimhZ0FHZjES4S9i
         q3EhA4x7Wnlwz3/FAt62jh94V9GCzBA3ZZOZ7y+V4y2GK1k19bGyQP0rIY9DvpYmu8FR
         qu/5U7xkAoxgzb3VofWwwKg2iFwyXjEg51ddc9aCyinW6v9a4aslJht5f3SMq1buw7Qu
         +kDGX/k7JHAQ7PMZgpHPw2RWsqrurMZ8KPxVZKY2VCKQ9BI77P3AmLVuN92pEAD+0Vnm
         aWHYbvAzUIvU8fqjaH91VtqSsp5HgTF3WCleIbh+DZ+8/jqjgChQNTfn1cwrVvYwf+F1
         T3BA==
X-Gm-Message-State: AOAM5315YnQlw15DhyyjKoVx2xO9KKrW4g3POwBg6PprZ3SI9rMNirx6
        YN7pBj7pQp4zDwpUMgrOuyFQz1TSu6ifDw==
X-Google-Smtp-Source: ABdhPJxdbpNfSj403kOVeYfO7br1dBVI0iEbUgOVZpKMkO+653dCbB1swCSIG7i2pG3Lol+rm311vw==
X-Received: by 2002:aa7:858e:0:b029:1f1:5df2:1f70 with SMTP id w14-20020aa7858e0000b02901f15df21f70mr1841538pfn.46.1616034147647;
        Wed, 17 Mar 2021 19:22:27 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id t12sm317836pga.85.2021.03.17.19.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 19:22:27 -0700 (PDT)
Date:   Thu, 18 Mar 2021 02:22:20 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2] btrfs-progs: common: make sure that qgroup id is in
 range
Message-ID: <20210318022208.GA34562@realwakka>
References: <20210316132746.19979-1-realwakka@gmail.com>
 <20210317183647.GW7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317183647.GW7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 17, 2021 at 07:36:47PM +0100, David Sterba wrote:
> On Tue, Mar 16, 2021 at 01:27:46PM +0000, Sidong Yang wrote:
> > When user assign qgroup with qgroup id that is too big to exceeds
> > range and invade level value, and it works without any error. but
> > this action would be make undefined error. this code make sure that
> > qgroup id doesn't exceed range(0 ~ 2^48-1).
> 
> Should the level be also validate? The function parse_qgroupid does not
> do full validation, so eg 0//0 would be parsed as a path and not as a
> typo, level larger than 64K will be silently clamped.

I agree. 0//0 would be parsed as path but it failed in
btrfs_util_is_subvolume() and goes to err. I understand that upper 16
bits of qgroupid is for level. so, The valid llevel range is [0~2^16-1].
But I can't get it that level larger than 64K will be clampled. 

one more question about that, I see that the ioctl calls just store the
qgroupid without any opeartion with level. is the level meaningless in
kernel?
