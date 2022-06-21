Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6AD552B54
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jun 2022 08:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345662AbiFUGzX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jun 2022 02:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiFUGzW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jun 2022 02:55:22 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20053.outbound.protection.outlook.com [40.107.2.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4342C1CB16
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 23:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3c8Q0GfeIWXS9XhqNqQrvtcSeb471nhWnaZzzG0keCfLqR9l0BbKhxzeQZcBm61Y7SaWpCbA8meZbuACk+kp1Kr0zK87F+D1SfVu99CcObnkVVOI6TL+xGuhBq+89pO6r4y9fk/dYLIwYCb2b83CTaaZNo+SJQEIc/Wh4NogVHoozBAqR7bdfY8g+DCZ3kl7TSJ9L91O6vaLUzlb2B3OM3EntPCMEwBwc/yITgcYxMPqMYjRCODakqyVSczvOXVv1rBEzNM9DlKCQ8KUyELQhNX0eep/TuqHK+iDGP3aXkkAUgsuic/M9o4WR5WjxcZ7eYavSm6wEUBjjkIe5u1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7uwK2hx2haC0OgltVENst5+wMdOYHMyR1Idm+FgcJc=;
 b=YxQiHRHX2zaXitfJ71bpK9MsG1z5Daku9Oaueqdm0gRgfqgVMC23Oh9eIsu8KijxxP80s0xEfYMQcszl939/hSlbzWso6PgwVAarZm1xB3tsDc10vkHqHXsUtWyh/14hiDHVVAZy7pDijV2mLg+kArwBEaItsLRJMYAyxyySbIhDgCU856htMqmBk46L3j68YubG7Ve+2npGX0zSHEIj31V3rOkY7UFziBHgW+r7TRRG0/K7uxLhCvZxfcg2rCvSrJLmvUap5v8AgxlxfWC/as90Depj7hNohPORIQZAw3FVVribJm/4EsJJCM1G2salEiSq9jRjXu3uaxbemg1ZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7uwK2hx2haC0OgltVENst5+wMdOYHMyR1Idm+FgcJc=;
 b=O8Eak3Ea4kRPaKf/ajvZpFZAmnfIfk9h6+k3niPb1Wr9j/btnpmxMci0ew3owOr3SykE8FFv74LekTkGjk1PUn6lb023xp1xf3xksnH01jy7Ql3yMUo3pWnU9ecKh6tfm6nso4BvHl8jnsr14j7rYbLBOMaUIZbB6F/SSpqPWm+9jkre8vKlGz/UpFAr3s/qtSGYf//bvTXariEUobLu5yZkaHOxmF5zxQpRtBJMP8LBhpXe+1knLFNZrJ0EAS3BzECNOTu1sQbUSglPClQEsxaSk4224GhIWPlw7XaueAKJMqwR2pw6jLu9DK5lFzeTXiGGyamUujqU/n3H5BGoMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB8PR04MB6796.eurprd04.prod.outlook.com (2603:10a6:10:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 06:55:15 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::4dea:1a09:c0d9:8fc8]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::4dea:1a09:c0d9:8fc8%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 06:55:15 +0000
Message-ID: <2bb7e620-fb2c-52d3-0ecf-87c2f75a1305@suse.com>
Date:   Tue, 21 Jun 2022 14:55:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <20220621062627.2637632-1-hch@lst.de>
 <221407c5-0aec-6ab0-4f7f-e74a5873e4e0@gmx.com> <20220621064010.GA893@lst.de>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2] btrfs: don't limit direct reads to a single sector
In-Reply-To: <20220621064010.GA893@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0091.namprd07.prod.outlook.com
 (2603:10b6:510:4::6) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbb1fd80-5917-4d47-1bee-08da5352fea3
X-MS-TrafficTypeDiagnostic: DB8PR04MB6796:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <DB8PR04MB67969A20F413B179DD7EF2A7D6B39@DB8PR04MB6796.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKFrFXBVfwmFhWaCJcERUUYHvsELPYg+d2YsSneEGInQi17//O+idPxeytzGgM25EIp3Bvk1IOYm7CGdf7VL0LhgDYrBpuIaPRHXAIRxwUneRCW1v+gdyrxMxO/tPstPcQwNKYroi14tH3yEOL2y/I7fCTke5JHdCsASBUnv0RJ6hwrGvqzoFAu3bIxBnVUzf7bvjl7WMjOODqMQi+u8vmDS1kCTEUOgaFrTTCP0pxtfvUy0DizH7Ylqgd178fYPlkaMOUP3fC7YNEE8eajO9yAgjucFb3rhplrVXj3HTIKffJZMX5L7mhbCnEWiPXLB2B4XY64I6WKHlC8d++ynRs12wa/ILbAlWJWV2ATQcgFEPPjWSS5Bu2R3zqZipKorNgZQWNFMAszU2M5/X6q8JZBhjAt2Yfxhn/3pk5LNodeytTlqV+yxpns4mdcG0JEgLgWQSF3js9h5YZSj66vYVCuvsXBqFJ+J2JlD30nT9Zz+AQeX+DGF5thuyvkH3pwTl/FEWbeuTdmIw/ViDT4CEJ6ZlP8H+T0rgN6DGMqz7VhOVBqzEQjkOcdo5zY8M4VGxe8UwbMr5pgrs2uun7wHQDWRKBQfma9oHgy0gfmK/qAbGQX2DibhlAXvweIAsViByj22b0JsrDRZKkl5TfK2Kua2qPcoSa7uimFvwc2L+jAwXDNyG5M2yeRUja3WCGS2BC5e0GOj9bT0YcrpGXHvrAwhlX/n+KQVeGlMXVINBFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39860400002)(346002)(366004)(136003)(53546011)(6666004)(186003)(6512007)(31686004)(6506007)(2616005)(41300700001)(83380400001)(36756003)(6486002)(478600001)(110136005)(38100700002)(316002)(86362001)(5660300002)(31696002)(66476007)(66946007)(4326008)(66556008)(8676002)(8936002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVhQcHBDZ0ZJbzk0WVVqYWV4V0lDZ0RSNnFwRkZyUmlFVVliQitSbC9HeHdk?=
 =?utf-8?B?WU5RVGttR3I4WWZ3VGlIc09zZ2JScHA1MkpTTVZzQXFjMEIyemVXNGw5Zkhv?=
 =?utf-8?B?d2ZuZFdKM1ZIc0ZQUngrUWNLUjlDSE4rVHBBTHlaRUxHendaZmZ5aXJabFls?=
 =?utf-8?B?ek93OWN3VlozOVVLUTBSb2p5cHJnbU4wSStxQTJFbmlKZjViVGtESTlOWVZO?=
 =?utf-8?B?VDlhYVRGMDRabmpVQ3RaZm1jOFFhL0JTUDdiem5iakJrUzRMcFZzai9ibnIw?=
 =?utf-8?B?YVQ1RzlvMTR4VFZFd2p1QXNpeXFsaGNtQWRTZ0c3K2xCL0YvSUJ6UmVlaS9k?=
 =?utf-8?B?dmhNb0tuN0p3VFZ5UVhwbGdSSHhkN2s0YnVRWWx4Yy93S00wZjFzV2ZFbzB0?=
 =?utf-8?B?SVFpQ0RlT2FHcWJWTnNVelZWTWJGaWo0cjA0V21nZVZqYmZYbHMzbmZueUY1?=
 =?utf-8?B?UW9OeTJCRHZHNThYcXhFTk1JVnNnNXV3MzFwd1hld2h6NzdsYWoyU1lnUmxO?=
 =?utf-8?B?dzdFVHpMSit1c1VVYUNtRHJMdFFFYzRLMEpkT0drRG5rRXBIMXYzSWliTnpD?=
 =?utf-8?B?b1FJdysvclZVRTZmaFBCK1Q0L3Vma3d4Wk9aNmRoSXRsNTJjbTg0elY3S2Fq?=
 =?utf-8?B?WTdYbzRQeDlKNi9ac2t3bC84ZFMzT21xMVoreG8vT3FtNUJFY0NUckxzbUhQ?=
 =?utf-8?B?eEgzZUk1cE4zTUZsMm5wN1cySXNjQ1BjM01tb1podEttc2NCOWQ5SnhPVldq?=
 =?utf-8?B?NzJIYW03R1Q5TmVaZlRPYXQ5aWJRR3JiUStBZGJTMW84WENGUVpzR1V4VzBn?=
 =?utf-8?B?OFpwcC9Fa0NNMGZWdWJNZHhBZzdUZjFBaFJXTXhPNDNMd0xGSFdOY1lkMjc5?=
 =?utf-8?B?S2o1akxXN244UnJUTzJQSHQ1NGoyb0xjTHZ0YmFWY2FTRnJlbi9yR0JObkcr?=
 =?utf-8?B?amZXMnpzVzlmYkVPSG5yV3RweTFraVdlSTUyQzJseTRVaTVydG02Z2xQYkNE?=
 =?utf-8?B?eGFjZzZ4NE1nTHBzLzdPRFhmSnluUkpaZ0djWFkwSitGaFBWRGlSa3VmT25G?=
 =?utf-8?B?WjJ3dkY2NGE0TkprRklxNHV2aXJld3Q2VzFUVzdTNFFPcmpEKyt1bjJ0bEJm?=
 =?utf-8?B?aHZKMGdXeUdlNHdiemxXUDlibys3L09ORCtwWk5xRXlXeUlJYVdqbU9VaWNZ?=
 =?utf-8?B?OXo0SU56RWp1RE13SHJrTXlWQXIzUURJem8rN2JXejJlQUZkeFp4MkErTnNG?=
 =?utf-8?B?ZHV4U1lGOStHdEExYWZzMEc2UzN1ZHdnd0ZhbnUvTk5GS2VHQzlHZEp5Q0R0?=
 =?utf-8?B?emJsSk5OM09lUmhkYmhIVjdpVXpwUnRWVzUybnpRNDgrYWhCdEpGellGdEFR?=
 =?utf-8?B?U2FKaG5ydTZrWE02aTFZVm9ydTdRbEtIZVBRZkFBendXK1lZV3VRTnp4c29N?=
 =?utf-8?B?dmtsSUxoakFBTzNUbVVXRkhzdmo2T0tuOVRyejJmUkQ5aHUwckoyZ3FPK2hJ?=
 =?utf-8?B?UkJkYis1NlFRMzJlNVNGUm41MU12L2NpYytrdVJzMkdoV1NSZE5PS1Q4Z1li?=
 =?utf-8?B?N0JoQjY4QSthSEM5Mlp2T21MbUczWm1sOFVlWk1OdnNqbk1LYThIUHBEZEZD?=
 =?utf-8?B?blBOOWFzeEFBMHdHT2FKM0FxZXREdzNWeUw1a0Joek5SSk5JNHFVMW9yeGMr?=
 =?utf-8?B?VjU4MzVnN05KMklHeHJPTXN1d29xUXNGVk1lWFRSd2lORWpTSkxNUCtFaVRx?=
 =?utf-8?B?Z1ZGMHl6cU95bXc2Qmo1U0hRZkF4OWZzUEJxc3hSZHk0V1c0RXhjL2J5cnlr?=
 =?utf-8?B?cG9IVWlOREExSkNpMzgzME9WTTZQV3BKWUM5L2RLZktWQTNUVGtnNlE3dmdJ?=
 =?utf-8?B?bmQ2bm9ic00yajdJTHdpV1lwSi8vMUU2MU1hSlFwWXZ2QmhtQkhaWjFLSXJB?=
 =?utf-8?B?YXBvSTBaQ3plcXRCS1lmZWJybkFJaTF0dHE1RmNwMnBHd0w0K1FUMnJJVTdp?=
 =?utf-8?B?aE9oWlB3bGZDbzdISUpyTW1haU14SGFQUFVjai9mQitzSkt0TCtWaGl6clYz?=
 =?utf-8?B?b29HSmJmNHMrSWVqVGo1QWlJUWwxaEVBTUEzMUpxOVkxZkFaWlE2dlhCNkNC?=
 =?utf-8?B?QVNiek9CbmRtdU1mVUd6aTVwR2dlN1VER2w0SzBudExBTiswbDRkS2JubUNP?=
 =?utf-8?B?YmxtZEs2dFRUTFZHdWZDSXhIWThndGtCSlNYY3BZbWZ4bzF6ZklMdTVhTXJ3?=
 =?utf-8?B?QmNpbTNxSTVEV2IySTlETm9KTWFYVWlHRCtMNVJER3VhOWIzMEx0T0svNXJv?=
 =?utf-8?B?YnRTbCtLd0lDeHM1Ly9GVGxaQlBZL1IxRUo1UDlvWktGNm1IVldaVEV2eGVQ?=
 =?utf-8?Q?cl6SypkzA+pt42CwTU6gfekV18drGJqnbbffM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb1fd80-5917-4d47-1bee-08da5352fea3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 06:55:15.3059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nFFT8+uTgZeLCM+lqadwlVq/9JtlkI8wH3Uk0PpRHqi7JXbKECrPhKWg70sjLEX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6796
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/21 14:40, Christoph Hellwig wrote:
> On Tue, Jun 21, 2022 at 02:35:55PM +0800, Qu Wenruo wrote:
>> In fact, one bio vector can point to multiple pages, as its bv_len can
>> be larger than PAGE_SIZE.
> 
> Yes, it can.  But it usually doesn't, as that requires contigous memory.

That's true.

> Without the large folio support now merges for xfs/iomap that is very
> unusual and tends to happen only soon after booting.

A little off-topic here, what did the extra XFS/iomap do here?

IIRC the multi-page bio vector is already there for years.

As long as the pages in page cache are contiguous, bio_add_page() will 
create such multi-page vector, without any extra support from fs.

>  At which point
> allocating the larger csums array is also not a problem as we can
> find contigous memory for that easily as well.  For direct I/O on the
> other hand the destination could be THPs or hugetlbs even when memory
> is badly fragmented.

My point here is just no need to align any limit.

Smash a good enough value here is enough, or we need to dig way deeper 
to see if the MAX_SECTORS based one is really correct or not.

Thanks,
Qu
