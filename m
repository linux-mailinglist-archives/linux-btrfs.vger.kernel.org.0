Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C770E72A0DB
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjFIRHb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jun 2023 13:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFIRHa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jun 2023 13:07:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA85D1FFE
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jun 2023 10:07:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9C83221A86;
        Fri,  9 Jun 2023 17:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686330448;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r0ejCfHWBwk2xhN8gzTrB2oQ+hFT6D2DE02chtY9utk=;
        b=JUhtsoOoUtuNIdOf96zbMCnjem8OQFG3LpoMOlSjaRhfKYBsf5Kg1eDWJmdj9X2lr8MV0h
        cO5EX3cPOzlRUC/QK4ozmPn1O/AS3oQ+XeL6OTEc+PI35vUuJIATMFmIoWUbEs0Y3qTEoI
        jiSXf7hvzn7DcA0TfOqK8Uay3yF850g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686330448;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r0ejCfHWBwk2xhN8gzTrB2oQ+hFT6D2DE02chtY9utk=;
        b=U+3X8/OkdxsEaX153YPFIQ+COiDE79P68erlA7ueJZ8r5CNaSylXyIiYaT0lDoo84C+J+S
        fGfB3hSGgl6duLDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8D51F2C186;
        Fri,  9 Jun 2023 17:07:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E762ADA85A; Fri,  9 Jun 2023 19:01:12 +0200 (CEST)
Date:   Fri, 9 Jun 2023 19:01:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: replace BUG_ON() at split_item() with proper
 error handling
Message-ID: <20230609170112.GB12828@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5891832d9130694cc60cffac74b95db92521728c.1686307630.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5891832d9130694cc60cffac74b95db92521728c.1686307630.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 09, 2023 at 11:49:07AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There's no need to BUG_ON() at split_item() if the leaf does not have
> enough free space for the new item, we can just return -ENOSPC since
> the caller can deal with errors from split_item(). Also, as this is a
> very unlikely condition to happen, because the caller has invoked
> setup_leaf_for_split() before calling split_item(), surround the
> condition with a WARN_ON() which makes it easier to notice this
> unexpected condition and tags the if branch with 'unlikely' as well.
> 
> I've actually once hit this BUG_ON() with some incorrect code changes
> I had, which was very inconvenient as it required rebooting the VM.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
