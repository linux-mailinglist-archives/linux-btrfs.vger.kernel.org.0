Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC799715525
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 07:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjE3Fpz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 01:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjE3Fpy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 01:45:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2905CE5
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 22:45:53 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9EA0568B05; Tue, 30 May 2023 07:45:47 +0200 (CEST)
Date:   Tue, 30 May 2023 07:45:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH 08/16] btrfs: stop setting PageError in the data I/O
 path
Message-ID: <20230530054547.GA5825@lst.de>
References: <20230523081322.331337-1-hch@lst.de> <20230523081322.331337-9-hch@lst.de> <20230529175210.GL575@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529175210.GL575@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 29, 2023 at 07:52:10PM +0200, David Sterba wrote:
> On Tue, May 23, 2023 at 10:13:14AM +0200, Christoph Hellwig wrote:
> > PageError is not used by the VFS/MM and deprecated.
> 
> Is there some reference other than code? I remember LSF/MM talks about
> writeback, reducing page flags but I can't find anything that would say
> that PageError is not used anymore. For such core changes in the
> neighboring subysystems I kind of rely on lwn.net, hearsay or accidental
> notice on fsdevel.
> 
> Removing the Error bit handling looks overall good but I'd also need to
> refresh my understanding of the interactions with writeback.

willy is the driving force behind the PageErro removal, so maybe he
has a coherent writeup.  But the basic idea is:

 - page flag space availability is limited, and killing any one we can
   easily is a good thing
 - PageError is not well defined and not part of any VM or VFS contract,
   so in addition to freeing up space it also generally tends to remove
   confusion.
