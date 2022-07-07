Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1433756A467
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbiGGNsY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 09:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiGGNsW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 09:48:22 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80054.outbound.protection.outlook.com [40.107.8.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AE62CCA1
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 06:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6ZRu0dKlG47GvplKyHowElLzRJmiOk/mXDgr8DEViK8a+W3FDiDneelU/SQRLpvE5QDUJG7OZwG12F5QyadMAMjHp1jfVgpByCnj+C6AtyLhy4Otjvd5pqQmxpC7GN55915vb6aGmwHzj0cl/e/7xivGKsDzOjy+VaeGqVnbXyEOnWDMlBMGRDxdJRNNoJEvAQdH7HK5z7Z5gZRdEYs4hesmn7uOoSTIrNW+R7KoNkbteAc/adk0S2tEA5qafCW+DUq+TpQP9lB5V3ypij4bGYOG5btNtvw31NYm0bZWhCpDy5TbLDSHOSxD27PWX/fZCUnATmgNYhO0Twep1rPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqlwuJmBO8I0V60kj5Abr6DsDlotdExqaAlBebcpWn0=;
 b=H5s6TUzFfLpwLlwu3G3Z+bv0yKSQsw8PjQu+NMjxGm57wu0RejNdgSn5i1T+BPNmG8f32lieh4Kt0n0zEHratH7TzaG03rv0B+sakmrI7HP2qqvra7+VdTJIGd4wUBXTX/cWxdnJCi5hwIeh6NmHBpELbj1XXs7W0Tf/0lhQUGerK5fY5TkKH9iHne/EEdhPSmInzYKzVdPEcbB0VeiVbTz8jJGC+ucuGcjvSXI5AfiuALC161x0eryz14lSudLG9Op5H2pwXpM+osETo490xM3/0IyS7cbjwiQ/X9ZfVJvrfgs1ootYkaCMU5Z09TqN//pjtmeSSFp9fCGGpNB/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqlwuJmBO8I0V60kj5Abr6DsDlotdExqaAlBebcpWn0=;
 b=09kxVsi/QXp/zYc/kbbWlJhiFwGw2neFpk1LanqJm443G846t3yEv8EqEQe4OuPQa6IrPXAYrlIVfyGBV0CxknCRYKgg3g/3wZ0dYWXGEI9ZEi62Bm2lt1AF36hYe9bjbLDq4Udy5jnVP1TsmN5vjAFLuWyLld5liTutGDX/bnBgpvGMfPeBBrLtOm6ldjt4RYa5PgJguRtYwBs3AF/OvMfulCm4Zj6xgH+xHy97zLDVouspvXh24xNKpwZB0DM+63uShEgxAxXpMRtr0uBOTH8p/k1tYkNJvkkn1yiketkxatqWN6l001JNBSpbwr3AI41GEbfxl4oXFGgVjSeuUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB7512.eurprd04.prod.outlook.com (2603:10a6:20b:29e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Thu, 7 Jul
 2022 13:48:19 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c48:27de:73e5:ea97]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c48:27de:73e5:ea97%9]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 13:48:19 +0000
Message-ID: <508c0b1e-1830-bcba-885c-b61b85d2a994@suse.com>
Date:   Thu, 7 Jul 2022 21:48:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1657171615.git.wqu@suse.com>
 <YsZw9O8fRMYbuLHq@infradead.org>
 <ba4c42bf-cebd-72e2-d540-c3b16e5485e3@gmx.com>
 <YsbhbmA8ZfkP0uDi@infradead.org>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 00/12] btrfs: introduce write-intent bitmaps for RAID56
In-Reply-To: <YsbhbmA8ZfkP0uDi@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:40::15) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76d596b2-a9b5-4912-4e72-08da601f59a1
X-MS-TrafficTypeDiagnostic: AS8PR04MB7512:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gn8WU9CusKWEo14JTRStYtWnMtU4vgzmQuQvtGtYDIKZZhyUxL/wbLc0t+zSvTFyA14iY8+ykFQqtTHnAe9sUstSI5yvAoO6F7PZnT7zdaEdAPJJELj+bNtzV2PWvEKK5AXU/7vw9+kXHZB/KuPVb+6b0d0a9SOwJ5ISLnmSzgMK90t8mntz5AFXX+fwSgr9huA7NfMO1u2U6YCV4rZkvlFgjuD6Ds0cKzGEi/4szEHBIlSHp7VAjbaIhR/SJao+xyu7ibV2xQFN9fFVuZwQ1J6UnUyRt3nLUZctBCyWDnnq70ps9LxeDSv6CgWv/1TfmSYgtye4a/ciloWfbUAq5MWN/NGwIwLiXSxNt4r8cnY7KG3O3LKt5PidCsa7gvxe4ugQ2XpRclB9/kJyscsLgFoVAh8iX+pctPQYYWI7oDA1hw+jeedB/hqqdvQtcUL1QL2OIE9HTJ+Nsc8eU2Fjbp7hmdgxAp5lvNf5WwIqI6f9FMxAqsAuvUaMXWNPe7VkqEHR4Qi7tFueTHSWq+5T9iqavYnJq2qS6Qyacdw7Iyx/iQVtOGcenrDoGZYykwCEvlWrjrLL2ZmfpTcWoP61ensLihc2T5/7L+48//waR/18g+0HXRYhHUk78X/V+vqpTK4KTAT1i99itGafYbuek8l6TeJjApJ5bh7DIaqBMBwFi1T9mYeWwO5/7bC6n8EABgZuChLLt+yPqgC23KD+g7AlUFHd62viXCUZaOYAbB0N25EMFM/YZMr1BQ7/AIDeL2bC8oYc43xf6ebtYmnQfQX5tFPrxNm+Hp7gmRYfwAAJ4vmpH7JFKVSriAvhpBPSe314n+pxaHlbNsmwOnkbIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(136003)(376002)(396003)(366004)(110136005)(6486002)(31696002)(83380400001)(2906002)(53546011)(186003)(31686004)(478600001)(6506007)(86362001)(66556008)(66476007)(38100700002)(36756003)(316002)(66946007)(4326008)(8936002)(41300700001)(8676002)(6666004)(6512007)(2616005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGJuTkNld050UmJnSjB6SHZBMG5ZTUErRnU5K3ZHdlhJeUxiK08vTkJCSkw0?=
 =?utf-8?B?S2kyVWY0eEpZVzMzRk1qWkRHdFBmV3RHYnpmTm9HdTd1RGFBbGw5czdqUWRF?=
 =?utf-8?B?aStXTW5QVGFiK3U0VEVRblJKUnMvVmt3MzB4dzlXd0hGbUI0WngxRzlCVnJj?=
 =?utf-8?B?VmIwMWtFV01Mayt1MHQxbW9wbVBKRHJWdGJJbmJ5bzhQUlRqZGxvYzJ6eFp4?=
 =?utf-8?B?UkJjWWxBSFAyNWZac1ZRZktKUDFvY0o4VnExajdqMTlhVFcyVkhjL3NqWFhZ?=
 =?utf-8?B?Yk90QXpMSGFVcUE1dWRZZVc0RW1uMEdxdG9KMDdOdnpJOFJmUTVKOUFoeWNl?=
 =?utf-8?B?MitJeHZQeVhqMzBzVDhyYmpXc2N1aCtKMlZCeEk5c21QWHovWDRIME1WTmFr?=
 =?utf-8?B?LyttbmVpdFNZU3oxQnpLVk5UVC9YUUFmT1c2aXp5dFNNbE9XRUU4MzFrSndo?=
 =?utf-8?B?OFk3UFcyY0RjV0ZzRjkyWGY4dU9pTDR6UlNxS0QzVUo2UWU1WWxuZG8waGZr?=
 =?utf-8?B?WW1nT1VQT1JCa0d3MkhJUmRianBFclViaGxQNnVZdloyeEVUTFBkZ3JaYjNu?=
 =?utf-8?B?TUlrZW9RejFsVnhsVUloUHdIRFlvWWVqRkc4djFUWFZvWG9JN2FUNURPaldx?=
 =?utf-8?B?aHV4RkttZTU1QW11aVlPRXFwVDJBMjVDMFJOa0VCbFpCVmdXOEppcjN6dGda?=
 =?utf-8?B?bVZXS25adHJ4SWhlVk81RnRWWWdlV0RTN2hOUXhkTVBZSGdsdGFmOGZtOEhN?=
 =?utf-8?B?VFlJTTZ2YjlMbmVvMUY1OExJaUk3NzBEeGVKZ2d0WWhnZ01pNC9pREVhL2RO?=
 =?utf-8?B?UC82RW44Vk50VHdxTXRJZGs1K08zMGd6dFZxdmZ5SWdSOUx1VlJBYU1KUHpL?=
 =?utf-8?B?blJDVXNIU3VIWWswZGNobkxINStNNmJwSTVsYTdwMElVNCsrK1RZRzBuSUpS?=
 =?utf-8?B?WmptYm9oRUhwbm01TzVYcm1wTVpOWXBSZVdta2FxREpJWkJBaFY0Z0xaSUtl?=
 =?utf-8?B?R0VrdXhYUXZicFNWMi9rOTZaNWpQc1kxbTRrTkppV3UvN2tCK3M0bEpFRVNy?=
 =?utf-8?B?NEVtelo4bU9aQXozbTVmVDFsTnNVeGg3dFo0MVZQWWdlTlVmd1pYbzVXQ2hx?=
 =?utf-8?B?MGxyQzlxZmFjejh2Z3liNVVPTFFTWGk5bi8zaDJHMjc4MHAzMTAzc3RLRlNn?=
 =?utf-8?B?ZUk2QjIyVU9kaDNNKzliUngwY2VSdGdwKzgzNlpPYUlWMy8xRVVQWFhpQkxr?=
 =?utf-8?B?bllORzZBTHBnKytweGdmNlMwNk4zNlg5bkVMQjFBaGgvb0RCQTJoU3IzdGhn?=
 =?utf-8?B?K2I3dlRWWSs3OWhoM1k1VitwZ2xsOTBUOG1wVFVWMDNkUDhIVktNVmtOMG05?=
 =?utf-8?B?d2JnbGNCL0F3R29sZFQzb1I2cTNmK0phemhuN1dJUDhMYWQzRTE1QjREazFo?=
 =?utf-8?B?N0U1ZGFicU1Ic2xuNDhTV0xjbk1zR1RVaTg5Z09wd2tjN1oxM01LVHQxQ3VN?=
 =?utf-8?B?d3JLVjhpRzZyVVlZQ2JUTW82bnlkbGsrclVUUXN1U3krWk9vYkl2a3ZQOXRH?=
 =?utf-8?B?d3M5SzZYY1RmUVNVZEF6eFd3NGRZVU1iYU0zL3RtWW8zQnprdEVITEpibXdY?=
 =?utf-8?B?Y2N0R2xFMWtEV2Vqa095RGszRW84RDJ4ZVRYV0VVcHY2THJrR3NvWDdQMDNo?=
 =?utf-8?B?VW52aWljd0FFa2VJQmZnOE9YQUNsY0loYWkyVkxUdkJEY3RRSERPUEJpZWx4?=
 =?utf-8?B?NlRIVUtwVkw5OGxmUUF5TGFJeExKYVFUazVYOFMrb081ejJFelhsWkpiTzVS?=
 =?utf-8?B?bStNT3hndytxdkdGZXliVlFHVEE3WjJmZ1ljeG10UGFEV2swZGNWMVYxdFdq?=
 =?utf-8?B?c1N4Y1VSMURUKzkvb1MxZFlKeCtaZThMNFgyQVVZVzlzZTFiQmsyWjNmemR4?=
 =?utf-8?B?TUR1Wnc1d3JnVFNpU21YSWpCQTZKSDVmTXRLWWQ0N3d3WDBZQ2hYM2U1VGVv?=
 =?utf-8?B?NXZOSVZBOFdjMnlFeDQ2V1ZBN2Qrc1czaWtrQ0tQRXZrdk5RVm9wZGZ2eEUr?=
 =?utf-8?B?b2hsMTlMa3BjV1B5R0Z5Vkh4QUZkZlVXaGlWSk5wUGNvTXMwOTlOZFYyNXlT?=
 =?utf-8?B?Wk5zVWQ0bTZhZCt0SUozNWpoNEhEaWo0WXVPTkZGYkFYbzFvUTJwODRxcm5H?=
 =?utf-8?Q?O6LTdbf45SyVXXZ+fT+co9I=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d596b2-a9b5-4912-4e72-08da601f59a1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 13:48:19.3155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5RYGOhxSzIizulAjhxb2+kGOI+pjq7CdngBamGtuYYMZS1ewfFu8/kcMW462WSw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7512
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/7 21:36, Christoph Hellwig wrote:
> On Thu, Jul 07, 2022 at 01:48:11PM +0800, Qu Wenruo wrote:
>> - It may not support RAID56 for metadata forever.
>>    This may not be a big deal though.
> 
> Does parity raid for metadata make much sense to start with?
> 
>> - Not yet determined how RST to handle non-COW RAID56 writes
> 
> The whole point is that with parity raid you really do not ever want
> to do non-COW writes, as that is what gets you the raid hole problem.

You don't need non-COW writes and can still get screwed up.

Just write some new data into unused space, while there is already some 
other data in the same vertical stripe, (aka, partial write), then the 
raid hole problem comes again.

Let me say this again, the extent allocator is not P/Q friendly at all, 
and even if we go update the allocator policy, the ENOSPC problem will 
come to bother the data profiles too.

In fact, considering real-wolrd large fs data chunk usage (under most 
cases over 95%, easily go 98%), I'm pretty sure ENOSPC will be a real 
problem.

Thus any COW based policy for P/Q based RAID will not only need a big 
update on extent allocator, but also ENOSPC related problems.

Thus to me, if we go COW policy directly, we are not really going to 
provide a better RAID56, we're just trading a problem for another.

Thus that's why I still believe traditional write-intent bitmaps/journal 
still makes sense.
It doesn't rely on big extent allocator change, but still solves the 
write-hole problem.

Thanks,
Qu
