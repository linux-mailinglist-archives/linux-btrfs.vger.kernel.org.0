Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78365561B0C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jun 2022 15:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiF3NKr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jun 2022 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiF3NKq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jun 2022 09:10:46 -0400
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 395462655C
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 06:10:43 -0700 (PDT)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id A6C2920D70
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 22:10:42 +0900 (JST)
Received: by mail-pl1-f197.google.com with SMTP id l6-20020a170902f68600b0016a36fb2c9aso10271082plg.2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jun 2022 06:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KXHvFJE+Ra1Ta2VHsFr1xKZy6p8ZRnSJx8lAp3hz1zo=;
        b=5ESp1GJGds0nU5+xzkAeek2MvyqzmytpfDItU5h+pfQt/qLY7/JZjIijsH0PtfvCPo
         BofWhIQ/jzUd4VM4Q4nBdiXt5Pm8fHF4o1+uzRTQZti0hYzq1kIxtKcKfnotcZEWialj
         grDWLvpqM29cTawS/AsV8itqVXw2ogcvMC/6Erq8ncUGZBHbqsIVVr/sfLQSy3nBEpX3
         UeQdoCojM0/hWBGOtVRQeblhegO3ThDq0F+cOi9B+0DeFwhlbpJZ5zYaVnFjrAGe1tQj
         ad5bUhgOkimiK0JNyRFOHhBWFhDXk92nDUwY01LuZ1kzYVwJjCHWe9WFkbemKipSWUnH
         0K+g==
X-Gm-Message-State: AJIora+U/LbHX9Yt6NAQugQPm/WZi9YMucthRO54OGafKisNy4ONvX+E
        rD2YNzJHz08UjR0D5F9PicK/6e52PaWB61uhdRZTAmSoP5hLGTQDZoYIEU+aiD+QAQQ60AjSFaN
        w2AUz5qK1lr9ltOg/7mxD2ND1
X-Received: by 2002:a65:5a42:0:b0:411:bf36:eeec with SMTP id z2-20020a655a42000000b00411bf36eeecmr617419pgs.522.1656594641704;
        Thu, 30 Jun 2022 06:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tMjKrlMY81Wg5EQjBFVsz+y9WcW1EPe860eX3wq9j49Vm6Pnuflkj6Pk8bucdksCmDfNFfmw==
X-Received: by 2002:a65:5a42:0:b0:411:bf36:eeec with SMTP id z2-20020a655a42000000b00411bf36eeecmr617405pgs.522.1656594641501;
        Thu, 30 Jun 2022 06:10:41 -0700 (PDT)
Received: from pc-zest.atmarktech (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090a64cc00b001eccb13dfb0sm1913575pjm.4.2022.06.30.06.10.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2022 06:10:41 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.95)
        (envelope-from <martinet@pc-zest>)
        id 1o6tuG-0007Ng-Ib;
        Thu, 30 Jun 2022 22:08:28 +0900
Date:   Thu, 30 Jun 2022 22:08:18 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Nikolay Borisov <nborisov@suse.com>, Jens Axboe <axboe@kernel.dk>,
        io-uring@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: read corruption with qemu master io_uring engine / linux master
 / btrfs(?)
Message-ID: <Yr2gQh5GaVmTEDW2@atmark-techno.com>
References: <bd342da1-8c98-eb78-59f1-e3cf537181e3@suse.com>
 <dd55e282-1147-08ae-6b9f-cf3ef672fce8@suse.com>
 <YrueYDXqppHZzOsy@atmark-techno.com>
 <Yrvfqh0eqN0J5T6V@atmark-techno.com>
 <20220629153710.GA379981@falcondesktop>
 <YrzxHbWCR6zhIAcx@atmark-techno.com>
 <Yr1XNe9V3UY/MkDz@atmark-techno.com>
 <20220630104536.GA434846@falcondesktop>
 <Yr2ItqlxeII0sReD@atmark-techno.com>
 <20220630125124.GA446657@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220630125124.GA446657@falcondesktop>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe Manana wrote on Thu, Jun 30, 2022 at 01:51:24PM +0100:
> > Please ask if there's any infos I could get you.
> 
> Ok, maybe it's page fault related or there's something else besides page faults
> involved.
> 
> Can you dump the subvolume tree like this:
> 
> btrfs inspect-internal dump-tree -t 5 /dev/sda 2>&1 | xz -9 > dump.xz
> 
> Here the 5 is the ID of the default subvolume. If the test file is on
> a different subvolume, you'll need to replace 5 with the subvolume's ID.

Sure thing.

It's 2MB compressed:
https://gaia.codewreck.org/local/tmp/dump-tree.xz


> This is just to look at the file extent layout.
> Also, then tell me what's the inode number of the file (or just its name,
> and I'll find out its inode number), and an example file offset and read
> length that triggers a short read, so that I know where to look at.

There's just a single file in that subvolume, inode 257

> And btw, that dump-tree command will dump all file names, directory names
> and xattr names and values (if they are human readable) - so if privacy is
> a concern here, just pass --hide-names to the dump-tree command.

(thanks for the warning)
-- 
Dominique
