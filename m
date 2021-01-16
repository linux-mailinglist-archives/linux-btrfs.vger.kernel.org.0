Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAED92F8FE5
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jan 2021 00:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbhAPXnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jan 2021 18:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbhAPXmy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jan 2021 18:42:54 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A818DC061573
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 15:42:13 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id C26F59C1B8; Sat, 16 Jan 2021 23:42:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1610840528;
        bh=Wuzwu8OwPze3seH83wRyTrp+Al8qKOfl53vLT5x+r1w=;
        h=To:From:Subject:Date:From;
        b=UKuZcdQbs1O6dyAC2BKddLpOICkP3eJqtYPrJI0BzxoCUl01gBHQjkdb5KfWiTir4
         f86+tSpPOIowTLvRxee2vQ9Nv4wcdDMVp/I/2ZRdcmubvF85yJ1j2fRd26FGeSsxxy
         sULlDWaK4egVCH9kIqqvATSwPmlN1KKX/yoFDlHHHCoQmDFVklS/thnMhJmh9/kKre
         t2+wa3TbXxMYLtBJIoFY3RxwdrvE699y2RfRG+i6vuBQtkc+2lVJnQiYC72BaozhrJ
         S1FC6UVJM8RYEz/EOJugxCeBH3+oC4C7SykH/2I3Su27AiwPdH3vruEnS4+81Urp3C
         ZVSD1uNzhYD4Q==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 46A8F9B85D
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 23:42:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1610840525;
        bh=Wuzwu8OwPze3seH83wRyTrp+Al8qKOfl53vLT5x+r1w=;
        h=To:From:Subject:Date:From;
        b=pVob/CdX8T4D3E7YKV0L+c4hmD/YRUcra9Bsot86N1nlSfx9LJgOFVdre9djijE1i
         Psy6Ybe4rHPRa45FuNs2090QERwnGiZ8HTmz9ip3zF7C9mD5MOwR6XAzK/oECeBwgB
         xUdfVRp+XsppsNvdRv2uznKbajUL4nQ/UmJWwyXCfLGNRJ3PxsmzEuvs0zIamcuGdV
         R+AQjtGoDpyD5hGt1QH/l8BJiinLccobQZg60QDp4V2FxpuC9R4IbIXF/9o65L9ar3
         10t42ITvu0RMZVc1wxyK/6/112WEu4d/yJn1FmrtXSUflgRkVTXmH89Sjjn+ycDpYL
         fGvZzc/7Vfn/Q==
Received: from [192.168.0.211] (novatech.home.cobb.me.uk [192.168.0.211])
        by black.home.cobb.me.uk (Postfix) with ESMTPS id 850E11D4F1A
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jan 2021 23:42:04 +0000 (GMT)
To:     linux-btrfs@vger.kernel.org
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: NVME experience?
Openpgp: preference=signencrypt
Autocrypt: addr=g.btrfs@cobb.uk.net; prefer-encrypt=mutual; keydata=
 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 myxb
Message-ID: <b5ea0996-578e-8584-2cc7-4b8422f75566@cobb.uk.net>
Date:   Sat, 16 Jan 2021 23:42:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am about to deploy my first btrfs filesystems on NVME. Does anyone
have any hints or advice? Initially they will be root disks, but I am
thinking about also moving home disks and other frequently used data to
NVME, but probably not backups and other cold data.

I am mostly wondering about non-functionals like typical failure modes,
life and wear, etc. Which might affect decisions like how to split
different filesystems among the drives, whether to mix NVME with other
drives (SSD or HDD), etc.

Are NVME drives just SSDs with a different interface? With similar
lifetimes (by bytes written, or another measure)? And similar typical
failure modes?

Are they better or worse in terms of firmware bugs? Error detection for
corrupted data? SMART or other indicators that they are starting to fail
and should be replaced?

I assume that they do not (in practice) suffer from "faulty cable" problems.

Anyway, I am hoping someone has experiences to share which might be useful.

Graham
