Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FCA5096D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 07:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384314AbiDUFaq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 01:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352029AbiDUFap (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 01:30:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989B510FD0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 22:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rX1HtLzx2DTh98Ec/24eOKETUmOPqLBX8VF5lBJiT68=; b=Q0ZQYnrJwB1/n8ObCQvjJx32Rz
        39Mr3AqYDbXqPj90rnLwTWFarytl5AyhK+KBBCCpMbBUlDApVP6WUSX0SOl2Sfe7RVGUGyPO+u+Tb
        6vyX8U1XUG7rIIWMQNQ6zvOuv9rUccb05EjlkBMLrkCsF0EFN4GwKaBzvpqcewUaZTwYRG3xuBoSl
        4lQCIyZl/Fl6s48tiPTZmd3hFepTmV2eIW0NLXi28++TpuOkIEsKObpKw+YkYAU47Mo+daU+kqZ02
        7hquGvi7hktMvhLITcO/mySOGmOT/qUEzyQ6kciujcdqsr5C8BKWDhGLdY9RRGq6U+n0UegT5QwUi
        H+WO6nAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhPM7-00BZRS-1o; Thu, 21 Apr 2022 05:27:51 +0000
Date:   Wed, 20 Apr 2022 22:27:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 00/18] btrfs: split bio at btrfs_map_bio() time
Message-ID: <YmDrV/Hyxn1bSOd0@infradead.org>
References: <cover.1647248613.git.wqu@suse.com>
 <Yjnu7yWxAforTGQF@infradead.org>
 <96e622b1-fffb-34ae-6055-49bd7a4ea23b@gmx.com>
 <20220420201158.GJ1513@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420201158.GJ1513@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 20, 2022 at 10:11:58PM +0200, David Sterba wrote:
> On Wed, Mar 23, 2022 at 07:45:31AM +0800, Qu Wenruo wrote:
> > 
> > 
> > On 2022/3/22 23:44, Christoph Hellwig wrote:
> > > I spent some time looking over this series and I think while it has
> > > some nice cleanups, it also goes fundamentally in the wrong direction.
> > 
> > Well, at least I got some review, that's always a good news.
> 
> So this whole series will be dropped and replaced by Christoph's
> patches, however if there's anything useful left please send it
> separately later on. Thanks.

There are some good ideas in here actually.  I think we'll come up
with a fusion variant eventually.
