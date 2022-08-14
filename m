Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3D2591FE0
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Aug 2022 15:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiHNNXr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 14 Aug 2022 09:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiHNNXr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Aug 2022 09:23:47 -0400
X-Greylist: delayed 341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 14 Aug 2022 06:23:45 PDT
Received: from emerion-smtp01.emerion.com (emerion-smtp01.emerion.com [37.235.0.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5447915A37
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Aug 2022 06:23:45 -0700 (PDT)
Received: from cox.net (mobiledyn-62-240-134-147.mrsn.at [62.240.134.147])
        (Authenticated sender: qgja7d8j3kpnp.gd8u3o0fklmnv784)
        by emerion-smtp01.emerion.com (Postfix) with ESMTPSA id BD10740117;
        Sun, 14 Aug 2022 15:18:01 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: Corrupted btrfs (LUKS), seeking advice
From:   Michael Zacherl <wast.00.bin+mi@gmail.com>
In-Reply-To: <5ecdbadf-5d16-0ccd-52af-913818e71d81@gmx.com>
Date:   Sun, 14 Aug 2022 15:18:01 +0200
Cc:     wqu@suse.com, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        kreijack@inwind.it, Andrei Borzenkov <arvidjaar@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <80D290BD-6C73-4985-874C-0B6A635BDEEF@gmail.com>
References: <12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@bluemole.com>
 <ebc960af-2511-457e-88ef-d1ee2d995c7d@www.fastmail.com>
 <60689fac-9a38-9045-262c-7f147d71a3d2@bluemole.com>
 <b817538a-687e-0fee-fa05-a1b0cfe956f3@suse.com>
 <83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com>
 <6c15d5db-4e87-dd49-d42a-2fcf08157b25@gmx.com>
 <6ab45148-cf37-43cc-1bd0-809af792e24a@gmail.com>
 <3c47ebef-a76c-3206-7954-42c6de557efa@gmx.com>
 <8ab11087-2a0a-18ab-d153-2be9ab254e56@libero.it>
 <5ecdbadf-5d16-0ccd-52af-913818e71d81@gmx.com>
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11.08.2022, at 08:40, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>> If we have such mechanism, then yes it's possible.
>> 
>> I think that the only available hooks are
>> 
>>     struct super_operations.freeze_fs     struct
>> super_operations.unfreeze_fs
>> 
>> I think a check about a consistency of the transaction id should be
>> appropriate, and then if it fails do a panic.
>> But the case of Michael seems a "misuse" to care of: check that all the
>> disks have the same transaction ids.

“misuse” indeed, I have a tendency (predisposition?) to exhaust technical possibilities. 🙄

> I think your idea is pretty to the point.
> 
> If we found some obvious unexpected modification, we can mark the FS RO
> to minimize the damage (as long as the unexpected modification is still
> correct, the fs will be safe).

I observed this (user POV) behaviour on an old ext4 system:
After waking the hibernating ext4 system again the FS was mounted RO and the OS unusable.
Rebooting dropped into initramfs prompt and an fsck was needed.
Then booting could be continued.

> I just sent a patch based on your idea, feel free to add your
> Suggested-by: and other tags:
> https://lore.kernel.org/linux-btrfs/41c43c7d6aa25af13391905061e2d203f7853382.1660199812.git.wqu@suse.com/T/#u

Thank you very much to you and all for all your efforts - specifically and in general! 
Michael.


