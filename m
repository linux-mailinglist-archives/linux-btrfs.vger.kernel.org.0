Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690C97B569F
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Oct 2023 17:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbjJBPYH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 11:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbjJBPYE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 11:24:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E79B3
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 08:23:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0DB012185E;
        Mon,  2 Oct 2023 15:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696260238;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U3Z1KWffrjuHzHCDVehEpdJv+75wYbTGXzFjoFStG9g=;
        b=cD540cF01E0/3OKLAmMvwZlsWKgSsq6QDj1zy8tV0vWYrMQ3a2/lb1gi1clXGHD9tc1ejw
        BlowtXabWNWPE1oYHRa5/IzjAgpROPP6CE13HNOIEHxFQUUeXBhWGUb2kLKIZv3GbYDX9E
        xzrF26kZIchSWMwcZniv2J2n4lIDZ/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696260238;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U3Z1KWffrjuHzHCDVehEpdJv+75wYbTGXzFjoFStG9g=;
        b=Wl1P5X2G2MKLs2dl3rrNPOp74lLlutjl8w8q78FfbG9yVNtpBmLLoYma0QepmhMQabl7+0
        7cwKmTMvq0tTUZDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC17C13456;
        Mon,  2 Oct 2023 15:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cP+YOI3gGmUGAgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 02 Oct 2023 15:23:57 +0000
Date:   Mon, 2 Oct 2023 17:17:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: -Wshadow fixes
Message-ID: <20231002151716.GQ13697@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1695873867.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695873867.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 28, 2023 at 01:36:32PM +0930, Qu Wenruo wrote:
> Since -Wshadow is enabled recently, there are two new warnings:
> 
> - @e from cmd_inspect_list_chunks()
> - @csum from print_header_info()
>   This needs experimental features to be enabled
> 
> Just fix them all.
> 
> Qu Wenruo (2):
>   btrfs-progs: remove variable e from cmd_inspect_list_chunks()
>   btrfs-progs: fix a variable shadowing when enabling experimental
>     features

Added to devel, thanks.
