Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD224503E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 12:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhKOMBF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Nov 2021 07:01:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40622 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230170AbhKOMAy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 07:00:54 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFBmqYG001661;
        Mon, 15 Nov 2021 11:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rtTC77JI3uTRSP5rslVZzFcUcHsBgJipMjmQxHbnVjg=;
 b=kL/Mh1C3O2ggzvCasLMUTjo0DASGg9uz15rwQaaKbke8hBcdZ7xw/Kx14Uf6+Fo6pa4N
 Swgb0MiGPVC6yG/m3KBUpbLns8jGLQhBUIuYvW/9KmV4+aVfDCQTi13BrN8AVykE8wGG
 hEJqlZpaQKiU+TKhph+HCh87zaXhX2ydz8omPxu1MowNzo3UiunsazsUjzTUNyHNuVwM
 rTvSVWqaKgtGfij/KcMHrB6/Pm08rAiSW65jHp/KDK1gqRGZ4PoT6JcWDlRhcVlhAw4X
 snhu6jgBc8n2n69bWtasBqQC2QuuSpjuzTDib4Ve9Kz2Mx0kxfi6hSdC5VSaZlML4FoG +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv7sp53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 11:57:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AFBu9t3078384;
        Mon, 15 Nov 2021 11:57:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3030.oracle.com with ESMTP id 3ca2fueefa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 11:57:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQJk3wsVogH+TsM0Kqy/gM4yyH1ip4fnBIypfY0/i5exjIiINp7ksG3xhsWcBzw/2IWs5bU+Fqg+9GUSp3KRdaaXkpC+G5qOWzr0Koz8XmGg/QzG1rriSj3I4OTLRxErsdrI+w7AJoAtqx9m0xibrjcRq8mMcdn91Pb5Z7RTw2L5sTy/gMV+9jKD0IUuBKt2Rtm/9sJZtIm3FC4nRGG0ib3V4DE8aY2yKfL3/1pMLdcqC5lNfYHPcxuqmlXkCFmxO7ntB0aaQpPItq/m1dvAdu3wET9fxtacpWXQ8TJy/xwzfr+DNaBBHmQ0xQlgRIHaMqay6/U7ih9fW/Jq4CWe4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtTC77JI3uTRSP5rslVZzFcUcHsBgJipMjmQxHbnVjg=;
 b=b3w6nbV+9Bcu2O0/QYtUAWfkBG712G885VPuyWEu2FqTXbDpTi9UL70sGyDqVkckJj/Ake4SbyF4Uq+Ymw7DISmz2sChH+zuukaRYbxU0/TP92fqp0eUdwqHsCDDQEhaK5S/U9rum1PV1smnGmqHJS627zpGiYfB0Mq5cM6ATnLuzTweumlOFhXUafXJwk57ogmTZi/KJJErUmqH6WT+iJImGiNPhwqaWNY7zsg0gTY82iuRcNL3zyD83P3mX6ZykS6xAg8iFZxjnNxuCp1UAPYTN7CPAIL08+pgXw8l+FrJ2OxJKAWtAthyVQETpyN/q5LJrtNE1DEB/Vj//NgeGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtTC77JI3uTRSP5rslVZzFcUcHsBgJipMjmQxHbnVjg=;
 b=tMtx47MrEQ6wMbcangL0rl9mHgFFDSSTkHePVC9Uq0xaCKqDEc5GSbZPsTUu5sXntITkx3Oiitbz4xBfYjkiZirR9EtPamt1x0G7GTxQ0W3hX+cbgWPwjDa1nOtUtEFUO005eStYFY03krRBRdA7x7lQIr3+8H2Kes/woGmGcHk=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3790.namprd10.prod.outlook.com (2603:10b6:208:1b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 11:57:51 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 11:57:51 +0000
Message-ID: <cedc5f30-3e26-8a5c-b017-07e06cec315e@oracle.com>
Date:   Mon, 15 Nov 2021 19:57:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 0/3 RFC] fsperf: enhancements supporting read policy
 benchmark
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org
References: <cover.1636678032.git.anand.jain@oracle.com>
 <YY57fpO88z4I0irk@localhost.localdomain>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <YY57fpO88z4I0irk@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.5 via Frontend Transport; Mon, 15 Nov 2021 11:57:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18fea8d3-0c17-4883-132c-08d9a82f2632
X-MS-TrafficTypeDiagnostic: MN2PR10MB3790:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3790F7066A16E93844CCCE32E5989@MN2PR10MB3790.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjgTEaP4IE0Gm8wngLTiJlhhtYfwYZnzEV9HUfKraD5yDjsp/R5GfuoiShPGO6uGTFAV/KZ8nKtmpdtD6bM++9o2AtTH2TTTfUpIKecVbIWqbZ1vONW3P+H2zbIZQbAu5X1aHIbcPKHgIu08gZhkQiUdvpemGbVKCFmK1PcpfIX+tt68jgeIorc/eU+S8uQzkQGJQPzkNl1T+mflY/TeayT23qiDMqb4z/SoxbsR3lONnDpd5MctH13wMwQrgezT3497mikxic467P4YAG3TVeUMietzpCXHw/wgPJLCS1KarukegaZ4KH7mXLvS2trlOWyS6A4K68dKnsXWqqy+4UgU9ve4Wsud0dUuSd2JtG9vCAVSg4L4aK9ZAg9Rv8nN8RmVbF/iE73UN29vI8vSe9/xJU+SDy409IA+D+uT3RCDX+vq0VNHOHoBSGC9lXP7ibhqlAkd2bVGsd2aytwj8k5Nhr3coLVGq87dKVkCtVOfy7QzGtnY4G8TweIVPdZYKgZsNm7/rULZA0B2nB0yqbWqnuZl186HarlQYjA7bpF1ZaeAjDoHcR9hJC9if5sgSYvtyfrDd973sPGyH98pyVBEbA5ybzwgJbPqywJsjGqvNQdlBklJX17akqLceZKCUr1zWLquUVZ34+gG0Sph2tOrXPbASXficrYvHZZIGEETne3HE3IgNawmUv52d3AzzN9VrxiU0sVbX7RxGX2kHfqym7oLAKHtMwOgjQPMAsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(66556008)(8936002)(66946007)(8676002)(53546011)(31686004)(4326008)(6916009)(86362001)(5660300002)(956004)(44832011)(2616005)(6486002)(66476007)(2906002)(26005)(4744005)(36756003)(186003)(508600001)(31696002)(6666004)(316002)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUI0cVJZOC8wK1FGVkxBdnp3eUZiSHhwTjFOQ3dlQ2VETjZIcTZKS09mUExv?=
 =?utf-8?B?emhqYkVJL1BTekVTRTFmUzhjdWhSRTg2QXFGZDcxaWJBdmdQRVN3R2h1Z2tJ?=
 =?utf-8?B?T3ZITDdpcVFUZUJqN2lOZHFKVFlTYWdvSGRaUTZTZUh3ejl2YmFkT3ZoVEF4?=
 =?utf-8?B?YXN1aHgyaUNIQW9rSFhzUURZdnNocyticFdqKy9UcURVVy9LVW1IWnNVcFha?=
 =?utf-8?B?bm1GeEZnMm9QT0hOMGZCNnpDVWw2bTZZU1JZUTRBRk1JeHhKcmNZM21uNmFV?=
 =?utf-8?B?UHlEa1BFdWRWSDJSekxRSXAvYUtnVy8rc0hldWtDR21ha2tieVFtZTdGaDFX?=
 =?utf-8?B?UlhadTZMREdKdmRaQ0tUdWFLcFV3RjlWZHZod2JuWG5nUDQyTGsrT3pTRTRX?=
 =?utf-8?B?Rjg5b0x5KzI3T3ZNS04zdkNVdHlTdjhBRlBqSnE4NDZKd3VNNmVCdkl1QUFC?=
 =?utf-8?B?MGNibG53MndRWDc5TStPZlU3UG1YbE9vMnNWcVBJNWw4VmgrUzhEa1docGlW?=
 =?utf-8?B?ZUlXMWN5MVJDTWM3bWp1MVJ0dXBnckViYmY2T0UvZ2ZUNndhNnJ6K1BjLy9s?=
 =?utf-8?B?QlovbWwzdHMvSCtna2F1eUpsUUhoaUVHT0s3dVFwU1hKUkRuN2tuRWdCYlRO?=
 =?utf-8?B?NXZQaGhKbVFBME43ZmJsT1diRmdrbTlnUFR5K3h3VCtlbnVrUlBST3ZJcUQ0?=
 =?utf-8?B?VTdWQnJTZnV1UWEyaUt0UStBNG02aFQxUUErLy9GbVZjazZMWFMzK1hZeGJw?=
 =?utf-8?B?Y1lZYk9XOC9XSU8xWWlLbmxibXhXc2JaTnVBTmIvRnlXMlBsL044SkNHMzJr?=
 =?utf-8?B?bXBvYTVGWTFieFBpcEhSWVJEN2lYZ3o2amJyc3pucTYwK092V0tlR2MwWDhM?=
 =?utf-8?B?WGdOSy8zZUo0cXNLYjV5alEwWmdEQTgvZU5UNVlBR25YaW5YWXlWWmk3a3Zv?=
 =?utf-8?B?aDVDd1pJa3VDcWQ4NzgyOHVDeWhhemRHSjNFZm1iK0xhdzJkSHM5OHd6anpT?=
 =?utf-8?B?TmpPNkpKOGpZQUdpQzZRbERoMWg4UGtFWUVYQlA1eDFPc2FEdklheUt6WGwv?=
 =?utf-8?B?WVR5cTloTWVrZThYOFNEK3lKWTZiYVc3VGI4UzMzcXY0bWlQVkpMYkJqUzBE?=
 =?utf-8?B?aGlCbGJaY3NxTXdORnF3TVpUbXEwUU5DZ2s1a0d0ZGo3Qm5JcXhPcmNoSUQw?=
 =?utf-8?B?cE9WdTgzUFZ3Y0hoRWg5TUh3dnVscEs4V25QQkRNSGhDTE1IN3lnQVAyYmxJ?=
 =?utf-8?B?QTRXQWxMMVZyVUhjWUdNd2dSZURzRnlHYlU3WjNyZWM5UXI4ZjJFRVdIWWhk?=
 =?utf-8?B?YnAxR3ExcW5PdUFLemtFQ3d2cExRdkNpMnYwTDg4OEhacmtXL2lqNzZDQTc5?=
 =?utf-8?B?WUxQM2VqVlZHQnY3Z3F6TFZQeEFBNWRNclhPRVdocWFrcm4yTEhGU0hNMU95?=
 =?utf-8?B?d1B1UGZKTGx4QzYzcGoyMlhJdkhUSTFSK3BlK1FPTmJZMjV0bEtBbjlvdWpK?=
 =?utf-8?B?b2xZQlZydE03SEhoRnJ4amFucUJ6ZzV3aE1QVCtZSnBBS3V6QVFqaUxlV1BL?=
 =?utf-8?B?aUdiSG1sd2l5c2U4TThiWnZaaUVaSG93aG1lWXJSRUN4cmRBT1NjUTNHdzJu?=
 =?utf-8?B?SmVkQlJUdGVpbFdhZ3RwQUhVLzc4eSt1UnEvNjBPM0N4Z2o4N2wvMHFvVHZa?=
 =?utf-8?B?SWtwT0VZYWNqTzFMRnhtK1J0cXhFeHFHTzZISWI0U2ZZQktOYk5jYXREQ2Vs?=
 =?utf-8?B?K1llc1BCRzY1QjRPQVJsK1VGYzdYNk9kQlNlNW1tak5KMFJ5Lyt4Y0dLcUxP?=
 =?utf-8?B?TUJqWVd4TVlWYW1CYURoYUI1U08xaDhzNm91MzRXQTNkSElqNXU1SnhocUt2?=
 =?utf-8?B?c3lWR29ob0xaWi9uTmZnbTA2azZjd1RmcEZoOUFDU1BpWkJDTW8wcWVLdmJl?=
 =?utf-8?B?ak9DZkFxNS9NT0tHSUFzc1dUdUt1SHd0UDk1Nnc3UU0rVG5PUTBkdmY3dHNl?=
 =?utf-8?B?S3prdUFwYmRKMm16MXptUnhqcnJrZ1ZLYnVjaGNVZUp1TmpqQVl5VFJTMVY3?=
 =?utf-8?B?dENkYkV2UFQwN0VPVXBIWnk1UFg5S1oySFJGanZRRUdGOFBudHA3RFlwaytv?=
 =?utf-8?B?dHVONC9qbGl3UEUybUxudUFocjhhQzlvcG5ZczFFcDBKRDM0S1ZNcEFHM0tK?=
 =?utf-8?Q?WAHBbUAJ5bHlACn/BhAD3rQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fea8d3-0c17-4883-132c-08d9a82f2632
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 11:57:51.1303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEgbyrRqebQpgO517BO4+c3F5CS7TEo7dwiAGJ8nxZxGROTkHDx9to9DoK4tc3tmQ7U30IQ6NEfefpZpQekApg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3790
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10168 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150066
X-Proofpoint-GUID: MVISlUsTmDyiHEoKWYKf7rooOJBvVZUx
X-Proofpoint-ORIG-GUID: MVISlUsTmDyiHEoKWYKf7rooOJBvVZUx
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/11/2021 22:34, Josef Bacik wrote:
> On Fri, Nov 12, 2021 at 04:04:36PM +0800, Anand Jain wrote:
>> I am sending this early to seek feedback on the best way to benchmark
>> more than one read policy.
>>
>> Patch 1,2 adds helpers to support a new setup.
>> Patch 3 adds a generic readonly dio fio benchmark script.
>>
> 
> This looks reasonable to me, the only thing is I'd want a way for the setup()
> part of the test to see that we don't have readpolicy support and simply skip.
> Right now there's no mechanism for skipping a test, so add that and it'll be
> good.

  Right. I have added it.

> Also you can just do PR's through github if you want.  Thanks,

  I included the above changes and sent a PR for this.

Thanks, Anand

> 
> Josef
> 

