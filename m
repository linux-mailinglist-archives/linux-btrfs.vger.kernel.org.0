Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6A26C74E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 02:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCXBLu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 21:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCXBLt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 21:11:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AC62B609
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 18:11:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D41E68B05; Fri, 24 Mar 2023 02:11:38 +0100 (CET)
Date:   Fri, 24 Mar 2023 02:11:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Message-ID: <20230324011138.GC12152@lst.de>
References: <20230314165910.373347-4-hch@lst.de> <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com> <20230320123059.GB9008@lst.de> <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com> <20230321125550.GB10470@lst.de> <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com> <20230322083258.GA23315@lst.de> <bbcb7c0b-42e7-4480-abec-5ffe13ec7255@gmx.com> <20230323081237.GA21669@lst.de> <6b1d2d63-ef00-3c6c-8bea-481e46b6fcef@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b1d2d63-ef00-3c6c-8bea-481e46b6fcef@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 04:20:45PM +0800, Qu Wenruo wrote:
> I'm just wondering if we all know that we should avoid cross-workqueue 
> dependency to avoid deadlock, then why no one is trying to expose any such 
> deadlocks by simply limiting max_active to 1 for all workqueues?

Cross workqueue dependencies are not a problem per se, and a lot of
places in the kernel rely on them.  Dependencies on another work_struct
on the same workqueue on the other hand are a problem.

> Especially with lockdep, once we got a reproduce, it should not be that 
> hard to fix.

lockdep helps you to find them without requiring to limit the max_active.
