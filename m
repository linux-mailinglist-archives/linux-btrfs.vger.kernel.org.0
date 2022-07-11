Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C372E570714
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 17:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiGKP2V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 11:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiGKP2U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 11:28:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD1728731
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 08:28:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 21C961FE63;
        Mon, 11 Jul 2022 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657553298;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8zYxNMDaT1YTzYsiRgu+EZrO8vE4bDgHLaN29LGq6A=;
        b=pHsKQr9or24JEcDp7/1d1Y4IhaspxQxdJlzVgbrbtLFs1iavMZp9CYGzy82CHPLp/ederG
        6qhAbwNY3zRhDlww7fPTIwRBMTVil1OpCNYwoh0QbNV9/L0JaxiQBR9wMqgHKPq1dMT3Hz
        evjufep6RU8MKqZFOPRJPNW/U5xNmpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657553298;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8zYxNMDaT1YTzYsiRgu+EZrO8vE4bDgHLaN29LGq6A=;
        b=7Rf7X65pvEBBWjnooVp/+avo4UeNixxP3z2k1x9XldndKLghF3PBrdPm4KPy04u9dsvPeP
        Nctj8ltPyFZdaxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC03A13322;
        Mon, 11 Jul 2022 15:28:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l0BrOJFBzGLKYgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 11 Jul 2022 15:28:17 +0000
Date:   Mon, 11 Jul 2022 17:23:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: remove MIXED_BACKREF sysfs file
Message-ID: <20220711152329.GY15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220624080123.1521917-1-nborisov@suse.com>
 <20220624080123.1521917-2-nborisov@suse.com>
 <21f7eb10-09d7-826c-48c3-ded892984d50@gmx.com>
 <3e01475c-8296-4cf1-14cd-5774d780b6e2@suse.com>
 <27f72ec4-a365-20ba-03f1-8d603a66e011@gmx.com>
 <20220624134706.GV20633@twin.jikos.cz>
 <75cb4383-72e3-58d6-ca23-fbfa9be65617@suse.com>
 <20220624154436.GW20633@twin.jikos.cz>
 <7ac6d505-6806-338d-d1f2-100737749e89@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ac6d505-6806-338d-d1f2-100737749e89@gmx.com>
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

On Sat, Jun 25, 2022 at 01:53:47PM +0800, Qu Wenruo wrote:
> > Removed functionality is documented, the sysfs feature files are in
> > manual pages and we can add a notice in which version it was removed.
> 
> Then have all the old features get removed one by one, until one day we
> have a dozen of bits set, but only one or two still show in sysfs features?
> 
> No, this definitely doesn't look sane to me.

And nobody is suggesting that either, the big data and mixed backrefs
are something that's exceptional in this regard. Removing other features
would take some significant time to remove and a check if it would still
not break some testing setups.

> It's just trying to hide some bad behaviors which we didn't get it right
> in the first place.
> It's fine to didn't get those things done correct in the first place,
> but not fine to hide them.
>
> Especially those sysfs is already hidden to most users, way less
> invasive than the dmesg output/mkfs features/etc, why we still want to
> remove them?

To unclutter the namespace a bit, in case of the mixed_backrefs it's a
bit confusing with the mixed block groups but I think I've mentioned
that already.
