Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBC070DA66
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbjEWKXf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236551AbjEWKX3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:23:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E457109
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:23:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6E82m024626;
        Tue, 23 May 2023 10:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=NAb5P1SKAgWVAMWvJnd6ZbyK77idHXSDbAaWrzoMynDtTg6NmHqV3SDecks7BRky/m8O
 6Qo/lDiCH3rhnh0WTq0r1DZuSvAl889bSfW9ibB5/paNBboli+MBTrKZrJpKJV0ZeCHr
 Kvu6ioN9y0s43QLunIu/y3miY5g5forxNGsTFO4XtS+w7ykfKkYmtBXyk9osZFrCa5Kn
 Ai6Zew0NCnEs7tZbL1BIxCgmgQq9BTXehfGELa1mC95Oznp1LVSnIIHxX79NFsVR9F6a
 O0ucDwT0+c4W0Mb0b3jokAr7ZhrzcWIbfNJXFOHqNBfVocei2tz0MEJNEcnRQBDkQwSA 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp7yvrmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 10:23:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N9BdSk028913;
        Tue, 23 May 2023 10:23:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2amve0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 10:23:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgEA+WtiKiI0Bc+zKuf7MQ6sQZxuXc8RT+x5W4vumhCuCXX/YDM2wU98YZBc6UDG6bmFP+ST/bpIh4u9fn2+l/5VSV/YV2u1mxYzXmgFe+/HVRA9oHpGpmBCIHIzej4uDQ4WHoFR/7UxkYWmGUu4KjBvDYv36BRTMFLefZS08xUwD1TPNsG+JVR7XYdql1XKa1aI7KIr2xUBjmxp+EHLhb1gToemgbTO90l5ziD22/jaGCD3Rww73xIlZfkmPsUt3DplQZ0CY20qqcgUDxNNqR3S0qxO0BYRh9LzCwoy6bxC7xZuw9Ny7sPwryRzQChN5biDbfnHeIX+4PwFGVG/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=kyHHgsCSlPadCrXPGD8gnkDyF4hcd7yz0VWRXDZ+M8H6yJIToOtSRyXwsgP8MBrbSOputAnqI07KwAGiC/i4lsjSm5Koq56TtXO3dr8VHVelkEGr0N4SDTqCUP+Sq1eaLCKaTXLxQkW2klR6aoiYlgGawnhw+opEk3MV2k4o01aTgz+ihM2e8o6YcvHy9VqxxGSsMEmll7W0cOtRl/WXY7cKcV6RPlk/2onb4YWfESuTfdbbNI6yXyar3uMb51lQCx1eOZLf9sEBYg9sm2A10XK8euTbcLpc1SNkuLSKKSWmrKT+8QZClACkx8kyVmx1awYYuvOZ0t3zEMaf/jiMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=cSmyDblWVY/x3rzvSE8PI8IU27v/+M7Ml4pE76iH80ckSSIA40OQThgWYM5cUt/5XhGubE1UvxRLEecpAaaN0RYYUEpaNJ17sPgipBPzORjMZfczJ0ez/h95P3Zu+obaowMydrOzj6zI0va0JAw/Le+h38FjVG2kXy2X1x/TVpw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ2PR10MB7110.namprd10.prod.outlook.com (2603:10b6:a03:4cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:23:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:23:18 +0000
Message-ID: <3e058875-1af3-881a-7577-115bacaa24f5@oracle.com>
Date:   Tue, 23 May 2023 18:23:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 06/16] btrfs: rename cow_file_range_async to
 run_delalloc_compressed
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230523081322.331337-1-hch@lst.de>
 <20230523081322.331337-7-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230523081322.331337-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ2PR10MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: c411e9bb-8754-499f-3ebe-08db5b77b9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95ZjDxUmvGMdmAVqhlaqTjqnvfIxU+sopQyN4QU5GbpSLYNtlHVF6DlXztUvfBU7wYoO9I/darjJp6Rfe6AKaXG+kpWJrLIggtgm0Pk82OcXyU76Eev/3iHkOD4551bJlePmFUMMAE4xwEeQaf/g98aAF3jM6pu7CbiWr4tnMkE15xIYcdoPdXq4OUCGNh+yf7+FyfQr3QMB/4dF9nq8WgkTDdsyR5SxomNZg8RXyFQ8xlRchhHgkxEfRBD/1rWVet0za0invvnCLzxmiAAUSjesjZkxFdrmAPGrFXvHPEELmyosydtNwuqcgmDletyldq8c6yRXeR1F1UYhK4fpKN78j21u0YL2zbuqalLoKWI7+/Rl7gJBOPB7qZ7x2nipVCvU5nDGHuIoYLPTSOewlZEwk00djouAGs64ekc6F0ksQnzpmTy/JWuvqctOddYGBWN2Ygct/5hTGo7PAydLTMKlMgB0iGN49DcJtWbMOHWlN3Ijylt8hFWoQqUQMudwPYurugMRDeeqjzi3Hebg/vWENu8nGJgl9cUjB9pLpRvJf6E4l/xqiiFnBgCO+R5kc9qfXq3CpTS5GhNftnNOMtKMZ8O55uanduP/E53QiSnfpuT6AF4q/ODkrzGrGYI5Dy3tbX0Xm6ni7Z5em5M0kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(38100700002)(478600001)(4326008)(66946007)(66476007)(66556008)(31686004)(110136005)(6666004)(6486002)(316002)(41300700001)(2616005)(86362001)(19618925003)(31696002)(8936002)(5660300002)(8676002)(36756003)(4270600006)(558084003)(44832011)(186003)(26005)(6506007)(6512007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckVyTndFNUdtT3FCS2ZVNnJFaHc4Qmk5Sm1BUk8xcWNtOENXRGRGWll0WU0z?=
 =?utf-8?B?RGd4OUJ4UGpoMTVCcHVCU05leGZCK1hjYS94ZVJYVjQ5d0hYUnVqNlVzRmNw?=
 =?utf-8?B?VUE3WVoxS2tRWFdMTWljUUVxSnZEaDg2VnZoUkZiR3JoUWF3azdCV1crL0RD?=
 =?utf-8?B?dzZWMTArV1F5SGlLYXBkd3YvcmVsZERIa0Y1TGNtL1BzMFZJcHFHRENTa3pn?=
 =?utf-8?B?ZXFzVlYvN2Q1QkZxN3RhRENrcUZLcWVmdkdZUUZDVDRWbDVRNEhxcCtBU0ZD?=
 =?utf-8?B?ZC9YNTVIYkd6TW1pdUNxWktmRG5veXZaM0J0WC9BSzE5eHdVM3V1S2dDZnhy?=
 =?utf-8?B?eXNFRHBoNUlhdEJ1dkYvOGFCMWNlTmVmUjY5OG9vK1BSYm9vKzE1MEczTGpv?=
 =?utf-8?B?ZG1KUEFiYjJRZmo0NnZhd1VCZmJuSXVqQ3Q4QnZDMENwdXVTWWRJd3lmV3dk?=
 =?utf-8?B?YXFkSmN3VGVTaVRRbnhHV3EvaENBenJocFJaTHFyMG1WYytMK2p2ek9PUE96?=
 =?utf-8?B?d0dvcThkVzIxZ0t1alJhUXB6d0VPcnFiZURKTk5QbldwQUIvTjZwdlBacW1G?=
 =?utf-8?B?Q21jcU94ZzhYQUZJVnBSVVkwQ0NYYWhnRS9LMTZJR0RjM3Y3aTNRZnUxVVRn?=
 =?utf-8?B?R0ZWNzdoc2tNTmVPeUpRb0p2d3Y2Ukh6alczR2d0NU11WGo1N0dKbmhzanBo?=
 =?utf-8?B?d3FOSzRuREcydFFreGhkUGxZNWxBbFl6cnZYUFBKa0QwSXdFdUpnc1ROUlVK?=
 =?utf-8?B?MmlXYlp0bi9YaU1iWlF5cFV2Z2U3KzhOUzVON0tmZXM5U0tMSDVjSnhOdEF5?=
 =?utf-8?B?NjlYTW93dnNwWnJrbHc5N2ZvUmcxd2FVZU9ESDVWVE8wQkxhSlc0d0kzMUl6?=
 =?utf-8?B?cTFMaUU4L0s5NEwxYi9XNEJPMVJpWmM5ekJmRzBiaW1XMVhmMmNDczhYUjBX?=
 =?utf-8?B?LzYrWHM3Ri92WjJBengyUWtyM25zeHdId2hCdDlJTVVZUk1VdWZDR1c1Y29j?=
 =?utf-8?B?NVJsRXgrT2tLK1NHb2RSdE5mQy9uaTFzT1F1U01Ia2YrVEFGdmVvMENKK3Za?=
 =?utf-8?B?N29tT1Rxd2FOSVlJWnhLYXMySWFzZ3R5THVVNWwrNVFmVmRXeGptN0VBZlR3?=
 =?utf-8?B?RlloM1lrQnNQR2llMmRNUWR3ZnY2WlpyektHZTIzM1hadGNCOG15QkpFdHlx?=
 =?utf-8?B?L2ZyY2R1Y1grRlNpT2R2SWdpNU82RzYvR2xSaHpGZTlKeE1QV00vTnNYNzd1?=
 =?utf-8?B?SWExNkc3cGhmaUlYRUw1TlliYzVVZ05CY2MzTGk3K1ZOUVpmenBHTm9Wamo5?=
 =?utf-8?B?NnpEWFl4VHgxUjRrQzNIZUY5bWs1VUZ5U2ZrUGdtNG5tbjNOd0t6cEJ1ZmU2?=
 =?utf-8?B?RHlrK0RTUzMraWY3Z2JLeTE4OTlqL3ZaQ1lSanVvV1ViNDBzNkFlWm1HL1Vh?=
 =?utf-8?B?cVlqS2lnTHhMN1IzRFBPQlZrNDRuV0xiSjFhSVE2MEdmQzBWNER1OGdtSERF?=
 =?utf-8?B?VVQ1eGI3OStBYVJjUTBvemhKcmZGVG40Ny9NQUNqMjlUYVpMUTEwL2o5eXJD?=
 =?utf-8?B?QTRZWlphVkdYT3JlSkt3dW0wbXQ1eUxkUTZLYm1zWnFJeFlsRVpPSmxUMnZM?=
 =?utf-8?B?L011eHlXczIzOGE3MjJ2SXNBL0Z1QnI2Ui91R2poMnZBa2VlM2dJMjR4TVFY?=
 =?utf-8?B?L09lb0loalJqSjdGU2lDMlBhV2hzMFJRMmp3R0Uxb3Y5L1Z4WHhIWlpaWVRR?=
 =?utf-8?B?SWNSOFd6YnZKMGdnQ09SQjFqbHBiaXhETThCNnlVdVVqNmdPb3k1M0RnQWdO?=
 =?utf-8?B?cjF6VVAvYzBuOUdpZEwweFg0bExIOHM2dDZaUnpTUHV0ZzRzdjVvekNiTEdI?=
 =?utf-8?B?T0lVRkVSL3VLa2V0NEdYbC90MVpOZ3FxeExQZjNPcE43TzZLMVU5QTY3NmZI?=
 =?utf-8?B?L1JVSUpaTDhvVy9INEt6amFQQmowODRUZjIxTmIybnV6RVJQVWxZejdaSTBs?=
 =?utf-8?B?amdYRkFCaTJJQ0I3WUtzVWVPUy9YRG9mSzR1b251OW1SYit0NTVsalozYnU0?=
 =?utf-8?B?YmZ2TUE2eFR6SkszNVlFVEpkdGtOYURPeDR6di82L3M0NjBGNkNpME5qZDk3?=
 =?utf-8?B?c2dsNFZaVHlFUDFOQlh0RHpJVDRiV2F0ci9EbiswMzd5bk1qWUliU3hyaWwv?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I1aeG00uuahEaYlVHUDLzC/LM/AyNOC3oNJqGjr4Sr4AyJGLGWFL9q8sya8pC4O6SGsD8wgJquZ22uMWH+7HhMJRTBjCA1/lzNuDcN4/iRo7kksFHWg71kXvIZ6JAGDup99bufhj9MQp8wiOH9pOydJISuKmHEiSgctVwI5a7rkwPV9KvVAUsvmbf74rT+EbX4WFd+ojQ1YmCXDRaCQYLDIGx9AX2ijF37GU1NiflJTFxpeqQyWVUX0wZ18nFlMGzb+DPAp2KNXxslCU3bEJ1z+fpQ4FP0yrfAb3l65JCbzQfoKmXz4ms6dugChS6y6/BSlVV+r+OorqpGPo9hkF/I4g5M3tS6pBYjTyPKqkl3XJ029CQCq0PTHDbRotx2mmqc59vovoR8yEEK5vXT6ndKY3SfjoqjH5iuEYk2s9j8tPOSTp8B/lqei9thUxkSdG8CpeIhwt8ggWIxXgXLMOnL1P6iypczeGeBtPFQXuuznvn+MXlrKGYRgCrvICEqcoD4SogvpbQH678AENoaMxIKyq22srG3N1cqvm7Q6YpiBxwHGAcsT3V+Xu+H0uGnnJPmWYWCwjHRrXL+sZpMn42Kb7FWnAzD1PwAgoPOLxzyU6eE4YYVfUpfrNxkPzlYZ09TKCPj2SVI59cfuZy6RKm+NtjnS0yXIv5WITpRwq8lQLvijVtonUTzR7Bg0PDD+3YVfWF5UL66t8T3cpxQYHKSnVRTzjrS3aIRCwQ4WyHWiWKvTlRm9b+oiRrn61RiBtFn1hNbf94Bewy0ODGm87uquQNy92IEN8731/7U4Smz8cbUsMPqtl7sI9vEa57IyI93dLkoYhimowhojBnHGWgHEoQUzL7+zn2O3dc2wpmDU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c411e9bb-8754-499f-3ebe-08db5b77b9f3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:23:18.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8R0ccmWsgLu6eX55aa081XXJaC2KggouSA7AQ6/PuxqrODiUezkKvfIqeFAgUWLkI+yKyUZikYly494PQ+P9gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230084
X-Proofpoint-ORIG-GUID: XQRGO8rEuZreIxImb4f9zrE-dfQyyjAt
X-Proofpoint-GUID: XQRGO8rEuZreIxImb4f9zrE-dfQyyjAt
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>
