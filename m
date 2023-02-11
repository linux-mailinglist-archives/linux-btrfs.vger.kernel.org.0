Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D83693363
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Feb 2023 20:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBKTul (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Feb 2023 14:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBKTuk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Feb 2023 14:50:40 -0500
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EE818ABA
        for <linux-btrfs@vger.kernel.org>; Sat, 11 Feb 2023 11:50:36 -0800 (PST)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 35E225EEB85;
        Sat, 11 Feb 2023 20:50:34 +0100 (CET)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     waxhead@dirtcellar.net, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Forza <forza@tnonline.net>
Subject: Re: Never balance metadata?
Date:   Sat, 11 Feb 2023 20:50:33 +0100
Message-ID: <2626940.X9hSmTKtgW@lichtvoll.de>
In-Reply-To: <f95ded14-ee9a-6e54-dd79-fe3811560513@tnonline.net>
References: <ad4de975-3d5f-4dbb-45a5-795626c53c61@dirtcellar.net>
 <f95ded14-ee9a-6e54-dd79-fe3811560513@tnonline.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Forza - 11.02.23, 18:18:50 CET:
> On 2023-02-11 02:36, waxhead wrote:
> > I have read several places, including on this mailing list that
> > metadata is not supposed to be balanced unless converting between
> > profiles.
> > 
> > Interestingly enough there is nothing mentioned about this in the
> > docs... https://btrfs.readthedocs.io/en/latest/btrfs-balance.html
> > 
> > Should one still NOT balance metadata? If so - please update the
> > docs
> > with a explanation to why one should not do that.
> 
> There is no direct issue with balancing metadata chunks.
> 
> The recommendation to not balance metadata is because it can
> contribute to a ENOSPC (no free space left) error. This happens when
> Btrfs needs to allocate another metadata chunk, but there is no
> unallocated space available.

Thanks for that very good and thorough explanation.

Something like this in the official documentation would be great!

Best,
-- 
Martin


