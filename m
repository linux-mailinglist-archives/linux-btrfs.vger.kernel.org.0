Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3181C5024A2
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 07:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344072AbiDOFsX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 01:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349937AbiDOFre (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 01:47:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660023E0D8
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 22:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7BHz5hsrXcPtFZqARseCUZueCEK0ZSG/gIZqHHZf5sk=; b=tnKEOjFzU8kfJZIxbxXALCku+u
        IxhpL32eH+z43HT0GkwbGDoIWYarML2yEHunh9gsh7sV4cCoesaAuih4G8wdhFCupjOCT/DH4AkLZ
        TVsWkPmjXq82PL1IY1HgUBafSocFWM4zoXSLoxVbhRwjQdLb5UAg1IEXcHjM8OkH+zebj1DM26C3R
        d0GqKr8IU7uU8bA2eZN8tZnrndKMhve6hBIIa/LLPHq/uE7YcdjdrCMCDktYfMaSsOkidnjRI/K9n
        cYPsMcKS+njfYSNmCz0EprER++arMOehEpBThYV0q9VbjGzdnGXgw3q0sHAB+XNw0O6TtfStpd9Ph
        M0cevpyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfElU-008kam-86; Fri, 15 Apr 2022 05:45:04 +0000
Date:   Thu, 14 Apr 2022 22:45:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 04/17] btrfs: introduce new cached members for
 btrfs_raid_bio
Message-ID: <YlkGYC6yld77ESfq@infradead.org>
References: <cover.1649753690.git.wqu@suse.com>
 <38fdde8665c4765551fea3c5818bfa79b1214fa6.1649753690.git.wqu@suse.com>
 <YlkDN0OaSUTKGeRr@infradead.org>
 <c7b952c0-6c86-1e72-5221-4876047cccbd@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7b952c0-6c86-1e72-5221-4876047cccbd@gmx.com>
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

On Fri, Apr 15, 2022 at 01:34:19PM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/4/15 13:31, Christoph Hellwig wrote:
> > What is cached about these members?
> 
> It's just like btrfs_fs_info::sectorsize, gives us a quick way to use,
> without calculating the same value again and again.
> 
> BTW, are you suggesting to calculate everything when needed?
> 
> I'm fine either way.

No.  I was just confused by the term cached.
