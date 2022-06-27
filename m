Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC8F55E096
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jun 2022 15:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiF0Ozp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jun 2022 10:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiF0Ozp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jun 2022 10:55:45 -0400
X-Greylist: delayed 486 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 07:55:43 PDT
Received: from mail.mailmag.net (mail.mailmag.net [5.135.159.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5310165A7
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jun 2022 07:55:43 -0700 (PDT)
Received: from authenticated-user (mail.mailmag.net [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mailmag.net (Postfix) with ESMTPSA id C3483EC7755;
        Mon, 27 Jun 2022 07:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net; s=mail;
        t=1656341255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRCfXRoZeDfdkVZ/s/uXDqwLkd4nfhE2Y+NUxlzeKqM=;
        b=GE9laeUA8Hk43v841duto1xOVLzbU3BvHVqGAWuOFTV931Rm9W8UUR7lBSfN9gHqmwaGoM
        hhCjexx611VmvVBxMMAqs0XQ4a3P7COuusVIrBtNtS7vxbmH1RzmuGWbkmCW7YlUvy28t9
        YCBysL6lux+yIkDaPu7yfhj9BXT57Xw=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joshua Villwock <joshua@mailmag.net>
Mime-Version: 1.0
Subject: Re: Question about metadata size
Date:   Mon, 27 Jun 2022 07:47:21 -0700
Message-Id: <E77A8A5F-4C3F-479C-9428-DE56C82A8618@mailmag.net>
References: <6a345774-e87c-ad3f-1172-e1d59f1382a7@gmx.com>
Cc:     =?utf-8?Q?Libor_Klep=C3=A1=C4=8D?= <libor.klepac@bcom.cz>,
        linux-btrfs@vger.kernel.org
In-Reply-To: <6a345774-e87c-ad3f-1172-e1d59f1382a7@gmx.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=mailmag.net;
        s=mail; t=1656341255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRCfXRoZeDfdkVZ/s/uXDqwLkd4nfhE2Y+NUxlzeKqM=;
        b=oRRZ62AGzvYsZHgTudoKs0kJjFS7jVzsG9KL58eKhhv9AbMPHfdnzG4GxRyGcA7Ke3QTrI
        /Z5A2ZPkPODSYOkTZB4l6WhOO7yHBaxKCTGxtAtTypDQ9a0KQxICZT2+yGWR0cVVbqrlK3
        pDS/eEOFdbqrM7bjleIcrKtnL/ZE51o=
ARC-Seal: i=1; s=mail; d=mailmag.net; t=1656341255; a=rsa-sha256; cv=none;
        b=4WSQtmA9wQo3UExEKuomeqvUGawC/ZEl6ohZpC2VdZosFQ+SUboUuMtcfM0NpTCQ94RaLq
        pg2o9AnSkBabY30zXFJTlM6bz3eM5SpzoIOyEhcdMz692wI2DGTYM5UvXeoY8Cm02KsVQI
        cFB8yvYXCA+XCmy7DuTkz57d/rSoD+I=
ARC-Authentication-Results: i=1;
        mail.mailmag.net;
        auth=pass smtp.mailfrom=joshua@mailmag.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



=E2=80=94Joshua Villwock

> On Jun 27, 2022, at 5:47 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>=20
> =EF=BB=BF
>=20
>> On 2022/6/27 20:17, Libor Klep=C3=A1=C4=8D wrote:
>>> On Po, 2022-06-27 at 18:54 +0800, Qu Wenruo wrote:
>>>=20
>>>=20
>>> On 2022/6/27 18:23, Libor Klep=C3=A1=C4=8D wrote:
>>>> On Po, 2022-06-27 at 18:10 +0800, Qu Wenruo wrote:
>>>>>=20
>>>>>=20
>>>>> On 2022/6/27 17:02, Libor Klep=C3=A1=C4=8D wrote:
>>>>>> Hi,
>>>>>> we have filesystem like this
>>>>>>=20
>>>>>> Overall:
>>>>>>       Device size:                  30.00TiB
>>>>>>       Device allocated:             24.93TiB
>>>>>>       Device unallocated:            5.07TiB
>>>>>>       Device missing:                  0.00B
>>>>>>       Used:                         24.92TiB
>>>>>>       Free (estimated):              5.07TiB      (min:
>>>>>> 2.54TiB)
>>>>>>       Data ratio:                       1.00
>>>>>>       Metadata ratio:                   1.00
>>>>>>       Global reserve:              512.00MiB      (used: 0.00B)
>>>>>>=20
>>>>>> Data,single: Size:24.85TiB, Used:24.84TiB (99.98%)
>>>>>>      /dev/sdc       24.85TiB
>>>>>>=20
>>>>>> Metadata,single: Size:88.00GiB, Used:81.54GiB (92.65%)
>>>>>>      /dev/sdc       88.00GiB
>>>>>>=20
>>>>>> System,DUP: Size:32.00MiB, Used:3.25MiB (10.16%)
>>>>>>      /dev/sdc       64.00MiB
>>>>>>=20
>>>>>> Unallocated:
>>>>>>      /dev/sdc        5.07TiB
>>>>>>=20
>>>>>>=20
>>>>>> Is it normal to have so much metadata? We have only 119 files
>>>>>> with
>>>>>> size
>>>>>> of 2048 bytes or less.
>>>>>=20
>>>>> That would only take around 50KiB so no problem.
>>>>>=20
>>>>>> There is 885 files in total and 17 directories, we don't use
>>>>>> snapshots.
>>>>>=20
>>>>> The other files really depends.
>>>>>=20
>>>>> Do you use compression, if so metadata usage will be greately
>>>>> increased.
>>>>=20
>>>>=20
>>>> Yes, we use zstd compression - filesystem is mounted with compress-
>>>> force=3Dzstd:9
>>>>=20
>>>>>=20
>>>>> For non-compressed files, the max file extent size is 128M, while
>>>>> for
>>>>> compressed files, the max file extent size is only 128K.
>>>>>=20
>>>>> This means, for a 3TiB file, if you have compress enabled, it
>>>>> will
>>>>> take
>>>>> 24M file extents, and since each file extent takes at least 53
>>>>> bytes
>>>>> for
>>>>=20
>>>> That is lot of extents ;)
>>>>=20
>>>>> metadata, one such 3TiB file can already take over 1 GiB for
>>>>> metadata.
>>>>=20
>>>> I guess there is no way to increase extent size?
>>>=20
>>> Currently it's hard coded. So no way to change that yet.
>>>=20
>>> But please keep in mind that, btrfs compression needs to do trade-off
>>> between writes, and the decompressed size.
>>>=20
>>> E.g. if we can have an 1MiB compressed extent, but if 1020KiB are
>>> overwritten, just one 4KiB is really referred, then to read that 4KiB
>>> we
>>> need to decompress all that 1MiB just to read that 4KiB.
>>=20
>> Yes, i get reason for this.
>> I just never realised the difference in extent size and it's impact on
>> metadata size/number of extents.
>>=20
>>> So personally speaking, if the main purpose of those large files are
>>> just to archive, not to do frequent write on, then user space
>>> compression would make more sense.
>>=20
>> Ok, these files are writen once and deleted after 14 days (every 14
>> days, new full backup is created and oldest fullbackup is deleted. Full
>> backup is dump of whole disk image from vmware), unless needed for some
>> recovery. Then it's mounted as disk image.
>>=20
>>>=20
>>> The default btrfs tends to lean to write support.
>>>=20
>>>> We can use internal compression of nakivo, but not without deleting
>>>> all
>>>> stored data and creating empty repository.
>>>> Also we wanted to do compression in btrfs, we hoped it will give
>>>> more
>>>> power to beesd to do it's thing (for comparing data)
>>>=20
>>> Then I guess there is not much thing we can help right now, and that
>>> many extents are also slowing down file deletion just as you
>>> mentioned.
>>=20
>> So i will have to experiment, if user land compression allows us to do
>> some reasonble deduplication with beesd.
>=20
> As long as the compression algorithm/tool can reproduce the same
> compressed data for the same input, then it would be fine.

Does Nakivo support compression that plays nice with dedupe?

I know Veeam for example has =E2=80=9Cdedupe-friendly=E2=80=9D as a compress=
ion option which makes it output less-compressed data, but ensures your stor=
age appliance can dedupe it.

Not sure if they have something like that, but if so, it would probably be t=
he best solution.

>> It may maybe speed up beesd, it cannot keep up with data influx, maybe
>> it's (also) because the number of file extents.
>> Unfortunately it will mean some serious data juggling in production
>> environment.
>=20
> I'm wondering can we just remount the fs to remove the compress=3Dzstd
> mount option?
>=20
> Since compress=3Dzstd will only affect new writes and to user-space
> compression should be transparent, disabling btrfs compression at any
> time point should not cause problems.
>=20
> Thanks,
> Qu
>=20
>>=20
>> Thanks,
>> Libor
>>=20
>>=20
>>>=20
>>> Thanks,
>>> Qu
>>>=20
>>>>=20
>>>>>=20
>>>>> Thanks,
>>>>> Qu
>>>>=20
>>>> With regards, Libor
>>>>=20
>>>>>>=20
>>>>>> Most of the files are multi gigabyte, some of them have around
>>>>>> 3TB
>>>>>> -
>>>>>> all are snapshots from vmware stored using nakivo.
>>>>>>=20
>>>>>> Working with filesystem - mostly deleting files seems to be
>>>>>> very
>>>>>> slow -
>>>>>> it took several hours to delete snapshot of one machine, which
>>>>>> consisted of four or five of those 3TB files.
>>>>>>=20
>>>>>> We run beesd on those data, but i think, there was this much
>>>>>> metadata
>>>>>> even before we started to do so.
>>>>>>=20
>>>>>> With regards,
>>>>>> Libor
