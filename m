Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9CA628DC9
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 00:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbiKNXzH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 18:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbiKNXzE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 18:55:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D28810FDA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 15:55:04 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F1C0A336C2;
        Mon, 14 Nov 2022 23:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668470102;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bx3cA3aDWCUA4TOTjggqi/ffIc1zkauy9OBv/M8mnQo=;
        b=rOGXDbXPB7MXU/KTQz9pSpA7SVpj9v3Hzj4EwCZY+ngYBKEOTJduvoXCRZBo5hc2Bpjyt+
        cCH7zBovTyKGxT55fBa3v2AxCkW97XHQh7iH5ut55KvmpxAzWuNYMPDhnJ+XcjGpPtTTZg
        IT/lqoNMfrd6EeYk9ibxVm9yg3tvppY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668470102;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bx3cA3aDWCUA4TOTjggqi/ffIc1zkauy9OBv/M8mnQo=;
        b=zvWiZi0wiVN8nXTH3MiK2b5AbfTOJP+NEWOG4Y94HCjN3hq06nwr4+bcD6/Gx5cysEu+/E
        WwK5WNi7BRnlhmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4EA113276;
        Mon, 14 Nov 2022 23:55:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aOW2KVbVcmNHAQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 14 Nov 2022 23:55:02 +0000
Date:   Tue, 15 Nov 2022 00:54:36 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     kreijack@inwind.it, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: use btrfs_dev_name() helper to handle missing
 devices better
Message-ID: <20221114235436.GD5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1668384746.git.wqu@suse.com>
 <3382bb8f7ab90e52ffa86cb39253ab5bdb78026e.1668384746.git.wqu@suse.com>
 <516619f0-2111-a259-6685-823ea48c959b@libero.it>
 <1f48d516-4016-d81a-78d9-62b34f7142c7@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f48d516-4016-d81a-78d9-62b34f7142c7@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 06:40:30AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/11/15 00:06, Goffredo Baroncelli wrote:
> > On 14/11/2022 01.26, Qu Wenruo wrote:
> > [...]
> >> @@ -770,6 +771,14 @@ static inline void btrfs_dev_stat_set(struct 
> >> btrfs_device *dev,
> >>       atomic_inc(&dev->dev_stats_ccnt);
> >>   }
> >> +static inline char* btrfs_dev_name(struct btrfs_device *device)
> > 
> > Because we are returning a static char*, should we mark the return
> > values as "const char*" ?
> > 
> > static inline const char* btrfs_dev_name(struct btrfs_device *device)
> 
> Right, that would be more accurate.
> 
> Not sure if David can fold this change during merging.

No problem, updated.
