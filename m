Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B51C58E7D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 09:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiHJH0J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 03:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiHJH0H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 03:26:07 -0400
Received: from libero.it (smtp-16.italiaonline.it [213.209.10.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CADA193F2
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 00:26:04 -0700 (PDT)
Received: from [192.168.1.27] ([84.222.35.163])
        by smtp-16.iol.local with ESMTPA
        id Lg6Lo84SCnJ6yLg6LoHjfp; Wed, 10 Aug 2022 09:26:02 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1660116362; bh=PIRiG609vf59zOVWiTjkWJ/taWjwcNdRISAwfrxSfV0=;
        h=From;
        b=SLhp+4CVBROThBZXXmkTRGeM+3DQbJ99o7OqZP4JAJWfGgit4++iLK6FTCStmZDJb
         4dkuv+cEGeOCC7zt5SyOsmZwGPIp+RoagfsEPNdq9SL7CfZbtQ+2j83KwcNs550q+w
         2XyXcwY/gMEGyVwEWZHaVmgY1j45/Wkzt8dLGuWxWN6lksghF6RO9h7GCkN8Sn2bHD
         0+rEvzzUtf7wXRUqcRktZs+gKKWu4209OzuLkDA2GXIuoSCuBbMkOZtSRLN1tj8P8M
         fHnHiQxlzven336W0ck7FD7T0L/lAUQW39QuKIWDe4t2rEfLS2Unkt0xck6tk8nYue
         PYzulXJH58qSw==
X-CNFS-Analysis: v=2.4 cv=E9MIGYRl c=1 sm=1 tr=0 ts=62f35d8a cx=a_exe
 a=FwZ7J7/P4KMHneBNQvmhbg==:117 a=FwZ7J7/P4KMHneBNQvmhbg==:17
 a=IkcTkHD0fZMA:10 a=DJ0FDovreU0eflN899QA:9 a=QEXdDO2ut3YA:10
Message-ID: <8ab11087-2a0a-18ab-d153-2be9ab254e56@libero.it>
Date:   Wed, 10 Aug 2022 09:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Reply-To: kreijack@inwind.it
Subject: Re: Corrupted btrfs (LUKS), seeking advice
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Andrei Borzenkov <arvidjaar@gmail.com>,
        linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, Michael Zacherl <ubu@bluemole.com>
References: <12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@bluemole.com>
 <ebc960af-2511-457e-88ef-d1ee2d995c7d@www.fastmail.com>
 <60689fac-9a38-9045-262c-7f147d71a3d2@bluemole.com>
 <b817538a-687e-0fee-fa05-a1b0cfe956f3@suse.com>
 <83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com>
 <6c15d5db-4e87-dd49-d42a-2fcf08157b25@gmx.com>
 <6ab45148-cf37-43cc-1bd0-809af792e24a@gmail.com>
 <3c47ebef-a76c-3206-7954-42c6de557efa@gmx.com>
Content-Language: en-US
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <3c47ebef-a76c-3206-7954-42c6de557efa@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKs9/gbqX+PF6pmaleAf8aEJk9h/5Lzx5vCKaJUqXoT6Ghy/craAEuBj4OIzfGMBteQQptO2AsDfPkbh07sE+qALasOi84ve2LxjPJ5acUeVID8bZ+fY
 PwI+BnID8AWrHYaOo5OeG0OrkGFwPvM0koFcGgsIhJ7pmCQ8LPByb3Ywgcl8T5+XXO6NsFDKbT5lXUDK7KG5K0MEcb852/pwcBbEDMKaJWcJrB5bYudgSFtY
 1dMj6sQJTW7Ky3Su6BaadNJ4joalUl3c27KD1wss1B1cx6opnKE2Sts8iUjnMXtf/5yNu/HmR/SxId+n64v1rg==
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/08/2022 08.29, Qu Wenruo wrote:
>
>
> On 2022/8/10 14:10, Andrei Borzenkov wrote:
>> On 09.08.2022 14:37, Qu Wenruo wrote:
>> ...
>>>>
>>>> I think what happened is having had mounted the FS twice by accident:
>>>> The former system (Mint 19.3/ext4) has been cloned to a USB-stick which
>>>> I can boot from.
>>>> In one such session I mounted the new btrfs nvme on the old system for
>>>> some data exchange.
>>>> I put the old system to hibernation but forgot to unmount the nvme prior
>>>> to that. :(
>>>
>>> Hibernation, I'm not sure about the details, but it looks like there
>>> were some corruption reports related to that.
>>>
>>>>
>>>> So when booting up the new system from the nvme it was like having had a
>>>> hard shutdown.
>>>
>>> A hard shutdown to btrfs itself should not cause anything wrong, that's
>>> ensured by its mandatory metadata COW.
>>>
>>>> So that in itself wouldn't be the problem, I'd think.
>>>> But the other day I again booted from the old system from its
>>>> hibernation with the forgotten nvme mounted.
>>>
>>> Oh I got it now, it's not after the hibernation immediately, but the
>>> resume from hibernation, and then some write into the already
>>> out-of-sync fs caused the problem.
>>>
>>>> And that was the killer, I'd say, since a lot of metadata has changed on
>>>> that btrfs meanwhile.
>>>
>>> Yes, I believe that's the case.
>>>
>> ...
>>>
>>> Personally speaking, I never trust hibernation/suspension, although due
>>> to other ACPI related reasons.
>>> Now I won't even touch hibernation/suspension at all, just to avoid any
>>> removable storage corruption.
>>>
>>
>> I wonder if it is possible to add resume hook to check that on-disk
>> state matches in-memory state and go read-only if on-disk state changed.
>
> AFAIK what we should do is, using hooks to unmount all removable disks,
> before entering suspension/hibernation.

I don't think that this is doable, because before the hibernation there are

some file descriptors opened, so a full unmount is not an option.


>
>> Checking current generation should be enough to detect it?
>
> IMHO fs doesn't really have any way to know we're going into
> hibernation/suspension.
>
> If we have such mechanism, then yes it's possible.

I think that the only available hooks are

	struct super_operations.freeze_fs 	struct super_operations.unfreeze_fs

I think a check about a consistency of the transaction id should be appropriate, and then if it fails do a panic.
But the case of Michael seems a "misuse" to care of: check that all the disks have the same transaction ids.


>
> Thanks,
> Qu


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

