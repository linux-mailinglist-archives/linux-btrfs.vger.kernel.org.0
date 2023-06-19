Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA72735ACF
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 17:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjFSPJS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 11:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjFSPJE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 11:09:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D4D10CF;
        Mon, 19 Jun 2023 08:08:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BBEDF1F45A;
        Mon, 19 Jun 2023 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687187323;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Smdnv4IpQsvgSQidyWWPIzGWrjMWf65TYxq8FUaUnw=;
        b=1hwJnRoM5oeKkoERww62tJ7kbZNHOEKnEAr7e6xteYPz+n/rtN8evTNNb6z5E1YXgVKD+M
        eBhqhg4NgS1lywk6gmZ9Xg8XqpZFFO0aANiwT4Rm1Y9n0RZiLhkQ+7VuLCu2rSDEldO15F
        dLry7YgaooTUsIHjMXGwqIbe4eS+vLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687187323;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Smdnv4IpQsvgSQidyWWPIzGWrjMWf65TYxq8FUaUnw=;
        b=po61XzdwdiUOKlpQ3mBwnu/kOfiWmAgQt2gDN9hnzdPavQwXX+J4s5l6X7nqxaBI7l6JH+
        8vg8xwiYm09nJ0Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9898A139C2;
        Mon, 19 Jun 2023 15:08:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xb2EJHtvkGTrNgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 19 Jun 2023 15:08:43 +0000
Date:   Mon, 19 Jun 2023 17:02:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.com, clm@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: make btrfs_compressed_bioset static
Message-ID: <20230619150221.GA16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230616172443.87681-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616172443.87681-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 16, 2023 at 06:24:43PM +0100, Ben Dooks wrote:
> The 'btrfs_compressed_bioset' struct isn't exported outside of the
> fs/btrfs/compression.c file, so make it static to fix the following
> sparse warning:
> 
> fs/btrfs/compression.c:40:16: warning: symbol 'btrfs_compressed_bioset' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Added to misc-next, thanks.
