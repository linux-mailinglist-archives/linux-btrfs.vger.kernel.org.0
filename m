Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FFE7BC65A
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Oct 2023 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343601AbjJGJMv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Oct 2023 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJGJMu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Oct 2023 05:12:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92317B9
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Oct 2023 02:12:48 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3976ukJY014874;
        Sat, 7 Oct 2023 09:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=97Q9QHjj/mab4OLqEFcmp/YfoLGozB9D85Kl2PiNfk0=;
 b=0UFhiMbwk2414JMYkwQv5n81c//WFlkS1ct7iO76QDaVzBn8t/Y0Ffn4mk7AolNwP4Sc
 5B7rhS6zhb9cBk2KDrV44ta8v+9rt4big93xd9Gc6FHSgxw/mZmvuXGYW2mwwufKT5Xb
 dN4CtjOH2ti419pUWFeV5so3RHovQFbOFZiu4SaQPCJF/JF+RfKSY6faRRVTYBC3iauL
 qgSa012vyHiA333GzpV2mL78XjZ7TfWVMGlqr3OY6gjXC1e2VU4a8xKPr+yfpGQ28eWd
 IkmOtAmtTMYkg6cOZwZ/p59okX2qIhvzEwYdBVrGRTDsgbI/5zwlJnq8Zf7LdBA4Q0RA 5g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdgbwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 09:12:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3976RQWQ021451;
        Sat, 7 Oct 2023 09:12:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws8rut0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 09:12:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geQevl5Woqi0PAsxwNeLbSVUF1pocpY4dAK0e3NpCvqiTALvKqe5Eth1BxUzviGhkak0Q5AQRWPvzJNmWBO9lonzCyv4z9LeeK2UvFYK/RRPcofe4pSAphTShSiVI7aj0+SrsyswWjyAd5cqI1Oj/Lv17w3FHzF42/GdbR4o3kk/++8Sq6LbgpsLbp8x8IhV4gMu7vEGqZJ3nRmx4ldbAFdF8veiA+XOH83L5mZJOE9aJuGzXJ+sE9+1+2zxO9iSxSq3FK5Ug/mHuCZ001/OoR09cDhx7eoiMKFtC2dUKPRYg8nR/4ZLg9R0pjhY+MhshtK/BWGR8qfkjmB001NCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97Q9QHjj/mab4OLqEFcmp/YfoLGozB9D85Kl2PiNfk0=;
 b=b3AfVkC1UfccQsTTK6dCHMaujw16VvkzVthlf1ITebN9c/kptd5zvfNsMnssIneYWmEsye8N2o0N9dJ2UYHNoaol2Q6CJ+0xNoPQ2B4e2FRbV97XzqqWIDabH5O+hKje7n0BwlRsoAjkt3WdWeIucDDaoYRI05q+t7/0qtbsVeIYXbd/7tCA+RlfhceWDKnYbUa5twS+y3GXeYzB0mvy/JZXLPqgRwMDHJ+o0JUmkmAwRjwQXvKNvm/pc0FoXIzE4P/Y/M7UlwbmH22iyM56UvxW79d3zr4SqE69I+5dA6NWM1vaOsIg8jI4n3cyNF/0NYZTp5UxVxcFMFVY+ifISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97Q9QHjj/mab4OLqEFcmp/YfoLGozB9D85Kl2PiNfk0=;
 b=HEgyuu8tgM42qMcS8B/XHefC+cmmcmQeaRHt6OonmnMBh1crbaTCvRn7S2obnTjauLtZLomDLTsrxMqLJCq9S1VXHtu0Ftii44LAZHOcpXU5RlDtu7YuZmaqdF9CwiQFdlb0h8SepTB3buruIceT8ph5pN/O5eGZq/847FOJQ4M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by LV8PR10MB7773.namprd10.prod.outlook.com (2603:10b6:408:1e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Sat, 7 Oct
 2023 09:12:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 09:12:31 +0000
Message-ID: <b658ef3f-9fd0-45a1-8950-c86f4f1b450c@oracle.com>
Date:   Sat, 7 Oct 2023 14:42:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: show temp_fsid feature in sysfs
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, gpiccoli@igalia.com
References: <cover.1696431315.git.anand.jain@oracle.com>
 <9fca0011d2ac24f7b84990db1c4af5eaa60da876.1696431315.git.anand.jain@oracle.com>
 <20231006145550.GG28758@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20231006145550.GG28758@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|LV8PR10MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: f505758b-a173-4068-442a-08dbc7158937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7OjN7OXh97TTv1SWtbnS5QQ/3G1vW/NeclNaUsLfLZB7JofHnAgon0w8ZgX4DrmEw0jx3k3ud2976VHdLSj6gsWXQ/F+irxoLLfiXRRUW/qOsYKWbaAsdbwCz0MjHRn7Su8Yg/LyVinmsgewCmyW+n1iwJ/doAOMuyWgWWzkuKh4cNi+Q1+WOiPJWKOVbeLHlpa7G4bAGLfuIUDIkiVAdbJz2T/NVtPzN7Ya6Dv+KPO+0mKJGaSgnLfcOCZ2IXiSu7IXue1V8ZcHjwvn5wPczqlGKTg5b+IFNoJ6qtNms8yvdyWIlYWKG0y4cCDAeptJOfJVg/JLMnyT0CXB3TVnAh/RIY2FCD9SPFjHAFm7p7cnm8fec0U/lU9lq+RIiAOb43XVuxAuuQ+hr1/pvcWU4jmVU8mD7Ubfs8PBr1zDlHbAZrGydap1JVOnLJdbKW2ZviPydg7yJjU6EQYNtBj0NIuc8U8EfeCS95J6U9W4Jco79dIRHpuJUxZT7iRwOqawtWcFFJOyvw1SolanAyvrqGm1KI+oQtvYQw2BPAoABX+IGqDYW/V7pvYAewSvr6RNbm+WFMi5ZJV4hsOn7vGS72cbGwUxwbMrt808Y78r2TOS/YtlOjW7LhqVbm0V48z+cktKa/8mOJSK0tz+jw9lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(6506007)(6666004)(6486002)(478600001)(6512007)(53546011)(38100700002)(86362001)(31696002)(316002)(2616005)(36756003)(2906002)(44832011)(41300700001)(66946007)(5660300002)(66476007)(4326008)(66556008)(8936002)(6916009)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEJBRlIrZEFsMkkvdWhmNDhCWEhURGRNUlNza0JNZTdWWDdvMWxnWjhaS3JI?=
 =?utf-8?B?QjZwek5kSGhJT2J0VmNmVlErMzRBeW9OckF2ZGpCak82TElKbWFMbkFJQUE5?=
 =?utf-8?B?cDcvbVZ2ZW9jZGdUUG4rMmVUZ0tOaVVSYXRwcWphb3NlSEk4NlNaVEY3dnhY?=
 =?utf-8?B?YjRNWjZQelMxSkFSRTRJRDBoc1VXeDBraE1WTnBnVUttMG5WV3U4ZDlhTG9h?=
 =?utf-8?B?VEcrQ21TdHZrMEQ5Zlh5NDRSTE16VU5BVDV5b3dQVXRJS3l6dGxoYzlsRWM3?=
 =?utf-8?B?UUtrVFhuVGFjTXg2Z3cxM0FSeklYeFhUbG51RjJzc0hPUEVkeWUvU1pFUWV5?=
 =?utf-8?B?dTNCZjlFUjdiTW1NaEVpdGtBcW1tMTR0LzMyc3BjVFhDN0xIc1M5ZlpKUngr?=
 =?utf-8?B?d0JQMlRtMUJLaW84VUtySXdRcUYwRUxnNERkYU5mc2wybll5dFdpOSsvZEN1?=
 =?utf-8?B?TEN5QW9OTW9VNitpdFA4QzhYVmxicUhUSENaT25Ic3hCSkZFbEpnd05kMHZi?=
 =?utf-8?B?b3ZxTVpvR0RDNkZZOEE4V2ovWHFZU3FFWnBDZnpTaDlteFUvZ2ZyZ0x1aUZ5?=
 =?utf-8?B?NDFPdEVqZFBaaXdVRHpmSUVKRCtldFpjdGJUZ0xmVkxWcUgxQW9TZS9UY2xO?=
 =?utf-8?B?ZSt6SWpidXZOQjZkejU5eWpoRFJNbW5peTYzWUpCWHNFOENPbnNtejYwMHB0?=
 =?utf-8?B?djNaTi9XRy9uN3JmNVNKOEZoMDdqZkRiazBoNFFPYjI0QzBSbmJEQ1d0RXRz?=
 =?utf-8?B?NENkTEpYRTB0OXU1eXhQaHpUOTRSSmNaR2w1UHVha1FiMVJBV0pSSFNoby9E?=
 =?utf-8?B?Uzd6ZE1nQ0FhYzhLWFlxSmZXbzErVG8wWUMxRDNISmV0WHkwZkd4T2F3L1JC?=
 =?utf-8?B?VUltUmlwWFdVNHZ3UzBaZEs4cU5Ybnl2ZS9LOHFpaCtVVGFXeWRZQ2lQS0hv?=
 =?utf-8?B?dUEvYnlzaXZvdk8ycWM2Y1REOEtJck9Camo0MHBRTjl5djN3TFVWSEZQYXZR?=
 =?utf-8?B?YXdPbFdpUlFHbWV0SUJ5UERVMDZOZGdBTE9RNVd2RFlwcE11YjZsd1FMZzRB?=
 =?utf-8?B?T3F5Zk80L3RsWWZKTjd4QXZVMmd2azNrbnhkSjBVYk8zbWVUWUhOSXZ2Qmh1?=
 =?utf-8?B?a0IwZ3B5dUlaVDBMWEUwNHA4RFJVM2RtS1czWW81cnppa3ArMHNhdWRjeVcr?=
 =?utf-8?B?WnNKMjNWbWFhMmdITXl5enFsTnFWWGdiUXlMVE5Dc3FxUzkxNU8xaFV3RTgx?=
 =?utf-8?B?V0d3d0JGTXU2TURzM2oxSTdGM2ZvSWlvMldnMmdFMDBnMGxBZzJnR2hmTjhy?=
 =?utf-8?B?bmcyTkZmRGV2Z3RZWkp5VTNEazZvUmxROHB1RVBtempESy8veU9BZ2dFTHZq?=
 =?utf-8?B?R0U3UkM2V0ZUaE5sejhkc0VtcDlVcTZiRDFFQVBycGhLS0FGTzhPc0RVanZk?=
 =?utf-8?B?VllGT1BVM3FCOHNpcldIRUNielhwblBUbXZDMTZrcWxwVm5BRkhoZENBaW84?=
 =?utf-8?B?VlgvTFNSUzU5dlQrcEtOeVlBbnpoU2o2L1k0YWJSSWpNRktCVTFLNG1HbmRI?=
 =?utf-8?B?SDczbXNValFUeDNoU3A5ZFpJKytKa29tbG5DQWtTQkJrZm82cVYrdVB1ejl6?=
 =?utf-8?B?cjNaODlwdlpMT2VGdm1uL0FyRVhobVpwT2NNNGlTYVRiSFNOYjBDSEhJeU5B?=
 =?utf-8?B?SVl5cDNhM1h1WDdxSzN2Yjc3Z28yb2kwOFB2NjlnMjFiUndzK1g4Zytsc1h4?=
 =?utf-8?B?ajI1TFEvMWFCbTRBK0hWNHVVTkpuV05vS3ovUjkvT0plTEMzUGVCTmhXZk1R?=
 =?utf-8?B?cGJCNVE0OUF4TVNFSElzWnpiVVhqVTB2ZjZDeVd2K2JLRGhhQUU4bnlHaGdk?=
 =?utf-8?B?V1o1VUhWaUhpa1B3bnlwQk5YRVRzRnhSYkUxZjE4VTZJZlI0ZlU4TlNlSVcr?=
 =?utf-8?B?T1grSVZ3bEhhWDVoNmplYXdXUUc1dFo2SzhKS0I5L0VwSFZnQjRJVk94WkhP?=
 =?utf-8?B?QUt5RG4wTGtYRGpERm4yM3ZpaFpBL01SRnhLdHJiaU8rR2wxdmEwVU9GUmQ1?=
 =?utf-8?B?YzRLUXlzM00zODNRYlJRN1FueFh3NjZrMUhaQXFMR2xmMW5QYVVDR0JiUG5N?=
 =?utf-8?B?Z1VSYXNDQ25QRW5YdU1yQmNzb1U3UEdMbEI4UzU1Q0pHM291WU8zTk1EK1ZL?=
 =?utf-8?Q?HEELNET+ySE2CZbRSu3tb0d42EKrWyrbnu4LUEDJbv3p?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ECx1aITYR4v5HEJxilYk1j0PbiNHLNUFBgY4d5VPuHQ61j5mREgTiIqE2S44mAI5qsGtTRQ7veFNRnfBLOjNfcKHKpyVWwVUlVqt+0zBy5hyALgXrIRE6C3MJukV93ggtFFHo6oc/7mtZuPJ6vdsdU3cM8xhd+1sjmKnJyVtINHdAwULITMYvYQc/A4orZrPzcWVDfLl+qjuahj/YTzeF/AwT5o81yaZfq0vdsUPLp0g40I/12EKjwfFaNlrmqa40+469zjYKN5uxgGaiCtRPdnJIOYJsSSHKBO9Co6SvX5cbOXn0qBGZjBZuq7c5R1xHJd4WWzU/pc9tu+YSrLNOFrj8bR7t5JjZ2v9oi7AytRVzSZ1Xn07PZoPI6xj1C4qkq63vxFUKtqvPzMqKVj+7/x1SG0RLqKxoG2hQC5KvobEN8ogI5xtXIPn4odSNsae/KKOpHCr5QDJXh4wTXLGFdhNK1OLaInA6IH+71P9Ok2DCLBgKRkuwYExSqplwqBCJ2z20GFSW3xemMQxwtMigqgb6ptVfiDgkH8zqbJM+WCCEzYopKX4CGg2mv0EWhjxUXRLvCkTOnaWBmTqXYZYyPv0NzMHPWZ1e033AhbXrAWhrZRO7wEHrwD1aXkj8HYKd8QRnm7mW7ZBDp/FtLtJudGrsPHO0uFF3+lRzKMFJsN9cOdSTBolDAkqKsBxXvkqYkj+Yv5ttgN7at0iH+5JGxZkYBaJHpSthpyloToszBVzkhi7fI4GCZFauCQns1w3oWUML+ZbofqCzSTUwAroN0olGYNdmLxhTLpZp+YLNBuPwJWP14WoCIyJUXBN8A4DY57Vn2JpEvTPYo2L8D+7zg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f505758b-a173-4068-442a-08dbc7158937
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 09:12:31.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ4eLLuGSgqTzL5Eh8sc0u23z0RywvQNWpIwcKJhxlWSsy6V6XI34QCoHz11/xcZewhook3Rfr4pNo4oBYyDWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_06,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310070080
X-Proofpoint-ORIG-GUID: 7z9UGmysl1X6L1zSrtovq-F09rLxQaUy
X-Proofpoint-GUID: 7z9UGmysl1X6L1zSrtovq-F09rLxQaUy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/6/23 22:55, David Sterba wrote:
> On Wed, Oct 04, 2023 at 11:00:27PM +0800, Anand Jain wrote:
>> This adds sysfs objects to indicate temp_fsid feature support and
>> its status.
>>
>>    /sys/fs/btrfs/features/temp_fsid
>>    /sys/fs/btrfs/<UUID>/temp_fsid
>>
>>    For example:
>>
>>       Consider two cloned and mounted devices.
>>
>> 	$ blkid /dev/sdc[1-2]
>> 	/dev/sdc1: UUID="509ad44b-ad2a-4a8a-bc8d-fe69db7220d5" ..
>> 	/dev/sdc2: UUID="509ad44b-ad2a-4a8a-bc8d-fe69db7220d5" ..
>>
>>       One gets actual fsid, and the other gets the temp_fsid when
>>       mounted.
>>
>> 	$ btrfs filesystem show -m
>> 	Label: none  uuid: 509ad44b-ad2a-4a8a-bc8d-fe69db7220d5
>> 		Total devices 1 FS bytes used 54.14MiB
>> 		devid    1 size 300.00MiB used 144.00MiB path /dev/sdc1
>>
>> 	Label: none  uuid: 33bad74e-c91b-43a5-aef8-b3cab97ae63a
>> 		Total devices 1 FS bytes used 54.14MiB
>> 		devid    1 size 300.00MiB used 144.00MiB path /dev/sdc2
>>
>>       Their sysfs as below.
>>
>> 	$ cat /sys/fs/btrfs/features/temp_fsid
>> 	0
>>
>> 	$ cat /sys/fs/btrfs/509ad44b-ad2a-4a8a-bc8d-fe69db7220d5/temp_fsid
>> 	0
>>
>> 	$ cat /sys/fs/btrfs/33bad74e-c91b-43a5-aef8-b3cab97ae63a/temp_fsid
>> 	1
> 
> So the fsid used for the directory is always the new one, is there a way
> to read which is the original filesystem's fsid? In this case it would
> be the 509ad44b-... We could print it in that file instead of '1',
> though it could be confusing that it's not the temp_fsid but the
> original one, file name mismatches the contents on first look.

Instead, can we emit 'fsid' in another kobject altogether?
Furthermore, we also have a 'metadata_uuid' kobject. Here
is how they relate.


1. normally:

  $ cat /sys/fs/btrfs/<meta-fsid>/fsid
  <meta-fsid>
  $ cat /sys/fs/btrfs/<meta-fsid>/metadata_uuid
  <meta-fsid>


2. metadata-uuid flag is set:

  $ cat /sys/fs/btrfs/<sb-fsid>/fsid
  <sb-fsid>
  $ cat /sys/fs/btrfs/<sb-fsid>/metadata_uuid
  <meta-fsid>


3. normal + temp-fsid:

  $ cat /sys/fs/btrfs/<temp-fsid>/fsid
  <meta-fsid>
  $ cat /sys/fs/btrfs/<temp-fsid>/metadata_uuid
  <meta-fsid>


4. metadata-uuid flag is set + temp-fsid:

  $ cat /sys/fs/btrfs/<temp-fsid>/fsid
  <sb-fsid>
  $ cat /sys/fs/btrfs/<temp-fsid>/metadata_uuid
  <meta-fsid>

> 
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/sysfs.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
>> index e07be193323a..7f9a4790e013 100644
>> --- a/fs/btrfs/sysfs.c
>> +++ b/fs/btrfs/sysfs.c
>> @@ -425,6 +425,15 @@ static ssize_t acl_show(struct kobject *kobj, struct kobj_attribute *a, char *bu
>>   }
>>   BTRFS_ATTR(static_feature, acl, acl_show);
>>   
>> +static ssize_t temp_fsid_supported_show(struct kobject *kobj,
>> +					struct kobj_attribute *a, char *buf)
>> +{
>> +	int ret = 0;
>> +
>> +	return sysfs_emit(buf, "%d\n", ret);
> 
> This can be
> 
> 	return sysfs_emit(buf, "0\n");

Changes in the misc-next looks better.

Thanks, Anand
