Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139B3512260
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 21:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiD0TU2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 15:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiD0TUD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 15:20:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11BF366A0
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 12:14:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 717F31F755;
        Wed, 27 Apr 2022 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651086888;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oBCrBqpzaf8thYBNDmiTSN5GmkHpoh9uyAxDMDs29Mg=;
        b=kWhPoJvJgwhqz+mYeubueGlNrMkT4fP2AJo2FHOD9xWfIOb6+ix56UO8b++/ZEyRfb///E
        tu6a1g7yqIwTATU3xH8Edt+DsK0DNJIFZA34lp95QTQBnFpT4wZGN653lhWfVFZeAsDZbq
        FnwJj/8OhqytMR+rz0nUikwBlqGIUP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651086888;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oBCrBqpzaf8thYBNDmiTSN5GmkHpoh9uyAxDMDs29Mg=;
        b=I9OB4hWZCR0Cx6gEtZSp6fV4gRR4Nt92DgPpjO3NYbNbewEKy2XCmF3He4+1oAfBzmGB7J
        FahY5MqcqiLDEHBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 520BC13A39;
        Wed, 27 Apr 2022 19:14:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2dYZEyiWaWLNagAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 27 Apr 2022 19:14:48 +0000
Date:   Wed, 27 Apr 2022 21:10:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/9] btrfs: refactor scrub entrances for each profile
Message-ID: <20220427191040.GY18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1646984153.git.wqu@suse.com>
 <260f924b-e434-c49b-0c39-a09dbf61ac19@suse.com>
 <20220420211654.GL1513@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420211654.GL1513@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 20, 2022 at 11:16:54PM +0200, David Sterba wrote:
> On Tue, Mar 15, 2022 at 03:02:43PM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2022/3/11 15:38, Qu Wenruo wrote:
> > > This patchset is cherry-picked from my github repo:
> > > https://github.com/adam900710/linux/tree/refactor_scrub
> > 
> > Just to mention, the branch get an update as misc-next now merged the 
> > renaming part.
> > 
> > The good news is, this entrance refactor can be applied without 
> > conflicts. So no update on this patchset.
> 
> Still applies on top of current misc-next with variuos patches merged,
> even there's no conflict with the subpage support for raid56 so I'll
> keep them both in the to-merge queue.

Branch moved from topic to misc-next.
