Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD73578D31E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Aug 2023 08:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238954AbjH3GFD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 02:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238710AbjH3GEt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 02:04:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDB8CD7;
        Tue, 29 Aug 2023 23:04:46 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U1i4hC029215;
        Wed, 30 Aug 2023 06:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=B6gk/xr6CEP5gaCrfG7QzBQRYmVRReJLFSS8CynVjVY=;
 b=p4xCodtoLhr+o6gkW6zt9/OAj3IXnGQC4NGur4O+4iKalUl5XSSGzNTlqkgujLHdETt2
 OlGmJOedhUv0tADtmh/Fm/URPqgWWfcS2igq2AxydXTWNucDn2hgRKCizPJSZkRCfcXQ
 D8XdU8lq+bjy3wJAwlGEt/vR2VaoKNZI7sBZUF6sUN/a1RiGxdcIvs4IfyWtcN8GHhyI
 spCR0kmqk3GoX7T502PdPOvA8SKdc8kgvBa0ymMEJ3N0xG7tgflJ8Sj61g5WZW329gN7
 O5xHXoah+cFw7yIlr3ucRtSRvL5prRmCoh4rQG5a6223DzoL0ahWMXuoGDHBicfoDG8T Xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTP id 3sq9gdxfex-1;
        Wed, 30 Aug 2023 06:04:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37U4KSYw009133;
        Wed, 30 Aug 2023 05:51:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ssepxf154-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 05:51:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSvWwyyg2lcjXN8Or27sfwM3RFO9ZwraGRLZJmSLP97PcDT03DOZu2m+8pXuiWrsHnjxWdJfwCI3N+X5UluS7cebm76TOXH0gjMdKsrk8gbT+f8mNRXMlvFE//b6Rx4zs3jCg6qbbXtAmHMGIIQKj7gXteERtdx7gDlMippBDywT9Q6f5F7YjJoqvYquze8Qhle3LU0AxZ7htslf1h36ZAPnq+jsrFCnGlA/8aMxbYp37gjOGACM1//Dc2CnPNuuE7q5U1NUskU07IT5YL9qGNWJQMJglvwn6N8nfSpzKLL47Fa1FFCAAIQUP1YlAzpW+vJqVGp6cSWVoK/PCoCUCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6gk/xr6CEP5gaCrfG7QzBQRYmVRReJLFSS8CynVjVY=;
 b=HhO4yCuYiXMUscELW9dVQTqeRKH6auavNYTC5zoHQLfspAM3RW1HZLSk4WfZT4T2iVTHwQsMydJW9N76q6KlEx2ZUNwpbFdVKiUqhSm/eqgmFxvl7hWPZ4hRF/6oz0Sk/H/Ge1Gijne6Rv1d9w4VNLTKUrrj+EjCgFjcw9JqHK+hrJcdDBLXn5lz/QiXzTt2Ppms/x+oiH407R4lo5fTAOZlWf8bLUwfEAu5iSy7IwKyrlWhtxc8abjv9Or3pl1kLz4BsucbDb/5OntDV76jCYUjVcJfgzPxp01zFv6edjbxjKpGfOV+T3xLev7HTae0KsWgHoihSsPLI7dIqdfGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6gk/xr6CEP5gaCrfG7QzBQRYmVRReJLFSS8CynVjVY=;
 b=jViJTAN6yXCbbaj3+478nm5/OR3HCRtuUbs1ClPm2hlxWlsjnZFCWpIUoSPZghBGcEwwb7rOwXWkjg+S1UG9RRGH45pSegG7/MC9pyUkz9zZhiIOZ98Y+erv0viCnLb9CZcjWOWS7Fn7WmaTrhfIkcCqNlW0Y6zp1O5ha7BKyoo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5731.namprd10.prod.outlook.com (2603:10b6:510:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 05:51:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 05:51:37 +0000
Message-ID: <6f2c2953-6e48-9b4e-f946-55e8920e528c@oracle.com>
Date:   Wed, 30 Aug 2023 13:51:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs/237: kick reclaim process with a small filesystem
Content-Language: en-US
To:     Naohiro Aota <naohiro.aota@wdc.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <20230830021752.2079166-1-naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230830021752.2079166-1-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 98755971-59c1-4c48-ebed-08dba91d2c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MjG3Y/1BWQPImLE1b79n5oAHjMZvHIjtfuoDuGAveVtSR0yci4vSY/e9m1d5qSm+UeIVf56bxFu0DzOpuTA50zn1vJOY1ecLlzWFP2LXHe54Y2dY17LM/oTH/9fmpfvTlwpYFoNttLC2QHo8uFm1vlaNt6fHjYMWK/SfE4TUMLXBfofCWS5gitonnKi8G7HpwSSUW7scuHcbu+KHM6SHgdkPlQfqN3VQLI+yX97n2MOxX+Eo4uxuKIo00uL3JHV+C1ccuhtFe78GNwEVKYw50nJVdAe3p2srfCO2ds6wNxjIDX1kn8K6YKd561U2MG5ZmJ0D+YFzumt1u/6J2FcSlinuKMXgskOVSGDuShTCXGFjX3NlvwXGUYg1DMiCHNmVtcoGUoJkbz9AM24ShM6NhaJMgfCtetUh938e6DmOBEeqWgt2J0kRbDD6Dw0khKwfbv+Z8ohqa61iZ0QRDAxqzEVevyY/UCsT5/T5G32GpNa2AUIJ+qCAS3MEsg0BdPmRP+swVcUkaC4aR81jfYSTA2hufdX5jn2JaLC3HVs6u0MgPx1KXj1FBj7U7eJ+0M+p0XkSs4ToCIVHT1/0VGuchrc08S7KfnGXaf1Av0epmreohnxfK89mI9K21SIjZuqDTMoYYSU5XP6MaL7rjoQSfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199024)(1800799009)(186009)(6512007)(38100700002)(316002)(41300700001)(4326008)(83380400001)(2906002)(31696002)(86362001)(2616005)(44832011)(26005)(8676002)(5660300002)(36756003)(8936002)(6666004)(66946007)(6506007)(66556008)(6486002)(66476007)(53546011)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVMxTm10SEoza3pGMHBqMUoxUWIzbHJLOFNsd01BcXNOUDhycE5CYm9sNEFy?=
 =?utf-8?B?RWQrMWZUMGVwVFJtRXE0UEYxUnJBTk02T2t0UWEyc0J4OW03MlFybFNpVmps?=
 =?utf-8?B?NnpoMlROWmdXWkpWMjVGaUhhWlZHVlJpZzFIQU5qMTJQdFF6dmZ6ZWhaa0x6?=
 =?utf-8?B?WFA0L1VITHpBZzVuNW5wOWxoNnFVbGtxb2RpWlEyUkRkZ2hwR3VVM1Y0RUF0?=
 =?utf-8?B?cms5dlkwZEFtRUtuNUxGMCtHN1pOZTcvWFN2aW82NzJZZXZrSjYwWWFpcjVZ?=
 =?utf-8?B?Z2NiMm1yRUhHQVI5SUNucEJQZU11eHZVWkw0bmhvMldoZ3hpQ1FIcTNzeUVm?=
 =?utf-8?B?VFlxdVhnV0cxU3RJYWNGZ21YeGV6WXd0Zi9NWVMrRlY0OUdsOWd1eGJCSTlI?=
 =?utf-8?B?R0tVSmJVNWVpMktGOEJ2d1pMRGVzdEpncEFKYjZZUGdBUmJrODUvVk9uQ3VX?=
 =?utf-8?B?WHlKaVNYbkZtclg2WjZQUzJHbzE3aTlqTldRKzZTaWhZVlRLVXJyMHlacHd4?=
 =?utf-8?B?a0lsbnF5dUIyck5NOTFQMytQNk9VSVczcVpQUnBySGRVMi9vSjV0U1BwOGlY?=
 =?utf-8?B?MEt4dmgwcC9nSDdGUHlOU0VWVGY4NVhpMVZBVlNPaDljTjNHZDNHQms5ZG9s?=
 =?utf-8?B?ODBGeGYrdFZzeHJ2YmVGSWRGWG5NOW9SdjVvcDloQzFPOWNQWkIydFFEK3pl?=
 =?utf-8?B?REo5N3NvTDBLR3FIQ1R2aWhQcVlWOGRCTndkR0hKNGVjRTFqbUxWbS9DZnZ1?=
 =?utf-8?B?aTcvQ0Q1UjdTcCt3d2JwSzlIWW5Fb0ZZOWw4T1c5M016OXhnU2NXZy9uWm42?=
 =?utf-8?B?b0dZV0RGdUZ0UWlsYVAraGZEZ09renhpRjVTNGJNRGZDZytpSzhmQTd2aFJy?=
 =?utf-8?B?SHFwRjJ5NE0wTkR4SlR0YkFTdlMyb0VxdjJMWVRTaXN6QUpyN01vK0I2RGtE?=
 =?utf-8?B?U2NXQ2R0OW0vaXd0MmxCclVOMUVOVFBEVHJScnlvTFZUL09GTGVqaUEwWGlS?=
 =?utf-8?B?Qk9DVDB2SENubGlhdVZzSGtYTjJvcDR1Mlp1QmJscHJSNmJzSFdKc3pwYmY2?=
 =?utf-8?B?alZQZml5OCtvZ0grV2tRdEw0WjZpaHRuUUgxT2c1bitSNW16NDQ1bE9MTVgw?=
 =?utf-8?B?dW9VdzZKTk5MbURIYSt5aHowMEUyVzhIVUkzRDhwYmFTdjZKVHpPbThwTHI0?=
 =?utf-8?B?Wll1alRmbFpQeU0yVzFxa1IyRThYQXdRTmdJcFNjcWowbGpNNUNqTTNXajI5?=
 =?utf-8?B?N2VQZWZkenJCTjFRL2JoWjI5UGZEUTY2dWtZRFRxaFVJU0N2YnYyb0dMZVo4?=
 =?utf-8?B?OXdHQzROMEVibVIxc1BDc3h6Q1pNYWVYUlJsci9HT2syeXZLUjl0SStPZ0Rj?=
 =?utf-8?B?cFhqVDZKMGMwSXE4WUZydmlsQmhIMkZodmxNK2FMQUx5dG1lam45anRERGli?=
 =?utf-8?B?WFM2OHQyeHZCV3kwWXNoY1V0bmZpdmRzYWcvUHFIOWVGZXhLVk5PcFRaWXZR?=
 =?utf-8?B?S0JPVExpTVlwQkNBbU40MU93U1pnVU9zZGtrWWZFK1R0NEtSQ2V0RWtscFNq?=
 =?utf-8?B?VThoZzIrQUtzcTFURjA1ZDFXK2hGOGw5ZSt3WWtGN1dicjducllyNHJRYTZt?=
 =?utf-8?B?SXNQUUxLQnhFWjdwVFlyNGJpdnRpT1EzUXd1T3hKVks4L2wyb2p5SUwyMHlK?=
 =?utf-8?B?dVk0cmhIQ2t6dXRqeXE3emlSczZzSnBNWStPZERyeWpYWW5OWkEvRTdlb1Bt?=
 =?utf-8?B?KzEwZkRBNEVpTGQxeTVXRFdpaVhxQnJndmdGeXFGNEQwcXVVcTBpOUF3MUJW?=
 =?utf-8?B?TUJTOFhwZCtBMWdKaGVNRTdHYko5L0M0RDB0V3JCbkFmaCtnMmR2UzZkUlMr?=
 =?utf-8?B?ejVpWkFFNDFaNHFRdm1HTFZCWFAzWVRENFh3UEZYbFFxU1RXbzlyb2pwamVT?=
 =?utf-8?B?TTEvQ0hvck5iRkg0UWNwa08vaDN3TXF5b1o4dXZzOEZyVUNTbDZyT0Rvei9I?=
 =?utf-8?B?cGpCK1l2MS9oUGpNWVFMZ3A3NkErRzMzYmFEOUhCQnUvT21yNVFlNThNdHE2?=
 =?utf-8?B?MVFwcTFRWC9kZTAyUEpXTHVvZWttOC9adUJjbTR2SkprS0wxeXVsV1NaNG9P?=
 =?utf-8?Q?r1f2jxun0xKQEahVbaLP5lj7d?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3vmRrNx9cxqKBNTQiUeXwdnufYF6Yj8wj1wWVvXOB79h7zfkmLFEK4M4U0f5Zolz2aXdSgSg1iyLMGRtBshsKNtMFH+cJIaHhPxz85RuJMXNPi3NG0zN9EavRaca6sk8lh5HCWV3qYbn4x8Ni0piP6bKgXJBf+5HVAljAmjk3f7kGQcmLrO2OFG/ToJrQWca9EUcUYBrtrvfQr07dIbbPAMFwgLQYZ/sUNx9xbJralyQY1wwPhL1+h/qFrbOjkCim9frB9phLUSxKpKlFfldo36/t5kQ4qNMQh5dgQG86q6XwSyO1nvEfg+RZcpW0ziW8TsrKXBzBM/F0ue08mB4GKmE/Pe6wXiX8tOcm0jd+q8L4K2p7mn7GzpresLnanIb8FtesUmZEAPMH++2pKglT8Ecn0ThRHqmvA4gAqqqPseDZjtxW9y8oi8eZpHoY8EQyLUQvWTd9dIlJTymqrJQpo6Y+k5Y1f4tFVfs8rE6lkf7NmSlhz4tca5YOJ22J1Uj3diFSKX/Sd6DqjclvP9Lw4/3eaIbyc5FQXLf1T9WEZtu28uW2Yot16CDYFaMZ9sZoCZNbrdYihgKDQ/JiamJajim4bWNoQLSS0D7l9pGXhiphifv88cV36NKHUU2G5dZWQLDxC1vaywV15HGR5lRONyoQ9cMvLZIwEQivW/bkMLE3jSHMVIUnW7EgjnwLdOZFfVoZMcDgELm/THjpUFZUky4kNeqh0CVxIFTay+piMTyK4TUyIV7fjGZiQko1KtRSCFfbqtk2z69XTjzTJ6SEuquRxxprRYwxaP97GeYNNU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98755971-59c1-4c48-ebed-08dba91d2c9c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 05:51:37.3985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNo1MeahxKDSMd0z/au5WT7F190dmFHpfFEe98+D8vriX1xKYdsfC4NRSWzv9Hg2UN5vVqfPAMO/VV68LL44TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300054
X-Proofpoint-ORIG-GUID: BkYFBKnaabDi5fi0DJfiG9kzT2JdATD2
X-Proofpoint-GUID: BkYFBKnaabDi5fi0DJfiG9kzT2JdATD2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 30/08/2023 10:17, Naohiro Aota wrote:
> Since commit 3687fcb0752a ("btrfs: zoned: make auto-reclaim less
> aggressive"), the reclaim process won't run unless the 75% (by default) of
> the filesystem volume is allocated as block groups. As a result, btrfs/237
> won't success when it is run with a large volume.
> 
> To run the reclaim process, we need to either fill the FS to the desired
> level, or make a small FS so that the test write can go over the level.
> 
> Since the current test code expects the FS has only one data block group,
> filling the FS is both cumbersome and need effort to rewrite the test code.
> So, we take the latter method. We create a small (16 * zone size) FS. The
> size is chosen to hold a minimal FS with DUP metadata setup.
> 
> However, creating a small FS is not enough. With SINGLE metadata setup, we
> allocate 3 zones (one for each DATA, METADATA and SYSTEM), which is less
> than 75% of 16 zones. We can tweak the threshold to 51% on regular btrfs
> kernel config (!CONFIG_BTRFS_DEBUG), but that is still not enough to start
> the reclaim process. So, this test requires CONFIG_BTRFS_DEBUG to set the
> threshold to 1%.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>


