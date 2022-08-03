Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087EC5892CB
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 21:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbiHCTai (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 15:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbiHCTaT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 15:30:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE715B7A1
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 12:30:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 35EAC34BD7;
        Wed,  3 Aug 2022 19:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659555003;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wdiJvRqmMh1kUJU+gCpTLeRKgBWuos/Ofg4M1pPK1SE=;
        b=ZPoNtEaMC84phiy6zDOP2gVxFGHHjL5ivpnatZdMdBgVBDjWbpOrdPikm6iFG7oBXbdZvf
        MvwQHLOwsoVNZhuUxhZPVFHuCKxWlSmW3QrC/OKwC2+XCAScqIhK2JKHdSTDakQoDgNIJ8
        3zQSSmJg9sx9q4j+rF6Lw6NDUGS9hok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659555003;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wdiJvRqmMh1kUJU+gCpTLeRKgBWuos/Ofg4M1pPK1SE=;
        b=dnH0jQiYdxbOAM882L3BeeaqiaNGGO6pJZk6+yZgPBCaRyjRnZs0fmCpt/LwUjfi7lznSB
        EXUmSceQfrKbFiDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A15513AD8;
        Wed,  3 Aug 2022 19:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eGSKAbvM6mK1GAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 03 Aug 2022 19:30:03 +0000
Date:   Wed, 3 Aug 2022 21:25:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs-progs: avoid repeated data write for
 metadata and a small cleanup
Message-ID: <20220803192500.GJ13489@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1659426744.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659426744.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 02, 2022 at 03:52:40PM +0800, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Separate the fixes from the initial patch
> - Fix a bug in BUG_ON() condition which causes mkfs test failure
> 
> There is a bug report from Shinichiro that for zoned device mkfs -m DUP
> (using RST) doesn't work.
> 
> It turns out to be a bug in commit 2a93728391a1 ("btrfs-progs: use
> write_data_to_disk() to replace write_extent_to_disk()"), which I
> wrongly assumed that write_data_to_disk() will only write the data to
> one mirror.
> 
> In fact, write_data_to_disk() writes data to all mirrors, thus the
> @mirror argument is completely unnecessary.
> 
> The first patch will fix the problem and cleanup the unnecessary
> argument to avoid confusion.
> 
> Then the 2nd patch will fix a BUG_ON() condition.
> 
> Finally the last patch will cleanup write_and_map_eb() to completely
> rely on write_data_to_disk(), without manually handling RAID56. 
> 
> 
> Qu Wenruo (3):
>   btrfs-progs: avoid repeated data write for metadata
>   btrfs-progs: fix a BUG_ON() condition for write_data_to_disk()
>   btrfs-progs: use write_data_to_disk() to handle RAID56 in
>     write_and_map_eb()

Added to devel, thanks.
