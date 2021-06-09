Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A7F3A20D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 01:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhFIXfo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 19:35:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:51129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhFIXfn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Jun 2021 19:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623281623;
        bh=DXbGtHScqn1n0hju0EeMxxv1mTI7QhPktzanKzphuKo=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Xj2oxA0Fc52aRSPPJhEUIJY+8aa6Nquy9ABDD9NE6kzW6AppArbpQ8OvyMPaS0vGo
         AxDgTroBV6RoMKi9bYs4eCCNQc2mPS28wc9osFS+vdLRa44qQFubpNYmSGbOGiQTOF
         PeUsDsMl+LbZQJYVzj0jDMGvrp5usJ6gHF1ls4so=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MC34X-1m2y553eZh-00CS6U; Thu, 10
 Jun 2021 01:33:43 +0200
Subject: Re: [PATCH v3 00/10] btrfs: defrag: rework to support sector perfect
 defrag
To:     dsterba@suse.cz, Neal Gompa <ngompa13@gmail.com>,
        Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210608025927.119169-1-wqu@suse.com>
 <20210609152650.GC27283@twin.jikos.cz>
 <CAEg-Je_8sDQNWM9tdka_Zd=v5pQzf0AsnJJAVAeKy7nMO5CE8Q@mail.gmail.com>
 <20210609230216.GF27283@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <6a6dcf9d-96ce-65cf-5615-4ffd05d2e1cc@gmx.com>
Date:   Thu, 10 Jun 2021 07:33:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609230216.GF27283@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PmL+0R7cpB2tPtqy1ceJcaCQp1Vs72Ehb/SeD+7Yrer7WoisHwl
 0RIMki65kjCos7C05Pb5P74MxRWBkCO/aYRaxs5hDk58Ozesm8Sj9Vi7cbhxxJuPr5cF6CN
 6h7C3KpFng7p02ciHP/Dw9SK854s/q7JyoiW89ijBy6CF+1JExbv2nHP95rz9RoxT7kbwI2
 B/+PR36A8ODZa4DIFiHNA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MSfXE4iBfjk=:srirCO48NQnVY46sxq7MAf
 dSYC0CZO9DW8Ut32DYnL0+C5ntNbIPt1/jvZ4qia1KeIpRDpinRGdCR836OGTjIUMUHIPBfwy
 pogLtnNr+RWGut7nHmK7jr5m8pjg+BsGKbbuPhqr5zlk7KsBDA8HOAx6QmrHSl7gjCXxB/U86
 YS5r8pnp1dMvuHs/PBfNOo9F4YrRqno5/zeR1HoBxcVMFek11K/ymrGDBEqVZbwyW8/gtDJJL
 6vaznIJNng2w97m/SIOv6DHw5OxQ+C8FQrdvaprY8zCa8CyI44x/v5sUtEeo3H8fBwe/25cTh
 RX3yfPyCOntViyyot54zHpDnx6lmDoGtMGbMPFeZ4MCeVARapYJzM3wyCbOwccNWpUdvDn/iR
 fL3s7znIyEjTM2TO0nt5BwxXnbJaxZ5xVedRnm2j50RouQFaNPUf5F8uErGYjqxq4lqk1gOPs
 tV761Dmo0qIvzjinqCbLp20wUQOKuV3wpkPhOOznwF1Pas+5dJEr+1snBgFofsJSNFBYjk4eZ
 rmaZAkIycF5ZUMXnSMsAsa4yMX/WtV9t6qls/tcbraV9eZwfGsUxMsWYepqJcX5YL75k+aos+
 iAOQhOH8GN+i9B5nYCdx5sF7mpOBC50giVmG63txkGntYSrBXHdRbuV9EY2GAZpNUwatkmv7U
 Ise1b34CxSVkxIVfOdvF1MUSJtRjubIZz2Uplxa+HR/9kqJWRfsm5Xz79hLoo6O5YoKLdJxlp
 pLmn8q/5l0VMlgGTVAN+KCzcdwXoSrRU4KwZqo4JMix81GtAZhIStA9qk443VEt4VIAQ+wKym
 NpQBSFmI+ePpvbWyhJpAznK90TFemYAerwKxftfBc1253xs3+QevaP67OMKxlV4UyntUn5yKs
 Ars4gKgrPgfAbRDLnWUp6V4AoewHl3u2c98mR93mfzNwoJEK8gqv3fh1XnNvl24uG8A+XDitr
 9StJWmr5xEYApelxUJkK7kMrAGaKZxagnL9Atsj8SWGyRTcFNeAh3cksLk2ukddZdmnd9fy29
 JkX0Thb9R15WXO+rt/jT2QALWClesAinF0nVeRH+qV0RvAv2+r8QVasYXNGq+vTxC2q7od6Mb
 IPszZfOIm3moHhZZ/FTo6Z+xIJudX4m0pnL4n/fq+yc2Om+ZLdUF97YNA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/10 =E4=B8=8A=E5=8D=887:02, David Sterba wrote:
> On Wed, Jun 09, 2021 at 06:48:31PM -0400, Neal Gompa wrote:
>> On Wed, Jun 9, 2021 at 12:23 PM David Sterba <dsterba@suse.cz> wrote:
>>> On Tue, Jun 08, 2021 at 10:59:17AM +0800, Qu Wenruo wrote:
>>>> [BEHAVIOR CHANGE]
>>>> In the refactor, there is one behavior change:
>>>>
>>>> - Defraged sector counter is based on the initial target list
>>>>    This is mostly to avoid the paremters to be passed too deep into
>>>>    defrag_one_locked_target().
>>>>    Considering the accounting is not that important, we can afford so=
me
>>>>    difference.
>>>
>>> As you're going to resend, please fix all occurences of 'defraged' to
>>> 'defragged'.
>>>
>>> I'll give the patchset some testing bug am not sure if it isn't too
>>> risky to put it to the 5.14 queue as it's about time to do only safe
>>> changes.
>>
>> This patch set makes it possible to do compression and balance in
>> subpage cases, right? At least, that's what I understood of it (defrag
>> code is used for balance and compression...).
>
> No it's just to do defragmentation in subpage case. Defrag and balance
> code are indpendent, and only defrag can do compression, balance just
> moves chunks of data but does not do changes to the data itself (it
> could write them in a different way eg. the stripes or copies).
>
Furthermore, defrag code doesn't do compression by itself.

The compression is done during writeback, defrag just tells writeback
code to do compression.

But for subpage enablement right now, compression is disabled
completely, thus no matter what setting you use, compression will not be
enabled.

Thanks,
Qu
