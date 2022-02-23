Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADCE4C12B9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Feb 2022 13:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbiBWM3W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Feb 2022 07:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbiBWM3V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Feb 2022 07:29:21 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1C599EFF
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Feb 2022 04:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1645619331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+kRzRkHiIvjb7Rlms1KkvmH6c3ZSQAJv6I/D/QmZuo=;
        b=jrdb34mwv9IxkeV1xXsXV+1wn63iaNm47cmx2/neNcYf93XyFzeJGzpzXwKdPqPe3EbRqb
        5wzC44jCYUk25tJzCZyRrly3mNNDjwfc4DFLSvoaprALZ02v9G9JcZWQbvmrUq5g0sVe0g
        kcnNRZk2RG3YQ0G5VgU8vOoUBb8kmxo=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-V3BTUfXhP92DYNRK9f8SWw-1; Wed, 23 Feb 2022 13:28:50 +0100
X-MC-Unique: V3BTUfXhP92DYNRK9f8SWw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaGmfHzjtE6pIDArsX5qGPTsvlBxtzBTqqL5vQMl0YB3OvVP93+2WFxN+n4hG7BPNkjfYlkWtrju2fu32Y6BTytHm7f5KMYOWoDypGKzyOKc6aMn4Qtx+3wvAuwBHDtdBUEDJ/2qOgV58aDXG2Wvq4JZi0wBGOY+dMKujGay2BeaaomZAmJExCokr9TD8zwwfEPdj6EQW49Zxhja3AfKxCldDwDTVnIirSXEty30TC4aWmRmdN8gkOoc7vO2o2qAdQD48rPKrG4mlKKlCyGlCKe12WAFbOouBb9C19QCIXf6kywSk2WI/gFq9DytXRseh4ggYhIUNjpyBPNQnB/ZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OCGKnkpZTF4GkjonIdCtJH+Jj34khmlUA/CZ5oLCcI=;
 b=F8siHJwfQVCsx1rlGogxGUKdyR615STmLFuogiPQt1ZbyqfNJz2cJzV480w2yxrLVDhJAFFXBhrUhWZTY60/K3JTEvQjsC3+Ttg+S+iAhWkZyUK99PYIBzsoVJ4x5cexwICccVDFzRJWIcxH9yNi5iSSL+lQQ9AyN5Uruul1B/RpiXveAiPEPqHgOKFI6o7bVIWPDpgPrH107laArm5zw00zCJWIs85R+e1QEtVEjuw1/WUTj15zCfE+w3yTO011S77E36y81me+rHuRJ6oIg527NUw6isNjzeF4O/4GUjqmLcdvJ1HftqGNiUFh9NvzyVNVuUsoyNLQcgeAAOUWzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by VI1PR04MB7039.eurprd04.prod.outlook.com (2603:10a6:800:12b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 12:28:49 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 12:28:49 +0000
Message-ID: <90be0040-74f9-29fa-4552-57f45dbf0a86@suse.com>
Date:   Wed, 23 Feb 2022 20:28:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Crash/BUG on during device delete
Content-Language: en-US
To:     Forza <forza@tnonline.net>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <c574966a-4b9e-0a50-cb47-e6f904f95eaf@tnonline.net>
 <4e094239-c987-8b1a-bc56-b4252481fbaa@gmx.com>
 <feada357-9340-0ec3-4899-91b7351d17ad@tnonline.net>
 <3c25d70c-43fe-cf38-33f8-05e35ceb03f0@suse.com>
 <b964eb55-537f-dab4-e8a0-1326d5ee2c67@tnonline.net>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <b964eb55-537f-dab4-e8a0-1326d5ee2c67@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::48) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5a7690c-6cb3-4ee7-5e8a-08d9f6c80b05
X-MS-TrafficTypeDiagnostic: VI1PR04MB7039:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB70394C63C4A9077BAC9CE94DD63C9@VI1PR04MB7039.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ln8fnjOw9d1sh3hZwzzj7fDqBZJ3LJ0KAd7gsT4pP8zcgrG9PLj9Op039hojMV4oP6YY0dwFaCC7pf2O+c64/hfptqd6AsIbxn1BpKGKn0SPyT46OnUSZ5PoAYoJ35JOrIYeuWau2C+JQp0+QAC/KKsx4VHvLEM1CMgmlY0a7yn0vF9p2bYEUSjVs/wuYITQ8PzjJwJ5bDuL7JCM8fM59KlhmklPvhz9MBRc5IJQGW7KDNRh5nipeahAaMbqYotiqSKEsikrTIa07ZZ1VxtvqHVIi1nh4aJifsACSn0ZzdHXtpuy0Bv3Pd9reXF+jftpLGGnCtlcX4EE4CYlwivwtkOPnmF0O+yGC2X8gBgwSWHcU/8pdvjcGoNl2cOyfY4ewlrA+6DxcR+6qp9UEYsQXBTqIfNsD5EFqOyXAcqEGOwyxXuQFK5GytXSz77IwFc9L2RCjbAb16rONp8CZD3L82AD1XV6I0vmn0DO8LRbvfst0yM4a5ok/8x74oHkJV2eWyd/QA2Yb6mEyRLMcvQ5jm1DgJ5fbyISSQ4oLTos8jFglAkBzztrmivYbcqKZL7JJGBoQFtYfGpuaWOPO5NiaFEernX15+hgjR1AY9AqZPWZOBVUN5kQqBQx2u3SmiUpiiS2NefIrEHS/sSJG7fsIQqtINMfKiq2L6GiXHuTBxYI4r59YHpBw6q/8m3PaNnHacwyVJmjb3NEKVXibyvvHOsWFN5dkXk3KXz5151iyEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(186003)(2616005)(53546011)(66476007)(6512007)(66556008)(66946007)(83380400001)(6666004)(2906002)(36756003)(26005)(31696002)(31686004)(38100700002)(316002)(110136005)(966005)(6486002)(86362001)(508600001)(5660300002)(6506007)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MTd1sYk5MLsbEp2t9h2/jxwomYQ1iOYRFPywmnMsW0AObLDEXukcmOuu1r+K?=
 =?us-ascii?Q?NtPTwEhQGMje3IHvnGrMnbdhCK7p3IXOkrNjm7IrKdvn9UUZ7khg8nZBLQhN?=
 =?us-ascii?Q?SJGvHfRLeg8xL1oCcu44cL5/MNQxZg+WMJLc/dt4od2yYIE//Hj37B/hlXxk?=
 =?us-ascii?Q?gnc0e4BKmNmivc2lQAEkNmbs9YZRiRXGVAwihj4fl3jCDiTv8OkpfHsU+QtE?=
 =?us-ascii?Q?3o/c+n06bWBsoBSkyPfy0cn9JAsxaEaFH2xWLdFdHQP16Az8lx8vkzYa0p/g?=
 =?us-ascii?Q?A99OfOWvYi+vGsVsPWzR6OUc6KzD/6M47bIQ+VSrcw8F5HH90968q1WpNGGj?=
 =?us-ascii?Q?CrhAtIht+gYxY8fzMJo3qg1FmXS5ICSZqIVuyF/y/6UDz7dUxuhTyRrgJ66s?=
 =?us-ascii?Q?SfeELYSTtGG3FeA01svby0zPtqOYB7gkeSkXY/zfdFn3tlKnBB4Y7yw39nqz?=
 =?us-ascii?Q?H9s7OcJ5PbHrZ+PwjezZKiwcEMZK3nqztP3UN5lA/zZZ/moalCkidzI1DnaB?=
 =?us-ascii?Q?Qzo+CdL48W+5En1nd4O78SpXtqYyA/jHTqrdZtaWwZuyKJI443zW0ueIF3TP?=
 =?us-ascii?Q?R1X9/kOr/fXxsMNP43uAwiXeDQJ40wR4/IzbNLsAiKuJ63d6fd8uSKL0uvcg?=
 =?us-ascii?Q?zUTTmr9+MX9VgCGuPvvPOQ3eVfxaMd1CbYSTsKglBhNGoSH13Km/vGNpiHyB?=
 =?us-ascii?Q?mld84JkjS8V+eHV0zSrhfS3/4r6fVOb4lNuy4pkl/Mra+v5iotSDjcYTYQ2+?=
 =?us-ascii?Q?rX5k1m8qHKRdJ02cMlTn8PPiHT/y8m6+2mu6h3hiz6W3JqIwi3sEnyOb5D7k?=
 =?us-ascii?Q?Y7o5bUBCwlL4ldYOugeVeBhLtuGgzKeB/yBMb5yfyfz1BXOEiT9qTm2SwBVi?=
 =?us-ascii?Q?kDCwie30KOaihaMgg8zEokafF6EMYTGxG0E8yV+Z7qCX9nGxVDSja8hMVFnD?=
 =?us-ascii?Q?8rcedB9TEqnv4EXXbH3o74FbV588ZtOw5VMxSknvWGUAUpEW+i8jGD6+xEiR?=
 =?us-ascii?Q?trBYnTvLkJHf8p3ow3qArPpFpNz5h2I/VkbDN4umvTbaFtMHT6LmgSEwBggE?=
 =?us-ascii?Q?bMGsniOtYE+zxN8d0coU83epv+hITMWtyYRvbGUAhOFLC5X0QYQek4AODG/v?=
 =?us-ascii?Q?243rAjPVYE+I08iZpcKKa/xb8tl7+TBtE/2lfl4JldJLd0XFiL6j9C26l4zW?=
 =?us-ascii?Q?ehqY8odoUpEt0/ewSiI4shQs1lMRHqDTRi1KlTNEKTM15e4opsjQVxHfqQcF?=
 =?us-ascii?Q?Sl2H9iF9QlVmf+F319eF6Mv8QQZPHZJ8AffYGd5RJqIOX1HqD/M3OC7jSU11?=
 =?us-ascii?Q?OydARMP59O5LKNKO33EkYiYprH8Dj3wrUP492Gq+Ncg5DYqtM7k64d4fV5AX?=
 =?us-ascii?Q?zUjdff9LzOZDCMh5xb7n1NbWDjXLK+BDWS512ZQk4IxgGDEMtFHErmqtqc/0?=
 =?us-ascii?Q?gBGjVcu+O209FYAZ5g04lgdrTJ31MwJsdh833JWa+2iqMMX1BD6papbVbkWo?=
 =?us-ascii?Q?dXFiyKwIreh1LcYNxPDw40XlsCAgCo7EX75C0pA4dIzNLP7fqeNsClWJ5pF9?=
 =?us-ascii?Q?bFuxraGpXeyVChpT5NM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a7690c-6cb3-4ee7-5e8a-08d9f6c80b05
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 12:28:48.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4flSGZgwVuny3BDf5M9nUScUHe47gKSdMuRRpMlN192Kg301L+HHNE6UoqQnud9E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7039
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/23 20:17, Forza wrote:
>=20
>=20
> On 2/23/22 12:10, Qu Wenruo wrote:
>>
>>
>> On 2022/2/23 18:30, Forza wrote:
>>>
>>>
>>> On 2/23/22 11:06, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/2/23 17:01, Forza wrote:
>>>>> Subject:
>>>>> Crash/BUG on during device delete
>>>>> From:
>>>>> Forza <forza@tnonline.net>
>>>>> Date:
>>>>> 2/23/22, 09:59
>>>>> To:
>>>>> linux-btrfs@vger.kernel.org
>>>>>
>>>>> Hi!
>>>>>
>>>>> I am running a test system and experienced a hard lockup with the
>>>>> following message:
>>>>>
>>>>> [53869.712800] BTRFS critical: panic in extent_io_tree_panic:689:
>>>>> locking error: extent tree was modified by another thread while locke=
d
>>>>> (errno=3D-17 Object already exists)
>>>>> [53869.712825] kernel BUG at fs/btrfs/extent_io.c:689!
>>>>>
>>>>> Kernel: 5.15.16-0-lts #1-Alpine SMP
>>>>> CPU: Xeon(R) E-2126G
>>>>> MB: SuperMicro X11SCL-F, 64GB ECC RAM
>>>>> Broadcom 9500-8i HBA SAS controller
>>>>>
>>>>>
>>>>> I had 5 SSDs in a RAID1 filesystem and wanted to delete 3 of them.
>>>>>
>>>>> # btrfs device delete /dev/sdf /dev/sdd /dev/sdd /mnt/nas_ssd
>>>>>
>>>>> When about 6GB was left on the last device I got a kernel BUG message
>>>>> with stack trace. Unfortunately the message was not saved to syslog -
>>>>> anything trying to access the system disk froze, even though the=20
>>>>> "btrfs
>>>>> device delete" operation was not performed on the root filesystem. I
>>>>> managed to get some screenshots of the trace.
>>>>>
>>>>> I performed a hard reset and the system booted normally. A scrub=20
>>>>> showed
>>>>> no errors and a new "btrfs device delete /dev/sde /mnt/nas_ssd/"
>>>>> finished without errors.
>>>>>
>>>>> Attached images (wasn't able to send them to the list):
>>>>> https://paste.tnonline.net/files/ISD0z6LNqw5D_Screenshot2022-02-23083=
359.png=20
>>>>>
>>>>
>>>> =C2=A0From the stack, it looks like related to chunk discard optimizat=
ion?
>>>>
>>>> Can you provide the code line number of btrfs_alloc_chunk+0x570 and
>>>> add_extent_mapping+0x1c6?
>>>>
>>>> Better with the code context.
>>>>
>>>> Thanks,
>>>> Qu
>>>
>>> Hi Qu,
>>>
>>> I could only make the two screenshots as the system was frozen and=20
>>> logs were not saved to disk =3D(
>>
>> No, I mean using linux/script/faddr2line to resolve the code line=20
>> number so we can have an idea on whether it's chunk discard=20
>> optimization or something else.
>=20
> I setup the Alpine dev environment but unfortunately I don't think I am=20
> getting an expected result:
>=20
> alpine-devhost [~/aports/main/linux-lts/src]$=20
> ./linux-5.15/scripts/faddr2line build-lts.x86_64/vmlinux=20
> btrfs_alloc_chunk+0x570
> no match for btrfs_alloc_chunk+0x570
>=20
> alpine-devhost [~/aports/main/linux-lts/src]$=20
> ./linux-5.15/scripts/faddr2line build-lts.x86_64/vmlinux=20
> add_extent_mapping+0x1c6
> no match for add_extent_mapping+0x1c6
>=20
> alpine-devhost [~/aports/main/linux-lts/src]$=20
> ./linux-5.15/scripts/faddr2line build-lts.x86_64/fs/btrfs/btrfs.ko=20
> add_extent_mapping+0x1c6
> add_extent_mapping+0x1c6/0x2b0:
> add_extent_mapping at ??:?
>=20
> alpine-devhost [~/aports/main/linux-lts/src]$=20
> ./linux-5.15/scripts/faddr2line build-lts.x86_64/fs/btrfs/btrfs.ko=20
> btrfs_alloc_chunk+0x570
> btrfs_alloc_chunk+0x570/0x9a0:
> btrfs_alloc_chunk at ??:?
>=20
> (I did also run on the hosts actual unzipped /boot/vmmlinuz-lts and=20
> btrfs.ko.gz)

OK, this means the kernel and modules are stripped, without debuginfo.

Is there any debuginfo package provided from your distro?

And since you mentioned in your report that, the fs passed scrub and=20
device remove works fine later on, I guess you can not reproduce the bug=20
anymore?

Thanks,
Qu

>=20
> Thanks.
>=20
>=20
>>
>> Thanks,
>> Qu
>>>
>>> *=20
>>> https://paste.tnonline.net/files/ISD0z6LNqw5D_Screenshot2022-02-2308335=
9.png=20
>>>
>>> * https://paste.tnonline.net/files/DR2pgh8bVHCZ_iKVM_capture.jpg
>>>
>>> Thanks.
>>>
>>>>>
>>>>> https://paste.tnonline.net/files/DR2pgh8bVHCZ_iKVM_capture.jpg
>>>>>
>>>>> I can do some further tests if needed. otherwise I need to deploy thi=
s
>>>>> system in about a week.
>>>>>
>>>>> Thanks.
>>>>>
>>>>>
>>>
>>
>=20

