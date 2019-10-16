Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7CD8B23
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 10:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbfJPIgi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 04:36:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:59435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfJPIgi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 04:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571214987;
        bh=mygg0stQz1K7mlrp/PCPeH0vrabpF1uoc+Ew1cGlTms=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LI6wdJzuIl2yXD/5VrZHV2IiC0/IguwLeq0ZM+7YZewt8y6l7eXTekMImviyhgi4j
         Uy4rvhFEx3qAU0X83m4eydCidqi2peGqjIFWX3LgJqblEovdiadb/NPyKllzmaa5vR
         BTASeKuP20cnzSii7Yg8Wi8cUe0YfRqEyWj0+lfc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7zBR-1hyC2T45Kd-01517l; Wed, 16
 Oct 2019 10:36:27 +0200
Subject: Re: kernel 5.2 read time tree block corruption
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        =?UTF-8?Q?Jos=c3=a9_Luis?= <parajoseluis@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CADTa+SqDLtmmjnJ5gz-3jDxi1NGNAu=cyo0kFXSZfnu6QE_Fdw@mail.gmail.com>
 <66e27fee-7f64-6466-866d-42464fca130f@gmx.com>
 <a6d7a4c6-4295-e081-1bfc-74e9d13fd22d@gmx.com>
 <CADTa+SrurdZf5+T+QGNyLc7gKLuTFYsto+L4Q+30y-uQj+jutg@mail.gmail.com>
 <3e7acddf-6503-7746-db4b-a116b7f89c4d@gmx.com>
 <CADTa+SoDEcHvpJj6-QMHUubFcKACiKLQ6izr=uER-hYtqVg20g@mail.gmail.com>
 <0cae0d30-db18-37cc-562f-100c862099e3@gmx.com>
 <ab485a5a-04b4-a117-9b94-902f7dbcf8d4@suse.com>
 <375ce380-7b7d-03e5-212a-197d8cc2d5fc@gmx.com>
 <20191016131226.465eb506@natsu>
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
Message-ID: <09661380-b479-748c-8347-1449691e2f7a@gmx.com>
Date:   Wed, 16 Oct 2019 16:36:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016131226.465eb506@natsu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DTUlYQuq/Z4X5hXVCHlfdCBxh/K1JdMoHf9fFRnBYVe21MpJtu4
 jAuqQe9hhbuSu751gOf3NBxP2xNAYipE5Dj7vJP6RUN56LKAs1Y1J2KymDCG+vf4Tke5k3Q
 kfeOr8g706kLaWwI8ZTfsgA4txvHwFNMaKZjBuRcmQKDVxrPhlRreySTzmnkCbqfVO76tIh
 OsFyH1POgw/lItBCldNBg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FzCYdLrSaDQ=:yEOD2wZhuNbvcuUFHuIwM8
 uCm6P2PSgtiTrhxI8NLyCcf2WLohcJ/n6TMPDIFDfmiojOdWtlaqVJSE7l64EGeCIKeSy/0xD
 bLFuLU/RSZjh6E/P6DLeAhRz66OlT7NhiIdWd3G4Qvrsd3KBdFSLIl93GQM3PiRU3s2vDyZ+T
 8WyW/AUiM837l7FzncqjO8USzwSuisH65/F3Im1E53xZkofpUL2Yn0UdwHFCQpuXqqyINjjnG
 W5v6GdU/kqeoFbaowFPlQ0A31r3X3tYAvOX2g0AKtgJrWmf6zUbULrhymiodk7JBeCWoYdAlT
 1xZ7n9S9BlsdjOSmpeWl8F1pM5hS/5iMQeziTNX97/6aJBDLISU6gk3Cb0Ka5pKs1Nbr0Rczz
 qO66Wp+0FmR8iLnsyDizdF1ie0I6N8IyBKQ3MrwBAUwdZ/ZKnfS3V+PgKUEVXTB+WPhbD2qOe
 M4QWIl0/U8nda32Zg4pibDLYphQ0vuAVJQsLG/kQM28eZsFEX6l3jzw4nF5zS1/YH0vDgAjXn
 HEroovdzwPZ0GC7Z/Vlhn4K0Y1z8Zua8VUHTiMKyJt4NP/tvc3Or27fdA4iJm0tpol7QtP2/t
 acOlHYwXSiVk2+0jDE4E/YFRQ2Cjv+NSmBICfItR8Jw9HYRXuTNprN+iDfRaNrcHunYRPlmI5
 /QSPbK6HJ64nRjOjSlHk+nbCvxP5hBDCJdsgY6HJk2AClONBOvNVoBhyQ7Bq9Q4bq4gS0E9Y1
 3wS2a8VN92mH56yZ7Z6gwISWNhvfeJJUtq/+QrrK2t44v4Ep0NrduWTyXYTRTH0ko6t+mLe5D
 0YLGR3t0qNmC3ssaj4GDw5slTGovdi8qApOH9KRzN/eR2c4rayWBYbUf8U1elCC4RK+mW+8Sn
 kMpzyA0mn24yztBOaPGuMVoqmK3l+ODrhGwik2XO3OJuYGCEMxD9yzdn1ydLl0pIIuKEWgf0s
 dbn5Mf4jvnLPDTx3gTypt2fdMeEDWYupkfkKv7qSe408nCb7OH1vvsaCOVgP9PDj0TgZZXIs/
 4/bsBWRxQ3AUa1scgYZfp9pyg8KZYJxciTU7HtOEG4cyr098SJpzCcqoNRKptooRHndWFmhG5
 V+xkxQcYydssplvHy+TzyUUyTdL3rA/5oCtLH2byMkcCHhHaQgz4GChk61Xu9w3tQyqkXH5w9
 xIRiKFQJ7b1qUbtYRuSydy/b4hippwMAan8mB3iDNkMU9N5Zn9dJyCoyGnxqnOPwhzNYuLD4k
 Zrw/tyx25XwDhkqXosnuHSza5OjTFU7F8kjBSnvg8QjE6bSrXPf1pcknLUWA=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/16 =E4=B8=8B=E5=8D=884:12, Roman Mamedov wrote:
> On Wed, 16 Oct 2019 15:45:54 +0800
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>> dirty fixes (a special branch for the user
>> to do, never intended to upstream).
>
> Still it would be nice to get a btrfs check mode which would include try=
ing
> destructive actions, as in accepting the loss of some part of user data
> (outright delete corrupt blocks, etc), just to restore the filesystem it=
self to
> a fully correct and mountable state.

It's already there.

The problem is, that mode only works for fs tree, and it can only handle
cases like full corrupted (not transid, but the child node/leaf can't be
read out completely).


>
> Sometimes there are cases when it is inconvenient to recreate the entire=
 FS
> (remember seeing 40TB mentioned recently), just to fix a few "parent tra=
nsid
> failed", not even many transactions apart.

That transid problem is the biggest and the most complext problem.
Transid problem can lead to futher corruption, like a tree block is
completely incorrect in the context of parent tree.
E.g. a csum tree block points to a fs tree block.

So we can't easily treat transid by easily ignore them.

But your idea is pretty god, maybe we should tread transid error as bad
csum, and completely ignore the child, do the regular corrupted
leaf/node repair.

Thanks,
Qu

> And the data itself is often backed
> up, so restoring only the missing part from the backup would be much eas=
ier.
>
