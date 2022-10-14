Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81915FEEA0
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 15:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiJNNam (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 09:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJNNak (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 09:30:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D25627DE6
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 06:30:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B9535210F5;
        Fri, 14 Oct 2022 13:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665754237;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zYI4ZjaKmnkd1xsp2eq8b1+iG1NcLM1hbO/KO5bjW+0=;
        b=vCACAvyaQusYAscYZ+Wwsq/XD/+jZNmXKTHgZigBMlA95/8zmBFX77FJJsHh3z/ybo1iXM
        KT8RtWaJARGXfNOnliNnDMIuKaGUBPR4dBsFRm+DPGeqVYFMgZTCYWgy+3/8vom05kMNNG
        H5FjIk8iJknSokKScAOpbAIFigBzi8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665754237;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zYI4ZjaKmnkd1xsp2eq8b1+iG1NcLM1hbO/KO5bjW+0=;
        b=bcVeg5eWHr+4jBRzZVkCR/Ta0mxx6n/obs9kfUgZ0TuHqDlKwxWRtggW1b7F2S+B62tWo2
        ooPtULoEDS1sVvAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C83013451;
        Fri, 14 Oct 2022 13:30:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E4seJX1kSWPkLQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Oct 2022 13:30:37 +0000
Date:   Fri, 14 Oct 2022 15:30:30 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs: drop no longer needed atomic allocation for
 tree mod log operations
Message-ID: <20221014133030.GI13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665656353.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1665656353.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 13, 2022 at 11:36:24AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We are still doing an atomic memory allocation for tree mod log operations
> which is not needed anymore after we switch extent buffer locks to rw
> semaphores. This replaces that atomic allocation with a GFP_NOFS one, and
> then removes redundant gfp_t argument for btrfs_tree_mod_log_insert_key().
> 
> Filipe Manana (2):
>   btrfs: switch GFP_ATOMIC to GFP_NOFS when fixing up low keys
>   btrfs: remove gfp_t flag from btrfs_tree_mod_log_insert_key()

Added to misc-next, thanks.
