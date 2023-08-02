Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EAF76C972
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Aug 2023 11:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjHBJ0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 05:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjHBJ0f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 05:26:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A970EE7
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 02:26:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 709946732D; Wed,  2 Aug 2023 11:26:31 +0200 (CEST)
Date:   Wed, 2 Aug 2023 11:26:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
        Chris Mason <clm@fb.com>
Subject: Re: btrfs write-bandwidth performance regression of 6.5-rc4/rc3
Message-ID: <20230802092631.GA27963@lst.de>
References: <20230801235123.B665.409509F4@e16-tech.com> <20230801155649.GA13009@lst.de> <20230802080451.F0C2.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802080451.F0C2.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 02, 2023 at 08:04:57AM +0800, Wang Yugui wrote:
> > And with only a revert of
> > 
> > "btrfs: submit IO synchronously for fast checksum implementations"?
> 
> GOOD performance when only (Revert "btrfs: submit IO synchronously for fast
> checksum implementations") 

Ok, so you have a case where the offload for the checksumming generation
actually helps (by a lot).  Adding Chris to the Cc list as he was
involved with this.

> > > -       if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
> > > +       if ((bbio->bio.bi_opf & REQ_META) && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
> > >                 return false;
> > 
> > This disables synchronous checksum calculation entirely for data I/O.
> 
> without this fix, data I/O checksum is always synchronous?
> this is a feature change of "btrfs: submit IO synchronously for fast checksum implementations"?

It is never with the above patch.

> 
> > Also I'm curious if you see any differents for a non-RAID0 (i.e.
> > single profile) workload.
> 
> '-m single -d single' is about 10% slow that '-m raid1 -d raid0' in this test
> case.

How does it compare with and without the revert?  Can you add the numbers?
