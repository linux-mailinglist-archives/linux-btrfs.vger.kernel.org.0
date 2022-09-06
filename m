Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A795AF200
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 19:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiIFRLg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Sep 2022 13:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240130AbiIFRJZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Sep 2022 13:09:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E550FE6
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Sep 2022 09:58:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C9A60337A2;
        Tue,  6 Sep 2022 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662483488;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+s4iO7QIkcEMynqf2Yq8RE3MsEeiyf3pVUVP6rXQ3uc=;
        b=qtT1g3uwQvtC8vhPzRlaYXE4cAzSwH+dKFTWzzzcG3p/Kn08a7wRTTVCO/sFPc62dI5B8t
        wIJ06IR7LvvKq8KTHEZZ7xec2McaXw68wOX2bLfBPnj1cqMDVUUmDXpGcaKi6alzz0/+FF
        Qgi86pHae+8ZyYYslMujzkijBN7PUHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662483488;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+s4iO7QIkcEMynqf2Yq8RE3MsEeiyf3pVUVP6rXQ3uc=;
        b=la4Ht24ZI6anHrKh32CdfbMOe8JdtGPbu86RUOuDRo3jX9EDX4hI4K1kKH3RhA6cD7QGje
        bWpb2H5w+wwqvFCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD8EF13A7A;
        Tue,  6 Sep 2022 16:58:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zB54KSB8F2NWRQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 06 Sep 2022 16:58:08 +0000
Date:   Tue, 6 Sep 2022 18:52:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] btrfs: scrub: make scrub uses less memory for
 metadata scrub
Message-ID: <20220906165246.GT13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1658215183.git.wqu@suse.com>
 <29229e8b-d4db-ed4c-1e06-90ab9b43a206@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29229e8b-d4db-ed4c-1e06-90ab9b43a206@suse.com>
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

On Fri, Aug 05, 2022 at 02:32:48PM +0800, Qu Wenruo wrote:
> Ping?
> 
> This series would begin a new wave of changes of moving various members 
> to scrub_block, thus being able to further reduce memory usage.
> (Per-sector to per-block)
> 
> Thus it would be better to get this series merged before newer changes 
> to arrive.

I'm not sure if I already replied or not, just in case, the patches have
been in misc-next for some time.
