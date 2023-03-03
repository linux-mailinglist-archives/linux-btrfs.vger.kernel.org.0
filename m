Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368576A9388
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 10:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjCCJPw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 04:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCCJPu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 04:15:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DB642BEF
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 01:15:49 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3233iMgn000760;
        Fri, 3 Mar 2023 09:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=PhzlNTKWGB49S/6cEbTpflwf/tl8SFy6p9ne+FN3J3c=;
 b=bKIAbHE/gk7A02TSEEPMYjNuLwP4+g1F1pVe5l57G0PaTUMYJ2IrQEBr73uVqxuFNHox
 8eXelRpDwQOSpHrofrGeK7JVnyWsaG9BeF/HuLWYDKh4itCpWAUH5MZqPMxfIfZDJJJn
 JpsY6HSa/zuKVymPSVupP9rxib3YZcZC+WoX1jsmmf9AGSf6BCNwdtMygmYO0LjANNsA
 HwGNs0p2o75Nnqb/Ab3QQKQN4K5KCu8Vk5mjUhdGYZJLEWGzk36yoRQsvTzndRC4gl2g
 lr5J4p4bM1vRLS1moGTvcynpOcQNRkEMvtOSdh72u60s2K3mFNLx+u1NWKdqw0vZfkp9 0Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba2e07c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:15:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3236qU7r005287;
        Fri, 3 Mar 2023 09:15:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sbjcxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:15:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gg5l/D2aBl5CiBF49TZtL1GqFlQei66h/ovZvXhZq7w29tB7JbF3fJep5TKfGQOXD1fq9aUwAw1Lzy379L16/ElI/5xvKNIE5lL2dq3s6vzhPYlgGMIasemxJBqp441O4l8ChbsMik/1tTXmkzBBenVPP1aLRpjdpwwGk6MOZ44GRsuxl22mTk3hUmXDkMHijrL7zu+97rmMbGm/G1lKx7j5qk1DMQ7loROAxT3Imbq5h0/xNv8mh305+xmrNdGO07eXV1vHCynJQLHHlvceBnw76PJ825AOY7m4C499HRbn6GCyU43Xh0kMTMoYRlAm+tAwn56jpqFUP+c+pV1hYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhzlNTKWGB49S/6cEbTpflwf/tl8SFy6p9ne+FN3J3c=;
 b=HxJ9gK4y3m0ZK2sLFU/KE/t39qNaDVS+y9uErKf3Sgypnp5cpYYKgBmKFkq/3gOkTIAgZS0HuMdnk3MQCydog7tZPRH/2we2Q5YKdrIdilHIH2G1d+3vPDZg9SjSu7khZL5qB6ho9yKD7kiatKLu4Lnm7kpKpb8J4WzdC8SHJHG/jfhcx2fG4ulyYeMjM1YxjAzgiLty6rWn9w4BQu3XvnuONSqbLJ166RV+KRaueCYb0+8K2JHw2JCQsXOV1NsuYnK+ajrtCD+vCsT9ne+Fzzyp6jXfd5flt3ZyV3i4UI9/92XvDF/KKA3TxmGMJfFJJUsF6yjgVFP8zp2oekA/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhzlNTKWGB49S/6cEbTpflwf/tl8SFy6p9ne+FN3J3c=;
 b=nwKmKInCbwLojWvtv/Cr2IGALQ9kxcjoPx2WrHKLYnmyXZxkeaeUKSl5RP6MBBqAlqrgyvLDXvmc7y4f/Uxer8FBsXhvGbbSZoMnSVYSJ5kEraLthS9XGtGVnGNxyjSgdqtnNNPnDAcXpFRitPRvlIe2rJNbFMSpW7FkwohbLSU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4524.namprd10.prod.outlook.com (2603:10b6:806:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.20; Fri, 3 Mar
 2023 09:15:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Fri, 3 Mar 2023
 09:15:41 +0000
Message-ID: <347a8ab0-82e2-44ef-e7ae-d10c5be4ecd4@oracle.com>
Date:   Fri, 3 Mar 2023 17:15:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 04/10] btrfs: pass a btrfs_bio to btrfs_submit_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-5-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230301134244.1378533-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0118.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4524:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2f436f-c7ed-41e2-289d-08db1bc7dc14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppTsb1XG7mjH1OE8ak/Kd+7PbOx4vmygF8KytBNQtKoiCpR/juO5veSjgIMWI3MqJFnQnWIhaikjZsuLPCQMj5KmKlLA2lH5sUN7HMKHpar2uP4KImKi7AeFQnXfpOTQxN/1XPlHbtDE8m/9EG0LFSzPqR0+MajL5RzUD0O2G6TgqBhFOMhK6On3wPmyo96P2o7hlD0hswCjoMZKKmCiJDIVboJWkhBhfYjitRAO02l0Cv4+myqQfk8QYCyJL0hw8qQtO5AgstYXsu+ng7WBblO8Cs192sjwUtjIXe4a88Jl9aoiJUe/trDSjFdvFcTU8Sy9Ne+3QW0pieERFqW/WU7ee8WBoHSkqNgVrg8SSsFJ5cMgSvJ+TrwGgrWCf0DaeEM9xF1Ao15jsuuoZf6bGOAjdlp3q9mb2kIYCoVSwYeT2VsM24Xh86pJkkiFhI+GSSK0DGwpjp/CzZ3GKUc5zF6w8WMMdaxR2lEjOlvpJy+hMOq/EuSS2oTcF4keR1mpFdqHUXBECsx/4HD44PqY23FfGyjBH/16cNYSEcqCZrsIQs4BLOFYJvd3sLe9eLOQ7navfOhY92yRsMGdh8uIVxSikd70hUTfaDNzdCIkjCzBTStBnrqUmVZcqdiMc/EtRPK8KD/YL65jCr6+U/RObNAOU4Oitem7VK23hLY1O+XuytG1A6KwRc73hx7W0qxlngxjVH3xZBJWJkf5ubcm5bd46VWSTKNafuQxE84f3JY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199018)(36756003)(6512007)(6666004)(53546011)(26005)(6506007)(6486002)(2616005)(186003)(41300700001)(4326008)(110136005)(316002)(66946007)(44832011)(2906002)(8676002)(4744005)(478600001)(5660300002)(31696002)(38100700002)(8936002)(86362001)(66476007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmNHNXNkMTJjVkpIS0lFa084OXpsc2VRUTVESmFVeVZUcERxcEtvL013eGxM?=
 =?utf-8?B?WHlMaGVBSXBFajRzNytxVzVWNnFuWXJBK1psQzcwNndwWnc4c1VoazJORWRM?=
 =?utf-8?B?ZHVjY1B1aWdDbnU3d0ZIUjMvUFRmT0hsdGlwVVlISUZNRU9MRjVJOXBmWFE5?=
 =?utf-8?B?NHdaQkFpV1B4MjdiQkZ3b05Bbk82QnAzTkFYK0lJdkkvV0VPU040ekhvUGlC?=
 =?utf-8?B?TkpOOFFvdElUSFFkUVlXK2lRV05hbXZieHZrTm9FVUVEMlM3SVFRMitRdW4y?=
 =?utf-8?B?ZEQzTHdnZU8rWTBRVlo4ZHlIL2xFeTh3dDBCaUN3RkJnTnlObkQyNkZsK01r?=
 =?utf-8?B?bjZjT0poU1FxejJSeWhiR0svUkYrelp1RTA4VTJTanpGS2FKWWJVOWJ0SXRx?=
 =?utf-8?B?VGtHSE8zV3JJM2tuMjYwWnRnUlA5RnRoM0U3OGFuSlF5TlhPNTlmdTBteEVQ?=
 =?utf-8?B?YXQ4UGxXeWhaR05HVXQzM0JBOWFIbEJ6U2YvREhDb0tVYWpNL3hRYTNCM1Rl?=
 =?utf-8?B?V2xvcDdjKzA2eFkwcGp1TVJUNE9wUERwL1RzeEtFNTFwWTViVjBuSXpYRGx2?=
 =?utf-8?B?Q0k5QUhJU0hyb0xSbW5ITHRmd0ttekJSVytRWWdXQ0F6SGl6em5WRXh3ZWZq?=
 =?utf-8?B?TTJ3NCtCa1Y2dm56ZDdBVHlSbDQzcHdXQjMyT2xFRzhMQVE3d1I3a2RCTWQv?=
 =?utf-8?B?L1BaZVE3Q3ZEaTkwS0owQ3JWelNtWmVEZHpEcVR1OC9DZnRSMGoveEtlcTJI?=
 =?utf-8?B?VWg3SXVWVGdLcXpaRkJsVUxDUURKNVpDOEluUkplaXdDckorSVVwUGF2MUJy?=
 =?utf-8?B?eUtxdVM0LzVFREtnRzBEQlk1RU5pZmtRb0N4UkZacU1BcEJZN3E1aVV1WEEx?=
 =?utf-8?B?Zjk1YWVxMm1zeVB3dVA1bkxoTXFVcFI2UHpPa0xVSkxVY1JiUkorSjdHTEJO?=
 =?utf-8?B?dlh2UHFLK2FZMmlHeXk4SEdrMW9ZV2hvS0lkYVhnaXFoQkdLbmt2Tzd1eVVJ?=
 =?utf-8?B?b2pZUEVpdnRrN2xESThzOUhJMEl6RjV1QVVxc2VEUnl0LzBZdlBVUGpTYWxB?=
 =?utf-8?B?UVVVSE0rcFRUZ28vTVY3czhGSDMrY1lTTmRwZmNwc3AzUU5MNjNRL3UzaEto?=
 =?utf-8?B?WTdHM1Uya2lySTdpK3BuczJyQzJxYUJSNmdBRkhDa0t0eFNMN01QbEZ0S3Z4?=
 =?utf-8?B?VDdiSVprNUdpTlVzTnl5K0JpWEFFTG8wbSs0bG9OQXN3czdqVFVHYVJGN0pY?=
 =?utf-8?B?KzJJRkxZM0ZhcWhYQWFueVQ3SkNnNVJZN05XUXl4eXZBQ1cyQ3ZBeHJ5dDVF?=
 =?utf-8?B?MEFiRVN1SW5ickZGNEE3YnpMbzRtZGk4aktaZFBsa3h6Wjk4dmJtbjJBQzBK?=
 =?utf-8?B?dDNXNWhBYXFsaDE4MGxIbDhHZnNKaGNSdGJBZS91RHA5T3RjR01FWWhvZFoz?=
 =?utf-8?B?Y3dIL2JNWXpHcUQwSmk3MmFpYjNIVU83SUV0M01tb3cvTjRmbS9LaDQ3OGFP?=
 =?utf-8?B?VzBmejl6OUx6a0loTytPaUZEZDh1QzBsQ3lONC9Lci9NYWZnU2wxU1ZRd0Ir?=
 =?utf-8?B?aHRzQnRaejA5R1BqS3BlV0t2c25KdFMxQnd5cTZya1hINUpyNmhTM0drTGNF?=
 =?utf-8?B?MTB5aVc2WXpIM2NTMEtQSDNhcEZEZ3YrN0NKWE5UVG5nZzZaODF1QytWVlBV?=
 =?utf-8?B?NklXMnZycXFVMVFvSVRuUXJRblVKYUd1SXhJUUw1bjl4eFFlSjNZVGpjRmVR?=
 =?utf-8?B?Z1ZLbkx6YUxYdk1DUmRlV2hkNU9HTzRMb3lGdk5XRHJha2t3bkMvMGt4WXo2?=
 =?utf-8?B?bkFOTGFtK0Rhbk1lcDk4SHZENStYZHRONGRNNXdUVDE4Z2VCMnprWWpiQ25y?=
 =?utf-8?B?QnVLcGx3RWZzV2JzN1FyNzBlZlQ5d3VETFRrYTRHV0dzQ3ZGeEwwSUdud25a?=
 =?utf-8?B?dklEMFdQclZqOWlkS1FMNTVSN3MySGp1SkkrL1ZxajIxRWxOK2V5aFRZQVd0?=
 =?utf-8?B?V1V4VkxJTkdFVGpUMXFPU2Z2bXppSk1rV3pCWDI3blBDejdhR2ROVUVqUURt?=
 =?utf-8?B?VEJPd29FLzl5RzhJcjZqeW8wcUxBZXl2Ykl3bE5sdnhUZVBib3k2Q3JEbnNz?=
 =?utf-8?Q?ozV+GtBg9xHRCRA2xwpXG//5V?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NQh66Knt/97y1oBNN999r6H9wQYRnOzksyOTbxUHkvOo7kHyjY3eoqkLudfQmjY1Zjs97pMxLR83AWmI+tA3yC03yhF9VEpQ5w9VGzCuGJhWlXY/9Awl+C3bX2wo+/2ZRNryFpd6RQYQg9m/GrF3YwpBR7zAPmfVPT0CqguGmvR2IfpK3qq4E8yLWBBZWGn3siCI/V2vGDRRG3W8AlgIVPurYZKsUeN3IhU+CzNooHhY8+NPaFevdqZjH1n22nsvmEHBbkPrNe58ZNkjcG0ePXuwIFfGraSzztnAAD5IotZ/C7r++vvzx9jg+a1Q0zn8v91iJOjwfJ7PLabbl2NcA6AkvLeM++EYoZ447X2JQTIjpxb4wgUn1vgGhRXc7I5dmyJBInmL7iVx8IVgVZCA8AhBH+j+EmtmvjXFJubSsojYAm4f/fypOYG6iN6yIhK6t9jePF3xL3CxN3YtZnqI+wwDvQABldjDxpasX/WTGzZMPWO2tifD/acVNeJqomdc4QykTJpcgKs0UakH9NHoaMuWNj5JpXs+LQEcaqgjH94TZuBPxtfjUTKHJKUP+D/DgsLvQX3NelHdarZd975HbOSShAQVmgeWB2s6lvDnuR/eQQ0hzqJkouN6d9+yypH1BWEv3RHp7Bw00N4/1jW2+YfgAGfYeGGJQihQrnO+HdwUCjCcaun6pMRyilNl+7iU5cpLjfnLyrYk9Bq36eV/gKdg6Mwks8YMRwiIoNQRvwFd9bcGNGH4Mdy0ugTSMj05+QxBQs1bL3JX7kHtvSTYj+r6EuRu0DOQgS7ZJhxUdakM3T8U2A8foq+ctm/OOfGrjCz+1BrUWsrZ+//EkhdRGtDRZIsxlfGPrsSyTv+x3rs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2f436f-c7ed-41e2-289d-08db1bc7dc14
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 09:15:41.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ot6H4YkJ2bVb4BZN4tuSyk30q/S/Clvn4hlXKxUzXWLgtFJZ8aQkRmCYtrs9RDHvya0kCXecLoCqUJElyUmMGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4524
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030082
X-Proofpoint-GUID: 9-D6fTQPKHtxllQyLN2GRV93Iy3M2mgL
X-Proofpoint-ORIG-GUID: 9-D6fTQPKHtxllQyLN2GRV93Iy3M2mgL
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/03/2023 21:42, Christoph Hellwig wrote:
> btrfs_submit_bio expects the bio passed to it to be embedded into a
> btrfs_bio structure.  Pass the btrfs_bio directly to inrease type

Typo: inrease -> increase

> safety and make the code self-documenting.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks
Anand
