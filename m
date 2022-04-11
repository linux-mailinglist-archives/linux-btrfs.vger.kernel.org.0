Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EBF4FB489
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 09:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245303AbiDKHXW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 03:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241583AbiDKHXT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 03:23:19 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B7335265
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 00:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649661663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TYfPe4HNsMu1ni7+38IuLiAj7Kxe6S98AeLrPXIWfmI=;
        b=QKqMun9dsqy0uRYevxfzEWwa+ofBLWjUj0OQG24GJEArTropJGSSQ12tAA6rOYIs68ACSW
        OXXK2GNpFcQ/ci+CYpD02Je4l1on/yOJR30WxGXWxQQR7VtChUJw+grNiTCxKsymxoX7Qb
        iHnYCRM071z6/0j1MMeS45+SBExbffc=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2058.outbound.protection.outlook.com [104.47.9.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-hpRmo7IeP7qeKFdW99q1rQ-1; Mon, 11 Apr 2022 09:21:02 +0200
X-MC-Unique: hpRmo7IeP7qeKFdW99q1rQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bg7OB3Rp3Balwzxy/mluu6oty5IxLvoHtHoeKeLaM0x1L0OoAuALQMP/tNjl390pzgMkDhPWSPDfwxfcbjKYTmL6xrwrkY3LH1oBAI3cU6qdMtQ5UL65MN7bT8+JYWSxXlmaE5GNkeqzKr8Y9hPyXOxSWlU2OJhi3VyzPvxjJw37sqAuLqy6n2AH2L11aWzTvOJxZE8cw78R64jNyXYldeOr4Ym+dDeeEtpypnH6aJMLAsZxcm0oQeXkes9Z0IZXoAk6MjiQzD9nkFAvOUdSBWIn/F+087Nulu8dmMc3MPKg9vD0iz5vJ8bRo5gcZ0O2/3c7d0l4wsoQbvlukQNagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYfPe4HNsMu1ni7+38IuLiAj7Kxe6S98AeLrPXIWfmI=;
 b=Uoryu7zF4fKkEH4hWQsh0i5huPlwOYV3S/ElO1khM8NQ+HgjTTt4jqplb72HwRbxK4qslbv9HbOlxjW71ZkwJhRDQZ665lUTDVQzwGdcXce8diB5LwBbXW/aruSZ/xyEsAQWiV5aJnXIKb+OlGDhx4DdsFCYmNfAi6kvgj7JbztbwUAvUeNWp6EeRNRg+Fv5V7zSuF6TE/i3TrkeRGsY0JQ6ns9v675WDKAfS+88e8vlV4J4yDi1eoBBqx6n0GRix+9MgWw0ITQgQtUmv6HNCbM6hJTaePRcbYD3K5G9Jr+QhVRncrl0tIJNaTsV4Dyjg3fO+z7qZy713c22N8X2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AM5PR04MB3105.eurprd04.prod.outlook.com (2603:10a6:206:8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 07:21:01 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::415f:1551:a6d5:face]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::415f:1551:a6d5:face%7]) with mapi id 15.20.5144.022; Mon, 11 Apr 2022
 07:21:01 +0000
Message-ID: <32af072b-ab06-9a89-ad6b-0503106cef94@suse.com>
Date:   Mon, 11 Apr 2022 15:20:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/4] btrfs: make submit_one_bio() to return void
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1649657016.git.wqu@suse.com>
 <e4bb98b5884a77114ef0334dee6677e6e6260ea7.1649657016.git.wqu@suse.com>
 <YlPWXw+cWtMG0kE8@infradead.org>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <YlPWXw+cWtMG0kE8@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0176.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::20) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d76b3e1c-4979-48dd-2025-08da1b8bd4a4
X-MS-TrafficTypeDiagnostic: AM5PR04MB3105:EE_
X-Microsoft-Antispam-PRVS: <AM5PR04MB3105AEAFE194406786651F1BD6EA9@AM5PR04MB3105.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1nXEM5WkNuqNYBSFRbrjXvQbx6qPXPoljNQtoLCwRE0lP/K5J23dJJl8F0MRfAA3P75XeXdSTxil4mJzfRm5CgW3fkMTfrR97Kylwp0OtCWQqFvwUN9Aoi/AlOb/gVX+yLHJSQjBXDbIgauluEw9RKctviPNMIP/zXgkyCKR9BMKpnArs/wiosSzg5hEnupxSQj0JHq4hpHXLEAJSyi3NATvgSDsGbudnWYYOw+7LM5Mlfrh8qHnKTXQIqoFjqdw7YbqROKwnZ54gs/Y6cJHMB3B1e0hRJHVl3GTK6T+yyVBNkthc66/0R+WmVKKlbUpy1HZebIZvToA5lxn1oTfbOR+xceGEv2TUOgoqgKCjCBRun+S1mBgzrVihCjh0ZkynO3NuJwJAxK2GO7hIsb89N1u606OYSQ2FUZe+FcwQjQDabL07dl8Mu/UW2P+1CcfTrX+chdj/imc4RWOnXVq6V7vqXf7jLeta1Gb+zT9BRc36n9HEFGzVa8AEmdVAw9O9dg1jJka5U6zuZL7KoFBfKU+vGHkEEXulyEFHyXj3lfoiZw8TYUCjOVR8vgNZnB60mG2SITdpVoAEfY7p3GfL9/ONK+JVjAoP1GCUnTGsbeH6KoociS1sEVm6DA3gG3rSMfOnLaMlGsswijyTK8uNHp38jbVEFv/CcZmrG1GQjXuG0hf815rqFFQ9mj9/Vix+11f3ndTaorYzl23A+8qRe9R693midsLUhK5gej2S8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(4744005)(6916009)(31686004)(6486002)(316002)(83380400001)(508600001)(31696002)(2906002)(36756003)(2616005)(6512007)(66556008)(66946007)(38100700002)(4326008)(26005)(8676002)(186003)(6666004)(66476007)(53546011)(55236004)(6506007)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUlPTkZHV2RMWklRaE9yRktxV0VzYXVaRUkrbC9KaW40RVQ5QmswS25KV1pU?=
 =?utf-8?B?RldBUW5EWk15THN1b2JMc1QvZnRTZzE1SGJmcjJuaytvZ0pQR0VrNEw3QTF6?=
 =?utf-8?B?NXZKbGhPTm5Ca2IvZ3VhOTl1dFl1ZXYzTkxnSlppMFI0SGwreUFkVE4yTHZ3?=
 =?utf-8?B?YXYrRnhXSmJQTGp2MmxOdGw2WmV5dzVHNjdRV0NLY3grWEE0eXVJYUt3d0NC?=
 =?utf-8?B?cmI2b2crYWdFSnF6bmdlOW1SVzlZNjlmeS9lM1orM0ZPZzkyUHpZZFE0eEZD?=
 =?utf-8?B?ZGUvYVRxVXNNczNlRVRrc3ZyNmNNcGRJSk84amlLMXA0RGtWbzVKZ3FOb1Ba?=
 =?utf-8?B?dytKZ2w4UFhUdUJnUjFuMjZPZ2EyTW94aGZQVTdJc2p5UXNhb1c1VlhJRjAr?=
 =?utf-8?B?dnV3UFhkOWFpV3MvUUY1L2orZmFRZDRaM05Ub0E5cnBtWTluZkRyWXBvVjE0?=
 =?utf-8?B?STFoY3BxcFlkNjZmam5oMXNMcndpeGxZdHNwc1JxUUhZWjV6LzB6SXZ3TXM5?=
 =?utf-8?B?ZytiOFdaTEo4SFBkVVc1UVVkS3pabWVDV1p1cFNzeTZJMVhyN054N2VETVBx?=
 =?utf-8?B?RFpLRytDNHhsNkxGV3U5MjVFeW9mK1d3Z0F2KzlxcVdBczBIR3FUajRwODkx?=
 =?utf-8?B?dDNGYkZkZm1mam5LeDFRTHJrQzFqRjdWeGZMdFJ2QmJUSmxxM1hFSzZkejRR?=
 =?utf-8?B?TmRmRHNoaGtWSDZ3OGpYQkZqbWVLazlzaWRxbGRpVCtQOUUxMjJ1VFdkaUM4?=
 =?utf-8?B?cDhGbG5iVGF5YkpRRGJnd2hVT2Uyb09ub2d5U3BoNmJFN2c1VHVIS2J0Qnp2?=
 =?utf-8?B?cWhrK0oreTZPU1lWbDBMNEpib2hRZndPbDRxSU56enlsWXY5SGRZb2hOUkNJ?=
 =?utf-8?B?ZXQ2YVdjQUc0OXJML2lYWWRnaWI3L3E0YnBNalNXTkJOKytWb2xBSTNPTURE?=
 =?utf-8?B?eGhBaE1wV0djR3NMYmpseGROSUtvMFkzOU5xMVlPWkhxdFU1ZVE4c0Qrc1VE?=
 =?utf-8?B?dmJiallxV29BcXNPK2R5aTJkNThaSk5HV2tWMHRJczFka3ZMNkdJVFZOYzZn?=
 =?utf-8?B?Q3F3NGQvME5TZ2JrT0NtZFBoQ3ZneGlRemxJQk5ZdXo1dWsvbXhLUjFyQmU0?=
 =?utf-8?B?U0tSY0MzU09FVk0zZVZIVS9DZzV3UDJNa0RVdktsVFVZUUt6bzRzeEhHeWpm?=
 =?utf-8?B?OEtTakJuSHpYRkdJb3J6eW1jcUovem5ROVkrVXhsMExRWGVJU1BqK3kwOHpu?=
 =?utf-8?B?eG1nakhicUZOUU9KeTN5NGRWcURVbXZ5dk1YNDRpbDJ1Z052Y3dvQWRBWFRE?=
 =?utf-8?B?OU1GNFYvOWpWUEp4S0M1YXk0Y2xhVG9UbjUvS0s2VEpCeWl5cENzcllXajZx?=
 =?utf-8?B?cUtuUWsvSEVnZDRFNFV6d1puelB6UXRIelcvVHE5OExjRG5wYzdIS1JRL3d6?=
 =?utf-8?B?bS9yUThiTnJQbXZHdlIzS2NUMGs5V1p6N1IrcEhYQWdnOE1OVGZMcEVEdGhQ?=
 =?utf-8?B?UU41dy9mSmZFYjJPMFRXWEIxL1BESnYza3NlcGc3VzB1d2p2SkVyV2NKSW1z?=
 =?utf-8?B?QWZ2QTJBNHc5d3JKLzdZOGxDZTBnWGRremh2U1gvRjM0UmxBYTIwQzZ0OHdy?=
 =?utf-8?B?dnV6UVlML2ZkOVJEcTV2N1FpOXNPYzNCNUx1WFk4N0RNRzM5S3hOc2o5VU1X?=
 =?utf-8?B?NnR6emM0ZDUwemtDK2VUUGRac1hsRnA5cURIS0haQ3htQjZGZnpLZ2FsSTE3?=
 =?utf-8?B?UmZid1dtMm1SdGM4amlNV3drZk9YZldDUXNSOUpLZlcxaVgzelFYYjlZbjRD?=
 =?utf-8?B?UC9weVpYTDA5aE9SZWxGMCs0R1JFMnlVL3h4enBWblBmWGRWUzRaNFA3M0ph?=
 =?utf-8?B?SlJiZERUb2tRMk9IL0pYclRrS1NaTktNK0ZIMUNTKzB5TWFGYTZRUGExNnR0?=
 =?utf-8?B?K2V2VEdGSnpxRFVMR2RZZ2crMStzRi8zYnlDUHJJMExiVWVWS2VMNUF6clFy?=
 =?utf-8?B?ajhrSTBDWWdxbVVZNGVrdE9aekRGVy9vVVVvVGZnS0NmR2lQZDZrSDlvcGl0?=
 =?utf-8?B?eFBlWCswNVduQ09JbXEyNjczQUZ5QXdwOHQ3S3F2bVB0NU5wTE94OFdYQ1Y0?=
 =?utf-8?B?dHlOVml2N3lJMm8xeHlxS2NUYTlESTUvMXNubXV6N3p0RTBnT3EzY29qWWth?=
 =?utf-8?B?RTIzUmNiaUZlOU15K0J2RVlXdnZ5VlNiQlU5UFU4SU9pUlh0bjRyalNZY0dF?=
 =?utf-8?B?KzFoZkU4eFlDemNpNGpuR1RkcmhSbUQweDFQUmhGZUwyM2dTVjE4WFFsNjZ4?=
 =?utf-8?Q?UnT18+PWEKhnECrTvK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76b3e1c-4979-48dd-2025-08da1b8bd4a4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 07:21:01.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xr26j1Y5D1Raw2KITLSmGTq6nIUAU5gsf3fAgaXUf0GPerX8HUlIQlKeaANLup1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3105
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/11 15:18, Christoph Hellwig wrote:
> On Mon, Apr 11, 2022 at 02:12:52PM +0800, Qu Wenruo wrote:
>> Since commit "btrfs: avoid double clean up when submit_one_bio()
>> failed", submit_one_bio() will never return any error, as if we hit any
>> error, endio function will be responsible to cleanup the mess.
>>
>> So here we're completely fine to make submit_one_bio() to return void.
>>
>> NOTE: not all bio submission hooks should return void.
>>
>> Hooks for async submission, like btrfs_submit_bio_start_direct_io() or
>> btrfs_submit_bio_start(), they should still return error, so
>> run_one_async_done() can detect the error properly.
> 
> This really should go into patch 1.
> 
Stable tree won't be happy about the size.

Thanks,
Qu

