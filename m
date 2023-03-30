Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6786D0FBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 22:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjC3ULf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC3ULd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 16:11:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF0A172A
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 13:11:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C22941FE10;
        Thu, 30 Mar 2023 20:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680207091;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lxIbV4GIHF/YEE9rDIcLqPia98eieGRzK4sPuLxyQZs=;
        b=nt92/u7Jc1UrU/4d6xrdK8Kp++NjxC3xvsDiUpCOPM6qYdyaoJdQI88VWTAjW0+aUJ6mr4
        lxdou+mD0PdzbQe1aJxknhnWYQ0uXqO1w8xJapYw1J4iGXtgDvho8tXNmJEaYQ7b3XRNuk
        eXU1Anp0cMUCwBVqRXUPlhoo4KYVPM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680207091;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lxIbV4GIHF/YEE9rDIcLqPia98eieGRzK4sPuLxyQZs=;
        b=Sn6nRi0AH7AFVT9ufzx+j1DRWfVqqNaylmfIDIZgH9zOpZIttMfP27MIFqzSQasLRlqh7/
        +mCPdu9cqBt42OCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A4E71348E;
        Thu, 30 Mar 2023 20:11:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n/PMJPPsJWQCVwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 30 Mar 2023 20:11:31 +0000
Date:   Thu, 30 Mar 2023 22:05:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: some trivial updates for delayed ref space
 reservation
Message-ID: <20230330200516.GU10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1680185833.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680185833.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 30, 2023 at 03:39:01PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> One cleanup and one small fix regarding reserving space for delayed refs
> when starting a transaction.
> 
> Filipe Manana (2):
>   btrfs: make btrfs_block_rsv_full() check more boolean when starting transaction
>   btrfs: correctly calculate delayed ref bytes when starting transaction

Added to misc-next, thanks.
