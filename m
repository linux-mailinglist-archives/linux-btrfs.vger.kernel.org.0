Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443206BAA64
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 09:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjCOIEi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 04:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjCOIEg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 04:04:36 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48342213E
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 01:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBoOVIGl3i8/j5o5aM+9vpyzXMRPGK40cFjda9DPmESRnFIo8GNz0Rd7ss8ojJnjahdCgwSK2XxViKUgvewO5IN8ETpKYSiiUKZeFRxpmsPJ9L9dK35fbyw/CrHPYVN2dBkwELTHrzi03+TnLWEWgKTSdaAerDV96KVhrl3kGjG2s3eiPPGjIoRbjmTobh10WqjHAKbYUebBB3w7VGma3sPJyx/stcNof4QpGCmKCCYu8UFmeXz8cwk3y1BBPzL5I2/FtMAhfiUkYk6iMoXgviJr/tovEwLh37pYak/32pofWIcvRFaRMqk24kM3udsGBJZqKeprO9utbq29N9hcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfKxkd4nqxQA3uLuTDawxZMUS5Cq2r2i3Nf4gubPcIo=;
 b=LdcXUmbbmKunuRN3cV6jQFgi1c1j+i+UqKaWPkpzPhtIUxGJYpdFzwV/awAYEeLECYAp2eG365Y8U9yLGTXK1OcgFDJVeDOHGDKcEy5x/xs4dm1mAaYDOivDBnNqWXiw5aLbJPk6dcGWGpiwhmk2lwbGZ1vdCYhmCoC65ZdaQ4fHSM3ay6pFfEgf11X4G2lDbJ4ojL9A2/MO7Mokdh3a9PT9gTVSx2kv8jfJYF8k8/NyQA2V0ELZpgW/n6xXo7EgRGW+9nxz2XVspkVBGDvMKxAPpXDYs2LtcPJPxT5nrZzQJDzy+dZmOizlm0BMg+6hlaYBQgBcAY6mtn9gohsenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfKxkd4nqxQA3uLuTDawxZMUS5Cq2r2i3Nf4gubPcIo=;
 b=b5SP1Y3Om4yGci9U/WFKsweQTmPc7V4lpDxk05suvZgib4q2FJRgwl4aaMJ6S0xjMhWmL0bByjZzEZZhdBkLOOTmn6hDJ8pu6Tw2jXb3GggMkglfTy8UET3hq//JJf0gIRRQWZIg9g/IWutripLo/IHvFXg0CA0Evbyu5Ncy/Pl9IotiInmJaenwHrozOkZspiqr21y1LuWmIgXGvOiuk5M6Xk0Q7Q1E+OHqw/tQKrRSiG3ex93BLcbKJyaYzh8vaxqdyqzMS95m2YJPsV0sJJStbI4zflQ3MHoBEpnvCnCpCTPpowPmRU1hGvRa2RxCsrFB4I9TO/apxftQAEjsUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB7623.eurprd04.prod.outlook.com (2603:10a6:20b:29c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 08:04:28 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 08:04:28 +0000
Message-ID: <736958db-3c6e-7ae2-b1b6-c658cbbd0b96@suse.com>
Date:   Wed, 15 Mar 2023 16:04:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 02/12] btrfs: introduce a new helper to submit bio for
 scrub
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1678777941.git.wqu@suse.com>
 <27af1ebdc7a7048895be3eaccd3fb437337e1830.1678777941.git.wqu@suse.com>
 <ZBF5r3itXwDKCsA8@infradead.org>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <ZBF5r3itXwDKCsA8@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR21CA0010.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::10) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 346feb1f-b81c-41ff-ccdc-08db252be60f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTgPdkjQ2W2WKwvCOpOXSFr4+DLHiPmxlgtzLHZlfjQGIpGiWQXH+Pn2M15UO8vzgIEQJ6RF/8w1X/gzVOBh753iGHySeVpyyentx3iX5JDOocJBXIQBJZbmwBnLIUo+/w9UnHod+/Xz5QJ8EsVHcYyiorw3BbcLbZFLo2+SLlKbH7bjpEaBZZ1Q8nFTMf3IALDutDQYO7C3q4b2Ry7ZUBkKdqmRO7HbcyV6Z2AJK3AYyGcCnYvfVem1Gv7sNWJ4CRuLJz86DxDkmKBNjC1Af5O5xi4L1a1NwEh+Sbf5pbzJ2GP1BCEG9gCJyXsc0thXQ7XucuMQfGhYbqY0xzHbTlDwJ8ic5gbvK12mUFxAgwgW44BKBF3C5jrI+JLv3Qs9HfQk96e6yLS2seNkrH9dxy9XuYjES9kXSk4kNFaP/Z8EE+kCksNel/QeuoFH7sXBUeL/+Uehphis47AOIamH6ByFihF3VLPsry9RjYQHAN+yM5SIdU/X8Oz7+g+WWk9JlU19wTZ0h3z+oBBtAAvi/Q0CFoWCyjoIQZcP0Fp8EtgR7uzbqAdsgYPY4Zx+MuT3poZRkjbf/LT1YF7GJUheY/eQSO0HGvg4dljwrSaxU2pQ7ao4W55AJKwo30N6N5O/8dQp+05DGrBE3R115ACzou9F1INlkMLMAhQYp8IdQP/kRyL8jTYyv+irW43dRTjSM0Ywzd9aif4i0AClkOPYgEW7Duej5rrrcJV1UFpzoWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199018)(8936002)(66556008)(316002)(66899018)(478600001)(6916009)(4744005)(6486002)(41300700001)(4326008)(5660300002)(66946007)(66476007)(8676002)(2906002)(36756003)(2616005)(38100700002)(6506007)(53546011)(6512007)(86362001)(6666004)(31686004)(31696002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTl6cUdEbjNqM1FZd2M4M0t0SVlPV29nZ3ZYNU1mVXZjUEdkYU8zZm5FZlJH?=
 =?utf-8?B?SzR6LzJncWkwY2lESkY4RHJKbWR3SXRRa0JGQm90SzhVUzEyeklDOE0vMGVj?=
 =?utf-8?B?ajFkU3lnMitoY3pXWWVQTnNFRi8vUmJOaGUxdkliTjdWZ0x4Ymt5ekVLaGY5?=
 =?utf-8?B?Y0NRQzlwSHBFbkpkblJOVUhmaTAwZW9lYkRxOWFvaEJMRFNZSlk1OStxclJs?=
 =?utf-8?B?UkZOZ0ZqZGQyeEFsMjFCNE9QVUhYYjhBYmdYSXRlVmo2ZytCUHhYU0lKcXNv?=
 =?utf-8?B?QWZsazIrNGwrQWtTVE5UYnBRZ0V5dzltNjh3cm1SSDJ0Qk9lQUVCMitac0Jk?=
 =?utf-8?B?R05CRjBhaVpZVU5MR1J6dTVZM082eWFxNGlXMXNuN0oyL2VVbHVhMmpQcE14?=
 =?utf-8?B?WVZ6c2QxdzhTRlJaNVR2Y0MrUUs1dUlNTnB3YmttdDlXNWU4eVg3ZjVuMHE2?=
 =?utf-8?B?R1BQSEhERlNxSEFaaGpJdThkTjJoMk5xdzlBeXV1SExhM2s1U1FvV29tdFNv?=
 =?utf-8?B?UmdYRTdIdnE5WWpDbXVGSmNnMU5HOFlKa3FDV1VEdkQxRC9XRU9IWGc4bWJ4?=
 =?utf-8?B?T1hQWUtyUmlOdGFQdHduaXdyUGFPVll5OGptNGpsYkxYTVNXRW1TdE5SNTd1?=
 =?utf-8?B?QUFMQ2ZUcWZhaEJydnVTOThOU01LWDlPdFNYdUtKc3E2TzNzR0FFWFluREU1?=
 =?utf-8?B?Si9qaWR4WG4wSFpKQzJ6ZGtvdlRnN0cwN0hWYTFpUy9NeTc0OVFZOTdpY3Vk?=
 =?utf-8?B?bHViVEhIVGlBSTZOVThYb3h6alpWWk5EcXRWT1VSQjZjN2pQVGtRWUl1Y1pr?=
 =?utf-8?B?ODNJZWdsa01wVjVXelFvMTQ5Z0RvQUNSSHZydDlqRHRHcjl6bDhxOHZtY2t5?=
 =?utf-8?B?WjBBU3VHcXBxMHoyTDUvazZEUDh4OUIvOUVoeS9oS3VTa3V4S1c2U21VTTBp?=
 =?utf-8?B?M1ptelVqMm1LcmwxYnJZR2tlL1UwL3FIRzMwblNUa3FWcjRkNWE4aG9XSmJq?=
 =?utf-8?B?TWlEM3dTWUZGMFVXTzh2c3FRcFdBTGFqOUFNWGhXb3dVNEJHdHVuNTNQNmlJ?=
 =?utf-8?B?MGtLUVA5SkxjMTNVbjh1N2xIY3dwemRxNkgrUWUvYmdPM0UxRHR3Nm95bTFB?=
 =?utf-8?B?aXozSUJCUWNhY2lJY0xWeFcvTjJnMXdoSENNcmhOSnFiWkZCS1k5RGZPcytk?=
 =?utf-8?B?dEdqRjNrbjlZQWhVb29DY2JzTlVBaXZZcnpmVm5KUVNlWTVNYjhucU1jVUcv?=
 =?utf-8?B?bmQ5WHdEZEhOQmlpZDA4R1RoNE45TkpvV0JCbVZ5MVcwd3Fuc3Erb2JPYmVp?=
 =?utf-8?B?ZEFaUW8rekx3Rk5MSkU4ZnB1U3VvR2ZTUU9ya2RyN21ZNHl4d1pIQlQ4Mk4z?=
 =?utf-8?B?clJIMUFML2wrRjNSbEZBQXhYSVFMOWgrQ0luZlZjNzQrWkJvc2JYN3BGZjJL?=
 =?utf-8?B?RGUrOGF3RUk2M25oMGlNUDBFL2JBYjFtL1RZNkNUKzN0QnJtM1NCK1FDMFNu?=
 =?utf-8?B?ZzM2SVdtNkp1alAzM2lrMm5sd0hJb29Ma1Rwd0dkQjl6clgrOFhHaU1Ycm9q?=
 =?utf-8?B?S3paUnJlVzY4OWE5RnhjZ3ZxRlQ0OWxhT0dFaVdmS3RIMUt2aVlkMnV5ai93?=
 =?utf-8?B?VXdRcnZkZVhReWZaSEg3bDNBMkZzMzg3OStRbk5CWmpUWlpzV0hDTDFmcmVT?=
 =?utf-8?B?WElQdE13bS9Pa2pFdnRyeWQrMDNVSS9qd3p6REJFM29ZbW9XYVJza1NldEtw?=
 =?utf-8?B?dHd6Z0JjbURxeFBkVUErV3RJV2RlVXh6UHpiei9kZW1JYnNNM1p4UFBXZlhv?=
 =?utf-8?B?UTBzb3RXYjBrbldXTFNEY0J2bGQ2Y1c3cE1Oc0lTdDJIRVRwQlJldEJRT0Rj?=
 =?utf-8?B?aXkrMTNnMCtianhjOHpyM2EvTmFqUmVZM0tBeUQyK3l5K0NDUlMrY1lrUEMv?=
 =?utf-8?B?MGxXaUxmWkFQQ3QvRUVXakxtcjJzM0ZWUVR0YnZGaGVJRFJCQk1qSU9kOVlO?=
 =?utf-8?B?T2hWTHpRYXp3dUFrK2JVaStGalg0dUNGcm43czI5NFE2WWR5SmlhNnlFV0hj?=
 =?utf-8?B?cHJYMFlrZUh4TVFNZGUycGxwN2kxTFhiNWFzNDBFNFZodXNGZy8yTlhYOXpW?=
 =?utf-8?B?UUh2TDZYd3VndDkvc1NxTHMvTFJJOVEwWGwxcnZtSytuWjZUNzZ6SHRleHpy?=
 =?utf-8?Q?xXk8oYcK5bSSrat9W/rJALc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346feb1f-b81c-41ff-ccdc-08db252be60f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 08:04:27.9620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGli+kBY+6Jhxof1X6bibal9H2e256alBfisyDF4x8+2QPvWpz44OoEE1hb2ZUdf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7623
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/15 15:54, Christoph Hellwig wrote:
>> +	 * @inode can be NULL for callers who don't want any advanced features
>> +	 * like read-time repair.
>> +	 * In that case, @fs_info must be properly initialized.
>> +	 */
>>   	struct btrfs_inode *inode;
>> -	u64 file_offset;
>> +
>> +	union {
>> +		/* If @inode is initialized. */
>> +		u64 file_offset;
>> +
>> +		/* If @inode is NULL. */
>> +		struct btrfs_fs_info *fs_info;
>> +	};
> 
> Ugg.  Let's not go into too crazy unions here that make the code
> alsmost impossible to use correctly.  If we want to get away without
> the inode we just need an extra unconditional fs_info field, which
> is what most users of ->inode actually use.  I can take care of that.

If the memory usage is not a big deal, then I'm totally fine with a 
dedicated fs_info member.

Thanks,
Qu
