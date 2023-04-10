Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD146DC9E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Apr 2023 19:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjDJRSA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Apr 2023 13:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjDJRR6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Apr 2023 13:17:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4341A210D
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Apr 2023 10:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0thVgOKWRl+cFLkLMj3+qmpKIpyeolHc9SWxnDWcSts=; b=a17Tw1vK1jrQWbagUHcO1mW7b7
        n3BjZXzjSKgT2Ky577NXeRow9B4E0umE3uEiO8suMAlyJfYhCPx6eDKCH9aa6eTIhc1ceAvJJbL2P
        /sZxzrt/AsvmZJ4+DlEeTVL3Q48qLOoJHOBuZnqIL2UZfVMx0MLGFQLJrE+ewNFTK381dqv88vpUB
        4ZUA7sWmOry4Z4RVFZyLIaRYvCFXMsvMI6ojC/cCHhCD3ImrQmVOpC29c8aMxJZHQTqhCM/OQhK+e
        PK9NM55dJb9SmkWm7XctBmCB2geYzqXUSIUy03EFwkW8+oqaOjJJZVBEAO8GpyI9CBYcG6u8pWMsx
        r862hP/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1plv9J-00Fcrl-0i;
        Mon, 10 Apr 2023 17:17:49 +0000
Date:   Mon, 10 Apr 2023 10:17:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: don't offload CRCs generation to helpers if it is fast
Message-ID: <ZDREvSPL3ePYAx4X@infradead.org>
References: <20230329001308.1275299-1-hch@lst.de>
 <20230405231455.GO19619@twin.jikos.cz>
 <ZC5XPqC9+us0sLPX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC5XPqC9+us0sLPX@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 05, 2023 at 10:23:10PM -0700, Christoph Hellwig wrote:
> On Thu, Apr 06, 2023 at 01:14:55AM +0200, David Sterba wrote:
> > > This series implements that and also tidies up various lose ends around
> > > that.
> > 
> > I've picked patch 1 as it's a standalone fix and should go to stable
> > trees, the rest is in for-next and still queued for 6.4.
> 
> So the usual question:
> 
>  - should I resend the series with a commit log that you're prefer?
>  - or just deliver a new commit log?
>  - or are you just going to fix it up?

Dave, can you help me on how you want me to proceed here?
