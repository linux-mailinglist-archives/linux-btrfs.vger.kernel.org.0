Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392BE50C332
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 01:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiDVWep (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Apr 2022 18:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiDVWeW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Apr 2022 18:34:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BD7275
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 14:26:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 68F9C212C2;
        Fri, 22 Apr 2022 21:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650662815;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bJehEAEiUua/mLc1YwFyeFnuW4BZnu7v6ovww7fY9aE=;
        b=zZ/PYz4OZGkGUHPyKcrpB+Q6pNvlcYWQhB12N/JE3Ey0Evgkeuskgw38y/bB92c9Y4a5YI
        1yeGHWu+AQpVFJlpQclztrDPLQonrvWOnfCZZEhECIbrmFCXHafMAHpVp6Lx6kT6FMT/94
        8xXUqZBNvHK9mQGXwbXoSskKgLIXz6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650662815;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bJehEAEiUua/mLc1YwFyeFnuW4BZnu7v6ovww7fY9aE=;
        b=DItnTwrWLAiRDHQVsyjZUUYPMzKktgICyi7rT/IVTFHPcpXU0RYs75BZYuIMCvZFj7qedc
        m8p9T4MqO/w9QQDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33E4713AE1;
        Fri, 22 Apr 2022 21:26:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rfy5C58dY2J7EwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 22 Apr 2022 21:26:55 +0000
Date:   Fri, 22 Apr 2022 23:22:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: btrfs_workqueue cleanups
Message-ID: <20220422212250.GM18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20220418044311.359720-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418044311.359720-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 18, 2022 at 06:43:08AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up the btrfs_workqueue implementation, and switches
> a few workqueues to use the cheaper normal kernel workqueues.

Thanks, this looks great, patches added to misc-next.
