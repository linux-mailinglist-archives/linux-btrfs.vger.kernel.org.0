Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89E97BE4B9
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 17:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376502AbjJIP34 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 11:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346514AbjJIP3z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 11:29:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E13DA3;
        Mon,  9 Oct 2023 08:29:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 596911F390;
        Mon,  9 Oct 2023 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696865392;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1HqVDwiKT9mbTGEItnnXsmJW+0BorQwUwbFjLDILKpM=;
        b=IBt9Zzx2vnJP6XRjCOrKnO5zaH9qGvhlvFzX23Np5EN62Oka65H94E02xzbrf2BF2j2hYP
        OkJFMDYyth0+YKWqpE8gZf/nEYM6P9u5OT5oGsQq8kLvUuQrnNMUOq+uI3O+dOkWhobYVE
        MBtaz7oU8HkN92ra4x/WuptgJ4+sRsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696865392;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1HqVDwiKT9mbTGEItnnXsmJW+0BorQwUwbFjLDILKpM=;
        b=FoC9feVo75wyhxH+ko20yCQhE2NzB0aY1NCI+iAyPXNH9DLlo/DznBcljU7/bC8PLaeqys
        oH9uSBdq6JhXmiDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02E5A13586;
        Mon,  9 Oct 2023 15:29:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AEc+O28cJGVpMQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 09 Oct 2023 15:29:51 +0000
Date:   Mon, 9 Oct 2023 17:23:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Potapenko <glider@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-btrfs@vger.kernel.org,
        dm-devel@redhat.com, ntfs3@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/14] btrfs: rename bitmap_set_bits() ->
 btrfs_bitmap_set_bits()
Message-ID: <20231009152306.GQ28758@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20231009151026.66145-1-aleksander.lobakin@intel.com>
 <20231009151026.66145-8-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009151026.66145-8-aleksander.lobakin@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 09, 2023 at 05:10:19PM +0200, Alexander Lobakin wrote:
> bitmap_set_bits() does not start with the FS' prefix and may collide
> with a new generic helper one day. It operates with the FS-specific
> types, so there's no change those two could do the same thing.
> Just add the prefix to exclude such possible conflict.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Acked-by: David Sterba <dsterba@suse.com>

We don't have any other code pending that would potentially collide with
this change so I don't care when and via which tree this gets merged. I
can take it by btrfs too.
