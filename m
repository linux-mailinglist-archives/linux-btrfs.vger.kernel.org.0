Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AD969BBBC
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 21:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBRULO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Feb 2023 15:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBRULN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Feb 2023 15:11:13 -0500
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB5914220
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Feb 2023 12:11:11 -0800 (PST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1pTTY5-0004Jh-Aa
        for linux-btrfs@vger.kernel.org; Sat, 18 Feb 2023 21:11:09 +0100
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-btrfs@vger.kernel.org
To:     linux-btrfs@vger.kernel.org
From:   Torsten Bronger <bronger@physik.rwth-aachen.de>
Subject: Re: Why is converting from RAID1 to single in Btrfs an I/O-intensive operation?
Date:   Sat, 18 Feb 2023 21:05:48 +0100
Organization: Phoenix Foundation
Message-ID: <87o7pqhh7n.fsf@physik.rwth-aachen.de>
References: <87wn4fiec8.fsf@physik.rwth-aachen.de>
        <04ddea4e-4823-00dc-c32c-700d9f7e1fef@libero.it>
        <87a61bi4pj.fsf@physik.rwth-aachen.de>
        <CAFMvigcmGsqNv11LbZxnJ+TX1_RUm__Vay-S2xNhwKupxTXuQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:8snRJGcF9vBmVnwThxTxyilQ00Y=
X-PGP-Fingerprint: C5C8 D6E2 79D2 EFE9 8C0F  6D77 D5E3 CEFC 9F51 6B77
X-Home-Page: http://www.wikipedia.org/wiki/User:Bronger
X-Face: +wpw"|jN2Fde|7<r"A\7[g0RGE#"N'WgB|46ohZy$RfV+Y!oH=FKMC>_<EQ_IdY;pJcjJrx
 {m$r$vTG>lKBa0\7!_6<ouwhB1|a+k#?z597ims{Y+POGr7Z{,b]wj]6Z"PqUHzA2\|m(:>suIE_m!
 x)'S9ytBu8tkt'k779jbzQ4o|p+@H_DCrIdnKG]E*w
X-Binford: 6100 (more power)
X-Accept-Language: de, en
Mail-Copies-To: never
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hallöchen!

me@jse.io writes:

> On Sat, Feb 18, 2023 at 7:45 AM Torsten Bronger
> <bronger@physik.rwth-aachen.de> wrote:
>>
>> [...]
>>
>> I agree that converting to single is not the fastest way to
>> replace a disk, but the safest AFAICS.  It is the boot partition
>> in a simple home server without monitor or keyboard, which makes
>> mounting as degraded difficult.  Besides, you can only mount in
>> degraded mode once.  If anything goes wrong, I have to rebuild
>> from scratch.
>
> I just want to make clear, this bug was fixed long ago. You would
> need to update your bootloader conf to use degraded at boot time
> in this case, but in theory, it should work identical to have a
> raid1 degraded as converting it all back to single.

What was fixed?  Can you now mount in in degraded mode read-write as
often as you wish?

Regards,
Torsten.
-- 
Torsten Bronger

