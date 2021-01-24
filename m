Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F828301917
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 01:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbhAXAgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 19:36:52 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:27014 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbhAXAgv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 19:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1611448543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pL56l28xxI+ecB8k2mTe28+2j21Zn99uFsMP4oEnIfU=;
        b=O/n9ANatlqMK6wh/Bo/dhai8JQdPXWerlJmA9kqplegn1rZ3D9s5AQwfSGZmA2gJ6udeLR
        RAqcb3rxhqeZBsc5ukcZEEezWx9f39WQm0OVXd6z/aBBVPhfDryDTCgujOVUkXFXYlvWt0
        JgDq+6B4jIfCkO8h6SfwxV5mQKhGOKs=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-HspCpUIiPgaMjcwK5BvXmQ-1; Sun, 24 Jan 2021 01:35:42 +0100
X-MC-Unique: HspCpUIiPgaMjcwK5BvXmQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0v9x1lctQV2S/zvz8NJHaBuk+29oBgRW8fYp62VWfZKGUiHLrtVE+aymmXLp0DHM2TM0N8/tV2DCJF252khKSf/emQHQtoobFd5ksCz3O2mZat+oUsLajXhiKcnOJHO5vTpHmIbSNDj2eYcyiboVD9NORlcwnnFE0nns0E08n85cc2yhZBFDheU0pEM4FxFf+debOymfeS9r+iz2v3ZKs8ks88NOe1NkTbCOs3cQUcwu9bp04RMavwrFV3Ivs93paG+r8706XFTQDN4NPedSw1BcsSDbykLsTH7QdI8XD5S3SXJIk3RB/lU91bgv9PyAzrC+rdUTLho9sOYQ9S4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRzUhyCZBXD57ApVnHpVY1HcH7b/mofoFEhRVc5TZOQ=;
 b=DlQ+R/KhvjoE1gpWR4K2ZgvKmu2jHD6ztHcPU63EV/xzLVJOiKjWiTDg2nokSKnLWgZ0eUzQrMtyeRfrccoKMrI/GlX0YrucX8T6GWu52An/iTb1jY/Bv2ksuppSbvHEct7tQLJd57olEcFnpLXSJN6GUSYp0Z0VjyXRbXPoQueMyqELY0R09wc3xqsjlZiIMCIAoZSPP2gIsOHkcGMcCxeOuWncSMppYrUHLLGYYvhoS8rBGkaPhmdIY4lf+GRCFsPnU66pmwryFV7cDHMM4HgB/wA0nTTPVyvJ7jWN/IGou53ThkWLr1alolk5Q/8CX31DL3jA3TF1sTtegLpzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23) by VI1PR04MB4253.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Sun, 24 Jan
 2021 00:35:39 +0000
Received: from VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28]) by VI1PR0401MB2382.eurprd04.prod.outlook.com
 ([fe80::9c:2015:e996:e28%11]) with mapi id 15.20.3784.016; Sun, 24 Jan 2021
 00:35:39 +0000
Subject: Re: [PATCH v4 01/18] btrfs: update locked page dirty/writeback/error
 bits in __process_pages_contig()
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-2-wqu@suse.com>
 <b0360753-072a-f5c5-3ea6-08e9db2445dd@toxicpanda.com>
 <c4bd841c-6657-5a72-85ac-fc8359c87a74@gmx.com>
 <bab806e1-ad3d-b34c-b623-915b39621983@suse.com>
 <20210123191304.GA1993@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <838b4acf-16fa-eaf8-e151-fc8b734c9b49@suse.com>
Date:   Sun, 24 Jan 2021 08:35:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210123191304.GA1993@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: MWHPR18CA0034.namprd18.prod.outlook.com
 (2603:10b6:320:31::20) To VI1PR0401MB2382.eurprd04.prod.outlook.com
 (2603:10a6:800:23::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by MWHPR18CA0034.namprd18.prod.outlook.com (2603:10b6:320:31::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Sun, 24 Jan 2021 00:35:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 744b9b4b-df0b-461c-b80d-08d8bffff957
X-MS-TrafficTypeDiagnostic: VI1PR04MB4253:
X-Microsoft-Antispam-PRVS: <VI1PR04MB42531F55DE7F180DC6C4B115D6BE0@VI1PR04MB4253.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqeU/wO8MbxZtkUpZrc4AbQyqgodrs6LfpBTI+U6HFu7sBYuW/JzBkMY2+qmWzliqHBPdp6WDinBMPAglxJiC5K2a20T7SkmXvXDvpkCUmys/fGWPpn1Jk6hR4Kv/wLEgbdMiQDWdJvtT7T4fH5QJFfH45iXJw4clFKCNm0JStZviGXs4HD9cp38c1+WoUN5D9X8VfRjwbFaiDFgz/AQ5UWRu3SHfFjWf1YxC1qgaweymLQX3sRP7EyJKTsMCwsTOvhIcqXyHVMivtgTdNUk/qrmQn2LU63vSxGpP1yGIL90+qTHEdbhInwiU/HeTeYMiiYJmau1hfUym0Y1VKT8MQlTf0gM8cA/egJI6O2CeFzy+u4OCOL3duUN13O59U4CXlBw3X1O2Gk1RqnX85YZWuW2tsBS7250qG4B23pNDnCoYG6aYzBGCy1Kg8PkXtX2R5WG3BtMtTs1hwO+LB75QUXHpF2A3+vvLlPBmIAzvC4WUGa5OoeXhH/j2+mdiCpqCoJbCi2EQfzUKGUmKT9f7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39850400004)(31696002)(66946007)(86362001)(2616005)(8936002)(956004)(52116002)(316002)(186003)(83380400001)(6706004)(31686004)(26005)(16526019)(53546011)(16576012)(2906002)(36756003)(6666004)(478600001)(8676002)(5660300002)(110136005)(66476007)(15650500001)(66556008)(6486002)(14143004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?//hMXVdNRK/yInD62EVLnqQphTiyqUffvG6iMgnm33PQbDU+kmI5k7AZcrpO?=
 =?us-ascii?Q?mDk8vK2WV+Beb9VdS289HZnN/oATScKUhnIcjBULwFU3hythg12cvoPOc1Rk?=
 =?us-ascii?Q?w7kCtSu0+Lg5feFogSUElseOi5vVoavpyGotSgVzL6iL7moLt5HDKvG7hsIc?=
 =?us-ascii?Q?wtLjPIeRABNj3LKNPgw0P4lRKqelfRwuHT7eku8G6bXv+iH19TFkpTFvRzvB?=
 =?us-ascii?Q?ksEd4sjd97vPSqhrOap81OWqduLeNvLlu3ypD7ySkV0IZMCMRkSgwVtjNhtX?=
 =?us-ascii?Q?L2sMKzT8YDBUCABJFqWmiranuee9zeYVBxv02n8rF1ExlusMnzJdJ2B2FgrS?=
 =?us-ascii?Q?dKuX617nYcZ5bVB0RE8eEMpullJ0rpDm5t++4QJ2h4w3lBAE4SfyQELiSq02?=
 =?us-ascii?Q?0yTsWC+GBEbsJyGs0q3xyIuVeGvZLGj2Zgwm4IaqH5AbHOvNCyS3s+s6oDDV?=
 =?us-ascii?Q?u4v8x0YZuaFGBj3u+JFCbMnx/apArXTHR58FFDjKskSQOcJXB5SpQ8UnUxGp?=
 =?us-ascii?Q?jHRdqtHygjJVr5KhM5N4B91K+R8ocBfL/6cze93tPsWJFZ//zfBfSSg5G75Q?=
 =?us-ascii?Q?I2+z369Jl3Lip1ufxfFdUNjLNkR2pTwTyFgeLc+F0VXzjvaBg2SEkvhR9QOL?=
 =?us-ascii?Q?q1fIFc3ZLOrhnELAwV5sk40IafbRpu9T+fZZ9/1FIE8xYbwJH1lamCPp64Vo?=
 =?us-ascii?Q?eW8edDyDvq0S+by/RPsJocRKCHwYufbHynZxE5Iahc73sN5ncQujXCoClz7P?=
 =?us-ascii?Q?wrvAK9k0QhcsetIDE2QqxxNdo4hnX+Csr2UKmhwJUm2yXIXqY2NWAYq4q+EU?=
 =?us-ascii?Q?FVnxalCQC/PqPVYr/1E1oT+fsxx/RMd5u5I+EzRE06DZx/yIZjU1rg+tl7Yg?=
 =?us-ascii?Q?mxKqVmw4rYHd6IzrvZNOG2rYb3GsXOELaIPtulPl8gGUlYjNix2gM3nEe/AW?=
 =?us-ascii?Q?LYq5wlPuX7Vyj3tQucSgADP78FOgfJqp0OuhIomT8XJB+Agns29dQeYDZ9Rh?=
 =?us-ascii?Q?5wR0EZj+6f6jvVssS+dNPlOxdAELc5jT3DVd2JnE/GDBOZK7bCLUPljfg31R?=
 =?us-ascii?Q?ZPHUU9Tv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744b9b4b-df0b-461c-b80d-08d8bffff957
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2021 00:35:39.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxQMDu7BZUDikxaVl4ABb+iN5Bu1ViORMnWSMcMzy+irZiPoPWX7W+pxgIDx5BpA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4253
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/24 =E4=B8=8A=E5=8D=883:13, David Sterba wrote:
> On Thu, Jan 21, 2021 at 02:51:46PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/1/21 =E4=B8=8B=E5=8D=882:32, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/1/20 =E4=B8=8A=E5=8D=885:41, Josef Bacik wrote:
>>>> On 1/16/21 2:15 AM, Qu Wenruo wrote:
>>>>> When __process_pages_contig() get called for
>>>>> extent_clear_unlock_delalloc(), if we hit the locked page, only Priva=
te2
>>>>> bit is updated, but dirty/writeback/error bits are all skipped.
>>>>>
>>>>> There are several call sites call extent_clear_unlock_delalloc() with
>>>>> @locked_page and PAGE_CLEAR_DIRTY/PAGE_SET_WRITEBACK/PAGE_END_WRITEBA=
CK
>>>>>
>>>>> - cow_file_range()
>>>>> - run_delalloc_nocow()
>>>>> - cow_file_range_async()
>>>>>  =C2=A0=C2=A0 All for their error handling branches.
>>>>>
>>>>> For those call sites, since we skip the locked page for
>>>>> dirty/error/writeback bit update, the locked page will still have its
>>>>> dirty bit remaining.
>>>>>
>>>>> Thankfully, since all those call sites can only be hit with various
>>>>> serious errors, it's pretty hard to hit and shouldn't affect regular
>>>>> btrfs operations.
>>>>>
>>>>> But still, we shouldn't leave the locked_page with its
>>>>> dirty/error/writeback bits untouched.
>>>>>
>>>>> Fix this by only skipping lock/unlock page operations for locked_page=
.
>>>>>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>
>>>> Except this is handled by the callers.=C2=A0 We clear_page_dirty_for_i=
o() the
>>>> page before calling btrfs_run_delalloc_range(), so we don't need the
>>>> PAGE_CLEAR_DIRTY, it's already cleared.=C2=A0 The SetPageError() is ha=
ndled
>>>> in the error path for locked_page, as is the
>>>> set_writeback/end_writeback.=C2=A0 Now I don't think this patch causes
>>>> problems specifically, but the changelog is at least wrong, and I'd
>>>> rather we'd skip the handling of the locked_page here and leave it in
>>>> the proper error handling.=C2=A0 If you need to do this for some other=
 reason
>>>> that I haven't gotten to yet then you need to make that clear in the
>>>> changelog, because as of right now I don't see why this is needed.
>>>> Thanks,
>>>
>>> This is mostly to co-operate with a later patch on
>>> __process_pages_contig(), where we need to make sure page locked by
>>> __process_pages_contig() is only unlocked by __process_pages_contig() t=
oo.
>>>
>>> The exception is after cow_file_inline(), we call
>>> __process_pages_contig() on the locked page, making it to clear page
>>> writeback and unlock it.
>>
>> To be more clear, we call extent_clear_unlock_delalloc() with
>> locked_page =3D=3D NULL, to allow __process_pages_contig() to unlock the
>> locked page (while the locked page isn't locked by
>> __process_pages_contig()).
>>
>> For subpage data, we need writers accounting for subpage, but that
>> accounting only happens in __process_pages_contig(), thus we don't want
>> pages without the accounting to be unlocked by __process_pages_contig().
>>
>> I can do extra page unlock/clear_dirty/end_writeback just for that
>> exception, but it would definitely needs more comments.
>=20
> This is patch 1 and other depend on the changed behaviour so if it's
> just updated changelog and comments, and Josef is ok with the result, I
> can take it but otherwise this could delay the series once the rest is
> reworked.
>=20
In fact there aren't many changes depending on it, until we hit RW support.

Thus I can move this patch to RW series, so that we can fully focus on=20
RO support.

The patchset will be delayed for a while (ETA in week 04), mostly due to=20
the change in how we handle metadata ref count (other than just=20
under_alloc).

Would this be OK for you?

Thanks,
Qu

