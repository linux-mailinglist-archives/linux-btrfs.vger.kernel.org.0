Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BDB642E1D
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Dec 2022 18:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiLERCh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Dec 2022 12:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiLERCf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Dec 2022 12:02:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D08FBB3
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Dec 2022 09:02:34 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0800211C2;
        Mon,  5 Dec 2022 17:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670259752;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PtpbsJomRaaXJLKEMDR6Zyagxmr0pQaSjR99Ymjh04A=;
        b=gQC79znac1ONF+DfVMuCpueaoJtbjjcmVhJjdMHQHNzpJlnzHX0YorJLIDy8PAGq88Q96Z
        jX7bNUKvwBn1PhoqnyhZdNEym9CQ5k9cb9689DJ+REV+m5/Ib/lDq2XWpui6q9sGkjDd8t
        WlRcpUXTHq+0au/xiB0a1syDeV0OySg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670259752;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PtpbsJomRaaXJLKEMDR6Zyagxmr0pQaSjR99Ymjh04A=;
        b=jm+ENsK7SArsPRYo4d5/7PN16yANsewD1ZxPqoJ7LtM/afFvYP6KZuVWkyPuQCgRhzMQx0
        vZJ2JDskIoQjNJAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C4E621348F;
        Mon,  5 Dec 2022 17:02:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Q6MnLygkjmPVZQAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Mon, 05 Dec 2022 17:02:32 +0000
Date:   Mon, 5 Dec 2022 18:01:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: print transaction aborted messages with an error
 level
Message-ID: <20221205170155.GA5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <06fd62ae08b2206c5243f8f5f4811ec488633f08.1669823310.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06fd62ae08b2206c5243f8f5f4811ec488633f08.1669823310.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 30, 2022 at 03:51:20PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently we print the transaction aborted message with a debug level, but
> a transaction abort is an exceptional event that indicates something went
> wrong and it's useful to have it printed with an error level as it helps
> analysing problems in a production environment, where debug level messages
> are typically not logged. For example reports from syzbot never include
> the transaction aborted message, since the log level on the test machines
> is above the debug level.
> 
> So change the log level from debug to error.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Yeah that should help analyzing the syzbot reports.  Added to misc-next,
thanks.
