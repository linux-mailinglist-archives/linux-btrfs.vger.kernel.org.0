Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F247127F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 May 2023 16:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243796AbjEZOEj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 May 2023 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjEZOEi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 May 2023 10:04:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32267DF
        for <linux-btrfs@vger.kernel.org>; Fri, 26 May 2023 07:04:36 -0700 (PDT)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BBC21219E2;
        Fri, 26 May 2023 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685109874;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gOmzu/sZ0RftNPoKqZKfunHatN6jWd6bDDQRJN+5Sg8=;
        b=YfYVBW9HcqIqaeIio1HAHCt0cgjDhCocBdvIeFtIAFF1XbTt17E6M2n9XpfPPyQytY2NdD
        H5dtxJhjjvOLiSCDs+WpRzDuOQozxF4vRESc5S9y5IUGZS3G77TuLS+9Nv2HsrnctCpWzH
        jbQPbG6glS9RGLOT61OT1Cyk2Jda5bM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685109874;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gOmzu/sZ0RftNPoKqZKfunHatN6jWd6bDDQRJN+5Sg8=;
        b=Nx8QUgkFtHLI6cVDcSzxnLdHoXn2Lgwo076KhvihNqJrHYOzZ24qrVblJ+/ta5cLi2xcFQ
        C9kIPWKeCiPSr7DA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8821E134AB;
        Fri, 26 May 2023 14:04:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id LdiJIHK8cGTycgAAGKfGzw
        (envelope-from <dsterba@suse.cz>); Fri, 26 May 2023 14:04:34 +0000
Date:   Fri, 26 May 2023 15:58:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 15/21] btrfs: remove the extent_buffer lookup in btree
 block checksumming
Message-ID: <20230526135826.GD14830@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230503152441.1141019-1-hch@lst.de>
 <20230503152441.1141019-16-hch@lst.de>
 <1442e52f-9ba1-d9fa-f439-34d31b46800f@gmx.com>
 <20230526064123.GA10378@lst.de>
 <e288cd7d-2f49-f517-a406-b511cae36cb7@gmx.com>
 <20230526070316.GA11445@lst.de>
 <82f06b33-c440-b3d8-13bc-53001b14a898@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82f06b33-c440-b3d8-13bc-53001b14a898@gmx.com>
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

On Fri, May 26, 2023 at 03:25:25PM +0800, Qu Wenruo wrote:
> On 2023/5/26 15:03, Christoph Hellwig wrote:
> > On Fri, May 26, 2023 at 02:43:11PM +0800, Qu Wenruo wrote:
> >>>> Thus for any subpage mount, this would lead to transaction abort during
> >>>> metadata writeback.
> >>>>
> >>>> We have btrfs_page_clamp_test_uptodate() for this usage.
> >>>
> >>> True, this should use the sub page helper.  Or maybe just drop
> >>> this assert altogether?
> >>
> >> It may be better to keep it, as there is also another case related to
> >> subpage fs got its PageUptodate and bitmaps de-synced.
> >>
> >> Thus the assert can have a chance to catch such problem.
> >
> > Ok.  I don't really think we need the clamp version here, though.
> > Does this work for you?
> 
> Yep, it works.
> 
> And you're right, no need for clamp. For subpage the range would be
> inside the page anyway, and for regular cases, it's just PageUptodate().

Folded to "btrfs: remove the extent_buffer lookup in btree block
checksumming", thanks.
