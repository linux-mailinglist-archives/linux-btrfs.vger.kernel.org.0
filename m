Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7567A0D76
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 20:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241876AbjINSuQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 14:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241892AbjINSuG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 14:50:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AE4E8B07
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 11:43:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3DC5121854;
        Thu, 14 Sep 2023 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694717025;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+R1d8wbAZr6q6wORqlrd9Dwbu2kqOQAIACphbVOe4ak=;
        b=LHm4ElxrWUWC6WRuop2zMOrbdgqjZT84xLczrtykVlud/a4ZxDaUvP0EVvDvuzXUJJjV7N
        7/7YpCEMAw0/Pvqr7kT9FzH/BrAH5tz+61CWZzKMNtSBgKO0yiPgIMxX025/CBBehU9rpc
        r9PLr3Pq1zyXFF8MyEtZ035OWFKTFrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694717025;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+R1d8wbAZr6q6wORqlrd9Dwbu2kqOQAIACphbVOe4ak=;
        b=ogQ7Rq99Kkq2FyfvuBq0OHXci7o/AApSrRmOFyj77NStFvPRZjL+PGdotceqINwqEgXVX9
        Ei1/LzyyV+s4GzBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2011D139DB;
        Thu, 14 Sep 2023 18:43:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yW8AB2FUA2W4bAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 14 Sep 2023 18:43:45 +0000
Date:   Thu, 14 Sep 2023 20:43:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/6] btrfs-progs: add support for RAID stripe tree
Message-ID: <20230914184342.GE20408@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-raid-stripe-tree-v4-0-c921c15ec052@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 14, 2023 at 09:05:31AM -0700, Johannes Thumshirn wrote:
> This series adds support for the RAID stripe tree to btrfs-progs.
> 
> RST is hidden behind the --enable-experimental config option.
> 
> This series survived 'make test' with and without experimental enabled.
> 
> ---
> Changes in v4:
> - Adopt to on-disk format changes
> - Link to v3: https://lore.kernel.org/r/20230911-raid-stripe-tree-v1-0-c8337f7444b5@wdc.com

I've added the series to devel, with some fixups. Any updates please
send as incrementals. Thanks.
