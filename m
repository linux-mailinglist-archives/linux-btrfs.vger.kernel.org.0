Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0695275B151
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 16:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjGTOeI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjGTOeH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 10:34:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236AD10FC
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 07:34:06 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KDdfDQ000956;
        Thu, 20 Jul 2023 14:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=22HndD0vbJi8TIwHVSRDZJP/eHhR3+/I2tRjj+3KhcY=;
 b=ABqOML7N0voJv/+gmBk244WBbeg2j7vSzaPi/Au31UQ4yUliYlWBBsnbWzr108FUfYY0
 HWhY1QgcAxFhk8hdnt+JD4kM/hjKXEopBHkviPSLt+pMpGdGSiJQDCA/uXlPxilFc2ji
 AwWeSq5iyrf47iKnxoFdYgGJXmSFaFsQM88M/f/K3CfKeskyEVJiM3v2l6oPPxWSloPl
 oUSRM/Zd+LREFlKXtxO2I6cJA+m9jtSk5biZjXE3l3wn5ey59bqfRF1fcHY3p3sR/dP6
 szwdTx78svqFTrWt34Z1uKQavq8j/u9nAOt1czQXhvj9X/7scmzsND38Y2QUF3vBrAIg jQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a200a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 14:34:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KDwB6s007795;
        Thu, 20 Jul 2023 14:34:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw8h5yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 14:34:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpiSpQGK9SV0N/X5h0AiZIN5bOy5BkwqhnS0allMQ+Lo76q1qesI+ctxKRHg8mg4ByYX74kMYUu5eaUOU7kwpw41EHoWovizBf9oJWgkcbXt7+3nW3DptFUa6BSArRPpIwQDkyT0rf346ddr4w+sIbOrmi7jv76c8Fpe0Cbb3E/415Y/V6XZnjDidBfCJheAp6hVftTZLlrk+aDJTv1QmFWvgmHDOfNXnPjoxuiz+qIDwZ6TWXaFbNU+LKK7XByNszvyQ2zklsAbhrH1N2d1ymG2898cPGrHZfjrgQaS3qxrXOMvNABrjEY6eLufzTsqV0MLyjxIXTQCdxXVAAAbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22HndD0vbJi8TIwHVSRDZJP/eHhR3+/I2tRjj+3KhcY=;
 b=JJEob+vSIJVCY4NXVbHb9EvYfv50NBxYxVfQgnOIfQro0AKg/eaS5DKKLKXQkLzlhUmq8Nx1vfN6QKJx6EeTbhiVry8OD5H1ZBqGE5clmnecfd00djDQgyvdy8O73Y8+zC+0GXEPxLl44LO16InEcDOOFKkPxqbENWLdgjI2MULFFtH+j8SAxQ7fXQQtZ+HpgFdWczz/UShjw8rt/jGeMyIIMS1wj1GSphOZ13R37Mt5I5RRj2qpelHaamNRWf/vlKj8vbvWWbwcjIZFHPe28t3LU21ns9CNZxmAHUTRQPbfqDcfFCaQIy1oLjz3WivK8+6qpj19i2SzzZxAg1+yHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22HndD0vbJi8TIwHVSRDZJP/eHhR3+/I2tRjj+3KhcY=;
 b=cKJv/QFaObGMJK3DAM3vC4JV9/cY0XoPP0YY7fRLesLWYxZr2COtGF4IXccp5ORM3jPKE6fT4tKeB4YEmgVK5bxDbE5jS4l1eUvf7+6mzvdRr+e137gSOR8lNUhA8bjRIs9XSlrxmyNYMmShza74pW9h4V99fNIefZqV8mqaotc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM3PR10MB7947.namprd10.prod.outlook.com (2603:10b6:0:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Thu, 20 Jul
 2023 14:34:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 14:34:00 +0000
Message-ID: <1fa6802b-5812-14a8-3fc8-5da54bb5f79d@oracle.com>
Date:   Thu, 20 Jul 2023 22:33:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 11/11] btrfs-progs: tune: fix incomplete fsid_change
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1688724045.git.anand.jain@oracle.com>
 <24bef15af8c65da69ab8a3b574e0da7b71295008.1688724045.git.anand.jain@oracle.com>
 <20230713185726.GE30916@twin.jikos.cz>
 <f561f253-ebe3-0907-bf03-4daa334d3693@oracle.com>
Content-Language: en-US
In-Reply-To: <f561f253-ebe3-0907-bf03-4daa334d3693@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0174.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM3PR10MB7947:EE_
X-MS-Office365-Filtering-Correlation-Id: 051f2732-51fd-4b56-471b-08db892e5b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQC++La/MYzY4CpIk3qTZiEHl4PHqxafM77y79OaVasr4eRJx+Vs91W37urbJ8YInbIQJzUqN1jYBB+YKW4ayanqo4gIQCnHcb2J+9cThhLPRsGZnNU9RciDE5Vze0TaQhlpD51JH/H/25nwLYM3eR42dTSMLv/NxZstpT2O2P5raJ/oA7qygXq1/ATptjTM0QVHpOuByqd6dhb/HAnVuOg2Yr8w+JfKnIq8f2+vDFFOLw4WrZ7Eo3vqnxmFQdtGx7UoqOL8E+GdbU3fqhmhr4dtjvPRbgNC8tyDcYaialbLfvmr9pyEqZlv/Tfv3QPsAxgWobCks8KRT5hlsusVChh9ihL6rfrXOK6HNQMgDeysm3cIN3BGKDG9kyMLna3o3rqKQFoOW6hXXmeNUjL/BEOGPHn8YD7S/EOa9kRDB2Dy3n9HRzQgl//+eswIP3Kg4uSuhDgt/0mm6+bOx3WY/YIca0iB/9o+rs+FCpxAMfiQcrsOJWdoejrH9WZmj68iEwhnHtnf0YdfZPDqosVTuoTrfvsZkrleQuXitmohWdRbQK0KBP0wqaetF6wV25eMQl5/NDjbUn82BTx1fIffzreVZv7RlD4i1bSw5b8d7gJ9Ql56G0qRUy28os5SsqZ/R+3Qs0qNmsPBAvB4hynEQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199021)(6666004)(6486002)(478600001)(86362001)(5660300002)(8936002)(2906002)(36756003)(31696002)(8676002)(44832011)(6916009)(4326008)(66556008)(38100700002)(66476007)(66946007)(41300700001)(316002)(2616005)(26005)(6506007)(53546011)(83380400001)(31686004)(6512007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVduazV0TlZmTW4zU1BFWVprQ0hRZDJOb2VTdmYwWGdKU0RBSkZHdmNVbzY0?=
 =?utf-8?B?d0ZwY2oyVkpPdml0ZzhTZFk2SlNXVGtEZmFKWTF6ZUhXMmdPVXBqWEd1emN6?=
 =?utf-8?B?RkxWM2JmOWpXMWxDaFR0SzB2LytMUUpuR29tNVcyN21JMmppUHVCMnhubFky?=
 =?utf-8?B?KzVwY1JSZHkrZXhUU1hnQ2wydk5YbC82eXZaSG9adHd1dkVUYmhOLzJyN3Nh?=
 =?utf-8?B?RGRiZE40OGczWXFWQ25lQ3RIMGl2NjB5Vzh2aEc1UG8zY2hld3hmdDd5Uksw?=
 =?utf-8?B?VmltYnpOcXJOUDhqZ2FWSGU5VTR2eTR6NnllVGZpRDVQMUt6SklWc3E5SjJD?=
 =?utf-8?B?OGh3Wi9tVXFZT2lYR0QxM3NZdnY5N1ZhdjBQblRzdndSUDJ0alE4bzNqR2xh?=
 =?utf-8?B?a1JmSjNseFp1TERQejR2RWcxeENRcnJCTEI0ZWxrT3R0OTVJUWpVTGMrSVd1?=
 =?utf-8?B?UVh5Rk5NWlFJNE5Tb2tSNkVPTXpCRk95bElISm9mSEZVOWx6V2hXaFVRS3V2?=
 =?utf-8?B?eVlHam5sSWM4a0h0K2dRcG5ERE5ZdjNGYVdWYjVpdGNRQyt4UzllOVFxVkly?=
 =?utf-8?B?STQ2SGpzYVFvaXVrUTFVM3ZuNExBd2c1NTJhSVVDWUN6allNQTdtR1lXNnF0?=
 =?utf-8?B?aWQ0S2owVnJEbHgwVlVSU2NkdWZLS1MxM1E2RmJxSmtXYXhLSHY5eTMzRmIw?=
 =?utf-8?B?eUdITlRDUG9va3lPVWI1RFVvMDZ5WlFSTy9FL3VoeDJuNkZIL3E3blNPdVFT?=
 =?utf-8?B?TmhoL205RW5Xc0prU1g1azhabE5hTVdwU1BTbW5icERVV3pRY21Wa1V6Y1l5?=
 =?utf-8?B?aUZ2bUJKcC9iTllSMy9JUi9YNFJLMHAvY3MySnBXWUV1TnR3aThmUXJSUGJJ?=
 =?utf-8?B?Y1R4blZrVS9ZaVpJaWliYnZtY21IclpCVkxqbTNQZCswUEczb0t0WUY5NEdp?=
 =?utf-8?B?Tm92RFlFOEZtYi9ZVjZzYlUxb2s1Z1V2N3FaVXZiejVPSFBuYkxZZnlHNTBC?=
 =?utf-8?B?eERHWGcyMmJWaDMyZDd6Q2E3amhPRHRZTFZ4NnM2L3F0VERKMmZsS0puYitO?=
 =?utf-8?B?aFgxZVY2RDNFNDdGbzY1bExLL0d0UExZSlRuRkhTNlNMd2wxQ3Rxd1UvMHll?=
 =?utf-8?B?M3VRZ3FYT0NkUytmNG1ocTZNeVlNY3dUejloYUkrdVA2dTZCZ2szelQ3enhI?=
 =?utf-8?B?N0xTbk5wbFBiVTZLdUhTWXpESTlBdGR0dFpqKzl3VUVHQ05LS1FJVkVrbGY2?=
 =?utf-8?B?Z3ZCd2ZrWHI2MkNpSVFnb2hPbVdpYzFMelFjNFJFUXk4M1NPOVJ2OXU0OGRi?=
 =?utf-8?B?dlliU21sdTJPTE5tdXdTa0VSYXNlRzYzSER1d1FGU1dvMVRHbFlmTEYwMjdh?=
 =?utf-8?B?c0JDU0xJbllsVlNxc05pY0JoSnBnTlRDNDQrdmVsMGQzUStveFRyeUx1NENy?=
 =?utf-8?B?allML2x0NzRhaVM4ZkNscGl5SEx5bU1LYzUrTkdmN0dkK0N2TDZPOUowM0oz?=
 =?utf-8?B?ZXh4aHZ2WlBBQ3pRc1dEZllmZm83Z2ZHWFV0Q3JJb05vNUNXcGFYT3FuajFO?=
 =?utf-8?B?N1F4QmFuTlBYbnBFdkd4K00xdjdGaU9nM2ZLUXVuRkQ3RDRwUGNTSSt1TWRE?=
 =?utf-8?B?Q25yWTRNRVVjQS9ybWV3NTN6U0FLSi9uTTVHMGloZDM0d0tTc2RYOERRdC8v?=
 =?utf-8?B?MFhwNS9YaGltSk5mMDh3czZRV1RyU0hKWGNnb050Qy8yOU9ha3czbEsrc1Y0?=
 =?utf-8?B?am9HZHp1dWdtRlM1ZFlpY2poK3VIUlZad3RpZkxPa1A1ZGlyWEFUVFhkb2dF?=
 =?utf-8?B?ZVUyRjVocjY2cE9uUlFRejBMLzN4Qy9zaExNTGVzYUYzS0lqSzNaWThLUW1Y?=
 =?utf-8?B?c0hxdnNlVWc3QmdVWGxqVUxQaXRlYm9VTnVGM3Z0Q251a1B1UkJiZUtTbG9E?=
 =?utf-8?B?RWdpQlNzdEhWUjk3S0I3aG1pUmRIYmtFSkZHS3RsZlZPUVpYRk5IOGwzMkYv?=
 =?utf-8?B?SVRUVzJnRGk5QU92eDBBVDV2U3BRYzcxeU9WZlcyR01yM3Y3RFFMc3NranhK?=
 =?utf-8?B?R0VUNHd0Z2ZFbythQjNHL3VxTGV2N0gvSk5KZWwxRHNCL2d5OGwxQ1lzRElk?=
 =?utf-8?Q?C8RVMnKHzisu3f2C+KxTcmMrE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oOWkyfjNK4A2iMJ2Y2Yx2erOVoijmpe+DMsjvzaXNVqXqaP2BS9fJWn/+QKFBlU3Jto95APROknknBVJ1ry7Vkao51m3AjWUW0bCVs7eouG/TEas58omWb/JWPhACpB08Js4ftSSF3zY4rMu5v2Xvhsw/5X91Ps9TrF+pq94xcOjjBKjyNfXWoS+LFNaTVRBuoGZjnEeOY6P/Z71hImDSpFoh5H6ox1kxEhbnSYXFCjVHBTnHkDrhdfm46sHvhkwnEL49zVvetkA4gNL97KLnLRQt92N5h81lcYAKtPCNntDK0rH64rRAd4APWPZHUxmynYCFzmlB7ecBBlGYaIvAv2Wkbu4VbfRCl7KvLFvgEGDkIZ/rht+d60nn4EireMvYj9ZcTWb5wsWFZobuOLEUmnOLGQWgWKsyv5e3+av5cDROZstzGTelfk+KPUfJhOWjmrAfhBQk85AJ5uVS4Jb43e+PmjuIivNRspLd3PZmzeLOpISYCIu0JqyqBvkIpkgx5ihJMrSfvnzltHZ3+WgvjmtWB2KqBMh8U63jf46xdT/moKgz2QzYUa7eHRDSjagZGhtNnq/h+6JDOd7rpYKAfy6jVgmBPWUhLs2ZGG7fZHE7MGpluMoxisiRPYBXBGjjZedL7d0E13f1Bb8aEcO1MT9aSiGYyv8YHcQ5IobGnqLdjSR/vsmHG9AJ61kWGIaznNsxaxno4BjwQJ7/lqSSGMvL+xpXtUB/Lo5zUjsaJWMGoQ1KCHJkL584cAFcHe4xcWZpzTBDkLu8GX4cEKUU1i/BIVsYopMikA4piar4pw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051f2732-51fd-4b56-471b-08db892e5b53
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 14:34:00.0041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ro/MdDKfP1kBQKpn/Z66A4dTkUyZ9vC6HPZuoUYBACzwiewI+XGTq94svCHD7qndw15k83Zx53xVTt4U8oEoTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_07,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200122
X-Proofpoint-ORIG-GUID: 5NVNxBo1MdYh8ZhoWgLJuOJy4-9c1F3i
X-Proofpoint-GUID: 5NVNxBo1MdYh8ZhoWgLJuOJy4-9c1F3i
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18/07/2023 03:25, Anand Jain wrote:
> 
> 
> On 14/07/2023 02:57, David Sterba wrote:
>> On Fri, Jul 07, 2023 at 11:52:41PM +0800, Anand Jain wrote:
>>> An incomplete fsid state occurs when devices have two or more fsids
>>> associated with the same metadata_uuid. As it can be confusing to
>>> determine which devices should be assembled together, the fix only
>>> works when both the --noscan and --device options are used. This means
>>> the user will have to manually select and assemble the devices with the
>>> same metadata_uuids.
>>
>> This is not a good usability. If the user can determine which devices
>> should be in the --noscan and --device options why can't we do that
>> programaticaly?
> 
> Technically, there can be many fsids with the same metadata_uuid.
> I'm afraid that in all split-brain scenarios, we may not be able
> to successfully identify device partners, and assembling the
> filesystem with the wrong device could be disastrous.
> 
>> If the found devices can be reliably identified as part
>> of the filesystem (and there are e.g. no ambiguities due to duplicated
>> devices) then the command should work it out by itself.
> 
> I expect btrfstune -m to be used more for modifying btrfs file images
> rather than block devices. Users can simply copy the image and change
> the fsid, which the system won't be aware of unless the user informs
> us.
> 
>> The btrfstune commands are supposed to be restartable, namely the uuid
>> conversions, basically with the same command that was used to begin the
>> conversion. If there's a problem that needs user interactions then there
>> should be specific instructions what to check and how to resolve it
>> manually.
> 
> I was trying to avoid yet another cmd option. If the command is
> restarted and the superblock has the CHANGING_FSID flag set, then
> the command will fail. In this state, we can add specific
> instructions on how to continue (i.e., --noscan and --device options
> are mandatory). Or any suggestion?
> 

  OR I think it would be better to combine the functionality of both
  --noscan and --device into one option, such as --reunite.
  Better? What do  you think?

> Thanks.

