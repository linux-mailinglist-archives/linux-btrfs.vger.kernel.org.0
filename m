Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FCC53635D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 15:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352304AbiE0Nh3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 09:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiE0Nh2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 09:37:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE88115CAC;
        Fri, 27 May 2022 06:37:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id ECB0C68AFE; Fri, 27 May 2022 15:37:23 +0200 (CEST)
Date:   Fri, 27 May 2022 15:37:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/10] btrfs: test direct I/O read repair with
 interleaved corrupted sectors
Message-ID: <20220527133723.GA23998@lst.de>
References: <20220527081915.2024853-1-hch@lst.de> <20220527081915.2024853-11-hch@lst.de> <eae19028-784b-92b4-d032-331aa4b21bfe@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae19028-784b-92b4-d032-331aa4b21bfe@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 27, 2022 at 06:23:13PM +0800, Qu Wenruo wrote:
>> +# step 2, corrupt 4k in each copy
>
> I guess you mean 64K?

Yes.  Same for btrfs/266.
