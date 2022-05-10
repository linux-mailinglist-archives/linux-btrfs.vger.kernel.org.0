Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E9F5214DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 14:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbiEJMOc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 08:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiEJMO1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 08:14:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4413229955D
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 05:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652184625;
        bh=PegR2HEILPoVagxdRs87HPhHjGoyvIk2mK6NvPBSFOw=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=iTi0iqgmVJMBf5x8wOknm5wJjAlxvyy7nC3kQgJ6RXDus9WpkXUvS492ToaiY+Cgy
         /Zwto86F3xliguZbxYCMX9R/OZFh1MHsuWR2/NesUhOTCjiP6N/sCBo+NRuMMyCVS3
         tC4qflUueNmWuLfsUk67Sby57+da83Dz5p8Dibv4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N3bSj-1nx1Zy00SR-010YiH; Tue, 10
 May 2022 14:10:25 +0200
Message-ID: <b3bd300f-7b1c-6bef-5377-b437e947f1c1@gmx.com>
Date:   Tue, 10 May 2022 20:10:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs-progs: print-tree: print the checksum of header
 without tailing zeros
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <38bf1bf79e8443d570e982edb8a6b71f27cf1ab5.1652162441.git.wqu@suse.com>
 <20220510114858.GL18596@twin.jikos.cz>
 <87f809c9-3b85-4eb0-8919-a80fc68740c1@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <87f809c9-3b85-4eb0-8919-a80fc68740c1@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EgD5spiMbKcW7BkrWBrW8+cX/mI6UFQPM+tfi64V+DtOFI09iej
 IF636Cs+nrn/nsjKkqrRsgyIVyCe0Q9AAPjE52fNL3KVX5Jc/eVX/vMcw1xFbGZU/xux+yV
 1jc3dXRLzcZCs0DAJ3H8XxpfNdm7zZqpcoKOcePWlNCfK1hvMITLV9eqjBMGkRxV4Ptpq8x
 RIdnldw3mQtLs/aKyqrZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XMk9I6D1b24=:yzbVZaxoh/RCSwcsvU6nf2
 1YiEGRSd2BnsBqWYqWDxsC63y0xRmVzv1T3aGm6yFbujxWcJk5WuLwy/61sUl0FZBOb5qgb9m
 0ZYlwRl9SjIP8Bu/8EC1IGuhD65La1zvYb3+JAzQiY/+m01RxE9Vl/1T3h4SOY72hypwegiwd
 VLmhzXdAvlmg6sSmuaCzXtFfM+REdEp/0ENfb9BC30+dJheKX0M3a94kn/OurhLaMEicwxws5
 nPaejT/cdwnEIzVjO34k6ccqrmv+XfuBSyrVcPxPY02CB5WeDZflTQ+vWzXjIjKPv1cBghIEU
 sYAfzm8QFA7j3pqPTJOIL79gddOt6efNTN9OhG4utEU7PYeXEKky8XvDrRuqjIE7iIB19iRKZ
 NtBbc0bFrLhssMOrqj00ke/rVGm5hj0/7gcRMQcZtcGr0LtP9W2lUIWKWseXmaX9F4hasnsu+
 LdhjyquTne6FexFNWxxymFi8lm/KWJg4Sqh9J66vNBS/WOVqOWClbjGPWzkzgrwkJu/7GS1t8
 TqWQzWrdl7dzTUjEZHbtCu6mQTcUnHWadkYfx8Es+X4BccV//jDoS3QlZ7vMIt+pn7Nr+dFTq
 ZAhKvOZ4LZqZOJJP3TlFzQh/HmRH3mYr/ndTq5ZPnoWk4vrHEf8roPd3ObcTD7YbxqAXH9sWk
 K8xxbiVJvYhCKZfi5QMNzoSAWKPlFI0y36wZwgkz6wOMCIfxWeTatek0OvPY122R18ah4jlJr
 VffdS5WiYezLENPHYNpN9d29aE45cm7GDetUOfzXEqMHd3+IVNYjZpXWkchCXibpmjaOHkXkJ
 Fd9d8gqf9lQS91Y+tZX92t0Km7aD7rPvAmNJa/18I4CYjVQgHlOR+jqS7PpPfcqj082k3gBaT
 1czn0TAuafVUGufxVCxPC2PjaIs6gI1Fi4pEtoF9sD9XwTJdFUJoWYHIxLGjaLfgD2bdIwK5M
 u2SlIVJ1yk2NrOF8rKKM8bBl0s9RhQV9lDiz/+MjGAwvpBLMiOZGi2CP68gu3LfxowQXk3Ry9
 b4A9d1mZUfzgBz7wkV566QOl8dzCgySlsnN3EoFQYA2NX9VGSov2aPrjJHJU4OZgTtyiqqyv4
 dDxoXGh7w6Ngjg=
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/10 20:02, Qu Wenruo wrote:
>
>
> On 2022/5/10 19:48, David Sterba wrote:
>> On Tue, May 10, 2022 at 02:03:18PM +0800, Qu Wenruo wrote:
>>> For the default CRC32 checksum, print-tree now prints tons of
>>> unnecessary padding zeros:
>>>
>>> =C2=A0=C2=A0 btrfs-progs v5.17
>>> =C2=A0=C2=A0 chunk tree
>>> =C2=A0=C2=A0 leaf 22036480 items 7 free space 15430 generation 6 owner=
 CHUNK_TREE
>>> =C2=A0=C2=A0 leaf 22036480 flags 0x1(WRITTEN) backref revision 1
>>> =C2=A0=C2=A0 checksum stored
>>> 0ac1b9fa00000000000000000000000000000000000000000000000000000000
>>> =C2=A0=C2=A0 checksum calced
>>> 0ac1b9fa00000000000000000000000000000000000000000000000000000000
>>> =C2=A0=C2=A0 fs uuid 3d95b7e3-3ab6-4927-af56-c58aa634342e
>>>
>>> This is caused by commit 1bb6fb896dfc ("btrfs-progs: btrfstune:
>>> experimental, new option to switch csums"), and it looks like most
>>> distros just enable EXPERIMENTAL features by default.
>>
>> Which distros?
>
> Archlinux.
>
> Their PKGBUILD can be found here:
> https://github.com/archlinux/svntogit-packages/blob/packages/btrfs-progs=
/trunk/PKGBUILD
>
>
> Which doesn't enable experimental explicitly, but still got the full
> csum output.

OK, got the reason why the EXPERIMENTAL thing doesn't work as expected.

In configure, we set $EXPERIMENTAL=3D0 by default, then
add the line into confdefs.h:

#define EXPERIMENTAL 0

However in print-tree.c, we use

#ifdef EXPERIMENTAL

Then it always get enabled, no matter if it's 0 or 1.

We should either don't define it at all, and use the "#ifdef" way, or we
should go "#if EXPERIMENTAL" instead.

Thanks,
Qu
>
> Thanks,
> Qu
>>
>>> (Which is a good thing to provide much better coverage).
>>
>> Well, this depends if the experimental features are used as such. I'll
>> add a warning in case they get actually used.
>>
>>> So here we just limit the csum print to the utilized csum size.
>>>
>>> Now the output looks like:
>>>
>>> =C2=A0=C2=A0 btrfs-progs v5.17
>>> =C2=A0=C2=A0 chunk tree
>>> =C2=A0=C2=A0 leaf 22036480 items 4 free space 15781 generation 6 owner=
 CHUNK_TREE
>>> =C2=A0=C2=A0 leaf 22036480 flags 0x1(WRITTEN) backref revision 1
>>> =C2=A0=C2=A0 checksum stored 676b812f
>>> =C2=A0=C2=A0 checksum calced 676b812f
>>> =C2=A0=C2=A0 fs uuid d11f8799-b6dc-415d-b1ed-cebe6da5f0b7
>>>
>>> Fixes: 1bb6fb896dfc ("btrfs-progs: btrfstune: experimental, new
>>> option to switch csums")
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> Added to devel, thanks.
