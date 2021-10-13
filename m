Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6510B42B958
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 09:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbhJMHlY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 03:41:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57688 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238509AbhJMHlX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 03:41:23 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19D7O81u010769;
        Wed, 13 Oct 2021 07:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=3x6DN+0NQ++BnNy07GOsJHVOdjQJlif6M1kmTJHXSRU=;
 b=Ai35w5IHdgu9odY53tfHzOJVKHuce0gI5Ewll8fBcB+VYbOC4FUj0Y96KZxk+bIA4usb
 mYhH7RoMMqfEYswGpYDk4msraEJzhTlWLHQpYlPEzjUkvld40T2zMEUy5iCu1+NmOO80
 GXqeIFCHllPS8vn3ILo1NVxfblLWPoAED++DOK6sqZi9Zyx2pipjv4LvP9Tp6gG2fptp
 IHaQ3FuHqKy4tV31h7OFtmwFNoiMkggLUJ0yWZsX1zsggpbrpZvV6NAbQ3Pt4/ipWv3h
 wEe7UO8mo7A9hF8FlP+zDuu2b/RmUycCJ1i0Ulqbmjr8UJVv9+ZwNM7vuXOx0pvEn6qP 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbk9yag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 07:39:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19D7Z8qm139929;
        Wed, 13 Oct 2021 07:39:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3030.oracle.com with ESMTP id 3bkyvaam3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 07:39:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7DfNVct7RCUx19xl7a0xqNHB/1JyiagPb7oH06uWQK4Ivy01YjPAnykCaIP2QuGgxAqdeSZ6k+SRRrkA5v851UkiI1Hw5CENTFYF5FKwCvrxTomcTOQYOBEjS43gDNEmXKsjw8Hi0cP41cFj9Gdwui5VcCmFcE0WZzq0yhq70vhB6Rn4HlnKw57bx6YwNtAA1e8U0AjYkAHjvZ9SwjadEq47nOQBSxkljKTyElaJmDgADdMfcjk/GNRGHJi6jvNVZfBh2Esh5L3glOl1seTpwmR8aet6okcOFLNkny2BGDUXywPPqtj+CNdPj4Rkt169qj4cN1fpLi2ITyoIZNwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3x6DN+0NQ++BnNy07GOsJHVOdjQJlif6M1kmTJHXSRU=;
 b=BPERT0d/isWG9yYAjQtu0Nihr1UlaXvmQNUorR12aejwgPk2y52TsZojG1amEOtpFrnF1PSiSjUQz6gLij/Lwt7OlDWUyp+5jLB73UeKtWOpbsEuiT8iEFaJBfEh/QL2dNSXql6mekfUy1jGRY2tAkdPbZnJrmMFNjSsxJyuSjPFQA7Vyn6RBF0CXCdtLalvIDqoCw4ZEOVqhltYGpqwtCo2fg6a1ruZzndmMm83Uu4LTNUoH2Hydv1Dtzq8TwqkUo+YvvtoAxi+/nySOcEvyaR+/kCo3e+/FEqiprpZPPQw4jD8ntQ3LfEHU8rRU77NpY3nSL6iblOg0Fkcz2n/yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3x6DN+0NQ++BnNy07GOsJHVOdjQJlif6M1kmTJHXSRU=;
 b=laWrfqhq8LSXO7Y7ka/rsERnU7rRrYvs9GvdTVGQe8ogfZG+gLvN3HGzJHXui1WIsZRP6QPp9qj+yE4HlRJij3+GJHuggZZrCpnVcG/wlJX808LNwBlJUXr7UIkViAvxxvaKhH2wD9gNzGPDD+n09G9uFozjOcG1kJGrlykhIME=
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4191.namprd10.prod.outlook.com (2603:10b6:208:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Wed, 13 Oct
 2021 07:39:14 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 07:39:14 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: perf/001
Message-ID: <d236c364-3bf6-d404-e3c4-2d82b7db6355@oracle.com>
Date:   Wed, 13 Oct 2021 15:39:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SGXP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 07:39:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a83f7d63-41a8-47d9-8044-08d98e1c8dc6
X-MS-TrafficTypeDiagnostic: MN2PR10MB4191:
X-Microsoft-Antispam-PRVS: <MN2PR10MB419171CBF395AD95C2C8944FE5B79@MN2PR10MB4191.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PrVDWrsIDbGXOo3n5n930gy8rdgPGj8mNiCgdeDenEkYHMV47sdP7ifQEAxasfknHOQqg7LDpNQK2kh/iMAcpnkDJe+52ppz3GLIKczURVQg+nPuY/k98u5fepMwTlH2QBceT5DcqL4Ur7gSEo1icW/tkIbHaA5X8LGwUmvl5MW3RimeFZ+vt2CfilEeVoaonqg/vLw8OWlBAj7bTFZTES9OmX/CZVaUO/SgeUij40+d3LZ8TfFCzFNdjzAWAKyofheHGrAXo0kZlPVZOcoQnSSuZUhdSgEH2gvnpBA6q/tn9mtjGnfYD7Dti2vZ48SJIQfrPEeog1HkAi3f1TX3OF+zctVVruUpwQ+RuXd2q10BGjF1/qVBjrFG9B+xl6pnviaIOM2vkLYkZw3GcD0iF5HS/yZiLBcWsbZHeLD7tWjCJjKadF63fmepSumYOXnA70mV+LvN4Pl2Pu7N2NfwWvh56rkg0X876IqMO9qxYxwX7sM59kY/aNZZGYo60PMhTkRtkzVDZgGXgOoydt998idEQevA038XaJ67go74QCu4uUWvSjKj97DTQwNhT1V5T236QT4pymRh1suejUykNnuEhAygvgwwMju1+M6NnM2jkfvSeZ5/TgYZKMoVouXsEyVQexUqch3kAo0RgWcoiD93CqUidkbSuiTEIuIcKpXHUZqCMgfWoIFOfo/T97KYpp1xIFJkQFCy/6EGCDG9a4E9ZATF3Rb9c7AyKfWQpxY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(110136005)(16576012)(8936002)(36756003)(31686004)(86362001)(38100700002)(31696002)(5660300002)(26005)(2616005)(44832011)(6486002)(186003)(956004)(8676002)(66946007)(66476007)(2906002)(66556008)(6666004)(4326008)(83380400001)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmE5NTJOWnZoMXZ2ajJlckpPbmdsdFZjSmNQMXNaSEJ3blFJTVBjV3JjSWl5?=
 =?utf-8?B?cDdOeXpNek9vN251RHkvQkFMaHg5RGpTbWdlZStaWlBMdnJTVWJPZlpRMlBT?=
 =?utf-8?B?czNSbWI1OUNITklzaUpCVUN2LzFvWHlHRExiRjFRblhkMm9vdHMwdVJIOTRH?=
 =?utf-8?B?NXdUZHRzTGQ1NjlmcUdXeW5hOC9ZcjRZWmtvQUdIejJFa1VaSmkzVDh0anNz?=
 =?utf-8?B?ei9TSWF1bHpPNTMrejBtZFFyNXJKVnhpZHRaeWI3OE5aR1lhYlhrZmI3eklw?=
 =?utf-8?B?QUZ6ZTd0RE9RSlRIVDZSdXd0K3hVVEJ0VndsTnhRUUtRMk9aaGJlNjFLUU9j?=
 =?utf-8?B?SWJFS3pSS2FTMkttVjFIZzE5eVRSdlBldy9mM1R1empycTczdlJBQy9GR0Jn?=
 =?utf-8?B?TFd5T1Y2Vlg5NnliRHRQUU9VdVhrM3VFNVVDSGNZVjFZZW5aVnVjSWc3U3ZK?=
 =?utf-8?B?QmV4cUpSRUU0V0pENVNRSE00ZkRCNEpZcjFvaXJJRmN0cDU1QkVRbFJSZndZ?=
 =?utf-8?B?ZElKS1I5Y0pkcHNhenVWR2FBKzJxdDQ5RFBXVmlYd0dqUHl3MURPUFp0RWVT?=
 =?utf-8?B?aW9XVHdNMlF5a1V0TXFkTUUxWkI5elRyUGRRRzErWU8xeEQzd0VORzF1NHFr?=
 =?utf-8?B?NlRJVG5Zdk84WENzSkFYMGVqcmhSRjlxT2FwRDFMTXNyYmFNdWNTR29Cdm1w?=
 =?utf-8?B?bTNFSUVhS1Z1bzVPdmZKOFJqZ3B0bHlMK1QyRVpma2tMY2VBWUpYVUdYRG9N?=
 =?utf-8?B?c2wxcjAzYXFab2p2dDByQzQ4WFAwSXlkS0RGMC8xa1BQWHgxZmh1ejdENjZX?=
 =?utf-8?B?RW5udU02TWo3YlFvUnJ5bTRaTkpobmVnT3FIbUNGWHd6akY5TE5XalRsbm0y?=
 =?utf-8?B?QXhwZm1MMHBwd1VxU0tWRnE0SHFnMkY4UCt4VExPMldnMlB2cllhSFBKamV2?=
 =?utf-8?B?ZnRwbFZjV3ZLMzU4Z1hPaW9XZTJZY0FPU2pMa0lYRzZmeExWS2hPbFlGR2kr?=
 =?utf-8?B?VEJkS1VmNFBld24zRjBwbk5XVW0rL3UvSGYraWMwSlJYSXZJcXBDYUJaRlVE?=
 =?utf-8?B?djRxbnJhZGdLN2ZtTm9MMlpwcnZwVEliMTQ0cDZBd2c3MEpRT2JIVWVJV3Uv?=
 =?utf-8?B?ZlpaeGNIWHo1RzJaR3RGekpGSGZCUU12TXZKQTBWenY5di9qN1hFdHBocmIz?=
 =?utf-8?B?RXBvZmtsQkZxSE9GSGhjTmpUTHVERkMyY3FZL2tUbjIrT2doMjZsZHpkU3pN?=
 =?utf-8?B?TnZjZ28wRWpvWjltZ2NENFNCbmtJT1lJWldLVUErMkZBWVBWdGJDWUhiTG5S?=
 =?utf-8?B?emV0bGI3OVRNd0RaTHFicWZQdTQrUUpTb252VSsvV0lYb2phMWQ0NEZWZVRn?=
 =?utf-8?B?VExyYnVQWFVwa2JCUTNudnFjTkJNeFRBSHhzUm5UZ2RycnViMUQ1ODd0NUps?=
 =?utf-8?B?MXd5eVQ5ZDJKV0hXdVo0cHJuREtTR0pnS1FaWjZXdGhmSVdlK1JybHVMeXlh?=
 =?utf-8?B?SUlwRDZQY1hTUTRBWjdudnA5MmI2VEFmU1Q2Z202TnUvSFFVWFN2SnlMeEhE?=
 =?utf-8?B?NHlNODlvN0VzMFZBUFZEOUVrT2pKYVliOEhFamFQaFBQSU5tNTR2TysyOWM4?=
 =?utf-8?B?OVB1TS8wL1JiWU9RK0lNRno5Q3U2U2lGWE1hajFjK3lGL2VBemNhb2t2L1NX?=
 =?utf-8?B?b2FtTlloKzJRQkRtUDIyK0hDK3ZQekVydG9SMWVKYk1jblV3V3NqM1FIcmRM?=
 =?utf-8?Q?QvpMvAhFpy5FChtVFpQefKQs6lnmWY10XE91CkN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83f7d63-41a8-47d9-8044-08d98e1c8dc6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 07:39:13.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udzKdOVt9aSVzpH2LC0wPzY5cB1LNXmk6tdPbiCatc7nksFLOsCTuLBuvxUXwdI1D+lysrLH2rimRIKCtZi2AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4191
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130050
X-Proofpoint-GUID: 8se6awj6Od0UiUmKIxb6aT2oy7t0AmwC
X-Proofpoint-ORIG-GUID: 8se6awj6Od0UiUmKIxb6aT2oy7t0AmwC
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


perf/001 fails to update the SQL with the key trim_bw_bytes.

Traceback (most recent call last):
   File "/xfstests-dev/src/perf/fio-insert-and-compare.py", line 31, in 
<module>
     result_data.insert_result(data)
   File "/xfstests-dev/src/perf/ResultData.py", line 45, in insert_result
     self._insert_obj('fio_jobs', job)
   File "/xfstests-dev/src/perf/ResultData.py", line 37, in _insert_obj
     cur.execute(cmd, tuple(values))
sqlite3.OperationalError: table fio_jobs has no column named trim_bw_bytes

I tried to add the missing keys (which are probably present only in the 
current version of the fio) as below, but the error is still the same. 
Any inputs, how to fix this?

diff --git a/src/perf/fio-results.sql b/src/perf/fio-results.sql
index 62e1464834b0..5d115764c4e9 100644
--- a/src/perf/fio-results.sql
+++ b/src/perf/fio-results.sql
@@ -8,6 +8,9 @@ CREATE TABLE IF NOT EXISTS `fio_runs` (
  CREATE TABLE IF NOT EXISTS `fio_jobs` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `run_id` int NOT NULL,
+  `trim_bw_bytes` int,
+  `read_bw_bytes` int,
+  `write_bw_bytes` int,
    `read_bw_dev` float,
    `trim_lat_ns_mean` float,
    `read_runtime` int,


Thanks, Anand
