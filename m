Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09068552043
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 17:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243877AbiFTPQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 11:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243499AbiFTPPz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 11:15:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B07B7C
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 08:05:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CD1621F74D;
        Mon, 20 Jun 2022 15:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655737498;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XkWXj7SItirN6+WfMnc2Pho8xWh+bs8zmHpfkHfAeOw=;
        b=1Z0Y/V9apkKJO+kH3xZQCmJp/50P+1kYCNWFvMBjebEhjYl9djGvEywQugpHbuTKJnGrYR
        evfqhbVF8DbavK3kBXjeepNlSRX6pYncwXiCRFZLixT2fE5yXOt1DWsS6VNJvlVfwV2tIq
        WeeoduhRlndSUJrYsMyTrGMoS6IKV+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655737498;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XkWXj7SItirN6+WfMnc2Pho8xWh+bs8zmHpfkHfAeOw=;
        b=0ILNHrLdjdy15/NWYkmjtEkxJqHDN2wrR+jB04GPv4k6H3MDceKRjbRPXFfhVx9o1rDyB8
        B4edrlf1N8434JCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D9E213638;
        Mon, 20 Jun 2022 15:04:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GsJjJZqMsGItcQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Jun 2022 15:04:58 +0000
Date:   Mon, 20 Jun 2022 17:00:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.com, Nikolay Borisov <nborisov@suse.com>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: don't limit direct reads to a single sector
Message-ID: <20220620150021.GQ20633@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        dsterba@suse.com, Nikolay Borisov <nborisov@suse.com>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
References: <20220616080224.953968-1-hch@lst.de>
 <a2dd54d7-ea9e-8647-261c-7d622f536f53@suse.com>
 <20220617155812.GB31552@lst.de>
 <20220620075216.GA12443@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620075216.GA12443@lst.de>
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

On Mon, Jun 20, 2022 at 09:52:16AM +0200, Christoph Hellwig wrote:
> David, I saw this patch is already in misc-next.  Do you want me to
> send an incremental patch or a new revision with the limit?  Incremental
> would look kinda silly, so I'd prefer the updated version.

Please send a v2 so we can see the limit code in context. Otherwise,
it also works to send an incremental in case it's something obvious.
Patches in misc-next are meant to be updated or replaced if needed, we
want to have self contained commits instead of fixes-on-fixes.
