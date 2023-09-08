Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526F07986E9
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbjIHMPL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIHMPK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:15:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADE01BFB
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:15:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1DBE621B7B;
        Fri,  8 Sep 2023 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694175305;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JSUDeN7EBtQqY6qVI3X8EK72wu0xe0JRGbO+ae5eeSY=;
        b=jqkXF7GxUO1cCrEdB56rwvJzk6CeavXR+kZaKtPSM3mCNBMZ13asmTlDciD6dMeFuYszP1
        P18E52LDhcCeoMnBrdOBl4xMPEUJWhno/MSqWQ8zMq7R/yhN8EQIkj9QVGqAA8hUl/3CfC
        m5ho9PaDFkmbr7BhYkM/GkUQugGMf7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694175305;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JSUDeN7EBtQqY6qVI3X8EK72wu0xe0JRGbO+ae5eeSY=;
        b=s2txbfJNl8ZWYbxUk24/Q3nPO8mpciJd39ZFyad04n4ntCey8EAIOff/bhgxIyDgDM/Ole
        mmCHhC3ZxQLvsaCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E9982132F2;
        Fri,  8 Sep 2023 12:15:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l4xdOEgQ+2QsMwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 08 Sep 2023 12:15:04 +0000
Date:   Fri, 8 Sep 2023 14:08:32 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] btrfs-progs: add eb leak detection and fixes
Message-ID: <20230908120832.GW3159@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1693945163.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693945163.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 05, 2023 at 04:21:50PM -0400, Josef Bacik wrote:
> Hello,
> 
> I introduced an EB leak that we only discovered when we started running fstests
> with my code applied to the btrfs-progs devel branch.  We really want to detect
> this before we start using this code for fstests, so update all the run_check
> related helpers to use a helper that will check for extent buffer leaks and fail
> accordingly.  This will allow developers to discover they've introduced a
> problem when they run make test after their changes.
> 
> This functionality of course uncovered a few leaks that currently exist in
> btrfs-progs, so there are two fixes that precede the leak detection work in
> order to make sure we are clean from the leak detection commit ondwards.
> Thanks,
> 
> Josef
> 
> Josef Bacik (3):
>   btrfs-progs: cleanup dirty buffers on transaction abort
>   btrfs-progs: properly cleanup aborted transactions in check
>   btrfs-progs: add extent buffer leak detection to make test

1 and 2 added to devel, the leak detection is done in a different way,
thanks.
