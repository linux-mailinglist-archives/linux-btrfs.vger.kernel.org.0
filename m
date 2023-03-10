Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80D56B3E61
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 12:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCJLug (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 06:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCJLud (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 06:50:33 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70226C97C0
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 03:50:32 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E18D367373; Fri, 10 Mar 2023 12:50:28 +0100 (CET)
Date:   Fri, 10 Mar 2023 12:50:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 15/20] btrfs: remove the io_pages field in struct
 extent_buffer
Message-ID: <20230310115028.GB19861@lst.de>
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-16-hch@lst.de> <c14567d9-ff8a-620a-575a-1673a82c4b24@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c14567d9-ff8a-620a-575a-1673a82c4b24@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 10, 2023 at 04:53:14PM +0800, Qu Wenruo wrote:
>
>
> On 2023/3/9 17:05, Christoph Hellwig wrote:
>> No need to track the number of pages under I/O now that each
>> extent_buffer is read and written using a single bio.  For the
>> read side we need to grab an extra reference for the duration of
>> the I/O to prevent eviction, though.
>
> But don't we already have an aomtic_inc_not_zero(&eb->refs) call in the old 
> submit_eb_pages() function?

I guess you mean submit_eb_page?  That deals with writeback, so doesn't
help with having a reference during reds, which this patch adds.

> And I didn't find that function got modified in the series.

It doesn't have to.
