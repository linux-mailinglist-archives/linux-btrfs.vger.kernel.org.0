Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9589653AD2
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Dec 2022 03:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbiLVCzF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Dec 2022 21:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiLVCzD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Dec 2022 21:55:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C96B1007
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Dec 2022 18:54:52 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM0x0L8012732;
        Thu, 22 Dec 2022 02:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FvH6UoX95sEVgNEAwXgs/BjPHEcjegWP8ANYzkjQnUw=;
 b=plCFP2VfaVs9GjFynWiVvWfKIFR3z1H9UM5nT+0quXHKNwMimoCswV0Lswt1tMufkKV+
 t+9Gjo7wZJXLZX/x/h9gLE54s9eeldP5VmpQo6AFkqCQV3S8L1AplKMluelH61ch//FP
 8DcsYK0OO79yYlauf9q3b9SZZVEldv0F5qIlKb5ibaVTnzB01T1BFEpwRxTdx0/TC8c2
 K1B163xv7wSqlm2bwyoNDQSVjqK2RhCkWmi2SJD9qETy+PurxhL+sbWtvgZ20h2vrdSK
 haVa6+KhcDVmzvjW3gWTeusGpPi1u6pqxqnGTDbHjDoBd/ij+LE0yZzqbTJbn1eDJ00m BA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tmaad3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 02:54:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BLNdUVH008108;
        Thu, 22 Dec 2022 02:54:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47eey9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Dec 2022 02:54:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k90F/mkMa6BWbzke9dE05yvnLO+gwYsNJj6a+Jm30SWcfUwf5SlhLGMLNbgmRUydZRuA///59yHzgs45pnBZ5wkWQHAoh555gvi6/qJAKjuMmhZPJg/3W9ohcA57PO8gtNyL0v8BdxCmIV++qq/NpGeXuWZNJIxhx4hrq08dYo1VfrcnP1NPumjLX1XnLMnRgFLKj7a1TB7uYXunW+0sTFPkWKzQI6qbVsFR6rg90FrvARRkDjpMb8sX5Zt+5HIchVk3LRxKv2yt3d/DT6AnohD2OrInb/GhOWlXDTT7noENGP4Ip+Rz46EZH1iBWsxVp/ZmLLLPi0ck5wMJIwAwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvH6UoX95sEVgNEAwXgs/BjPHEcjegWP8ANYzkjQnUw=;
 b=HEexRcFUuIjSr/Wz+wTW9u5/8VjjYwPUlWnH4XylTxodzaYtnRWkNP70CVkJOgBGkxHzI5K0/+Gsx+C65JYPI0fjO3kxBniM/yDq6XyflodGeqAStevszC+afHEI98Ux19z4/xSTqRF6rutdmlXabuk6iBHFA6tWGL2dEGFZToyiPRodS4QYcngVwdm0/Ip+FGYWyrYRo0lTNms1y5sNvjTfW5ryZ+ZwF8Dk9AuwmUVOnFAKQslkf11Ob0y0I6B5RKBl/1TZ8qzWgITSe26gvmMKf6OmnGvVrr20VyUqdbg73jnpCmf65h/nzNm4gWMsu2IQf8AL6ADVuNDf/4AS8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvH6UoX95sEVgNEAwXgs/BjPHEcjegWP8ANYzkjQnUw=;
 b=ab3u4gRN+Elhc8zAlo9kLCx+xPnLKaa0QdqoorQi/s4PHcysdzrDekRdt1sTJwcUPHBLKTOBhaO4k69hPBV9RHWxalKvsqQgkFPoN+xNM+QLjfmN23sQ0VBGTh9goppB/NDFdYLCzhNytP7RqtkNRjTmsIOWJFsxBojR166tiEQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4420.namprd10.prod.outlook.com (2603:10b6:303:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 02:54:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::797d:8a0a:fc5c:7e65%8]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 02:54:45 +0000
Message-ID: <a3f752ef-d950-60b5-8e6a-8939e85315ae@oracle.com>
Date:   Thu, 22 Dec 2022 10:54:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v3] btrfs: fix compat_ro checks against remount
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chung-Chiang Cheng <shepjeng@gmail.com>
References: <e343fbf122d17f6d74e3630b197f7b344bbdaff1.1671667128.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e343fbf122d17f6d74e3630b197f7b344bbdaff1.1671667128.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e1043d-e411-4b75-ad9c-08dae3c7e1cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e164RQeNLqRgZt2d+/o2VoY5pU1oYi6t4fQlg45nwgOTCxpG9frKrCVjykX+oPaCp/tEHGQLqLl8Qgcn/7uGPZ2Sy/EAM77f/sY4/N+zyhHncN1wWlPtFjRGbLIERAmwE38Ve+ULVDc2kr8p5DQhXh+MKzNQAV2fzq4RBJwy3b80NAq8DH9+ldsjUWD5hSxUx8Txrptk5xJd/eVEdaw7NszoHQ0Zumfo4zK+RrB1QGaF4bQ76pRCDECXo0Ntdws5bYUwl73i4+jWzq5omxjpJxqjwTykS4zRpABk0vZQq3ywBUTJZG/I0y7buPjqvf6aWHrXK3S0gJe1mHilnK6GoN2NatDRellhp3bAOGrOiIziv0hPPrHBzRMVHzlu5qeuBtV3W7mFOmcXAma2y2WEzHFvxXNrLlPt+3WnhvC5juepXu9j5UgIPcR/Wb8WtKpLihUCY+UmUWMUkmoij6UGIJljGB6WCKMsJHqk7eKdCfsdc1QnIvwsVN5RbD6l9lGSWrcKBSGpjNjyZakTMc8wSVFNmbV6klV1tgwWyRGqC86ru+yKChT57n3DPvRA35oU7pf4b9WG5YZ9zUmlR70vzhqBRApdg4wq6EmtOAmBzhKW0/KIioFSYdgaiccZaVHkxxyE/YBSp18K1GvUcgb+v4BMJQXpimm3sSPC6+AWgZX6ivD2VRSDx/xLHrheom0z8EiGPOq7V9fzPjtp51RJ5hyWzOzJmviS6ZkdTz+6URs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199015)(31686004)(66476007)(36756003)(66946007)(31696002)(5660300002)(2906002)(8676002)(86362001)(66556008)(4326008)(83380400001)(38100700002)(478600001)(6506007)(316002)(44832011)(6486002)(2616005)(8936002)(41300700001)(26005)(53546011)(6512007)(6666004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djdzaXV4TWw1TzErLzlNdXB1dTI1QVJWN3V2NksrbHBQSGVFTmxKVHk0dzBu?=
 =?utf-8?B?cHFwc3I5eS9qc28wK1Y4YW5Jam5RbkZsZHRHY05pM2hkb0ZleFh3NXNjODMx?=
 =?utf-8?B?emVrS1lpUGo5WGRCNDZEYlZ5NEZFMnpKMzJ5dzJqWEZEUExqV0VjMXBJcG5v?=
 =?utf-8?B?b0QwTk1maVE4WUJIMDFCVlJvaHlmbUNkZWgxUjhBQ2JGWnZmRFZYN0dBV1V2?=
 =?utf-8?B?dFBQdXlMc3ZncVlCVFlxUHc2K3pwdFpVVXdIT3N2M0xpS3VrWnROSVpGdmx1?=
 =?utf-8?B?TTV1cm8zclhZRm1IOVNtNXU3SnpiT0g4YVZoUmIxS29INmxzNUtpVFgxMThl?=
 =?utf-8?B?N0NzdlZIWUp1TEdjejlHcG1ENDR6VHpkZkk1c3M3NjFPQTZQQVpPRFFWOFNE?=
 =?utf-8?B?N0lxN2VncW80ZVNTZDRSYUF4ZlV2QkxSU25Nb09wRE8zL0NhS1hRQnVFNk1a?=
 =?utf-8?B?OTRLUzc1NkVtcjZVNWFBaVNtWXJoZVViQmJQcnBSNVVxb0preUNlcEVXWmc1?=
 =?utf-8?B?Y2ZuZ3M5NEhuUG9MYWZMRjJuelNDSUVzaHB4NVFQTm84NFJBUjBSUlFtcjVI?=
 =?utf-8?B?YkVuRkhXNWlwK2VUM3hma2pkN01PMzNkTTFxSmxjS2pzMFVOK1YrVEx1SUNT?=
 =?utf-8?B?aWlBYjZ5aWNzTnZUUGJZamVIem1KeGlRZU5MYW1oNHdGbnk4N3lOaHh3THBr?=
 =?utf-8?B?c2xYT0RCUHhTcHBCRFVKWUo3UmMvdmVNdjVRc3czMWJ3SWJxR3RJYlZZOUNz?=
 =?utf-8?B?QjBuVVhWVzNUWUoyd0ptUmRDWWpCelg5NTc3WVdmTGYxdFNSTE1MUE80U1Nn?=
 =?utf-8?B?bUFqYzFwbzVKMFA2MEQwWFR3dCtIbStBRWhrVlFaQ0l3RWFaL3YxSEk4dXYw?=
 =?utf-8?B?MDJqVElLYWlDaU5qb0ptNy92eUxuMnhpZFIzeHI5eVN4ZXBReXhGYXhsb2hF?=
 =?utf-8?B?aGEzeTQwTUt0akYxRjBJMHBtMmVGOUlMY1JDMlN5WndDc0ZsNFJleGgvQVJi?=
 =?utf-8?B?anY4dlNmaFpiSWI2R0p1ZXZHZ1JZUnl1cmlpMXVINDRKR1YydFFscEE3V0JP?=
 =?utf-8?B?M3VrbUdkUU56Ui81eXArZGo4UDVzL1JCd1FrRHFodFVjYk5mRnNlSlZmWU03?=
 =?utf-8?B?S1NFemdiWkh0VDZTak1ubHRKWVBENmdrS2paUnYyMFJHYXpHMEw3Qkh1UC9s?=
 =?utf-8?B?eXk5WngxMXNpVnJDNUlZam4yL3ZGZ1h6SnhqQmtsMk1yc3M5Nkd2SHdkeEFN?=
 =?utf-8?B?UUxBU3cxOHlYeG1UNzYxTE1JVXVvZEwveEhqVVVVa0g1bE5FeXhpS29EOEFq?=
 =?utf-8?B?d0NnaTZZN3UrUmk5NWNvTFBvZ2xORkNLNkYrejh3U1VScUJmMUoxWG1jaGho?=
 =?utf-8?B?VEdHc1JHMGVsa3VCMHYzbFR3SStKNkpNbDJRV3JHUU9GbEp3bWdXa1EydGw5?=
 =?utf-8?B?N2tWNnlZeExPTTFtQjJYV1R2ODB1anRSUUxIbU1DN2M3WGVXR0RIcy9oTFVl?=
 =?utf-8?B?S09VMXBTOTVLZTFaRzFncDdlUjlwMUMya1FpY3MxejByTFI0ODNGWjdnMFVO?=
 =?utf-8?B?RGFrUXo3NHp1UTRpOXRpaVRCRGhBbThlZnFCWDBRZVlNbkRlSXJCZTlVR0hV?=
 =?utf-8?B?RDNkNVFEQldXUnczZm5xZllURjI4Wk5aWHU5eGwrWUJTR0JCU0lreEIzOWxI?=
 =?utf-8?B?eTA1cnlQdHNucE1oWWFDZ0hNZllyaEU1L0REdzg2UXU1djVvRU5GOFM5QUNR?=
 =?utf-8?B?cHYwd04yUVViWnUvN3RmUWszanNCRWdWcjN3RC81YnVuR0VRY0V1SGxOajNZ?=
 =?utf-8?B?aWhWZjRPVXkvalJYZ1N5V0w0clpHSVB1SkFzR3dCTFdtSVYzZmFWcHVscnlE?=
 =?utf-8?B?RTVCMi8wTmdJbXZDUWhGQlJGL3hiazZheXZhZ2c5WkhzekVzaytIV2tKcWxF?=
 =?utf-8?B?VzhlV0pJRUNSY1JJTkVvRWZkcG8xKzBuQ3NQejcyNUxhS2FITEZOc0k3cHFs?=
 =?utf-8?B?WDU0dUR6amYvcFBvUUltZ3orQjQwU2hKaXdtemJNT21PbkVzRHAzZEpaZVRI?=
 =?utf-8?B?RkppMEVjdXcvVjlHRTJtTFVUTTkrSnB2Z1ZvZWhzUWVQRk9MZXBNOWUvTjVN?=
 =?utf-8?Q?C905yC4YSihfETeHjl9y7n+yD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e1043d-e411-4b75-ad9c-08dae3c7e1cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 02:54:45.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6huke9tBF+HTRJr0BhNtDg9xDewS9gQ/lay/AVCzymzUHIcr7BNPRKFGFi9T4JFSnGQorAKJUU0QSIf0bExX7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4420
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_14,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212220023
X-Proofpoint-GUID: 5fVjjIzU5KgEvMuRq6FplW5RZ2_LNvDC
X-Proofpoint-ORIG-GUID: 5fVjjIzU5KgEvMuRq6FplW5RZ2_LNvDC
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/22/22 07:59, Qu Wenruo wrote:
> [BUG]
> Even with commit 81d5d61454c3 ("btrfs: enhance unsupported compat RO
> flags handling"), btrfs can still mount a fs with unsupported compat_ro
> flags read-only, then remount it RW:
> 
>    # btrfs ins dump-super /dev/loop0 | grep compat_ro_flags -A 3
>    compat_ro_flags		0x403
> 			( FREE_SPACE_TREE |
> 			  FREE_SPACE_TREE_VALID |
> 			  unknown flag: 0x400 )
> 
>    # mount /dev/loop0 /mnt/btrfs
>    mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
>           dmesg(1) may have more information after failed mount system call.
>    ^^^ RW mount failed as expected ^^^
> 
>    # dmesg -t | tail -n5
>    loop0: detected capacity change from 0 to 1048576
>    BTRFS: device fsid cb5b82f5-0fdd-4d81-9b4b-78533c324afa devid 1 transid 7 /dev/loop0 scanned by mount (1146)
>    BTRFS info (device loop0): using crc32c (crc32c-intel) checksum algorithm
>    BTRFS info (device loop0): using free space tree
>    BTRFS error (device loop0): cannot mount read-write because of unknown compat_ro features (0x403)
>    BTRFS error (device loop0): open_ctree failed
> 
>    # mount /dev/loop0 -o ro /mnt/btrfs
>    # mount -o remount,rw /mnt/btrfs
>    ^^^ RW remount succeeded unexpectedly ^^^
> 
> [CAUSE]
> Currently we use btrfs_check_features() to check compat_ro flags against
> our current mount flags.
> 
> That function get reused between open_ctree() and btrfs_remount().
> 
> But for btrfs_remount(), the super block we passed in still has the old
> mount flags, thus btrfs_check_features() still believes we're mounting
> read-only.
> 
> [FIX]
> Replace the existing @sb argument with @is_rw_mount.
> 
> As originally we only use @sb to determine if the mount is RW.
> 
> Now it's callers' responsibility to determine if the mount is RW, and
> since there are only two callers, the check is pretty simple:
> 
> - caller in open_ctree()
>    Just pass !sb_rdonly().
> 
> - caller in btrfs_remount()
>    Pass !(*flags & SB_RDONLY), as our check should be against the new
>    flags.
> 
> Now we can correctly reject the RW remount:
> 
>    # mount /dev/loop0 -o ro /mnt/btrfs
>    # mount -o remount,rw /mnt/btrfs
>    mount: /mnt/btrfs: mount point not mounted or bad option.
>           dmesg(1) may have more information after failed mount system call.
>    # dmesg -t | tail -n 1
>    BTRFS error (device loop0: state M): cannot mount read-write because of unknown compat_ro features (0x403)
> 
> Reported-by: Chung-Chiang Cheng <shepjeng@gmail.com>
> Fixes: 81d5d61454c3 ("btrfs: enhance unsupported compat RO flags handling")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add a comment on why @rw_mount is calculated this way
>    This will cover RW->RW and RW->RO remount cases, but since the
>    fs is already RW, we should not has any unsupported compat_ro flags
>    anyway.
> 
> v3:
> - Use @is_rw_mount to replace @sb argument completely
>    This should make the code easier to read and reduce the argument list.

  Makes sense.

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

