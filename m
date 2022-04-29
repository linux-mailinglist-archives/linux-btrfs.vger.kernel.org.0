Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD6651556C
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 22:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380550AbiD2UVM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 16:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380427AbiD2UVL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 16:21:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F32A0BE6
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 13:17:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 74B691F894;
        Fri, 29 Apr 2022 20:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651263470;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zYf5UODVuoYzYr08+iGhfWCupJBvd98SxD7yzBnmBDY=;
        b=F23vAu3gOhFtxd1FcrnryOxw+LOydVoIzlShMds/8wBRd8MDNccYnzX8kjbbZHNiF5uBP6
        u0eA7V1lXCUPLwQR0Xr5FWAesVq8rgCZPZRAf6ZSluv8KkYWHL66ukJuixs7LKDr5N/Sj0
        Hoz894BRauuAiMx7XnFV23keurbWzK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651263470;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zYf5UODVuoYzYr08+iGhfWCupJBvd98SxD7yzBnmBDY=;
        b=Vq1Z02hOszAOpZ/hsg0SpKlkrhydTrB0UgvnMG9GH512y89uOxNzI7CZsFKwdvwpuxw/B/
        d4Z5GdNTCUhiQ9Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50B0213446;
        Fri, 29 Apr 2022 20:17:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LZKDEu5HbGJnEQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 29 Apr 2022 20:17:50 +0000
Date:   Fri, 29 Apr 2022 22:13:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: remove the unused btrfs_fs_info::seeding
 member
Message-ID: <20220429201341.GI18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <0965ac68fbcb31b5cc4b70da84725e887fde847c.1650007153.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0965ac68fbcb31b5cc4b70da84725e887fde847c.1650007153.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 15, 2022 at 03:19:53PM +0800, Qu Wenruo wrote:
> This member is not used by anyone, just remove it.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.
