Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DA65B3B8B
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 17:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiIIPMi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiIIPMf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 11:12:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337EB1440B5
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 08:12:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F7C01F88D;
        Fri,  9 Sep 2022 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662736352;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XB/5zLXOXWcAu0rRVuVR6Pm0CQv829TUu+Wcs94gCmU=;
        b=W2KYJ+3nhJaKngQ4Us/QeK2iN0G4Y2sAzy+78ISrpwwMmKdnEJMzg2OwVc0/0PMiYhJZng
        mYniJA4c5YsxmssN6xvVXlGFss0gsvzivYjPB7TNNUTpxSQcs8ZyFBaURHjcovhmpmnMX7
        yCvQP/iiZfkQyLA/RpdiftsL0Q7msDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662736352;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XB/5zLXOXWcAu0rRVuVR6Pm0CQv829TUu+Wcs94gCmU=;
        b=978uUsfGCbToOFg6EZxK6O3W/ouNxqJ4Fz+dlmMQNbHoCM5LPgU7Z0SHBtQv6fpdM6Q+kQ
        xq0zPkGMzJkKRCAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EF81139D5;
        Fri,  9 Sep 2022 15:12:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZY9NEuBXG2NkbAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 09 Sep 2022 15:12:32 +0000
Date:   Fri, 9 Sep 2022 17:07:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: refactor btrfs_check_zoned_mode
Message-ID: <20220909150708.GB32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220907092214.2569409-1-hch@lst.de>
 <20220907145106.pq5eki5wusaluomi@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907145106.pq5eki5wusaluomi@naota-xeon>
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

On Wed, Sep 07, 2022 at 02:51:07PM +0000, Naohiro Aota wrote:
> On Wed, Sep 07, 2022 at 11:22:14AM +0200, Christoph Hellwig wrote:
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -652,80 +652,54 @@ int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
> >  	return 0;
> >  }
> >  
> > +static int btrfs_check_for_zoned_device(struct btrfs_fs_info *fs_info)
> 
> Maybe, we don't need the "btrfs_" prefix for a file-internal function.

Exported functions should have the prefix, for static it's nice to have
so it's obvious that it's our function and not some generic helper.
