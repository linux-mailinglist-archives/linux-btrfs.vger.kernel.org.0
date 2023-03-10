Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E5B6B3853
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 09:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCJIP2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 03:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjCJIP0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 03:15:26 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09952EBAC8
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 00:15:14 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F09CD6732D; Fri, 10 Mar 2023 09:15:09 +0100 (CET)
Date:   Fri, 10 Mar 2023 09:15:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/20] btrfs: simplify extent buffer reading
Message-ID: <20230310081509.GA15515@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-6-hch@lst.de> <52d760f4-dec8-7162-40b7-4f0be14848b8@gmx.com> <20230310074723.GA14897@lst.de> <17c86afa-41af-a8d4-094e-81f1d47e8788@gmx.com> <20230310080331.GA15272@lst.de> <3f4ec877-4d19-80a8-1dcd-84fbdbd54745@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4ec877-4d19-80a8-1dcd-84fbdbd54745@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 10, 2023 at 04:07:42PM +0800, Qu Wenruo wrote:
> Yes, but you don't need to spend too much time on that.
> We haven't hit such case for a long long time.
>
> Unless the fs is super old and never balanced by any currently supported 
> LTS kernel, it should be very rare to hit.

Well, if it is a valid format we'll need to handle it.  And we probably
want a test case to exercise the code path to make sure it doesn't break
when it is so rarely exercised.
