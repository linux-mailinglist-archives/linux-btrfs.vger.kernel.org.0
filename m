Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688FF265D8E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Sep 2020 12:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgIKKPb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Sep 2020 06:15:31 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:50642 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgIKKPS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Sep 2020 06:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1599819314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQWnjT77ByAkM95a3zWUvJWOGEDPUsseVPPYe2Yrqnw=;
        b=JlS+3yLNhExrufgAn2WjQ/q8H8lhyqi3Vw7DrI8PoveJHA3nrZ5ROh0exo8mKVcbhwpMdH
        paxgF8E49Xh474dQPrsntXbHHJRRs/F8SznUSxfq59UtgGmAJN7wCY/iMCqufyJ7oKz1nJ
        GM+GAMEriX1RRw91J/s5iuzzrOLMhAk=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-KFsqvyxGObKr7YeZvMEH7Q-1; Fri, 11 Sep 2020 12:15:13 +0200
X-MC-Unique: KFsqvyxGObKr7YeZvMEH7Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwlQz3EGCDSsR96N3P1Zirr/FB1CjsCxPuNhBmRAFmvJW3icXKtsdCEP0SchWm6zA+ytON/gQX5gDkNydq+TVkG+EuBFUyT4tKJAnFnF3pNTnXbnKuFPc05xguIzxbwLIG8chpAvCzqPE7fvK92qpvhNjwUV3GiYPHZY5RETLdKIXqtGzJq2Q03ssvaHBITL3lrC6qx4KZB/JLSsigWEnm4vDAmZqnUGHw2KKiXAbI/H0niaJ0Bn5rGu/7IMPPc0+aQJjhbMTtkivStuOmtIqJMRiSn07Jf2gDHo3gjyTgByyTxy7Ed6HGNOam4Un/dwgIbF7BZNXaiWScR64ewaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFKa/kcOT4+UDeoJuvGpXhBDwy4JeW2REf0MHvqBNTU=;
 b=Jf1CuYvIrPe9lRHHrsVtAm9adW+/Q1uyxGUfot+yVx99L3nhDe5k1K16r4Wyeq74x64dWS7GhUqnWQNlZ7ZtiHBXlVT1V9LkC5rbh+6vIlafbN+exTg0up4iYsh8zmA800tkmjRrqhlRWlOO17We2ZyKq3rA23CCJB3XxtR+A2dB3wNp5gsZZZnQMszFIfuG8WFRn2Jn06Cat97SRqmvqj5qSUveNhc3st9to+0gH8VNq/fc+J8d61y5Nbu9JEEQDmM/ytwj71jmZhWlnn+vZF8QCaKIZ74KUoxwY83dT9FwwRHSx5UwN5STRxGSSm33Zwfx3pyRKKwD+VHiYQ2NcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM8PR04MB7236.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 10:15:12 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 10:15:12 +0000
Subject: Re: [PATCH 04/17] btrfs: make btrfs_fs_info::buffer_radix to take
 sector size devided values
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200908075230.86856-1-wqu@suse.com>
 <20200908075230.86856-5-wqu@suse.com>
 <cb58ceb4-1636-c717-7ac5-4a45d4d80314@suse.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <b4fd6389-7a99-2d6c-bf07-eadbc3540a82@suse.com>
Date:   Fri, 11 Sep 2020 18:15:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <cb58ceb4-1636-c717-7ac5-4a45d4d80314@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::21) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR16CA0008.namprd16.prod.outlook.com (2603:10b6:a03:1a0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 10:15:11 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb6b193-b8c0-4b5e-e2d7-08d8563b9216
X-MS-TrafficTypeDiagnostic: AM8PR04MB7236:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR04MB72365577D06A36604E4AD520D6240@AM8PR04MB7236.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5nkL2mNrLRi5JElp4mOu5+ZIxeQgvScAE5NAdOte5vOJYy1r3oWrDvu0PY036mBJpDp15YqCkefhqWkVt+bQIhjkXjIrFBlXlzqDKiTmTdF6fpFGhp37+Q0Xk+89KaazboEiIGiVwHOSD8WxOWKdnlf3DZuUMwkHZeYLDXkPrE1B6dMac60aMatRW5QgRJWyLCWKacD+jD3+RY0YGQD63g04Ctv02qKgvfGTYfPvSpefew6utietfp/uAD/DyDxsI7l/Pa/JByzOPm7lZOZmPEh7A4iR0vCT+q/go/9vvv/IVNJwBhxPpiWf1++IFGEPVw5MCWQZzs/htoj/usVCjWKcdiRZ0Wds82d5s20HFTA9rqnC9h9iDSP3zAknUWSEGjDJDVqAIMkrY7qAi7O4YSlwpbwHJbhZniYj6Ajshg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(6666004)(8936002)(186003)(956004)(2616005)(16526019)(83380400001)(8676002)(478600001)(6486002)(316002)(6706004)(16576012)(52116002)(26005)(66556008)(5660300002)(66946007)(2906002)(36756003)(31696002)(86362001)(66476007)(31686004)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RfyFf+tSLJG/S7sLVUn8fe2MAMol3AAhDvhmioNGaBDhGFgem4fKx5jHHATqfl0vTYqdzqnnZXwEk/1flAEaRlpa3aV3d60Vs79G9AJDkr121vYd3e2uBQ3eNRCWnS+v2unYCmKrjOYGYcEXzaUQl8XmE82joZuRI7i/frV2G7NbpARX7HiLU6/BIKNCWOgVZn6XNSSNpnaX8F4wUAyZmTfTbFpL9swIhCsDJzG1McwyOroYDBgEXwf0ko+FbTvxIa6NXkN/2cfhEZIrfYcAGCKyvoixL+jWxXsccNjpltuQ4/B2Z18XZoeCEX0alm4sIMMWGVyZqL+ldhzddhfIp2zV7nQsxOk6NkX5YqF8axaFgZVaHiVvnboUvNynTD6B67c7nQqe0773xd8TBkSJGPfqY+3U89bC92BfSQtLxtGxVTxnTuRzsoyC7eAw9AIE8vwNLD1xNOOW+CiblXQYyN7A2sRgP5PE7le1RSTqULjva9bJmX8Ky2iVOKL2gL3XRupTY4eS0dYJe6M2W4HakQNjqCM2WxklpHH0m8zwETZ29bDtgDwt91OGvVb2YrkMRyhrn3LzApQM3xiwa/E9fL3PcDecvNXwgyPWQyf72Ow94GqWAshG3JT/mEsYgqc4ER9uLYZfkwY4sCBmdg7MtA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb6b193-b8c0-4b5e-e2d7-08d8563b9216
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 10:15:12.7887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziV1ZUBI/nb0lSoR0k7qYX0fKsYOoYCKODk7vhfU7a1RDNvntEdRoFgr1YyGtmVT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7236
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/11 =E4=B8=8B=E5=8D=886:11, Nikolay Borisov wrote:
>=20
>=20
> On 8.09.20 =D0=B3. 10:52 =D1=87., Qu Wenruo wrote:
>> For subpage size sector size support, one page can contain mutliple tree
>> blocks, thus we can no longer use (eb->start >> PAGE_SHIFT) any more, or
>> we can easily get extent buffer doesn't belongs to us.
>>
>> This patch will use (extent_buffer::start / sectorsize) as index for rad=
ix
>> tree so that we can get correct extent buffer for subpage size support.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> That's fine, however now that we are moving towards sectorsize I wonder
> if it would make more sense to fs_info->sector_bits which would be

Exactly what david is doing.

IIRC he mentioned such shift bits simplification in IRC, and I'm just
waiting for that bit to land and use that to further simplify the code.

Thanks,
Qu

>=20
> log2(fs_info->sectorsize) and have expressions such as:
>=20
> start >> fs_info->sector_bits. I * think* we can rely on the compiler
> doing the right thing given fs_info->sectorsize is guaranteed to be a
> power of 2 value.
>=20
>=20
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
>=20
>> ---
>>  fs/btrfs/extent_io.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 6def411b2eba..5d969340275e 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -5142,7 +5142,7 @@ struct extent_buffer *find_extent_buffer(struct bt=
rfs_fs_info *fs_info,
>> =20
>>  	rcu_read_lock();
>>  	eb =3D radix_tree_lookup(&fs_info->buffer_radix,
>> -			       start >> PAGE_SHIFT);
>> +			       start / fs_info->sectorsize);
>>  	if (eb && atomic_inc_not_zero(&eb->refs)) {
>>  		rcu_read_unlock();
>>  		/*
>> @@ -5194,7 +5194,7 @@ struct extent_buffer *alloc_test_extent_buffer(str=
uct btrfs_fs_info *fs_info,
>>  	}
>>  	spin_lock(&fs_info->buffer_lock);
>>  	ret =3D radix_tree_insert(&fs_info->buffer_radix,
>> -				start >> PAGE_SHIFT, eb);
>> +				start / fs_info->sectorsize, eb);
>>  	spin_unlock(&fs_info->buffer_lock);
>>  	radix_tree_preload_end();
>>  	if (ret =3D=3D -EEXIST) {
>> @@ -5302,7 +5302,7 @@ struct extent_buffer *alloc_extent_buffer(struct b=
trfs_fs_info *fs_info,
>> =20
>>  	spin_lock(&fs_info->buffer_lock);
>>  	ret =3D radix_tree_insert(&fs_info->buffer_radix,
>> -				start >> PAGE_SHIFT, eb);
>> +				start / fs_info->sectorsize, eb);
>>  	spin_unlock(&fs_info->buffer_lock);
>>  	radix_tree_preload_end();
>>  	if (ret =3D=3D -EEXIST) {
>> @@ -5358,7 +5358,7 @@ static int release_extent_buffer(struct extent_buf=
fer *eb)
>> =20
>>  			spin_lock(&fs_info->buffer_lock);
>>  			radix_tree_delete(&fs_info->buffer_radix,
>> -					  eb->start >> PAGE_SHIFT);
>> +					  eb->start / fs_info->sectorsize);
>>  			spin_unlock(&fs_info->buffer_lock);
>>  		} else {
>>  			spin_unlock(&eb->refs_lock);
>>
>=20

