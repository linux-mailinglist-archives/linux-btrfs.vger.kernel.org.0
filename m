Return-Path: <linux-btrfs+bounces-10509-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4B69F57F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 21:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FA387A5A53
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 20:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554A91F9AAD;
	Tue, 17 Dec 2024 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="eJSMiJ5C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255E34A23
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 20:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734468162; cv=none; b=rFdRBGQR+Pax8ZFm3mKwX13mho1cd4ZBfYzxUNsH8kQp0VBfg9TktNZ7vPOZtMODLCI53KE9gmKQh9n5RIwsM4TrF/h+gd8Ptlys7tR57SwP1XnrQdyJmLmBL+rW1pJ6rntb2rJHS9QciwGTQpKNKcM4VycfhjaHO7FaD+pVKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734468162; c=relaxed/simple;
	bh=OD2GLYJKYQfo5l2f5mO43Ad7yysAqKOj7yXaUSgNDZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNEYWNh7bXBSvn1ncP5gnjU1or54p9J3DXS/X2kBFsg0QiZL6lhBUbJsERsUI+4fpYTfO0f5HMgy6Vui7ce8EPPGs5CeqrSncQvJoagryPcnCgMeE3ydPBiXtslyfWSgMDTlQa4kvb/kBY5/WzAtNHP6+jEZeZqZeU+KKAtshyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=eJSMiJ5C; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734468153; x=1735072953; i=quwenruo.btrfs@gmx.com;
	bh=T5WfVDYh1MQOWWdWoio9gcvduxwGZ62mEhJaUo0woAM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=eJSMiJ5Cke0k2sf5rHMvwjzO11/y8t7X01x1Ms5ftqmwvrFhlrFU38MCqFgeMoCl
	 8APMvmFTIwNuBm5eQ/LjBNjKw1X5cwbeSRxfvcWbPL9rv5ZRymAQjGR88WbteaS0L
	 17HMZGA39MAVptM5osHQYgq2sb0+fXhCvyqonr4u7GDNczZyL7QBjCGnPnJ5PGeiz
	 zReN2/lMIZWLgj7bLktD/I0G+jSPM6XC5Cy6qcO8JAKV/NQwI0kVN2ljjaEX6mump
	 97v5gFwEVZXDplJPXhVIzND7qEOuDAbEsmealpAhLpGRsLYlYjKVoOCC3bCzvxXRp
	 siC61LMa1aL1NqGCLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mlf4c-1toQQc3V9G-00kAHP; Tue, 17
 Dec 2024 21:42:33 +0100
Message-ID: <0a2fd26f-40f3-43a3-90e9-4b0acdcdee6d@gmx.com>
Date: Wed, 18 Dec 2024 07:12:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] reduce boilerplate code within btrfs
To: Filipe Manana <fdmanana@kernel.org>
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1734108739.git.beckerlee3@gmail.com>
 <5b02e350-8c28-42b2-8ccf-8ce76b4ca683@gmx.com>
 <62871028-9f70-48d2-9d46-3ae1f6a57505@gmx.com>
 <CAL3q7H733CPhUgtRuj_KCskSik1qXNbK7kdqyQb5XWvSJ4ARUw@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <CAL3q7H733CPhUgtRuj_KCskSik1qXNbK7kdqyQb5XWvSJ4ARUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r2FS+M+Apq/7IbCT/oxCGgmN13Cz3i80XVzhQUv3PNxu3RO51Xs
 FE3K/ngtSx77TzF67g5X4I/eOwno5NmLtkREWcYWdPq2EGIVLa07qrxjCokYr3fhUdglX9p
 RkmpojlGkjUOaRT1JAAmWhMXSUVeOF8WwfwuA3ZOmBvRBg04/dS/bN2Vds60H3l6DZSBW4m
 utYQpw0gCWLfiLHMiWDuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ytnwyrzazYU=;RdJ9hraVBITePcwksqBEYpc75aM
 jXseObS6cTkFssg326/pLvrK0MnR6uPK1+u5r57SZa5hYo0l1RwaZn8JoJQPAslNN1qcSEmdT
 gqJf3EccXm51fOZO3Ls4RRWnNuSgnQirAg7dJgotKSd/PMPo0fVX+ZiYVbrpmQbx8Nzlb59eG
 yChhmsW69uqjxxzMZGUC+WHDpDyhvdHdPHH0kP0qAXXoGCadlN0r8FKxzc7CT/uZpBJlvC6XR
 ABmdu7d8Qxiw93oNoewxguTpT8TcJTJz3MymUaR1MQ1HRThLTG9Z76T7Kad3QZgmXxCYX35yB
 2lPudGfc74bWU7i688aFEGqfgJkzVbc8ZP+2kJVSiNd4Ptq+3dx63cewNrtOqYn1Vsvv9dJEX
 jf+P2nQCldvJuqz68uNgbwVUcQcfhNAkiH10Obem2Vb0JKgdeUWUHwpHZcVkrs/Q+++KGnYxp
 eGRU0qsIBRiA/rO9NYlBXtjklPCpGYs2RRZqa6TRLGPK/A7XE4exTEvrzkfd6rSJ7OP0aPVP3
 9QRaSd+53J/MxTCqKZrDDfdbiIq1go+ZhvMkK3CDNHezNgadMmaVq2eU4FaNPDLi0K+184Pea
 7g6sD0Nb27UB6c9sXVN2Moqj7gjoznpWKoSV0PMOCyHB4h1Ys+vo02P4R3QPPUydnSYpjx2uo
 kOxaQxbdOT+8s6Ft6PMISyH9D0Jkq5ZXAEL7k13egJuYpDODvIXYvJ6rNnsutdIO12blMiIcM
 Tc0IEFq0MbC7vXDkJ7ND/ARsQoaEj65PoCR/ELWf/mF96MbN8kb7HS7w46ne+MNl49VzIhKUP
 o54VldX2YSEX5kD/gsPABUseyfISzTnjnfzRReaD4Uo+8wIxzHhiE/1bB0cDvWEuTVlPoJxIi
 OVYBCANqw0Z/BAd4Ksm2n3vuO9YDRM5SACof3zYebNq2K0k+CXgYZdTyhwZGdRd1Dbd/J6YRn
 Q15TJ1M59AhgAJbl8GTNvYuFS3TDbPos93ONYtzCni11dc2A97Ok71Lngb1xorkIulqHMZffR
 DVxdRF0WaeeRLSdaGLUQWyA9So1z6QLdUD4Y+5TgVJCcvOmHxP/hnITL5i9DbF91SVQFw1GDM
 B7mKth3uSczKCtx8dntlrw2Wcc8UA+



=E5=9C=A8 2024/12/18 01:39, Filipe Manana =E5=86=99=E9=81=93:
> On Mon, Dec 16, 2024 at 10:07=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/12/17 07:50, Qu Wenruo =E5=86=99=E9=81=93:
>>>
>>>
>>> =E5=9C=A8 2024/12/16 01:56, Roger L. Beckermeyer III =E5=86=99=E9=81=
=93:
>>>> The goal of this patch series is to reduce boilerplate code
>>>> within btrfs. To accomplish this rb_find_add_cached() was added
>>>> to linux/include/rbtree.h. Any replaceable functions were then
>>>> replaced within btrfs.
>>>
>>> Since Peter has acknowledged the change in rbtree, the remaining part
>>> looks fine to me.
>>>
>>> The mentioned error handling bug will be fixed when I merge the series=
.
>>>
>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>
>> Well, during merge I found some extra things that you can improve in th=
e
>> future.
>
> One more thing to improve in the future:
>
> - Run fstests and check that that are no tests failing after the changes=
.
>
> There's at least 1 test case failing after this patchset.
> The patch "btrfs: update prelim_ref_insert() to use rb helpers" breaks
> btrfs/287:
>
> $ ./check btrfs/287
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc2-btrfs-next-182+ #2
> SMP PREEMPT_DYNAMIC Tue Dec 17 11:02:25 WET 2024
> MKFS_OPTIONS  -- /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
>
> btrfs/287 1s ... - output mismatch (see
> /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad)
>      --- tests/btrfs/287.out 2024-10-30 07:42:47.901514035 +0000
>      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad
> 2024-12-17 15:00:35.341110069 +0000
>      @@ -8,82 +8,82 @@
>       linked 8388608/8388608 bytes at offset 16777216
>       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>       resolve first extent:
>      -inode 257 offset 16777216 root 5
>      -inode 257 offset 8388608 root 5
>       inode 257 offset 0 root 5
>      +inode 257 offset 8388608 root 5
>      ...
>      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/287.out
> /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad'  to see
> the entire diff)
>
> HINT: You _MAY_ be missing kernel fix:
>        0cad8f14d70c btrfs: fix backref walking not returning all inode r=
efs
>
> Ran: btrfs/287
> Failures: btrfs/287
> Failed 1 of 1 tests

I thought the failure is caused by the missing fix, unfortunately I
didn't notice the fix is already merged upstream.

>
> So please fix the patch (or patches) and resend the updated version once=
 fixed.
> Meanwhile it should be dropped from for-next.

Now reverted.

Thanks,
Qu

>
> Thanks.
>
>
>>
>> - The length of each code line
>>     Although we no longer have the older strict 80 chars length limit,
>>     check_patch.pl will still warn about lines over 100 chars.
>>     Several patches triggered this.
>>
>>     So please use check_patch.pl or just use btrfs workflow instead.
>>
>> - The incorrect drop of const prefix in the last patch
>>     Since the comparison function accepts one regular node and one cons=
t
>>     node, the last patch drops the second const prefix, mostly due to
>>     the factg that comp_refs() doesn't have const prefix at all for bot=
h
>>     parameters.
>>
>>     The proper fix is to add const prefixes for involved functions, not
>>     dropping the existing const prefixes.
>>
>>     I have also make all internal structure inside those helpers to be
>>     const.
>>     (Personally speaking I also want to check if the less() and cmp() c=
an
>>      be converted to accept both parameters as const in the future)
>>
>> - Upper case for the first letter of a sentence
>>     I'm not good at English either, but at least for the commit message=
,
>>     the first letter of a sentence should be in upper case.
>>
>> - Minor code style problems
>>     IIRC others have already address the problem like:
>>
>>          int result;
>>
>>          result =3D some_function();
>>          return result;
>>
>>     Which can be done by a simple "return some_function();".
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> changelog:
>>>> updated if() statements to utilize newer error checking
>>>> resolved lock error on 0002
>>>> edited title of patches to utilize update instead of edit
>>>> added Acked-by from Peter Zijlstra to 0001
>>>> eliminated extra variables throughout the patch series
>>>>
>>>> Roger L. Beckermeyer III (6):
>>>>     rbtree: add rb_find_add_cached() to rbtree.h
>>>>     btrfs: update btrfs_add_block_group_cache() to use rb helper
>>>>     btrfs: update prelim_ref_insert() to use rb helpers
>>>>     btrfs: update __btrfs_add_delayed_item() to use rb helper
>>>>     btrfs: update btrfs_add_chunk_map() to use rb helpers
>>>>     btrfs: update tree_insert() to use rb helpers
>>>>
>>>>    fs/btrfs/backref.c       | 71 ++++++++++++++++++++----------------=
----
>>>>    fs/btrfs/block-group.c   | 41 ++++++++++-------------
>>>>    fs/btrfs/delayed-inode.c | 40 +++++++++-------------
>>>>    fs/btrfs/delayed-ref.c   | 39 +++++++++-------------
>>>>    fs/btrfs/volumes.c       | 39 ++++++++++------------
>>>>    include/linux/rbtree.h   | 37 +++++++++++++++++++++
>>>>    6 files changed, 141 insertions(+), 126 deletions(-)
>>>>
>>>
>>>
>>
>>


