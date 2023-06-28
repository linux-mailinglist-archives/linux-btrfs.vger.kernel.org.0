Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AAF741909
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 21:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjF1Twc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 15:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF1Twa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 15:52:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305541FD8
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 12:52:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD13921866;
        Wed, 28 Jun 2023 19:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687981946;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oXxAr/Lg8kF42S7u3Z8kA8Riy6dkuS/HBDR+Ri0LLRo=;
        b=lQ3+mRKibvl8czyrEybZf6jeDf0jW23YPOXSOzL61NEEdCgkz5LXdkdw86xtShBKB/5eGR
        BWuDnSkWMwwSk5kCifYscjzF1xcIAA4FUpA/OcVxqqmEq1U0NFZvgiPTz2Sq3VjhHcKmXr
        0+fwvAF+v8WNdIdEluz20fwiXM6Crfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687981946;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oXxAr/Lg8kF42S7u3Z8kA8Riy6dkuS/HBDR+Ri0LLRo=;
        b=23HcIsSjuD9lBzXZvb+78McFRcJ5V+i+givmM1QnSjSh8FUt8QJ1ow3UBoWNTAuIwhTyI+
        OamtuJH9D9ubhZBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AED2E138E8;
        Wed, 28 Jun 2023 19:52:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BePWKXqPnGTzMQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 28 Jun 2023 19:52:26 +0000
Date:   Wed, 28 Jun 2023 21:45:58 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs-progs: tests: fix warnings during make test
Message-ID: <20230628194558.GD16168@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1687485959.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687485959.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 23, 2023 at 03:58:58PM +0800, Anand Jain wrote:
> This set of patches addresses the warnings when running the following commands:
> 
>   $ rm fssum fsstress
>   $ make test
> 
> Ensure cleaner test suite for btrfs-progs.
> 
> Anand Jain (4):
>   btrfs-progs: tests/fssum.c: fix missing prototype warning
>   btrfs-progs: tests/fsstress.c: move do_mmap under HAVE_SYS_MMAN_H
>   btrfs-progs: tests/fsstress.c: move do_fallocate under
>     HAVE_LINUX_FALLOC_H
>   btrfs-progs: tests/fsstress.c: move delete_subvol_children under
>     HAVE_BTRFSUTIL_H

Added to devel, thanks.
