Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6CF55AD54
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jun 2022 01:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiFYXEP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jun 2022 19:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiFYXEO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jun 2022 19:04:14 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130088.outbound.protection.outlook.com [40.107.13.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE9E0BC;
        Sat, 25 Jun 2022 16:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/ZwlbwpnIoRL1bJ9M1B+JBp95mvqyzX/4yZaJu4pqvMK5avILhW+X17Kv8cvuoXX+BgMzhhzsi/DP4E9fDIT5m0etsnP9TLCbV9D5Tds/uCph84da6nz1dDVkK/UffLZFrjYw6DePt+EwxQPVYTxCWCisB82wgCu6vObN9G41hyhjj0yvC/I3r4JqaldHz2wkzlP0bCJi0s6dL7rawrejVB7CF20Uj5kqKhmcgDmeM2lO2dIJTdpzVpCEaTIOF89OIsTcvJ8TxdzTrPvRz8IslBHxiBf1djYJXhzQ2dG+gOYm8ps9hrwOTyecWUHNNtl/gK8g3zDJqZ6CS9EgTHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tXetC1KTZ7TrIx0ND9aci6HN/hQN2kfrkh/jeEvyQ0=;
 b=IA+Hx7ql/YUdDrN7I3h9QPNF6z8zi0GK01M/OD1I5xeUv/x2OelKKrARmRIrI8+UmfA/71CFr904nzqLzJYvka4444pcA2qIfJS4C/HDESCKZr2jbBUYA6Y2lSwJRZX9d9wqhWVJKPgEZwWO9/eDCMJPr7SP/XBaYVDu31XNg4yZrmTdfLEwYcrU0x7Ejy7A5OD6k0RDQbwYISEhpMZDBaJEfwqc75OgtH89aSxH9R+Cv+8vlviGNqg37PXFM+RQiLk3fDxyxn1qUmUgIeWLbgIrxoQsJIqHXLap1fD2eN3IZ7vg28EKtYIDsMjQ+1stzqbcjoNMQHCN4VfSLrkUlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tXetC1KTZ7TrIx0ND9aci6HN/hQN2kfrkh/jeEvyQ0=;
 b=SY00fHcKSq1eFldL5I07vHefhvSubTJSfhSnBcm7GWgmAj7HS8qHM63nM4JZoP9qHTJUOJK1JivUXX+XS5J32Fs+f0dUjvWVzEjRJfv5V5NiCG6NxL/8Q8velkTFx5ifxeoOed2sRDJE2N5gllfBC8NcM4St//g1L2aVsRdLrfzMdnw8w5FiLkDfWpq7aAuEmxgepGsnSR7/Qa88QdTVLKY3m5Jcd11yMvpq9TwrHgkmFWXKiWkYE6kk/AHF3sPOqMGxYiD4edmemDqEV/9wOIN/wPOndNDF0Gu5icx0UHKTOUvdoD3+dbYjyTNi6uubO6d+Po/iTXpdMu92fz315Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM0PR04MB6884.eurprd04.prod.outlook.com (2603:10a6:208:183::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Sat, 25 Jun
 2022 23:04:07 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::2581:79a4:26f2:44e9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::2581:79a4:26f2:44e9%5]) with mapi id 15.20.5373.021; Sat, 25 Jun 2022
 23:04:06 +0000
Message-ID: <f65fd4fb-675a-3f9e-accb-77db9ad7d551@suse.com>
Date:   Sun, 26 Jun 2022 07:03:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: Convert zlib_compress_pages() to use
 kmap_local_page()
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Filipe Manana <fdmanana@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Gabriel Niebler <gniebler@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
References: <20220618092752.25153-1-fmdefrancesco@gmail.com>
 <3110135.5fSG56mABF@opensuse>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <3110135.5fSG56mABF@opensuse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::20) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67bb478b-00ab-44fd-4a53-08da56ff0146
X-MS-TrafficTypeDiagnostic: AM0PR04MB6884:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6FuJQAmYSdpNAzb7hU58NintoRqnUq+BF8eG/YrnF9F71NcPmhXtCSIssdMZ4ZQAjHFwPhZhOIj1A1b0UxLulBOSbgQvXAB4lJaJ5jJlE6KeRPkgoDRY9s63wyTVkECPp/giFlxgDhhBbK88YKdH9mPnhe6CKhqRj/kVwJE/9qO4jhXTIDn3x+Qz+w0klOfLL0O2TYbyrXzNfkNDdmrfTa18z6UbrPwQe6wNJcRecWGpbrnbvhbN7ezC+1ATzbaK5sMxtoBMuA0lukExnhGYunU3SRnUFrwQcPuMx668T8nPAdfew4reYexqYIhHBmPnKLJRO56U2xIlx7AQCsV8+IqjsZQ/DF7RUKScHCrct3oT3cCjak2s1z6eQAL2/T6r74o0rpXS478Zl+hL3uC9WmqLYBQvgUxcSQCZJHfV9Kko+EE+q5MdD7P3rq+CIKvUXKRnw3EVGeixhuxm17I9kDCkjwZTviaQPeBvu4kYOoiF29rBEYYQDD6T4BSzBi2PqHvXwkabCrC5qWIJTDV1peB5ceDhGBW9i6zJbxDmY7TNs3xdAw08xGav0lcMGnWZWcKDDkJkwOA0ZzxX7y4ACLrb/8EM7kz01urXtp0qojH5yySU5JJrcCX883vacBx6yBcBifkZGFGgKLxNak1nGsmw/eGOkMg0kNtP8+/4ojsoN3Th/nkBdaBLXkPu9D3hbZ2o2/t5uxj1Eo1jVIKi8tpeCYCcuuyGPkUlAs9rcV/87QVADI9KXHpfkBSYSZzQB5O2dFAMNIDh+KPdpRLUNO5LQ/hwwps9Wq+039VfJonRO/2czrB0Gm+wwqNWgNrkWoUBePSljHSNevficfz1KCma8GhpHw6q579wDCdUKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39850400004)(346002)(396003)(366004)(136003)(5660300002)(2906002)(36756003)(41300700001)(86362001)(31686004)(8936002)(186003)(2616005)(8676002)(31696002)(966005)(6486002)(316002)(38100700002)(6506007)(53546011)(110136005)(478600001)(921005)(66556008)(66946007)(6512007)(66476007)(6666004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGtwUmdaL2VaMU5MVEprY2hvNHd0a0dIM0pUb0lkc2w5NUV1L21ZZ1B2Umxr?=
 =?utf-8?B?bTdKUnZtSElBMUZvRU5RajY4bXBSSk9Yc29pbXVvMDFqSzNNcnNzWHRtOGhG?=
 =?utf-8?B?RVlrNnV1MzdKWkhkUzJxZDhNZGczZTdjejFMbml1QVNNdDVqUXBpTm5VR09W?=
 =?utf-8?B?cEs2N2hhelp5enZSZzVvV3o2am9iNkNNdEVtTHMvTHFlN2ZTTjUxbW83NHcy?=
 =?utf-8?B?VGdBN2sxUEx2dzdnNEdQVm11MjZvNTJRVkVXU0ErQnYzeDNzejJoRUVMaFJN?=
 =?utf-8?B?Tm5LaFBKME5YZERHMWpCZ24vRG9pTlQ1aTEycThNS29Ga0hWbFkwaExjYzZB?=
 =?utf-8?B?L29vWXU4dTAxUC9BYzZDQ3E4bHRCN2szZ2xGNDJKeEZSSngwYnhnODNqTlpm?=
 =?utf-8?B?U3RUTjhvRjZid2k5eXFnc0Uzd3dkdlduSWFWTmhXUjFzY3FuOWhJS2xxL3F2?=
 =?utf-8?B?VXE2MkhMTFVoZ0pSWXIyTVFYK2NqYlZ2UTRkYUxBeUpUc2d6UXVBR3FjZnBB?=
 =?utf-8?B?dW5VNEZYMWRYOE83Z2JjQVM0NTFvU2UxcFlBSTIxWVo5UUJ6MzJsMEJKRnNx?=
 =?utf-8?B?ZUVTbzJvQVRjUnk2bElLUTg0UFdXUTkyK1F6aFJTUW1mZ3c2cUtNd1JnQXBB?=
 =?utf-8?B?TERMNENqZStsZFdsSzNaOW1ZdDdvVFZWTkdRWEtVVXdLUVk2Ulh1YnRXYlMz?=
 =?utf-8?B?Y1dvRDlMd3Y3UDA3YU9IUEJ0UzNaWlpSN09JU1l2QStBTlpUQXZUQXROUUx1?=
 =?utf-8?B?bGVtUmtMUnFkTDF6Y0R1YjhNQXUzQ2w3S3M1OExGdWdyaGxPQkNCVWZvS2FD?=
 =?utf-8?B?RlkrNEtCZGt2TzN2aktRSkE3WldsbXhVd1ltUWtzV09DRm9vL0RVbXJZOEsy?=
 =?utf-8?B?N25iNFlRc0d3L0tNTW9UdVYzQkxGTmhydUhseUMwdkNMcDFNcWt0ZFhPaGxi?=
 =?utf-8?B?ZmtjeGpzWHhLR2JjNU9pQlBXYkFIMGVHNTBYMFNEOTdVVmdqSlBFS3JXQmV0?=
 =?utf-8?B?cU1xc3V6RHBJRG5VMTVPMkhiQ0dnS1lRZDNpWlRadFpRd1M0TXBxQWI1UHYw?=
 =?utf-8?B?Z1M2ZHN6bUY5ZHIyY2UrMmhiMThoQk1FZEV0aGlJeWF3TXptTFFVUDBxWDcw?=
 =?utf-8?B?d0k0TmRlM28zNndrTTVsekE4SjFyZmtVd2JNcVBiY3pCSnZlQzZrcE4xZkVQ?=
 =?utf-8?B?Z0YyaTR4emxXNmR1emFEOUtpNW15SWpvYTJkSDF3dHcrN2puM2RkQThIblZI?=
 =?utf-8?B?WCtWR0NBMHlpYmZIcERtZmR0L1kyQUZsSVBWbkFWT2hKRnlyTklab2ZtQVdz?=
 =?utf-8?B?MEVXTE1KcGhuZHNBUVRiN1lMbjBRa241V1puMEZ2cVl3ZWxmUGRnZ3VTVlFx?=
 =?utf-8?B?eko3N0pCQXRTM1hSZ2xhaHJQeVFJbVlFb2RiRS9zSkhZQ2cwSlUyVnpLUFlT?=
 =?utf-8?B?US83anpMMXVNenpBb1FzNElhZzFVRHV6Y2FMUXRMSWdGU0xiT3ZBZHU0Ly9y?=
 =?utf-8?B?MXZ0R1RGME1kUGp0aG5GZ2hPVXNUek9WWmxsN0dJU2dQaDNpRE5DR2ZKNEhN?=
 =?utf-8?B?aTZQU1RKamtuZS9Jbk5qMGdFMUt4SzNYOGYxbzVqK3JzS2VyS01yS0VXWnBJ?=
 =?utf-8?B?ckJjYVJyb1BnbzRKZkdlWUhIcTJXVUg0Q0cwYTFXd2JpNDh4ZUtzVm5sNEVU?=
 =?utf-8?B?UVhIMENlb2d6RFZzZzNJYXZZWjlqUi9JYUoxOTRUUUJtSUNQaVpVZ3NVWFNP?=
 =?utf-8?B?enFXUVdaR0xCc2kvM280Wi94STR5RUsrSU04aDRNdklrajg2djJ4NDVKZFBq?=
 =?utf-8?B?d3htbXlqQjV0NWljaERwWE9CZzVNb1cvWUZOUkdsc2NybFVZaEtMTXlhK0VI?=
 =?utf-8?B?clFyaU0ybDMvNWFvMFIyUDVFSU1NL201MGNlK1hqVU1oNGZXQSszV2lyb0lI?=
 =?utf-8?B?MkhRenRtSWtBaFd5OWtyTDFiWnhDeGVzdjhjTDZFNVFFMG1wam5UTXdqSVg0?=
 =?utf-8?B?eTAwUDU3d0lmSmlIc2VZVjcxdDE5R3Zhb3Nvd0JTWlFXOTBXbS9nOHJPT1F1?=
 =?utf-8?B?ai9ISVRUTzc3dVZJUCtOTWtQNFVFa1pONmY4VDAyL0VmNEp3VWg2WFV1emZU?=
 =?utf-8?B?bXFWL1Y3M1ZhN2tBMldMcDJ4bHJneWpwU2hpWVN2ak1jblhxUncybTBCeWNi?=
 =?utf-8?Q?4DlTWIHBJ+QU0a60LCZOlb8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bb478b-00ab-44fd-4a53-08da56ff0146
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2022 23:04:06.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgEb6OvfmGGRjwppS5beiPK9sHQ+3W3w3tgiIKi7pxM8PWseJOkAGvmcb39inkqz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/25 22:41, Fabio M. De Francesco wrote:
> On sabato 18 giugno 2022 11:27:52 CEST Fabio M. De Francesco wrote:
>> The use of kmap() is being deprecated in favor of kmap_local_page(). With
>> kmap_local_page(), the mapping is per thread, CPU local and not globally
>> visible.
>>
>> Therefore, use kmap_local_page() / kunmap_local() in
> zlib_compress_pages()
>> because in this function the mappings are per thread and are not visible
>> in other contexts.
>>
>> Tested with xfstests on QEMU + KVM 32-bit VM with 4GB of RAM and
>> HIGHMEM64G enabled. This patch passes 26/26 tests of group "compress".
>>
>> Cc: Qu Wenruo <wqu@suse.com>
>> Suggested-by: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> ---
>>
>> This patch builds only on top of
>> "[PATCH] btrfs: zlib: refactor how we prepare the input buffer" by Qu
> Wenruo".
>> https://lore.kernel.org/linux-btrfs/
> d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com/
>>
> 
> I've seen that Qu sent a v2 of the above patch. However David thinks that
> it is better not to map pages allocated in zlib.c for output (out_page)
> since they cannot come from highmem because of "alloc_page(GFP_NOFS);".
> 
> @David:
> 
> I suppose that, since it builds _only_ on top of the refactor submitted by
> Qu, I'll have to wait and see what you decide.
> 
> If you don't want kmap_local_page() and prefer using page_address() on
> "out_page", please drop this patch and let me know, so that I can send a
> new patch which will be in accordance to your preference.

And that would also make the convert much easier for kmap_local_page() 
of input pages.

I'll hold the refactor patch after all the kmap code is converted.

Thanks,
Qu

> 
> Thanks,
> 
> Fabio
> 
> 
