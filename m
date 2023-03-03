Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E519C6A9381
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 10:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCCJOu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 04:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCCJOp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 04:14:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A0B3B21C
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 01:14:29 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3233hrVs032128;
        Fri, 3 Mar 2023 09:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wWXozIZ+XybyuRQ8ih6MXRQDkD9STQFVvfAglm2Wgks=;
 b=kVrUg7b8nCqrub3mYRjDvcNysqA5AS9fzFizWpoCKln8cndANWEBjMV0om24qOWyXje5
 r3kS/YFEsNEA/sO82sTxs8zvZQ7fhv3vvy9Tid3uQ9m3FsUoz6lg0WkYhfoHkMSBIar5
 o3zsL2tqplVqub6X0zhdHnpq2SHQz0p9VqDLD94B6TftZnl+bFvup7gfNxiKbsr4rmus
 xNpuZpbiPwJGEwJwYHqiRx+dDA+iGv6VrhpVGN9ON5xrLrlDdf5RsDl1O4zJg1E3K7o4
 vQO90yxEHageOPwy/gZru8rAlCfmPbBriWhc9CJqNVr4fU0R+7djyGOej+83LA0D/1Wp HQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba2e04g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:14:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3237KQ6U004937;
        Fri, 3 Mar 2023 09:14:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sbjbag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Mar 2023 09:14:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlTJRjWxtBokNjWJU8equEN2Xgbae5LfeodzTC5f+uADhiI8rsNOE3xgtP/hWy6UJgM8ImgvQmoDSEiT4MNW/9GU+BZMyLeACQOKZvrc5czwqLc/+xve6RCZ9ELukLP2WZuz2a9ZxAyo3e626NkYwDiDmGASl+mXxeY6w8g2C9kubUN9kzaWzUQ6SrzXo8T1WBazUUAXERdJ/FkRkWg/MVx2kxL0SMCVWYQT1ycMY/JgYkFYIIsE++DZGgeaI9nhSD97EsQ+oigj5OwEcX/EZqVa1jFxdR2UyPEmOZ582rAYoA6QCR8MMSWmED7cvVsb7nft4VtR/tqubiMdyLO5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWXozIZ+XybyuRQ8ih6MXRQDkD9STQFVvfAglm2Wgks=;
 b=SNBrlbYT4oZO+B2OhwRUv4gcwniFYfGdcdEs2pWyoNSh03tWP+x/I7KpyBkkB558DwnNTMZY2AtOgFepWlJmDEv7hjlRWlSXz7BU1GIP+PfSG0ySZ9TgscPV8L3TXLoGeY1do/RkiHvVPJ8L/ItLnpPrhEXyVmD5tZuVISuAgyq7pm+nH15QmX9rkvFUPLgaNVzpJUubxXRvJ5RFFY0ySWY5W7Lao6qq9byzm+twOLRz6iy1ma3wcpTmsJGdbibO3veOEO2JC6r3tVXyYgnNwZfIG+4O0WR/4HgP3dqhivo5XcExmbIKm0MZ1RIBYkX7xgTFL+PfwMJKQwV6sXJ1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWXozIZ+XybyuRQ8ih6MXRQDkD9STQFVvfAglm2Wgks=;
 b=Cec1xC25fvhuDfBaLVOShoVI/ONCP9fHIaq+/Y/H1aUC5oYw0qi8I9nijr9G+bfr8hQcXB6N/wBg8FZz2l4Z/f/workqrTH/EkKrCkTZq9Qnz7NntgM82EXhAy1yWB994LRZUkkItaBWDF8Ib05ZhTzyaSEGE5nIp/LeS+fyj/c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7299.namprd10.prod.outlook.com (2603:10b6:8:ea::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19; Fri, 3 Mar 2023 09:14:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Fri, 3 Mar 2023
 09:14:21 +0000
Message-ID: <085780eb-8ba7-aacc-66fc-573c6bf01645@oracle.com>
Date:   Fri, 3 Mar 2023 17:14:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 01/10] btrfs: remove unused members from struct
 btrfs_encoded_read_private
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-2-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230301134244.1378533-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6a3bdb-5a79-44e9-f15b-08db1bc7ac2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40fh9hbrOkVdD3xsOSywQLj5PkmRNObBTmMtoFJy9uHIOOlrIJ1KbJ0Xl8OWZKt91JChRMzA/PRS5dR3wCDw3QIRt3MjgJRrfTvMC/+5sWBOvdTVY+7s54e2ffL27HeKQfn+pPpAoDUO3BifTgshN/rh1JrM+FhuRpLp52BUqQXlvgCEBLi/c9nO8hD97USdcZvFeWoSQn4CTPjbPDh+oOLHjo7IBhd+7UmuStGO+l+TfbcPf/FRWFQIBsYKcv0CQX3W3f1KfP/V4ToMWFkcRsOx2+Dhfm+x6RL8Xn78GjzGCNqmbvpHbsDPa5PBRFYhwM0pnD18MSBZBW3O36Gz/G5XVMtErafNhCyBesuKZ0402B9l4XCWGOm6sAkDu64ekV4Z1SSCC5ODmCp2xLcb8L41Uep9Ggo5PBVJp06QGn84k3TS0MGxBhsRWTBiZT6bsjXHaxw98YrrEcKFfob7Yon0+Crt6UxmiZV7UMT6hW1vfFuPMD4lKTbJASmrZH0IGRtIY8I0+ne00jNbg8Lkhi9jecOlBMlETOz/+oSv8NhBOJolrKCbdjScKe3xmiY8bgrJbuNP5lmzeWTODAv/TC6kBFEn5JpIiGjZBE/v38ogM4tDuYKvCCjGd1+nVgZjc0HeUvBJWJPLRKy+TRrFPxocsRreOZZl/P4gaU16Uz7rwJU32ZpEP8OlBhdnIH2iT39HYju/t73I9gb1/YwuIZVld7ffJ50G7Msa4zwNDac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199018)(66556008)(31686004)(6666004)(36756003)(38100700002)(478600001)(6512007)(5660300002)(8936002)(86362001)(66476007)(31696002)(186003)(26005)(53546011)(6506007)(6486002)(2906002)(66946007)(4744005)(44832011)(8676002)(4326008)(41300700001)(2616005)(316002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1ZvMkE1VlZPSTBnSjVsMG5EaDJsdHU3eXpwVnk2RjJKbk9GalJmcHcvUXFR?=
 =?utf-8?B?VG1vS2lGT0hHa3ZpRGN3bnBHdGk2OTdNMnJ1ZmZIMzVOQUozdWZ4aUVDem9o?=
 =?utf-8?B?V0RSQ1ByWGxwZ3R6WHFJNTRkd3BIRDk3a09jRUdkU1FYQjVsK1NFTlRYeHg2?=
 =?utf-8?B?N0ZLWTczeVZBelorbVBBSnV4ZTI0T1R2MlZIcFJHSzY0R2NKUGJHRFBxSDJw?=
 =?utf-8?B?bEZVaW5CSFYrakplRCtnSFF0TE4wVlU4ZWpHSGZiV0syYXNwcTVIQjBOK21S?=
 =?utf-8?B?dUNoL25LSTcwV2syUUZtL2dYb1ZtMTUvcml0Zi81QVdKWDRKZDEwMXl1RDFK?=
 =?utf-8?B?dlhIZUQxdURGUWlVTDFuUFVCMkZPclcwWGMzN0lFc2xKUjNrOC96NGlma2lq?=
 =?utf-8?B?aWgwWC93dDFyOHlWdmw0Z3NaUGRxN0p6a05BUHlXVTVQcGpmMGNRUnVPT1ZX?=
 =?utf-8?B?SURvSzFHSUZtcng4RUdSWDZIaWtpSk85Ly8zeDFGKzFnTkJsbE5LRDByOGdN?=
 =?utf-8?B?S3hnZUJJTjVaN0htZmdpNXhyWCtiRUJBZ2J1OEI4a0tLNCthWnQxV2pHbWk3?=
 =?utf-8?B?QTRkcW5FWVdBL1RHbk50ZHJHM1lFMFRMMGhVRHBIQUx1NDROWlkyREtJd0Mv?=
 =?utf-8?B?a01LaE01WFpmYlhVNTFRRzVGV0pRUnhWK2xuVEE2SlN3UCtVQzVJbXRsZnc1?=
 =?utf-8?B?aFA2UXdDSVlvK2RlMnRodk5qRFd6aTA5ZTZ1enFwMXg3eTlCbU9aSEU3eW5L?=
 =?utf-8?B?YVNCYXNvc1VxVXBUcEpPZGl2OGl1WkRHUFhuR1ovSlRYRWY2Y0ZLWHYyb0VN?=
 =?utf-8?B?Z0xqVDZrWGZ1ZDhmL09TMEpSMmo1STZIalZrNVplMitRWXJFYTFqYnZKSVlw?=
 =?utf-8?B?Q0xlOW9rMFQxMS9jR3FXVVh3d2JxT1lRanpuWkhLSGw1Z3dkajNuek1IbDk0?=
 =?utf-8?B?NVEzaGNRc1J0a1pScXhZc1JNZEV0c2Q1dnExaGdhL0RrWlJpVlJjcVVsc2la?=
 =?utf-8?B?b3VSMy82UXlBdHRGRnRQWElVdk1uU1o4UjdaK2xHYm9KbVRGNzkvcWI3WUdr?=
 =?utf-8?B?WU50WG12SFgwOG5BZmtrb21XUlMxNk45d2wreThYR2U2UmxKSDYrVWMvcGtN?=
 =?utf-8?B?RHJQblFpMWJWT3JhN0kwallCTnBZd0k5cmp5MUhUMHVZVE9qQnN5R3U4ekZM?=
 =?utf-8?B?NFg4WThrSzFTdXBaN1JYRkR1alRlRFZSd09vWXJOYmFYNURJNHF4ekp1UEwr?=
 =?utf-8?B?OTZseGRiSWFqZ2lWa0NLL1d2WmxWQ2V0TzJFc0ZyOVVlWXFJTG11Rll1RjNO?=
 =?utf-8?B?SW9NQjg5K1hXUkVzbVdtY3JHbkorMU1uaU5FZVowSytlMEFqR2NOaEpOdDhW?=
 =?utf-8?B?aitocDVEelpWQ1RCbkxlaldydUJWU1lOd2lxRTlQdmhzNzNPL3ZmQk1iRVpP?=
 =?utf-8?B?OCtLQk9ZSVpoUzNoRFp6aThBWFRyRlVoWTZCemFFYmRpZTdoKzd1NkVWRWNE?=
 =?utf-8?B?L2xSSUdBNWpBbFQvYUdsQ0JOdjUwRFJTa3p3M21XY3ZaWllKOGtubE4vM0pi?=
 =?utf-8?B?L2tqb0MxWk9xRVQrdDNyY2k3cWIrL0dYNkYxNnoxeUVSVTJ6RC9aenZqNy9n?=
 =?utf-8?B?Q1R4REV0MFR5S1IzUE8xN2FLelEvZEVTb0txbGhGTEpDaHgzWWxxQ0s4cER5?=
 =?utf-8?B?ZmVUNGhqSDlhaVhxU2h5c1B0c3J1QUdWdnYzdWpDSzRBNGd5UVFvWjEvWHZO?=
 =?utf-8?B?STlLbTIyRVl5L1M3bXFmeDRkYkY5SGtmcXZ4M3Fvc0hHektqcHdwL3VJcWRx?=
 =?utf-8?B?VVU0d3RvQ1hVODF0Z3VRbkFiYVNWcW5NdG1iTXRBZVpVRlIxK3lsV2R0MFRt?=
 =?utf-8?B?ZFRGUFI0dkhQeHBIMzJhdHl0RllIelFvbWEyL3NGbFZRdFpCRnNLa3RsU2VQ?=
 =?utf-8?B?S2cyazBTYjkyVGtFek1UbzhQcWd2cThkU2xORjl2UWZGQjd1QWs2b21QbERa?=
 =?utf-8?B?ZUhGRXc4OXFFK1MwUjNMd2J6QXBReVZMZzRsSnFST3UwdFJQOW5Ta2hCSStS?=
 =?utf-8?B?b3VjQ3hXZmlHakNqTnFWK2FyaXdzOVlkU1JPK255YXJZb0EwTkdNZ294YmtR?=
 =?utf-8?Q?AAV6dERhu+9sYThZLEq9YIBF6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 00RUhJ+xvePlueaA5rhGGeyqJDm6pClXKf/0BiALrECAubiafLnOJ4CVwlHtIKRWgbd+DpUq59nL6gcJACtI8CT7Jlg1uIHEqyDyFDuJ09tICrHu1zkVQ14yM4KnbJEY+NKzLBv+lDGhd2gL8Yo0PfwOG4iwanp+kHrS65Da5yMOdBg3bwcnCoDiMWuzS2ppb3wOmf7fc7PQVNUNBr3HZgQgHdVVLeHAFb29nnsTIxvxXSat1xzV320ut64QQVMYoAQ1U0b0fIOImFOmNDYrPCmf2uuesVCVeyqptH3NPn14w9pnoH+XYaS0AYgt3eq2Y6JpCgpfaLNwzMqN3t4Ki8y/htnyyrPlsJ4kJsCiHaowlfsMVdxzft/ohUgHuR35K8M+kORPQMLmgQymGrNBhszNMqtBVvD+06MsMRUSxyDpu5oSaEvHqe+HLFDyk6WDSNKy7M/dai85zKvEYxneqPLcQ1xQoodzLfa2/aD4JyGc/0DOptW5rOZO3E35Z4tuGn+mOqOpQBOzpuGkWY1Tlzhu/E0oUb6N1m+3ZZ+5wIFDbvjAlyfxhD0oyOG4s1FyX4drWfM4Cj6oXJhS+6cfcZJ8ARtVgsmJAnIhdDUCVn42tRo5KvHu6Ld3w+2l3xupNMxYeCsxHWjZ3jJIq9GFXSH3NmYmJrO5LMuF241JyS1HgW2M0ALpd4B3zHw4Ta2gfSJAE0/8YmnAA41Oh0egxgggHJuNk7Rk1SlqHko2yHH4xKYMqp+yvSEJnLAqus4leYaw32aSdSMuJe7V2yU0JYjUSV7PWjdzmJHimtgGoy7cCVlOOv4OsBLl1TCSFyUua4hOtCZPkdzU1UlroDgSyOYvFg01SRBjpa+vs/MNLRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6a3bdb-5a79-44e9-f15b-08db1bc7ac2e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 09:14:20.9568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBz4Hn/ie1BmgdkBSQ0z5JhnVMj3uIbXvs9cuMkQ7i3OhB+Ja54WPXaUoVZxQWu7xFQAd560NtVN4sRnhrwc0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030082
X-Proofpoint-GUID: 2N8Yg310RXVflG8eJrVuosQ30e1w5dVM
X-Proofpoint-ORIG-GUID: 2N8Yg310RXVflG8eJrVuosQ30e1w5dVM
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/03/2023 21:42, Christoph Hellwig wrote:
> The inode and file_offset members in truct btrfs_encoded_read_private
> are unused, so remove them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks like commits 7959bd441176 and 7609afac6775 and removed their use.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


