Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80C87BBBCC
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Oct 2023 17:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjJFPeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Oct 2023 11:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjJFPep (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Oct 2023 11:34:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CEE9E
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Oct 2023 08:34:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 21B111F8A4;
        Fri,  6 Oct 2023 15:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696606483;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZxL0l7FoSysR5PI9zeM6gBaTo/kimtAL/SuCxINYsrw=;
        b=ZMXtZogQehErKWU3IvQiH6WZ+lANcf9z3Pf/Hzx/YEf/ZOWnJ5e/yU+9Z/seuyNQ2kOSME
        nF1xq8BmeF7sobEnzimngLCrzms7d3a5LoeVJETaAGxtkqMTnAoFGCJUMQFqpGso21PgoO
        UjPmuHugUJ2Y5l1U435WBrrfXTPzwzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696606483;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZxL0l7FoSysR5PI9zeM6gBaTo/kimtAL/SuCxINYsrw=;
        b=TzNACNQhTRwDiUZzNJx4Ed06U/V0fA+t9wKKeqi6RkL2JqTK/Py75ha6FRh0XVGnn97ozu
        VOtAg+WarVBskLAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00C3813A2E;
        Fri,  6 Oct 2023 15:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u0IPOxIpIGUIAwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 06 Oct 2023 15:34:42 +0000
Date:   Fri, 6 Oct 2023 17:27:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: update on-disk format for
 raid-stripe-tree
Message-ID: <20231006152759.GI28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231005-rst-update-v1-0-7ea5b3c6ac61@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-rst-update-v1-0-7ea5b3c6ac61@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 05, 2023 at 11:58:01PM -0700, Johannes Thumshirn wrote:
> This series brings the RAID stripe tree on-disk format in btrfs-progs to
> the same level as the kernel.

I've added changelogs explaining that it's been removed in kernel. The
previous RST series has been released so we can't do fixups.
