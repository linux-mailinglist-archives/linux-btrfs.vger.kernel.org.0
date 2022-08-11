Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9878458F7CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Aug 2022 08:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiHKGlB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Aug 2022 02:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiHKGlA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Aug 2022 02:41:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D9262E
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 23:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660200051;
        bh=pgEvPsXhmgiTLJlnweE+Xw0+Z7vfwQ1h4bUZp8KuIM0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Sa1vu7Y+HdObWNDdUyGmuIXaMHq0ke0HsEmiAN93568wemPp4kvWyz0PCv5ibw9pl
         cDeDZqoIypoHYML5uYNnt5HlpmaD1hjcIHCNOUV5nBnzAEog0S1sTBDlu1Z1pSATrA
         bS8hWcZ/EZkRPmRDvvVB4cbYclmh7k5drkHEk2zQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MZkpR-1nr0Rp2bOZ-00WoGb; Thu, 11
 Aug 2022 08:40:51 +0200
Message-ID: <5ecdbadf-5d16-0ccd-52af-913818e71d81@gmx.com>
Date:   Thu, 11 Aug 2022 14:40:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Corrupted btrfs (LUKS), seeking advice
Content-Language: en-US
To:     kreijack@inwind.it, Andrei Borzenkov <arvidjaar@gmail.com>,
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
 <8ab11087-2a0a-18ab-d153-2be9ab254e56@libero.it>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8ab11087-2a0a-18ab-d153-2be9ab254e56@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bwk0Ekw2pC/Ga+gRBzpioIUuPi4HUFhD1NUZyDD2gvjyVO0OWIC
 cqS9i9zjJNi/9BGwuEZbeaiOz3mxwEbgvN1Fq2pf6MOoxxLPD1PDqnCUvVVaTjx2bu3+osL
 KXcz3t7vyGoRpV7W4kduKnc5c025DFS+o7gqFFMKWS70exX2HqPYF0eedFL9hZa9Y9gGXCN
 tK0Um6KbljkkV4W+kKRuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fRhDuMdIbYY=:Pvr+dvmPNDcqLt6xlOv9vX
 TjbiEcXMClP/6zdUv9i0rNjZD062XA8whZ0b0SrJ6JRn0R98ANATRoZWiJuSeMMnw/x8eDHM7
 cmg6gbdxCGznzjoLeA6XQoOSc9VUmRJYQno9R8Vh0K7Feynpmtifyms8LYlqYZzQ5aCbNnb03
 qY2KnnhM2/WC/nbIOH3DNzbjdvgTY0/J8J6rnvU40kIHf9CYYGKg+zNoXm7wb3AJ20TXjZznX
 AGiks1ZOwXqzLIQGf+tbssIZ54d4HQyIednUhjXcMW99wnknu3Xuakf033oyCm2BRBcA65c96
 xDo2ZhFEB7frck7/AtkPmoM4xvb35RVCNUz89+7D4/EGnwJ2CxUFF+rYv6N9NyuUUe4UgVQXH
 ZOFiDilSzZAtB/1jzebYepiGJEsrW6xhjrgEepHbLz/0/67Y4wRmzMpEZQ1Y341b0F29VaFUW
 BrLKsCBe0PnTtEDg8g4eWEJLO4W6jk99Tmgn3Bi5cmfyt4Xr18cG7xLQWke3S2MEnjLN/jffo
 Uhf53mcY1c+qVgegDxcItYvg6ZwcLYxT41VTI7mNznFkrvibux48rMKTlLdqXPOhf6AMet0o6
 aSoiCtgaR0jc2k/11iHSxJfr5dcB+KUfm5ru0d54WdgyRqy4gc+Zk+ChtzjSgEEMMz4xTsoSb
 jVuvFIaayBhH+M6oAvCTgg8O+5S1YrsFIdy0hPyvdT0/B26Uev5tOI9tI2DGhuLesd+DtfDBC
 zPwq4tQZZMgPx0jmMpbRUf3tnq1IbEeh8sEgUXY56+CaMjRzA+K3W/C9iiNQ0cKuuBfrKY9BV
 6ujkfexFMIkPNYzrqBUF/WfPzPQgwi3w/k8xVrhyOqXBsPYIk5GCwkf8YzHSAt/pTr5qlBUJ8
 0GiYxYuSCZ8g81KvNXwESJdjPo7WR1ZU11C5hQR4JXDiRusCIcBSwWDygF36z17TdzG/x8F13
 AbBPJmkZJuMkJM8D6M5xbMEIOcLqKVB6Bbe5/NYIWUMfj72dfSVKHW2YLfK/5ffxiy6v8KdZl
 ejFonEZm1GFZdPuYyuiALNlGHXZmTOBMCBeF91mHIvJ9QsL2atm3yXrvEyi/K1R8B5NCpLw8L
 f5mKEP9emwnZn+utGlFH5IrxHB9mJRsup6rkzm4Ji4FAkKVE883EoWGqQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/10 15:26, Goffredo Baroncelli wrote:
> On 10/08/2022 08.29, Qu Wenruo wrote:
>>
>>
>> On 2022/8/10 14:10, Andrei Borzenkov wrote:
>>> On 09.08.2022 14:37, Qu Wenruo wrote:
>>> ...
>>>>>
>>>>> I think what happened is having had mounted the FS twice by accident=
:
>>>>> The former system (Mint 19.3/ext4) has been cloned to a USB-stick
>>>>> which
>>>>> I can boot from.
>>>>> In one such session I mounted the new btrfs nvme on the old system f=
or
>>>>> some data exchange.
>>>>> I put the old system to hibernation but forgot to unmount the nvme
>>>>> prior
>>>>> to that. :(
>>>>
>>>> Hibernation, I'm not sure about the details, but it looks like there
>>>> were some corruption reports related to that.
>>>>
>>>>>
>>>>> So when booting up the new system from the nvme it was like having
>>>>> had a
>>>>> hard shutdown.
>>>>
>>>> A hard shutdown to btrfs itself should not cause anything wrong, that=
's
>>>> ensured by its mandatory metadata COW.
>>>>
>>>>> So that in itself wouldn't be the problem, I'd think.
>>>>> But the other day I again booted from the old system from its
>>>>> hibernation with the forgotten nvme mounted.
>>>>
>>>> Oh I got it now, it's not after the hibernation immediately, but the
>>>> resume from hibernation, and then some write into the already
>>>> out-of-sync fs caused the problem.
>>>>
>>>>> And that was the killer, I'd say, since a lot of metadata has
>>>>> changed on
>>>>> that btrfs meanwhile.
>>>>
>>>> Yes, I believe that's the case.
>>>>
>>> ...
>>>>
>>>> Personally speaking, I never trust hibernation/suspension, although d=
ue
>>>> to other ACPI related reasons.
>>>> Now I won't even touch hibernation/suspension at all, just to avoid a=
ny
>>>> removable storage corruption.
>>>>
>>>
>>> I wonder if it is possible to add resume hook to check that on-disk
>>> state matches in-memory state and go read-only if on-disk state change=
d.
>>
>> AFAIK what we should do is, using hooks to unmount all removable disks,
>> before entering suspension/hibernation.
>
> I don't think that this is doable, because before the hibernation there =
are
>
> some file descriptors opened, so a full unmount is not an option.
>
>
>>
>>> Checking current generation should be enough to detect it?
>>
>> IMHO fs doesn't really have any way to know we're going into
>> hibernation/suspension.
>>
>> If we have such mechanism, then yes it's possible.
>
> I think that the only available hooks are
>
>  =C2=A0=C2=A0=C2=A0=C2=A0struct super_operations.freeze_fs=C2=A0=C2=A0=
=C2=A0=C2=A0 struct
> super_operations.unfreeze_fs
>
> I think a check about a consistency of the transaction id should be
> appropriate, and then if it fails do a panic.
> But the case of Michael seems a "misuse" to care of: check that all the
> disks have the same transaction ids.

I think your idea is pretty to the point.

If we found some obvious unexpected modification, we can mark the FS RO
to minimize the damage (as long as the unexpected modification is still
correct, the fs will be safe).

I just sent a patch based on your idea, feel free to add your
Suggested-by: and other tags:
https://lore.kernel.org/linux-btrfs/41c43c7d6aa25af13391905061e2d203f78533=
82.1660199812.git.wqu@suse.com/T/#u

Thanks,
Qu

>
>
>>
>> Thanks,
>> Qu
>
>
