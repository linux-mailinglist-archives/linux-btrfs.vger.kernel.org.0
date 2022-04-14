Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5AD501BF4
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Apr 2022 21:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345747AbiDNTdv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 15:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345720AbiDNTcm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 15:32:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C9C2ED4B;
        Thu, 14 Apr 2022 12:30:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8AA871F747;
        Thu, 14 Apr 2022 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649964614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PeyLvFfLPcu6npNhffBMTXhfIWBWIhlLCr+uIvrgKf0=;
        b=Zd12RdZj7FuQb1/14hSVsAT/PRFujS+DQkawT07jSz1ZymtxRr3xgvkzJZoPCChpKM/eEb
        FU14FfMML16jbqz/14PVYNsSoWAPkjHMJH4U17l2nYdC+orXwpjk2UPEZ2CjNQQWFtawNC
        NudY6nLPcWixE+9lL3dnp2zGr8365uU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649964614;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PeyLvFfLPcu6npNhffBMTXhfIWBWIhlLCr+uIvrgKf0=;
        b=EgH2wM/nvIaTpFzxxjV6SxRvKDhReeeIyOCAkta3mciy9QEdlmdSfMRXBq5DMsCz2jSRj2
        vQ9uy6XiuSkqVCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B12F13A86;
        Thu, 14 Apr 2022 19:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hUG4EUZ2WGKQQAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Apr 2022 19:30:14 +0000
Date:   Thu, 14 Apr 2022 21:26:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Schspa Shi <schspa@gmail.com>
Cc:     dsterba@suse.cz, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, terrelln@fb.com
Subject: Re: [PATCH v2] btrfs: zstd: use spin_lock in timer callback
Message-ID: <20220414192606.GS15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Schspa Shi <schspa@gmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        terrelln@fb.com
References: <20220411135136.GG15609@suse.cz>
 <20220411155540.36853-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411155540.36853-1-schspa@gmail.com>
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

On Mon, Apr 11, 2022 at 11:55:41PM +0800, Schspa Shi wrote:
> This is an optimization for fix fee13fe96529 ("btrfs:
> correct zstd workspace manager lock to use spin_lock_bh()")
> 
> The critical region for wsm.lock is only accessed by the process context and
> the softirq context.
> 
> Because in the soft interrupt, the critical section will not be preempted by the
> soft interrupt again, there is no need to call spin_lock_bh(&wsm.lock) to turn
> off the soft interrupt, spin_lock(&wsm.lock) is enough for this situation.
> 
> Changelog:
> v1 -> v2:
> 	- Change the commit message to make it more readable.
> 
> [1] https://lore.kernel.org/all/20220408181523.92322-1-schspa@gmail.com/
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>

Added to misc-next, thanks.
