Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C340A58A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 06:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbhINEqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 00:46:44 -0400
Received: from mout.gmx.net ([212.227.15.15]:46693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232829AbhINEqn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 00:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631594719;
        bh=6VXQSgwsXSdmo/m+d795endairul62ZGVBHgG0rMVO4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=PXAHK6UQq4xbFDsF8HUJTdFKVIiZPts7ODOsNDQ6HPGFtMMVr4IFjg/yJWh6IhwO1
         qP03R8699/Ppz+cq9HG69YR1TogQXNw6m3FaEYEXW2FtY4ExEAZeDzGAR/ovP57ZGK
         Tfq68O1dA+YycfPKijvvhVap4JiS3tIh6JLRZJkI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MrhUE-1nDcol0hbI-00niys; Tue, 14
 Sep 2021 06:45:19 +0200
Subject: Re: INFO: task hung in btrfs_alloc_tree_block
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CACkBjsZuFQykH=vQmy0n_mE1ACpiy1t48dvbUT0wtfBuHC4RFw@mail.gmail.com>
 <1ffc5484-b68e-22db-349c-d1e0c31f9562@gmx.com>
 <CACkBjsbUnPQ1J5HpXW-be2jb_h2k8d4b2p-epp5pUek_Rf0reQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <52b5e79f-6b56-2d90-6927-86b2faa295b9@gmx.com>
Date:   Tue, 14 Sep 2021 12:45:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACkBjsbUnPQ1J5HpXW-be2jb_h2k8d4b2p-epp5pUek_Rf0reQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tULegFjIvGnbxA/NfaYS99DxwIcCjszgLTd2YibruRy57x7WKAE
 cbgL7cnKqI/dnF0QhsICC5m/6/9oQkaX2AjyJvfuq/TK6GjlXcXs/rba+OtmK9HqCerOXqw
 631w4Ur/vqgc2PnR99IXSrRC6E4HCCb4/xo55b6umObulzerXkK/Kfy62+Jt+4o3GM5rGNy
 IyDz04OCBrv2v1YIOBIOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FUHTIJppHZw=:jtuonRwitxbBSl9snPw0IF
 rhHQB8puxH5xYDNsrUhGOdSyqvvXKE5pCxM9DFCtU1pln9uSyorrPbtNoyazloK+3wo5IgW4B
 KCjkOENm+xvuxoaafyP1UW18MFxcgDk2qyFoZAE0keiAQK1QB4UwOpQ0SSUrgszVJ/z6v1tBE
 1rMe5fmWEfL1b7AwttHKH1Ys7oR9oXBqbf0BEHn0IiW+FifUfXxOkDdHEDDMgK9pX56GajR07
 soa2nUr6SAVOY98f3B7zqpdkmAmegMWx1vSN1/cVx88WU3JaQr49eNUcEFjaXCtzd3+zNMzOF
 a6WbtW50IHk2JfBztEJlgfjlldzmE1gPeED1xZDWjBiuaZdPmOUJkPq5n3JxJEIlLJnCd46Lt
 cENaDYTQcAVYO/YrgMubLAiAqarHGaKNvKW7wBy5n5OGfPYEu6v1FJlpRz4l2gOBj2wJIl6BQ
 lc2FwHVGw52NXshvMhIapWsFSrykgmRMYDgPFm4SV3B33y5LdwBabbYtxzRNdPVC0Ke5qLlNX
 qxHac2uJKFmvsZ3a5DOlh29+uKdMvh6nJnary3P9fYBsda9xj179TKbfxCAjG9a90b/ze9tqs
 ns3Z2Nz3NaEl4ku9tRjBuPlMpWOYaSecBoMvi2yGD6XVEpIj5c63WYBRTa4lnO+S9VmT4G30y
 vFi0Wvq+RnC7GjAEk2SSHdJ1Eg/yPQRaynqSRZ+YBYbPNGR2CI/wRnR0ktAdfJxsHOKUeiRIu
 41pwXHO6qpAB4AsDq0iNLWrOIQ9WlEI+R2gVLbv4ocpnobSV+ad7ijftZHytozPaY3kVLfrGd
 YDzVti4h3O9kVoRyG59BrLreBHP6Xa1WVoShRniZWkjAZ/IhLpco5gfKN7Wt2RBQd3De6Jxv4
 DIzW5dvNYedsvmXF/mTAUWu6cyC08PuWtTAjuVzGx8+fZeaOg5EewWMemwqu3XxeQ0fnHoAlv
 zyxgy+3qNDGVU8WzDm4Qw/LiSaSsUDmOQzOr98XdgfmfI8NNPL8YbLtQQJrrbD4CgTegO4sih
 frZAFChnHE6LWsOCiOQU4ROECtOIQtIawlscks1FVw9YTyKWzGgZJMIkuYIV7RifKkz992mHU
 K8WFL9wx+or3zn67L8m2DRQ/yfp+TsScymrm1xvybuWeDCwkmRmcVwW1qxzf4aven4AhgfeEn
 Y2Wr8aJY/xre4nP4bHOoL2RFg2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/14 =E4=B8=8A=E5=8D=8811:22, Hao Sun wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8811:13=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>>
>>
>> On 2021/9/14 =E4=B8=8A=E5=8D=8810:44, Hao Sun wrote:
>>> Hello,
>>>
>>> When using Healer to fuzz the latest Linux kernel, the following crash
>>> was triggered.
>>>
>>> HEAD commit: 6880fa6c5660 Linux 5.15-rc1
>>> git tree: upstream
>>> console output:
>>> https://drive.google.com/file/d/1U3ei_jCODG9N5UHOspSRmykrEDSey3Qn/view=
?usp=3Dsharing
>>> kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHT=
LJvsUdWcgB/view?usp=3Dsharing
>>
>> Any recorded info for the injected errors during the test?
>>
>> It's hanging on a tree lock, without knowing the error injected, it's
>> really hard to find out what's the cause.
>>
>
> The `task hang` happened without any fault injection.
> Based on the recorded logs
> (https://drive.google.com/file/d/1x7u4JfyeL8WhetacBsPDVXm48SvVJUo7/view?=
usp=3Dsharing
> and https://drive.google.com/file/d/1U3ei_jCODG9N5UHOspSRmykrEDSey3Qn/vi=
ew?usp=3Dsharing),
> no fault-injection log was printed before the task hang.

OK, then it seems like a big problem.

Any workload log from the fuzzer so we can try to reproduce?

Or just using the tool?

Thanks,
Qu
>
> Regards
> Hao
>
