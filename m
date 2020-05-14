Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB361D235B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 02:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbgENACF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 May 2020 20:02:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:43633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732806AbgENACE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 May 2020 20:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589414516;
        bh=vMmE71/PglsxE3jLt+ppMEn/Jg4EDfeJ7vN91ROBceQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Blwez6aon5GtfonZR2jGUU7irJOHrjF47W+EJxV5pxP+SEPlGrbJoWt1pc2u93fc/
         AN2kevB4z9L0XgU+YLYumSp0TyAcCbgKtCrVADzlFpIncxO/ZrVC+B/FlvCEZtvz4L
         2UnO8a3a8QmiUEcnQAeFdGE1bqe64LM13XOLqtgQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M42jK-1jZ1Jz2qPo-0000bK; Thu, 14
 May 2020 02:01:56 +0200
Subject: Re: [PATCH 2/2] btrfs: Don't set SHAREABLE flag for data reloc tree
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200513061611.111807-1-wqu@suse.com>
 <20200513061611.111807-3-wqu@suse.com>
 <84d3fb22-3845-b952-88ca-c5ce31ab967f@suse.com>
 <2dc7bd7b-dc68-613e-f668-0462829f380f@gmx.com>
 <20200513135152.GJ18421@twin.jikos.cz>
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
Message-ID: <12c06d3e-276a-9d5b-c7d9-6716884d6b76@gmx.com>
Date:   Thu, 14 May 2020 08:01:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513135152.GJ18421@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Djeb01Dz5JwQz1OqUi3Q+I0d20SuDz8xdAd27wevkBQMkz96S0
 SBDUoP2KFFDVYFc0mVzHcf6Xg1Pg1KxlxFx4uBH3PWyYuqRdKz+YdzYckHLJsoyMYSBXX5i
 +XYCp3kgyLaRkQb1n/5h3VsfPfBOSsiA/77QWhF6yGB2Xw8sx7lRdd5rS4E+MYhGuYO/RNr
 ARksacD7eZ55kuEHqKBOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CTjZStPrMNY=:57ZYKwg/odsTUlypqu6wlH
 I2pZEm5mgCYrGPnV4mY537AoCSg6MFQO2mUPFSEw7pchc9S3RT+oBExvic1nHPPRcoEW7RT7B
 rBOFL13oQDhBXeYbQzNok9I7q9Ni546LIkhUxN44haxTvdqsw7Brw+kLOlUOWEqKQb28Idl4P
 I8fzEk/LP5PpQmjcDVWa67+R+AuVjWM6owXt1OP42Do4FZh2wI3kq5+C/X5CT1laKugxHXBtB
 x+5x96vVAxkC5Zej7fDt62YEhN4Szmwj2cGuq8SfvwkHP0p9UIBHb5vO+1DkyYpzZyDExFfYY
 rBue9VM32i+MJPFWaAPKSY5RhUlSIY0Kjx4Jr4b0C3xoiH0OA4Qom9dE05HZ2iJwGz3iMH2KC
 WSnmoieUSot3qV9ojJV1uMIMg39vpqWZJ1UZbD48Cok6D0he8VxHci3XpJn+3G+/jDRwbCq2O
 lO6hTu6KEITtWE0cPZbzn5lDM7pufdM+1naIwdsf4J1JvLMy54LwkAib8Q+guJjZSwsdXj7tB
 Mv5bbIlVnUf3RpxbW9B7bwbO6li9EhLuBBoXXW4tlItBbOd76b/Bb5ReFfTpoLtUUvnAd6WVV
 iVGtLL/Nn+NwU6Au8IxQAKOpeaetUeWdu0nNdhGTEUXM075ZeGJ0GARLuLSURykiz8oAOY58R
 ngaq4DhiOCe0EXH9nsYsdx66rUp3KVdqdHenOyxvHfW7bAdZhRnQOITSKptv9MJOkfXynRUAh
 3YdNHpxRHvWMHFkNPJMpQ54LXNEKT0y+pjK7GGsM5jvtFLeZ2AebyqXK0TN0GVVhV/6SKiuhp
 6Zk2wf4e+8f2sjDIthbd0dQnvXoZqrs6wp00LZOfJEjcg77EOJ1EdrMBarPxVUMUEFwzcdfmr
 LYsRewT6wuiW4BNLkx9vj4hlIa2mwRqLoOOGIGErGcz3toHlL1Ne+pQCB4Q6TccfIILbVJCMO
 kcVsjZt1uvcmOJAlGoYChjkayAB8QHAwXSZhPclhgLVlDGGhoww7gkcnNzsC4UhZXfkuBAgII
 gHaE+IvbIZdtUjdgcsf58G/XDbqvkQLu7Jiss4MVyTuhqqmNMQ+4KoGq3435sk47waCOZXayE
 so3PyD1IgJfQOsQ0lpa5+iISf1FnaV6D2Qp0FGN5ayCNfilAltgD6loaJ6aVO+nuW5xW5VED2
 bxU7gmsDaT+jZ8rvQZPZXEOtW5c9AWWLPSerTQe82V6X6oKMejWM/CT+4XwCrH+JKOYvn+dHt
 2NTI6PnhqRtO+r/4X
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/5/13 =E4=B8=8B=E5=8D=889:51, David Sterba wrote:
> On Wed, May 13, 2020 at 02:49:11PM +0800, Qu Wenruo wrote:
>>>>  {
>>>>  	struct inode *inode =3D NULL;
>>>>  	struct btrfs_trans_handle *trans;
>>>> -	struct btrfs_root *root;
>>>> +	struct btrfs_root *root =3D fs_info->dreloc_root;
>>>
>>> So why haven't you added code in btrfs_get_fs_root to quickly return a
>>> refcounted root and instead reference it without incrementing the refc=
ount?
>>
>> This is exactly the same as how we handle fs_root.
>> And since the lifespan of data reloc root will be the same as the fs, I
>> don't think there is any need for it to be grabbed each time we need it=
.
>
> I'd vote for some consistency in the refcounting, ie. even if it's for
> the same life span as the filesystem, set the reference.
>
OK, I'll call grab and put in next version.

Thanks,
Qu
