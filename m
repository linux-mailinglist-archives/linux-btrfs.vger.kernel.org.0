Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409506F0252
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 10:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjD0IGx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 04:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0IGu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 04:06:50 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A112D71
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 01:06:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjqtmui0JDXYlpSj7Kn2d7T7jQu6076chrSAMXkTRRjlKehdrEdMlP8fB2nWJ6teqZ1Icl/2DsdnDeRSxhtuVFmV1JHXt7HIMCe2DTj22gIgfXGA89mqTO49LheTOErSmdhszqe9zXYtctpAZNILnsFSrf6mXd8GznNxkShToUnC1KbIANG0ul1TkPv9S40MYrsq7sWjE9JBPTEmCGP8K59ZjZR9a8GHEk6MUa17Ds/W29ywI+/Gckl2VYEFiqEPwLbY1V+0a+YRRFPySfMN+Be/fbJXjZ9L+/jvQvTwsA0dp2wwb4T8co1eOlVynlaacatR7nynK9Lncbu+QFKTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skaQ5cfL/wi5I6qjCSUDgU9U7B5Xr4WtoDvR/YuJeN4=;
 b=a2tpsWejR+DZykJj0v6yY91mtBnCv0bocC1+aC+s5tbuhQRjIoonSvjccifK3ksxdrn99+QBgCskO6iR3vYzmRM4Q4pw3LwRlfjIeWVirL3UPKDn521MvsvOmKc0lDter8jYG8MaHsZkBVHhCKfUz8MUiJilHCn0euT1Glz5ce+7JoBaknHJPvTjPNJpwOjSt9PluEkP+Zo6eH/wWPZGSUtlnuOl3SwLVqvX4zVp13IP9zWcWsqEUWAF+Oy0ro4D6osQRiOe3kzOTdZUvvExLZD1bAXK9EPJRCGzc/cfKsYhQz/ajsqjcw0kzcCUIGJmwJY0bmC7qrsncvN8199FFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skaQ5cfL/wi5I6qjCSUDgU9U7B5Xr4WtoDvR/YuJeN4=;
 b=0G00IBJlJpWh7dYySnutIfY+pBnXbZ2ttTeIf3Vf4o5Hq8JBe9wQnd5kp5o9lCQMrK2AiN6rLDbcWftVtfl9ZPFldULB/U6vLRba29ebmP2ICSMB5srglShH/fzXcRgGE6JRznW40SOeSETRpIgU6PBMJoZHR7jvIroJnEd5MFGfw7FHdAxyls/LW392RdsF9F2ioVREzGt3YptXibTRfbjz8gdfQ/hcpHpVLdOJsptdmguOFDlEPk/tJKzkE7BlUvoe+eFe2wrMpG0Z4DbZ0jfGauE8d5hj4wGhr4oNUOPIz4p4Qc1gqGblp4fvma9mNF2H2SOY/XSjQgEeircBKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS1PR04MB9309.eurprd04.prod.outlook.com (2603:10a6:20b:4df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 08:06:44 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 08:06:44 +0000
Message-ID: <89a6ede0-a043-ed11-016f-37f866f17e1c@suse.com>
Date:   Thu, 27 Apr 2023 16:06:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Failed to recover log tree
Content-Language: en-US
To:     Igor Raits <igor.raits@gmail.com>, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@gmail.com>
References: <CAH2U3KrVYroUyJi-xBTmtEm+bnkz4DjEzdcZqG-=X=333b3HHA@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAH2U3KrVYroUyJi-xBTmtEm+bnkz4DjEzdcZqG-=X=333b3HHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0372.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::17) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS1PR04MB9309:EE_
X-MS-Office365-Filtering-Correlation-Id: 29733a53-e3fa-44ad-d671-08db46f6572e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qe8n9hXWTY1PPqnYLdw5+WVdEdChlEvtgBlil44T6epW/cq7ZrPDvzxj8B8m9H3PM9O5kj/Eq8qFKV6YgLEgk8nJTbuTr1jTG2P+z0w5Hi+SsvNpx/IBd/pivCfcbtRciwae+cm7ibcEzFWPMjFFMfVm5SqxDBv1tvhAOoln4vTcu+I3ScC+c5YrnEemQPYkgvC39yaYDbU1WOaezCqWgK+g+I8CF7Pce2dBFHHg4tCqEHchLgj85C6eTTPq80+ejJ0S+6izAjMb7ao74bcKXfz6Y1Uv5M1gV5yi/uZt35O+MYv5QFQwoPgY80zW9O5SHAc2C432jyNB5dEYqwNvyV/qDfVX9lgm1haY/jt5HZbJ+LEdNHH6T0rnhefoaY9VmbRgq8rWZFY6Vp8RkNsVyqYUOhkvgMteyHTtDTTrT31RxSdJGyBAnToxtG2ZIv/TfqbIVqSCgwl+B9B1lbqjvpTL2n1KlvtokfvlWdYJWrL5SVSTcmHAw8oumwqSM/inuufTRZGE2CMrenOU/4eGHz5Bs5Zl47qXbY42gnBTiiD53x9PXfsv73yfWTGmC/ADfPUhEfyAkqct+W0LVo1SWPvBlrQA6Ax4O285dB04nTuZnnumsgLT0SyTqTnMBGU1IFV/Fb806IsGuIBO8nOtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(6486002)(6666004)(478600001)(83380400001)(2616005)(110136005)(6512007)(53546011)(186003)(6506007)(30864003)(2906002)(66476007)(66946007)(8676002)(41300700001)(66556008)(8936002)(38100700002)(86362001)(316002)(31696002)(36756003)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXZPVHM2cGE3R3FjY3FlamdjcnBibjdFNTNNR3pYRXhMeUw3SGZsQStvaU90?=
 =?utf-8?B?RHRiVW1hZUxMcldSSG5nZnd4T2E0VDlOZnVvMWdlRVFnKzRaMDhVNHlmSTUw?=
 =?utf-8?B?Y3hWSDRWcW4xL1l3TmpKOElqNEMrbFphdVhvWmhDNE84c1hJeGdRZmtLTzlE?=
 =?utf-8?B?UDA4a05qdmhKK29COUtPVmhzRGU2K3hmMU5EeWJWWkFEWVgvSzVrQnhHUUVM?=
 =?utf-8?B?azA0RVRmc3JsR0FTbGl4ekxUL3NCQmZYckNGOVFRNnZaNTRCS1BpR0xKVzRy?=
 =?utf-8?B?RXJ0MG8rWmI1UUR4Z3M3MStNbUNNd3pnRCtnSTkyQitnRlM4dnQycU00SWx2?=
 =?utf-8?B?UkU2bTVWQUo4RksxZXVWQUkyNURBODdIaFVIeFVmWjk4Qk9oMFhTU0RCNW9I?=
 =?utf-8?B?MG03QUJVYTB6QkhnUGVuWDNMZVhFYkRkVE90VkNab2RCK2w4L0t1TXJTU0FW?=
 =?utf-8?B?L1huU3RPejY0Qmc0WUh6dGVsOVQwdGNxTkJicHFUR2p0L29zNjRkN2JpTlhm?=
 =?utf-8?B?SWRqazNDQ0R2VGh6WTZKOEY2UGpzR1I4TFpSYzR0T003WGhZdmp2RVBDRzBK?=
 =?utf-8?B?OXNId1I1VXZ0T2VrZTlUZnZWM1E2blB1YW5JaFF6U2E2N1BmRVRUeEM2Yk5P?=
 =?utf-8?B?RlJLdFZvUVE4ejhNYWtyOVdFeE1Lb0E0cnljaG9aeTlZdEdWYjRaSW5hWXUv?=
 =?utf-8?B?UG83a1gyZXBVbjd5T21mMkpUaCs0dUZKUFJwQVB1Y0pLRnk2QUpHRjJxaTFr?=
 =?utf-8?B?Zm16clQrSVBNVDFORUoySUVPMU9QbnNVNHZCd0FvQUJSYm5PWThMTk1FR0Vp?=
 =?utf-8?B?UEpqcGlTWFk2TGszNUVVMnl4cXR6Wm54K3JzTjFCVDl5ZTgrZVV0Zzkzank3?=
 =?utf-8?B?T3FuOFUyT1RSNzR6Ymd5TFFHU1FDWWpESi9iYmF3WTcyYWZFdnNWV1grR3NY?=
 =?utf-8?B?NmFUeU5ucnpmcmVxR1VPeXJ2NzkzeDNzVDh6ek0wN1oxakZxdnljTmlYYlhD?=
 =?utf-8?B?MTdJeTF1cU9IWWRINlFlZGo0N3VnbnNUVklGcTVrdzRsRGI0dnNSWjdEbWJT?=
 =?utf-8?B?Tld3Q0NlbmdYUFI4UWliVEN2ekZsL0NWR2t6cmNyYzBmVXhzRjBjS1FmeFQ2?=
 =?utf-8?B?dERzYWxZUVVDaW9rRGVqdEk2KzYwbTVrSVkxY1duM0xma1lWNFNNbysrNHJz?=
 =?utf-8?B?WEw3azNaZDJSazUxcmVDeG1zcnBaaUlMcWQzYVFSSHB1N25HQStZWXYxYzdE?=
 =?utf-8?B?NXdveTg4SHZ6RFVLTTZNWlJ3eVhUbFlQZ1VycEp4Nkp6MWFaek5ud0NMZ2Zm?=
 =?utf-8?B?NzE2d280ODA1aVkzWnJXUFZYaTVoNkNWVGtaUFhQL1gvRCs5clZFVy9hRkNh?=
 =?utf-8?B?anQ2L005K2lSekZNd2ZJc25rNWZGZ3hmOEtvaVR5d0ZGcEhWaTNNVitTa1FV?=
 =?utf-8?B?QjFBM1R6REh5RExkUG04aHptTlRGN2ZLVTJZbXIzeHZTZkc2dGJMSzIvMnc2?=
 =?utf-8?B?K1BMQ2F3OUd5VVYvSnpGVzZ4dDYxL1B5RXZwMGZuTVZkTFYrNzBNQlZNQzU5?=
 =?utf-8?B?OE1ndFZDSUtsa2ovaVNhOWwrSG5WbjAyTjBOZWRMRmJucUxNNWZQS1NOTlBN?=
 =?utf-8?B?VW5mTmhrL2EycndBSHVZc09rT1J3U0lNQzg3OCtZMGFMSEJheWt6Z3c3MGtV?=
 =?utf-8?B?Z29yZHh0aG9rWkxTY0JScUd3bEdRc3VwWjVoNWNCcnFaQ1V0dG5YcjlXbW1p?=
 =?utf-8?B?Qk1tOGRyUHhMYWRXV3VOVUNlVU5hSy9tTkJYZGNRbWsveGpsams0aXNPeWx1?=
 =?utf-8?B?b2c4RzdOdlYrQmJOejYrZnJNWng3ZUJFN0V6MUxSN3paNHdlWnR2MSsxWElU?=
 =?utf-8?B?UGFPbmN0NEhNYno1QldKa09jcnNHaFF6QlNRVWw3aUdTck9FREhMMXVNNE56?=
 =?utf-8?B?MDBYK1lZc2RiMmwyenB1eGZPcDU0dnlrVlp1M2xGa3Z1K3h0QXpoUVRyRFE3?=
 =?utf-8?B?NXdMNjBCWlV4OXV6QXdNMGRSVUpnSE1GUzNCTlViTk5rczJoUTJvZ0k4bUlZ?=
 =?utf-8?B?R0tMUW1ZLzVtN2dkK3FMVkplRzNHWVA1QUk0RXZMQzZPL1N0Y2NwakpNaE1T?=
 =?utf-8?B?VWRFeDBQdUdZMXlaaGFiWkRobjFPYjFjUWZjdnFuK3RuSEZleUFlV0h1WnAv?=
 =?utf-8?Q?eHLTVJrC6hF1g4Jtvg0chds=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29733a53-e3fa-44ad-d671-08db46f6572e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 08:06:44.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oUzXKLKfATTGz25gxB6ctjzBaQ3M7pEHc7wO1Lgm3JvcOOWNNmP2n9WKJnJwYL0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9309
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/27 15:06, Igor Raits wrote:
> Hello,
> 
> We are using btrfs on some of our VMs and after some bug somewhere,
> kernel has crashed and the VM had to be rebooted. After that, 1 out of
> 4 drives was not able to mount.
> 
> I've tried a few commands but that did not help to recover it (I did
> not run btrfs check --repair yet).
> The kernel is 6.1.18 and btrfs-progs 6.0.2 compiled with the
> experimental flag (as we used that to use block-group-tree).
> 
> Could you suggest some steps for recovery other than btrfs check
> --repair to try out? Thanks in advance!
> 
> # mount -t btrfs -o recovery,ro /dev/vdf /mnt/ebs/minio2
>   kernel:BTRFS critical (device vdf): corrupt leaf: root=5
> block=3562706763776 slot=17 ino=407482430, invalid nlink: has 2 expect
> no more than 1 for dir

This looks interesting, meaning a log replay leads to an extra reference 
on a directory, which is invalid.

On the other hand, your btrfs check shows everything is fine, thus the 
directory in the subvolume tree is completely fine.

>   kernel:BTRFS critical (device vdf): corrupt leaf: root=5
> block=3562706763776 slot=17 ino=407482430, invalid nlink: has 2 expect
> no more than 1 for dir
>   kernel:BTRFS error (device vdf): block=3562706763776 write time tree
> block corruption detected
>   kernel:BTRFS: error (device vdf) in btrfs_commit_transaction:2447:
> errno=-5 IO failure (Error while writing out transaction)
>   kernel:BTRFS: error (device vdf) in btrfs_commit_transaction:2447:
> errno=-5 IO failure (Error while writing out transaction)
>   kernel:BTRFS: error (device vdf: state EA) in
> cleanup_transaction:1958: errno=-5 IO failure
>   kernel:BTRFS: error (device vdf: state EA) in
> cleanup_transaction:1958: errno=-5 IO failure
> mount: /mnt/ebs/minio2: can't read superblock on /dev/vdf.
>   kernel:BTRFS: error (device vdf: state EA) in btrfs_replay_log:2395:
> errno=-5 IO failure (Failed to recover log tree)

This means there is something wrong in the log replay code.
Maybe the log tree has something weird.

Mind to dump the log tree?

# btrfs ins dump-tree -b 3766932537344 /dev/vdf

>   kernel:BTRFS: error (device vdf: state EA) in btrfs_replay_log:2395:
> errno=-5 IO failure (Failed to recover log tree)
>   kernel:BTRFS error (device vdf: state EA): open_ctree failed

Although the workaround should be pretty simple, "btrfs rescue zero-log 
/dev/vdf" should fix it.

But please consider not to zero the log until we have collected enough info.

We may still need extra info even after the above dump-tree output.

Thanks,
Qu
> 
> # btrfs rescue super-recover -v /dev/vdf
> All Devices:
>      Device: id = 1, name = /dev/vdf
> 
> Before Recovering:
>      [All good supers]:
>          device name = /dev/vdf
>          superblock bytenr = 65536
> 
>          device name = /dev/vdf
>          superblock bytenr = 67108864
> 
>          device name = /dev/vdf
>          superblock bytenr = 274877906944
> 
>      [All bad supers]:
> 
> All supers are valid, no need to recover
> 
> # btrfs-find-root /dev/vdf
> Superblock thinks the generation is 3595442
> Superblock thinks the level is 0
> Found tree root at 3424157040640 gen 3595442 level 0
> Well block 3424059916288(gen: 3595435 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3424054345728(gen: 3595434 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3423941132288(gen: 3595431 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3423913361408(gen: 3595430 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3423724224512(gen: 3595429 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3423618924544(gen: 3595428 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3423522717696(gen: 3595419 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3423509741568(gen: 3595418 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3423381946368(gen: 3595417 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3423254937600(gen: 3595411 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3423190253568(gen: 3595410 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3257715638272(gen: 3595407 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3257566904320(gen: 3595404 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3257494061056(gen: 3595402 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3257426460672(gen: 3595401 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3257354846208(gen: 3595400 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3257189138432(gen: 3595398 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3257066291200(gen: 3595397 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3257054314496(gen: 3595395 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3256925880320(gen: 3595390 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3256790237184(gen: 3595384 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3256747343872(gen: 3595379 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3256734842880(gen: 3595378 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3256726290432(gen: 3595377 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3070848090112(gen: 3595376 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3070762254336(gen: 3595369 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3070533402624(gen: 3595366 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3070520950784(gen: 3595365 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3070319542272(gen: 3595364 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3070275878912(gen: 3595355 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3070224957440(gen: 3595354 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3070133649408(gen: 3595348 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3070109827072(gen: 3595347 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2889425747968(gen: 3595340 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2889301147648(gen: 3595339 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2889314811904(gen: 3595337 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2889158066176(gen: 3595332 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2889076523008(gen: 3595330 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2889007906816(gen: 3595329 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2888883896320(gen: 3595328 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2888770060288(gen: 3595326 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2888474230784(gen: 3595325 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2888414789632(gen: 3595324 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2654316625920(gen: 3595323 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2654292000768(gen: 3595322 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2654178476032(gen: 3595321 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2654046437376(gen: 3595317 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2653815832576(gen: 3595312 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2653688217600(gen: 3595311 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2653640425472(gen: 3595310 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2503985594368(gen: 3595309 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2503770832896(gen: 3595305 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2503679131648(gen: 3595304 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2503542685696(gen: 3595300 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2503440711680(gen: 3595297 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2503322124288(gen: 3595294 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2503168000000(gen: 3595289 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2503054426112(gen: 3595288 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2503041384448(gen: 3595287 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2503445053440(gen: 3595285 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2412690669568(gen: 3595284 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2412570755072(gen: 3595281 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2221267697664(gen: 3595278 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2221141753856(gen: 3595275 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2221038993408(gen: 3595270 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2220922290176(gen: 3595269 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2220743933952(gen: 3595266 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2220618924032(gen: 3595264 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2220595019776(gen: 3595263 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2220507889664(gen: 3595262 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2220364578816(gen: 3595258 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2220268486656(gen: 3595257 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2220199788544(gen: 3595256 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2220125945856(gen: 3595253 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2220104859648(gen: 3595252 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2219941019648(gen: 3595246 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2219772805120(gen: 3595245 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2219676188672(gen: 3595243 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2219385782272(gen: 3595242 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2219322032128(gen: 3595239 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2219298471936(gen: 3595238 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2219189157888(gen: 3595234 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2219168301056(gen: 3595233 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 1725089398784(gen: 3595229 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 1724993929216(gen: 3595224 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 1724703211520(gen: 3595223 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 1724590768128(gen: 3595214 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 1124192288768(gen: 3595206 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 1124086104064(gen: 3595204 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 1123955785728(gen: 3595198 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 1123796860928(gen: 3595188 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 1123702702080(gen: 3595181 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 1123696197632(gen: 3595180 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 1123421716480(gen: 3595178 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 1123298459648(gen: 3595171 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 409090146304(gen: 3595168 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 408798691328(gen: 3595166 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 408693866496(gen: 3595163 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 408471683072(gen: 3595160 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 768655360(gen: 3595159 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 508542976(gen: 3595157 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 426082304(gen: 3595153 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 275447808(gen: 3595143 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 158154752(gen: 3595138 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 3069995843584(gen: 3594572 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> Well block 2220640256000(gen: 3594469 level: 0) seems good, but
> generation/level doesn't match, want gen: 3595442 level: 0
> 
> # btrfs inspect-internal dump-super /dev/vdf
> superblock: bytenr=65536, device=/dev/vdf
> ---------------------------------------------------------
> csum_type        0 (crc32c)
> csum_size        4
> csum            0x50cf7576 [match]
> bytenr            65536
> flags            0x1
>              ( WRITTEN )
> magic            _BHRfS_M [match]
> fsid            261534ef-b111-4056-8124-6dd207030548
> metadata_uuid        261534ef-b111-4056-8124-6dd207030548
> label            minio2
> generation        3595442
> root            3424157040640
> sys_array_size        129
> chunk_root_generation    3581791
> root_level        0
> chunk_root        25460736
> chunk_root_level    1
> log_root        3766932537344
> log_root_transid (deprecated)    0
> log_root_level        0
> total_bytes        5498631880704
> bytes_used        4346997747712
> sectorsize        4096
> nodesize        16384
> leafsize (deprecated)    16384
> stripesize        4096
> root_dir        6
> num_devices        1
> compat_flags        0x0
> compat_ro_flags        0xb
>              ( FREE_SPACE_TREE |
>                FREE_SPACE_TREE_VALID |
>                BLOCK_GROUP_TREE )
> incompat_flags        0x371
>              ( MIXED_BACKREF |
>                COMPRESS_ZSTD |
>                BIG_METADATA |
>                EXTENDED_IREF |
>                SKINNY_METADATA |
>                NO_HOLES )
> cache_generation    0
> uuid_tree_generation    3595442
> dev_item.uuid        1d32f1a0-6988-4ed4-b3cd-24d243baf975
> dev_item.fsid        261534ef-b111-4056-8124-6dd207030548 [match]
> dev_item.type        0
> dev_item.total_bytes    5498631880704
> dev_item.bytes_used    4820052213760
> dev_item.io_align    4096
> dev_item.io_width    4096
> dev_item.sector_size    4096
> dev_item.devid        1
> dev_item.dev_group    0
> dev_item.seek_speed    0
> dev_item.bandwidth    0
> dev_item.generation    0
