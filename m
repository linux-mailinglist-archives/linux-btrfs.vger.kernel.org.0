Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BF75FD758
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Oct 2022 11:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJMJv3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 05:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiJMJv2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 05:51:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B082F4E41C
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 02:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QS5wM1NnHbW0lJjv6eix5XH6D1U2bfsbaz8MtP6ViYbPNbQ3288qG+UM2Ij1cZ8QC06IabCXgSNQF4rqgmZTovSaTJ3HEVp8e2JDd9eFBWc8r+jKkyLzAvf2exwyTfSHcGj/jW4vmNMcZodRLAIXXnVf0HeNHhEMskouVW02DvMwjWte3Q1t8OCobkn2/1waeMt4CIstwSRpGipCQW2L7kWq5Rd/h/Zu3MzKf2xgjzDgFWse4OqKN06FP5WXTQNAsFushamWA1zKeYT2prB5CxjtNFwxgX25oYLTO31ai0FIzmIPct/iOlgK0djK0H2+DHwpaivqyOVggJH9zdmSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTO2hK1Cs2nlIsQ8FUkiMuhE2XfZBHGTbyR6RfZHWQE=;
 b=l7HvDFFxWK8jwDoM343zEn0nNBdCLpO6bM+KH7uZ7RFGTXLiQc+f3Eil23peec5fUbbYaSjg3R0lTLdn+VJrKolaDahJs65JBmIaASQxkOORbdz8Sy7auBDax1OPTYJZ2Tk2uksqFxqito6oLf6/1oMsLiELnHrjTIo7G+StmiCnhF3SePA4fqvCscRMzBtea2lG8WYvd3yz2/qOh4xatnB4F/ZJXXFOrqecad00/Uww/XFIqSeiTT+N7hsuFTSQ8b2oWX5LIC6nxqtNkr9d6pMd6lQ22lDqGN8TMufxrfsDzre5VQ7/qYd4KAX+C8pTaabzzQ100VFUMZjheMFW/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTO2hK1Cs2nlIsQ8FUkiMuhE2XfZBHGTbyR6RfZHWQE=;
 b=4C/CpebCwz2+XRdgCY5zysa+7/ZR50Bnwm0CXo443j6EAMRmFc8db4KtFHFP8Xt/8pXs0YJxgANiZ1GGCtxM8qJQmQLn3Wl9ikxLecMfEtHsBFkwCNJQVyFtlyi+fnuZgaCEPPqH9lZtiDjzItpfcqBWNfNJEHFqso0KjhLNQcMFbgxDzjixBgZpJvEEO43nBYfcddMPH0rVGKOtJDyqlZgnCz0p7oyivO07pTt0OLcbXux7vRva4Nw4ovEG6dXffX1Jp1yNOWbNNSbIOpNLsV1kHpf2t9x7O6wlGbvRmXmu9+xq+wogB1xQ+etM1wqa6ZYgda4fBReoBLI6tjbEuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 09:51:18 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::3a32:8047:8c8a:85d9%7]) with mapi id 15.20.5709.021; Thu, 13 Oct 2022
 09:51:18 +0000
Message-ID: <7aae4b29-ec0d-db3c-c08e-ad9ab6b448a1@suse.com>
Date:   Thu, 13 Oct 2022 17:51:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] btrfs: make btrfs module init/exit match their
 sequence
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <679d22de5f137a32e97ffa5e7d5f5961f7a2b782.1665566176.git.wqu@suse.com>
 <89f06268-d610-1282-02aa-ba1c78fda772@suse.com>
 <0fc3dd35-de05-7654-b813-15367f2a71c0@gmx.com>
 <2c0f8168-3c30-6826-e035-6ab018ed3074@suse.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <2c0f8168-3c30-6826-e035-6ab018ed3074@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::15) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: a5230566-c75c-4b17-5227-08daad0079d0
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wh+q59I9ebiALrJyG8R6iZsGZ9gEraI4f3+mF/vvKHIY/sk5Y5c9Xl5lqfLCivW/ASgcXVbRE/no7wrYQwhj5Ak5gNwUMe91JAfQa0CM/groJjb4mevPvBUT9297GyHOjdAyuopaDM354sx8axsGg8a5AKe9imOlO+exVpS2plTAmG4s5ilJfEBbFhNhmI8JcpjkBX+mBnWObfKNIJ9P+ApBgz4QUrWRb1TN1ZqY2d/FumlnmBGLllXWa4pyn72n94PaJGbYvyBvQ5Qojm+dgHmJk2xJMnmMEvP8ol+gw24bmaA9uq/9v6Wt26AVm3Z1Ix7RaGHOthZxmeVIE+twYJXIbzScw4oCx0OnQyzMkiYBiL1Cc48NYcvtdKY8eZ4cE9YAV1UmMuKgUZQmcCCXGCCCKTC1WXFnxzjuKXEHGQbjMwIEtK3hTccIiGSUAStbLpwzFb4Ipi+pm/mh4Z6lMgPEDU+KaR0Pwha4DQIZ3xvLE7MOOAkpqUL5vuCcaYmDCPZStoeDck8Xh0FhCVNjtXfhsILvASKjzI1rV9uZcCAI2SUgraFvZzNr1Q32cYxjD08DpplZvjFLeUyBJAyf6HAZcydh5AHYcZAJqZpu2/yyYb2LVztunGq/wY2SKmY7M/5gynY4/5azpYfZhAO/x6li3Atjcw5S+SynXzHsEihPrbEK8Q968b5C8nSpeE7JwCDoIwau6DF3R+IkcaRWiAyW+l63xFijjZSyJDESHFw5IVf7xxWXKEHNuYsEmbIo6VUtsFQATBw+520XxU1LkxAZs11bWtemzBAMuNkCJpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199015)(6512007)(53546011)(5660300002)(36756003)(8936002)(6506007)(41300700001)(66476007)(66556008)(66946007)(6666004)(8676002)(38100700002)(31696002)(86362001)(186003)(2906002)(2616005)(83380400001)(31686004)(6486002)(478600001)(316002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejhhcWZZWkdTa0hSY3hXd2NTcWRQcS93WXFhTFNaaVFnc3JlbVRFMGtzN3lz?=
 =?utf-8?B?dkE3cWNZbW1Ha1VJOTZabFNPWWdIMDF1RDdybWhLK2M0dUEvaGlNMXI1cHdZ?=
 =?utf-8?B?ckduVmUyTkJEMEJuWUNKVy9mNlBiWnVzc2FaL1Nuc3d5SWNFOWNlc2NYWDE3?=
 =?utf-8?B?aHpvQThPM0l0QVVRRWNQZ1NLUnh3ZXU5a3F2OFVlZjIrLzNKRGU0R1hZZlRW?=
 =?utf-8?B?c1lTNENiRm93ak11ckJHTnZsNDJFRHNvK3d4RzhrTGljdXNrRVhZWWswOFNK?=
 =?utf-8?B?cWRkZG1ycC9veldOZDA1eXFqVCtjK0JyVTRkMUlTOWg4QjExU05TWWgvVGtl?=
 =?utf-8?B?akpoSXFiNW5ZaVlITU9OQVYrT2pLeFZUeTdmenhkL3Nab0Z4RjhrTGg1Mkpr?=
 =?utf-8?B?eXI1d0Jxa0dMZHFlYzNRelRrcWNpRUZGRE8vVU1FZGpaTFR1M2tFQjdHRGR3?=
 =?utf-8?B?RVhZaTludW5iOFY0R0JQYUFDMnNkYjRzRmtEdHV3aWVNRktZOTAveUhkMEFH?=
 =?utf-8?B?MUloYWxGelk2enFhRnFFUis1dktENFVoM0RvYzBFa3RobENrRXFNS0NvU1kr?=
 =?utf-8?B?WkpXL2dMZnVoT0pweGR0VHk5NE04dWgvbFNFVU9jNjNIZHJpcjhTQTRqL2FO?=
 =?utf-8?B?QTRlcXYzUnp2ZThxOExKb1d4VzQ2Y0UrNjlubHVVcWl6M1ZudE1NeW5ISFlk?=
 =?utf-8?B?bzhGeitvUkNGZCs5anhoRHIzS3BlSjEzQzVuRW93cWtNQVUyUXlOOVdEaENQ?=
 =?utf-8?B?YjM0UzJ4MGQzeThWeWJGbTFKMm9jaUptSjc4eXpTejRveDE4allNQ3NJRzJO?=
 =?utf-8?B?QVA2cFpVMS8wVXhpKzBJL1RMTHZkbUZ0NjFER1gvNnpsck9QVkxHTFdyUGJP?=
 =?utf-8?B?U3VkWFdyNWlhRmMrMkNsSmx1b1ZOUDVKM3NUOHp0eFVZdHVFdzVpdmlUUGgr?=
 =?utf-8?B?WHU2YXhQWFpqQWduQXFlMVNEbmFZbzNkaUQxYk4xNlVVUzhmRG5IaWh4NkY0?=
 =?utf-8?B?QkUvb2sxdGJPMVFXbit0RytTbUxadytkNkc0elZFSWVBTjAxSUFzRHRqRHV6?=
 =?utf-8?B?Qi96TGlHSzI1Z3UxczZoeDJhdVBEU1hLN1dPb2FjNzlFaXlxWEhEL3F6OVFF?=
 =?utf-8?B?WStwU1E2RWlmeUlZVW5TTHV1Vmo2WnZ6WjRoS0VjZmJOd2o2eE94UkJhZG9I?=
 =?utf-8?B?U2FzbmFMMFNQemQ1bG12NEN5SEFuWXhGVVBIb3g3YWxiZ3YxMnBaOXdaTU5P?=
 =?utf-8?B?SDNRWnhURkNoOFk5Y1p3cVBqdi9NdVJQa0lIemRlVERCRWV0M1NuMW9RK3Zw?=
 =?utf-8?B?bytxOXYreDlOd1VhTDhyWUJsQmIvZWl6UXR0Uzh6SFpZOHZoL0JrUVJwTis1?=
 =?utf-8?B?aGNwcWd6OVo1MkNORlBhTmRzaXZrSU1QcEZ1MnJnVys1L2FDTUlKeU5OYng1?=
 =?utf-8?B?OEhRTVkrYlJzK2dnNU1EZTZYTFdjUS9GVkNBQThhY3NndGRzNjVkRWdTNHFx?=
 =?utf-8?B?Y0xDSnJFdzdNMzFvRmpKQTh4dUxlU1ZhQUJ1S0JpVEdnMFkxNzhHcGREWkVG?=
 =?utf-8?B?dzdDQVp3cDVBdjg0WWc4VUduYldIYisxWXdrUUZ6SWUyMnVTV3RvNjZ0RnJ1?=
 =?utf-8?B?NzdoOG5jWEdrcW1VRjhXN3ZNVTFyUjRiemlpdXFSVFoxcVBpQnZUWHZoazRO?=
 =?utf-8?B?a3FxS3BjU3RjeE5wdW4zOStiUWVnc3BMNG8reWpTaVJPK3R6MHJoL2VoR1F0?=
 =?utf-8?B?RTRGVEx3TFRiS3ZEdXdXUTBjbFFKOUR6NmM2SThQQlpxZWhBSjZ4dlV2OUs0?=
 =?utf-8?B?WkZHM3k0dmFEVjVTSWRKVG1JNmh4cEVQd1kvNVdhNnZVeWdOSjR1cHd1R1NX?=
 =?utf-8?B?ZEloQXlrWmZsNkRqdWpraE00d2Zpc2tWNVFpcUcrWUswaFdUcVphbEt6Y2Uw?=
 =?utf-8?B?aGRubXJNYTBzUWhBb0l3M25QeUxnTXVNSXNiZng4cU94clNsbFlTbVYzbEww?=
 =?utf-8?B?NlhtbElrWjV2VGpoQndvMTExVlVsUk1JVEpXSG9NY3plVFB1cUxjOVBtSzRQ?=
 =?utf-8?B?SWV3MG1GbkpWRTR6SzBWMktGbTRONFllMXM0K0t4S1hLSnI2Tm5xRkhSbzgr?=
 =?utf-8?B?NjkyVmRHS24rWERVS0g3R1FNcFdQR05wakRXTjgxMjNZR0xNU01LTXZvOU9w?=
 =?utf-8?Q?01/cYwdJcVUjdOwWQdnmI/s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5230566-c75c-4b17-5227-08daad0079d0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 09:51:18.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSoM8V7YfH8zDJC8nVimXEYHUFopcXtAwJUKLGS38viaNIxAqkhOTJJnsiijGoKH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8963
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/13 17:29, Nikolay Borisov wrote:
> 
> 
> On 13.10.22 г. 12:22 ч., Qu Wenruo wrote:
>>> ?
>>
>> For adding a new sequence, one has to understand the dependency (if any).
>>
>> If no dependency (which I believe is the most common case), then the
>> generic idea is just to add it before the selftest.
>>
>>
>> The question would be more critical for open_ctree(), in fact
>> open_ctree() has a lot of cases that something can only be initialized
>> after its dependency.
>>
>> In that case, your concern is correct, one has to go through the init
>> functions to find a proper location.
>> And unlike the original code, it's one extra level of indirection.
>>
>> But I'd say, for most part, the init function names should explain
>> themselves, thus I hope it won't cause too much hassles in the future.
> 
> 
> In this case I'd say open_ctree shouldn't be switched to this mechanism.

The truth is, open_ctree() has the worst mismatch in its init sequence, 
almost half of the error labels are not properly matched.

And for the several init functions which needs dependency, it's not that 
hard to grasp and put into proper order.

Thanks,
Qu
