Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AFF544C37
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 14:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245198AbiFIMgP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 08:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245479AbiFIMgN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 08:36:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87FA22BDE
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 05:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wBSgtsx5slcSTW2KsjMgLEFNd7Ur2Tu3G3a/elprB+U=; b=ZI+i8P6h+5IBzj6AR2Gc94T7gB
        QbCeXQmUvSXmP1JFGAA1voPT3vgoXzcnoOrGxLJjD9sa4c/Zp8Uq1658vxan/xVPgrPY2cX2AxK/v
        riu7QjdZsHLuvyaMm5rKvMF7TxJA+MEKiLFGi9uwfUJyIsA4+qPfPzdkIIRyF8FMr8a+Alkzx9Jfj
        iW9huYT22m8PsJ/fOEpAIoG+5BLcR3PB5hsN1P/Bus3JcM1EOg0T030VQ1zkp9AQTXA9iKRmZIQ+S
        nqX49z1MPk57Vxy3WXLMvGjX8zChnHW93Scqj6waZdP62AdmqckghGCgTVJ3vxQYmeEuKFbCoQqOJ
        THeuHNUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzHOT-00DYAI-Hj; Thu, 09 Jun 2022 12:36:09 +0000
Date:   Thu, 9 Jun 2022 13:36:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use preallocated page for super block write
Message-ID: <YqHpOSWedxnjPWfP@casper.infradead.org>
References: <20220607154229.9164-1-dsterba@suse.com>
 <1c8faef3-6ccb-6eb8-6f42-d52faf8f74e1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c8faef3-6ccb-6eb8-6f42-d52faf8f74e1@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 09, 2022 at 10:30:06AM +0300, Nikolay Borisov wrote:
> nit: I think it's important to remark in the changelog that with this change
> sb writing becomes sequential as opposed to parallel with the old code. This
> also means that wait_dev_supers can be simplified because the max_mirror's
> loop is not needed, at least for waiting, since for each device we at most
> need to wait for the last write to it, as all previous ones have been
> serialized by the pagelock.

I've just re-read the patch very carefully three times, and I don't
see the change that makes this happen.  Can you explain to me how it
happens?
