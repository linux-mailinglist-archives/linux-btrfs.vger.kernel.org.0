Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE25B0CCA
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Sep 2022 20:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiIGS7W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Sep 2022 14:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiIGS7U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Sep 2022 14:59:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0166844542
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 11:59:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A417720702;
        Wed,  7 Sep 2022 18:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662577158;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lsVY5loTSsL2WKQAUb0fh02rL3pxZQyKnsw0Arb2OZ4=;
        b=jz3IEDVWxPosbBpGp0qGz2Gg0zHUzbPLAEXRIh/i3KFL6YoMMiAY79nR7egwtbfCG7cRqq
        Vcp0YlMPS7hr56hZswBeLFKsxCJGetlEvr1WnR1PkJLlaLzOtuUvXrI2C4gK32CGZbGD07
        lrPoIId878g98i/JMVObAA31vgVoEq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662577158;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lsVY5loTSsL2WKQAUb0fh02rL3pxZQyKnsw0Arb2OZ4=;
        b=DTYTa6eWA2lxGaaEk1yF0/bzerfSI9i6jSdLCj8tqyFC2lz73RF2gz9cq2KhKDoR58yF9q
        PDtiPTsgZEnPklBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82C1913A66;
        Wed,  7 Sep 2022 18:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W9gmHwbqGGMJJwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 07 Sep 2022 18:59:18 +0000
Date:   Wed, 7 Sep 2022 20:53:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 03/31] btrfs: stop using extent_io_tree for
 io_failure_record's
Message-ID: <20220907185355.GE32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662149276.git.josef@toxicpanda.com>
 <3470bcd6166aaeda443174064d0e172953513fcd.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3470bcd6166aaeda443174064d0e172953513fcd.1662149276.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 02, 2022 at 04:16:08PM -0400, Josef Bacik wrote:
> We still have this oddity of stashing the io_failure_record in the
> extent state for the io_failure_tree, which is leftover from when we
> used to stuff private pointers in extent_io_trees.
> 
> However this doesn't make a lot of sense for the io failure records, we
> can simply use a normal rb_tree for this.  This will allow us to further
> simplify the extent_io_tree code by removing the io_failure_rec pointer
> from the extent state.
> 
> Convert the io_failure_tree to an rb tree + spinlock in the inode, and

That's the perfect subject "convert io_failure_tree to rb_tree", we
still use the tree so we're not stopping using it.

Otherwise ok, it'll shave a few bytes from inode too.

> then use our rb tree simple helpers to insert and find failed records.
> This greatly cleans up this code and makes it easier to separate out the
> extent_io_tree code.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
