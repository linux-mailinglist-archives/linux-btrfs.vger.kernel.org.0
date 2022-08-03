Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8F1588742
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Aug 2022 08:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbiHCGTe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 02:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbiHCGTd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 02:19:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822E84E873;
        Tue,  2 Aug 2022 23:19:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2735TA24005102;
        Wed, 3 Aug 2022 06:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8KPzX0v0rwIICCD6GHl2ZHnlIcPdfZMgyBLjyMYdz4w=;
 b=ZSnvUxP5eNKyvJkU1BkUt9PPXyiYfvX800MXzVDMBG5KVN6ABq8ypR1PCXJdcOdw/rY9
 3EnIhlaGEtkNI4RNaeNKT/J3uaQiBloLc1XPTmLIMJdHdjaeQSpXKyYr9bzIK1uEgspv
 lPw4DO5En4rLg2HG/reZcWHlVGKiV6VfBh+lNv/P9BaPHPhD09WoQG2JL3BEuRBTiyEe
 Ix4w3tIsgXYo7VrRsWZObjElIneVH9VixjkCaVOa/kFJ+fq6c1EdRr02wJVPmNJDCP45
 +WRcxoFqw1INuDHFTFg8Bwfmpxf8zSewk79xtsVX3Z1TkLfGKaP9OaKqeM9GyjV26ce7 OQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmv8s8xt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 06:19:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27365sVa008364;
        Wed, 3 Aug 2022 06:19:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu32rwyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Aug 2022 06:19:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDIWOan1Y5PmYJo0geiruvX6nx07f+800AklcfclhjY42StIMeARGNGZJnGQdTApH0zntZ83D127uOnY4fDKvIpjnOrAG0eZEKJsjbF4YeqI5ghs9mAnOLSbYxWO4okL2BwI3UoHg56QxPuu5jOst8hE7+YbXE+RJ/gy6yb8E0xVj6PTMWroVaeg0ZltYyiYOD0EwTV4ONi1ksyAhAEi9ohVIhyxFr92UG9aSo3i3QvrdqsvGjwAmAujsvSbQm9AB2WL9A0si1HA91YMY5qIh1gVrWEP4VJlEQYM9L8PubaN1tAc3zJtTqJuubu5Xy532DeuECyCgNBLJoYUpyqw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KPzX0v0rwIICCD6GHl2ZHnlIcPdfZMgyBLjyMYdz4w=;
 b=VeXqVMm9KN+dAqKRpccv4mc1nKbkoj+O4S1HHDVAf0xXbDyLEalygPh5BrztKZWFIJqdF8iRDAs7K8TFJZF7w0gMPBLx/YULRbXBtHAqqlY8XcnNJ9uPHJStYCYHQRgo3bTx8PBwQN00S/8V5UNim3/RXK40qL4BxwC9IS60TxkIHHteAd+JXfFk0vBnNn+NGrOLTGtFX1gudoeoGuIbJujmmPsBE9klZ1AIt4rBaam7rWlUQFHvw3EH+VfhtT1EwnQx2ZGqOQRZQ5eBRXLLEfqTOCRe4wF8ZHhWrC4ZWOg8sqbExYwtb+BnwEkIKi+oqGyYsVGKvhSOkqTmwZgqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KPzX0v0rwIICCD6GHl2ZHnlIcPdfZMgyBLjyMYdz4w=;
 b=i/ugSnT2CFozq7+EAFjc6dZer2hkdDwQpwmnAtxO47082VltrYDItuP3O9tN2BdTu0LoJdEWH10/qVMUFR3MBv4b5A2MfYojP36rxOWOavhKsQFJT2hZAYkdb0v9hokuCYgPMqwO1lb6kTPLVGTGh7GfV8aRfZlGBC/C925J3+s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4733.namprd10.prod.outlook.com (2603:10b6:a03:2ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 06:19:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 06:19:20 +0000
Message-ID: <da885cc8-1f60-d586-b8c7-f3f51f451ada@oracle.com>
Date:   Wed, 3 Aug 2022 14:19:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH]btrfs: Fix fstest case btrfs/219
To:     dsterba@suse.cz, hmsjwzb <hmsjwzb@zoho.com>,
        Nikolay Borisov <nborisov@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220721083609.5695-1-hmsjwzb@zoho.com>
 <0c2337c3-2b39-c54c-27e9-dd4f0a99cf71@suse.com>
 <1aaff0ac-436e-7782-081c-3549ff3d8c8f@zoho.com>
 <20220726183824.GL13489@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220726183824.GL13489@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87fadadd-83f3-4f5c-89df-08da75181a31
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4733:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBSKDKh/DdbWe+rOh9NAZZLgl6u4SsM9noxfzyRg2opaGPnQGejNPccxB/OU9kzX0QQrYrG40RDaVicAAYW/g15NszWSlGGsLFYIs7L5nsYWj51zjrArCnsSjL71BlVxN5O4o2IjACoUJXsr7imd/I3cVnd9bk25phO4HHH5GWMVu4yWdddsHwzdrcQMaN+uXoLvQO7n2wz1YgkUa5dytZpgfrI+uxUoQGhoDibnjTc+yF2OREIeiRmsPu29ASFp8Gthr/0SH3VQwQ0VFNKcLQlsLpRBivHAtjg5MjJFE39bbKj/x+8h8fwFhC3B6jKaGQ9hzgVNx3V9iHrXCs31nvOO1f0SqV9TaK9nvEobr6ItMqH8oxcFtdKV/Nua9eLox4YMb68RYoC/PfLoNzhNRbvH0B2s8ptK4Z4VuiopwXp5g+ZyVnWdKahoq2LV6cH2yVubHOKW43nasPgzhD+fW8VGPWeW3CkDXkT/Vxb2BkTCf+q0daW8vLaKhzSs3dShpUthGeCnjKMyonuVq+sfBziZx0ntByJumQ4MQ8W2E/viJoGGzzA6qZSyjbAwHoB5+ek/dNzbncY569qc7n+CpqGkGMJsyQBS687Ms4ZMxBEUdqTOCHUh3DXtfY2N6oIzdI7LC9CHT9TZ3DbcVWaoLkPKgiw+gQyFxTFW0iBLWr6dary5903R0CZCrHTJyOWmenMk1KjrWyskWnT7FKVj+tAZ3EWdTpE3//7Ui/o25OS+0rQgqZtx+qnK0q4nWkj8Pu0tTlqg7SD3R9WWvYilB7YPM9mBg7PQz0EOJnnIQxXjj8r6ryL5zQLh65PtcKmJQK+01tWHJ17wLIvJG6IcfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(136003)(39860400002)(346002)(376002)(66476007)(38100700002)(6666004)(66556008)(316002)(66946007)(44832011)(5660300002)(8676002)(41300700001)(2906002)(8936002)(6486002)(83380400001)(36756003)(86362001)(186003)(478600001)(31686004)(6512007)(26005)(31696002)(53546011)(110136005)(2616005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVlPRlI0SDlxYTJUd0JjYjMwZXpOK0lRSFJUbHNydUtIdEdwV281UFYrZ2Rq?=
 =?utf-8?B?dGNpQ3RrYzRJUVY4MHVyRFcrV2lWMU43VGc5dzd4UGNiM0NZOExlQXRHSDVQ?=
 =?utf-8?B?a0Vic3o3anF3bmlHVEdIS3JxUXRNWE9IM3ZMRHVwVldPSFpNcFBSUUN4amh3?=
 =?utf-8?B?V2g1SEgrUVZxMWMzeWhVcE1DVHVMOWc2cHNUWG1UZC9hZFV6a2NjR2xZdWt1?=
 =?utf-8?B?eXhwdWdGWUZUMDN4ZlY1dC9tOFpnamdBR2lUdFhFbVk2NFhTVXk1RExCSmc4?=
 =?utf-8?B?SlZNbnBWaTF1QXRJcElCR2k2Y2o2NmNLR0tCWllwYmtvZDBWc21TQnd2bm5O?=
 =?utf-8?B?cEQzVkllS0dwbFFnS2N5T20wMlN3ZGJNaXAybVpiNVg3b2hCcklxNHBsck5P?=
 =?utf-8?B?aENQMENaTmhKYWNPWEUvcXVodVZVVzd5ZkJLV1FiR3dHbzRaYzBKbllrMWRm?=
 =?utf-8?B?YlM1a0JraUtENzluakpiZjZudlNULzllWXp5cFlYb1pNOXN0bFc3aElFZEJJ?=
 =?utf-8?B?ZTR0SEVaMUlRQ0hvc1VmdWl4eHlFamZRNXFLMEFjcTRqY2RldXBIMXdNd29W?=
 =?utf-8?B?bUpkdTJGL2tXSlgzaU02cFZyMkNqL3gwNllmRGJENUhya0xzOFF0ZVFuOVpx?=
 =?utf-8?B?NXlPU2FuL2RPc0Eydm5lU1M2YjJETnlTL0FRRmJQN0JZMk1xL1dwdWprNHZR?=
 =?utf-8?B?Vm90SEs1SUNiT3RoaDJkQW0vU2ovQjRiRU5MQkczKzhmS3FXdlRRNW0vR0ty?=
 =?utf-8?B?dXBlRUpDYlRoTTlXT0xURXliY0xLNnRpU0lEcWVwUFVldm8vbkpEWXIwVmpT?=
 =?utf-8?B?Y2FpbHA1RTk2Tkl0TmJTeGlPZGxuU2lSd2VZTU9pTVhOVWVDR0ZzR2htS3dv?=
 =?utf-8?B?b2lTeXJiSVNPWVpkd1h2YzZrMWJtOElVMGZRa3EyUXFaa2pXYkFFTG1RODlU?=
 =?utf-8?B?WTZPUVdSM1ZPWnpSK0cxNnZEdzR3MVJvbWZuSzNidzdRK0s3Z1dWODZCMUpu?=
 =?utf-8?B?a0hwOU1icXEwZ2RIdHU1d3NiS1h4WE5xK0RrSVFmU1pwd0YyQWZwMWYrUndI?=
 =?utf-8?B?WTBDbkZvamNNdndSb3NtMVZZQmVaT0hPUW5jU3hnTWVvdVE4V0dSS1NsSjNP?=
 =?utf-8?B?UHZXVU9pdHByTXBkcVBCeHVwK3dnR3g3NW0ycG1KSlQxa0c4VlBpUTNvWGl1?=
 =?utf-8?B?N0twd3BucWgrTjlxQjFyb0lIZHdvWkZaYjJ6bi95T1pqWENvbWZ1RDlCa0hj?=
 =?utf-8?B?dVRYdGgrN240Nkp4N1NXRWpPMXFwaktHb2ZoMDZhcERtcW02Z1lZT3pFcUpN?=
 =?utf-8?B?YVRPTDQ1ZTYxdnphdXVyeW9VTlNDRDhvMGNwdTdLaDhZMmdrN2JBMUJ5UXpP?=
 =?utf-8?B?cXNnRlNNbXp0U1lSc3h0WGZXNFF4YytISnJBVW1OMndsZkcyc1dScG0yZk9z?=
 =?utf-8?B?aElFZmVOTndleXg4a3NhaGhwcXNhVndkTnVtNEZBYlZRNmY4NVNGWDNERWhq?=
 =?utf-8?B?QzdBVXlTUlhHM1lHb2JlaDNGeG8zRy9DbVJOSlRpUXNqaHNabjB5MGM1blk4?=
 =?utf-8?B?Wk0xR0pzM1VFUWxXY3FvZVdlMGQ3NTJUZHE0UlNDQXI1YVEzRUNKNDdrTzZu?=
 =?utf-8?B?MnRSa0JkWURoeW9qWVpUQUZLTFh0Z3hWcWM2SHozQ3RMdTBzMS80UkQyb0hI?=
 =?utf-8?B?Z0R1cGVEanFUMndDZmtmZ1dLSHJyRmFnbEV1Tk1HOWVScDJoVXNDRFBrK0c4?=
 =?utf-8?B?TnBnZk5UVU80MHdiYSsyTlYxR1hwS2hsMjhZcU5pcTRrdUxZbjBsS0h0VVRp?=
 =?utf-8?B?aG1xdEwzSzA3M0VSeDZpR3R2WGxnbTVhMlRTcXRUaHJUZXAzc0o3WmJVV2tI?=
 =?utf-8?B?RjBTMmwvbnFibVlFWEtFQ3JCWDlsSGNVemZoQi9Ca1FjbWVXL0dWckNnblUx?=
 =?utf-8?B?czRKY1JqRE05Q1FzcGhjRFdxS2dOb0FDdnFTREd4Ujd1emZveFY3Ky9oK1JJ?=
 =?utf-8?B?MWk5c1FET0VZRVoxZFhPNFM1UG0zR2RoR3hDb0I5QWVjd3Fvdm4yTG9CcGNP?=
 =?utf-8?B?aGxKUm12enNWanZKek0zaGFBUk9SdktiU2tVR1dGNFRaNUY3QWlxUzNSQjBw?=
 =?utf-8?Q?HhiGzBhOfi5YyNrNF4iJ10S3M?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fadadd-83f3-4f5c-89df-08da75181a31
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 06:19:20.9204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUZmJ3P3Pb42NMkVpKOy5wrN4jDXXMR+zHn9qhcwCO3q3h9U14pekDZs3WRc6j67oWc4h7xEE7L9rP7uNJCE7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208030030
X-Proofpoint-GUID: Dfc2cWE1THp1u2pC78ySQuOtCC1ap9l0
X-Proofpoint-ORIG-GUID: Dfc2cWE1THp1u2pC78ySQuOtCC1ap9l0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org






On 27/07/2022 02:38, David Sterba wrote:
> On Fri, Jul 22, 2022 at 01:34:11AM -0400, hmsjwzb wrote:
>> On 7/21/22 09:37, Nikolay Borisov wrote:
>>> On 21.07.22 г. 11:36 ч., Flint.Wang wrote:
>>>> Hi,
>>>> fstest btrfs/291 failed.
>>>>
>>>> [How to reproduce]
>>>> mkdir -p /mnt/test/219.mnt
>>>> xfs_io -f -c "truncate 256m" /mnt/test/219.img1
>>>> mkfs.btrfs /mnt/test/219.img1
>>>> cp /mnt/test/219.img1 /mnt/test/219.img2
>>>> mount -o loop /mnt/test/219.img1 /mnt/test/219.mnt
>>>> umount /mnt/test/219.mnt
>>>> losetup -f --show /mnt/test/219.img1 dev
>>>> mount /dev/loop0 /mnt/test/219.mnt
>>>> umount /mnt/test/219.mnt
>>>> mount -o loop /mnt/test/219.img2 /mnt/test/219.mnt
>>>>
>>>> [Root cause]
>>>> if (fs_devices->opened && found_transid < device->generation) {
>>>>      /*
>>>>       * That is if the FS is _not_ mounted and if you
>>>>       * are here, that means there is more than one
>>>>       * disk with same uuid and devid.We keep the one
>>>>       * with larger generation number or the last-in if
>>>>       * generation are equal.
>>>>       */
>>>>      mutex_unlock(&fs_devices->device_list_mutex);
>>>>      return ERR_PTR(-EEXIST);
>>>> }
>>>>
>>>> [Personal opinion]
>>>> User might back up a block device to another. I think it is improper
>>>> to forbid user from mounting it.
>>>>
>>>> Signed-off-by: Flint.Wang <hmsjwzb@zoho.com>
>>>
>>>
>>> This lacks any explanation whatsoever so it's not possible to judge whether the fix is correct or not.
>>>
>>>> ---
>>>>    fs/btrfs/volumes.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index 6aa6bc769569a..76af32032ac85 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -900,7 +900,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>>>>             * tracking a problem where systems fail mount by subvolume id
>>>>             * when we reject replacement on a mounted FS.
>>>>             */
>>>> -        if (!fs_devices->opened && found_transid < device->generation) {
>>>> +        if (fs_devices->opened && found_transid < device->generation) {
>>>>                /*
>>>>                 * That is if the FS is _not_ mounted and if you
>>>>                 * are here, that means there is more than one
>>
>> Hi Nikolay,
>>
>> It seems the failure of btrfs/219 needs some explanation.
>>
>> Here is the thing.
>>          1. A storage device A with btrfs filesystem is running on a host.
>>          2. For example, we backup the device A to an exactly some device B.
>>          3. The device A continue to run for a while so the device->generation is getting bigger.
>>          4. Then you umount the device A and try to mount device B.
>>          5. Kernel find that device A has the same UUID as device B and has bigger device->generation.
>>             So the mount request of device B will be rejected.
> 
> That's on purpose, devices are matched by UUIDs and making block copies
> of the same filesystem is known "don't do that" and discouraged.
> 
> If you must store the block copies then you can change the UUID by
> btrfstune, there are two ways (fast metadata_uuid, and slow rewriting
> all metadata uuids in all blocks).
> 
>>
>>              if (!fs_devices->opened && found_transid < device->generation) {
>>                   /*
>>                    * That is if the FS is _not_ mounted and if you
>>                    * are here, that means there is more than one
>>                    * disk with same uuid and devid.We keep the one
>>                    * with larger generation number or the last-in if
>>                    * generation are equal.
>>                    */
>>                    mutex_unlock(&fs_devices->device_list_mutex);
>>                    return ERR_PTR(-EEXIST);
>>              }
>>
>> I think it is improper to reject that request. Because device A is not in open state.
> 
> But this would prevent mounting A. There should really be some way to
> distiguish the filesystems, the block device is not a stable identifier,
> the UUID is. Imagine having 10 copies of the same filesystem identified
> by the same UUID and device UUID, but with different generations and
> data. That's asking for problems.
> 
> There's not much the filesystem driver can do than to avoid using old
> devices and giving preference to the highest generation device. All
> devices with btrfs signature are registered in memory and this is the
> primary source when mounting the devices, not the block device itself.


David,

  The unintegrated patch [1] also used the same use case.

   [1]
     [PATCH v2][RESEND] btrfs: allow single disk devices to mount with 
older generations

  IMO device-copy and mount (without changing the UUID) can be allowed
  for a single device btrfs volume only. We even have a fstest case
  btrfs/219, which tests single device duplicate UUIDs.

  Please integrate [1].

-Anand
