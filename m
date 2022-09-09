Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512FF5B3802
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiIIMkU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 08:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIIMkS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 08:40:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BCF4DF14
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 05:40:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E6501F8E3;
        Fri,  9 Sep 2022 12:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662727214;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8HpSvC73hx9bm6v+pQ6AMfSUa4kW9Mp1wNXR+ewE2HQ=;
        b=e4WM7Nhv+AdBpYUYSQYqWdeLcCRiDqBL1ZVgBuKxJYHK7NOW3PbdbAZhq+b8lGUATBdRcU
        ghQHR3kNeluAL+GkDDz59lzP8UVFfmmhr2HhNNeaZnYzDO9Fy3LKQmW7ORvkTXauedI0R+
        k5q26gV4yspvnGJ42aputETcdjt5elw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662727214;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8HpSvC73hx9bm6v+pQ6AMfSUa4kW9Mp1wNXR+ewE2HQ=;
        b=9djl5ezDH6PW5gUTa8fbf4T9Ro3fHoTAaXErPNDeys3DUnOTRjzjh5cuJG9PahNceaeshq
        k9REJk9Yn8oXyjAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E628213A93;
        Fri,  9 Sep 2022 12:40:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mQj1NS00G2MQMAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 09 Sep 2022 12:40:13 +0000
Date:   Fri, 9 Sep 2022 14:34:49 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: btrfs I/O completion cleanup and single device I/O optimizations
 v2
Message-ID: <20220909123449.GW32411@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20220713061359.1980118-1-hch@lst.de>
 <20220906131201.GM13489@twin.jikos.cz>
 <20220907090826.GA31659@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907090826.GA31659@lst.de>
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

On Wed, Sep 07, 2022 at 11:08:26AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 06, 2022 at 03:12:01PM +0200, David Sterba wrote:
> > Let me point out one example, the 5/11 "btrfs: remove
> > bioc->stripes_pending". The subject gives a false idea what's going on.
> > There was a member removed, yes but the whole logic regarding bios is
> > changed, it's now using the bio chaining, as mentioned in the first
> > paragraph at least. Other patches state in words what the code does, not
> > explaining why.
> 
> Maybe I'm just too familiar with the block code to not agree with you,
> as to me these changes are totally obvious.  But as I often point out:
> if an experienced developers asks questions that seem obvious to me
> my changelogs are not good enough.

I think that even if you as patch author see it obvious it's a good
thing to give some summary or hint for understanding. The changelog
quality varies, there are some stellar examples that explain lots of
the mechanics that probably just the patch author understands that well.
We want that for code documentation and to spread knowledge, ideally.

Speaking about block code, as it's an interface for btrfs, in a few
occasions I had to read some commits and got the impression that I'm not
supposed to know.

> But asking for that after the series
> has been out for a month and a half is a bit silly.  Please comment
> on these patches in a somewhat timely fashion if you think the
> changelogs are not good, and I will update them in a timely fashion.

Well, the summer development cycle is like that, I wanted to reply
earlier but it was not the most important thing I had to do at that
time. Some changes happen in git because that's what gets tested and
pushed as people depend on it.  The mail can wait.
