Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C22044CE87
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 01:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhKKBBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 20:01:11 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:37899 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230430AbhKKBBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 20:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1636592301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CqwOqQPGtqHt+ldTgEnfra0ZP3w/7WbqqCVST4lDqzk=;
        b=mSP9hvuZuu4cAaq1249JDzHdzEkU7LeGNQKJoUwRGXeXKcyoXk85LvaRas3cOUGpEpYhUA
        zTLrYA9o7aPe2favfR8xP+wmePPO90Xa4wr41iMi6uwyQ+cqBOr3Z30o6/Vccc9xW462PU
        4mW4vETKKNyP83yVjgYWo0rAJuDhKOA=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-IXRwHaESPaSwmSbo9mx-Iw-1; Thu, 11 Nov 2021 01:58:20 +0100
X-MC-Unique: IXRwHaESPaSwmSbo9mx-Iw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URd1cVPIMz+qZ5RZbtgXQifw3lxmKxDpYCwzbQjHxci9w589omr6vTyCCqZWIUEEd4RnNStGu3il1MOL1epOj7ftN7t2CAW+tUpyTSH2D4PQgcl/WKqV8UhYSgzlalCCwhfImuq8JOja/exbJ6b7rNa2Cb3UnxRXLhi0O60Topy2wnNPzuDmXQxKD356el40n+hNgucNYs2L8pA2ox2vM8AP2CL9h+BgclL/hyRr7hqwkvfeKhxaTPxW1bBdIvMAazJ9Iv4JqX93Lsm5PAGprExStJGktRx0xzJggN9LfGorfTAaP/UV5znRQoeCe4y7ua/aM/gRRm8uetBt4QgSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqwOqQPGtqHt+ldTgEnfra0ZP3w/7WbqqCVST4lDqzk=;
 b=eQqvGJvC+13NxMg3cMQR19f/VVEYoL2nh5s7VrxkoZ+w9JRJtTsirBtdNQ7Ryjz1JSybICyRFtTMyLAFP4YunEsEYydyf7w4L+qzqIEJh69EjchZOuXMvEPjUoQ2KN+SQO72koyurSsYde9HZLCoRCcQekXmGUF15JrsgwlelzSgWJJ+HWi2beP1R7VHqdX8QQYGPldR88Hm9rmbgJZXoH9r9W2amRjc/gkPyWB6AtKl/LFd4muW7/py8vPP2kx9nYG4QCpimpy36YzGLqC/ZkGdh4MjB3vdIyCl3fz30evv77U0X8k05n9sX52NCPeuHAgJQmfpZQU8bYwROSY0WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (10.167.23.78) by
 DU2PR04MB8965.eurprd04.prod.outlook.com (10.141.108.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16; Thu, 11 Nov 2021 00:58:19 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286%9]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 00:58:19 +0000
Message-ID: <725543aa-029d-c22e-0ac8-bc77637c0474@suse.com>
Date:   Thu, 11 Nov 2021 08:58:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     "S." <sb56637@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org
References: <a979e8db-f86a-dd3a-6f0a-588b14bbd97f@gmail.com>
 <37379516-cc7c-b045-ad2e-15c669a60921@gmail.com>
 <179e61f7-82c9-0a5f-1a05-7c0019b4f126@gmail.com>
 <76156d73-9d4c-a473-4dd2-105a905d3d1e@gmx.com>
 <c94ecfa2-752b-9952-9483-ae3dd04f6c02@gmail.com>
 <1f4db1f5-2f37-0074-cbe8-e78ba7836587@gmx.com>
 <4f7be37a-502c-6ee1-2519-29b84810999c@gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: Upgraded from Buster to Bullseye, unmountable Btrfs filesystem
In-Reply-To: <4f7be37a-502c-6ee1-2519-29b84810999c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:a03:333::7) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0092.namprd03.prod.outlook.com (2603:10b6:a03:333::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 11 Nov 2021 00:58:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8195a83-23f4-4fe5-87a0-08d9a4ae59b8
X-MS-TrafficTypeDiagnostic: DU2PR04MB8965:
X-Microsoft-Antispam-PRVS: <DU2PR04MB8965BED9FF4D2332A959E6BFD6949@DU2PR04MB8965.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fHStIQAMWaFfLVQZqL/E2uGaZUXQt4cox/JXA8E4azcWs5HF2HtYD0+aW8W5kVItT+7UXLp8G0C3EVRS2Y66r0Shc4jp3pjBn8ru2MgeYZLvoFYeRrOxq6lvk8lbOcqidCSSfrRdgOiXqJHLvm3R7oQD3CwSw7tjk1HoR43csmc97glYHFXpW1UGydH43OVaUNMVNfYxM6k0GL07SJt+KX0TuQRf9uwJQPuXDkZJsN051/Cj9u8YmsRwQ1jY4fAjUiiAWEbm/pTUS+ZrxwJ1xXJndEHKLkWbg8yugrQ63+8GU6FBG082pAUz+2areucDMV/eqa0sSCiVpxTaN5PjQQINb3Dj6+ly2959GTeN8IrlKAEgjPFUc/3nf1x0llcNUdi1v9nE2GXmvP0CSJu/GuLpvDLulJaS59EKwHuT7CPGBPmmapSWmQ1mpDk20ObaW1Y1RXob7DNaeiWDg3uhTN1eXxGN8nkLCBosE1kw+pBQMczqsEbP+STkN/Q9tyx8kH9s1Y4QzmPQHXEggKQkND3X1yms2h6e+SzsKxy8Su+zzh15K2DmmTFULB7+B6+afpAaLbenPzrfdSkOk9kxCICUajvukehBmulgrk+0OkAnLLYC57GpJAjrP5o9LzRqEwefoWU3iB2lkDyFyXpQuQefYsdRH3CRRnRoju7lRWk6o9yvtvrYDpQJKhoy6jfsCpn8HgTmrYJnr4q93cmGuuuZzxhXmbqI1RNb1TuB2ge54C1d+T1gbeMUP0NFEXJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(36756003)(83380400001)(31696002)(2616005)(956004)(86362001)(66946007)(38100700002)(66556008)(66476007)(8676002)(508600001)(26005)(8936002)(53546011)(5660300002)(6666004)(2906002)(6706004)(6486002)(110136005)(16576012)(186003)(316002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjdWbmk2RS93ek1KTkMzaW52YXdvS3BaMVc2c0pzWFptREhUSmJkbjJsM2RY?=
 =?utf-8?B?Wk82MkNuY2VsZ3g3WmlKdUpucjVwU2ZjRTFlaWV3eUpsdW8vR3RMYUt2K0Y3?=
 =?utf-8?B?NmViSlZNVW1IRFd1TXpMeGYyYnpoRSt4N0wrVVFtVTRYSWVzR2UyT2o5NVp4?=
 =?utf-8?B?RjFKV25mV2lMYU9BN1ZSTTc4aWVYVVZaTXJ5V2ozS05kc2xEUE1sdyt6bXl1?=
 =?utf-8?B?VU4xMkRoQ2xXY2dPRzE3OHdEeEJNTHptdXJ3WFBWaGhXTy9Oa0RKNTNBUXJX?=
 =?utf-8?B?MXpJb0NIL3pQcEVtOWc2SExqZSs1YW16TU03cXNhVHhNTEgxaHlscTZRSDMw?=
 =?utf-8?B?elhzWFNDaGFuRDFsVWgrYTNEK29ZTmpPTngzcEdRZGZ0SU40STN5QXpHUUNR?=
 =?utf-8?B?dzhQemlKeFJudFhEbG5Rek5GMktxYkRpazRSQ0psd1JSUkh0UC9kQysveGlp?=
 =?utf-8?B?Q3BsdHdJSEwxSk5mWGdDQW02ZGQ4aHpMZE9IenJEdUIwUXc0d0hzZjRNdTla?=
 =?utf-8?B?QVRaTXA2K2lXcFVjRklsNis2aEs5dGRQTUFuL255VWFFMDFoOVg3eVJDSk9Y?=
 =?utf-8?B?MldkK2p5ZENRUmZxU05PbytaT2c0R01wWGdIbC84ZWZhcksxOTB6ajJPb29Q?=
 =?utf-8?B?aEoyeEpPU0lYeDBxaUJyQnloTHZ6VDhoMHJ4aUlHWTB1YUl4UjdWR1ZjYTUw?=
 =?utf-8?B?VStYWFlvUFpCOVNPWnMycko1bEhoc0RqcW42NXpIdmJaLy9DMmFEL01QWndt?=
 =?utf-8?B?WUxxSmQzcy8xZ3RLWGtmNlh5VXpyT1l1K1FnczJidHJQbDBuVVMwWWNHT0s1?=
 =?utf-8?B?Z0dvY2JsVVpwcFZBd283SFVUTjJ2VHdoYjd6dk1pZDUxdnNWNFFNYnlkUWlK?=
 =?utf-8?B?ZUlUUGpVUkt4ZitKNW5IRlpTTitrOGVBUUY5KzU5RUhxUXVMSnIvbEpXNFhr?=
 =?utf-8?B?TW9LTGVkVmR1d0ZLRHVJNlc2OEo0MHE3RUliT2NkakIyM3Jvb2dHVEQ4cUJy?=
 =?utf-8?B?U2l5d0xTNWlBSG12Zk1TSHBrdG1OcUd5bDZGcmxSSzBLeSsrTjFoelBXT1Bl?=
 =?utf-8?B?SUYyNzN5VmVjYzlvejZ2WFVnNU0zV1lIeU1EaHBtamE5dEo1OGVIV0NxbEFN?=
 =?utf-8?B?MjhUd09JVVRCNVhpNUNTelkvVCs2M0NDeGZPQ0Zoc2UxTjZnYithUUdQL3lJ?=
 =?utf-8?B?YWQyWjNuZTlZeGtoTWxodG53azR1aWtPd1NEVm0xUkJTY20xZzdSTnRkQWRK?=
 =?utf-8?B?QndvcWNQN2ZNbzQzZUZBY2FrYlpyQVNPdTNVV2R3Q1JxZWpCTGpNNU1sMEdU?=
 =?utf-8?B?b2F4V1J4UDlUNXJOUFhBMkFYb25NYTBnc3BvQ0xJUVpYazNHcXpYaGc2eE9G?=
 =?utf-8?B?eTBUNHR6SjhTWk5oY25teUdpUkRHalZKaFA1a0Y2ZkRodlRyZytxSCtyUTVS?=
 =?utf-8?B?UU5NQUVBUm5yZ1pQQzVWQ3BEcXp1M3JGeThJbFM0WUJGcHhvMndKRG8vbUd1?=
 =?utf-8?B?d1l1a1diTk9CYlB1YUlCT2UxWkkyQWd4RXdVSExSMXk3NTVzTk00cXJtR3U3?=
 =?utf-8?B?TUhubXRPNldldjR6NnllbDVuYUNQMFRvd2xWa0hoa2RuV3JBYWZBZW1QQXlt?=
 =?utf-8?B?dld2NU9MOWo5djIzS0IrK2wzNi9IWHZTN1JNTDZMNTg0Ky9MSytJTTJxSk1z?=
 =?utf-8?B?dGViV1hoeSt3ekdENkViOG9DTVdabDVFYjhsNnovQlMwbXY5c3BOcE5pUWw0?=
 =?utf-8?B?ZzJyaHc2ZGZsNXFqR2tIOU9WbXdNRVN6WWZQTkRFNHU3YnNJeTlJOGlld3FM?=
 =?utf-8?B?aVh1bFh4ZEQ2ZGRMV3VUdHRTcFd0aDFSRVppQmxURzNrTEtFMGlHbmJJa2pD?=
 =?utf-8?B?aHZBSzJMaUFITnNLZ3A1NmRkQzhxU0N6enVCcW9acTBGU082a2xMb25MTXlB?=
 =?utf-8?B?NFFhTXk2ZTRyMGkwUVJPMW1VZXVZQXI5azZjbmZaZXJJRlMrSXhwMmw0UjVN?=
 =?utf-8?B?Z01jS2h6b0FxVGFIcjBqelp5blRLZFVhLzZPY2NLa1Iwd3FvdUdaTHIwMHVG?=
 =?utf-8?B?YnlmZVowRnFzejdvTi9kSVdRYUVkYlhZNlhXTnlYa0ZNa0loTnA4N3RWL3Vl?=
 =?utf-8?Q?Y9dE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8195a83-23f4-4fe5-87a0-08d9a4ae59b8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 00:58:18.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfg3xO0bSQ0TCPN/fEbsPPI3ANzHMCjrX0Rb4C3kjd4I2zEue0ncJBGzkdcc1km+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/11 08:18, S. wrote:
> On 11/10/21 18:46, Qu Wenruo wrote:
>> So it means, we still need btrfs-progs to repair it.
>>
>> Thus I believe you still need to prepare a build environment for it.
>>
>> For the worst case, I could try to build a static btrfs-progs for you if
>> you could provide the "uname -a" output.
> 
> Thanks for your time and patience. If you have time for a static build 
> of btrfs-progs I would be very grateful.
> # uname -a
> Linux OpenMediaVault 5.10.0-9-marvell #1 Debian 5.10.70-1 (2021-09-30) 
> armv5tel GNU/Linux
> 

Oh, I was expecting something like aarch64...

I don't have the toolchain for armv5 at hand.

But there is still another way.

Don't mount the fs with older kernel yet, make sure the newer kernel 
still fails with the same dmesg output, especially the same line like:

[  115.428780] BTRFS error (device sda3): block=170459136 read time tree 
block corruption detected

Then use the following command to grab the physical position of the 
corrupted tree block:

# btrfs-map-logical -l 170459136 /dev/sda3

It would show something like:

mirror 1 logical 170459136 physical 178847744 device /dev/test/test
mirror 2 logical 170459136 physical 447283200 device /dev/test/test

Then use the physical values to read the tree block out:

# dd if=/dev/sda3 of=/tmp/mirror1 bs=1 count=16k skip=178847744
# dd if=/dev/sda3 of=/tmp/mirror2 bs=1 count=16k skip=447283200

Then send the file mirror1 and mirror2 to me, so I can modify the tree 
block manually.

NOTE: 178847744 and 447283200 should be from your btrfs-map-logical 
output, the numbers I used are just some examples.
And 16k should be your node size, which you can verify by "btrfs ins 
dump-super /dev/sda3 | grep nodesize".
16K should have been the default value for a long long time.

Thanks,
Qu

