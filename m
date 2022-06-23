Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E292557DED
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 16:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiFWOdq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 10:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiFWOdq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 10:33:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C983EB86
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 07:33:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E89361F8B4;
        Thu, 23 Jun 2022 14:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655994823;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iGqRIjGnsDlZypFokHrpqEk6C42gBdxNn7tHFO2TdbE=;
        b=3cTj/TREnGYEUANoiKVmVnvfqcI5q0G+NhcdFJEMyBFI1OQ3ylDJ+P89whfAzmsuv0nahH
        v7N1XHdtzyIwK19vKmciki1LWIb5rmAOdZaK1ae7D3G7FkvsUu8MuuURFtX6n5ljuukwjP
        jJsRK3e6SjyxR6JXHzxjACvrFSKPDEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655994823;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iGqRIjGnsDlZypFokHrpqEk6C42gBdxNn7tHFO2TdbE=;
        b=fF5RfR/OOqxsYLdXsXMEVTEvIFXew9TPAGTWFgWVzs7KCuBPXW8BjKhdnbbr2Rnx7pGtO4
        5cay5XLpurk6jCDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFB04133A6;
        Thu, 23 Jun 2022 14:33:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mbvZMcd5tGKjTQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Jun 2022 14:33:43 +0000
Date:   Thu, 23 Jun 2022 16:29:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] More send v2 updates: otime, fileattr
Message-ID: <20220623142905.GR20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1655299339.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1655299339.git.dsterba@suse.com>
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

On Wed, Jun 15, 2022 at 03:24:55PM +0200, David Sterba wrote:
> New protocol enhancements:
> 
> - send otime with utimes command
> - rename SETFLAGS to FILEATTR and send the btrfs inode flags
> - other cleanups
> 
> David Sterba (6):
>   btrfs: send: add OTIME as utimes attribute for proto 2+ by default
>   btrfs: send: add new command FILEATTR for file attributes
>   btrfs: send: drop __KERNEL__ ifdef from send.h
>   btrfs: send: simplify includes
>   btrfs: send: remove old TODO regarding ERESTARTSYS
>   btrfs: send: use boolean types for current inode status

Moving from topic branch to misc-next. I got no feedback on the protocol
extensions, there's still time though.
