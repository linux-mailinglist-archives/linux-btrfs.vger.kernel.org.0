Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA6C51C378
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 May 2022 17:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242737AbiEEPMI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 May 2022 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiEEPMH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 May 2022 11:12:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932C438BDA
        for <linux-btrfs@vger.kernel.org>; Thu,  5 May 2022 08:08:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F09DE68AA6; Thu,  5 May 2022 17:08:25 +0200 (CEST)
Date:   Thu, 5 May 2022 17:08:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 04/10] btrfs: split btrfs_submit_data_bio
Message-ID: <20220505150825.GC19810@lst.de>
References: <20220504122524.558088-1-hch@lst.de> <20220504122524.558088-5-hch@lst.de> <4b4e9991-3c1b-6758-3e1d-c6aafac61c13@gmx.com> <20220504140851.GA17969@lst.de> <b9283134-54b4-5a9a-f8c4-099cdb5df6fb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9283134-54b4-5a9a-f8c4-099cdb5df6fb@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 05, 2022 at 06:41:50AM +0800, Qu Wenruo wrote:
> OK, that sounds good.
>
> Just a little worried about how many series there still are...

A lot.  There is so much fairly low hanging fruit in the btrfs I/O path,
and with Dav preferring series of about 10 patches that means it will
be quite a few.
