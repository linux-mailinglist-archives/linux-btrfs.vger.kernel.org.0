Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0822969DB16
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 08:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjBUHVV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 02:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbjBUHVU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 02:21:20 -0500
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25522596B
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 23:21:08 -0800 (PST)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1pUMxW-0004dT-GY
        for linux-btrfs@vger.kernel.org; Tue, 21 Feb 2023 08:21:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-btrfs@vger.kernel.org
To:     linux-btrfs@vger.kernel.org
From:   Torsten Bronger <bronger@physik.rwth-aachen.de>
Subject: Re: Why is converting from RAID1 to single in Btrfs an I/O-intensive operation?
Date:   Tue, 21 Feb 2023 08:18:14 +0100
Organization: Phoenix Foundation
Message-ID: <87r0ujbi6h.fsf@physik.rwth-aachen.de>
References: <87wn4fiec8.fsf@physik.rwth-aachen.de>
        <04ddea4e-4823-00dc-c32c-700d9f7e1fef@libero.it>
        <87a61bi4pj.fsf@physik.rwth-aachen.de>
        <8531c30e-885b-1d8d-314b-5167ed0874ac@libero.it>
        <87k00dmq83.fsf@physik.rwth-aachen.de>
        <c27655bc-8582-07e2-236d-e3afc6860d13@dirtcellar.net>
        <0282b6d0-b131-3b3a-084d-8c8de2f522a5@tnonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:vP1G7tIdVSdSOsCOVrJrzOWKNKY=
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

Forza writes:

> [...]
>
> I believe this would violate the "CoW" nature of Btrfs. In other
> words, it would introduce a change in-place, which is not possible
> with current current way of working.
>
> There probably are ways to make it safe and atomic, but maybe not
> a high priority from the current devs?

My naive assumption was: There is the bulk data, and there is
metadata that also contains the profile of the data.  If the profile
is changed, only the metadata has to be re-written atomically (in
particular, the CoW way).

But apparently, the profile is part of the bulk data chunk itself.
This may well be necessary, but I was surprised by that.

Regards,
Torsten.

-- 
Torsten Bronger

