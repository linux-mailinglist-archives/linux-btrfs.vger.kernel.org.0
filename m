Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2BE74EB55
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jul 2023 11:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGKJ7w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jul 2023 05:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjGKJ7W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jul 2023 05:59:22 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94751BC7
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 02:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQe/g8gvwIHFYbWjKDukAn5VCCtGiKYKyOKizBSs5On+rSSNU8MWzuEFVq48fr3CpDLu08JrO7+ASoGy386ZjV2pVKghHzeipTDSsDAcZvapgLCdTxyhk+fV4f7CF/keO4LIs/MejUtiLpx1Yg1GGdyAJZEVm5DOSZyjNAqNs2zOGcpddF29hsUhFJot+yub4I3PXG1m86pHpXdnvhy0wJALuRs89aLl2yxMlUFJ10HDptmJkNHcGMbXoqwtgwmOACn8JaVXj/HFFw2Uj6id2BbOb1cDHRdYyMxUAydZgdSyaTOP2gGQAFlpJOp0haZoaho3o5xhLLrFPKgS+9IYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwcePNIpyi4QcLLl2ndB5j40G9negYMY2jLeSTQI8SQ=;
 b=E8M0uSQdOVjy5lq+K+sodRRCmGD4fXwjvJuuOpDv3V7+F/wnceBWeZP0wMOkkQhTCB1rl7bRX84pyi2H7ccubscUrGr1WJ8+D6ylqqOfiKs3HJPRWC4xg80p67ZbNpGLpSLP0/9tikSNmeG30s4M9d3SyUQ7rZFAOuBPN/VJDdz4x+7rPGaf5tpp/3a7yBi/ANK/3jl+toHnl1/n+tek2ZRD8Llrm0ZBEXAeZ1WSnyvHZwoedCyG6DJPQikDdxJaOrZt83G3SsahQV0hhjEp1K17/JX6kbrWP5nY3jWRUM+v+jknjvZQjLQSpOPJlNB59qPsbaj8X1oIatT0a8RfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwcePNIpyi4QcLLl2ndB5j40G9negYMY2jLeSTQI8SQ=;
 b=XJ37ZIeZML+As1YNi1XfYnZX8Uq8zjxz1MbvgsJ6s0dZ1ksf1yUqPtvSFthRM9gJBdXPvpCzBy1Ea0wNcyP6g6sLoVwn8bFXa1Bf94G0AZgbpGFZ3js9LGEVZU7prrtXuzB9d7bYwKFrv56aEhwCM+OVDgy5ZW13e8TRcU9aPjX00UTrV/f4OKznOrGAIBqiH5kbNtVKm+mxnqX+5A23kF5pK00CyYmj7DKJNyoGXOoyIMZHHAcAf2GUIl7lNZ6SiQX/YK5DSWd58LauKGbnH62j+FZr0jbaMsL0Lo6trxMEZyZHOafj4aAr/XIs+azvx1EqOty4aJqvpB7RSrt4aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB7981.eurprd04.prod.outlook.com (2603:10a6:102:c0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 09:58:03 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 09:58:03 +0000
Content-Type: multipart/mixed; boundary="------------q6b70rCfldGBRbM9AMHznpLY"
Message-ID: <3ff556b9-2450-e5d3-2ad3-34a52e723f27@suse.com>
Date:   Tue, 11 Jul 2023 17:57:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
Content-Language: en-US
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, Tim Cuthbertson <ratcheer@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <2890794.e9J7NaK4W3@lichtvoll.de>
 <22b2a8da-5225-7703-e8c6-75c25baa986d@gmx.com>
 <1956200.usQuhbGJ8B@lichtvoll.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <1956200.usQuhbGJ8B@lichtvoll.de>
X-ClientProxiedBy: TY2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:404:56::29) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 47bda42b-af8e-4462-5172-08db81f55160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dDqOfFfTKplYkEup51trkLAfMx5QY5jSStO9v+XxoP5/hvuzwXu6EMKSg+vTWYHhLzeBOjcgHu9kRenraHfazXe205qzf9saPGm2HxGK4PfTNSPuXj1AsNYLduOxYoxAngylr7JPrTx3waIVrPzhQ91Z7PbBYLKh69dRFFzJPvRcjSPgDF+IZau44KUjIPGG4G6e/y+aI1utR+djq8YRT1eycVHuJmWGRfwXA4r/wZB9Wy3Ab5NCVW/WGqxjk5iaugN5zx9I7DC0rMX0ZpMk1G8UOZkRb0vW1TTX3F6hr3mtHYt7QNGdldVGSUKPrq3leNeGPv5swo4vuo+X4I85Rb8Vx0G3zBYIxbrZhYVtTI1ask5Tp+fj5nfIHTfjdkUgTfRt/opPnQypKJwdUIxQUDatL5lfVJYkxvca5ozkL+Gh37ElERXvZ3LrKhXn2Vg8c/09l9H/c/tnSB93dCQFa4pb6gqHHfvEMOMTnjp4Y13ikDfPX4H3iDuk5IZQsYtNH4f/WISGfUpvW8cps4JS88Prj5GlnINQtEkujPj275lMcfOHRlmT0bCSgFJ5icHzEbN5Iq6e50BmzDb7MJe/H4n5kS4JdREAb/DNCyrumUElpLFduEh6Vr3/yM0673jpID1rSd9RbUUxUwGoy3Bi6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(186003)(6506007)(2616005)(966005)(6512007)(53546011)(478600001)(83380400001)(41300700001)(2906002)(66556008)(5660300002)(316002)(235185007)(8936002)(8676002)(66946007)(66476007)(6486002)(33964004)(6666004)(110136005)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3dTK1pQVFNlR1V5dE1sWWJOQ2JxQndzdlZDbjlJUEdKWHNwWUNrMXRRYTFS?=
 =?utf-8?B?cHJXcE96VkNQeWNPejU1NGtvWGYzWmtHREoxQUtGVEhJTE5ZR0Nld0kvdWVB?=
 =?utf-8?B?UU5MSlNic1FiamZaYzhQRmhaWlB0clpXaXFVeC9LamVFVG03QmZwK05VNFEr?=
 =?utf-8?B?NUMvVkcyM2JZYnpxdUJoaStBZ1ZydjEvRkZrQlU1azhiQ2oxN1p1QlRPMmJq?=
 =?utf-8?B?eVVSMHlSb1NKVWF6WFNaNkw0d2cycHJjVHVCcDdZc0ljMmZJWGRvMjR4YTZT?=
 =?utf-8?B?ZmdsVFJ6MTVEQzVQcndHS1FBOXJxRGFHOHNYL1pCd25wbTFIWW02MDFxOVF6?=
 =?utf-8?B?TzZ4ejBHU2wvV2pKQUVLZXhkZ0JORmw5UTNFOU5kYzhkYUVBRlJtQmFSaXhn?=
 =?utf-8?B?RzFSTDZ4cENRTm5tV2tidUJaSWgrdURlRm05bzRteDloNmVmdXpiOUdmaWd5?=
 =?utf-8?B?RXdoZXM3a0R3ZlBqQTQ2ZFNETWNISjYvaUhYRmVCQnFVR1M2S1RhM0Y4byti?=
 =?utf-8?B?M1RRL2RMb2FVQi9pZENZMWlxa3UwZHFEVkVCM0RXR2pXZGxEcFM0TXZ3QVpK?=
 =?utf-8?B?a2ZQQ3dSL2F6Tmh6QlFYWGo0MDlBNjFQWVRqRGV2WjUvdVovazQ1dlZDNjRy?=
 =?utf-8?B?Z0E4R0MvM05NMG5haFkvQmlQWFRpWmNPQXBZL3Jqa1NQKytidHB6VVNyZXpT?=
 =?utf-8?B?WGVCOGE5ZkNjUXo4NkJCUTFRRTlncFN6bTJoa2JNZXgwR2lhYlF2ZHdqWFNQ?=
 =?utf-8?B?ZUs0OEpDSEk2T01FNTVSMHllWmFadnF3VUx1eVE5a1NRWGRHamdlVm4xVjcr?=
 =?utf-8?B?SFcwK1FtWXpWOS9KQzB1NTZUbVFOQUlHLzJuajZyUXVNaXZKZzE5Snc0RmdG?=
 =?utf-8?B?bDlvVFAxd2VjTFg2ZGM2bkpVT2locCswTGNmYitlMDNGTjRTczd0RDFqR0ds?=
 =?utf-8?B?MHpmejlSTjhpZEFTR2FELzBnbkZucjloeVg0S1Q2cHEvRXJRUkRlSzNZVFJY?=
 =?utf-8?B?K2d4OTdZY1JjZ3B1Z1ZLWnNqUFdkNUtLUG0xcEl0T1NPeFo4d0JLN3NYbmRl?=
 =?utf-8?B?a0dhdDRWa1NEaExWMmU3MDhjODRyTytUcGN0NmFZdW5Sb0E4elhjVllXSFJ2?=
 =?utf-8?B?SHB0TmRVbXByS1FncWovZnRhZDBkTXFsSTUxN3gvUlNYUWR6UkF5QUdSbmwz?=
 =?utf-8?B?ZTZMUmlleGp2VTNzcnQyWHM2NHNKNEsrTE5jdGZlcWpKVzcyTkEvYXJ0Z1hn?=
 =?utf-8?B?Z1VkQ3FwejZhRXQzVHl0cnNsT2JZVVNOa0VDL3BsTjJwK0d3eWFzeldIc0x3?=
 =?utf-8?B?VSttU0lXL0V6OEFLaHJjRXVRZWduQjB3d0tOazFndDdhOWp6NXRPc0xhQWw5?=
 =?utf-8?B?RGd2TUp5UUpMNHhIOCtBV2hzeUo0cDE5TW9ja0I0eFJkcGRjdlZPRFdUUEZE?=
 =?utf-8?B?QTlYZHdwS0xJa1FYWVNWQzNlRGF4MVN2ZWJ2ZndYNngvWlJYL0dzczgycGJi?=
 =?utf-8?B?UHE1OVZBeGF0bkt2SWR1UHd2MjBoc1RRV1JYVHRjOHB4RXF5ZHI5T2tyMjZK?=
 =?utf-8?B?OFR6V2dDcVV5dnlaMi9zMjBqVDdJL0dUcnlqUVNsVS9DdnFwL2dDV3FEY1pG?=
 =?utf-8?B?TUtlWUMwVWNBcTRvZGhYUEdtUU9rWWt3OFZpemNtNTdNT1RJZG10UHBvTDNt?=
 =?utf-8?B?TGl4V29VUTIvb25EaG9NbVRpS2NoNE1jK3ZuU1lLN0FTWkFDUTZSRW1RREZq?=
 =?utf-8?B?ZnRLRXdTZmp6aHlWOGZUTlZ4b2kzaGZKZ0loWTJGRUZQRVhlUzdwb3hsalM4?=
 =?utf-8?B?RnVjR2d4OTByWkJRYTByS2hsdlJpSWhFakhVNEY2ODQ3VkJ0aHl1anplNlZ4?=
 =?utf-8?B?N2JTMTNOc2ExU2I3ODBvUWNuTVVDa202WDhueWI4MlQ1SXpoQVRNUWxrSnhi?=
 =?utf-8?B?dEFycnZ1R0VQZjZJZVByc25BN1ZhV3FIY0hvSTBoNEhaQlFFWEdYUVNMQTdy?=
 =?utf-8?B?U2VWcnYzV2NRZVQwQ2NySHVZOE9jWFJzNFhpY1EzaG1MRG9Bd2hxVmVvMnJZ?=
 =?utf-8?B?LzEwN20vTHFldCtNcDNOWktXV1lEZ0Vob2hOZXRPNWpjWWtxVHdHdEwrOGZL?=
 =?utf-8?Q?4HiATC4vqDT/znOROppnWUN80?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47bda42b-af8e-4462-5172-08db81f55160
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 09:58:03.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zt1A7xHlPwOb+vQ8LJqBnnL62MttxkBBG2mvTiVlh9KVghiBoAE8sbtLNTBRn6Sp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7981
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--------------q6b70rCfldGBRbM9AMHznpLY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2023/7/11 17:25, Martin Steigerwald wrote:
> Qu Wenruo - 11.07.23, 10:59:55 CEST:
>> On 2023/7/11 13:52, Martin Steigerwald wrote:
>>> Martin Steigerwald - 11.07.23, 07:49:43 CEST:
>>>> I see about 180000 reads in 10 seconds in atop. I have seen latency
>>>> values from 55 to 85 µs which is highly unusual for NVME SSD
>>>> ("avio"
>>>> in atop¹).
>>>
>>> Well I did not compare to a base line during scrub with 6.3. So not
>>> actually sure about the unusual bit. But at least during daily
>>> activity I do not see those values.
>>>
>>> Anyway, I am willing to test a patch.
>>
>> Mind to try the following branch?
>>
>> https://github.com/adam900710/linux/tree/scrub_multi_thread
>>
>> Or you can grab the commit on top and backport to any kernel >= 6.4.
> 
> Cherry picking the commit on top of v6.4.3 lead to a merge conflict.
> Since this is a production machine and I am no kernel developer with
> insight to the inner workings of BTRFS, I'd prefer a patch that applies
> cleanly on top of v6.4.3. I'd rather not try out a tree, unless I know
> its a stable kernel version or at least rc3/4 or later. Again this is a
> production machine.

Well, I have only tested that patch on that development branch, thus I 
can not ensure the result of the backport.

But still, here you go the backported patch.

I'd recommend to test the functionality of scrub on some less important 
machine first then on your production latptop though.

Thanks,
Qu
> 
> You know, I prefer to keep my data :)
> 
>> Thanks,
>> Qu
>>
>>>> [1] according to man page atop(1) from atop 2.9:
>>>>
>>>> the average number of milliseconds needed by a request ('avio') for
>>>> seek, latency and data transfer
> 
> 
--------------q6b70rCfldGBRbM9AMHznpLY
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-speedup-scrub-csum-verification.patch"
Content-Disposition: attachment;
 filename="0001-btrfs-speedup-scrub-csum-verification.patch"
Content-Transfer-Encoding: base64

RnJvbSA3YjVkOWY0YzU5Y2IwNzFmOTJmZmE1YWYwNjgyN2M1OGVhZjQwMzBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8N2I1ZDlmNGM1OWNiMDcxZjkyZmZhNWFmMDY4Mjdj
NThlYWY0MDMwZS4xNjg5MDY5MzcxLmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1IFdlbnJ1byA8
d3F1QHN1c2UuY29tPgpEYXRlOiBXZWQsIDUgSnVsIDIwMjMgMTQ6MDI6MDEgKzA4MDAKU3ViamVj
dDogW1BBVENIXSBidHJmczogc3BlZWR1cCBzY3J1YiBjc3VtIHZlcmlmaWNhdGlvbgoKW1JFR1JF
U1NJT05dClRoZXJlIGlzIGEgcmVwb3J0IGFib3V0IHNjcnViIGlzIG11Y2ggc2xvd2VyIG9uIHY2
LjQga2VybmVsIG9uIGZhc3QgTlZNRQpkZXZpY2VzLgoKVGhlIHN5c3RlbSBoYXMgYSBOVk1FIGRl
dmljZSB3aGljaCBjYW4gcmVhY2ggb3ZlciAzR0J5dGVzL3MsIGJ1dCBzY3J1YgpzcGVlZCBpcyBi
ZWxvdyAxR0J5dGVzL3MuCgpbQ0FVU0VdClNpbmNlIGNvbW1pdCBlMDJlZTg5YmFhNjYgKCJidHJm
czogc2NydWI6IHN3aXRjaCBzY3J1Yl9zaW1wbGVfbWlycm9yKCkgdG8Kc2NydWJfc3RyaXBlIGlu
ZnJhc3RydWN0dXJlIikgc2NydWIgZ29lcyBhIGNvbXBsZXRlbHkgbmV3CmltcGxlbWVudGF0aW9u
LgoKVGhlcmUgaXMgYSBiZWhhdmlvciBjaGFuZ2UsIHdoZXJlIHByZXZpb3VzbHkgc2NydWIgaXMg
ZG9pbmcgY3N1bQp2ZXJpZmljYXRpb24gaW4gb25lLXRocmVhZC1wZXItYmxvY2sgd2F5LCBidXQg
dGhlIG5ldyBjb2RlIGdvZXMKb25lLXRocmVhZC1wZXItc3RyaXBlIHdheS4KClRoaXMgbWVhbnMg
Zm9yIHRoZSB3b3JzdCBjYXNlLCBuZXcgY29kZSB3b3VsZCBvbmx5IGhhdmUgb25lIHRocmVhZAp2
ZXJpZnlpbmcgYSB3aG9sZSA2NEsgc3RyaXBlIGZpbGxlZCB3aXRoIGRhdGEuCgpXaGlsZSB0aGUg
b2xkIGNvZGUgaXMgZG9pbmcgMTYgdGhyZWFkcyB0byBoYW5kbGUgdGhlIHNhbWUgc3RyaXBlLgoK
Q29uc2lkZXJpbmcgdGhlIHJlcG9ydGVyJ3MgQ1BVIGNhbiBvbmx5IGRvIENSQzMyQyBhdCBhcm91
bmQgMkdCeXRlcy9zLAp3aGlsZSB0aGUgTlZNRSBkcml2ZSBjYW4gZG8gM0dCeXRlcy9zLCB0aGUg
ZGlmZmVyZW5jZSBjYW4gYmUgYmlnOgoKCTEgdGhyZWFkOgkxIC8gKCAxIC8gMyArIDEgLyAyKSAg
ICAgPSAxLjIgR2J5dGVzL3MKCTggdGhyZWFkczogCTEgLyAoIDEgLyAzICsgMSAvIDggLyAyKSA9
IDIuNSBHYnl0ZXMvcwoKW0ZJWF0KVG8gZml4IHRoZSBwZXJmb3JtYW5jZSByZWdyZXNzaW9uLCB0
aGlzIHBhdGNoIHdvdWxkIGludHJvZHVjZQptdWx0aS10aHJlYWQgY3N1bSB2ZXJpZmljYXRpb24g
Ynk6CgotIEludHJvZHVjZSBhIG5ldyB3b3JrcXVldWUgZm9yIHNjcnViIGNzdW0gdmVyaWZpY2F0
aW9uCiAgVGhlIG5ldyB3b3JrcXVldWUgaXMgbmVlZGVkIGFzIHdlIGNhbiBub3QgcXVldWUgdGhl
IHNhbWUgY3N1bSB3b3JrCiAgaW50byB0aGUgbWFpbiBzY3J1YiB3b3JrZXIsIHdoZXJlIHdlIGFy
ZSB3YWl0aW5nIGZvciB0aGUgY3N1bSB3b3JrCiAgdG8gZmluaXNoLgogIE9yIHRoaXMgY2FuIGxl
YWQgdG8gZGVhZCBsb2NrIGlmIHRoZXJlIGlzIG5vIG1vcmUgd29ya2VyIGFsbG9jYXRlZC4KCi0g
QWRkIGV4dHJhIG1lbWJlcnMgdG8gc2NydWJfc2VjdG9yX3ZlcmlmaWNhdGlvbgogIFRoaXMgYWxs
b3dzIGEgd29yayB0byBiZSBxdWV1ZWQgZm9yIHRoZSBzcGVjaWZpYyBzZWN0b3IuCiAgQWx0aG91
Z2ggdGhpcyBtZWFucyB3ZSB3aWxsIGhhdmUgMjAgYnl0ZXMgb3ZlcmhlYWQgcGVyIHNlY3Rvci4K
Ci0gUXVldWUgc2VjdG9yIHZlcmlmaWNhdGlvbiB3b3JrIGludG8gc2NydWJfY3N1bV93b3JrZXIK
ICBUaGlzIGFsbG93cyBtdWx0aXBsZSB0aHJlYWRzIHRvIGhhbmRsZSB0aGUgY3N1bSB2ZXJpZmlj
YXRpb24gd29ya2xvYWQuCgotIERvIG5vdCByZXNldCBzdHJpcGUtPnNlY3RvcnMgZHVyaW5nIHNj
cnViX2ZpbmRfZmlsbF9maXJzdF9zdHJpcGUoKQogIFNpbmNlIHNlY3RvcnMgbm93IGNvbnRhaW4g
ZXh0cmEgaW5mbywgd2Ugc2hvdWxkIG5vdCB0b3VjaCB0aG9zZQogIG1lbWJlcnMuCgpSZXBvcnRl
ZC1ieTogQmVybmQgTGVudGVzIDxiZXJuZC5sZW50ZXNAaGVsbWhvbHR6LW11ZW5jaGVuLmRlPgpM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1idHJmcy9DQUFLemY3PXlTOXZuZjV6
TmlkMUN5dk4xOXd5QWdQejVvOXNKUDB2QnFONkxSZXFYVmdAbWFpbC5nbWFpbC5jb20vCkZpeGVz
OiBlMDJlZTg5YmFhNjYgKCJidHJmczogc2NydWI6IHN3aXRjaCBzY3J1Yl9zaW1wbGVfbWlycm9y
KCkgdG8gc2NydWJfc3RyaXBlIGluZnJhc3RydWN0dXJlIikKU2lnbmVkLW9mZi1ieTogUXUgV2Vu
cnVvIDx3cXVAc3VzZS5jb20+Ci0tLQogZnMvYnRyZnMvc2NydWIuYyB8IDQ5ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQx
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvc2Ny
dWIuYyBiL2ZzL2J0cmZzL3NjcnViLmMKaW5kZXggMTZjMjI4MzQ0Y2JiLi4zNTc3YjhkOTI3YjIg
MTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL3NjcnViLmMKKysrIGIvZnMvYnRyZnMvc2NydWIuYwpAQCAt
NzIsNiArNzIsMTEgQEAgc3RydWN0IHNjcnViX3NlY3Rvcl92ZXJpZmljYXRpb24gewogCQkgKi8K
IAkJdTY0IGdlbmVyYXRpb247CiAJfTsKKworCS8qIEZvciBtdWx0aS10aHJlYWQgdmVyaWZpY2F0
aW9uLiAqLworCXN0cnVjdCBzY3J1Yl9zdHJpcGUgKnN0cmlwZTsKKwlzdHJ1Y3Qgd29ya19zdHJ1
Y3Qgd29yazsKKwl1bnNpZ25lZCBpbnQgc2VjdG9yX25yOwogfTsKIAogZW51bSBzY3J1Yl9zdHJp
cGVfZmxhZ3MgewpAQCAtMjU5LDYgKzI2NCwxMiBAQCBzdGF0aWMgaW50IGluaXRfc2NydWJfc3Ry
aXBlKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLAogCQkJCSAgR0ZQX0tFUk5FTCk7CiAJ
aWYgKCFzdHJpcGUtPnNlY3RvcnMpCiAJCWdvdG8gZXJyb3I7CisJZm9yIChpbnQgaSA9IDA7IGkg
PCBzdHJpcGUtPm5yX3NlY3RvcnM7IGkrKykgeworCQlzdHJ1Y3Qgc2NydWJfc2VjdG9yX3Zlcmlm
aWNhdGlvbiAqc2VjdG9yID0gJnN0cmlwZS0+c2VjdG9yc1tpXTsKKworCQlzZWN0b3ItPnN0cmlw
ZSA9IHN0cmlwZTsKKwkJc2VjdG9yLT5zZWN0b3JfbnIgPSBpOworCX0KIAogCXN0cmlwZS0+Y3N1
bXMgPSBrY2FsbG9jKEJUUkZTX1NUUklQRV9MRU4gPj4gZnNfaW5mby0+c2VjdG9yc2l6ZV9iaXRz
LAogCQkJCWZzX2luZm8tPmNzdW1fc2l6ZSwgR0ZQX0tFUk5FTCk7CkBAIC03MzAsMTEgKzc0MSwx
MSBAQCBzdGF0aWMgdm9pZCBzY3J1Yl92ZXJpZnlfb25lX3NlY3RvcihzdHJ1Y3Qgc2NydWJfc3Ry
aXBlICpzdHJpcGUsIGludCBzZWN0b3JfbnIpCiAKIAkvKiBTZWN0b3Igbm90IHV0aWxpemVkLCBz
a2lwIGl0LiAqLwogCWlmICghdGVzdF9iaXQoc2VjdG9yX25yLCAmc3RyaXBlLT5leHRlbnRfc2Vj
dG9yX2JpdG1hcCkpCi0JCXJldHVybjsKKwkJZ290byBvdXQ7CiAKIAkvKiBJTyBlcnJvciwgbm8g
bmVlZCB0byBjaGVjay4gKi8KIAlpZiAodGVzdF9iaXQoc2VjdG9yX25yLCAmc3RyaXBlLT5pb19l
cnJvcl9iaXRtYXApKQotCQlyZXR1cm47CisJCWdvdG8gb3V0OwogCiAJLyogTWV0YWRhdGEsIHZl
cmlmeSB0aGUgZnVsbCB0cmVlIGJsb2NrLiAqLwogCWlmIChzZWN0b3ItPmlzX21ldGFkYXRhKSB7
CkBAIC03NTIsMTAgKzc2MywxMCBAQCBzdGF0aWMgdm9pZCBzY3J1Yl92ZXJpZnlfb25lX3NlY3Rv
cihzdHJ1Y3Qgc2NydWJfc3RyaXBlICpzdHJpcGUsIGludCBzZWN0b3JfbnIpCiAJCQkJICAgICAg
c3RyaXBlLT5sb2dpY2FsICsKIAkJCQkgICAgICAoc2VjdG9yX25yIDw8IGZzX2luZm8tPnNlY3Rv
cnNpemVfYml0cyksCiAJCQkJICAgICAgc3RyaXBlLT5sb2dpY2FsKTsKLQkJCXJldHVybjsKKwkJ
CWdvdG8gb3V0OwogCQl9CiAJCXNjcnViX3ZlcmlmeV9vbmVfbWV0YWRhdGEoc3RyaXBlLCBzZWN0
b3JfbnIpOwotCQlyZXR1cm47CisJCWdvdG8gb3V0OwogCX0KIAogCS8qCkBAIC03NjQsNyArNzc1
LDcgQEAgc3RhdGljIHZvaWQgc2NydWJfdmVyaWZ5X29uZV9zZWN0b3Ioc3RydWN0IHNjcnViX3N0
cmlwZSAqc3RyaXBlLCBpbnQgc2VjdG9yX25yKQogCSAqLwogCWlmICghc2VjdG9yLT5jc3VtKSB7
CiAJCWNsZWFyX2JpdChzZWN0b3JfbnIsICZzdHJpcGUtPmVycm9yX2JpdG1hcCk7Ci0JCXJldHVy
bjsKKwkJZ290byBvdXQ7CiAJfQogCiAJcmV0ID0gYnRyZnNfY2hlY2tfc2VjdG9yX2NzdW0oZnNf
aW5mbywgcGFnZSwgcGdvZmYsIGNzdW1fYnVmLCBzZWN0b3ItPmNzdW0pOwpAQCAtNzc1LDYgKzc4
NiwxNyBAQCBzdGF0aWMgdm9pZCBzY3J1Yl92ZXJpZnlfb25lX3NlY3RvcihzdHJ1Y3Qgc2NydWJf
c3RyaXBlICpzdHJpcGUsIGludCBzZWN0b3JfbnIpCiAJCWNsZWFyX2JpdChzZWN0b3JfbnIsICZz
dHJpcGUtPmNzdW1fZXJyb3JfYml0bWFwKTsKIAkJY2xlYXJfYml0KHNlY3Rvcl9uciwgJnN0cmlw
ZS0+ZXJyb3JfYml0bWFwKTsKIAl9CitvdXQ6CisJYXRvbWljX2RlYygmc3RyaXBlLT5wZW5kaW5n
X2lvKTsKKwl3YWtlX3VwKCZzdHJpcGUtPmlvX3dhaXQpOworfQorCitzdGF0aWMgdm9pZCBzY3J1
Yl92ZXJpZnlfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCit7CisJc3RydWN0IHNjcnVi
X3NlY3Rvcl92ZXJpZmljYXRpb24gKnNlY3RvciA9IGNvbnRhaW5lcl9vZih3b3JrLAorCQkJc3Ry
dWN0IHNjcnViX3NlY3Rvcl92ZXJpZmljYXRpb24sIHdvcmspOworCisJc2NydWJfdmVyaWZ5X29u
ZV9zZWN0b3Ioc2VjdG9yLT5zdHJpcGUsIHNlY3Rvci0+c2VjdG9yX25yKTsKIH0KIAogLyogVmVy
aWZ5IHNwZWNpZmllZCBzZWN0b3JzIG9mIGEgc3RyaXBlLiAqLwpAQCAtNzg0LDExICs4MDYsMjQg
QEAgc3RhdGljIHZvaWQgc2NydWJfdmVyaWZ5X29uZV9zdHJpcGUoc3RydWN0IHNjcnViX3N0cmlw
ZSAqc3RyaXBlLCB1bnNpZ25lZCBsb25nIGIKIAljb25zdCB1MzIgc2VjdG9yc19wZXJfdHJlZSA9
IGZzX2luZm8tPm5vZGVzaXplID4+IGZzX2luZm8tPnNlY3RvcnNpemVfYml0czsKIAlpbnQgc2Vj
dG9yX25yOwogCisJLyogQWxsIElPIHNob3VsZCBoYXZlIGZpbmlzaGVkLCBhbmQgd2Ugd2lsbCBy
ZXVzZSBwZW5kaW5nX2lvIHNvb24uICovCisJQVNTRVJUKGF0b21pY19yZWFkKCZzdHJpcGUtPnBl
bmRpbmdfaW8pID09IDApOworCiAJZm9yX2VhY2hfc2V0X2JpdChzZWN0b3JfbnIsICZiaXRtYXAs
IHN0cmlwZS0+bnJfc2VjdG9ycykgewotCQlzY3J1Yl92ZXJpZnlfb25lX3NlY3RvcihzdHJpcGUs
IHNlY3Rvcl9ucik7CisJCXN0cnVjdCBzY3J1Yl9zZWN0b3JfdmVyaWZpY2F0aW9uICpzZWN0b3Ig
PSAmc3RyaXBlLT5zZWN0b3JzW3NlY3Rvcl9ucl07CisKKwkJLyogVGhlIHNlY3RvciBzaG91bGQg
aGF2ZSBiZWVuIGluaXRpYWxpemVkLiAqLworCQlBU1NFUlQoc2VjdG9yLT5zZWN0b3JfbnIgPT0g
c2VjdG9yX25yKTsKKwkJQVNTRVJUKHNlY3Rvci0+c3RyaXBlID09IHN0cmlwZSk7CisKKwkJYXRv
bWljX2luYygmc3RyaXBlLT5wZW5kaW5nX2lvKTsKKwkJSU5JVF9XT1JLKCZzZWN0b3ItPndvcmss
IHNjcnViX3ZlcmlmeV93b3JrKTsKKwkJcXVldWVfd29yayhmc19pbmZvLT5zY3J1Yl93cl9jb21w
bGV0aW9uX3dvcmtlcnMsICZzZWN0b3ItPndvcmspOworCiAJCWlmIChzdHJpcGUtPnNlY3RvcnNb
c2VjdG9yX25yXS5pc19tZXRhZGF0YSkKIAkJCXNlY3Rvcl9uciArPSBzZWN0b3JzX3Blcl90cmVl
IC0gMTsKIAl9CisJd2FpdF9zY3J1Yl9zdHJpcGVfaW8oc3RyaXBlKTsKIH0KIAogc3RhdGljIGlu
dCBjYWxjX3NlY3Rvcl9udW1iZXIoc3RydWN0IHNjcnViX3N0cmlwZSAqc3RyaXBlLCBzdHJ1Y3Qg
YmlvX3ZlYyAqZmlyc3RfYnZlYykKQEAgLTE1MzQsOCArMTU2OSw2IEBAIHN0YXRpYyBpbnQgc2Ny
dWJfZmluZF9maWxsX2ZpcnN0X3N0cmlwZShzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJnLAog
CXU2NCBleHRlbnRfZ2VuOwogCWludCByZXQ7CiAKLQltZW1zZXQoc3RyaXBlLT5zZWN0b3JzLCAw
LCBzaXplb2Yoc3RydWN0IHNjcnViX3NlY3Rvcl92ZXJpZmljYXRpb24pICoKLQkJCQkgICBzdHJp
cGUtPm5yX3NlY3RvcnMpOwogCXNjcnViX3N0cmlwZV9yZXNldF9iaXRtYXBzKHN0cmlwZSk7CiAK
IAkvKiBUaGUgcmFuZ2UgbXVzdCBiZSBpbnNpZGUgdGhlIGJnLiAqLwotLSAKMi40MS4wCgo=

--------------q6b70rCfldGBRbM9AMHznpLY--
