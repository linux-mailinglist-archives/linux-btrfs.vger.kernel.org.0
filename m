Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE872770C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 14:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgIXMTP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 08:19:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:39895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbgIXMTO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 08:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600949947;
        bh=oRAzzE675IFR7hX1KeS6nO8pw8UEoNl0WLinRqfck00=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=BjlSXGWdNe4FWq7r9QBfvockDlbl8MDs1U57WKX2s7FCz8GSFiPkR8T9J2kVrnHi9
         h1OAOotMbMIPV0RhBkNhVXz3sQ0XpcZINe5KznDJWc7talRL9fwvAuauLa6uNxjCOu
         zVOzmwWn288rNkGGaRAz/eIzqrIlaLiortat1mNI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7zFZ-1kZQXx0jwp-014xm0; Thu, 24
 Sep 2020 14:19:06 +0200
Subject: Re: [PATCH 1/2] btrfs: drop never met condition of disk_total_bytes
 == 0
To:     Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com, dsterba@suse.com
References: <cover.1600940809.git.anand.jain@oracle.com>
 <4fea8a706aedf7407d6af7a545126511168e15f5.1600940809.git.anand.jain@oracle.com>
 <c9e538dd-c039-478c-d677-0e9dd95cfc39@suse.com>
 <b879f134-5bf9-a28a-885a-750d39f29a63@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <ffc60c8f-3045-640b-bed9-07001287470a@gmx.com>
Date:   Thu, 24 Sep 2020 20:19:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b879f134-5bf9-a28a-885a-750d39f29a63@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3j+tZWFacCudbquH8knzwcZyKmKVq0elPjZM3Bw/RShAHcC9khb
 k9czi+RPsfEsCjEk9YMeynu7+WzpNTilo8TOtCXyaHiiSBWq7hAJrA96nDdRiQndzQYG7M5
 RXfUgL6pvI6IaeM8HVTSbbUnxUKv9VuWQUkWsBvDDwB8sCM2aXdaSRJ5GFLACk6ZuKYbT4q
 Q19+SGKX/Z4zuHUOsNvGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:df5bh9SVWT8=:c1wR0D5uY2bVAU6mfilbCA
 LlnBhInYrU5OVOlemG7IEc2fJnLkmiJmgeIRgsCu4XJFIupp3C37vYlSeEYK/5bNWMctKpNoQ
 KntQ8/qXCbKKhmnenm5mX3c48S5DPz6MPIkM8crz6SoHboYKzNp6gsBDbdArOEGULTnoMj9I+
 Fc/q4jKTwfIthlRyRlIKod3pJ9H8cZlUUCTVyU4+nJ9hFo0ygHmIKyrt4j0Glymbup+RdxTQz
 Qo7JNAYNCUwiJc2RbFm8DmSQZojsUtUzLe3vXYO2AO+Z9l66Lwn11i+ZMHeHd7hd+QRPbg0ME
 8hzB6A2G+MTpfiKIKPWPSkEDM3q2g7thobx997pLXzXmpAw+Iqq6Bn64Hb9EcwkIl+uTNZVsA
 citQiZPnj1VX5q47QRZuzaPQrsY4aus2YQCUmWosOHIWnWukgBAL+NMs7gjKykIJiggqQigBx
 G5wXq1myB9GB7DLbsPiPq6DCncgkEFv0MaLFq8aPR25Rs5xe+U2Ek6KO+7SCp+7Y7qDh79t2n
 LpRSKJU9LBoKcONLykNV8PSAGQt3Um9m1+t4L2Wwg+v2RhiZEYdAOHObRl1InGUWZWygfeu/h
 g2/LfWpd65gXkjWrAHMJsg14CThuxhoVrqCnQi3+7jOKWgxfHoVRCVwMsYPGFH48HjIOIMSTK
 FoEHZZ6PYOjFnzpseJnewZpqtwp9HNrVPHbjPW2JYLvrBwwxrwTrQqLc8sWPpTddyi76AZXt5
 QxlPWSYUoMzAjxR6Ldx2dyNSTofwlGnxRoDoHPcOwusdTOgqKDI22hvbCzRjUFiGBwqOFlvOq
 C47m2TJjtqaCSmHHKH15OujTFbHdoBo54rKotk8TiWoxXaEAigW3BeV6QaRVc8Cz+P/drtwpv
 4uWGvy/tQmoduQLnFMFEBszUZGEeFE6EH1NJRluF/aPWZvpR7hTDRfX7PoH+ecFe1ZSP6THBq
 FAuFfGxXLCGM5uXRIsI6GYs/NtVW1NKEp1BUfw0DQoaqRGhsm9hTt6nUC76iYgr+lj+K4ELds
 lRSUlJYHps7my9bnhad/cTCk/3ByISM6yxrR8N+C98n3uVsp0nb9Em7EsRCSG/au3lvMBA8YQ
 TArQ9QGAzN+rTwregF/mChi6creUkrGvCuRmtY/F1Qdf2FMxpCLUcL+dBvnqD1Qi/KRDIytc6
 l5GldmryUtQ12mDkT3P606lF5RSGUEW/zn1H9ovJe2FtKL3ulNGmtrUfxCUdIJCcfquAVzUJm
 ZAKDsfTF2BDkUPCWF25F7bjPTlPx6F6hnFau4aQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/24 =E4=B8=8B=E5=8D=887:58, Qu Wenruo wrote:
>
>
> On 2020/9/24 =E4=B8=8B=E5=8D=887:48, Nikolay Borisov wrote:
>>
>>
>> On 24.09.20 =D0=B3. 13:11 =D1=87., Anand Jain wrote:
>>> btrfs_device::disk_total_bytes is set even for a seed device (the
>>> comment is wrong).
>>>
>>> The function fill_device_from_item() does the job of reading it from t=
he
>>> item and updating btrfs_device::disk_total_bytes. So both the missing
>>> device and the seed devices do have their disk_total_bytes updated.
>>>
>>> So this patch removes the check dev->disk_total_bytes =3D=3D 0 in the
>>> function verify_one_dev_extent()
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>  fs/btrfs/volumes.c | 15 ---------------
>>>  1 file changed, 15 deletions(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 7f43ed88fffc..9be40eece8ed 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -7578,21 +7578,6 @@ static int verify_one_dev_extent(struct btrfs_f=
s_info *fs_info,
>>>  		goto out;
>>>  	}
>>>
>>> -	/* It's possible this device is a dummy for seed device */
>>> -	if (dev->disk_total_bytes =3D=3D 0) {
>>> -		struct btrfs_fs_devices *devs;
>>> -
>>> -		devs =3D list_first_entry(&fs_info->fs_devices->seed_list,
>>> -					struct btrfs_fs_devices, seed_list);
>>> -		dev =3D btrfs_find_device(devs, devid, NULL, NULL, false);
>>> -		if (!dev) {
>>> -			btrfs_err(fs_info, "failed to find seed devid %llu",
>>> -				  devid);
>>> -			ret =3D -EUCLEAN;
>>> -			goto out;
>>> -		}
>>> -	}
>>
>> The commit which introduced this check states that the device with a
>> disk_total_bytes =3D 0 occurs from clone_fs_devices called from open_se=
ed.
>> It seems the check is legit and your changelog doesn't account for that
>> if it's safe you should provide description why is that.
>
> And it would be even better to mention the fragmentation problem in the
> man page for btrfs-convert.
>
> The fragmentation problem is a little too complex to explain in the
> error message nor usage.

Please ignore this, I replied to the wrong thread...

>
> Thanks,
> Qu
>>
>>> -
>>>  	if (physical_offset + physical_len > dev->disk_total_bytes) {
>>>  		btrfs_err(fs_info,
>>>  "dev extent devid %llu physical offset %llu len %llu is beyond device=
 boundary %llu",
>>>
