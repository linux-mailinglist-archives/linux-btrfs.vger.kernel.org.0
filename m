Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC943447344
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Nov 2021 15:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhKGOVo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Nov 2021 09:21:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36786 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229683AbhKGOVn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Nov 2021 09:21:43 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A79dlV3013888;
        Sun, 7 Nov 2021 14:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BWjG6+CB4FRVTpTK14ZwJkkogpPO0NKwyxWli5BNcio=;
 b=GA/ewwkf9UVoWCIBTvZti+dNtE7GldDyytJzqNt8tnCgDwdUkE7Ft5gDd/MlrccDWvwY
 HXcwqCmvpT5I8L8FeEI+Q6Z13AQS3OpYXhN4XCkSW2h6ZEdRp898iOEDryOvzHfRBIa5
 sf++PY6uBOzwz87KOD4fFahPCJfyvMmNtxYpm82Vt8Y0muwJyOPhI/VbXS2gW5uUNgro
 w6XBd8NY6yuKTDNQaVRbefyaVBDgE84RFTn+tlzF/xLUQvzaSdwK0KqDAnyq4JiLblyf
 o8uZGI00DtUL4ykMSZe5kjxDaxWy8j0XBPHtR+JrP91FJHLSTy5X7hOkiM0ikkkps3+N 8Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c5gg3kace-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Nov 2021 14:18:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A7EAAOj107965;
        Sun, 7 Nov 2021 14:18:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 3c5hh0y9ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 07 Nov 2021 14:18:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSSs4G3CKQ8v6lBPvHYl5wUy47uD8oWQfXuY3Il8g2a5xODHASd0PH3jX1fSF3vQ5ag6wcmmGixDtu0X4S0ydC6sT5mxvWkw7+dDRSiVpqiRbh5UsbmbzlyEuti++CE2iBZzZ4qnIzKJP/H5mkIlgEwpe1ZnDsYkgIXgEPzg3HkFBQl2V3eb1LXMCSFh981E8Kk0h8pD8JVjjY1GfdYeL4NFFlF9Ooq0q4J5pq3u+WtC/QeDYCOjXIc7UrX1VyWZDomi8BG+hU4bKhjfS3DEQDr+BeGnJKJOOA/9ZABcMrxMwOuU1WUFfbrNtqfL7jsyVsgUgSziZo1aRCn++1widg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWjG6+CB4FRVTpTK14ZwJkkogpPO0NKwyxWli5BNcio=;
 b=jq079Yp5LDhUun4ryhmRz3eFz9KPFdPzgM/E7nHUshYimeA0LZCi+cj1MxgP97wK7QpFiPHH4n93sEb7X0xhA+gPywwzxNwrpN3oXGGERGspnyyvgF/OtBiw24R/P5h1jMMV8570LqU11DiCHiBDV8V0g5l5U+AjTFU29HGLsurMxffkR5ZT9MHqVGuEWunegk2NGmtOWw0ioeSCnQxLjVo1R/9N4nJjDWAxukfRDej5XXqHYs6C81S6wOmKCNgkr1N7u/PQGIBVjDEIyuHXDjvH0TFtlimRH2hcOPt77miaU9K1OkHebYRqSImTG7PNld0WFKZFt/gabf0AUCa0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWjG6+CB4FRVTpTK14ZwJkkogpPO0NKwyxWli5BNcio=;
 b=wvw/x+P1wazPn/mfLn2h8AqSLrQa2SnA7X3LptUl4wBwinZlbQYZ5NNnbE3+HoE0C2F1UUREXQBL5n4uDC4L2DRhz4M71nKzxT/kP+GqvXU9KeTLYtw3drxHkrmjotJJ+9ZJOODAsd+/Lz2JdU1tCCjz/A6t+3EKm06Bh/Q8YAk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5169.namprd10.prod.outlook.com (2603:10b6:208:331::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Sun, 7 Nov
 2021 14:18:50 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Sun, 7 Nov 2021
 14:18:50 +0000
Message-ID: <b4f76b78-3ea9-949a-b8b6-253bb8f109ed@oracle.com>
Date:   Sun, 7 Nov 2021 22:18:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] common/btrfs: source module file
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Cc:     fdmanana@gmail.com, fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211104203958.2371523-1-mcgrof@kernel.org>
 <CAL3q7H7=eKNTqY70cOfurxBqTetWcjkbTVKieBHQm4+RuJ1-hA@mail.gmail.com>
 <87935890-a607-0d14-0a6f-a16b7fa84988@suse.com>
 <YYVTrl88M1c9bgnm@bombadil.infradead.org>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <YYVTrl88M1c9bgnm@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR01CA0009.apcprd01.prod.exchangelabs.com (2603:1096:4:191::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Sun, 7 Nov 2021 14:18:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c314043-eb6a-4624-733c-08d9a1f98539
X-MS-TrafficTypeDiagnostic: BLAPR10MB5169:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5169F04C2E75B5BCF2AF2BCAE5909@BLAPR10MB5169.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPq1IjnH8TmQ+FJfHc5wQQWYxttTZszxOnvCUzJn8XWSHpNm0sYmh87+t6MC6gyURX0slOjMdVCN/Qa5Sf+tSviNBls9z2a6uwUBLxGJp4b/YkRw9N9Fl4ipfuW4YcqeZZ3mV0Cut1NXzIdfWxCrD9FSeqS2tRymCJUe8aqOYQGn+5mqYiDBzti+D84vI7641629qXMIKPw8gytpwroGjaFDTD6jtkNnDcnOXTF0G68DJYpiC+rhWuRY9BYUAC8ING/K/9hMDZrwYzucFB4YkYOTuJ0BXnu/IrztGBa0Y+dtrTF1O8yobhSDerLw34mxUpyX7rYIEValf/AHY7JYxjFdsjEh5Njm72vaeo3+F4HnJoLtyMOq6ak/+W/DO3aALcfXB5RzG4Oz6sLgoFxQk6FaIABgyT2RqN7IplxFyry++TXB54P7+fe1+57jx9Ip+9ezXfXI22WIXgmmgBu5t9BG8H2RBGbjusMuCYZHGGs90igN6cH9hR6Z+LFsqls0lnJ4gGGeSQZVCUN0cF3LcmaY3zkOLlgtz+A5Q6986ao6HSbdfOXCPrrhDS4AIfydRwxbdF+uIakS2npZzdAiPKZcrt2BSGWQrQNt7f6MYZcgyyrylz/0VubaG4p5F+aJpBFBT7OE5cpSo8jyg6BkwwDKRHyyA5iAC837FdHzsRwZIgdQBWwH2KZcONH0PGfPTCqZo5DcM0JE/13RDSIdtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(6666004)(66556008)(83380400001)(4326008)(66476007)(86362001)(508600001)(26005)(53546011)(36756003)(44832011)(2616005)(956004)(186003)(6486002)(31686004)(316002)(16576012)(5660300002)(8676002)(110136005)(54906003)(31696002)(2906002)(38100700002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFBFeXdCT3JlWlg3M0pTZEhSTUFNeExTMklSWjA2S1Q2OGVMOS9vby93dk00?=
 =?utf-8?B?Uk9BNGppQW5aemhvOCsvbjM2cjVrV3hyc2V1VXM3d0ZPSkQzYlRPV0l2eFA1?=
 =?utf-8?B?R2NwYVc2LzBqTEczUUJZcHFuSTVDU1p2MWJXbmJBSC9Nd2lGWUFuN0JhY0lR?=
 =?utf-8?B?WXc1a01sYklvWjZJeWJEV3p4NnBZOWNSanRQanhaUXZqdEJxUUd0elRkTDJZ?=
 =?utf-8?B?cDJQTVBobE4vMlV6ZzlkKzRPNWVNcmJOTTdpWXV2SFVhdUFEbVR0TE5qckNV?=
 =?utf-8?B?bWlicDlpbWg3bVZKN1RtanRabVNJTTEvZ1plcWswRTd1dUhIMjVWNkNoVHVi?=
 =?utf-8?B?c0srSGxVVDJ0RnE2eXhRWmFSQ0RyQ0JZeUIvQ2VrUWswVnFrcUtaZEVlMDhi?=
 =?utf-8?B?ejI1UmVkUE1KL1U4amFUc2FFd0wzVGJJay9TSkR1cjBlTlR1WGcvcGp1aHFY?=
 =?utf-8?B?eGVUWnZFYmovUUo1Um5OQjhha0toT3g0TS90RStMUVErQUI3aVpySWo0aHhz?=
 =?utf-8?B?eVB3MjVBaWVtK01yaGdxLzdodjJhK3Y3K01TcmIrM0xyU3dySWNWcThESS9u?=
 =?utf-8?B?bFRXZzdTcmZoZytVR2h2NjVDdmRLMC96UzJxZTl3aVlzaDM3Nm1qVW15ajBl?=
 =?utf-8?B?MWFjNkJOekVnd1RXS29QVkdxaXdRanJqVVJFbUhWcjZ0dFhnNHF5UWtrVGVX?=
 =?utf-8?B?cTg0KzRna0JnamJ3V1BtNFo3NStQTEJpOVd4b3RiN0pDUlNrMkl4Mmd3ckZT?=
 =?utf-8?B?Z3ZGaE4vd25KbWJlN1lISWFuWWRJeXZBbzQ1YXlCVUNERWorUFFlb25jMTVB?=
 =?utf-8?B?N3JoNFNGZm9kWE1FK05RYlY4WEFMOUR4N0tMeDJNU1JmYnZ6ckQvWC82bm5r?=
 =?utf-8?B?eWZnTEN1YjVURXQ4a3RuMkdJMWRhY0svZUhEUnViRmV0N0k2M3UyL2gxU01k?=
 =?utf-8?B?eHRSQ2RucWlSV0JQMTRCSTBiVTJOM1FVMnFPK0Qva3ZSbkpEZTZ1YjdCYXpp?=
 =?utf-8?B?K3lBbEQ5ZFBLOHpaRFI0Y0xWY29IOTdvcTJ5b3FPSjlmRnVpblBzUGhLcWpI?=
 =?utf-8?B?U2JVaW1zb1BkZGRCSlV1MWxxMm53NVNRZWNtZCtsUnJvNDZobHR5RVV6RVhW?=
 =?utf-8?B?ZlprcTAweXJUTU9FZkUzdWxIMzRTZy9wdy9mSkd0ZFVQWVd1cVFmYkt0VXpz?=
 =?utf-8?B?R0xwRGprY1hkUXJQRUludGV5VGhBRXdZT2tobHptTktldmZXamNnWlVRZ1pp?=
 =?utf-8?B?ZlFGRVVGNnFiS2JnQndQSzdrWmxyMEJuaVo0ekRmZlpHRGlPamJjZCtQUE5j?=
 =?utf-8?B?eGphSzRLQko2Ty9Bd0hlQ21vRU9WNTBDekJId0xnM1FGNW1IcWFtSExjZXE3?=
 =?utf-8?B?UXcrZk9oR3E2WnVETlh5WWhnc2FpYVRscmdOK2VnY2pIOWhZUnZNSExkUlRk?=
 =?utf-8?B?TWpSTVB6ZWZjMktXZGRyaXNWN0hiNnV6VGVMRk56N3BVZ3FTMDB2aUEvaFc1?=
 =?utf-8?B?TktjS0hKSG1YK0FZMjc5RGVKTmdZaTJ5ZTRqMTJ6a1R0M1Z4Z2ppRUp1SUZm?=
 =?utf-8?B?QUc0YWM4MjdQTkV0ZWFOVEFtU1BlWW1CL0JuMjUwQU4rdG1pQjFzVHhHLys2?=
 =?utf-8?B?dHdNSHArbFVGNDh1cTB6dmIvL1pGQUtncUc5SVc2WDBGdTh6dUVJa0pmUjFm?=
 =?utf-8?B?M2hTWk9Pd05uNzU1cWZ0WGhkdjIrNjYzSEd6YU9lQnFhSWZPNkhtNHBYaHFp?=
 =?utf-8?B?R1liQmZZM21aWnZ3TzA1dkE5OHZ0QUtBYUdPOS9TUnd3T3h1dStPNm9VWDhh?=
 =?utf-8?B?c3hsaXAzLzZWUlpYSitLYU5CcWo1cklCRnhqcDk0SzhQa0toR0IxYUdPQXdk?=
 =?utf-8?B?Skl5UzFlWHBHdmlhc0dPNkNaUUlPdVVDa0JLdjJrTDRKSk1oSTVSY01IdTQw?=
 =?utf-8?B?eVhTRVpZR0U1dTRVYk9KbzV0NzVRR0Y5d2ozTzhoYUMzRjdVSmVvdDVMMi8r?=
 =?utf-8?B?OWV4RGRtSTQ2ZU81WkNiNGw1aEJUQXZEUE1qNG1qM2Z1Qm1wYTRlcUk0TGR1?=
 =?utf-8?B?YjI2dWt5SjR3c3NCL1owSTZoTU9ER0dyVFp5Z3V6SHFlMDVkVkZwOUltYVk5?=
 =?utf-8?B?U284QllQVzMwek01TUkyL3FSY09ndndYRUdvaDQ2SDZHVHVnSHR1UnZkT29S?=
 =?utf-8?Q?dmYqbAd1HsJt6MZ1Te8lfgk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c314043-eb6a-4624-733c-08d9a1f98539
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2021 14:18:50.7174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvgtZtr7ZMqFodYJeuLPw1OxwNQlHBuysyAsdA3n4qmXAycO6btRwp5Xxof24vygoJI3jLbjp8Z6w8Ybg3AepQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5169
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10160 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111070091
X-Proofpoint-ORIG-GUID: tetxKhnojSK82-PwDHMFfJ3vFIu5FkAA
X-Proofpoint-GUID: tetxKhnojSK82-PwDHMFfJ3vFIu5FkAA
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/11/2021 23:54, Luis Chamberlain wrote:
> On Fri, Nov 05, 2021 at 01:32:11PM +0200, Nikolay Borisov wrote:
>>
>>
>> On 5.11.21 г. 13:04, Filipe Manana wrote:
>>> On Thu, Nov 4, 2021 at 8:40 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>>>>
>>>> btrfs/249 fails with:
>>>>
>>>> QA output created by 249
>>>> ./common/btrfs: line 425: _require_loadable_fs_module: command not found
>>>> ./common/btrfs: line 432: _reload_fs_module: command not found
>>>> ERROR: not a btrfs filesystem: /media/scratch
>>>>
>>>> Fix this by sourcing common/module in the btrfs common file.
>>>
>>> I'm not sure why you get such a failure. Without the relevant
>>> btrfs-progs and btrfs kernel patches, I don't get that error:
>>
>> I checked all these tests and btrfs/248 and btrfs/249 do not import
>> common/module whilst the others do it so this might be one of the reason.
> 
> Odd btrfs/248 runs fine here.
> 

  Thanks for the report and the fix.

  I still can't find the reason why btrfs/249 runs fine on my test 
system here. (It is the same error as shown in Filipe email).

>> IMO it would be cleaner to source it in common/btrfs to remove the
>> duplication.
> 

  Anyways, in general adding common/module to common/btrfs is a good 
cleanup.

- Anand


> Sure that works with me. Will send a v2.
> 
>    Luis
> 

