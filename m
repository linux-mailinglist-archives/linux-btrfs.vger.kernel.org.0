Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EAD4305B0
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Oct 2021 02:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbhJQADY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Oct 2021 20:03:24 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:50685 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235752AbhJQADX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Oct 2021 20:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634428873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ic336xzH12bD9GoiylU1k5BqMrZYNe1TLZvmb+gnhxk=;
        b=MUeUVAsqcTiAYdW/PN6uDwlSkdIJnu9FY4j9TPJewzIi8RkS0EoCmGvndiWAtiElbywu1G
        EzUMn/SLdlzu4nxaWcN4/3f7kKBfvGUYObHJ4vfRsEBHktVsrhHGc0Jwm3hzoJc6Nm1UM0
        EF2+4SQslvWjlHyusrT3/wjcy3dYMFg=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-23-X5ssvncCMp-LWhDGcQ6jEQ-1; Sun, 17 Oct 2021 02:01:10 +0200
X-MC-Unique: X5ssvncCMp-LWhDGcQ6jEQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcPuHNsgnUH51cRq0QaOOBUjqaPMqxzvlpp3NWvm2JcPb78IVCO8YJVWCC5UhuaKX11floZ7l8mAzZIMvX4Ty5FTx7ax1OkeAizXh/T/BjgVWq9Y+EYKXBNwOdc4DcjePalg6rmNzZM15WMhGGhs8bJETk+qVS/KWpCF0dJMALUkEi8O9B/vNJRv7UY11fBmG1mQ9DLBXS1KEJnDtnC9OTDnyAl0+fsHCl6W+b0H7dDOuI6JDdW3ZXl/sQHDDPgETjmwen8bMT4529fqLb7kRXZJYkDgUCWP5PyE+JQAZHudUj9gYDzkSYFqy3SIy3+kORIm383HIk5ejqaD7Xia4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ic336xzH12bD9GoiylU1k5BqMrZYNe1TLZvmb+gnhxk=;
 b=OjeX8TCjdAbbYgIDggdoUwLWd0lOoLhuAfAFc3xn09Y08qulz8sDYxcWVGxnc8M0YV0+JpddKelMUXatjyYczV5MBY4uvQp2mbc7xeblITyZrVhekRiBzIYNe7iil2/jFqrCGF2PR601d5rfYCFcp7Bj7TkJb8PXBRU9ZagTr21ozIO0iup4mB/WniL2dDq9UHQFSeXo8lHWRAwdsJ8XXjihxBX7qGoDJ+alxsQEUmng5EHTdMBUzCB7kknp1Jm0/bzLOOFmuongruExwthxD8mTx1IwIhUFX9l06EnZ89VOqMKN+tsCp8APY2YjLzP0Mza5HrCOq5yK19Ho8Jq/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4679.eurprd04.prod.outlook.com (2603:10a6:20b:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Sun, 17 Oct
 2021 00:01:08 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%5]) with mapi id 15.20.4608.018; Sun, 17 Oct 2021
 00:01:08 +0000
Message-ID: <32b91541-1b30-eb26-36d0-7a642172b547@suse.com>
Date:   Sun, 17 Oct 2021 08:00:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: csum failed, bad tree, block, IO failures. Is my drive dead or
 has my BTRFS broke itself?
Content-Language: en-US
To:     James Harvey <jmsharvey771@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAHB2pq_Dhp7X0zRQhzbtMxKP8rC=Z8DvAaB33EF56jZHg0=+rA@mail.gmail.com>
 <637a43e5-4d6f-f69a-74e4-ae240880aa1b@gmx.com>
 <CAHB2pq_6Wb7H3zxvV33gm7j4nknAvPieNtFU_xFRWr4TZE=6cA@mail.gmail.com>
 <95cd0638-b070-6e92-0de7-bfe74e039684@gmx.com>
 <CAHB2pq_hmje4zEjf33KHiQe7TpGAsW+0mczgjZkVnkRnVW7z=g@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <CAHB2pq_hmje4zEjf33KHiQe7TpGAsW+0mczgjZkVnkRnVW7z=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0065.namprd13.prod.outlook.com (2603:10b6:a03:2c4::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.11 via Frontend Transport; Sun, 17 Oct 2021 00:01:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69ba32dc-3fd3-4387-789a-08d9910138e2
X-MS-TrafficTypeDiagnostic: AM6PR04MB4679:
X-Microsoft-Antispam-PRVS: <AM6PR04MB46798188A1D8DE7DAD2B4DE5D6BB9@AM6PR04MB4679.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bp8h43O4o/pjqD34orrVZLcQlz2Tqhh94EohUfWVo2EfrThXOFigIilnRMOqt1wI9cHc3WHMEmLBfr5s10yhzY7LWEbw7/RU9gtBbD0MWsPMtqBI+2fa23exd23FnL8+VVCveq6jfvs8hPXMDUu7inY/67nA2/w5nrSH/9uvM9bJLgqmLAhYrVBrLJA7eqKdHgOssZEQCPOyXceQwyLk0Swapde55AyFRIKq1xfAUL5evA4fOmhC5NvODlFQe+HA80Hl8SWQhveLfB6Nf5tz4oJkz5QTQI49DJJsqjjMY2/wMIxEI9h4Ydb6NgCx7x5Xty9S6pXX7MYyW3/kXDOauk2emxJ5ECodkUNbnafDlN8V4xNH86i3yyadRn28yoL7hTaJd45Q89DoWBVd+LeAkQzCEfm+YQiFIKahtqd7W27M7Ms/hw3c6x5C9SmjB4Wvt7bLUpNx3kqe0ZQZTH62QOGppILDEroJubDnxsQAtHPvUUaEl++Jdj96rufVJ/R5H/dTgPlyfEfL/9ZC5mgZUJugUP7+q5GfQAH0M0G8P22At7wmL58mAYTstadEPhKT48W5IXTZApH3bHK06S6hDgiqlEV8L8ZoeWievSCT2ABdJJxkkfh/uDn7LLoyx4nlTfO6W0yyDwy6JZgnz35Hl6FhTtx7W7rNZ2D//R0iQUahgjvDZmlbOSZdBLbau6+AZSO1NP2rTmTvnqW0dr+oxAulGGpAf0xieQJF2Se4hXIT87QfRtYWqo8I/UpXQ2oFKwTCnTzExS6xqlJ5qNC3qywr4WPr6VS8s+dgPhrONbM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(26005)(6486002)(86362001)(16576012)(31696002)(110136005)(5660300002)(66946007)(66476007)(66556008)(956004)(2616005)(53546011)(2906002)(30864003)(6666004)(38100700002)(316002)(83380400001)(36756003)(8676002)(31686004)(4326008)(8936002)(6706004)(186003)(518174003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHIweUJ2ZVZKcFpEM3ltdFhlUlptYWFQTSswYjAzbmhiUWpUNGk2anloaFl2?=
 =?utf-8?B?ZTNzZUx6UWxCNE9lZ0x0Q0grWXdaT2pqK1FuNjZDc2VPYkNZZENGbjVJWG5o?=
 =?utf-8?B?RlJyeHhrSnd3VkxIb1pxazFqMHAwUGtjaUY5aDdqd1N0a1M4NFNoWW5FR2dZ?=
 =?utf-8?B?Q25iMHlIY1pmSWdJUTlLdktNeldUcDJMTTJOYW0xNmt0UHpnWEZlakp4Nnd0?=
 =?utf-8?B?bmw4b2Fzc3F5bnZnWUpNR3c4bEh1TFBMcFMweUdlWS8vQ3NXOHhnaThna29k?=
 =?utf-8?B?MGpxZkdSQUFUM1RtbnRBQzBSbzQ3eDBsSGZJTFFvZXpISWtGS3RmQjl4cXht?=
 =?utf-8?B?VXhhcVNSUUpUWURkU1laL2pVaVBIdW4xQjBTYTVJRThpYWcxaHZKVUphNkZv?=
 =?utf-8?B?VUNHUktTcjMvS3Y2eHJDRndwUjViT0NkaDlva0xJeGJEOTRIeUp2cnMxZ3Jr?=
 =?utf-8?B?SGpWcVpWb1NrYWJFUjZ5STdZUXdFZElDRVpJSnhoNlFWcWdSSlZvcWd1Vmx2?=
 =?utf-8?B?bGh2N1RqT1h1SW8zYU9DZ3ZBOElPVW5VSWozMWorZ1hvaXBhemRGV1RGRTVi?=
 =?utf-8?B?SnVCLzFnQ0h4TnJWUjZLQ0I5NHNMR2JoOEZlZGJPRUxMS2N6ZmhKNW56NTQ4?=
 =?utf-8?B?V2lqYVRiUmhIbXdzdVB4MUJhMkJQSXlWME1RbW9KWlFvNTNUZ1JOODl4N1RV?=
 =?utf-8?B?bmdidVhyNVpzbXEvZEV4anhYMmk3WmgvUjBYL3NQd09DMkVXaG0wQXRJSCtJ?=
 =?utf-8?B?ZmhZbjBkZUM3b3BEVDRrd1dTTWJJL090WjFLUjhwV29hZWQ3WW1tWi9DenRv?=
 =?utf-8?B?QTFqdy95SnpsTjhIbHdtTmVEbGEwcm5mZkZ3aDZGNXFVa2JmMnplZmJrQnRL?=
 =?utf-8?B?Z0lqWTRna2YweDZlOG02L0dpbTZYendpTlhGVnhKV0wzNHd2Y2czcC9HamI5?=
 =?utf-8?B?VDlPbTVCYmtLNUNKdWlybmovSXAwM3hGVWFWTTFQM1FFdDNVYmVWRVJUdTB5?=
 =?utf-8?B?WHEvcy9UWnkyVXZMZ3E3Nzg3UTNhdEx6cmxFcjJrU2QrRUhUK2JoaWo5MHgz?=
 =?utf-8?B?K0xVYVpvSHpqbWdpNysvRW1rVlV3NTBPbXY3c1BZSjY4bjBjK1E0STE0QUFM?=
 =?utf-8?B?ZVlwdSsraUZ3akkwb2xWa2FXSmpMTXlEZjFpYnpJQ1lRc29IUTJCNno4blVD?=
 =?utf-8?B?aDFFSHk1NU5FYzFHWTdMZGZuMi9oSy9heEgxVW9JUUMxMHA0aDNOSXNkM2Na?=
 =?utf-8?B?Z2pUaW5UVFQxYWNTTHRsNWRqd3F0UGdYQVZJeWlXd2d2QjFrYmZYNGFQUnU1?=
 =?utf-8?B?WVdHcGV5ZXV6bEFVd1RWOE90ci9nVFk3cEtxbURLV0pSU2dIN3M5dmJUSHUv?=
 =?utf-8?B?a0UySy9ISmc1NnB6UWFoaE9nUEIwSThuclNVRlA4ODcxdkwxVHNod0RwUjZQ?=
 =?utf-8?B?UDcwa0d4bjNGenYwZmZ0VGk5M2JEUVR3RGtYMUZYb1Qvc2hIRWR0dlJoSW1L?=
 =?utf-8?B?Rm9oZGhRYUR5dUxjRDlsSm90dGt6aXpKMGVjdDJGL2NlbXIrZnNsb3pqTlE2?=
 =?utf-8?B?U3kwNUNwRTB3U2JWQlBwQ05UeHh6WkFHQU8xcVJLU0h2dzFZYVlXV1p6OUlx?=
 =?utf-8?B?dDVickhKVENxUTdudm9kOENLRVdwR1ZpUXhDem1TcjFDN3ordGQrZHpld0N1?=
 =?utf-8?B?SWV4bFJDV2pvQllvUmRmSVFkMkV2NTl1OWlidkY4SDVFcSs0SnpWT2dFZ1FD?=
 =?utf-8?Q?cgIAugalesWfpFNAW8RxecaCkeKqmcqJySo914N?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ba32dc-3fd3-4387-789a-08d9910138e2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2021 00:01:08.5693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sui7onsmc9TDX1v1tBHlhUn9gKLoeztF/q3piWlDbk5lfft5+DbBOS7E44nylmPv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4679
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/17 04:45, James Harvey wrote:
> Check hasn't done yet, but it's spit out about 1700 messages (tmux
> won't let me scroll up futher) that all look like this:

Yeah, this means quite a lot of metadata are filled with garbage.

I'm not sure why, but it doesn't like to be caused by btrfs itself.

Thanks,
Qu
> 
> mirror 1 bytenr 2276825735168 csum 0xeae339f3 expected csum 0x7e048d4d
> mirror 1 bytenr 2276825739264 csum 0x2b229954 expected csum 0xdfdce631
> mirror 1 bytenr 2276825743360 csum 0x87c424fa expected csum 0xa3e161c2
> mirror 1 bytenr 2276825747456 csum 0xbf09d2c3 expected csum 0x18f64523
> mirror 1 bytenr 2276825751552 csum 0x5de49de9 expected csum 0x19dd16c6
> mirror 1 bytenr 2276825755648 csum 0xece642aa expected csum 0x0238d7ce
> mirror 1 bytenr 2276825759744 csum 0x2af150fb expected csum 0x52bd6dff
> mirror 1 bytenr 2276825763840 csum 0x5c41b1e1 expected csum 0xbd8dfb35
> mirror 1 bytenr 2276825767936 csum 0x9646f3ac expected csum 0xcbe7c6f7
> mirror 1 bytenr 2276825772032 csum 0xf02eb278 expected csum 0x6cb180e8
> mirror 1 bytenr 2276825776128 csum 0x9c9b21d5 expected csum 0xa1100bd8
> mirror 1 bytenr 2276825780224 csum 0xcbcf3d94 expected csum 0x56462400
> mirror 1 bytenr 2276825784320 csum 0x9c3537f7 expected csum 0x5751fc32
> mirror 1 bytenr 2276825788416 csum 0xf9ee3396 expected csum 0x48bb945b
> mirror 1 bytenr 2276825792512 csum 0x1acc32ba expected csum 0x8fed41c9
> mirror 1 bytenr 2276825796608 csum 0xce357c65 expected csum 0xdfe6c125
> mirror 1 bytenr 2276825800704 csum 0x03e7eff2 expected csum 0xa7015ff2
> mirror 1 bytenr 2276825804800 csum 0x316f9ca5 expected csum 0x1fe2fa08
> mirror 1 bytenr 2276825808896 csum 0xddb636da expected csum 0xf147e370
> mirror 1 bytenr 2276825812992 csum 0x68d0356d expected csum 0xe234b227
> mirror 1 bytenr 2276825817088 csum 0x3902cfcf expected csum 0x18bbfe05
> mirror 1 bytenr 2276825821184 csum 0xc39fae3b expected csum 0x16e45df5
> mirror 1 bytenr 2276825825280 csum 0x1f31351f expected csum 0xa6284e93
> mirror 1 bytenr 2276825829376 csum 0x0fa43e43 expected csum 0xd3fdd516
> mirror 1 bytenr 2276825833472 csum 0x130ceb54 expected csum 0x3338d67b
> mirror 1 bytenr 2276825837568 csum 0x1d712e6a expected csum 0x916da565
> mirror 1 bytenr 2276825841664 csum 0x503b960f expected csum 0x4934ecf8
> mirror 1 bytenr 2276825845760 csum 0x71501ac1 expected csum 0x90137f36
> mirror 1 bytenr 2276825849856 csum 0xcccac321 expected csum 0xb5162487
> mirror 1 bytenr 2276825853952 csum 0xd7d8cc3d expected csum 0x8e61d7f8
> mirror 1 bytenr 2276825858048 csum 0xb58bd180 expected csum 0x2ed55820
> mirror 1 bytenr 2276825862144 csum 0x5f5ff26e expected csum 0x489fa94a
> mirror 1 bytenr 2276825866240 csum 0x8b4dc0d2 expected csum 0xa3bbe335
> mirror 1 bytenr 2276825870336 csum 0x6889cff4 expected csum 0x43b681da
> mirror 1 bytenr 2276825874432 csum 0xe335f493 expected csum 0x6f8d0018
> mirror 1 bytenr 2276825878528 csum 0xc44048d2 expected csum 0x732df5c7
> mirror 1 bytenr 2276825882624 csum 0x51465985 expected csum 0xbcb8b8b8
> checksum verify failed on 1066590306304 wanted 0x79b7d8af found 0x46e46ce6
> mirror 1 bytenr 2276825886720 csum 0xb6c0b96d expected csum 0x74b86fd5
> mirror 1 bytenr 2276825890816 csum 0x53d4b5ee expected csum 0x94580af1
> mirror 1 bytenr 2276825894912 csum 0xef4599bd expected csum 0xf078822c
> mirror 1 bytenr 2276825899008 csum 0xc6c6b488 expected csum 0xebc26a0c
> mirror 1 bytenr 2276825903104 csum 0x8351262a expected csum 0x06f96be7
> mirror 1 bytenr 2276825907200 csum 0x35bef480 expected csum 0x735cb781
> mirror 1 bytenr 2276825911296 csum 0x94c66e86 expected csum 0xb45de73e
> mirror 1 bytenr 2276825915392 csum 0x95fb29ec expected csum 0xbd7fd008
> mirror 1 bytenr 2276825919488 csum 0x71f1c174 expected csum 0xcedea227
> mirror 1 bytenr 2276825923584 csum 0xe77b701c expected csum 0x6c583887
> mirror 1 bytenr 2276825927680 csum 0xc9e6f2a1 expected csum 0xd1f13d97
> mirror 1 bytenr 2276825931776 csum 0x979b4438 expected csum 0xc6b3fbca
> mirror 1 bytenr 2276825935872 csum 0xd997d355 expected csum 0xd14a6bcc
> mirror 1 bytenr 2276825939968 csum 0x391f8495 expected csum 0xf6983d9a
> mirror 1 bytenr 2276825944064 csum 0x20840579 expected csum 0xee72bbbb
> mirror 1 bytenr 2276825948160 csum 0x40149e97 expected csum 0xd94f93c8
> mirror 1 bytenr 2276825952256 csum 0x1f1715e5 expected csum 0x37e610d6
> mirror 1 bytenr 2276825956352 csum 0x36ebd950 expected csum 0x9910580c
> mirror 1 bytenr 2276825960448 csum 0xa686f08b expected csum 0x7cc3bf8d
> mirror 1 bytenr 2276825964544 csum 0xf5445297 expected csum 0x81f00992
> mirror 1 bytenr 2276825968640 csum 0x3f1e035d expected csum 0x1c76c7eb
> mirror 1 bytenr 2276825972736 csum 0x4fd040a9 expected csum 0x5830589b
> mirror 1 bytenr 2276825976832 csum 0x753ce78b expected csum 0x7da10b0e
> mirror 1 bytenr 2276825980928 csum 0x3e9e5cbb expected csum 0x19ab752a
> mirror 1 bytenr 2276825985024 csum 0xde2721a4 expected csum 0x10e2d47c
> mirror 1 bytenr 2276825989120 csum 0x26278f8a expected csum 0xd7bf627d
> mirror 1 bytenr 2276825993216 csum 0xbaee17bd expected csum 0x4197c662
> mirror 1 bytenr 2276825997312 csum 0x38cae044 expected csum 0xb7cfb4d8
> mirror 1 bytenr 2276826001408 csum 0x7877b868 expected csum 0xc8f7443b
> mirror 1 bytenr 2276826005504 csum 0xba7ac34b expected csum 0xfaa4a32d
> mirror 1 bytenr 2276826009600 csum 0x152865f5 expected csum 0xa79878d1
> mirror 1 bytenr 2276826013696 csum 0xccaed754 expected csum 0x4bf5c189
> mirror 1 bytenr 2276826017792 csum 0x5205c2bc expected csum 0xd679bbad
> mirror 1 bytenr 2276826021888 csum 0xa5e8a13a expected csum 0xa1d40c2c
> mirror 1 bytenr 2276826025984 csum 0x0b9d1cff expected csum 0x0c746d0a
> mirror 1 bytenr 2276826030080 csum 0x324af2e0 expected csum 0x53004126
> mirror 1 bytenr 2276826034176 csum 0x0a739ceb expected csum 0xcec66738
> mirror 1 bytenr 2276826038272 csum 0xd6d05cf9 expected csum 0xd59832a1
> checksum verify failed on 1066590322688 wanted 0x3e47a93a found 0x18856eae
> 
> On Sat, 16 Oct 2021 at 04:30, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2021/10/16 11:18, James Harvey wrote:
>>> I have attached the full journalctl from the boot where this first
>>> happened. Note that this happened again after a scrub and a reboot
>>> during a different write operation. I'm currently doing a backup (not
>>> overwriting any of my other backups), so I will do a memory test to
>>> see if I have bad RAM. I don't have ECC memory so I can't easily
>>> check.
>>
>> With the full dmesg, it's much clear how corrupted the fs is:
>>
>>   > kernel: BTRFS warning (device sdb1): csum failed root 5 ino 97395 off
>> 12255248384 csum 0xd6230a4c expected csum 0x723d189a mirror 1
>>
>> Previous error are mostly data corruption.
>>
>> So far still no idea how corrupted/what's going wrong.
>>
>> But the next ones give us quite some clue:
>>
>>   > BTRFS error (device sdb1): bad tree block start, want 9344471629824
>> have 5162927840984877996
>>
>> The bytenr we got if completely garbage.
>>
>> This means, some (in fact quite some) metadata blocks are completely
>> overwritten with garbage or whatever.
>>
>> Considering the context, it looks like csum tree got some big corruption.
>>
>> And it's not a common symptom of memory bitflip, but really corrupted
>> data on-disk.
>>
>> And btrfs-check should detect such problem, if not, you can try "btrfs
>> check --check-data-csum" which should throw tons of corruption.
>>
>> I have no idea how could this happen, maybe disk corruption, or maybe
>> some other problems.
>>
>> Thanks,
>> Qu
>>
>>>
>>> On Sat, 16 Oct 2021 at 02:52, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2021/10/16 08:14, James Harvey wrote:
>>>>> My server consists of a single 16TB external drive (I have backups,
>>>>> and I was planning to make a proper server at some point) and I used
>>>>> BTRFS for the drive's filesystem. Recently, the file system would go
>>>>> into read only and put a load of errors into the system logs. Running
>>>>> a BTRFS scrub returned no errors, a readonly BTRFS check returned no
>>>>> errors, and a SMART check showed no issues/bad sectors.
>>>>
>>>> This is very strange, as normally if there is really on-disk corruption,
>>>> especially in metadata, btrfs check should detect it.
>>>>
>>>>> Has BTRFS
>>>>> broke itself or is this a drive issue:
>>>>>
>>>>> Here are the errors:
>>>>
>>>> Could you please provide the full dmesg?
>>>>
>>>> We want the context to see get a whole picture of the problem, not only
>>>> just error messages from btrfs.
>>>>
>>>> If the problem only happens at write time, maybe you want to do a memory
>>>> test to verify it's not some bitflip in your memory in the mean time.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 97395 off 14105460736 csum 0x75ab540e expected csum
>>>>> 0xaeb99694 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 97395 off 14105464832 csum 0xe83b4c2a expected csum
>>>>> 0xb9a65172 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 97395 off 14105468928 csum 0x4769b37a expected csum
>>>>> 0x3598cf9e mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 97395 off 14105473024 csum 0x7c39a990 expected csum
>>>>> 0x9c523a6c mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 97395 off 14105477120 csum 0xfedc09f1 expected csum
>>>>> 0x68386e9a mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 97395 off 14105481216 csum 0xf9f25835 expected csum
>>>>> 0x96d2dea3 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 97395 off 14105485312 csum 0x37643155 expected csum
>>>>> 0x6139f8a1 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 97395 off 14105489408 csum 0x13893c06 expected csum
>>>>> 0xb28c00a8 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 97395 off 14105493504 csum 0x2a89fcff expected csum
>>>>> 0x4c5758ed mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 9, gen 0
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 97395 off 14105497600 csum 0x7484b77c expected csum
>>>>> 0x0a9f3138 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bdev
>>>>> /dev/sdb1 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>>>> tree block start, want 9343812173824 have 9856732008096476660
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>>>> tree block start, want 9343806013440 have 757116834938933
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>>>> tree block start, want 9343812173824 have 9856732008096476660
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> hole found for disk bytenr range [9622003011584, 9622003015680)
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>>>> tree block start, want 9343806013440 have 757116834938933
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>>>> tree block start, want 9343812173824 have 9856732008096476660
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>>>> csum 0xc096fec5 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>>>> tree block start, want 9343812173824 have 9856732008096476660
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> hole found for disk bytenr range [9622003015680, 9622003019776)
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>>>> tree block start, want 9343947784192 have 17536680014548819927
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>>>> csum 0xc096fec5 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>>>> tree block start, want 9343812173824 have 9856732008096476660
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>>>> tree block start, want 9343947784192 have 17536680014548819927
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> hole found for disk bytenr range [9644356001792, 9644356005888)
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>>>> csum 0xc096fec5 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS error (device sdb1): bad
>>>>> tree block start, want 9343812173824 have 9856732008096476660
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> hole found for disk bytenr range [9622003019776, 9622003023872)
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>>>> csum 0xc096fec5 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> hole found for disk bytenr range [9644356005888, 9644356009984)
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>>>> csum 0xc096fec5 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> hole found for disk bytenr range [9622003023872, 9622003027968)
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>>>> csum 0xc096fec5 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> hole found for disk bytenr range [9633973551104, 9633973555200)
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> hole found for disk bytenr range [9644356009984, 9644356014080)
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>>>> csum 0xc096fec5 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> hole found for disk bytenr range [9622003027968, 9622003032064)
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> hole found for disk bytenr range [9633973555200, 9633973559296)
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>>>> csum 0xc096fec5 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>>>> csum 0xc096fec5 mirror 1
>>>>> Oct 14 21:50:37 James-Server kernel: BTRFS warning (device sdb1): csum
>>>>> failed root 5 ino 173568 off 3875945435136 csum 0x23ed6941 expected
>>>>> csum 0xc096fec5 mirror 1
>>>>> Oct 14 21:50:41 James-Server kernel: BTRFS: error (device sdb1) in
>>>>> btrfs_finish_ordered_io:3064: errno=-5 IO failure
>>>>> Oct 14 21:50:41 James-Server kernel: BTRFS info (device sdb1): forced readonly
>>>>>
>>>>> uname -a: Linux James-Server 5.14.11-arch1-1 #1 SMP PREEMPT Sun, 10
>>>>> Oct 2021 00:48:26 +0000 x86_64 GNU/Linux
>>>>>
>>>>> btrfs --version: btrfs-progs v5.14.2
>>>>>
>>>>> btrfs fi show:
>>>>>
>>>>> Label: 'Seagate 16TB 1'  uuid: e183a876-95e0-4d15-a641-69f4a8e8e7e7
>>>>>           Total devices 1 FS bytes used 9.61TiB
>>>>>           devid    1 size 14.55TiB used 9.62TiB path /dev/sdb1
>>>>>
>>>>> btrfs fi df:
>>>>>
>>>>> Data, single: total=9.60TiB, used=9.60TiB
>>>>> System, DUP: total=8.00MiB, used=1.09MiB
>>>>> Metadata, DUP: total=11.00GiB, used=10.74GiB
>>>>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>>>>
>>>>> Mount options: rw,noatime,compress=zstd:3,space_cache=v2,autodefrag,subvolid=5,subvol=/
>>>>>
> 

