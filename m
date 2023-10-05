Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA61E7BA07E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Oct 2023 16:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjJEOgr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Oct 2023 10:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbjJEOep (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Oct 2023 10:34:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76BB5B98;
        Thu,  5 Oct 2023 06:53:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3950EP0j014778;
        Thu, 5 Oct 2023 08:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8H5Xno1cwR/YWdtK7elUHWpeeCi4JyTPO7hzhjYIiD4=;
 b=c3Sap7cHCQcU+EQWphbdWcsdmwMH6QUm6uw0xpKyQB6uUpDnDRMi/cLC60V8sSpF1Vaf
 DgbIsn7gHnDSis7MysrbyCtQk1hOeMGuWPz9kuGCq23/GWbuuNDZBgAYxu30rocoDG+m
 ceAY3icpS0QptTRHGwAvKthfLacshhu0PKA4KUOlIIVCPxFpnhOpJn8yPFdVqil5u9s1
 +cFg3fBfqbODf0O5iq8qslQSYQwl056wrCioZTBVBYnAYsNTeV1nNM+JJqUj7khdqIt3
 ndHaafD12fjlOoSHvIjbe4rXLIp8f3Soyq6XEUEJd7s3HMJcMLUxI0gsWmoMSqDNI+H6 5w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vgugc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 08:13:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3956jHxx002884;
        Thu, 5 Oct 2023 08:13:37 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea48r4mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 08:13:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYBKPSlb7vQDGq5ZjyO2tr8uc3x4IzCB7WuGHb5K5B9nYOBf+8h76UQ9X8TdKbW4PFkrdM9s+ZmiD4UkNAIoc9EjzCVm6YERmzDcRo/6Z/yizgJuzc/5kwHgiBRRzrcgKUkdHBw2xyRVse1a3tVw9UT2xniVQZ85L5NEdvDs15ngRQXlLU027s72IbkOVi3I6jK0FS9G1BrRIctcOEN/pQWJ3Ri2OMLg9hWVeTeF7yKkXd4MQaMbuZADdERqpR5E/BOq0DCLxIapQa+Qvun6amL8Z1E6VrXlbKAeKg7YN5c6/sqXX/HXVuQp6siUUrxsgm6jUwEeeaVJE82aInq7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8H5Xno1cwR/YWdtK7elUHWpeeCi4JyTPO7hzhjYIiD4=;
 b=mRvYeg+GI2cieCzm6CKz7IhRXCzsJi1f89fhFg0XrS2b7En3Gfo96iblK9pSTf84fuXhoIxZCGeFLlKg2rRt9MpKlEiyS0OJo4C64usJO5v9wDoiAXgsU+kxWG46bcFtXX0ZTiIibRxEziuZTW/1ZywVXWH9t84F2nPAQ1eNT9YVYdoUOJtwP4W0ZHwf7VO66bowO4TKX7J/xjJKoddAok2RIq1WuEkGinzfLrQzmu0FpFNcj2SZAyN6PSMVY2watQLaWyO+B4M2FYGCUgJ+a+ajuiKWyG9XLW6h6UHBfwkgAaqHasLt61fjOwfAJexgSK9hL+mZPZZ66MKz6rTLog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H5Xno1cwR/YWdtK7elUHWpeeCi4JyTPO7hzhjYIiD4=;
 b=zykVbp+0E59Gzly/zbkZpkAnJkRLDUpYrzF99nUpAKDXWygS3bOHDcC5X3yZtHf6MHcLR9Jr1vrXmtPjsmAjGwCdWjg3oIbALmMcC+o95qjyXCUQ9tPmz9c9umYZ5W7ytf586PHdAFTEOKaYffdr/YR71IFHuMHB+JVQRriGRoA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6678.namprd10.prod.outlook.com (2603:10b6:303:22c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Thu, 5 Oct
 2023 08:13:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 5 Oct 2023
 08:13:16 +0000
Message-ID: <f2028f45-efad-4321-8bb9-536f3adf2b28@oracle.com>
Date:   Thu, 5 Oct 2023 16:12:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs test scan but not register the single device fs
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <7f8e18168419ce6f89faddd3eea2611b53dac67d.1695891643.git.anand.jain@oracle.com>
In-Reply-To: <7f8e18168419ce6f89faddd3eea2611b53dac67d.1695891643.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 211a48bf-ff61-46e9-5a01-08dbc57ad663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xcILb30nIq1l7SQsTIp+CeP4DgLL416A6tNmJpCz9lazrvRhjupLRwYkMQqPOK2q26f7G6lBa1ycLWfVcEZkzq5WmRCGWh+Er8K3I9CC/XNNJdBWPKz/089ydtmeNDie88cdzem+OQw015QyPFANOrX1JLO/hNYdkGr+eSCtGPQmq6HIY27oFo3lI5YKCrlgOZ+7U18ePhsZNr/cM98pw1RAgWezOd61EXSw07XDuBo0Ccaff2qvHi0nY52eRtn2v5JfDt3ZpwCM1Fz+2aRM2gVrth01Df09+0q2zt23yWttAXRE+snymZUn/BxqS+f5MGSK3SoRO0PV9DoZ8bVRmt0DGYeY6U4kTurMy0tUlA7hK4i79BH41XVvyYtHJp9TC11uZSbRSlftXW11R3TZwbAz9BEJ+SqMDgRMVfCscA8d4fJoh+nTeg/nYrckRhdpaBMoC+Z8Yy/5unWN0GpXUl7OcVYUJk947dekGkOnsLR4Y5Y3ikE/n+YDu7J2Dr5Ar9TIRDD0PLtoXuZUVS50EKfMevdbt9jeAMvpcx21rsMVjMVHHOWrrK6fBctDQSxxwGCPhzFgrBNwbiH5qKI1n5VihDhfSXJkFWH3IcUTygys4/qsjlahfjkNZIS8pKS3edeFGWkQPz9Eie93Eu4aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66556008)(66476007)(66946007)(316002)(6916009)(8676002)(450100002)(26005)(41300700001)(2616005)(36756003)(8936002)(478600001)(83380400001)(53546011)(6666004)(6486002)(6506007)(31696002)(86362001)(38100700002)(6512007)(2906002)(31686004)(5660300002)(4326008)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU5ZVXRXdWN2ZWVOZVN2MW9aU1M1eXRjRnBLY2hERHVLbHJSRnFhYjRkSURD?=
 =?utf-8?B?YXJJYVFjM2FRZ2NkM3ZjWE1jWTVBVmhtTHQxd1IvOWUwU05jR1dPK2hTc3ZV?=
 =?utf-8?B?ZlVxQlN3Q0NTRGNucFRNeTZib3VaOHRibUJ3T2thME85dTZ0K2dwa0VpU1Zw?=
 =?utf-8?B?OUtCM1AvdjZnemJKS2p2UGNGbUw3VUJpVkFCMU9qOUkvQ0o2aER4OGw0RjVS?=
 =?utf-8?B?TDdJLzZWK0N6cTd5SDRmby93bE9xWGNSL3RZTzIraW9LVURLS0YydXNmK1Az?=
 =?utf-8?B?UHZKakV2TCtjQWJlS2FSTTMvN3U2MzNyUlBZZlVBNFgza0s4NlRJaTVoNE4z?=
 =?utf-8?B?d1BFNERoazZGSkE3Wm9tN3ViOTRkRlZPb2JGdjdJNWlLNjNrQmpGODE2Vm5V?=
 =?utf-8?B?NHE4QkRCK0hMZUY3RWxhdjFlMmlEWVRBUUJsTWczYUo5b292cnFYb0RFTTMy?=
 =?utf-8?B?bG1NbXZncDliTjIxQ2RQbDkwV1BHNmtQbWZGb2ZXdTZXMUFNYWsvNzNMUklY?=
 =?utf-8?B?RmtZU2RTQmF3UXNIWGFpZFdTQ2QvQjhwZ0RNZVUrYmswTHZyVGlYUitCNzZo?=
 =?utf-8?B?M1JDbSsrOUFteUVlZGN1QW81VHF1N2VGa20vOUVZQitUb1o1VTNzNE9GMDhz?=
 =?utf-8?B?TkJwVmIwczNEWXpzVmlzd0kxMHMrWlpDNFE5YTRxME9oRjBQRTlXelVWRUZW?=
 =?utf-8?B?NDF6UmthZEI0eTVLa2d4aU81MjlXOWhqZUlrSmF6UDNpOVZVbG9Pa3daanNV?=
 =?utf-8?B?UEFOVVFjT20yeXRJU0xRUEU4cnZMcWlGcXc2bW5qK0Z5MGhKMHJISHpTdUx6?=
 =?utf-8?B?bTE2K3pvQWE3MFFCZ0FxTVZTUFFFNkw1dzlReVdQU1U1MTQ5bHRoNDgxNGI3?=
 =?utf-8?B?TFp1VDI1MkRVTVBSWGovbTR3YlhZQkg5T1JFSENzMjJSQ3J6OU9vWEhsK3JO?=
 =?utf-8?B?V3l0SVhHT3VWNXFJR2NIKzdiRHhrNzBlVWFrbzQrODhOWGwyeEdYMkp0Q2JX?=
 =?utf-8?B?WkxncDl2eW4wdTE5TkcrNzZRdjl3cThMamFxK1FMYWdSVy95RUM4em5lRWFJ?=
 =?utf-8?B?c3BsbjdxbE5jNTNUS3RabkROaENmMTdsS1hZaitnSlYrTjRxNDU4NWwxcW10?=
 =?utf-8?B?czQvN080TUM4MHBEdjI4VWpsUWxUOXpJUDVjQ2ljVmxXSjZ2bG5oakhzNkUz?=
 =?utf-8?B?d3ZoNGt4UmRWNXo3Ti9LbzZqU3pMczV0a0dOOGVTanM3NXVxazh3Sy9FR3Z0?=
 =?utf-8?B?ays3TUI2UmEzTXJPL3FsRmtuSkc5TS9xWnErTzBUVVIyUTlXaGhzU0M0b0lV?=
 =?utf-8?B?Q2ZTbE5ocFZhQ1FlY3NzZ2xhclpFL2xtNG5qOXZTTGpDV0MrMytXWVl6UkxW?=
 =?utf-8?B?alFRWFM4T0MxMGhxeEVDOWJGYVd2N0JuamJ1Wk5IY1VlZGNjaDV6YU9IRHc0?=
 =?utf-8?B?ZTFFSGRzbWVHSFhTZ0JLZExTQWxyN2VHQWZhait0Nit2ZDBVd3E5WHJzWG5a?=
 =?utf-8?B?ZHBoaUJKN1RtaTBiZ0xNZ3ZyeHhDdWtiVVUvRGxsTDFXbHRQOG82S1d1S3pS?=
 =?utf-8?B?UHFKa3BGZk1sUDk2aXBSZEtWY1pGQWZ1TUY0SDNldFcwVEZsMStyWkRjalpC?=
 =?utf-8?B?cXdPQTNuRE1WQW5OQ21qVWtBRzJCdzUvcU93RWdNNXR3NWVvTno0ekZ2dW9M?=
 =?utf-8?B?cUtjeDFGZm1LSHdSc25iVy9DN3pRT24zSTcxSXJiUUFra1JkL2RNbWJDYWVF?=
 =?utf-8?B?OTc2SmdQK1lUd0d1YmlRaUV6eDFNNWpvNmlqYVViYU9lWm5rdEJPa1FxVU1o?=
 =?utf-8?B?RFhvMEkzUjVlVWl4NWpUVkxDSmdFQnF6RTdPanhGdkh6cFBhY2dKNG1rUUg4?=
 =?utf-8?B?L3VyaHJhN3grMEMyTWlKVzlLNCs0UEgvOTI4ZzA2SzkwK05ML0l1ODZ0WVpN?=
 =?utf-8?B?c2g5SW52V25UNTJoNDgzTHU5ZFg1bXYzYzdyS3RBZ245bDRrajZrWDNXSUs1?=
 =?utf-8?B?M2ltM0JiUW9LTmRaVkwwa1V6NHZiVkZDcTNnTVdUTVRrM0E1eGpxdVZjbGZk?=
 =?utf-8?B?MHR5MDZxQngvT2RyM0JkS2NyWmJHTWR2WGIvbHZsb2QwN0pST1U1eUtEYy90?=
 =?utf-8?Q?QjYA2TfKIvhQ3jUuisV0KkJQz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: loh6GJTIyyeVWUkV0gHauIHZq4SYOl9ygjjJXYocGDcg4XO7CqDhm8M/ym6z0J5DJxCiVoFEbi5MYpyWC8dJ5j33hFkPcVAURxK3h808HUzXYvIxI/sRJGviqp4LJ36RbcDw0lt+v+IiDoCw41XhzKcEG9SfuZp29hNEOwwAI+pnn4iSdTVDM77AkMJ8/vz0OHoQXGEuash9c053UytiTUvOEreup1ip0lHGjhGUyf7t1KPpMFd5OiZ+UBWU3K6u+HvCuUOGTqbR5l9SzVdYVu20PLRs87VmSM6zr6OhYAzFhTZVM46WQGnthgmi3hHvoi1iWbkdpxpyt3e6PiH4UR0E2HXV/Z4HNq+Ffa37aEX5lBsR+Z5nopJ8SLqWUXA62dD6ri/7L6qyV0V1xVQZeDj0kozoA3oicyJYYSxCA2Noj9Kr1fqJZteSTrji72ONfLu5WyR94rZ6LFEG/XnHs8z9PTxSZGKXGnQ/6qrHAVQD+sN+PCs8uvcJlPwr9lvaY2qWfch1ulMDNuqDQGXQLaW43jx9An3RMy+66TPSGhQSa9/S0jEvFtjiPamaoJzbwXwsUA8D5qmy6h0S/p7HY0VpQGYIvVeUy0J0leroTGkt2DtFBtRuyJw6Xqs2uSD8qcJLzLgRGU8cVajWD6FO1mKaukrxLDArrqTOvVWrj+9jAYkSjhXt3wfirYXzsHv0DbPdfrv6n2O5Pz8R7+63V9nwDfYDyG0C68WcQeFryJNCEm8PQhL7gpFoLNXYItUkbAZEdie2IpIZy45RKAV4AA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211a48bf-ff61-46e9-5a01-08dbc57ad663
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 08:12:57.1257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klPvsvt4kkteWHhJDDFc5pPIsii5fEBVuuSbj/r408+DqyL2o91j2I9O0+ypKzZZ1yPC42XgWMgnsXkbRBrAkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_05,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050063
X-Proofpoint-ORIG-GUID: IDgc3SQM9RgLJUXFy7dSi3VKDVpfH_nS
X-Proofpoint-GUID: IDgc3SQM9RgLJUXFy7dSi3VKDVpfH_nS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Added to Staged. If there's any RB, please feel free to send it. Thanks.


On 9/28/23 17:01, Anand Jain wrote:
> Recently, in the kernel commit 0d9436739af2 ("btrfs: scan but don't
> register device on single device filesystem"), we adopted an approach
> where we scan the device to validate it. However, we do not register
> it in the kernel memory since it is not required to be remembered.
> 
> However, the seed device should continue to be registered because
> otherwise, the mount operation for the sprout device will fail.
> 
> This patch ensures that we honor the mount requirements and do not break
> anything while making changes in this part of the code.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   tests/btrfs/298     | 53 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/298.out |  2 ++
>   2 files changed, 55 insertions(+)
>   create mode 100755 tests/btrfs/298
>   create mode 100644 tests/btrfs/298.out
> 
> diff --git a/tests/btrfs/298 b/tests/btrfs/298
> new file mode 100755
> index 000000000000..1d10d27c1354
> --- /dev/null
> +++ b/tests/btrfs/298
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 298
> +#
> +#   Check if the device scan registers for a single-device seed and drops
> +#  it from the kernel if it is eventually marked as non-seed.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick seed
> +
> +_supported_fs btrfs
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_scratch_dev_pool 2
> +_scratch_dev_pool_get 1
> +_spare_dev_get
> +
> +$WIPEFS_PROG -a $SCRATCH_DEV
> +$WIPEFS_PROG -a $SPARE_DEV
> +
> +echo "#setup seed sprout device" >> $seqres.full
> +_scratch_mkfs "-b 300M" >> $seqres.full 2>&1
> +$BTRFS_TUNE_PROG -S 1 $SCRATCH_DEV
> +_scratch_mount >> $seqres.full 2>&1
> +$BTRFS_UTIL_PROG device add $SPARE_DEV $SCRATCH_MNT
> +_scratch_unmount
> +$BTRFS_UTIL_PROG device scan --forget
> +
> +echo "#Scan seed device and check using mount" >> $seqres.full
> +$BTRFS_UTIL_PROG device scan $SCRATCH_DEV >> $seqres.full
> +_mount $SPARE_DEV $SCRATCH_MNT
> +umount $SCRATCH_MNT
> +
> +echo "#check again, ensures seed device still in kernel" >> $seqres.full
> +_mount $SPARE_DEV $SCRATCH_MNT
> +umount $SCRATCH_MNT
> +
> +echo "#Now scan of non-seed device makes kernel forget" >> $seqres.full
> +$BTRFS_TUNE_PROG -f -S 0 $SCRATCH_DEV >> $seqres.full 2>&1
> +$BTRFS_UTIL_PROG device scan $SCRATCH_DEV >> $seqres.full
> +
> +echo "#Sprout mount must fail for missing seed device" >> $seqres.full
> +_mount $SPARE_DEV $SCRATCH_MNT > /dev/null 2>&1
> +[[ $? == 32 ]] || _fail "mount failed to fail"
> +
> +_spare_dev_put
> +_scratch_dev_pool_put
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/btrfs/298.out b/tests/btrfs/298.out
> new file mode 100644
> index 000000000000..634342678f11
> --- /dev/null
> +++ b/tests/btrfs/298.out
> @@ -0,0 +1,2 @@
> +QA output created by 298
> +Silence is golden
