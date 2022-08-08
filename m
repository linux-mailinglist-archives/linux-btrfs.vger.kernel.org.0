Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACDF58C37F
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 08:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbiHHGr5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 02:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbiHHGrg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 02:47:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E386312AC1
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Aug 2022 23:47:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E964968AA6; Mon,  8 Aug 2022 08:47:09 +0200 (CEST)
Date:   Mon, 8 Aug 2022 08:47:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/11] btrfs: don't call bioset_integrity_create for
 btrfs_bioset
Message-ID: <20220808064709.GA25082@lst.de>
References: <20220806080330.3823644-1-hch@lst.de> <20220806080330.3823644-2-hch@lst.de> <cf1e829d-bbe7-8948-0de4-a2d6cd774de8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf1e829d-bbe7-8948-0de4-a2d6cd774de8@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 08, 2022 at 01:06:29PM +0800, Anand Jain wrote:
>  This patch is a revert of the commit b208c2f7ceaf ("btrfs: Fix crash due 
> to not allocating integrity data for a set"). So nowadays, integrity data 
> pool allocation is not mandatory?

Yes, the bio-integrity code now handles allocating the integrity
payload without that.

>  Why not complete the support of bio integrity metadata instead?

That is very much an unrelated and complex feature.

Where would you store the t10-pi style checksums in btrfs?  Note that
they are different algorithms from those currently supported by btrfs.
