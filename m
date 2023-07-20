Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77CA75AF8C
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjGTNTl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 09:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGTNTk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 09:19:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0024CE60
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 06:19:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A628922BD6;
        Thu, 20 Jul 2023 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689859176;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kueN933Q+8vQsUSQFRc0k4oNssImP3hvudxSy7DvAzI=;
        b=pMPEuhr7WXQAq3drWPWrZ7/P0mrLyhHil6EoJ1SobMc+fFkWtbN2fSW1wc5VntDTRSQU7X
        if4u/iN6nE2ixp/oRhXcHKNhDcgi3i9OLjplTSiqMLBJmao+CPlOIFTarnExV8y1lISB0R
        RjV2Y3W5L/gciBC3xnB4zuKMNFw8EUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689859176;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kueN933Q+8vQsUSQFRc0k4oNssImP3hvudxSy7DvAzI=;
        b=0Xz9TeIUCLPG5/JWkqAED6ubEr1W/IjH6s5KbK5UCYdXVlRMsAr9R5FeBxU7kFVCCiXywZ
        BLiX3oLGEHfBYjBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EE62133DD;
        Thu, 20 Jul 2023 13:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3+8jImg0uWQhSwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Jul 2023 13:19:36 +0000
Date:   Thu, 20 Jul 2023 15:12:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: account block group tree when calculating global
 reserve size
Message-ID: <20230720131256.GZ20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <433db4e6908c35fd2636c6f89d1e9efa3a2f08e5.1689853275.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433db4e6908c35fd2636c6f89d1e9efa3a2f08e5.1689853275.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 20, 2023 at 12:44:33PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When using the block group tree feature, this tree is a critical tree just
> like the extent, csum and free space trees, and just like them it uses the
> delayed refs block reserve.
> 
> So take into account the block group tree, and its current size, when
> calculating the size for the global reserve.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
