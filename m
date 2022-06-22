Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C3155418B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 06:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiFVEYF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 00:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344959AbiFVEYC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 00:24:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71B734B91
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jun 2022 21:23:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B768F68AA6; Wed, 22 Jun 2022 06:23:35 +0200 (CEST)
Date:   Wed, 22 Jun 2022 06:23:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: repair all bad mirrors
Message-ID: <20220622042335.GB21099@lst.de>
References: <20220619082821.2151052-1-hch@lst.de> <b633dedf-b322-2d8c-adfb-8ab88af5652e@suse.com> <20220621154653.GA10068@lst.de> <3971f947-aeec-98c0-dca1-a90016f67dd5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3971f947-aeec-98c0-dca1-a90016f67dd5@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 21, 2022 at 08:49:09PM +0300, Nikolay Borisov wrote:
>
> My point is won't this loop ever fix at most 1 mirror? Consider again 
> raid1c4, where the 4th copy is the good one. First we read from 0 -> bad we 
> submit io to mirror 1 (orig_mirror = 0, this_mirror=1). The same thing is 
> repeated until we get to orig_mirror = 3, this_mirror =4. This time the 
> repair would be completed and so for this_mirror = 4 we'll execute 
> clean_io_failure in which case the do{} while() loop will only fix the bad 
> copy for mirror 3.

For this case ->orig_mirror is set to 0 if that was the first bad mirror.
The do {} while loop then walks back until it repaired org_mirror, tha
s 0, and breaks after that.  The impotant bit is that unlike in the code
before this patch orig_mirror/failed_mirror is not reset for every new failure.
