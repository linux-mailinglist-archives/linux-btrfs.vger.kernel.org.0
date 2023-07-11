Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F2D74E688
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 07:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjGKFwq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 11 Jul 2023 01:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjGKFwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 01:52:33 -0400
X-Greylist: delayed 1127 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 22:52:31 PDT
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2282E4F
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Jul 2023 22:52:31 -0700 (PDT)
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 7A9EE73B041;
        Tue, 11 Jul 2023 07:52:29 +0200 (CEST)
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org, Tim Cuthbertson <ratcheer@gmail.com>
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
Date:   Tue, 11 Jul 2023 07:52:29 +0200
Message-ID: <2890794.e9J7NaK4W3@lichtvoll.de>
In-Reply-To: <2149714.irdbgypaU6@lichtvoll.de>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <5690570.DvuYhMxLoT@lichtvoll.de> <2149714.irdbgypaU6@lichtvoll.de>
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

Martin Steigerwald - 11.07.23, 07:49:43 CEST:
> I see about 180000 reads in 10 seconds in atop. I have seen latency
> values from 55 to 85 µs which is highly unusual for NVME SSD ("avio"
> in atop¹).

Well I did not compare to a base line during scrub with 6.3. So not 
actually sure about the unusual bit. But at least during daily activity 
I do not see those values.

Anyway, I am willing to test a patch.

> [1] according to man page atop(1) from atop 2.9:
> 
> the average number of milliseconds needed by a request ('avio') for
> seek, latency and data transfer
-- 
Martin


