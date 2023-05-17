Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C082B7063B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 11:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjEQJN4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 05:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjEQJNz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 05:13:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCDD40EA;
        Wed, 17 May 2023 02:13:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H6iAas017616;
        Wed, 17 May 2023 09:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6q9CugWN7PY+iIfIw2Bd9MdmJrAGX0cULNYrhl68xm0=;
 b=CX+NaeLJ9ZlXnE/pqqD9e2BDd0exhdyaiOYrwYkJRV7RK8Iki3jMQHaLpZ7M3CD3sMK3
 nDcpfMj05AjhNKhzrkFTsxbDnWEXpN8WAczTztgWCs4TkTm3jfsBlX8gryfPkrE5ZdnL
 yIlU96a6K5LMy+Pz83O/e56W0i+sEw0HwdWrqqKg1u8bLG+IBB2lzqO0aZFVlAqPzVy0
 2u74o9WdrbwPiheCExDnQmP0Xrp0hL//fvf054QW1+G0d5/w2QvekApKM8IkhfuJxyDy
 x16HlEENggF/2lcdZ2iJ0S8fFcEolcQ3by2npHzp82W9p0omI08L+kMw6iOSCl8WSqsT eQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj25u552g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 09:13:43 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34H7NQT0004182;
        Wed, 17 May 2023 09:13:35 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10bf4m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 09:13:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvIPtYbn3nMbbIZ9SPo5T+GgKx11YVg7sUsEqRfXEeM3mK0um//ggLePw0pZ0BfYCc35uyyADg7Z+2eukD+DEpgJZ+oYBuLSoZPfwaVt0453+z7B0CuWx7PsoIfsOCWWVbUrhtJBqrKnUVkyRws+r+XSUOF5eaXrJjoFactAsAYoSPB1+cZR0ODYqyWA8qP9uO3TMMx4zohBkuc+89rgYceN3veLecR+M5NDqG1fod+22jTOR63Y2IRujTIShqwzxl2xG19rHNvYS/uizB7kr1rGij/De4+MqXW4HLnSeyJLBnirtX746kxiV5Am4JDvOVvVulIJbBCXwkYLq6ggBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q9CugWN7PY+iIfIw2Bd9MdmJrAGX0cULNYrhl68xm0=;
 b=j8YmYE+WOGi7VzR2kc2UT8FwWChNIIwtKpJ74xvw8bMObGe2sGjLUecljyJxrcMS1a+r9FJaZ6528rJfzbAOQF05dEbQ51qAHUrEOr7e36LkxndB3c8uXjCair3MV4j9gltspvwTyOEedPJyY0F5ePrEIOBqPyqcoXsmo7VtTMK5c99aHcjT3JbYTouArZA1kr3BLOXTvN0m0U3KJAfRdFgfx5QrYzcEw2pI7hLJbslpNz54BTYZGmN0y6CbDvOL4bxj59oD9mVt/9acTvti2Jh+cCGHJ8oRD4OCIbLzvBNN21+vPHq/ccCC842Y97ozQxX7ZbCbKvGV/eaK46utBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q9CugWN7PY+iIfIw2Bd9MdmJrAGX0cULNYrhl68xm0=;
 b=NW0Ecg0+u2hE7OiiimyIMUk6jYKrq0nXTxyFrXQeSd5FVO5MshyM/RAIoHP7GKIVpKM2RrQEsGCl0u2A0iKYqUJpnGI7yYGmNxJb4jQYdp7elnFo9BpfBiKrR6u/VWRI1L5lmAEVftPNngCb6C8NJEhSzORpLkenAZCPjxMOfG4=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by CO1PR10MB4804.namprd10.prod.outlook.com (2603:10b6:303:90::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.31; Wed, 17 May
 2023 09:13:30 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::cc8e:8130:ef15:a31d]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::cc8e:8130:ef15:a31d%7]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 09:13:30 +0000
Message-ID: <28116d72-d3a6-540d-fea8-542dd5d5ca54@oracle.com>
Date:   Wed, 17 May 2023 17:13:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs: fix uninitialized warning in btrfs_log_inode
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        zhangshida <starzhangzsd@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
References: <20230516013430.2712449-1-zhangshida@kylinos.cn>
 <f90eb6c1-4491-ecd2-1fdd-56580088c993@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f90eb6c1-4491-ecd2-1fdd-56580088c993@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|CO1PR10MB4804:EE_
X-MS-Office365-Filtering-Correlation-Id: 47967f79-3da0-4514-bf22-08db56b6fb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fufifq/tjRZQBy75X/tDCbWoFjUATxzwTR8VnKlcahhmErmoXAZGyorcmdR8JnDphfAxxE/3ofMqE7MfJWiRGWIuPgJ4tCmrPBneCBxpP4l582E8YRW+fE4zyqICD5tGBSrv329u8iGdBDgVEJo1th+0o4AF6RL8IrM0XITecVsYViOsxmZqZxFXDrkV/BQZB87kONEdruNlXbDnxCqaXFfyIygxCmhrox2aKKpnZQO2dYct5+K6BoZ+PAJPFkVx30GBTycp10IH2yKi2lBy8sTvvQi/ZE4Q3BXHnWDDgUqq+Smw1GzAqFmZy64Z8UjeAqyu7vwIZSVyLYNhtZA1JsBz+bCzn624ajOgJJH/tD/haYGZy2LkvpNl8I1iGJDW5Qe7r+RgxpJjKrUjdVxJrbuLokmx+b3ReskCfb2XNXRQ0vxNBkaE459rKTNGf6uGnbTwS1gbjNROv2cMqYJEskeb9ggikP4ebLx+9OQUNOJcXJWZCOks/+ooNZ4iiRaRED3hRMo423ErPmFNwRC+M0zwMGCuoc1q+440RjhDtJQmSqoXzmbcr9e3rGTUQmAfiPh67l5FYbk5GpsErjgJx7d+8rhI9A1zMC57r+F8Gba0bq+AAwcVrVWJQEXF/vth0hB5Zpy2OriWJf0eVsZzvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(26005)(44832011)(38100700002)(6506007)(5660300002)(186003)(2616005)(83380400001)(53546011)(41300700001)(8936002)(8676002)(2906002)(6512007)(31696002)(6486002)(478600001)(66946007)(110136005)(66476007)(4326008)(36756003)(66556008)(6666004)(86362001)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1kvVURBTjhpcmRVdDNhNFlrcWl6ai9TUTNFSVNld1IwbU5FSXl3aHdpS0ZY?=
 =?utf-8?B?TUVGZldUT0RZWllyZC9DSFhpL2h1VlBrQW9pbFB4ZWNLMlRBbTJZYVViSHJV?=
 =?utf-8?B?TFMvMklpVXNraHROZG84WEp5eEIvMnBwMENIaXpFcXYwTktKMzF6WVBYVGNO?=
 =?utf-8?B?RGQwaDVHaVhWUSsraTFORUp0MExaaGtTa0l3ajl0aEI2RnM1TlRxaGJGRS8v?=
 =?utf-8?B?TVVPYWpsdWZpZkF0V29qbGxBemVmcC9rcU82aXpQQnpCcUtJMitkalNWL1RG?=
 =?utf-8?B?L0dKL2FzckM1cTJyS3gvZVhKMDNGMFZVQzdkbFhXVktQR0FQOEl5SWtEbVRh?=
 =?utf-8?B?dnJoNDFuQkQrc3UxRCtNM005UDNIcVk3bHRwTlJkK3Jydk02V1ZiSnhEQW9n?=
 =?utf-8?B?bW0yaHpGd1Y5aThvM2JuTXo3TEJSeW9oN3NjdWt3K2tUQjdqcnRjTk5oYnJP?=
 =?utf-8?B?eVJaNUQvQXFnbGljcVp0WU81R0xNbnNwRWlZdFpYQWtOTXp2R0tmZ1JnR05M?=
 =?utf-8?B?R2dNQk5Ka0o2eUR4T0pYdldDbW5HOWFYRjFVWnc1WjIySEUwQlB4TVhpd3RS?=
 =?utf-8?B?YXBHRVN5aytzUndQcHArSnliTG1vQU85MGVJS2l1ZEZvdExrbmhRd0FjVHhQ?=
 =?utf-8?B?MHh1ek5mRE14SG8yMUE4ODl1d1NHNlVXS2RwZVJjZlB3N2NOTVFvalZ4U0Fm?=
 =?utf-8?B?T3NTaTMyQktyaHVnY2dwT3VZaHZLdzJhMTZQc0FIellva3EycFNrajNUZUNs?=
 =?utf-8?B?ZVdZOEV1c2Joc1liUjR5WlZEZDJmblJBamZDdDRQTVlGMkEzZ1dJVmd2RFBK?=
 =?utf-8?B?Z3JqNkQrR0dmOXZRZXVIdHh6UkFxSHBhUjEvWjloMFRFU1lkeW5pRUVRVVMr?=
 =?utf-8?B?M3NaaktkQWFOUWtLSjR6N3Jmb3NoanM2blhKNW13MGh5TVlscHNrV3V1RXF2?=
 =?utf-8?B?TUo4V0lrNXFvNEQ4cHQ3aUhNcDZEemR0azMzdVZoUlp6R3ZRWkJFcTJ0MUMw?=
 =?utf-8?B?Wlg4QkFFTEpmMytDd2NGQ0J2ZExJbXpuUEE2UGRYQk1CTWE0ZVJxdVBqdjRP?=
 =?utf-8?B?RXFjMEljakhZanFuaFlWNGE1eXNsVTY0SzBPSzd5V2tzeGRyVzdWNy81WGpG?=
 =?utf-8?B?aG9CL01Ta3VKOFNVK3FIMFFhQXo3SUtqYTdpTzllZXNaeERlU09UblZZMlUz?=
 =?utf-8?B?UFM4QzhUcDJhYlJsQUE1TmpmakpZOGJUMkRNSWxMMkZ4TElhRGZFb1Nqbjdx?=
 =?utf-8?B?RXROTzMycURvS2ZLdS83aGJMWnpzY0V3a1NOZG1nUlp3eFhIQ2t2TVNNVFBR?=
 =?utf-8?B?cW9VTjZaOWI0NGZWZlFWeUF6TjladUVWQzZnMzRaQ2E3cFptV3hydkpibjhH?=
 =?utf-8?B?aEdBZ290VDN5WU5hVUx3a0dnOGNmM3g1TXVwZHovVWVsSFVXTzkwd2p6TENG?=
 =?utf-8?B?aHU4SmtOWHFLRi9ORG1kdlhTS21NeFJMSk5POGNHMUNJRzZYcEU4M3dHTVc1?=
 =?utf-8?B?K2RDNElscG9vL1lrYU02R1c3SFJWVWdCMGNqeWpIR1M5TThLMTFhOUNQVS9h?=
 =?utf-8?B?RVdCVHgyS3hVcWFvbm96THAvSDhmOE1VQnJPcDJvOFNvYnYxMXhSV2tRTzc0?=
 =?utf-8?B?RnRwYWFMV3QxaEVMUnNMSGQrV2ZEa3ZpMVVGUGZjSVd5MkRFaGFoNkVYV09K?=
 =?utf-8?B?OG1jNDlFcEJVR3A1eWRMS0YxL3FqK1ZRdWhmc1dEUHVBK09QYWxDeGJ5YkZm?=
 =?utf-8?B?VFp6ME5QZFcwZ29ieEthb0xrd0lqK0pTMmdlTkdhYmp2Tno3dmR0a3h0Y2s4?=
 =?utf-8?B?T2hVQmc3dE5VSUpBWXpTKzN0ZXluOG53OVdTaE5Zcy9UZHZOc0x0cHdDQlJY?=
 =?utf-8?B?MFljS2tjSlRkdmUxWmNnL3FFZmpycFFXeTZzamVLVWVpUmh0QjMvSWdpd0JJ?=
 =?utf-8?B?SDRkaWdDR0duWmlFR3hWUkJwNFhqaDhGYmtTbGhpcGNXRFBRWTJCaG1QYitN?=
 =?utf-8?B?N28vS042T2NVcng2dUtLTHg2cVhVeVZleFlERlZ6RzVVaXpqa3lKelFFSGZj?=
 =?utf-8?B?R0UzTHNHbjE5REwydXZqOWxwb2RsUDZnMXowL01DWWl1U1R3cVc1ekRtZmpF?=
 =?utf-8?Q?MC8NhSJuGqa/3b/r6on4o27UJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iqVira81I4qGcJd6U4Q4w3ZX+wScpob68gNdpseFEPWjTLvIFfuZA2ReS7aGETOhFSELYqoWJUnrCTsTO4WUwXVb3JvXUe6Bx3QlHxd3EW+3qDtWOnmQGG19sbHYjJafmvVIqr82JrKbNj6L1GasssT/aPkwxsOkXa6I9nsxL8OajkGgGZOR3AZwyf6ufbNsNZ+8YmYJfAgFM/KhG6MvanI8S8P/wqO5dlR+OzsgQkdkfPeA5JYJjnKHqPYrfDWFEk2ImDhx8BOGdXHkxWQcxJgQI5MKjRU3UyjizWB+9+qtmao+VvUMQXXv86uZCMYcflyLuwBXTVBRjGigmjNVfXIUDS8evEwL06YzMJb+xmr2pBLOR1Bsfy8SiXyiHj9qEOPug3OYReKb+xf3vIhRbvTBOWxlpyPbvmERySKjyi2c0O4Nau6DhSTk4gXopKdx+g6WZgT+PMPfT41XPAjd5ahbX1/83jdvh7FAR+AvnddKF9TzSsLoNLOddNhEalrcrIlaPz2fnc4WGfSRbSAshEB8F3Od3kFIBn7e4MQXPbzdaOe5tm0De1LjSqL/NN4C8yz6lkqwWHk9cjbdAokcLuoBt7QXOM58Y/zdcP7Jq4z6cabd/jFP7T3GA4CzjElrlEAg4mweEVe3EE1n48eIDOu0MqsV5hdJ0Lk/YdAoRgBipNv+M4nuQMsFNObXhDNqTeXELEZtD9R4LNWoDFOmZxm+Kxw+WYxVQQJVvtodPc61zUZ5+iFHXuacibqX1HuN0+UNLJ2G2LO2HFPKD5xI5A35MchCbmfVfaPR+NE1yN84lJatflfIvXTv8mXFjU2p5mP2AKya9rzIc51I9ssh5yeULMtpl2VzWGqeplREnbOMc7Pj6bqzUeAi6uNPeTqVBIpYtEf/2BCXkKf8b1yJvZbpXPBksC3Ga6aKu+T+OmQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47967f79-3da0-4514-bf22-08db56b6fb02
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 09:13:30.2119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTjUhX7DlJpYQzj3l5CBuggI4qFKaf9Ubgs04/dQSLl23EKmXl/SyiZOuERiqj5lU9ODh/jvjFONfWV4Iyh38w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_01,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170076
X-Proofpoint-ORIG-GUID: pA7e_CXu1u1a2EbZXQuyXhugxa7xO4LJ
X-Proofpoint-GUID: pA7e_CXu1u1a2EbZXQuyXhugxa7xO4LJ
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/5/23 15:46, Qu Wenruo wrote:
> 
> 
> On 2023/5/16 09:34, zhangshida wrote:
>> From: Shida Zhang <zhangshida@kylinos.cn>
>>
>> From: Shida Zhang <zhangshida@kylinos.cn>
>>
>> This fixes the following warning reported by gcc 10 under x86_64:
> 
> Full gcc version please.
> Especially you need to check if your gcc10 is the latest release.
> 
> If newer gcc (12.2.1) tested without such error, it may very possible to
> be a false alert.
> 
> And in fact it is.
> 

I also noticed that last_range_start is not actually uninitialized.
However, it is acceptable to initialize a variable to silence the
compiler if necessary, right? We have done something similar in the
past.

Thanks, Anand

> @first_dir_index would only be assigned to @last_range_start if
> last_range_end != 0.
> 
> Thus the loop must have to be executed once, and @last_range_start won't
> be zero.
> 
> Please do check your environment (especially your gcc version and
> backports), before sending such trivial patches.
> Under most cases, it helps nobody.
> 
> Thanks,
> Qu
> 
>>
>> ../fs/btrfs/tree-log.c: In function ‘btrfs_log_inode’:
>> ../fs/btrfs/tree-log.c:6211:9: error: ‘last_range_start’ may be used 
>> uninitialized in this function [-Werror=maybe-uninitialized]
>>   6211 |   ret = insert_dir_log_key(trans, log, path, key.objectid,
>>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   6212 |       first_dir_index, last_dir_index);
>>        |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../fs/btrfs/tree-log.c:6161:6: note: ‘last_range_start’ was declared here
>>   6161 |  u64 last_range_start;
>>        |      ^~~~~~~~~~~~~~~~
>>
>> Reported-by: k2ci <kernel-bot@kylinos.cn>
>> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
>> ---
>>   fs/btrfs/tree-log.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
>> index 9b212e8c70cc..d2755d5e338b 100644
>> --- a/fs/btrfs/tree-log.c
>> +++ b/fs/btrfs/tree-log.c
>> @@ -6158,7 +6158,7 @@ static int 
>> log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
>>   {
>>       struct btrfs_root *log = inode->root->log_root;
>>       const struct btrfs_delayed_item *curr;
>> -    u64 last_range_start;
>> +    u64 last_range_start = 0;
>>       u64 last_range_end = 0;
>>       struct btrfs_key key;
>>

