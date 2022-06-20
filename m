Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8F65522B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 19:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242447AbiFTRUu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 13:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbiFTRUs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 13:20:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E22B1E3DE
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 10:20:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A330B1FDD7;
        Mon, 20 Jun 2022 17:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655745645;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K4JPG9NESX/5hGpKK7J1KfdulYxqIDxKPo04lkkWtJg=;
        b=festShkYDjcWMWAzK7V+djPW1Kv3VevGg7pYpn+m6Yijjl+E7TRmi96uHE14nrrcSX9RK+
        wynfqLoQl65Fc3JD362bUZq8y7M9zD2lViBAJh+2T8kGRXSyuQYXHtE2BjcVDAAohGaFkI
        BGAn/c9gM8cKi7gT2IktiIEOVScTRVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655745645;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K4JPG9NESX/5hGpKK7J1KfdulYxqIDxKPo04lkkWtJg=;
        b=8IBGscRrsELYi29M1jHUNvMrGgaks/yEZlzNbHrbEewbbs86Lj2I7B6+kVC2urMsNPg/QJ
        RZZsgReFdHbe1bDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 776C313638;
        Mon, 20 Jun 2022 17:20:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yWodHG2ssGJhLwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Jun 2022 17:20:45 +0000
Date:   Mon, 20 Jun 2022 19:16:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 01/10] btrfs: remove a bunch of pointles stripe_len
 arguments
Message-ID: <20220620171608.GU20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617100414.1159680-2-hch@lst.de>
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

On Fri, Jun 17, 2022 at 12:04:05PM +0200, Christoph Hellwig wrote:
> The raid56 code assumes a fixed stripe length.

The code does because it was part of the initial implementation but
raid56 as a feature wants a configurable stripe size, we have a super
block member for that. So the question is if passing the parameter is
such a burden so we'd rather remove it or keep it there though it's a
fixed value but still part of the design.

I'd rather keep it there so it gets used eventually, we have ongoing
work to fix the corner cases of raid56 so removing and adding it back
causes churn, but I'll give it another thought.
