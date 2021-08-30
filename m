Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A4F3FB6B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbhH3NFl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 09:05:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19566 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230119AbhH3NFk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 09:05:40 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17UBNf1k030201;
        Mon, 30 Aug 2021 13:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=O9LKDBMnLgLDxGGc/YB/mU2kdFhZrQtetLk17qnIUMQ=;
 b=WPP0PhNK6Fjel3mJjuZH0diFVlhOCGE1gW6hcA6ZM/isrJGwc+sZdCJtRITmX4iW4Vab
 ungWBdY+FMjr0ZsG7LfjhEDY4IDEZgjYA554j54pGPZ0byxE8l6ml5RFqQ+tNZXIMK7P
 37+VEXgvox4kJ/gZbIAWuDbeejXj1QJJ3u2fWnSzSltH6cSU2M9E5d8GxHFb5ZBHDADQ
 loL/+ripST956lhXOwJcQAl6XTfgn5HPvIb8q6Wo2VrzcDwg5sGo79wxchXf5SMV9j6q
 CimflgjsSiGbAgSNaVzzn2dmj0Lk17ldUTOZcND4Ln0w7VAeY2npFk0q/dYfyWMHim6T zQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=O9LKDBMnLgLDxGGc/YB/mU2kdFhZrQtetLk17qnIUMQ=;
 b=u/8/L8GZDDUb6Jrm8/fLScJeFfRZg/M/ugr26vMmTadKXRYelMMDJOaYaZXdey8dgc+p
 KDZnkNyxm9mKppQeGCovQF8Lm2m76uL+kgMbvc34+yPX1R7A2kBQBOGzXa7/iURz0ljO
 71GYNNRDU+OlaMiNcrRMymggtGKgFnGHLwLgsAkXI/NopGcrDgU0vYNCNIo3snKvABVw
 hMlIFXriexXshanpFniG6i1SXQL895i/ywEpEXSv2BOejwQPGePK11cab/Qy8S1/0V3v
 L6wCbo0IcLgnsZKeMMNEr0lOM7NemKrMYTaMAq/S8Y9nBCOuYQ0X9tCDrF3IVFulhXCY xQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3arcjw9f6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 13:04:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17UCtg8X149537;
        Mon, 30 Aug 2021 13:04:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3aqb6bwkvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Aug 2021 13:04:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUuy2sIGKlZX4my4R9dYlyBwhbaYjPD4SJKztaqPq4P4uZdMttyPjPOooj9zihzA010Z7Ic2OCn85N+cMRB+V7URE83bPp/Df/PlPspL7WiS0XTHS/Q8AYdTJm6DRQwIvMNInEPAPv1kmqDETtG4L/5TwLyrOfts2tqhMiUVCgwI1hR2A2qHzaLNA15PJWmiQakMs1GM0gVvVlZU912i3R3d4LJylKOkXaY5sW1dM4FbO/5d94x8NpDuNKJkB1nve8gG9IrChfgEaQeAlJNy3DdDsL74KNEmov4zTRFbk9lfMuYw4np4nwDdj8q7L82FjQMST+lqqYMwHtYae7xjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9LKDBMnLgLDxGGc/YB/mU2kdFhZrQtetLk17qnIUMQ=;
 b=aGrL0NXccJkB6PdEACroyKiaVieAa/aOmZlOGdmJC9/q2/Hs/lfpYfyGmrEbAXiaWVFOkzIQuE8z82rjhISaI6pEoaEBj9EDUdghp2aT+Kv9C5g4Og5Il81Nrjl2zlZuaH1VJ8Anth1mH++pw7LmZaETNrbkV9468Fkf5/bFeCr9Ci/CnNG7joqpqacIXR2YHQVm8MBwjsxTswjAhVnmpkbcuutdTmsFhfOvxinkPZXbo4omFa4il0I9n04Yqool14QCFNROrYHtoo2musdA3emHM7NX1DBnrmnHLA2R2x9UQFfCVb2HknuEQ8lCXH0GQ1MaThOl+kLg8QcxnZoYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9LKDBMnLgLDxGGc/YB/mU2kdFhZrQtetLk17qnIUMQ=;
 b=c8u537gUsOWlkhlyLyh24Zf+FyOvCP4ZlKTIqCvG4ICgaWRlnjUvcED1eylrICwfenM/tFiUhOatCZVR6kk4bXBZwi0C1ynxgbPSlbnBnJGBwLEim3ZRgRHCo2QbODrl64uWhcLhldEZKZtxLtSEtRi5Uskxt0vUlZHvvCd9Sw4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4865.namprd10.prod.outlook.com (2603:10b6:208:334::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Mon, 30 Aug
 2021 13:04:41 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 30 Aug 2021
 13:04:41 +0000
Subject: Re: btrfs mount takes too long time
To:     Jingyun He <jingyun.ho@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com>
 <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
 <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com>
 <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <03b2a09f-eb06-174d-60e2-be2690b27a8d@oracle.com>
Date:   Mon, 30 Aug 2021 21:04:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SGAP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 13:04:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a281228-1a21-46fa-fe1a-08d96bb6ba9a
X-MS-TrafficTypeDiagnostic: BLAPR10MB4865:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4865F8BCA244D229118E809BE5CB9@BLAPR10MB4865.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6cfqBMwx2JKIw4MZRWlFLWZ8Qwen52zRGFku6wC929eib2PgBH0xueefxj20bAIpNVgemHn/+TmovVWWraf7t51cN2HOEjIxPPAoF5VjrVIQYCwAfeatnEgFBNMvCac4/NC2WETXlmAqBvY87JnuK8j4wvnoOjBUF3Z0o2h+i96YjE2SjzTukHLSmEwwsII+n4035+Jo/B2br+HntMbowt7yzOhcEpRX40lycHIX6Ed5ahjaiowUIyGPzgTVL6sfBXcRv7xBR2kgHT1Ie62tnOhPi34pL6sxOMN5sgRlAZNgBLf2hL8DyQEMn96UErhG+S50XAvtobklbS/8XmRIl3IBIUA1md7/fVsz90znb9JZH+FHpisSUbZnoaG/0mdTYVJaA4Yb+3duJh3kYo6wvi8v/HGY9luWDGYRoSaKIMnGIMODXEHjzbj2/HEYp47yT+68h0fseXW9wLOBbrSJXfy/rmfUIL0bP5X+YftpxooFFHpraR0PJMrmMmkEkYsUe1F57ohACekri1r28oXc3FP3x1Qb6A5mZTLrpMXMmJJ6khJJ8EL8GPEflwYcbfXS8M64LgXL8j8Ziq9pMndHfR+I0db0hncF3QB3gPeCbF/o5FJOhVSlcI+tdZxtGTiCKSWURo1bd3YC0xfod3jId2Z7tiRfDev+Gs+hm4Wzbke99bald0WGfaXn/ycHQLyhkdNxRwXgm4I70QgUdqe8w9MzxIMcvIrunrMZwh/YFTaohInu7f5+E24jFcM+PMgnuizivd+HJcWIjhUBCptYR4g+pgzmyEq+1HS4jyQ6kP3wXmHbm14Nc1q0LZHF4Hg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(366004)(396003)(376002)(6666004)(83380400001)(86362001)(956004)(31686004)(36756003)(38100700002)(31696002)(6486002)(8936002)(316002)(966005)(5660300002)(2906002)(2616005)(4326008)(16576012)(26005)(53546011)(478600001)(8676002)(66476007)(186003)(66946007)(66556008)(6916009)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVR5M1NBdGdjQzdXU2ZMaWgzRnJQUExJM0ZmaThhS0tuUHZLL2M3a20zZFFK?=
 =?utf-8?B?WWJ5dTc4SWxic052OUJhRFh0Q1M4ZnF1ZkdZTy9EZ1p6dGtpMjVXVmFXdTZV?=
 =?utf-8?B?UXlNMUMyWnJLeXhtVTJRbWg5Y0tTSE1NZkdZb091M1F5Z2pUYzBidEZjMkVL?=
 =?utf-8?B?L3FIZlJ5QXExNGlDQzloZkUzdDBOZHV0K2hmbk9FQWZBdmVDMjA0RXNNZnVW?=
 =?utf-8?B?WFdkY1lmTjZaMVlWbUUzM2U2QlYvZnVVNEhWQkhuZUI4dVJ1VXdYQjFvMFRz?=
 =?utf-8?B?MWRjOTViZ0JlZ0xTWU95TG9RNmhob05rQ3VERWxuS2pVK0V4bko2cG95NnJY?=
 =?utf-8?B?amVqOCtJc1loc2o0a2JqRktsM2NYQjhhNGVrN0pRL3E2cTZZSERKK1AydHZN?=
 =?utf-8?B?YWhRRFprc2k1YWk1VzB5V0dmaVo3SXovSGV1blJIaWpLa0pPRUNRYjk4TmVT?=
 =?utf-8?B?d0R2SklmNXE0ZjAyTDVJRHhoOEUxMFhSV2RoQXM4Vmtkc1lvQllTTlhiYmFS?=
 =?utf-8?B?dnVKRXFFaGZxUzJUelRtSlF2c0tKSW5xNkVDS2h3SXY1aXZEK1MyRVUwaytT?=
 =?utf-8?B?aU9rS1pSN1hLcjU4V0hSei9haDBYcTFERzRuRWxLV1RJNFN2TFpoSUhjdmlo?=
 =?utf-8?B?UVhNNmN2QzN6dVpLMElxNUlhK0xGTHNzUjl5OUNTcWtuOUp5eTZUL1liencw?=
 =?utf-8?B?TFM3emJkaUdGNGFzbVEvUXZ0Z3ArbEZ0cXpaZHFvUWg4dVJ0dUU5T2xnSjRY?=
 =?utf-8?B?TUVXcEhUNEJyM1YzbmlINTFmVmVoaFE4OXYwYlNVZlRrakdZc201NXJ0Y3Fl?=
 =?utf-8?B?am4rbEFSaU13cUwvZEFhZ3ZkeVNUMHJKQnVJWHptNGxTMVh3azVqcjJqYzc1?=
 =?utf-8?B?NHdZUk9tWXpQL3NuVm42dWxQazd0SFpZRkJPRnY4KzJkVDRJYWs3RnozU1M1?=
 =?utf-8?B?OVYzaDNXQ1JUdHBhMk9qSXZrTXJUQ0Y2SHdibmgyeDU0d3pMbUVHYWgzbWpR?=
 =?utf-8?B?Y3BiMkIrUEQyUlZpVTBhSmxlRXpYcCtrSW5sTlZlZ0JON01oSGZqTmd2UjlJ?=
 =?utf-8?B?eFNxWm0rRzJVaDZuOHdDaVBLUE1JQ09lN1RQSVZEZmdZT2xMM0hSRktYWGtE?=
 =?utf-8?B?alBKeVJaNlpWWXZqZzF2RkpLYWpWYnhmY1p3OWczaVN2ZVU4Z2hoZGtYMFhG?=
 =?utf-8?B?ZU52b0lQc0Vwd2U4TnNUSW5kUDBwOWI3ZUVrVXlPZDRFaE9pamdNMG1QTkU2?=
 =?utf-8?B?bnJRcmQxY2NxR2dLY29LemFaQnpVdGxJWExxbUU2WmdrbmM2bnF6eEJTZEtG?=
 =?utf-8?B?ZjludFhoL1E2aVovU0ZjQXFIcXEvWENRZkt6a1pyNXNaWk1rb3phVnh1NjIv?=
 =?utf-8?B?Vldvbjk3NnEwZ0l2cTk2S2ZETzNvaEJBb3VSNWx6UGN3ZjRVN3QzQzZkWjBr?=
 =?utf-8?B?OVVEQXRteTljKzJuMG5jSXN6R1FFQmVMTEdmU3hEVGoxdXpkZDZnT3VteU00?=
 =?utf-8?B?bkR1SGdIY3JReGJDRytRU3QwNTlPVDBFbXo1VnFXdFpzZUs1THRqNndpU0Jq?=
 =?utf-8?B?S3BkcVFzMGxjSURFb1cvNi9wdW5odVUxaUVZZVBxYlpqRkVMaWNHSzNkSnN6?=
 =?utf-8?B?dXFtd25MSE5kK2FmdHBQVkdkR1o4UHdZQlZ5Qjllc0NScGphN3FlVnhUOHFv?=
 =?utf-8?B?ZUo0QlpHZHlGOXg1dHlPOWxuZWlYNGYxUVdCajErRUlMdUozd0oyUFJhZTR5?=
 =?utf-8?Q?HNSIb0BghMoWDfp/w9aGctKKCIv1Aj88YJ9yqB5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a281228-1a21-46fa-fe1a-08d96bb6ba9a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 13:04:41.2946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DM/PueI9fcGsvqmXk5jB4I/mbTZzbGKLZbDvTJaO/HkIa7UfTjW8T1VJ/xxs1VooLxOVcI193ZXrkF/JocfKtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4865
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10091 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108300093
X-Proofpoint-ORIG-GUID: GOjMndhGBBSANa2XxusG6si9v4oBFztT
X-Proofpoint-GUID: GOjMndhGBBSANa2XxusG6si9v4oBFztT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

open_ctree() took 228254398 us. And 98% of it that is 225418272 us
was taken by btrfs_read_block_groups().

-------------------
  1) $ 225418272 us | } /* btrfs_read_block_groups [btrfs] */
  1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();
  0) 0.967 us | btrfs_apply_pending_changes [btrfs]();
  0) 0.239 us | btrfs_read_qgroup_config [btrfs]();
  0) * 21017.34 us | btrfs_get_root_ref [btrfs]();
  0) + 15.717 us | btrfs_start_pre_rw_mount [btrfs]();
  0) 0.865 us | btrfs_discard_resume [btrfs]();
  0) $ 228254398 us | } /* open_ctree [btrfs] */
-------------------

Now we need to run the same thing on btrfs_read_block_groups(),
could you please run.. [1] (no need of the time).

[1]
   $ umount /btrfs;
   $./ftracegraph btrfs_read_block_groups 3 "*:mod:btrfs" "mount 
/dev/vg/scratch0 /btrfs"

Thanks, Anand


On 30/08/2021 14:44, Jingyun He wrote:
> Hi, Anand,
> I have attached the new result.
> Kindly check.
> 
> Thank you.
> 
> On Mon, Aug 30, 2021 at 9:27 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>>
>> Our open_ctree() took around ~223secs (~3.7mins)
>>
>>    1) $ 223375750 us |  } /* open_ctree [btrfs] */
>>
>> Unfortunately, the default trace buffer per CPU (4K) wasn't sufficient
>> and, the trace-buffer rolled over.
>> So we still don't know how long we spent in btrfs_read_block_groups().
>> Sorry for my mistake we should go 1 step at a time and, we have to do
>> this until we narrow it down to a specific function.
>>
>> Could you please run with the depth = 2 (instead of 3) and use the time
>> command prefix. Also, pull a new ftracegraph as I have updated it to
>> display a proper time output.
>>
>> $ ftracegraph open_ctree 2 "*:mod:btrfs" "time mount /dev/vg/scratch0
>> /btrfs"
>>
>> Thanks, Anand
>>
>> On 29/08/2021 17:42, Jingyun He wrote:
>>> Hi, Anand
>>>
>>> I have attached the file.
>>> Could you kindly check this?
>>>
>>> Thank you.
>>>
>>> On Sun, Aug 29, 2021 at 7:47 AM Anand Jain <anand.jain@oracle.com> wrote:
>>>>
>>>> On 28/08/2021 19:58, Jingyun He wrote:
>>>>> Hello, all
>>>>> I'm new to btrfs, I have a HM-SMR 14TB disk, I have formatted it to
>>>>> btrfs to store the files.
>>>>>
>>>>> When the device is almost full, it needs about 5 mins to mount the device.
>>>>>
>>>>> Is it normal? is there any mount option that I can use to reduce the mount time?
>>>>>
>>>>
>>>>
>>>>     We need to figure out the function taking a longer time (maybe it is
>>>>     read-block-groups). I have similar reports on the non zoned device
>>>>     as well (with a few TB full of data). But there is no good data yet
>>>>     to analyse.
>>>>
>>>>     Could you please collect the trace data from the ftracegraph
>>>>     from here [1] (It needs trace-cmd).
>>>>
>>>>     [1] https://github.com/asj/btrfstrace.git
>>>>
>>>>     Run it as in the example below:
>>>>
>>>>     umount /btrfs;
>>>>
>>>>     ./ftracegraph open_ctree 3 "*:mod:btrfs" "mount /dev/vg/scratch0 /btrfs"
>>>>
>>>>     cat /tmp/ftracegraph.out
>>>>
>>>>
>>>> Thanks, Anand
>>>>
>>>>
>>>>
>>>>> Thank you.
>>>>>
>>>>
