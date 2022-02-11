Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9DC4B1DE7
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 06:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiBKFaP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 00:30:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiBKFaP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 00:30:15 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE3BE4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 21:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644557411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ZxoNHJMxL2EEsv+hSKMMsvM5uyXwqYNp6SBlsicVPc=;
        b=QxzYZ7EuXGJCWFDFvBPkJ3rRBhvQ+ckV8zb1K4mJoU0WuPWO0gbZSU+1EnHQ9z52FkqoaZ
        +B7J2D+StOg+pJI6UIXiclnCXXouYU8odWvKPy0gM9iN0KwKmHi2t9Dgh7paPMmZhTnbDs
        UySrV6H8BT9st3WfFRe5J8r3YQlfmcg=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-Z5ra7mtyNy6K0vDAVJxVzw-2; Fri, 11 Feb 2022 06:30:10 +0100
X-MC-Unique: Z5ra7mtyNy6K0vDAVJxVzw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXGz8UCxx1vLy8IQaDzDgXmCYBTZeezr1+8rpAztGxQvpWB8uYJW7KIGSQ9xyGgqMSg12j459u/ncf0ecJqsrn/RGXPDsDU/JkaDatZ7nQydTSnuAj3li97kw5SN8SF62hjSGxL4Trh//xJdlm0dqqEgYP6xCQSPFRl10aGkcx8DYC0GIpahJbBALBq21KWh1yIWH0MqL4UUZqjGRI7cOaHLWEHnpxivZ9aBeF0fBsVofLgWtCDL5VncU37i/gP/qOOF+TdVxuTMuPYwG6jefNQ778Gd7ujBAM1Mr0vw2H4BbTIVz0pVgYYefoi7pjvq/36wSzHMtn/WUo91ZzOIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZxoNHJMxL2EEsv+hSKMMsvM5uyXwqYNp6SBlsicVPc=;
 b=VwUdItxg4gFdi78Z9q/GM0uAJgGosXUNzrdAlwegu/vYCoAyJQJsSFOi0CgNpSy7QmIT+MG7tnE0QxhO3yIKm6OkmKgMaR/cPpp/MIaHpBYttrR/17ZSLsZy2R3BzUd2ayaFq/1ZtGZ8K5am2FZRgJ6JueoA6DYpTyL8SEFRA5Hu1zFLY81LQp31qqjsXXg5dvBS+7c2fE5GEkJxp4RfNdKpxWG90mSkGwlpg2jrk2e8OjK+L+RpBmRSCOu1+3T5NUmhdnzZ4Du/+1yN5zAlY6+WW92otsspQtJ0HC1OpFs/YYihxjJ93NhvVSMsi+GHn+1GXpPnc43JyUkEjMnvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AM0PR0402MB3348.eurprd04.prod.outlook.com (2603:10a6:208:24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Fri, 11 Feb
 2022 05:30:09 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.4975.012; Fri, 11 Feb 2022
 05:30:09 +0000
Message-ID: <71663419-4771-7c7e-1d01-4d55da851c40@suse.com>
Date:   Fri, 11 Feb 2022 13:29:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 0/3] btrfs-progs: detect and fix orphan roots without
 orphan items
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <20210625071322.221780-1-wqu@suse.com>
In-Reply-To: <20210625071322.221780-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:a03:100::16) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37965215-64da-414f-e3c1-08d9ed1f9152
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3348:EE_
X-Microsoft-Antispam-PRVS: <AM0PR0402MB334800B5E70CFC82FE6EA923D6309@AM0PR0402MB3348.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n1fPElWqXHIPVf3w8qERMQ54gDN3djWf9a4QsJhPxqcxywFEtRBhs7UtlBDvDNFriFG8tYPfNQ/Sz2VBiKb5KSLQ0BPobFe3rBeGW9+bngKOwTsuIBAV711K2bM8DqkgwNMYpBgNo08uQQF1Bxqg7O2DSUKEZRSZFtIZa02bEI4Dy075cMVRIWVKOb3XLfohYn/3C8BzLW25SkuTelABQAhDuxYutzjvv5rhOz+vhiuiawGBeKzqC6Jd76LhsICwPdebOIb7abgl0j8IBxKuGjsVBN6jJBSGhdcSVOK1c7OpQdG8NkJ9w1ng0r6LZTBPPqbJTcs1fUh+UDVTB2Wz6eUAjGM/PrtYR6xm3QN+Uk7OSumzqmn8cw81pdLeiypoJwKDqJOG+GSD0uz+07BjGlWj07QWxVWcqGTRNa+feAdYC0cRkbA74GVrP8rhZDbnbTQCotCIMCqag/y6gE2PUTzzyZaR3KB0arekZ85Kaz8yYCavygTqhvbvbZSULhMqGVAfNu8sCc4dPr8LunM09klHqI4Q3yd5bj6pHvlBVMnh/75BbR3iYqF8GnHBT0SC8b63rKnyrB7U6C1UORjTh5eCqZK6ScgsaDCgOWFwvEk5P+vrzyeVR2FiJUYHlKcN7qXgisiyBBfxtWFjoW5rd40+c9JSsXOnZpZe1E/Gf0i7+HR1Hko1juT1i0ntFbyoZGPzw4BwC4ih0XWOdmiYT6Ejr6B1m9hxdJrOCmmJkMgR1z1oN6HTFEdp659EgLJSk0w94lgu3Z0pqWne0gHr5riEoV5uXujYxPW2mnuw1NV0Mt/FG44z8P39IfwDIsx1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(83380400001)(38100700002)(2906002)(66946007)(66476007)(66556008)(5660300002)(8676002)(8936002)(31696002)(6666004)(316002)(2616005)(53546011)(6916009)(6512007)(6486002)(186003)(26005)(966005)(36756003)(508600001)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2lmSlRWSTB2WTV5UGYrV3M1UkJmV2ErY2pId2pPM2tYZlN4NURVRjRpNEtG?=
 =?utf-8?B?WUdrQjVRdjlLbExWZ0NJY2NvZUNQZlhNV2oyVTVhQWV5RDQxeHlLM0kyV2lV?=
 =?utf-8?B?R1F6eHNUSTJCQVN1YUxvaWVzQzZpcXJNQld4VFIzK3dFcThpVDVkZWxnbkdU?=
 =?utf-8?B?SkltZ2dQWE9mayt0REYzRCswY0oyNndUQ3ZXOWY4Y1hDT2NVNkZlVGRPMEVj?=
 =?utf-8?B?M3JRWjhLalQ3b0cxMWdQN1lhM1ZFNnZQR2JjenlUN0d2ejJING42TXo4aFV2?=
 =?utf-8?B?bHBnYU1HWm5URStoK1B5R0xlcng1ZE1GRjIwelI1Q0kwK3kxZExDeFVsTElK?=
 =?utf-8?B?NlBqVWFBNmJmZTAyWEFLejBBZEd6UXI1NldhMTlPT2lvYWQ2WU96QnY1ZUha?=
 =?utf-8?B?aC9RbGdEM0QrSXd5YVJsUEJ0SHBUV1NSTTgzSmttbVZCUUVHMURnampIQmZi?=
 =?utf-8?B?citueWpndW9QL0FSMVNhNWlEYVNaR2pqajhYTEhlVFZIMXdZZTM3YXJPL0Y1?=
 =?utf-8?B?cUJYYlBnOWw0aDBDMllRK21KMEpvcC80UklGRk9JZWc5VGp1VEtsQXNXdnZV?=
 =?utf-8?B?VEk1cTFlWU9Zays5Ym44QmhEWUM4cWUySnc5Mk9YbXRHOXdyYklxRVhmVGJ4?=
 =?utf-8?B?bENaVmF0Sk53TzNPYUFsYlFqOFo3UFlDRDhtYVV2NzFOTTVVaTZadmtFL2xJ?=
 =?utf-8?B?cHBVa1RDZ2NQOE5mOGdhSHFLcWRFeDZjZ1BSL056bm9jRCsyNW9ucGg2RDF0?=
 =?utf-8?B?R21ZN1JKbE1BZVhMWmdTUFk3MVV6UXZnVHJrcEVJS0pkakNHM29GVktLb0JO?=
 =?utf-8?B?UGNQVVBGdlpsRTZyUVVjN3J4MXhmNUpMMGYzR3JCMGFpZVpEVWM5Rng1aEFr?=
 =?utf-8?B?ZEZVRENCNkhtQlNReXpUZFB5MUpEMVo1ay9oVHBDWGNKZTVWenNvR1VxS2hL?=
 =?utf-8?B?OXVJWW9ybm9lVW5pd21GZ2NJWjlkNHZVaVh0QUN0Y3FkMml1RVg3WUdIQmdP?=
 =?utf-8?B?WmluRXFCb2RMQUliOFFGYjFLZ1JzcjEzTjBwaVJrMjZwc2xsdmhrc0VVdlNE?=
 =?utf-8?B?NWkrcG9GY0xNdWpWVGg2b2tyWDJDN05wdHFUNmZ2OE51eEx6aTFrNWhwSHo4?=
 =?utf-8?B?V0xVWjFGN1NLVlJxbEM4dHE0RTQ4UkpwNHBodEl3YXhLTmNBekdiZE9XcnpI?=
 =?utf-8?B?aGxLNVhiYnoyaVUrcGpTakFsT3BHVzgyOGpkYjB0ZlFpd3VwOURRYWl2dEF6?=
 =?utf-8?B?WDFpVVZxVkF6QWZqN2hOL3NyYS9VWWlWQTAxREVESWxmd1lqNnNtcGJGaFNW?=
 =?utf-8?B?SWNxNDFtYWZpZ3JMRTRDVDVTbysrSTBXQ3JLWmVUOXVZOEdqS2VBc1RnU08y?=
 =?utf-8?B?QTQwYXcyeTVqM0VHRlNTUnd3Nys3cFozaTB6VDA5Z1EzZk5LVkRUdHhOKzlY?=
 =?utf-8?B?R2dtaVBSbGw1em9pdFV3QXBVWUU2MlB3R2g3QkRCV0txa211Mmo5elYzaTQ3?=
 =?utf-8?B?VnZ4YWI3S3lIRldGQ1RGR2tRR3Vud05Oa1JDcGovSUFLTmROYlFTWTZOd3N0?=
 =?utf-8?B?K0dBYm53THF4Q0V1QmdvUEtNVjZJZmdYK0toNS9ZMW1BZXQ4bEhiczNTZTg0?=
 =?utf-8?B?dElUUTVOQUlTSkNlUEFkTmVjRGhpbkVacnU5TlUyakFNOXZaL1BKMUdnZm9S?=
 =?utf-8?B?bTF6b281RURKK0pDb2JYTlhCcHJSckd5RVdWL1d1RUJObDZ5cEM0bEd2RUZI?=
 =?utf-8?B?Rnc2V3BvczVMTHBpdWc1anVIVDA0VVVGMTE3RDFhZ0swbkIyeHdORThiU3Nk?=
 =?utf-8?B?TkpkaVIrZzUvRUdxWGpSQWg2bndpenVZZUYrQ0QvQ3lYaGdCbVBPU0F6T1dM?=
 =?utf-8?B?MnhubEJlem9vUjVycys2WnJZbjdSdGxPbE83RVF1T1A4U3R4clZpaVhYSUo0?=
 =?utf-8?B?NUlFTks2bytFaGJTZjNtS1RHMldkc3FmMlhLK2FUNHNGNEw2WWFDNlNBN1V2?=
 =?utf-8?B?bS9mNUdDLy8zQ24zSzJiUUJ6RW9PbytlSHU1bS9KSzRwSjZmWmFmQXB6akN6?=
 =?utf-8?B?VDBNM3JEMS9qaWVLYVRBZVZNeFoyVktEekRmUzhsdGNJYmN4aGdKaWcwNlNk?=
 =?utf-8?Q?jY0Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37965215-64da-414f-e3c1-08d9ed1f9152
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 05:30:09.1608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScOr2OaQDTUV2bM0kL+HAsU+V9+mLZWBFkDjvSv3IKGnd/t+7aj3LRXgyM45FNrL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3348
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

Any idea why the patchest is not merged yet?

In fact we got a newer report on the same problem, which this patchset 
is definitely going to help:

https://lore.kernel.org/linux-btrfs/c75599fa-3b4e-5a5a-c695-75c99b315a06@gmail.com/

It has two subvolumes which has 0 refs, but no ORPHAN item for it.

Thanks,
Qu

On 2021/6/25 15:13, Qu Wenruo wrote:
> There is bug report from Zhenyu Wu <wuzy001@gmail.com>, where even there
> is only one subvolume, his filesystem still consumes way more space than
> expected.
> 
> The problem is, there are 58 snapshots, but all of them have no
> ROOT_REF/ROOT_BACKREF, and all their root refs is 0.
> 
> But strangely there is no orphan items for them.
> 
> This means, btrfs kernel module won't detect them as orphan nor queue
> them to be removed.
> 
> "btrfs subvolume delete -i" do no helps, as it still requires
> ROOT_BACKREF to resolve the dentry.
> 
> For now, we should teach btrfs check to detect and repair the case by
> adding new orphan items for them.
> 
> The root cause I guess is some strange behavior for orphan item insert
> and subvolume unlink.
> As the report mentioned that he had one forced power off.
> 
> Qu Wenruo (3):
>    btrfs-progs: check/lowmem: add the ability to detect and repair orphan
>      subvolume trees which doesn't have orphan item
>    btrfs-progs: check/original: detect and repair orphan subvolume
>      without orphan item
>    btrfs-progs: fsck-tests: add test image for orphan roots without an
>      orphan item
> 
>   check/main.c                                  |  37 ++++--------
>   check/mode-common.c                           |  56 ++++++++++++++++++
>   check/mode-common.h                           |   3 +
>   check/mode-lowmem.c                           |  42 +++++++------
>   .../048-orphan-roots/.lowmem_repairable       |   0
>   .../048-orphan-roots/default.img.xz           | Bin 0 -> 2584 bytes
>   6 files changed, 93 insertions(+), 45 deletions(-)
>   create mode 100644 tests/fsck-tests/048-orphan-roots/.lowmem_repairable
>   create mode 100644 tests/fsck-tests/048-orphan-roots/default.img.xz
> 

