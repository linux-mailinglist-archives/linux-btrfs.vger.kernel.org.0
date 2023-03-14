Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717846B9115
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 12:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjCNLHT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 07:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjCNLHS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 07:07:18 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on061b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::61b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD377EA0F
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 04:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5fEAn2KxF+lyvsIS3+pvY0+uUG0Rby+9uKgEl/h1TGgmkFfzSzejC3t/aZXOggsUIyrapYuk/Uv0hZuj9vPNKxAnOKW8NqkAuabjhw7WGRTb2wFXWLR5JLwqrX4ltKBNkMqUntSIbczu5Ks7l1bMaM67wyLb9qBz8lQLyv5lmrShkV02dMUKkJ1m6nMvlcyhk085DHlfXz4TMZpdoRSTwYvpu+2SwnX71Xl6EnhLTEPZK/s1tymo7TB0Q1Nc62ONXfYTWk2LWYVPSlPy1+Wlel8c5IDiWMF355Zqs8lMFwFMb+1KrZ6CFvTWDK19G7bdx+LUMXS59+6A6XLiBLQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B5uumrgH9co+BgNY8wyjksjPbkx8tYyEPvzU0v9WD4=;
 b=nPUFciSLjmHGU1QZraKl+vPzuJIuGFgw8euqaw/2L1XWGidOIND9fJ3TVggUbx/+0ROQStpphR7tsiwuleJcdZkpQYXoT/NFa3ryG8P1vtvrqQ++JwC78ybGsHpv6a5KjXeRoURJKt1MgNuW3A5reA67tieNPkC/mPrlaYVylf/4F0YDRVw70oAPmqIxuSVkV6O5vq1SPXh6oQ8Oqwre5ukCG0d3EFnFt2OWbuqMhSha7rDlbjZDbbo/pKeYVRpWJWsqwS/67TTQiGipgx7IUUZ+ElFOWRctOgCjA1jshIFt+65adcFLMQJqRwxJDmNwU88O5nK6b4MEtYI5rgWPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8B5uumrgH9co+BgNY8wyjksjPbkx8tYyEPvzU0v9WD4=;
 b=JKSeFBX+AzJwHAhE3ZcLMgpaW6pAa8hDNjudmKxUhelUXQgh2h5r0XQptEaNfPnHJ/xfrJjWNkAlLT7bNzK12GnAYMXtLb44WwhLicYTwF6t6JbVzXlrFvFF9VtiHTYLjjErFJ+F0iqg6YcnZBdKhT09f9IMDV5qyuGpNPPVEftUcEPnAv/Sbstorqu7lDS7ywanvtQvIa+YYJiovErwnbUpiwVLE3o2vMcyujNxGhxT/V4N1vOfLkdVTEzb2d54HC7cuody3QbedlmwZIVu+VwslZaDjySl7wNJ0WVkQGCaQ2dc/Ry3QcSn45Wvm8c9B2W9s9sb0XKinF9ydbUtBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB7520.eurprd04.prod.outlook.com (2603:10a6:102:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 11:06:36 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 11:06:36 +0000
Message-ID: <accc9636-bf5f-c20c-22c0-57760433eb21@suse.com>
Date:   Tue, 14 Mar 2023 19:06:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 00/12] btrfs: scrub: use a more reader friendly code to
 implement scrub_simple_mirror()
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1678777941.git.wqu@suse.com>
 <25f5bf6b-7c90-b114-b903-1fb9a78ec971@wdc.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <25f5bf6b-7c90-b114-b903-1fb9a78ec971@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::21) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 4674123c-bdb1-4cc5-a458-08db247c2d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAqJAMEG8o/9burs9xfqWHejVHtsda7kLws39/zxssHWmjb//WSRGRpzbyzvLSQ5ZrI1Pm9vfSMaq8s2Ux9A891Uyi7AiAG1LDyPESgwjZnDtktS56gKD/Fhhu4drNhhckslMSEhkZLeULe6pLXBKoxGp8AtMIBJMdqgxjPNd/lOz+AKipuxhIMCynJXCNUjvsljP45y+h5RKO8va22Q5/rsbE6RArnpkYhI4G6pMupneqdXTIwCLPuqJ8TiRgcSexNODpxBmsH8umxnEOJSu22r7BahLIpS3qrnDAY54ll9OFu7HDG1SFeO5Q7ZrOXhgZM6y6a69P8FF4Id4WWa65jxMWiyzjU/TDBa4JwfWn/fxGrvq8rwcsFzFd4HiE9Wu6ihQ8dqdSfD+6Itu40yXsjfBUisIEVUnZLHZ3Y8rpiUnBT4SyYW0tcQESBE4MJIf/XdJzWm+danvf6JYfVrM5iDfN51IH+kEfVE0fPeaeiBNVPWjT8BfBEZG0M3J6b9PtK92mCoDzPIRQxN7HugLvJKrXFpsKin6U6hhvPCfAdnEfRAr9B+R7ynI4808XcXVgYhzLwvJMLirZ1CKgHDHVzg45pPeivyPVIW31T9TOQ3ts7Sr0kc5676txYUQkPhBKfq4CHVcnzS5w6mNsN2/Jjw53QadlSNM0Xzqkxws9nczGW3VOOrpPy7RUqh7GuqA4kTAkHKoP8j0BVr2qSsZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199018)(6486002)(966005)(2906002)(86362001)(38100700002)(31696002)(6666004)(2616005)(36756003)(53546011)(6506007)(6512007)(186003)(41300700001)(316002)(478600001)(110136005)(8936002)(8676002)(66476007)(66556008)(66946007)(5660300002)(31686004)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkxaTEJlcGpTNTNGOU5hSGwzZUlaVEFSTUJTMlE1T29NOUlDcjFXajhxdStF?=
 =?utf-8?B?cVZHVHYweDZQTDVMWW9EamJCMkVMYzFDZEFXUWpHcnN2QnRJL0lnWHhGRTZO?=
 =?utf-8?B?blZzQkdJTUZNc1NWamxtYzUzMCtwclFnYms0dnhUbThiUTZ5TzdjZUFZVTAz?=
 =?utf-8?B?SUNiVnBKZHg5d2pjNEhxUU4rUjlNemJxQXRNWE1sdFJnQjlxVG85Qktzb0U5?=
 =?utf-8?B?aTRJa1czby9RamJmQ0NwU1B2S1dzQ2Z1RXRFYk5ya1RFcncwTGRmcHErMGxS?=
 =?utf-8?B?MXlzdnNJdmVCQ2ZIQzhNZUZlc01XV3hxa2pMUlRlMTF2VFRPZndDWkNhc1Fq?=
 =?utf-8?B?cmlrem8rNUpkMUlMSFRReXYxQlg5WXg1ZjdwTzNpSEhpVjU2VzNQZ3BNMkh5?=
 =?utf-8?B?Ync5bVQ3UW0rMjYxWVl0UmRxMGg0SEtkV3Z6Q0oxS0N3QjErZk83Z0pONkNO?=
 =?utf-8?B?MXFrbDdPdFJ3ekJEY3VBcnNraktleHMvVEdRTi92QzROazBZM0E2Z0UyckdP?=
 =?utf-8?B?dnd1TmpxWjVlbm9oMTBMRk95cnhlNWg1dEhKZDA4Rlp0VjFzTm9KN1VBbVlY?=
 =?utf-8?B?Z2dta0ltc3JYQWlBcGR6eGRTbWJQVVZuNitUdnpDekl3Q0tOWUdTQVJwQ25X?=
 =?utf-8?B?OERwY1VoTXliUmxJV0JCRHVtc3ZJOFVSaVdmU21GOVdsdVZ4Zk82M2xhRU54?=
 =?utf-8?B?N3RJUDFtekNSQWNKSGF6c3FrMnVYTUc3ZFJSdVVRNjJBajc4QldWSm4wTmph?=
 =?utf-8?B?eEQ0b2IyejJ6R3AxTGJ6WGp0V2QzNHQ2QUwwYTRZbUJqS1orVDd0R3FBMnp5?=
 =?utf-8?B?b091WDViS3dkeXJ3bEZtd2lGV3JiMTVUWTg4dFI4akRFWFlHYzd5VDlGZlVu?=
 =?utf-8?B?Uko1OGtnUzcwYzAwOTdHbVRobm9qNmtjMTl4QnBsV0tWRVJ4eC9WbjJEeXR4?=
 =?utf-8?B?T0tvL3dCUjNRakwrYURjVm9Vdkc2Y3NpTkM5YUxhSjBQeXlTU1l0M25MdUc5?=
 =?utf-8?B?QWlnVjdtbjh5SURSdnVlNWF3U2o4d0xsTkcvdmRUcnRQb1RDeERJWDROdnkr?=
 =?utf-8?B?K2twcDZmWEtnV215U2puVU93cDMzVThwTDhqOVdLT2tzaWVEN2xDTkNCdkZN?=
 =?utf-8?B?OEFpNGp2c3hNMDdGeDVEV0VxOHYzU1hGNGhlQmZGdFJid0lndDU4bi94ZHJL?=
 =?utf-8?B?RW1DSmRvdmtNRFZEa28zVnkxd3ZhdURUcWlPTXpWRC9zVW9kSU5TbUtxaFpN?=
 =?utf-8?B?ZHRQMk5hWlRZSGtQWDdtY2Q5cU9PTnd2a1R6UlV4QlNTU1RjdktyaU5UUVdD?=
 =?utf-8?B?aXdGSnk3cVdTZkFDNW9iVUl2b21HT0NJSnVxckMxWjM0eXR0QmZrbloyK1hQ?=
 =?utf-8?B?d1EyWlVYYnpkUE14QUp0SHU0L3EzWjk5U01KSzlFcm1jQTI4OWFpdmJwM1Jk?=
 =?utf-8?B?VXRGK3FhODZHVy9nTlppMGtuRnlnbVdRZUczZ0FOUE1ST2RmME5BTk1PS0c5?=
 =?utf-8?B?OXAvT2ZFS2paUXY5SGt0YVhlS3N5YzlNL2NXMzZnV2Y3WnB1NWdoekI0OWxG?=
 =?utf-8?B?MXRSWFg0c09zWlBhWGV1bUIwRS95QjBEenkxRHRmemNHYjVkRGJ3VzErcXYw?=
 =?utf-8?B?WDFZYURDblRCMS82RjVTZ3N1anU5WEtIY0RLN1lxTGxrMDhUTnkxaXdwYjY4?=
 =?utf-8?B?YUU5NStydXk5Ykx4N2VDUzNwNWkvSGUySW03U3U1WEREYzdFc2JZbzZ5WjFV?=
 =?utf-8?B?RWtjaFlDMnpaV20xUEZVNWlDN09QTTlOb3RmeG92SCtQR010c0tXSk1xdHRz?=
 =?utf-8?B?Wml1RGw4MTBydWVtLzBSMUo5aml2QWRTTm83Y2prZ1doclVxSzNqY3NCZnQ1?=
 =?utf-8?B?N0xyNUIrV1haTDlaeTkrOWZuRmV0dlZ5OGVTQ1JKYlhaZ0U0VUFDK2M1SjNK?=
 =?utf-8?B?L1ZIaWdRT2xDUThoL01oU1hjVU81elp2bTdjS2VTTm5QS1hBWkVnTVFuRm9v?=
 =?utf-8?B?VkVCTE81cldsZGVpM1M1M3hIRW81Q1Zka1BHMFU4c2ZTWUpiZHllTG9yZWNn?=
 =?utf-8?B?a0JoWTlMMW9ybjQzNHRpay9oUWtoeG5xeDVEaHRMZTBWRmc1emc1U3M0azlp?=
 =?utf-8?B?dFdlTnFqYnlrNy9PemUxYnZTdHExVy9QVE41NWt4YnlmMUY4dHJOT2Z3cFRJ?=
 =?utf-8?Q?Wt7FPdLSHb74Gp16m2Vm0ts=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4674123c-bdb1-4cc5-a458-08db247c2d53
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 11:06:36.2432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8ui67RYtJpEgftIZoVOwWRm1Rq+XoOMpkBxhHGHUJL4Z2zI9bk+UpeSJT2kCdqF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7520
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/14 18:58, Johannes Thumshirn wrote:
> On 14.03.23 08:36, Qu Wenruo wrote:
>> - More testing on zoned devices
>>    Now the patchset can already pass all scrub/replace groups with
>>    regular devices.
> 
> While probably not being the ultimate solution for you here, but
> you can use qemu to emulate ZNS drives [1].
> 
> The TL;DR is:
> 
> qemu-system-x86_64 -device nvme,id=nvme0,serial=01234        \
> 	-drive file=${znsimg},id=nvmezns0,format=raw,if=none \
> 	-device nvme-ns,drive=nvmezns0,bus=nvme0,nsid=1,zoned=true
> 
> [1] https://zonedstorage.io/docs/getting-started/zbd-emulation#nvme-zoned-namespace-device-emulation-with-qemu
> 

Is there a libvirt xml binding for it?
Still prefer libvirt xml based emulation, which would benefit a lot for 
all my daily runs.

Thanks,
Qu

