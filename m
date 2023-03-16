Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68376BCA35
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Mar 2023 09:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCPI7h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Mar 2023 04:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCPI7f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Mar 2023 04:59:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048A8B448
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Mar 2023 01:59:34 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G8XsM4007399;
        Thu, 16 Mar 2023 08:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wwI9DKP6bSJNEjmizvrD4dhnCdVUcEejB4pQ6g4qgks=;
 b=PDj3iV8fxRlpbN9HsRsIV/QnC5xnfKOXWEZj3KP75LcrwvvOfmxYqj9ZCiBBJtgLxjFj
 0w52zUbT2wXnJjmUcoKfE2irMmU1E93VPMTfUEtMRvmgdLoP5m3vI+ms2pYX8qPNHIrd
 roCfT43gvAxYPT8wkwZ8b5I24P3s/ImKQjG1V9TqdSdxJwgIkSn5m3QTXFRfXDOb8Mon
 3m06h/z2WxgdA+c5/O8XKgXlO+T+uuD2NoNNiFx9diAkWrtA2oYMN3+qpC3WPHc22YkV
 xYS/kLoZumXjYqvolsuRVud2xPhurIsZYkUp6SFJEzFzGUZldBAzeLdk4XiFJ8eSmBcC pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs260m9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 08:59:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32G7G3Bn020508;
        Thu, 16 Mar 2023 08:59:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq460kbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 08:59:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFlwfmKWeEr8Y89H6vuywdYBrsRiW8y9BrIoWVmLdxwsDdjrpSmj0jBh8nTpr4cMuw1x1Ed+FoVByHeS7lH9hWv13d+dddXGbr3onDKZyW2ETKFl+fga/lW1a9sD0SQzsx1fI04wmpsHHj57Ji9rxlxXMAWGAkgpFE3QyvqmFHIEk4KVUfyu6cqLNCQ60t7HJlalU3h2hfiilhHKs68mxRilJmAiTwj5qLotybju3iGPtKh/Km7BxO/wNh1Mw0lpjxWlcZTvoWvDB2Cw2bvcVqKQiLFYhwP451bkSkBn1f3i/RRsx/+xRt4Ru3TeOw8aD9U86KEg/DDWzeF36U77Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwI9DKP6bSJNEjmizvrD4dhnCdVUcEejB4pQ6g4qgks=;
 b=At17HDUnYyIHwb259EdzyDS4U6+0cTRcvZ1jC28I5Cg80iNozJVkpWnB5a2LxgdyOZfPlnZDFdEoWUSYuWsODTqU+oKpn9NZnwHMM+hfkXHD3xc94wOIfX2nkkdfQZ8vwFiSvG/uC1cKD1HLiKDIexvVdAPfJTA3b9eURsfagMhnX2lmvF+j1SoK4DZlD/OC1HgrPzuptJDWwOCa7aKEhx7OVzcbroE7zABt9O+OltWoNEwgkTnZRNyv3d707U0Qra9lfguzGd2bIY/eD+YMBBDZ7Jsu48eza8ZBp0444qcaI5gD69nAlmRy98lk99CgcwHyKjJ116SL1visp/QFnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwI9DKP6bSJNEjmizvrD4dhnCdVUcEejB4pQ6g4qgks=;
 b=MxDCry0avK/OiOaJpevkpwRTtA6TdkeVj1NnMX3dzN3iEurqKBkStIWRM5LNM6VgOjen9AElxzB0fLKdp7HbkQGyyjhCVtgJWy2nMQS7lz15UgiRR/VOUT01OOXJpoqECLErBjrSueaY3mQVmlxLJWGp4+eZ/823cisGzRvHL4k=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB7216.namprd10.prod.outlook.com (2603:10b6:208:3f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 08:59:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 08:59:26 +0000
Message-ID: <cb59c00a-9083-daed-99f0-91ba399d5f99@oracle.com>
Date:   Thu, 16 Mar 2023 16:59:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 1/2] btrfs: move the bi_sector assingment out of
 btrfs_add_compressed_bio_pages
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230314165110.372858-1-hch@lst.de>
 <20230314165110.372858-2-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230314165110.372858-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 55574ca7-5738-4177-954e-08db25fcbe8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3wlE0JzHVksiVgKDWlGX/XbYwgUaHCaKzcs9d00P5NxAXEVCiNI+yvdXIUbwoK4zx3TF38b4YU6aK0aNCL8rjYRN/WOugg0g1Znp+tAEFYB9ud23pakF6U7KrWoyvGiOk0RtEejMhMSggokoKlo4vYrEtTLxbemc4zRXzDc0FBXIOi7IZ3BivWCivOwThgc/xBdrqAoQiM3FHY8ua4OM0UeUJ2hsU6bzidTrsR8CFt7II+vTnZTmLYvz/vn43+XW2lWCNTbAdSyvUd892TRDkFHoDVrYQ0SjlkzdS7dy8ccoZrr32vScA5oufGogZqCP2VSjVEOw+0MyctUfpvlyrYUpho1IYseiIw3FnEU6UK31vRpoOcJ5wQ+1RZjmeSBUXff4OymfKVn9C3Zq6DvWMxzt+5zk1aFeSTazCMinyIRTvRgbjs+lHR9TYLUQJLfQv850j4jytOYpSbkyalIGrLifH3ULi6aYL9xI9ntkapb17WIFRjVZKhnzXgnYtrmrfrbo+YlK1beb0grH9EELRug841tmUejDu7E1c7z7THr2xD6Drh2THdhyXMvcia9k1w/nolVAb1o1xBSR/xhRlF7TubEvf5NUklGGiBVXHi2zq/7t1pxYS0fOHSlyheNBh0NG4xeUuUILyrXjd4JLAXgGYYdwKlJPr9gWwn8/Q0vLx3iIzK0k+CD//3gppX9U8AdWsGuh0sZZ9gBGLGyC1icHwpRQW3SzQTHSJNx5yM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199018)(31686004)(2616005)(44832011)(186003)(4744005)(5660300002)(66946007)(8676002)(66556008)(66476007)(41300700001)(6666004)(2906002)(38100700002)(36756003)(53546011)(6506007)(6512007)(26005)(8936002)(478600001)(31696002)(4326008)(6486002)(110136005)(86362001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ppdHR1ejdkTjZzNVV6ckJpUEdoMEFVcG9EK0NaVDRDYm5OMUxWVk5YYWlm?=
 =?utf-8?B?dFYxYXBldVgvNTcrQk1tNi9QMkd0cHlUcHRNSGNmakVKSERaME0xS042L05h?=
 =?utf-8?B?REtHbHZFMEU4amV4V0ZNcUJYVEVmcjlXb2FqeFVGYkRuSndGUUhuS3NoQkhy?=
 =?utf-8?B?eGRINktRTThlcGp2cmNaNjBiNnlNcUd4Z1BIdnlYWHZ6Uit4SXo1REY3Rldz?=
 =?utf-8?B?bCttTHNmOUdSTkw2VXBsTFYzcjZWeExkdEN2dStnNVNLMHZxb0VuSzE5dUhr?=
 =?utf-8?B?Y2dFeDVGaFZudVFQUnM2MGNzTi9oL1E2amRQbjZ1UEJRU2FXbURJQW9tT1Q4?=
 =?utf-8?B?WFdWbCtITE55VnByVG9DVFpvOGtQbldMa1Fqc0VsaFdmcms0dUxHeDV0b1Za?=
 =?utf-8?B?TFNpc1ZBYUZaVXlIMHFwSGo2dDh2SkFGVElpbElpTEZzRHQ1elErbVRVWjMx?=
 =?utf-8?B?QnNwTDdKdi9HeUJxaWdtNWRPbkw3QitzSkp5V29KYkNQMzhQUXdJbDl2N0JR?=
 =?utf-8?B?aWg1cHYwOEE2SW5JU09oZjYvb1RDWitRbzRmN1JFMW9nRVdnank3TVg5VnhG?=
 =?utf-8?B?RHNQY2N3Z1M3QUF1L2w5NzFsaThBS21LcCs2Y243bjlyczJ5dU9YV2gwNnZm?=
 =?utf-8?B?YlhHcFZwblNlaWt0NCtCK0FPY3Y4MS9vbWVmdUFUNzlQL1pRYTNOQ243UnRu?=
 =?utf-8?B?SlZYVTJaa0RZWVVia2JzcmQ1MmtUVHN4YkJ2SUc5UlZQRTZIcFNPcmdBMGgz?=
 =?utf-8?B?b2NqeDhHNHhQS1JWU2M5b3EvRlk5RkMvOUxPclFmTTh3bUxNc213OFArNndt?=
 =?utf-8?B?OENRSVBnTi9LSGs2S3JEVUx3UXR1Y01oOW9ucVBJVU9yR2VKRnJQdEhscThK?=
 =?utf-8?B?YldEdUhqU2lFVWp4Z2piT3ZDelNub2RvVGZxM1FES3RZcnVBL3FPbStncEJk?=
 =?utf-8?B?ZGtLZUVpTGFXekdmbEpLWkoxODNYWmVhdUZQazBzLzkxM1B5NllwK2t1Nkp5?=
 =?utf-8?B?eWNYMTVuMDlKRG1pNDVmN1VxcWNGdkJkQU50WjNIU1A3NVBpcU5majJ6c0lj?=
 =?utf-8?B?QUlaV2dQQngvQjgxeitSTzArNnNWT0FKRWpkeEt5QlJIa0x5Zk9pY0lVMTVj?=
 =?utf-8?B?RGJlQm00NXhaZzA3OXpWLzZUZTZ4QTBmeDEzNGIrYjFCT1ZGUWxESHRLSmVt?=
 =?utf-8?B?ZGREUkhkeWpvZ2dhMTUvMUd4N1I1ZWMyY1U1MWF2NkF3RkFRRTFjUzZHa2tH?=
 =?utf-8?B?N2h2UUdFV0hRUUVwLzc0MHNKMzVWYUN1RVVoaVdjZW0xMnBwVjBLZ3RrbVFZ?=
 =?utf-8?B?VnQ3Q0VjNjhqTkF5OVA4c2d4ZVJMcG4wdnNpa0JaTzZXMzg4V2FPNjlCT29J?=
 =?utf-8?B?VGltcmNsTERVNTZETE9TeEljV3NOUThFWW4yM1ZWdTY5eEt3YTJqZVZScFQ4?=
 =?utf-8?B?ajhwaEc4YUpLWVJCazhhakJIRWVtZjZpV2xabGNyemZuaktjeDlHOXlsYTZt?=
 =?utf-8?B?eXhGS3Rqc0gzNml4SW96c1cvckNlTE5NME9OcHh3Q0p2THUzMGN4eGdmejZO?=
 =?utf-8?B?eWxQZUppNFArbzZVMjc0R1pTcmwycDdSSXF0cU5NNnNTditpUGIwV3JTQlV0?=
 =?utf-8?B?TVB0aUFLUFc0Njh1Nm9GME1wQ0NTakFqOVBTaGZSdWtHUkE0elFQMjQwblFz?=
 =?utf-8?B?eEptY2RNcEZ4YnNtaDZOVU5EQ1ZiZXprNTJnU3ZXYmVjL04xZ0xCU0ZibG9X?=
 =?utf-8?B?SEV3c1RJQmtHZTZpZEJYYmU1YnFsRGZ6aHF1c3MvSWQvQUp2dlN2dUhkaWRI?=
 =?utf-8?B?RHRVbkU0QXZSZjNVSDZmSXd0a2E3Nmd1ZkRoS3Vna2dDMXJ4bzdJN0lLT2RS?=
 =?utf-8?B?enFjV1ZVeHBHSDRUMTJmN0s4UEJSekc2VVdXRFgzUTB1YjVMZkdpWTNETW9G?=
 =?utf-8?B?M3h6SVc1YVliblM2VmVxZnZqa2EzTXRrdTh4ODNhK3Z6eVZ6UFJhdzFZZmtq?=
 =?utf-8?B?NnZwcFhlWExCaWp4Q3pueFMrUXZ0MnpYTkg2bkozU2pDdlJNSjJDNjZoZkNK?=
 =?utf-8?B?cmhzTFhPdmFqYTgyalY5YVJBRllVVnB4VjRlTFhxS0FIdEwzdHA0T3B6OGYw?=
 =?utf-8?Q?c467LDDyGFh5oDtBa8swqmgZA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mJxxtkOQGYbKyQXLhs6gNOkAt7GEvLxMGKFEyL+bLp/cb+csA+1SNaWEBrNGrkTqRIdXo5Cd0KnvA7u+BApX5XOHHNeZfaihvGKubtj1l0r8aM3KoJtyPE8Z8AHlEAPNaIpt/LdNmaSe0toFWFF3YfaiVVdo9Dz6hNtrbvulJbFtqG3rfvCQDPwoTWPi1KlvexZ26QZ8z9+PsKoYBIfGZBHKzGX+aCoB9oDYfoKiYJVUpJYVbpo04dev8bpW808H2NULPgZxIj1VC1Pmigaxy6VU+nEgRVwd1BTGKPgEoI29f8KjC2jCTM8l4iuG0YwPGKrNs7os9jNcbO2wIkqVgvc9PATLId2IeSp0Aop7brjNpfB3SNiCsb/ZFQrl+ka30E7YBbBjeE3gXyc3+BEzFtE2cx1NxGy+vk2nfXqbv3yLiOrxrWV8kvno4U1TL23PdKQUJanvFWWL4sV6rxe+NqhMzHLD8Zf7LdDRy5F+WmKIkXpi87rGvQ7bNCHZ5A/e+ijblyo24zVLxpLFdM1pI9j/rfr+jc+hpQMNchBKgtiQZWHZ/awNf9zm+z7CTk0F7npnMYIVn8nZ+KfOax2hjnfhyv8q1YGcNkfzqRZrp8VvItKyxqjmyPmdQIJNmRgSuBYh9nrjDhSsKR+EnDJ3Q9f9CDJjkSQKtMwknc4pBVou40as+OJGqByEFdWoYfJ9J9JBk3ZaARpg0jXRfG2mQZh9Z3u3l3e/Kysh4sF7aJe1bpqzJgwH5HE6lhWZehToR7GX4jKQEONb/01lEMGX7GS7JlOlBI6B3/cymBjJAmdFAvCT+6XmKnr4CetKE9XtKlO0KDGcvKc/KmMwQSf8+IeczZZDSxMvAlOvkgFfCCk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55574ca7-5738-4177-954e-08db25fcbe8b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 08:59:26.5923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uD/mcLkDrquKyfXE26f17L3Vy/7GTiQWlSz5gnEnMj5hgQgNaBqtXps8pS0C+Z3KB9AtFaFGV64xqJutIcfZSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7216
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303160076
X-Proofpoint-ORIG-GUID: 2QzUTeuFRf51VfHZ9zRTIjtQrIyRIIRV
X-Proofpoint-GUID: 2QzUTeuFRf51VfHZ9zRTIjtQrIyRIIRV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/15/23 00:51, Christoph Hellwig wrote:
> Adding pages to a bio has nothing to do with the sector.  Move the
> assignment to the two callers in preparation for cleaning up
> btrfs_add_compressed_bio_pages.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>


