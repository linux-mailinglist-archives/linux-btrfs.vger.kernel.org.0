Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7006C74D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 02:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCXBCD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 21:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCXBCC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 21:02:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A99298EB
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Mar 2023 18:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JJiQUhIgwuts3z4fJ0tATfGpbsRwh0wl4nsWodAtcF8=; b=qk898iHjFZGOHPTymXWEZIL5HC
        Fr9NrvVkvAK1QklMqMohXZJQ8XEobSHi1ensX1L2Mt7rTt8SpHAX9tCwAw3cMxalBwCn7eoDgTqEe
        nQ+uGZZXEmUnssBcZiUgAZMsDcwZZarF+1xxU17Bd/jpQ4Gz1OPvbEWpPp/I4cxzdCI90Xs4dZtpa
        2geC0eZP5A4dagQIm34B7sdrarI8OTN38uT2rpfaBA3J4bsXPIdTnhNSufiCKOffxUneKwa3Mr/1i
        11dqo4ubkDykOwDDnawvtoRMv6HWsL1f6DCnRo4QYx/WKUNWdn4KrPKgQU1BxLwCXam1aCt6EYJ2Z
        BLqxzcJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pfVoc-003IF7-0P;
        Fri, 24 Mar 2023 01:01:58 +0000
Date:   Thu, 23 Mar 2023 18:01:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Ryskalczyk <david@rysk.us>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Kernel panic due to stack recursion when copying data from a
 damaged filesystem
Message-ID: <ZBz2hvO/NRqVZhvQ@infradead.org>
References: <E567648E-DEE9-49EB-8B01-3CE403E4E87C@rysk.us>
 <b9ed921a-2cd2-411a-4374-c7682b56c45e@gmx.com>
 <ZBwC7n9crUsk4Pfi@infradead.org>
 <9628f5a7-2752-4f74-70e1-f8efd345bdc7@gmx.com>
 <ZBwJQcvt2TcqoCRh@infradead.org>
 <2F36C097-7549-49D8-8C70-C254A93FAC74@rysk.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2F36C097-7549-49D8-8C70-C254A93FAC74@rysk.us>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 23, 2023 at 09:17:49AM -0400, David Ryskalczyk wrote:
> 
> > On Mar 23, 2023, at 3:42 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> > What is interesting above is that it tries to recover from 4 mirrors,
> > which seems very unusual.  I wonder if something went wrong
> > in btrfs_read_extent_buffer or btrfs_num_copies.
> 
> This filesystem has metadata set to raid1c4, so 4 mirrors would be expected.
> All mirrors likely have identical damage, as the cause of the corruption was RAM issues leading to bitflips.

Any chance you could try 6.3-rc3 or the latest Linus tree on this
file system?
