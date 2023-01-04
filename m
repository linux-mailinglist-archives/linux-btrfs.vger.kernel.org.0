Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B11D65DFC3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jan 2023 23:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbjADWRs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Jan 2023 17:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240529AbjADWRp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Jan 2023 17:17:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB513FA0C;
        Wed,  4 Jan 2023 14:17:43 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304ME18b004525;
        Wed, 4 Jan 2023 22:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6S8l8ng4ZbpEvREYRXGsQuFOaTYqJgRs2ZEkMnvbN3I=;
 b=hMTEk+CCDEaHDrHUirQYfpWPAKsrNJ3YXYJLQK0SvuGLCNDt7ePIZMHn/4+o8ovdkMIP
 CKasHL41PRg4hDTwMBz81KRQQP3P6tc7AzIee+tmPI9GLg3qRUfWvGPoAtBQu5mKcG+V
 oyQYl03/R0Ew+Q0IvrglsMT3hVEaJXBeIJLKnsm3UM4kwai8WTla3gWRm7NWabXhj+8h
 OMjgGmz29VpYMi/PGFhikE9oUDZkGlibY6dJH7pLOz13zFQz3bWIFIaEXBO3zq4q5Lar
 aVgJneDiQwgHEmKFfrxNKagH+7YeZoKUoY2bTI3LCZcoOSwwnDpmRk4OJEgPkW6er+4R DA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtd4c7s12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 22:17:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 304JwNY0031263;
        Wed, 4 Jan 2023 22:17:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mwg374b1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Jan 2023 22:17:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNIZRTCT887U5kkzQQ+6azGHZFKCeBgmUe5amU+voFyTpCMxg3phFHGqNT+41q8YDNaGNXkVE65t+5nmBHnf7sc/NFRywpJ44NmsYHxHvEtkUs/dEf5H+BIVxkHv5Mtwfsnua+BD/QB+AE5CaEaqSCvWoVqZLWqC3RUNcriILRyGdbInsLSLplCUTQ3BiqIWyiECbwgnebkOQeH4afn/dsZ/sKACZz9msfThelxLnK4S+AfrwM+QnbuWA2ZCLGah43p+l/vmMdMan3ueioJmXvEd9RYCpCbaWpMtst36lJY/vmn/S6YQhpnHh6o/yEOE4nYy2mvuXnbMkPEWKct2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S8l8ng4ZbpEvREYRXGsQuFOaTYqJgRs2ZEkMnvbN3I=;
 b=j9EPRM9lxXkAd4Rg7vA3YpHBlK+KZ00VouRNzCMsoQOdqhyI7Vcyl4GRdDUZD60CN2McMID3fA9N8bxoDm81OTm8Z1zGgpRJgT8N3l4kqaatkUOMvyALrU8ZtwTBdd9vmZyo4qYsAVeCIugxpHp1uN0Z/dWREIRBVMLuJEIP45WlvI9Eebc3N+jQPm3BcpkA6mxsYlV+GZ16BL9FmTyuuHO0IPK/oShOh82qKDzIe6CjjszxYVIp5SP6Zkv8s5bg3azOfBeOkABrMTpf5Vvz+Edgj9Ipf9ccEuWda1dxsgbPLQWOs/XXIVp86z/XKGeCOI2GOVDxCgegOQiuHv0uCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S8l8ng4ZbpEvREYRXGsQuFOaTYqJgRs2ZEkMnvbN3I=;
 b=ZghEi4BCb3gw6xEzpgloi4/7YIGjjVyJCoh/lYeti9ALPEkFL8XOknxuSVDcd3MJjyfS64XdwSTd0YLSjYUT5F8QxC2XxgX41Ibv52T6UkYPY8oulutB9dnImOyrQVZ1+BquZi0wa3evoSalgDOl7sInW/7TP+ldpNdQFKm89aY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 22:17:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a%4]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 22:17:37 +0000
Message-ID: <151e5c83-6de6-9950-d1ce-8a375acea356@oracle.com>
Date:   Thu, 5 Jan 2023 06:17:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: add a test case to verify scrub speed throttle
 works
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
References: <20230104082123.56800-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230104082123.56800-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a03912b-df1f-4827-5246-08daeea17c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLoXshoZ9rIGE0lggL4VXMCFzBpty6UONIOgnwo0mMJawmC5ojJDVXgwISP+qE1jKP7rP0lDbyz6niWnZ4jNX0y8FsX1ks6SkCRU8NPWWnkBrjxUAIyIuaG0e0oCKvNHMfZ5Xhh6v3zGgPi7qT0T5Q+naOK2ZWoiKQ0tUrQzOEfOed0HyqzuIalQaJJMxqNHbO4IydKH7W6rB7L2oNcCs7oxbOipzsEnFxVUimJsLYcuJ0UudpPF6JnszL/4VeI3CZSZKDDuGGxg3EpG1qUEJMCn0HkFjLqF/Ld1H4z6kl/N1UQvox/nN2I4PKT2qAsUtslojdM9bgLgJhoGAc2y8zng/pvYPrsZueyD/XmLPt2q/LiMapBHvWfVJxM+gXzog6gkKl6ulHHZlfW3pUd4dRzBBL9Aq8y/PqjEujyqlnLxD2nTn+9RqZ9sHaTN5FQHjQXsqx/NalOBasExOyKKy77h5/+Wt7UD3eaFDR+k1eLb2kyn+tzrY84u7vLmacqJQeoUClaKOpFGI8ojbIDp7P4TZD2THFde69tArpMT8yiHuzEQHmHx20dX5KNMhkWS7IWiC7zxLsBGR85dsxnguhLRDgKascbjDB/T2HYy2yaGvU1e8vcN//8l10R1MqDaFr9IiCyaYETUQ7v4KRDs64rg0W4QY4ytFcC/IuBPHzsNPF25jU7Xi+Rlki5DwwYwE5hbxaoer0bf9D4tk8xGinbQlcW8uQBbnNImwc5flkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199015)(38100700002)(36756003)(86362001)(2906002)(5660300002)(15650500001)(8936002)(44832011)(41300700001)(4744005)(83380400001)(31696002)(31686004)(66556008)(66946007)(6486002)(53546011)(6506007)(66476007)(478600001)(6666004)(8676002)(2616005)(26005)(186003)(316002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckxkOE1nc3RHM09PRlp6UHNMY0hxM29YelJ1Wno4YTVQT0d0VFBzanRhS1R5?=
 =?utf-8?B?cjI4dnQxR0FPTEVGODVOa1JMdnJrQWpVQmpTdmt3cXU2Tkl1ZXdjVmRPVHFC?=
 =?utf-8?B?a2U3NnNlY0RlbERxWS9xKzM4c0Z1dWo1WmI2SFhRM0hMdDl0ZjJ2RU13UnRo?=
 =?utf-8?B?OW12OGdJcFV3MDJSTVc5MGVJUDZmUUJ4R1VFY0N6T0dGaW1sdHl4L1lSbXFB?=
 =?utf-8?B?Tm56Y0syUG1FYTFJejlqQ0pYblZMUDNvaXZlZm40bUduaGh6QlptS1BFSWsv?=
 =?utf-8?B?aE9nWHovVE43QzBLL1lYZHB4Wkw4dTRXTG1Rb2VvRk1Hb1hmdHpvRjNFdlgx?=
 =?utf-8?B?SWxUM0ZRQW5BZDFqK1pkM3lZaUR4bWlRSUF6V0dvREoraUxTTEhNMEpLb3pn?=
 =?utf-8?B?MXo0ZmN4REtoZ0U3c052RVNMekx6NEhYaVV3MWYvczE5KzJndFAvU3lqOEE4?=
 =?utf-8?B?YTB3cnJ2dWxsSkNhZWNQU0dReEpGRG82MzE1RFUzZmk2Z1FLUzR2aUoxZWt5?=
 =?utf-8?B?bjFlL0w5UndwcXl1Z2Y0YWJDRzg5ZEdxaXZpMzNwNTJuSXNTSU0vRHFKZGFy?=
 =?utf-8?B?OXJDMGt0NDJMQlRIZ3QvcUpOSk8rUElkS1pWVTMxS0VOZ29IbVY0T2FuR2du?=
 =?utf-8?B?Tk5wbzlRTWRPSEJJbzRKT0Mra0tlZmFDeE52VUJScEsrYUg1M1FqVEJSc0tF?=
 =?utf-8?B?TlQ3YWNnUDdad2tpQW5mbzFRL09KZlF6THBoeGJlWU05Y1VlTlJXWCtPb0I4?=
 =?utf-8?B?a0srV2t6VzlRM0VGOVdURmN5Z3Nva1VXUG5FSUN1dmpGbGxGZ0JuMmJwY1Bv?=
 =?utf-8?B?MHRUa2N5T1hhZWNpT0luNFc4MWxVSkVRcW0xVkUxbkloR2hOVmV4QVoyQ3ZR?=
 =?utf-8?B?dGFDblgzK0k5bSswdlNlZktRZ3N3Mmk5YU12YVJzM3pYWnZQVFRMZXk1bUJj?=
 =?utf-8?B?bDlNR3V3V3dQU1VkTldrRjdkODZ3LzkvdVlMb05BSWdGUVF1NnNlUmlaU1hn?=
 =?utf-8?B?cDBzNXN1RFZIOHYwd3c0cnpiU25Fa0wyUXRTM1hEK1EvR2tWbi94WGtYekZx?=
 =?utf-8?B?bHZ0a1dPejFCb3hHeHhlZU9pcnZQemp6d3Zpam1LYmFlRm45LytaSUgzRk9j?=
 =?utf-8?B?YzlSekZ4RXpodG9XSFB0MDFBeXkzRTdyVmR6djR6TW56TWJJMVhhRmF5Mm5a?=
 =?utf-8?B?NlZLSEFFQXN0Y0hPM1dyeDlGblIzczVZUXpTTHNPZ0lvUW5GL1VCRW9vWlY2?=
 =?utf-8?B?TWpCSUpvWDlQV1JWV04xWTZuQXlhZDRKeldWNXd2aE4vbG9ZaEhSQmQvS2lR?=
 =?utf-8?B?MDB2SVM0c1IyVktrQU5vNjlYYVdLTDFsZms5M3RaWTQ2dlZKd0RFMGp3Qm9k?=
 =?utf-8?B?Wk5qR1FRVTJuWS9iWXRRZnVpRllCeFVaRStXY1YvTlZNVWJxUjBITWpWeFhh?=
 =?utf-8?B?c2FFdFFTcnVkUW5YUkx6Wkt1UWVnZytWQW1EbkpnajVWY1hYdUhiLytxVFNG?=
 =?utf-8?B?ZlBZWVp1WjMrMnFBNm40UUZGVDU3ejNiWUtXbkJkMHpmMkJGSThScldvMCta?=
 =?utf-8?B?anJ0TUIvUDRSNUlDOWhyS0paQWFDbWVROGRBak5qcXh3M0NldWxiTU03bTg4?=
 =?utf-8?B?Zk9FV0xkTzNaZHN4ZGJQbGxGMFBJK2I2bGprV0RYM1QxRXBFRG9oMFdFWmV1?=
 =?utf-8?B?TU9kYi8rc3IxdDQ0S1FkR3pNaTBkTVF4VkFmNWYzR0tQdmNzTVR5eHlnZW1Y?=
 =?utf-8?B?UU9Ya2hweWxYeEtjaTM5TTdXVkY2UUt6dVZmMGZ4bzA2NzhHMWRZNTh4KzVV?=
 =?utf-8?B?bVVMQlpBYlpSdjdhZFdyUEtuVDRqclArVnova2pLMUR2dzJwS3hYbUp1dzZh?=
 =?utf-8?B?cVpqQzVoL2tVSnlvWEJLNUQzaFNnMGlTd0lkSlRsZTYrZGlZdVNiWlFxcDB6?=
 =?utf-8?B?aktqcW55UEc4TFJJRUJXRTZ0WmRKMFNxMlcvMnY3RTdTMjdlRzM3dVZ6Y3BH?=
 =?utf-8?B?Z0UrRXlFejllQVNNa3hKOVdWTXJJUUpuZkhYd1BPWG1HNnNqWFF5Vk9HVFFy?=
 =?utf-8?B?Z0tDZHlYSi9wdmlVeTQ4cVY0aVBtZTZVZmZScUNiRTc4S0xudzRoZ3J1aHlQ?=
 =?utf-8?B?MGhyZEVSMHpjVTB3R2NKUjBGRG1FbDh3a1c1MGpna3plV2NLcUlUOTkyWjhw?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RbXz0DjeabQ59WKik234HF89URkKznJPo4L5e/CQm1LMqZaW2N9acN6odBNjvkzNgMb66XkMpvcNluwRW3qACcmpdWB1iq8YnBnuslLJ3eahHWtoUsibblXY8kRO55x/hGbfFp0HqVPk9PRMDQ37F3mzGqqtl12aqGoHFk8y1+wmONUD45g3mYAA/QggltUl9UuavXRZJjL9Q/nrbFsWDReMASOHNCU5h89NbkGKs8Zl9szp8ZzEO/AocKpGOTxku/kwkv2j6qzXhqaxA03SEN/oB1eAeDOtbVI+8GGzaACq4+Bg7zpVQLCdqyNSQRFM62JH38f0MPGFvRtmsQQl0luWfTUUtJPa5srP5jmQSJC0tYoRSedtnkzideXe3MpaoKS+8LkJvMFPNImD+3VvTDnY7s5K6ONyBqg3WAqWoBwA/Tg8Jnq19CdpTuERFLYlGt1F96KsrncZgWRUKJVH65P4nLKyeJlZmu7hnWfvz08HV8Bep8Sx23nU5o7O8rxyY0K63KhXE0epXJmBz1X9/agp0PdAQRIbi/O9trKjGFZtEh9YvVklteiXN8/WmICvp0QzeqCGrHnksiYtQooM+AVeogvbfYJSp4cgQlsEE37FONskgHaDJG9I/arULatoEi9eTT/btKy9PIO57sijKk4kjELo0JpARHHfOPwD462owUMHUk8BqIPbac9eHgPWBA7mEET+oYT/UHqWq1WrnzMKVpYKztqk/AlChi7RBuo/a1OPNGjs1THjgYXwt3Q+jnsK+mJF7yAszjeNc/yWH9VrA0PTD8IUsXL/Nt+Y+U1pwbWNgepTMlxPYGNqRWJYV2idGF+MEXsrr2YF5QLEWw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a03912b-df1f-4827-5246-08daeea17c73
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 22:17:37.4236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +khZkgDP5uy7GedRaj8siE3/1dK6X3KNO6lYN9tM9LGk8hijxDF/Z8nA6tH8ACt2H7n5bzEB5OQTMG7nK+z1YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301040181
X-Proofpoint-GUID: Mqfoy4C86Zbwafrv_S5OiyBoqq6prlS6
X-Proofpoint-ORIG-GUID: Mqfoy4C86Zbwafrv_S5OiyBoqq6prlS6
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/4/23 16:21, Qu Wenruo wrote:
> We introduced scrub speed throttle in commit eb3b50536642 ("btrfs: scrub:
> per-device bandwidth control"),  but it is not that well documented
> (e.g. what's the unit of the sysfs interface), nor tested by any test
> case.
> 
> This patch will add a test case for this functionality.
> 
> The test case itself is pretty straightforward:
> 
> - Fill the fs with 2G file as scrub workload
> - Set scrub speed limit to 50MiB/s
> - Scrub and compare the reported rate against above 50MiB/s throttle
> 
> However the test case has an assumption that the underlying disk must be
> faster than our 50MiB/s, which should be pretty common in
> baremetal/exclusive VMs.
> But for cloud environment it's not ensured 100%, thus the test case is
> not included in auto group to avoid false alerts.


Why not scrub the data twice: first to determine the speed, and then to 
check if it can be throttled to ~50%?

-Anand


