Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F99E2FE33A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jan 2021 07:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbhAUGxZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jan 2021 01:53:25 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:41158 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbhAUGxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jan 2021 01:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1611211929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YARoGCddBaFyY1fxWur2JGwIMRxgWBnOBAhTPVp9RqA=;
        b=S0S2vl5dncuMd+e3XdsNoRP+yDGeqv0BHcEOTPXVbHggrc8FuZLcu9QDknGfMkogEAoZee
        WgTp8tH//X+970J8/qR1N3faqN1K18JgO2tat19idMD2WpF/71Pu6C/Kzm7VzfmsjOXkrj
        RAVIgrmlCIZcbNYOdQl8ahbP5R4XIHw=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-8-hl_EqsEmNc23Uh5WHMREjA-1;
 Thu, 21 Jan 2021 07:52:07 +0100
X-MC-Unique: hl_EqsEmNc23Uh5WHMREjA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ew42Ar25ceJbgsTIEdeolLHReAdW1ipn0jdb3pBTb53ExbgOaDDbiUl7inTL8qbPdpA/C7GNNmidah4ci+vKAUyuOg1ihcd6sclbx3Zb2WINbbQ1XLslJy98ros92mO13oCJGSlCg+eOlIZJrJBfVM5wsaj/WajBI2w7xZeWgLcgUg6e6L9hjLjFVqmWL32Xflls50JceeUMFzDDneIl5ysoUAi66g/xT/zyJocGlUFaRor6GQHqIikaeYRYcEkI5Xt9S6+VihEIOhqBf7RVkRlYu+1T5Z9paGNnwvgT+vyJTYOc2VO6ea+X1knCJEtXYlvOuJM/hgWXU4XIg/zB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b66rNSPgbzsFzkcPVOlOYdfylGz4+jmuG0byH8Py7ew=;
 b=MyiEvojzFLqCFeXunDqtsoM9dHpxpvu5GBxTTVXMhvGSTdIzJu0vyC9phIDnPgER8CiN8oPcf6wUOdD8NmXvw4ZNpnUPx2fU81jQq4KDIShmpcSrf42kUIhkpLvI5m2CxJIn+Gxed6Y1aR2m7ywwssCwAVXKGlaS0YufE2gnudf7j3UP05rhBpeeCmct+uKjg8dkhlieUtOt/yPsU//awoqrP5O3IhwZKeztRvByDk51ZG+1x6tIVFzL5tpnHlTpIb6RezpxTSYMN27PDvTKrlJdRaTTnRpoXnifI6HhmBR3FJu2i3ADBWkwWowCuJxJ6k+j8hf/f5l4F6VdDUDntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23) by VI1PR04MB4751.eurprd04.prod.outlook.com
 (2603:10a6:803:53::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 06:52:04 +0000
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28]) by VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28%11]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 06:52:04 +0000
Subject: Re: [PATCH v4 01/18] btrfs: update locked page dirty/writeback/error
 bits in __process_pages_contig()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-2-wqu@suse.com>
 <b0360753-072a-f5c5-3ea6-08e9db2445dd@toxicpanda.com>
 <c4bd841c-6657-5a72-85ac-fc8359c87a74@gmx.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <bab806e1-ad3d-b34c-b623-915b39621983@suse.com>
Date:   Thu, 21 Jan 2021 14:51:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <c4bd841c-6657-5a72-85ac-fc8359c87a74@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY3PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:254::17) To VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:254::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.7 via Frontend Transport; Thu, 21 Jan 2021 06:52:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c27566b-e1b4-40cd-82b3-08d8bdd90fbd
X-MS-TrafficTypeDiagnostic: VI1PR04MB4751:
X-Microsoft-Antispam-PRVS: <VI1PR04MB4751C864D37C9A36D6A75AE4D6A10@VI1PR04MB4751.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o9wiKE5NaAi63IafFhDG8+zmCx0wDdf8TAjEVDdoxNcT+zJxjT/nASv/dhzrHWhSVhug78iqHT5s61QSTag3/Vj5irDnbbjkUNEd5vWWH5I5LGeX4PghNO/KyBBF7LnAbwfmvOXA9WXu/n+pvskXEvOx4zFZbGu1mW2h0X+mKXCXmQx82FSnYNtBexHPedkgMp8rVzMsORTO+7083yNnn28ylCkf0s/soel56F9LY+4FYEGhbQcqDEvzfuDdHR4/S6DNyznRYMU6fouVvR1KzHtnYAwFJWO54pkebtCJUqjiFYDnITkbYVI36x3lc1ANdMBZ4Esc19/o7FRFfNoscbuLYcplf9nCliHuMZoimG576PGTbMTVbSp/CSBwfUL/ZJ2ShBpfCB5koJqaZJ/q6oYLW9hKSucAjIq1sXpX4a/yHQvFleUd4SPi46IdKVue1j8Sye8q/tufgSINrvtiEicDsm+4+TB3abrQ4VxiWgxq1ML2q/k7iLdMdpj5ruwn+DLDOzYG6LY2cWyaJMyNCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(346002)(396003)(376002)(2906002)(2616005)(83380400001)(52116002)(186003)(478600001)(31686004)(956004)(26005)(5660300002)(6706004)(53546011)(8936002)(110136005)(6666004)(8676002)(16526019)(316002)(6486002)(31696002)(66946007)(66556008)(36756003)(86362001)(16576012)(66476007)(15650500001)(78286007)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ifrSg0ueUm6d0DHaoxLw4dQBtMlryMNCOMxUBN/AWuoJC9NJEm7pBvecFitB?=
 =?us-ascii?Q?AxobP59mGlt4cYAgPwqITLnLFRbIFTKyu72zNkGdf8yDhyLY7mD+atLQgshP?=
 =?us-ascii?Q?+ZrzouCWMx60GMOZA2HsIwnDyUJaolw/bCXhO4wubMNo8SFbU7IcIi/z/8SQ?=
 =?us-ascii?Q?4Ax/TJuHaN8LDbaDzQ3IDUAI94TRWyTq4Y7sIVhX8z5aFCIitztZ5WUR7i4W?=
 =?us-ascii?Q?kdGmyUM7N87jMt43y+HXJ/9W1RmRzlv58l4Nhvvp73AR5AAC9/ixO9C3KNas?=
 =?us-ascii?Q?urtXmOYh24lzJtBbFiUG/suOr5Sq27nq2kFLNlD44lnFU9AB6ykDKHsmA8WR?=
 =?us-ascii?Q?gT7FF4MdweSuMGHRwSaZ2CZIeC0IeFsJSrfaRO4z17nSAjEVP+zMeEgBSFph?=
 =?us-ascii?Q?Yx3jizkc8MwD3BK3mvfOhRuiVwwXv6VQh22D8jK83LDPCSjfwQ0BDrzm7y5N?=
 =?us-ascii?Q?kP30YT27cmqUFff15Ubiizc+btiWA/WHYsembLFEU0NnxGA/CNaG1CXE883e?=
 =?us-ascii?Q?SPLkWfWrkTGeusavom/+kCTIHHt7wFE3vWxf2/dBKroIuScn7HYX+mvAfsXn?=
 =?us-ascii?Q?lzkHf4NXVsW605S5g+wTqaVIN5XfJyDMLzQJyuNGYw9WCTS3JiV8rVcyVp6M?=
 =?us-ascii?Q?+utAJeiASOD5guuECgFsDtN522I+hEHlHKsSqr37slPn8ICDo8lHMek2sjU0?=
 =?us-ascii?Q?sd6K5PNNaeFjFaEyhcrdazlmgBQllIVXiX2kiKh6EWYx/cM6ckUt0WY84v1I?=
 =?us-ascii?Q?UMH64yM6G5l0Dmm0eIKMdIfgo1u8eDd3BnTdellcfQe182jnoz6JI8febhaq?=
 =?us-ascii?Q?IW30WnmXCoMn7NkUZZj0zCT4dVwYg/ryqHBl/D/daYTqxcoF9WCBO90vUJam?=
 =?us-ascii?Q?DFmYLiQw1mp0dx++aMRLLZK1lvEFyjztrC09JoCQfoajLXMcD5oB0LKEq6zs?=
 =?us-ascii?Q?DQLauvut5IhJkvkeZW+eMmVPUdw8jxfb+8j5hQC+lOejgdqRCyt0ZByoLPhs?=
 =?us-ascii?Q?JlqI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c27566b-e1b4-40cd-82b3-08d8bdd90fbd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 06:52:04.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlcfmhOFjfN/IQ1uxXf1tUduPiwcvuoUg5CAIv+D5BxxER6DDgm8GzMwfKxiuRr2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4751
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/21 =E4=B8=8B=E5=8D=882:32, Qu Wenruo wrote:
>=20
>=20
> On 2021/1/20 =E4=B8=8A=E5=8D=885:41, Josef Bacik wrote:
>> On 1/16/21 2:15 AM, Qu Wenruo wrote:
>>> When __process_pages_contig() get called for
>>> extent_clear_unlock_delalloc(), if we hit the locked page, only Private=
2
>>> bit is updated, but dirty/writeback/error bits are all skipped.
>>>
>>> There are several call sites call extent_clear_unlock_delalloc() with
>>> @locked_page and PAGE_CLEAR_DIRTY/PAGE_SET_WRITEBACK/PAGE_END_WRITEBACK
>>>
>>> - cow_file_range()
>>> - run_delalloc_nocow()
>>> - cow_file_range_async()
>>> =C2=A0=C2=A0 All for their error handling branches.
>>>
>>> For those call sites, since we skip the locked page for
>>> dirty/error/writeback bit update, the locked page will still have its
>>> dirty bit remaining.
>>>
>>> Thankfully, since all those call sites can only be hit with various
>>> serious errors, it's pretty hard to hit and shouldn't affect regular
>>> btrfs operations.
>>>
>>> But still, we shouldn't leave the locked_page with its
>>> dirty/error/writeback bits untouched.
>>>
>>> Fix this by only skipping lock/unlock page operations for locked_page.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> Except this is handled by the callers.=C2=A0 We clear_page_dirty_for_io(=
) the
>> page before calling btrfs_run_delalloc_range(), so we don't need the
>> PAGE_CLEAR_DIRTY, it's already cleared.=C2=A0 The SetPageError() is hand=
led
>> in the error path for locked_page, as is the
>> set_writeback/end_writeback.=C2=A0 Now I don't think this patch causes
>> problems specifically, but the changelog is at least wrong, and I'd
>> rather we'd skip the handling of the locked_page here and leave it in
>> the proper error handling.=C2=A0 If you need to do this for some other r=
eason
>> that I haven't gotten to yet then you need to make that clear in the
>> changelog, because as of right now I don't see why this is needed. =20
>> Thanks,
>=20
> This is mostly to co-operate with a later patch on
> __process_pages_contig(), where we need to make sure page locked by
> __process_pages_contig() is only unlocked by __process_pages_contig() too=
.
>=20
> The exception is after cow_file_inline(), we call
> __process_pages_contig() on the locked page, making it to clear page
> writeback and unlock it.

To be more clear, we call extent_clear_unlock_delalloc() with=20
locked_page =3D=3D NULL, to allow __process_pages_contig() to unlock the=20
locked page (while the locked page isn't locked by=20
__process_pages_contig()).

For subpage data, we need writers accounting for subpage, but that=20
accounting only happens in __process_pages_contig(), thus we don't want=20
pages without the accounting to be unlocked by __process_pages_contig().

I can do extra page unlock/clear_dirty/end_writeback just for that=20
exception, but it would definitely needs more comments.

Thanks,
Qu

>=20
> That is going to cause problems for subpage.
>=20
> Thus I prefer to make __process_pages_contig() to clear page dirty/end
> writeback for locked page.
>=20
> Thanks,
> Qu
>>
>> Josef
>=20

