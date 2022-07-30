Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EDE585AE7
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Jul 2022 17:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiG3PB5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Jul 2022 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiG3PB4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Jul 2022 11:01:56 -0400
Received: from mail.tol.fr (mail.tol.fr [82.66.50.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777B018B08
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Jul 2022 08:01:55 -0700 (PDT)
Message-ID: <6a22d8d1-f11e-e37e-3d37-1ab28d0235eb@couderc.eu>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu; s=2017;
        t=1659193312; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=OT/AMafVurlK+xm6pkmtmf6ItEaIXeKfqXGcpvYTUrM=;
        b=He+T0UMhnk96BC+QV2Nl8xhEc1gTsEAHp84utItXGjORkZJvt19yGiBFSuW1/v2nOeIOIb
        /Y05Lx613KOSVdItQl9Lr/Pj9LCuyfWCpVcDIpwWIx/4sYv9e2W1b2Goz/zY1KHM2q8Onv
        u00DP/6Z4iUzCTZZyFzBU1hQttBktlvCMGenLiF+0KLNwk1eOdRYKVtj3MT75pBwSQNf3J
        FrfsL99gY+W4kJ6BQq/lK5U7lQgRlVLWLjBPrxlTzesUjWms2pNeHbgsSqY58jiVVyNuKF
        2s+R0wAU23KvHw8vHqEcUFYru4iwBgJv61pEN0e7hk69NsnEj1ps7vw2pNbxqA==
Date:   Sat, 30 Jul 2022 17:01:52 +0200
MIME-Version: 1.0
Content-Language: en-US
From:   Pierre Couderc <pierre@couderc.eu>
Subject: How to get the lsit of subvolumes with
 btrfs_util_create_subvolume_iterator
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=couderc.eu;
        s=2017; t=1659193312; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=OT/AMafVurlK+xm6pkmtmf6ItEaIXeKfqXGcpvYTUrM=;
        b=ZlFunBFlFNJ/sFyrOUCiGsxkTARRUwdOABoZMJotviqka2LG+BHNIujWtKmydaHOmo0Ajj
        Gpw5I7BKkLKZ20UAP4p0Tlkwshuthk2kKDT7xzuR1NHF1OjRItvnBL9DJDnusBqb2psYSr
        WB95DYpY+vaBZQPpZrwlzY3uzaSsXx323io2jsUQoDzHIKN928elrB73QI8Sz3UuBaxdhD
        yMdBkXaIWrOQsY7la5CeMkUhsuvsmZJuSOUlNNL9bvbdoCIamUsc6SlfGNSuzUVCYUZuaO
        +/I3dIU2R5DjgvsTV4zgalHnR97AREQrlwxCw3CTPLBEEz86Ov+g1SukQZmb+w==
ARC-Seal: i=1; s=2017; d=couderc.eu; t=1659193312; a=rsa-sha256; cv=none;
        b=mIVgLGyy5J60Gke2sqFLBIs87LEIO6fC3T1vMffccIKtAcVtyH8eEfB3igoF7dxW0YU91gpT2GP1BGejd4bqn/eZFh6ASmEONQUgG4bRMW0JhkjunptGzB1r5iQyxsqeDF6woHnUrJS8zTKbst/FMuZGb1OnlAE225qBw6opWAcJNOEhkncNlvnybu85J/wPCDXvnFxotmM++gCisfa4GnXjz0sQ7enCLTbl+GKiD4YI3CjypER/3nCjUVipEoZCuSdAWZlk5iSVvafyj7oSALt3FgnaGwjRxlQD+a90KrcpuzJa8FgQkpNfVSHurQRjBNwCvIn1sEYk2CkfZQH7yQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=tol smtp.mailfrom=pierre@couderc.eu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_util_create_subvolume_iterator("/",0, 0, &iter);

gives me an empty list !!!

What do I miss ?

What is top ? 0?

What is flag ? what is BTRFS_UTIL_SUBVOLUME_ITERATOR_POST_ORDER ?

I just want the list of all subvolumes...

Thanks

