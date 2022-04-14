Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC608501EB1
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 00:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbiDNWum (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Apr 2022 18:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiDNWuk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Apr 2022 18:50:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BB6C6EE6
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Apr 2022 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649976490;
        bh=2G4p3MJqimDjHFH3SsfUteu5E5spwU0XKNI0Y5romNA=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=l9Dk7zxwrck1+NAIz/VlvbQWbaXdkL4ZhD3os9ZGetXw6FWSdSht6ow49L/lkJ052
         HtxxQYudbvCEGJAxg55ZHWX2E0jYgEonWCps8sM6I3KzGmR6ROEtMonLzQEtZytFJX
         B+TOJaFNkJh/ZFuqjc466m0KoYLFVQiBjceLy+nc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHnm-1nv1Tk0lbO-00tnF9; Fri, 15
 Apr 2022 00:48:10 +0200
Message-ID: <44ebe35f-aad0-aa90-7792-814769a450a7@gmx.com>
Date:   Fri, 15 Apr 2022 06:48:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1649753690.git.wqu@suse.com>
 <d2873b5f3a00e9bb966150b4dd0253f4db107c12.1649753690.git.wqu@suse.com>
 <20220413191456.GN15609@twin.jikos.cz>
 <5b296828-65fb-b684-dedc-6f018e5ece4e@gmx.com>
 <5b190bf5-892c-0856-e623-f6f716985b28@gmx.com>
 <dce41e95-a11f-3897-bd51-51a10c0da799@gmx.com>
 <20220414155150.GQ15609@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 07/17] btrfs: make rbio_add_io_page() subpage
 compatible
In-Reply-To: <20220414155150.GQ15609@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ya6w77xfdz4VLq/9iu1vJDXZY7/FkNhKJOCSsTZIgsMB/ZZS3tY
 pOV8TVeyvQz7UlzP2xqmkK8wDht+OtEe536nhl7ZiI3JWAaKCLjG4qvTPg6JscFHloEQVIJ
 RY5HMAKrX4SJXl91/3sA214LUwK0jpedbII2GcFdvG6BZoh9VH6B0m5RbOpXLQUcGe1fz3J
 Qh195avQbCsqBD7tucaVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kli+UyZniv0=:lAd8Pb9efUTEH5FHsEv0et
 HAJAhJ2+SvFvkua/mnNuaoJOzlY3QJDtX9vgy4sHEtzVtC57PtHOGQ2k+TGdOVdqlMZ9O8JDh
 Td4ojLkJ3PMnF4UToRDQFZfbY6zny7weEP/D8oF2rZyK5Z4rQ6KWgCY7cQEVhXCJY2RCpQvhD
 OKr6mxlD/rSsK1fCz+Xf9E4SbAHVCExD6oHeMb2Fi0cgWzD/A/tuGKvcXicrdaxG7EwKnaUYu
 Gb/C90VB7eZHvde9h4XNxPpK2wyAqi7WZWNvfErSg8QEdfj8cH9JBnn/LWgiWgLt++Usx17tc
 IvdMaJd0h5Qhb4kF+yr7IFpZYewyMnFurH2ScdzUZG9XQsL+UgtWjKHO3rP8HzVdBvglFfH9W
 imotxXkrxTf6n+abS0Wf1Ic1BgZJ0PWeb4o79pj6yQMOcMMuGDqc2+6FhrH/rlP8QTnwJYeF+
 6TSgaMbZhUvs0hWzrj5t4Zry11VQmA2IZeSMRxzPYPsHTC/EOHcqtYGJhCRfsHk50x8QBCgmu
 PXCVtZu25QrnUZllBuONDdq9tZZZnmXZZOelIgyYHFBYxab3RH4XAZpzYtUq00vcPXODb0qhj
 Sg2hysNSikRsB7iNa7ZcGrN4wkLb29T/SQmQpp+pCoX8jjSTc5DPPoxz3SBa/IwQ6x9LRgHfk
 iqTJG7PLYGkxcP1kZ4nFm6aB4ZddfunzgtP8Tk1vtfJael//Sr+SsFNubGr1Uvs62okMWusJZ
 xaRWW0HR9peh+BT3gROTm3neigo4HYBrJ/WqnNOkXVIiLV0U1j+1m3QPYVLCF61M/FOYbf74g
 57fnos10BeblXWSoZdqlDVR4gvEXVhKTAjHYiwrBSgApbawC+UE997awrC4PMjt+dk3OISIei
 45127TO7jEey4CaBnshJk/gFI5fRHSGfrxlVmce/Lwnjof7tvwdX/tMDHry4N2RrJa3AFplQk
 910xoIEjApqboVtLpX4WKXgQaQDSIy2KFDk0GN4H2zomnAGIybrzDvpSFMukPcNYCJ4KPfCeq
 7xK9dcx7cnN9wadYydfCf5ZBntY4xGuv3T9YnThpwi32uQ+dp59QL11vYIEPfKYxxVhf10HKO
 BP3R9UPsrqt/y4=
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/14 23:51, David Sterba wrote:
> On Thu, Apr 14, 2022 at 06:59:58PM +0800, Qu Wenruo wrote:
>>>> to see what's wrong.
>>>
>>> It's a rebase error.
>>>
>>> At least one patch has incorrect diff snippet.
>>>
>>> For the patch "btrfs: raid56: introduce btrfs_raid_bio::stripe_sectors=
":
>>>
>>> For alloc_rbio(), in my branch and patch (v2) submitted to the mailing
>>> list:
>>>
>>> @@ -978,6 +1014,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct
>>> btrfs_fs_info *fs_info,
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rbio =3D kzalloc(sizeof(*=
rbio) +
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(=
*rbio->stripe_pages) * num_pages +
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(=
*rbio->bio_pages) * num_pages +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(*rbio->st=
ripe_sectors) * num_sectors +
>>
>> The more I check this part of the existing code, the worse it looks to =
me.
>>
>> We're really dancing on the edge, it's just a problem of time for us to
>> get a cut.
>>
>> Shouldn't we go the regular way, kzalloc the structure only, then alloc
>> needed pages/bitmaps?
>
> Yeah I agree that this has become unwieldy with the definitions and
> calculations. One thing to consider is the real memory footprint and the
> overhead of one kmalloc vs several kmalloc of smaller memory chunks.

One thing to mention is, although our one kmalloc seems to be some
optimization, I guess the benefit is already small or none, especially
after subpage patchset.

Just check for 3 disks RAID5, one btrfs_raid_bio already takes over 2Kilo:

  After:  2320 (+97.8%) (From the cover letter)

In this case, I doubt smaller kmallocs would cause anything worse, as
kmalloc() will give us a 4K page/range anyway.

> Both have pros and cons but if there is no real effect then we may have
> better code with the separate allocations.

There are some ways to optimize, but they may be a little aggressive.

The most aggressive one would be, replace "struct page **stripe_pages"
to "struct page *stripe_page", and use alloc_pages_exact() to allocate a
range of physically adjacent pages.

In fact I'm even considering this for extent buffer pages, but it would
cause way more unexpected ENOMEM when memory is fragmented, thus too
aggressive.

Thanks,
Qu
