Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D4A48FA07
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 01:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiAPAmf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jan 2022 19:42:35 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:31885 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229829AbiAPAme (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jan 2022 19:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1642293752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b3hz4u1bA2UTB9yW6eisJalcEsv0TJkC1/bFkYsSlpU=;
        b=AXWDkVBxUj+XxJ9eeo/LH/CwVYKVEedh5NP4Ftzn93EsORG1oteTdwpJUPUWlB1FTPFnTB
        CjsYKnWCPjDLxY2sCTtwZiJt51NwYxV/3AczHElST2+ik8AS3No6w7CDdTQYYWOV26Rdlb
        nDo8ZGFnBNQwrcKyQscqHHxXEVGqKKI=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2054.outbound.protection.outlook.com [104.47.10.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-j54KNSFtMIyt4mru4JFfTw-1; Sun, 16 Jan 2022 01:42:30 +0100
X-MC-Unique: j54KNSFtMIyt4mru4JFfTw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV/oibl1Y9eB5Fce3E4C/rVEyHxccJ83SARd4SFrpeTLpA4tgdm5SNvyjbCSruHSCU9FoXzWkdrGvuufGUmRe1XSNjEvxfgZaIUavkyymHNlzRwpAYGzyQFK00UHzFWhZnRbPGf/pWRYOG89fpIrjXUidh0yKc/e4qWq1qjcGPVoQDY9HBl2BG2xoiYglQlX7IQn/kTrQ/z4UNPfTvAaAhgfPXE3eM7MC6G6PWL4MgjPHSMs4lYcrI4EfFzjjO3Kz3RCLSUbLBRJQFtfS/0xmPyLpiTFAnP/okKcuYkZrPPjKAw/+oruYYpwQSOzz/FmVqvCGVvgY4w6zno58mkwKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3hz4u1bA2UTB9yW6eisJalcEsv0TJkC1/bFkYsSlpU=;
 b=WMnxQ0qjkWGaWQFUY3kpKIw4Wnw6jDtpCKnDcoj0o4mn+8C2SCNLW/2PH/bSqNyb1lSNlsYkWZaOskqAuFOoK674ZV6Hzn32DMAp6FGP+BJHu7vwftBWP0limIMWo+PfI5t9fDN1RJ/idwhwAXtj68d3jpiQwt+CrSOY93pm2phdeMh1yjP9xZIGq4TD5Qaslf1JEwFCdSZ4J10eHmCqst+n1jODqVvaXAqJHs2e2OiUMcGuesaxzzCiOC8lvhZEcR/wIeVAouFpaoE6QwFOsAUnubBryaB/LQQU3ZSqoQKGClRw27zjITex2RsafZz+ibyEKrppqWvWC5klCaBfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DBBPR04MB6090.eurprd04.prod.outlook.com (2603:10a6:10:c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sun, 16 Jan
 2022 00:42:28 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e%6]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 00:42:28 +0000
Message-ID: <ba6db0c3-6605-d5d1-de04-051b9f099547@suse.com>
Date:   Sun, 16 Jan 2022 08:42:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: unable to remove device due to enospc
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>,
        Ross Vandegrift <ross@kallisti.us>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <20220111072058.2qehmc7qip2mtkr4@stgulik>
 <CAJCQCtTKd_yMUa_Fr9bGuhPvfYWPuY0=Vs=-+k85gfZJqLK_FA@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAJCQCtTKd_yMUa_Fr9bGuhPvfYWPuY0=Vs=-+k85gfZJqLK_FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4ddd542-f6a8-473e-1034-08d9d8891286
X-MS-TrafficTypeDiagnostic: DBBPR04MB6090:EE_
X-Microsoft-Antispam-PRVS: <DBBPR04MB60901EDA8D70252ED21CB9EBD6569@DBBPR04MB6090.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhFZNY+By/ukFqyrGF41l0jup2Ls+6cFuzEBkw+ZqmMehnvqfOhSLUrdEXgLpocIy4Q7585bwuWcnVu9vEfZmPdWr5+Ih5fBSvxey65ROoGOYsdLnjkO02D70tSY626yRRcIcKmXejvNtW1mZnQVtRr/TlHJVbBiEXWODtFIJHErh1xzDlrmoQilR5mcnlTjG3JhqQZDcwk2oRrWUBd2p3JXUrmRcNUeL4cyj3XSYPYfuwTdZ44XrJiiZVOcVhlKNlKOcdeCDI2OedpUwG7eGpQHvfbWLqJ8ue/lXUC5Ypk4Vq0eMssbJ0ls7Di19Khl3XUMmBG7bpiIUSA7TaLGa9n7VCVdGj5zzQ3jWTpKHVVd+igmaOjuVaxbgQBRltNPu7vtdS0a9wGU3LeQVWI+WuQBGYE3QMze9pY/ji/V8z3tATVvfk01F18X51xv3vvoaEjEboo1CcLPq+1zLqfKSYyIHI7lReEkLzgibHm5BidYChdHH3OJJzEY9/2cit8SEizgHB211ii5z0apA6ydXdrJ4AUFBc4+D5sW8MiK7wfkgfA/qkfKMiIkH6LcKRwu5/mSmdsiPat90SiMYjsnvpuOGuXAe8A0pSoIeZOvGWXTQJPap2Gv4eT+hG3mRH2XjJrwQcjYRhFLMcLcTSHMr+uK6XwSuQdyY68btQishLaJM4AlXwWrhijPLraweepIUA8vd05GL3thq1yiZbbxiVPWZ2y9kTeObY+LDGQy5FY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(66946007)(6512007)(36756003)(31686004)(2906002)(26005)(110136005)(5660300002)(316002)(66476007)(8676002)(508600001)(54906003)(8936002)(83380400001)(6486002)(66556008)(6506007)(6666004)(53546011)(2616005)(186003)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkJIejdqcGNkKzZwb0JHZUI0YjJIWHdDWnBpTTR6eTBPeW5oTTduSUU1L1Vt?=
 =?utf-8?B?L1RlOFJDMHZsNWJGbjZCUXVGM1BjdHZweWxOdldkRUI5SFNqMEZCaTc0RVR6?=
 =?utf-8?B?a1JlMnV0YmY0YkRUbWU0Mk52QnpjbmQxMGZKUzhFVjl3T1lQSU82djNjWlpp?=
 =?utf-8?B?KzhxRDVyYVR1bk5uY1N5WDNUcjhSL2dLb0VkZTBqd0FGV1RjN2ZPZjhRQXV5?=
 =?utf-8?B?Y0hKRFZYWTBrVzU1U1V0MjJwL0hWMEZIcnhlK0JVTUsrQUk1SXROK1hETHdD?=
 =?utf-8?B?NHB6N2pPbEhZTmJMckJrVFhwc0Vmc2dFZGpXNk1YTUxXNW1DN3F2QXVxdmU3?=
 =?utf-8?B?QlZrb1FLYis1M2Z0Znd3VTVGcGJDeUVsazVOT0lqZXN2cVpPNkVPcDBsMWRB?=
 =?utf-8?B?V2NmNlk0L1oydE9MbkRsQ0hsN29PcDBEUFlzY0Rqa1QrMHlucmdnUjJNeUNM?=
 =?utf-8?B?NWdBRW42RithUk1xZXd6cHFCSUlMbVVuUmYrV09tdThkTVhONU5pRmszVG1Q?=
 =?utf-8?B?VEl1bUprMHdJNzFaRm02TldJVzg0dU9VMHJoVmNTSjdOUHdjdGdDTU96MnN3?=
 =?utf-8?B?NytxbDR5MU1uQWI0YnpEUjBTM2JtMVZtZktMNVpUMlA4UTVnajNyZTI5am1T?=
 =?utf-8?B?TUo5OEZpdlhPdXVYcVlkVjZDcmVleUo0QnNUTW40NDVieWNzb3VOU1lBVnhC?=
 =?utf-8?B?V3JoeVZFZXA5ZVpHbFREMkl4WmhuVWt0MkNpRGNINWc2NW9SUFNoWDY4Wmpm?=
 =?utf-8?B?T0p3K2lFNCtacVNMNlBJTHppL3ZlUEpTb3VIck5jc3JsQmtZMnF4NDNldmZq?=
 =?utf-8?B?c3NHZjVEdGNVNElhdDhhUm1KbDJ4bjUrRzU3UFJiWVgyb1RNaGQ3aXJ5My9h?=
 =?utf-8?B?bEU4ejhtSmR6OGZQS3dEa0JFSElaOGxDZFpRRlFYcUE1Z2FJQzdiWW5XYVVI?=
 =?utf-8?B?VE5nNExGMU0wQ1k3bW1IbkJpNWNSYjFhdkd6cVd2V0JMUWFiWE1sTE0vdFJn?=
 =?utf-8?B?MVNlN014VDl2cHkzVzNTOUdkRVBuekY4UHBhRWpjVllGeGNUUXh0OUJFaWw5?=
 =?utf-8?B?a0ZBZGd4NU9SazdoaTdxb2ZyemhyelZIOTMwWEsrWkhZdVl4NHFxQ1lFTTFG?=
 =?utf-8?B?bUh1WFBGQzIxd1dkOTlwdktpblBMWWl1eDJUM1Z6aWZqc2Zrc0VmdDFCWkRE?=
 =?utf-8?B?MXJ1M2RJaDludm8wTFkyL254QlY0UCtRekk2RDFKdVBBYTQ5cm4zSUFqK2tG?=
 =?utf-8?B?VHk2Z3ZPZG9sQzBDQlc1UEp5RW0xZ3RwcmVFT1NSbnkxYWJTMUJscGJROWxL?=
 =?utf-8?B?RGJDdTNRRFJRSjJpM3hkMkI4TlNPVUpVSnpkS1VIWVhzOHdud3ovTi9FWHZw?=
 =?utf-8?B?ZzhmTlZwSG44bndrU1ZrcmZKUWJOWWNydFpOVjFKNWdqVFY2bDRSU3VpYmYx?=
 =?utf-8?B?MDliS2NvMlRFQzRkT1h3SmEzcnZUWmo4Y3RqMjZSa3FGU2oyY0pDWGt1Qmlv?=
 =?utf-8?B?WlJLeFZsM2VHd0h4NXpDa0dXYzNwNVhjN1hNWjFTb2huanBMbnppMG1ZSkZt?=
 =?utf-8?B?VDhCSGxEY0VyaWpEKzV3Z1NxT2djQlFBSnhETUYwYmpWREFFakJXQXM0bk5o?=
 =?utf-8?B?Sk5ubTB6QnBybVVNVFF4VStxeFVseGtxNWVrWVR6SDd6cTdzL0dyUXB5Nmtk?=
 =?utf-8?B?Z3dxWEcxZC9FVEtibnYxdmt0cHc2cU16dGp1bjMyZ2UwTDJoaHJOQ0tzenE3?=
 =?utf-8?B?Tm12U0tlcHkzR3FNNVhnaUFEWTlMSzJrLzRMcC9XTUgrbVNWY053RE12VlEx?=
 =?utf-8?B?WXgwR0ZvNTgrN25jem5xcFFuSkljRlRoV1hNcVVDUXZuSVFnVTkzdGZnck42?=
 =?utf-8?B?TEcwNU0yS2JUVkJVMnoyOHl3WGw0WmIvUnVGTlpRU2hTc0NId1NLZVNCV1Aw?=
 =?utf-8?B?UWFhNjFMWVMxZjlzazVUbmRuYVRsVld1YnBpQ2VkRXhBRUozVkF3NHY5bm0y?=
 =?utf-8?B?a1BNOGEvRFlGVVlRYmZPYjJ6TkduU3h4Y2lZbTZIUHRwdndqam5wL292cWNU?=
 =?utf-8?B?OUpORlNCWWdHUWsvZG8vTk1kbFpUeUxlU1F6dUgyY2hPY3hPQ09QNDM2UTVN?=
 =?utf-8?Q?XI7k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ddd542-f6a8-473e-1034-08d9d8891286
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 00:42:28.5979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KtB1KTjItPtYVtTi4ERy0RCHS6vzAnAd4oeluNI6+gfbtI+9qWZWzruAsZIyUGq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6090
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/16 08:39, Chris Murphy wrote:
> On Tue, Jan 11, 2022 at 12:41 AM Ross Vandegrift <ross@kallisti.us> wrote:
>>
>> Unallocated:
>>     /dev/mapper/backup      7.24TiB
>>     /dev/mapper/backup_a    2.55TiB
>>     /dev/mapper/backup_b    2.55TiB
> 
> You might be running into this bug I mentioned today in another
> thread. It's an overcommit related bug where the initial overcommit is
> based on a single device's unallocated space, in this case the 7T
> device - but then later logic results in ENOSPC because there aren't
> two devices that can handle that amount of overcommit. If you  can
> remove /dev/mapper/backup, leaving just _a and _b with equal
> unallocated, then try to reproduce. If you can't, you've likely hit
> the bug I'm thinking of. If you still can, then you're hitting
> something different.

I tend to believe it's a bug related to recent flush bugs Josef is 
trying to solve.

Adding Josef to the thread.

Thanks,
Qu
> 
> However, since these unallocated values are orders of magnitude bigger
> than discussed in the other thread, and orders of magnitude more space
> than is needed to successfully create new chunks on multiple devices -
> I'm not sure. Also I'm not sure without going through the change log
> for 5.15 and 5.16 if this is fixed in one of those so the easiest
> thing to do is try and reproduce it with 5.16. If ENOSPC happens, then
> try to remove the device with 7T unallocated.
> 
> 
> 

