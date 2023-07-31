Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29027693FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 13:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjGaLAV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 07:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjGaLAR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 07:00:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF6683
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 04:00:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VAiElU011756;
        Mon, 31 Jul 2023 11:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/SgODI5IMJng0GhB9iFmByPmnvaKjCytx9heHr0dEVU=;
 b=29UxnYnJRRsgX2jY/Eb205YUeSu05TUL4beH3cVFklSy1VTgueWnCAdDJahO6jI7GvnC
 Y/ATvhCp9MImUujiIHt6CKDjJ8Z41K9VF28jgxRmxK8P/uxCFPRqgr5mckbgd4cDb1DN
 yNj6EGuvbRfOuNWPODsa8YmSzcbCdemxwqc73NwGPARxFZFbm8fQvF5Kw4E0bluVcAOV
 IQzWQFLEvW2agfgwQWF0L43PILPY/qwsz6TyKA2GHlqMCwghw5mpcble0WnVKuGyjGID
 5eBlIcVEDJ7KgTXX5Si9YOkVgNggkfJHC31W1HxZDhy+SGv78ycvUCl1Lxstkv/jzCvR Dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sj3taw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 11:00:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36V92pI4013621;
        Mon, 31 Jul 2023 11:00:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s74mfnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 11:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ9HHwoMHtcldhrbExdUA4LGK6BhIcWbqTnvuF/iv8JvFh4TVlzkdX9gQeEkONb2jU48crwaFUV9e0w1UC3sU0rMGqv/0nSS9d4l3YtmWAuIfP/mFTkNT9BMn65YzLrcYxa/s9HoeH8TuEBrTQjqnoFqCDeMhu0e3JcFr9pV2OlYKy5zvv76alNr4XNCQj818+LvdsGgHzCIwTqjKHkvnTmOVl+bQQ5etG5Sa5q+WfZs4Kyo9G/1yVRUSjHRzfn6RpHaIZ/Xh/zjW0MJNWCdq1n2BfjSzAqCR5+IREXDCD/GaniWJvMPzwbVMe1FnarWxrbzmJ8DsMUaCLGExmk4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SgODI5IMJng0GhB9iFmByPmnvaKjCytx9heHr0dEVU=;
 b=goqKvAU1UD9ElIwNJnRPy6TRfkvfAcvC4qs1TqV3z19HEExmfa7O69g4YJneZbM18NvDsKwxdgLewlN9KTjUJfBnhRuwpUFor5Rl2sIK8dbjKNx3cbhelId2JK/N8LgkrpiL6HIriMGTFA1mhKqmElgG3AG4+lfyYyLe5RBgRO8w+hxpxsOcb110hkOkSAhkEbuoFnCrpPlZyy/RXFZLPvPigqO1+BVZ2mAkuLa7yH/SbzK+zMvio9c9uNCTk2dnFLp6The7FSKCyGIbsMcwFUcKOunqhZS7uJlamFtI77I6JFk//9AqSTY2lSFGgoAWteV83wu4R3ZzCQkqLHc0/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SgODI5IMJng0GhB9iFmByPmnvaKjCytx9heHr0dEVU=;
 b=HqoT37nr5yBjrNLsxfv6rYicyAiP8shS6pifmK1iaHcpjGrXHaQUugyJDM1BCyyTsGBeWLMabF+n3pA+Gh2lx0fH6bGcqT9bZmy31t5xmmpfxWjGD6bhi4SGo16ShgrkBtnsPALAPU/aIZj2nbXaKIAKmOaOdBgp8VNRMGrldNE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7908.namprd10.prod.outlook.com (2603:10b6:610:1d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 11:00:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:00:05 +0000
Message-ID: <392b35e5-a102-f5a9-20d1-1c190c467f36@oracle.com>
Date:   Mon, 31 Jul 2023 18:59:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/4] btrfs: simplify memcpy for either metadata_uuid or
 fsid.
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1690541079.git.anand.jain@oracle.com>
 <ae10e7c26537465368445d379c660fc8be62ad8b.1690541079.git.anand.jain@oracle.com>
 <CAL3q7H6nGQWdvpNr6GUC_4eGpveH5ttdqn78XXFw0Ux-A+7MLg@mail.gmail.com>
 <20230728183907.GK17922@twin.jikos.cz>
 <8507d459-ecbd-b123-d8ae-233d2efa3ccc@oracle.com>
 <a5fa2ab6-f72c-5f53-10d6-f08fc78198f6@oracle.com>
Content-Language: en-US
In-Reply-To: <a5fa2ab6-f72c-5f53-10d6-f08fc78198f6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 3516316e-ae9b-4f2e-2bda-08db91b54c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvce70Q6bBovQqedAQ/e94a0zDEZZMG9cpWB7yQNlW8AiuoogBWmaolQ4BHgiqGg7w89DvFkkT78vbypb9eol8hNk8ZYser//mMzT+t/yl9zj4gZYxeJh3JjnghT/0okf2h3ycrEqyEUcr/mldpNGrfYze8T4Fil0FIzE2XiWj5nVHDGWeyVSDHxhEh9luw1ee2gikCMhieFkY+3vH6aAdrnEf0hUZQ19gkXPZNvYdzV0uJF2w/VsDP8r/GPH+UAst5aMSDb8dA1vxPtUQPpqRAOhVO/aPnzXnMNtg1LYMjd1O8bzJNv/jDQULp4/eMEBeU59fY9J4f7WRNyXx+LjAc6vVolAypfeRy4+AFrF3a09KkfYDxDMsloxQaOfiut0XsqS4bmkBzIXTL7E9TCEB9NmuJvlVy+BVa8ENY7b9dMjLYe5iV6SKzrmNHZLD5bnusrSYoSS6TTFVVnEvamXbAI1vrnd3kBH29EKFu7GiHAjYqs/yZMz4wIm59JZK4dslZU3KZ28zP+5IQQ2wHnG0VJtcfIPtmo9PFpWs+T8VVpbTpdXJhgFlOSHra4VKagssXkR82AUUzacIXOrWigT+B4+R9uwx+D6pfPGto2YUetmJguR4iOqecUimZae3/PDgvbhicZZif8l+WStvJVqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(2616005)(36756003)(53546011)(26005)(31696002)(6506007)(6512007)(6666004)(6486002)(31686004)(478600001)(86362001)(38100700002)(83380400001)(186003)(66556008)(66476007)(41300700001)(4326008)(8676002)(8936002)(6916009)(316002)(44832011)(5660300002)(2906002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wnk4V09NUFlWeHdPSWVZUEd1TnBSMjRhemlKWjJDS1dyYUlPRU9OcEFGVWxE?=
 =?utf-8?B?bDRnTllXVUMvOGdNRnBxNHhZc3RzZ0RqL0hLVy80d3ZEUmxwc2xTbEhzVTQz?=
 =?utf-8?B?bFBWZlVnckZDQTMxdVQ3ZFp6c1BacTJYczU0NzZzN096M1grcDVzYWNXam95?=
 =?utf-8?B?SDVQcmFsc0wrVGhTQVQvYVlQNXNZOUw5QXcyeXlHQ2hVdVpuc3pPaExDWWZV?=
 =?utf-8?B?TGxEZHFhQnZhWmU5UzNxdUxuRWluRnpic0MrVldXNzNaVDJ4NHV3UExSR2hP?=
 =?utf-8?B?QTdzckZrazdXVFdOSC81cGhUdmpBVEpJcUdaTFEvTVJoRFhtZGVPZGo3SU9U?=
 =?utf-8?B?Q3RyYUJlbXo4eTNqNVZSRURZNUFIVWZ5WktDZVlQTUgzNHlJeFVObjFuVEx6?=
 =?utf-8?B?b2xhVFpjMmpNa3puMnZyNjBVdVRXdjBSOVprWDBaUDRQVldYTTVDbXN6Q0ts?=
 =?utf-8?B?NENKMEpsa09NQ1NRbHJ4SURkM3ViRkVrWm1HT0MzbUc2WjJlT1NvSjdMVTBN?=
 =?utf-8?B?TEVPZGM2VjQyVit1SUFlZFVLY00yMTVxYVpTZE0xdWlJM0tCaE5GbFNWR2s3?=
 =?utf-8?B?c2V4QmlSaG1kaEhxQjJGSnh3MUFhWk5RNjJFaWd3VzZ1enBQVVJWNFg5R0RV?=
 =?utf-8?B?SjlUbFlPSVA3TWxPbnFVWGx5Y3lmNGdYYzFYV1RlUnZYbW1qWWw3Q1VPZUNL?=
 =?utf-8?B?TGs0NHlLZmFldkFiTHdybmo3Q1dqUjV0Yk8vS0lNYnlQWXlCU1hneE5May9m?=
 =?utf-8?B?VHhKejIwL08vU1ZvTU1xbERoZHhMdTBiWUtNNVZ3THlEMDdOa3d5YlhRMTlY?=
 =?utf-8?B?eUNFUHFUYTl6bVV4QXJrTzZzT2ZzOGhDWXlxOHRVWEp5YlBKVEFSK1BhN1Jr?=
 =?utf-8?B?VmM0RzFGS3I4RGhLeE5zdjlJRTlUY2U2RGlBV2xuTlVhWm5RM2ZHL2ZnT3Ni?=
 =?utf-8?B?Uk94R2JXdmRYS1MyYUtBaHljV3NtNmZhcnE3SW11ZHdoVWVNSUxaalFRN3lp?=
 =?utf-8?B?VWN5UlVqSjRVOVFHLytoYWtQd1JwUFg0QVdIb01maVg5amxOeXdBZi9XMUZ4?=
 =?utf-8?B?ZStpbWFLV2ZmMkd5QTBZRlJQODh2RzlZQm5SVTQrTGgvNkdqV1crd3lhbTAr?=
 =?utf-8?B?OXdMVnYvclFsNFZ5OE12V1RZK2tjT1ZscTlPVGZibVZOR1ZqT25HYTU1K2Nq?=
 =?utf-8?B?OWNkOThIMlUzdEQ3Y3RpSk9LeEN4QXY4QjYxYXNLcks3VlIzMnhyK0xsQUhr?=
 =?utf-8?B?b2lVUE84UTNpbElDS2h4T3IrSHoxZS8rdnNCQ2pKWEY5elFWeWttYjU3UDcy?=
 =?utf-8?B?OTJGV3o2T0EwZUlsTUc4UXlyY0VNZHI3dUVOS1N5MUptMHc3UWtTU0piVTBv?=
 =?utf-8?B?YTdVazZ4L0hpTUh6SFRUdkpoSlc5QWtGRVR5NWJUTW5UWlhRK1hJc0dZc1c0?=
 =?utf-8?B?V2o5SVorZ2dMSXZ3RHJWUkpuWU9ZQmhlMHplMFBXeWlLMVZWZ2tUQjNNNEhv?=
 =?utf-8?B?K2YrRmFlWVVtR1ZLNkh6TWFOQzh4a25OdUx6ZG1zYmdOZkdnMEF2L3c3empj?=
 =?utf-8?B?NEVyK2JjeG9MeWs4S2xFTkdOSEJPeXFKVWg0cS96TGVKVEs3UEpmZ20wUUNV?=
 =?utf-8?B?NG1hUEU5RmVYSWhGWUp1NHFGdGY2MlBiRGhSL3JlWTdRL3k1MFdHZ0hxV3ox?=
 =?utf-8?B?THNJTTJGelhzOUlWc3R5b3dVWnFDZUxHYnJPTjBMb0Uwb3JDQ2pzbWVyeG5u?=
 =?utf-8?B?WENLVEJEVWpPRGJ5VkkvdVFCVFBzUTQrZU01eWExSTV4UE1EZHdMM2RzN1J5?=
 =?utf-8?B?QVZrOGNFUWRnYkZBUWp3cFhWNnlWTjZTZ2crTnBHdTNnckU1V0RVUkVicTJp?=
 =?utf-8?B?WXRwZXpGL3U1ck4yV01ralloaFhDS0xpdVdlYWRNYmNybXU4WUFIemtFbGpz?=
 =?utf-8?B?emgwYnZySmNrdHlsYWRqOW4vYkgwUWVxMWorTHhqR0twT1diamFhQ29sRk9r?=
 =?utf-8?B?RFlVbEZPOHFubEZzdWZ2TXZWVUxvUEE2S2I1MmJCbVU4d2RGcXE1WDM5MFEx?=
 =?utf-8?B?NDhMNnA4RDRwVDRwcVh0c0VjcW91VHFwR3BMTkthZk56NjlrSEVjTEswMXJ6?=
 =?utf-8?Q?9mgOxIHJe3mdV9W9U53lDYqIb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: asLvyixqTCarwH5caKStpJG52lc82XLrNGepiqA0fPSlUUKGRVfYsAbuOo5P+Aqm7l04xPMaufzYVMxElcJR7AhYZ2dXs/OoNB7czQFlkjjNDFL9rlF0qdTQyzcG0oOP7sMAwChDV9xJX3qDgH7rbcmSNXhcouD5htO0hKOnV/HOqZbGpUSeixk2m/MPbUXg4ccosoKLdggIITbJjLuWDplamF8hbrYS/CNGdQRW5NQQOgLpW4V1Xb6RUvsqxiYQl+9j2TVVnqj5BEtb3f2iDDiddnrSrSy3bLTXoW0owSVuAnsSCUJBKmpEvh3jISoWp12jE5hPj5C3dHTS8hidri1qKArSsFa1ByYxQcpPcdicmsNg/DfHWwOoMHXFUYfP3Epsqv8VSeZwQVyd0Yo4i7J5+3hyUDZ3B3arLPHpAY9FFbBMJU4EXMUHYM2Hl35mvEkrv4MKqz/tDgoEPhZFLsU4pFUh3WgnrEc2qDbXG/Zm4bpUn9uqYv5B0O/7J7DS7BwyzJ6pMnpVpN0BDwX/okMbKkusyrEaK53lyWdDi/C8Z1Y/q+v08qylowh7keBzrtThva/ZZUsoMv6lZQ4knD/2fkDBzPpAHT9I2jSiLDHN3rHsbnbYm6fI6ZxX3q63CMk5aAMqo/YQqQ01Xp2s073PY8N6kodAvCK6Q9BOaPCWxi87NksV3tsvMvQ9Kf3dXwtY5dn2nrWtwqY0J75jjG2jA9Rt8R1cMDsXVA4dMZ9Sdbe7N62SztrSEgFPjAsAAWuF3EbEIN0oDpElN79fXq2+n/JvcX9KrPIbmo1oZYwpC5hsDrwx+vb6zRzNs+cT
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3516316e-ae9b-4f2e-2bda-08db91b54c20
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:00:05.8921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1P1frOqD9Ya4kddovZXpwu72Q9ijpZp4e9I/5OZ0iYUIl//W/V2p/09yc8TP+FvDTKZ4Y/OCXHcvh+DLTniZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_04,2023-07-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310099
X-Proofpoint-GUID: 6Kqq0actT3ISkMLcLbOzjubG5IApyYId
X-Proofpoint-ORIG-GUID: 6Kqq0actT3ISkMLcLbOzjubG5IApyYId
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/7/23 12:22, Anand Jain wrote:
> On 29/07/2023 06:23, Anand Jain wrote:
>>
>>
>> On 29/07/2023 02:39, David Sterba wrote:
>>> On Fri, Jul 28, 2023 at 06:40:39PM +0100, Filipe Manana wrote:
>>>> On Fri, Jul 28, 2023 at 5:43 PM Anand Jain <anand.jain@oracle.com> 
>>>> wrote:
>>>>>
>>>>> This change makes the code more readable.
>>>>>
>>>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>>>> ---
>>>>>   fs/btrfs/volumes.c | 12 ++++--------
>>>>>   1 file changed, 4 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>>> index 5678ca9b6281..4ce6c63ab868 100644
>>>>> --- a/fs/btrfs/volumes.c
>>>>> +++ b/fs/btrfs/volumes.c
>>>>> @@ -833,14 +833,10 @@ static noinline struct btrfs_device 
>>>>> *device_list_add(const char *path,
>>>>>                      found_transid > fs_devices->latest_generation) {
>>>>>                          memcpy(fs_devices->fsid, disk_super->fsid,
>>>>>                                          BTRFS_FSID_SIZE);
>>>>> -
>>>>> -                       if (has_metadata_uuid)
>>>>> -                               memcpy(fs_devices->metadata_uuid,
>>>>> -                                      disk_super->metadata_uuid,
>>>>> -                                      BTRFS_FSID_SIZE);
>>>>> -                       else
>>>>> -                               memcpy(fs_devices->metadata_uuid,
>>>>> -                                      disk_super->fsid, 
>>>>> BTRFS_FSID_SIZE);
>>>>> +                       memcpy(fs_devices->metadata_uuid,
>>>>> +                              has_metadata_uuid ?
>>>>> +                               disk_super->metadata_uuid : 
>>>>> disk_super->fsid,
>>>>> +                              BTRFS_FSID_SIZE);
>>>>
>>>> While there's less lines of code, I don't find having a long ternary
>>>> operation in the middle of a function call, split in two lines, more
>>>> readable than the existing if-else statement, quite the contrary.
>>>
>>> Agreed, one line of code doing one thing is readable.
>>
>> My POV was one memcpy() per destination argument makes it better
>> summarized at the function level. Anyway, I am okay with dropping
>> this patch.
>>
> 
> I missed something. I have a helper function btrfs_sb_fsid_ptr() in the
> patch 3/4 which reads either metadata_uuid or fsid as per METADATA_UUID
> flag. Which in that case the code shall be
> 
> memcpy(fs_devices->metadata_uuid, btrfs_sb_fsid_ptr(disk_super),
>      BTRFS_FSID_SIZE);
> 
> I think this is better?

Sent v2 with this changed. Thx.

> 
>> Thanks.
> 

