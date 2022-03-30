Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBF34EC700
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Mar 2022 16:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347154AbiC3Otq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Mar 2022 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243105AbiC3Oto (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Mar 2022 10:49:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C47237A25
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Mar 2022 07:47:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D7C2A218FC;
        Wed, 30 Mar 2022 14:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648651676;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MduYLXPs0iDq0/JQc6QPFzunf2sxqFz4VM6rsWq3iI4=;
        b=RW0ddLCo4fEyJtnl2ACrKrH7TaNyn4rv7+rgc0DpL2OPQ/fUTlFGjJ8COxtR9SaiWlsb4G
        Zcqlo/PZ22avcJE3m+LiDoye86YQZ0VIeTI/gix2ga53JxOBZvWA7h8lqCnVQo+pvYsYb3
        fXXDSQM4Ii+AqOZWCxXcdze+JTFULZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648651676;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MduYLXPs0iDq0/JQc6QPFzunf2sxqFz4VM6rsWq3iI4=;
        b=tYyR40mlci6BgAQIiWK8Oa6OvkoBIrbbVAKi68wkRBDrIqDYuQmVWwMhaGw9a8wKYSfNWu
        6f8M5Si/6JMdypDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A936CA3B88;
        Wed, 30 Mar 2022 14:47:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ABBA3DA7F3; Wed, 30 Mar 2022 16:43:58 +0200 (CEST)
Date:   Wed, 30 Mar 2022 16:43:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: fix direct I/O read repair for split bios
Message-ID: <20220330144358.GF2237@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220324160628.1572613-1-hch@lst.de>
 <20220324160628.1572613-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324160628.1572613-2-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 24, 2022 at 05:06:27PM +0100, Christoph Hellwig wrote:
> When a bio is split in btrfs_submit_direct, dip->file_offset contains
> the file offset for the first bio.  But this means the start value used
> in btrfs_check_read_dio_bio is incorrect for subsequent bios.  Add
> a file_offset field to struct btrfs_bio to pass along the correct offset.
> 
> Given that check_data_csum only uses start of an error message this
> means problems with this miscalculation will only show up when I/O
> fails or checksums mismatch.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Qu, you've removed the same logic in f4f39fc5dc30 ("btrfs: remove
btrfs_bio::logical member") where it was a different name for the same
variable. What changed in the logic that we don't need to store it along
the btrfs_bio and that btrfs_dio_private can't provide anymore?

I'm a bit worried about your changes that remove/rewrite code, silently
introducing bugs so it has to be reinstated. We don't have enough
review coverage and in the amount of patches you send I'm increasingly
worried how many bugs I've inadvertently let in.
