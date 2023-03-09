Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270D16B2D35
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 19:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCISyG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 13:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjCISx6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 13:53:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DE3F9EE6
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 10:53:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1C6F62023F;
        Thu,  9 Mar 2023 18:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678388025;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/bXc9r0XIDcLmmuivFQsJ/2o8u1Vv51ghaPsn+NK2ck=;
        b=SxdK1CQCPM/AJwl7k77YGAylydlppAYYtGtComWfnVP+xppDGw4VjjNMF3vffJ1WLyWgKM
        BZvqb5qSLkD8WRJtovttrED/o7uWQEdaTsuSOTn2gbjyF5i6fcea4Y6mDpcGGdw1jTulDS
        9f4UuN7DfNQ17fQjvhbRZJkKr6jRuWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678388025;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/bXc9r0XIDcLmmuivFQsJ/2o8u1Vv51ghaPsn+NK2ck=;
        b=AEcqmCynsBLo2cevAw9noXpGMQ4xWwrHkfEmQYDIX1GOPMI+Fnlo++IgbT4qAy2v0g2kKB
        lfr+ZATxJbuxtnDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAB0D13A10;
        Thu,  9 Mar 2023 18:53:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4ZpOODgrCmQZQwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 09 Mar 2023 18:53:44 +0000
Date:   Thu, 9 Mar 2023 19:47:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     robbieko <robbieko@synology.com>
Cc:     David Sterba <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: fix unexpected -ENOMEM with
 percpu_counter_init when create snapshot
Message-ID: <20230309184741.GN10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221214021125.28289-1-robbieko@synology.com>
 <Y5oA3qBk+qMSyAR/@localhost.localdomain>
 <20221214180718.GF10499@twin.jikos.cz>
 <f1971de4-5355-6f57-46df-0a6cefb9ee95@synology.com>
 <20230110150818.GD11562@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110150818.GD11562@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 10, 2023 at 04:08:18PM +0100, David Sterba wrote:
> > Sorry for the late reply, I've been busy recently.
> > This modification will not affect the original btrfs_drew_lock behavior,
> > and the framework can also provide future scenarios where memory
> > needs to be allocated in init_fs_root.
> 
> With the conversion to atomic_t the preallocation can remain unchanged
> as there would be only the anon bdev preallocated, then there's not much
> reason to have the infrastructure.
> 
> I'm now testing the patch below, it's relatively short an can be
> backported if needed but it can potentially make the performance worse
> in some cases.

I forgot to CC you, the patch implementing the switch to atomic has been
sent and merged to misc-next.

https://lore.kernel.org/linux-btrfs/20230301204708.25710-1-dsterba@suse.com/
