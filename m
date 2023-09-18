Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872B47A5508
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 23:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjIRV3U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 17:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjIRV3T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 17:29:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB60990
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Sep 2023 14:29:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB4B222222;
        Mon, 18 Sep 2023 21:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695072552;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E4QKdT9U4DIBv+l46dNEUXfKA7qSFR2/ge9M2lSQS8s=;
        b=ojt4t22oosCp1lIIJxf6CxpOVR6V3i+GE0h7YKdoDb2bD0C3XpUNKySOZg1ctUrGKrflPm
        beAYLDgVOG60g5mmJ6Jif1MwkPy0ikj0bAwgNIXCpgkleaEo375SEPtTMEaem5WO3nQ5pj
        GGDD620o1EPujzyiJUBz+kkTn+EBbhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695072552;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E4QKdT9U4DIBv+l46dNEUXfKA7qSFR2/ge9M2lSQS8s=;
        b=aFYjAjldZP68W34a6BVW68TA0apvap7PN5BwCnxQjSBvuM1Iltwu87rbIESSMhvwHhmaPp
        9HiWm++zL6mGOCCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9470D1358A;
        Mon, 18 Sep 2023 21:29:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3ZWjIyjBCGXyegAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 18 Sep 2023 21:29:12 +0000
Date:   Mon, 18 Sep 2023 23:22:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't arbitrarily slow down delalloc if we're
 committing
Message-ID: <20230918212236.GO2747@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <801c5d3726d8370a7889118b5ecf15f30fb6b9bb.1695060918.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <801c5d3726d8370a7889118b5ecf15f30fb6b9bb.1695060918.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 18, 2023 at 02:15:33PM -0400, Josef Bacik wrote:
> We have a random schedule_timeout() if the current transaction is
> committing, which seems to be a holdover from the original delalloc
> reservation code.
> 
> Remove this, we have the proper flushing stuff, we shouldn't be hoping
> for random timing things to make everything work.  This just induces
> latency for no reason.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
