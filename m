Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06E46184D1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 17:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiKCQgX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 12:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbiKCQgA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 12:36:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A33520341;
        Thu,  3 Nov 2022 09:33:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D7AAD21A8D;
        Thu,  3 Nov 2022 16:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667493212;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wYp4NSAmMjloU+4ZYxqgkdcvOEJOURO/Z+6l27+xu5Y=;
        b=s7R7Ahlejr7XkyABRZTtuYJc/HMMZdEZkXx4rFgjrAIY3ktoqH/s4kF7ZecyswXYWjfIfh
        XDxSvJRYnLDdHpP6VKsL0GwC2DDvv41i+fXhpC/YZ7pgGUgwJ8eZk9GYTi/qepfPcqb8tw
        pzomb8U2JvGxwAL9VFVYJGoBbYT/iXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667493212;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wYp4NSAmMjloU+4ZYxqgkdcvOEJOURO/Z+6l27+xu5Y=;
        b=zCAAPIJoSA7ulGZzw5teHqHaOKyG55fDeB0yMNELEnxWTy4S/GlseoLfIy1qDg/awoDKNH
        +52MvMs4E1rzqWCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADE8613480;
        Thu,  3 Nov 2022 16:33:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UEV9KVztY2O5RgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 03 Nov 2022 16:33:32 +0000
Date:   Thu, 3 Nov 2022 17:33:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix match incorrectly in dev_args_match_device
Message-ID: <20221103163312.GO5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221103083301.626561-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103083301.626561-1-liushixin2@huawei.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 03, 2022 at 04:33:01PM +0800, Liu Shixin wrote:
> syzkaller found an assert failed:
> 
>  assertion failed: (args->devid != (u64)-1) || args->missing, in fs/btrfs/volumes.c:6921
> 
> This can be trigger when we set devid to (u64)-1) by ioctl. In this case,
> the match of devid will be skipped and the match of device may be succeed
> incorrectly.
> 
> Patch 562d7b1512f7 introduced this function which is used to match device.
> This function contaions two matching scenarios, we can distinguish them by
> checking the value of args->missing rather than check whether args->devid
> and args->uuid is default value.
> 
> Reported-by: syzbot+031687116258450f9853@syzkaller.appspotmail.com
> Fixes: 562d7b1512f7 ("btrfs: handle device lookup with btrfs_dev_lookup_args")
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Added to misc-next, thanks.
