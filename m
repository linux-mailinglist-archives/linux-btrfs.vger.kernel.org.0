Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACC83F1D85
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 18:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhHSQNw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 12:13:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24182 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhHSQNv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 12:13:51 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JG5vNu018201;
        Thu, 19 Aug 2021 16:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MopjVqAPdnRxKqf5hKr2fgA+pssL7GsFxOB208SJqa4=;
 b=ODbq5fW0nevMPVrngzOs3aabgnI8R9WounVQDLjmjr1sSSUddWh1lV0+d3/hce4HKRLn
 SfDEwAr6Tx8xRn2XuM6Rwety/oMb383yycL9RHWn1DthBJVm1z4NwQIHubWwoTsCQNwC
 Zc/malkyTpAMA+KnEj2v9byyXsoZDXyfg/6n2pL+hprtlEnafRmDtl6NpvetLcZ60z71
 URpbJa9SWQTv3t8e0SRjDT7DjbucdapM5b7oEbj/MDKpJX7RdcX9xWaH4IXojOtimfEg
 OK2lphDyNJXlHqNRJbUabhABd37aXbSegS+1K/XHJkDmhLBVIPhLmrWeGS4QLJdreD1T 8Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MopjVqAPdnRxKqf5hKr2fgA+pssL7GsFxOB208SJqa4=;
 b=ivmQwQ8I2Fcs3nEv2AxsHe/l9QnBDOOFT1XNwdywbVo/9Ml6teswMOmUUENDVxk/kOag
 29MUUae6Yn/e/qmuqYt+4A/tOZQj4UDZtGdUnZln0oTTVzBqMwD60VnIB5ucQUn2hXya
 sFoIp4rn13T/QbZFWt4ZwBHR9C/wgBJM088q7J9znA5Fy/1qbqj4wj9qiHiDV/U4Tinp
 VXVA+t0m7oFvICQkn29VtMZ7FOmv1AmPqK3NQRkv+2r03sBLWXkM4jc4Q3NkvcWdnOs2
 qtvA6ciaMtSd+Uwz4mxbkggoo9pYHj+BXGltjsJt7Rc05j6yz8Lqn8NrAwi2SfLpoTj7 oA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agw7t45a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 16:13:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JGBC49143612;
        Thu, 19 Aug 2021 16:13:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3030.oracle.com with ESMTP id 3ae2y4pgqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 16:13:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mP6LizyMDY1Jkkb3Xiv/II4yjy7fqDTf/ZsHddKYZbGZjUBgIT+Vlr3+zW3hYASnLmCeuE0PYMsoCyMKFWAGK5H2nEk7muklHVzQ9HEQzEdT3EZy5HfS3YBIA+XHF6l8A6hUdTS8VzeqqAGHDmO8E5WMwpWd2SaxE0tcfMI+oL9qIeM9L2oWOAQGBsPN6zezsDohdmK18smFp9IEVtj9DPKeJTyElVbT6HZNuTspVt+d2Jb2mXTWGKKWuXlcMLoEn43P4E1L0EBjcjHNNdHXUg+zbWLSLjoEJYxzRK6dJJczL6cwTtM9hiSXHOZw1qp0cGtXxfj6XKAFIc6DVa4iHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MopjVqAPdnRxKqf5hKr2fgA+pssL7GsFxOB208SJqa4=;
 b=JMblqXpMyGzN0smdUPK2KCDnMc5ViGMbgP+4cFjiIqQ39qzD7Ku4xBeu/DOveTbcPKzbMl8QHZQHVLvrb26v8g0DVd7Q0nMLyCf/ANivE31hz1QCzmffqPZTUYBloV7wKnuRQGp6K6yS+FI9e4HR3pwFjGiL086iz6zVTiIlnQBKCP2tEEo4t3vq/SC8BMlIieIYBEhdneSqpG4hYFM6cxQX4U/DlWmwOAMCkJyR+A5WSJSBUfFOfpGH1BbjuQjdidOGTZB9lq/KzIbB+zMCScbSTFilwqy21vp8DmnOjo653vep8VDk+LxRsgbaUVjWAj6SR0WpnClOtM4WiCNuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MopjVqAPdnRxKqf5hKr2fgA+pssL7GsFxOB208SJqa4=;
 b=jF2mbpg1+nK4932n+EQVO+PPPwMu1FjiIQHISQoOSF1Onowxsp5KAfS+g910fKN5AwfaTltXylleMhdcussRYHxwTrBqdg9Lq5RgwAdiyPi9/KkjJHOUEc870sxXDP1QXP3xCKJPKa6Ix/MXrKK/4GvxuPicPW/68wm9wcLX924=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3427.namprd10.prod.outlook.com (2603:10b6:208:7e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 16:13:03 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Thu, 19 Aug 2021
 16:13:03 +0000
Subject: Re: failed to read the system array: -2 / open_ctree failed
To:     Christoph Anton Mitterer <calestyo@scientia.net>,
        linux-btrfs@vger.kernel.org
References: <2d56668e7c0f83531c6e46b9582bc4a0704e690a.camel@scientia.net>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <61f4dac5-2365-91f0-0d53-32a021eba96b@oracle.com>
Date:   Fri, 20 Aug 2021 00:12:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <2d56668e7c0f83531c6e46b9582bc4a0704e690a.camel@scientia.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.40.145] (203.116.164.13) by SG2P153CA0036.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Thu, 19 Aug 2021 16:13:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d73d04b2-4049-461f-887c-08d9632c38ce
X-MS-TrafficTypeDiagnostic: BL0PR10MB3427:
X-Microsoft-Antispam-PRVS: <BL0PR10MB34277BB4D09C6390FC3CD587E5C09@BL0PR10MB3427.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PUF201tPxhD6m5g+r66hTuIdDOLhfOJJytGzLEPdHr3V3jkm7BBlMuAYS8kRwGecVmy3wewLWt5aB8PYKYOcByixBOAowKoV+TlgYvvgvWEfyanCswcMykVZapn7ehbKq+xgkXdmIJmZkxe197D7/7XJYrdsTGNcBrr2ytfLEg0NGY46skGIL9YSnKhoKe1ITsvqUFc+sBj1tZGSsmvxuQxX6uK85XSIOtt+JXqxLnwp98ftY4hHiEkP/bNE89sPb2fxky17uE6frsv0OY383QyfXF0pSO637vn9zpDsAsob1JlCC6Zxx+8P3090xb9UTwosZyYuB3KohNH31ajMwA7PPyZJCR9kJKvFMQ2K7t8/UCz07seVBrekTlgXY0fnMBaOI0GniKYhp195JlG1lZgvnhGMNMrZ4CiPDwRYkyMsS8yKx5ByzgPjuxwbnyrhucLyjUnueAm8WuEM5rd/mdvTiPNwcPYyQ8kKYlUHkVsMBhfgau9dnoeDR31ezD+psVHVyQcPd3aywWHJAGFEYQUsb//7Et3iAfqo+5WCzpmNhcR+91L86xYK02xH7L3l7bLQN26xB0CPQe2QkUVG4aJNuaAt0IM0EHzKGubW3SEqGOy2akiCOKJeiinshwTHrTYytjPrvrOrIbLjVumFzx6s4WdOPmdTm25Fi7oS7drF1KbpUFMaejTByWeoGeREikV2EVTQgD9C6q5To/d7N2wYw+tQc+7lJEV710yzzn0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(39860400002)(136003)(8936002)(8676002)(26005)(316002)(2616005)(2906002)(16576012)(86362001)(31696002)(956004)(38100700002)(44832011)(558084003)(66574015)(5660300002)(31686004)(478600001)(6486002)(6666004)(66946007)(36756003)(66556008)(66476007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHpkTXAycWZVVnlzcUF6Zk1wekNHemdHQjd1TnE3U3pwNUZXbHpNWWRrU0pG?=
 =?utf-8?B?a3JOK3dPZFlIU3NmQk5YeS9HOWhkaTNJLytMU0p1aVl4eWhDWmpXeGFKZVAv?=
 =?utf-8?B?VjJCT3MzVVNqbThlVFBhSjRwZW53bVRiMmJSZmdMS2hrOEtiOU5lRmkrWVBn?=
 =?utf-8?B?UDQrTWs4akNJcDlqTXA1QzQyeWtWRjRJbzZib1dZd1RZN2tFWUsvamVjL0Rl?=
 =?utf-8?B?OHNkWWRkVzJScXo5WHlMMXJ0V0RmTHlsNUMwLzhWZk9rSmE2RWg0ZkNzMU56?=
 =?utf-8?B?ZGM5aUxNcDhuRm8rVUpxdlhMSzlMNnpodTJOc3BCallVc1VjbllLNGcrdVAr?=
 =?utf-8?B?MStaUSt3VVBFVWZUVk1KMFRPdTY0bWY5ck1tbjJXY2ZtS2hwamJwdGZQZEFU?=
 =?utf-8?B?MTlOVEt4ZWtwQlZVNzlzZm95cWl4VExFTmg0Y3Q0RmxxSm95UFFNL3NRMGxG?=
 =?utf-8?B?V3ZyZDNidUdpMjJyZ0ZQTk1PdXdXMVYzUkFvNnlSSGp6OVhPVFJ0dEtyV3Iy?=
 =?utf-8?B?angzMkpENnRMNGRPN1lJU3h3Qks2Q3NMaFpxVzZmR1FkWHNKdjkrY1RGNitB?=
 =?utf-8?B?VFFmSFJVVXZ5OWtHa1JMdTkybTNoejRwZm1zY3FkRUVjUEU0bEJEMHhQKzdN?=
 =?utf-8?B?akFKVFFpNDN2WE0yK2dhUWJCVHNxUHZnVnlPM3V4NFI4QzZCNWs4UEcza3Yz?=
 =?utf-8?B?dys1VGpMVDYyZzEwaXJramZQZDkxd2s5blFTWGs1eWpQWHR5dnJwZTBvVHFq?=
 =?utf-8?B?ejZzbUtoTU1yenIxRUpnbVFJMnN1d3JqVWZpc2VmcDlCSHcwNk02Z0RCRUNT?=
 =?utf-8?B?c2ZrdG56TGJzdStHeDExZjB4ZkJDZGNoWEhiZUtqTmtKcWdSL3RsVkZBbERp?=
 =?utf-8?B?UlcvbUFYWDZLRktlRzJLUTVxOURibzFzTWowa1IwTkxqa002MEw3ckh3L0px?=
 =?utf-8?B?b0NOdnpnbnFoTmpYbFJ3bnJJa1E5a1E0ZjgzaEowR0dQWFplejJvWUFUd01h?=
 =?utf-8?B?cEt6ditiVGxEcDFsKytuVTgzYnJpb0RucTBaZ243SkFySnRZNjdad1BEWG5h?=
 =?utf-8?B?KzlwOHRWT1VwcUtoVDMvN3g2SUdUNUFQbWJQbE14TTRWeFdnMTF2bThzZ0tB?=
 =?utf-8?B?WXI1QWpYdWtPekFFSlFieTVqWHFYSi9ZUitXR2dUZzhHNnhNQkNrRDVVcmd6?=
 =?utf-8?B?b0pCVlpQekxsaElsS05rQ2JhNE1MRE9RcFRZSGFoUWpPSUEwYW5wYWNWODdC?=
 =?utf-8?B?R1g2dC9UYUxCU01iL0JZbmdzdHpUeXlabjdLY0p5aEZKS3ZyMDB3b0VVMUZh?=
 =?utf-8?B?Z1Y2cjk4Y1AzeDBFZ25Hc0E4Q21Lbjc1am1hNUJRMW5JeW91Ly9VQWNISkJ3?=
 =?utf-8?B?d2JvTm9yMFA4L1VoMWthQnR3Qk5FbW85aktFcFdZcjRhZXM2cmJOMWE5a2F5?=
 =?utf-8?B?UW91WlJpYzJmU0xwSmJWV2dJSVVHU09ycERTMno2UWlUeG1KUlljY28vYjhI?=
 =?utf-8?B?Y1NYbEFPRG9rVVBTaDVzeTBybUtXeFlOejk1YTFxWW1XejR6TWtMbEZUVWE1?=
 =?utf-8?B?b2R3bmRTSGVyYmdWcEgrNHhZMjZPZ21CTDg2UlpsaUhHKzFWWEh1TFBKWStQ?=
 =?utf-8?B?aFVTdmtPaVJZV1A5ajluMklFbGJVWDYzUTFPQ0xhTm5odk55aElqSEFxUFc0?=
 =?utf-8?B?dFlBNklUSGhGQUJjcUQ1M2xwdENSWlQ0M08yRS9WTXM3SXlQWnA0a0dEU09U?=
 =?utf-8?Q?7nuU2M4psnKEHGJNF3O/dwE5NbKjIZoFAGsL7oL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73d04b2-4049-461f-887c-08d9632c38ce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 16:13:03.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdg37yvro52dZ9dfdOqqF8wXk9gwSs08fsFcZFd8EY/M5JLKX8TdJK3hi046q2hBf9oYX5MFno3MvWeBofMk4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3427
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190095
X-Proofpoint-ORIG-GUID: EhgMO0ZU84-lSbqbwue18xYeMAb6jM_y
X-Proofpoint-GUID: EhgMO0ZU84-lSbqbwue18xYeMAb6jM_y
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Devid 2 is bad/slow.
The screenshot shows devid 2 is missing as an error, which means the 
mount option contains no degraded option. So the mount fails in a RAID1.


