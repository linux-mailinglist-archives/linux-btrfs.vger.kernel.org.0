Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B194C7BA06D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Oct 2023 16:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbjJEOiQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Oct 2023 10:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbjJEOff (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Oct 2023 10:35:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC6D36A6;
        Thu,  5 Oct 2023 06:59:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3950k1Cw024157;
        Thu, 5 Oct 2023 08:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7YEsEyST1UDExCPSJC9NoJ0SebrIyyILJG3EtyMOEr0=;
 b=qZjgSvhM2MpiQti13GVWgyHLGiX6AT/4nJuED0c/N0XsIBV4wH28cvQcHxju89FA3akn
 TJ+feHzxsozwh5qd2XrFw3UcerXhIIyad0SP1XgsAPgRYNELYLRVeBRDn0WlyqvhiTB+
 p51hA0MkZJ1cJ7Br7CaI12UZRZz98w/aKmmd07Q1Eo989nZoBZ+fLTvx7u/H05lPuKyJ
 P7j6FC+ukTMXYFXmtk1H08ChcrIC4I9K3DMZHdpkhCkO/aApuOebhUFKiEiSViMWFyJR
 iXRZvbdhRwLef7YriRnVNC+KIUYGKtVsdX49814vZDodPS6aAKWpTCen9e/RWZ9E4YjT Jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf48xmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 08:08:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39573X1m033595;
        Thu, 5 Oct 2023 08:08:14 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea48x9fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 08:08:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQsf1b1nU7j2gPuDkkW+6uQAi6XDNQOYEG8BB/GcqnWOFJptrSe7/Wksr7elBu76+tqAtLBj2MTZ/BbgV+FAuFeKV7gaeeQ+416/7u1RGUJcacKxxGgiRNGcxUCfWraXjWk2bZ4uiwfIs2Qvv7Aozf29zLuRQ5PfH2kFO09FLFf89ybL1T/D1GEsNnhlOX1E9oaEMyCnrt2iWyrm9fpvwbJE68bHk83LHSnS7VDOeJtP8H7FEY/pR+2iizJl8hHwj/1pSYJyvDPbYwz241YgJXaWgbNxaulg/GS1IVRpxIN5DtWEwdRYfWptq3qfBlV6k0apse4pieB2djUwJrnFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YEsEyST1UDExCPSJC9NoJ0SebrIyyILJG3EtyMOEr0=;
 b=efYF9seOpMwveHKcpKbqxTvnuYJSjsn44mqMpKIGYwz+1ooxxNBgeHDqaYrNus494nZV8ji4GsJD9Oge/MTfSHN0TkSGV1A9dd/PhRn4xH9MHxvJMxBsk3BFajvF2vP0exySbfI3WqiVn4V0ILh2bOlHKUMnQJ0uDFSF7ijNAU8EyGKBqvtL/6n6pe2hRpE/ZI5QBB1ZQAqVIXIIvp6tDAK5KIsqb8fLOi0IrpXsSD+dPewiKSrQcghLc1aU80GHi37caKpASfqmP/ntdoxB7kITTW1lDUXDlj6hlGOL3LULutCQtpQQSn+uyWxFmjgdWlFIt+0EekAt33Z5RToYHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YEsEyST1UDExCPSJC9NoJ0SebrIyyILJG3EtyMOEr0=;
 b=UzQMa+wOZYKbfeGk4TL8T0XmxYiAlLbrK3Nseffvc4qbOG6sTKZHimWDNY7i2G9CuUTiRdemlCviqQtPjDtcY6Y5cmkBQhaJXihSb+wt0iM/P0hfuP4PMwQtuQiGy8484QHsVHJbYOW7h7XBBG+rrldJmeq4mQUqhx8WubjwhnY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4770.namprd10.prod.outlook.com (2603:10b6:303:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Thu, 5 Oct
 2023 08:08:11 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 5 Oct 2023
 08:08:11 +0000
Message-ID: <1ba5097f-c1cc-45a5-817a-4ef32749fa72@oracle.com>
Date:   Thu, 5 Oct 2023 16:08:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] btrfs: simple quotas fstests
From:   Anand Jain <anand.jain@oracle.com>
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <cover.1695942727.git.boris@bur.io>
 <59124721-0e07-7b5f-d650-d58d9ce9fcb2@oracle.com>
Content-Language: en-US
In-Reply-To: <59124721-0e07-7b5f-d650-d58d9ce9fcb2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4770:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cb91ab-e9b1-4129-f26b-08dbc57a376e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JV0286w0fTgHZ9+LTkfSIY4h0XM12SpLwhf4IcQ9FkOxCgIP76AsxLf6kbfyeV5HjD+7N3BZgYEIC9Mec5YJDV/yVgin+IIgRZ1iFpQOSEgu66Mim+yVg7iGlVdZeuEbx8JAYmhrdm+L56RhmfsLbu4n/MQ/ojWeov5fuCEJCP9IsQEuzX2zhvNKQGkZiB+PyTSNeN4npyUKxy7xBeO5Y5z7/Hpaw64QtcCGppiRy9JAgdgUBfWiQut6qy/z8KdfUuxJ9upwJXkGghb4jjWDYdZOTFs+TDUskgPFUbsMvDqtHJ8ku2TS5ggKS2GCX8q7lyCXgtMoB/jXar2c/RbZXdm9Z1Q7rKTyeUsns36DNNQNqXdYlSEJMRrWtagR5WYVrrMQMdwKN47JCwYp8WDGsQc8YOofFpeYdFNs9+Wj4vVz1icXxEPBJA+X4UdGIsXhslKOAVvC0/zzJ5NinvQFcVvrx6bFDP9EobKqn4BUBqaOtCbRnllpnR5Dx3fJxVBEJpxqYSOdmX4XOKm0a4DSJBYDNuyWLOa/fW7jDJWFHviub5jYRqKaEDXe127///AqyZZDdxTbS3qoUNrYU96+/nOrDgYs5WewLkwum8zSh3dVGx5iFzhhmXpZ8RLmC4pa95hLnLOVuSiYnkckSAIXfpURf5+R65aWZO7GlqLTJlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(31686004)(6486002)(6512007)(53546011)(6666004)(6506007)(966005)(478600001)(38100700002)(86362001)(31696002)(15650500001)(2906002)(83380400001)(26005)(2616005)(36756003)(66946007)(66556008)(66476007)(8936002)(8676002)(316002)(5660300002)(41300700001)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3RiMUZLSEs4eUlURW9XaTF0WHl2K1R4QnY3aVlvOHhWNjVxWDRobWJidGxI?=
 =?utf-8?B?d2VEdmxKaFlvS1FuQklCNjBxUWVmcUpkdGtBUUlTdi9sekxqTm5ubDlBckhy?=
 =?utf-8?B?V2w2bjRVU3BkVHVoaXlRb2ZUV2NCcXJsRDhIa080RnladkRnN1ZlZTFuYllv?=
 =?utf-8?B?N0hyOG5hUGNqOTMyTC8vVDA5RG5aWkc3NGJQcnNaUlFVbDEwYjFtSVZGaWFs?=
 =?utf-8?B?ZE04WXBXTGVtK0d3OW81MGFKUWNZakJmb3ZNRWhTMmc4Ty82N1VXNU0rWk9q?=
 =?utf-8?B?R01WcEM1WkdMMXpaUzJ3MlNWOFBFYncxOW1IK3BSVkRaZVgzT0VJRFp6Ynd4?=
 =?utf-8?B?Y3J3VXlJTlFrOHZtMmxtZmtmdXIrNGY4aXZOc3BPQy90dEdwMUZ4aHBBc1pU?=
 =?utf-8?B?c1Q4dXdQbENkK0FGT3kwNTZOR2w2MDlpc3FodmJXNGJLV2VWNXpzczA1TjJH?=
 =?utf-8?B?elFSaER2Y0UzNjZRNHNDWU9xQ0hNeG1MSFphOFdrUHE5SjZ5Tm9MU0J6QkVW?=
 =?utf-8?B?bzRhTWJWTXNIa25PR2xldmd6V2lmZ25veUY0REwrUzdEVDNlczhpemo2Z040?=
 =?utf-8?B?aEVVRVVWV2JnVGVwRDJzK2svQXZta0l1MFlDMzZheWkzSkNzVVBJSGh3NjVP?=
 =?utf-8?B?NFJBeFpEalJXU2NzOXJESGxrVU00K21VSnFOL1k4aGFVdGo0RGVmV2E3Rk95?=
 =?utf-8?B?RU9nS1FsRktPaFhGc3JYaDBGb01YMDJZOWRXODN5Y1FQeFg0Y2txQWhPK3RM?=
 =?utf-8?B?T1ZRaXRGdklFVUxIN0Y4UnpNQlE0dFhpeGk4NU9ESm5IQktlMDc2cW1nSE9Y?=
 =?utf-8?B?Ukl0bDhIMk9UdmoxUDJZbHFuM3ZYN0d5K3EvNHZZVGExbVVic1ZOWXZkcUFE?=
 =?utf-8?B?NnBZWGljTUc0Q2wxNkMySWIwbkJXVVZueHBZUUgrTzdwVmh1M1VGdll0RWVx?=
 =?utf-8?B?SVJ2ZGJXWkxwK3lrSWFTRVRLWUZrSVk0d0k3OTZibE91TVdiMGJLT3Rsdzlu?=
 =?utf-8?B?Rkp4V0RLdGxwNnhPV1NzdTR2T0k4SW1NdlVacHVERE9vNGlMNGIzYzNTeGtr?=
 =?utf-8?B?RWtodWhYd2ZxM2lPTWdqUWRnUTlGcUN4eWpudm1BZjZLSEs3emluSlZvdS9n?=
 =?utf-8?B?VXBvcXp2UldSY2xsQmFIYm1CTllnZXdPMFRTV1o5UmNVNm9zMmp6MnIwTWtP?=
 =?utf-8?B?bUR1QkFobURuOU04Mkw3RDFYVzZkeVpZanBPUWVVNmxrd254MkV6bkE0ck1n?=
 =?utf-8?B?Q2pYMk05ek5BSjJvUFZaYnd0SnpyUUFqOUdVUUEvTkFYR3BtV01YN2Y1SmZF?=
 =?utf-8?B?cUNNZ2tTeHNDenV6U3FFN0dQTTlPckFaNXFPVXM5Q1pXN1BUWHgzRGttcGkz?=
 =?utf-8?B?UC9XNy9Wcm13Zi9KMmtuY0xodkNob2QycjVGUXZBUzRHTUJZbkhkSW9NbDlR?=
 =?utf-8?B?dXpBZndTUFBGazdFUXBxV0tFa3Y4ZVpjMW5WdWJxVG5qdTcrQ3o5UlY5S3dU?=
 =?utf-8?B?UlZ4em5LTmJ3RHgwWXhEVmpUc0tzaEZ1a0FNbFFUWWV1YjIxV1owOCtMMTQ2?=
 =?utf-8?B?QStQQkNKVUZiWkRIa0cvakpQY3RxTm5VMGhBRjBKaG1BVlBXQ2xPU1FnN1dq?=
 =?utf-8?B?b3RjQTZHMjhCemtKK0p0OFZJN2VsazlDOG1VSVpBS1oxWFNKUHQvZnlHYzRZ?=
 =?utf-8?B?Q2hLc1ROWTFSRTJjS0pMaVJJVjJ0L08ydENnNDI1a1ZYc3A2WUUvRE56THQ1?=
 =?utf-8?B?aWdVdTVxbExqSE9EYUNxRjVuMXliMkpRMWtVNHRNUGF2VEwyU2c3aDd1YzBx?=
 =?utf-8?B?UHJ1T0lEQ0lTb1QwOXl3elFYMW5CZGNRaGsrMFo5ZXpVbkx4cjlhSWwxZEF6?=
 =?utf-8?B?QUY4cWxxVHI1SzNpUWJHdjhIVHFyYVR6dlR2U3ZCY013R2VFYTRzNnkycDVP?=
 =?utf-8?B?TFo1bWkwUW5INGthUnBhYThSN1lsNXBLczhHdld2dmNiMTRBQmlIUTJZcStG?=
 =?utf-8?B?M1ZOckhYaWNFV2Npbmowek1VNStMdElLdCtRNU1XOTRsRjB3V21EeHlUay9y?=
 =?utf-8?B?OXZEa1FxbDJNS2ZYMVNITzQyZFluTjNLWjk2N2xFa2lXbVM1TkFHSDB5bTBK?=
 =?utf-8?Q?14iY1Ojfq+fvxG1XVaW7dlydx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mzVs8bv2+XkVsPDeeCwutmEthLv/+12X5GHZvacysoGPoK97shFRl9knpifIrJzrOur8iyCmm/S/305+BZKNUHkVydYc1rtRc822YhDCz5qU45VI81nGJPkue8o+3O0yiokfTv8+/eyux4QVTaXRfEIunacR41dyWyGpk5UWmqKO+D9LkyXTnHsEcgL+ykFaxz6fPkpxwyrALJ3UMpracStfOsvBbUJ7bRpE2sHQ0WtmJGOq+rOTt6iG8PRm/v5yOuCfUqvMhBLLxD7gLfYD4EwUmMcdyasRSQNJsNTBNrKcEQAVyfvc/5n20bExJ0WOQvPgxlpzmT5V7OTvyjhQrj3KS6YkxcAg6PIoCcwm73I0MSZJ73hCXItvMLmIyp3F3v1oGu6BI1FlNoNvPznH7404xTp6a1sS7N1bdw1vGQatvQvCP0x28oM5E3z7ovsP0tsmiGRCZbEnZCHiNMk3/98zVpU1ytLGkq2CxZ8YqvyhyQHtQaaFYgqOGpmJfA0Wtg5TujAP7pVUxbRND6xtzTmG8K07I+rCfRXxUVVeXTO67BlcK3Fmd5CziiB+jMKWawHRtySLFW3s3CxUI+F6qMYd8d7YA7Uhk0vDFozxT0hCOeaEwmF8XC7CY/Vk4KP9MqMNnlqNOZovQTH436HlLnIRXnXEixfDCZ9X0wKOy88o7/t6SDNIqNDyXWVqDQV9oFsD+n3ZfbzCMsOaDpO+Au5Wz2VQ8xz4eMViiPJ3Q9QRX/vaYuVTDbGT2sw6GfqaP6T3ZZb2rjtUT4On94WXYRrJ6ChEIGRn/qZV+HD+QgE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cb91ab-e9b1-4129-f26b-08dbc57a376e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 08:08:11.2714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWBMxG/f9pSoFBAPR8E5bAPA51WHIxYeoZCB8VL4H27Nqz5Ubg0lROjAd+JOu+03u7qxsapwcWjZnuWY/IP2RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_05,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050061
X-Proofpoint-GUID: BZZvVYnrqGk37X55rInpPZZuZddVjdnf
X-Proofpoint-ORIG-GUID: BZZvVYnrqGk37X55rInpPZZuZddVjdnf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9/30/23 17:45, Anand Jain wrote:
> On 29/09/2023 07:16, Boris Burkov wrote:
>> Add a new test for specific squota scenarios (btrfs/301)
>>
>> Also made modifications for passing existing qgroups tests when possible
>> and for passing all tests with simple quota enabled via mkfs and with
>> squota-aware `btrfs check`. Since this required reading sysfs files of
>> scratch fses, did a bit of refactoring to make those checks target a
>> device rather than assuming TEST_DEV.
>>
>> btrfs/301 depends on the kernel patchset:
>> https://lore.kernel.org/linux-btrfs/cover.1694563454.git.boris@bur.io/
>> and the btrfs-progs patchset:
>> https://lore.kernel.org/linux-btrfs/cover.1695836680.git.boris@bur.io/
>> (and config appropriate binaries to use squota-aware versions)
>> ---
>> Changelog:
>> v4:
>> - fix rescan helper bug
>> - fix broken tab/spaces in squota helper
>> - cleanup comments
>> - improve test names, add some comments
>> - switch to remount commit=1 for forcing cleaner
>> - fix group list for 301
>> - use reflink helpers
>> - output errors to 301.out (and have expected ones there waiting)
>> - cleanup "/dev/ksmg" writes I missed when grepping for /dev/kmsg
>> - cleanup variable names
>> - proper fio/btrfs/xfs_io requires
>> - read nodesize from dump_super
>> - sync before dump_tree
>> - documented all calls to sync
>> v3:
>> - change btrfs/400 to btrfs/301
>> v2:
>> - new sysfs helpers in common
>> - better gating for the new squota test
>> - fix various formatting issues
>> - get rid of noisy dmesg logging
>>
>>
>> Boris Burkov (6):
>>    common: refactor sysfs_attr functions
>>    btrfs: quota mode helpers
>>    btrfs/301: new test for simple quotas
>>    btrfs: quota rescan helpers
>>    btrfs: use new rescan wrapper
>>    btrfs: skip squota incompatible tests
>>
>>   common/btrfs        |  56 ++++++
>>   common/rc           | 127 ++++++++-----
>>   tests/btrfs/017     |   1 +
>>   tests/btrfs/022     |   1 +
>>   tests/btrfs/028     |   2 +-
>>   tests/btrfs/057     |   1 +
>>   tests/btrfs/091     |   3 +-
>>   tests/btrfs/104     |   2 +-
>>   tests/btrfs/123     |   2 +-
>>   tests/btrfs/126     |   2 +-
>>   tests/btrfs/139     |   2 +-
>>   tests/btrfs/153     |   2 +-
>>   tests/btrfs/171     |   6 +-
>>   tests/btrfs/179     |   2 +-
>>   tests/btrfs/180     |   2 +-
>>   tests/btrfs/190     |   2 +-
>>   tests/btrfs/193     |   2 +-
>>   tests/btrfs/210     |   2 +-
>>   tests/btrfs/224     |   6 +-
>>   tests/btrfs/230     |   2 +-
>>   tests/btrfs/232     |   2 +-
>>   tests/btrfs/301     | 435 ++++++++++++++++++++++++++++++++++++++++++++
>>   tests/btrfs/301.out |  18 ++
>>   23 files changed, 615 insertions(+), 65 deletions(-)
>>   create mode 100755 tests/btrfs/301
>>   create mode 100644 tests/btrfs/301.out
>>
> 
> All test cases modified here run fine on a system with PAGESIZE=64K,
> except for btrfs/153 with and without MKFS_OPTIONS="-O squota".
> btrfs/153 is successful on kernel v5.15 (I haven't tried other kernels)
> 
> btrfs/153 2s ... - output mismatch (see 
> /xfstests-dev/results//btrfs/153.out.bad)
>      --- tests/btrfs/153.out    2021-07-13 08:07:54.096971521 -0400
>      +++ /xfstests-dev/results//btrfs/153.out.bad    2023-09-30 
> 05:33:53.560640258 -0400
>      @@ -1,2 +1,3 @@
>       QA output created by 153
>      +pwrite: Disk quota exceeded
>       Silence is golden
>      ...
>      (Run 'diff -u /xfstests-dev/tests/btrfs/153.out 
> /xfstests-dev/results//btrfs/153.out.bad'  to see the entire diff)
> 

The test case works with the standard 4k page size. It's already in
the Staged branch. Please send any required fix patches when they're
ready to be applied on top of this set.

Thanks, Anand
