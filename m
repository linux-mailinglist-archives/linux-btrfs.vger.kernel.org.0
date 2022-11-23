Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995BF6361F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 15:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbiKWOff (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 09:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbiKWOfe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 09:35:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C3C1D314
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 06:35:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8612B1F890;
        Wed, 23 Nov 2022 14:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1669214131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RBCuAjm75sildTLHm4SQRaexyRmIOc8JDNMRlnLdvxU=;
        b=Y4nZMpA9jeehiyGl3WiMoTGlAXeYtCYqArSeUgw4zXash9fIt+YMcSUslAz7xck/vhItjG
        mXCdKDVEvRHn7g7eOjtH6cDop6wzkTvoiWtS4hH7nNdnPgb+0KNuJYQubWuEl509kw13S0
        Dtm7lhqIT2gBEu6GmamOKmTLfsLnWY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1669214131;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RBCuAjm75sildTLHm4SQRaexyRmIOc8JDNMRlnLdvxU=;
        b=F7Ycx4wSl37C9bH4dR8pxEh7j7HvBmkbSQ7AKUMuIFimlhrhvBjbb1nRYYfPYX680Ya7F6
        PNAAAb4wuB4PfTAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DA2113AE7;
        Wed, 23 Nov 2022 14:35:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DnfiB7MvfmOgJgAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Wed, 23 Nov 2022 14:35:31 +0000
Date:   Wed, 23 Nov 2022 08:35:29 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/16] btrfs: check for range correctness while locking
 or setting extent bits
Message-ID: <20221123143529.ihaityxu3q74ysfz@fiona>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <07534e31d822b5c08609c72e5a2e8054604765d9.1668530684.git.rgoldwyn@suse.com>
 <CAL3q7H7F-7njGV4tZJ8arcqwfzMO3_0_7qvpaWRCw1AhH6-55g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7F-7njGV4tZJ8arcqwfzMO3_0_7qvpaWRCw1AhH6-55g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13:12 23/11, Filipe Manana wrote:
> On Tue, Nov 15, 2022 at 6:13 PM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> >
> > Since we will be working at the mercy of userspace, check if the range
> > is valid and proceed to lock or set bits only if start < end.
> 
> At the mercy of user space, how? Can you be more detailed about what you mean?

An example is:
A user can perform read() with zero length. Since we are now locking
extent before pages, this leads to set/clear bit with start>end.


> 
> Is this something you ran into, or is this just to prevent such cases
> from happening?

This is a preparatory patch and encountered while I was working on the
series.

-- 
Goldwyn
