Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B888792848
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjIEQCq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354389AbjIELQN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 07:16:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D3F1AD
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 04:16:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 424722188A;
        Tue,  5 Sep 2023 11:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693912569;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VZIu5O5g/jix96/v9zTaTElP/+yg0ftOZ3tkBR4rvNI=;
        b=x7zBT8RlKtXRFBnpHQQrsgO2AyiR0UH+s0glgP/8qw/4TcnEcZ6L+6SoY9KL/+fVfPIJjH
        ndTE7tldHzNbIN11ZsGnXWUuZURcGUmRzQw0wzVpezn2NqhF+49xr2Q82+pa8GlWB09zOQ
        D1kT4rBm759D7kyeSBo7iNLHlP/jSwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693912569;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VZIu5O5g/jix96/v9zTaTElP/+yg0ftOZ3tkBR4rvNI=;
        b=uKmPM6pJTK9zkhE4xmhlvPyEVpKDojCxrYZIhvtRuqyMtdk23YMmKPF7EhSOkTIrsEZRDP
        yFAnkBUXYA3m0NDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 200DD13499;
        Tue,  5 Sep 2023 11:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iNfOBvkN92QRawAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 11:16:09 +0000
Date:   Tue, 5 Sep 2023 13:09:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: check for BTRFS_FS_ERROR in pending ordered assert
Message-ID: <20230905110929.GS14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c640ee0669c4454488d2ddacbc3a93884c905b38.1692910732.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c640ee0669c4454488d2ddacbc3a93884c905b38.1692910732.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 24, 2023 at 04:59:04PM -0400, Josef Bacik wrote:
> If we do fast tree logging we increment a counter on the current
> transaction for every ordered extent we need to wait for.  This means we
> expect the transaction to still be there when we clear pending on the
> ordered extent.  However if we happen to abort the transaction and clean
> it up, there could be no running transaction, and thus we'll trip the
> 
> ASSERT(trans)
> 
> check.  This is obviously incorrect, and the code properly deals with
> the case that the trans doesn't exist.  Fix this ASSERT() to only fire
> if there's no trans and we don't have BTRFS_FS_ERROR() set on the file
> system.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Added to misc-next, thanks.
