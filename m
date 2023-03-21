Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2010E6C3318
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 14:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCUNlN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 09:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjCUNlL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 09:41:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE30B6A70
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 06:41:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LBi6FN032664;
        Tue, 21 Mar 2023 13:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Rrtvf1MjA5rX9OXeJY0Hi1MzsG9DyIM/izS5nIKx5FE=;
 b=c39OEamwvj6DAmw3tRyzPxNmOjgPnBZk0rVyClPQ6nOmmkrWK+Rdta13//ifLagbnOXF
 VR723/Td8xecP42YFKR4Cx/t7Q+QrUn43mBDrWQTlsieY8C10vO3/nbGF1nfa8R/zuBh
 XHM/FaAYBrc6cjqR9QNN8rU1LU8+YngZWkT9xF69eLEygpIn8zHq7qCSy6ymkNUp+fWw
 /9mxH61ZLKdPCK5Mdfl1mosGYNgjToaIPi8PdnHXKrrCqK/FvVQvowi0ZKyNe7cTpGeK
 iU2OZAQ1acfiyXK6AKK4PD1cnjp2qAf2/fK3DYeDM8OC4HM+oKdXSiUt4557qD36TxPx cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bcea34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:41:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LDGUGZ015666;
        Tue, 21 Mar 2023 13:41:02 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r68tnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:41:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPI2sCHGGnOtJPCb67PQ1aTFxZTgym5PHUQpd1OwuoMNAiQzWX1PXlnEX+9/AMH6Pi7TuIyhVbJvbmxsmyj7qNQpZo0+TD7IrcdR7FzcR7z4sPseBzVboz4HkpetzpfhDB9lEAJso5T9d6WVyLitLVFmg8ZYCu/kSa3mJVmDoCJ0f49+eRBoXHGmu/x7DCIeGhxxa+1C+AvYQCr3AKe6zHDikS0MGJRvyjjUPfZ1LKhmzIDAUh0HPBjwuH8UbArJV9PBBH1WTkClqpOTtQVWa++JoLpe3iZlwMswUMMqb+OJi6AGz6q0eYBM+mTB3A6g5OlQisyMeyxX7sKgq5m77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rrtvf1MjA5rX9OXeJY0Hi1MzsG9DyIM/izS5nIKx5FE=;
 b=CE+zKHfkKuOE4s8IVTaREMDo9B3DTVBi2gP1d4eQOVY6iB677YP9qFxIg0umqbJRH9rh9P3ytJk7g0vcx911ZYYiaUXTLQF26/5+/X+cnELcERX9V7+3jFydZh/u0LlIlKViqOL94cywm2wLPdSC3cPoGCEDPFng7kAjnclKWVMRm/tbk8i6jWPArMVfRxNiZayI7VzBPXLJaZxkgMwRvksFnm3i1nmOjge1/maZXrvbLylDDTSnMZz7mtf2XiyDudWeuid/VmvrlgG9n3TiC4UJ3jyfbyhUk7neVp730O8IokcVj2iXvNYjc1Dd9Tne8w0aa/jmcf9xXoR/IKSKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrtvf1MjA5rX9OXeJY0Hi1MzsG9DyIM/izS5nIKx5FE=;
 b=NO1ZhgeKes2M2XW7ysqWmwk1pobGKzai7oYGhHX6F/p4MUBrITPlAx5E/bkRVrX5yhAWG8SovP9VzDw4WJawsiuksict7Vpxv3SZ1sczeB876Sc185KKw9xTLLXc52RYUTrUUrWLsFagoCgx+baLfsoAVE3pjY70PaA9q4Zlpvs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4282.namprd10.prod.outlook.com (2603:10b6:5:222::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 13:41:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 13:41:00 +0000
Message-ID: <f74cbb91-1868-e49b-022f-59c43c2d02c2@oracle.com>
Date:   Tue, 21 Mar 2023 21:40:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 12/24] btrfs: simplify btrfs_block_rsv_refill()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <2ce9a65bf72584f5bb9da5e248f94ee4e104f24a.1679326433.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <2ce9a65bf72584f5bb9da5e248f94ee4e104f24a.1679326433.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df32a3c-9c1c-4ea7-1000-08db2a11e741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ZhE+XIxB7hbqnN5oiGyvXiK3Rg6j7vNka3relNaLlfs/iGJO/A/IfDhiKq6qh+UzVLpWz05uiLWyF2noUho3Ci1cpMy9WijA1lkSMgxp/oKAE2LJ6TG75lmvj0WAPEfnRtHaobL4Mm4RU8rte15lPNAIQdY8dQ2bHx8XaQBez5ECElP/SNpEmPyifM5LWXKAcU0c5i19/ZNGOZBBJjtzs6zJME98BPqLxpLcGJ3u3OVaFdklRkTtW2HBKs6cMkOjwikUcjaLeJEmhGylB8gAu9/pP8Y7WxxAsj2DEE+J389DQlqOQZLYuR9HoZISeuuFpRYINmfjjjXrwIFwOedBjMKjsmZJnh2rcTckn7dU9XsZfPi9vZg3K/Y54HPx1oav47uF1ln+kvvcfcyBf23jWxm8IaP92UkWzVKm3ntxrD+bZwKN1iZ838W7h9kIVczMlDcXpAyoMkgufL9JAuRhP5x53S+QXVZoq8TBSZXeVJk3ZnXeb2RET29OcUbvoP6Nf9EVWZyCDTv0VRYjuSQNmDucIlvaY6UZQZLEjULpYpVK3y4XzKjCArHuv4suuHE09CkORmLvdGYvrjnb82cLvaxAZ2puTy6csIOAiKqz1nLgsmhkrAkp5SZE3CJe7sxfn0RF4wXe+DRVG7GNsAh99x4JuEQ2aZeeXm5FVd6MQJVCanWz+2sdIxUabPo8qJj08sc4xlOiFzO8c3OdBOTWDZTuZSNIQUb/vqQGrl1Umw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199018)(31686004)(316002)(478600001)(38100700002)(36756003)(86362001)(6486002)(558084003)(4270600006)(186003)(6512007)(6666004)(6506007)(2616005)(41300700001)(2906002)(19618925003)(66946007)(5660300002)(26005)(8936002)(44832011)(66556008)(8676002)(31696002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRVY0tESy9lTFlYVCt4UWQ2SDFRd3RDQ0dsQ0hJQWNQbmZPaTFtVFZFcVNI?=
 =?utf-8?B?RjFGU2s3anRPN29yVUdlRWVBbFJNcTVSa1o3S1JZTEZXM2ZIU0R6YnU1L3Zm?=
 =?utf-8?B?N2VCU05Ddm9CR1E4Uzh6dXZNWFZsVnRhbFY2cW0xR3dOdmUyVGx2cGtWWURi?=
 =?utf-8?B?Nmx2RVlQb3JCYWdQZ3VxYWxhWTQ4QUNvWmdHUTA0Slplek0yYmJNaVlVVmU2?=
 =?utf-8?B?dmc3Z0ppQStYaTN5M2xsd2lGcDVEaVVYU1pFcEFnd3VZdkkxSFZrc1NRb0M2?=
 =?utf-8?B?SDhKaVVucVhKMm5OUTM4RUZ1dk9xS0Vyb1d6ZWp0K1MveSt3ZW1pRG0xZWta?=
 =?utf-8?B?dFFIenI1Z0dVZFZPUEpiUytoVTExSFVIZVdaNHZJTEhZVEhMdUdnMitJVVlr?=
 =?utf-8?B?b1ZsSDZaUHZucy95RlBhWmxnWkQxeDdWWHNtZXdMbjdDWFpybmRaY1RLNXdu?=
 =?utf-8?B?bUJGeG5EalNkWWlJODgzSVhrcHdWTlBUZ1Y4Rnh5WitEWHlHdlB2TzJZdFNY?=
 =?utf-8?B?UUk3MFpRUmJ6VUx3T2ZDa3ptTzAyNVdpSHVIT1RCZkZuekE4bE9rblRORjQw?=
 =?utf-8?B?eUFzNkFHRGpiUE1tU0lUWk1aSFZxb0ZVSTBqNEFXQ2phMDk4NGM5emoyaGVC?=
 =?utf-8?B?dzVXTFM3VmY1MHM3UGw0SXZHUnduajNiRHkyazFveGNiLzV5Ym45Rks0NExP?=
 =?utf-8?B?Q2FmaGthSXUzdGpFcUtHN2dESjBJcmJDbGpQVFA5NmtoMDYyZCszaGpObXpP?=
 =?utf-8?B?TzVTOHNuOFl3V3RWVTBscldEYXJUQVJqRktvN1RFcEJPdHk1a0xkS1crMzV5?=
 =?utf-8?B?MU01RGpmZ2pvUVZtNlBKaVpmK2JBUnNDL3BwSGM2R2NBbnFDZzcwbERhdVF2?=
 =?utf-8?B?UU5oVENKZ2loVnh4L3dGZlc1S2VHdFZmcWNJRU5yRUF6aGsrbllvdFhwVUFy?=
 =?utf-8?B?eXVkejdYS3lBcllBNDE0NmZNcWZPZm5nR1Jvd2V6azBlZ0pLVVhpZXBTRHlN?=
 =?utf-8?B?T0dRQXBydVlUNUJ1TWpKZlBoNnlxdVhiS2d3UXNhN3JUcnJCVVV6ekRyK3VH?=
 =?utf-8?B?MHZXMG9lK0RMbGVudjBnRERGd3ZmRW5LbW5uV0Zkb0p1aHhDWWV3KytNRlZF?=
 =?utf-8?B?Tkl5cFdWMW1KdDVKTEQwT0tPOVNpTzlKNW9IeitCa0ZDazJjSTYxdW1nbGxL?=
 =?utf-8?B?U3k2bkJvM3FvcG1hNmFlNHNrVlUxTTI3aTFlLzlsbi94MGtqcFd0R3Z6cUtJ?=
 =?utf-8?B?elhzS3NMeXJnQlRNOVAvMnkzRHZ5b0Z4aHIvb3p4TnNzc2xCKzZRQVdCeUN0?=
 =?utf-8?B?NmF1RVplVHE3Qk1pcnhIWlpHejFEbk9lbXhUMlBoQ3JuVnpEU2g5SWNnVGJW?=
 =?utf-8?B?Mm5HU0phaFB3ZzhQRldlVmN1Zy9FSHpTQVBWQnpDOU5mQU1oVy8wNitreWt0?=
 =?utf-8?B?Q2lXMGlSL1B5Rmw5akMvN1ZGN05kekMzaVF0TU5UUXVOaTIyQ0FlRVZEYXY1?=
 =?utf-8?B?azdxb2k2UGNrbDFReUdkYVdkQjM1a2hKMWlCMTAxOWpYWnJudXVxY0FtUFdj?=
 =?utf-8?B?UzVxbGU5RTdFOUEzYW9IU2pId0Q3aHQxdkQvcDZCaW52ZFQ4M1RxRmlVc2FX?=
 =?utf-8?B?amZQUnBveGZ3RnppeTIzbWVHOU1PS2VwdE51TlgrQlVTMS94NC83NUtqWFo4?=
 =?utf-8?B?YTJTKzBUWUpuSkhvdmVJZEtZT0Fva3VTRWxqbTljcXl0QnhaS1NQTzIvdDhQ?=
 =?utf-8?B?NHIvNW4wdFJXWmhoekkvdityRUFjdGIzMU1zVEk2enJ6Zk5aRitNdjRRNUY3?=
 =?utf-8?B?VEJTSzFHbUIrTUtydFNoQmtHYUFGcFRMb0FId3YySUowdStFRjlmUDVqVkVY?=
 =?utf-8?B?YWdYS3hoU2dpMkJCM01keU8wWm9sK0JlWlB0dSt3bW9pbzFodmFsemxvajVF?=
 =?utf-8?B?cTJPOTA0aHpDelM0OExBY2lkcVhvbmxBbGcxQVZIOG04WU9OcE4yclhKWm0v?=
 =?utf-8?B?T2FvbXI3aThDUElTY21lTCtqeUtlTCt4aTBSZUdUek5yT0Z5bHdPNFN1R09L?=
 =?utf-8?B?bGszVEdaejBnNkMrZEJNUEhoZjBybUM5aFJETk1KSmxRQXNSdVpvUUEyRFI3?=
 =?utf-8?B?NDRxVzVscU1CUnlDR3diVytETlIyUWVoWE42ZElpRWdLelZURHBtVnZtTnJT?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9CKlrtvVWESmmk3qJd0VqzMkg+22dwX35/WKCs2gIliauujzZCSl/LG6wYil8T3aGeRHJeabxWJR8v29qVXfmXiNGcRgGoob2Em0JZpp+Brmjet1UCVEyKqVvT46ZMdCELnubxJgnJ7ooPnCMD0jU4Rg6nSx+bXhctnIzsIs5gtqZ2DyhsyT51DkLY434XiYbVSX5zyOmfI66NUqzpG6Tn/hRYu0RMEm95D3/meW3e9Kc1c+fwYMfewaej6z0k7P9Z8pz27uZIaJ/lZ+oPIqD137n8Qs2H3py6M1ji53CL0siNKy+gkWLf0LEi/CcY6sUjsTuYkMyPAavQzM6Unwszs76Oj2d5JNLAGmaVklzLZSs1y+ZlZ8xsXJH8wquynXWSEvYkrI38EZjM84jhoOtfOV1q3k4gzg3ICKGshstQgpkw7b0UnfY7u8NKpcHkBRAGoSEo5+FY9epopmY7/Jg1uQIKCGLznaOmpXI0p+2CXZdVRRkvOTaEAFIb2wmJJVirqQbocYkfgItLVKL/otYlVZ5DfiRGmwBj1zn3t1jyjjoJtFUZVucV5E7p2exilEZIhXp4tmmbRrCfRvWOR5bSl3L45qzMO8XSfGDHb1bRCUiL2jcZcyp1XanhU8FY4aVLIh8ob4HEGzDup0FijDC5dq8/hxbXkheCbKrcaHQQCWaeww6+UiDtgZPo3x0WLqVbTYzPDcc7h86YtjQJiUaIyFlhx6rrJ87eEE2pgjvTn0UhJiusqJ1+SStE+zWXL3akOcGrFlhdwRryLDGD1AfJVkm1bkhNkThaRuf9Y1qlM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df32a3c-9c1c-4ea7-1000-08db2a11e741
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 13:40:59.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WXM17bJ6RbwMbvJHORDcGleoXIgfFyhnfYfZBQtBL6bYII30PH+NicNa+xz4C6mn5+x9x2jwx7BN7T3NigLUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4282
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_10,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210106
X-Proofpoint-ORIG-GUID: Xnb5WQNJbCyIBRa9Svacc7J6EhsoSVIy
X-Proofpoint-GUID: Xnb5WQNJbCyIBRa9Svacc7J6EhsoSVIy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Reviewed-by: Anand Jain <anand.jain@oracle.com>
