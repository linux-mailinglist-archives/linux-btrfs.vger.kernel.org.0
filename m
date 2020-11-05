Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036DE2A7CBF
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 12:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgKELQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 06:16:08 -0500
Received: from mout.gmx.net ([212.227.15.19]:60789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729916AbgKELQI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 06:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604574964;
        bh=XhujgVKnrYZrpeK21YKgdEEnVeYQBZf29xNm14UAFMs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CHemzjKCY+OUjFPYwsFW601PWjBv+oSJREaVjTtwlieKU/CZEr8sRf8l7LCbm296L
         wKG0K3GmI4vEV17kK7EaAF7L8tqdcYoqQ2B1Ky82yg3ZdHRwp9Pdb00Y7oGiAhuxUs
         Acw0NVzbF9rzFPm6qSNakgrJ/LVrt6Q4yqNIzWLE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOA3P-1kySgi0Mrh-00OZd2; Thu, 05
 Nov 2020 12:16:03 +0100
Subject: Re: [PATCH 02/32] btrfs: extent_io: integrate page status update into
 endio_readpage_release_extent()
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-3-wqu@suse.com>
 <425a0a98-82d8-35ce-1d56-48af0a62546c@suse.com>
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
Message-ID: <1dbb8469-2a96-2403-dc54-b9aa6bf9480a@gmx.com>
Date:   Thu, 5 Nov 2020 19:15:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <425a0a98-82d8-35ce-1d56-48af0a62546c@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xMo/Fkdhvgxcpom1mKPWGIICMxmP8gcRR3pWQegasv0pYI+yxQP
 UK3oEsTEnBxeTCsVAKRgBYHA06/YhPi1KwhZOSLQvs6KnzcYoqi5TiGtL1EmUuc9a1Cr/LV
 os0F5IysMt3qDDIqZWy2cxp9M297sAEzffsU74HdIIMrgS+ccZZTrIS+s38QUw8mbsLMtuI
 d7qd8g4kzIL2g/d4h3EKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QZ5ZlPQ3CNI=:EXOZ7i9qEPc9ea8CIq8XPR
 5A1q35jN4w1fLRr53VR7v9ystXjKi5xg/q8s4Jmz5ZvFG2KSPhlLvIkNfA4so7QiIddK4UCGV
 7n9XWvgcuEA00ce+HGGnInq0dzvNEvXfMrYoawQmWmh9gtAW9c4IUvDzqrsrOCZm/BwXquik4
 G0ETUbWcKDk2PNoz3VamkgTmywtZADrKcF9Hc9P1uPzLfgCBxe+4cSQqbdxb9wrEGpGU9EvGQ
 tj3AZx3plI6hDU72pvwVC3Gt2MTXF3m6P8zapME0HHIN1Iu4nZ/E4xfvlQasM4SPXZFgl0KeG
 TOJ53zAwA2U693pZWB3zSDa7Q9WEpFNuaSUpCt8ldzqfgR5/wG+HTt5d5AQZ6MtZv9CsD1oG1
 357KbCSs54E7+TWvvyxqUeIiTijsB+Yvrqy8rdbLWsE2Uw3QgmSt5oLlDg5L8x3Varh3qJiLj
 4+p19dgjR1OjDc+H7nwR68PsQtxRIW6xPMqoVTzPWOOeXq5KKnKjeTvawmB/e0Nc4m6lYxIJV
 Vjkacqmi1X9TT5cNGY21YF6lcVYGrG5wVaiakMZN108azQzJ/2/kISS7tWHVn5HwHpDZDe2d3
 sF9txMw2eQnP1MILohTZbIztPVRPBoe3GNUa/1IOnE94Prf7BDiyHZrTGh0c/zALByzqW35WU
 BPEilo3gxXEhLDS47J/TZOWlsM+7ox9E11L1PFRG8+nvviM2ZCjYh7ksxvvVjxoiA25+rxPCZ
 0ujXWSCw4M6N0z/GsvGvHubeo++DiAdutvTOyx8vFzL1yaTz90q0pIszN0OV3UjjBYIwSyGY+
 N8Z6DYnD3AMAkW+glpi6vjQQCN2Oc7KjVN5syFR6or+4vbdm7LWQ2S8Punt8Jz1t2tAC+roJe
 sBJwhY+KpO/rhTIWLLrQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/5 =E4=B8=8B=E5=8D=886:26, Nikolay Borisov wrote:
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
>
> 'start' is 'page_offset(page) + bvec->bv_offset' from
> end_bio_extent_readpage, this means it's either equal to 'page_start' in
> endio_readpage_release_extent or different, you are effectively checking
> if bvec->bv_offset is non zero. As such the '<' condition can never
> trigger. So simplify this check to start =3D=3D page_start

Nope. Don't forget the objective of the whole patchset, to support subpage=
.

That means, we could have cases like bvec->bv_offset =3D=3D 4K, bvec->bv_l=
en
=3D=3D 16K if we are reading one 16K extent on a 64K page size system.

In that case, we could have start =3D=3D 4K end =3D (20K - 1).
If the tree needs track_update, then we go the set_extent_update() call
and re-check if we need to mark the full page uptodate.

But if we don't need track_updoate (mostly for btree inode), then we go
the else branch, and if fails, we do nothing (expected).

This if branch is a little tricky, as it in fact checks two things, thus
should have 4 combinations:
1) Need track_uptodate, and covers the full page
   Set extent range uptodate, and set page Uptodate

2) Need track_uptodate, and doesn't cover the full page
   Set extent range uptodate, and check if the full page range has
   UPTODATE bit. If has, set page uptodate.

3) Don't need track_uptodate, and covers the full page
   Just set page Uptodate

4) Doesn't need track_uptodate and doesn't dover the full page
   Do nothing.
   Although this is an invalid case.
   For subpage we set tree->track_uptodate in later patches.
   For regular case, we always have range covering a full page.

>
> For 'end' it makes sense to check for end >=3D becuase of multipage bvec=
 I
> guess.
>
> Also the only relevant portion in this function is really
> check_page_uptodate  I don't see a reason why you actually put the page
> uptodate into this function and not simply adjust the endio handler?

'Cause we are here handling the page status update, (with above 4
branches combination), thus it seems complete sane to me to do things here=
.

Or did I miss something?

Thanks,
Qu

>
>
>
>> +			/* We have covered the full page, set it uptodate */
>> +			SetPageUptodate(page);
>> +		}
>> +	} else if (!uptodate){
>> +		if (tree->track_uptodate)
>> +			clear_extent_uptodate(tree, start, end, &cached);
>> +
>> +		/* Any error in the page range would invalid the uptodate bit */
>
> nit: invalidate the whole page
>
> <snip>
>
