Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEBC69F03C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Feb 2023 09:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjBVIbR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Feb 2023 03:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjBVIbP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Feb 2023 03:31:15 -0500
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F379235249
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Feb 2023 00:31:13 -0800 (PST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1pUkWs-00039I-Og
        for linux-btrfs@vger.kernel.org; Wed, 22 Feb 2023 09:31:10 +0100
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-btrfs@vger.kernel.org
To:     linux-btrfs@vger.kernel.org
From:   Torsten Bronger <bronger@physik.rwth-aachen.de>
Subject: Re: Why is converting from RAID1 to single in Btrfs an I/O-intensive operation?
Date:   Wed, 22 Feb 2023 09:30:38 +0100
Organization: Phoenix Foundation
Message-ID: <87ttze2jbl.fsf@physik.rwth-aachen.de>
References: <87wn4fiec8.fsf@physik.rwth-aachen.de>
        <04ddea4e-4823-00dc-c32c-700d9f7e1fef@libero.it>
        <87a61bi4pj.fsf@physik.rwth-aachen.de>
        <8531c30e-885b-1d8d-314b-5167ed0874ac@libero.it>
        <87k00dmq83.fsf@physik.rwth-aachen.de>
        <c27655bc-8582-07e2-236d-e3afc6860d13@dirtcellar.net>
        <0282b6d0-b131-3b3a-084d-8c8de2f522a5@tnonline.net>
        <87r0ujbi6h.fsf@physik.rwth-aachen.de>
        <CAFMvigfxFfMwpBUUBbixzksNX38L2U-Pct0+g-ZZsGm5vJj32A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:OV2BpDHnP/hnKAI8NISLgYoKo0Y=
X-PGP-Fingerprint: C5C8 D6E2 79D2 EFE9 8C0F  6D77 D5E3 CEFC 9F51 6B77
X-Home-Page: http://www.wikipedia.org/wiki/User:Bronger
X-Face: +wpw"|jN2Fde|7<r"A\7[g0RGE#"N'WgB|46ohZy$RfV+Y!oH=FKMC>_<EQ_IdY;pJcjJrx
 {m$r$vTG>lKBa0\7!_6<ouwhB1|a+k#?z597ims{Y+POGr7Z{,b]wj]6Z"PqUHzA2\|m(:>suIE_m!
 x)'S9ytBu8tkt'k779jbzQ4o|p+@H_DCrIdnKG]E*w
X-Binford: 6100 (more power)
X-Accept-Language: de, en
Mail-Copies-To: never
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hallöchen!

me@jse.io writes:

> [...]
>
> If you want to go back to single on a 2 device RAID1, and avoid
> the wear, especially if you plan to return to RAID1 at a later
> date, why not just use it degraded?

Now that I know that the mount-degraded-rw-only-once thing has long
been fixed, I will do that of course.

Bye,
Torsten.

-- 
Torsten Bronger

