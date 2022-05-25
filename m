Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E46F5339FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 11:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbiEYJfz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 05:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiEYJfy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 05:35:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F78CB35
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 02:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653471341;
        bh=MWtrIdByVqBS9Fz4Vqqr9Q4E0dDeCfmbPZiLLxDdu7I=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ODOh5AWcdNj/d6RbRRs0kNmV0dnbvmx+EMftln/bjVcCxeVq/1NUsK5nspuAZHMBx
         Sdl1yLzcb/+yNgfrI8sbthA6KamPdJDqFFFgA1Iu8Y5E1mdDn4bwmMAnsJLzg5VjAO
         cOt1xjvJlW+4eqFj6Vz+ZUs0QcVCuF8BgDilFejE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp5Q-1oLAZM2Nwa-00Y6bm; Wed, 25
 May 2022 11:35:41 +0200
Message-ID: <b8cbcac2-7e8b-e0fd-67a9-8a782e0afe23@gmx.com>
Date:   Wed, 25 May 2022 17:35:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
 <20220524170234.GW18596@twin.jikos.cz> <Yo3wRJO/h+Cx47bw@infradead.org>
 <bd6ac4d4-41bf-f662-e7c0-7841895554a6@gmx.com>
 <Yo32VXWO81PlccWH@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Yo32VXWO81PlccWH@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:itbYJoTOgEdtDyaX2rIOMEWkBlUWwtbk9vtbwAaSHUrLRCADyyR
 uDrvz+cOxZsdkr4d+S/Tk6FX5KPLuclVePQ6hz2rztDSuX2/yhHk/9oOIcSbMZGXe6EwlP2
 xJJJ9n7ZaZ8Ao8wBzoXMDc9NAF07v+7HsslE5tVY7fX9jkZdGTOfA14PJPI2dR6LAUY2hbs
 3EWldgFG5HU6Z8gKNWvRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PEToeHNbP3k=:oSZrGgZHijtK2MjhUwfTyY
 XedgxN6HUmQkdROS3qgs0lPSRT3IahyMw/aOwmJY5qNfpKP645PudauNDZC3El738O/Chm/f3
 iWOnFZwJKNS+S/PA5YttipZfGys/3SDtQqmvIZvwC6OguzMIfAzwkNiFzf6M195h9njQA94sy
 nHnVrpnr0fzEvJYX9G8fMSVFLY8+FWkcGgXMlA2UBaqPG2nErZMOW/yflGC92YjNHNpkn5e0v
 ClksDPVrPiuS8crDLsX/AP1ciS0xcxqeg+eHNJQhUGCp2C2UR7nsC2vhRujgEyRxP6OYijbaS
 RAZydggpckPZBQQXH/+ObBUfZ+tvXYbyhcAEIzz7/5nueBW/N2eQ3J2sX+fmG8bphqwl2dkTT
 uOPkOBHJL9AgELsm37HaVGqzS+IzDOLDxMmtBkwh/o4Ndw59kxGomHV1DzhTdwLnSnO5pt2ip
 nwuJHZNqC0U1nSoiG1gblR8Qu7xAdao6NO8LZcsitgCl7VgLDSlhtzFVBuAigXJT4NyEgkeeZ
 PWA4Nd4+BMkGf1NrkdM2Zo4nrvjfwUlbZzEs4CYmKrQnp+lrs4SRjNgwhsVCIYygOOZdgp7W0
 Yvpt1PdUIJevt9VYADPL/Cx/ElfJ7WPyxaw8kWd/KhrhZb441nFE3xt+ig6vWHn1Exkr7Gzl5
 7vNClUM6ItTCFKDmoPyv84TFhp53JXpHdsopmPg0LhdWBPZSTDDnI3+FSc8Jmp68SZR1Lz1/A
 AHn/7w3jp/D+NtpLJvTN9UmAJSMTjPvaNDmg/RskQAvfB0KrhJDQoDxv42N95n4uhfbaIRbUt
 y+OWygmbx6aqAcp7YFx4stcUdgzY7Yjyk6Dzsc8ZnHlW4Aj+9y4d6bDP2DVFbAykmdoWQEj0/
 842ckeNIBgjoYdbPRrD/tR4F/3rD8Ax632WILH+VdIS5nein1HrnbmwmL0Zu9YPFzE19cmK29
 fZ/uIhQzl1Av1V2em9GgZ3cl+3BGZ2BrZ8rPuqsPzcu0jeO5iwikS6dG0v1fEGvmYDdEkU4n8
 1Jz/ERruPrpJZc1IZpp5ycmIqjt6W7Hq9f4AAfClkxUu46j6T2A+X3zIkuARX9RsbqyQEXVr/
 t7ly/QOAAGR3Uco3RQY2JEoogzZ9zzJAW4DvwwlBCGfF/xpAe0+LaYw0w==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/25 17:26, Christoph Hellwig wrote:
> On Wed, May 25, 2022 at 05:13:11PM +0800, Qu Wenruo wrote:
>> The problem is, we can have partial write for RAID56, no matter if we
>> use NODATACOW or not.
>>
>> For example, we have a very typical 3 disks RAID5:
>>
>> 	0	32K	64K
>> Disk 1  |DDDDDDD|       |
>> Disk 2  |ddddddd|ddddddd|
>> Disk 3  |PPPPPPP|PPPPPPP|
>>
>>
>> D =3D old data, it's there for a while.
>> d =3D new data, we want to write.
>
> Oh.  I keep forgetting that the striping is entirely on the phys=D1=96ca=
l
> block basis and not logic block basis.  Which makes the whole idea
> of btrfs integrated raid5/6 not all that useful compared to just using
> mdraid :(

Yep, that's why I have to go the old journal way.

But you may want to explore the super awesome idea of raid stripe tree
from Johannes.

The idea is we introduce a new layer of logical addr -> internal mapping
-> physical addr.
By that, we get rid of the strict physical address requirement.

And when we update the new stripe, we just insert two new mapping for
(dddd), and two new mapping for the new (PPPPP).

If power loss happen, we still see the old internal mapping, and can get
the correct recovery.

But it still seems to have a lot of things to resolve for now.

Thanks,
Qu
