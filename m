Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F2A4AF7ED
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 18:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbiBIRP6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 12:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiBIRP5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 12:15:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032D3C0613C9
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 09:16:00 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B5739210EA;
        Wed,  9 Feb 2022 17:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644426958;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lnaPNTdhybWwmAC0M0Kzno6QC3KR0ztZ0ElDe9bJ7KE=;
        b=xh6qF5p4DKMXP+SnQ4HdYDzqT/2yR3av4/h1xt15IiSSGLOX2TWgM+DaVmDP0lUxxoT8ur
        yZuhBvt36DM5z7J6V9CNshBxgIR9fwi9YfHd0q4jvEREc8j308D/UUc/uFgO6AZ/WiCthE
        8xuMmDW/moxTuk6zPXcSXkLOMqoL6BM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644426958;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lnaPNTdhybWwmAC0M0Kzno6QC3KR0ztZ0ElDe9bJ7KE=;
        b=7fXsiNGL0fXoXllnqvB2E9pURnvhF3BL9E7fL4KoqhnBfQh5Zk9RHdu03XCkXpKMY7Q6TV
        00KLqPIFTPje2iDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E1404A3B88;
        Wed,  9 Feb 2022 17:15:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 963F5DA989; Wed,  9 Feb 2022 18:12:17 +0100 (CET)
Date:   Wed, 9 Feb 2022 18:12:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: pass in block-group type to
 zoned_profile_supported
Message-ID: <20220209171217.GM12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220209154218.181569-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209154218.181569-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 09, 2022 at 07:42:18AM -0800, Johannes Thumshirn wrote:
> Pass BTRFS_BLOCK_GROUP_DATA and BTRFS_BLOCK_GROUP_METADATA to
> zoned_profile_supported(), so we can actually distinguish if it is a data
> or a meta-data block group.
> 
> Fixes: 8f914d518a46 ("btrfs-progs: zoned support DUP on metadata block groups")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Thanks. Meanwhile there was a reported bug with --disable-zoned that was
missing the definition. It's been fixed in devel, so please check that
patches also builds with zoned both enabled and disabled.
