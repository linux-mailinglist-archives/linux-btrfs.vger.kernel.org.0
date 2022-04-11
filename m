Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F169A4FC7A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 00:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbiDKW0t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 18:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiDKW0r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 18:26:47 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFDC1276B
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 15:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1649715869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMdcOT91nkj7L3ctxIzMfnE2UlcGLxpyiqCTZO1hb+8=;
        b=AvId/GWpFNd1BxkezuZoCT/WMwiZKO86xJDlViMAOSZyug6KzttrZAP+LCF3vMNNu9Rua9
        JEa6un09B8rewxHtWkjsh1cKiIpw5ewvSrYQOp1ZyBqd8/yKHO3tAwWdW/tpqDr8ThpPny
        GglfORSF4PvHmwN1wCgiJD1VbX+AN9E=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-2ksqudUYMH6nXt-AeYBaQA-1; Tue, 12 Apr 2022 00:24:28 +0200
X-MC-Unique: 2ksqudUYMH6nXt-AeYBaQA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP0KVNEUy0eJybkVdN5YMa/s5nakvbZMPLAfvvIPw6yhFP6Hl/dq+fBA0EBMmI8bCRKGZKRuyr9yZbE4h2ohOzQEIq0TwsBuSZ+IV5+88O6Rrupxjes93S05EfZNLKIgTrsrxUW49euDIpPusYH0rD2y05NpvGw4HpgLqMXUMygDKy50roWL8ZDfqYLwhVU6/+lhp6oJBsjzXBAMyByQxMPTby3Y+pSbmxHkBJ37G81JkmXQkkj6CxdnWIgwrfy1jZuySjd5KlWIe3iFKeNDJ1DClKp79IVnixBh71LT539j0p0vHyTzdrs33JwTOdzPUFEt3nhkEYHdhxgZeo9v4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMdcOT91nkj7L3ctxIzMfnE2UlcGLxpyiqCTZO1hb+8=;
 b=g6d6HHR9t50oiyVnhqslTxk0lEAxU7gpTVfcxlBS7QHZbONhfHG5qkVuXinDUnvIoOFDMw9qvfK9saoDNYgjDeo1y+8HgUgBkwf18zpN3/mSCppJuot9zqJIq2qDb4ONJhhjlZy07G5OiUMDnXsE4HXMRyTWV3ZZK0EHZ2H/c4B2HZafoZLJLZ7KNWz9iKug2uIV8vGj48QP7H1O126caeg3vWildsWcLKEkL2bHuCv3/xJIo8S8s8CP9i+1qOwIH7XVFUcUMTeJtfjpr2XcQGqgaHkrAFPeJFkjO9xfC1QBVIb7ju7ZAwJTKRomWnbkcahg+FiUmHE/DBl3Enldzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AS8PR04MB7927.eurprd04.prod.outlook.com (2603:10a6:20b:2ad::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Mon, 11 Apr
 2022 22:24:26 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::415f:1551:a6d5:face]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::415f:1551:a6d5:face%7]) with mapi id 15.20.5144.030; Mon, 11 Apr 2022
 22:24:26 +0000
Message-ID: <027f93b3-35c9-f18c-7600-1e3594d96f41@suse.com>
Date:   Tue, 12 Apr 2022 06:24:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 09/16] btrfs: make finish_rmw() subpage compatible
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1648807440.git.wqu@suse.com>
 <911628d0221328e4e5c0bdff58313c0c64485315.1648807440.git.wqu@suse.com>
 <YlRentZd9vVt1Ff2@infradead.org>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <YlRentZd9vVt1Ff2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:254::12) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fe9f9b3-68d6-436b-c017-08da1c0a0993
X-MS-TrafficTypeDiagnostic: AS8PR04MB7927:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB792716D2364571369E838F8CD6EA9@AS8PR04MB7927.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZorB2hIJUm6y+kh3UXaMM/CCqCZ1x67TPh60q2EJ83SyRCQtJXd/FmEMCHObyXkCe5WLbPpYA98BA7R6LCJQKyREUNp7j4qZI4cUwUeVpw0LyHNSJPkhGRiwK1/XQGZndLidkP/dSGtpxsVUWf/A0P8QCg7za3M8xgcDGHfFwTRuXILFDl48BxVLmjbDNuw2zWrhMjU8swXxIPsS4UGHFDpK9s5brJtelrDi+gsC+wTb6iOzTH6YVeyZeNZStiKwm7z5+t4b/PCRjpz7Ya5OiFIKOEiB5t4OIox+PkdFedeoBmIvdTGVW75qVdV/K9/FN79egJmcDMAPmCghNaAcIHZFeRdPucLjd77QtSF2lHnazNQdGoMq5IGu68VTMp5qpDyqbRcscULZGC/ADkVG84lzsg48APNo9Ba2SgAlzbVFS2RaOJCSfhtfGbMHRRqZHUYxt8sSkmcJfdC6EGFclY4iD4P1NAsUHBe+tkdQ3O9RmUyY4PnakkDlLJNzOAzv4fw57YJnSNZqwysJAE3hyeAwQ9EJJ8eH9z7SVvi21bsK8JbreBXB3YlBJkQhUit070iTK8IbbdjS8T2n2v6kaYpBuJ/jfifW7hzitxGZEClV42TWC8HckBhFDm40x+SvP09WHZ3hFycd50OoURyWkizd00nRkmfr5lAGjJbTKzKw+WxBZ5iJaEwOqAtKz/7DiXEpXkvUKhuIM6Cnn6KYQa3QUBQ/+hoLnXOuk2lDY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(26005)(6486002)(186003)(2616005)(508600001)(38100700002)(2906002)(6512007)(53546011)(6506007)(36756003)(6916009)(66946007)(66556008)(31696002)(4744005)(8676002)(4326008)(66476007)(31686004)(5660300002)(6666004)(8936002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjhzYUJYckxyOC9VODh0TUw2YUZqQVIrcEtqazhoQmNIOXEyMkR4UlFQMUQ2?=
 =?utf-8?B?MGl2RUtFTk1JS3YrWUU1ZDlveFltUlNYU08xT2dMcmlab1Q4cjdDM1lNUHgv?=
 =?utf-8?B?aXhIa2R6WWRlbjZBakY5clFZbEVOUWlKUGUxS1ppbFNvN2QyMjBDWHZ3eStW?=
 =?utf-8?B?SmYwVlByY2V1TXIvaE5YNGNuUHlhNmdwbGoyZDVIZ2lmVkNQL0ZjQjZBUTZu?=
 =?utf-8?B?bzVyRFpYMGk4ZnJqNHQ0aldabzJyZnRxSW1SVEdMb2c5dEpxL0RmenZsQ2J1?=
 =?utf-8?B?TXVOWTVSR3dyYTVFTDJ2dE1mMnRaMXozT1lOS3FoTC90VGsyNlF4SFZ6SExV?=
 =?utf-8?B?Ry9VQ2Z6V0hPT2syYlRwcUltZHYvQ2tXVS9tQkYxaWtlcUFrZytiV2FDcE5H?=
 =?utf-8?B?bmdjNEtUcm12cW4zU0t1bjZjY1IyaDBJMGt2UnNjeld2T21rTW5hR0RXK2tk?=
 =?utf-8?B?elBoZUF0TGdieUxYQ0lQaTM2L3BtcUpPZjJvWjZzcUY5NXhhdVJqYjRZSlox?=
 =?utf-8?B?V1NiVXlMNjAxOVF6OFptYVI4cmRNVUFwNjNNZUZqVlpBU1NWSTlsaFlYVHRT?=
 =?utf-8?B?WGZWei9JVXc1dGRkanZqZDlhR1hrOFBzNzJBMXp3WUFJQ0ZwckNFNEFrZ3dm?=
 =?utf-8?B?MjJlT2VVVFdUdWNHS3k1SUttRW0yclc3SFgxOUFEK0czSzFUdFJoTXlVQUdh?=
 =?utf-8?B?ZlRUUXJ0MTNlZXUwWE01QUZRczBHZXdJVmlqSHFCRFNhUGgzYVZXdGEzQnda?=
 =?utf-8?B?V0VsSEpmZExSV0I5WERURnFDdlRpU0lHWkJQNllYb2Zhd09sajZ0a2tPQkYv?=
 =?utf-8?B?Q3RoTEIrdGMxNDBuYWVkb0YrNGZhVCttSld2VDZNdUVIRzlFNjhERzk5cEUz?=
 =?utf-8?B?dVRjOVAxL1d4cUhRT0s4WWFjWHpVY2g3dmVUSkxRU2JTRkdGY0dERTgwVDI1?=
 =?utf-8?B?RDNVM2pOd0lnZlhCTFJOR25kQ3JKRld0VUFNVU1WbzhnYjFtTGlkZFVMQ1c2?=
 =?utf-8?B?NnFsK015U0RNVDV0OHl6RVBzR1lPVGdXTkdBQTJ6MEJENVpPVTdWQzIrRWZs?=
 =?utf-8?B?Wm1yeE91dDdyclBKUWQ2UmhoUEsvZGtFaTJod0szYkhIRGdlemdCK2Z1V3Vj?=
 =?utf-8?B?VitwdEFlT2MyVWFFTUdQTHh0ZlBteXJHWWRhRWx1SVk0d0dsWDlMQlFJN3Zn?=
 =?utf-8?B?NTN1bHBjQmp0ZUh3Mm9Xc0hUMWFJSVo3RFltb3pIckZCdTJ5T2QzUk8xbStL?=
 =?utf-8?B?dGI4cTl1QlZtZGdPaWxQa0xrMlN0Zy9NeFdNL2pqd0ZFS2RieUxRU2hGNEUy?=
 =?utf-8?B?bSswTnhiV1ZDVmtmY0paRm5PVFFST2Q4bWdzUi9rV3VLTnZoejZnSjlCNDRH?=
 =?utf-8?B?UTczSUcyZHVkYXRhT21jUmpGOU9zYmg2ZFZ6dmE2TStzcnVnZUt0TngyQ0VK?=
 =?utf-8?B?STJzdGFsTGRYNXl6TjZHbzBjVUVjNzYwdUpTMUVzNzFLNDNyZm9uQ1N4cWpP?=
 =?utf-8?B?UVdJTmxRTGJ1Z1paSW5uQ1lmckhVOG5ta2M0bGdxWVJ1eWc4SDBXdVowdlpu?=
 =?utf-8?B?S3hsWmQ4VUNLaTAvSWpGZGZ4dzVDQk5ZR252a2gzSHBOK2MzbGZwTnBXMHhB?=
 =?utf-8?B?c2R0Q0JGUVdJMDl2eDZFU3hCM3EzRmJiL2s0VnNMd1RvcE1YNUpnYWFoU0FT?=
 =?utf-8?B?RjJTZlBTTE13YzFTMDlIMFlLMkNXc1ZoSEFJa3I2NTdDSXA2M3VCWndkWWFt?=
 =?utf-8?B?NkxMVTc0RVFMTGtRbktTdys0UkFWcGZUbmdWeVROaTBueDhtK3BRWkp1c1dE?=
 =?utf-8?B?dkpsVkkya2g4dlF2UFhXMWpkWnlBQnkrU29RRy9TVUk0cGRxbUZxRHRNa0Y0?=
 =?utf-8?B?d09YLzZ0bFk1ZVNUTm1oZTNvL1dINTNZQ0pvY0RWYklhaURqb205MUtFWng3?=
 =?utf-8?B?aVRXRkRZT29tbFh0OFhLVEFScXRxeVhVT3p3d1lkWFlGSTFyWWVMeGxrbVlR?=
 =?utf-8?B?Q2JkYitkUFZYSGswWkVSMnd3OXZ5WUlBTkZjSGN3d2c2VG9DWmNPR2VaYWN3?=
 =?utf-8?B?b3lJbCsxUlFrUGNVZ0ZxVk9FbVp2QzNlMkNlQVNKaE9rMDZ3eDFtem5acTkr?=
 =?utf-8?B?Y2FtS2ZlQ2dqUHJGOUNGaEJHSlFocjZ0QnF1dEtWL2c5c1N1cU9TcTNPVVkv?=
 =?utf-8?B?OFdWbXQwbGRqMGF3dHpQZ3FkT3F1UjNiVjJBclFXcSs0bW5kV1BKeDRMeWxU?=
 =?utf-8?B?Q00vVUw1K2poQ2ZMTEp5OVJQemNsQ2JiUW5oRXNNbEhEaThEVzdSZGpWWkR4?=
 =?utf-8?Q?0P3GPJaSKxomF3XLap?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe9f9b3-68d6-436b-c017-08da1c0a0993
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 22:24:26.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKg7ns1HlCleoWs1WoDylQGVXudDCDE0rfe+SCVBzqGRP74T+rB0h9Dpx7MvVo+i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7927
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/12 01:00, Christoph Hellwig wrote:
> On Fri, Apr 01, 2022 at 07:23:24PM +0800, Qu Wenruo wrote:
>> The trick involved is how we call kunmap_local(), as now the pointers[]
>> only store the address with @pgoff added, thus they can not be directly
>> used for kunmap_local().
> 
> Yes, they can. kumap_local only needs a pointer somewhere into the
> mapped page, not the return value from kmap_local_page:
> 
>   * @__addr can be any address within the mapped page.  Commonly it is the
>   * address return from kmap_local_page(), but it can also include offsets.
> 
>> For the cleanup, we have to re-grab all the sectors and reduce the
>> @pgoff from pointers[], then call kunmap_local().
> 
> No need for that.
> 

Awesome!!

Finally we can get rid of the complexity of weird pointer tracing.

Thanks,
Qu

