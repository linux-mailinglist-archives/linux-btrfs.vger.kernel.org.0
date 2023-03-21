Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388E36C3242
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 14:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjCUNF2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 09:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjCUNF0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 09:05:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317EA4AD13
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 06:05:25 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LBiKX7009089;
        Tue, 21 Mar 2023 13:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=PQSmsq600JUnAu8Y9UrzQOckiasQiAffIlWQeHeJtQI/TzzLGIbFseFni0sixljxWJ3i
 OPQg8weK5rqi61yziPcC2h5K2gLWrQgbbLfjt4KSDcSWTm9bn8kRMCAhFXxP16qY7cKm
 LMmbDTKjkvtjewl8iQSGFQpxMuqcnREdQM01FNT71J5Om+0+ffOQTrmXI62Pt8UTQBXZ
 oZuTJzvU5QcnXLDavIQEU/QpOghrPzjAqVjKdh2berY6vVbiMvBCd4demRXkQ/nl5hnI
 swURYOo+Fx9Y7tkza580cyeKEv5mGgXZfW4krE+15f5RHf4Tz4JAltg2HOZUPu65N1JZ nQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd47tp6x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:05:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LBvJA3010443;
        Tue, 21 Mar 2023 13:05:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3peqjnra9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:05:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEEwdJ2XFsO+cJXJs7flbcb7rQEDAKUgM1T3HXa+8kxw72zxRH80OjYx5W5VBVIl0QosKBx8rkxWEZePmCdG6hx+yG2HdslqsArfagqp9KB7LOIQzxBeOJTCAoY1KlVELyGExwMIklzv0Q29gO/SzKWI2UUml4GROPOAdlP9c2NmtNKeTInsobV5LMD5NRyIrsgcHBeWL700ehpJy8EM+bGSDxOPLH4h1jByiSOaE70QQo1c9nfE5foj6Ueryu9KcS+ZNcZSjVXVyN3Zqorvenx0c3W3HW/ekdrravMSOwGcHOcbqaAIqnS5DKz7A5TzT0yfeUGkwuTypO3UbjoQkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=RN8cmI3FX7SNhOrbJpS7jl7BCMMIi+6n5589iYdn/2WUt7RoOM+r2OWlnLdcvKRZvrdj7bv1rJretibKEuH8j+jv/hZCv6ysm8F6sh/fpawdQsJoXtFXdBqZGppXWl+Xh4NwjIUQQmCyS9bppjCU/5ayakX3UM+7mJSvh3mfL58vnbfW51qxLXfoSlHimBhHLnCrJKuS6PZo1kkeTGn/JxOBES51l0e6QqTqD22H2NMKpeOxKm75kvCuLawfuJNyHm9kfNQHEZsVgIf59dseamsPfnoTN3kvObmxxmsmJnQgAr0W7S488er6qc87dBkK9LELML5ve4932yjFQMDEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=tdEaw6mux9Gh/KacO56E3j0Qa/0gD+vd58nkuupZMbAGMLdjGRjX8VCwB2MVpkSdPWfyzl5kWX86GZEkIrjW0T454BQnfrcZdjvFeGrGYG43yYKICAaBSvJQJ8uA4T/wtohP3JegwN8vyueXoCgrhGV1qprcI4YM/phaBrKxacc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6152.namprd10.prod.outlook.com (2603:10b6:8:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 21 Mar
 2023 13:05:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 13:05:18 +0000
Message-ID: <f0bd4ee3-a711-1692-8c11-52a12e0e7b9e@oracle.com>
Date:   Tue, 21 Mar 2023 21:05:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 09/24] btrfs: remove bytes_used argument from
 btrfs_make_block_group()
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1679326426.git.fdmanana@suse.com>
 <84070b134bcaab995abb46437568fdb1a5282171.1679326432.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <84070b134bcaab995abb46437568fdb1a5282171.1679326432.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0150.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: c149cd92-f504-4135-2247-08db2a0ceb9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7XSPfNrjGMSgjMI3laWVVGaJY5jL4GrnShq9t8t0muwmabFpZy72SyNcOBoaZI41OuF4IPjxOQqBRhFykq4FPZV3y9UapqpPKhl9BSNJgKjaEsCEA+dUCeIY3m0G6TiL+NBVYWTsVpbBIxwdQVcXJqssfisohGnWdy4Ku1DvwmdD4eHkZXJeZO1U58SdGr4ky+bvXYsPKYUuywPsV31AZMMPyqkk16HiFT1fsu0jf67Bc1trXCX1N0rcSVIeFLfepmXZ4+criR9IkM8O5xCsHJgs2zAQ5n5pyi4N0YRm+I2QZzOZl90sJejtXoI0o5j/06+VLBEq//Id9RTGxHv7GtoZ5cMjtgoPaXW21uzyybwdQTY3FXcZeEHIFEMnQuOSu3l4jR+JlUl76btbIlHDd7UXEx3oGHFRd62qJuX4WctS9mpwD3Ki/AkQwfSPmVrOjRudYdc164k169VoD+Auz0ZoqyL1ad/3jyJ/nvc/xo1IXQgZiqByGyLQvjlTcz4mNwOjPSwY+fuiBzwYJATogaXT7LFgNqZihO8D1UYmCi96elOTWAovERXw3FWexIX5I5ANzUpahvbR4VRNDfRWL7k+rVMymK1x8BEcCYKPY8puKZzvhhyQj9+cHbzFsMuqvEgAcbNM3ruIRKjuqgbO+fqdUecKzmjkfwNqOQaB8e2NMl3EB4fLYXxOrjM2jraMrpL5+2TEKcT1uN9Xuc6TBSCLPgUxlKPoqhoEV1cCn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199018)(31686004)(478600001)(66946007)(558084003)(38100700002)(316002)(36756003)(8676002)(2906002)(66476007)(31696002)(86362001)(66556008)(41300700001)(2616005)(5660300002)(6512007)(44832011)(6486002)(19618925003)(26005)(4270600006)(186003)(6506007)(8936002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVdJbk9NNWg0OEJRYWlLZFhTZXlodkd1ZDNrQlYxb1dBVTNwU2QveTZMVTFD?=
 =?utf-8?B?Uk95eVIwKzFyWlpEZ3FIQU4rQUZxakxWUy9UWDlXNGZxOGN2TkF5ZG5aNmNO?=
 =?utf-8?B?eXptWmp5cnNhWUF1MkNmbUIydGZyaHMzcHpXdlhQOFVUYnUxV2xrY042NnRl?=
 =?utf-8?B?aFV0R1NvcHc0dFlnS3dISVZvWU44alIvbjhYcCtVNE1RajFCanBGY29RODQ1?=
 =?utf-8?B?dEVxV3JRamJmbWJhMUh3cGdQWnVNT0R0TzloTkJEUUdTbTFhUXVVVmkzNTZO?=
 =?utf-8?B?T1lERkVSQTVTOUhaTmtkSk5Lc3FnZjQ2dVJnUkZjMjlsRTUxVTVWRm1KaUVy?=
 =?utf-8?B?K2ZYWUtmY1poRkU1RnpUWHVFWjlZd25uVVJuRHd5dDMxQWlKbC9vaFZ3Y3VI?=
 =?utf-8?B?dGhwWm1hK054Qy8yQkFLdUxoTTRIWjNmeDZlQWxjZmsxS3hyZDljVnYzZ2d6?=
 =?utf-8?B?NEx6NGtXVWEyY2c0OE1UbXRzZldvNUk2dEgzNnV4MFNYUWR1Qmh0SGMyRTVi?=
 =?utf-8?B?ZjUvbDJFM2NWbVd6cXhhQXcxWUEyamJzZlcvOXJFblVGbHZFRjQxbUhDOWFu?=
 =?utf-8?B?V0x4aHNaSGdtUE5pb2Z6WmJoWWE3TW80Nk5QcnkyU0w3ME1RWThacUpyeEp4?=
 =?utf-8?B?d1dwcGx3OFh3SHcwamlvenZRVHVNZHMvQnA0UDArN3paWlowZkw0cGllOHFr?=
 =?utf-8?B?TjdnN1FGQmtrRzE2ejdxQ2dDNkVTMDhBbDZyUmQvR2J4Slhqak5QYytxbDAx?=
 =?utf-8?B?Szg5TzVjV0lPYmJtdTNacS9pTmc0R2pnYi8zOEtPTzluWlFZWEtCWEJQT0lr?=
 =?utf-8?B?K1hlQmdMaXozcW1NUXplZ1JzbTNsb3RUMVF3bC81Z1d2bzU5c2xadndxdW1v?=
 =?utf-8?B?bDZESjh2bmFmMVA2QWQxZEkvQTJ6WGsrZ1JjSkdDSzIzc24zOUROd3J0ODJL?=
 =?utf-8?B?c0ZHMFhWWW1Ybk1ra1h6NzUyTnRwaXpCakFFK0c2NUxINVlHdnh3VDhNK3Ux?=
 =?utf-8?B?TjMrME9FSEROWkJSNVU0RjNCMkxHTjVUWGRtajVObDFRellIS0ZrRHpOOWtW?=
 =?utf-8?B?OE9vTDZncXB3OG1FeWFIZG1BaFVNTEZGYitEK1N0RWh4eU5ndVYrNWg4QUtS?=
 =?utf-8?B?VUlmTnI2dkpFNndWV29VYjZLSDFDcDJUMldidXpsWGI5NUlUdVcybHZXcGI0?=
 =?utf-8?B?TjAzWndOajVvNm5Ya2hYaXk4eU1XK0xOZFFSUGdJMG11ZHB5cVBUdjlDSUM5?=
 =?utf-8?B?VDhwUHFUYVFYM285R0k3ekxNVFVkb0M3bFRUblVSK0ZoTkV0WGh1QTU5YnFU?=
 =?utf-8?B?dm9Pcno0dkpJZVh0QVlLUzBEK3pEOFY2dnpaSDZmdXBmTDFiamJwN1ZCa05I?=
 =?utf-8?B?M1lranVJM2V0dzVNUm5uNW1hN2N4OE9oYnNoeHZqMlZqR3pPakl3dFBmRkVU?=
 =?utf-8?B?WW5LNEpZUDRkYzcya2Qwb3FDZzFvZ0gwRnVnZEdJQ3JsSW4xc0hZL3ZxZVA2?=
 =?utf-8?B?b3ZOcFRleXR6WWRmOUxHSFJMQ3RlenFuU2hHZ0ZJWjR3NkNOWDVmVy9LNnVJ?=
 =?utf-8?B?S0ppb09QeTNvcFZtcGNFL2FYcFlCZzVOL05Wa01JNE53aWJqSXUzc1hSdzZX?=
 =?utf-8?B?MitZbXp1NkVOS08zSmQzSi9wM3lIekNvY3lzZEMwVC9FbVFScVlHS0xyaUda?=
 =?utf-8?B?dFhBNVptblc1ekRZU3RaN3dneHQ3MmZLN3RyOTJZaTNsWXZ6VytlQ3FzVUJW?=
 =?utf-8?B?WlF4ZEo4THBQdm9HbEhpVklXSVVSNDg3dW9neG9VeXpEdGV3bVYraW1mM3o1?=
 =?utf-8?B?RjJmb2VWZzJkZllCNzREckNBQ2VIVHJDQXQ1akY0akRwMXpMeFlnVnZoZTd6?=
 =?utf-8?B?Wnc1OHgvZ2JLNDYvcE5Ta3BNSVE2RzVlbVNRclpYZE9VRlBuZkg4N1ZUc2ky?=
 =?utf-8?B?LzJVV0EvNEoxSTFIS3BSY01EZHV0MldCckdHS2UxVDJodFdaOGpRMjRTTGdl?=
 =?utf-8?B?RUlHRFJ1N0I4ZitjWmIwRUptK0wvUzVueExKU2R1V1p5L2JPRFRnd1IzVzJi?=
 =?utf-8?B?dStSK0ovM1k4c3JVRGRNWXdFTVRSUGxyb3lxaTVvWlR4UkZuK0h6YWJ4amNG?=
 =?utf-8?B?dHdrKzlkUVNxUnVjOHZjbWlxZmJlWGNHU2FkN1NEUzMxU1A2TEJOV2hoaDk4?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XiP5LbeBRLjAHCiBkx/2Sn5ZPyVpQUVyCxjkasmjxKsF0nmeoEHA5LK/KVD0JeVQqXR/ZKevKXdlPeQuFCL04v8T8l201J2BLCySx31ApJQCbiihOOaTevb339PDGxizRflUCnbnxHZuJFuo6ZJD5PU3TczHMMCwCH9rjHEGyKUbGcCJQqif3WDiZKdU7TnjzMEmYyogHz0bZj9a1e4lAV5VkioZxezWTkZouCArJL6uSU4huBWIri66KwMyzdXM4Q0qW6mPk3BYff8hILKy0cJhzB9Rvma21jM5MejZcfDzZzzySinNnzwQktjqiF3lhDq7zfFAans4DQMI01FOJ45aBqubmIaPZb4dQQ+izvvd6VLdadyiEJO2RM4lFNp62whrI1w494jJ41XF0wj5bppPqI/4XWKbjXrOdFRiXX3wotEDBSEDlGzoVoosu75+1prVvvBUeX3Jtz/T1engmmv0JM+b9IXFpORJieF+5Uk0weo0G12h6aWKmJG0HjlLv5eYfg37dhQfk3GLnNJML6UDT0SJV9spegs0D8FEQ36DUNDEEX2LFcFnCeGLdugvyDm+LQxDkCB5GUSKmzH3wF50+ZovafkxRR+VaF2T9YmdU0MVj0dnnu8AluLcYsYGEVo+PN+22aSD2kQSRgqgAq8SrwSGk0hRgl40sPqf5HYFH/HCuTiufwO4yxvJvyxTeSoSLMClK8IULfqhIevgK1pjih5C9QCSGtrYAcvRGTI1RCE1ZXAlWrf1FSka6SuUPy507jqSyxZ1YJElKXCAVJ0z+OBpvmZy98poSjfP5vA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c149cd92-f504-4135-2247-08db2a0ceb9d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 13:05:18.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SjTfE6ma4H13wizdJJlV+c7Ifj9b1UWRpGNWZXNmMfzEeSrcPL3YAJJaOH5fS0+d83MB0YLkxTVdaiVTgaRXwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210103
X-Proofpoint-GUID: gCUGLsIaq0GBYyPBb1XUWe1iqZNW0N21
X-Proofpoint-ORIG-GUID: gCUGLsIaq0GBYyPBb1XUWe1iqZNW0N21
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
