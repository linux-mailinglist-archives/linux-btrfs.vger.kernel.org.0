Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF96A682BE7
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Jan 2023 12:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjAaLyn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Jan 2023 06:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjAaLyk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Jan 2023 06:54:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1891E061
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Jan 2023 03:54:38 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V7xOZs012732;
        Tue, 31 Jan 2023 11:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=w9j1ysZelj8ooPluRqkaPi9eVkJ+ZsKaLqKF+aC5eFPAGdwV6O5iDpREqaTEtun1RogV
 YoW35+00sRCf6ktxCyYDVx3SWBtkfQea44CX5xh5qP2zAzvKzMoNKRR6DdhOLn8sIvKV
 y67Nw+nxdu5T/2FAlLU4NgVjizqMvsN+GDXGe9ILDAIaCrw1t9NiAT17K8VcyfYyI96e
 jKmj/xuFl8jsIGvK1VWcFIr9ZmugYHCmYPIFz87kKj4F7JPYYwgojmdh0oF5p9l3f7CB
 zBryoHWhmBW9175a6mZJhvZopxk7nEKVpTekFV5AIzZSBQrbs7K+sEEcy1eak1i9Leu9 pw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvp15bjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 11:54:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VB0aJC020475;
        Tue, 31 Jan 2023 11:54:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5cb23q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 11:54:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzVcUQJyPq37Wi4XOTqewguUIKsCUODpEiubu9JGZJd54LabIUQvHz4JwZaR82lJ+ZZdGaxYAM/qQPzR8Fe53JKVo1OtDn6YanLkHaa8ujuAxYmJTcwSETwTPgFPn7TRLitLS6jjpidH7X2osX4Oy66AkfMdisv6gVvWozme31lZGL++1t3AJk07gZe7CU7Cn27XTMtBDkINB4HbqjhTbBZiTd8cEqW7GGvL1FtQMgHj0hyXwYcikjo8uBqzgBORynq6AJzkwlWR6wpKmXcvb2/RXOI6ePS5qWmoj7OLDinQODQECqet+19uLrHB3MfOnXELArPKBhNAiLFRyxeYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=NoQgFVzZaKNyo+bPnp6bOjqfkqAeYUdtHZuBivc/62i3nXEerymBxLitbeu9uhuciPF2JvVHUbpujaAN6Qh78pBw67etd/aQqmF1HbFJ3ohgatUNKPfq4EqDRP+3K0WnpjL4uT4oIi3N/4bqYna3BX4Eh84YXsG33w8CJQedaWsFag3virXKVcHCqW5tOUJpIevVkz1qkS2rBJhWDLxDDLW7KfqsXdiFL4tnxpGyYWbMR/58GdQ/81pajpBFegu7bEagPoSJUtqk5bKki7HvZdo3j+pkDz4Eu1FDsKxrHLUFT/YyqJho/hIPITUb9ykubxJNat6hlZlzgiVoW+kL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCCdixEvSWZoQv6sIEGfuTk2XXZEW16s0lJXr/2ZHIs=;
 b=ZlOujZvHTFKO5xPB5jITWAX8pcBwb9bYLPBP32FacnVn02NPg7fMV2GVJXkqUFcRpCcUhwDnH4oSi4a+x24lUO6T997TCOzRg5edRVsF8pWZjc/N8ybHahu3nn9r58RVNOUZJu4LALZDRVDyEglnCAit2Hx9/wQWa4QpqAfEUT8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6324.namprd10.prod.outlook.com (2603:10b6:303:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.17; Tue, 31 Jan
 2023 11:54:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6064.021; Tue, 31 Jan 2023
 11:54:31 +0000
Message-ID: <58ab08a3-6b36-e5d6-1d03-1727c7a273bb@oracle.com>
Date:   Tue, 31 Jan 2023 19:54:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 1/3] btrfs: simplify the @bioc argument for
 handle_ops_on_dev_replace()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1674893735.git.wqu@suse.com>
 <92276451bbeed279f8c04bc9ce684f42a25cfc92.1674893735.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <92276451bbeed279f8c04bc9ce684f42a25cfc92.1674893735.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: f65a93f3-29d7-4e50-ca93-08db0381e9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2PeRHApPofib687MxxD85TzE2m/CI3FaNaTuRvoUwrGYIDDsUHwAEg0W9al6gMKx4MWnlo8CRpnja/e5T4zk5QaUzIJKx5/U7vCU2hTMvT0nRdC+h+uADpc6FLAD+oYd/4JqRogOghNnWjKT3F679QIO6K65uVVZZQImjXDEa0GgeU73ybyHr8VOJnhJtM0PJcfzJwzmbMnjuMyMQJIopYHetziPBrJR1GIcYhBYTFTnh8clNAKWMFd4/NGARl1D58DRXobsMGmwKmmmiH5SgBSwX9tGvgdbEp04WfpGhHw1QUrFpBxUfNtsAWBOgTu8uAmMxXKER+AnXBgdkl2rCwyNA7pok1qc0BEOFE9zK5ir2d0kiTIbHF9qVrtEiMrtw6iFKDjTgAtqY1Dd+/rU4of+2hwX0UvQyuMnAAulXqw/GezKHPDrIkMAg2Bewj7SxFXa1MsIZetvrNOHGMmrnPoCcvP841KkIQlV3hmKjBRAtibdUAa3UqJJZoXgEqqeNr5vLB2YWkPc69QstEZLApXwgj8/KJRY/J468WOsyt/w5tJhc4Qjc1+uNRKrjFqjQtPCiRxp6GYhLPd0otczigE6+3OLH0F/p2XSp+d02xfH2iU1B3SqvNAIjTRpkJKsyLyi4pUrWFh867/cIuBxRxrHtHvVQKCEXzm7nJzUo17OJ/wuTXPJq9jWIqSlWhw76jbuRGsKMtdE+MdA5NUWKEBVkH6Q5l1La/UqU1JvZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199018)(36756003)(19618925003)(2906002)(558084003)(6486002)(44832011)(6506007)(66946007)(2616005)(478600001)(6512007)(6666004)(31696002)(316002)(41300700001)(8676002)(66556008)(86362001)(38100700002)(5660300002)(26005)(66476007)(8936002)(186003)(4270600006)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEoyZzJmMXQvU3ExQlZqOXM5eE5XakVLYUxYSzJxYjdqdHZSMFBYdTVHUjVp?=
 =?utf-8?B?SEdHTll1OWxQUFVTSldWMnpJcjM2Z1RyaWJMbUpsbEdBTzc0VUt5OUpOcko4?=
 =?utf-8?B?K1E4ZHBPTlo2M0hXcWdNWXVnM0RqRHVnUlNQMHBsZ0hEa3o1dGd5UjZPYUd2?=
 =?utf-8?B?T2JPOWlwdy84UmpVSU9WeUg3dU1IQ3ZmM1RTQUYyV3g1ck9sN0M2SEJMWnpv?=
 =?utf-8?B?aGZQMktrSDhROEh6eVgrdDBlbTlkRzBNT3dOc3ZFMG9UUG1ucUtuKzc2SHZj?=
 =?utf-8?B?d0xldjBWdWZ0N2dsL0ZNMHZWMVRnZStTS2ZQSGE4aVpOSDh1N3lGb0ZrNnNG?=
 =?utf-8?B?QVJmRmFoODBmb1RZWXFJc1BEUUZCNDVabDdhMUFVa1cvbVJia284aGJuUnVt?=
 =?utf-8?B?RElCaHdYWjBsRG1JZnpPSjhGZEM2enVTRlRHTzlQWjg3RXB5L3RQclZmSUtk?=
 =?utf-8?B?VVk3MmV1cGdXbVRUTWR3NmZWUlEzTVFPakZYbG4yQkVqcjNKSmpiVXVFVW1W?=
 =?utf-8?B?U0dpbk81U1loRzZ6NEdNSmpzZk8rU2UwYkhVbzBGRTZvOWtHb2E1MkpYa0pF?=
 =?utf-8?B?RDNpU0todjUxbFZVemFZK3hJbzdxK0Vwck9hQ1dzWmRVNTVrUlNOdGxMbXM2?=
 =?utf-8?B?bElaWHNNYlIyVnpZZVRrNEk1Y1RJNUNKU29LbFQwZzVrQWFBdU9WOWhwUzZq?=
 =?utf-8?B?c2tpa1pFTFd4VFR3Wmh4SEJZZzJqU1BRazNJUVFhS2JFbHhUUk9kbzMrbHhB?=
 =?utf-8?B?amZHNFhVS0JQWVFzN215ZWpOWlNCTUJwVjZ0ZjhkZHViT1JuOCtPQXplSHRE?=
 =?utf-8?B?Tnk1TU9OVUdLZkY5OTh1OXgzbU1RQlBoYXFvTnEzVWVLVllRUEoxYk1tZHRn?=
 =?utf-8?B?RFZwcVlmVnRqdUp2cktqZlkxRGxadzVuL1JhaUVNeGNEejZZQVJLSGU5RmVo?=
 =?utf-8?B?SzZPSUxpUjY4Q1BzNXdnemoyRWVnQnRramsyUkU3U3pIc1owelV6cFhSMmdM?=
 =?utf-8?B?UXpQaExESUc0cSticFl1Sk5zK1B4RE5JUmdXTG5ZdDNHSWF6b3BRdVM0cFls?=
 =?utf-8?B?VzMvYWVKbW55UmJBM3J0RStZT2hlL3RMMWQ0akMvMGFqbnlsYU9uQjNSd2lN?=
 =?utf-8?B?R2RKMzdtZ1RlK2pac2NwaXVMTlZzNHFHUkZwTmNZeGd6bWxHd3M5ZFNmSXlH?=
 =?utf-8?B?OFVGQ1FNQ1o1UzJONnBPNVR5S2YrY3kwcTRGSFNUbEh5R3Z6QVVPMmNUNVpr?=
 =?utf-8?B?SGVEMFZXekhyRUI3MWNhTkVvMkVoazdwZDBkRnNTRTlyVVFaTk5jS1pFdVNt?=
 =?utf-8?B?Mm5qaXZCN0xTSzEzNFZ6QmtlZmtCK0NDTUFENVFtZ0k5MC9XWmF6MXlrSldC?=
 =?utf-8?B?VzdwSWhickc1THpOWEJlTDY2U0R2UGNOTGc2R3ZQcW91cndPeklJcXZqb2RS?=
 =?utf-8?B?V1dMZVNjMVpBbG1mcnBsd2ZvWEc4Yk5YTmdhTWNSS2JSYnRtSElpQkdscG91?=
 =?utf-8?B?THA0bGJhWllZSlFlM2V0dFlBS2drYXNMd2txVHcyYkZyY2tNWjRwTjZzbmV1?=
 =?utf-8?B?RUdpNzIvUVMwRERCTnpMZXd2bmhSK3VHSDBKYnNKWmc2VkhVbFNxOGdUVTV6?=
 =?utf-8?B?RERvRzlVSlp4d1g0dDNQd2NJTmRGVmoxM21nSEV3OHEwckt1OEhyV0oyYWJa?=
 =?utf-8?B?bHE3THhkdkVLbjRMSFdudjd5N1VsMVhVVzBTWkkwdUR2VERINGZtSFVDMVZv?=
 =?utf-8?B?dHdwQ3lSZ3RPenVMQTdJNmwvVExpa3NLV0JVVmNFY21mYkdlOFVrdDFOVGk0?=
 =?utf-8?B?OW90MGRBSUQzVUxXZkt2Z3BYS3k1RjBwOHBNbjlZZ3IrSmpyd3ZXYjd1Q2Za?=
 =?utf-8?B?VUYrWTZDSkNINnFtbVBWaE00eGNFRVduUDl0VXFaMklnT0I2b1c3blRhY0Zq?=
 =?utf-8?B?SElGMi81ZXhuWmk5ZmNEeXgvYTd1NldyUERha1NkMXBycyt2ZXhHUjhBenFs?=
 =?utf-8?B?Y2dRems5YjU2cTRoNC84Y2h4TUhvRXdWSUYxa05qS3JTNjIrY3ZlaUF6aGVs?=
 =?utf-8?B?TWdEREk3T1hnQzRtYWR4dzRWb1ZvYURFL2MzbU9XYWI5S2xXRDlDZ2dGVmhQ?=
 =?utf-8?Q?xY/e2+bjXJ7VnrgMHGT3taLT2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WrtaSFS8AKh6aji3RvVI7vo31yNlSVuFhzEIrMZIQVe7IOT/ngodMtAZ4L703uapch212JQIHELEorQN1YMop+d0oLTjaiSWPOtiIiuYPid3WDJShbC/2M+QH0OYidwBjBWfRZa6oW1FTcXGUn5fiWcS3X9EJapdfa7U2zSpEToe6ZYHHnxHnh4xC6emKpbx9x/6pMMCPAhL1FpUnAn0cjsQK//RbfXVj7/+lMhqrCK+FGinc+vmItTfMnatGWakhKWdFVqmHzTWqz/zRRMvufNZF7CAweDuNIlTNd5TR8ySkmMsFF6RPRZ/pqSCLOY5M5SP9FsmskSYOVvbyP+uzmDE+Co3xZnsFs0vZK+L+KkuReQx5KCNpcRnV8+IzcRN+ov268aDO2EYTWmApPrei79hxqnxijrcE+n0LRMAW2yb2mJVf2v36OXSCqESiPBOdOOn7/GA+oN03P2OCGjUWZmFiwAxxwGJ0DtQQIRZp8iu22HDbpM/NvD60upyVuJBTRtEse3cOcLuPKl4Vpa5GNJXUcpcwKV+BV8JHe1REOat86YMs9bDtib1u/XhAt87JmAYTgbyAGpllLfIUGSNCd75ctFL0KZV6juAVgHc9UpXZk8+g+8KxF1JaikrUw0tXNKqnPHZU+L/sp56xEa8xqTt5UD4J+qCoMGW0hpKYmq5B1XBl3R4IupiaqqvFMUCq9jbmxiVz8H3GjlEilJVZNI6oLBsX+B2hf6/rfpvZ7AVBqMOF5Zsj9k3tFoCzQztjvesUP9OFAOjRz0giCP42HA4qIVcxsh2tqG6GfxX0OQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65a93f3-29d7-4e50-ca93-08db0381e9c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 11:54:31.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0r2syA+QpXsKKd7ipsKOGBvsXY52wpKm8wHOBjbbUErRoIvzasVYe58nCY3rbUruqEvIW8z3r9QuCIKJAP/Waw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_07,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310105
X-Proofpoint-GUID: K0vziY3-5RHaxRLF_umgu8_LKwjHQyi3
X-Proofpoint-ORIG-GUID: K0vziY3-5RHaxRLF_umgu8_LKwjHQyi3
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

