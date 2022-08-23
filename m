Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE1859D014
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 06:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbiHWEdY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 00:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbiHWEdW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 00:33:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710532BD7
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 21:33:20 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MNwxiP018289;
        Tue, 23 Aug 2022 04:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Q0p8ZdEHTEDGn8pY5c57Fid4uU+2slXLcmrMna+FxQE=;
 b=S+Ix07SOZdqh8FVRs3mlh5sszsziGDkS3xw6lSSwTf0Bdv45BuMkI91HZMLsHnFoMumf
 s6ctLMPjzQoJlGkYiAvtHcDDHIWUc3lFv/Vr9KBeIANN4ZCbt92Gq0Kd+mEy2hPHVvy1
 NUdvLllcw1KZ6zocBU1WbvyvpUnTUIm9i2JUyN8N4cY2mvb3vFuQ+tCulmImeEldfRf6
 thZD1Lo2mCsr9DgFrPwUBJy9+RxrkVF2TRJIr7+fDRVPDbmMtEcngFVXVXlMe421WSfD
 MbetywdUJQHBOnqjdaI9wyClkxtg3d+5+Epq/41cDeT1WZ79M1VuUMQHnTd1Xt1D07QD Qw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4e2ms3gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 04:33:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27N4UV9U026608;
        Tue, 23 Aug 2022 04:33:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mm8y7g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 04:33:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvhdpGltJzfaYlWIe4Yx0NxN2+2x4lFHboyWbRRl7hGqSKhN3j9wsd+dRuQuoBMQavT40EmmsPgoUnpaWNJtUSmE+CyJ2hQxsFq0dfUCNp4NQXNEBYUnVQefEYxLSHO93m4fNiOEA5RQgBfFDz5wuQG6CCEDP6txXEFHMuqxNKcXiljE8kKaei4x3ajmmsm6Ub5iHDdIaFBXjy/pIpsFQzgwqnw9HS1Iwzll4Fp93JeIUxzDoo1MdvLSTRCea3gpn1uWpLG712a6DOgaDVd5kTwwhPjQIl5/P4FdhttUBwf+LdeXTBoYcF9nwL+2A/P7WiBM11hupZtl/SP7ac/LDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0p8ZdEHTEDGn8pY5c57Fid4uU+2slXLcmrMna+FxQE=;
 b=YvRI0CzQYH6JxPHDDrnnybApKm+CCLKRCRpZJ11y8Z4Phbnn/5ccK1UryPHJXqeNsVLYzbJcqAPyvUuyRQgBVkAblcrhA3qXM7fz1Qf37WrnRLAuI5Cl0cmad5ImEiuL1NEnzcECEA99UPAdsaxbG3nM3eq6Yv4Y6ePllaHx9JDHj+dAU/PsjgwtqxKFiFpVWR+PHPV51lDJFvI1jiRcO1YuwnXKADhUZRSlV8v3sYlPciSxsWDaZltkMsA+IUgAjtwq9BVvXE6wAm94du/3rDBRCmcdUIDgt+F32njWTkH6CZxezcgXGz7vsz1M+GTSOIWPp5l+MqJsiDdzTBSt3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0p8ZdEHTEDGn8pY5c57Fid4uU+2slXLcmrMna+FxQE=;
 b=OPT7i9XoPNuSGKL635Qe0GsgN27lzEUH8lSqNVYQgCvIMO3B+9VKbByqsjS6nLwI2E56ei7+nlZjCEh1bQbnEWTOsAuKm5IpJa+96udlCVlNox6wN6ZsvYd+yGFNxRk28Xft5c+z3sU5wNbqk3bYERcBl0oMAvdpMh4ZRQBxkeU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MWHPR10MB1246.namprd10.prod.outlook.com (2603:10b6:301:5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 04:33:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%7]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 04:33:10 +0000
Message-ID: <ccf63e35-7073-886a-e306-34590302a396@oracle.com>
Date:   Tue, 23 Aug 2022 12:33:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: btrfs I/O completion cleanup and single device I/O optimizations
 v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
References: <20220806080330.3823644-1-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220806080330.3823644-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51466cc5-b440-46c3-26d7-08da84c0954c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1246:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hu0SKFvJdngWA0U7CfiBC4e1BEQsB3JPnaYCRdpepqwttXZot9RjTLe3wawy84MYsSiat3Rkk9jdTTSqTxykatdV4905Mvm/kzqR+boXbFep/LBRnrG9cVjiu5WJjoq2f32lxPRn0vrFfxVx3qSp1ionmWEzCeTBaw+vzLvB3i52yZ2vxUUMNtgmQnmTreX7s4WFatPT83P82wsVtZUBGD3vTxiNkZLmOEzWLvgKISo6GpLhIPUzGcDsCg5n5UW13e/vO+HdGPJ26jC4niRWbZShGfZepkOiUf65P7ib4bON/GnhZND+R+0wwV1/JJtLMpD5TXommufc2gh7HFdW9/GZHj84EmMigfzPobxplAY4NGjlkr9AiVQQsdEDT50KZqtiqKcctr/ANrUW2/0Xe2GpRomBN19kzM9l/7G8GFkpdCEafWKOrxDwDZBn0x8yYNCtqVbTpDAUxeMSVtPg7I7bMPsRNHaqCcNeyziGJugOyA6cTZFNuRK7HACjCEucpW5WcPhNFhPdouiHuETVtqk6UsakdHbifi11zoY/A8MIFRwTrNF2FnC/EaugeAS5CyB8AFQXAZ5VUFIOGQ122n+hxEtK1Np21pDZm9v/A9WU6AO/IXlLkWXEcQcmMOyjD2Ty7ngCoTJn85T860PlaN8aQy5TMrSUL0CJktbcv4igBVfhNMA8JsGORtvreGsBV8W9Hy0uok/i92DJz0wi2WhIb5wTHb44rrQfsH8UIMaavFjwnMNpYvNbzr6IzM8+xqWeDfuHp7Vr2WZAv43doS+ucRLewaS837cT6qWEEvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(376002)(39860400002)(136003)(6486002)(478600001)(83380400001)(316002)(26005)(6512007)(54906003)(6916009)(31686004)(36756003)(2616005)(186003)(38100700002)(66476007)(8676002)(4326008)(66556008)(66946007)(2906002)(53546011)(41300700001)(6506007)(6666004)(44832011)(31696002)(86362001)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmRITURwNC9mdnZQcVFuejBYeGs2RHhmVlh5SlNTVXNtVWZ4YUFaclpVbUNY?=
 =?utf-8?B?STlhUnBFaTFGNjB0c1dMZG1YNENkaXhCdDZxQUtseHJIZXZrblN3MFFLcW1x?=
 =?utf-8?B?SFltN0dhWGhWbkFNckJpYXZpbVUvVkJZZ2dQVHUvTVNFYWtpaGlWa1JHVXM1?=
 =?utf-8?B?a1BXRi9iK1JsOVJyU2ZLck1PaFQ3WW90SitsVWZJU091MlF0UkFjdEVpSUs1?=
 =?utf-8?B?RDd5MVpFSC9oN3lIdCttSUZtNlFBVUZkSVc0Z3hGbS83RVFXc3d5V1hnK0hk?=
 =?utf-8?B?OVZ6ZTVMU25pQTVLeG84bEE5Wno5N2lJellad2VTblArUEpVbllPdXM5RVp3?=
 =?utf-8?B?Um5aL2ZZNWNaYzRvbkYwSmJoVWhWVlhKa0lOMDhaNC94QWt1aUNVOVdNdnow?=
 =?utf-8?B?cmFudzFPWkxValcralhNV3VyK2lXbWFCR3UwaExVZ1E5Vm1ieXZWYjloWjlO?=
 =?utf-8?B?ejYxSlRmZWlKNk9ZWEVVL2FZQTdndU5uWU50UEZCUmZoU2ZtdExha21qNi9l?=
 =?utf-8?B?UmJ3NFJCem9ZbVFobWVBTG0vOEpLTmRMVjBBNU9WTHpjWTVYTDN3Y0FCQXYr?=
 =?utf-8?B?T1hudFJSaEZDMU9qRW0vMzFKeDJNQTA2WU1BUk1RTWVPbE0wQjZtNGFVOG93?=
 =?utf-8?B?QzJ4M1dwalY2Rzl5T1NvMHRyR0NGUjFDVDVYRHZQbmV2dEpDRjkzMWptSXQv?=
 =?utf-8?B?RE5hYTF2UisvSjBVcmtxNmZpbXJvRS9rTjFuck1wcGlrTlJhdGluZ2htZGJl?=
 =?utf-8?B?eVBKYTlva3M4QWdyWFBTWVpXa3pZeTlRTy96b1ZyWjUwZU5VcDNVS2thN0dr?=
 =?utf-8?B?a0dRS0RXcklHeE41MUluZ1dwaVozVGY1Y3pZQ1N0em5qcWI5NlpFc1BoQk0v?=
 =?utf-8?B?bFNnejM5U2xacUhkTDNlb1BUbnI5VUZZUjV3Q0hWa0FWL3RhSW9Celhja0Q0?=
 =?utf-8?B?d1RPbEY2ZkJqQmx6M3Zta3JlQ0JHSUtZZjBVWGRuTVhWSjZtS1ljNDhMVGdi?=
 =?utf-8?B?N2Z0MGp4dGErM3FXTFNtRlpkRmVKLytBMExsT0dnWEVHZGJMR3hHMk0ycTJI?=
 =?utf-8?B?dS9UNW5sbWRoaVFsVktKMlJEd1J1UUl5UlJzemlmUDF5V0N3THZSL0R5NFpO?=
 =?utf-8?B?d3paNHkvM08rZURaSHcyTWdSSUE4NGs0ZkZ3ZVdWZ3dtQ3VDU1hWeDdsRzBv?=
 =?utf-8?B?NEFVaU1NK1d1Q2pNdXNNZi9yS0Z2NGdla3dPNmxnWFA4cldsUTZOckgreDJR?=
 =?utf-8?B?ck1YaXpBMlpEaFZWZExIK3I1Z0JiVXNtM0grMXMvMThmcGJOY0pLaHgrWmFM?=
 =?utf-8?B?QWJ0ZTJhOUszRS85YkFrc013WmpMbGpETUlmUEFXaFFSTVRlRnpGd21sWWZ6?=
 =?utf-8?B?RWsxRWFpbjgyc0ZISkRPWFdwU1IvWnQyU2tpNjErVkNwbHNDdUVEWVBZSjRC?=
 =?utf-8?B?SG1vM0pCZzRTSmlhbjltMkFrZTUwNE11QnFqeStuZExiUnQ4Y0ZIWGtWYWZX?=
 =?utf-8?B?OTREeFM5V0hBdG9ZSnNmYWg5aU51LzJwZVdjcHpVZmZFWjRZUGF3MkhxSFBi?=
 =?utf-8?B?anZKSm9GUlovQ2lEZFM5eEsvTlVwZ3JoQUdOS0FacS9HalUwQ2pRaTBacmV6?=
 =?utf-8?B?NE9GYWhYWUJtNUJHZk1aSENrWjBldGF2dXdaT1AxZFYvOHVPSDI1ekZzUG9Q?=
 =?utf-8?B?ZUNKM1NLdzhBQ083d2V0TXVOOG5sUVhXbnB6MVVKdDd4d0tGRHdMdStOSS9X?=
 =?utf-8?B?ODdNQ3pqY1FocnBqTkRJQ2Rod3AxUWNmRGpYNURkd0VFVm9hRkdNL0ZscVpK?=
 =?utf-8?B?dngvcDBsNExveGJNb1QwZXhBcDQraUFqWmc1SkFRM0RUU3Vhd21NOGM4U1Na?=
 =?utf-8?B?RHVvV0ExRG9ncnlBaENzNjhPYXBJYVdWQ3ZFZG5NaDFtcHhrYUFIVk12SFhl?=
 =?utf-8?B?UW1SeDFzSUZnWE5UeUZPbXJoMG1XOFZmUTE0ZVl0elRrY3R1T296NXVONEhn?=
 =?utf-8?B?bERnZlQ2Z0pnQVh5YkdaWEtlcFdUMVpaUndWK1ZxeFg5Yi9qNkFZRGE5eGUr?=
 =?utf-8?B?MTgzL0ZZQ0xGOTl6cy9zWFFrQ3ZweGkvQU03SnZudkUrZ3YwVFhscWMrN2JC?=
 =?utf-8?Q?S3UjQyV2GOrnxk2lzvTDO0RTK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51466cc5-b440-46c3-26d7-08da84c0954c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 04:33:10.2697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPjwPWLwTPzU8RzZD/u1HRpAkTcNOss/hEzohyCotM/7Y0WnZFgCi9M0rKFLvEtGSYgRzO6/2SZM+mLcCWxTrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1246
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_16,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208230016
X-Proofpoint-ORIG-GUID: h06nYyICZ11K0b_rODw7Ypey11dCyd6y
X-Proofpoint-GUID: h06nYyICZ11K0b_rODw7Ypey11dCyd6y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Fio scripts completed, here are its results with and without this 
patchset on the latest misc-next.

Random READ
  Before 2016MB/s m:RAID0_d:RAID0   devs:2
  After  2011MB/s m:RAID0_d:RAID0   devs:2

  Before 1031MB/s m:single_d:single devs:1
  After  1015MB/s m:single_d:single devs:1

  Before  971MB/s m:RAID1_d:RAID1 devs:2
  After  1025MB/s m:RAID1_d:RAID1 devs:2


Random READWRITE
  Before 236MB/s m:RAID0_d:RAID0   devs:4
  After  234MB/s m:RAID0_d:RAID0   devs:4

  Before 204MB/s m:single_d:single devs:1
  After  202MB/s m:single_d:single devs:1

  Before 204MB/s m:RAID1_d:RAID1  devs:2
  After  200MB/s m:RAID1_d:RAID1  devs:2

We can say perforamnce is stable. Fio command use is...

fio --eta=auto --output=$CMDLOG \
--name fiotest --directory=/btrfs $OPT_IO \
--rw=$RW --bs=4k --size=4G --ioengine=libaio --iodepth=16 \
--time_based=1 --runtime=900 --randrepeat=1 --gtod_reduce=1  \
--group_reporting=1 --numjobs=$cpus




On 8/6/22 16:03, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up the btrfs_bio API, most prominently by splitting
> the end_io handler for the highlevel bio from the low-level bio
> bi_end_io, which are really confusingly coupled in the current code.
> Once that is done it then optimizes the bio submission to not allocate
> a btrfs_io_context for I/Os that just go to a single device.
> 
> Changes since v2:
>   - fix a small comment typo
> 
> Changes since v1:
>   - add two previously submitted patches skipped from an earlier
>     series
>   - merged one of those patches with one from this series
>   - split one of the patches in this series into three
>   - improve various commit logs
> 
> Diffstat:
>   compression.c    |   43 ++-----
>   ctree.h          |    1
>   dev-replace.c    |    5
>   disk-io.c        |   16 +-
>   extent-io-tree.h |    4
>   extent_io.c      |  117 +++----------------
>   extent_io.h      |    3
>   inode.c          |   57 ++++-----
>   raid56.c         |   45 +------
>   raid56.h         |    4
>   scrub.c          |    7 -
>   super.c          |    6
>   volumes.c        |  337 ++++++++++++++++++++++++++++++++++++++-----------------
>   volumes.h        |   20 ++-
>   14 files changed, 340 insertions(+), 325 deletions(-)

