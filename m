Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618D2779371
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Aug 2023 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjHKPpk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Aug 2023 11:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjHKPpk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Aug 2023 11:45:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E162120
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Aug 2023 08:45:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D2081F895;
        Fri, 11 Aug 2023 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691768738;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FkUt5xS+Z8c+PoO+0rD3VznXR8Bx3oQyFWaJ2qA4Z9k=;
        b=al8MexMosXC9tQAdhglPVNRaq4AFButoML9BySO1LgoZ40Skbhsps8mwFI5X9dIOkQbH4T
        S86EsVN2PlZl1aQCKiyDILRCvqFtG78b0APacX8UMY1Q3wM1dlWqEHvWKyC3JCh1JUvSVr
        1wKXyKkNOB3j28O0Jpl1IJTEm8kQrnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691768738;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FkUt5xS+Z8c+PoO+0rD3VznXR8Bx3oQyFWaJ2qA4Z9k=;
        b=oq/uMGxp49L+NaomyS0aUUoEGg34AKkN0le30vtwu4AJQ8CUXJT5JgzRXyzeAD31WcDNP9
        7xpn+sh/rlnnM+BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D32E13592;
        Fri, 11 Aug 2023 15:45:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rpopDqJX1mQgOgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 11 Aug 2023 15:45:38 +0000
Date:   Fri, 11 Aug 2023 17:39:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 6/7] btrfs: add a superblock helper to read metadata_uuid
 or NULL
Message-ID: <20230811153913.GS2420@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1690792823.git.anand.jain@oracle.com>
 <5ab449690af1ec46c64ff6dad0d3702c5ebbe18c.1690792823.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab449690af1ec46c64ff6dad0d3702c5ebbe18c.1690792823.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 31, 2023 at 07:16:37PM +0800, Anand Jain wrote:
> This is preparatory patch next two patches.

There's only one more patch 7/7 and given how short the helper is it
could be done in one patch. The split for perparatory work and actual
use applies more to bigger helpers.
