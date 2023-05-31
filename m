Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C54718F1D
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 01:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjEaXo6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 19:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEaXo4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 19:44:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1119312C
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 16:44:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AEA7E21940;
        Wed, 31 May 2023 23:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685576693;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w00SzOWVcfBfLeUOYtCymAByjvaS7kFQJm6/LwcY230=;
        b=d0mINPuZaJiltdUTeufOXjvJ6dPpNIRdj05D+R+eorPqchry+nZPj3zjzbZ46hQosJbUn6
        xrz3LJHtbtCcc/4Dm2o4CkYdRPNk2WEXex19tmQ96U4Rx5jpRGnE2U9qRj3tQnXVqjBRNA
        t+hd2fgRyOA9ayYyR8XFRqyDXqxOVrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685576693;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w00SzOWVcfBfLeUOYtCymAByjvaS7kFQJm6/LwcY230=;
        b=6HFgtjRvhe88L8n5XqEuuEv8sCAN7pBeW6RIRLowmpASAP8TC01u1svsP9+ocs5iHvnIpE
        ZvfoLEus8yC5ZaBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EEA613488;
        Wed, 31 May 2023 23:44:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +dSnHfXbd2T8IgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 31 May 2023 23:44:53 +0000
Date:   Thu, 1 Jun 2023 01:38:41 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: cleanup the btrfs_map_block interface
Message-ID: <20230531233841.GG32581@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230531041740.375963-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531041740.375963-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 06:17:33AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> the interface around btrfs_map_block is a bit confusion, mostly due to
> the fact that it has a double-underscored complex version and two
> wrappers that just take a few arguments away.  This series cleans up
> a few loose ends to make this interface easier to understand.

Added to misc-next, thanks.
