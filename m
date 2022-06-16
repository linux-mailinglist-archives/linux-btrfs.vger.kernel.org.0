Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7FB54E5FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377669AbiFPPZU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377611AbiFPPZS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 11:25:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058072BB2F
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 08:25:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B44FB21B4E;
        Thu, 16 Jun 2022 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655393116;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/pANSUDMIXOW5repXyl010xHqgXnbDNY+2g5VTs0Go=;
        b=sPrC/WDvs0KTSijXm/dTZVUB1pqytg25PzuLMOrZzMuESnkU6f72hqGtcFcanuKuaZ9CdK
        /DdP3qRswpU/xB158rprTq+epCHrLsk82+OFk16U8JGsMruXuzQ3+yAfVhhf7/XQobCVOy
        /Al/62K6yOO75RV5I7J060UCSZ3a5QM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655393116;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y/pANSUDMIXOW5repXyl010xHqgXnbDNY+2g5VTs0Go=;
        b=VE/JNrZPPz0N8eUs0hBO+Lwq6thQjQt1F839EmtOU4FSZBbwrC9u2cT3WYijeEIF8DW8/j
        rPo2rTOupXnPdaBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D9EB1344E;
        Thu, 16 Jun 2022 15:25:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AleoHVxLq2K1QgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 16 Jun 2022 15:25:16 +0000
Date:   Thu, 16 Jun 2022 17:20:42 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: introduce BTRFS_DEFAULT_RESERVED macro
Message-ID: <20220616152042.GD20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1655103954.git.wqu@suse.com>
 <51b17f7480724d528e709a920acd026acff447ea.1655103954.git.wqu@suse.com>
 <24bd65b9-d382-f55b-3640-add00b02f4e3@suse.com>
 <2307850a-4f38-19ab-48fd-47246f11cb4b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2307850a-4f38-19ab-48fd-47246f11cb4b@gmx.com>
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

On Mon, Jun 13, 2022 at 05:36:19PM +0800, Qu Wenruo wrote:
> >> index f7afdfd0bae7..62028e7d5799 100644
> >> --- a/fs/btrfs/ctree.h
> >> +++ b/fs/btrfs/ctree.h
> >> @@ -229,6 +229,13 @@ struct btrfs_root_backup {
> >>   #define BTRFS_SUPER_INFO_OFFSET            SZ_64K
> >>   #define BTRFS_SUPER_INFO_SIZE            4096
> >> +/*
> >> + * The default reserved space for each device.
> >> + * This range covers the primary superblock, and some other legacy
> >> programs like
> >> + * older bootloader may want to store their data there.
> >> + */
> >> +#define BTRFS_DEFAULT_RESERVED            (SZ_1M)
> >> +
> >
> > The name of this macros is too generic and uninformative. How about
> > BTRFS_BOOT_RESERVED or simply BTRFS_RESERVED_SPACE, because
> > BTRFS_DEFAULT_RESERVED implies  there is something else, apart from
> > "default" and there won't be ...

I've renamed it to BTRFS_DEVICE_RANGE_RESERVED

> BTRFS_RESERVED_SPACE sounds good. The "BOOT_RESERVED" part will
> definitely lose its meaning in the long run, since now there is no
> modern bootloader really doing that.
> (Either go full ESP, like systemd-boot, or extra reserved partition like
> GRUB2, or use unpartitioned space after MBR like the legacy GRUB1)

Yeah the bootloader is there as a known example, but what will happen
with bootloaders in the long run we can't predict, so the reserved space
will stay.

> But "DEFAULT" is here because later we will enlarge the reserved space
> (for write-intent map, and will introduce a new super block member to
> indicate exact how many bytes are reserved), and I don't want to add
> "DEFAULT" when we introduce that new reserved behavior.

I've dropped the default because right now it's not configurable and if
it eventually be then it can be renamed, but the write intent bitmap is
a work in progress so existing patches should not mention it. As said
before, naming the constant with a single point explaining the meaning
is a good cleanup on itself.
