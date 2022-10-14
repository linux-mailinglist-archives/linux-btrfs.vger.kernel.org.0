Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6065FEFDB
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 16:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJNOJt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 10:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiJNOJr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 10:09:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8094D1FFA3
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 07:09:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CC2F51F385;
        Fri, 14 Oct 2022 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665756281;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TddYCZ9UZ0POeC/ZhpE2Im6E6lHG5OwlFpFh878Hxe8=;
        b=opIoEwKusbYXyDHpIXenclGbmdVJHlg4e8+umNKlmdLl1xi+9JWUaNBEy0Iu3L/MEH9a3+
        BWh+hcYuEyVhzqg6pxlvcQubu7n35B5zEZEvTpLL2wMcIxHNaoizLFCMDEi/+miDZo8arI
        qWjeuQF9lxUsKjQ8GfPhh62q8wrIyKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665756281;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TddYCZ9UZ0POeC/ZhpE2Im6E6lHG5OwlFpFh878Hxe8=;
        b=QPSCPTsP470h7lHaL93NAy2yBAS/PqIydtRERqWbBP9p1AxVSYVYWK54QRwegOMBNEX/IE
        qvCFpyZI5qwI/lBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE88413451;
        Fri, 14 Oct 2022 14:04:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id npOQKXlsSWOiQQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 14 Oct 2022 14:04:41 +0000
Date:   Fri, 14 Oct 2022 16:04:34 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: drop no longer needed atomic allocation
 for tree mod log operations
Message-ID: <20221014140434.GJ13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1665656353.git.fdmanana@suse.com>
 <cover.1665754838.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1665754838.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 14, 2022 at 02:44:31PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We are still doing an atomic memory allocation for tree mod log operations
> which is not needed anymore after we switch extent buffer locks to rw
> semaphores. This replaces that atomic allocation with a GFP_NOFS one, and
> then removes redundant gfp_t argument for btrfs_tree_mod_log_insert_key().
> 
> V2: Updated patch 2/2 to also remove the allocation flag from
>     alloc_tree_mod_elem().

Updated to v2 in misc-next, thanks.
