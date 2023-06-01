Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C767199D5
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 12:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjFAKcO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 06:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjFAKcI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 06:32:08 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3361E98
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 03:32:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DA8FC68AA6; Thu,  1 Jun 2023 12:22:17 +0200 (CEST)
Date:   Thu, 1 Jun 2023 12:22:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix dev-replace after the scrub rework
Message-ID: <20230601102217.GA10149@lst.de>
References: <0113e9e82b06106940e8ef7323fd4a9c01aa5afc.1685610531.git.wqu@suse.com> <20230601093747.GA6652@lst.de> <bbd57e3d-c61d-cf1e-6f8c-386c24625a69@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbd57e3d-c61d-cf1e-6f8c-386c24625a69@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 01, 2023 at 06:12:12PM +0800, Qu Wenruo wrote:
> Yes, the cleanup is also in my mind, but currently I prefer to do the
> fix first in-place, then you can do the tide up after the more critical fix.

There isn't really much of a difference in the diffstat between
doing the consolidation and duplicating everything.  So I don't
think that's much of an argument.
