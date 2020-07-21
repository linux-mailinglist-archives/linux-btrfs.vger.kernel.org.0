Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C99D227CF9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 12:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgGUK3t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 06:29:49 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:21850 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgGUK3r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 06:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1595327384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWnTOy6b25MuS/JrPKZZxUmxOKOFl0EFe5qTA+1dEgc=;
        b=FrikOFCrOncXCkK2Lgzm0/JHPqt/6Hagx1aT4bTXB2v6Qoraswi44d0r4STTkXdO0G3l+B
        LogAsYGpeU4yxKa52FvRF2H4lZmaK2X2FyREI9HCba9kIkGPiNhstATQPDuV4lPixMyF51
        naVEWETymH8XwzcsgUZ4P0YPZIlEwoM=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2057.outbound.protection.outlook.com [104.47.8.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-11-1-3Od2UKNvKy6Yl7Z8-D2A-1; Tue, 21 Jul 2020 12:29:43 +0200
X-MC-Unique: 1-3Od2UKNvKy6Yl7Z8-D2A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pzwe8EJ8y+f5GNxOXXkcke1sx/2sRWWDzmc5HHKrNdxYxIK3A2vrNc9AgnD2iUS9pkh1ghXbV7rsGk4AXfNmg+PKljrprvzar+MC+WprX1jr+e/10czOd45pALOeJs5xq/EJ0/FADEohelCaPOcQ4I63SisdFchNvCrmWmlaQ4eYQfu3V9SVmmDLZCTytRymmaLxvzQfsgCosT7otw35e/smfY8ZjKqFfpdsPVbCDk5379Z0DVzCHHemBap/LL/S9a56NzjOCMmCQ7QwLy/pPQmIc9JoFgLTChEoQEoFgC1jXysgHHs/QTqrp13ida2o6Ion8hm/zYos4kPCNCLnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7GghL6UgwjS1nPQbZVrJ+tDjxqJuzAV+uSPG0TaBTE=;
 b=XsYYn0jiVPoBmFzUA7pieM3UrkUzTi4b+tfGYMped4pFASBXzfcVxe7u6GR42XtQEzG+GtUP6zLQDf0xQK7FKgwBmxgeFzbNrPrHCnMbwyZJlzmkcU3uQZ671Zms8wQAYl2vUV7kqFTa1zWV1HEx9TyNMy3F7drgJrLyzHiv9N4CdWxxPQ1/AfpJ+caMYBe3xyS3Xq/ETVvVVpQlAxeEiunv2Su8xGeEpHANv97stZIycmGqSv8jIfXcKwB5ANVtwqEk4Uc3cV+ExiUXcHlHzpcBgqfaPudKCXc+eN5wRO/A2Ih4BJGzC7f72BxRJisA1A4XSnjcyXCdrqIKyXgH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB4977.eurprd04.prod.outlook.com (2603:10a6:208:c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 10:29:42 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef%3]) with mapi id 15.20.3195.025; Tue, 21 Jul 2020
 10:29:42 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Prevent bit overflow for
 cctx->total_bytes
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, Christian Zangl <coralllama@gmail.com>
References: <20200720125109.93970-1-wqu@suse.com>
 <20200720160945.GH3703@twin.jikos.cz>
 <cf6386e1-a13b-e7cf-a365-db33a3afe2a9@gmx.com>
 <20200721095826.GJ3703@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <0d3eb6c1-f88a-e7cd-7d12-92bce0f2025c@suse.com>
Date:   Tue, 21 Jul 2020 18:29:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200721095826.GJ3703@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.15 via Frontend Transport; Tue, 21 Jul 2020 10:29:39 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9239bf6a-5aaf-4902-0ac2-08d82d60fadc
X-MS-TrafficTypeDiagnostic: AM0PR04MB4977:
X-Microsoft-Antispam-PRVS: <AM0PR04MB4977967A4DE7AFB24CB2A760D6780@AM0PR04MB4977.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xSTaMB67cL9sK4JDQ+Ajjk12uqbb8Hf1lMldrRS/5Du8xWwBa2nuCgRcCgbXh62dNABE5nUVohZTvc+X2dJF/nHjGzFk79Bl4sDYWmPrw6TAu2ZCDk5ZVXlDhrq7YHoXrknGuTJqGoDATCD3zEJtETWcxdhO1wLuTISqr+C70ygr0Abw5IgttSO7ANj5Jh/siGB1K+IC+pbzS00R8G1kqK61GzfmJC5P42yD/bg1r3r5qd6DSMyWEkEvOIfVFTCE7MvX/UUBdmRF44GsPbs26P+1RpJto/9H/xYDd5QBVgvOMF9CGxEGCiMk9e0glYDxERqcQj0L1P9ZWaYd9fUkTn2WBX1i6cHYRcJQu65o6UUbTA/J+OqR7h6qThLuHBNLw1aJ2uNsgyrwAung3SLAGak+i1iG9GF5c5kDX4OuHtlgxE86eERmnLlyWO3d1oCA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(39860400002)(366004)(396003)(86362001)(66946007)(110136005)(66556008)(66476007)(31696002)(8936002)(5660300002)(8676002)(26005)(36756003)(83380400001)(16526019)(186003)(2906002)(6666004)(478600001)(956004)(31686004)(52116002)(316002)(6706004)(6486002)(16576012)(2616005)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ROLkAA0v+kHyrGqJ3ohdSpuHb6+qesY3ofv5jEp8XdWhj/6FGULwuUEQV1LwH/HoxI1AYEOzyG+lrxIEkvAd1TfoV6wvx86BbQrCPfkAVl+jcRocOVQA6Xi+AnkwWjfgxzi2jw8FfgodcKgiR41oq2RQxzUvxGnuFM52kw1FiuA9gW20JOdgWgkLaN2FgGWnTe4I9flRpZ6i01pClNmpZThclm8FP000Xg58U+MI1CDpUFTR99/jC15yKRbimb5DAvLw1k74fBBL8tNPLW7iv8WeY80ghsOE6YnSt8svpHMo8Em2ELNrquiRkrQGjUpy5QF3zocLBsivjs7dQYuU4rApi6GbZLa1jeiXRcPNeisl62bLqyXyrRIAFtk3gMugoiqB9nQisR2X2VXnwvwjasJ20JLueVhRtEEso6yVqQrfelgf1R8bP0ZjVfSLqThvYhAdENX++1SxU2C5SYf3/Y0HON8/QoVlDVB1hQZcGlE=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9239bf6a-5aaf-4902-0ac2-08d82d60fadc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 10:29:42.4088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YFGFbSpxLCCI1PsQfqTk3qvJUe+UREGdTiXWTblmknbRKrP1DqFaDw95yrVkYyG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4977
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/21 =E4=B8=8B=E5=8D=885:58, David Sterba wrote:
> On Tue, Jul 21, 2020 at 07:51:00AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/7/21 =E4=B8=8A=E5=8D=8812:09, David Sterba wrote:
>>> On Mon, Jul 20, 2020 at 08:51:08PM +0800, Qu Wenruo wrote:
>>>> --- a/convert/source-ext2.c
>>>> +++ b/convert/source-ext2.c
>>>> @@ -87,7 +87,8 @@ static int ext2_open_fs(struct btrfs_convert_context=
 *cctx, const char *name)
>>>>  	cctx->fs_data =3D ext2_fs;
>>>>  	cctx->blocksize =3D ext2_fs->blocksize;
>>>>  	cctx->block_count =3D ext2_fs->super->s_blocks_count;
>>>> -	cctx->total_bytes =3D ext2_fs->blocksize * ext2_fs->super->s_blocks_=
count;
>>>> +	cctx->total_bytes =3D (u64)ext2_fs->blocksize *
>>>> +			    (u64)ext2_fs->super->s_blocks_count;
>>>
>>> Do you need to cast both? Once one of the types is wide enough for the
>>> result, there should be no loss.
>>>
>> I just want to be extra safe.
>=20
> Typecasts in code raise questions why are they needed, 'to be extra'
> safe is not a good reason. One typecast in multiplication/shifts is a
> common pattern to widen the result but two look more like lack of
> understanding of the integer promotion rules.
>=20

My point here is, I don't want the reviewers or new contributors to
bother about the promotion rules at all.

They only need to know that using blocksize and blocks_count directly to
do multiply would lead to overflow.

Other details like whether the multiply follows the highest factor or
the left operator or the right operator, shouldn't be the point and we
don't really need to bother.

Thus casting both would definitely be right, without the need to refer
to the complex rule book, thus save the reviewer several minutes.

Thanks,
Qu

