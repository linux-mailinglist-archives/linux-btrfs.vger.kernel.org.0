Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A464D7D8E49
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Oct 2023 07:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjJ0FrD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 01:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJ0FrC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 01:47:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB681A7;
        Thu, 26 Oct 2023 22:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ft+RBoJIY64vxL9oTa4cbHQ3NmFM9JUoNFCGpOHO5aM=; b=zNay1crFNjpn3ZQ1u5xp9H0xQc
        29HnioyZHVlpM0XXx62804lEO5nPP5b9RqmNwnpI+7OKSLNSvT70x7+gpaSeLsvl9Afouk0b4GFnH
        qW3eD78R4x9xUX4Krqr8Drj/duVcuB4x1DXjbSqteRr6lPglTAhjnjG0CGxCwEf3XgNglmEo/Odwy
        7buo3oD+ia6to5eRkBoWZsUk1Z4O1ETZL2P+LwTZbkgRj7hsy9HzTJ/ouxrGdYD2HLuPJKL7ycL+k
        keOQY0M8dt9FRks1uS15/rWfQIaV5BDUHIxn7qEIqeBfQcf4F/tGy7+K0P/mgUevf/obUdlytjOkc
        8DfkcODA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwFgN-00FdK5-35;
        Fri, 27 Oct 2023 05:46:55 +0000
Date:   Thu, 26 Oct 2023 22:46:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fanotify support for btrfs sub-volumes
Message-ID: <ZTtOz8mr1ENl0i9q@infradead.org>
References: <20231026155224.129326-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026155224.129326-1-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As per the discussion in the last round:

Hard-NAKed-by: Christoph Hellwig <hch@lst.de>

We need to solve the whole btrfs subvolume st_dev thing out properly
and not leak these details in fanotify.

