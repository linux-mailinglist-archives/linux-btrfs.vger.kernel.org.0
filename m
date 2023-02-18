Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8BC69B8AA
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 09:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBRIQ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Feb 2023 03:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBRIQZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Feb 2023 03:16:25 -0500
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Feb 2023 00:16:22 PST
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD25D2C666
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Feb 2023 00:16:22 -0800 (PST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1pTIJT-0007br-Gt
        for linux-btrfs@vger.kernel.org; Sat, 18 Feb 2023 09:11:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-btrfs@vger.kernel.org
To:     linux-btrfs@vger.kernel.org
From:   Torsten Bronger <bronger@physik.rwth-aachen.de>
Subject: Why is converting from RAID1 to single in Btrfs an I/O-intensive operation?
Date:   Sat, 18 Feb 2023 09:10:15 +0100
Organization: Phoenix Foundation
Message-ID: <87wn4fiec8.fsf@physik.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:iw4eirc4KTexNR/FYfb3gx9nr14=
X-PGP-Fingerprint: C5C8 D6E2 79D2 EFE9 8C0F  6D77 D5E3 CEFC 9F51 6B77
X-Home-Page: http://www.wikipedia.org/wiki/User:Bronger
X-Face: +wpw"|jN2Fde|7<r"A\7[g0RGE#"N'WgB|46ohZy$RfV+Y!oH=FKMC>_<EQ_IdY;pJcjJrx
 {m$r$vTG>lKBa0\7!_6<ouwhB1|a+k#?z597ims{Y+POGr7Z{,b]wj]6Z"PqUHzA2\|m(:>suIE_m!
 x)'S9ytBu8tkt'k779jbzQ4o|p+@H_DCrIdnKG]E*w
X-Binford: 6100 (more power)
X-Accept-Language: de, en
Mail-Copies-To: never
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hallöchen!

I want to replace a device in a RAID1 and converted it temporarily
to “single”:

btrfs balance start -f -mconvert=single,soft -dconvert=single,soft /

This takes very long. I don’t see why, and wonder whether this is
the right approach in the first place. After all, no (significant)
amount of data should be needed to be transferred in the process,
should it?

A side question: Is -sconvert also necessary?

Regards,
Torsten.

-- 
Torsten Bronger

