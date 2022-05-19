Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EFC52D3EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 May 2022 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbiESN1O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 09:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbiESN1L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 09:27:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301B081480
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652966818;
        bh=6ks6R84BcrOekXG8qi3FPacSpqk8cHQ7ALFXL8tznk4=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=Ea68aqWpZm6WybOaRLCh+4XVtVGu978zzfWCMhVDIMZQutGow6vM3hhOpQV98G8r+
         frBBazwSOMlTkYB6I5elY9L93YM+MMLh3XX9A2ErkhhbI69tOmYwlKzmWPZZ0usFpX
         R71sTwhymuXRAWRPgEDqIhKLzQ7Eqc680wAIFO5w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqb1c-1nVrwv20W0-00mZ5d; Thu, 19
 May 2022 15:26:58 +0200
Message-ID: <e0ba76bd-72c0-fa6e-212f-92e060d79d42@gmx.com>
Date:   Thu, 19 May 2022 21:26:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC ONLY 3/8] btrfs: read raid-stripe-tree from disk
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <2ccf8b77759a80a09d083446d5adb3d03947394b.1652711187.git.johannes.thumshirn@wdc.com>
 <6ddec77c-2aa5-d575-0320-3d5bb824bd04@gmx.com>
 <PH0PR04MB7416E825D6F1AC99F8923B659BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ab540ece-37b4-7cb5-216b-dad26ee75ccb@gmx.com>
 <SA0PR04MB741858084F504990FE654F879BD19@SA0PR04MB7418.namprd04.prod.outlook.com>
 <a1b876ca-6e6e-39df-ab70-0dd602229f0d@gmx.com>
 <PH0PR04MB74162E6BE1BB1F9519C440199BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <a6540b7b-409f-e931-dbfd-98145b48581c@suse.com>
 <PH0PR04MB741655C18EA13F9152DAEB509BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
 <e66ba88c-52f0-3db9-7284-f7a161542634@gmx.com>
 <PH0PR04MB741660F84BFA0F9C4E0204A79BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB741660F84BFA0F9C4E0204A79BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lYiqycEXXnBssb1+ZJ8XesypIG/fUHz3Bjy4/p42TblRKR2+O26
 Bb+n549uXK0YkIyvDRtJF1R6WkH1P3+5aRCIsPNwGRjcs1Q3z9/PVch+Jwldu88x15lRcrv
 2+xeiU96Y9gik5uCO5aRMDH7fhfL29/Xj3CL0Bgi3zG6FoHajK2VN3sKbd7xDxpe0JWxJnn
 l8AgVRmz8UGoDBydNdjfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vVzrBr9TN9c=:NFUTAIavyLJAigao39nLvW
 9gtDgYCqDlCAFJ6Zw14hNvrVdxLZhQJkJlPpRg2wQKp+ZYHWg1Vc3d2QGHZN+AyyY7utzhxne
 FbkvSmWGoyxl+mhDonMs3EyY97vd0tlMLpcy8y07Vz8TV7OSh+FzViKbCK5RtgdY/+yc+Un52
 PiEVSZpp2OWbS7Bim5rSEZZXDQPXGmh8SQkiszTjd5m4uRmcKTUg27v/k6hLH9ta2v1EHb3NC
 NcWHObivxn5QA7jA2RHscv809VHPJF6J8D1O5rmxyEaw8AemB8twZVJc/zKJhiB+YCue1635k
 M3+hygoN4xKKCdYFlvaAe3OACxrDiUyplakemmCCiCWZggT+TIqZWzh9Vm/f0+7gM4ZH5a73G
 9Er0OSj7td680NlTFEMClccw42WFzpihWETQsDMifLp316E0dOtEtT9YXU9ZTwvaR8QZsEoBL
 OWg0FBG1htAzkAueZB9CStFz5vr542oyRXl/eCK+lL3letW7i6q/Bb4LyXpE8RGXq5TE463h1
 S2FyfMo4tlCPCDpftsuVmvvQQwLfAXb9FSqcfwxFxaa/cjaz65h+w3Jo9nVKTNxAcTBa45D2x
 lO4NKHRh3mgj+S29fkGNlrqQkMWDKtqAv4q4JTh8KTSVGncl0Iz9z8dM7pbs+gkM6YW8Vd2kG
 qEIin9aEUx3JVDMsrEjDVQ1/UmvodL/sdPTzehZLhjpWlpCpGmReyklOPtmA0F4Wi0Q59U+Py
 urVhyTPYwoyGNWHSnVWh5AZ3SE8gXoIKydOk98yZ5LCr+wBod1L8W8zQEEeP1Esm6+g2NtYRv
 gmFUfF/msWl6is95+xaVrU3Wp2/YEwBjFMlrVdwAFBtuRPmSSw1GTOcdODf7YX0N/VmpVVxhI
 3HWcLe2tVknTPcXowuAknegirlabV4F88jFrwVK2OeAnuxokIk85rq0wjxPuDI/1dtjD127Vi
 eM5tFZn3wdNkYrlMlasMItWCtbqb3UAVCmX0zorp2izENjWH6opt3gC7Ficmx1aAbjOjmw5SX
 UWwe+i+8Y6M0aAoZNWCHgcfoOqZ/U8BHQ4n3DAsIrMXLvyX58YwtYWXVhMdjrwvD+EKb2YSNM
 PauARFX7B6NKkEoDll+WPMNuDD2cDKezHxEu3COrJVnfpPpf3NGuJ+SGg==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/19 19:53, Johannes Thumshirn wrote:
> On 19/05/2022 13:48, Qu Wenruo wrote:
>>
>> On 2022/5/19 19:44, Johannes Thumshirn wrote:
>>> On 19/05/2022 12:37, Qu Wenruo wrote:
>>>>> RAID1 on zoned only needs a stripe tree for data, not for meta-data/=
system,
>>>>> so it will work and we can bootstrap from it.
>>>>>
>>>> That sounds good.
>>>>
>>>> And in that case, we don't need to put stripe tree into system chunks=
 at
>>>> all.
>>>>
>>>> So this method means, stripe tree is only useful for data.
>>>> Although it's less elegant, it's much saner.
>>> Yes and no. People still might want to use different metadata profiles=
 than
>>> RAID1.
>> For RAID1 variants like RAID1C3/4, I guess we don't need stripe tree ei=
ther?
>>
>> What about DUP? If RAID1*/DUP/SINGLE all doesn't need stripe tree, I
>> believe that's already a pretty good profile set for most zoned device
>> users.
>>
>> Personally speaking, it would be much simpler to avoid bothering the
>> stripe tree for metadata.
>
> I totally agree, but once you get past say 10 drives you might want to h=
ave
> different encoding schemes and also have a higher level of redundancy fo=
r your
> metadata than just 4 copies.
>
> The stripe tree will also hold any l2p information for erasure coded RAI=
D
> arrays once that's done.
>
> So this definitively should be considered.


Then let us consider the extra chunk type flag, like
BTRFS_BLOCK_GROUP_HAS_STRIPE_TREE, and then expand the combination from
the initial RAID1*|HAS_STRIPE_TREE to other profiles.

But for over 10 devices, I doubt we really need to bother metadata that
much. Consider we go RAID1C4, we have the ability to lose 3 devices
already, that's way stronger than RAID6. For metadata I believe it's
completely fine already.

Normally it's data requiring more balance between cost and redundancy as
they are the main part of a fs.

Thus even for 10 disk, metadata RAID1C4, data RAID6 (with stripe tree
for zoned), it still looks very reasonable to me at least.

Thanks,
Qu
