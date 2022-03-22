Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ED14E4533
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 18:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbiCVRfj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 13:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiCVRfi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 13:35:38 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AA833A1D
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:34:09 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id 10so15006334qtz.11
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3CfGkTByQrA+vOn97otQcuwaiZJQFng8oyCyNbp4xO0=;
        b=UobLnNfRD3J5nuzZ0wPcdb21uCXXwG/7InmwL63BJxpHQyIhHK6JyCPrToGVBI8VRQ
         8+DB+QZNRXkqyPR7Op56DT4tHgJS6EfD37GheZ4NI1L7qE2pm8Un/GFkFBa6n9ylQSWI
         XW6p8/BEbvl4/CNAYjAjogspq5Et5h1jsHv6bLZdegHfV1a2h7ELykDWPf+vfnfQoLvJ
         ObXQQMJvHp0wgwzZvHPtiCZY+emjR+STumMZZUV02lHO1AnJhxy8P1EiiHVTNVDQTXVx
         mEGBSCabvNAnQaZi5mnymwCDVOracaskqIKQz4feLwB+152uAQwhcV8OfbRKOzwIGifA
         IPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3CfGkTByQrA+vOn97otQcuwaiZJQFng8oyCyNbp4xO0=;
        b=zVVLJ4Pn14V/g1TU8VrbxUASHswMZpJAMOSIjmIl7Lu5T+JhDpq619vhfvDpYlheIw
         BUN68WSsN/n9xI9B1B6VqNUwd0Aj425PF9sH1KimHSdrvGNwopZcEmIrOjF3vVx648Vi
         75fryxRLghlEDS1zcvxE3eigXK7XMRfi3W5MpCcVqXIhgD8j6Ora1myqFyLIAMUt5viX
         6fW/p96jYp7XLr9j8jlhae/jpPfz9rIG4rxoezdwr+NHiWTbu4+Z0jG0gGeVoWwf85er
         fW1wDKihsegCjGXHqHC0//i5t5Ji9OhH8vgDshdk1oAsXu56LfBQIjVctEex+Zi/UgI6
         6wCQ==
X-Gm-Message-State: AOAM530y8rdrzjN3m47q7C15J3rG9vQ+Af5OpXyBN7UedRtsobT+3IQJ
        2YkPUzhteI6RR4wLfq2jHBJvWg==
X-Google-Smtp-Source: ABdhPJzDocWcUQdKDy8HwuXE82StPnNzrr8e+qojDuiGJThPUopHMmv3n3udsp8kOktAvvYjz/EsAA==
X-Received: by 2002:ac8:5f12:0:b0:2e0:67f8:132d with SMTP id x18-20020ac85f12000000b002e067f8132dmr21138555qta.417.1647970448819;
        Tue, 22 Mar 2022 10:34:08 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a36-20020a05620a43a400b0067e95f1248asm3362179qkp.45.2022.03.22.10.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 10:34:08 -0700 (PDT)
Date:   Tue, 22 Mar 2022 13:34:06 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 4/5] btrfs: make calc_available_free_space available
 outside of space-info
Message-ID: <YjoIjukH1ZJ5l38A@localhost.localdomain>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
 <c77bf5c2e069891e6885197dbb080f8847bf7b7b.1647878642.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c77bf5c2e069891e6885197dbb080f8847bf7b7b.1647878642.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 21, 2022 at 09:14:13AM -0700, Johannes Thumshirn wrote:
> Make calc_available_free_space available outside of space-info.c and
> rename to btrfs_calc_available_free_space.
> 
> This is a preparation for the next commit and does not impose any
> functional changes.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
