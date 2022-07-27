Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D35B583394
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 21:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiG0T31 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 15:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiG0T3N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 15:29:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AC712D0A
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 12:29:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2CFE620D09;
        Wed, 27 Jul 2022 19:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658950151;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2K03mEuDVxe9GJP4j+OszpRoWyDaaM6ISehHrU8nrcU=;
        b=R3Az38fvTtTTlCuW9L5dKEnFQqOqNPYGr8ESO0JBAl1FmRgrVLv4Oz2i47EO9iFpRXKeDQ
        l22/zIb30pxS+5OTN8mdNjsxf5dt9N3m87rU8c7M2qBHm7npbJy5mPvMOnwJNNcBrDvHcm
        CffsaklYPShYAHC27A0TuBNyiOrOWvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658950151;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2K03mEuDVxe9GJP4j+OszpRoWyDaaM6ISehHrU8nrcU=;
        b=ezwCq3IVBPGRYE09xYsR9Ju7trcJnVa3VXu34boVCNssbIDazVRJjTztRVsFtUx9IxBH6j
        oAQpZQYvHNzE+ICg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C45213A8E;
        Wed, 27 Jul 2022 19:29:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /PoHAgeS4WJxSQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Jul 2022 19:29:11 +0000
Date:   Wed, 27 Jul 2022 21:24:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: reset RO counter on block group if we fail to
 relocate
Message-ID: <20220727192412.GX13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <ca31fa4152849cee02f16c49f7ef818b89995a25.1658768686.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca31fa4152849cee02f16c49f7ef818b89995a25.1658768686.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 25, 2022 at 01:05:05PM -0400, Josef Bacik wrote:
> With the automatic block group reclaim code we will preemptively try to
> mark the block group RO before we start the relocation.  We do this to
> make sure we should actually try to relocate the block group.
> 
> However if we hit an error during the actual relocation we won't clean
> up our RO counter and the block group will remain RO.  This was observed
> internally with file systems reporting less space available from df when
> we had failed background relocations.
> 
> Fix this by doing the dec_ro in the error case.
> 
> Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
