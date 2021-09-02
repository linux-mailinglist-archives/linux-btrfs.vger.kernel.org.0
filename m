Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138C83FEA30
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 09:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243381AbhIBHq7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 03:46:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7386 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233428AbhIBHq7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Sep 2021 03:46:59 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1827OdvM011043;
        Thu, 2 Sep 2021 07:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rFWY/A1OAt8oRYe2dvKeZrVUtmtAiR+CVyNT2q+ymSg=;
 b=cAnu33mrtYeFI0JGB8ePUzY/vSsvGEmKHQ+DpCuqbyOjiWVX0xWjBbLqs/XuCPFiY31E
 ALe+oibnK2tl5Kg6PqGpT6oP7z+WqwTNCJwfuDXKj0Qn76wR5CLCF7UOuaSgfBQkJq3O
 G9eslFopJsYC3Z1w+JGc+VkXBJCeJ4jvjZcA/D61ctHecEibNghYyaKxTwB4z3o/Gh2s
 oJkyxT4/Ge5B8n/gDSwjDljQ8q4EvtDDLOfioW0TVvFx1aDtIzzbHys47uahYz6ErjNB
 CI5GhyDFVYv6GIAJixJbXrnHGtTYAm82pLmlDlo7FotM279+xFMGxlJOZMTVItBamcu5 7g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rFWY/A1OAt8oRYe2dvKeZrVUtmtAiR+CVyNT2q+ymSg=;
 b=ubkH948V/uqMCa/5TPzvxj0eClt4C2kZ9i2oQBD2K86Ouq3Wkvlz93o/fz4ZCNtCOQSR
 AXVG4RCOK5BTlk05cqJDzZ440ZuAY7efKDMAehvLZWUB/hpUZ1SivOLzxcJ6YLjF5Z+n
 VNfiCrSWwigPo2GHn0Amg+te7+4hthyXuMLXnye8NFNm3WPJv3E/zgQONXEoYYrC3Kik
 8WYdTEJqtCCeNBnoODwPPlUktLyI7TaHj+CpbP/Ru8UoBo8jKDUCMumEmVLXIFjFniQq
 ru9Ma7usbgsqX03KNFVEZzjL1X9R21rwfkRjSwl7V2iIqdSyF8OOXy6oWgVmo3K1G2LI Tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw59q9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 07:45:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1827eUD0058911;
        Thu, 2 Sep 2021 07:45:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by userp3030.oracle.com with ESMTP id 3ate05d117-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 07:45:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldt9dhzrKRV3jrPWLSQxFrd0on5S17iM2a6zqb1VYyLAZoPRs4A1tx8JHOxAC0UUFsA3KqOjcr1pQCHmmf5UCaRgVO1FH04qoJnN62aqYAxSe/Y4TRilGamRiqdn/PL+uu6FYQD1joLumu3HY/e8/xnciNueAB/KR9aWb/5ermnxNoBaRGSpvYWg748BKCEc8RxPebCPLprlV7X0pyIK6HaPvSnTtk+PHwgP+EX532uGotwDX3+KtpYCGIJ+X6hA/kg8bcuUuO/g9kYW0i6af1J5JKnsHS3tOuNy9np1EEi0ZB8n+RzVwmjjbTVGUsvzgpa0/P0DfbuSsCDpxcl9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFWY/A1OAt8oRYe2dvKeZrVUtmtAiR+CVyNT2q+ymSg=;
 b=Wu+b3mzwRjIkDANbjPl4Lnz8JbaYcW0bRFgu7QazCqHZCdw6VVToy7Iz7hUcoXUyhAyJJ13w0oxFNxfAmfKdgKaytZc+b3U+VRoHzae84okUB9Usar0jR62ifhjbrIm1YD+lhnMlJ0uO2KaSG7hN3rDTdPT4AaClG23F7Vn85CjxbWd0Xp5xGcjHPhFcAzW505lNZtpBVBQe4CtUoTqZ980u8TVby3vSSMKEJXfErXd/t24qmUdqx4SOb2d9TqLHbjLZXlSmJCyfwaKbLeJEzZcJCGMfA1eeTTy4x7D6/DQoL7+sd6fEx4MKUELZflDO0vChyqjcQBM/TmoLDDo4YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFWY/A1OAt8oRYe2dvKeZrVUtmtAiR+CVyNT2q+ymSg=;
 b=a/EDLOlNQdo/bR6R/FqXKKTYxZ+aW2Ykr3+vxfJinDygrXdOmJ1Vm4eCXEJimOAuT1MjVvqwaJaUqE5GgdJ/UZOKMT5YBalDBkRtDbrS5yT8L3aUQh1GOoQXcvrGwI35oVeYQjyuK47ZZkfkGU6TYf0+6iyYHEO/U4wbOYVTJmo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4930.namprd10.prod.outlook.com (2603:10b6:208:323::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Thu, 2 Sep
 2021 07:45:44 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 07:45:44 +0000
Subject: Re: how to replace a failed drive?
To:     Tomasz Chmielewski <mangoo@wpkg.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <b0bda3d5dba746c48bb264bea8ebc1cc@virtall.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <70615a2e-bf3e-c56b-d536-48bd9cfdfb8c@oracle.com>
Date:   Thu, 2 Sep 2021 15:45:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <b0bda3d5dba746c48bb264bea8ebc1cc@virtall.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 07:45:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c192a558-6256-4585-5360-08d96de5abb3
X-MS-TrafficTypeDiagnostic: BLAPR10MB4930:
X-Microsoft-Antispam-PRVS: <BLAPR10MB493045C45256E724423D1FE5E5CE9@BLAPR10MB4930.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EyYpFqVvwLTKSF+0L/scofGZ5/pbt6b1uByj8S5110FEqfP+s6udIn3NF3UWdVi7ZabKLyyvd5aBXX6AwVBBwlFi51Kb5E7FQX0+QuJkqv+54y64GNd59Rupun6aYiCQZ2HP+8rxvNJLf0aNblPJVvEAy55vXa8H3bkhGWihYGFHxeHd4e8KkrjG2EUf4YAqm97MryvbnnHISV4SXgI2xeLQRnY3LUqgSLzm7VXCvr5leiTnl4JlR79Vc/VlRIPa6gVztIyniirVYsB08OFHSAdWgrHv1UoV2hNBJQZp5AoWLXYM5XoN3DGpvUz3LYY3kq/Ra4Uh1yANj8SZ9BIFlgqbmPGVDCjUcboxBPqg4i9eX5Uh3oXYhqDWU1zC4amAstHDPFgpTLE7QsPq8ZWpiL9Ri0ZwtJPaOeOeEBVY1KWAxag8iVSS+AzOzAhQ4DYNlgLve8cRv8bSpCxIhc5ZC7szkR6+tThsoNS5zb+AcnbZwDgFNNWecmiZvYrD6mxtl5QsBZlPsPv1ITtV4GF3rU5XTeZTjStjviiayEmInN30DnwPEbEfevZBQYLnsPguFC9x0ooqTgNe5eK2rBMG4AmrpKKjyP3e2kKWk4doRdlGTGaRo8YBn2AQHAAOp7C0lWwQ/hG1Oqj+W4KSHOtp0gzR0o6vFQ1n9xEMo0j+KgGwc+xHO6QT7rz/UHjQLmsL+fA7/G9mHA+FM92eWxDWED3SlXC5Of+CFepyW/8hQOjNaKu0fKkA4QzInA0R0LACysvOjttHcQHJviyDhzqCNu934TPTkv5Xhh91ItFi2+avERDExA21JZeYV0I+EOr/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(346002)(396003)(136003)(16799955002)(66476007)(8676002)(966005)(44832011)(66556008)(186003)(66946007)(8936002)(26005)(38100700002)(16576012)(53546011)(110136005)(316002)(5660300002)(478600001)(36756003)(956004)(6486002)(31696002)(6666004)(86362001)(2906002)(2616005)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjFSRnBJYTZiOHlUM3VTdHRJdE9CMTBsZ2hhc2h2WVVlTSttQ3VlZ1k3OXo1?=
 =?utf-8?B?N3AyNWoyY3FmUjFzQnhieTBHNGExTElLeXZIamlERWdPRHcwakI5QWtIRW1V?=
 =?utf-8?B?ZTZvdllOWFl0ZWxlNjVPMlJmRENVS3ZYVTJZd3hoUDJ5MlVqMkpvMWZiM3Zm?=
 =?utf-8?B?TXF1aUZlUXVtVHRtRTJObkY0Mm1Qdm1xRUZ0RXpvVG1hRGc4eWZqelVRbVB6?=
 =?utf-8?B?SW1zck9pSWpkS3ViVFR3RzQ3Tkh5bG53RVlpNldFYlVDQXZHcGJ1RkxKbU5o?=
 =?utf-8?B?Y1RoZTNXYlRkdnRhYitaMmUrZFhDWm5BQi9kdEEyZ2E3U3pNREdjZEhrZzc1?=
 =?utf-8?B?VWZCZERXaTYzSmpCQ0xrNVNlSjlHd3RtWGxrUmpGcnYxNSt2NjNVdnlkdENJ?=
 =?utf-8?B?Tm1QZC9PZlB1bHdyV3FVM2JnVHExMnZFbTh2TDJERTRET3huN2dkV0NlQk9q?=
 =?utf-8?B?eHNaYkRYMjRkUU5wZCtHNWVWekFmYy82WTk3eDlCY05leGNtMmwySTA4eGNS?=
 =?utf-8?B?WWtNT2o0RDZ2UHU3Z1VTbm9NTHlxV3cydVlMc25zM25pWXc2bUhIL2xzNVJx?=
 =?utf-8?B?aUdMSElES1IvV2ZTVWVLMDQwNFBYU0VGeVZYRG1rbUdDOHFoTWZ0ei9LNUNO?=
 =?utf-8?B?dXRBK0tSc0tlN1ArNFNvaTRNZjFnN2RsdjFSVzk5M1k4eTFIZmIxRnpJSUdj?=
 =?utf-8?B?K0U2NGNLMTlZVE0wMDFWSytpUnpia2REY0pkREVSL1VYcHU3OUxZaE0ydzN0?=
 =?utf-8?B?Wm5hQXpLM3d5U1pwM20yWmVFOGRLNGZmbzlzS0Y5WEpHNmY2ODhDZ3BaMURj?=
 =?utf-8?B?ZkE1c2lOc0lrUXkvSFkvbm1WNVhXSGdHNjJkTUlPdFhrUjZmVFlGK1JXaG5h?=
 =?utf-8?B?MXVJN3BlbkI3bVc1ZDNjK1YyWFd0NlJ5MTZoM1h1ZkQ3OTV2MDlVWXYyWlJG?=
 =?utf-8?B?R0RnT2Q3RktDM2NmK2x4dzZFTGFRcGRwL0ViZjBmUnBDUWp6Q1dXMWpNY3pn?=
 =?utf-8?B?VDROYmJxaTNTaXJUUitRS3pIMVN6VGR1VEQxR05kZEFvR0dqalJnNlhxRmJu?=
 =?utf-8?B?RDVaeVJCUG9PV2lBN2tTalB3bExNRmJPSXNYVGRVYy9oMTJhczhNeVdCYW0r?=
 =?utf-8?B?bU5zTmUxclZSaDkrSEJrQUhyTWJrZVlOdGIyYmtGTDFQZjNjVWR5QnJRQUJl?=
 =?utf-8?B?Z21vZnRLNmVYcVlHL1RwdlZtaVdadkxrM0ZFakxEVkg3Um1xZDRLZmt2cFJQ?=
 =?utf-8?B?SVVGUk1JQ2ZYSXlQb2dHU0FlcVZqVGJEZStMY2Z3VWpNOVhMYjhITkJEbCtS?=
 =?utf-8?B?Z2RGMkltV2lpZmFjNGdZMnpHclFGdjlLM2w1Z09EbDRaZllHc0pPV2h6eVpY?=
 =?utf-8?B?ZEpKcWJXcVlXSWFud2ZCbDNtWDllZUprNDB3anRkejVodnFiaElyQkxhYm9O?=
 =?utf-8?B?dVNhaGRnQXNWYVJTb0ZIdHpYL1p5WU1LZ0VhNytIK1hDZ3lMa2VmVS96VjJl?=
 =?utf-8?B?aXB2MWxyTzZoRW53UVRlY2lVU1pURGJTRFBJN3Z3Z2dveHplS0RrV3BXaEw3?=
 =?utf-8?B?M0dhMDNCK2ZNT3JFeVdhUkthOGZFZVplN3k3WlZOQndKODZWaFFuTThSSXVN?=
 =?utf-8?B?TDNTelBnWFZpeWZMWmU4d01UZHlIRFBJYUNLOTVEKzkzNU5RdUJMVFY3UUhL?=
 =?utf-8?B?MDMvbWUwbnJ6bHYvdElIZEN3K3Axd1A3dXU3WElxU0d3UmZKcUZSZHdKd084?=
 =?utf-8?Q?P/Edp2GSqMkPnF4Hbj4Msm8iTcz8fs85PMVjrW1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c192a558-6256-4585-5360-08d96de5abb3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 07:45:44.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cu0p1R7x1A++dnMCVsaObg8yrFPEspHeTfXcDaqTJ3aLVKDYyppHj1RPz6XxiIdy/dygkc1goLnqnCneKFf5MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4930
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020050
X-Proofpoint-GUID: eVDK7CNen6wwOF3xVhob8xWW1KRMi08_
X-Proofpoint-ORIG-GUID: eVDK7CNen6wwOF3xVhob8xWW1KRMi08_
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/09/2021 06:07, Tomasz Chmielewski wrote:
> I'm trying to follow 
> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices#Replacing_failed_devices 
> to replace a failed drive. But it seems to be written by a person who 
> never attempted to replace a failed drive in btrfs filesystem, and who 
> never used mdadm RAID (to see how good RAID experience should look like).
> 
> What I have:
> 
> - RAID-10 over 4 devices (/dev/sd[a-d]2)
> - 1 disk (/dev/sdb2) crashed and was no longer seen by the operating system
> - it was replaced using hot-swapping - new drive registered itself as 
> /dev/sde
> - I've partitioned /dev/sde, so that /dev/sde2 matches the size of other 
> btrfs devices
> - because I couldn't remove the faulty device (it wouldn't go below my 
> current number of devices) I've added the new device to btrfs filesystem:
> 


> btrfs device add /dev/sde2 /data/lxd

  Wiki is correct.

  $ btrfs replace start 7 /dev/sdf1 /mnt

  That is 'btrfs replace start <devid-of-missing-dev> <new-dev> /mnt'

  Do you mean this didn't work? As also mentioned in the wiki
  replace-command is better than add and remove.

  Moving forward, as Nikolay suggested, remove-missing will help.

-Anand

> Now, I wonder, how can I remove the disk which crashed?
> 
> # btrfs device delete /dev/sdb2 /data/lxd
> ERROR: not a block device: /dev/sdb2
> 
> 
> # btrfs device remove /dev/sdb2 /data/lxd
> ERROR: not a block device: /dev/sdb2
> 
> 
> # btrfs filesystem show /data/lxd
> Label: 'lxd5'  uuid: 2b77b498-a644-430b-9dd9-2ad3d381448a
>          Total devices 5 FS bytes used 2.84TiB
>          devid    1 size 1.73TiB used 1.60TiB path /dev/sda2
>          devid    3 size 1.73TiB used 1.60TiB path /dev/sdd2
>          devid    4 size 1.73TiB used 1.60TiB path /dev/sdc2
>          devid    6 size 1.73TiB used 0.00B path /dev/sde2
>          *** Some devices missing
> 
> 
> And, a gem:
> 
> # btrfs device delete missing /data/lxd
> ERROR: error removing device 'missing': no missing devices found to remove
> 
> 
> So according to "btrfs filesystem show /data/lxd" device is missing, but 
> according to "btrfs device delete missing /data/lxd" - no device is 
> missing. So confusing!
> 
> 
> At this point, btrfs keeps producing massive amounts of logs - 
> gigabytes, like:
> 
> [39894585.659909] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
> 60298373, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660096] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
> 60298374, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660288] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
> 60298375, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660478] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
> 60298376, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660667] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
> 60298377, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.660861] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
> 60298378, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.661105] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
> 60298379, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.661298] BTRFS error (device sda2): bdev /dev/sdb2 errs: wr 
> 60298380, rd 393827, flush 1565805, corrupt 0, gen 0
> [39894585.747082] BTRFS warning (device sda2): lost page write due to IO 
> error on /dev/sdb2
> [39894585.747214] BTRFS error (device sda2): error writing primary super 
> block to device 5
> 
> 
> 
> This is REALLY, REALLY very bad RAID experience.
> 
> How to recover at this point?
> 
> 
> Tomasz Chmielewski

