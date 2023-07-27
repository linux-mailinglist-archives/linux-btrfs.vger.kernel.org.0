Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C562B7658E4
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jul 2023 18:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjG0Qil (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 12:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjG0Qik (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 12:38:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA0B272C
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 09:38:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 626D61F7AB;
        Thu, 27 Jul 2023 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1690475918;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zaQQ9H7lQcudz6JiZBlgAhy7KlAF5xNkDez9cX/w+DY=;
        b=kzVzzSzjPZfMPiRWkA61BrIGlKvecWyFRs6ncWCPa7VVZARbD5TVP0/HpVkURffEKbxhVH
        KcfCG9MG1YrIRRA9Vl0rGTU9yZmk6fcSKInTbF7T9vVZFpDPJUcZI7Fc5kN5YsSQ5Ct4Im
        qIr5q8SXo+NFGCP3OzA9Ao0N+WjO+5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1690475918;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zaQQ9H7lQcudz6JiZBlgAhy7KlAF5xNkDez9cX/w+DY=;
        b=s+iwTwxclkBZKZd3QQl52jspDIPps3xLXfNJaftJgx0nalKd0cH3NWKxYDy593e9xa+31/
        RugtbrEHeySPeOBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 013C3138E5;
        Thu, 27 Jul 2023 16:38:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oBkWOY2dwmTIUQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 27 Jul 2023 16:38:37 +0000
Date:   Thu, 27 Jul 2023 18:32:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/3] btrfs: move comments to btrfs_loop_type definition
Message-ID: <20230727163215.GE17922@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689883754.git.josef@toxicpanda.com>
 <6abfcd8c6763baf92199be9532db3bd9e9e0e418.1689883754.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6abfcd8c6763baf92199be9532db3bd9e9e0e418.1689883754.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 20, 2023 at 04:12:15PM -0400, Josef Bacik wrote:
> Some of these loop types aren't described, and they should be with the
> definitions to make it easier to tell what each of them do.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

This is still relevant, without LOOP_CACHING_DONE, so added to
misc-next, thanks.
