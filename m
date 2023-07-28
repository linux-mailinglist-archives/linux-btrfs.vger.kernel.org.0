Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F5376777B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 23:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjG1VO6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 17:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjG1VO5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 17:14:57 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9056B44AB
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 14:14:54 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id D182E75BC86;
        Fri, 28 Jul 2023 23:14:50 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 0/5] btrfs: scrub: improve the scrub performance
Date:   Fri, 28 Jul 2023 23:14:50 +0200
Message-ID: <1738327.QkHrqEjB74@lichtvoll.de>
In-Reply-To: <20230728165037.GJ17922@twin.jikos.cz>
References: <cover.1690542141.git.wqu@suse.com> <6543972.G0QQBjFxQf@lichtvoll.de>
 <20230728165037.GJ17922@twin.jikos.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

David Sterba - 28.07.23, 18:50:37 CEST:
> On Fri, Jul 28, 2023 at 02:38:35PM +0200, Martin Steigerwald wrote:
> > Qu Wenruo - 28.07.23, 13:14:03 CEST:
> > > The first 3 patches would greately improve the scrub read
> > > performance, but unfortunately it's still not as fast as the
> > > pre-6.4 kernels. (2.2GiB/s vs 3.0GiB/s), but still much better
> > > than 6.4 kernels (2.2GiB vs 1.0GiB/s).
> > 
> > Thanks for the patch set.
> > 
> > What is the reason for not going back to the performance of the
> > pre-6.4 kernel? Isn't it possible with the new scrubbing method? In
> > that case what improvements does the new scrubbing code have that
> > warrant to have a lower performance?
> 
> Lower performance was not expected and needs to be brought back. A
> minor decrease would be tolerable but that's something around 5%, not
> 60%.

Okay. Best of success with improving performance again.

> > Just like to understand the background of this a bit more. I do not
> > mind a bit lower performance too much, especially in case it is
> > outweighed by other benefits.
> 
> The code in scrub was from 3.0 times and since then new features have
> been implemented, extending the code became hard over time so a bigger
> update was done restructuring how the IO is done.

Okay, thanks for explaining.

-- 
Martin


