Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02BD591D38
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Aug 2022 02:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiHNALW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 20:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHNALV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 20:11:21 -0400
X-Greylist: delayed 58490 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 13 Aug 2022 17:11:19 PDT
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949351CFE5
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 17:11:19 -0700 (PDT)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 20EB61C0006;
        Sun, 14 Aug 2022 00:11:15 +0000 (UTC)
Message-ID: <69235bca-d420-37de-54a2-68790af40d7a@heyquark.com>
Date:   Sun, 14 Aug 2022 10:11:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Corrupt leaf, trying to recover
Content-Language: en-AU
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <6270a749-5fb2-0b36-529b-07f0e2ce4639@heyquark.com>
 <0b4a3bca-cafd-b47d-d03c-a97922e49228@gmx.com>
 <c1b246ad-6665-1216-166c-a1ad32222b35@heyquark.com>
 <a9d3eb38-e939-4751-4dc8-896fa653be73@gmx.com>
 <593e9196-7455-1874-750f-2f11443d7841@heyquark.com>
 <20220813223613.0245732f@nvm>
From:   Ash Logan <ash@heyquark.com>
In-Reply-To: <20220813223613.0245732f@nvm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 14/8/22 03:36, Roman Mamedov wrote:
> On Sat, 13 Aug 2022 18:28:36 +1000
> Ash Logan <ash@heyquark.com> wrote:
>
>>> That new sanity check introduced in v5.11 should save a lot of hassle
>>> like this.
>> Debian doesn't ship it, though.. Will have to see what my options are
>> there. Maybe time to build my own.
> Kernel 5.18 is available in the backports repository for Debian 11:
> https://packages.debian.org/search?keywords=linux-image-5.18
>
> See https://backports.debian.org/Instructions/
Perfect, thanks.
> As for bitflip, I would be concerned to keep using this hardware (RAM). It
> might be that you are using tests that are not rigorous enough. For instance
> once I got some sticks which were "stable" in MemTest86+, but TestMem5 with
> its custom 'extreme' profiles has reported errors.
>
> Or at least next time you get a weird Btrfs issue, which is quite good, with
> its currently present write-time/read-time sanity checks, at tripping on any
> bad RAM in a loud way, you will know there is definitely something wrong with
> it.

I did end up finding another (larger!) RAM stick which also tested 
clean, so I now have that in there.

I actually had another subvolume (ID 410) with the exact same incorrect 
flag bit set. Given the filesystem otherwise seems totally clean, I no 
longer suspect a memory bitflip - it seems more likely that across 
various software versions (ReadyNAS OS, Debian versions, etc...) someone 
had a customisation or a bug that went unnoticed due to the lack of checks.

<speculation> I noticed the two problematic subvolumes also are the only 
ones that had snapshots.. perhaps ReadyNAS or the like used such a flag 
to track if snapshots are enabled? </speculation>

Thanks,
Ash

