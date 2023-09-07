Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFEA79789B
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Sep 2023 18:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbjIGQt7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 12:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243551AbjIGQt6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 12:49:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499511FE4
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 09:49:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387GU4qH009188;
        Thu, 7 Sep 2023 16:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=U7dtxqTBMUp2eREReuri1oJ54h6uM8cXWK/1oF+xVjU=;
 b=XKHOj4jB6TBaJpZ7xICfiIGx9U/yMHqrXGPUL7gHGjR21+C6Weoar9GERZB9mMNljGUX
 GwWHwtdk8sLGNk9L0CRQHbt/Zo3fDCF9FuDXjdE1v2R4Cf9qZvjwY5exNKpzwa0FOGyZ
 VlkrBIZ6A6pA95MKpbJbTxofIs9Q6OSh2jkGTuekhHp9eQbZ9st5PokHWcVoOe4hMgXe
 l1Nuj15lV6ZQT39FjGd7AyTrjQ3sPSC38ZPuHrgJN0PW5q0kFrXiuwpzXZLZ5nZZm3ts
 HGUci6O+eWdejumnmOgyTSaVuan9x6ePlu5lCG/09CuA5MG+y/j9h7cYAoEg2QKG6FBZ 0Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syj3br1jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 16:48:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387FgbXO037848;
        Thu, 7 Sep 2023 16:48:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suuge7xce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 16:48:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvNerXNu68rl+RK0C8df/wnlFnuG1HjUDlRV59B9MTZ+nGy+aGn9RfU8f5POXiaBXsaHii10C0FrQwA4JhdzMxgKpkLhhU82wmZ0Oh84fnlbW2QrKYKJvjOZLFSRVgsE5EBQxww7IoEhCdh/2sYUm5RwTyugIo6IchAlk32Kfr9KswAwD/cgXoLunUNU0vI4IH9s8iSO5NOM0uuPnaL9tW1zaxk9bCtZiYBooZAXtT8KVNphleENyM+2MABgvwDnGQ7rWV5eGp7BhBrljlYmntUUUHQLQfDCOVZoWdkg5RCY6t2dKMtfSeiyP+GtUFc4yxXtgYQg+qzvPK4BhySqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7dtxqTBMUp2eREReuri1oJ54h6uM8cXWK/1oF+xVjU=;
 b=DacjOmD1qdm36+5IQrfwzv+0VFScT86cSAAceIN2SWWK4TnWkVa58U1ogZVLzOXfzrM/KgIymRZlmexYg2t9xHWA3k3633gK+EL6YKhtGpxkxZ1FK+9BkkI2C6mximfq0On1KviWbE5LSIjjus6Q6Z1k3+vp7OHMWdyLiYCIJjFcm0FH4aLEHzSrNzE/Xwu9Hn4co+TLuJrG+rYM6Ulo6rqCUMPFyoVj7baJ7Nu2FB8AWnFpiHVelKfvfgOgp8Rr9MlFCdab75OlP6LTWr98ziNVmm+eibWVkemty5ypnuYvHOBEoEsHVmgkqLSNthkn5EWRTZjwc5er+iYMkeE3jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7dtxqTBMUp2eREReuri1oJ54h6uM8cXWK/1oF+xVjU=;
 b=FtWhGguuXwaXateDMBN6KDdeuWCbHzzcqVOZpYGOU8JhZjUsy5fPHWcyQFiq61TP/SywFWyZuBVF8H7ekccYVIvXzibX6J0FM9eV26Ua8gRqhSSBpG0H2Em3h7tcMHeXpf0Iwy/yd0t5kQY3Xnu6a5fXYoNsCTywWYrWYrsDPMs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4225.namprd10.prod.outlook.com (2603:10b6:a03:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 16:48:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Thu, 7 Sep 2023
 16:48:12 +0000
Message-ID: <3a5c3d54-2e34-fe47-1ed0-12c765a928b9@oracle.com>
Date:   Fri, 8 Sep 2023 00:48:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] btrfs: pseudo device-scan for single-device filesystems
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <b0e0240254557461c137cd9b943f00b0d5048083.1693959204.git.anand.jain@oracle.com>
 <20230907143658.GQ3159@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230907143658.GQ3159@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe7447b-38de-4732-64fe-08dbafc23929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnZoulgMTD/Q/BHGu+fawzvDB4RA3/IxRsW3/XqT14bHnmiHD323E/JQ3jOZbAlZBydqJiDEMgPnuCRYuVD39/5h85RFJ71P+yMb8XTGgEl/G2THORWxbOp3sQYi8audv8ke04vucjmVZo0Yge6Z+8E+Otr4yu0dZiNElk4qLHxpw4ZgW93QPRXXx4lScZ9HYP4GsAG3wiYsoHgJHhAalfg28UfkevMLjHKJohAEnlH/UelmhT0YJaRML3Y0Rc6x9kJWZQZ21g4ZJkpxMzaF5m8CcnBipGhtaTJtuKGlgKkz35P7VW1xIZoz3wDB73fMjOTHRMDDFPLXcmB7e8yW4W3zBqiNRJKnQr8tPibRQqTcO0VNr0BFCLS7vVdZsXqLFqXKWLQwNSEjbFPNClkqyyAM0YnvFzq/2jz++WqIsjIyh2vFQc/P/Ljz1jntVUl76zO05ttjICtDUBpA+D4u7ysKx2PPA43w1PgjrfZUoELbCw3MochY9Ynm0+y4Oy++UNArIHDuy3MHgA4QA+mt/GchJHECVgaVMw5Bb7jXITGhfYZSujnEForb9LxTievpn+jpgyV1m5lv2DK4wQaeAlMDRGA97ukZ1fzJ/aHChptsr2zb3oI+Oawl94uLJnRSuOzZXU8sZdmfXm4UV4atxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199024)(1800799009)(186009)(31686004)(6666004)(53546011)(6486002)(6506007)(6512007)(31696002)(86362001)(36756003)(38100700002)(26005)(2616005)(2906002)(83380400001)(478600001)(66946007)(4326008)(5660300002)(8936002)(8676002)(316002)(44832011)(66476007)(41300700001)(6916009)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGd5cGZKODlpM2p3UmxqcTV1MnZnWHhLb1JGVmJHYmtjSS83azJnRmxCcTRR?=
 =?utf-8?B?aXpSeEpZWVFsc0lqZCtncWIvVFFabzAwZ2xPcW9aY1lteHhtQzU4dC9PUmxM?=
 =?utf-8?B?U2lpTTdwY2NOcTdVako5RUwwVDFta0JnS21URkNpV1BQV3lDZFhWUldERmdI?=
 =?utf-8?B?eXdBZXhGR1lRWWQwalY4eFFCdVFuYldYMjBiYW9SMHEybFJUMzNML0ZycER6?=
 =?utf-8?B?RFlaVGRkSGZWU1ZhQ0EvQXhzbC9NNWhtNlZFa1UvNEZBZ01ndXF6bGVzcmgy?=
 =?utf-8?B?OHVEbE5rV2V0VHRKM0VPRk9UOVlyME51anRJL0JYRkppcEtUUktJY1hrb3VO?=
 =?utf-8?B?eUprQmhkTk5QSndIMlRFajFzc3VBRGxvT3RTTVQvekRnc1h3TURia3pVS3NW?=
 =?utf-8?B?SlF4RFdNQ3NFM1VpaXVJWDhnVGpnaFYrZmVYdXBRS29VWEpvWFBGVVJQMktF?=
 =?utf-8?B?cjFBVjROR0RCWHRWbE1GdnR5V3lFelZUUVVxWUxwY3ZZRUkxK2NyT0h6dk5W?=
 =?utf-8?B?Q2M4ejhnMU5leHlpQzdNWlA3Y1pWa2F0cFdad1hxSm1QSCtydlV4cTRZNTl3?=
 =?utf-8?B?Q0NhbnZzQ3Z3U0FlcU9TS3hRTjVSemlETVlQODhzWGYyVmM3aURtTE40eW5J?=
 =?utf-8?B?a2RiWkkzNVlja1NvWlk3NHV6VE4rM3AvSHVmdnNlWThLYmFTVGpQZmFRRzNy?=
 =?utf-8?B?Q0FiWlRpWlZyUEFZdWNkcWxJL2pJYXFHV3hKL0REN3VEMEw4YlRabGJ5dVZH?=
 =?utf-8?B?SVlHRHpXNGVDSjhOU280b0xuNHgxSzArNUJjMTVSSnR3cmUwYW0yYWkxdTRP?=
 =?utf-8?B?bjM3WmswdWdRbklSbWsvRVg3U1ZzUkNzMlVSSTROYWtuVklZckdUUkJ1aEF4?=
 =?utf-8?B?NGdubFlKbG1HL2RwRDZJaTlwOFlPV1lBT2hYV2YrR21QSVl5RVhPdTJ0QUk3?=
 =?utf-8?B?NTBQYUNUSVU4VlN5YUt1aGJYaWpqVG5XS0l0VjhBT2xyQ2VHclhDQVQ4Nnpa?=
 =?utf-8?B?R1NSNVdsQ1FoRHJ5QXpmcmZlR2J0elV5T1kyUXpLeU1nVk4vaVRFNUs0NVFQ?=
 =?utf-8?B?SWV6VGJuMDBKTnhxQU0xQXlKSldsZThBSTdhWDA1ZDdDK3BOODV2azlBTEhQ?=
 =?utf-8?B?clNlQUU1RVlUeEZMeTJJVEloa3h6cHJrRWExQkZOeWp3UU5jVmtUV1pWUUlI?=
 =?utf-8?B?S3FmRWk4SFd0cVdhWHd4VWtaV3M0ZU9sTk1Hejg4NWtyNVFZVnByRXl1QzZB?=
 =?utf-8?B?bGRuYmk4bHdNTlI3alRrak0xV1kxZW45NDhjY3pZL0FBTGVibXJveUp5VExi?=
 =?utf-8?B?M1RxaWVIOThZS0FjS1lqV2Q0Zlhrcjc0dXQ5MmdYZ09ZZkc2NVVRYmUzbUFn?=
 =?utf-8?B?b1BOSFB5RUxTZHh2Rmxad1c3Slg0blhycHBPNVRQWERiRWN5b1NpdVBHU3dH?=
 =?utf-8?B?eVkwU1pUdmFCelJiWTdkRjhvS3RSd2RhZnBtQUNaWnliVjZSOXdLSlFQUXMx?=
 =?utf-8?B?TEpXSTJOSmRZYlJDc01RMXBTT1NDWjEreUtRd2hUNy9FK1V1a05PMFJjK2pt?=
 =?utf-8?B?Ti8xSEt6Q0xLdm1ONEdPZ0xNSk12WjN1S29MZzRKMStTWS83ek1pWlBDRUdn?=
 =?utf-8?B?dEY4WGwrZWdkamI4NzUvT2dRZ2xpc3VpeUtjMHdIZ2Y3Zy9tdVIzNlMrTG9Y?=
 =?utf-8?B?TVF3RVNIUzhZS0NmdnpseFlPd0hMU002Z05rUFVSbVpuOVlmMEJsRTVkZFdD?=
 =?utf-8?B?QjZzM2h5SXZTMllyYmJnMVE3aFRleFFyeENKS0tVdTVKUFNpa2c2TGs0Kzhq?=
 =?utf-8?B?ZFhtZ3lTTXJkdy9GMGVQeWpiSlUxWXVyaDlKZXFlK2pOOFZWUUl2V3Vmd0F3?=
 =?utf-8?B?K2pxUWlaWTdmanQzVGZkMVdhMis5WHdXSlY3YmJTSmJ3bzZIdngyUUpHd1Zv?=
 =?utf-8?B?S0ZRWnlQaUMxOWFWMFdwSFhBZzVyem1PUlpCZmhCL29BNlE2eWFaVnhhRkxL?=
 =?utf-8?B?RTFuN1RXN2xRNGVrSmpRSVdlaENJY3lhM2pTKzEwSVJ3NDZPbm1vUEdxdWls?=
 =?utf-8?B?cVBJbjJUUkh3Wmw1S2Nwd2VEKzFIdVdkWVJCZTl0SHlSMjd5WldSL0ZYRllq?=
 =?utf-8?B?T04zbE5IL2pFZHVnUGE2V29DeVNFbnVUQlRablRLclF5b0FRNXRhUDRIbEdh?=
 =?utf-8?B?S3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bqFDEF/fTpMGDq7A60eAyvFSe1bD3LfzysDKCt4TbiTMNu2rJcsITAKzEb2riWFOegzTk+YHsiFK8+Z9Sv04f9qtoBs0L9RjmJFyLR3WtRLH11+AtB9KV6d61fn4b4U2rpbM0iUD92r9wQmGR8f6PVXyRshjhgOkmsYXIyaLHO3Bfw9fqJisobbipQovpoO/Su0dsagAwBYc190wH25cbqiPbV5TLdjgTkbnFnL7E7LVku4xZ11RGXqLInazNzBaJHZYGGlTGRy59AQytB1JHDs3rSmzpWpo/MJlXrNPyr/ugPOS9pIrfjqID7qdPrpBMUZbLQoyHwbOv/zjdKbvCki55T2F47QBu+bBD2bqsItJnpQ+33wyEWHqksePSd0rgK1Z6CAtvUJDsigYoWbbfNempgF5vFemEu96JJnHUEuBQ+QX0EVMNLajtlfjwQTLuqV3vU+j48XJ85gk3pbP4d+++UcYoxpPpGlttaaXambw9Z7QPBkkZjhqECK35Q5FS2dK7WKCqvPaeXWaWXaMzZzcDKhHNNZB3RWgaK/+CbvCH1U9fQy7qC7JTsjUcvKxvnKqYxq/45+TbhqUx6ZOyLvq3MzKvsCXxKUE5ydwlLA9Vjp4NecMbdNyjBLiKyFoU2LFOM4jtpWXK31JM5bSRgpIYzinDum05/8elRjv5pilPvAiEHyA0P74RBbwyHZdEBBr+bSKYDEcGtEnbU5EOW7xlwG7Q3VEdd4/jPykcc+y8OE+Boj1ejVHTEIo4/8jd6DjBS82os5/Qp1d9/V4LQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe7447b-38de-4732-64fe-08dbafc23929
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 16:48:12.3544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HjIK/RexF24xoKcc4IFLy+M0NKZeISZzMTuM1S3e+ed2KcDlJ9Xl2OwV775N3CkAZmUliyNZLmDpxeAYx5ftg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_08,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070149
X-Proofpoint-ORIG-GUID: 3YaOJr0GBu98ym723qDivr66_VcCJYv8
X-Proofpoint-GUID: 3YaOJr0GBu98ym723qDivr66_VcCJYv8
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 07/09/2023 22:36, David Sterba wrote:
> On Thu, Sep 07, 2023 at 12:27:41AM +0800, Anand Jain wrote:
>> After the commit [1], we unregister the device from the kernel memory upon
>> unmounting for a single device.
>>
>>    [1] 5f58d783fd78 ("btrfs: free device in btrfs_close_devices for a single device filesystem")
> 
> You can write patch references into the text, the [1] references are
> more suitable for links.
> 

Got it. Thx.

>> So, device registration that was performed before mounting if any is no
>> longer in the kernel memory.
>>
>> However, in fact, note that device registration is unnecessary for a
>> single-device Btrfs filesystem unless it's a seed device.
>>
>> So for commands like 'btrfs device scan' or 'btrfs device ready' with a
>> non-seed single-device Btrfs filesystem, they can return success without
>> the actual device scan.
> 
> Just to clarify, the device will be scanned as read by kernel, signature
> verified but not added to the fs_devices lists, right?
> 

Right. btrfs_read_disk_super() called during scan, performs sanity
checks on the superblock.

>> The seed device must remain in the kernel memory to allow the sprout
>> device to mount without the need to specify the seed device explicitly.
> 
> And in case the seeding status of the already scanned and registered
> device is changed another scan will happen by udev due to openning for
> write. So I guess it's safe.

Changed? I think you meant converting the seed device back to a normal
device.

With the current code, the stale fs_devices will remain until the
changed device is mounted, as its udev scan will return success without
calling the device_list_add() function.

However, there are two things we can do to fix it:

In the kernel, call btrfs_free_stale_devices() before the pseudo scan's
return.

In the btrfs-progs, 'btrfstune -S 0 <dev-seed>' thread to call 'scan
--forget <dev-seed> ioctl'.

> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>
>> Passes fstests with a fstests fix as below.
>>
>>    [PATCH] fstests: btrfs/185 update for single device pseudo device-scan
>>
>> Testing as a boot device is going on.
>>
>>   fs/btrfs/super.c   | 21 +++++++++++++++------
>>   fs/btrfs/volumes.c | 12 +++++++++++-
>>   fs/btrfs/volumes.h |  3 ++-
>>   3 files changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 32ff441d2c13..22910e0d39a2 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -891,7 +891,7 @@ static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
>>   				error = -ENOMEM;
>>   				goto out;
>>   			}
>> -			device = btrfs_scan_one_device(device_name, flags);
>> +			device = btrfs_scan_one_device(device_name, flags, false);
>>   			kfree(device_name);
>>   			if (IS_ERR(device)) {
>>   				error = PTR_ERR(device);
>> @@ -1486,10 +1486,17 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
>>   		goto error_fs_info;
>>   	}
>>   
>> -	device = btrfs_scan_one_device(device_name, mode);
>> -	if (IS_ERR(device)) {
>> +	device = btrfs_scan_one_device(device_name, mode, true);
>> +	if (IS_ERR_OR_NULL(device)) {
>>   		mutex_unlock(&uuid_mutex);
>>   		error = PTR_ERR(device);
>> +		/*
>> +		 * As 3rd argument in the funtion
>> +		 * btrfs_scan_one_device( , ,mount_arg_dev) above is true, the
>> +		 * 'device' or the 'error' won't be NULL or 0 respectively
>> +		 * unless for a bug.
>> +		 */
>> +		ASSERT(error);
> 
> Could the case when device is NULL be handled separately? That way it's
> not so obvious that we expect an error and also a NULL pointer.

That's neat. Will do.

> 
>>   		goto error_fs_info;
>>   	}
>>   
>> @@ -2199,7 +2206,8 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>>   	switch (cmd) {
>>   	case BTRFS_IOC_SCAN_DEV:
>>   		mutex_lock(&uuid_mutex);
>> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
>> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
>> +		/* Return success i.e. 0 for device == NULL */
>>   		ret = PTR_ERR_OR_ZERO(device);
>>   		mutex_unlock(&uuid_mutex);
>>   		break;
>> @@ -2213,9 +2221,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>>   		break;
>>   	case BTRFS_IOC_DEVICES_READY:
>>   		mutex_lock(&uuid_mutex);
>> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
>> -		if (IS_ERR(device)) {
>> +		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
>> +		if (IS_ERR_OR_NULL(device)) {
>>   			mutex_unlock(&uuid_mutex);
>> +			/* Return success i.e. 0 for device == NULL */
>>   			ret = PTR_ERR(device);
>>   			break;
>>   		}
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index fa18ea7ef8e3..38e714661286 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -1218,7 +1218,8 @@ int btrfs_forget_devices(dev_t devt)
>>    * and we are not allowed to call set_blocksize during the scan. The superblock
>>    * is read via pagecache
>>    */
>> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
>> +struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>> +					   bool mount_arg_dev)
>>   {
>>   	struct btrfs_super_block *disk_super;
>>   	bool new_device_added = false;
>> @@ -1263,10 +1264,19 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
>>   		goto error_bdev_put;
>>   	}
>>   
>> +	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
>> +	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
>> +		pr_info("skip registering single non seed device path %s\n",
>> +			path);
> 
> Wouldn't this be too noisy in the logs? With the scanning and
> registration repeated scans of a device there will be only the first
> message, but on a system with potentially many single-dev devices each
> time udev would want to scan it and it'd get logged.

Ah. I used it for debugging; it should be removed.

Will send v2.

Thanks, Anand

> 
>> +		device = NULL;
>> +		goto free_disk_super;
>> +	}
>> +
>>   	device = device_list_add(path, disk_super, &new_device_added);
>>   	if (!IS_ERR(device) && new_device_added)
>>   		btrfs_free_stale_devices(device->devt, device);
>>   
>> +free_disk_super:
>>   	btrfs_release_disk_super(disk_super);
>>   
>>   error_bdev_put:
