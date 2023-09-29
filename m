Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3207B36D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Sep 2023 17:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjI2Pb6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Sep 2023 11:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjI2Pb5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Sep 2023 11:31:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877BCB4
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Sep 2023 08:31:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3FBD0218EE;
        Fri, 29 Sep 2023 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696001513;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kW7J3L/gPjzSkk2JjYoR3HGyRo/Iz12cLzIkbjgJ3YE=;
        b=mjCGGAzT3lk5jG5mOeibAY/BjxVzAxnyOueGrTaS58lhLbmcAzhRwI+/bBRz6pqdAttb9j
        MBatWbeo6OUSSJdQ6ERfDumoA6Ed5OnBe53v55569BZhQ/jpr9eJxXSYDqoM/ycEuZjFiD
        N7IM+R5cEC2ZfKhdZ/DUMif2GTsr/Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696001513;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kW7J3L/gPjzSkk2JjYoR3HGyRo/Iz12cLzIkbjgJ3YE=;
        b=Fu/YqtPQL8JHJsAtjgijkHYyvDULiZmjVr95UumogfjI2gy5yqhM2GCdRJtm9MU3G1TGFi
        6gy0MTjhKQY8ihBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 158E313434;
        Fri, 29 Sep 2023 15:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /a9GBOntFmWzOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 29 Sep 2023 15:31:53 +0000
Date:   Fri, 29 Sep 2023 17:25:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/8] btrfs: remove pointless memory barrier from
 extent_io_tree_release()
Message-ID: <20230929152513.GG13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695333278.git.fdmanana@suse.com>
 <f7f89af6619fc4ba4f98c7654496c4a4c13445b9.1695333278.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f89af6619fc4ba4f98c7654496c4a4c13445b9.1695333278.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 22, 2023 at 11:39:05AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The memory barrier at extent_io_tree_release() is pointless because:
> 
> 1) We have just called spin_lock() and that implies a memory barrier;

Spin lock ins not a full memory barrier, only half (one direction of
updates), full memory barrier is implied by spin_unlock-spin_lock
sequence, so I this reasoning is a bit imprecise.

> 
> 2) We only change the waitqueue of an extent state record while holding
>    the tree lock - see wait_on_state()

This looks like the real reason why it can be reomved. What
waitqueue_active cares about are updates that must not be lost between
CPUs for the wakeup.

Here the updates under spin lock mean that there's always the
unlock/lock sequence when one thread does the updates (and unlocks),
then the other one (fist locks) and then checks.

> So remove the memory barrier.

Yeah, it's redundant, I would not call it pointless because there's a
legit reason in connection with waitqueue_active().

I'll reword the changelog along the reasoning above.
