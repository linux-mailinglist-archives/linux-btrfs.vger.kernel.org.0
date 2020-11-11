Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968E22AE4A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 01:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbgKKAIQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Nov 2020 19:08:16 -0500
Received: from mout.gmx.net ([212.227.17.20]:44291 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726706AbgKKAIQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Nov 2020 19:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605053292;
        bh=eVjIGp51COUCKaMsXDh9Ocy558xW/7CQjEW4TIIKVLU=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=T7MQu/GwrAbLBEcsubg+ux+VvmLDhvUDWXvsokctYP2VgiPS6v5OYXRxEL/gaW2qe
         PCu4izauZD6V0g8VGpS23ys+E4bWq2qU6NZZMc/ira5jc1TcGRJRl+nkJnTeeyXtjT
         CgAOwao8ua7skj3HukWPFvN/MTq7+aljxjfVFuIM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MAfYm-1kRb3D2gMy-00B0As; Wed, 11
 Nov 2020 01:08:12 +0100
Subject: Re: [PATCH 11/32] btrfs: disk-io: make csum_tree_block() handle
 sectorsize smaller than page size
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-12-wqu@suse.com> <20201106185836.GS6756@twin.jikos.cz>
 <746bb53e-8a71-67a0-6d93-7c6e126670ea@gmx.com>
 <20201110143339.GH6756@twin.jikos.cz>
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
Message-ID: <3f8c7173-94b6-bd59-4b02-4a9b5c0ce804@gmx.com>
Date:   Wed, 11 Nov 2020 08:08:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201110143339.GH6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fHrTI1+bKyIYgwNuPe66BHJvQz5kEDGy90eMNxpe5MMVRfSqOKA
 peviuFSbuLOgFokZlHpMxnYOiF4LSeL7CaxsCbNr2fixwNRnO2KuZT1X6ACmNPAUtXO9Muu
 WGCAKYcZFsJ7HyHHqsakppsw1lAb0CAHnKJU4z65Ml0FtNv4MGfwIMDx3PujP8so0PoVZg+
 TGm9nHSnnC1UFJA+JDrbg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:88BK0fCM32g=:EXLVKIiLQFg8PkwU3GzwPQ
 hz4qHotWWfHKmYxrjJSmLyeG1/RKuHcTXzezvmW/7GYXQgB+mrAxJCyerMw0Ba8FMhVFCzGnH
 oNc0Z9wqPWrsHaYRAOy8DV9sgM6OVC3mJrZvhopGSuRrxsXULEdvWEHxfD9i7movUOuhVVDYM
 txVtjD0nG9pYlClxl6g/CudiP8ekpUWWvJAtbXZqQGQX6jKk8b3/R+wMg1zYtVv3/ipT40WST
 shU/91tXDFX1ldJZQ8+75WumwyriZzE7AjpJCRuchugrBv6EzDQPVmh3IsMpbr/kXZMpF8doH
 GkTIKb88W7zcghxEkjIJnKaUNPl4eOEQZ64+wgmDqu4FMMeBkbRtakrcC9piKk3672ZtTqVZG
 GJaCGBVzdtsEV8KGxnrx37nqWFcxPlJWiD5ZO0pNg7AGNbfpooEH0qMNR9VT10BL3hl9V4TK1
 LQzkJ2w4WoQi3XrzY3u3W//J9bWO8yVaxu1FsR3/i2ACNScRzs2FKqa5CNHO3tzMSiZpZkQZy
 mfxuiSCKHfNzSZTaDtfixbl9XOn2ATU6siL1UrIWFPOy6q5kVFFpzsA4IBOaoPaCT92sfVLsR
 QLo+pKNIGzZa+nrnWGVsgIm/uVX0DkYkZ/EXVLp7pcg5+Agey66Uys1TKsxGqlKoB94FN3vAE
 g7rWoj4i5ScLCD62jopY1ktYN08k0alhOoY8wEiDKQxRdhSa0jAlKWR1Hi4Rw591v1S9MSz61
 uvqcuFKquyfV4ioiDQCIHdlRb7x2Me3glWJg7Lw6J+HPibA+Wb7qB57TjFW7cDyXeYPykxgrs
 dNiH+Vp3xCQ6JRNomGX6HLBZSfSAu6/eoDrmX1zjqCKTiixYRVZp/1qgvijzHWG2QKprD89Do
 KuAkSNLXS+tLEpHntsLA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/10 =E4=B8=8B=E5=8D=8810:33, David Sterba wrote:
> On Sat, Nov 07, 2020 at 08:04:44AM +0800, Qu Wenruo wrote:
>>>> --- a/fs/btrfs/disk-io.c
>>>> +++ b/fs/btrfs/disk-io.c
>>>> @@ -211,16 +211,16 @@ void btrfs_set_buffer_lockdep_class(u64 objecti=
d, struct extent_buffer *eb,
>>>>  static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>>>>  {
>>>>  	struct btrfs_fs_info *fs_info =3D buf->fs_info;
>>>> -	const int num_pages =3D fs_info->nodesize >> PAGE_SHIFT;
>>>> +	const int num_pages =3D DIV_ROUND_UP(fs_info->nodesize, PAGE_SIZE);
>>>
>>> No, this is not necessary and the previous way of counting pages shoul=
d
>>> stay as it's clear what is calculated. The rounding side effects make =
it
>>> too subtle.  If sectorsize < page size, then num_pages is 0 but checks=
um
>>> of the first page or it's part is done unconditionally.
>>
>> You mean keep num_pages to be 0, since pages[0] will also be checksumed
>> unconditionally?
>>
>> This doesn't sound sane. It's too tricky and hammer the readability.
>
> I don't find it tricky,
>
> - num_pages =3D fs_info->nodesize >> PAGE_SHIFT
> - checksum relevant part of the first page unconditionally
> - for (i =3D 1; i < num_pages) this obviously skips the first page
>   so it's either 0 or 1 in num_pages
>
> So this does not break the top-down reading flow.
>

All right, I would keep the num_pages calculation.

Thanks,
Qu
