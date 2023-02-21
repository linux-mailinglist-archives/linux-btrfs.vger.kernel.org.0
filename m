Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCD269EB41
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 00:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjBUX2v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 18:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjBUX2u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 18:28:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADD71C7E3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 15:28:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4A47335230;
        Tue, 21 Feb 2023 23:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677022128;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5dlbPG52PyA3Hc+6wOmYfu4jUSGN0Q/SFzJ+XF4MO2c=;
        b=mUYk3aoMEdjzhamX08dYtz1fibZTDnOPu7LDBPfYOY9BW1BtCUk0C7xL3ciHD7zGfVpS+P
        klf+HJXGytFNDRXlLwZ+uSAI3Nhi3ZWsB811pxVS57gHec6OH5CiJn5kspLdQf/46WtpwX
        9v2jNHhtfgLjyRgCadKbfGVbx9KARzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677022128;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5dlbPG52PyA3Hc+6wOmYfu4jUSGN0Q/SFzJ+XF4MO2c=;
        b=jH1QTlTDVQbTWs7S9jxSeqhwsAHoCazQ9mrj3+AGjtr7h7Ux9YlKv7hjxa7+x3zo7seo5N
        Gsbs/Q1T5d5QBPBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C1CC13223;
        Tue, 21 Feb 2023 23:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hF/tBLBT9WPPXAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 21 Feb 2023 23:28:48 +0000
Date:   Wed, 22 Feb 2023 00:22:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: fixes for the cli test group
Message-ID: <20230221232252.GR10580@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1676265837.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1676265837.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 13, 2023 at 01:26:31PM +0800, Qu Wenruo wrote:
> For the current devel branch, there are two failures for the cli test group:
> 
> - cli/009
>   This is caused by a very recent (only in devel branch) refactor for
>   btrfstune, which removes the ability to customize the return value.
> 
>   Fix it by adding a new @ret argument for usage() helper.
> 
> - cli/017
>   This exists for a while, and it's caused by a recent kernel change.
> 
>   Fix the test case to handle it better.
> 
> Qu Wenruo (2):
>   btrfs-progs: make usage() call to properly return an exit value
>   btrfs-progs: tests: cli: fix 017 test case failure

Added to devel, thanks.
