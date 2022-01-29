Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0344A2B04
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Jan 2022 02:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352054AbiA2BiC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 20:38:02 -0500
Received: from mout.gmx.net ([212.227.17.20]:43193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352031AbiA2BiB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 20:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643420279;
        bh=u/rqgeDEFx8uiXwQwydneZ5r77Wmdo+/UiufagVrinY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=VlEz9qQg/EvLhXUVcr5rXkPN+nwGYbQxwkpyW7qdgBOellmZj1x+LgfW+3YZEGThJ
         XG2pzSnR2BQRNT0sS2CG42aWJXlYqeD6MPCzdT0gzl0tM6CdwPhoyE4MZl9Y32LofQ
         nPtJ7Cidcv8yW3k43yFidy6QAGTQ2wLybPTFAMuo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.232] ([86.8.113.40]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZktj-1mideq2KoR-00Wqjf; Sat, 29
 Jan 2022 02:37:59 +0100
Message-ID: <14dc3da9-bd0b-48bf-ba1a-6aecd07dc76c@gmx.com>
Date:   Sat, 29 Jan 2022 01:37:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
Content-Language: en-GB
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Kai Krakow <hurikhan77+btrfs@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
 <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
 <cf0cd0df-7391-adf5-abbc-42dfd1f07129@gmx.com>
 <e2dee101-bcff-a269-e062-710438bded3d@gmx.com>
From:   piorunz <piorunz@gmx.com>
In-Reply-To: <e2dee101-bcff-a269-e062-710438bded3d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tq7z93sd9Zk8sqV37SSEWanzSJ/jxl3dgPvSzWRfh21NY9THSAa
 /iaDPhhC1He4N1/6L15etxXBBeCALqz8JD/B4QALObQUvX7cbLkxnkxGTO/UqkIIVp4UUSz
 WWAIPQ2k/SH1mee3TNLpu5ikzSD0YqhP7n8VkuHVjTmfCzJGtLtMXpnWE0wXVb/76MusXOM
 wqrQOVCbbOA0KolBFMFDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8OON4y4zxxQ=:NH45zgC8uiU0/QE24ajlny
 HhOcvvxeyewKFNds8bG76RynseMEPeFkQzQggbQn38cDtkxl1uRve1SD1VwFP6QM+BPkSBDe+
 2L3AdWgRWREjwMD184I1m3aHaArrkhJtxQXAnBTnuzYko1j629WbiEtAvWnQmYTASPSYuXF4d
 Rb9WoKRiWc+1e6IsEUyogK7Lbhf9GRB7JHVC1ddldfVzIVChjia/Jrn0i8Lf1RMnuG29QLqwX
 kwRi2LCVKdGdeXWZQifRUzsm97x8Nrd5+wX2t+8rzJ9jMmQBtOiyu17dII/x5ls+vBb6/U0fo
 nqpnMwFOZW8gs2WXFN+SM/t6mK7Ip75SoCIrgZeY0L0YtTg0ewqEm9E7/WSrvtSnByHAmrrUi
 7+DFh4w2hdHQA6vOxyQwdYU7zrgKD4tse52lj/xAR57jbpk1ZfEFnb56CbeV5V6vYLJsky6fs
 Q/oGD8QxICnW6n1/NL3GHs4fA3C51EwHIf9MYQGW+deIHm53RjU2PkvPlApGxxkUHaokhjCpd
 rZJiThYu+kxF9H77UvnRl1hKvRxeDyfwpU/YSaFq0/go23vbi8ViH+WsYp52yVyn67+i/DJEc
 DsgcbLzqZWrssGDSvQrsoqVcg093kCuNm1mVA/hk5wzUJHs/I2fFXRv8i1WPfIInlZZS87BJX
 OyvZ1W8U8gIp6SDtBtFrfwaTqWNke8fBEKyX04HPgIp3IUP4hEAm+vFGmW9gID9q0lszQeUJ2
 8t/V/KG1WUmuKYAvQDVPftdPsfDjt0Z6NGkr2ryzxTTHUiMfpcyvEn7E+7JGUwDy4oQGfnY1S
 u7cRwDrumH2RDy/ZNxT5ru3Jk605+WSglBC5VWN6G750kuvAqVk8bmxhGDDmi+u5lJJHpKgOx
 eByBhDVoK0skBHNTBDOijBpXznb2CJNKcGHi2h+DcoAAfqg4vSpN0Nqd4NPdqrqVnyXUvmdXo
 4sY8+qSEjR+2c8+rXCiZfHJ1x+1GHqMigqn3SEL3mL6NQWC5ZYQuNF5e99MqpvPK6mGoh+dQp
 emFpHOcfAIHC5DCkSwylz1g+K4bs0SpS+YBpn84U+9Cp59BsOq+fHwOvIP++ICcnMUCdAtLEQ
 GSerQ9y+Qqncto=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/01/2022 12:42, Qu Wenruo wrote:
>
> With -t 128k you may hit the 120s timeout problem less frequently.

Will do. Thank you.
>
> Although sometimes you may want to further reduce the value to something
> like 64K, to reduce the workload.
>
> I may craft a fix to add cond_resche() inside btrfs_defrag_file() so
> that can be backported to v5.15, to let the problem to be gone for good.

That would be awesome. Please do. Kernel 5.15 is LTS so many people will
stick with it for a long time to come.

=2D-
With kindest regards, Piotr.

=E2=A2=80=E2=A3=B4=E2=A0=BE=E2=A0=BB=E2=A2=B6=E2=A3=A6=E2=A0=80
=E2=A3=BE=E2=A0=81=E2=A2=A0=E2=A0=92=E2=A0=80=E2=A3=BF=E2=A1=81 Debian - T=
he universal operating system
=E2=A2=BF=E2=A1=84=E2=A0=98=E2=A0=B7=E2=A0=9A=E2=A0=8B=E2=A0=80 https://ww=
w.debian.org/
=E2=A0=88=E2=A0=B3=E2=A3=84=E2=A0=80=E2=A0=80=E2=A0=80=E2=A0=80
