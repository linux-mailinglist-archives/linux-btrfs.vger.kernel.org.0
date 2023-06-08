Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEDC728C11
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jun 2023 01:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbjFHX56 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 19:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjFHX55 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 19:57:57 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC62D52;
        Thu,  8 Jun 2023 16:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFGzBWXwnuoqPX6O2VtC9SOV261SxLFHTVs7zi1ApgvpNNz33o86o8zV4Z5Jwd81LiJ+kcSiY5tNwpB28VRXSEklCP9K3XC+ei7KvALJYhhXwSGNURZl5JkCZb/mO30E4ElKb2q1kZB5rZqaZ0X7yp2TyKoOEdbSnC8RpyupIqupf0NiG4x0Vg7+26dNhTASlmS7OU/t1Jo39+U70BsYmPRTdQDnBlZLR6YzcWvzOTSnJsKkvftMLjxiT2SbXKAR+PdfQqF+QBGBR5Uyti5fa/W4l62RsZ9vXbjERjuUBYgzrCwbWjTJw2GjBJpH6TUPKB0NEUysiw4jkcFg+L/YBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDabEfizBbWgST5oWdwpLoZ3yQSXbF0TLhgWxz3zqKk=;
 b=NAo5WlgvgVLHZ/e9gkPv6zOeD6wWAnSJShs/Pp8ckLCAL7LZO6sEJFQPX6wSQPy5HSxLYNV597uFVMaGjzyyRuktaPEzn3k13bebqOVNODST7dOtP2DeoRHCeqhye6QEaTeCvdJTo1ZF1M1cG+JzzONcNVagmwKKQx7wqihhIe9e5nyJ/67txNHntZ3H7T+Wj/qi4L3Qa5kvOG1r1F80I9KpQZKRzRdPo0ix3KpHo46RgLZ+cUe9ZoVgagyJ5l+/MID0IEFTHtFmfZTIL0IaV8U3Mn4n5oGtqjCwjIo478NuhoOWhTqNhfnVCct7ryLioWnumgknecB8/9aLoYOz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDabEfizBbWgST5oWdwpLoZ3yQSXbF0TLhgWxz3zqKk=;
 b=KieWHQS5L/Wrm/qOpQ8xiYHzm3YFfxLZBJrH6N/5cIDBqT/3OtAkEQi9YwD9+T8eraMHqXqFt9tDbRa9/lcUTxrPJjMxcEA1MRxPfo7xtlUTCLv5NMl4FxKXh7K5BfnFg8Bsh8+l7ea1VTkJ/kMX0UDXPX+ijpeMA3Bk+NYC8k5D6YLtR4+vZJclLZuQ3nM1FcrUYeA49k9rL+HFL0X0v2OdgmZmAuI/315Ipl9UJ6mOZ+En20sQQarL1+xdVwAjnyC8uo1VQA2z6F34a2Hf379NUriKcdfEfhIXVOlU/fFe1UwXQGrJ2Td19KlGpItvZgSwZ9MHkse9UTKmG42FvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB9PR04MB8494.eurprd04.prod.outlook.com (2603:10a6:10:2c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 23:57:48 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%6]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 23:57:48 +0000
Message-ID: <5790cd5a-04d9-bfe9-a8cc-0c09f784222d@suse.com>
Date:   Fri, 9 Jun 2023 07:57:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC] common/btrfs: use _scratch_cycle_mount to ensure all
 page caches are dropped
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230608114836.97523-1-wqu@suse.com>
 <ZIHGb+KyYW72MVzp@infradead.org>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <ZIHGb+KyYW72MVzp@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:404:42::15) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DB9PR04MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: d07c10c4-3cb1-4e62-a4a1-08db687c28a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XxWyQpy2qmcxKIL16fvIsQfhdGYLw5e1d2GkdUDlejN2dmTr7faR0KtpXSsF3Ha7fHoyCBDGP/v5a+4rZe8+tCbhwmvOXdVHoc97NVKowTw/zXfBRuSw4J8wD/JHclBKn1vPOOtb50kz2pAsqNegAG3SjduBip9o05vGpoyUO088OPVfqqdp9/bythEZ+hLgxU/3tof6nkKd5doMNdH5T/nxySMhvwc73i1UlIYHJG0215k6glo+NSsjFqOzPGUjGE2autYXWdoQOLXedCzCNcW0ywRpIBUegvUuaNMubt3dwBnbku2xKhG9v1pPy1EPNM+hHbhJSdMF6wH3GNtxRs0hhqeQrYUxSCWXXEMJB7UGAwPffEZlL1jFDXIBMt7oUmBLow5QHMH4fPdF0Ceekf5an0uBBR/evAXMOAEgLe3C57KVungz5Sx7y9OG2Yur1Jp4kvFMkcN4M/J5lQRccNCuiDWMG5OovL1w4qPJ7qK/wr1RGlNQjlYymGUCcxZONDVXLaM582i6m0IrRJ4yh+3Pl3GQmaTrprOfAgSXaNZj6fS+uBJxGNCMuAsfq4pXeWnlONMB6ARs1haHmfpGFScq27Rs9Df6x73s60uAu12tVw/8GubN3JhUiQGxtovwt//qpgXyuFLs83yiMwBDMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(83380400001)(478600001)(8676002)(8936002)(66556008)(41300700001)(5660300002)(316002)(86362001)(6916009)(31696002)(66946007)(38100700002)(66476007)(6666004)(36756003)(6486002)(4744005)(2906002)(4326008)(6506007)(31686004)(6512007)(53546011)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjRDODFoNXVyWmZ6WUpSVk5LOUNFaHRZdkRNdVlHc2ZWREI1Wm02T3YzOU02?=
 =?utf-8?B?a0F4ZWVsOWxPQ2pDOEdlSnVpQnhPTkw1YmxXS1FEV2RVTUJVb3BlV1lySmZp?=
 =?utf-8?B?empHeDhYY0h3SEZaazNqb3BoNHhpNU9tc0lUNnZZSG1yMHRlWVZuVFBSL28r?=
 =?utf-8?B?SjhEY28xWXVqeVpHZTFlRkVjR0RvTEFsRmE0YUljeHZXYzJkMDJvajZlR0hE?=
 =?utf-8?B?UURIQTRuRzVhY01RNGx3UjFaNi96eWtCRlUvYzJjL1ZXTlIyQWtJcGIyaFhh?=
 =?utf-8?B?VVRzTnUyKytIb09UWW9NbFVSK0lPVjlhL1dOWGRDTDMxVThYd1hVaS9rZk1I?=
 =?utf-8?B?bU9OZjlBZHFnV0pMWmFQSUhmQXhxYjE0RnZPM1ZOaXRIYVUxN3cvT2QyWnIy?=
 =?utf-8?B?VURBeTJzMk9POTFBY0R5N0ZQcjZxajlseThtcGZaS1Y1RlFyNDRyTjg0Nnhm?=
 =?utf-8?B?ZWlVcHB4RDl0OUVXdVplbnl1clY0b2RyVXVXVmQ0WTNCaXk5SkJjWHdUeHlO?=
 =?utf-8?B?cThOdVdxVVhtOHh4cjQvVEE3bU1EZlprN3ZnZEhDUHhmNWhmdURUS21Hbi9j?=
 =?utf-8?B?bWNvYUprOGJkeXBBSlNTakFVYUdvcUtPUlg3TkkxTzFydTFQTFQrWnFISlJt?=
 =?utf-8?B?MEVkNVBjV3dXZHljWlpwaW5BUFpwU3FoSzhQL0NTUVo1Z0F6R3BPT2hPUWN1?=
 =?utf-8?B?VnVJb29yK2h0MDFXNS9mYWRBQUZBV0o4aXNRa3FpVFJRRWxGa2xyZG43T3Br?=
 =?utf-8?B?bXoyRXBUZEg0Qm90ZjhkTk9zcHhJTUFXSkpkYXJqNlZ3ejVBVXAyQzl5MWs0?=
 =?utf-8?B?dnN6TysycjN1U25PM0tPVFRVU3hPUG55bEIwTU4zRDNkMktiRXFWbEUybjk0?=
 =?utf-8?B?d1B6WE5FS2ZLdHRFblVKUEt5QU44WUdIdHVldlpramlOcGdpVjMra2JXWXR4?=
 =?utf-8?B?NnVGdWJlZHNrYUF2QXNDZWl0VERQYVUzR0RGcWFZK3ZYb2cxWUs3Wm5xV04r?=
 =?utf-8?B?WjhtK0ZQTzFnSWg4S05lWGNMNjgrMVEvTWJHMDV0QlBMaU14T1RGWHBIeTMw?=
 =?utf-8?B?MGkrdjNtUFVWZVlwaUlvaTBVOURpT0g1ZGlEa0tIT1dCajZzMHNTbjFXc0Vr?=
 =?utf-8?B?UkQ3QmZ6bXN4b0tHVHBZcXIyemhFai80Y3B2QjJ5MjFJaytwZ3FxQnA4Uys2?=
 =?utf-8?B?WnVDaHZNNWpBUjBzN3hKTVVoMGdxU2ZiRnlLcExDc041VDVrWndBRHhKN1Nq?=
 =?utf-8?B?SU02MVJvTTNZUWRnTW5wMVdGeDJsMGp0b21jb0xXSWQ5aVd5VkpwWjN0eDFv?=
 =?utf-8?B?YmN0UGdhQlVXYTEvaWJBL0JMN0pyYTMreHgyWUwxWU1JNVdGbGw2VWp4WkNT?=
 =?utf-8?B?Ui9JOGtzVGQ5ZTdHajVYV3dvaEIrWFVWRWZxVXRHaC90cG1PRnNGcnRBU25t?=
 =?utf-8?B?U2w0VVJscVFBVG9oRm1qVUdvalRmTWdtbStMSUxySjhBS3p6WkhiMFZ3aHA5?=
 =?utf-8?B?c0lkZ3lIckdvVTdMWURoQ0NENjcyMWlHc3NHbjRSVFUvaGtLZzh1bTBoY3pR?=
 =?utf-8?B?a3VacFFZNEJGSFVnNGtPU3hUVWxGbDhYdHJ2SHpabjFSeEIrL3hQcTNoVk9V?=
 =?utf-8?B?TVVKdEJvdDhRMHZZZ3o3MmFyeHR6VERhSGdKbk1wd1BIelhQMzFMcTFtSkRh?=
 =?utf-8?B?eFRvNUJjbG00aVNCQkh4TlhkM082TlRDQndORDliSGhHclNxa0RTVWMxa0FZ?=
 =?utf-8?B?eTZOdGprd2VZc2hOYW1FdHFUNUpleGVVMy9ROHFleGMzbTdNV0lQT3pPd0Fr?=
 =?utf-8?B?WnI0dG9yQzNHbnFybUlXbHQxaEk5OHpybjdnS056a0JhUjM0WldrR08wcjBh?=
 =?utf-8?B?aG1TMnIrUVBXVHJ6bWgwQXF4ZVhMU1VsV0duYVFzbnQ2OFMwd0NndzNpbVNJ?=
 =?utf-8?B?cnZoUmZiWlNpSzFwR1ExZFZVdlF3WTV5eHZsdjZtK2lieDBTSytUR3E1SWtJ?=
 =?utf-8?B?UWZmMHJXSHA4UXdJckRvcGlISWpBbzRXb25zVnlzK2VzSVlVekgyTTlHMnBO?=
 =?utf-8?B?TXppMDgvRzBseTIwQy9tRUZpN1lkbEdEdDN2RGlnLzJpckUzSjVvOFBjekt6?=
 =?utf-8?Q?Ibk/75Tglvx9Knjuu+9dgJ8db?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07c10c4-3cb1-4e62-a4a1-08db687c28a9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 23:57:48.0452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aBa+cxMZLNsQ+ol+wf2HjaL/64/236n+Z61BwxLQDj/tELZ1UWoWjdhyrTrDjhO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8494
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 20:15, Christoph Hellwig wrote:
> On Thu, Jun 08, 2023 at 07:48:36PM +0800, Qu Wenruo wrote:
>>   	echo 3 > /proc/sys/vm/drop_caches
>> +	# Above drop_caches doesn't seem to drop every pages on aarch64 with
>> +	# 64K page size.
>> +	# So here as a workaround, cycle mount the SCRATCH_MNT to ensure
>> +	# the cache are dropped.
>> +	_scratch_cycle_mount
> 
> The _scratch_cycle_mount looks ok to me, but if we do that, there is
> really no point in doing the drop_caches as well.

Yep, we can remove that line. It's mostly a reminder for me to dig out 
why that drop_caches doesn't work as expected.

Thanks,
Qu
