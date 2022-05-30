Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAC85374C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 09:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiE3FeY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 May 2022 01:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiE3FeX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 May 2022 01:34:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD804B41F;
        Sun, 29 May 2022 22:34:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6F7BA68AFE; Mon, 30 May 2022 07:34:17 +0200 (CEST)
Date:   Mon, 30 May 2022 07:34:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Anand Jain <anand.jain@oracle.com>,
        Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 01/10] btrfs: add a helpers for read repair testing
Message-ID: <20220530053417.GA1127@lst.de>
References: <20220527081915.2024853-1-hch@lst.de> <20220527081915.2024853-2-hch@lst.de> <8bdaa753-ae46-88ec-09ce-0a5f86ea5b9d@oracle.com> <289c77f4-a2b6-d7e1-0114-dcb111d57f91@gmx.com> <20220530043632.talbzod4sohbdpxv@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530043632.talbzod4sohbdpxv@zlang-mailbox>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 30, 2022 at 12:36:32PM +0800, Zorro Lang wrote:
> This patchset has been merged into fstests release v2022.05.29 last weekend.
> If you feel something isn't good enough, feel free to send new patches to
> fix/improve it.

Also this exact same code existed in two tests before and was just
factored into a common helper.

