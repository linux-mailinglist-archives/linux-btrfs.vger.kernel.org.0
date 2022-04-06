Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786BC4F5872
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 11:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349416AbiDFJPA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 05:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350693AbiDFJIB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 05:08:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C684E49DEA0;
        Tue,  5 Apr 2022 23:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ohw7alrunBo6u8y9r9coEzrKweqjNAIRF9fP6BRpv9E=; b=Sk1lh0IE7jv4XEl0/O5uKmGIo4
        pg/FBkcdAg4L31bNa3nEAzNsgJ8PfodMs+1gAZLzuxOVlzFmBROEm4gTRcU7sx5FG6dNQLc+qa8wz
        n8CXWqi6mPLi199fby9MIImB9Iq7Mk7Yj6FlmdZWXCz4VdrLXzR6DIg/copXU1BzNV6HIwix5D52M
        JQgIeUYlQe1Zv1ur6WvubATrjo3vCkdg3mAEb6V33v7oQMAJs2g7GmGduTU5qp2O94Q24uU8zl5x8
        57aoGbIzO6wMp1wRh0UGT0N4JVlyFrZPWxiOefeHJknNqZZ48By+y2FVQD/2PT4iXAPlsn9NfbpKG
        Plkv4nVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbyqa-003xFs-Ql; Wed, 06 Apr 2022 06:08:52 +0000
Date:   Tue, 5 Apr 2022 23:08:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Btrfs fixes for 5.18-rc2
Message-ID: <Yk0udO4ttnrbY/jN@infradead.org>
References: <cover.1649109877.git.dsterba@suse.com>
 <CAADWXX-XPrfiD0TLGwMuzmGfs9pZ+HiTo1v9cs-mxb6x0OXpZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADWXX-XPrfiD0TLGwMuzmGfs9pZ+HiTo1v9cs-mxb6x0OXpZw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 05, 2022 at 08:58:35AM -0700, Linus Torvalds wrote:
> I don't see anything wrong with the message (spf and dkim both
> fine).so I assume it's something about suse.sz or suse.de that gmail
> doesn't like. Presumably some spammer sitting on a nearby network on
> the same ISP.
> 
> Anyway, not much you can do about it except perhaps ask whatever MIS
> people to see if they got put on some blacklist or whatever.
> 
> I've obviously noticed the pull request despite it being in my spam folder.

gmail seems to be going berserk lately, it keeps rejecting tons of mail
from mailinglist for random reasons like too much traffic or a close IP
apparently sent spam.
