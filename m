Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247297996D2
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Sep 2023 10:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbjIIIHy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Sep 2023 04:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343533AbjIIIHx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Sep 2023 04:07:53 -0400
X-Greylist: delayed 72777 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Sep 2023 01:07:48 PDT
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAE519BA
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Sep 2023 01:07:48 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 8A2107A1D18;
        Sat,  9 Sep 2023 10:07:45 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Tim Cuthbertson <ratcheer@gmail.com>
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
Date:   Sat, 09 Sep 2023 10:06:53 +0200
Message-ID: <2918226.e9J7NaK4W3@lichtvoll.de>
In-Reply-To: <4f5fee23-2ccb-41a2-a64c-1675bc378ff5@gmx.com>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <2169630.irdbgypaU6@lichtvoll.de>
 <4f5fee23-2ccb-41a2-a64c-1675bc378ff5@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo - 09.09.23, 00:03:38 CEST:
> > Scrubbing "/home" with 304.61GiB (interestingly both back then with
> > 6.4
> > and now with 6.5.2):
> > 
> > - 6.4: 966.84MiB/s
> > - 6.5.2:  748.02MiB/s
> > 
> > I expected an improvement.
> > 
> > Same Lenovo ThinkPad T14 AMD Gen 1 with AMD Ryzen 7 PRO 4750U, 32 GiB
> > RAM and 2TB Samsung 980 Pro NVME SSD as before.
> 
> The fixes didn't arrive until v6.6.

Ah, okay. That explains it.

Well I can wait.

Best,
-- 
Martin


