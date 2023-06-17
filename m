Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C10733E65
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jun 2023 07:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjFQFbN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jun 2023 01:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjFQFbB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jun 2023 01:31:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEFA1FF5
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jun 2023 22:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGenjoXpHLY77YPGfO8fNXWRvc60atm4du1r0Sd5cHHX5QhFtWgVYIqTwBh4nZ9QG46/IMVfyrTSE6KQslrEr8a2ptVEsR20uzdAoDWsvRZ48dvr+tbtPrUcLfOPVLjQ2PtZxmzC0QPi/DwoLEuJP42gDV/IoA3FizR5GEVFXpCFPCSQ0m9jnJvSI7Meoft/Am53gUu6F7l0UuTq/XG2vNv0ntiSu9MmJIADQoOYQDjSbs9g0t4Qqu1PB5hvlc1Ls3GyJCQUh0CTZXQfHwRL+zTo1wGqaGj3Rp9o2GJ0z0sd0qQsPHzEpM6shohjXEk3yrRsT2prixs2gpDkUXrKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pA/0LzO40xYZ1/5Weks3S11sBMOWxRbHU2HkWnNzkkg=;
 b=Qr9yZI/L6PVft8V+S15CeVzXpF6Uv9pPaTFjl6WR2qQiKLj73qh++5uPljL4G/vJgyKJB2J3ci4QViqWENkxiX4bTmF8v9pg7V5M6i16jspD4N70DUF7emvw7D5QqVWM5lKI3/tk6MsHc4dvn154NasfUemj5xvhkD/R0xMkjZlUUzeneMUNDm46tooBbDs+TqxDRX88XolCkzNAUY69HzHobhl44+75biDysSGt0Ux7+m5/jtZMa4t7HuJdAkwxAOr8LbCNPki4NqWKyYXRqCEEhv5YHqz9RnRtyIco4oyi1s4flqh/V2i72LbjK7tiGnWCS/DD1vgsjddJp8wRKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pA/0LzO40xYZ1/5Weks3S11sBMOWxRbHU2HkWnNzkkg=;
 b=YAB3/HPdEfHpDZ/Lgs/uH3G2IQxZewBStzT3LIgv/x9Ol+zOv2ZIHCxeRzyijt7endWI7vbBIdnleNToYaDA337NEj2IzDwudZmdLoXEaTvttUAVLDfBmgdZu3CwtHVhdD7Ii979HKzxFAKid7+Fprvi23R8VKv04+f16wPv562C+WOuwy5JEhh8OViypFyyLSvZooyZiLcjM7BvrbTeDJN4eUOl/9/CC7ftccfFm12ErVkovB26f3Uf7Cdh8sWyePM1u7OGWeol6B1z4AHGbjDYDplgSxeIChobgbNND1lByvfllVNQTCNU3Kp3bj2pORrv6xDpRe/2+MNztgl1Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DBBPR04MB7705.eurprd04.prod.outlook.com (2603:10a6:10:209::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Sat, 17 Jun
 2023 05:30:51 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6500.025; Sat, 17 Jun 2023
 05:30:51 +0000
Content-Type: multipart/mixed; boundary="------------xAJFbzdSIf8iX7ZDiB9RAwIf"
Message-ID: <403c9e19-e58e-8857-bee8-dd9f9d8fc34f@suse.com>
Date:   Sat, 17 Jun 2023 13:30:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Stefan N <stefannnau@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com>
 <1ee0e330-1226-7abf-44bc-033decbe43e0@gmx.com>
 <CA+W5K0ow+95pWnzam8N6=c5Ff61ZeHyv7_yDK0LG6ujU48=yBA@mail.gmail.com>
 <40ecba88-9de2-7315-4ac5-e3eb892aac39@gmx.com>
 <CA+W5K0qLN3SaqQ242Jerp_fiyBw407e2h_BEA9rQ45HU-TfaZA@mail.gmail.com>
 <SYCPR01MB46856D101B81641A6CE21FB99E55A@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <CA+W5K0oKO2Vxu3D2jOLET1RrM=wOxTEH2a_uH1w44H2x9kT2tQ@mail.gmail.com>
 <16ab1898-1714-a927-b8df-4a20eb39b8cd@gmx.com>
 <CA+W5K0pm+Aum0vQGeRfUCsH_4x8+L3O+baUfRJM-iWdh+tDwNA@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: Out of space loop: skip_balance not working
In-Reply-To: <CA+W5K0pm+Aum0vQGeRfUCsH_4x8+L3O+baUfRJM-iWdh+tDwNA@mail.gmail.com>
X-ClientProxiedBy: TYCPR01CA0137.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::13) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DBBPR04MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c94bfe-974c-4ff0-7c23-08db6ef4036a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZEnufRM+rGyk+QZp8wnTqJK5fj6QKFHEnow+gxicb7zicU7qJAdNLWdzN0RNdjRalrlWywjuGUqN4YGvR1MvkiW0agkxdyWPBO6gyQdwiv2A8IV5IH5Gp+/mmAEvNHDBPHx3CFroJt90KGHdrwHnGyscTU+8XRvlhDjmDaAMXjjJLW3+klnDYbWQX/ZqZ1icMsgaoG7n9mh9OANe+vRJBhiUHLLlcYXGnYuG7StBI0pPDqk0L5MPvUionBy5VPsjrlMzbGesB7rwf2+VMsC5E5DaZqGUU0bl5pfWB40T96iQ95JhJ7fF1qCRBdvUF8mAqzQty4I97qOEfTbYcr/TwBkA0U3UgQZPODrHKt6/Kt+3p+UpvOrr/Wq1LzwOFJIZEoOj5wtYBE+cLDqi+Wyz2Z3IL+zsSgbbocnoL7ygVYk2mx8rxOe6k7Eqjug+wXo1jf648OcozbsYvDYu8uaC/nE7aDw3Pe4Ej8mid7W2V+/ZYLwjVE9q9dfJsrPkwF2fnFc7a3uXTM38W8t+dEZeTZ1T48//TnYQB9uYmvWy0ahQYu2X2x5mNzyPHjWZasV7+5YVM8ifUis7i+HFeGMKzisuEw9PXmJwmGkW/HOGWcmNdEFD+pg36m091z3O4nNfqNvK0rwZQbMRU0LoT9ly09fAmNgsvYLtgDTy6NLYJ62Sz6C49ZSHdPK9GPPcQHKa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(478600001)(110136005)(33964004)(6666004)(6486002)(235185007)(8936002)(5660300002)(8676002)(2906002)(36756003)(41300700001)(86362001)(31696002)(38100700002)(316002)(66946007)(66476007)(66556008)(6506007)(53546011)(6512007)(186003)(31686004)(83380400001)(2616005)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ukp1dDgxdVBoT3JmVnlMazZQRk4xY1JEa3FTaEtaMllpemtYVE9NVkd5SXg3?=
 =?utf-8?B?c3V0Rk84Nzh0Q1hHSmhmTENTL1ZjTEh4YUNWTUNQeFJUUEhxQWlMeDZZdWhx?=
 =?utf-8?B?MzNuVk5zVlJUdVd2UFdEQ2NobkZKRWhuWnlkQmtPYVBkcWhmcnBBbkxkNUUr?=
 =?utf-8?B?cURqZDdCSEpBR0l0WWVnbmpKRkx0elU0VDY1WjNGbzk1TU9nZnBWNmQ5TkFG?=
 =?utf-8?B?QkFhOWJpOGpaMlZFbldONjNjSGpkakNvcXdhRG9RTmNuOGZrd3JaYkJWMDU1?=
 =?utf-8?B?ZHNwcS95QmwrRUllQmE2RXdFMy9TaVRrNGl0TG9NSFBIT1dIOHFJZXJWUkdI?=
 =?utf-8?B?cHRvT0lGTCtlWDZIVjU3TkNkc2V2R0gyL25DVHhPaGxkdXZPSzE0SFpFWitZ?=
 =?utf-8?B?SFRoOUZuT01uRFZlUjA3Y1VGOHhoVkF3a0JPdWJrYmczdnlWRjRBMW5NUjhU?=
 =?utf-8?B?K2tTV29raGZQSURhOXM2TzZyTlpKNkNLT2lUNTJrZG5mMWtKT3VaRUJrZGlT?=
 =?utf-8?B?NVBBTWZ0eUd3RG56a2NoT1N2UzJnSVg0QUpldVEwRjZac2NZdmdaTms5YW5z?=
 =?utf-8?B?NkE3Q2FCNXlNR2Nxa1ZSQW5FU2JBdWFTUVZuZkhVY3FMOFlKbEYwY0Y1MjQv?=
 =?utf-8?B?RlZoVjdDdmwweVJteExsRWdubVR1SEJNWE1WZCtQS2dtRVd1cXBya2pieERS?=
 =?utf-8?B?UEYrR0o0d25BMm5Vd1RpRHZOVjY2eHIwdmZmWkdUazZ4REdyM0VYaWNYSjBZ?=
 =?utf-8?B?UFRZT2RDS0t2dWlMZEJTdXErd3R4ajRiOHhYL3FiOG0xVXlEV24wQXh1Q1pY?=
 =?utf-8?B?MS9jd1BOWENRMzhPYVRwTnBBWXY1RjVTYlBrVmd4NXRma1JWcW4xZnVlN2wr?=
 =?utf-8?B?SHlWNCtLOHY2NnBDbXBOa3BjRFA5NFN0MGZHNkxxNnFrZGwwRGxLN04zMXdt?=
 =?utf-8?B?TTFqZ1FxaUxSUjVSU2lZMDd3ZTkxWTFOdmsvUjNiM2gxeXRvRS9GWUpxZm1I?=
 =?utf-8?B?UE81SFE4N2o5ZlZOVkRvcDUxTkRURlZPbVJhNU5oMG54MUIyN2VsZlpsZDR5?=
 =?utf-8?B?T0xDM1huNDZpcWtPWkZyYmRvVkVIQzJCRStoR1pnK1IrVExRRTBnSHhMSHR3?=
 =?utf-8?B?ZVZTSkNuNWFhNkxwMzcwNHNmYmVLQ0VVTUpxd3RIREdiQzJ3d29OdTdKREVF?=
 =?utf-8?B?dUd0VjFyRFZ4aHZUUVhDSnZaK3FDWnh5b2VnUEhISG5QbVUxQUVacVcyRFh5?=
 =?utf-8?B?d2tTK1ZJd0xJK1FQRnJjSU0xcE02cjdBOUwyTUcza0RubEYwQmhDS3BTeDg1?=
 =?utf-8?B?VXIrRzdKSC9lV295Zmd2RjBSalZVQW5WdFdyaHNJRzZHZ2xLdzkxWG4rTFhX?=
 =?utf-8?B?T3lnMVF6bVhtbDhOM2VvbFZKeUtIdWtjUGROeUlYelY1YklrSXhCVGxqQURr?=
 =?utf-8?B?UGJYamVSbk5rTDJxeTV5QStNVGhIaG1UZDE3WjNFd2RlRW4xOGRUYlZxcGJD?=
 =?utf-8?B?Q1M4Q3lCZlMrMDlZbUZROTNwTDhCRW5KY2dFZWRXazNIbXQvd1RucS9mY1I0?=
 =?utf-8?B?OEtWcUNabEdza2ZlUUtVOXZvanB0VmJqUFZsQ0U2NFlDWlVNZmRoTGV2OWhu?=
 =?utf-8?B?YzRNRXlEa3NzVnhIT3QvVmJwZTVDSzlZTGYxOTdNcGRTcDRtWWNPQ2F3QTVZ?=
 =?utf-8?B?ajNuVzVaQ01Qd0ZYVGlPbFR2OHVhY3BkbTBmQ1lkekI2QjBiNlZhOFI1VWN2?=
 =?utf-8?B?czZpTEFrN2Y2eEYrRG1YeEp4WW5JY1NCM2NwYUJtZ1h1NlVRWkJ5ZlBUeUFT?=
 =?utf-8?B?ZGhJTGw1UmFFME50TkRCcTFUbnhOdHpvenZ0blpoVXg4WHphemV1aU9BYnNL?=
 =?utf-8?B?R3VQS2hCSmJ5QmNseTdkajIrSXZGc1I2SFFhOGtnM1lSME9lSHk3TzFyUEJw?=
 =?utf-8?B?SHc4c2d4MEQ0LzZ5QkZvZWtoQWt4Tmk0NUZtOFpJVkErdU9hNzVJUWxvMk5S?=
 =?utf-8?B?aDZLY25TUC9IRFNqSVNZS1N4QWVVbk05cml2aXdQQ3JZS1IwU0RCb3l3ZzlY?=
 =?utf-8?B?bXhOeTgzaU50OEtNMU5vY0psTEJvTFV3WGpiUEZzNUM1T1NDZUNOTDNSUDUy?=
 =?utf-8?Q?IoTRBVC18+ckzYRQhhGiPpxt1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c94bfe-974c-4ff0-7c23-08db6ef4036a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 05:30:51.5238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGr2BiFz6d2MgEDT1a8gvtKHPE59QtkJ6EF+eT1y7E/Q7QEmurU4MVn3iltQCf4A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7705
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--------------xAJFbzdSIf8iX7ZDiB9RAwIf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/6/17 13:11, Stefan N wrote:
> Hi Qu,
> 
> I believe I've got this environment ready, with the 6.2.0 kernel as
> before using the Ubuntu kernel, but can switch to vanilla if required.
> 
> I've not done anything kernel modifications for a solid decade, so
> would be keen for a bit of guidance.

Sure no problem.

Please fetch the kernel source tar ball (6.2.x) first, decompress, then 
apply the attached one-line patch by:

$ tar czf linux*.tar.xz
$ cd linux*
$ patch -np1 -i <the patch file>

Then use your running system kernel config if possible:

$ cp /proc/config.gz .
$ gunzip config.gz
$ mv config .config
$ make olddefconfig

Then you can start your kernel compiling, and considering you're using 
your distro's default, it would include tons of drivers, thus would be 
very slow. (Replace the number to something more suitable to your 
system, using all CPU cores can be very hot)

$ make -j12

Finally you need to install the modules/kernel.

Unfortunately this is distro specific, but if you're using Ubuntu, it 
may be much easier:

$ make bindeb-pkg

Then install the generated dpkg I guess? I have never tried kernel 
building using deb/rpm, but only manual installation, which is also 
distro dependent in the initramfs generation part.

# cp arch/x86/boot/bzImage /boot/vmlinuz-custom
# make modules_install
# mkinitcpio -k /boot/vmlinuz-custom -g /boot/initramfs-custom.img


The last step is to update your bootloader to add the new kernel, which 
is not only distro dependent but also bootloader dependent.

In my case, I go with systemd-boot with manually crafted entries.
But if you go Ubuntu I believe just installing the kernel dpkg would 
have everything handled?

Finally you can try reboot into the newer kernel, and try device add 
(need to add 4 disks), then sync and see if things work as expected.

Thanks,
Qu
> 
> I will recover a 1tb SSD and partition it into 4 in a USB enclosure,
> but failing this will use 4x loop devices.
> 
> On Tue, 13 Jun 2023 at 11:28, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>> In your particular case, since you're running RAID1C4 you need to add 4
>> devices in one transaction.
>>
>> I can easily craft a patch to avoid commit transaction, but still you'll
>> need to add at least 4 disks, and then sync to see if things would work.
>>
>> Furthermore this means you need a liveCD with full kernel compiling
>> environment.
>>
>> If you want to go this path, I can send you the patch when you've
>> prepared the needed environment.
--------------xAJFbzdSIf8iX7ZDiB9RAwIf
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-btrfs-do-not-commit-transaction-when-adding-a-new-de.patch"
Content-Disposition: attachment;
 filename*0="0001-btrfs-do-not-commit-transaction-when-adding-a-new-de.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiNTViMzgzMTUwYTE4NWQzNjdkZDNiN2E4MjBkYmUxZWZjNWNmYzlkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8YjU1YjM4MzE1MGExODVkMzY3ZGQzYjdhODIwZGJl
MWVmYzVjZmM5ZC4xNjg2OTc5MTYzLmdpdC53cXVAc3VzZS5jb20+CkZyb206IFF1IFdlbnJ1byA8
d3F1QHN1c2UuY29tPgpEYXRlOiBTYXQsIDE3IEp1biAyMDIzIDEzOjE1OjMwICswODAwClN1Ympl
Y3Q6IFtQQVRDSF0gYnRyZnM6IGRvIG5vdCBjb21taXQgdHJhbnNhY3Rpb24gd2hlbiBhZGRpbmcg
YSBuZXcgZGV2aWNlCgpUaGlzIGlzIHRvIGFkZHJlc3MgYSBFTk9TUEMgc2l0dWF0aW9uIHdoZXJl
IG9uZSBoYXMgdG8gYWRkIG1vcmUgdGhhbiBvbmUKZGlza3MgYmVmb3JlIGhhdmluZyBlbm91Z2gg
c3BhY2UgdG8gY29tbWl0IHRoZSBjdXJyZW50IHRyYW5zYWN0aW9uLgooSW5jbHVkaW5nIHRoZSBv
bmUgdG8gYWRkIGEgbmV3IGRldmljZSkuCgpTaWduZWQtb2ZmLWJ5OiBRdSBXZW5ydW8gPHdxdUBz
dXNlLmNvbT4KLS0tCiBmcy9idHJmcy92b2x1bWVzLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9idHJmcy92b2x1
bWVzLmMgYi9mcy9idHJmcy92b2x1bWVzLmMKaW5kZXggZGY0MzA5M2I3YTQ2Li5iOGY2OGQ1OGY0
OTggMTAwNjQ0Ci0tLSBhL2ZzL2J0cmZzL3ZvbHVtZXMuYworKysgYi9mcy9idHJmcy92b2x1bWVz
LmMKQEAgLTI3NzMsNyArMjc3Myw3IEBAIGludCBidHJmc19pbml0X25ld19kZXZpY2Uoc3RydWN0
IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sIGNvbnN0IGNoYXIgKmRldmljZV9wYXRoCiAJCWJ0cmZz
X3N5c2ZzX3VwZGF0ZV9zcHJvdXRfZnNpZChmc19kZXZpY2VzKTsKIAl9CiAKLQlyZXQgPSBidHJm
c19jb21taXRfdHJhbnNhY3Rpb24odHJhbnMpOworCXJldCA9IGJ0cmZzX2VuZF90cmFuc2FjdGlv
bih0cmFucyk7CiAKIAlpZiAoc2VlZGluZ19kZXYpIHsKIAkJbXV0ZXhfdW5sb2NrKCZ1dWlkX211
dGV4KTsKLS0gCjIuNDEuMAoK

--------------xAJFbzdSIf8iX7ZDiB9RAwIf--
