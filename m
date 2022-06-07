Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA3B53F5FA
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 08:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiFGGQa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 02:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiFGGQ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 02:16:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C7FD7723
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jun 2022 23:16:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F21DB68AFE; Tue,  7 Jun 2022 08:16:22 +0200 (CEST)
Date:   Tue, 7 Jun 2022 08:16:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: simple synchronous read repair v2
Message-ID: <20220607061622.GA9258@lst.de>
References: <20220527084320.2130831-1-hch@lst.de> <20220606212500.GI20633@twin.jikos.cz> <dcddfea0-ca0b-c59a-187b-34534509c538@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcddfea0-ca0b-c59a-187b-34534509c538@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 07, 2022 at 06:53:35AM +0800, Qu Wenruo wrote:
> OK, although I'd say, considering the latest read-repair test,

What is the latest read repair test?

> we may
> want to simply the write part, to only write the data back to the
> initial mirror.

Why would we not write back the correct data to all known bad mirrors?
