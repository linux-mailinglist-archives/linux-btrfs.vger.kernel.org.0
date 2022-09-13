Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B5C5B6CA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Sep 2022 13:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiIML6P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Sep 2022 07:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiIML6M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Sep 2022 07:58:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062805F7C5
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 04:58:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0ED771FA03;
        Tue, 13 Sep 2022 11:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663070287;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JyX/cF7qHH6fMHCgajCKPjWKYCB6UQNPdnQaa/MZ5Fw=;
        b=NlhLjUYcrbt4ON+q+2yHtLa2FEXm2DenYWOEeboGL+q/gBtDJ15qNg4AyjicnCIhPBxmqH
        nKwmpDMpPrOFmggzyQTIcrOgA6+N9HFeEDUmcGU60lKbnj+As5ZE3Kq9Y7aj3NzMZa9k5u
        Urn2+lRlQUc2sQ4Nnx/gzQzFzFFNrII=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663070287;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JyX/cF7qHH6fMHCgajCKPjWKYCB6UQNPdnQaa/MZ5Fw=;
        b=xRDyE5ItaVnSh0NBB1M4aXsqOKUONAgaQ0lf6Y79BS//I7C78Rn2bxgZ1m6yGhhazu77e0
        db9AUTk4cOYiabBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4F9413AB5;
        Tue, 13 Sep 2022 11:58:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id spsHN05wIGO0cgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 13 Sep 2022 11:58:06 +0000
Date:   Tue, 13 Sep 2022 13:52:40 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fix a couple of hangs during unmount caused
 by races
Message-ID: <20220913115240.GJ32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1662636489.git.fdmanana@suse.com>
 <20220909143254.GZ32411@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909143254.GZ32411@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 09, 2022 at 04:32:54PM +0200, David Sterba wrote:
> On Thu, Sep 08, 2022 at 12:31:49PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Due to some races or bad timmings, we can hang during unmount when trying
> > to stop the block group reclaim task or one of the space reclaim tasks.
> > The second case if often triggered by generic/562 for a while, but the
> > underlying problem has been there for a long time, despite seeming to be
> > more frequent recently. More details in the changelogs.
> > 
> > Filipe Manana (3):
> >   btrfs: fix hang during unmount when stopping block group reclaim worker
> >   btrfs: fix hang during unmount when stopping a space reclaim worker
> >   btrfs: remove useless used space increment during space reservation
> 
> Added to for-next, thanks.

Moved to misc-next, thanks.
