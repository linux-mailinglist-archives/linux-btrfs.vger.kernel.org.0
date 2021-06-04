Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02DF39C38B
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Jun 2021 00:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhFDWkW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 18:40:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38336 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFDWkW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 18:40:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154MYvOh176152;
        Fri, 4 Jun 2021 22:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ggZDG//OxU02n1Ey3SJ9mw8clmxR3wTaMcbYyutDkjM=;
 b=MVYjuiAjwGE0TMw4vBf2zGeGfoBLS7FFQJvlqj6Ips+WXu81p+SmPi4mYoBAlxNVKF8b
 ogsg5EfDu6sC4/pUBOHcca2AVTCbQCy9U9NnQpsXt580ug1gHgyiJ/t+MGUaYUfo3lc6
 0luqVe3d6C1ZH4Zav24jdUyFYq4y7yD+1g6eGjE+ZRohem2InF9RegzNG0GZd1fYHSyv
 Hpv9Tey9Z/sb0zqifx0vuyc+7mCJYYcl9lzDkhwDz3kT3wDwQs2dE/eqPzrDckqpW24Y
 2GCBqEL+Wzjd6UUSZIF59GxoOEGGI2S9/iVutTFl+8Raoinl1ClRO0XUmPHw97uDCRWn Qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 38ue8ppy3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 22:38:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154MYdQW140186;
        Fri, 4 Jun 2021 22:38:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3030.oracle.com with ESMTP id 38yuym9t7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 22:38:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahAmwFQdxyoaGjEUBLpOb+qnJ4mcCcE4WmKcjV43BHKQfTC0PZZJaXih9CkqDtO6Dfmy0eQL7AOjIPud56YpSR+Ozlq/AK1XEH+oMAYcQVI3pe5iJlCk2qcul9DVdENWJ4D5aYvV/0vTyoWAI20kGYkgXJ428gPjjTdPxodkryoHtBZQpgzGzwd3L+s7rIS/h0a+bapr3PHmnY/2Xn+KsT7CJ0QX+g0f5p5pPlDodp1gq/fimQbf0eMewLjahA6mLsNjibADFdFxQU6jpDYQtVT8XcZ5mRR99JrqP86LylGQJU7H5xnVIpttXdfsMau52OOCs2LopqdFYi1xmsrcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggZDG//OxU02n1Ey3SJ9mw8clmxR3wTaMcbYyutDkjM=;
 b=g/p6LzGxb9s809+PSzMRkzKUSr0HhgsuohNK6U6hjSlhpxNQgXgLlZwGtW5SCcoxP4qrF9W9B7baMeCw4fAt6iyYUW9XyWCGM/8I3f/Y4yySYpMMUEyz8AgKv+PnulmxAGm8xCU3TH6/Y+eAf+UrVuKgDr1Csj1AAQnd/6eVaj2LRyvNy9vEJsRm5nXvtqQJ/6ABYL2uZFyhOTFi6nx8er/dyv5W9Fa+clIaRhYBMTJH4K0c1v7SMYiBtuJjgVQVgXnc3T0z1bvVa6jkB/Vccvhu3kKzwvRj15qobCvPZrkB7QMvVJlAVJ9NwuZriY6r7w22G9+dj/7MhEujt//IXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggZDG//OxU02n1Ey3SJ9mw8clmxR3wTaMcbYyutDkjM=;
 b=VLrHVKRC6a7OZSxcmnvTPcZh8STe1pywn/wAIyGgYeAOnFVadPD5M0+3gc9xt9O9HgMq79T6Olie+Tjh80D0OoW8gYQFbn0L525SVSqocNzOT2YChf5M5bwddUNQovrUMLFhMeqWPT/uNtRgVcda/FIvBR2F1OMOywfuJLS7Cnc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4016.namprd10.prod.outlook.com (2603:10b6:208:180::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 22:38:26 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4195.025; Fri, 4 Jun 2021
 22:38:26 +0000
Subject: Re: [PATCH] btrfs: sysfs: export dev stats in devinfo directory
To:     dsterba@suse.cz, David Sterba <dsterba@suse.com>
References: <20210604132058.11334-1-dsterba@suse.com>
 <5aeca0cd-c6b2-939a-6f83-7ea5722076dc@oracle.com>
 <20210604142105.GD31483@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Message-ID: <77708664-a7db-50e0-aa44-6cbb3fb90070@oracle.com>
Date:   Sat, 5 Jun 2021 06:38:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210604142105.GD31483@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:a89c:ceb3:46df:b01b]
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:a89c:ceb3:46df:b01b] (2406:3003:2006:2288:a89c:ceb3:46df:b01b) by SG2PR06CA0248.apcprd06.prod.outlook.com (2603:1096:4:ac::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend Transport; Fri, 4 Jun 2021 22:38:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3663668a-d6f4-4f17-2a5e-08d927a977a5
X-MS-TrafficTypeDiagnostic: MN2PR10MB4016:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4016A4F0EB0C71700459FAF1E53B9@MN2PR10MB4016.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHTCBSVeH6XgsTj7XDAoxq/PWgTVwyi/7RYu37SIKjTirjI+qyToIZpRZmddW/Josz29uSusB2fLvZQtOnZORR4e5cn+F64Wa4TWaR5i5KC56g653Jw2Dc8+VQwbdI9/MCBvrISrgpmyp3rB6Qs7icAkweWwZ6rkZUKA/diF0kJY7Wsvlh/gBDWNgCH682ZL2EiXZhf0x1LJ+mT86sDkUwLPrslRQMspgfOiRaNLN52kOKtxtjZTEJZrKpXsW4X+pcyrxt7YSoloS0O0dazboT8tXaMMGWSNPJs5CUl56NF4bALDGwwqV3992ylc6LftPEK4CMj06Oog1LYheWeA2iYiTbBCuy9i+5LTNbW2eeMfQoqBUyt1Piap74pm7l2wb4JuUP3JDLXSjsOjxqAcKep269mOiwB/KAPpWsEyR4QHMUcrbXGDNGaps/ycaHxqUJQ9qTPA/Cexg4UMlEYvy2kQibLJYgsQWXCRB90RAaGMuVDh+JGmHEXj53qH6RWP826VIEP5CB9H7znNDkJ1482W7TKQob5hNBbG382zj+qzahKd2xoRU3jy9uWsXVLmFbeaW4uJRAXd3kmQ9UnAtFCQdPT0mCLvNQPEP+AIwxXq010wzUhMnC+/3ZTnOCLpqR03HK6xd1xPdgnOd/5zgHT9lEatn8d9NOx3n9q0POm++U8LUMSIChbkzC/SXLWZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(39850400004)(376002)(396003)(6916009)(2906002)(36756003)(2616005)(44832011)(6486002)(5660300002)(86362001)(53546011)(38100700002)(31686004)(316002)(16526019)(31696002)(186003)(66556008)(66476007)(66946007)(6666004)(8936002)(8676002)(478600001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bk5pVUthUDQ0NGU1TFhyUXdxSDlydGhjMGJzMnNGaFpOcWU0MHQ2QUJ5ZGp1?=
 =?utf-8?B?bEI5b3UrQktZaGpsRnJpalVVYTBtUzNpNGhrTU9mTHlacE9SQkFPV20rWW9s?=
 =?utf-8?B?VmpscStTM29mMTk0TzFuNzZmQVRsRG13SFVtR3VsQUtGM3BoQmxVMlc0NjFP?=
 =?utf-8?B?c3FDMlU2eWc4TnBmVTBNVXNWNVloNU9udnhNa0pMTTVkZnVyQmxYaWNxUmZT?=
 =?utf-8?B?ejg5N2NNUWFYeGhjUWtsb1dBRlJ4SkZTUElmMktkb1ZHNXZnTzRvL2NJN1Yx?=
 =?utf-8?B?Q2w1TlFYZUdJR1RRekxYdFFDSkNSZ1BrL2dyZTlkOThlMHU3eTRIUHBWRTk3?=
 =?utf-8?B?VGNTUDlpdHkrKzV2Nmg0UEtGNVU5OU1NekxkVTRhelNoMitycG1PWlBabjVC?=
 =?utf-8?B?T3FqQXNrMzluakRUczRUbVJCTk95WkZvRDZMOHU0d3owQmJUR21xOFpVK3NC?=
 =?utf-8?B?VkZ3OEFRLzFoM0RWaWNWVEpmSUZrR1FjZUovYXlqQ0xVT0JkUTl3V1ZucmI0?=
 =?utf-8?B?MTVQUXl5K2hjNnM4N1VTbjNmSWZTVXp4dEZrQnoxNXM0LzMvQVhwSmJqaTV4?=
 =?utf-8?B?Z3VSUG9QWHhvQ1dZekNnZ24zMWRMd0RlUnZlcDdlUkxVNGErUFNGTG9wOTlO?=
 =?utf-8?B?WHpVNWdlQ2xxWkhrVG5LMlhMU0RObDBBVjBNZUlKTWdob29uekpybTB4Ukhx?=
 =?utf-8?B?SCtxemZubkVab2ZnQ0psZEp5VHBjWUs4ZGEybmNPTW5PTy9qWFcrOVFLK0Yx?=
 =?utf-8?B?bTB6ZlcrTDdNQ3pUYVh4Tndpb0Y5K3VFRUZZMllUbmRreUZRQjBjNnI0ODIz?=
 =?utf-8?B?V1pOZ21DL1ltYjd0RXJYcUsvdEdnTE9FZ3RVRTlxZjRUMmpVRythU0NZZTFF?=
 =?utf-8?B?ZTJ1M3Z0Nm9yaENFSHZYUkhScXdBa1lXTCswdGtlUlZBSUI3NWV5RHhOdHJ6?=
 =?utf-8?B?eUpPakUwaUpNV3RXR0tXZ3BZaUo0eWE3d3Q5QWpCb2UwdHd5ZVFRY3NlVS9V?=
 =?utf-8?B?VG1NK01XOUFjQTdTblFQZXdpcjNGeU5EWk8wOGNoNk1hTzZXWit5RXQ4YmFM?=
 =?utf-8?B?Qkl6NnNLWlpxNGtwckl2aXNieFZUM1VhYjY5VzJPYUlwaGMrU0lpendaUDJt?=
 =?utf-8?B?djlqR1E5d3BVRzlweFBSUGJqajJvUW5icTllWjJSQ1JoL3dUakJtak53RnBo?=
 =?utf-8?B?QUdjdEJQNzJhbGxwaE01RDZYWHFTZ2IwMktDOUwyZnJZSWU2SFoybmxJam5Q?=
 =?utf-8?B?c2ZKV1dTWlREZjlKVEVlM0VPQitHKzJIVmE2cmpLdTFFTUxrWU5YRTN3ODlP?=
 =?utf-8?B?M09NTEhWUEZpaEs4d3BYbFVvOGh2Qm1OYVI0bVdSSzlCS0ZYVjBld2ZsaURT?=
 =?utf-8?B?RWRRNlUrdW92ektXbXFpdk9adXp0UGlYWUZmM25LcXNQaE9lWlBJWElCVTVk?=
 =?utf-8?B?RW1ZNFdpbm0ycmhpYkJJbmMxSm1DdVhxZ3VsMDNUaHQ4Y0F4NW5pTjVwK01W?=
 =?utf-8?B?TzkrVmlsNkdrMDVlRzJ0a2dQRWR2NnRHRWprN1RUSEYwdVRCU1hPSmRHaWs3?=
 =?utf-8?B?bzZkV0pvZy9uUDJwSnY0U3h3U2MrYUxQR3psNkVTSDBieU9qSGdWM1RNcWEz?=
 =?utf-8?B?Q0dpalNBenh3MXF3bFFnNlFRdElSWHRFUVNBWmNEVEM3dDgxc01VU0tBMlpK?=
 =?utf-8?B?R0lTeE9xTnRFTm9VZGt1VHU1MkIxUm55NVFydkJkSERJZFBxcjNjeDJ0MzM4?=
 =?utf-8?B?RW1uNGlmazBhcW9WWUoxeTFFbmRFYjdNblBzYysvZDRkTzA4MWF1Rm9id2hV?=
 =?utf-8?B?c3lwSmQwNThiNmFtdEtVNVJpcDVTL1VydVRZRWpYS3lncytWcWs4REo2Mk1P?=
 =?utf-8?Q?wR8RnJhjvtUg5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3663668a-d6f4-4f17-2a5e-08d927a977a5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 22:38:26.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzPkoym9UDq6sqYtDgSJMLNJ5HnX9Tyb1KQyomOApYYKbAswXnxJKtyXvWQRSUlHORwToHWToqON3Hrc+GZ9Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4016
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040155
X-Proofpoint-GUID: ioWf-sgQXrwCwPYq-hhcVFRxAcOmkipi
X-Proofpoint-ORIG-GUID: ioWf-sgQXrwCwPYq-hhcVFRxAcOmkipi
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10005 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040155
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/06/2021 22:21, David Sterba wrote:
> On Fri, Jun 04, 2021 at 09:41:09PM +0800, Anand Jain wrote:
>> On 4/6/21 9:20 pm, David Sterba wrote:
>>> The device stats can be read by ioctl, wrapped by command 'btrfs device
>>> stats'. Provide another source where to read the information in
>>> /sys/fs/btrfs/FSID/devinfo/DEVID/stats .
>>
>>    The planned stat here is errors stat.
>>    So why not rename this to error_stats?
> 
> I think it's commonly called device stats, dev stats, so when it's in
> 'devinfo' it's like it's the 'stats' for the device.


> We don't have other
> stats, like regarding io but in that case it would make sense to
> distnguish the names.

My read_policy work (which I suppose is next on your list for review) 
made sense that publishing the io-stat information locally from btrfs is 
a good idea. So that it provides clarity if the IO is skewed to a device 
or balanced. Which is even more essential in the case of mixed device 
types. For now IMHO,  /sys/fs/btrfs/FSID/devinfo/DEVID/error_stats
is harmless.

Thanks, Anand
