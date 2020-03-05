Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CA0179CEA
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 01:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389432AbgCEAkO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 19:40:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:41189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389346AbgCEAkN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 19:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583368806;
        bh=7JXRW6RLhCVnSoFMM/HukmvLu5Oe6H9dzB3m9AV+3AE=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=ZOd0YIW/SFZkRcpHCD3VrPguuQWtI76PKE0UqsVcEyoP2yqXbAVcNT9ty5GpCKbee
         OyEcLIPR8lJ4PVVqtdxaxqfqBq40Bd8E4HIzBaiNtKYXqNhzQn4Pranh2V0jNrflII
         DDIcslbnPO8yfARQlBhNm6v0+/jz/ykD/VEuLacM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MysRu-1jWHmZ1tzu-00vtJp; Thu, 05
 Mar 2020 01:40:06 +0100
Subject: Re: [PATCH v2 08/10] btrfs: relocation: Remove the open-coded goto
 loop for breadth-first search
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200302094553.58827-1-wqu@suse.com>
 <20200302094553.58827-9-wqu@suse.com>
 <30ec7909-9ced-fb21-cf8e-1fa0c970d9a0@suse.com>
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
Message-ID: <e76f9a62-6c7c-b1fc-e1fe-c985ff395b9d@gmx.com>
Date:   Thu, 5 Mar 2020 08:40:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <30ec7909-9ced-fb21-cf8e-1fa0c970d9a0@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DPHQIJFXbr1B2o33OCvl5ahlaKjWqdxlp9Zq2or6WOT7LGJ/99d
 lLLfecgcFUm8NMxp7VrEny1eQlZDc20REFuQAc/ny02OWkGDVdOLLYiGpkQlorf3GLKmQtE
 oPMXD7fX22xqkrf8cKDaPrNCHOAAf506b8Pyrx2lRGv8VLJLdW8uKld/3t0vhK9h7kJl2w+
 VsvqCJn5qxPw/oIEQ+7lA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:a9OxV5v1Ng8=:SnjTziG70F4iDAogZZnfwv
 qDiNNv0w9QTYdgvCSNyKGVCuoI5yNg3/qN+CJmwc+/lV7agpPqdbWFUyeypQc9uiKwOq9FlCj
 wCuQXcOT5BZzStoxaexaR2ENlBHdMqLJm17oEl5j9fow0AnSSvueQHBVMZWuP4Xn77PVZ4iGi
 1Hv/EYC/n8XkLGa8CM0VV83JHWO5W9RPttjjkfoWxKcCzbJfbLu4UI7izrBW3Qj45XWA55eZv
 3a+uChCeW4EcM7YtiKyHi/c/yMEfJzC8q/cF9XULhhCJA0juealDFYPEqM/3UsLNA0bg0S7jF
 mQrIYrYjDk2jy7RZKMiy+UaDpXsrfzueTWSEyrkElyD+D5V5105kB5XbHdGYqH6l2W90HMGd3
 5/uEZZcPj/feLVAOcezkeOMEfm3mrHOhb66X344BkIziRkDoCGC/eCcQhrYKYkvYikaVf+qvv
 7d5ol/AOizzE1dx8ERgQWzd4JAhu3hFuOMvYnwx5lgqsbE8kPOLf713riyS+/li8mkUOt7Q2c
 TfwtAQIxqz86E9jhGvx+0uyRHMFz0SbZx7RhBtpHeV3+o5uW0SdbWcMOFB2exaILT1mMWgqIr
 +1UFyCulgC21HsfyosFQzzaxadokMiDu7po1mKrXpca5caiQfzTEki1+dQbdvAiCRsin2VqE2
 uRTCMnm3nKslxda5yob1FJ/AV8dtXY4DjsDhxiVseLxEn09TOaGW4VifdXsEs67vOfch4qVF9
 gpg1s3dM75ksZhr8cMhtO7uSUSJu+Oauq//G8+pwKdh4EbVMYSC80WhGLOG9QtvEykkluIO0F
 RY9h+Kq2apXvPYlfGZf/m9LSAhPcbPFI8J2TW19n/Wcv7GzPXyzIbOw3rNwYcmu7LbzpKZkSP
 JoOIzJzlrgDt+6/vhfNaa0a3pubYx8WbcgeKaPYDi1pSk/m1ltONZ87iY3vCugligiEP3AkQn
 zn5Ij8hFaxpm2N3ffJhiWXDIE8KIlI9CFQgxG3K/qPoVKHE0/O76D3A7KQiEki6aoNc2w7yeR
 4rfFnH/wK7KsX5BQMlFKcYRTYHfy5iq5XNYpmzTOj7dxfvz66GNnBj5tdtKLlJtqE+GuO9aGT
 32hDgdxyVOIZr/Ki7mqCD2cGWBdrf3FoaWoA/GlyCogP6yfg+z8vKVIsjWOTPpbNBY9R4dj5t
 e4mHJGA7xEQvhTenSLdruknbNpxQaILE4BnRiF5soxNk3NmPAY14j6QxxfjCagQG5yqZ7bvEQ
 1FruyjQK0oqTesq2d
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/3/4 =E4=B8=8B=E5=8D=8810:24, Nikolay Borisov wrote:
>
[...]
>> +	int err =3D 0;
>> +
>> +	iter =3D btrfs_backref_iter_alloc(rc->extent_root->fs_info, GFP_NOFS)=
;
>> +	if (!iter)
>> +		return ERR_PTR(-ENOMEM);
>
> This iterator can be made private to handle_one_tree_block as I don't se=
e it being used outside of that function.

It's kinda a performance optimization.

Instead of allocating memory for each loop, we allocate the memory just
once, and reuse it until the whole backref map for the bytenr is built.
>
>> +	path =3D btrfs_alloc_path();
>> +	if (!path) {
>> +		err =3D -ENOMEM;
>> +		goto out;
>> +	}
>
> Same thing with this path. Overall this will reduce the argument to hand=
le_one_tree_block by 2.

Same performance optimization here.

>
>> +	path->reada =3D READA_FORWARD;
>> +
>> +	node =3D alloc_backref_node(cache, bytenr, level);
>> +	if (!node) {
>> +		err =3D -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	node->lowest =3D 1;
>> +	cur =3D node;
>> +
>> +	/* Breadth-first search to build backref cache */
>> +	while (1) {
>> +		ret =3D handle_one_tree_block(rc, &useless, &list, path, iter,
>> +					    node_key, cur);
>> +		if (ret < 0) {
>> +			err =3D ret;
>> +			goto out;
>> +		}
>> +		/* the pending list isn't empty, take the first block to process */
>> +		if (!list_empty(&list)) {
>> +			edge =3D list_entry(list.next, struct backref_edge, list[UPPER]);
>
> Use list_first_entry_or_null or it would become:
>
> edge =3D list_first_entry_or_null();
> if (edge) {
> list_del_init(&edge->list[UPPER]);
> cur =3D edge->node[UPPER]
> } else {
> breakl
> }

That's an interesting wrapper. Would go that way.

>
> or simply if (!edge)
> break;
>
> Also this loop can be rewritten as a do {} while() and it will look:

Yep, but I'm not sure if such do {} while() loop is preferred.
IIRC there are some docs saying to avoid such loop?

If there is no such restriction, I would be pretty happy to go that way.

Thanks,
Qu

>
>         /* Breadth-first search to build backref cache */
>         do {
>                 ret =3D handle_one_tree_block(rc, &useless, &list, path,=
 iter,
>                                             node_key, cur);
>                 if (ret < 0) {
>                         err =3D ret;
>                         goto out;
>                 }
>                 edge =3D list_first_entry_or_null(&list, struct backref_=
edge,
>                                                 list[UPPER]);
>                 /* the pending list isn't empty, take the first block to=
 process */
>                 if (edge) {
>                         list_del_init(&edge->list[UPPER]);
>                         cur =3D edge->node[UPPER];
>                 }
>         } while (edge)
>
> IMO this is shorter than the original version and it's very expicit abou=
t it's terminating conditions:
> a). handle_one_tree_block returns an error
> b) list becomes empty.
>
> Alternatively list being empty is really a proxy for "is cur a valid ino=
de". We know it's always
> valid on the first iteration since it's passed form the caller, subseque=
nt iterations assign cur
> to edge->node[UPPER] so it could even be
>
> while(cur) {}
>
> In my opinion reducing while(1) loops where it makes sense (as in this c=
ase) is preferable.
>
> NB: I've only compile-tested it.
>
>> +			list_del_init(&edge->list[UPPER]);
>> +			cur =3D edge->node[UPPER];
>> +		} else {
>> +			break;
>> +		}
>>  	}
>>
>>  	/*
>>
