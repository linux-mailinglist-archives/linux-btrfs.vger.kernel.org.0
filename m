Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0830154F8EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382696AbiFQOJR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 10:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382639AbiFQOJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 10:09:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479741EAE7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 07:09:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD29821DD6;
        Fri, 17 Jun 2022 14:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655474950;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w4IV58ysAmzaMcxMh6qbzS6O8m7ZlTNZtThStwR3m6A=;
        b=BQh+XTgyLUESV07s56SPl/Ymt+M6dUQuloRqKUDbXuOADiVpGu3YGOuqXCPteZH5BzKaN4
        iczeisqqhaEqsZiVUgiHe8+e1BkNCIf9ni4HLOJR0EULSN/JcJjiqfL5E+gyfwTO49ES57
        rWSOxIV1RD6yrdNr57wP3GA/bxrSqsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655474950;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w4IV58ysAmzaMcxMh6qbzS6O8m7ZlTNZtThStwR3m6A=;
        b=r5fdltUvk6R5N6XVpuCOQmDHY+15MEDVrOE0xxDN/caa9SdRoPPLICsRaDDowxifo7RAY0
        jvh8aGR7PdS4C5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB35813458;
        Fri, 17 Jun 2022 14:09:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ioHaLAaLrGJTJwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 17 Jun 2022 14:09:10 +0000
Date:   Fri, 17 Jun 2022 16:04:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: introduce BTRFS_DEFAULT_RESERVED macro
Message-ID: <20220617140436.GJ20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1655103954.git.wqu@suse.com>
 <51b17f7480724d528e709a920acd026acff447ea.1655103954.git.wqu@suse.com>
 <24bd65b9-d382-f55b-3640-add00b02f4e3@suse.com>
 <2307850a-4f38-19ab-48fd-47246f11cb4b@gmx.com>
 <20220616152042.GD20633@twin.jikos.cz>
 <17bbc7c6-c2e9-dcde-501e-0aad631e53e3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17bbc7c6-c2e9-dcde-501e-0aad631e53e3@gmx.com>
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

On Fri, Jun 17, 2022 at 09:47:49AM +0800, Qu Wenruo wrote:
> > I've dropped the default because right now it's not configurable and if
> > it eventually be then it can be renamed, but the write intent bitmap is
> > a work in progress so existing patches should not mention it. As said
> > before, naming the constant with a single point explaining the meaning
> > is a good cleanup on itself.
> 
> OK, I would rebase the branch and using thew new naming (and rename it
> if needed) after finishing the write-intent bitmaps feature (at least
> for the bitmaps update part)

Patches are now in misc-next.
