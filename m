Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAAA758E29
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 08:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGSGza convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 19 Jul 2023 02:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjGSGz3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 02:55:29 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783431FD9
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jul 2023 23:55:27 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 98A70747972;
        Wed, 19 Jul 2023 08:55:24 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Tim Cuthbertson <ratcheer@gmail.com>, linux-btrfs@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
Date:   Wed, 19 Jul 2023 08:55:24 +0200
Message-ID: <2585111.Lt9SDvczpP@lichtvoll.de>
In-Reply-To: <3526703.iIbC2pHGDl@lichtvoll.de>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <1d611dbb-8aee-9a6e-701c-6498f1b51c34@leemhuis.info>
 <3526703.iIbC2pHGDl@lichtvoll.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Martin Steigerwald - 19.07.23, 08:42:58 CEST:
> Hi Thorsten.
> 
> #regzbot monitor:
> https://lore.kernel.org/linux-btrfs/cover.1689744163.git.wqu@suse.com
> /
> 
> I hope that does it.
> 
> Above links to a patch of Qu about asking for other ideas to fix the
> regression. It however has been superseded by a later patch of him.

FWIW time-wise it was the other way around. The other patch was slightly 
earlier, but it not fully recover the original speed of scrubbing of 
NVME devices in 6.3¹. Thus Qu was asking for additional ideas.

[1] https://lore.kernel.org/linux-btrfs/4f48e79c-93f7-b473-648d-4c995070c8ac@gmx.com/T/#t

Best,
-- 
Martin


