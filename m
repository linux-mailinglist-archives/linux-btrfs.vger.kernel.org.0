Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF283446CB3
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 07:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhKFGGd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Nov 2021 02:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhKFGGc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Nov 2021 02:06:32 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAABAC061570
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 23:03:51 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id n23so10139100pgh.8
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 23:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=52Ihlo8rQr5Y8quEzMpA93uXs+QYzBYqHHA9pqvs2i4=;
        b=L5SSbgbvRVfH68PnU4oX3Hi4FSGCdJwWYJORo2Zmd66DFy0xOE0WQG3CNysjXFkQj1
         IPYzarUmx96h1YZUl/FGSf9GR6PCCRHn6D1jYD7aimhIL7TX+wpNxKENAU4++o20s2Zj
         6Rs7ruCWs8BgAV8QC3Y91f1N4l0qGj4fy+S8jFwQuwzZtPlvYj3apVuHjShWGPJJYgeq
         f/uhg3uvLxRTGw1fKzAyBjZx+eVdtX41h+ovYP0pfUrr1QwsUR1HSdxgcFup7FkZVGvD
         ziiE67Mq3MJ0vjSCxJ7QASiJIb4oqs4ll0e53ttNTXbyzvZR7uSq+z/sgMmXTJ+ClioS
         8rVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=52Ihlo8rQr5Y8quEzMpA93uXs+QYzBYqHHA9pqvs2i4=;
        b=KCmgqRD46l2WcZ643+ARX3p0cVrFTkPnCH2qUKjBbPHeF8rVF/ALzWeFsyFE3W1Ctg
         rWRntZSafeUdewT6oZa2KrvTOjT7g7VymQAMQfyM6zaXhREC3UPAAqzgbeMo/qcdRrc1
         KAEYGQNziwmqJenOjzH4UapgaN6cn8CYGjQijSbAV8/RvH+U2D2HfJR5HtKuyrXzze8z
         o1v4HJJpxH85ZCmq+EaqhEg+NgLBXZMBg9e1xGblSqZW+76PhMFIar7aBIae2CgZZS+j
         yM64yvayHSCZ35RRKvid/rXJOM1UyY52HuuKQUFjStEmQvRfxptsJNKFoHZAI9oOMJZW
         OFhw==
X-Gm-Message-State: AOAM530o0RdjLPQHUA3JaMtk8hDUi1my6gpt4wpZOWQVjgmnEmwvIsuh
        KKGpneZykcO7Eemdc85c+8ojfJc66bnKTA==
X-Google-Smtp-Source: ABdhPJw9MagENm9jVFBSGgTaX73d1cJft9VBPiygYaCm1Ty3kTVtljJuBm8WsH7boIqRLIrpYeAQ4w==
X-Received: by 2002:a63:470b:: with SMTP id u11mr47755045pga.441.1636178631504;
        Fri, 05 Nov 2021 23:03:51 -0700 (PDT)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id a2sm7448294pgn.20.2021.11.05.23.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 23:03:51 -0700 (PDT)
Date:   Sat, 6 Nov 2021 06:03:43 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs-progs: balance: print warn mesg in old command
Message-ID: <20211106060343.GA53099@realwakka>
References: <20211031131011.42401-1-realwakka@gmail.com>
 <20211105160541.ED15.409509F4@e16-tech.com>
 <20211105115036.GH28560@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105115036.GH28560@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 05, 2021 at 12:50:36PM +0100, David Sterba wrote:
> On Fri, Nov 05, 2021 at 04:05:41PM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > This patch broken tests/cli-tests/002-balance-full-no-filters.
> > 
> > becasue this
> > 	printf("WARNING:\n\n");
> >         printf("\tFull balance without filters requested. This operation is very\n");
> > is put after fork() in this patch when '--backgroud';

Thanks, This patch has an issue. I should work on it.
> 
> Right, I ran all the other tests than test-cli. I'll remove the patch
> from 5.15 queue.
