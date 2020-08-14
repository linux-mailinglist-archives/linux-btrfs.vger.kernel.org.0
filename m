Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637E1244294
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 02:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHNAw2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 20:52:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:39997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgHNAw1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 20:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597366344;
        bh=b10x7P55PGFzHXQJ9KH7cpbI1piLR6Dk1SMuVf1/ZeQ=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=BeaKjZL2jS5iEcOiMFkv3bml+s9jDzD5MQL3SmK6YCTtWOzK8TdaxMI5tSZd7eo6w
         FT41O8JE9iMsPoteKjRg8Bx0CW2V6z7D+0Q8ZPPQyDA2AuBSfMl7rXtah+5qGdWEuP
         ggDtK9C8m8yEg8YQwsw+FCxmZAQyhV9ZSgPRKxuI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMobO-1kMosN1DCm-00IpPs; Fri, 14
 Aug 2020 02:52:23 +0200
Subject: Re: [PATCH v4 2/4] btrfs: extent-tree: Kill BUG_ON() in
 __btrfs_free_extent() and do better comment
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20200812060509.71590-1-wqu@suse.com>
 <20200812060509.71590-3-wqu@suse.com> <20200813141019.GI2026@twin.jikos.cz>
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
Message-ID: <bf3d96a8-f19c-1b0d-9171-c82f7a4d3d0f@gmx.com>
Date:   Fri, 14 Aug 2020 08:52:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813141019.GI2026@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o+dYScEEPeEgYfrxIy3Ro4bcrjeJ5K7SuOEOv0RDBXE3utC43Z+
 pX5ldSmqWq5F+VsvfvbeFKRCoIKY3EL/VX1iXVGaKbVXn1Au+biQT01Q5T6zKNXkm5EhDh4
 +WMnA4u9/pqIAnRt2CbJyGZs8nH3fMJe0Yvbuz16sK23dg/ZN9wSM2QKUqAGlYsWW9OAMWh
 /rqcYIjV7v4VIfqvFtAAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E2gle4s71XY=:okEw+poON8IZORLE61mlnJ
 JVJfuNdvS2mx8gmGlxLPHM13HOLzM7odzJedP0jEuKemOGQ5wt6uesza6LNN1wN0NP8IpyBrG
 AHL6zjbrhEBq/zT2IBDmJcGVqzajBq8jMG4zSgpM/ILDk9h2WA8GjQNaid2l0KHSzTtlQBurW
 N4QLYx4FoObtyFKdL2bkdEDprPDcG3RM6k0m1ZwVEWE5LuhrNhzMnTFO6tziz+eQZmwLP0S/E
 ZZ22TjUJz1cN6b4EP5tMU6zpub3wlMwEuQ70Ftnld+bmveCfY/4QxbigrLYEWpab/3GJkOqaJ
 T3aXwVmlilhxyjFOR8+o35+ptxD3TWMJYnrYneCgp9AAsoozlML769STCI9pgaZmRNvM86oIX
 lGYWGduEBiLZYNO5hmjoMhHyJPtZVmb/1k4muIUNoBsL36bkjY9Rl2sPh9V1mJp0ufnBQtWnA
 TdgsaLrmhfV6Eah1gxCPzvqegnMw1aFUmBphXvmgRekc3J/c1jVsH6brtDZIRc6koh86hlrkQ
 hIN39bKrL80SuM+373GF4xvebID1ZuWtjv7qT2oPjg73BKWKEMrz/kz42BzDn17UPG2n+Q5bd
 M6O1bEKXg9zMWHbfzayQ9BYUiZNYH3S4TVO5G2+A1Z4zj8Ri+eteL17mzbvFCLgKcLd1ci9vp
 WEbyJ4fmwWvP41SPdPx5bl11Uu9rQpCHgS5pX9ihoux6mKE09PJkqjOKa7pY3Zy2S/tPzXUmn
 LDLkYoXjhDOWbPDYMnUAtv3z4ES2LyMd8jnLqX1o3M10pcPrY4v5FEPKcic2pmUI92j2UMEmx
 mNIznSF17tmC54Uz0Veh7PnQHPvnb38p2c8Pf58ATSaqn4+xk/TJEu20MboRCq+4X9ULRYXhG
 ca2u5wyf4ec2nuJJj033GODykpsiF6JWPDU53W3e10eihO6kF3DMjqHG3I4qycYqZYUzb8ax+
 Pkmlsj3HY1Jj6Lio9sbcYP3J7abR+PNbjmwl0g+VZUuzQUgwZKfx2WTH3A76M0nOhNmwAIIQm
 SERc6hVVbb1h6sYM6ll/080x3bNwwSBG+THr2BI4D7rwZZsc8eC5Ly1SqT4oFsJXSXCpfcGub
 wjl9+PK/nE49bRjViaIpAc3tDdkBpqpBVwvBktHcqMo2OcoAeHa7K5lectZ0lxvEhyD3JxrRf
 t8GlMPc+yIvn83aIlGggLxRBO+YAJKA6yBLz779R6bPEBKBPn5rN87Fqp8Hzi3tLfP2Q2ic/+
 6+7Y3Q1HygutySzr/qFXI1nAjDnQ/OKzlKGsLzA==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/13 =E4=B8=8B=E5=8D=8810:10, David Sterba wrote:
> On Wed, Aug 12, 2020 at 02:05:07PM +0800, Qu Wenruo wrote:
>> @@ -2987,13 +3049,20 @@ static int __btrfs_free_extent(struct btrfs_tra=
ns_handle *trans,
>>  				found_extent =3D 1;
>>  				break;
>>  			}
>> +
>> +			/* Quick path didn't find the EXTEMT/METADATA_ITEM */
>>  			if (path->slots[0] - extent_slot > 5)
>>  				break;
>>  			extent_slot--;
>>  		}
>>
>>  		if (!found_extent) {
>> -			BUG_ON(iref);
>> +			if (unlikely(iref)) {
>> +				btrfs_crit(info,
>> +"invalid iref, no EXTENT/METADATA_ITEM found but has inline extent ref=
");
>> +				goto err_dump_abort;
>
> This is not calling transaction abort at the place where it happens,
> here and several other places too.

Did you mean, we want the btrfs_abort_transaction() call not merged
under one tag, so that we can get the kernel warning with the line number?

If so, that's indeed the case, we lose the exact line number.

But we still have the unique error message to locate the problem without
much hassle (it's less obvious than the line number thought).

Thus to me, we don't lose much debug info anyway.

>
>> @@ -3164,6 +3267,21 @@ static int __btrfs_free_extent(struct btrfs_tran=
s_handle *trans,
>>  out:
>>  	btrfs_free_path(path);
>>  	return ret;
>> +err_dump_abort:
>> +	/*
>> +	 * Leaf dump can take up a lot of dmesg buffer since default nodesize
>> +	 * is already 16K.
>> +	 * So we only do full leaf dump for debug build.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_BTRFS_DEBUG)) {
>> +		btrfs_crit(info, "path->slots[0]=3D%d extent_slot=3D%d",
>> +			   path->slots[0], extent_slot);
>> +		btrfs_print_leaf(path->nodes[0]);
>
> Preceded by a potentially long-running action, so this will delay the
> acutal abort.

That's why it's only for CONFIG_BTRFS_DEBUG.

And for debug kernel, that info would definitely be more helpful for us
to locate the problem, right?

Thanks,
Qu

>
>> +	}
>> +
>> +	btrfs_abort_transaction(trans, -EUCLEAN);
>> +	btrfs_free_path(path);
>> +	return -EUCLEAN;
>>  }
