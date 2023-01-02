Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65065B54D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jan 2023 17:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjABQuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Jan 2023 11:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjABQui (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Jan 2023 11:50:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039CF1F6
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Jan 2023 08:50:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8ECF5C6A7;
        Mon,  2 Jan 2023 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672678235;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73/82vgIS2p54Bwi7N1lgGeGiWBm8ruTDB7q8Ytglo8=;
        b=fT3veh49UVnm/bnP+oZ1XbA0WUA3Oqk1sFXxKQlrOUj45M0GMkjkyb58Z/m9tHlthI9Jp6
        UOWEUXwF9Um+NTFEsQZTdMF/1TAmk4MX+PsfBT4RZzu6h/Ves+ndl3P9zGpWSFM+cEXuVk
        ydX/w0XJCf8yF/Znfv7sLFmhXXk6/to=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672678235;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=73/82vgIS2p54Bwi7N1lgGeGiWBm8ruTDB7q8Ytglo8=;
        b=Ku+CiQhjv8R501rf5IMp1wY3jUO8sKOja8gMW7Vy4aNgOsSCNRitvAPJBW62KwmWl/XuOc
        lvXwdcAZrRLr8rCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EEDA139C8;
        Mon,  2 Jan 2023 16:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TxPsIVsLs2PJEAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Jan 2023 16:50:35 +0000
Date:   Mon, 2 Jan 2023 17:45:05 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: always report error for run_one_delayed_ref()
Message-ID: <20230102164505.GM11562@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1672016104.git.wqu@suse.com>
 <e8249a59dd7a59869dfaa4fbcb76424f458e21c7.1672016104.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8249a59dd7a59869dfaa4fbcb76424f458e21c7.1672016104.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 26, 2022 at 09:00:40AM +0800, Qu Wenruo wrote:
> Currently we have a btrfs_debug() for run_one_delayed_ref() failure, but
> if end users hit such problem, there will be no chance that
> btrfs_debug() is enabled.
> 
> This can lead to very little useful info for debug.
> 
> This patch will:
> 
> - Add extra info for error reporting
>   Including:
>   * logical bytenr
>   * num_bytes
>   * type
>   * action
>   * ref_mod
> 
> - Replace the btrfs_debug() with btrfs_err()
> 
> - Move the error reporting into run_one_delayed_ref()
>   This is to avoid use-after-free, the @node can be freed in the caller.
> 
> This error should only be triggered at most once.
> 
> As if run_one_delayed_ref() failed, we trigger the error message, then
> causing the call chain to error out:
> 
> btrfs_run_delayed_refs()
> `- btrfs_run_delayed_refs()
>    `- btrfs_run_delayed_refs_for_head()
>       `- run_one_delayed_ref()
> 
> And we will abort the current transaction in btrfs_run_delayed_refs().
> If we have to run delayed refs for the abort transaction,
> run_one_delayed_ref() will just cleanup the refs and do nothing, thus no
> new error messages would be output.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
