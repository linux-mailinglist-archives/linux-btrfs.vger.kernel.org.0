Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBF13FF9EB
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 07:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhICFNq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 01:13:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34938 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232002AbhICFNp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Sep 2021 01:13:45 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182MsZLi020815;
        Fri, 3 Sep 2021 05:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ywwjQMQ4O6W1csxTwd+MzB2ed3ZQbIIhQtU+XsDlFuw=;
 b=ky6RCkqK+arH9NSACx6/AYfDbzTdm+u/T/6XeIfsBagcE7PjQ5x5j565+fqkq2w0oCr+
 cuQ/LEugmKvomnSC1uOWew6uhYvaPcxPzcO3FT0YsarLZt2NU8KJKoE0oeG8kW0r/df7
 Z0kcgk0gbbAZnDXQ7Jp9S/PXmrfSBC+qpWWIF+ezRsXRTJxB5e6j9Ikf+Q4WJb6QSC/e
 bMEH/hKXkEdzpDCZiR5ryLK2Cn/EoCI0R10L7jzDHVyUfaCQh9gmoaMVL6Za0fPkDSJT
 ZK9HK+sXdgWzJffFVYKPs+jsDneEOgSpLHcc+WIL8Wmpff4BYS6VaGreD1vZxCWtl4Kb SA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ywwjQMQ4O6W1csxTwd+MzB2ed3ZQbIIhQtU+XsDlFuw=;
 b=vB6zqSrSBlOUkrgxE0wxTGyIVP2EM4KZ91Ctk/h199gC4qvE8WD8E6v46w4ZXcwSuQka
 8NFxasYR/VXfhQm/asZt+R+usn4PmbTOpXqFbjWU0TG4uwgO7NQKaVfeyOG9ejicEG6f
 dLjcDugL85G3Cv8NX7fh6vOdvEO2Hyu0urTrX7mhFoJXqCo1ZFNjuVSkGl3t//xZykvV
 pzgKUzOyxpxEsHHIr4oADiHrpiaScOANCGMRWsOiO3c1lgoJNKH8PEDF/HIGfteSNRM+
 7sU7C7nvmv8cpqSpZ5svDUe9ZIkvFzuxx5wR2oIWr60LKAm3hZrTQmFsNhoe+aObQInC ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw0mteb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 05:12:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18355maO146209;
        Fri, 3 Sep 2021 05:12:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3atdywkxpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 05:12:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNqetw4Bm6LqMwFGdNseMcaV6QWh+8TNh3oQ9G+hbgKjkhg2WlH2IYt/ixsCH1KcmO+NCRJE9Xp3sprpffAHBXn12vZLdbYL6+3RqDog0ERlPz2c4/P8tx60ndo+1tlxP91utQt32EvWpZWhZ0Q+WNNe7tgLN6MGU31UxRD/9Oh/RmwslSzV45o44qCKJZBXv/B9Zo2WidybNAasabUpAXT8CchTq3mmXJNuA/nYCSLoNZgPeAvGVIxPHkHKgsdv6Zkrx8bANfw0N8rAFPOD7FvCLOtIik3l+vTvslzFBD8cci00ClVTCFJxYnc2HyDZ5FIT1UjczUb1zE34O1oSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ywwjQMQ4O6W1csxTwd+MzB2ed3ZQbIIhQtU+XsDlFuw=;
 b=e/E3VyofzCR/VpFiOizqStUcu5WBfswpg1DaDqKK7liwnk2y6rhd1xqpQBdLKJkFOu+ZFdr51FbqMg08jgogNaxeMD4o2crenqwMb7xml0He/2HZXfkuA5tjgUnYqEmCdyoQihToSpynToZ7645pQX8gyOv2eVHp30WW4OaPyaop7xZ+Eu8JfNbYjwplOE/mBmWwlpF617OL0sJnaRzJxQcAtlHaaey+LLlRNSHwMg6dzJYZOXz2RBfhrwJOntu7iWHwgFu691VL1Al3As0bOSSYP8ubyGBDfkl+A4mBnH0hBHHze+V4Hvj/Wtpbab4vKwYk8LnVIYLB1yJA9iyBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywwjQMQ4O6W1csxTwd+MzB2ed3ZQbIIhQtU+XsDlFuw=;
 b=O2A1WxKmX27/MSVAaKZXqxt1A+sZtrhsvLrBuMyoYM3gn+1sS+eI/Gu8sR5VySfP+3/gk4Ogb842dZ4h3pbmI/7KPeXOVIyHUI3ywgjQgdbPHA6qKs/n5Oc9lC27Sk6mqM/fIv3zBZVB6wOXsh/HpEu1mmnqKgh9pQA7oxqPt5Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Fri, 3 Sep
 2021 05:12:40 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.020; Fri, 3 Sep 2021
 05:12:40 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: fi show: Print missing device for a
 mounted file system
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210902100643.1075385-1-nborisov@suse.com>
 <b2f9ea09-7fdb-dd3f-2e58-3cdfed65cf12@oracle.com>
 <44803fc4-8f7d-2bda-f7b3-06017f6d5b39@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c3aa7db1-c3ca-2a26-2eaf-c975e2b0af54@oracle.com>
Date:   Fri, 3 Sep 2021 13:12:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <44803fc4-8f7d-2bda-f7b3-06017f6d5b39@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0009.apcprd02.prod.outlook.com (2603:1096:3:17::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 05:12:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93011557-00c3-41aa-5432-08d96e9973cf
X-MS-TrafficTypeDiagnostic: MN2PR10MB4013:
X-Microsoft-Antispam-PRVS: <MN2PR10MB401391711B191400B53CE99EE5CF9@MN2PR10MB4013.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7njjDWDZmFN8Z6JWl5fwk2JIX9PBSf7H2A8Y14cKSCE2w45gHJQimfw6t8KOpNsw+tjWydqUvEHaSk3xP0s5qOVlsXkQaW2rkf61MWpyj1SqQyFj42Oz5Wv3MifoUkWf+d9HQe3qtAUyBAVgJzAgR5DtIx0+JzPqmBNbNnHeU0efmSbJdCcd+aRLZXOZ2q3dalh3t7pzEY26OI9lOU11Wx4zNjWfZZqto8W4OGNJSdyr2NK4dpbdl2ctJ0/JEWXcgtwHn1p1gKif/u0GPRu7bg7r7y/8h/FAV3h+QH4eS8CAhQ6nckdsvnkWqJBol7+GjUL99nZd6J/ODUtTEFzhEJVGtfKcxKSsGhZejTRN6lIvBYSsuDCSUHKfQKjdEcaiGvQpR4XhR4++SakJf1u2s7SUlfQrTuL/qlQ7XmDHDnFCZOVEGtMXQr9zHfKyBUriBhPNx+4xEkpqOKWQRGZrbU8RKZGglVtVqjcs0Vc1QcmpGF4m08hyx8cGbrvy35MpvVEuLPh+w4bR6XxeTODclfq4z0oz4lzlkRPqDgijJ2OcQFg65kaTEBtmnBCZzKzU/PBQZ5Lvw+ETUG2CyAxZilqSfid+yih5U8LIxqMZMIU3ZKX2fBiEer40OCc2V3217R+b9rgcGJ72weZpFhBEEtkeWqxAzftX5aRUbCuPwB8JNDt3CFgVOyCZbs60XMK8zB1wktCzLnzEMJM3KEezhcaPzmC3LI187GHeQ2zCkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(346002)(136003)(366004)(44832011)(5660300002)(6486002)(2616005)(956004)(8936002)(36756003)(316002)(38100700002)(16576012)(31696002)(6666004)(186003)(31686004)(26005)(86362001)(66476007)(478600001)(66946007)(66556008)(53546011)(8676002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXVmaTY5QnJtYVA1aE44citWWlNIVjJmSnMyeG1JTmp3cDExMUl3bDhTS1FE?=
 =?utf-8?B?NlhKNDljb28xaU14S0tzRFFyRkl2SHk0VmcrbUsxUFYwMXpWeUdjdTh6MFd5?=
 =?utf-8?B?cmtxd3pHTytqS3JlRVFjR2FtanUzcHFEUUJUVHpFQlJqSXVPNUs1YTZSRFd1?=
 =?utf-8?B?elFodUpsWWNyck02ZG9KbURIeHU4eU9uV0RUT2xVMW1VcURGRnBKRThzTjky?=
 =?utf-8?B?ZkNIeTA3R2ZIbTN0dHo4ZE01cDNjbEtiQUdYd3JXemJlenBWNWxkTDB6eml0?=
 =?utf-8?B?N0hWeXJjbmlzaVNpa25USmNvaXJxWTVBY2lBaDUyMTlpVnVvZU8zUHBEdFJh?=
 =?utf-8?B?bjc5aGVFckhlRlRHWk5lYTFEdEkzS3dRK2x4blRaLy95N0dnb2pHYmlvUzgx?=
 =?utf-8?B?ek05WGpFT3k0Zkk0eEF3aGNrR1pPQUxmN3QwUFh0MnVkRlJhaWE3TEpJSTEr?=
 =?utf-8?B?aXFaRCt5WnlkOTJPYjN3cnNEWDM0Sy9lNDM5Q3dTdDJxUi8wRk1BZllyZWtv?=
 =?utf-8?B?dHpUUkRYc292MTRLaVBLanhGVmQ2NiszUTh1NHJjd3lPY1B1WEU1akNJU1hF?=
 =?utf-8?B?QUlXR2hpSWhNVVlLU3U2T3lwZVFBdTgyaFRtaVFRbSt2ZUwxUzJSQ29oVnd6?=
 =?utf-8?B?TDc3UkFlck41YVNrekRDREJLOTA1UnZpTGxaazZkNEZrRTdhZEYyNlo4YTZT?=
 =?utf-8?B?bitPMmZhNmtxQ0VPTVVpQ2M1SVA2a1dkQWdGMTJOK28wRzFIZlErZWNFUk56?=
 =?utf-8?B?RDR4Ni9WWklubHdUZ0p6cnhpZmphcExRek8remtWRmFtWnlOclRQamVRYVM4?=
 =?utf-8?B?THFVUUNzUHFkeURqanRhRGdIdXUzam9TQU1hUE5UTksvZy96SE43b2xYRkQ5?=
 =?utf-8?B?SnRxU3J3c2NYV1lnbGFRaEtXWHFpVmhIOFRhY0RhdFAxMmMxY2kwS0lNVGhF?=
 =?utf-8?B?Uzk5RlBDQkcyakFOdVBWdlNPbi9wd29GZm1CWnNGbjAwOXM3bGd5TS9Bbysx?=
 =?utf-8?B?UVFXbXJRTTBzOTNaejZaeVZ4NEVBd1YydllXN1hLT3kzeUwxTDA3T3RNVzhk?=
 =?utf-8?B?RTR2cTVlWk1lN2h2Y0Y0c2ZjaGkzbXZFczlDY3lSMEhDT2N6TnMrSU14MEJQ?=
 =?utf-8?B?dUYwdEZaVVI5dzZQa0ZCMlI1RmdBY2k1eEwvTUhVMWFiRkZhWGRCdVBEZDdS?=
 =?utf-8?B?STR1OG9EazQ1SUtiSjFNZVdlQnNvb2dVNkk2WEdhYUQwOTVUMTZMRG1SS3lI?=
 =?utf-8?B?VlluRFpQTk5ZTzh4LzY1VmR0RkI0b21hN3BaeFExRE9QNCtuUUZaVHlIdjl1?=
 =?utf-8?B?TTRSRDhGK1dhZU8rMWFsUm8zeXhzdC9IWGxNNGFsbitnTWlUbE44elVLSldO?=
 =?utf-8?B?RFcxNGgxRmVKOUEyOURPT25DOWhRdE1NMUZwRVZrdXFPS3NKZUdTTUN5RWZE?=
 =?utf-8?B?UndUQ1U2RWFhMU1kQklhSGRMZzVUcTVXK1BXSlJGakFiVDNvMFJjanpGWXpE?=
 =?utf-8?B?V3RKMFdrbWpWR3RreElTL3lpSndiUnBUeDdHbTBadXd3enozemkxL0piU2lE?=
 =?utf-8?B?TVl2S1RDb3k0Q3VGMG4rcHBtcEdpRVZkN1V3VDFqTmhBTUNkeUQ0ZGtQbE1p?=
 =?utf-8?B?NWZDRU5OTWxFaUJTM3FvSmEvRjBMUUdvNWdLODhLQ3E2M2dJMlVHVUZWaU1w?=
 =?utf-8?B?dzl6Tk44ZGljSUJFUUQ1ZWtENmVtS0lCQXZPWDNwWjhiU1FpUDJxSnR1TFMx?=
 =?utf-8?Q?E+3B+I07RECjg55lSlUoiaVjKQSxW3qQ/qBcjRP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93011557-00c3-41aa-5432-08d96e9973cf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:12:40.2919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fn8kJiGTgrqzZNP2TmvStCH2F+7GiH4CoS8q30R4EfBgoe6qxpFi76VgLmkdoOiS+S65tI/+pg5Z4gPOplSbVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4013
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030031
X-Proofpoint-GUID: 6jlAzNDquwzPmqFl9AYeIkhCFQoMVO5F
X-Proofpoint-ORIG-GUID: 6jlAzNDquwzPmqFl9AYeIkhCFQoMVO5F
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/09/2021 22:28, Nikolay Borisov wrote:
> 
> 
> On 2.09.21 г. 14:44, Anand Jain wrote:
>> On 02/09/2021 18:06, Nikolay Borisov wrote:
>>> Currently when a device is missing for a mounted filesystem the output
>>> that is produced is unhelpful:
>>>
>>> Label: none  uuid: 139ef309-021f-4b98-a3a8-ce230a83b1e2
>>>      Total devices 2 FS bytes used 128.00KiB
>>>      devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>>      *** Some devices missing
>>>
>>> While the context which prints this is perfectly capable of showing
>>> which device exactly is missing, like so:
>>>
>>> Label: none  uuid: 4a85a40b-9b79-4bde-8e52-c65a550a176b
>>>      Total devices 2 FS bytes used 128.00KiB
>>>      devid    1 size 5.00GiB used 1.26GiB path /dev/loop0
>>>      devid    2 size 0 used 0 path /dev/loop1 ***MISSING***


This change has to percolate to xfstests as well. I think btrfs/197,
btrfs/198 and btrfs/003 depends on the existing format. IMO those
test cases still have to be backward btrfs-progs compatible.

Thanks, Anand


>>>
>>> This is a lot more usable output as it presents the user with the id
>>> of the missing device and its path.
>>
>> Looks better. How does this fair in the case of unmounted btrfs? Because
>> btrfs fi show is supposed to work on an unmounted btrfs to help find
>> btrfs devices.
> 
> On unmounted fs the output is unchanged - i.e we simply print "missing
> device" because there is no way to derive the name of the missing
> device. Check print_one_uuid for reference.
> 
> <snip>
> 

