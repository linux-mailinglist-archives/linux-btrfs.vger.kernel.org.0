Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367874C20AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 01:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiBXAee (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 19:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiBXAec (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 19:34:32 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338DC97B92
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 16:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1645662840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qP/QoNYqqrNZ2YbWOgx3MbB8shTv5puB653UdOAIf/8=;
        b=U02FQfrjveBuFsD03spXw9iry4yeIAJ44PIswgcgDDdu/rOfI+vKAWxS0rhMhsnZiIAfDv
        slFtHpgHRq1MyWh2mLE/xPBuSvnQ6QJxvMmia+C3Bhqjsfyn2YJNwuZH8bv+BIXpKZW5tZ
        CnlqOm97UA7NydSCwVhvMbh8wRWhOXM=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-yfMWgUlBPlqolQb7mBiUVQ-2; Thu, 24 Feb 2022 01:33:59 +0100
X-MC-Unique: yfMWgUlBPlqolQb7mBiUVQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC/E+sTql5suc4DRdxoxCVmUI0Exf2ryM3Zj2C1mV0pkaD4yThGRb9BKgOY6e1CFbOPKlM7yK5/+Bc3dNU7pk6H4inZyS1PfQ7y9sA5EBoRirMPHiiC3+HSqZfDSeByrlOTRjIQ0uZt1aP0NpNYhnrovF70TnVrG5KRq9rbaEJZaFcfSXs3xO5h4V8D92V8vFuud12DGNhwt4uPDUa5i9q7E8U44xULTEPnsLPVBNJzY0PD7jazoSqAYiQX7/wSCewdzJtErH/sVyhFZW2g2LJLjm8JIgEP4DfZI2q1Hi1biACAP9FQ53lP4diL1hxzcRTKEhrMJ96mFGBupw7TbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiVC8qpJo0h2NEKDXpAWmXilAufjl/5IwFbxr0JFicE=;
 b=X1z2ghgi3eyby5g7cqVzVspNoswkn8UWVN1098GeBAkRjabh+W1Py9qz4MTUtvh1cckig/85nKavGHih8SzlTjpz5LfTaOI/BJ+I2ST/SywCYl3V/Y1RjhXRAlidUwm/GgMqp9yFjrUxXR6KvWr6iQVCu2AUw5MNYjvtAF8QocyynXzh2B7lWwqEZLT9AILkP3oVavriOOS6dXk3o7JXeFPFJGDhSYSwqXFPuDnT/XqQQ2PpLls2EeNsd6wfuziGqwBn7OFSHUKyz7rV7dWbvnbsFHCyJeQR/Hh/UtdtcoWZgDT5mZDRJWs79UffucbI3wIwVNl47/AZDdANabbcPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AM6PR0402MB3462.eurprd04.prod.outlook.com (2603:10a6:209:6::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 00:33:56 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.4995.027; Thu, 24 Feb 2022
 00:33:56 +0000
Message-ID: <173dc4fc-21fa-1534-9e6e-d1ff4c1b7564@suse.com>
Date:   Thu, 24 Feb 2022 08:33:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Crash/BUG on during device delete
Content-Language: en-US
To:     Forza <forza@tnonline.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
References: <c574966a-4b9e-0a50-cb47-e6f904f95eaf@tnonline.net>
 <4e094239-c987-8b1a-bc56-b4252481fbaa@gmx.com>
 <feada357-9340-0ec3-4899-91b7351d17ad@tnonline.net>
 <3c25d70c-43fe-cf38-33f8-05e35ceb03f0@suse.com>
 <b964eb55-537f-dab4-e8a0-1326d5ee2c67@tnonline.net>
 <90be0040-74f9-29fa-4552-57f45dbf0a86@suse.com>
 <5a8a1ecf-d8ef-7db3-7a97-3f9f29b57bb1@tnonline.net>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <5a8a1ecf-d8ef-7db3-7a97-3f9f29b57bb1@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::13) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91827fa5-2658-4000-0dc8-08d9f72d5773
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3462:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6PR0402MB34626D7407942D4251FB5E41D63D9@AM6PR0402MB3462.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQg3GQfyiLIEZhGdeV8MW0qKcb/pAeND3V7E3berhopjwBkGbFr4HODnixJkMSFUDspMb7LdlyhcjrCOQ3Wjav6rFqia4gsZ8CNQxIYjZRq8PSd7CQ7M3+VQsjf5A5qQmkHVUgjlDHzro9T5dOOOW/q6tycbbI4HH5Im1LiwP8HUU3AwdE4/T5RWEEvI8rOz72/Vntl9KtMZkaFU4tSbxQPmjw1H+esl9gKxxSs2//D2GraRvsF3MMbHUNEHvg/FjIG0LLkwPQ6teaoYlL8oYqEk0fB/7KcWttRDW6OKqIlGkzwffD63YzxAJzV7bktDSHxksIsLXaMcwIYzQiUFrfPvfsyrq/IsGSxcOnQ2UQkzlBs+AINj483Ndx3OifCqHJ1sYO7KV+KCDbcK4Mp64GIYmZugPm4QDrYCs89trbQQiSyp4QJ+pZiIT3yNyWPbqS1uqfpeLrmUC04TWiomxo5pUOO5dDbqSmJnmjUproDkYiXlNRd6l1YBZ7JO0xm0wHPlm+LQADdah1wHpqI7j9v30q76t0dVQGU9EaHQIPyjulSdETHG3nSBbMFDgb1oEITbXetZkAgOXXZjSGngL2Of5UBYty/sGuTIg+BZKIlNUClkProAUPAaJQ4YW7mp/FdpRrPFsGGuZ7MhMBRB1lyCDLn0N1O+xCpL2eT+FqSw6Y1BYEv5XLLOSgkgiJTJbIc/qSxQNCtq+JMyNX4ACYhvoXuaijtqNHwhgkSA7ds=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(2616005)(66556008)(26005)(8676002)(66946007)(186003)(6512007)(53546011)(6486002)(966005)(508600001)(2906002)(6506007)(38100700002)(36756003)(31686004)(31696002)(86362001)(316002)(6636002)(5660300002)(6666004)(83380400001)(110136005)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KXofkWEBV2sOzj+tfJ3QArvwRqlJNPlirsCSdZGel3/7Q6w/15ak3kH4JfXj?=
 =?us-ascii?Q?taSaqGZ7FVDAluyqCQ/HkchXDGDILdeBIEqeZJo1F8V1ySNkAem22IMwol+E?=
 =?us-ascii?Q?3jw5H7A82JsWWX8goV2AnYZyaR6FItyl+YIwueABMiYJj1fu8l/0o1hJPtVy?=
 =?us-ascii?Q?xLWL7EIRowigUjv2elIlgNDUw8aVMlWH1SM9ZQxk1Vm2ld6/0HVKg0m5iaLA?=
 =?us-ascii?Q?W/HZa6PxqmDaq0soC/nZhKmdf2KPwcNTPQy86xOS6/hyY6akIlBZS9K3yKfh?=
 =?us-ascii?Q?uRh+hAu9RQ03dEH8UlSA6VPY0Ob29i3EBDzH7HOgqyqQpz0V2+2igkIHH9wG?=
 =?us-ascii?Q?yPQfcSE2zghwCFZkgNsQ8WfT3k6d+9hnzBYYyRdoHFrWCNw5HeO7EiVCOASJ?=
 =?us-ascii?Q?H70NA9uKQUlfzL0PtOPUdkK+OBEJd+VKMsI7Vplo1Rx7GjZIh4O8UAsNneeW?=
 =?us-ascii?Q?T2FCyGpov3AK1EvbBI2bnDCnNvIuA/MVHoTQG68Bo8ujY5AlAJnykUEQqZ10?=
 =?us-ascii?Q?LdufPKNdp3so50JhQYfkmlKk7Q6uAkwaOfZHcM5wpWWWbwHYk/lmVKNcVip4?=
 =?us-ascii?Q?vsDSamqi3rhpNXqWbNdYRp6Q8riQA12+mmojHw2M49RAchdvlue/e+Orix9q?=
 =?us-ascii?Q?AcMcbtIw8M91I6A+oISCPf6VWCTd9PI3LeyUbva9Abi6zVsklYP3GjyZ/4yH?=
 =?us-ascii?Q?CpJC8HQT6fuzuME5puB4IWDEczoMoV+A24BTmHjXkX1Uc50Zk9jW/uHXA7MW?=
 =?us-ascii?Q?eO1iJ2ktbZAU/v5Np7P5YsuOdu30GdGAeXAminM0gl2aCZfTZX0+hzBuiySO?=
 =?us-ascii?Q?U90j4qKm+Kn4euCPERCH1ABGGnse7acTt87wnv0f4InUCfUHRZWF9AD6daAX?=
 =?us-ascii?Q?/l8YpwlVBasiS1wqtVfjbqkI38JEOCpqOYaT/WyfKZF8G32igRqqMMhPLIOT?=
 =?us-ascii?Q?1joCjWgWNJjZUEv58QNbfkXUbqBOSuXfKVICNVVlEUpcHQuvs67r88S3FxGg?=
 =?us-ascii?Q?JyZtHE/hnUKYBM2Ob248nBo3QXWpllEFG88+4FrCsWJHP9toS0qMPngXGtql?=
 =?us-ascii?Q?JVKgAiRuq+pnUoD7yfcqZxNQervHhWsQXScvmIFmPezoryg5DzbMcbiIYByH?=
 =?us-ascii?Q?i1YvIKqkYrl9kNvPs9BDxdG3excznhpwFxPTYNiUUA4TF9JpSRHniYTwBmhp?=
 =?us-ascii?Q?iAEV+F/TzYO+cBEdQ9RZLIEcsU7/uMLrguOr5Xbg9KDvl3wHgCrkwjZZocK6?=
 =?us-ascii?Q?OyW2Sbqm6ts6OnsRA6RIQBJikyvRpH6o/HTVr11GVv2lFxcuINX9LzC2EAjk?=
 =?us-ascii?Q?MOd9ih96Q5SAfgJICPAdvnQWWWmeFPaadrzt2KcfUCetw9CzipaZdKjh/seI?=
 =?us-ascii?Q?+Iae7l2W7+KgACclgiNRe1xan+ANgvR0Kkd89sch04nGandvBSIa7M3NzIkc?=
 =?us-ascii?Q?LoabgQPqKJYNXNMRlpmi1a0i/PC4jMb0Kxaba7qLXX2adYSiAP+V3GUWAWpH?=
 =?us-ascii?Q?AkaMtG4wy7ZEdUCwT3nvhbabHQ6d+d4O991nIa/iLVc5RqI6po9syYH74pUH?=
 =?us-ascii?Q?KhZYJaSRLucmhi215nQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91827fa5-2658-4000-0dc8-08d9f72d5773
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 00:33:56.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU1cyzpK9I8Xknhxc/eKvFEVTHHdFzfKZU1BF5miJM7JiYKdPwAdxUaYQYcEPhkJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3462
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/23 22:55, Forza wrote:
>=20
>=20
> On 2/23/22 13:28, Qu Wenruo wrote:
>>
>>
>> On 2022/2/23 20:17, Forza wrote:
>>>
>>>
>>> On 2/23/22 12:10, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/2/23 18:30, Forza wrote:
>>>>>
>>>>>
>>>>> On 2/23/22 11:06, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2022/2/23 17:01, Forza wrote:
>>>>>>> Subject:
>>>>>>> Crash/BUG on during device delete
>>>>>>> From:
>>>>>>> Forza <forza@tnonline.net>
>>>>>>> Date:
>>>>>>> 2/23/22, 09:59
>>>>>>> To:
>>>>>>> linux-btrfs@vger.kernel.org
>>>>>>>
>>>>>>> Hi!
>>>>>>>
>>>>>>> I am running a test system and experienced a hard lockup with the
>>>>>>> following message:
>>>>>>>
>>>>>>> [53869.712800] BTRFS critical: panic in extent_io_tree_panic:689:
>>>>>>> locking error: extent tree was modified by another thread while=20
>>>>>>> locked
>>>>>>> (errno=3D-17 Object already exists)
>>>>>>> [53869.712825] kernel BUG at fs/btrfs/extent_io.c:689!
>>>>>>>
>>>>>>> Kernel: 5.15.16-0-lts #1-Alpine SMP
>>>>>>> CPU: Xeon(R) E-2126G
>>>>>>> MB: SuperMicro X11SCL-F, 64GB ECC RAM
>>>>>>> Broadcom 9500-8i HBA SAS controller
>>>>>>>
>>>>>>>
>>>>>>> I had 5 SSDs in a RAID1 filesystem and wanted to delete 3 of them.
>>>>>>>
>>>>>>> # btrfs device delete /dev/sdf /dev/sdd /dev/sdd /mnt/nas_ssd
>>>>>>>
>>>>>>> When about 6GB was left on the last device I got a kernel BUG=20
>>>>>>> message
>>>>>>> with stack trace. Unfortunately the message was not saved to=20
>>>>>>> syslog -
>>>>>>> anything trying to access the system disk froze, even though the=20
>>>>>>> "btrfs
>>>>>>> device delete" operation was not performed on the root filesystem. =
I
>>>>>>> managed to get some screenshots of the trace.
>>>>>>>
>>>>>>> I performed a hard reset and the system booted normally. A scrub=20
>>>>>>> showed
>>>>>>> no errors and a new "btrfs device delete /dev/sde /mnt/nas_ssd/"
>>>>>>> finished without errors.
>>>>>>>
>>>>>>> Attached images (wasn't able to send them to the list):
>>>>>>> https://paste.tnonline.net/files/ISD0z6LNqw5D_Screenshot2022-02-230=
83359.png=20
>>>>>>>
>>>>>>
>>>>>> =C2=A0From the stack, it looks like related to chunk discard optimiz=
ation?
>>>>>>
>>>>>> Can you provide the code line number of btrfs_alloc_chunk+0x570 and
>>>>>> add_extent_mapping+0x1c6?
>>>>>>
>>>>>> Better with the code context.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>
>>>>> Hi Qu,
>>>>>
>>>>> I could only make the two screenshots as the system was frozen and=20
>>>>> logs were not saved to disk =3D(
>>>>
>>>> No, I mean using linux/script/faddr2line to resolve the code line=20
>>>> number so we can have an idea on whether it's chunk discard=20
>>>> optimization or something else.
>>>
>>> I setup the Alpine dev environment but unfortunately I don't think I=20
>>> am getting an expected result:
>>>
>>> alpine-devhost [~/aports/main/linux-lts/src]$=20
>>> ./linux-5.15/scripts/faddr2line build-lts.x86_64/vmlinux=20
>>> btrfs_alloc_chunk+0x570
>>> no match for btrfs_alloc_chunk+0x570
>>>
>>> alpine-devhost [~/aports/main/linux-lts/src]$=20
>>> ./linux-5.15/scripts/faddr2line build-lts.x86_64/vmlinux=20
>>> add_extent_mapping+0x1c6
>>> no match for add_extent_mapping+0x1c6
>>>
>>> alpine-devhost [~/aports/main/linux-lts/src]$=20
>>> ./linux-5.15/scripts/faddr2line build-lts.x86_64/fs/btrfs/btrfs.ko=20
>>> add_extent_mapping+0x1c6
>>> add_extent_mapping+0x1c6/0x2b0:
>>> add_extent_mapping at ??:?
>>>
>>> alpine-devhost [~/aports/main/linux-lts/src]$=20
>>> ./linux-5.15/scripts/faddr2line build-lts.x86_64/fs/btrfs/btrfs.ko=20
>>> btrfs_alloc_chunk+0x570
>>> btrfs_alloc_chunk+0x570/0x9a0:
>>> btrfs_alloc_chunk at ??:?
>>>
>>> (I did also run on the hosts actual unzipped /boot/vmmlinuz-lts and=20
>>> btrfs.ko.gz)
>>
>> OK, this means the kernel and modules are stripped, without debuginfo.
>>
>> Is there any debuginfo package provided from your distro?
>>
>> And since you mentioned in your report that, the fs passed scrub and=20
>> device remove works fine later on, I guess you can not reproduce the=20
>> bug anymore?
>>
>=20
> I got the Alpine kernel sources and added CONFIG_DEBUG_INFO=3Dy. Now I ge=
t=20
> the following output. I hope it is relevant.
>=20
> alpine-devhost [~/aports/main/linux-lts/src/linux-5.15]$=20
> scripts/faddr2line fs/btrfs/btrfs.ko btrfs_alloc_chunk+0x570
> btrfs_alloc_chunk+0x570/0x9a0:
> create_chunk at=20
> /home/forza/aports/main/linux-lts/src/linux-5.15/fs/btrfs/volumes.c:5341
> (inlined by) btrfs_alloc_chunk at=20
> /home/forza/aports/main/linux-lts/src/linux-5.15/fs/btrfs/volumes.c:5434
>=20
> alpine-devhost [~/aports/main/linux-lts/src/linux-5.15]$=20
> scripts/faddr2line fs/btrfs/btrfs.ko add_extent_mapping+0x1c6
> add_extent_mapping+0x1c6/0x2b0:
> extent_map_device_set_bits at=20

OK, this is indeed chunk discard optimization causing the problem.

@nik, any idea on this problem?

Thanks,
Qu

> /home/forza/aports/main/linux-lts/src/linux-5.15/fs/btrfs/extent_map.c:36=
2
> (inlined by) add_extent_mapping at=20
> /home/forza/aports/main/linux-lts/src/linux-5.15/fs/btrfs/extent_map.c:41=
3
> (inlined by) add_extent_mapping at=20
> /home/forza/aports/main/linux-lts/src/linux-5.15/fs/btrfs/extent_map.c:40=
0




>=20
> Thanks for having patience!
>=20
> Forza
>=20
>> Thanks,
>> Qu
>>
>>>
>>> Thanks.
>>>
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> *=20
>>>>> https://paste.tnonline.net/files/ISD0z6LNqw5D_Screenshot2022-02-23083=
359.png=20
>>>>>
>>>>> * https://paste.tnonline.net/files/DR2pgh8bVHCZ_iKVM_capture.jpg
>>>>>
>>>>> Thanks.
>>>>>
>>>>>>>
>>>>>>> https://paste.tnonline.net/files/DR2pgh8bVHCZ_iKVM_capture.jpg
>>>>>>>
>>>>>>> I can do some further tests if needed. otherwise I need to deploy=20
>>>>>>> this
>>>>>>> system in about a week.
>>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>>
>>>>>
>>>>
>>>
>>
>=20

