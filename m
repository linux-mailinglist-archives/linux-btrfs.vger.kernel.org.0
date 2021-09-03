Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62B23FFDA4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 11:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348912AbhICJ5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 05:57:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:43250 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235067AbhICJ5n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Sep 2021 05:57:43 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1839Nx2R029834;
        Fri, 3 Sep 2021 09:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IgyKQFcC+ASwiCh9p6YduN7Yw2WMuaqNPC2Z0rur518=;
 b=OLBOpvmZ59ImHkSRgxu8yS3ijCCEcBf4z6EF/DTZvLAViZOIBRSEStu3CTbYgaSFEYXf
 3DmMeTOLeUyJEKRbO4ma3f+KkRVK2DjchQkmU7zhG/l24iR7te3TkyQhWm6pFbEWN/7Q
 CqqA8AIeAZtDpeIjA+te6fOqaGsP1DkwM8BoIwTZIE3QVYYWjIdym0uJ/+NF1w5UT+n+
 SqNnpl/Z4reV+CHALPyoKTPWekKbW+2MP8mxGkth1UuM3hbMkWo3LBa9CwaXw8Gk0diF
 uqIPwNBx+BHNhC6rN+XfdKdJ/xAokqAl5mLJNEqQFdi8dIh9yNigByw0LsH0gInaxL0S Nw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=IgyKQFcC+ASwiCh9p6YduN7Yw2WMuaqNPC2Z0rur518=;
 b=w0feLRIh9HR+yE4z+KEh0AQG0cMpRfyl1BeUDFtz8EcT6JWwMnkA+COPlQ4jfjuSoQC1
 fpp4h7bQ3wvxI++QUWPNhcpsI/end1oc4F7ChetaA21lEUU2mZBedxOXFXkUp5xEJRTb
 dAd89CCrtLCcD6rrUrfkOBGds2PJVaZsGZ5W3QtwFcTDHam4Yy5VLf9osQ4nmel4WssS
 egqCWrnivyfRRw5eKQh76ELoBKIfJZ6NkG09hZ9Dw5VFKUqYByJUWkQumY7jgVxr9zHz
 EDwqUeIubW+5SB2Q8n2SeI1HSp5KQEWqoF2ns5efDyCtK8h8VQgocMqw3cW4/KL3AYBd vA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3auh1r024b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 09:56:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1839u5l9076314;
        Fri, 3 Sep 2021 09:56:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3020.oracle.com with ESMTP id 3aufp342vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 09:56:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjTCtBpKUvDeHFeB0J1XVlBq08IW7gHyzVQAdiwIgTG77xlclr1m8cT3Y3XWYiq87K8K08Eo++Z2nsoiL+mbNTPQb8UxAp1cF92gB8h0ZjsG2HQ39budFkKqlMSKFOV7erwDslBJ+kSRY8IhoIXGg6qlKnUTdFZuss/nuPuUjRdtiRoFpuYVE3XPjxellIZNcMIfYYLLcs9W4CreciGH+rBt7vT+Sc8uS0k8p+ctn0AYMDUXTMSU+OygtnQKBlK71r9d8T2b96DTUQI9jnM84itLpBAFYMdFkdK67uUsPvbiPKcS5jQ8sDQtosoOScDU6enhBLYrMIsXPaS+d8e7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IgyKQFcC+ASwiCh9p6YduN7Yw2WMuaqNPC2Z0rur518=;
 b=BxIyGMxhD0RvoVU2sa4NNIqKCX9oybh0iDJPFNY/vjN7zEZ1umU2GOFAJJVCvwEz4Ct/02+DZjTDtzjnJ9Bn00uuJG0p/vutCYEAjq9Sxlsp46AnBQ+jOMHU0WsAJUaMFoKxO5Wr8zz994NmF3kHFvLa/CITs9+FdgFo8tAJtOZdHuqc6israylAwLFjwL1+Uw47c4aLPMMAfsupSpxiS3SOz4B1sYfoY6gvLhI1QeUfLKX4doLH8AWGygCPfeQed7NunRy8agO/dJmLwusWTjq4et7W26AaioNTrFxlWP6AJJMc2IzaZ4G5AQybbWN7LoGoAG1PWyHkfHey4MS7ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgyKQFcC+ASwiCh9p6YduN7Yw2WMuaqNPC2Z0rur518=;
 b=iml6+tNB7XqG8spUn8+xvUkYNunG31ZzBgRzhoZog0HZuOJAm5aVUp1x47mBV8RVXHJd3qRolxAY6RtVYrqDKsW08lqTxHkHl4o4iWYEhFqXYMMyxi1Mb4B/conQVOvMvR9iOZ0aU6gqjodqstr+fM3lFu4RnLi5tLevojot6cg=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 09:56:36 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%6]) with mapi id 15.20.4478.020; Fri, 3 Sep 2021
 09:56:36 +0000
Subject: Re: btrfs mount takes too long time
To:     =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Jingyun He <jingyun.ho@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
References: <CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com>
 <ce0a558f-0fab-4d52-f2d1-1faf4fb1777c@oracle.com>
 <CAHQ7scVkHp8Lcfxx2QZXv2ghkW-nYpiFGntyZa0Toz2hU3S-tQ@mail.gmail.com>
 <b0feb23e-4a18-efd7-eeaf-832ef0cf6860@oracle.com>
 <CAHQ7scUiNLVD_4---ArBet-0DqzfmmH5Y9JgQY0grYrUv8yhiQ@mail.gmail.com>
 <c2d2a244-f77c-e0a4-d266-db011fc4154b@oracle.com>
 <CAOE4rSx5+9jXEE2ra5qYOiZWpVU=EcB1MadEf_35fa0M3MZyiw@mail.gmail.com>
 <a0990c37-0b94-53e7-051e-ee7667c4bc94@oracle.com>
 <CAOE4rSzkodTb0DFOS4C1tDU-7PVie9v5Sa=yTHHKS5YWQXnKMQ@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <bece5217-8bd7-11f6-9cc8-888a40966a22@oracle.com>
Date:   Fri, 3 Sep 2021 17:56:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAOE4rSzkodTb0DFOS4C1tDU-7PVie9v5Sa=yTHHKS5YWQXnKMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0146.apcprd04.prod.outlook.com
 (2603:1096:3:16::30) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.109] (39.109.186.25) by SG2PR04CA0146.apcprd04.prod.outlook.com (2603:1096:3:16::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Fri, 3 Sep 2021 09:56:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f83cd7c0-c197-464a-6112-08d96ec11df7
X-MS-TrafficTypeDiagnostic: BLAPR10MB5171:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5171C7DDD1AC988AB6770270E5CF9@BLAPR10MB5171.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yYHUbg24JOl8eGsj24uueKy0s8Ixtyw9VlQyGO72qPlfh/uw8sRaBBeDb4j/pB03cnuyiV671Vd1jmLkA1y1DtVMMyyI86cSzpKAX0/DZ9F9L3abnO6Gtt40jhmS7PrcEPp+5ydy8kcVc+dzhaudX7wPpSCfQ2B69/Zc0QIIUUrf+MKCo17aoOYxh/g8Lf3rNguOKHj6rFmxe+exvbq8YebG/Tw/1psp7wWJXIHM2rov97/MO+VtpBxIWEBU3zo4OJ2aar5r2fZekPY4QXCELMCjZlJk1n2IO6xVHpuDXz4CwtIIpdc3Vv6rMYLXdZC+uKiyrwNdQRyBObT/vku+CEG+WsrE6cpoU1kuEQNl+sqqf3GvJc/rF0fIUBSfePtHw8j9OvLT3ZtiHnCOLCpbzmd44H/WQkOU1mqvBRC9s5VvrbECb3uacJpENM240gY6v+3YYQc3OwTE/yuJcC6r5+yLnQNqfbEYJ+EYH+/esrJV6kYMkd2gf5hVh7HjyEhmAP/KGvNQDDNjf2uwQ0NP1ZSA6WRmHlbx8ItIPHY/XJpIh8OrB0hartgiOY5gWSwGirFAJqMFUsN3WtTIWKhbXOkTob7JnaM182g9zSaBR+mMKbTxcP7DAw9eumkah6XtZ9+Cz9snFCFuajQ4GTIH/vTswZviQ5xtoZDRPAuAToaKSu4U3fiA3Goed1syKqx/qsWAtW9vX7VGfR5bfcI9qslMaR31V+18fkspaFx1mJN79y7wFdlhsHNYIcZZCblXE4C3btkA77oKOREQacq+57+T4aOBRysN2qx+30mbnumNBlWuEM8YszCOI0JbNwO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(346002)(376002)(366004)(2906002)(83380400001)(53546011)(86362001)(186003)(966005)(31686004)(956004)(4326008)(6916009)(8936002)(31696002)(5660300002)(66574015)(66946007)(66556008)(38100700002)(66476007)(26005)(44832011)(6666004)(2616005)(36756003)(478600001)(6486002)(316002)(8676002)(16576012)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW11MWQ1ZlBKUW43L3hvZnIyYzJlWWRkZGM4L1hCU0lTcHNncWpmbVlOcnI2?=
 =?utf-8?B?Q2VrOTFwZTZGMEE1K1M5QmVoQjBaUm5GL005dU1QQmd4YUQzblpXN2c2cDNG?=
 =?utf-8?B?VS9XUWg3cUVXOXVQL2E5YSt1aE5FdmpjTDJaaUQ5UGtnZGJoVVdIclgzM0dP?=
 =?utf-8?B?M01FcVRLNFUvSmM1UzZyOHNVTUJFT2llN2pPcExJZzlFcDF0d3EwdnlBM0lh?=
 =?utf-8?B?U2RJajgyZ3lIWm9Bd2ZTS0szdUZ2NmJYUEtCclIzQlI4SkFNK2RFRFcxWU1W?=
 =?utf-8?B?SHhrckpiZUtORXE0Sm5SempRZFpJTThGWER2ZDBad0RXOS9OLzBxNkVmd1Fy?=
 =?utf-8?B?ZHo0MVQrTHdtbFdKWUxFdFBSUzVGY241RHRwaFFTa2VjK3QrVzhESTA0Z0xq?=
 =?utf-8?B?SGJLdEJUQXZTUDhzRExib0JGZTZUc0JmeTNQL0g2amVxZHRHRE1jb0ZVWkdT?=
 =?utf-8?B?emtMc29IRk1TNDhNdXh3Q1E5cFV4THFoak56Vk1OZmh3WHNzdXd3d0Mvcnlx?=
 =?utf-8?B?cmFEbzJhK2VuWDZPZjNGZUlLWkFJNnJmUHdMNG5hdkZPZ2NscGhFb2k1ZHZu?=
 =?utf-8?B?R05wMHlzdEVDejhtZ0RhaUNDRHJnVXI4SjY0S0wzWXJ0blMzYlEzb0JQOXRP?=
 =?utf-8?B?dGsva3VOZVVWdTN1M01mSHJxT3Z4ajZNVTBuSWloVWJ0TWEvdTJIQzZFcjFz?=
 =?utf-8?B?RDJNWlB1bGJiWWphWlIrNE9FRkxJYmZscTdTdXRMRTBoc29RM0VUTkpCN1dL?=
 =?utf-8?B?VDZkSitkR0RNUFMxSERPR1Mzc1dpSjhVRC8xM1ZXckkrbWx4RytWdUlLTmg0?=
 =?utf-8?B?dGdCOWFEcTJMbk9JbFd4clB5V0dQQ2JiM0NuRU0vZlJzcEFIZGJDKzRLRHlo?=
 =?utf-8?B?ZGN0MlVrWWNNQk9adzFnZUpzbnpTVnowSkxENWFRd3dLWU9nNW1yMDVFNG5Q?=
 =?utf-8?B?RDVueU5nUG1CcTVXbnR1bHo4NDRGbGlEKzVNTnRXYWc1c0tkcWJuUHkvbnFh?=
 =?utf-8?B?UTRmZ2RiUjNWSmVzTWliRVdXd2RSMkE3eDRtcXRCUlF1ck8wWSttRmp5L3ZP?=
 =?utf-8?B?b2Y0SGgzVDVwWVIwa3gxZEN6WiszSlU3aHFHMk0reldrZGhDOGhmZlFMNFpO?=
 =?utf-8?B?Y0xESXBNT2RmeFpueTB1WFFDN3lncFVCY1crbVJQOURlQ1ZQejk2NFJhc29p?=
 =?utf-8?B?N2pIRDVBejcva1VpSWxLbW5RNWV6Rnh2eDVva2FTLys0OHdyZURMQXdybXdC?=
 =?utf-8?B?RlZmbzNwVWxWTjhvdjNHZXJNcVBEeTAweEd1QUVPeDluWkp4bDBpWHN4dHN2?=
 =?utf-8?B?STJKYW9yUnc0WmpGZkZzbTRKMG5PR0NDZHdMemxIdmdjUGpqNTVpVll1b3dk?=
 =?utf-8?B?d1ZxMjVaNmtkQ3ExLzZUeEF5S0ttcWhUTC9ySzZpK3pOMldPNU80eWp5eW9s?=
 =?utf-8?B?TThDS3RGbHV4UUNid1QyYkRWRGlockZNSnhUOFcrOWlEZ203NmZDc1lsOW9T?=
 =?utf-8?B?WFF2Z2tIUzVvMEdvYk1jUEoySWY2UDJrS1I5ckRHdmR3V3M2aG10WnVMN2Rv?=
 =?utf-8?B?Uk9CQ1FVSExpSXRhODJjZ2NyZGkxek1HMzJJK3lKUXNuSytHdExraTVPZ2Nq?=
 =?utf-8?B?TlNoN2tJUVgrc2NMaDVpcC9NdkpaNWlqV3EyU2MzYWRuN0tML3FWMnNJSmgz?=
 =?utf-8?B?bmdWbnk5RkdDc2NqWWRjOEFNN0tVaytkUkpZNHdEelVOQXdCK1dhN3E5RUht?=
 =?utf-8?Q?X+y32ObPe/lfrGR1VRP3+Od5oakBH1jsUPcvIab?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83cd7c0-c197-464a-6112-08d96ec11df7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 09:56:36.1614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpb00iIe+0VLLh9PDnlmFFT8/wrg8jVZj9r+AhV5XlKIACyeTSH3vttpzoBtOQMVQJpEm2a65g5XR4E3EySnUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030060
X-Proofpoint-GUID: rfXuqTlk_xcMFcduE4Uha5pnYEQtSVHA
X-Proofpoint-ORIG-GUID: rfXuqTlk_xcMFcduE4Uha5pnYEQtSVHA
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03/09/2021 00:56, Dāvis Mosāns wrote:
> ceturtd., 2021. g. 2. sept., plkst. 00:31 — lietotājs Anand Jain
> (<anand.jain@oracle.com>) rakstīja:
>>
>> On 02/09/2021 00:11, Dāvis Mosāns wrote:
>>> pirmd., 2021. g. 30. aug., plkst. 16:08 — lietotājs Anand Jain
>>> (<anand.jain@oracle.com>) rakstīja:
>>>>
>>>> open_ctree() took 228254398 us. And 98% of it that is 225418272 us
>>>> was taken by btrfs_read_block_groups().
>>>>
>>>> -------------------
>>>>     1) $ 225418272 us | } /* btrfs_read_block_groups [btrfs] */
>>>>     1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();
>>>>     0) 0.967 us | btrfs_apply_pending_changes [btrfs]();
>>>>     0) 0.239 us | btrfs_read_qgroup_config [btrfs]();
>>>>     0) * 21017.34 us | btrfs_get_root_ref [btrfs]();
>>>>     0) + 15.717 us | btrfs_start_pre_rw_mount [btrfs]();
>>>>     0) 0.865 us | btrfs_discard_resume [btrfs]();
>>>>     0) $ 228254398 us | } /* open_ctree [btrfs] */
>>>> -------------------
>>>>
>>>> Now we need to run the same thing on btrfs_read_block_groups(),
>>>> could you please run.. [1] (no need of the time).
>>>>
>>>> [1]
>>>>      $ umount /btrfs;
>>>>      $./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount
>>>> /dev/vg/scratch0 /btrfs"
>>>>
>>>> Thanks, Anand
>>>>
>>>>
>>>
>>> Hi,
>>>
>>> I also have a btrfs filesystem that takes a while to mount.
>>> So I'm interested if this could be improved.
>>>
>>> $ ./ftracegraph open_ctree 2 "*:mod:btrfs" "time mount /dev/md127 -o
>>> space_cache=v2,compress=zstd,acl,subvol=Data /mnt/Data/"
>>
>>    It is better if we don't use the time prefix for the mount command
>>    here. The ftrace, traces time syscall as well, which is unessential.
>>    And we lose a lot of trace-buffer to it.
>>
>>> kernel.ftrace_enabled = 1
>>>
>>> real    1m33,638s
>>> user    0m0,000s
>>> sys     0m1,130s
>>>
>>> Here's the trace output https://dāvis.lv/files/ftracegraph.out.gz
>>>
>>> The filesystem is on top of RAID6 mdadm array which is from 9x 3TB HDDs.
>>
>>    So here is a case of a non-zoned device.
>>
>>    Again it is btrfs_read_block_groups() which is taking ~98% of the time.
>>
>>      3) $ 91607669 us |    } /* btrfs_read_block_groups [btrfs] */
>>      3) # 9399.566 us |    btrfs_check_rw_degradable [btrfs]();
>>      3)   0.922 us    |    btrfs_apply_pending_changes [btrfs]();
>>      3) ! 186.540 us  |    btrfs_read_qgroup_config [btrfs]();
>>      3) * 26109.92 us |    btrfs_get_root_ref [btrfs]();
>>      3) + 23.965 us   |    btrfs_start_pre_rw_mount [btrfs]();
>>      3)   1.192 us    |    btrfs_discard_resume [btrfs]();
>>      3) $ 93501136 us |  } /* open_ctree [btrfs] */
>>
>>    Could we pls get this?
>>
>>    $ ./ftracegraph btrfs_read_block_groups 2 "*:mod:btrfs" "mount ..."
>>
>>    Hopefully, there won't be a trace-buffer rollover here, as we saw in
>>    the other case so that we could account for all the time spent.
> 
> Sure, here https://dāvis.lv/files/ftracegraph_v2.out.gz

  Ok. For conventional devices, it's only btrfs_search_slot() 
contributing to the mount time significantly.

> 
>>    Also, let's understand how many block groups are there.
>>
>>    $ btrfs in dump-tree <dev> | grep BLOCK_GROUP_ITEM | wc -l
> 
> It's 22660
> Also by the way `-t EXTENT_TREE` should be faster
> 
> Best regards,
> Dāvis
> 

