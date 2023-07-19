Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4852758E0D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 08:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGSGoP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 19 Jul 2023 02:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGSGoN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 02:44:13 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80681BF3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 23:44:10 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 3837774790C;
        Wed, 19 Jul 2023 08:44:09 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH RFC 0/4] btrfs: scrub: make sctx->stripes[] a ring buffer
Date:   Wed, 19 Jul 2023 08:44:08 +0200
Message-ID: <3191260.5fSG56mABF@lichtvoll.de>
In-Reply-To: <2250219.iZASKD2KPV@lichtvoll.de>
References: <cover.1689744163.git.wqu@suse.com> <2250219.iZASKD2KPV@lichtvoll.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Martin Steigerwald - 19.07.23, 08:34:51 CEST:
> Qu Wenruo - 19.07.23, 07:30:22 CEST:
> > This is the attempt to increase the queue depth of the scrub
> > behavior.
[…]
> > Thus this patch is mostly sent asking for better ideas.
> 
> Hmm, another approach would be to revert the patches that introduced
> the performance regression. It would release the pressure to find a
> fix soon. Then you'd have all the time to have another go at
> improving scrubbing. At least the issue at hand seems to be tricky.
> 
> What you think?

Sorry, missed that you posted another patch later. So just ignore this 
idea.

Thanks,
-- 
Martin


