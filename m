Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5910B54C739
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 13:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347200AbiFOLOt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 07:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346695AbiFOLOs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 07:14:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E763E3B2A0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 04:14:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9344321C5E;
        Wed, 15 Jun 2022 11:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655291686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLBFzSbQjbJYnEYflsSOG+Jqxa7H0Fbf95dDXs99v2o=;
        b=K2lGjO/ZNCayt6D2COb0MHEzrXe7WmJ03n9vX7NJQkLQpS4VWUYUKtI11vEmUv+jH1+bpN
        H49/qQQ6OkmTctKVeOqb8b1mqNGANqMmfy16noByHKrV4oCa1EVeGhmZiT16qt9uFOCeLi
        2JFINvsgnEbxHRyX+vUIY41JOcg0I3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655291686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLBFzSbQjbJYnEYflsSOG+Jqxa7H0Fbf95dDXs99v2o=;
        b=nrQ5A16PGikr3cFAHE7Lvgzk7cTGAspyJVWjimoxyhwy7tU85su+nX6XYN2lFiW/RsdC61
        OlpVrZ9dsLfFiAAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 644D313A35;
        Wed, 15 Jun 2022 11:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yAyBFya/qWKLbAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 15 Jun 2022 11:14:46 +0000
Date:   Wed, 15 Jun 2022 13:10:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [btrfs] [confidence: ] b3eab9f80b:
 kernel_BUG_at_fs/btrfs/raid56.c
Message-ID: <20220615111012.GQ20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        kernel test robot <oliver.sang@intel.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, lkp@lists.01.org, lkp@intel.com
References: <20220615062938.GA36441@xsang-OptiPlex-9020>
 <11a59839-de31-a088-cf04-70a1a2cd07ee@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11a59839-de31-a088-cf04-70a1a2cd07ee@gmx.com>
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

On Wed, Jun 15, 2022 at 03:12:08PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/6/15 14:29, kernel test robot wrote:
> >
> >
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-11):
> >
> > commit: b3eab9f80b60e3333e3ce3a7b7fbd323c71b00b1 ("btrfs: raid56: avoid double for loop inside raid56_rmw_stripe()")
> > https://github.com/kdave/btrfs-devel.git dev/sb-own-page
> 
> That's already an older commit.

Also that's from my WIP branch from last week, that was based on your
raid patches at that time. The fixed v3 has been merged meanwhile and
new version of the superblock and page is not merged yet.
