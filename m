Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF7044A9C3
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 09:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbhKII6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 03:58:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23792 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236483AbhKII6L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 03:58:11 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A98T41Y027927;
        Tue, 9 Nov 2021 08:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hVL8bjLKxw1e4Bb28j7Pzp6+0VHDY1a/QyD9glaXFd4=;
 b=UimROk7o5OZ1hchYVVVLTi2V5sTRhtJu+eqVSXoZwVXJ6uuBuVvPs58jjshzy1CeKKA+
 XhEy3YXMLwBnDlR1mtjGTE64PLNBGlmO3KXi+nE0ObWEZCaIV11xVZFbET80rklSjLHS
 PzrfUTaEViFzeVqcRF0LyCaa8m2vyeFeCHypdS3kSMOS/QtTQFGjU/T2I4J2aLL8yk05
 xqGyBz/52UtSEVAoDZQEG9utDFjpUyDsY1e/yjglwXiWiR5HnaHiWHW0fhBG4V+sWvh4
 ycBrXkZ+6C2gGKPxexSRpL1TAzoLXsF7ayHWEpoXuFgQMaqrIKnzW0LaZsaQAxSfQbXr gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6st8suhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 08:55:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A98ke9T074393;
        Tue, 9 Nov 2021 08:55:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3020.oracle.com with ESMTP id 3c63fsm1w3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 08:55:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+BrNbF7r7Nk1zoqVT41OZsHtyG7cVXgtorqiwXG+DhOCs/4GIsAaUVY9MW3E4Jw1nZUu9GLYgBn82lXHbDA52tvPcd3GtQyz5CoWxXnk9Lhu1uLtwPYsCf1NUiBkf6ZNjbwn4JvoittcDmfws5T61QS1k+JiFMt3pd/24R59jdXYzWenqdwN65Y2vWsqu5vUM1qbGH5+rORr0p6xLnC58DVwTGFdXgZcTMpdgovnC4Jk2wUVhIxZhnszYLIxeVbu4zk1qmokxwxQAi4Jp/13CF+aVy2GasraKQ7yrsGbyUDYqrqFjLGfd4kZOohxe7jOYCw4hf4/V+5jLEod+3rRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVL8bjLKxw1e4Bb28j7Pzp6+0VHDY1a/QyD9glaXFd4=;
 b=jY+KT3q1vTseXQdQfLOI2ywZCr0J3kIDJst4yeknvYEUH9wj7rIFKO15K6YTR4CguuCwRmGON809U7JMFcZtqrOtw3DUwiDH9Kbj3mSxefmvulEYb3UdFDik/zPP2e86TX1NaGUidJFGnXaBR3X8eHfu98mcVra8oULnvb0Y73ZV/WCBQ/YoXskutff3Lznddb141i1J/TQ1aIQY9Ha6WFgH1uLhcAHNcNl3Kyl4tFvR6bOSVK+H5yM6SLWOtUkbpPGzAZu2FxUcr5X6IFLmGS2/GoPj/SztYqBTIo6nF3WQ/bWDEJ2jS+RndFDPZfHT80TvI+PFjKAtzptplG6Abw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVL8bjLKxw1e4Bb28j7Pzp6+0VHDY1a/QyD9glaXFd4=;
 b=OHN4R7G1NBz1Mjnz7tpu76kVu1JMMLNe79vvwNHURW6priBPGqT7zow82z57Jej4UA4Ec/QNhjFqo2ziXVpzeGSPoMwfu1Sqp+Fps2n0Ioghmc4Htz5c6oTbtcUuLJM74Q8BcQhTOYseBOcFjxRgTtMCRC8pvY4QNCL8lPLsPow=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4351.namprd10.prod.outlook.com (2603:10b6:208:1d7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Tue, 9 Nov
 2021 08:55:15 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 08:55:15 +0000
Subject: Re: [PATCH] btrfs: add a warning to check on the leaking device close
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
References: <8ad72827dc32542915f87db73cbb6b609f24dce4.1600074377.git.anand.jain@oracle.com>
 <20200916101003.GM1791@twin.jikos.cz>
 <52013ea3-fd54-5dbd-5c4d-3c5f41fdbf93@oracle.com>
 <c1ff087a-26e6-f2d1-eeac-73d65d3a432e@toxicpanda.com>
 <20211108195847.GN28560@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <956c6ef9-4b81-8f96-5746-d7bf16116898@oracle.com>
Date:   Tue, 9 Nov 2021 16:55:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211108195847.GN28560@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.137] (39.109.140.76) by SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 08:55:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3a003fb-409c-45d9-0952-08d9a35ea56e
X-MS-TrafficTypeDiagnostic: MN2PR10MB4351:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4351F2DC871FD69A15FA4866E5929@MN2PR10MB4351.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhRnfjxlCJ+Gr8XO4jJnB/qzMLYb7a8jotxJbHvAT7x86BCNphVralpAq5CCTF5NM4Pb++zNWE6+WkhYybDkQghEfHBbQGcJDP9sjVJGNffMcrvgmpzI7qIkTWa1ouUonAJGDourjY8F931W5KohA5TOf5NUKzEYS0y4MU7vC3s5Ia+vu9NN2a3udExUM5WOCzegfA1Wc5qqyR+lNMKtC2WPukMgc7L+KHVngHUK7oR6FKZfciE+6tZihNA3Ja1TLgr7Bz4UDz7iRkSwqgBTQ0sC9Eq4wcjhJGGmOGBBVXr2GyHniC2MQ1cnR58oiBKOe7iheirPsN6EqFMNBtgobdolOXVSrY2GSQ83RUjSixHAzh0MOlomFawZn+pyNya9w+6oxYxit9JUIkdJdwwgwgdOswB3FClbMtT3bizx7MOwbrp5pv7b7JYgDIgnQq70SApqH7zUUCpPQVPBraoOMfCrYgFwiwnuYGNmyRY42h/Yge1uJzhJe1XDaELpAPjEDeHglvyvCSpEsq91zktZpVjgweP8AkWidgh1KgmC2+j5MbTRJLJyFv94Ma7GJXJDENF5vGBXJRvAu6MlcF8E5l0cNJYEAscHqxe2NLHiJw9bpHcvUUoYb0JFGqM3Tu3yyDp9lG6Xn+7OyMBs91o3dPR/0dr9g/XGynRQ1L/aJxHJaVl1t9UMAL2E73exNJyBVxHpKM0C1BFXzOO2TeveCztltvCoJ7w0DdGxb1l0WXFsDHKGdkWQqVJbn107wBfzWYstWvbmXnAWh9IZrKvHKQIIk6oJiZSg7JW2EMtKr1sH7NWHYUAL0vIPKiHCKfTb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(38100700002)(53546011)(186003)(86362001)(6486002)(36756003)(8936002)(83380400001)(8676002)(26005)(6666004)(16576012)(316002)(956004)(44832011)(508600001)(66556008)(66476007)(966005)(2906002)(31696002)(2616005)(31686004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czV0bnVBWlBWcWoycmVSbE0xL0lzdE5hakc0TTdYTUhEYUNrdWZtLzU0Um41?=
 =?utf-8?B?R3Q1dS9UY0hqaWpRN2JSUnp3bE1ROUE0dmdUc2RkZUlJMkV3QnRoNjdRMWYy?=
 =?utf-8?B?TFFPUVN3dlhyY0sxV2dCWDhjeDZnUS91NVVaRWJTYXI1U28xL3p1ajVGakoz?=
 =?utf-8?B?aDZlNlQ1RHVNUWdKbUlsajJ1bzZrc0RUYmJZQUhFcVRFc2RjaytJYVYwb05x?=
 =?utf-8?B?REVmYXlQY2Jpa1hnVWJPdFQ4ZE9YLzhmcXN4Q3Z6UHNvZ2tXeDMrK1ErdzIy?=
 =?utf-8?B?eVRKNmZZRFlHOHo3c09zdGZEVDB2cjROdkJld0E2UEVJeDhiaVpJekJhL0Ru?=
 =?utf-8?B?ckc4Ykh1WC9vT1BYbTl4dmtNZnlYb3VKUERBRmR5eXhOVjN4bkhuVXNUdWxH?=
 =?utf-8?B?MmdNR1cxOExPczBBOXMwREJKTUowN2JSaVBjb3ozYkdwNVNNZW5xZDYxYWNB?=
 =?utf-8?B?UzRpSGgxWEc5ZCtJRmpwaUVMSGFUcmIxV1BCZUs5dHd5MnovRWFwUkF6WTVz?=
 =?utf-8?B?b2tXUWdLbThpbU5SdURaOStTRHhSb051K3p1NTV4bk9pWVYxU1pqYUpGZ01w?=
 =?utf-8?B?MkI0Z2FlTnRJVE42SllPZEo0YkFiOTV0UUR2TTB1YXJHWTFBdndzV2ExQWpW?=
 =?utf-8?B?R25VOVB4c1RqbDE4VUtVT3FieVRYTkdHR2RQZDlkaW1wRlptZFpYMUNzd1R0?=
 =?utf-8?B?MUs3SUE5Z1E5VGdqbU1UN0xUYjY0T09WelNvWE1QR0JYL2F5MjdWeXZCbFJv?=
 =?utf-8?B?ZHpJR0xoRXJNOGtlSGtKNjFZNW1pUVkyV2FCQld4ZmxWbGxFMEV6aHRaWG9H?=
 =?utf-8?B?MWFnbHoxc1J2ZEF1RmZuMThZMzFFclJBQXVQMzNVWklQN0N4blFmNk1ybE9Z?=
 =?utf-8?B?WEt5ejVIemhIbHBxMUQxYUhXQ2N6TEQ0Q1ErM2RTbG9wRHo4cjV0VXR1LzVq?=
 =?utf-8?B?a2NoNTFCVnFWT3BLbjFKZFRKQW51bmpQcHVBN1hSVnN4bHp6Vzl6S3ZyWVJ2?=
 =?utf-8?B?Vk9icnd5bzU2c3l3ckxqNkhzQnFOMlJueFI4eERvM3orWlpnZ1RxL21tS2ly?=
 =?utf-8?B?T01TNTlHeGlOOHovV2RPUzR2N09NK2ZzdThzb1VvL3B6bjF5MFJsUTVqd0Fn?=
 =?utf-8?B?WEZ2UnVWZS9ZYlFQMlY3MDN4aFF4WGQ5anI0WHgzT0VSbnpmTXZIeTVzRTdi?=
 =?utf-8?B?Zk81MmZyeU9ONnFFWTB0TFpETk94UUJveEdmeDdaZVIvTlZHVVVtZzkyUFhO?=
 =?utf-8?B?aTFJUlNZU3lHWnQxem52RFo0ZTZTa0NrV056MFdYbGQwYVREM0pQTS93aW92?=
 =?utf-8?B?OXJUb2w2VGhHUWZDKy9HbEszOGxqZ3ZPVDdPanNBdng5NFNicmVZUE80cWJw?=
 =?utf-8?B?aXd6Z1diU0FlZEY4dVlhWURzVlg2OGUzUjlJMExHRDFta2dQQU1EbVpYZWYz?=
 =?utf-8?B?ZW8vMjdYTDRwZmtKaFJTNlc2dWtSeUdtUDdpWHdGMEd1UlBCdlNnSDVUUE9M?=
 =?utf-8?B?UVd5QnJoem1iNG9lMXZqSEd4WVZaRXdFWUJRZ3BMbGs4K0E2ZGRvTVRhUE5W?=
 =?utf-8?B?ZHJsOWNFUnF2YWV2SjRCZUhtcGtEMHY1OWIvbTVtZmEvMmNTRDZGZHkyTW9B?=
 =?utf-8?B?VkZEM2hmbGIwcllUeU9aOHZoUTRHdzIwb2w2TjJ0aEdRTWR5Z1JJOU15VHRN?=
 =?utf-8?B?Y0VVeFpMUkkzem92Mmg0VmpnSU9PVlVFSXFiV2plK0tuMDhuRFgyUS9nT3lY?=
 =?utf-8?B?c21wS3RRUy9lcjk4clFodk9zejJLZjRXVTBQYTNuam9NcVVQTkthV1dYM2la?=
 =?utf-8?B?ZjhqK1dpVzI5WVZ2cWtsZVdVWVRJc1JMS1pQekk4UDVibm9xZHlIeDF2UlBq?=
 =?utf-8?B?YmhpRCtqNVVUTnhYNUsyRzA4SU83eTZLYlVXVGRJdzlrWUhsd1JUcDZHeVFL?=
 =?utf-8?B?MVo1WGx0V2NhKzJDY0NvR2ZDazdjZFhuM0pITEl4YjhITTllZUR2bUxlVXp0?=
 =?utf-8?B?S1g3ZGszTkJtNEdndWMwWUdmNG9tNWxKUWJpQmlubDFwZk5LaFBLcHJvK1J0?=
 =?utf-8?B?ZHBFYWFDa3hmNVdvQ1BKaSt4TmlWdk92YWlvckZXeEMyM3Rya1E0ZFBqdnNn?=
 =?utf-8?B?bXdLZzR1bEhPMkhISTZZeCt5N1R1L1FyMmJ2ZGRqN3haNThXb3pTbi9PTU9m?=
 =?utf-8?Q?LXf2Wgn7GYrJHWeFx7UkqTo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a003fb-409c-45d9-0952-08d9a35ea56e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 08:55:14.8884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbykhNPNsy4LReDg0jEjUS1d9BuC7ENGlhqWfprlhs9s2FJnBqkhJVwlkkwKh9DuHmZc3PbiR0RR+epP9gBoXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4351
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111090051
X-Proofpoint-ORIG-GUID: FcOhcbqd3TECCKWZ9gOFyD32Y3nITeQR
X-Proofpoint-GUID: FcOhcbqd3TECCKWZ9gOFyD32Y3nITeQR
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/11/21 3:58 am, David Sterba wrote:
> On Mon, Sep 28, 2020 at 02:16:34PM -0400, Josef Bacik wrote:
>> On 9/16/20 7:51 AM, Anand Jain wrote:
>>>
>>>
>>> On 16/9/20 6:10 pm, David Sterba wrote:
>>>> On Mon, Sep 14, 2020 at 05:11:14PM +0800, Anand Jain wrote:
>>>>> To help better understand the device-close leaks, add a warning if the
>>>>> device freed is still open.
>>>>
>>>> Have you seen that happen or is it just a precaution? I've checked where
>>>> the bdev is set to NULL and all paths seem to be covered, so the warn_on
>>>> does not harm anything just that it does not seem to be possible to hit.
>>>> For that an assert would be better.
>>>
>>> There is an early/unconfirmed report [1] that after the forget
>>> sub-command a device had partition changes and the new partitions failed
>>> to recognize by the kernel.
>>> [1]
>>> https://lore.kernel.org/linux-btrfs/40e2315e-e60e-6161-ceb7-acd8b8a4e4a0@oracle.com/T/#t
>>>
>>>
>>> The mount thread can't use device_list_mutex (because of bd_mutex),
>>> and we rely on the uuid_mutex during mount.
>>>
>>> The forget thread used both uuid_mutex and device_list_mutex.
>>>
>>> So there isn't race between these two.
>>>
>>> As of now we don't know. So the warning will help to know if we are
>>> missing something.
>>>
>>
>> It is clear that it can't really happen, but if we're worried about it I'd
>> rather it be an ASSERT().  Thanks,
> 
> I'm going through the patch backlog and the patch may be still relevant
> but a lot of device locking code has changed recently.
> 
> Anand, if this is still relevant, please resend, thanks.
> 

This patch is not relevant anymore. The commit 3fa421dedbc8  ("btrfs: 
delay blkdev_put until after the device removes") introduced blkdev_put 
after the device-free. So pls ignore this patch.

Thanks, Anand

