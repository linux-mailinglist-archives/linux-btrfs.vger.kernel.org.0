Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF11865E755
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 10:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjAEJHD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 04:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjAEJG3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 04:06:29 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E06050159;
        Thu,  5 Jan 2023 01:06:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGEk3duM2rh2gl/wU72Qin+QvilR4diYYquYnpD4VchoALrr+qXqpRoHgPxei8vvk8kVnXe5KuIT6EqydV9kDrkSn61df4s4i87qWywDKkIb+tXUTIzizPIKCgy7my03zHe5RW53e/LqBly8B7l4kb6Q0CPcWoJjTCcNpykHSmKfBFWQ5+gtSPtU19UEZmsbymKeA8feJy4MWJXZP6B0ldSw4AS6m2XyUlqOjqoknn3jPHdZO+IyLsa2D3brbCFbgRQz/Sv77+sjA4N+i2EOO2g92LV2XhXDtf7oNebSxGoqqvPawAwPP/o+IevNtSDbXOVUdHPfJ/QeQC3qXQtw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJMKL/CvJq/pZDv853N4swfnXEDFYxCPFYQMCrQiZUQ=;
 b=apy3L1LeGryTbCv9nIvCNUxWFQfIShvEu1+UIiWiWSGcYGAopXjJsUUx2cSOid9f3q/TC9Ipdh03HZ1Dy2d9NVjthe2wXjbRPwKtOHcaggqTJRBEnmjNURT2sEoLatLIGe235YO4vaCmdRnIKpJiy2dMJAvRZqp0nipPD+4slAs4cNJSLb4tmtuqIMeH6MIK64sdr868VLJwjItjO57FXZWSLTXjnn2IBci+MeLcMbe7aRU1xuthsw3aTVXooiTKzd0r5xjNJcSiHFsylj//3W3xNoWgVMMraZ1LE8lFynNN4W8lYtR2ZZw1sVL5awiW6yZIUikKGAfGJH3a6VN1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJMKL/CvJq/pZDv853N4swfnXEDFYxCPFYQMCrQiZUQ=;
 b=NujT8fbXz6Anxwsdcglf43Yh2BcSfBUiIXpKG3j9IbSV0D0R3XMOAExCE74yK5A0qLDGT+WDSt5XTBcOYJThd/2tcgZ64kJq2JVSLEfmvTQ5LmLmxkiccAxoH7y1I4ejmOZZRt07QZ+6aO1Y0XgC/Rlyx/8THIN/gWegtowoE0Z79cHMmUqQM9wBoALgnFOL8kTxaOhqBMdE3yudb1lGXwrRACoF9ZmY8vbKSRj46Sx2uxAXdajeyjvxguyCOJvxIEIURw19SLBCUFbPPq4wDDm1pn/ucjFIvs2z1+0pX5vpDI1O0xQHoB/FpyYrSCewzv7o5GPEWK9zFdXbz8KwCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8835.eurprd04.prod.outlook.com (2603:10a6:20b:42e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 09:06:26 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%9]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 09:06:20 +0000
Message-ID: <ba9a15cd-5d95-d766-19a7-17e0925bc63c@suse.com>
Date:   Thu, 5 Jan 2023 17:06:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH rcu 18/27] fs/btrfs: Remove "select SRCU"
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-18-paulmck@kernel.org>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230105003813.1770367-18-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b53966d-f4bd-4157-bac1-08daeefc1c5e
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uG5Y8QHjMewTjqHHLkfY7A1e8Fckb1lByPx1rxw1RaOTmnifpMxcRajh+UIKhTDlPstmSmptsZ2xxNsnlZw36bvEuUFJtycYN9bXlxpqcm9er2mlfvV+Bp5k8Gn1XlVO93LtXSk8AiMMjs+sdAj667wbQZz/W59YOYL5lgiN+8Tn3Ff4fQBc/J96+wisbzSfs2OngoTHTerC7E1A9cDgVLr+3A2A3dehA/qriioAAIIEhj1F4LikhiOTfag4qr84eTSGX3qGg5JhvbLwUAxVWtyiwSGpG6I4mwDG6n6kdBYcpzmdxjAnWBpPj8YPF6HtUk/3I3PeEP3+qmTX30NMOBn/v+8AXXlAbYJV/vNdF057dyoRFXgAT24rskmxpWXSN5EYPNAlY44uGY6EqOqzb8juk9km572AGLdOoHEviLzoQEHHp4z9Zve3M7wBWSrsAiwfUhSVCzdz+a+OAXqenqe4BNIAgifb8fmh5Fmx5AOkBaKwENDG4pE4ki2+KAWJF5tOz9RogcNct36ujNB6X0VuzpTS+wHiqjnoMTT1ICtaf6hLYYv5yUR1833dVZZ9Lv+1xytXA0jCp8RhqkFpbvZQAs5Dtyugm4wCmSDqzuR5qGRvTt26p9yAjPr7FU36vA53ZfPTMHDIQ/jx1BNqpMlemWop9H5boscnV2VdQNM8bN+Y3q6MyQDlMEVaYEISGlsB8lu8OUOFfl8tFdk1g37yN3gds2iAEa5h44XXiKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(316002)(2616005)(478600001)(31696002)(186003)(6512007)(6486002)(36756003)(6506007)(86362001)(5660300002)(54906003)(53546011)(2906002)(83380400001)(41300700001)(8936002)(31686004)(4744005)(6666004)(38100700002)(4326008)(8676002)(66476007)(66556008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTVtYVNtWkpvNlVNdzR1RmRidGY2RURpRXZLS0JSbFc2Z1VBWFVzaXlQSXRY?=
 =?utf-8?B?VVJtcEwzZi9aOTVrRVJDNHYyOUNUZDZ1ZXl0SmdnWDM2TU10M25SOGtaa2Y3?=
 =?utf-8?B?a010Mm96Ui9STjFrbks1U0UxbmNJb2M4OVgvUWkrQlp2UHBXUXh3TUZDVi9m?=
 =?utf-8?B?ekFEK0Q3ajE0Q1dHbTdIOWhZYnh2a2ZaT2lwZlpNOTZ6TEltU1NiNlMwQWpm?=
 =?utf-8?B?dmZxS1V1UGMrSGx5T3RIcFVlN01RZ1NQb0E3M0xaWVpnQ3N5L2dZbWMxN011?=
 =?utf-8?B?cTZGTmcwNXZNOE94eG1rb1Z4S0VDb2REUUZ3QU9odTRBRlBRVjdQbXdPVmFl?=
 =?utf-8?B?c0V3UVZDNTJ3eXVHbHhaR2trNUNYdmJFVko3VktBK3V5MDMyeHZ3bUYyWHRh?=
 =?utf-8?B?c2czV1UrL0lBM1N6dUgzOFpDQlRFblViWnYvY2N4dDdlK1lMeHNnQzFjT3lz?=
 =?utf-8?B?cmZUMVZ4RmJmNG5JSUllMkRySmdMOEVOanE2d2hlMS9iaEY0UXZOQXpmRi9N?=
 =?utf-8?B?dmw3OTVEVnZQOWhzaW1QRytOdnpmb2R2eUFFWlVmc0NCYVlCZDY4SkVMczBr?=
 =?utf-8?B?dFd3OVlWbnZBZ2lsRkRxK1c3UHR3U3VNb3EyWDlUeVJTMTZoaVVaMmFDK2pE?=
 =?utf-8?B?SzdXOXZzV004VHV1ODZnSlVJTGR0ek5YOHBMMkQvdklleUdXcTRpcjZ0TGZa?=
 =?utf-8?B?dGh6TGNJSTRETmR4Y1BrckR1WXFQRnZ5SkVpNUdOdVBBSk9sOFBvZkxrOWtW?=
 =?utf-8?B?M2pxcFprVE5BdlBBTmpsMTF6OGJGSkhxUGNZeEF2aHh5eUdLSDF6SjlqRW9m?=
 =?utf-8?B?RXRIbWJWdSswSEZoNmdsQ25SdElvMHhVQjlGVnB6aWJtQ3hRVk1EbEVKMU9h?=
 =?utf-8?B?KzlsdzIrSUlYOFFKdk9wL3p0cnRWR2c1VmFDT1RzbUZUM3ZuUlJLUTV5eUFk?=
 =?utf-8?B?NzFnd3p5bnpMUnFseGxHMFJFT0xWRjFCT0JEbSsyL1NQUk1SS1BZWXZMUnZm?=
 =?utf-8?B?dTJYY3Vra3NaQkVqdUJNYVhmK3BLRWlGODJpendnWi91ZnZ2RzBWbkZpMk1k?=
 =?utf-8?B?QmIwby81STFvcExjdkc2dEcxNmdHU3NDb2FPMjNDR1o1K0tsVW9nN3pka1BT?=
 =?utf-8?B?cGM1SkhwU1p6TFlDTGJUSDV1TnMxT3ExYWV4VXFvZEU1Szl6SEcrQktiNllT?=
 =?utf-8?B?UWRGSkNaQWRTOXJ4YTVQR3hsenE2N0JqN0p1QU50TWlLaUltSWVPb2M2NXAz?=
 =?utf-8?B?OFJPZndDR2JSWCtDeWo2OTZqUXgveHNqczh6alloUVRQQTUrc1MxTmJVMW45?=
 =?utf-8?B?dDNNazBNRHlrNjhpVXlqUk10U2dmeUUwODdkdHFhRmxkQXFvS2U1dWZZS0k4?=
 =?utf-8?B?VFQyUFgvc3VGSGpCYjdYWUhxS2d3aTNhUzVlRjNlOFJheFdKTHhDWmQ3cFpR?=
 =?utf-8?B?T0dLM1FqWHovZGxFWnRab1dsR0htaDcrL25PaUwvbTJGUENOMndPMloxTElN?=
 =?utf-8?B?bnBDd0d5dFIxWEtMeHJoejh3bmZRVnlDcnZNaHQzMW45WGxDcFMwazVVZi9D?=
 =?utf-8?B?eWovSVArYW1BTjkzQlpGTWlQcnlTZlo4cDhzWXJhQnMxRkpVanpGcG53dUd2?=
 =?utf-8?B?bnQ0SnRGckZ3NU9CVUVwWGYxcjg1RjRaVDZROU9TUXUzcGNCbUJwNHNCTGh5?=
 =?utf-8?B?QUZVbE0zeHZUTmJHNVFObng0U1NEVVFqOUI3NEsxNGFsWVVOd1BHR3pUVm9S?=
 =?utf-8?B?NFdZYzhJTkdkZ1ZwYk5WUDUra1ErS21Ra1RHU3JCbk0xcXhETnZGeU04VFVn?=
 =?utf-8?B?MUJJc2UwVUR0K3UrejR4S1FNbHhOMzc3WnBlcUc0Q3RqNmQ1OVErT04ya3do?=
 =?utf-8?B?WkVzaGwvY0Q0OERFV3BJNVl5MW9RNnBOaXdhOURXYWpDcFdTYjNPa2s4WE1C?=
 =?utf-8?B?N3FpTVg5TDV5bG5pOFZRcjNvbkVtQUVEbzZmOHRVSHoyMWFDUi93TXlpdEFv?=
 =?utf-8?B?RDJhN0tTZ21tNVZnSWhlSHduWDM1Y3Q4VmloOFdFVWhFL1lDR0NsQ1ZRdmxu?=
 =?utf-8?B?SUsrQ2ErSnZSM1R1WlVJcjBuUCtHYU8wek9LSk53TjdtOWdObXFHZzhWMEFM?=
 =?utf-8?B?MGo5aVEzV040a2Z1UWpZWFR1OUpnM29sRURESHBvSXB4aTA3dXQxWWlhSFI4?=
 =?utf-8?Q?/SZiIk31z7jb+98Ygq0l2sg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b53966d-f4bd-4157-bac1-08daeefc1c5e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 09:06:20.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ldn5zjHJM7C9/FAERhUAMrDcmXmWjfBlaVEPHBndGn0pggP3uU11LfK/cl1aYTQT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8835
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/5 08:38, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Chris Mason <clm@fb.com>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: <linux-btrfs@vger.kernel.org>

In fact, since commit c75e839414d3 ("btrfs: kill the subvol_srcu"), we 
can completely remove any SRCU related configs and even includes.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
> index 183e5c4aed348..37b6bab90c835 100644
> --- a/fs/btrfs/Kconfig
> +++ b/fs/btrfs/Kconfig
> @@ -17,7 +17,6 @@ config BTRFS_FS
>   	select FS_IOMAP
>   	select RAID6_PQ
>   	select XOR_BLOCKS
> -	select SRCU
>   	depends on PAGE_SIZE_LESS_THAN_256KB
>   
>   	help
