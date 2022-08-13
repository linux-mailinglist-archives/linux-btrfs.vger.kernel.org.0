Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0959591975
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 10:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiHMIhh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 04:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMIhg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 04:37:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58B772EC8
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 01:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660379852;
        bh=LTXXIUaz7qzxgkljYxKN7uleYsEzQTFTFweGDoKLmDM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=g6wykE5pkYHjCpR7TlGcdZcB0QNqFyBbsA+NKTmqRVmwpDwTahJFmAHoEwizzeID7
         OpukTGQyLWJmCA1oK4xS5xldWUe7fVQd3UC7XkBz73EDdSg/L3qGGLF3W/xAyZ9C/3
         7i/8QROye6jVO7Tbo976zgC/hOYz9aRDnBFpzOHQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6siz-1nJ7qe34nf-018LgF; Sat, 13
 Aug 2022 10:37:32 +0200
Message-ID: <f27f4453-cd3d-4898-05c5-970c8296e64b@gmx.com>
Date:   Sat, 13 Aug 2022 16:37:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Corrupt leaf, trying to recover
Content-Language: en-US
To:     Ash Logan <ash@heyquark.com>, linux-btrfs@vger.kernel.org
References: <6270a749-5fb2-0b36-529b-07f0e2ce4639@heyquark.com>
 <0b4a3bca-cafd-b47d-d03c-a97922e49228@gmx.com>
 <c1b246ad-6665-1216-166c-a1ad32222b35@heyquark.com>
 <a9d3eb38-e939-4751-4dc8-896fa653be73@gmx.com>
 <593e9196-7455-1874-750f-2f11443d7841@heyquark.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <593e9196-7455-1874-750f-2f11443d7841@heyquark.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JKiHHYvoeJjTaBTT3w/gCFcGHbGIyl/3lJ03qQuluesVU36DaVW
 sQB3LyOFS0ra6vQBFsikXWm7vx/FRPKqovPBeWdaoyIoM2sYpTV/wtZU5b7dFbknqEH0wqb
 fL2F3Uc6oyVZPyT6480rFaxuHH1TatO453rbm/lFWAF2e91VnRC+wNf/+LPlpoWOIvBizK+
 0EKJG+06yfEt7SRrMMeKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ozXIBZcVbHw=:YoOqDrf/qAzOgtmpg22uUD
 6172f0v82fTLHr16+GxyYAjB06KQ1oObYy/I2tds0WGQ9TZa/ezPWClZ+KtBYlClhQfSi240b
 HtWvbp28/W9nUnjQsSY9EbB0oTQjBlnQ8BTpvQ87VU/xuaYJ9X7OPcpuJdFx+ud8hV6JWERzv
 GTp0uDuiomF2IHh12r0cXV77yUwKzvG2BaaYFgRuH1P7qk7uoTn8YnNiwzinZwy0yEN+38UPh
 UmjMIooI5joYVFDQUtg7RBmmT1OmsyEtfUH6vE52YyTa9YNuqNbERLMe4naW4zDnvgFMFyzbG
 0Vi3AWX6tcN4Lg9PlVLGawZBVGq5ypeA/oTHo5N/UQfueq54NahPk5MZlFHi65Q1kIlW9SXSw
 SVPwUKMMyhZb/TPgNCf7jtX2ftKXso0aGi3xcXoAzJaUySxW2h6ndwOURCKPikpZ5pXCKqF7m
 upDPvVtCXAtLrMYmrcynZ1VOFZrr/vFQUBYN88xEaq5vCJqH/+8nB8MgVUEJxIkWAA6BKD4DU
 z8rpc2VNDU7wUWf/DfGSipKl9jgFJHixeKE5Kr9/OAGIrILYzNBxcFJmCFRmyCJuvOtNXnwW1
 jilhsZxYoalu1El1Gp5+xVQ65lzyx9CMjCl4qUSN67u4VluCCIEQQEgXfRHam7aW9o+gP5LyW
 bNTjWcXaqGkq2/RMaFdV3+lyezVg2Cr7S0zG6AOmtKonjjhCDcDOpDpj7UD0dLDjDuZUG+2PH
 vGgJHGqDhRjcV7RqDXMvzFfanc1Jbjv3pwdaqcqMovmre9Ik7DJtuWgudLFEycMheW75SZ0Bp
 IHr5BRiNeJnrAcZSkF1t0TxPTWTUzmj28NCZg0lKkETTX941jdIbt6C13eCpehhe3CkC6/B/d
 XjkCBlgNzUsMWPrIcq6s5BhFFUXVFQ1V8fQKSpI22MwW4UiFn4eVHRyIC9YFmNJ0cr8LIDnB/
 wRs+A6kDsl67P/+5EYysdN6Byl3agEWlCjXpSprb2ZaXFtfFwAxldKUHqy8k7SiRswh4NEZiJ
 /CAz1UfycddItPnOacSDhndlfB8Hce8uLzwbahwCqN4LsHpCfGeUWmY750DPzxRQeF8MeIHsg
 Q4t/oEEb5jv4p0x/7Wjf++mubXdcBAoXKxQmtPJbuUXafvAsSmJHG6zHw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/13 16:28, Ash Logan wrote:
>> It looks correct, all other ROOT_ITEMS has no extra flags, and only tha=
t
>> offending root has the problem.
>>
>> Thus it looks more like a bitflip.
>
> Cosmic rays got me, perhaps. Thank you for your help in diagnosis!
>
>> Yes.
>>
>> As long as that's the only bitflip, everything else should be fine.
>>
>> If you want, you can remove subvolume 389 (and if that's the only
>> bitflip) using the older kernel and then mount using much newer kernel.
> Would I be safe to copy the files to another volume before doing that?

Yes, that should be safe.

The offending corruption really only affect that ROOT_ITEM, which is not
related to any file/directory under that subvolume.

You can safely reflink all the content to another volume and call it a day=
.

Thanks,
Qu

>> Personally speaking, it's strongly recommended to use kernel newer than
>> v5.11, even if a memtest is clean.
>>
>> That new sanity check introduced in v5.11 should save a lot of hassle
>> like this.
>
> Debian doesn't ship it, though.. Will have to see what my options are
> there. Maybe time to build my own. >
> Thanks,
> Ash
>
>>
>> Thanks,
>> Qu
>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> Let me know if you have any advice.
>>>>>
>>>>> Thanks,
>>>>> Ash
>>>>>
