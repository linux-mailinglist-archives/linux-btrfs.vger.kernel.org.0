Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FC15091FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382459AbiDTVXr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 17:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiDTVXq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 17:23:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CC44830D
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 14:20:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6CF4F1F380;
        Wed, 20 Apr 2022 21:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650489658;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cn5jJ1uaNk6fUhis2FKpNT8YiZ15Yq06lUNVuF83/lc=;
        b=IeZ7fy79FFGVaMIa6O2SF7HenGlv6JYamWx3603LS84c0NanHm2K9NXh89qlPfOZOUvtsc
        vtJ+QDwct+ZtAlph8zZ7PoeTJUv4xkIvA+7L5j+Ezh6SbuzoGBKoC982ViDJFjzyQmeSLq
        M0n700jkbvkCXLuNgdF6KWVEikNXzkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650489658;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cn5jJ1uaNk6fUhis2FKpNT8YiZ15Yq06lUNVuF83/lc=;
        b=jw9noX1I5C2FebJ8cNV3/70ShJnaIdxSm5DCJGTNbyObGyLMuJvtCbvK6ZPqpaLqZYMc4N
        Q2Aiv35re+BvM9DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 507C713A30;
        Wed, 20 Apr 2022 21:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4gSiEjp5YGL+LgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 20 Apr 2022 21:20:58 +0000
Date:   Wed, 20 Apr 2022 23:16:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/9] btrfs: refactor scrub entrances for each profile
Message-ID: <20220420211654.GL1513@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1646984153.git.wqu@suse.com>
 <260f924b-e434-c49b-0c39-a09dbf61ac19@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <260f924b-e434-c49b-0c39-a09dbf61ac19@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 15, 2022 at 03:02:43PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/3/11 15:38, Qu Wenruo wrote:
> > This patchset is cherry-picked from my github repo:
> > https://github.com/adam900710/linux/tree/refactor_scrub
> 
> Just to mention, the branch get an update as misc-next now merged the 
> renaming part.
> 
> The good news is, this entrance refactor can be applied without 
> conflicts. So no update on this patchset.

Still applies on top of current misc-next with variuos patches merged,
even there's no conflict with the subpage support for raid56 so I'll
keep them both in the to-merge queue.
