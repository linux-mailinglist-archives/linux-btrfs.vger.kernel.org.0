Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732632A7CE5
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 12:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgKELZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 06:25:13 -0500
Received: from mout.gmx.net ([212.227.17.21]:33493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729992AbgKELZM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 06:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604575510;
        bh=jBWC+sAF9V/HX4qajj6UWJBNBdWUM258TC/08ndMCYA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=efsqJ4QLPvDinALhjituvXuuJxWaoeUqLyXBoQUnNfjC8ghCwuMxwbCha7jtBLI8y
         ghg/KqNO4k267MMLhkS4LQ7zLJA7y8/6kJhoNzeqJ+UF963ua5Y4tYB3qkWXX/I92B
         fx5X14aGQNe2SWBRE8a+LAaAihR2z5EckLubvRP0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIwz4-1ktpEd159G-00KQ4u; Thu, 05
 Nov 2020 12:25:09 +0100
Subject: Re: [PATCH 02/32] btrfs: extent_io: integrate page status update into
 endio_readpage_release_extent()
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-3-wqu@suse.com>
 <17f71e81-6cb4-d37e-2915-1f5e0fb2ab59@suse.com>
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
Message-ID: <9752fdc2-3654-6b40-815c-84199ff31249@gmx.com>
Date:   Thu, 5 Nov 2020 19:25:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <17f71e81-6cb4-d37e-2915-1f5e0fb2ab59@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dMcARKJJJfRGtk6sRiq8W7qsQtq8YGdeFkhAE3EVrbgo4o5KZnR
 oKUQ0xVexN7q42lbRERE2Nanq6S8a7XKuHJAi7QPFulnXAr6IlJHPW1WnSf25AB7jqAokIi
 zfdYZJQEF4HmUBS24ctTAb+DCLrCGA9Awp/5q9bVU6We7M6tGqbpM+vi2w0Z61tgYZ1LZTd
 Kj41givZFbbfhar2lOgRg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZUYdeYslUCQ=:ZcbL7Jd6z1sqVNtg53lKUm
 uqsDKY4Gc+7KGVjHk5JzBUpHuWMTwffO+QGi5Dnx9r2NIHpHPQF+s6zKm2q1cHbTdGuSBfAVs
 if9ju9ALo2kpQBqeEtsRKhB4tg3lfiNOXDbi6bl99LLsvkYrr/GZzJ+V/djXOCWWJvzWXfRM3
 agBbLyLauKtWdxHYPLk3k+bluTEpe8SxEiD3b9vRZ8Mv4CvDmcJOPHz0v0K8atWh1g2HBk2AB
 hO9LMlUQ5ucgZyfdsk6yyKxtDof6DOweSXwDwY9XG0f+U4/qufShXNfGGEqTjAsTviG6G2j+5
 lciDFYa1NmuyGQjiWoCGlAlbeBZHUVtY9TXqAY5jA8OMqaOnWYZOJHAkh3qLfNPnigJSvUH1E
 zVYAERyFh4ckCpf0M8eUmvb89naUdn2wex9FPMYKYmBSB08JCZjJfD45uBmR3sBG5QI7b4Nm5
 YlKsyYp7fuypd02Cn5Ihn+jvx6ZIEs3/yDDuzRnuPX34af3GJtBNp+pHcC7F5I80Az5rx6IdN
 jiQh9/llN37Mnhz8OdjNBAFmMNxcc+C314y74MF1H4GT7nrj4o4PAYCA9R05IqCYCxV7t8ZXr
 V1gLQOraom1P0DKb8X42na3n+VBcRVTivaAFE7lYMj512u5s35UrOrxpotV8Cok6/szKtiRDv
 j2v1PbretG8qo194cK6h86b88krBexP0uyFNsLld79Dg1npkhGupAPrGpxPwgqXQjq/9YImt5
 zs/z8U9HzinyI/qPf1de3Smzm7ug8PdiDqU5ivOpnO82mD+NHUK899VeUfu2iDSRcldVHBmYe
 sVT4PUG6Seqo+5hMk6Lf8tTjU9ZoEYdfdXKguB+HdIznrIeZJnftmPyHMHBzj1UAO7cMpjRif
 JSfUqYHLeKawzcIrEWEw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/5 =E4=B8=8B=E5=8D=886:35, Nikolay Borisov wrote:
>
>
> On 3.11.20 =D0=B3. 15:30 =D1=87., Qu Wenruo wrote:
>> In end_bio_extent_readpage(), we set page uptodate or error according t=
o
>> the bio status.  However that assumes all submitted reads are in page
>> size.
>>
>> To support case like subpage read, we should only set the whole page
>> uptodate if all data in the page have been read from disk.
>>
>> This patch will integrate the page status update into
>> endio_readpage_release_extent() for end_bio_extent_readpage().
>>
>> Now in endio_readpage_release_extent() we will set the page uptodate if=
:
>>
>> - start/end range covers the full page
>>   This is the existing behavior already.
>>
>> - the whole page range is already uptodate
>>   This adds the support for subpage read.
>>
>> And for the error path, we always clear the page uptodate and set the
>> page error.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> ---
>>  fs/btrfs/extent_io.c | 38 ++++++++++++++++++++++++++++----------
>>  1 file changed, 28 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 58dc55e1429d..228bf0c5f7a0 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2779,13 +2779,35 @@ static void end_bio_extent_writepage(struct bio=
 *bio)
>>  	bio_put(bio);
>>  }
>>
>> -static void endio_readpage_release_extent(struct extent_io_tree *tree,=
 u64 start,
>> -					  u64 end, int uptodate)
>> +static void endio_readpage_release_extent(struct extent_io_tree *tree,
>> +		struct page *page, u64 start, u64 end, int uptodate)
>>  {
>>  	struct extent_state *cached =3D NULL;
>>
>> -	if (uptodate && tree->track_uptodate)
>> -		set_extent_uptodate(tree, start, end, &cached, GFP_ATOMIC);
>> +	if (uptodate) {
>> +		u64 page_start =3D page_offset(page);
>> +		u64 page_end =3D page_offset(page) + PAGE_SIZE - 1;
>> +
>> +		if (tree->track_uptodate) {
>> +			/*
>> +			 * The tree has EXTENT_UPTODATE bit tracking, update
>> +			 * extent io tree, and use it to update the page if
>> +			 * needed.
>> +			 */
>> +			set_extent_uptodate(tree, start, end, &cached, GFP_NOFS);
>> +			check_page_uptodate(tree, page);
>> +		} else if (start <=3D page_start && end >=3D page_end) {
>> +			/* We have covered the full page, set it uptodate */
>> +			SetPageUptodate(page);
>> +		}
>> +	} else if (!uptodate){
>> +		if (tree->track_uptodate)
>> +			clear_extent_uptodate(tree, start, end, &cached);
>
> Hm, that call to clear_extent_uptodate was absent before, so either:
>
> a) The old code is buggy since it misses it
> b) this will be a nullop because we have just read the extent and we
> haven't really set it to uptodate so there won't be anything to clear?

You're right, we didn't need this, since the page hasn't been read from
disk, the range should not have EXTENT_UPTODATE bit at all, nor the
PageUptodate bit.

Thanks
Qu

>
> Which is it?
>
> <snip>
>
