Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E82315701E
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 08:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgBJHz6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 02:55:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:47181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgBJHz6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 02:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581321348;
        bh=S89K/aKn8czo611/9wXaL/aAinmvpU9laJaCYCAKSZk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cem1jPaRLbeW6KG3eVEQymaYgudEph2CKpUHV2a40TmA4cMoehQLOrvbAzynm5PMW
         lSaU2n+FIRchoyZRC5q0wYKti8Dul6C95USBjUMgQhpgH2M3Fd8Gf5SKkBGNnLx4W9
         xl8/quQrRLU0pO9S4Sjf7e4Hpk6OAmyEPbaPDUW4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRjt-1jcJY347AX-00boVA; Mon, 10
 Feb 2020 08:55:48 +0100
Subject: Re: [PATCH] fstests: btrfs/179 call quota rescan
To:     Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <1581076895-6688-1-git-send-email-anand.jain@oracle.com>
 <1fae4e42-e8ce-d16d-8b2f-cada33ee67bf@gmx.com>
 <580c99c8-dcfd-d12b-6ede-7636bf404d32@oracle.com>
 <e4a8a688-40bc-c88e-7ccb-ca7c958fc457@gmx.com>
 <84b66420-4c4a-93b9-52af-37e85a343773@oracle.com>
 <73b9d157-840b-b93f-b86a-5041745f08ce@gmx.com>
 <2937988f-3ebc-8cd8-a6dd-82648faf126e@suse.com>
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
Message-ID: <f0d9163c-fd33-907a-b5ae-dd9a5c42507c@gmx.com>
Date:   Mon, 10 Feb 2020 15:55:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <2937988f-3ebc-8cd8-a6dd-82648faf126e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QMJWFdnNrowX1U+W++MzGjRrkD5SUkHe2dAX9SZDvhjMT3KRW/0
 q+4vxtfu3QpHC0+jOAFsBJdqyUVEdEX2qMbJhUKQhnk64nU/Lnk8A4xTalNnMbTs805YFdl
 oFwHPfK1gtfuNvvssBA8DQHDcWfEUtHw4vU2kk5qsXsbHDBrkAElZEC2r7Gzn8gIsyLK5KU
 Bd32iyVthMrug4IpJ5o1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8hixPrDUfmo=:uO7iVk85447NrbxJcSRG55
 +jpZUaUlobRNZn8q4vmkktXP6d1Wt+kXPvFSHKcf88vf8i5Ofd9q5GLgMctVnSqABDxgN5g2v
 gsLZOzzPbMl48sD0Xs9tNw80+xqtShdrndfb5/eiJQPjkbJarkRgyjgXJFG0lZhmjpDW8uX+E
 QERXfweFkFqLyaos+sJhW2L7mB3c9+fYqg16/DPeU9BjpVn5HBKWwpF2+RwE9CBZkQ/26CRHa
 s8Mu4b9aGCW23D7Rh8q9A3Kh1foUzVDckGdM7rJmZd1kYm7SRZAcxLpYwHIkAZj+ZeyIXcIcl
 5fPqeqPiEvhUiLZX8lEraIbWQ843W/5tB1kYG80ZSkztAA2gsbhIDDGhqRaXbn/IR9rNL2mhT
 Fznpbu6QCnRKohizKA4Wip2Gd/tftuIEV1nzqy8QjqL0eGCJsnodHtDUu7Mse5A+fhkl21tLU
 FY8P3G3CStgKcu8aYvDGHjcUjStCjT55Qw2xJdB0PPR7h9fv4cVKWUK8SM3us23OuuXKk2WkH
 97161RW3eN9aiHA2f4t90qUQlGb3KHnm7aNq7x5OAPLQ0tmLnBWtqLeOKCPe7nnG7GighLbAi
 CfmcitDl6zD7EeISQKc6w0p9CMqBaZ6cIlUuMkV6eFTeNnlSlVCbl7LFwZPF3bf67Hp7n65BP
 36MWUXwWp9MkWfjy8ltfSCrXKYqlcxQxoxVEPghHowivUUiycsgq42NTZt6WDzefa/lsFaQE3
 fk2AuZBo/rzJ74rm2E/JNDpoSpRJ1Pi5BBSH42sSqOzrJqi+UyPDal1x2eIDB1uqXaYKnQxBg
 tR/8PezpwYXBjWywgR63TncOaBL9LTwXL4miOxgkzSlE7A2J8W9B8R3NQ8KCNlafXMprV+eGW
 6w6exsvrvyHCR5AHiC8pGxG/L+J8wLvYK8chP/1XeSgqRB9+9Ip6HerocEznQLPhtOREgjw3E
 Y5zVJhpKCiD0I1KHxy9uLcMmx7E1mvNwNQz2YJF7coAHH3O2YQf5/sM159lxTJ9i/ZF+Yj8l+
 B4uiSrDgFg9yhOGP7SjWz3x2EeD2JNFqEwZPoqNwo2Hk00YKhoAGTcd6h0llKW9rlVaAuzOnz
 Njeza+Ev8/L13b/gZ/zAx8RlGUG6RPeAlahd9L9YNAqZDPejFDMTfnaZcGAED5/YWleESUJ1I
 X/J3bH9HU3dxn023CQ5cjIlDukUvuV3Y4IcbZZ9A1x4vqbB5XsF5Bo+us1NlBeT1qaazhduzp
 B0WTcMBY4SSCT4oNg
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/10 =E4=B8=8B=E5=8D=883:45, Nikolay Borisov wrote:
>
>
> On 10.02.20 =D0=B3. 3:36 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2020/2/8 =E4=B8=8B=E5=8D=885:06, Anand Jain wrote:
>>>
>>>
>>> On 2/8/20 7:28 AM, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2020/2/7 =E4=B8=8B=E5=8D=8811:59, Anand Jain wrote:
>>>>>
>>>>>
>>>>> On 7/2/20 8:15 PM, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2020/2/7 =E4=B8=8B=E5=8D=888:01, Anand Jain wrote:
>>>>>>> On some systems btrfs/179 fails as the check finds that there is
>>>>>>> difference in the qgroup counts.
>>>>>>>
>>>>>>> By the async nature of qgroup tree scan, the latest qgroup counts
>>>>>>> at the
>>>>>>> time of umount might not be upto date,
>>>>>>
>>>>>> Yes, so far so good.
>>>>>>
>>>>>>> if it isn't then the check will
>>>>>>> report the difference in count. The difference in qgroup counts ar=
e
>>>>>>> anyway
>>>>>>> updated in the following mount, so it is not a real issue that thi=
s
>>>>>>> test
>>>>>>> case is trying to verify.
>>>>>>
>>>>>> No problem either.
>>>>>>
>>>>>>> So make sure the qgroup counts are updated
>>>>>>> before unmount happens and make the check happy.
>>>>>>
>>>>>> But the solution doesn't look correct to me.
>>>>>>
>>>>>> We should either make btrfs-check to handle such half-dropped case
>>>>>> better,
>>>>>
>>>>> =C2=A0=C2=A0Check is ok. The count as check counts matches with the =
count after
>>>>> the
>>>>> mount. So what is recorded in the qgroup is not upto date.
>>>>
>>>> Nope. Qgroup records what's in commit tree. For unmounted fs, there i=
s
>>>> no difference in commit tree and current tree.
>>>>
>>>> Thus the qgroup scan in btrfs-progs is different from kernel.
>>>> Please go check how the btrfs-progs code to see how the difference co=
mes.
>>>>
>>>>>
>>>>>> or find a way to wait for all subvolume drop to be finished in
>>>>>> test case.
>>>>>
>>>>> Yes this is one way. Just wait for few seconds will do, test passes.=
 Do
>>>>> you know any better way?
>>>>
>>>> I didn't remember when, but it looks like `btrfs fi sync` used to wai=
t
>>>> for snapshot drop.
>>>> But not now. If we have a way to wait for cleaner to finish, we can
>>>> solve it pretty easily.
>>>
>>> A sleep at the end of the test case also makes it count consistent.
>>> As the intention of the test case is to test for the hang, so sleep 5
>>> at the end of the test case is reasonable.
>>
>> That looks like a valid workaround.
>>
>> Although the immediate number 5 looks no that generic for all test
>> environments.
>>
>> I really hope to find a stable way to wait for all subvolume drops othe=
r
>> than rely on some hard coded numbers.
>
>  what about btrfs filesystem sync?

The only cleaner related work of that ioctl is waking up
transaction_kthread, which will also wake up cleaner_kthread.

It triggers clean up, but not wait for it.

And my first run of such added fi sync failed too, so not good enough I
guess.

Thanks,
Qu


>
>
> <snip>
>
