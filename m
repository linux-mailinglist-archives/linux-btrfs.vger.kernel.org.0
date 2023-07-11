Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB9574E661
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 07:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjGKFhB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 01:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGKFhA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 01:37:00 -0400
X-Greylist: delayed 197 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 22:36:59 PDT
Received: from mail.lichtvoll.de (luna.lichtvoll.de [194.150.191.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF29134
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jul 2023 22:36:58 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 23A0273AFF4;
        Tue, 11 Jul 2023 07:36:57 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Tim Cuthbertson <ratcheer@gmail.com>, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
Date:   Tue, 11 Jul 2023 07:36:56 +0200
Message-ID: <4495685.LvFx2qVVIh@lichtvoll.de>
In-Reply-To: <a371b46e-dce1-833f-2068-d9d8c11902ac@gmx.com>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <c30a0d54-dd57-06d7-92e5-1a0fea98fea5@gmx.com>
 <a371b46e-dce1-833f-2068-d9d8c11902ac@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo - 05.07.23, 04:44:02 CEST:
> If you're fine compiling a custom kernel, I can craft a branch for you
> to test.

I can compile a custom kernel. Actually findings are with custom compiled 
kernel from either

git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git

or

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

I can confirm faster speeds also with Debian kernel <=6.3. No Debian 6.4 
kernel installed yet.

Thanks,
-- 
Martin


