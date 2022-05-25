Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B66534176
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 18:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiEYQYo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 12:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiEYQYn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 12:24:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45898148B
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 09:24:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B9C41F918;
        Wed, 25 May 2022 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653495880;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l8hiuF8omc9ibeK979/TU5lOAFJo/9OJbkA2I4bWgQo=;
        b=06qgUD55Gm1dAM6H6AjdUXMaLk5mZuTapLc5abmt6uaIEHI7f1IB68RIfq8EhP9/2YjTKB
        +y3DB1OCKkN7qn/DUr2ML8qy8p21u2zw4YDTD57AXs5XtHnX5vwsIV1TyJpN9bH5VSTvU9
        tvuE0EPBNc6l6lpbHL283E34689Qx8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653495880;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l8hiuF8omc9ibeK979/TU5lOAFJo/9OJbkA2I4bWgQo=;
        b=7lb8G62ZNhUky9JBq7aeVgxz3wSRhKX9cLEhYHy1uax/w+4Oxs9IjNwpfJ4u3D0vna67fp
        0OdgKP3wOzpDF6DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 507F313487;
        Wed, 25 May 2022 16:24:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CmbHEkhYjmJKJQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 25 May 2022 16:24:40 +0000
Date:   Wed, 25 May 2022 18:20:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 2/8] btrfs: introduce a pure data checksum checking helper
Message-ID: <20220525162017.GE22722@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@lst.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
References: <20220522114754.173685-1-hch@lst.de>
 <20220522114754.173685-3-hch@lst.de>
 <d459113f-7325-ebe9-77de-6639c646f0df@gmx.com>
 <20220524072458.GA26145@lst.de>
 <6423b926-c5b2-612c-ccac-0cb9ee29984f@gmx.com>
 <20220524081110.GA27062@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524081110.GA27062@lst.de>
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

On Tue, May 24, 2022 at 10:11:10AM +0200, Christoph Hellwig wrote:
> On Tue, May 24, 2022 at 04:07:41PM +0800, Qu Wenruo wrote:
> >> -			    u32 pgoff, u8 *csum, u8 *csum_expected);
> >> +			    u32 pgoff, u8 *csum, u8 * const csum_expected);
> >
> > Shouldn't it be "const u8 *" instead?
> 
> No, that would bind to the pointer.  But we care about the data.

Then it could be 'const u8 * const csum_expected'. The consts are not
everywhere I would like them to see so in new code I care a bit more and
add it when applying patches.
