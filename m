Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BB64F96B5
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 15:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiDHNeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 09:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiDHNeE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 09:34:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4D3118F7D
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Apr 2022 06:32:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D439B215FD;
        Fri,  8 Apr 2022 13:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649424717;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9mQwI1CtkLI3L6B6hfu416pUjGXA7kyQ/Kt0j79Y+V4=;
        b=JfdIM/KpFi21CxjpHWfLEaR7LRXZwcxh0voJS8z6pu04vkg+PC1GhGw1+yUSM3hrZD+BJK
        /ZSf+Ms4vJ7S3V3txtGrcknUC1nh7Z7wVskwFWtG5ZrYccf0S8qqKQtPMQDnkqpOnE4ouG
        8WWbjtX8H5XzQsAJ7YbVaf2ClAN8LG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649424717;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9mQwI1CtkLI3L6B6hfu416pUjGXA7kyQ/Kt0j79Y+V4=;
        b=q+2s6EdoDF1hBdvPs4+D30YC6OysV7vhyriDgrLz/m8bF6xY39AeD/xbJtAXNOPwMh8ueq
        jW0z1mJPbUIhXvBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BE43DA3B82;
        Fri,  8 Apr 2022 13:31:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 02AF3DA80E; Fri,  8 Apr 2022 15:27:53 +0200 (CEST)
Date:   Fri, 8 Apr 2022 15:27:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 07/12] btrfs: move the call to bio_set_dev out of
 submit_stripe_bio
Message-ID: <20220408132753.GP15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20220408050839.239113-1-hch@lst.de>
 <20220408050839.239113-8-hch@lst.de>
 <888b0f4b-0454-fc4e-eb0b-bb047bc12b3f@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <888b0f4b-0454-fc4e-eb0b-bb047bc12b3f@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 08, 2022 at 03:27:21PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/4/8 13:08, Christoph Hellwig wrote:
> > Prepare for additional refactoring.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> The change is small enough and doesn't make much sense by itself.
> 
> Mind to fold it into the patch which needs this change?

Not necessary and I think it's better to make moving the call stand out,
it's the one that's hidden but very important.
