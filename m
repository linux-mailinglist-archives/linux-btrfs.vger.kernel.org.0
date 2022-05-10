Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43625214C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 May 2022 14:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbiEJMHG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 May 2022 08:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiEJMHF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 May 2022 08:07:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA13315E776
        for <linux-btrfs@vger.kernel.org>; Tue, 10 May 2022 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652184184;
        bh=YWbpkbziZ3bMpwyI8Jlpaxn01FQlvnsdXnB6oN/PLw0=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=HCBYwKfklcu91mjaQJ1nkFx1obZ0aZOoLq/gs9yFi0j1eWe/opLGgkJdUgWzk6qus
         u/XRVqEUCFLhSXPiyEMDome4PVDnv5PQ94pkhfenHm1NkHcoySB9bHMNGhmfT8vyMQ
         5HEU0eCQrLigUMYYZaQEym1ztaNkHYXd5lt02a7k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPXhA-1nRlLx1K0A-00MbER; Tue, 10
 May 2022 14:03:04 +0200
Message-ID: <87f809c9-3b85-4eb0-8919-a80fc68740c1@gmx.com>
Date:   Tue, 10 May 2022 20:02:54 +0800
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220510114858.GL18596@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VtPSiIpwDJnuJISOq0ANNmRWzDiIxc1B8lVWU2MoKBKIkQzzODi
 9RDzI0r5QQ3VuV6yYwUsJSnCdAgoAT3Oj5/2dwD7r3R4CfyeG+BOxPcpQYZygkUeyvO9E6e
 ATqkhJnyD8xCgKcBvDrTgIm7I+2VTH7RBN7uYcQu7XGr10rzL7iRJZuhbPk/Qx+zq4ZP2iy
 sR4LeDDYzAwGf/Pb8emjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uFuGeeARADw=:Cvvt6qgnyGit3+acn2NerJ
 dI4CjonSYZIgIadhUwSZshR+gawLpCjlObNcR26o1bxlCfYnJAzc9UjHZHxlThabqjtMiArg9
 +lUVNHKHRZq41PnqzIYlgr1qW9qvNFRif85zGKTrxBO/pcRjrq3gNDy2ZzdUTso8Mp8Abdwoo
 uY3Qj7EQrsXppOrkgR3wvknCD/gN8ugIYxB7Q4XnV3iaaLR18DvAqDpLOCJH9uBQXbI8SHrkj
 vhyhg7O7NAj6PFpODewxyqxeigHU6xFdQS2eXnFl1BDI8tAkrqnAlWNFn3eptSm/mUw1phbN9
 rUIEG6tTLAza/vxerDZcrxNDqi9t9+5P2jtZd2SDjUKHohK6ZDkvx9/wUdDh7L9RveXRZgOM1
 GeYtJOMXkgrvWt82LpQgR4AIua4XafbV99xE6PoxiEAhqxcsnsR+Cm2HdduDuERaZC2zAAbz5
 YbNJ816jzFOQ4XdctCn5qqhGxkG/9nAZMX8IO1r13u3HsC4WF0SP39lYoCJ6ipmexiNVxuO+F
 SUAdHTv5L1xvFkJephmPsj/rVb5cImsTTmlz+6Mn3YSftlQ2dpbWMKJ+ismn4fj5c7jL76zOt
 zFtvY6GpoXsHnX67InH2Ih0l4jLgUSW4ATolWJRiW7I+oAXlPEMa2aByNyxaK7EcsGwedWWp2
 TU+7tJ+fXZDHFa9egop1JShgAJFNmHMIkFoiUNUjZ6U3L7BmbpMVy14+3qDCec5oUP1Ek8d6g
 T2rj2uNCwRhEu7bISw/TxluvGyLGGyya3fGTTRMAJBf3ROVpdfTYOt9G9P7hGjxdHnZr4CObE
 w7WJhV9LYTO0PSNDdPU5BlyCMhXgSpFBFqEFXt7bcJY9mczBNPUvn18JeTWbNkbL+E6Lytz1j
 v8Z7598hiGLmFJhElsLPcFmzcu38Y7t1NdVU7gSXt92snUFnioP/TNCUVsY306G5Fu3RYhW1d
 8C/R9dAqMGaTWWiV0k71GrZgsPIooEYoLPqiCraOAhYjMbhDXflogiJ2KQg20QlPBRvtMRz4Q
 3tnNIW9xTTrw1QW9BlaJVjK40Jo1j1+hh6UHX8+w74SjNrh5RLXDw3DG06693Rq77UXLvRax6
 pFi+U1BmcsuHCQ=
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/10 19:48, David Sterba wrote:
> On Tue, May 10, 2022 at 02:03:18PM +0800, Qu Wenruo wrote:
>> For the default CRC32 checksum, print-tree now prints tons of
>> unnecessary padding zeros:
>>
>>    btrfs-progs v5.17
>>    chunk tree
>>    leaf 22036480 items 7 free space 15430 generation 6 owner CHUNK_TREE
>>    leaf 22036480 flags 0x1(WRITTEN) backref revision 1
>>    checksum stored 0ac1b9fa00000000000000000000000000000000000000000000=
000000000000
>>    checksum calced 0ac1b9fa00000000000000000000000000000000000000000000=
000000000000
>>    fs uuid 3d95b7e3-3ab6-4927-af56-c58aa634342e
>>
>> This is caused by commit 1bb6fb896dfc ("btrfs-progs: btrfstune:
>> experimental, new option to switch csums"), and it looks like most
>> distros just enable EXPERIMENTAL features by default.
>
> Which distros?

Archlinux.

Their PKGBUILD can be found here:
https://github.com/archlinux/svntogit-packages/blob/packages/btrfs-progs/t=
runk/PKGBUILD

Which doesn't enable experimental explicitly, but still got the full
csum output.

Thanks,
Qu
>
>> (Which is a good thing to provide much better coverage).
>
> Well, this depends if the experimental features are used as such. I'll
> add a warning in case they get actually used.
>
>> So here we just limit the csum print to the utilized csum size.
>>
>> Now the output looks like:
>>
>>    btrfs-progs v5.17
>>    chunk tree
>>    leaf 22036480 items 4 free space 15781 generation 6 owner CHUNK_TREE
>>    leaf 22036480 flags 0x1(WRITTEN) backref revision 1
>>    checksum stored 676b812f
>>    checksum calced 676b812f
>>    fs uuid d11f8799-b6dc-415d-b1ed-cebe6da5f0b7
>>
>> Fixes: 1bb6fb896dfc ("btrfs-progs: btrfstune: experimental, new option =
to switch csums")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> Added to devel, thanks.
