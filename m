Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2312A6D270F
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 19:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjCaRvy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Mar 2023 13:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCaRvw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Mar 2023 13:51:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123E572B3;
        Fri, 31 Mar 2023 10:51:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B6EBC1FE2F;
        Fri, 31 Mar 2023 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680285109;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BkNxQxQtLxOIATn942LBWqaiyWsz7ku+7E7J9rM6aUA=;
        b=Eq7XmaCAuBaH8aqP9o9NRc/mibdZ2My0tlTjFdnvEq6o6jxmzg6aPnFIXQRcyCJWDZIkK2
        c9uuo9SQlP9Nz3RQgrYiBULoSoKUWnftZA+GKcrQAivcarE/kEUacykmEDXCC6fJraSCS+
        MC4bQqpFUq46crnc0Hn54wydxilYvLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680285109;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BkNxQxQtLxOIATn942LBWqaiyWsz7ku+7E7J9rM6aUA=;
        b=cu8GpRU01qeFVBHmk5sk0pxsnW7/eDWe/urGLJPUpyUs6RBXPojdV9rG/uVLSloR4ua+YL
        6I2H9lX2AcTXicDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EDA0133B6;
        Fri, 31 Mar 2023 17:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oLtsGbUdJ2TbSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 31 Mar 2023 17:51:49 +0000
Date:   Fri, 31 Mar 2023 19:45:33 +0200
From:   David Sterba <dsterba@suse.cz>
To:     xiaoshoukui <xiaoshoukui@gmail.com>
Cc:     dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoshoukui@ruijie.com.cn
Subject: Re: [PATCH] btrfs: ioctl: fix inaccurate determination of
 exclusive_operation
Message-ID: <20230331174533.GZ10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230328094335.107562-1-xiaoshoukui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328094335.107562-1-xiaoshoukui@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 28, 2023 at 05:43:35AM -0400, xiaoshoukui wrote:
> > Have you found some bug with the above or is there other combination of
> > the exclusive operations that should not work? The changes to the state
> > values are the same, besides the wrong locking.
> 
> Yes, there is a racy bewteen btrfs_exclop_balance and btrfs_exclop_finish
> in btrfs_ioctl_add_dev, when cocurrently adding multiple devices to the
> same mnt point. That will cause the assertion in btrfs_exclop_balance to fail.
> 
> > void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
> > 			  enum btrfs_exclusive_operation op)
> > {
> > 	switch (op) {
> > 	case BTRFS_EXCLOP_BALANCE_PAUSED:
> > 		spin_lock(&fs_info->super_lock);
> > 		ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
> > 		       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
> 
> when btrfs_exclop_finish function was executed before the ASSERT, the
> fs_info->exclusive_operation will change to BTRFS_EXCLOP_NONE. So this
> assert will failed.
>
> Please review whether we should patch the assert to add BTRFS_EXCLOP_NONE condtion.
> I'll post a patch if needed. thx.

Yeah I think the assertion should also check for NONE status. The paused
balance makes the state tracking harder but in user-started (manual or
scripted) commands it's typically not racing.

btrfs_exclop_start_try_lock does not allow to do the change from
none -> op mandating an explicit btrfs_exclop_start first but the
assertions do not care about that.
