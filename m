Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA929651F74
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 12:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiLTLJj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 06:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbiLTLJf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 06:09:35 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119D18E1A
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Dec 2022 03:09:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKPW9zp3CD9vHFHb+lzHZmxMaXfa62W1DrfdYEDg+91pXLPUF9haKwhMmPlgPY0dHV/dx58IjthF0B03U/rWgayYinNCykS7LzoML5KZwsJsdwxNmVOHM5Uv4jenUYBxSsvK5eoPui88GdZef3Wpo09rL+O9+B4192guLzQk0Kxla+Yu4fb1inWPumfKZi1tTPCx2zydRTZyfzggp5fnCPvkcZMVvadUVy8gos+33+07W8QeEdhoGOlAac5JT6MPD5sxdCu2NHEC6ed0kArWFhcZa8vEhRxupnigfvMLphNbOlH4Wio4eY5/d9E4U2Eq7tAIKB3m4NPyF7QCpj45NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VekJmi2tjej3jOD+/8JwtZR7GrlIlf9wjDPe2ITS5U=;
 b=mULQQYrHkgFk8f203yJL1ZcW/IYVcEfjdW+sFuIYYwPe16g5U9vGOhIo7uhXVpuO494dEZifQUY4YD01zpKQgKX2F7zujbp9WQ5BZJ9BwcNWTgXs7F1nWlay3zAX0Jc099mkFKiAxIwfhxGYB6ZzC6y1JN7C397W2rTFtvg2qvWpoqS6WAr3nGiaqWjuidBIPBwBL+5V/i7bD76CMCHwLxtLs5n3CguGEdnK6Vxvv6zBYTsqhMfro8e0dOY8iyhFpW48gOQRnwLXTzCmGW1aXWNTu76NKUfCtzTzvpymtp0rVavBu6LSDK61TT2fgWtIOcqeKYl0mKPfrY2WXFT54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VekJmi2tjej3jOD+/8JwtZR7GrlIlf9wjDPe2ITS5U=;
 b=Sm1OI0CTPbBfi8pUeI2vm0Jk0v6iS4krnESFGL5wLjxwpTIs1mKsL0D6XzwjoFdsbeoKhKRuzNAJ8qMWOaBRxHZ3CE2r2gCEX3MxEuqAqnSiO2OhzOV7DIqbeyylDwaHiBLJLOlsr13H4h/UbsHzy7l4SdIFtFZRqmMS9pwzASs9XWmTVuFQDbt0Q2UkujbkTyuqUyXY5S3gfYvaU0QJodakA317PLgphCQoidw0iUADVp78yMlHcvPGc7eUXZUtJuhbHvb0o9Z2P9ExTqr0HeVLVJXq5zpYHHUVG7irS+7D3dU3Uv8o8bxxkHZ9FALGfqriD3b7Pt02JDgsTKDuew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB7590.eurprd04.prod.outlook.com (2603:10a6:20b:23d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 11:09:27 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::748c:98fc:fa1:4c5d]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::748c:98fc:fa1:4c5d%9]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 11:09:27 +0000
Message-ID: <e4491c53-1869-9a85-f656-f2e35acd8b65@suse.com>
Date:   Tue, 20 Dec 2022 19:09:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAN4oSBewVqdWU8O4jBqneexYKZGHLSDEhFCwKj+mL5+OjcWeYg@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: Doing anything with the external disk except mounting causes
 whole system lockup
In-Reply-To: <CAN4oSBewVqdWU8O4jBqneexYKZGHLSDEhFCwKj+mL5+OjcWeYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::14) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: f173cac9-f250-44da-9d57-08dae27aa83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9bYhCVJcBheQnyHwsaxsjDq+gFaEoleUWInwVA8xdZe9BJ94F6pBSzwGrQAWbr4LCL5nGNCDkCyoqubFnffG4SZqfHtqM9AAkYHL2TaIbfHXxLXtW4AqzW8485/+gqkZTRbMBYjOJMJ9eEUihpfTVxEgO4l1sfxbSi84jNxup82d1do5vPEeatzRwktGHdE4/0fcfdt1JxEIDlEasNgOQeXbYm+fZoIJP1loyyBheY4sTDMvwZInr6tD2ZsH1E51f71lAEvGhhShnSIlO6mq+E58GOX5UYiXlNwAKRqklQ164PCRYo1WV37GkUTQNlPPSlhiAdUl0/dzQL7wM+CfZTSw3CGqn/Ek72Bq838Z9QciQ9VGP/r33PwYRW+4uYsEFyYYoDjkyQc6hXVG0uDrOoTa8N+Am7MpcMD7joFNWhQUAIDst+A1LgVV6q7l2g+moCyoRIAX8mcFbWeR4Tk8fRb3d6mr/NGybDRd3rPtBeFlMoDTO8VPvVL/0LY2Ip/feZhBEzzH3L4pxB4bVtwR4Bn16btd3oMAG+1j83gu1CfvSetkbtg+3UHEo8KTMnJ4pvgUXIIw7QSBzHG5t/bG7h9ZmDJZ5Xk5mCUyB2SM3HZnBH9LxA6/MKGcc92oQbzIcpCbI1Se09a/ZCg7Y5uqW/oGmc2/XJhEFHBelk/yEF+nQridrDG9Ws8txYrCz1n3ijDZiZ2T9QwzMo00UiL3Q7QHA+v6Bsn3hO4/ikgDqd/5igeRMydJkssnC2Hwmb+IoHrRdsDTa40jEywdLkNjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199015)(6666004)(8936002)(31686004)(83380400001)(5660300002)(66899015)(6512007)(41300700001)(186003)(2906002)(4001150100001)(36756003)(6486002)(966005)(110136005)(478600001)(53546011)(66476007)(316002)(66946007)(8676002)(66556008)(2616005)(86362001)(6506007)(31696002)(38100700002)(45980500001)(15519875007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWRZdWthOXBBVnNTbGtyQXhEYXFVYVJmM2pNdStDRlZvSW5lWit6YU9JV1Ft?=
 =?utf-8?B?YjRUcU4rb0dJd0lTa29Xd1RUclYrYnZzT0xOakdTQmdqRkpzN3RGWStIa3ZY?=
 =?utf-8?B?ajc3bDBmRnA4azhtTDEvUnRINUZwcUdha2RSMDIyRFFuZldzcmU3eHFqMEVa?=
 =?utf-8?B?YWZzL2dLaHhXTmY4RXFHcXUzNHlaZjZNODlDVWl3czR4bC91ZEV3b2JGQTBj?=
 =?utf-8?B?eFFXMEM5bUY3QWRIT0ZFcU90UlNOZ25IMUtIbG9pdFFkZmRjNkQwcUw1STMr?=
 =?utf-8?B?UkF6cTJXRWpPbjRGSlZSOHl5RUJ4OEF1SG9RZFlIMENiYVViOVFnV0o4ZWE4?=
 =?utf-8?B?TFBrekE5SXNDR2ptTi9OcTM1OEEvVk0rMXRJTENLeVkreDgya3I5dXI0ZEVK?=
 =?utf-8?B?K0ZXUHZJUXcyWTdRblVNZHM4MjRIaUEwY1BEbjRWcnV4QzlKNUdJL2doRjA4?=
 =?utf-8?B?M0hRVWZJWXhPU082ejV1NWEvS0dQUnNtV2NKdnVDdWFQNW9EQWVveE03WkNZ?=
 =?utf-8?B?dTJ5RzRUaU5jWXY3dkxFbDMxOUEyallMV0ppYTk0YTJ1VzhBenZzaFFZTkVO?=
 =?utf-8?B?azgzYVRkdE5pT2NyOUV4VlJtVUNib1BtTUxsRVBJeTdKUkZTWXNhNmVrTEpa?=
 =?utf-8?B?SU5IM3FzVzJUZG1rZlcxWURZcGNVc2N1WUxROGJ2L0FaVHhjcWYyb2FSSmV4?=
 =?utf-8?B?NW5KMXdWMEhyM1ZnREk2STJaMWtYaERGSlJCaUYxQ3dvaFRGRy9NVjNFODI0?=
 =?utf-8?B?MjhZNzlieXV2ZXRVT3JDOFFzY0EwRy9McXBBTXZnUHFZQ216VWtFY1RvdUc5?=
 =?utf-8?B?Qmt6SkVvWE9zODd6SjJlejJYZ09QRXM1bGpyMUpPcTduZ21kWk1jcHhhcTF3?=
 =?utf-8?B?dFlVKzNsVWYramt3S0FnS3RGTkVnRzRNeUJLMG9JR1VMbEtRTHA0SnpXY2Fw?=
 =?utf-8?B?SUxpU3IvcTlqazlkbWhSV2ZRYWc2UUdOeW9WcmtlWHFoZnI5Z1hBZEtWRU0v?=
 =?utf-8?B?NDlWSU1La1BPWVB2S3ZveExuRkR4TUlMYjR1c3JTeFlRUXAvaVhoODJKOS9k?=
 =?utf-8?B?eFF1WWdxWGxHbmpSQVBZSUF5NTJ1U3psLy94RVd5QTkvQU9OOWhTRk00bXpq?=
 =?utf-8?B?N2pmS0hjQ0xwZFRpd0FtQjZGTGxTTG1WUHpISk44d1lKWGVVWmR3LzZjRWFO?=
 =?utf-8?B?T0V5WjkxZG1JYnVFQ3NhZ0F5eHpDUG85RzF1Vyt6SzhERDNGV0pwalp1Wlh6?=
 =?utf-8?B?SDZWL3hDcE1qRkw1aWxZT21tVXZrY0NmMEZUaGdzZCtPa043RkgvOW1pWENw?=
 =?utf-8?B?YkR4U0tXd005UlhyM3hEU3J0NXk2NE41Ymt5b0k2RGNrR3ptQ2lvdDNYaGpI?=
 =?utf-8?B?K2wxZkJvaENveEpFeGxkQnBhbHVwcU5TYloxY3o2eDhJeFY4QXZReTVTNm1Q?=
 =?utf-8?B?SGVSSTJmWW5OSURDd2RaTm1WcDNHcFpJQlNVWWlEdG1nRGoyOXpYWWVINlY2?=
 =?utf-8?B?MlhzeTQ2OGZSR2JleGhxVGY4OVY3NHp4dldqemlnSTl5TGkxVEFtK2xIeXRE?=
 =?utf-8?B?MnlVOUgvdXJxRFA3ZWNnMldlMitkTVVZb3hrcHlRdCtTRXFwQnlkUzdNZE5v?=
 =?utf-8?B?WnlWbVFQK3lTSkNkRmZvZUNWUVJLOGlDcXNPVXhvM0lVYnkzQ2NKZXdTYWla?=
 =?utf-8?B?eFNjbXl3Y256WnA4bGd2SC9WS2JzdEVwbHlrYUF0dFVQUkZFbHh6U2dHbXY0?=
 =?utf-8?B?L0U5dm5rUjFRcEk5blFEUUhPSnZ2N1gvTFVyYUowRitaNXdCZHI0dkNRWDJm?=
 =?utf-8?B?dHRlVEVTdS9BZ3haeHU3WWlpWlRNY01Kdzc3VEwxZFlnTzArbXdDWkhhQ2tm?=
 =?utf-8?B?Qk5NdDdYc3AxZzI1M3JvbzYwYVdFTldzVEhNNlJpLzN3Y0trSkRpWkVyK1Vz?=
 =?utf-8?B?MTNvSmVkVGpSQ0hvbEg0NmF6TU56bi9oR3p2U3c4cThqaVdEYThRRXBWeWlW?=
 =?utf-8?B?ajVOQTFzbngwRm1BdTNCTlYza25ETUF5bkpsRkl4aDNxNTFVTE5ZbWxRU3pN?=
 =?utf-8?B?REIwd0dVWldFd29Pck5QMFJzSG5Wdk9YdEw3TS9LbXVIUjhhaWthQ3JYc1dN?=
 =?utf-8?B?dmxFYTRJMjNIVzlka09OM0hIUk4wQU85SDFWcFljNVV5dUh3RDJwUVVmZnpo?=
 =?utf-8?Q?fF9INaAMokHZ44XyJgsovrA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f173cac9-f250-44da-9d57-08dae27aa83d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 11:09:27.0655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyuLcJUyWA0DPb3deO0BeX9YYltu47ody253bkOaDQJ/FCc4AxomA163Ul+sVSGX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7590
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/20 01:32, Cerem Cem ASLAN wrote:
> I've been using my scripts for mounting partitions, unmounting, btrfs
> send|receive etc. while I'm dealing with my external/backup hard
> disks.
> 
> Recently I had trouble so I reformatted my external spinning disk and
> transferred all snapshots to it (~800GB).
> 
> At the end of transfer, there was an error (I might have modified the
> bash script that is currently running) so after finishing the `btrbk
> ...` command, my script gave an error (that's normal), so I restarted
> it. From this moment on, I could mount my partitions but I never did a
> btrfs send|receive or scrub or unmount again because the system was
> simply getting locked up.
> 
> I run `dmesg -w` command on another terminal but I didn't save it
> (because the system was locked), so I took a photo of it:
> https://imgur.com/LJfgjbY

RCU stall, then it can be anything, I doubt if it's really btrfs causing 
the problem.

In fact, I hit similar problems before, very randomly, sometimes when 
playing some steam games, sometimes just random crash/lockup.

At least if you can setup a netconsole, we can have better view of the 
whole situation.

In my case, netconsole also sometimes points to RCU, sometimes some 
random generic protection error.

I tried replacing my RAM, no help. Finally I brought a new mobo and CPU 
(switched from 5900X + B450I to 13700K + B660I) and no crash anymore.

Thus if you're hitting RCU stalls, I'd strongly recommend to test the 
same fs on other systems.

Thanks,
Qu
> 
> I haven't lost any data and I still have another backup disk, so no
> worries. I'm just keeping the disk just in case you may require some
> more information this week.
> 
> * Linux erik3 6.0.0-0.deb11.2-amd64 #1 SMP PREEMPT_DYNAMIC Debian
> 6.0.3-1~bpo11+1 (2022-10-29) x86_64 GNU/Linux
> * btrfs-progs v5.10.1
> * mount options I'm using: rw,noatime
