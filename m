Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A786F027A
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Apr 2023 10:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbjD0I0h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Apr 2023 04:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjD0I0f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Apr 2023 04:26:35 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2084.outbound.protection.outlook.com [40.107.104.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FE549D5
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Apr 2023 01:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5qIU7tDPoty0l9FngEtUAEvLbkbphiF9ez7HZJk/BLTfNBijnPUJZcPMCRYDINUL4QaXXvGk/9vMI6qROsgPRilPQm1vdWRmiZ2P4HYvDmFwG5fA4b9lj8M1kYLV4JoaLPUS4vlRRYd9tpWpRgBx2e8ueeXfvz/KImZVJrmM9+seQkm8mdNyNdRrdrnP1EBPrPVjsrkPW9eJz5si2jFvne2Q92sAB7bH/KDPEozQCyJ7obw2Z7T1aDlBLQgFfonALSB5HN+pTBFUFDO7AacNVpfPREYF6ewTZozPJicL3mAtulp6Bx+u8fN4vq0qJadr9zHg4/fiAzfpVSjIb8O8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aziXhwRJ2l95gdWRRDaLtETy60i0RbpVf+qBnS2ZBlY=;
 b=ECoRm1OYo0Evut387gI+QwdiDEr3ZqnwLN5c5Pc2HVdTRjstdMcANfs5CEuQbHOY6FP2c4fs+qA3OazLbF2nbvmWRodqDrxhuTlHLO3oY3sYJR3Sd/YFGwXW2z5r5Lkxrvuag57Mn+gd1pOJB7GTOH6fjQwId4IsTmDv+AvVSrDLcmjxlb/ctTRm5ZXRq9JKbapYfkDa2SuDzgP61FU++rEUaU6cE5KUwI7Y/eD8M6BsmYR4DAQbLkM8bhA7ptfW1JDku8hX9xptdXPiEZiGLS5bf+Kkfoqh+ZipJ5F/LdyXuafGTY5fJfn33DHO+KVGjJql1LfW59XRqVMeQu1bxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aziXhwRJ2l95gdWRRDaLtETy60i0RbpVf+qBnS2ZBlY=;
 b=tjE12qQLLydgVtk0NbnUHha0zLJ/mQ55g9q178URd92NyJOiF/42wdMIjM1H4L48WBW3trHymxXCn3A7EvWJQWOm1SnLOVG4Q25voYjhlwFjnw2rXkTzKGR8DJ/vW5tBTyLH5t7QCefdAqlIJXb7+RCevFFvD2X5+ak3Rt6ZE/wX/I42jLO4M+O+fOFr8NbymFMvG5kDYvdBs9nqolM3RlSGTti8WE0Ro4vcg+eHsys031Tto/6lkL1tq/uNfiIES2CnCyvXt1A+7XhhMgGqZTtf8VRQc/QrBGDqgUfiVdrsZ0sN5QMOFxZre559Aon+epVN0hPI44Gh1LB3U+BIIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB9224.eurprd04.prod.outlook.com (2603:10a6:102:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 08:26:28 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 08:26:28 +0000
Message-ID: <6d7e779d-64e4-cbfc-ecb7-cc73399accf4@suse.com>
Date:   Thu, 27 Apr 2023 16:26:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Failed to recover log tree
Content-Language: en-US
To:     Igor Raits <igor.raits@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@gmail.com>
References: <CAH2U3KrVYroUyJi-xBTmtEm+bnkz4DjEzdcZqG-=X=333b3HHA@mail.gmail.com>
 <89a6ede0-a043-ed11-016f-37f866f17e1c@suse.com>
 <CAH2U3KrN4Dhm7QTxfCXA=P1B59kDduYcDH8wK7HRrwdAqb_x9Q@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAH2U3KrN4Dhm7QTxfCXA=P1B59kDduYcDH8wK7HRrwdAqb_x9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: d709b3c4-5c58-40c8-c894-08db46f9189d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEvYOxRczT18pEwW8VDUKHtoskdYVogQSE6tcZvvupu1O/e7QRRCbjrPhuTeRnylmWV6mKqrs4KBaZ5d+MOscUkCx5tnrQ8AILsV7Cc6btiSqktJPFd8nukInJiGNPRbEXYM3TRYTrK9xJmbWAIV7EWYhKuP5CU0VdU8x6cXVRSOi/oEIhrHoTCoYAPU5nShQyUuHx8EmOC9Xqd9qX4QSykssk600+jJcdmlLfzUglUAk66eZsB2yQtjRBa3hXQ1fkYzh5cm8sGfyqoFe+Tt4XYPJBQ1QwEgyGhPpwfOS3Bz1awPSCKLE3dEErTGiCKHNCHwglY7Sb4eMhbfNuCv8uRqq8ZmSSXuztOeKOF8Bem3VzjLOzGeW+oOBWzyueq3tqznyMONIvKlD5JG0F+K46GRl0p7rjdMBUfUIYX43QWKKZhZuzEXtX+qzyPN3ZJkJhPoB2ALAaa23XTCVVumyo4rsOqgaLzZ43yAI3Agxe1OrxA9Q9M1nOjpJE16n+/qvUuOKQZSWplP0Q6jDzXGShqNkXzX1JiBZf/ClMV0ksjsn2FVWu9MtONULvwws8WApFpG4IloXqCqzDSK/qnMVA52hQ/U+6fuRESrxCCtxc3G8nTqbceogOKRYiQ9Iz034V3WcJnRcx9Rft0ioPDKhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(31686004)(2616005)(83380400001)(41300700001)(53546011)(30864003)(6506007)(186003)(6512007)(2906002)(36756003)(6486002)(6666004)(31696002)(86362001)(5660300002)(8676002)(8936002)(316002)(4326008)(6916009)(66476007)(66556008)(478600001)(38100700002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTlZQ3hOMmcxWmhLR2dhanhxa1cyZkNEc3lxZjE2U2RrUHF3bVdaV1FiOUN2?=
 =?utf-8?B?R0s2MmdSa2g3TkFxOFdpOVZhdnVJV0lCYUM1SzhFQ1BKc1hLZGRkTmZOVjFG?=
 =?utf-8?B?aUZRcS9CU2NDajRNUERTRTNCZDJidWFOZnNjNEpOK3pGOHYrR0dtL3lWek80?=
 =?utf-8?B?TWk1SHhIM1BhU0xoQjVDMUREMmRqZ1E1b2pBOW5FeDF6YUdrTkg1Mng5VWtw?=
 =?utf-8?B?TlA2YjhjMWt4YVB5S3FDVUtsZ08vNkx0bVRxZndNdWtBVTdia0RCbkpZS2Rq?=
 =?utf-8?B?MVNHNDBzMi9SS0l1a2JlWlloL3FqMkFDSDlzZHNqNzJCTXhkVkFFaHAyMHZu?=
 =?utf-8?B?K21BT0pCcld2KzdBUHg0ZmlSS3NoRjVoL0FvQW9GUjdoQVBQWUJnU3cwWk5Z?=
 =?utf-8?B?aWhwVnhvMEdmR0t5cGdVSkhjblpFaE8vdCtSUVh2VkVlOG5rVGtNMGt0NEsv?=
 =?utf-8?B?RUwwYkxrRFhrRC9xM2xnU0RRcjdJYVlwcnEwRnBsY3MxejJ0blBPRjZwRFNm?=
 =?utf-8?B?S0xrU0lBOGJhVXYrRzJHT1psd2ZzT3Z6Mno3QnpJc2xRcStLM3lFZ0NtK0xL?=
 =?utf-8?B?NlcxQ1BUb3hybWNNdnhGTXJNbDVzQURVcWdPRkxyREhmZ1MrZlhBdGVuSStH?=
 =?utf-8?B?ay9VOGs1NHMvenF3SEJIWEhxYzB6ekk4L1pRWDVwMkVzTnR6TWdwcE5XQksy?=
 =?utf-8?B?cERVL0hPQ2dtSGZ6UUhhNTVxUlVhTWFEdDBqQ3M2clozdm04UFBzQ3QyLzA3?=
 =?utf-8?B?bU55Q3pZVE9KREtNeHYrWFNCanVEc2R6bXZPMy9sUWpvcTNyR0pSRFhCazlD?=
 =?utf-8?B?ZFR4MnhtOGJBWWpoTlZscTREVnBlcUZCODZPKzFXNzVsQUtraTRyVFFTUUx6?=
 =?utf-8?B?VHF2dHl1alBuWVFBZ1NuKzdnYTRrWWpQeW5yVzRPTHBjb2pvMzFLMC9nVkhP?=
 =?utf-8?B?Ty9SOFE0MjI4WW8zUnFibDd3ZzJtQUk2eWNkMTV4a1daeW5nTjBnVWU1U3hL?=
 =?utf-8?B?cE9kY284U0x1UnJzSjhuVU9KQ1U1OWhadXVYN01uM00rdXpGMjJYenBNMC9P?=
 =?utf-8?B?LzNIdnRvRlgySnBNa1pTOHdmcnBmZVdmMDBlQ1FpVGM3UUlUVG1HdlRjOXF3?=
 =?utf-8?B?bCthTGtrVTNBS3dOVDhmeTVHYVlsSCtBYS9vQWFheDRFcy8rNW5yZGZlWkdi?=
 =?utf-8?B?QWE2MEM0TDc0Qi9tTE9uOTIzK0c5TEowVzZpV0hsZTBZcFprSFlvWTByS1J1?=
 =?utf-8?B?eHkwM25FSDgvQTMxR0haWGZZbVgvNWRyenFPYzRubk5wdVRmaGNLUUFOMXI0?=
 =?utf-8?B?SEttMUNIeG1sYzFmeDEwUTZ1OHZNekNlclRXZEZjSGVHMHpYclVWZERCbjYr?=
 =?utf-8?B?UEtaOGU0enovUitLR2VidVBKWGNVZXhqZXBIc1ZySnRqbkNPYU5sMUQyL1ZX?=
 =?utf-8?B?eC9ncndwR0NJU25EUU43SnZoREJUa09pbWdLYU82bWJHVUk1VEYzN0N1VWxy?=
 =?utf-8?B?UlVBS084TWp1WEkrWWpPTTc2dVZpWXk5WnNWa1kxYVA4cmRxZzczRFVMZGFk?=
 =?utf-8?B?dUU1MmJzUU5JSWdpNWtydkJYRDR6UksyT2lDd2xIMjFxRE5LanE0ZVh1SGdu?=
 =?utf-8?B?TzNEanQvUXFwQmxycWpMYUtxSFBYYlo1UDR4eVFjdWRLWHdrQXY2LzAvVm44?=
 =?utf-8?B?ZTl1aDVCUGEwbldaTEVWN1pSOFZ4NzNjalJHODFaWEpsWWdNalRjR21TYXdP?=
 =?utf-8?B?cmZubFZsUVVrWVZzZzJEQmdyNFdzeldyR1F2a1c2RjdkdFBCbTIwUmdTOXNo?=
 =?utf-8?B?Wk1uczBneENtbUgvRWN6amE0QytDM2hxMkhXeWNpdlBYRXkzTkJjUmI2VVdu?=
 =?utf-8?B?ZVJEM1luaHY3TkJ1clMyTG4yWVdvMEYzNEhncG9yR1ZSYW8xNlUyaDY1ejNE?=
 =?utf-8?B?YUNoK0I1cCtMMWNDUUFFeWYzeUZURE5XUkhPMzBSS3NVVVZLNTcvMVZwamJo?=
 =?utf-8?B?NXlweVdCUTRoajU0anNmdUtRYk1mVk5hSWxETHlaVEh6QVdoQS8rNC93Q2Er?=
 =?utf-8?B?eUdoZ0hyRHBscjRIbE8vNWdpUEV4eTBSTDhQVlo3SElaN0xLWHV6UmdObXR5?=
 =?utf-8?B?V0VUZ1hibDJ5VS9DM0xxdlBKcGhtV2NEUlRBVU93cHVXNExWcTJSdW1vT0I3?=
 =?utf-8?Q?UBZok9iaqRoMtdVGeRjrfPI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d709b3c4-5c58-40c8-c894-08db46f9189d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 08:26:28.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZ6F7aTxpYty/xok+gZPinAlYXT+cQSDcHH7sJ+YIF7MuotiUlXjlvRJWCwZf1Uz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9224
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/27 16:19, Igor Raits wrote:
> Hello Qu,
> 
> On Thu, Apr 27, 2023 at 10:06 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> On 2023/4/27 15:06, Igor Raits wrote:
>>> Hello,
>>>
>>> We are using btrfs on some of our VMs and after some bug somewhere,
>>> kernel has crashed and the VM had to be rebooted. After that, 1 out of
>>> 4 drives was not able to mount.
>>>
>>> I've tried a few commands but that did not help to recover it (I did
>>> not run btrfs check --repair yet).
>>> The kernel is 6.1.18 and btrfs-progs 6.0.2 compiled with the
>>> experimental flag (as we used that to use block-group-tree).
>>>
>>> Could you suggest some steps for recovery other than btrfs check
>>> --repair to try out? Thanks in advance!
>>>
>>> # mount -t btrfs -o recovery,ro /dev/vdf /mnt/ebs/minio2
>>>    kernel:BTRFS critical (device vdf): corrupt leaf: root=5
>>> block=3562706763776 slot=17 ino=407482430, invalid nlink: has 2 expect
>>> no more than 1 for dir
>>
>> This looks interesting, meaning a log replay leads to an extra reference
>> on a directory, which is invalid.
>>
>> On the other hand, your btrfs check shows everything is fine, thus the
>> directory in the subvolume tree is completely fine.
>>
>>>    kernel:BTRFS critical (device vdf): corrupt leaf: root=5
>>> block=3562706763776 slot=17 ino=407482430, invalid nlink: has 2 expect
>>> no more than 1 for dir
>>>    kernel:BTRFS error (device vdf): block=3562706763776 write time tree
>>> block corruption detected
>>>    kernel:BTRFS: error (device vdf) in btrfs_commit_transaction:2447:
>>> errno=-5 IO failure (Error while writing out transaction)
>>>    kernel:BTRFS: error (device vdf) in btrfs_commit_transaction:2447:
>>> errno=-5 IO failure (Error while writing out transaction)
>>>    kernel:BTRFS: error (device vdf: state EA) in
>>> cleanup_transaction:1958: errno=-5 IO failure
>>>    kernel:BTRFS: error (device vdf: state EA) in
>>> cleanup_transaction:1958: errno=-5 IO failure
>>> mount: /mnt/ebs/minio2: can't read superblock on /dev/vdf.
>>>    kernel:BTRFS: error (device vdf: state EA) in btrfs_replay_log:2395:
>>> errno=-5 IO failure (Failed to recover log tree)
>>
>> This means there is something wrong in the log replay code.
>> Maybe the log tree has something weird.
>>
>> Mind to dump the log tree?
>>
>> # btrfs ins dump-tree -b 3766932537344 /dev/vdf
> 
> leaf 3766932537344 items 1 free space 15819 generation 3595443 owner TREE_LOG
> leaf 3766932537344 flags 0x1(WRITTEN) backref revision 1
> checksum stored c1241ec5
> checksum calced c1241ec5
> fs uuid 261534ef-b111-4056-8124-6dd207030548
> chunk uuid 976c9d1e-ca7a-4611-befc-5a08375564bc
>      item 0 key (TREE_LOG ROOT_ITEM 5) itemoff 15844 itemsize 439
>          generation 3595443 root_dirid 0 bytenr 3766932439040
> byte_limit 0 bytes_used 3686400
>          last_snapshot 0 flags 0x0(none) refs 0
>          drop_progress key (0 UNKNOWN.0 0) drop_level 0
>          level 1 generation_v2 3595443
>          uuid 00000000-0000-0000-0000-000000000000
>          parent_uuid 00000000-0000-0000-0000-000000000000
>          received_uuid 00000000-0000-0000-0000-000000000000
>          ctransid 0 otransid 0 stransid 0 rtransid 0
>          ctime 0.0 (1970-01-01 01:00:00)
>          otime 0.0 (1970-01-01 01:00:00)
>          stime 0.0 (1970-01-01 01:00:00)
>          rtime 0.0 (1970-01-01 01:00:00)

Thanks, now the following needed dumps:

# btrfs ins dump-tree --hide-names -b 3766932439040 /dev/vdf

And

# btrfs ins dump-tree --hide-names -t 5 /dev/vdf |\
   grep "(407482430 " -C 5

The first one is to dump the content of that log tree.

The second one is to dump the original tree of that offending directory 
inode.

With those two (and hopefully the only needed dumps), we should be able 
to pin down the cause.

But it's better to let Filipe to determine if extra info is needed.

Thanks,
Qu

> 
>>
>>>    kernel:BTRFS: error (device vdf: state EA) in btrfs_replay_log:2395:
>>> errno=-5 IO failure (Failed to recover log tree)
>>>    kernel:BTRFS error (device vdf: state EA): open_ctree failed
>>
>> Although the workaround should be pretty simple, "btrfs rescue zero-log
>> /dev/vdf" should fix it.
>>
>> But please consider not to zero the log until we have collected enough info.
>>
>> We may still need extra info even after the above dump-tree output.
> 
> No worries, I'll let it in the state and follow your guidance.
> 
>>
>> Thanks,
>> Qu
>>>
>>> # btrfs rescue super-recover -v /dev/vdf
>>> All Devices:
>>>       Device: id = 1, name = /dev/vdf
>>>
>>> Before Recovering:
>>>       [All good supers]:
>>>           device name = /dev/vdf
>>>           superblock bytenr = 65536
>>>
>>>           device name = /dev/vdf
>>>           superblock bytenr = 67108864
>>>
>>>           device name = /dev/vdf
>>>           superblock bytenr = 274877906944
>>>
>>>       [All bad supers]:
>>>
>>> All supers are valid, no need to recover
>>>
>>> # btrfs-find-root /dev/vdf
>>> Superblock thinks the generation is 3595442
>>> Superblock thinks the level is 0
>>> Found tree root at 3424157040640 gen 3595442 level 0
>>> Well block 3424059916288(gen: 3595435 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3424054345728(gen: 3595434 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3423941132288(gen: 3595431 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3423913361408(gen: 3595430 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3423724224512(gen: 3595429 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3423618924544(gen: 3595428 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3423522717696(gen: 3595419 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3423509741568(gen: 3595418 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3423381946368(gen: 3595417 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3423254937600(gen: 3595411 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3423190253568(gen: 3595410 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3257715638272(gen: 3595407 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3257566904320(gen: 3595404 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3257494061056(gen: 3595402 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3257426460672(gen: 3595401 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3257354846208(gen: 3595400 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3257189138432(gen: 3595398 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3257066291200(gen: 3595397 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3257054314496(gen: 3595395 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3256925880320(gen: 3595390 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3256790237184(gen: 3595384 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3256747343872(gen: 3595379 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3256734842880(gen: 3595378 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3256726290432(gen: 3595377 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3070848090112(gen: 3595376 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3070762254336(gen: 3595369 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3070533402624(gen: 3595366 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3070520950784(gen: 3595365 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3070319542272(gen: 3595364 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3070275878912(gen: 3595355 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3070224957440(gen: 3595354 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3070133649408(gen: 3595348 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3070109827072(gen: 3595347 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2889425747968(gen: 3595340 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2889301147648(gen: 3595339 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2889314811904(gen: 3595337 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2889158066176(gen: 3595332 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2889076523008(gen: 3595330 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2889007906816(gen: 3595329 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2888883896320(gen: 3595328 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2888770060288(gen: 3595326 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2888474230784(gen: 3595325 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2888414789632(gen: 3595324 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2654316625920(gen: 3595323 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2654292000768(gen: 3595322 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2654178476032(gen: 3595321 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2654046437376(gen: 3595317 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2653815832576(gen: 3595312 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2653688217600(gen: 3595311 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2653640425472(gen: 3595310 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2503985594368(gen: 3595309 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2503770832896(gen: 3595305 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2503679131648(gen: 3595304 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2503542685696(gen: 3595300 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2503440711680(gen: 3595297 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2503322124288(gen: 3595294 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2503168000000(gen: 3595289 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2503054426112(gen: 3595288 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2503041384448(gen: 3595287 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2503445053440(gen: 3595285 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2412690669568(gen: 3595284 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2412570755072(gen: 3595281 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2221267697664(gen: 3595278 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2221141753856(gen: 3595275 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2221038993408(gen: 3595270 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2220922290176(gen: 3595269 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2220743933952(gen: 3595266 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2220618924032(gen: 3595264 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2220595019776(gen: 3595263 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2220507889664(gen: 3595262 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2220364578816(gen: 3595258 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2220268486656(gen: 3595257 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2220199788544(gen: 3595256 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2220125945856(gen: 3595253 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2220104859648(gen: 3595252 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2219941019648(gen: 3595246 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2219772805120(gen: 3595245 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2219676188672(gen: 3595243 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2219385782272(gen: 3595242 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2219322032128(gen: 3595239 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2219298471936(gen: 3595238 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2219189157888(gen: 3595234 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2219168301056(gen: 3595233 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 1725089398784(gen: 3595229 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 1724993929216(gen: 3595224 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 1724703211520(gen: 3595223 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 1724590768128(gen: 3595214 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 1124192288768(gen: 3595206 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 1124086104064(gen: 3595204 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 1123955785728(gen: 3595198 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 1123796860928(gen: 3595188 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 1123702702080(gen: 3595181 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 1123696197632(gen: 3595180 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 1123421716480(gen: 3595178 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 1123298459648(gen: 3595171 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 409090146304(gen: 3595168 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 408798691328(gen: 3595166 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 408693866496(gen: 3595163 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 408471683072(gen: 3595160 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 768655360(gen: 3595159 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 508542976(gen: 3595157 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 426082304(gen: 3595153 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 275447808(gen: 3595143 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 158154752(gen: 3595138 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 3069995843584(gen: 3594572 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>> Well block 2220640256000(gen: 3594469 level: 0) seems good, but
>>> generation/level doesn't match, want gen: 3595442 level: 0
>>>
>>> # btrfs inspect-internal dump-super /dev/vdf
>>> superblock: bytenr=65536, device=/dev/vdf
>>> ---------------------------------------------------------
>>> csum_type        0 (crc32c)
>>> csum_size        4
>>> csum            0x50cf7576 [match]
>>> bytenr            65536
>>> flags            0x1
>>>               ( WRITTEN )
>>> magic            _BHRfS_M [match]
>>> fsid            261534ef-b111-4056-8124-6dd207030548
>>> metadata_uuid        261534ef-b111-4056-8124-6dd207030548
>>> label            minio2
>>> generation        3595442
>>> root            3424157040640
>>> sys_array_size        129
>>> chunk_root_generation    3581791
>>> root_level        0
>>> chunk_root        25460736
>>> chunk_root_level    1
>>> log_root        3766932537344
>>> log_root_transid (deprecated)    0
>>> log_root_level        0
>>> total_bytes        5498631880704
>>> bytes_used        4346997747712
>>> sectorsize        4096
>>> nodesize        16384
>>> leafsize (deprecated)    16384
>>> stripesize        4096
>>> root_dir        6
>>> num_devices        1
>>> compat_flags        0x0
>>> compat_ro_flags        0xb
>>>               ( FREE_SPACE_TREE |
>>>                 FREE_SPACE_TREE_VALID |
>>>                 BLOCK_GROUP_TREE )
>>> incompat_flags        0x371
>>>               ( MIXED_BACKREF |
>>>                 COMPRESS_ZSTD |
>>>                 BIG_METADATA |
>>>                 EXTENDED_IREF |
>>>                 SKINNY_METADATA |
>>>                 NO_HOLES )
>>> cache_generation    0
>>> uuid_tree_generation    3595442
>>> dev_item.uuid        1d32f1a0-6988-4ed4-b3cd-24d243baf975
>>> dev_item.fsid        261534ef-b111-4056-8124-6dd207030548 [match]
>>> dev_item.type        0
>>> dev_item.total_bytes    5498631880704
>>> dev_item.bytes_used    4820052213760
>>> dev_item.io_align    4096
>>> dev_item.io_width    4096
>>> dev_item.sector_size    4096
>>> dev_item.devid        1
>>> dev_item.dev_group    0
>>> dev_item.seek_speed    0
>>> dev_item.bandwidth    0
>>> dev_item.generation    0
> 
> 
> 
