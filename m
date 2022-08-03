Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9F9588CDF
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 15:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbiHCNUg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 09:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbiHCNUe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 09:20:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E912C120A6
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 06:20:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 90A2437B77;
        Wed,  3 Aug 2022 13:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659532831;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tgYOr4hBvP3PYREGoRNCcpUoL65S5kKK5IqeC9kVyVM=;
        b=J1BRIvcb66VByGJZRUkWyLNgpH0+0lj61qxuDaurXvvdqTdC5I+MP6QRZKxzQLleGxWmVO
        UyEYqABd2/sWzcuV1CmTKRNvs3bXgLdM3XvJ1I/JxxJ036dbOnIGBohZ4/o9YZr9xwOkyZ
        30/DBVBDF3Kp9ip3LscrtNCaRv08CUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659532831;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tgYOr4hBvP3PYREGoRNCcpUoL65S5kKK5IqeC9kVyVM=;
        b=9VrNCnjk7yNAorYUgq35+l0lfLZfD9oQGjTCWA/cGqlT8z2roGpnZlw6GpHzFUdF91ciLx
        FlJCGzwZX+h5/mAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 730F513A94;
        Wed,  3 Aug 2022 13:20:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kiElGx926mJ9egAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 Aug 2022 13:20:31 +0000
Date:   Wed, 3 Aug 2022 15:15:29 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: use sysfs_streq for string matching
Message-ID: <20220803131529.GD13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220802134628.3464-1-dsterba@suse.com>
 <1e1a6e01-da6c-a82f-1606-6e548451884c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e1a6e01-da6c-a82f-1606-6e548451884c@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 03, 2022 at 04:01:23PM +0800, Anand Jain wrote:
> 
> David,
> 
>   We have user API breakage. Are you ok with that?

So technically it's change of behaviour, OTOH allowing initial/trailing
whitespace in the values is not common for other sysfs values. What is
accepted is trailing "\n" and that's what the helper provides. I'm not
sure why we allowed the extende format for the read policy. It should be
safe to do the change now as there are no other values so nobody was
writing to the file anyway.

> 
>   Before:
>    $ echo " pid" > ./read_policy
> 
>   After:
>    $ echo " pid" > ./read_policy
>      -bash: echo: write error: Invalid argument
>    $ echo "pid " > ./read_policy
>      -bash: echo: write error: Invalid argument

Yeah, do you have a usecase where the " " must be accepted? It may break
tests but I'd rather make it slightly more strict and cosistent.
