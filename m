Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C989721EFE
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 09:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjFEHKo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 03:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjFEHKM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 03:10:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0236610C
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 00:09:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 77DCE68AA6; Mon,  5 Jun 2023 09:09:05 +0200 (CEST)
Date:   Mon, 5 Jun 2023 09:09:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [linux-next:master 6080/6849] fs/btrfs/volumes.c:6412
 btrfs_map_block() error: we previously assumed 'mirror_num_ret'
 could be null (see line 6250)
Message-ID: <20230605070905.GC15651@lst.de>
References: <14e5f928-5395-4cc4-90ff-8223ef857320@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14e5f928-5395-4cc4-90ff-8223ef857320@kadam.mountain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 02, 2023 at 05:04:37PM +0300, Dan Carpenter wrote:
> Hi Christoph,
> 
> This is just a rename function so the warning is older but I didn't
> send this email before.

Yeah.  The old version is my fault as well :)

It is not a bug as all callers that set smap pass in the mirror_num_ret
as well, but it definitively isn't very maintainable code.  I see what
I can do.

