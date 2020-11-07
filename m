Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C661B2AA1A3
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Nov 2020 01:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgKGAEx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 19:04:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:47105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbgKGAEw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 19:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604707489;
        bh=V2B6mI5g8IjsFd8H7lZrvXibxbc1HIEZzWA49xF2oOc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fvNGE2HbBVd0nWfcuwkNCMpkop4u3S1zaDAIbaZNtAHT71TGGA2bsuT0qYTEsbpxc
         rV9Yo9a1wAWz709wyeixl+NUKBSbC2l4Sow9M6qhGdnsUuIZ7A1Hrhd+v/zUA9n7OB
         pdJtF9A2raIhLLK0ypvkTXGvov4er/N1wZt70OWI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MkHMZ-1jux8z3TU9-00kk0k; Sat, 07
 Nov 2020 01:04:49 +0100
Subject: Re: [PATCH 11/32] btrfs: disk-io: make csum_tree_block() handle
 sectorsize smaller than page size
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-12-wqu@suse.com> <20201106185836.GS6756@twin.jikos.cz>
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
Message-ID: <746bb53e-8a71-67a0-6d93-7c6e126670ea@gmx.com>
Date:   Sat, 7 Nov 2020 08:04:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106185836.GS6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NOLsE4s317wXT1utyHsdEP1WdQELfFtadG9waZp+gbbOcAC/xVn
 jG4b10CcVHAmScrIiVtyDa4de2LZzd7P0WEvOsRQ2fMFGFyF6A9zWbamVufQJzX/a98qm3q
 pjqHIMJl8QzLZYhjms8CWU0bKCZbVTAMNAuySg0Alg/HzMrxZ56WkDe+sTC34U2q+SGpkGt
 LurdloehyksXGWSxYWIfQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cfduYm6tuxg=:IAwzGUx9tdxF07BRisLsGx
 oCDBfuAo0zCQ8d82xfQWw2eCWcAOuzGHMLixamuwnur1owq39Y2kty7dSSXELsoyyyxrsncQC
 B4RLxWTDWb758Q+TLyZ9Dr3S4JuJiMc6LICkA4ROeWXS6hPW5ad3pItmV5ketkuVTx3kedsDv
 qyLdBJsQ69XaKslsRcudtmqmTa9ROFtotz0u7u66G7et9Fr87WPHJafNi4mDPQso5twmvxrpj
 /ysnVPApJXAD9LY4jf9V/K2pdv8Ej7af15sjR94ZRAi0KtIoLTyPl0LV53Gt1rR53cSnY/xow
 ROJFq4Cmo5gbfberch5G73smdeiplIu4sQ6UygL0ng7ksNjq99MiWKdb+ivCLzw+tKleU3512
 JPKTcQ+Eer8tzCX2mr0EQKnVNaAIMkaLzTOsjVjaoMN4bIuYqxhvGuMBRs0YJw77DIFGD0pA5
 hj7Q8es+28hPK91kpzGQA+zLXDSKx+YVQAteZzP+iVe4M+5PsUTMvZQy7A0T+ScBQ6tMxyqW4
 yw6iObGfZ3/aobVpHZzgKzQkDmELaA8yCfdkCdeI0ce/Y8rr+ANsxN327RW3gICdOUzuSiAX+
 B2cXWDhkBakhr59wRhxCaeMl6RpyhJvDLDaSbirtxttb+ABHZri5kU2oJptQ9/GU5gsNFeDnh
 T0m/zLlvXalZIy6EQBXA+10UihGXF237AfLBL1pQdVKpJ9flHrxyuTw1aoHJCGAaC0+0MtFWl
 qPEpl9ivttSFxxKHZ6c0GNVak8hGJHZOMTvW6IUEqr7ozdZI014g7XvU6arj+huwBc1A/8TCR
 7IMLOaMeyYGYbANxAMR8EImwqZLr+Ev5kGTPnzI+TkkkdRFqtywff+cZbOLwg5YyLqdU/whxt
 eVSNt2K29ZdiaCgNhelg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/7 =E4=B8=8A=E5=8D=882:58, David Sterba wrote:
> On Tue, Nov 03, 2020 at 09:30:47PM +0800, Qu Wenruo wrote:
>> For subpage size support, we only need to handle the first page.
>>
>> To make the code work for both cases, we modify the following behaviors=
:
>>
>> - num_pages calcuation
>>   Instead of "nodesize >> PAGE_SHIFT", we go
>>   "DIV_ROUND_UP(nodesize, PAGE_SIZE)", this ensures we get at least one
>>   page for subpage size support, while still get the same result for
>>   regular page size.
>>
>> - The length for the first run
>>   Instead of PAGE_SIZE - BTRFS_CSUM_SIZE, we go min(PAGE_SIZE, nodesize=
)
>>   - BTRFS_CSUM_SIZE.
>>   This allows us to handle both cases well.
>>
>> - The start location of the first run
>>   Instead of always use BTRFS_CSUM_SIZE as csum start position, add
>>   offset_in_page(eb->start) to get proper offset for both cases.
>>
>> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>> ---
>>  fs/btrfs/disk-io.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 1b527b2d16d8..9a72cb5ef31e 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -211,16 +211,16 @@ void btrfs_set_buffer_lockdep_class(u64 objectid,=
 struct extent_buffer *eb,
>>  static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>>  {
>>  	struct btrfs_fs_info *fs_info =3D buf->fs_info;
>> -	const int num_pages =3D fs_info->nodesize >> PAGE_SHIFT;
>> +	const int num_pages =3D DIV_ROUND_UP(fs_info->nodesize, PAGE_SIZE);
>
> No, this is not necessary and the previous way of counting pages should
> stay as it's clear what is calculated. The rounding side effects make it
> too subtle.  If sectorsize < page size, then num_pages is 0 but checksum
> of the first page or it's part is done unconditionally.

You mean keep num_pages to be 0, since pages[0] will also be checksumed
unconditionally?

This doesn't sound sane. It's too tricky and hammer the readability.

Thanks,
Qu
>
>>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>>  	char *kaddr;
>>  	int i;
>>
>>  	shash->tfm =3D fs_info->csum_shash;
>>  	crypto_shash_init(shash);
>> -	kaddr =3D page_address(buf->pages[0]);
>> +	kaddr =3D page_address(buf->pages[0]) + offset_in_page(buf->start);
>>  	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
>> -			    PAGE_SIZE - BTRFS_CSUM_SIZE);
>> +		min_t(u32, PAGE_SIZE, fs_info->nodesize) - BTRFS_CSUM_SIZE);
>
> For clarity this should be calculated in a temporary variable.
>
> As this checksumming loop is also in scrub, this needs to be done right
> before the unreadable coding pattern spreads.
>
> Also note that the subject talks about sectorsize while it is about
> metadata blocks that use nodesize.
>
