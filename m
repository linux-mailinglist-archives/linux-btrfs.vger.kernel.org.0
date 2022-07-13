Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41354573873
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 16:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbiGMOKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbiGMOKi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 10:10:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D6B26ADA
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 07:10:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F9C220195;
        Wed, 13 Jul 2022 14:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657721436;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53NWTpY6qGg38ra6AN84LPq0UEpkwMXbX/8SL4CmsX8=;
        b=1SovyGGQLVfA2joFvksMHuG7z04MjyBVn2AUyKxhlMofCK7dJ5KZKOjqyE0V9hPyLHU4cv
        bW45wTn0EdWHMZzKuXKSQWhFeenh3da11IWx+YizcfmnNFL3W8V7pCMU+NUoR6MMCZm9Jv
        qsWuF1dAwByJcKAcr8h3ZtcrnHVZDeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657721436;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53NWTpY6qGg38ra6AN84LPq0UEpkwMXbX/8SL4CmsX8=;
        b=ByN+UACD3hsUaADXnEv/U1WwcUxz5wHiKwEz2U4pcH5J0lZV1zklHtd1SaxiScC2WHc1E6
        vA3it/aBOOiFUFCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14D8813AAD;
        Wed, 13 Jul 2022 14:10:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pCAxBFzSzmJ5WAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Wed, 13 Jul 2022 14:10:36 +0000
Date:   Wed, 13 Jul 2022 16:05:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2] btrfs: don't save block group root into super block
Message-ID: <20220713140546.GH15169@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <40ce67d5bbb8f9c471b3c9a33504b0bb4022a51b.1657520391.git.wqu@suse.com>
 <866899c1-6952-e0f1-3a78-9caa483a7db9@suse.com>
 <4cd0eb6a-4893-a5c8-a758-947d8502368a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cd0eb6a-4893-a5c8-a758-947d8502368a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 11, 2022 at 04:44:36PM +0800, Qu Wenruo wrote:
> On 2022/7/11 16:27, Nikolay Borisov wrote:
> > On 11.07.22 г. 9:21 ч., Qu Wenruo wrote:
> >> The extent tree v2 (both thankfully not yet fully materialized) needs a
> >> new root for storing all block group items.
> >>
> >> My initial proposal years just added a new tree rootid, and load it from
> >> tree root, just like what we did for quota/free space tree/uuid/extent
> >> roots.
> >>
> >> But the extent tree v2 patches introduced a completely new (and to me,
> >> wasteful) way to store block group tree root into super block.
> >>
> >> Currently only two roots enjoying the privilege to stay in super blocks:
> >> tree root and chunk root.
> >>
> >> There is no special reason to store block group root into super block,
> >> even performance wise it doesn't make sense.
> >>
> >> So just move block group root from super block into tree root.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> >
> > Overall looks good but I'd like to hear Josef's take on this, but indeed
> > it's better to make those changes before unleashing extent v2.
> 
> Yep, that's exact the purpose of the patch.
> 
> In fact I have more things to discuss on the extent tree v2 things.

Yeah we need to discuss that in the group, I won't apply the patch as it
reverts the supposed preparatory changes of v2.
