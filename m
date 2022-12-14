Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585CD64CE8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Dec 2022 18:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbiLNRBw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 12:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239207AbiLNRBv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 12:01:51 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EC625285
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 09:01:50 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c7so2949414qtw.8
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 09:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GYvItGFJqOegD+hPJVF+rnBaOe478OAlktW60GT1thQ=;
        b=Fj8gufc32+gau9B4yjpIVT3zb8/ngGL1id2apqgoLYwIvRbKBTzeg0F2kSZyFg5bnb
         22QF4rnA5Rf38+r5M9nbeMieLf5I2MwJarIf5mDZaVvAbGtAeyIxRW3T2+rxKS+9/Vyv
         hSPRPy2/UDTRkScsDDMlGmNv2pebtrMauhMJ4kucUfNRgAmEUqOqJHxya6i9c2+eWUaf
         xtsBIanzIHTcIEtp7pTjqnNN48R0xaGXYaRBgeta2CB93fLWr+x0ulk/8cZ1yPS2SrQo
         MwQ9VLXtkd4qM8N3V69txFPFIDBlWQoQOYi+TRxzvU0HLM0v9N7YD90Ep+mEKfPgGwz8
         z7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYvItGFJqOegD+hPJVF+rnBaOe478OAlktW60GT1thQ=;
        b=knrYiv1Bb/IuS69ifHA5acIMqgK9BZEaE1mJyf0poijX1cHrcoZ1/MU/J5y5h/SV9p
         RwWSttkbBpSisHUYFiHI/KJtyzfCwC3+IuFiYYuDUk1aEO9fTEK77rH+G+SmY9Pzn64X
         Jm7mN45Kl1k4hupF5FnlrZyS8G0iUupbcJYMyIu4vs9BlCO2WwltDAawmj878sIRvhdj
         f+tQ0tvl70IEmGZYXiDhSe7pHz8/80Jr7bZtW0OvnUcvpF3daWUyJguly2iLoAulz3md
         xUgVFqh3lFJuOGfiS9FiC437yFxeNgMUXcCGmKczpkgqfaWszlB3E6224AUq1oMq5OJ0
         cyiA==
X-Gm-Message-State: ANoB5plCNkSlL5E/r1jD5Gtbk0ubpS6ge9sRUAGSWITpWAuMh4HBmktA
        5//GFeM3aXZeLwnJchUpLAdb4Q==
X-Google-Smtp-Source: AA0mqf7PEMpTu2ttbi/jD59EncTehY1amqVI+yebdl/I+DOM8yWCf0yqKo2BAISV7oRiwSnf5CFwRw==
X-Received: by 2002:ac8:1345:0:b0:3a7:ef31:a07b with SMTP id f5-20020ac81345000000b003a7ef31a07bmr32802228qtj.11.1671037309569;
        Wed, 14 Dec 2022 09:01:49 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x8-20020ac84d48000000b00398a7c860c2sm1974526qtv.4.2022.12.14.09.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 09:01:48 -0800 (PST)
Date:   Wed, 14 Dec 2022 12:01:46 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] btrfs; rename the disk_bytenr in strut
 btrfs_ordered_extent
Message-ID: <Y5oBek81Aepf84bZ@localhost.localdomain>
References: <20221212073724.12637-1-hch@lst.de>
 <20221212073724.12637-3-hch@lst.de>
 <Y5d5vuENR9vIltLs@localhost.localdomain>
 <20221213140849.GB24075@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213140849.GB24075@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 13, 2022 at 03:08:49PM +0100, Christoph Hellwig wrote:
> On Mon, Dec 12, 2022 at 01:58:06PM -0500, Josef Bacik wrote:
> >         /*                                                                                                                            
> >          * These fields directly correspond to the same fields in                                                                     
> >          * btrfs_file_extent_item.
> >          */
> > 
> > which with this change is no longer true.  Please update the comment
> > appropriately, other than that the change is reasonable to me, you can add
> 
> Ok.  Or should we skip this patch and stick to the on-disk naming
> even if it is a bit confusing?

My preference is to leave it, but generally for these things I defer to
outsiders, just because I'm used to it doesn't mean it's right.  In this case
because it maps to the on-disk naming I'd rather leave it unless you feel
strongly.  Thanks,

Josef
