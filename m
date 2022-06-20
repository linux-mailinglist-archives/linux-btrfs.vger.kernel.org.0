Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9155227B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 18:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiFTQtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 12:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiFTQtk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 12:49:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BC91570C
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 09:49:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02CA321B0B;
        Mon, 20 Jun 2022 16:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655743777;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0KEj77N+OwSvcCdSg4Qe9iP4/J+0uE886t+U4oWDPWE=;
        b=WWR40MFO+cvhq3R2jtd/L81hbRBaAKspMDD2tvLOuO+I/WmkMWvziLbq7650SZvqp1jH+u
        rQDpzXsrcd1lJjNg3OWJ5M4/jq8SWMKzmyD4F1fNTQwi/AC6MTnrycLwzcZWLhgC2jwPl3
        52aNShjeV7v/1MTk212Y1De+RUqxgXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655743777;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0KEj77N+OwSvcCdSg4Qe9iP4/J+0uE886t+U4oWDPWE=;
        b=LODzFv6LLhoHsI/pzhbSRZShFd6HHDL/eiZzHGO4RU2fZQbm8DnnzTIuE3c254uQ0UNznT
        CqaEtoRCkdsg3pAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D955B134CA;
        Mon, 20 Jun 2022 16:49:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P80INCClsGJXIgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Jun 2022 16:49:36 +0000
Date:   Mon, 20 Jun 2022 18:45:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: don't trust any cached sector in
 __raid56_parity_recover()
Message-ID: <20220620164500.GT20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <5c6e45e599134cf203b76956d314b28835211990.1654751908.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c6e45e599134cf203b76956d314b28835211990.1654751908.git.wqu@suse.com>
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

On Thu, Jun 09, 2022 at 01:18:44PM +0800, Qu Wenruo wrote:
> Changelog:
> v2:
> - Update the commit message to explain all involved patches better
>   There are 3 patches (one in upstream, two in misc-next) involved for
>   the case.
> 
> - Update the commit message to show we still have the destructive RMW
>   problem
>   It will never be solved until we do scrub level check for partial
>   write.
>   This patch is just doing damage control to limit the spread of
>   corruption.
> ---
>  fs/btrfs/raid56.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Added to misc-next, thanks.
