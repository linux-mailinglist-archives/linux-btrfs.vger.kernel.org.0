Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E66276140
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 21:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIWTlw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 23 Sep 2020 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWTlw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 15:41:52 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807FEC0613CE
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Sep 2020 12:41:52 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 6CD2B1566E1;
        Wed, 23 Sep 2020 21:41:50 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: fix false alert caused by legacy btrfs root item
Date:   Wed, 23 Sep 2020 21:41:48 +0200
Message-ID: <1952994.EpAzVLkqvi@merkaba>
In-Reply-To: <ec3a5769-a847-6b3d-d502-b96c053b070f@suse.com>
References: <20200922023701.32654-1-wqu@suse.com> <8998433.IpVEtotQbC@merkaba> <ec3a5769-a847-6b3d-d502-b96c053b070f@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo - 23.09.20, 01:17:01 CEST:
> On 2020/9/22 下午11:48, Martin Steigerwald wrote:
> > Qu Wenruo - 22.09.20, 12:34:18 CEST:
> >> On 2020/9/22 下午6:20, Martin Steigerwald wrote:
> >>> Instead of the tool, can I also patch my kernel with the patch
> >>> below
> >>> to have it automatically fix it?
> >> 
> >> Sure, this one is a little safer than the tool.
[…]
> >>> If so, which approach would you prefer for testing?
> >>> I can apply the patch as I compile kernels myself.
> >> 
> >> That's great.
> >> 
> >> That should solve the problem.
> >> 
> >> And if you don't like the legacy root item, just do a balance (no
> >> matter data or metadata), and that legacy root item will be
> >> converted to current one, and even affected kernel won't report
> >> any error any more.
> > 
> > Can I get away with a minimal balance? Or does it need to be a full
> > one?
> Minimal is enough.
> You just need to balance one chunk.
> 
> You can confirm it with "btrfs ins dump-tree -t root <device>".
> If DATA_RELOC_TREE item size is still 249, it's legacy one.
> If it's 429, then it's the current one.

Hmmm its 439. So is that good as well?

        item 178 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 8546 itemsize 439
                generation 13246 root_dirid 256 bytenr 896876544 level 0 refs 1
                lastsnap 0 byte_limit 0 bytes_used 16384 flags 0x0(none)
                uuid […]
                drop key (0 UNKNOWN.0 0) level 0

What is this tree used for by the way?

If you like I can test with unpatched kernel whether warning goes away, but
I bet it may not be needed.

[…]
-- 
Martin


