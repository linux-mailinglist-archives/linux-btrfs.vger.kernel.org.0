Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36DF539D0A
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 08:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349850AbiFAGLE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 02:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349803AbiFAGLD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 02:11:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15B0517EC
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 23:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654063857;
        bh=6EQXAuDN6s3CxRKui3+RZ70AYXTMGBdKaDtw656eGKU=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ZQDxURFMuEfM6CDat/1/hqD2nrymnGutaN5LWDS2QDlb7QAWZv6PRA++u7HyaY4pj
         G2MdKsBStPrg/0xV2tPmhs2UM6HDWPL2HSVohHlIlWCfuV+tyjtzGsHclindioNhtj
         9jV/wBBdR3DMCbr77wOY7+ROgUCkSYbX95rJyVJc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7R1T-1nkB9p3FSH-017kH9; Wed, 01
 Jun 2022 08:10:57 +0200
Message-ID: <c022b317-2623-e5a5-7302-89144ad59b42@gmx.com>
Date:   Wed, 1 Jun 2022 14:10:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs: add btrfs_debug() output for every bio submitted
 by btrfs RAID56
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
References: <de8cc48c6141a20fb2ccf2b774981b150caee27b.1653988869.git.wqu@suse.com>
 <20220531144328.GI20633@twin.jikos.cz>
 <a0a1b6af-30f4-d785-a905-60a053a60bc6@gmx.com>
 <d1dd5698-52fd-3992-0233-f03ce2049d34@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <d1dd5698-52fd-3992-0233-f03ce2049d34@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a7nSIA3hIoZ7fdJcT+wOhqFmPSUTiAVMBPP1TPawvyCbUZ0KUx3
 wJTzQpvGbSkZjnySP1wkINdZowovtwn12hlBGjrQZ6UaR8y7WKxJFqqVkl7XC1pQAKfxIJx
 o1+rP+Vn7Vf8g+sD+Hz37cTipeDIQazjAJkrf6BTVl9MMdu80h2a8F/mV3K7bMl13EE2ns4
 P0OgALTaxvvDGdCKp8K7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TICwLEHSz8k=:bubu0fJdMWFdzSpWDwt2k6
 oIU7utzzB9qs8CLL+VIMYClpPtUm/5balrPrS6GkCQmB/aJx94qvExtbMKY1rLkIfxUmhvZAd
 V6X3xpKNJGmGC7i5TJu5eLcBONi1LvXyneaAE66K9Cs17k7l5n2HYtyo7MSJmh6rBecxUtGOd
 ediSFcx531Npi1Xs+aUObdze16no0QTdeel64Fp0uJzpXfpBd4CTWb4cjWbh1rG/86aaMu5B4
 1BvxdTu1C/cFH8oBf97h9bN2QbwlhnHgJ5SKWPfsjYDW4kzlO6zUR/m74FAkjihuqsIs2xXpY
 QGTM9q+vGCe/I5vnOrys6rArbwfatbYZVphqyfNqx/GahP/hjw96iYCujYPhecPf9hOTGG6Yx
 cMr3WmmvUUbKsE2kZ2GucJPqmJyhDVrL3vVTicql4PNrNeidp10gYgUfqMSECxGwR99e4OLZM
 mb4aV4hveb9uuNaBgX6Yq8sVQMz6QRdF1wE7i9BYffFSV9rp1/Dn1w+AJn4aZKTT9y3gkNi52
 /emXmRuzGUv/cEaAPHCVFkVUO2YdoPa+IWmQiuIg29ElVGHz9FaXOAsI3D7vqn/FiqOJI7/0S
 rxl9ClaxSkOx8v1aXxHzo1IglX7a5SEkAY0qK5UFXvYReekHUtGEPaXaA0mUQQkkCLZGgooN8
 jv6it3JzSjFhD9Qgj6Iz33GyGpmvRMXLNACesLzGE7EgUN77+zCKAJJcNgEPk7LIZHXlai7Rw
 xuflJr2ELQXeo+RX1xH/e5RRVMjCORMtn62eTQJqgs0iVQBAFPBgGhNfjyw3JpyiWP5Ffp6It
 AxTBUcnZdg+G17OoeD0VwWfWd98+ugnKLK6AtMFJKsQLIYyrS1h37YkW/+ncminDS5uqBAQPK
 Xa9NkjHv7WmoLzIXCxjRxcQ83ypsmY+EaVix0sQ2b6V6cE5ibaSefnHsuPrVpNPGymN+uNiuw
 z80yOd1K5QQtfgOxRSJVs+iNsoFpLYbGxh0xcbDkfwh629KzPF6Tpnd05sPcYDV4yuHFGHYaF
 hajL7NnyV2PfKUnbqHL3d40EFYsMSiU0BwSdKEnGJBGQOcm5sFM1sl3+9CKNfvgiGjs5f9yiL
 /fmMH+EnKy1epmzn0h0/7aXAM/AG5STnjOhO1BSugfmD1KWwkL0Lfl2YA==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/1 14:07, Nikolay Borisov wrote:
>
>
> On 1.06.22 =D0=B3. 2:12 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2022/5/31 22:43, David Sterba wrote:
>>> On Tue, May 31, 2022 at 05:22:56PM +0800, Qu Wenruo wrote:
>>>> For the later incoming RAID56J, it's better to know each bio we're
>>>> submitting from btrfs RAID56 layer.
>>>>
>>>> The output will look like this:
>>>>
>>>> =C2=A0 BTRFS debug (device dm-4): partial rmw, full stripe=3D38915276=
8
>>>> opf=3D0x0 devid=3D3 type=3D1 offset=3D16384 physical=3D323043328 len=
=3D49152
>>>> =C2=A0 BTRFS debug (device dm-4): partial rmw, full stripe=3D38915276=
8
>>>> opf=3D0x0 devid=3D1 type=3D2 offset=3D0 physical=3D67174400 len=3D655=
36
>>>> =C2=A0 BTRFS debug (device dm-4): full stripe rmw, full stripe=3D3891=
52768
>>>> opf=3D0x1 devid=3D3 type=3D1 offset=3D0 physical=3D323026944 len=3D16=
384
>>>> =C2=A0 BTRFS debug (device dm-4): full stripe rmw, full stripe=3D3891=
52768
>>>> opf=3D0x1 devid=3D2 type=3D-1 offset=3D0 physical=3D323026944 len=3D1=
6384
>>>>
>>>> The above debug output is from a 16K data write into an empty RAID56
>>>> data chunk.
>>>>
>>>> Some explanation on them:
>>>> =C2=A0 opf:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio operation
>>>> =C2=A0 devid:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs devid
>>>> =C2=A0 type:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raid stripe ty=
pe.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >=3D1 are the Nth data str=
ipe.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -1 for P stripe, -2 for Q =
stripe.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 for error (btrfs device =
not found)
>>>> =C2=A0 offset:=C2=A0=C2=A0=C2=A0 the offset inside the stripe.
>>>> =C2=A0 physical:=C2=A0=C2=A0=C2=A0 the physical offset the bio is for
>>>> =C2=A0 len:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the lenghth of =
the bio
>>>>
>>>> The first two lines are from partial RMW read, which is reading the
>>>> remaining data stripes from disks.
>>>>
>>>> The last two lines are for full stripe RMW write, which is writing th=
e
>>>> involved two 16K stripes (one for data1, one for parity).
>>>> The stripe for data2 is doesn't need to be written.
>>>>
>>>> To enable any btrfs_debug() output, it's recommended to use kernel
>>>> dynamic debug interface.
>>>>
>>>> For this RAID56 example:
>>>>
>>>> =C2=A0=C2=A0 # echo 'file fs/btrfs/raid56.c +p' >
>>>> /sys/kernel/debug/dynamic_debug/control
>>>
>>> Have you considered using a tracepoint instead of dynamic debug?
>>>
>>
>> I have considered, but there is still a problem I can not solve that
>> well.
>>
>> When using trace events, we have an advantage that everything in trace
>> event is only executed if that event is enabled.
>>
>> But I'm not able to put the devid/stripe type search code into trace
>> event.
>> It will need to iterate through the rbio->bioc->stripes[] array.
>> I'm not even sure if it's possible in trace events.
>
> With the trace event you can do:
>
> if (trace_btrfs_raid56_enabled()) {
>  =C2=A0=C2=A0=C2=A0=C2=A0stripe =3D expensive_search_code()
>
> }
>
>
> trace_btrfs_raid56(..., stripe)
>
>
> I.e execute the code iff that particular event is enabled and pass the
> resulting information to the event. For reference you can lookup how
> 'start_ns' variable is assigned in __reserve_bytes and later passed to
> handle_reserve_ticket which in turn passes it to
> trace_btrfs_reserve_ticket.

Awesome! exactly what I need.

Now I will go fully trace events, since the dynamic debug still needs to
run those helpers anyway.

And with trace events, I can provide a better readable result for the
stripe type now.

Thanks,
Qu
>
>
>
>>
>> So I go dynamic debug, with the extra cost of running devid/stripe
>> search every time even the debug code is not enabled.
>>
>> Thanks,
>> Qu
>>
