Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C140242364
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 02:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHLA33 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 20:29:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:47761 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgHLA33 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 20:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597192164;
        bh=oLS/QegZwUQ4oEJg5jfVm/qSDXpRpu0Ooev46+vt13o=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=T+9XrQ+sOqRT2UX+7LiqEM1NEwKCBzi0P4f4mn7ggsSgr+XeRE71/FG7LkBhe8A9Y
         xeEVURr9s0lgyuQqXMEf3xnlBcyfchHYc7of2ElMzPuc4/15k2ePiAYBXh6UBpmKFV
         rppT4PSrOEprclaeXElH+vi3aftWhYdQ/ijjK6Fk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMGRK-1kNriX1rd8-00JHQM; Wed, 12
 Aug 2020 02:29:24 +0200
Subject: Re: [PATCH v3 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200809120919.85271-1-wqu@suse.com>
 <20200809120919.85271-4-wqu@suse.com>
 <8d21ba85-52a5-5419-dc16-ceece8b0c3a8@toxicpanda.com>
 <dbe1176e-db46-7ff7-1231-ee69d7c3c5d1@gmx.com>
 <ee1203ab-444d-cc9d-0e00-2102bd02ecd2@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <fb4aea50-0e81-6444-ae9f-3e6c2df88c67@gmx.com>
Date:   Wed, 12 Aug 2020 08:29:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <ee1203ab-444d-cc9d-0e00-2102bd02ecd2@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iQbqi3hHaSPUsr7ektEmsdPZ9cdz6WhRpUYQJ48IPaVWlP9+W+9
 W84tie+U3r5bK+A/dtj4dnHEf4euaDwxn8EAXlnOShQ8xNlHYmmXIe+7/236jxzwb4qa71A
 coq024R1jOYXE/yXtunyNMO57f5/rNkKoX6icKRIZ7tTcUDjGnuou0WKz9Hn948KD0MTw1Z
 niwx9lu3NoB7Lx7Cd6/bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:viLeO/rbc3s=:yoewnjD+Y6CQi43ddrdV8H
 8ET6bMaBuD87uoZ+7ZMJQIiJhIJlGSjUqFn3DavxrBwh4j95xtsqAejQS6HpoDHFQi5arjOVN
 8dBvHtXV3+Rf/0uN/DBEw5Juseqxob4R/EiwY6klIDstq4D0n/CSDJ6N9Nul0TxA9tG1m53zB
 LuM+ggdUFU2lMiRGlr3cg94n2Jrny9PXCc5zIuc0HeI/QKZvo3o+RePwbO3lTtCaC8MR7LtR4
 T1CdpKW5wSy2dhj+3uuDIQ2MGYBUmtDlhvfgqZNvMRzDKBMu1AGiL93ad4KUSDF96wnq5JGOt
 frWwkX7sTOBQeH6zmRybNeeGyA00JZaJHlY36fTBQiiyZYonhp/VHUgZNOh0sPoDI86Z2ly0g
 p4uwfgNtxdRtXGgKJoUb2LqbDgQVHSQyT5vjTJwT6c1PuLlUhsn0DZK3wohgqecBoZ62TxgBR
 bwbhRWFqgBtJr7pgazu3MNAPoLjLhWUlPPaO2Kh+WHDiRwa3W6cRc+QzmcbYwp1F10lmejA1L
 LYS4np+1cU7sSdsihmsHNW5cEgcI1+ops0NqkJnV2EikX0/dIkye/92dj3XkFaZEw5YqmznOa
 b4JxWv70y/xygv1WWJSaVhAkyKyXuTjZ9IKl7fQKHGcDQHwyydsc/W8L8eMnCugw77oxYCkGP
 5wyGaunrRAGRMIwKsoyOL2cAtGWGFW+SeuzYNPJKFuQnUUFSYnygAfQwHTQk0JvoCeIHmhtMI
 df5iWQHdx5glvXBwPOCchny1txiTgwZFq1gbny/pw1a3C5YAJ6wAgKtog1VkXP/Kw+x48l6u8
 oxc5NhQCQt8JOi5hEd5W2aY3DlHXA1S22xFm8l6rw+Q6734uoE+tqFq7k9YGeTgf6wYK2PsqE
 EK4ahAzYTY+VwkWeyzoh+kmJqse+hJRyhRPx5tAHsEc51+tTKuNQfsI/HGKFv6ORFcxd7kRLn
 3UayWWDiYGd7MTJtTc6ZO2Ou+J+PduviVT8UoW8FOZYgoaAF2aXoWCid7nvv44jYdC/TPyZGA
 7KSgiNRRGu+Pj0x+PI03mwlThfPSQPhjjcJUL0xwlPq911swuaDjcNuQZTM8hHXaJbGQ3Anh7
 AaJINviVmS/iU+ImJ07q4r+zout2TzqOko2ao7nrES30WsPaA81mNKCudnc5vqp9FMm8RBULj
 KhoHCnuoIIGo4GKL9mKUoZNAZfTv8iGZ8KKo3BHF5CH8B214JjFv74uYFM8T4LZRCPlwagyqe
 pS+OjArPN8n3skppEcnd0W6s75PhaTgC+g2k2hA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/12 =E4=B8=8A=E5=8D=888:23, Josef Bacik wrote:
> On 8/11/20 7:04 PM, Qu Wenruo wrote:
>>
>>
[...]
>>> Which I assume is the problem?=C2=A0 The generation is 19, is that >
>>> last_trans_committed?=C2=A0 Seems like this check just needs to be mov=
ed
>>> lower, right?=C2=A0 Thanks,
>>
>> Nope, that generation 19 is valid. That fs has a higher generation, so
>> that's completely valid.
>>
>> The generation 19 is there because there is another csum leaf whose
>> generation is 19.
>>
>
> Then this patch does nothing, because we already have this check lower,
> so how exactly did it make the panic go away?=C2=A0 Thanks,
>
> Josef

Sorry, I don't get your point.

The generation 19 isn't larger than last_trans_committed, so that check
has nothing to do with this case.

And then it goes to the header_nritems() check, which is 0, and with
first_key present, which is invalid and we error out, rejecting the
corrupted leaf.

What's the problem then?

Thanks,
Qu
