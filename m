Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D7755ADC
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 07:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGQFYF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 01:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjGQFYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 01:24:03 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2070.outbound.protection.outlook.com [40.107.103.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941311AC
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jul 2023 22:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpMFZZdaBZhU4GWanXBHvU0ULhqj7aphENNN9m/smxRZVdx2VaMSlm15UwQpMCTh+dozJs4RlvIHYqGx7K6VWXp6pXAFpbcSvjC2CDdJTIHYTMH136vKcAW8SuwBBgBe/nBaKuKmrZic4Bf5Bp4EAtStOeX6EsToHsQpC4Kp/RAMf1RphQnbB4IW/jnkdwiiCrF3n2wx6CcIK7iCDesbnTsKzZJWvB3DO/7XTzEbJGGIJvpmBa551pHRuT+H+YfGWPOyduXJ7XJsv7JUQG2B/VcKzVEgGb5waeRueMl/vvo0v0touq/m8SDq2BPppLK56flB8jr1/tSP0rqtCCuVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdX22fCoe18USxg5u6+oXrL6TmJnk+sWCExCQ9dvQV8=;
 b=WoRsWPuBHhMHelErBtEsiqXELRTJaVkbW5mobEygKOqCDuNm8oifIY0xL930POT101nx6cd3mDYpuhdbh+Y/FOh4MES8usP6NSMmc90I1lovbfdOgzXZY7Qq6v+sv3zLX1Ot3gQXAPM4XB5U2CPSV4K6zDs9csWLZGd1pO4PUqi6je+fBXkuzSYK5JAhxV+6mqI2RuBIpMHKAAhoClgJ3i9VMrUMeXbnR4LTaJkOtsuCeu5giO2VZsboJ5EhlJXlkdpYUYY5FI/Lo/LMVEIC/nRQYvEIUumKenECvXdZBC7TBzC9RuCJaZLXgaf1lGj3jgeIGxMNoTFisNGvtXLPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdX22fCoe18USxg5u6+oXrL6TmJnk+sWCExCQ9dvQV8=;
 b=IGRkUkgly1piGBAh6B2SxXKxlfcy5rRk1PePsuuY46aKPEXZnp1qy1CpROUeMX3fgvqZhqq8SmPLu2dOTkUo5/aztq6CLGneaFm0wwJ2r/2NODySl7o/YFLmQ3+bwVruiMUUMI7s+uD6FXJZWd6AXA3kXUCQ6lSHAnbjQjdQX6kh8fcq5U4wug5INIlAjI8Q7rMMBPIFdGQYGQpblnKQTauLQkMtvrYiyKUV2MIArtqQQG8EKe+O/XHiX8nfcytcPNsA+oAEieU9JI85w22eO8y1jJVJEwXNqpuHNGTfcIr4d149ZOB+sSSRlthDfFC2VyPb2G2Ad4nddSbCbHzukA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS5PR04MB9730.eurprd04.prod.outlook.com (2603:10a6:20b:677::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 05:23:58 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 05:23:57 +0000
Message-ID: <0f35d3b1-b12d-97e1-5abc-aef451b8c39f@suse.com>
Date:   Mon, 17 Jul 2023 13:23:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Scrub of my nvme SSD has slowed by about 2/3
Content-Language: en-US
To:     =?UTF-8?Q?Sebastian_D=c3=b6ring?= <moralapostel@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com>
 <2311414.ElGaqSPkdT@lichtvoll.de>
 <151906c5-6b6f-bb57-ab68-f8bb2edad1a0@suse.com>
 <5977988.lOV4Wx5bFT@lichtvoll.de>
 <9e05c3b9-301c-84c5-385d-6ca4bfa179f4@gmx.com>
 <3d9af05d-af51-22a4-3dee-2fa9e743ce68@gmx.com>
 <CADkZQa=xu7h8jryjUNf_XYh=f88VTU4xNp1c7f=FxVHnmXmYoA@mail.gmail.com>
 <d18c2da7-17f7-4d39-c511-8123484b3c08@gmx.com>
 <CADkZQamJ0U9c_77prc-bFoyu+NgiyVsjo8dKYHdXOBHqAi=1Fw@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CADkZQamJ0U9c_77prc-bFoyu+NgiyVsjo8dKYHdXOBHqAi=1Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS5PR04MB9730:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e0f79e-74ff-4e47-7860-08db86860532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRKs1wCUQULDYyKGrLadgqom81UwdKZC4WlYxXt5FpJHHhBpzdnUEzDjmWpoHa0neQSWFuS7Pnu/HX8YVUB+H1wD/uy8PUaGgp3cnnAyzCPGalk82sGrsELk9j2oL845VTVRGoTow5Fp56QOSPYraMekyUhmAHmLlPH91UmSJ43gB1nMYv3aVwh8PTULta695gPbbelAK0rpqY47DcQtFRRmgt+le4cgSaevWhW9o12eqSg+MBimjbjfxQvAiTFWzgELkwNNzlNmdWSji18uxaHmdlyTMOlqnIDonVfeae23B0VdK5BtpTRgUf0nmZfD1jdKjjVds2EoihjaXamcJ7hafbetjMpAid/ZwM+yxW2InCOb50y1tUQ3JLn1UZSm7Mu7hEzY7PiU7FaSMlu1Z7TyF/Rvxpgon1vTbrhIOinvL7IbTHixG33psNPv1SheJlohXAd0V4ctkEiMrkNOhHGVH5syx2hMTXY97hOyj+8XvGjdw+7V6umbCAIOy8ws4cjKCv09Ciw5+qzX+5HeSJu1uFFYJE8RwmZtwi4RRV5B6HwJfgTKoqVmMFLV17RaifSbATPGR88HwuoJcx78sUQ/2Nkbzfr+uDFLVCmOCRdDB4b8QNuIZgTV9a2dJT8guT0ukt3B0JhE6U99lcEAMewxh1NSXioCsQ/pyuWZmd4OOFTz4DEkqJtUapGT4Jb97jhzQ7/2XBqWtZEYpAoE+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(31686004)(478600001)(6486002)(110136005)(6666004)(66574015)(83380400001)(2616005)(31696002)(86362001)(36756003)(2906002)(186003)(53546011)(6506007)(966005)(6512007)(38100700002)(66946007)(66556008)(66476007)(4326008)(316002)(41300700001)(8676002)(8936002)(5660300002)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFhZVWdnWmVsTkJJcFpUdUN5akgxb2c1TTloQWYyRU12RVBvdkhzaWk5dEFu?=
 =?utf-8?B?eDRpdS8zbjNvck9FeDJXMm5aV2djRWpYRVRRQjFLdFhzOERyTmZMTG1qK2cz?=
 =?utf-8?B?YjBQcXlKVmswc1NGOGFTZng2OVVVNCtPMUJFOUZFL2NHWi8yNUprejlNWVJ5?=
 =?utf-8?B?dWt0cXNqVG9NaThEZzl2WVdBOXpKZWx5Z3RQSjZLQ3JWUWF0YkltaTZlVUVp?=
 =?utf-8?B?a2d1RitpRlNKcjZlM1ZUT2VTRTNvYktyV2JKR3c4L3pWNzVYVGpMQXJHVTc5?=
 =?utf-8?B?RnRMUitOSHBFdnVjZjUrbldnMDZINW1uT0ZETnY3ejJvYUxNYVE5VitWTEZY?=
 =?utf-8?B?Ty8xZ01odllGZU5yMTBZcTJSakVmeXFIUmRMWnJDdGtHNVZJSUpNTVhWWFY1?=
 =?utf-8?B?UzVxaVV1anh5N1g3cjMzcFlkRmpFbHBzUHJIWXMvZndHU0p2Vy9aL0o1aitS?=
 =?utf-8?B?ZHg1Zko1WkNPa0lEWkcrL3Ava0gzUnljcE9ReGgzdjRnNTVEYzZKeElxZTZX?=
 =?utf-8?B?Z0VpNmtCdkVmaXg3NS9zQjlhWlJZNHphVWdaQUlFWURlK21UMlF6bklaT3cv?=
 =?utf-8?B?L2pzZDZ1dGtac0hzT2ZVOC9pdDlRbmdWUnpRSFJKSlFtQ1E0QTJYQ056V1lD?=
 =?utf-8?B?QmRtWVFGd2U4ZE9HRyt6Z3YwMG1sS1hlL2hyMXpGaHhQL3ZLWUFibmVxa2or?=
 =?utf-8?B?ZEdtSlZOY1NoZVNsdEJjUU9XWXkvS2dIczZ0ZWV3a1FPbmNOVFEzL1hwVTho?=
 =?utf-8?B?QlFUb09XUUpnMGtmU01OdElLNWtheE40RmRmTXFRaGwvTy9BekVhZUhVaUNV?=
 =?utf-8?B?OERPWW5tdXFsZ1BhSGRXWmJWeTZDSjRKOUlHamNqaUh0d3ZYdDFFdmFnV0dL?=
 =?utf-8?B?NHZqUnJqYmdPcE43WnMwWnRYMkdkWGoxVktDbklBRDJzOFlIY3NFVCt4QUV1?=
 =?utf-8?B?TXdzcXNjTXptTytSc1d5bG1zSng5OHBXR0p3OTgwNzViYmI2L0F4RWNvQk1q?=
 =?utf-8?B?czJzL3NHcitzbnJsb0lwYlB1Z0lhTUhTd21ZOUl0WmxENVJsbEhpWmprMVVk?=
 =?utf-8?B?TXR0QWdoNFk2WE9ZTU93YngycWVmR2ZDdUpqdGYycktDV3NHUGozdFVvNGVi?=
 =?utf-8?B?c1ZIMkJLNXB3UFh4SExMeVJtcDdpNjE2NVMzdUgzbk56Wi9NY25JWFpJaFBw?=
 =?utf-8?B?UUlYb20xYWhoYzVGSkVKSnlsOHZ1Y1pHbENUMmdZM1lKb05SdXNQZnVsYjN6?=
 =?utf-8?B?MEZUdWtRZTgzaDRhVUpneXNnbURDQzFNTFdyMVQwWkRuTEZDR3BDUDhIb2pJ?=
 =?utf-8?B?OThsQkJMVXpXaElIMjV2YjJ4WDVzZ3pTbTNuTnZrYVBCTGdRa1VsWHZRYkhq?=
 =?utf-8?B?bGN0NlhRZnYxRFFmMG9yaWVEbExWc05ydHQ2VGhkcjdGM2pvbTZvSmpvQmxH?=
 =?utf-8?B?WFdNTjhRT0dvNXN2bVNrS1ljZmIvS0dmZG1wTzgrdXN4ajFVNEZzM1B0aHZB?=
 =?utf-8?B?RFk4OVQ3S3UxSTdBd3JsT3lEM2YvTStOZG9lRDdmdVFHbE9WaTFpV2Iwb2J0?=
 =?utf-8?B?eXFSK0ZYRHJZbWxuWlZzVCsxNUJPQTNycTZWaWJFYjBKbi9lWGdYbG1ab0Yw?=
 =?utf-8?B?dFlNTHROTkg1ZDkxcUFSQjlmU3pJVWNBQnpRQW1FWXZybnRnKzlYZ1YzSUU3?=
 =?utf-8?B?N3Z6MHJWdm1CWEFiem5GOUxHV2VjSmFES0RrWVZYcDRZK3hjeEpIdTJScC92?=
 =?utf-8?B?QlZyY3pvS1MzRkpIUXpwenN1L1VNWUYyanVUMmJWK2JVUTU0cnZ0Mmo1UitD?=
 =?utf-8?B?TUxHWGZoY0ZqNUpRdkZURHdSWExaSU5PUGZnbC9oM0Y0Q1VCYlIyYmVYbGgz?=
 =?utf-8?B?T2VMMzVtTzVIQXAwNXJHak0xZDdkUDVQWTBaVFBLdytTZlBMUDRZM2RqK1Vh?=
 =?utf-8?B?M25YOHpueUI5L09jbmM4RWhKTlh5K3VPN0VTT1RSSDZkekZhR2JHUzdqb3Q0?=
 =?utf-8?B?YXhqMG5qa080N2lwS21YYVB6UVNvWERIQ1VHT1BIZGRtR0NubjU3TzVPQzY0?=
 =?utf-8?B?MUU2eXM3bmdZbUowSHZ4bmVoa2wxL29SbTk1ZUlMdlIvbTZWc3hMUlNuUXdE?=
 =?utf-8?Q?9/0gi8QDqS2jP+dzK+Db/zPHC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e0f79e-74ff-4e47-7860-08db86860532
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 05:23:57.6937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SakEYrKRvSweya8qvkqLzqh9xQWoA4tOr4jFk4FkfZE6rfwLXOpqGmvBpn50kwIM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9730
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/17 00:01, Sebastian Döring wrote:
> Hi Qu,
> 
>> You can try this patch to see if it helps with your setup:
> 
>> https://patchwork.kernel.org/project/linux-btrfs/patch/ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com/
> 
> I gave this patch a shot, applied to 6.4.3, and it did indeed return
> scrub performance to 6.3.*-ish levels for me (at least in this short 5
> minute test):
> 
> rockpro64 ~ # scrub canceled for 0a1dfaa5-e448-44df-b5ca-3024b9f35b43
> Scrub started:    Sun Jul 16 17:48:48 2023
> Status:           aborted
> Duration:         0:05:28
> Total to scrub:   103.34GiB
> Rate:             322.61MiB/s
> Error summary:    no errors found
> 
> Unpatched, I saw around ~140MiB/s.
> 
> As an aside, are you aware that the "Total to scrub" seems totally
> borked in per device scrub status (-d flag)?

That's a bug in btrfs-progs AFAIK.

There are some cases that btrfs-progs uses the total size of the disk 
(instead of the used space) to report.

Although for the case of per-device scrubbing, it may need more accurate 
checks (needs to go through dev-extent tree to grab the real per-device 
used space).

There is already a patch to fix some of the cases, but there may be more:

https://patchwork.kernel.org/project/linux-btrfs/patch/2e1ee8fb0a05dbb2f6a4327d5b1383c3f7635dea.1685924954.git.wqu@suse.com/

Thanks,
Qu

> 
> Scrub device /dev/mapper/disk5-6 (id 1) status
> Scrub resumed:    Sun Jul 16 17:56:53 2023
> Status:           running
> Duration:         33:32:24
> Time left:        0:00:00
> ETA:              Sun Jul 16 17:59:36 2023
> Total to scrub:   7.49TiB
> Bytes scrubbed:   7.49TiB  (100.00%)
> Rate:             65.03MiB/s
> Error summary:    no errors found
> 
> Scrub device /dev/mapper/disk7-8 (id 2) status
> Scrub resumed:    Sun Jul 16 17:56:53 2023
> Status:           running
> Duration:         33:32:24
> Time left:        0:00:00
> ETA:              Sun Jul 16 17:59:36 2023
> Total to scrub:   8.35TiB
> Bytes scrubbed:   8.35TiB  (100.00%)
> Rate:             72.48MiB/s
> Error summary:    no errors found
> 
> 
> Best regards,
> Sebastian
> 
> On Sun, Jul 16, 2023 at 12:55 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2023/7/16 17:57, Sebastian Döring wrote:
>>> Hi all,
>>>
>>>> I got a dedicated VM with a PCIE3.0 NVME passed to it without any host
>>> cache.
>>>
>>>> With v6.3 the scrub speed can reach 3GB/s while the v6.4 (misc-next) can
>>> only go around 1GB/s.
>>>
>>> I'm also observing severely degraded scrub performance (~50%) on a
>>> spinning disk (on top of mdraid and LUKS). Are we sure this regression
>>> is in any way NVME related?
>>
>> The regression would happen if the storage devices don't have any
>> firmware level request merge (SATA NCQ feature).
>>
>> In that case, the rework scrub block size is way smaller than the old
>> one (64K vs 512K), which would cause performance regression.
>>
>> You can try this patch to see if it helps with your setup:
>>
>> https://patchwork.kernel.org/project/linux-btrfs/patch/ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com/
>>
>> For NVME, it still doesn't reach the old performance, but for SATA HDDs
>> even without NCQ, it should more or less reach the old performance.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Best regards,
>>> Sebastian
>>>
>>> On Fri, Jul 14, 2023 at 3:01 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>> Just a quick update on the situation.
>>>>
>>>> I got a dedicated VM with a PCIE3.0 NVME passed to it without any host
>>>> cache.
>>>>
>>>> With v6.3 the scrub speed can reach 3GB/s while the v6.4 (misc-next) can
>>>> only go around 1GB/s.
>>>>
>>>> With dedicated VM and more comprehensive telemetry, it shows there are
>>>> two major problems:
>>>>
>>>> - Lack of block layer merging
>>>>      All 64K stripes are just submitted as is, while the old code can
>>>>      merge its read requests to around 512K.
>>>>
>>>>      The cause is the removal of block layer plug/unplug.
>>>>
>>>>      A quick 4 lines fix can improve the performance to around 1.5GB/s.
>>>>
>>>> - Bad csum distribution
>>>>      With above problem fixed, I observed that the csum verification seems
>>>>      to have only one worker.
>>>>
>>>>      Still investigating the cause.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>> On 2023/7/11 19:33, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2023/7/11 19:26, Martin Steigerwald wrote:
>>>>>> Qu Wenruo - 11.07.23, 13:05:42 CEST:
>>>>>>> On 2023/7/11 18:56, Martin Steigerwald wrote:
>>>>>>>> Qu Wenruo - 11.07.23, 11:57:52 CEST:
>>>>>>>>> On 2023/7/11 17:25, Martin Steigerwald wrote:
>>>>>>>>>> Qu Wenruo - 11.07.23, 10:59:55 CEST:
>>>>>>>>>>> On 2023/7/11 13:52, Martin Steigerwald wrote:
>>>>>>>>>>>> Martin Steigerwald - 11.07.23, 07:49:43 CEST:
>>>>>>>>>>>>> I see about 180000 reads in 10 seconds in atop. I have seen
>>>>>>>>>>>>> latency
>>>>>>>>>>>>> values from 55 to 85 µs which is highly unusual for NVME SSD
>>>>>>>>>>>>> ("avio"
>>>>>>>>>>>>> in atop¹).
>>>>>> […]
>>>>>>>>>>> Mind to try the following branch?
>>>>>>>>>>>
>>>>>>>>>>> https://github.com/adam900710/linux/tree/scrub_multi_thread
>>>>>>>>>>>
>>>>>>>>>>> Or you can grab the commit on top and backport to any kernel >=
>>>>>>>>>>> 6.4.
>>>>>>>>>>
>>>>>>>>>> Cherry picking the commit on top of v6.4.3 lead to a merge
>>>>>>>>>> conflict.
>>>>>> […]
>>>>>>>>> Well, I have only tested that patch on that development branch,
>>>>>>>>> thus I can not ensure the result of the backport.
>>>>>>>>>
>>>>>>>>> But still, here you go the backported patch.
>>>>>>>>>
>>>>>>>>> I'd recommend to test the functionality of scrub on some less
>>>>>>>>> important machine first then on your production latptop though.
>>>>>>>>
>>>>>>>> I took this calculated risk.
>>>>>>>>
>>>>>>>> However, while with the patch applied there seem to be more kworker
>>>>>>>> threads doing work using 500-600% of CPU time in system (8 cores
>>>>>>>> with
>>>>>>>> hyper threading, so 16 logical cores) the result is even less
>>>>>>>> performance. Latency values got even worse going up to 0,2 ms. An
>>>>>>>> unrelated BTRFS filesystem in another logical volume is even stalled
>>>>>>>> to almost a second for (mostly) write accesses.
>>>>>>>>
>>>>>>>> Scrubbing about 650 to 750 MiB/s for a volume with about 1,2 TiB of
>>>>>>>> data, mostly in larger files. Now on second attempt even only 620
>>>>>>>> MiB/s. Which is less than before. Before it reaches about 1 GiB/s.
>>>>>>>> I made sure that no desktop search indexing was interfering.
>>>>>>>>
>>>>>>>> Oh, I forgot to mention, BTRFS uses xxhash here. However it was
>>>>>>>> easily scrubbing at 1,5 to 2,5 GiB/s with 5.3. The filesystem uses
>>>>>>>> zstd compression and free space tree (free space cache v2).
>>>>>>>>
>>>>>>>> So from what I can see here, your patch made it worse.
>>>>>>>
>>>>>>> Thanks for the confirming, this at least prove it's not the hashing
>>>>>>> threads limit causing the regression.
>>>>>>>
>>>>>>> Which is pretty weird, the read pattern is in fact better than the
>>>>>>> original behavior, all read are in 64K (even if there are some holes,
>>>>>>> we are fine reading the garbage, this should reduce IOPS workload),
>>>>>>> and we submit a batch of 8 of such read in one go.
>>>>>>>
>>>>>>> BTW, what's the CPU usage of v6.3 kernel? Is it higher or lower?
>>>>>>> And what about the latency?
>>>>>>
>>>>>> CPU usage is between 600-700% on 6.3.9, Latency between 50-70 µs. And
>>>>>> scrubbing speed is above 2 GiB/s, peaking at 2,27 GiB/s. Later it went
>>>>>> down a bit to 1,7 GiB/s, maybe due to background activity.
>>>>>
>>>>> That 600~700% means btrfs is taking all its available thread_pool
>>>>> (min(nr_cpu + 2, 8)).
>>>>>
>>>>> So although the patch doesn't work as expected, we're still limited by
>>>>> the csum verification part.
>>>>>
>>>>> At least I have some clue now.
>>>>>>
>>>>>> I'd say the CPU usage to result (=scrubbing speed) ratio is much, much
>>>>>> better with 6.3. However the latencies during scrubbing are pretty much
>>>>>> the same. I even seen up to 0.2 ms.
>>>>>>
>>>>>>> Currently I'm out of ideas, for now you can revert that testing patch.
>>>>>>>
>>>>>>> If you're interested in more testing, you can apply the following
>>>>>>> small diff, which changed the batch number of scrub.
>>>>>>>
>>>>>>> You can try either double or half the number to see which change helps
>>>>>>> more.
>>>>>>
>>>>>> No time for further testing at the moment. Maybe at a later time.
>>>>>>
>>>>>> It might be good you put together a test setup yourself. Any computer
>>>>>> with NVME SSD should do I think. Unless there is something very special
>>>>>> about my laptop, but I doubt this. This reduces greatly on the turn-
>>>>>> around time.
>>>>>
>>>>> Sure, I'll prepare a dedicated machine for this.
>>>>>
>>>>> Thanks for all your effort!
>>>>> Qu
>>>>>
>>>>>>
>>>>>> I think for now I am back at 6.3. It works. :)
>>>>>>
