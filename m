Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DF67B564D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 17:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbjJBP27 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 11:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbjJBP26 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 11:28:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BBAA9
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 08:28:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 48222210E6;
        Mon,  2 Oct 2023 15:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696260535;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0rP7AZihwg6z+gcZBkwWxmA6+tl3nU5dUz+Br5M/j2g=;
        b=TWZAS3is+mWJsOt2g6X3jiPvFE4SjM0tBuMW4Rt/TwzVpjam12x4JWHeA8RfGS04cbpeG4
        De+QBu9ib811+z9WRA8YT8Urn2LOtS+MSpioGXmuEUupunG8ohA/8qbzhO8TyuX7J9HiAU
        AQl+af5pK6PWpTJvu56PydYnSxnQieo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696260535;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0rP7AZihwg6z+gcZBkwWxmA6+tl3nU5dUz+Br5M/j2g=;
        b=WATZFOl25l7c8vJuRgVJejw4o9rNuI5V5INEoB7t10tVVu6m6rBmA2LW3dMiAbstgS5KR5
        XcYM/7sJ+j/WDWDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 212E313456;
        Mon,  2 Oct 2023 15:28:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rNo+B7fhGmWLBAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 15:28:55 +0000
Date:   Mon, 2 Oct 2023 17:22:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, gpiccoli@igalia.com
Subject: Re: [PATCH 1/2] btrfs-progs: allow duplicate fsid for single device
Message-ID: <20231002152213.GS13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695861950.git.anand.jain@oracle.com>
 <9a18c9a1dcf857c3e505994d488facda4bcf37f2.1695861950.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a18c9a1dcf857c3e505994d488facda4bcf37f2.1695861950.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 28, 2023 at 09:09:18AM +0800, Anand Jain wrote:
> For single device btrfs filesystem, allow duplicate fsid to be created.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

As this is trivial I'll add it to devel now, but the other patch needs
updated.
