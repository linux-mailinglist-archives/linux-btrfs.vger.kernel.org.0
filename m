Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972403CF627
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 10:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhGTHts (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 03:49:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:59677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234445AbhGTHtJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 03:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626769779;
        bh=gvwFQB/bViVSIXY1aWpjZ4Ga6onJRorvQQ6t+EGarZU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IYgo2Wb7pMoDoF6Wfe2gqudQAce5JnUQrtRwkd5K9VWdCRfw9KiSFJQrNF1eyAtrf
         L2A/0kV0lD54HG6w/AXuskGdqzrihyc2IeX2oUY3bMEN5Uxv0lzDzt9Pw3kaQvsB27
         aKc1W1gmjYPPYX9dFX+9u4YLo/cXySKCkAEuKsH8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MybKf-1lBsgp3MEv-00yusN; Tue, 20
 Jul 2021 10:29:39 +0200
Subject: Re: [PATCH RFC] fstests: allow running custom hooks
To:     Eryu Guan <eguan@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20210719071337.217501-1-wqu@suse.com>
 <20210720002536.GA2031856@dread.disaster.area>
 <3f2d4ebd-bf75-b283-45be-3fa81e65d5bf@gmx.com>
 <20210720021437.GB2031856@dread.disaster.area>
 <cb2bf09e-91fd-2976-4366-4daf29664890@gmx.com>
 <20210720064317.GC2031856@dread.disaster.area>
 <20210720075748.GJ60846@e18g06458.et15sqa>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <3fd6494b-8f03-4d97-9d00-21343e0e8152@gmx.com>
Date:   Tue, 20 Jul 2021 16:29:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720075748.GJ60846@e18g06458.et15sqa>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X4gP8smjobPTOPL8YVN3RsyTxjkxsuTRhDjq7Pj1gC4M/hzWk0h
 PIqMH19G1rao7Km15y10yceHO49268RgKOyOQTu8vUoSDwRrRxzixXn+sPBHshQ2hf9BWgK
 tBvDxkebLzYRKUFCOzbYWXc8T5NTRVh2nBpw4xEC8PZWMgc/yVh/8cmS6yHvB82VMbj4Y3/
 Bs8K5N9Qv1l/Vy5/dAs0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KiGWQAJjsmc=:6TZ/4D/mY50AsHIFY3woik
 1B4Ql+YLX+/fnz/s9BaJmunxcNU5BfsRWSrSQvz2dBUJnH3Zc1b0bKxhwACSN2GccujJEduab
 PVsNHKEQpUpGAasUTMVYBXXabzTq6d7mUyG8kOifS0jomWLoTEEKrR/AKEJwwSxOpRDsybARi
 NWFbxcPrkoyaQYZzHr67MhLA7x5/byJSU+kHWyrOw+B4jHfDEh8yB9plKy/qtj1MLB5iah+qF
 50EyvnLwtI0yx9DdLAiLWRDJhkUrCq7aSwEWGEPb25P5xcwIgJs4oBixYxkDg/M3bHln7j9s9
 sNl5MBcFeM46f50Q18Aywpr5x4RwEqznFJL5A+bbBOy08npOop8HW925f+vgpk2zzj5l3ni2G
 E72DMHUsmIAAABOfId2cKzLCGUyOjKI5DR3GkXVTtcOtMTLG8C+PhV06qRA43fo3PXemhi6R6
 kC1yG5wrImkWGurCglL0FU51eU+A5k6z2BmwcJstqCq80H9bIK+QYiJAsMazGDCgtv5p448Tn
 sG6la2BFAaPZHyadgbcaMTRoKifL9chEKUM3+V8i+bzQNNm2CroWy4rdl1N/qRV8bGoK1nMbh
 SHpW5t9AGJ19r92O7TnCJtOU7DaptWvtzmXvzwMuU2yDaZs0PzE1I7WbHR36Q6dAgaq1S1Bc6
 0lselWu9EVXsexWwA+S5UG2S06lFegpSq1eRzPEuS7xUFKw4n7GrUfP5pdiKerYQV6t1lMcz1
 1SBeCxG4LwShf9yYstwtldgfckuGqOekks1i4mc2WG1lJpI/S+iKXm5sorgxOU8O6KNopIccF
 uW8KRlKSQAS0o7BpghTWjKbluchj8mloXjTLxNo6yLckYws8CqxNwlMp7V5bSYr2QZ+Z4LMSD
 qYk4M7Z5fl+R/4tK1ByqECJUxEQrH4u3o3k7B/yARXDlZEZf5XYUUWWLH3RGkThFtQc/h7QVb
 uXrCZHv64U38MQyX1TNZrJg/E87KZBO8uomA16qtPSh48CtHzze9i7ofSeeK1jkXMW09bLwEm
 M6ES/jU6wLg+/D3sEHS9XNXqHrMZvECzZksAr7qkNfGRpXqb01/yzoibQlx8EarIPeBlj5qcE
 t9lpXZxMeQ43vnSIz1GDEjAoUtMs2mI26X2sO9QbqBf5mEMOnHjaxgYFw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/20 =E4=B8=8B=E5=8D=883:57, Eryu Guan wrote:
> On Tue, Jul 20, 2021 at 04:43:17PM +1000, Dave Chinner wrote:
> [snip]
>>
>> And given that it appears you haven't thought about maintaining a
>> local repository of hooks, I strongly doubt you've even consider the
>> impact of future changes to the hook API on existing hook scripts
>> that devs and test engineers have written over months and years
>> while debugging test failures.
>>
>> Darrick pointed out the difference between running in the check vs
>> test environment, which is something that is very much an API
>> consideration - we change the test environment arbitrarily and fix
>> all the tests that change affects at the same time. But if there are
>> private scripts that depend on the test environment and variables
>> being stable, then we can't do things like, say, rename the "seqres"
>> variable across all tests because that will break every custom hook
>> script out there that writes to $seqres.full...
>
> I was thinking about this as well, if such private hook scripts are
> useful to others as well, then I think maybe it's worth to maintain such
> scripts in fstests repo, and further changes to the hook API won't break
> the scripts

But those hook scripts are really craft by each developer, which can
have vastly different usage.

How could that be maintained inside fstests?

Thanks,
Qu
>
> Thanks,
> Eryu
>
