Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A577776462
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 17:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjHIPuY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 11:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHIPuX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 11:50:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02691718
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 08:50:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 90F8A1F390;
        Wed,  9 Aug 2023 15:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691596221;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AmcIkNXQD976x6Y6Jv8dhPhJ3sMrWzEBDZHUXqK6W4U=;
        b=QTe1K4SbMJywBaTi+DYDEacKyd02OewxxwQzy670OjzdvOQX3JZM4z4AtfM5GEEAHi07Rk
        0OD6mDEM6bJqpa+ojhHjIH51zNlnvDHTRWy7vxVQCpQmIf0sXXHRDd/Rp18ZwZxfeEssMA
        OAB9hjBsQUii6PX4gGw6SHMBKDe0Tr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691596221;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AmcIkNXQD976x6Y6Jv8dhPhJ3sMrWzEBDZHUXqK6W4U=;
        b=+4rZhIE31+rGPi/UIQaC41VPdGCnsSShdC+fDZwltDMiRdTGeIK2ACgxlejKfEKkuTARaR
        cEjoRbow1edGtMBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 700F313251;
        Wed,  9 Aug 2023 15:50:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y7tuGr2102TwUwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 09 Aug 2023 15:50:21 +0000
Date:   Wed, 9 Aug 2023 17:50:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/7] btrfs-progs: tune: add resume support for csum
 conversion
Message-ID: <ZNO1vIVIQI7uxOaV@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1684913599.git.wqu@suse.com>
 <20230524155502.GA30909@twin.jikos.cz>
 <dc5d31a0-0f44-9c86-7b83-dd03f4ef4c04@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc5d31a0-0f44-9c86-7b83-dd03f4ef4c04@gmx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 25, 2023 at 06:24:42AM +0800, Qu Wenruo wrote:
> > Alternatively, can we create some error injection framework? In the
> > simplest form, define injection points in the code watching for some
> > conndition and trigger them from outside eg. set by an environment
> > variable. Maybe there's something better.
> 
> For injection framework, we at least need some way to trigger them by
> some possibility.
> Which can already be a little too complex.

I've implemented the environment variable approach, it's in devel and
example injection points are in the checksum switch. It's really simple
and I'm not sure I like it but at least we have a starting point.
