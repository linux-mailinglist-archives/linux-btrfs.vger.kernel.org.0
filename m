Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15636228B2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Nov 2022 11:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiKIKli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Nov 2022 05:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiKIKla (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Nov 2022 05:41:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8121F2C1
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Nov 2022 02:41:28 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9AdRpu010264;
        Wed, 9 Nov 2022 10:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ju9TGtNd9+4RtRlusUmAMsF4U0PRW//JxTjeKrjwx5o=;
 b=CPiTpzSSJmXPymXfsvxP5HTJD1zUcOgDEufMQ0RdJrnvATVPM5nT21dC9kbeWn1Y5maw
 0ZF1/gOCJaFi26SaoN0TTkZ1Nu9rrRuAndpH8eDZ6GKA7nrU8Rn4wswiDh04AVHh2IUV
 5dj/+GKyLcaAkkNs1yH6n3J3fWRFLlJN87IO2cOCxZhg4jZcJ4i7aDu1dTldzKCLWDNh
 Hq0y1OREld994Rl/Myz7kNPF0+4U+q1NertvpHsLRZ7daS5NI5AZwtYkVBPgwhwnulBO
 lFg/n30P8uOG8DU/fySxShehsQlVsMq1l91RCF3tNaI1/XCg6/lANDrQzGeDO+mX46D8 cw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kram5r0b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 10:41:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A99xrM7004265;
        Wed, 9 Nov 2022 10:41:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcq379d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Nov 2022 10:41:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvAbTRmBc1ZSvbFwbiOvTGRWIbdoUUP+EauqFVALRud+X/45lkQfwE+NC4qI2tzD1yR32aQ2HV5roTX7PAw3s0i014m72dNoQVX7egkPGPMDfp9qhHlAg3FLTG1jrIxeYThyhOWr0hRYSGYaVCteiVsaHRbEt9A9dQm+qySc6rgG8QOe8zLDH1UfUsLD9mYpr5wtBT/7HhiMbSySxsMigVyZA+tdIeqTMz7xf8W9bQz/0Z6+S9zqtYvbOmNfK2A9vKYDgZEy5fQugfVte9lAviiD8B1YuOL2V1WNP0Z/EoOv/0ZsZYEk2m7u4QcYSB3IPvRkPoJoa68bRWxxeTe5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ju9TGtNd9+4RtRlusUmAMsF4U0PRW//JxTjeKrjwx5o=;
 b=U/11vygKENz7IHYK66apdNsDqfawjZqMk6jDDHmHVsRGRSFxOhb0+uVsUZoXDS5/bYwdTDQxtxgfM2utK0olPZHx+UHExyiFy9/ceXZ8MvJ38quMEUCjct6t4WEdNZ4oDnAD6aRoq3BtKdL9ef4vGZ+buSXWcbISRp7xzhdq+ZHoq0wAweJpsYAd0V4UiyLLaXNmMhnXjRQa/ABExYrOJT1VDE6hLubnSM31dNQfK7S7BjNBfdJAmWizAQI9lQFyFHzY5e4JJudUV0tiAZcXQmOFq4H8VXSzLPuey61iMK0/x+NmBC17HO+8l4MmzyvOhADnVLbG3AmpAWy6MHf5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ju9TGtNd9+4RtRlusUmAMsF4U0PRW//JxTjeKrjwx5o=;
 b=enEaX2wG3qdFJlio7w+tlDiMnLdWZ4V4AKVVvZtL+EqQ9NIwxy9+A9ku5tHofT4k1wzg3ITCbz82Al3TOz6gFS3Gtv8HL+FHDoSZCsc0Ap3Ds6k5bSYR0F+3gGd9OrNnP13AnRPa1TqlCxABldFWqmXvU5GvYHmHIJqnLFJMjMs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5149.namprd10.prod.outlook.com (2603:10b6:5:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 10:41:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56%4]) with mapi id 15.20.5791.022; Wed, 9 Nov 2022
 10:41:12 +0000
Message-ID: <4f3e3012-c248-4c6e-7368-63aef1a2c766@oracle.com>
Date:   Wed, 9 Nov 2022 18:41:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: move device->name rcu alloc and assign to
 btrfs_alloc_device()
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>
Cc:     kernel test robot <lkp@intel.com>, linux-btrfs@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
References: <558d3ae7ad53788c05810ae452cece7036316fb2.1667831845.git.anand.jain@oracle.com>
 <202211091331.YNFqkpxV-lkp@intel.com>
 <6af7ebaf-4dca-31ad-7854-df73772dacbf@oracle.com>
 <20221109102805.GC5824@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221109102805.GC5824@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da51a9a-04cd-4bed-acf4-08dac23eebb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cy2TnhXAnmWbC15+rHJBIcZtDX2B/ReX5P5O314CiJ8zq6NxI6MzEHb/A2kJpTnWj5998P0X/8kHrDNtMkrfhS3fF9f+/Y71mCYjYYvWv8XWjFZBpcmNX4sm/T0zwqG2835c1IAeBQjdmyp4cpUsbJWlQ113vNCHc4f8MoSTNsS8RSbmn9YkL/NU0f2qMEkC9GCJxHBlSf+P+os1FkuG4exrOCRgyszxAaVvFd+QljnxnjlxKP2GyEBXX6rKjs1BV/VZHMJ8C+jD0zQEEibc6ooqtIJcojQiZ7GR8erTJZOkuL3tt4WrAGplt+PmrWyXQ2uKMcU0hJBdvHx5FEiP/ZVYKM8ks2Uq67dXFhmCRWq9/PbmAuAVC9r1JPv0GNr1eGIv8+Exb1k65GR6AXCONgvF5wJUYO//g0l54WHostZvb+lX7Go43dgwdhGVbIBaNy8gXOKNZQauybVvauwBVi/6axwGxSbJfwaiL7fitsjByDoefpsMs/eB5dVIfdg3pVHvuIqsqr3XnR7xsRHww6ItserklteK9lwDCJixHxuuZY66tz/jRZ+1IHp54TWAK4qDQhqLOEHksEaiBJdfQMb4Y6yeovUugz7ZgF260ROvPTLzgQW9dauodpX/+RdHocJb2PXUVakrL1R7sem2uuhPtmmcvhCMTqjrsUS3qEJAdMM7WuiBisyu0vMGc1M1LMA1kX1Xi+IeTaZfzZrHnzco136CCWyYTvzMj5Ebxu2d5ONnQarWuOBtKwKEdlAEQyswTDe6Ha8P+Vwepw2mbDG/Wp9Q1FZTpMX1IbobFT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199015)(6512007)(36756003)(38100700002)(86362001)(6486002)(41300700001)(478600001)(31696002)(31686004)(83380400001)(6666004)(186003)(2906002)(26005)(44832011)(6506007)(6200100001)(4326008)(66476007)(5660300002)(6862004)(8676002)(53546011)(8936002)(37006003)(2616005)(66946007)(316002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWJyUnRKTnN4WWpZTXdER3JyczJ3cTZOVWRYNkpQeUJWOFRWZHZybXN4YmU3?=
 =?utf-8?B?UmhTZ09wQmxhNWtOdkZxY3MrZk5Yb04yZzU0T0orcG1pbHFlbmRPUC9KaFY0?=
 =?utf-8?B?NGVKeG5JUVgzZlVpV0ZQNUhBM0xQcEJCdTArV2JxOTNXblh0V0M3dGk0Q0Zp?=
 =?utf-8?B?NUMrVjJKV1BvODI5aFBRSHdBbFpzc1VZNXYvbW1vaUFZRTI2Uk9CZ2RZS1pV?=
 =?utf-8?B?MjZ1bWVETFd2dHY2bmpqMngxZTVyRWFKZzI2M0UvZUQreVRIR2Y1LzkrQlZR?=
 =?utf-8?B?ZTZkY1NIcE54R1Y5Q0xYcTQzOTErV3lkcEZlNkVKMXB2NnpsdWhIWXRIWENZ?=
 =?utf-8?B?MU5XTVI4c1FTaEZYS3N6SnhBUm1zOUZsQThPRDJzNTRISXZBZjQ3SmxoWUZJ?=
 =?utf-8?B?bUI5bms4RUhmSVJJbjJGTUo2NytZbmhQOTlXWU4vSU1BZllITVdxNE4zUHhx?=
 =?utf-8?B?ZDlKUHh5TnAyVGcvN2dSNEpZQzJHV0dZK1o1ZVBUMlh3eE5FeHN1bTZicGx3?=
 =?utf-8?B?aVdzMno3cGdjMFZzbDJoelFvV3pUTTVpek1tN3dObHFBZXZyTTUxclRlc2gv?=
 =?utf-8?B?VXFGMWJoT2s2NkRLOFVZdzJ2d0xDVE9ITksxREJkaElmcFBRTy9uYmJRb3FY?=
 =?utf-8?B?Yjh5dlV5MUF3aVFBd09rS1FMSUtlZjEvdlhhSGVva0VaMDQrL0tleXBpbGl4?=
 =?utf-8?B?UDE2Riszd1dDc3ZFQzdYeXA2RzVSNmJIc09lNll2bDluTC94L0w1Y3NNOTBy?=
 =?utf-8?B?ZnlPRG9zRzg2ZjNpSjcrMmZVRzhBbDIwNDNQcUtVMmJ1MmU0M0N6NUVyRGxi?=
 =?utf-8?B?MmczZEV0UVNoVUVlbWw5UTZZcXdZclJmbjlsbnlrQlQwZWZIOWd0aWlva2Fk?=
 =?utf-8?B?YStyNDE0dXlteVNSbjlaWUppMEoxZCtUbFh2SGRCQ2NGRzlRWGFDWS9aYzFp?=
 =?utf-8?B?dVVDYkUrOUcyTkNZMm1URGZXUlhCZE1EeTRNLzBmc1pZTVlvUFRyQVZlVUhG?=
 =?utf-8?B?SUQ0VWF3ZVZkaGt2d05UVVhUNnRLc0ZzRGhCY1AxeFJ2UkNWUnZGTjBFalNm?=
 =?utf-8?B?RGRPeG9nYmJQME9VY1d0UEQvUk9qLzZydHdkSFowNkRKcGVoRWxCK20zeTFj?=
 =?utf-8?B?VVJpTmpNUHNYSi9BUW85UzNzOG5RYVJ5NlA2dVhCUnhJcHhMTjA4NjVkYUVq?=
 =?utf-8?B?am1vWk1hdUtHT0VBWE56UVprNGZpWDhUbmpkZnQ2Ym50T1BSUUp6aEkrS0t4?=
 =?utf-8?B?TE5MdXdRMkZkTm0rbU1kdG9qd1lPR1gvdTR2dVNUREJVV2t2VGx4UUx2c3p4?=
 =?utf-8?B?WVZobmxIb3BrYVZEdW1Rb2lFcmhNOFpvWWxlb2V0K0d5Kzh0WEdTUFQwR2E4?=
 =?utf-8?B?Q1lkT0VSaUVweE1WWFJHYUd5QlcyUUtsU0Izc2NIL0pOcE5QdkdKdk01NWdp?=
 =?utf-8?B?RlQwbXJtYzVlZFVDS1B4S0VteVRhV2s4Zk1nckplTkZCVjcrOW1JZjFPMkdP?=
 =?utf-8?B?eGhPcWltbHE2TzArOGJGcndHMDViSlFyMVhneDVTd1pXWEJKTUV4T2NqaUgv?=
 =?utf-8?B?a3ZodGp4RXhNa0E0UkQrWlFvWTBhYmpMK256blV4REV4dk9EeERMUFpZaE12?=
 =?utf-8?B?NitLM0t2U0V3SFRnaWtnVzJXU0xmZnVpNHRYYmVLUWtUV3VXREN3K0VCaVJK?=
 =?utf-8?B?ODNOK0JIM3M5M3JweHIrVWJRaG1xdFdWZ2h2U0NLbHJqNE4zaTlxR3FVd2NG?=
 =?utf-8?B?RGVRMit5SEJuNzRwTEtaR1R5dGliTGd3V0VqcGVyc0RFdXhGYlpVY00vYm5I?=
 =?utf-8?B?VlA2Z2FLQnBmRE9iOWlFTnRSdnYvaEdTdHZQc2s3dU9relRWN2gxbW9udnJH?=
 =?utf-8?B?K09NaDlCK3dSRS8vWGhxMFZOWnNhdkt4MHBpQkVOVWpxbTdPRWlKL01MMyti?=
 =?utf-8?B?VEo4eTNseU9hZWpINkNsN2djQlhsZTFJWlJ6elIrV1liakZwSzNGZnJMTVF3?=
 =?utf-8?B?TnNIUUpXQlFEUjFIS1FJYmgwVDc0Ly9FZVRPb3dUbXdEbHQ0MEJnRjBQMklQ?=
 =?utf-8?B?NmZ4WUE4TUFSYlZ2akNhSjhZek4valZXUDRhU1RqNEdld3V4U3BheGtqRHIz?=
 =?utf-8?Q?JHpUvuAU8MWCC9k1/b2Zt4o7y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da51a9a-04cd-4bed-acf4-08dac23eebb0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:41:12.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1o2rK7hiA+AN8bwpTeQwNOM6VXznweHdQY6SbS+PUp4XGvJx3P5TlsfL2y3GUvIz8KbIAJsPPY46hsc8xo+e9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_04,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211090081
X-Proofpoint-ORIG-GUID: BueLHpCW80BnUV2YQoFNmeNe6z161wT4
X-Proofpoint-GUID: BueLHpCW80BnUV2YQoFNmeNe6z161wT4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/9/22 18:28, David Sterba wrote:
> On Wed, Nov 09, 2022 at 05:21:12PM +0800, Anand Jain wrote:
>> On 11/9/22 13:25, kernel test robot wrote:
>>> Hi Anand,
>>>
>>> Thank you for the patch! Perhaps something to improve:
>>>
>>> vim +1000 fs/btrfs/volumes.c
>>>
>>>      980	
>>>      981	static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>>>      982	{
>>>      983		struct btrfs_fs_devices *fs_devices;
>>>      984		struct btrfs_device *device;
>>>      985		struct btrfs_device *orig_dev;
>>>      986		int ret = 0;
>>>      987	
>>>      988		lockdep_assert_held(&uuid_mutex);
>>>      989	
>>>      990		fs_devices = alloc_fs_devices(orig->fsid, NULL);
>>>      991		if (IS_ERR(fs_devices))
>>>      992			return fs_devices;
>>>      993	
>>>      994		fs_devices->total_devices = orig->total_devices;
>>>      995	
>>>      996		list_for_each_entry(orig_dev, &orig->devices, dev_list) {
>>>      997			const char *dev_path = NULL;
>>>      998	
>>>      999			if (orig_dev->name)
>>>> 1000				dev_path = orig_dev->name->str;
>>
>>
>> David,
>>
>> Access like orig_dev->name->str isn't introduced in this patch.
>> We have to restore the original comment about it.
>>
>>                   /*
>>                    * This is ok to do without rcu read locked because we
>> hold the
>>                    * uuid mutex so nothing we touch in here is going to
>> disappear.
>>                    */
> 
> Yeah and I kept the comment when applying the patch.

Ah. Thanks!

