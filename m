Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C15158D156
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 02:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244356AbiHIAYg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 20:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbiHIAYf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 20:24:35 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20077.outbound.protection.outlook.com [40.107.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC0F1AF0A
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 17:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqb28PUefxFhasrJ+OBRftZ4Pz9DxwXu+noAvCNWVrLU14fh8/nvjewfFkntsZnWbHiTELNMnMpaPtNX61ZKaM9DYQmGRuQiqZ6efXR/oHZ3V7aSrcfGvdNuZlxUfC8l+SJM0Tr5EMDl+M+7rTOjtCu71tl7nBUrtEtMAgpvzRXM5M81GAkWc4lLEgMNJfpKMqzxksMyKNoW2Pl6b9C9UxVpebU4utrkhllW7tWnczQVRziNmBP47SvH1y+TdGBOj9It2alHDP9DcjIWTD4RoGNLZuv0wyf7WDO7dl2++5b6mLvHVJq6zf1jgNgKNHVUc37DIlF913E7eCQcsMgSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MGY+ZdcOBj7xtoK0gp7viHL74iY8nel/p4zKc3oP0s=;
 b=e2VBBNJgA9VtUhSp3/7BAvZuboxpO9mG2bGHSvIhQ1jbC7kNlQOEXXDRYUmoCjIeQCrvtBaFBncpgMg3AlK47yabTrkH6zVkQOxsOmbm0PPW160HUQOX5r15GFhWfkgQwStm73rQyqsszYUMcWig3O0JrDGakCIdjwaCiYg4LjJL4G7bsFhW6y8JZLN/1YuMPKi2rGdgs3AwfOR0c9OLZG1i7kDRXBv2iXvRZ2yTy3Utc6hsn78pEvq9IrWssmTv167MqePMouOGdQadzGeqeF06OpJg4ACVyqhdClp2914ShxaiuiKhT0PaPDLTTyvc5+THFqiWTzinTN40JR5XUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MGY+ZdcOBj7xtoK0gp7viHL74iY8nel/p4zKc3oP0s=;
 b=iabaf3v/f6cPwBK7EBaSiixs1mr8LBRku+HOjVDhbBUn9pez1zX6GwFELeOFEL/M7k/izysh2PGCjgafnjDpdaejg9e+nZQ0j4bnDLbAt9uWoaPafoXt3ITYPjlU+EOUMn09KRvqSwiUCkHGEwBBatuccvG/Ra/IzTpwrm3fjz8oVuw6AzHU29xc0WhWmIGY+l9c6tORpi/xnyFMckXXO078DbjEV0wkWUYvOZ4F1SqzaBbs2pRC8gLN/n9CNexoYX1mWBHEW8WKin9jyHdVyzG1dGP+Pft+5L0LOkeTqeA6AFUxPoEo27MUGguFGFY7Dvzy5FVcEDfv3cEKvmYszQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB7PR04MB4940.eurprd04.prod.outlook.com (2603:10a6:10:22::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 00:24:32 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c4b3:5f3a:8bf5:f6e9]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c4b3:5f3a:8bf5:f6e9%9]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 00:24:31 +0000
Message-ID: <b817538a-687e-0fee-fa05-a1b0cfe956f3@suse.com>
Date:   Tue, 9 Aug 2022 08:24:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Corrupted btrfs (LUKS), seeking advice
Content-Language: en-US
To:     Michael Zacherl <mz01@bluemole.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <12ad8fa0-a4f6-815d-dcab-1b6efa1c9da8@bluemole.com>
 <ebc960af-2511-457e-88ef-d1ee2d995c7d@www.fastmail.com>
 <60689fac-9a38-9045-262c-7f147d71a3d2@bluemole.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <60689fac-9a38-9045-262c-7f147d71a3d2@bluemole.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::34) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84c092ef-99e5-4400-3577-08da799d879a
X-MS-TrafficTypeDiagnostic: DB7PR04MB4940:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgZ0M11m5gUJkIcJnUk+Z5KnuK6eFenbSPZeHeHXi/1xwZLH9NNyWizXgLSdriZmzqmEvWpNzZwHIkfFd5Hp1fyRKtlxDa6avVf16aJ98psZQ+8MIIwTrpEihWprAJQQRy6VQAZN3Ka7dZFbG6XJi7Py3AdXuZ8T465x9Y6562eOXDU6hk+bSj0D+43slCQkb9D3OGEeegtmuztPKt+avbCwHq2j/2rP4BKb527tQafHJQuCjdC2zsPmczbTxNzibOHiMDQxZzKnBIPzJB8ifxk8AUZlBOJ+vELE9mhWIyDli1+71Dmk7zM3VhpoMtuRN5fTYKB282ibsszIAxfNXFMIOTjvBqO81D8zH9Mvn+nKucv7IJ8y0MHnmvfkZ3CsJy40kGghtNusTWPE183ynHEor30X5Qr6+2DyTB524muiUIMDPAKGrnsZbDPYij6kPigqlrCrXF7Z98fFFoCOlP9o7wKsNpiQwmBhblPTGxXndODf1goTAgMN74wdiN+KKaZBmM79U7pVrGixwVJylfawAg5xvInAlMK8NK4iDizUDxZMlVn7QxqRIM+HVYFO4WhhziocDmZWaFkNLakYbBUTsZ7AeZdFsZYyeWHKcOObNfwhIlMuABQrfAw+2vzKVGL+TY+L7GLG3QG3iGyieM+3L99rsC1vPsQZLqwqRD5pdbLp2wjXWAAplfx7wk/tbo27zzYdpf7HcXEimAVWKBCqr4UCPmLw3ZaXvwGZEC8YfrgnFhtitsBMP5D/WbQ78SFNWl247wvOAaqU2sw8mVHrYKC8CdoUS646UopBnmiV2UBaU12Ps3iaIL3WMVO3QaSCq50Tf2kRdGrky6Ir+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(366004)(346002)(396003)(5660300002)(2906002)(36756003)(6486002)(110136005)(316002)(478600001)(66946007)(31686004)(8936002)(38100700002)(86362001)(2616005)(6512007)(31696002)(41300700001)(6666004)(53546011)(6506007)(66556008)(8676002)(66476007)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDZ1NGowUTMyN0dWU2lOSW1xZ2tHeUlUTmpkMEtQTGxtb2IvL3NzTmdHc3BC?=
 =?utf-8?B?cFhubnhlR3VQZ3g0UWVwN2Jvb3k2YWtvU29TcFB5U3g0ekVmZmpHV1M2anRs?=
 =?utf-8?B?QUxhY05qaUg4K2h0SHo1TDhYMVIxbDYvUWo4SmZRd0VaazZDNEYyVENXa3J3?=
 =?utf-8?B?Z0hXcXBubzEyZUF0eW1Rdk8yeXFqS042aTdFUHM3bDNjVjZOQUduZDhub1hy?=
 =?utf-8?B?RjNkMEdOaDVYRUVJVnZtRTdUZ200aGd1czdRYXhjRWRScm9uUmVUMGUzdUw1?=
 =?utf-8?B?b1VEV2xRQjZBZHRlT1A5ZWFhZGpodHhLUkdBcy91cXh3U1BESmVpL3kxQlJ6?=
 =?utf-8?B?Q1lGZktxRk00OFJRN0FoZy83VzZOZmxGeGtVUmNXZXE1Vkx4WUt5RE15cDFV?=
 =?utf-8?B?MG5EeWlCSGtib0lNTEk4NzNwZmo3a1RLUWk3ejV1U2N3TDQ3SFFCb2c3MXZI?=
 =?utf-8?B?TGtLeHU1V2FTalBkUFN3N0w3Rk9XeFpaeDBwN3A3ZVR0L3pmSkVOZDFhODVk?=
 =?utf-8?B?NmJrOXhYc0lBSTljY2xGRUN4VTBQUVZzS3NCeW90SUdzOFRaODI4MXBUcm5t?=
 =?utf-8?B?MVFKYnEzSEw2b3daaEozV1lId3VmMFBFRXZGN3ZMdjR1MTQxOFdrVE1ZWWs2?=
 =?utf-8?B?azl2NVdtTG1GTUNxYWFnYS9IRnJRVWsycHRYODZmeTh6Nk0ySmtkQjJUODgy?=
 =?utf-8?B?akxnUzV5MUROb1BaMUlyeWIrcWkrSlNWRFBTM0g3bXpXUzVFUXVtYnNyZk1P?=
 =?utf-8?B?cllIZm4zZWRNdEhuc09tQmJzektmcUhMNzVYR29McmRMUzFubTlKSmdJbEI0?=
 =?utf-8?B?NytUODk4bmRWVEk0bzhHTk9QODZNRXJsWjd3YnZyTmxCYWVuUFFPTExuWkxq?=
 =?utf-8?B?T0orV1ZTdFdyV1VOYmpFdU05WVNhOW9hYUd0Ni9YaFc2T0NNUnlaV215Z2w0?=
 =?utf-8?B?UjFjWCsvUlVjSjFNcno3SmtEUGVCWVQybDFha0ZMaGQ3QXZOYm84SFk3ZzA2?=
 =?utf-8?B?Si9LSitXajgxK1d1aTZBbVp5SzRNU0pxdUxtUEpUMzM3TDVFQkxLOXExclB6?=
 =?utf-8?B?akhjV2YyaXB2QlR6eHdLMm9MR01nWDQ3UGFJclNYOXFqeTVBNllWRjZJODFC?=
 =?utf-8?B?TmVQZFhEL2JkMjhoanNiaFJ2M1NWbnM2SHZvYVByUkdNUTVhdWFYWFhibHNB?=
 =?utf-8?B?TnNDaW1mMU1QWjY0TkhJNXNFUGgrK0tBaWErN3Fvc2RxVDJqUnVyUFdrUE9C?=
 =?utf-8?B?UlVzRHprQXN2RDBNZTdraWxpUWFob1VaU3p0M0FGZVc0a2pCODhKczVPM1M5?=
 =?utf-8?B?U21iWEh4TWlyc3lHbHhxNUltYUdqK0tlcno5UU02TUxPK0tjR3Y0SGYzbGZC?=
 =?utf-8?B?MmI0elVveU50SEdEcFZ3YytMZjhrY0NDUHRBcHNIWW5mZmMra1NPS2JsNkN2?=
 =?utf-8?B?SkUycWwxTkVENWphQzJsSStQclZHSjBLbXBiME1qTUJZUDVscnJLVTF4R2ls?=
 =?utf-8?B?NXdRSnlPcGM2dWpoRVYvYXhNU3NYb01OMTg2VHQ5OGMzMWtpTmlsMjljbXpX?=
 =?utf-8?B?L2VVeDB1NnloSWhvTnh5VytvY0xEZ3BaeGphaUZSK0hIZ0dHdnloWFFTb0hH?=
 =?utf-8?B?NDkxbnpweXM4N3JxdjJKZmhPbEUyVGR0djVFM3F4aWR2emdHb2RWMlpMSkNw?=
 =?utf-8?B?bUtCYnBFRVlVbFE1Ukg5aE1yanFzNzdsa2JDaU0ydjVjcDlpZFFJaDIxYVV6?=
 =?utf-8?B?emZXMys2R3AwcEdOUWk0MlVNVFNkV3JDWTBWdzRISzE4SmUrOUFOcUd6aEFz?=
 =?utf-8?B?TStJMWRTWkNSZ3YyQjB1TWxXbkR6QUE1V2txcVJjVmdTcUR5OUswVUIvaG9I?=
 =?utf-8?B?d1oxeWRBbTMzYVVyWmRmSHJmU0FickdXVjFOUTFxYWVldFA1RkNPRTNxVzZu?=
 =?utf-8?B?eUpTM0kwcE4vb1lubVNnWTFZNUxFKzhVc0dpRlVNdFZLek83MUxjL3hDbUp4?=
 =?utf-8?B?TGl1NkgxZ1FQczlLN25aRlVFR1NtY1M5SlNXb0h1SlhJSFpiN1d4WGNreXJU?=
 =?utf-8?B?Vk5yVjVicDAzbEV6UXhHUDVqQk9CdEgzZ0lNNHhmRkp3RjJHakk1ek1jajl5?=
 =?utf-8?B?WUVJQWp5RE05UndXS092RlNDOThHSkpsT29JRnJTYmFSQ2lRcFZrWVNmUG5t?=
 =?utf-8?Q?yHToY6mWmheSSvPCe+oMvig=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c092ef-99e5-4400-3577-08da799d879a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 00:24:31.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mw8TJZd8Gb3kGBL35ZZaUqeif2KRAsY3tYa1pUnD/AbGZ95iyfcAb9HPS/ZmNc68
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4940
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/9 01:33, Michael Zacherl wrote:
> On 8/8/22 16:57, Chris Murphy wrote:
>> mount -o ro,rescue=all
>>
>> If that works you can umount and try again adding all the rescue 
>> options except idatacsums.> It's nice to have datacsum warnings 
>> (unless there's just to many errors.)
> 
> rescue=all mounts.
> 
> dmesg from   mount -o 
> ro,rescue=usebackuproot,rescue=nologreplay,rescue=ignorebadroots 
> /dev/mapper/luks-test /mnt :
> 
> [20680.066631] BTRFS info (device dm-1): flagging fs with big metadata 
> feature
> [20680.066641] BTRFS info (device dm-1): trying to use backup root at 
> mount time
> [20680.066646] BTRFS info (device dm-1): disabling log replay at mount time
> [20680.066650] BTRFS info (device dm-1): ignoring bad roots
> [20680.066652] BTRFS info (device dm-1): using free space tree
> [20680.066654] BTRFS info (device dm-1): has skinny extents
> [20680.072359] BTRFS error (device dm-1): parent transid verify failed 
> on 334692352 wanted 14761 found 14765
> [20680.072571] BTRFS error (device dm-1): parent transid verify failed 
> on 334692352 wanted 14761 found 14765
> [20680.073296] BTRFS info (device dm-1): enabling ssd optimizations
> 
> A brief look shows I can access data!
> 
> When also omitting nologreplay the FS wouldn't mount and dmesg shows
> 
> [20837.557120] BTRFS info (device dm-1): flagging fs with big metadata 
> feature
> [20837.557138] BTRFS info (device dm-1): trying to use backup root at 
> mount time
> [20837.557148] BTRFS info (device dm-1): ignoring bad roots
> [20837.557152] BTRFS info (device dm-1): using free space tree
> [20837.557156] BTRFS info (device dm-1): has skinny extents
> [20837.567354] BTRFS error (device dm-1): parent transid verify failed 
> on 334692352 wanted 14761 found 14765
> [20837.567809] BTRFS error (device dm-1): parent transid verify failed 
> on 334692352 wanted 14761 found 14765
> [20837.569387] BTRFS info (device dm-1): enabling ssd optimizationsquite 
> understans
> [20837.569403] BTRFS info (device dm-1): start tree-log replay

Try this mount option "-o ro,rescue=all,rescue=nologreplay".

> [20837.637057] BTRFS error (device dm-1): parent transid verify failed 
> on 337412096 wanted 5492 found 14764
> [20837.637223] BTRFS error (device dm-1): parent transid verify failed 
> on 337412096 wanted 5492 found 14764
> [20837.656541] BTRFS error (device dm-1): parent transid verify failed 
> on 334643200 wanted 14761 found 14765
> [20837.656670] BTRFS error (device dm-1): parent transid verify failed 
> on 334643200 wanted 14761 found 14765
> [20837.656676] BTRFS: error (device dm-1: state A) in 
> btrfs_run_delayed_refs:2151: errno=-5 IO failure
> [20837.656682] BTRFS: error (device dm-1: state EA) in 
> btrfs_replay_log:2567: errno=-5 IO failure (Failed to recover log tree)
> [20837.675238] BTRFS error (device dm-1: state EA): open_ctree failed
> 
> Is this FS repairable to a usable state?

Definitely no.

Thanks,
Qu
> 
> Thanks a lot, Michael.
> 
> 
> 
