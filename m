Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9900721943C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 01:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgGHXVl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 19:21:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:49945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgGHXVj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jul 2020 19:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594250495;
        bh=DPKjiwr6m0xglrIYYM8B0aq/ILyTU4tzjgPzz4VrfyM=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BloH4nVfUno/IjFB8h4GCqLLIRxnTPpRe9Ml5fYocn9ATPOlHcxEpgR0Nd6WdEg8Q
         zOBrelLxaNXQjcLmIaLvdrnSMDVzUOoIjdExk7ZCmc+rzA8dTYUwQZPRxgy+uox9Tk
         eAoywNp5SRgs5FImhNeEZ7dioUJ0wnKmqKDgwwbU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MFsUv-1k7MOH3TSR-00HNrN; Thu, 09
 Jul 2020 01:21:35 +0200
Subject: Re: [PATCH v3 1/3] btrfs: qgroup: allow btrfs_qgroup_reserve_data()
 to revert the range it just set without releasing other existing ranges
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200708062447.81341-1-wqu@suse.com>
 <20200708062447.81341-2-wqu@suse.com>
 <9a95772f-8986-294f-abc0-447fc1ef0a06@toxicpanda.com>
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
Message-ID: <3d566945-49e4-f8bf-4836-1c5db91d6a11@gmx.com>
Date:   Thu, 9 Jul 2020 07:21:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9a95772f-8986-294f-abc0-447fc1ef0a06@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5xTMEUnu5A/Vq5Z2rZkhHXCmbACp8AS+jwsPobGMLjkdvSCZ2FC
 kilBFyRFL/tB7/9xHmQXOFlfVVnrcRI+yhTAEMmxoYP/OmywCsLD+zmnud5u6ewpYQZHJZN
 sDfECagHROgIiGSEyyQL9ul6o3vg6e/ZOCM2sIHcdNu4f5C9Ay5EeEYrx+5huBcp4WRIB04
 7v4QX11m7r8tBrL5QaGHg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eRiztLEdf6w=:lD8HX3bpTfgS+gbD6XnNvv
 QxORq+26ioTE9psVIQMJIcGkqsTMXhrTgTDWeFCsKyZwpQpPrwp52yvF3ymUMgA3apXZYJbn9
 3Hf7q+RqSsnamFdCB8Oy7umODgdn4bDtZd4ViF9fAZq+w02KxEAVgfCbsK3MUOqurVwk3ha8T
 +35p1pSPO8ylTRddbmChBCFKP69ws1kVzWj2vYVOtsZ+ldgdmfm1HpLfMX9XEQpLr/7tbod4c
 IXNi/mQ4AoVVtXe09OVIKUdO8YiThndx1atIZBr7fgIrkRLecYefNKHNqzSHOLah16PpKmn+3
 nACDM89HWDOup8t1SKBag7fGJeluPv4xz6KzBBgPDD1RpAnID7HYrz77dWnLRZ3IdM02YLb2e
 Sfs5eaEz8mRSchWCybNyEjjf7+5+NXS93MXYWdAqvxicjELVGd439WiwO074K0xICYQdcdWrN
 DEw8MGQ1t4/HVUfYQ1ceII22mbQXXtSlwqVYvSJeQY8m18EPWMKjifw/R6KmbFsBp1mRGmGXv
 fNl9Rk091anWqLDtsgjutyHAD8BtCWTFn/lg7UCa108FBCPYiP+fw8LZW3agSllcWUzu3yj9l
 uC0WuY3ZY5JqF+GCN39kJ/BQWIbP4G1JmojnUWO07WXnOCYCb+jG1LIfqQ81UoKhO5DjAdI5t
 42cNUimynSZOUJxammUZ9LhpL+RsTUHI6VMUQBZBl6kCup3GDbGLdTFplSENhFGyU/Nt7OvQr
 8NNloP61I0kf38rBmkLU0Reka13OPwIHnPqCQYnHVJmY+AR/r8crTzLuUSWAGaxk95W6+rIck
 EZZAQ4Pdxk82eHR4Bz/XHPRYwKIcQmsrqOCxcAI1SZ9ZQQr2eP/8cB74TO2m4rGr5DWIOsIgm
 9SqKfzCK4XLUOtEN/+q18c5lHHQoNIIeAi64auyO5yWmWFP0hkh8NtYJ+6ux1cLPl1RSmUhOh
 Y5MY4dnXgmchu0I50aS9rl4nUvciUkszOukAc8F3EG/gjMWMXS2ufomeo9tvSz2clJN5m6JKv
 RQ0pr8ss5GEkUwEBt6Hx3vHANzKnat92ObCRmm0KkBPR1Iq/1W8UBVipJFp7ymPCjtYGquPS9
 VnCm/8UPoM16jr6P6sNpArzz2B1VNXEii7nXKX83Wr09tC6WInKyVgrdEVot2NePaijcPmv4Y
 J11Eevf4Zid/ZJ1dCMgtCgCaHxcFtHgOf1WSv4diO7+r02F9LM1iHv4VYdMGT7VccG+tGJMAj
 8L8vswqc7RuCDKq/FhKjty3ESZMR8+9FaTyX1DA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/8 =E4=B8=8B=E5=8D=8810:09, Josef Bacik wrote:
> On 7/8/20 2:24 AM, Qu Wenruo wrote:
>> [PROBLEM]
>> Before this patch, when btrfs_qgroup_reserve_data() fails, we free all
>> reserved space of the changeset.
>>
>> For example:
>> =C2=A0=C2=A0=C2=A0=C2=A0ret =3D btrfs_qgroup_reserve_data(inode, change=
set, 0, SZ_1M);
>> =C2=A0=C2=A0=C2=A0=C2=A0ret =3D btrfs_qgroup_reserve_data(inode, change=
set, SZ_1M, SZ_1M);
>> =C2=A0=C2=A0=C2=A0=C2=A0ret =3D btrfs_qgroup_reserve_data(inode, change=
set, SZ_2M, SZ_1M);
>>
>> If the last btrfs_qgroup_reserve_data() failed, it will release all [0,
>> 3M) range.
>>
>> This behavior is kinda OK for now, as when we hit -EDQUOT, we normally
>> go error handling and need to release all reserved ranges anyway.
>>
>> But this also means the following call is not possible:
>> =C2=A0=C2=A0=C2=A0=C2=A0ret =3D btrfs_qgroup_reserve_data();
>> =C2=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D -EDQUOT) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Do something to free some=
 qgroup space */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_qgroup_reserve=
_data();
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> As if the first btrfs_qgroup_reserve_data() fails, it will free all
>> reserved qgroup space.
>>
>> [CAUSE]
>> This is because we release all reserved ranges when
>> btrfs_qgroup_reserve_data() fails.
>>
>> [FIX]
>> This patch will implement a new function, qgroup_revert(), to iterate
>> through the ulist nodes, to find any nodes in the failure range, and
>> remove the EXTENT_QGROUP_RESERVED bits from the io_tree, and decrease
>> the extent_changeset::bytes_changed, so that we can revert to previous
>> status.
>>
>> This allows later patches to retry btrfs_qgroup_reserve_data() if EDQUO=
T
>> happens.
>>
>> Suggested-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/qgroup.c | 90 +++++++++++++++++++++++++++++++++++++++--=
------
>> =C2=A0 1 file changed, 75 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index ee0ad33b659c..84a452dea3f9 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -3447,6 +3447,71 @@ btrfs_qgroup_rescan_resume(struct btrfs_fs_info
>> *fs_info)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 }
>> =C2=A0 +static int qgroup_revert(struct btrfs_inode *inode,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str=
uct extent_changeset *reserved, u64 start,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64=
 len)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct rb_node *n =3D reserved->range_changed.root.=
rb_node;
>> +=C2=A0=C2=A0=C2=A0 struct ulist_node *entry =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 while (n) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry =3D rb_entry(n, struc=
t ulist_node, rb_node);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (entry->val < start)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n =
=3D n->rb_right;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else if (entry)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n =
=3D n->rb_left;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 /* Empty changeset */
>> +=C2=A0=C2=A0=C2=A0 if (!entry)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>
> Don't need the goto out here, just return ret;
>
>> +
>> +=C2=A0=C2=A0=C2=A0 if (entry->val > start && rb_prev(&entry->rb_node))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry =3D rb_entry(rb_prev(=
&entry->rb_node), struct ulist_node,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 rb_node);
>> +
>> +=C2=A0=C2=A0=C2=A0 n =3D &entry->rb_node;
>> +=C2=A0=C2=A0=C2=A0 while (n) {
>
> for (n =3D &entry->rb_node; n; n =3D rb_next(n)) {

You get into the trap!

Since @n can be deleted from the tree, it needs the @tmp to record
what's the real next node.

But I can still use for loop with @tmp involved though.

Thanks,
Qu
>
> Thanks,
>
> Josef
