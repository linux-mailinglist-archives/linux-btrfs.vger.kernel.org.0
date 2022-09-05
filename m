Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165115ACB15
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Sep 2022 08:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiIEGgc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 02:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiIEGgI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 02:36:08 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2334E38B4;
        Sun,  4 Sep 2022 23:35:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F320068AFE; Mon,  5 Sep 2022 08:35:39 +0200 (CEST)
Date:   Mon, 5 Sep 2022 08:35:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     dsterba@suse.cz, Zorro Lang <zlang@redhat.com>,
        fdmanana@kernel.org, Christoph Hellwig <hch@lst.de>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: remove 'seek' group from btrfs/007
Message-ID: <20220905063539.GA2092@lst.de>
References: <bc7149309a8eca5999f22477a838602023094cb8.1662048451.git.fdmanana@suse.com> <20220902020030.oho6ssdrdzjy66pw@zlang-mailbox> <20220902094424.GQ13489@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902094424.GQ13489@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 02, 2022 at 11:44:24AM +0200, David Sterba wrote:
> >   commit 6fd9210bc97710f81e5a7646a2abfd11af0f0c28
> >   Author: Christoph Hellwig <hch@lst.de>
> >   Date:   Mon Feb 18 10:05:03 2019 +0100
> > 
> >       fstests: add a seek group
> > 
> > So I'd like to let Christoph help to double check it.
> 
> It's quite obvious from the test itself that it tests only send/receive,
> which is mentioned in the changelog. The commit adding the seek group
> does not provide any rationale so it's hard to argue but as it stands
> now the 'seek' group should not be there.

Probably.  Unless it somehow exercised seeks through the userspace
seek code I can't see any good rationale for this addition, and the
patch was far too long ago for me to remember.
