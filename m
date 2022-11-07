Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219CD61F448
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 14:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiKGN2q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 08:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKGN2p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 08:28:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC01A80E
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 05:28:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5FAF81F8B3;
        Mon,  7 Nov 2022 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667827723;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xdHgG2KAzP0iwVynY00+hPihS5wQj4rvBWA6TyCexsQ=;
        b=Nm0HvTj5AD5gqc0sCNoQ0OjLxOEE/PLKDmAe3ZT+yI1GwrXLGLV/6A5Rc1H/A1UEsw1pnn
        RMmZaPLHXG/ykCIBw1aL6Z5nBKyE7+vupIxCP6hCuPMGJDIXT/s3JRNb1pNzG9d97MlGeT
        PuzkFiXYMiNrnAcQ2zlA+YGIORrtamY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667827723;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xdHgG2KAzP0iwVynY00+hPihS5wQj4rvBWA6TyCexsQ=;
        b=joe7IkPhB7CRqHagz3ZVbKdKMNeXKidbquhdeiLt9564uRXNuYF4BQ+cOOw3RD5hzx6JJ6
        Bx5Zg6UDGGNW34Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FD1613494;
        Mon,  7 Nov 2022 13:28:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vPelDgsIaWNHWwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 07 Nov 2022 13:28:43 +0000
Date:   Mon, 7 Nov 2022 14:28:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 0/3] btrfs: zoned: misc fixes for problems uncovered by
 fstests
Message-ID: <20221107132821.GT5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1667571005.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1667571005.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 04, 2022 at 07:12:32AM -0700, Johannes Thumshirn wrote:
> I've started running fstests with an increased number of zoned devices in
> SCRATCH_DEV_POOL and here's the fixes for the fallout of these.
> 
> All three patches are unrelated to each other (i.e. no dependencies).
> 
> Johannes Thumshirn (3):
>   btrfs: zoned: clone zoned device info when cloning a device
>   btrfs: zoned: init device's zone info for seeding
>   btrfs: zoned: fix locking imbalance on scrub

Added to misc-next, thanks.
