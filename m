Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B0381941
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfHEM06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 08:26:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:35889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEM06 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 08:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565008012;
        bh=pW02v76urWBqnLuWJHNlcPQ7mn4iCMb+cRZ5XEqEsHg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=j00fDdZo1B0BvDv7LpoxB7zCIX0XupTkdA9oKlQRCHfTX62OA6RobjYOFVP5kxrSb
         mQuWtYxmF62i3Zogq6H4DpxA8oXRx/9QjTdzEXBKQYRH6FlMgmwiNHYHP0wSu0kIYO
         AQp7GLKp7z1HNzt9AiycxtMq1eVnLNjAUO9pnDPU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([54.250.245.166]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0oFz-1iIDPA2DNV-00wl70; Mon, 05
 Aug 2019 14:26:52 +0200
Subject: Re: [PATCH] btrfs-progs: Check for metadata uuid feature in
 misc-tests/034-metadata-uuid
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190805114522.12151-1-nborisov@suse.com>
 <fbda482d-5530-e6d2-b351-d94c10583c65@gmx.com>
 <cf65bf5c-a1ec-8871-8e3b-b510a36a4e60@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
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
 ABEBAAGJATwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <151dedfe-cfde-6b74-aa6f-dbb67f15874a@gmx.com>
Date:   Mon, 5 Aug 2019 20:26:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cf65bf5c-a1ec-8871-8e3b-b510a36a4e60@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1rnxDzcRvpC8eRoo6S+zNp6t46hcW/BEVh00dcCRZG/OGeiFzlw
 esVD9SRhgLYd88O4Qlw7k1T/H13oGZKw5RKulQdxwepWyZFO9OfAqd/wz6aUmsy2gthUd2f
 3GU4Af7yiqgU6hLx9tq5CqqPIB/p+cQhCAWSKPDr69Z/Gi134wPSKUivzBB+ulLhfy2jt7K
 ftpwVVWo/JNij4rapyqag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zQa28FNROWg=:qXjYc7hAXVIZk9o8tOMadq
 xRG7aiqR9FsQahP5HcV1TSMJ6NYOHs59AgeIMCdG0sDhVx3f81v+jQ9jjbx+pq375f8gQHGVD
 xS2HYKu4+7lxVCAjQNr+RrkvMvF0kgowMrqos3VpPWH8l8ggvpFnwENev0S3O0ZBOQLY/QUlg
 24UDT4uTXGT1/9+Fgjq6VgPbF4ibrPkdtBDpUKvNu8NhpSmjz+ghtLAaBTUfytlwzMBZQVbdq
 42fx72OuCL0Krx9xb92kK3zDpSTLMx1cIzqKvXRLZgCUQ/qUVIAcadJwBcbFNvczxHUJVq9nk
 7EXPx+L/y5aOogoDyumTKyWAIGHwqHGVQhezrPYmkZDdJb2gsRZKpte8D5vTdnhMhRfQFxVGv
 TnoGrXDxDFDSOyOpehGQb/bc1hHcKMr7UStoFKljwzhVxj/ybuCxF5AniJjDHFp8puvqtVHot
 dGcPYpXOEs+/RLXa37uRBPLCaYmpdWMPfIRD4pz1AgGdZrPSftt6BdAAvwr+Cr3LI/KgrZllX
 ueeBLdb6SxLx6lESYT1YWIe3A2m+Z+c4Wrgg3dUmuF0p/4OOznqFo8FnL4zqQ6VmZPgjJZSgP
 z84lLfFNcgzpanrdgdLRnPqW3bVmDyHhK2vEVdGibDB+ueDhwJ5dpumZFj88GEvUrk4i7vqSZ
 rLyTrYDvaFAzLtww6Kq23WgMCR8RfabiYwRsaqlqZhGWQJylOJwxJ9gg4nSZ9W1itxEe3jgOs
 MI8H77iA8/JfbzsgYksXFjismQ3MKOFH3uzyscDAsqMUNUjiYW/icoi0aiLpEzrbXg9MQGS2O
 tcfgrsQIHLNQKQb14jG6EGEVEei4dsu4J4PQJdcxulfH2evNplY3ZNAbtKGH+DY7zSkwrGIiJ
 E4KHU6q5vPX6h15aZTHYd4PNhcGRlpvtP/KJUFwDYpy11CrIlftRbAJR9pqTsTXlvN7LeL1Hc
 /jc6+5eMmM8lQIIWtgR+XgEWTP7J0B/PlGj7LghgMlya7GJEdDEB4BQbqnu8oRdVCd4eL/3MA
 G6iOQ+7LJlliBYDn0ApaNBqMPpht1ihf4H54WztIwSSwdzO3C7lTPpj5Vr19Ci15IdOEHI8gs
 xLPna3jdpPQ+NCjRKaj4h7BI1IGbxai0sEyUPes16mGBcKstWxft7TAwEhWHJ4oQHvlQ8/wj9
 k5oFk=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/8/5 =E4=B8=8B=E5=8D=888:20, Nikolay Borisov wrote:
>
>
> On 5.08.19 =D0=B3. 15:16 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2019/8/5 =E4=B8=8B=E5=8D=887:45, Nikolay Borisov wrote:
>>> Instead of checking the kernel version, explicitly check for the
>>> presence of metadata_uuid file in sysfs. This allows the test to be ru=
n
>>> on older kernels that might have this feature backported.
>>>
>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>
>> The idea is pretty good, as sysfs is way more accurate.
>>
>> But /sys/fs/btrfs/features is not ensured to exist, e.g btrfs module no=
t
>> loaded yet.
>>
>> Can we fallback to regular kernel version check if
>> /sys/fs/btrfs/features not exist?
>
> The top-level test runned (misc-tests.sh in this case) already calls
> check_kernel_support which ensures the module is loaded. So such
> fallback is unnecessary.

Oh, forgot that.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
>>
>> Thanks,
>> Qu
>>
>>> ---
>>>  tests/misc-tests/034-metadata-uuid/test.sh | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/misc-tests/034-metadata-uuid/test.sh b/tests/misc-t=
ests/034-metadata-uuid/test.sh
>>> index 3ef110cda823..6ac55b1cacfa 100755
>>> --- a/tests/misc-tests/034-metadata-uuid/test.sh
>>> +++ b/tests/misc-tests/034-metadata-uuid/test.sh
>>> @@ -10,8 +10,8 @@ check_prereq btrfs-image
>>>  setup_root_helper
>>>  prepare_test_dev
>>>
>>> -if ! check_min_kernel_version 5.0; then
>>> -	_not_run "kernel too old, METADATA_UUID support needed"
>>> +if [ ! -f /sys/fs/btrfs/features/metadata_uuid ] ; then
>>> +	_not_run "METADATA_UUID feature not supported"
>>>  fi
>>>
>>>  read_fsid() {
>>>
>>
