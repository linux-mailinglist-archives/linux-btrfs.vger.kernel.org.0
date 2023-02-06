Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6468BD87
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 14:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjBFNK4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 08:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBFNKy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 08:10:54 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DDA1DB9B
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 05:10:53 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316CwwVx028752;
        Mon, 6 Feb 2023 13:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6Nmnv1265r++WpfQZv4vUH/0vFTHR6cvl/XWMkEbuoQ=;
 b=R5lTEkv1C3BdMVWSv1CDgjbzzEdh512BCbLOL9u4GUCPkwsfMow9UhUWktHRJolkp1RO
 2d7bVUpOIgsnY6U1mB/eS4B7LzKfa604jrMVUpmvrT99lS/NenNV9yqceRxGqVCaCMtB
 OofS4R6VV9hkguQqgWWTVd7gd8hkUKpcHRGfMfvckxgR53NuuOyHsQ4t3SZjsKqD4oR7
 +ZDWQ7e/pMtNzBNZoVbUSfle0LJSmA8bDQ62E+4ORNeOCsW/vn5WfvWgym+rxpj2M1Hm
 j5stqY8U410B1Nth7TsUfxCUg7slkCAcGy4HjVzgiC+e97zchqL45fFxxtKeUnhjcXhN 5A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhf8a2smr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 13:10:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 316BGl3k011671;
        Mon, 6 Feb 2023 13:10:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt4gyep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 13:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA2VZ9e11hPlwmwwmq2WxmBsIMPcaT7BFBidqG4CcM5iyPCwMG+yECCvUAmhIUO6re94ZYb7HWCpColsHE5o4CHnNBBc3o+QJV1S/r3R9+TVHwsWQb8+CIcpM6cP87hoQssrpW9UJUSIZzwQfwNa1HyqdGnp0nEP3Ty/SseUxW9CS31UABxMDDnu6wH8DGItTCx7WDqbbTHOuC5amWKf9MwabgjTFIH/xmoJD0ks7uDoEEFFrcsILAZLtQ3tKEGfqnEYYLZfiQjrww/t/Knz0tKqzoZ7kuH55alCBiLjvXrsg8Lsp1utjsyjlCaxjX4h/lQGjBoZJ7cHYyyFXJPXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Nmnv1265r++WpfQZv4vUH/0vFTHR6cvl/XWMkEbuoQ=;
 b=fMgmzubZtXJL95tY6b4DYW2GxjDvfz8pNEczZj2vgb1DE1AfEa2ErYAGgfLGdL3J0C49iVjRzK96/8qxuewQn0CXL2PmS96izl/hkGfYpOgzK545PTmCs3IgvgG6f49RMcLaIigj3MRUugO7G9ZkmY+cnJ0hGhs01t9g6/xJhq9A8D0p6ssu5Fg+AXr5fKzGmWT2UOzhA52ngCZ7KdQqVmtWiLpFEfqcLD67QIEfx9MDH21G7zXLzuerBg7teLDOmYl8uUB0jCaZxg4YtHByOiICz5x9ll4un73j7kwfEmR4HhgJhtI5dARcJYS+kjkJ1zB0yotO5DLI/+7KPOvDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Nmnv1265r++WpfQZv4vUH/0vFTHR6cvl/XWMkEbuoQ=;
 b=W+aCS9aHq1sZg/cX7lLIaFJyEANW38+5KejkrByq/y9CzifEZl+errzQQJb0I+eUnXDm+Db04vEzRtZo+rEB09WigQCDsQKOQS8bCZE7kEde5dhYDW7T3DPM7spTQl7eSmTXjI9jEErHtoP/+lyepgInekTcNQTAbR4OFRfCm2M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7495.namprd10.prod.outlook.com (2603:10b6:610:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.15; Mon, 6 Feb
 2023 13:10:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Mon, 6 Feb 2023
 13:10:40 +0000
Message-ID: <49b075f0-ec14-efc5-29c3-495c0585a135@oracle.com>
Date:   Mon, 6 Feb 2023 21:10:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v3 1/2] btrfs: remove map_lookup->stripe_len
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <cover.1675681212.git.wqu@suse.com>
 <9f238a29f8875a7f5bebd510e324bb10062eb4ab.1675681212.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9f238a29f8875a7f5bebd510e324bb10062eb4ab.1675681212.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 522512e6-5a40-4ec8-f5cf-08db08438bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ScazpZGgV3TutlkfvGwLGamdqzRs+EmePnWJVh/RJTnvtXuZB5yHtUkkx9lbG/1f4XuLWDk2YDQ4pfSdyprFzmAQV+gLzKsZIFgEbAHgunFZZWzRNF+kZz78AYEFdt5C2/HOvwa1/W5AkTCsJN3l20InN7+0fB6PZx51JVNOMg5fNB6mAdqCwlBwJe7acdS+eWwcDVENkB8dN8UhSmNRI1/OWS0PJnuLu8ZVTW75Yymwx7dBUGD4gZEO3K9YEqNK/oEORs3HqZtXODjuHEfvEmH+u4U1SW8P3uTxltBR1Gfe7fQADqJlNpv6Z+r2oK1uwFLncfj/ETx2+QDcPkW3G0e20mFbEGcmvk4BPN1W7ZEU6g1ZxdWYFFFQQoMCyXPAxHF3YQLqvMddfxpZZn2t8oXGYYQdUpPYcd3nuYVnx4QLySRnYE4zKoHgvUhSTVl3BhqvN7y6hXBJucO/fWkKn28kdfZW3JmcLrLojuL9MmdOIknn/0d0G9IIfHlPp8RXdzy3LL2Ewo87ZnJS7sphTPL8xlvaYQoLq2IsUYnB7+CrfBfDuoGAP6rF6h++g7q0g7LuldBB9wwKazO/7WZRmowB26rr5g072UAdqIXtmtAb9z9ZOZC/gnQ4OKb+qcbMxlLSnc2rWaomKZAVTF76XHo8zOFvCWSU30BJo6QTSC4y68fJHVSh5R3IbJYRtXMiDjTW5hBjdbyx5UizdPmQZwzOLdUuX5TaPMZ1wU/QvvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199018)(38100700002)(36756003)(478600001)(316002)(54906003)(6486002)(8936002)(4744005)(4326008)(5660300002)(44832011)(66946007)(66556008)(66476007)(8676002)(41300700001)(2906002)(86362001)(2616005)(6666004)(6512007)(186003)(31696002)(26005)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1k5eEJCaVBMZ3Jka2xMYU5hQ2NkUW5WaU5pWUgxOUlUSHo2Z1Y5a2VaNVVD?=
 =?utf-8?B?Z3FNVWM5RktxUkZEL0YyTDNRR05FbjFoMjFVa28wVkhBNC9lS3JuQWNvelJk?=
 =?utf-8?B?T0FoOTA5SENTdHFCS3RuM1lhZjR4N3o1T2xhQlZvSVlHc1JjVXI2a0JaRElz?=
 =?utf-8?B?MnRwT0Jmb0c1YUM1cXdFa1BsUFBTeCtnVE81QVArWDlIQ09JWnFzb2tzZ1NZ?=
 =?utf-8?B?ZGZPWnZNZ04rVUxLU0p3YWpjY1Z6UnRCQ2ZaR1lTeVpoekt5Vlh1M1kyQnlS?=
 =?utf-8?B?UXM0bVZrZFR2VXpCS2hwU1puc01ISG1MeWdOTXpORGdvb0lMK0RWUC9hVzJL?=
 =?utf-8?B?NWR1Nk1wVFlsOElzQlo3dTlyZXZzRmFjd2FDWHp1dWd0KzBzMDVQOVF2a1RG?=
 =?utf-8?B?TS9xTVE0Z0h1ejNRQk51TzVZWndCbS96WmpWSUljVEJDTVUyRkhRcXgzQUdp?=
 =?utf-8?B?R2lQekNaenpJQ3Mwa3FZOGo0TU1NYU5TelgwVFg0c29wNDJlVSs0ZGN2Tnov?=
 =?utf-8?B?SUp2NlBMSFVxQyt2dm1kaUo3czVLSDllMjYyWlhiSkoyL21FTVdXWkZucHJq?=
 =?utf-8?B?M3M4SEMrUGd6WVM3MG92ZnFZMFlqOEF6YkZwUFZHaFZKT1RlQTVmalBiZUR2?=
 =?utf-8?B?OFJmRjBtWGY5U21qSU1zMU5qd2lSNlVZRHN0SHRwM3NrOVFRSWZ5V1hLZmRY?=
 =?utf-8?B?UG5lQVJoc0JiczZLRFR1L1BpU1hiN1NEdHZnSmFxU3JzU3lRNmNDdm5YTTI1?=
 =?utf-8?B?ZkUvWDRYWnlJamNoQ3VVSlpGMHBGMm1tM21aYUZwbjVHWXdnM21JV21kZWgr?=
 =?utf-8?B?RUF6L2VLeGdBUm5OWFpndnBRL1hQZkFKR3ZNMjlTcGhHSDA5VzdiVHNyTmZm?=
 =?utf-8?B?OHI5b2RpK3BhL09MSFdueXpnNXdMTjRrSXMvbGxjb3o0VlR1V1hQNzI1WUpv?=
 =?utf-8?B?elBjK09lRnVlbVJ3SDVWdUgyREM0cTRna0FGdHl0dVRhZE9lQkxnNk9ndE9x?=
 =?utf-8?B?cDV2MGZ5ajl6VElBWmxUWXlLMUtFSlEzN3ppN3l6TUFFbkNWbkZSSXVNakpB?=
 =?utf-8?B?V2V0bkZoVDJneXRJcTRHV0p4dzZhRlFIU3N4WkVVSWUyNUhJRzZDOWNkdFBl?=
 =?utf-8?B?LzVnK0E4Q013UFJXWXVnUzNab2huMFlWQmJVdGhWVlRmenV6cUJwbnlaR2U5?=
 =?utf-8?B?cVMwNHlOaGxKcXI4eVltR2VGTzZwTDM0V1V6WDdib25pYmxlR1dXd0lGT1Nw?=
 =?utf-8?B?RHFWUWRyVHYvdVIwVDhPNGw4Yk9MdkNnMU1zUk9wT3lUMEpMWU5UTU5iRGdm?=
 =?utf-8?B?M2FTbEsxeVRBK2JsYkk4M01VQzV5bjZCNEVPWXNmN3RPLzZZSXgxVm9WdFVE?=
 =?utf-8?B?Rzh6aW5wMlQwMlYyL3cwSTJscVVMRVdlUHdwS2dxTXlhZ3JGMkdqM0J6N1M2?=
 =?utf-8?B?YmtWYUNIanZaRklKWDRwMzV3dUYrVFlkdVFtc0RxQ2pmWGszWjZjeExzNGdW?=
 =?utf-8?B?TE5Uc1B6RElQbGFjZXY3Z0QzVUUyWVJ5M1pMQzNHSTFmV3Y2NXhaQnJyclB0?=
 =?utf-8?B?emx0Mkd4emgzQzhEaW16WGdqZlBaNHZDVzV2aG1SaXY2dUZScnF6QTg3UlI5?=
 =?utf-8?B?bVg1WUJxRmpIZFRsckdiM3ZoSjF4Z3IzRUdUWG1rYVBEdE9PTmd5b0NhVUFO?=
 =?utf-8?B?ZHd1YUx2VlRQRFR2Z2U0UFMxaGQ2OG5BZHZsa05GSVNwVGU2RU4zNTJVUkQv?=
 =?utf-8?B?L2xYNndzcU81TUM4UEdVYkdrV3Y2c2RBaUZsVmlyMjhKMU0vR0dZZHU3YUtw?=
 =?utf-8?B?SFBIUGZ3Znk5Sk5ueHlJSDh6alliNTdEdDRpaVRpYVZmQlM3UjlleGEyeWVJ?=
 =?utf-8?B?dUsyODZpRFVZQ3hiYjhKRzlUaFhuTU9NYmUvU0s2RHpvdUdzT2ZXTU5UWmdT?=
 =?utf-8?B?QjN3WjY4cmRqV0pDckwwUEVVaTRZdlVlVm55VDh6TW1tSzY5MjU4aC9lRVFU?=
 =?utf-8?B?cE9NUlN3a05pQUtqOENHWTF4R3RyS2ZWZnJUcGRzbnBjTGRpSkl3MFp6Vm5U?=
 =?utf-8?B?enRyWVdrL0JYYXViSWVzWThUTXdmRFBPYVNJanRGQnNJZmhIdDgvTXdoWUo4?=
 =?utf-8?B?THpub2xzSWkzbXd0VVJ3a0RmZTJKSVgrVDNBWDk1MG9vbHJmcThTV2hRNHJ2?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kgKkPks9k0AZqVtn2jyc0AP0gtPjQPfOW0iXgOzooieEq2qeC0vNjRJNRYpXHwNCK6opZpLk3WJqGq5aRCek7oqxrpmUrHy+5M6x75fCXzmYXHRBKIVawdB858zxTCYCLT78qMEvcb9pRavGb2DYTQxaAoLDmH+j/X52gOj1HxL8evE0KIE5KE6iIopdjCUQg1FZ462Xl7ohRCn1pSVQE9+taXdqFZBti7+6bAYELlyT9yHj371aJGEhFm8deacwhB1tOPCkGXGp4ZWpSWY8kZdNP1rEmQeyj5NyQwwCge0Y5ylniT4z3kO7T05oqtaeJ8lDnfgCtCp6b8AjDD0aA2Vf1gu1mKaqWV80SWUsmCyzHajMH9jL5+LH3whGqJXuGUI357Wywx1mMc6TgBAus7APVB8S2K0rtEGfV1DgsksOZfI6ZPFHSiri9FjHCKuwru4iyJ9f8bOVT+YAJ2Wm0EWaZLBSfmYPOl/qUfFcw/FJRCbsMmCwqdwOn/YFJ1rm94B98yM+yQOihkc99KeU2495Hon1phE6JCuyk39Gi1BhgRDkXiWb+48uvc5vXo2MtEvslUowxkIrW8DKg3SmE74r+0tJRNQ8Rk+jMbNT3+Uh+c/X/JFcTke6ynSTcbVoDve1YRcIVlo/rsgYvWm6SyK3hJ/g+7pYWYSuqxv4daP/F/UVof+TZ6ZXzzRiHXg3zUwrqL11hR/MrniXbs1LCITrDT1YrYLizwfL9eveob33NcoyARiFs/flDUCWMRfFsBTo17PxtkR+8MHwKXPeSmBJG2gFK3hPeSqxR1MVUsav5f1qKPktSLjoL3aha8P8
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522512e6-5a40-4ec8-f5cf-08db08438bad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 13:10:40.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NkDOkd3/hOxCL8vfHJ7/5FJwQ7wZziyl1AK/GHUnLx96aIDW04kLff6Uvx2L9Sa5jS21x8J5xcQDiBgJoDiUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7495
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060112
X-Proofpoint-ORIG-GUID: LKXMqyVX65cNhq4dLJDRUoo4OEp2cUHp
X-Proofpoint-GUID: LKXMqyVX65cNhq4dLJDRUoo4OEp2cUHp
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Nit:


> @@ -6338,7 +6333,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
>   			 * reads, just allow a single stripe (on a single disk).
>   			 */
>   			if (op == BTRFS_MAP_WRITE) {
> -				max_len = stripe_len * data_stripes -
> +				max_len = (data_stripes << BTRFS_STRIPE_LEN_SHIFT) -

This can be:
max_len = full_stripe_len - offset - raid56_full_stripe_start;
