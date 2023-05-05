Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16196F7F10
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 May 2023 10:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjEEI2x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 May 2023 04:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjEEI2d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 May 2023 04:28:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F8E1A1C4
        for <linux-btrfs@vger.kernel.org>; Fri,  5 May 2023 01:27:32 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3456YXrP011398;
        Fri, 5 May 2023 08:27:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=dlXUAt5+nKgI4uE6j2L77fOnm4JuLETThTiAIVD505KB1U67cOZ8lK43uo7NJ/bZwK8H
 V3S7gwdd8N2J+PCYgZucEzfB54fvn77qy02WOgL4lZBcV9knsVRdqbVSZYgU2G4weYJX
 vBEbzF8VtTY2XciqNrDtQFbux7puORJfOsVEsGrzGgzSrHR3DiUhU7FbmBHH1wiLy3iJ
 v3v5kndPoQ4HwiWG/8NMWhWiaeYV/XzjlsebagYuvahQJK+YYg12IbdesiMRnZU+uvaV
 DoEpmEquZR66EYD8QQvdvoBo/0pYaRBrDmXpzswMlai6kZif1Uu7rZMPU04KCWLkuT1U zA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fv5c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 08:27:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3456YSPf040517;
        Fri, 5 May 2023 08:27:29 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp9n1wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 08:27:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7Wpb7VunIt1IFRmJk1lvizKWAduiQVpExnaH7yWXlTmFAPSqHoUDtNgP2mVmgg5bwTZNf6ejKP5LSVUIJqEf6mFd2v126NQWO8wuDgyzECWR3LIax/ph1JZTmjtUeQUw94ecBmN6K5s8WuyZJehkX+I+1qS7rSOV10ru1kXfcYs+7aljLOoQZj5+uJPf0QwKJ8D5dp1igUOUKyd4CLvcCvvXRYZOyva98lonrmJM0uf+KTuRqLKZ+mfUsOCPNCpg/Tb8JeXSADv2umBgy1PdIvcBzC5eaQ6g4TYxchWD91szOpLr8LxcsLIyBUYHlFvbrX88TCtaBvjhYE9WO1ljQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=Qrwvhs4E6x/s9IGoLybuap0+nRADsACQl9sNMo7K3+GVeVPX1kNIjVOSvPUfHx1GxLau0lZTQGbI4QKhr8VlsPEFVAUDbdHSigGE9UhS6oQYY03dxhoemgI2B5ZIaL6le4g7f6uAhnwmOGATcH1KoiQhQ6NNL8De5KUvOlacudrZQ+sFgcUVqXcywbKOdfzAqo9SQZeRTAnaae6vjaJIGznYA6Ih2jT5Of+T64Zmkmb89uzV3IqFnUxRIXv9uc17fm3x8DPOtawekE3nK9LfxuUQWFAqyL+C5XOfBz2sYMauCbT1xn/e9x9pPpHE4V0brPSgEJBaaHvhnOemiOO8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=vzOSXw/SRhHQjUIuwEVVC6lVl83xQif8V6DiLPT7ogapeJyfY2HIGtLCoehHRgoI2dgOHlW46zCou00fCRbhmOyHy7+jk4XX1vh0Crvnio2NCwU+j6cNqWfL2mwj3QnFKjW8ludoCobtnEME2d7TU7HT0hjmOAyDXnKStv2DSFs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 08:27:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 08:27:27 +0000
Message-ID: <72d5f6d6-b0ba-cf5b-d482-f93964007ed7@oracle.com>
Date:   Fri, 5 May 2023 16:27:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/9] btrfs: avoid extra memory allocation when copying
 free space cache
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1683196407.git.fdmanana@suse.com>
 <f4cb3735fa8b97e14f71ac89cce3c938f84023f6.1683196407.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f4cb3735fa8b97e14f71ac89cce3c938f84023f6.1683196407.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 6252952d-86c4-41c2-08f9-08db4d428f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fSC5R+XtqGM1YeF/uPU8wqO+Yb/IjJdvymqHaF4RvjMUa+xWaIHtNCv8FZqyjZX243RrybBo68Q2ZFavgYO+iHzqaORdUJAc+ln35EY+N6FtAr3yiWCPTDaMElJw5O3sSrzMZ3JtmsvQmatAtgcrpzHiWZGX3EoaCU9wNr2zWfoRt5g+C/4NFrrpTICcdFM8TGnAH6H4dCINFtkZcIsI8a6SltHFTfgBPcsQ242Jl/nK9sMbehUuS8WU0amkE5LB2Ioh78lhNMZqjaDY4Y3Cjwv/KCj5H6xy6Mtx8qJbq3z6novr+TzwRMF8XLcWRxMHzyYoP3pTA+xccIie7PRAKcldY7andK9YNZ10u+LFwARzNPbYc20cpISqBk+vCkE8B2Jz1TUZaiZxjwDFeNhtY2vO1nNepWLvNJOVkZGI0K4oJHGrtN4vahKako/JcqeKqDkcSQXrcrPL4prAyromX5wETsTInIPurpu+1tXSL5m3WPWkICsJ43X7JqR/sQ3NuQo/VHpuwM5Mxrd2Ryc2CiFhuy5u4SDFN6Cv7Ah2sN1MlU2zxInhECC5KR7x7J0+rS9vSJOzMXDqMGtRFCHClDKWHf7YSphUDE74Tw8DuEmQZp8xsZGSMAZtri+3DStU4uyIh1jcsINlURJFVmygg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(396003)(366004)(376002)(451199021)(186003)(316002)(558084003)(31686004)(2906002)(26005)(19618925003)(41300700001)(4270600006)(6512007)(31696002)(6666004)(6506007)(86362001)(6486002)(66946007)(66476007)(66556008)(2616005)(478600001)(44832011)(36756003)(38100700002)(8936002)(5660300002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anRHc1ROMXRTanB1eWsxaHJ0K0h3aXhtVXhWL0VZbjVvbUhrSFNyb1NzMnpN?=
 =?utf-8?B?ZTJJTmVjdjJpbXE5Y1k1ekVPSnBBRzdyYThsS0Q5cm5WOXZUTEZPanluS2tW?=
 =?utf-8?B?NTJNeWlya1BMTUZzdk1zWE8xR1loUUQxcHRNTGFLRlN2dStjQlpxcXFRK2Rv?=
 =?utf-8?B?R0VHU052ckVGMzlna0p3dmFHYVA5ell1eFk1bGNkb1J5aW9rTnBnSkdpMnNI?=
 =?utf-8?B?VUhCU3J3c29ySFppR2szV1o5U05nNU9XYmpXaDYrTlkzazQydW00ZWM2K1Z2?=
 =?utf-8?B?d1dIRktDbDZLbll2TXpYVUY0WC9GQzRMcnlzNzJLQjgwRGpWWlRSbUp1OFM5?=
 =?utf-8?B?M3ZpVm4yMW5QdmZJZHRqelBsa2JRckpyL3VkZm45WHYvb2hOdUlraFhrSnVR?=
 =?utf-8?B?VjJkSk9MV0M5T3B1ejZTM2t0Sks4UmVmbUFlbFBCdWxkYjdoUjUyajBCMTBq?=
 =?utf-8?B?bDhYem5oeERzbENyaFNSY3ZZMkEwcnhWTnB1SWRNTVpjRmZKYzNTRFhJaUo3?=
 =?utf-8?B?U2NaUHpMYXJvWUJTVHNKTDhscWV2a1BtRURIT01idXk1cHlmVzJEeWU1RHcv?=
 =?utf-8?B?bHVtbnRjZVBZelZkMnBhSnYvZEZrMmZQdnpUYTZqS3lSU29VaDc1VEUyZnJk?=
 =?utf-8?B?WFZGR0hHYTdSdTlyclFCbDByb08wdEtENVdKYUk1dWpMeG5UWHVPWlRQdXQ4?=
 =?utf-8?B?L0g4NmQ5aWdtYXZlWWg0M0JkZkxXM1NtWEMwUFJZU1owcnpad3l3d3MybE40?=
 =?utf-8?B?Z1VUc3N1OXV1SGNUdVVpMktseWhxaVovSG5kU3BHUUlBb055SHphcEY1dVBS?=
 =?utf-8?B?ck5WUXpwMmxCUGJXQWRiQ3gzSUlRS0hjL3pqbHpZZFRxL2NsZTJ6TndHU1Aw?=
 =?utf-8?B?WlUzcWdZd3IzK0V3eVFqMFlQblpWWGQvUC9CVktsemZadU5KelRJSzZ4RUI4?=
 =?utf-8?B?TEpxdHoybld5WER1bnN1L2s2WTI3MDFYVFZCQXhSWi85UlQ1enJLNmFGZlZS?=
 =?utf-8?B?L3grN1Q4UUtxb3p1Q0RXdFR4WmJ0L3gvNnlWRWI4bmF6VGtGVzJqTHNGMXli?=
 =?utf-8?B?bDA2blJCRXRqYnJzNjEvRGRXVFJsaGoxUWNkeFJkRHNzVzNYTVkwRUlBZHll?=
 =?utf-8?B?bnJYSklJQ1F1ZTY1c3paNzAvbEc2bURta215SzBJc0xudjBWTzNjMy9kdllo?=
 =?utf-8?B?Q2c2T3BURFFBa3RLMk1PYVZTc1gzc0pjVk5vSzg0RThBVHRFL0dZcUluQXhK?=
 =?utf-8?B?eWJVanpEZDRPNkxHWjB5OEdrdHZnSnJ2M085bGtXajduTUVhYjBNYnBQWkpU?=
 =?utf-8?B?dWdaZ3NPTTQ1cEt5dEM1WGk0KzJ4WmZTNGtYMThweG5mMms3cUFxWTlxMXF4?=
 =?utf-8?B?ei8zU2JkaW42TzFDbXYzZEw0YmdCZkZtMWhVVWFiQnN4K2svVXFuemdIeDJF?=
 =?utf-8?B?L2NlWlFHckx6eUh2cTA0cGV2ODg4c1YxWkJQUkl4eDZ0b0s3RXhSWmcyc1ZD?=
 =?utf-8?B?cGhINFZTUjZKWWRRd2pPN2NIVTBwVDhYQ2dmR1dHN2k5MUl4OXNsdzRzTHEx?=
 =?utf-8?B?azc2dFNVRXQ4NTkyWDZNS3BORmxGWVpIRjJsM1RYYVdYVEIxZXRhUk1ubVJK?=
 =?utf-8?B?UWkweHFwbkVyT3pvKy92N1pBZ2RyTW5Eb2VpMVZvellaQ0d6QjVzUm5TaCtY?=
 =?utf-8?B?ZkhhZVVSUkQxMVNrb1drcXdOSjFhNTEzM0FPZTE2YmlxVFU4eG81UVhhSFMr?=
 =?utf-8?B?aEQ5UGNaSGN2eTZGYXJMa01EV0tTeEVNV3UzdGVzeWZzNlZXemRYcnNjR1Np?=
 =?utf-8?B?ZjRtWmZFbkl5YlliWncrL2JLdFZVMU9ubk5ZYlVxVEp5MXB3cHJxTTd5Mm5M?=
 =?utf-8?B?OXJLdXo1NDJFQ0hqekJ4WFdjUkVNcnNOb09mS2VCK2JVQnlvbEl0VHM5TG9s?=
 =?utf-8?B?MGNkVFlrTWx0YnBoZEFIdW0wVFY5bWFiM0xmZDloNC9VZldEbnRkL0grVTJO?=
 =?utf-8?B?cDlESkNHMTROS1FwZzZvYkY1a2JxOW9xdzNWNjBkWEpzOWNQdS93MXNQbzU0?=
 =?utf-8?B?YWk1VTFTYTFmNXA1YWxYdFpRbTJVNjV5Uy8wQ1lEaFZ3aFRJdStwNmJwSW5M?=
 =?utf-8?Q?HbPcIhP7XkIH+y/srsffJIwK5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SKxvTV45cCSpl6ZDpDj6Pqixy9q6inLftKjczic2+sGSLQLdmyWMffs+pyI24vY5KBka86gq7BHPe6FPp5hprHbugSImDxKZUZW7HqtHfDLPsDLNu0TpfjWb4r0jt3XxgIA2osWlV49q5vkDqWbWIaI//0ezC+XCCfMg23G9t9T5laGBbuLsELrSKi+8jZnUMwOwXVWiSgIBqfEF/rmwJrQsMe4HY2OVZIo9Z8WBZyr67jMsOt1vhVK/Lzg0AlIPWE03FOK26zY3noZ/Yd6ujN1fYtGNc8fKWSl9p94qnAJ+b1GQ8ZRpZGKmkSe3uHHWsQ/6kQC9JWO98ZkRH0ktfBY3irtOAnXLeoUeuSFd8UbJgJ8nFhQ7lEl5vHp+Gq9aZ5NPsiGXocYPwBSxX9PeG5Q0lPegfeDZIHHRvEn4RcZm+VU1xhQtY/FFEkc1ZMcZPPO27mEZpcE9EH4ajkpzlS/XhAB5AwgrR7cLmG6zu7woTvt6tg4Xw+NHMCmRk+ATTbK9IEt85ZGjxhNMJQBL75ORwc/nnmU2OSu6aFVqe2+jdTtGk12bK0cLgkU7BXYdIJN6gw+E7CvD5+pOmZkip61uFgp137R7YkxajY3ZY895dafKr4aqV5S4lBWN+03GaLVzz7usDrkjjtBJl22MTOa0k79U0TVCqvHQBqCJtJOKgf/adPmsAly4oXvsWXhGCIqnjTCqX/fJPdHVPOi20YQ6eotKbWttZSzCAPEwH1B95TbQV69ZVBIYWfBuvKp1T9huNjSKBpIbqfnRxhbykpsp4Y4DGIlrhOlcZoRTC+I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6252952d-86c4-41c2-08f9-08db4d428f2d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 08:27:27.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70fqqFjPPl5+V7wCqLMQDTGOm5QKrxF6jrFLwxSr7BdZTWYY/tx0BDA259N4SwnhA0u0gLncxoDKNp5Pmh+4tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050070
X-Proofpoint-GUID: 8qQb8BP3nHVCZP22DuoX9XhbNBbYYWoG
X-Proofpoint-ORIG-GUID: 8qQb8BP3nHVCZP22DuoX9XhbNBbYYWoG
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
