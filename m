Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1304114C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 14:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238621AbhITMoq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 08:44:46 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:44598 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238864AbhITMoh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 08:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632141788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7SfrznEi4s8Ux6hz0+5J7qy9wdeo7zxG1x8r32w1nuI=;
        b=ITvhQlwV7FZdGBUKHTqRmN/HQEsCKdNCTGKCygAR5G7I5EMGFv3q8+892JZgGiFm9BAEiW
        3gqBhFCD9r8PDsqbg3TjyZGlAlq04BxOQ3MAXHyN11Yfi6ILntWy7OQt6jD0feOfVVMZFn
        OZJW+9VnfNUE2rwPRxSbS3NJfpJgVwA=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-27-xQEoYHDcMNGTZ-tCfRcgCw-1; Mon, 20 Sep 2021 14:43:07 +0200
X-MC-Unique: xQEoYHDcMNGTZ-tCfRcgCw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii7Pq775TaIUZbRowEO+hdqbEruOXsz+78J+3rv0yOO8KpCvk+y7Sm1MLntgOvPtsgOIbB7breUvAfBwJRAymMbrH9/DdJ7SyRNzFLpgxfqEjziJKy62LKfQqdgjicw7fFLwF4Nk5XVQisVOTpNc4Q7rida6DGFsJbByCfYBhtzdg0blYRFfCFlKyPagtmNGGSNfJoRFht4YlS3kuJvGchEBkR4EbSzm7vHz7A54FQh4DiOZDDS4XLpcJQ5KrHuS7idxukU/jTSIah1VZ8l+O64U2/XqqS4SQDFM90eZfWHCfrGqc4ad5OaalgBW9uH6TFxGSSjPCqmXcen+r8yoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=L3L7xBehd3jaiQN7NwwLr9PtTYOaCbxu6d9nRb0snzc=;
 b=IUqxKDf83Nhs+cxAjPEgo8//gU8ZwILZzBYiW7OY7Lejg6lmm5Liag8Wg4I0WNIOO/b7b2EZs5HiADc8yOKh0YbFDzFxTwgxiUKbP8c7i0wJPvUBwGS2E+R02Uh4cvAahRo4V+g3yFS0zZvRJjqJ8O4am8O38uc6zJhpv8U3LxMty8yjMKE92eYIPTVizqn5CYePPtg6R8JGeQRn0JOGXokqY5LPj3OQUx2Vv5yy/lHMkwlPOElHcFQrGMfgfPCwLyfUqKBvWMRt6t2fxcMggf96oHD+fI68c5hzLnmX5mOC4YOtwIPMEzqYbQc03Xjm52A0AjoKfho9rPdsHSSqtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8167.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Mon, 20 Sep
 2021 12:43:06 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 12:43:06 +0000
Message-ID: <0597fd82-d528-3aae-16c2-9d227a705529@suse.com>
Date:   Mon, 20 Sep 2021 20:42:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v3 2/3] btrfs: remove btrfs_bio_alloc() helper
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20210915071718.59418-1-wqu@suse.com>
 <20210915071718.59418-3-wqu@suse.com>
 <a4380e7b-b728-fd85-b6c1-175a53f6a1ce@suse.com>
 <20210917124341.GS9286@twin.jikos.cz>
 <6d4ee72e-1f3c-0d06-7ce4-6e17d296c390@suse.com>
 <ce7b5672-9aa4-607f-f21a-594f1f9d3262@gmx.com>
 <20210920124126.GK9286@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20210920124126.GK9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::26) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0261.namprd03.prod.outlook.com (2603:10b6:a03:3a0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 12:43:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1da4eb61-7fcd-48d8-ca7f-08d97c34317a
X-MS-TrafficTypeDiagnostic: AS8PR04MB8167:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB8167002D1206E9C74474C18BD6A09@AS8PR04MB8167.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RjjZE18rHeRPKgUuUyTwTAp4oq/dkWu2iNsmaah6ptlouIFNu0uPIftCNNb5Bxz2B+jjx6CfUxw3K0dK7JzGUZPNoa9nHolkNgWCCaFs60nw2vjadvZCYfxGNIhnujZcxoX7dvp2ExGuCr3YDwz945diNZsT/4IPPrRb/wHS5Oy1zf6JUWEmAp1nmVkjMqOueDRKDw4fONhERM2gDYh1FL5L7AWzFJIfo9pUwE+c50BeXh0b4HXPk002d9M8PInHOkNBXnfSnmQXpmTMKDC0Wv5T4kBHM9a5XQAXFNd+sQNLHfeFWxThCEvm6plzGGtjbKfHovMj9LJ2wlcxG+I0VBkMBg2xoyz29gPZzUsG9by7irzJyZUIGYFf3IUPMFG0bpA38/kxr9n5E2smePLdWxnLgaalmfWH0yP7xfnIWL/+sSY4Y8W4p/TZU7UXoBAWKE/p3WpKDTBWBiGrRnB9e1TJXGq9idZWF/n6mWc+UfRCYXuvDhZZ57Nbxo0N1x+HKPGbAByCrX9N2iQ67mtf99NePLuVUsBu9Qnyvl7ISucgCw83ZYmJaE/C2u21u8Mzb2SZVeDnEdmpUJl70ODy4fUXZ2V5tti+drgbc3rMYogX+pOs10RtZ/3olhuyeuKI+VduNlX/e/yr9envgg0ar+Nkp9/WKz/z6a5xdG6rNdhF9neZlA+T46cX759opkt9AxlJi15h863G1uyPm9yChmtiCN7cj1JYZBy28Z+3vuvLVwL1DqNfBfEXldpsoiIB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(366004)(376002)(346002)(53546011)(186003)(6666004)(66556008)(110136005)(66946007)(31696002)(16576012)(316002)(31686004)(478600001)(26005)(66476007)(38100700002)(86362001)(6486002)(2616005)(6706004)(6636002)(956004)(83380400001)(8936002)(5660300002)(36756003)(2906002)(8676002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N8APAuMzrEzSO9hQcK950ZbXSTGdftQ1k1kd8SDSVs7HEaj9D9uwImmv26Va?=
 =?us-ascii?Q?ajPsVjutP6l6AbknpXIBuQPVVWTX8dnu1mEP4bsOMAF5/zhSYrFJn9E3T1s9?=
 =?us-ascii?Q?nahGeshBiQFNFJhuzGG8vAekJzpukKxTUAmai9Tp2HqTenBcLBOg58WL63uw?=
 =?us-ascii?Q?Lkk0C8s6ChTJtVMbspHUZ2IDSk2GjLSU0q1hgiRN1aE9CgUHb7X0pZwovW45?=
 =?us-ascii?Q?VomX55uceC/6Qruf0WnJ85Ov8YA0WICSiC9F/i6Zx9gUhnpx3Hb53RoYU++Z?=
 =?us-ascii?Q?CSkbm5Q0yFqKpRVgmcuMnIIXPvl65kft9OXSC989i0ki2qOFin4rFJzwqF8/?=
 =?us-ascii?Q?LX3tKTc08PvU/DyNLLlUoVwmUomGntkfFhwIsNEnl9GcHajH4haqQ2T0Uezm?=
 =?us-ascii?Q?sAgwmvsVTztAWBm/Y+8YB2cpzqgyegwrYF1HZCIe6EkV2jPd3VpLCNAX68hQ?=
 =?us-ascii?Q?J36hcznKo1m4DLiOMhqIbpcIIbYg9NR6xa+MpWLnNaBadr2THbbLZnR8TL8R?=
 =?us-ascii?Q?xmp2b/DQMKTADjAvgoTKeyS9A7VcYalzUIg5B8Z6twUZ5swDqMYWVlFZQGyC?=
 =?us-ascii?Q?sdO2y9+1nPKp4VN/21wi899WHfQgnUgZjLZ9GKO9SsBsC27t/NQ57jN7gNa/?=
 =?us-ascii?Q?2aGwGXZAGLOkTKrjpZnaIo077gJBPjP4Or/ZgwcmlE4lkuObBO303/Kmz30Q?=
 =?us-ascii?Q?uXOVSXy1ZdUzYxpFo8v1Ucyp0q+S6pic8HkL7vWwCuFl5dGNu7x4mFxAgzFB?=
 =?us-ascii?Q?PVv+HKvGwPv7JEnwz0DDjViiWni/E8SAlPkjo0qlc4MKsEt+Mb0+YxPtR4kt?=
 =?us-ascii?Q?Qq6Dhf1xPUAXRaOQCKJlefNua6+hOaEpLSS+XJR1cEztrzr21fj5MFGQm05r?=
 =?us-ascii?Q?EL10VY9QHQakoHmuGVwTebnO0ir0/a+WmV5o6xww7ZHAIdPrOe7gRupfwe5J?=
 =?us-ascii?Q?pZjY5gp4fP6rIVocx1S+9jcSY9aHvco1SiKYwBhX/VjrnsFiaQG5TUz+lGeu?=
 =?us-ascii?Q?oIDaDAfMk8WjH0pNs0YPSqjSljpefrKwTZ5gtkVgLYrGLaseN4+0f+DJHxEt?=
 =?us-ascii?Q?Ip3o/HSFTGqQv6W7HwMYLgvnpJ9IS3Le4pY1tHqrB//DFl1SuYCRe1Xvrqx4?=
 =?us-ascii?Q?9jofoeP1vj04Z5iH30L+0Z026qHFHTrL93/Pb6An4jyc3InJqExD1tCKMlF3?=
 =?us-ascii?Q?2Ct8w6yWkcAp5EVq+5hUNF3SHavP0DWgMzETfKWKtL7rh459QgSXbfS8Ssw7?=
 =?us-ascii?Q?lIY5vDCaX2tr2OAVFCThw4N8LZvcAs680tIe23Dzp0zPibcjEP54MRDZgf5W?=
 =?us-ascii?Q?muFkwcTUgZ9FOrLnZQvo1nlk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da4eb61-7fcd-48d8-ca7f-08d97c34317a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 12:43:06.1184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWrfybYe2rwv75r9pR457S6E7jwYNlEB8njAabaHCvNfu3O2bsc1XpC7+hpQsmsN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8167
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/20 20:41, David Sterba wrote:
> On Mon, Sep 20, 2021 at 06:33:14PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/9/17 20:49, Nikolay Borisov wrote:
>>>
>>>
>>> On 17.09.21 =D0=B3. 15:43, David Sterba wrote:
>>>> So should we add another helper that takes the exact number and drop t=
he
>>>> parameter everwhere is 0 so it's just btrfs_io_bio_alloc() with the
>>>> fallback?
>>>
>>> But by adding another helper we just introduce more indirection.
>>>
>>> Actually I'd argue that if 0 is a sane default then BIO_MAX_VECS cannot
>>> be any worse because:
>>>
>>> a) It's a number which is as good as 0
>>> b) It's even named. So this is technically better than a plain 0
>>>
>>
>> Any final call on this?
>>
>> I hope this could be an example for future optional parameters.
>>
>> We have some existing codes using two different inline functions, and
>> both of them call a internal but exported function with "__" prefix.
>>
>> We also have call sites passing all needed parameters just like Nikolay
>> suggested.
>=20
> I'm fine with explicitly using BIO_MAX_VECS instead of 0. I'll update it
> in the patch, no need to resend.
>=20
Thank you very much.

I'll no longer use this tricky way any more.

Thanks,
Qu

