Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE297269BAC
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 03:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIOBzQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 21:55:16 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:27826 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726069AbgIOBzO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 21:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600134908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=OgKImWo6e38XaM2a26KxQxDUVUOS9m/16b7Cenu1QeI=;
        b=TR5Kf/C1xanX/eHBjRpQNOqDf/JUt4ENBWLp2H80rbzRDilIQpwKS3MO3Iw0xF+dy6AgrC
        ExdcBDTMGFukYaRbOoPUoTUZkCztRbtzQgF71c55g7bEivmuH3RWk8c403aC44LWisuhyZ
        U3QKGLIT8nGUH6pnVyasa4A6RKs8Qds=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-XWG5liy5Msq5HEaLy-yReg-1; Tue, 15 Sep 2020 03:55:07 +0200
X-MC-Unique: XWG5liy5Msq5HEaLy-yReg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTmIf+jhfb4RKPdBzB+2DX6RPLoXyQMoL6XTEPZM/jkjRQLTaAknpTnB9V3hODR827kDdYgBJgjTA5kTs5csgVPwoAQ0/MAIdkiyno+SRxf5HITKelBrJOdirqhclB/HfyEV+J0YF+6vT27EaqJcXJFl3c7gqEytT5tLiZvLEJy4qZmJEbq5YbXfgWnWE80Sorcej4VNyV4tB2e+qehfAAPTG9Vr5UN9JTWkx8pqlaoUB7xyOJW3omHduRfIqLYOV/cQBvtyyoVvFkJNcyUZpq7LHdihxrpthoIPQ9ZuMmXGm4qaduMm2yR97Ipb5AKHsRaVPqpfmXtu2+0WAwoUMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlXIh67pnCatqlHdsdjMnLmTz3yOOsGoMYmDa6Y0GSI=;
 b=dis75z1Ve+NVB/7TgkN1YxtyE5qEo/9DEZfNijgQILCBPNDkxKqq4DY89tL6aKjzvEpyQYxVhVxXIUahLQMgh+xij6CaQ0BMuKa68cH8aAuYIqQ7nT4XXgLmarbPikqtyorfN8M+JyFODzKPp8FzhG/8H3svlrbO+ZkkurE6KG9wtoiOl72YW3uf7L9nSVgd6qTy+brOHr73zTTHua2MhYeRDhjupUc86hWyNP83w8j5R6/KIEkAq+40kaxlSVOF7CFl8bOcA1o2aEhjIprN7soYquqgPtnjPjfPykqTPgAZqTEVj2NUlmVtqIzAK7pbpg0nwZVALJNEiD9JQTsymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB4435.eurprd04.prod.outlook.com (2603:10a6:208:76::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 01:54:58 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 01:54:58 +0000
Subject: Re: [PATCH 13/17] btrfs: extent_io: only require sector size
 alignment for page read
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200908075230.86856-1-wqu@suse.com>
 <20200908075230.86856-14-wqu@suse.com>
 <89fd9545-c539-3f58-e48a-218a9b111edd@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <6a515ae8-7357-7383-9501-e876b905248f@suse.com>
Date:   Tue, 15 Sep 2020 09:54:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <89fd9545-c539-3f58-e48a-218a9b111edd@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:40::41) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:40::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 01:54:56 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0841a196-c939-47ce-0acd-08d8591a598f
X-MS-TrafficTypeDiagnostic: AM0PR04MB4435:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB44355BB085FF21B4904233D6D6200@AM0PR04MB4435.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFhRPsgmQgwyp4BYSaEqbAi/OpPE4vIPksV9ampQv+6/a9VzZ70+F77KMExNj7I4k0Sgp6LeU1tmrjTFP075P06tLHEiMoeYL4FILAZzyuxKrP/doSlnvXJ0VXUFf03Gy+2ukSVMd+jO+u1VUHVlGNFUT/x9CXSDuE4vRWyiIEOHUevNxwgGVpI59i4nT2R2hzxjoDGNL7wo+usAgnBCKEuXve1uog5JrOQQU29BIT4Va3sKOeh2JizAturN5SeEiqCDd2bwKYoKF+2rentGKEE/jlXEp4dybZuz6XAmbOZr64S+LeYntuGvMcAufAIGUKA+936uGzpascwmysbX3EfuP4I1lL1IHPKcY+YhXa1TjrOVw0CDW4A2opvsH19JcTmISKAQQtGo0U34nbBm3j+hGS2r8QW7IyGhs444zFcAji9w8DWwKyO6hTcoVMt3nB/3gCmPpYQ/X9dusI0r2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(39860400002)(346002)(8676002)(52116002)(8936002)(2906002)(478600001)(316002)(36756003)(6666004)(86362001)(83380400001)(31696002)(956004)(31686004)(5660300002)(2616005)(6486002)(6706004)(66556008)(66476007)(66946007)(26005)(186003)(16526019)(16576012)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +PWt4FGasXO9/OOnxBeyM9h3DlGEZrbGXK9BJnQqklsCwvNxB1336qKT4nxTfzpNBJNPHIMeOHlTjuBKvkW07NyHjK+WtKn1A3SRO+JRNqEARGRXJ2kgF4P0XXO6ILCqc4CyU1FWW+6L8aHX+IQThajbH0bPgotpq7NEwgQCCZE1O54kEed+ix8bn6UAPn7lgKTBY0de8bI3e2mFtYQ4bvF/67xV1XbAOOEClaWbQWxnF1ndRtP5XtiiANbzXyamulNlD1bYFW4My94SH22H0Z0M0aJGToc/UXWu/VMUQOpgjTMA9sOnP6TDYrV7n/G3h+6kZ/5TdEafPWeKtstB75H5UGVUXPPbFSPDa+cxlqJCO5u+iBtHiyHwSikwT/Qg2ODGj9j2NPVkBAU9+SAZsMnqDdp1vUZK+quSjpi3V/8CSt8E5KZQCAV7Vko0+rjXJ3zAsNf3AmdKNomdnQHCoDzWTF7xQgZ2xnytqXpkYhpgnez6LrMpcm06UtaWkul6U6B5qrGN23jVGzSAt/TXd2rj/TysoUTrpIdii6ocEqJ1awmMe7jOWzJkovuJcZkqHGRUUKvwT+XrXlLwml4UjSAjopUsYxLDVxjZ5G60CkUckkvY5eAR3C0/56w3RmIvQLS+fMvEtskVBq9uffHdAg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0841a196-c939-47ce-0acd-08d8591a598f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 01:54:58.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JThDI1OnF0ND0JKVb8pew5QDM3IqxbYahihAmTzEd4fgQ/EaRvaUzqUpIVzjCzeV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4435
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/11 =E4=B8=8B=E5=8D=889:55, Nikolay Borisov wrote:
>=20
>=20
> On 8.09.20 =D0=B3. 10:52 =D1=87., Qu Wenruo wrote:
>> If we're reading partial page, btrfs will warn about this as our
>> read/write are always done in sector size, which equals page size.
>>
>> But for the incoming subpage RO support, our data read is only aligned
>> to sectorsize, which can be smaller than page size.
>>
>> Thus here we change the warning condition to check it against
>> sectorsize, thus the behavior is not changed for regular sectorsize =3D=
=3D
>> PAGE_SIZE case, while won't report error for subpage read.
>>
>> Also, pass the proper start/end with bv_offset for check_data_csum() to
>> handle.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/extent_io.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 81e43d99feda..a83b63ecc5f8 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -2819,6 +2819,7 @@ static void end_bio_extent_readpage(struct bio *bi=
o)
>>  		struct page *page =3D bvec->bv_page;
>>  		struct inode *inode =3D page->mapping->host;
>>  		struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>> +		u32 sectorsize =3D fs_info->sectorsize;
>>  		bool data_inode =3D btrfs_ino(BTRFS_I(inode))
>>  			!=3D BTRFS_BTREE_INODE_OBJECTID;
>> =20
>> @@ -2829,13 +2830,17 @@ static void end_bio_extent_readpage(struct bio *=
bio)
>>  		tree =3D &BTRFS_I(inode)->io_tree;
>>  		failure_tree =3D &BTRFS_I(inode)->io_failure_tree;
>> =20
>> -		/* We always issue full-page reads, but if some block
>> +		/*
>> +		 * We always issue full-sector reads, but if some block
>>  		 * in a page fails to read, blk_update_request() will
>>  		 * advance bv_offset and adjust bv_len to compensate.
>> -		 * Print a warning for nonzero offsets, and an error
>> -		 * if they don't add up to a full page.  */
>> -		if (bvec->bv_offset || bvec->bv_len !=3D PAGE_SIZE) {
>> -			if (bvec->bv_offset + bvec->bv_len !=3D PAGE_SIZE)
>> +		 * Print a warning for unaligned offsets, and an error
>> +		 * if they don't add up to a full sector.
>> +		 */
>> +		if (!IS_ALIGNED(bvec->bv_offset, sectorsize) ||
>> +		    !IS_ALIGNED(bvec->bv_offset + bvec->bv_len, sectorsize)) {
>> +			if (!IS_ALIGNED(bvec->bv_offset + bvec->bv_len,
>> +					sectorsize))
>=20
> Duplicated check ...

BTW, this is not duplicated, it's to distinguish two different error
patterns...
One for read request which doesn't end at sector boundary, and the other
one for which doesn't start at sector boundary.

>=20
>>  				btrfs_err(fs_info,
>>  					"partial page read in btrfs with offset %u and length %u",
>>  					bvec->bv_offset, bvec->bv_len);
>> @@ -2845,8 +2850,8 @@ static void end_bio_extent_readpage(struct bio *bi=
o)
>>  					bvec->bv_offset, bvec->bv_len);
>>  		}
>> =20
>> -		start =3D page_offset(page);
>> -		end =3D start + bvec->bv_offset + bvec->bv_len - 1;
>> +		start =3D page_offset(page) + bvec->bv_offset;
>> +		end =3D start + bvec->bv_len - 1;
>=20
> nit: 'start' and 'end' must really be renamed - to file_offset and
> file_end because they represent values in the logical namespace of the
> file. And given the context they are used i.e endio handler where we
> also deal with extent starts and physical offsets such a rename is long
> over due. Perhaps you can create a separate patch when  you are
> resending the series alternatively I'll make a sweep across those
> low-level functions to clean that up.

I guess we could do that in another patchset.

The naming is really aweful, but there are tons of other similar
situations across the code base.

It may be a big batch of work to properly unify the naming.

And the naming itself will take some time to mature.

We have a lot of different terms which share the similar meanings but
still slightly different:
- bytenr
  btrfs logical bytenr

- file_offset
  the offset inside a file

And in this particular case, for btree inode, bytenr =3D=3D file_offset,
which may make things more complex.

While for regualr file inodes, file_offset is different from the extent
bytenr.

So we really need to come out with a proper term table for this...

Thanks,
Qu

>=20
>>  		len =3D bvec->bv_len;
>> =20
>>  		mirror =3D io_bio->mirror_num;
>>
>=20

