Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB41534B2D
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 10:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbiEZIID (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 May 2022 04:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiEZIIC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 May 2022 04:08:02 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF9E1D338
        for <linux-btrfs@vger.kernel.org>; Thu, 26 May 2022 01:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1653552479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=esi+QEfozdifxGrKAxTEBYP3n9CmuPU86uFm3EKqDls=;
        b=EKzfckqNmpkgvpOtESZ52ntAhDLRao398qIc1X6FXqK7THj7ljN4/AyjQeZqmIFmOOtkiP
        Vw7zATzGd4DOkmL6AsrTbk/MbC90YvvOLVLS4n09TGT11LIoqf1UZbBD5VJAqIppgEsaVz
        OUSCA0gqkX5WVuJIJHYhlGW3Iwq/ev4=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-3G_irlFePnunnxW97-FELw-2; Thu, 26 May 2022 10:07:58 +0200
X-MC-Unique: 3G_irlFePnunnxW97-FELw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzQumWC0bE/EDj/uMQcb/uEppRX3/dgXVX9ybFzMvOdEYdKOfjMEx8sqYY5CzMfi0uSuEoHE+ZyvJ6gjHEOQmNS2pzt9KDLArxfFrk6R46nx3YT1oIVOOHJJU39dRvMEfx7PKD30SJldD0mSteJpFkvPS0Xop7r1O/vPtxfN5C9ICrR8N1d4MRum/tu8i+Oy0pPwGq6FZ7MVU66XPgqUtL74gvEUZfXLI/ULChuZb+wdf50MdYP7FFw6oriLDEjT1Zrzd99yLsNRFXnMMvh/zNbhqDlY45ba8YPMel/GCL8NjV6mzyUD5y2ddA0J0xVMI9ykPZpNw6fWLmkuej9CEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esi+QEfozdifxGrKAxTEBYP3n9CmuPU86uFm3EKqDls=;
 b=maTZ0a110p5a+AZP2frICjrZwySU5zU8LxUEY8U9Kj8FRBe3HxwPQkgyZnNeEMoqpbPflb1uEBlPjE4fdpHVKGbvsF0G3Q2J8YmI2FJ7evmwIXc29cUwjxZLzTlUXkXneyA9sXr31Ciyu2Bg1CYKvJfTmrq620dgSAeEYn7Ml/1jeOxl/nnRX8gwF4LgLeARN/yDPB9NoiGBgLaYVClRhUym2kpREkhdKgle2aTV8TEgnWRTRq1+jNoJUVJGlCnDeK/XPcUmgFb5XHNMWzUvfrrCtyfou/N8uGk4//4O+4hVvGQfIqGg5lKa5HQsIub9tL1gcXsc3iznEXHRKYNslA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 08:07:57 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf%9]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 08:07:57 +0000
Message-ID: <0cbbc3aa-a104-3d5e-ad13-a585533c9bcb@suse.com>
Date:   Thu, 26 May 2022 16:07:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cover.1653476251.git.wqu@suse.com>
 <b014412ee0713e01f52269e553c0cff3487ca495.1653476251.git.wqu@suse.com>
 <531d3865-eb5b-d114-9ff2-c1b209902262@suse.com>
 <20220526073022.GA25511@lst.de>
 <bf92f4ee-811e-35c0-823d-9201f1bceb0e@gmx.com>
 <20220526074536.GA25911@lst.de>
 <aa251ce8-e97d-8b38-b9f5-421b95fa79a0@suse.com>
 <20220526080056.GA26064@lst.de>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2 4/7] btrfs: introduce new read-repair infrastructure
In-Reply-To: <20220526080056.GA26064@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 025e980a-de60-4d0f-ca93-08da3eeed7f1
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_
X-Microsoft-Antispam-PRVS: <DU2PR04MB85823F23C1637D3121B98EE2D6D99@DU2PR04MB8582.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqjvt9taZUeisqWSaMX8sMpfqdJk51CMsEjSb5ReS2mpKFO3DiOTSpSxVtGUOAdr2ambcvdjYkwGC0l5g54C4mwkTeLuum9fFrySN3VS+fZscVNA4qg2XVI3Rpr93UKBuNMe785h+i/53n29W3kKF0zVP+EMJQEGF0YvL2C9FNwHh1d+Va3ktqhotbjaUT5GyfIq67G2tx7kym40McGSL4QeRmYdM3ubTQbGfM1Q2sNJnyqAbUnau/peoicovRFhpG5OzEMMx4BQBR+bzAyJfW5Une8uyUYYYkfLT7+/HwJaz81E8IJuPapMjbmx6A5CoAcqLtorLmIwvBMjNV5FVdQmRqcagJ5PR1FUEJDzMmjWyOajMFoMSnXu0TQW7mM3138bMnY8VYpN0K5o9PJEXTPUgXXm1CL481ksqEkIzg6lf8h1sUzCg8Xmv0V19G/KB44Efo3wFETz7k9+4K1HgfckZ8vRFNXxe4aHFQ3OCPqN5szffevFdWwkDIf6Z1Z+WvgnKwAPswi9W/bWmXgjYXGxzsnaBIyDwpF1eDKKxXOX8tz8iRsxLXhwIeQnfXz7wTcNVXMnTO2fTKmOyFgrp9vgH87rEeDEYNoTbJ8pOMMli2Byv2LAi5QMm19CADFBEqHQ82Xea9XGsAy9bSkMMStQB1/NX8fAYVaUhoETALkprEfyph3gUZrisq+Yj0NUkxr/1CKAHm7iApqECz6cDeCOiQyjiSGPQEdTemysuaHQ8j7Ugh6qJGIlsYo/08Sm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6666004)(31696002)(6506007)(53546011)(86362001)(38100700002)(5660300002)(6512007)(6486002)(31686004)(2616005)(6916009)(186003)(66476007)(508600001)(66946007)(66556008)(4326008)(8676002)(36756003)(316002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWZqdmlXU0QrSGdWSklqYTRGUDlMNk9xSUZwdGR4N3BWa3RqOHE3WkU3RUR6?=
 =?utf-8?B?aVorbm1xa1NtbXBZSjYydlFLbDVjeHRGeS8wbzBkNTNHMHhZdnd6UGhJbVNJ?=
 =?utf-8?B?SndjL25UcmZOcWorYlNkQmtuNUVFRzhGWHJZUEFZQjNHR1NJSjNneE1yWGRM?=
 =?utf-8?B?RkxMOEdKT2xPRXJlRkJySlhjREh3RzU5SDQ4TVlYemI2U0FOOVcxM0E1MWta?=
 =?utf-8?B?OHg3RDEvR3dQcVVHREl3TndPODI3NHcva3dSWE8wb0N4QWJNb2d1RFFhSGE3?=
 =?utf-8?B?NzMxaGxwTlU4cVdEbllxZ3RDQWs3WW5sYi8yTFB4a25PWENhRGRTdkhwV0Zx?=
 =?utf-8?B?VmV1TGxSK3NtM1VJaGQvalJYRE9kNFN4NWxLQVpzbFVIdkY1SUtMY3Qrbmpp?=
 =?utf-8?B?TGNjejNGY2tmVEw5bWc4WDV6cjhIYXA0N3UzVjVEQWtyL2RtTlVyZHd4MGhz?=
 =?utf-8?B?SGdSamEzc25yOEZLV1lHYnUrc0UzRWZsMzVSRFp5eHRMOFY3TWN6N2xhRHV0?=
 =?utf-8?B?UmtMWGVrbEErVktKVUpkRmRibFR5OTdhZ3ZBMGJaZlJJTXFRa2R3dEdXZ2pZ?=
 =?utf-8?B?Z2J0b0hGZlo4eG0wbkF2c2pJUGU0ZnliZGFpVWRWNVptaytVeGkwK3hoVngw?=
 =?utf-8?B?aFdob251elBZbUF2ZndEc1VjSFJ2RUZkZU5sYjQvejVTTlhSeU9iQUkzODZu?=
 =?utf-8?B?M2hyZnc0bitLTldyRjFQMUhQcHAxZ1g4TG04N21aTVY0d0F4SkhZTUkxaEIw?=
 =?utf-8?B?SEtjVlNUZDlpU0FGYjdGZ3grdWpaNytvaHhMczNjYnpyTWRjbXd5UG5MblB6?=
 =?utf-8?B?S3BXbkEvY2I5UTZkR3hSYnhvdTBsc1hkNDkvNzlhVmJtRk9aejlPN0VrYTJx?=
 =?utf-8?B?R3Z1Ujh3UEFvU0wyWm9NUGxLcStFQVk4bmVaZmY1ZVBIZEVHdld1ejhCajNx?=
 =?utf-8?B?ZitWMVZYczBDc0h5R0JQWlJBRFdOd0xTbWdPdk9iZnpCYmxPY3JYbjJPSGg5?=
 =?utf-8?B?Rkl2aElrTTFiNGpRZ20xeWRVcjFSbVo0RE5WQnEyeUQzZ0RBTkozMUJGc0w3?=
 =?utf-8?B?MDdFbVI5cUhDVURJdDJrR2NYcnZYRXM4dkNJcGRvRjZ6YVk1MGlMZitNM29K?=
 =?utf-8?B?VUZ2ZFBqZnppU2N6U1ZlY2hORzNSUWs4TzhLdVVqZzd2QUpabFpYTDJIM1Va?=
 =?utf-8?B?U0tNMkRrLzJaTjJUck4zVVNXWHc4L1lDcFBLKzBHNlppTzlhNVgyQUxaQkIw?=
 =?utf-8?B?VzVGN1E3d0dLVm1SbUpNK3R1bVI3S0hCaVJPa0dKMGFDTHR3dkdnM2NvdHph?=
 =?utf-8?B?YmR3MXRsb1dxd2YyZWlLUG9ZcVBhR1hRV0Vqdkl6Uzlybzl4UTV4THdBYXlX?=
 =?utf-8?B?ZVAydkpMdWc4Nythd2FPVmxhSmtnanVoR2p4bFBObk1jY0tlWUgydmR2VFc4?=
 =?utf-8?B?Wm43M1Rpb3JDQkZlMzZmNjdyNTk5MFRwMkNZUlZvWGFpNXpiTStJV3d4TCta?=
 =?utf-8?B?cFVBdjI4ZDhIVTQ5TWRQUyszbXlRQll4eG1EaDE0SDd0UVBoRWtxQTBUMTM1?=
 =?utf-8?B?U1ZGVStWTkp4bkR5SzFjNHVPaW96T21ZVXo0RSsvZFZaVVJ3TnRoSjR3bndB?=
 =?utf-8?B?V0NkdXJHWGUwOXN6cHd6TU5ESHhZZmNsOWQxWXFBazhGSm5uTjJNU0U1WHNC?=
 =?utf-8?B?eGRpbFVzYWlxQjlWejJKM1NuVG5QdDlDYlp6RDhZalR0a0w1TUJTQ0tLa3Bl?=
 =?utf-8?B?Y3N1NkphYnN6K0Y3RGVkS2xSU05XMWpCKzdOL21zbGlRL21DUkU2TCtRZG1K?=
 =?utf-8?B?am5Jd0VtSzRhR2tyLzMrZFpXL0lVNUpxNW54TnBuUHByVVVpYmRBWFF1WSti?=
 =?utf-8?B?NVdId2tqNnFHRGJFOGQrWTVCdHkrVDlGczQ2UGl4V3NDNGtldDRwYVNkVmVi?=
 =?utf-8?B?ZDNxeC9NczNETzZRNEdEaVZIQXFqNk8ySjFRYW1rK2J3RlA3bWZmYmFLN09S?=
 =?utf-8?B?R3ptN045eGVkSUdUMnA5eFVQS2ExT1Qwa3FnQU93MWR5SDlrR0hjd0d2RkFy?=
 =?utf-8?B?UjJrYUNhWlN4QjJWajJYKzJ4c0hiZEd2VnFNNGpISnhsd0JkOFVIamI3RVpX?=
 =?utf-8?B?NWY4QUZLNFBzaEQ2Z002K2RxdXFjdkFkakJSNG80UkZZRzFMdlhYbkFHdUMr?=
 =?utf-8?B?VjFienUrTld1UHBYV095WHhEK2xlQ05BcGc4WSt2ZVBtamYvR2lvMkJLOHNL?=
 =?utf-8?B?Q0MxSFRNT0xhK1NiYTkxWGl1ZTY5bFFsTURZTGhTWVN5TytBdzNxMDhGSU1s?=
 =?utf-8?B?ZHpyZUJVMk1HbEhmOGhjaXRnN0lDbHpyUUlRVzJDdTh1NVhOQm5ob2FhNXky?=
 =?utf-8?Q?1OKcc8rYWxjosQMNQpAzFq30EM1/5pFtYL27DRvrAeopN?=
X-MS-Exchange-AntiSpam-MessageData-1: 1lzhvmkWdSBapQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025e980a-de60-4d0f-ca93-08da3eeed7f1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 08:07:57.4619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VrhsX892l+l2ZuT/UF2QfrnFwO04G2nPaEI6TBfikl2Un7G+zfpoSY8BhyhdQLa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/26 16:00, Christoph Hellwig wrote:
> On Thu, May 26, 2022 at 03:52:03PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/5/26 15:45, Christoph Hellwig wrote:
>>> On Thu, May 26, 2022 at 03:37:47PM +0800, Qu Wenruo wrote:
>>>> Rare case doesn't mean it won't happen.
>>>>
>>>> We still need to address it anyway.
>>>
>>> address != build overly complicated code to optimize for it
>>>
>> Well, using seemly simple code, but can lead to read way more loops and way
>> more data to read, is neither a good way.
> 
> Again, having checkered corruption is an extremely unlikely event.
> I'd rather deal with it by doing more reads than code complexity.
> 

Then it can be said to almost all ENOSPC error handling code.
It's less than 1% chance, but we spend over 10% code for it.

And if you really want to go that path, I see no reason why we didn't go 
sector-by-sector repair.


Furthermore if "more reads" means over 10 times the amount we need, I 
strongly doubt if it's sane.

Just the same RAID1C3, mirror 1 all corrupted, mirror 2 and 3 checker 
pattern, fill it into a 4MiB range, and try run your version of code 
starting with mirror 1, and see how many loops we need to go, especially 
how many times we need to read mirror 1 unnecessarily.

Thanks,
Qu

