Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5549C71616F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 15:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjE3NTg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 09:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjE3NT3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 09:19:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50BA110
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 06:19:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E3E521A78;
        Tue, 30 May 2023 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685452755;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=US0G/fTamxe4Iuf3C5YkZsWpoaa15KrB/co7qiESuHA=;
        b=ICgazqn8W6gDE/BI5VBuUfGIECJt2eKv6hC0shYzkC7egPX3LB9BTm4k8ZYgay3PlIWEgq
        vl3qcoWC8vNIV8nGCl9p/nM0OukOYFZhGoT5KDO4HD23uiHIl4ECNguVP0+FA1yxlMSGBs
        UGo3w0kFWlx2JgW5isgE7fvI2y9jKFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685452755;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=US0G/fTamxe4Iuf3C5YkZsWpoaa15KrB/co7qiESuHA=;
        b=O4ynEIwAkZOHPBYmxDLzVMS34zauk/lqkWSju9V93k5WD9Dh6hXwuOtDRKodckdEcFOhDK
        Is6l97XpeJ1PIZCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40F3913478;
        Tue, 30 May 2023 13:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4p4PD9P3dWTdOwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 30 May 2023 13:19:15 +0000
Date:   Tue, 30 May 2023 15:13:04 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/16] btrfs: fix range_end calculation in
 extent_write_locked_range
Message-ID: <20230530131304.GP575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230523081322.331337-1-hch@lst.de>
 <20230523081322.331337-2-hch@lst.de>
 <20230529171318.GI575@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529171318.GI575@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 29, 2023 at 07:13:18PM +0200, David Sterba wrote:
> On Tue, May 23, 2023 at 10:13:07AM +0200, Christoph Hellwig wrote:
> > The range_end field in struct writeback_control is inclusive, just like
> > the end parameter passed to extent_write_locked_range.
> 
> There should also be analysis what are the effects and how severe the
> bug is. The code is from 2008 so if it's really bad we would have seen
> something already.

Seems it's directly affecting subpage since e55a0de18572 ("btrfs: rework
page locking in __extent_writepage()"), the range_end is passed there
and adjusted by + 1, IOW expecting it to initially have the value of
'end'.

For the normal case the wbc is passed down to extent_write_cache_pages
and "end = wbc->range_end >> PAGE_SHIFT;" the final range [start, end)
is one page larger, tagged for writeback and then processed in the loop.

The actual writeback goes again to

__extent_writepage
  writepage_delalloc
  __extent_writepage_io

and the page gets written, so there's potentially some unneded work
done, unless some other condition skips the io.
