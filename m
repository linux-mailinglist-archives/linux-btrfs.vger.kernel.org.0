Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D00C763711
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 15:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjGZNHk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 09:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjGZNHh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 09:07:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504E41FF3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AZd+dooxkQke2o4wNccvEWmgRpoI+6n+kZkq1ewllM8=; b=Na2A+H2OAn+n2Cc5AG4PT2Ajj6
        UGQjPQedQbE3ItqwLND+uQ21buwHwO72z/YKDccxjeTNOiBZF1ymYb+5BeSnbAYfUzvhuxwUq1qSt
        Cw4786h7NvOoOBZgyWVn5Fn+NLXy/NKD7buFWuFivCrv76R+yu0Jk5BMnxKrQ/5FWzlyawcdKAdhY
        48iOIAhDcB/RLVeTBqMEr5sATrdgp7JfEBDHIo4YavuljnFCZ+Jm5K6sSrWlEOa0pEKmg8IML8bQV
        LDfPOX4TXN5fXhVTjJr4jXPEq3dSgq8CA1RenSVeCwJFHLOW8hFcjcSAhRYxd/g+bArEVsYP5Q4Zf
        FHwJarcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOeEj-00AUg0-0c;
        Wed, 26 Jul 2023 13:07:29 +0000
Date:   Wed, 26 Jul 2023 06:07:29 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/8] btrfs: zoned: reserve zones for an active
 metadata/system block group
Message-ID: <ZMEakUqn+huW7TLy@infradead.org>
References: <cover.1690171333.git.naohiro.aota@wdc.com>
 <df9fa11d7d8299b04b99d7276a764bfa318f5734.1690171333.git.naohiro.aota@wdc.com>
 <ZL6TioS4YxPUJEdg@infradead.org>
 <xv2bbg3ae72huutwcrk3vsuh6tsfajlkfmsg64w6rqa4xkie7e@jdv7rtmw6p7v>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xv2bbg3ae72huutwcrk3vsuh6tsfajlkfmsg64w6rqa4xkie7e@jdv7rtmw6p7v>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 25, 2023 at 09:07:19AM +0000, Naohiro Aota wrote:
> We can convert the profile from SINGLE to DUP while the FS is running. So,
> simply storing it won't work.
> 
> But, we can hook the converting process and increase the reservation count
> if it is converting to DUP? Then, we can calculate it on mount and record
> it in fs_info.

That sounds like the right thing to do to me.
