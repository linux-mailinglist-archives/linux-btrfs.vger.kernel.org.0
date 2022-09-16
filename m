Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0882E5BABB3
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 12:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIPKxs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Sep 2022 06:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiIPKxY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Sep 2022 06:53:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B213CC5
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 03:34:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G8o0C1024273;
        Fri, 16 Sep 2022 10:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VOE018TsaULHG28hVHftCgdeRau27+EM4CMRrjWgh8k=;
 b=0ElS4EjQlBInumf1eXnt28WUFG1Cl+aBfyo5vQIK0SkIofPDYEcWwfep1h627LLxjRgv
 IiyhkUfXbsOwZkyRNdLVyM/pv3Y7BHvVa26vrOfa/kLL/DUnP/gD5dGrgJiCJy5g6fNI
 EvhlBwMvr14zLFCbjuLyhXUH/LH3w7v6qbLgOrETkCDkDtzgT2fn69mSzjgu4dgx0Aqx
 0iFpsPIxK+so3XSM9Hoh9I9CeslgSoynX8007YGKC/Okyxq+BQNM3cXFF78EkYIgyFqH
 A2uy+B1yO4nVoSZaV+utw7/d2Seam9MgvWsmd8/GtCptN5nU2deMip7hp1nI8MQ2wjTJ 5w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8x8a588-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 10:34:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28G8XACf025155;
        Fri, 16 Sep 2022 10:34:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8xe29ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 10:34:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOCFQvzap3aZngloLp7/FAxED62G5pmiDmmxLJ8OIDTOuxtsa0lxv5ww5IHHlcStMEIAtLlAEVKkNhRXTQcZ9u5WsDHT7nQhPyRovP2TyfId2AWLMpIa+sYxpwZGXI/mFPRz9Lpdy4brLt8PyVrpR+TTyfQUuqM/pF117jkqRYqWzzG3x5payfmYFmROMz9UIxVvYndtgOQ+Zdu29hGnXQeR6f1nFnlccvzyzLPYz5hZELLb/lDwNHRsk+WE/L74gpx9fdXOxu2CSlJFIj9kc+CPPy8hi/rtCY3EXX3dwdnREjRE5hJDkT4sH33/g5nhcsQXymIoxWWBxa5Ma+c82g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOE018TsaULHG28hVHftCgdeRau27+EM4CMRrjWgh8k=;
 b=Yawq3v194zA3f6TVWD+mdhywluAQF0ctP5VYLLywwNNHTjDwRwmDE4N8Sn7xno3AZ5LiYT8drKmmkGODd+ju6zT0UO4nAUvNBFcvg/Ko4sTSyNUoTSF8W+0UNPb0KKSehHV6gRCh5/rKWkNb+Zm3dhu4OZToEIYLCS5bqG5otAo0Jm2XDzzhnyEkDLMBGfmJXEitfFMwsEbhct8tFhXfiNgm7aTH9yDpF3TYl952vi1aku/q/xMBq8SP+09IhXFHJwbL+Uhuvmn5gi3aWrx0ZdFAcYdgNwpgkarNONbQ/xUv8nuI2cNHkiP6mC1228XgHZAlimTM22O5rAEbJVdppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOE018TsaULHG28hVHftCgdeRau27+EM4CMRrjWgh8k=;
 b=km2x4GkUSQi4rUGE1ZRRr0gECneNI4Q+0F6ITVoEBhK6Rwpcx9dv0c/ZQ5KUe7JEeOOcLMbR4DAqMSqzKrdNXHPYYZt55NQG8Ar2KFbtBeXvURbp65XXAshZ2pd/5WjajpZ7uGcKoRT2lwNrU03RvFg/fS8+EfP5iN2XG1HLbBI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4513.namprd10.prod.outlook.com (2603:10b6:303:93::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.17; Fri, 16 Sep
 2022 10:34:09 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Fri, 16 Sep 2022
 10:34:09 +0000
Message-ID: <4c338b44-f2f7-7e82-1f0b-86f0649a5d74@oracle.com>
Date:   Fri, 16 Sep 2022 18:34:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 01/16] btrfs: move fs wide helpers out of ctree.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663175597.git.josef@toxicpanda.com>
 <d2d190d8c93f85e0e4d8a20f133a6e99a41eac98.1663175597.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <d2d190d8c93f85e0e4d8a20f133a6e99a41eac98.1663175597.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ee38df-770e-4772-bfc4-08da97cefcf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AueVrP+BZVxqLhZ04Nz9xMRQzeHokbYJ7ZkjX+YKER0mvmAbxk4yjB/zwleSuylGwfQI8+/x7Lm2njURHr5wtZ3UjvcQcN2pIwKKVFQ01OUdJm6UvuuCeLhV1pZGPh/CTYCB1ocw4DNCGQ/SuKB7tTvfJQ1zc2dgTnLTCBZuCUBu62hhGQpJT0NwCKoVilu+8Tz56PtkFJ3ic2mfhT6itQ+mRp6v467mk0RYqgMDT9F2LnNGiCvL26gKnGVjga+1lbtxunD2wtl8efNlqMDSvGV2tAjrImxOuvBaptKXeyRN0jlSfRrI/2Hn2ATxxsHDi2XZKrvAgPv3BhRWWE9aPHbR7tYVyAu6IvRHylWV+V7XA9KLxSdbgLf85I4dBcrVi3q31qRqJ7T6s2rfIMq8yUZBcxAeHUNlKf7r6LGTY/KqaajH5iFMBpOVt0YTPwPVQsphff/ZCZerivsG+tuF+fsVO7QUVeWOcqND0g+JLQWOSTrx7ujMVfgWLkMz/ATOVjjI6VWJIdkf27fEZvd+ol5iQDneEhI986NRzwnk3SaN5fdI6B2jrxxI0yVTdCkFit9IygL9GklIH1YdRxdDKUICjyZZvrim23nH5XsSVBCNaUCXgm4sf6YkWcYl4iiJmBsc3SelUlEAgriMTykKfDKey0HQwdBE+YAhPQb5eJoI5+VHWDKHwM0AsKbfkQDMqZExtSogCbOBFPfqPAZ1+3vnqvEhkpRSOzexiqgvFVc4tM5zK0ov9xtk85nUXwCDj3a5GGstM0YUbCgBKrfopPmKBlwWN1Apy2RlBNj2NXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(38100700002)(86362001)(31696002)(31686004)(36756003)(44832011)(6512007)(26005)(4744005)(2906002)(41300700001)(478600001)(186003)(6486002)(6506007)(6666004)(53546011)(2616005)(66556008)(316002)(66946007)(8676002)(5660300002)(8936002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFlSUnpqTHRzWDVrMnA1RlFEamF0RHNVelZ6QVd2cHFhWitENEVtZWxCTUtF?=
 =?utf-8?B?bzdsK2hIMFJDZ003VTQySjdqM09XT3o5NnpSMllrdzEwV1ZINzhyaUVIT3Bt?=
 =?utf-8?B?dGc5dXUveGpIdUx4Uk9xcWh3ZW92R0hFd0hNa2dab3pkVEozU1lRVmJtNjlz?=
 =?utf-8?B?akdMVVhhbTYzOTFlUzNjWFFCNFJFWVgxamtsNWxrdXhtS1dTWXpEN3QwY2Jj?=
 =?utf-8?B?Z1c3YnFXZG9IbmgzR2xsWjlsSkEwTllhZzBTdGJBUVl3RXlXdGZXbGVnZzVy?=
 =?utf-8?B?eXV3TzJNS1QxNzhJTC93NEkwZGNSeWgxTFlnNnI4YW9iWVJGaE5Wamhlc0g5?=
 =?utf-8?B?a2tRYmprcERoZ2o4SkV0eG95R2FCYlJ1Nlk5MHJjNGNlL2NUNFE2WktmZGxO?=
 =?utf-8?B?MGZYVFNBVWJFZWRBMDRYOVUxeVE1OW4veExzSjFwUDBFalRaNlZCcmpDSkNF?=
 =?utf-8?B?cytuM01XRE1QSm1ERjhBRVpSMWdySTRuaE9NVG9NekdnbWZGRkROb3FCVXVp?=
 =?utf-8?B?d29PSVYzKy9kU2NvY1lsV1JQM1M4NXJsclI3dnB6V2JyM1ZDRC91NG4rcFBY?=
 =?utf-8?B?M2lNWnV2bVpDZ1VxNmZhVU9WQUxXS0xCQ2VMZktTYWRHUmJEZ1lKUlVzTGxL?=
 =?utf-8?B?cjJNRjl2V3R3TTBTR1VVOFgyNUNid1pFSUhUYjZQbDlaa0piWEl6WjlUa2NF?=
 =?utf-8?B?L1BYNE9saDBCcnBxVEZ2b2pBd0orQTA0emh5WlJsOElkRnlMRUlSOUt1cC9n?=
 =?utf-8?B?N0ZYcEppWGpHVHBvM25xa2hQYSs3M1pnNWFiN1hidmVJM2dWckZ2ZVQwd3pm?=
 =?utf-8?B?aGJTekV1NTcvaDVYRzh1dUZZR1VZK1R2SzFIZjRRbzdCNmZlNnRWaXo4RGVS?=
 =?utf-8?B?TUlVWTlnaFZtMm9WV29FcWhVbzNSVFpnaGg0TVoyZUd1NkFvaGx1MlAwZ2c0?=
 =?utf-8?B?dDJqNC9BazFBMDZIZksvemwxajNzK0QvRHJIL3V3UFV6OU1RL294ck05SWJG?=
 =?utf-8?B?YjI2Wnc5Y1UzaldHMzBtL2xUYVZ4N1EydktkMDZqMHZ4OWZFWkh2a1JINGNB?=
 =?utf-8?B?VjRzWjRYdHY4VnRscXBVWHBzblBqTFptaHdESktTZVJFUFI4UU9qanRmQmpO?=
 =?utf-8?B?TkFZTExvakEwU0psV3A2OVFMeEkxV0tWcWFKVmpybU1lZE9iV3JBVlUrS2pl?=
 =?utf-8?B?MzRqME1OL0Nacjc3dnVpUTdJV21vN3AySEpVTk5xK2RhL0RnVkRSbGZYMkxu?=
 =?utf-8?B?TFFNdndWUUlyL2xjM1BMWTRnS2R4R3ppb1FXUDJuNGczWm1LUXcwUkV4NG5R?=
 =?utf-8?B?a2xZN2RSWXhObHBuVjlTMTlvMjU2elI1T1dzMDJlMHJ2bVZmT2lmKzZ6ZDc1?=
 =?utf-8?B?OHZqOWsrUW5MNnpJUkVWaGlvRnBobG0yVVBQeTI5eUs0NlFVV1hCNjByQzFS?=
 =?utf-8?B?ZXdIdEZjUlpSbFIvZVRoWTlDcGRwaDltbExseVZqWkxUOXptTDFGTE9QbHgy?=
 =?utf-8?B?U3BjWGR2cHc2ZG1ZZStwWFdoVzY3U3BnUjNQWENYc0hqMlZaOXNzT0pPTVNp?=
 =?utf-8?B?UzBCUFlZQ2xTZTdkUlBOUUhsZW9jRXVsUFdTSi91Yjk0N1pkVFpnNHZhUnNr?=
 =?utf-8?B?MGYzczNkMlo3ZW40ckxvV3Fjc1ZPQ2FMTnJTaHRES213cSs1S3ViQXhNQ3Ur?=
 =?utf-8?B?OTVxT1V2UGw1eFRWMm81NmZkdFV0RVJpdWpPWGNEQjErZHFTTU5hNjdCK2pp?=
 =?utf-8?B?RHNMbXNrYm82ZjlidUlQUy84ZFUwc3hDWktjdjlkYW9HMXMyMjZ0bkM4M3B4?=
 =?utf-8?B?QUdXVEE4RTdxanhsTFBBdVIyVldpZ1VtTnFqT1VMUDlYanZ2N2VCRXl5Skx0?=
 =?utf-8?B?OHJOYkFHWGVHK0tHWnlJQS9obzliR20zVDJwYTNzeGtKbGhseDZGd1hOaFo2?=
 =?utf-8?B?ZXZnMjlEaUwzbzZyQ3d6Z3BMTWtReVNWMEdvQ3pnZGgwZm0wMmVURTlDT0w2?=
 =?utf-8?B?cGZHby9tTjh1d0RTelhtQWZjZzNqbW1tclVkODZkTGZUVytNWnUvQUtPOHBT?=
 =?utf-8?B?SVlwQnpCTnJML1JIU2VDREwwKzAxNS83UUNaemJVRUQzT0FxVENCdGpHOVEr?=
 =?utf-8?Q?H7ooeBVZlt1lw1zIEmVQzyPfs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ee38df-770e-4772-bfc4-08da97cefcf8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 10:34:09.6281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUwHerdtXucQJKiXJWR9dxwewrMSuqfsVgA5A01q8THPUgicofQwrWCsMLXtDmvoL2MF4ImkZJsJQ46BOmdDiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209160078
X-Proofpoint-GUID: xvAWpbBsAAsT4AinjNT5RPOE1bEREIvZ
X-Proofpoint-ORIG-GUID: xvAWpbBsAAsT4AinjNT5RPOE1bEREIvZ
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 01:18, Josef Bacik wrote:
> We have several fs wide related helpers in ctree.h.  The bulk of these
> are the incompat flag test helpers, but there are things such as
> btrfs_fs_closing() and the read only helpers that also aren't directly
> related to the ctree code.  Move these into a fs.h header, which will
> serve as the location for file system wide related helpers.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

  Reviewed-by: Anand Jain <anand.jain@oracle.com>
