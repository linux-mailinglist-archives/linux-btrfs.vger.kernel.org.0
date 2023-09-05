Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E197926B7
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Sep 2023 18:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbjIEQD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Sep 2023 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354606AbjIEMwy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Sep 2023 08:52:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F571A6
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Sep 2023 05:52:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 745D11FDB3;
        Tue,  5 Sep 2023 12:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693918370;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sPIAJ+Zni4kf8APOF3FRCc+nLWksP44/ICBaxjYHT+A=;
        b=jJAQHPfLWrQbUCtjNVblLcwBc38POBsvq1NyeR446JR78osfJ/LrHg/xMxJv3SrSiXHv9V
        bRFG1d35cAVbJwPpXDPEdQtcfr40N9kR7Ppzx+dwEzEl/HygeZQZ2z1RKH+ECypkab9AU9
        2wmDLsjlyeW7mfkJgqKlW98/z76ysH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693918370;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sPIAJ+Zni4kf8APOF3FRCc+nLWksP44/ICBaxjYHT+A=;
        b=KW9N7H+Idjpmy5TxxjwAyaZ2YXJdp/ySokIcZEkzOCoHUVbPHrZHgiVFD3Y8EVjiNoo5m5
        zOv0YSfzSH3gyzDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FC5C13499;
        Tue,  5 Sep 2023 12:52:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WvCYEqIk92SpIgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 05 Sep 2023 12:52:50 +0000
Date:   Tue, 5 Sep 2023 14:46:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: prealloc btrfs_qgroup_list for
 __add_relation_rb()
Message-ID: <20230905124610.GW14420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ca35f1e6134d6e14abee25f1c230c55b1d3f8ae0.1693534205.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca35f1e6134d6e14abee25f1c230c55b1d3f8ae0.1693534205.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 01, 2023 at 10:11:16AM +0800, Qu Wenruo wrote:
> Currently we go GFP_ATOMIC allocation for qgroup relation add, this
> includes the following 3 call sites:
> 
> - btrfs_read_qgroup_config()
>   This is not really needed, as at that time we're still in single
>   thread mode, and no spin lock is held.
> 
> - btrfs_add_qgroup_relation()
>   This one is holding spinlock, but we're ensured to add at most one
>   relation, thus we can easily do a preallocation and use the
>   preallocated memory to avoid GFP_ATOMIC.
> 
> - btrfs_qgroup_inherit()
>   This is a little more tricky, as we may have as many relationships as
>   inherit::num_qgroups.
>   Thus we have to properly allocate an array then preallocate all the
>   memory.
> 
> This patch would remove the GFP_ATOMIC allocation for above involved
> call sites, by doing preallocation before holding the spinlock, and let
> __add_relation_rb() to handle the freeing of the structure.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

This does not seem to apply cleanly on anything recent, neither master,
misc-next (with unrelated patches) or the series cleaning GFP_ATOMIC
from qgroups. The last mentioned series looks good so far so I'm about
to merge it soon so you can then refresh this patch on top of that.
