Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8353160D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Feb 2021 09:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbhBJIVp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Feb 2021 03:21:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37932 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhBJIVi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Feb 2021 03:21:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A8KAgf023031;
        Wed, 10 Feb 2021 08:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=swlgNPgUpuALEjHFNvv1vF7hp1ECmKqlgsn3uz9v9sk=;
 b=p7n/pl+DX7cpYoCmZ14uZNd7X+VDWLTw2z+YZ1q9Wc2fKctlSUzo40DlDxhOx0U06sWX
 nYBU8WyZxJQq2wdoWDOop3RRYOTm2bRdy4O5O/4KrGvG6ck3TrNSX1t4ud6rVBwFISij
 06xRusrVVh8SwarpHxc7bmsT8NdFA8M6mM7QztnhLWVAs1bkj8XzEV8tnMUAHE3qrxqD
 txD41Ut2SJe7vr08ZNh0dj85tMnS2gglOp7gUXhWB5d2tpftJGi2LmOnbSePL0/WVHmk
 +I7luWdqbMUKMuNEJ9NawQnlYHBUoN6pTmThtL3mKFn0Q3kLmlxHAJy0Wi5yZr0VW2ob tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36hkrn2b9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 08:20:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11A8KgSM016542;
        Wed, 10 Feb 2021 08:20:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3020.oracle.com with ESMTP id 36j4vsgar9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 08:20:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fto90yQLpxiXtWHogX0i/4SWWC0zYcxMMm5eenXF/eqlBmBKezKBvaclTo2NH4Vvy3+QPT89RAwDtQj4+aZlFEu66AtuRg7NhSFeoaPsUaeskMKFpELj5f4ZbOkRTeg1g6gHMxM00JaC325W+DPCp7K94/TJd53ALHph1jYJSsK/3PVRgXcGn4PgImRUfucbEPPb9Y0KqYm/0VWcDWMsWDKnzoPxThZ5k5QDq2GE7RNNZleYIH8KawMH69GvANt59rPWQUifsyOOyPuasmIV1t/aVSSJwv65pUxbGzzei8pFMzHAMW4tmVv5K/9A1ABP987Q224CYGOG30zR8RM7DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swlgNPgUpuALEjHFNvv1vF7hp1ECmKqlgsn3uz9v9sk=;
 b=AjnFgqJ5YoCL1cZzp7jnLzA3wKLjZuiNF33Vy/88jJDeJQcPylZL5CIk4lRs0XFlAGJtx3exeJWM1ucEEGUBjOjzn94u6tZ61juN+ahZRmVeuRPom33QPFDY9bOHXBbsKqDWlJ3/x1OuWHpK4rhS+M/+5mrPAwfixmbEJaJntPfTRtGDOy5aFgp/9XGry/hf5G5DK3yLZPYN73y5YUUQ4B5+fRbi3cyOxJYlF0QCTmiqI4/rxQM8SEejUqqz7XkM4KpWEZnuZ3yKoBA0gR8UaQjAAywhPaf0ZVu733OCGpIfp/h6DJw2nOVAn6YEr3DFgO81ZpsuyMoN6nJW51lU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swlgNPgUpuALEjHFNvv1vF7hp1ECmKqlgsn3uz9v9sk=;
 b=V5A11x0Hvpdd3pNDPyd4Noqn0E6mWTQTzCFRREDog0h4USLt+EWVfBcaUEZPurcZ47j8nhHUuWg/bOnsgPnzILm8TmtPwsXOjgBCB4od1G2qeb+O7KJAJbJMDglWrS9Y8nXPpTmB0CHEWwZ/XnK60XmrflJIOq+ZFWfHfNoOIyY=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
 by BN6PR1001MB2338.namprd10.prod.outlook.com (2603:10b6:405:2b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Wed, 10 Feb
 2021 08:20:31 +0000
Received: from BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::9d63:7b79:33d4:a802]) by BN6PR10MB1683.namprd10.prod.outlook.com
 ([fe80::9d63:7b79:33d4:a802%3]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 08:20:30 +0000
Subject: Re: [PATCH RFC 6/6] btrfs: Add roundrobin raid1 read policy
To:     Michal Rostecki <mrostecki@suse.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Michal Rostecki <mrostecki@suse.com>
References: <20210209203041.21493-1-mrostecki@suse.de>
 <20210209203041.21493-7-mrostecki@suse.de>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c2cbf3a7-3db2-afae-4984-450e758f4987@oracle.com>
Date:   Wed, 10 Feb 2021 16:20:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <20210209203041.21493-7-mrostecki@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:8086:eacf:7bcd:bb81]
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To BN6PR10MB1683.namprd10.prod.outlook.com (2603:10b6:405:b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:8086:eacf:7bcd:bb81] (2406:3003:2006:2288:8086:eacf:7bcd:bb81) by SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.0 via Frontend Transport; Wed, 10 Feb 2021 08:20:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87f0db3c-22d7-4e60-57a9-08d8cd9cbaab
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2338:
X-Microsoft-Antispam-PRVS: <BN6PR1001MB23385232CC16B3892CCAE56BE58D9@BN6PR1001MB2338.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nm+4Gt0gowt/mfhQkrXpO2xHZkrETc4kBx0iujNLY6XBt7RDKo4UGAwxJJnuqWcaruOmYk7ojRy2DnmLMSU+6hdWTHl0w/0nx+NmtRGGduz8RccNcPPN7xMViS+kApFmND0CVzJmPn+WNzNVq1tVrZiQ+ioaJURc+erzRIxGyS72Mvl9ptFb7QOLLT8mPkfwy8JFvamyQrsQQ/YW1j4G5AFJ/ssv4P3P70nf2/L9//L8ZY6wh7NfymBHmGCipoc2eWaTDW/V/PodoM132IfteDg1ZYdMQ6b4ioNQK7b3kF6pRnK9/trKBu7IdvpQA6yZbhcbZKli86zt32eewuumJauVedJoUq0kegSk7/JyzFA475xhkYl6pxG7EqQzG5g851XtnraQRO9gbB2T5dgyThX5P4dZOD05NTE6IcP0I+F+Cp9+dikudfimxctRO4U1FY/xyRnJe982VVr5EyQXE9473JAnOFRvY3KXYPo9HrsXtpV1GWscUoikH8QpmPZooG07tQyfK5+cl+S9qJ0/RWzivr9xMZK6N9apKYII4EB51KHE0xvyQWrgATNizBtw3ytVj2xlYHTVh4vPpvIprHSF89qvvyn++XHtp4pwVM6zMrBeKmBlpjyJCaMYGEsjVBpmzRFR5PcyXaQDZt6csdbfT7rX6vZh+o04YK9EHMcuIVVc0yQcnf3ip9VgNgkL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR10MB1683.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(39860400002)(396003)(376002)(83380400001)(66476007)(4326008)(186003)(16526019)(966005)(2616005)(44832011)(316002)(36756003)(6666004)(2906002)(110136005)(86362001)(30864003)(31686004)(31696002)(66556008)(5660300002)(478600001)(66946007)(6486002)(8936002)(53546011)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MHJyV0VCT01GcjJmSXU1TXlHVFN1VG5GamhQdGx1NmhGN2kzZjZ0aHRxL1dK?=
 =?utf-8?B?bWdISm9kMEY1Vk1ZL0RxV1J1YkpPWXJFTkZtaWY3NzNiR0diRFRFT1IweitV?=
 =?utf-8?B?aTNkT3cza29jc1VUeEZmbkRrUC9zcnlnL1pYbzVGWEJ6ck54Sk9PNU1GcU9X?=
 =?utf-8?B?bXgzVUFVdGNJZUtKd29YeGxVTi9oYzNnNWlUMXVmT0xneWd1VVM4UldwdUFH?=
 =?utf-8?B?WiszTmk1RHdpQ0dPMXVrYjljSGVzRFh3SGtPODhwdjdPZU5oUUdudzJuQ0pJ?=
 =?utf-8?B?WlROdmMwQkhxU013VnhLS0k3TmhTMitlUjV2UlYxbWZGNURBN2JxMUJyQ0JL?=
 =?utf-8?B?R3pWbWtsYWRkNFpTd3hVdlQ2RjdFMWlkcWhueE43UjZUaGJEL3RlOUxJSytv?=
 =?utf-8?B?aE5ONDdvb1FYY1Q3RWxRVmZ5dEN1MlBLYlN6ZXJtVW8wRUx2OWJKUklkRzlh?=
 =?utf-8?B?Q3lDTzh1TWhkeGIzUEQveHE4dklSbDdxUm1mK21oeUsvbTBwanhSYUU3Vm5l?=
 =?utf-8?B?YXVvY20rQTFzZXlSTDYzbWdOOGNTczJLVHdKSGhaTlJ4ZEhxSnlnZm5qNnJD?=
 =?utf-8?B?a3JnbDZsbElsTWNNVm5IRml0OXFBVTNlWndCSWRRbUZjckhFNXFWSk9lMHc4?=
 =?utf-8?B?akZmQXVMOHoxVkUvbGNMTTIwcXFsUmhaUjFkUWNpYWxUUW1kcG56MlV6WUJK?=
 =?utf-8?B?eTlLS1dwRXBnUnNGRk9lUEFtQ2h6YlZKcUtJcUpiMkpseXlrY3l5cm05SU0r?=
 =?utf-8?B?S0RrWCtBRTdQZUNsdUtrTGUzOHdiVGhsMTBFUk9Vd1ZXM2VuNTlGK2RFdlBv?=
 =?utf-8?B?VGRlZDhsNGU1OUtTOEpCM1dWeFVQM2wrdUVJdkFBVmdhdFlkZjg4cE51aUZp?=
 =?utf-8?B?a081N2JURlkzTXNSNkhSSDIzcEpBRWJWSktQelhLK3J3dnBxZzZ2Qk9pN2xa?=
 =?utf-8?B?NFVmTjQ0TUpuREh4TDJkeDR1eEZ3bHRWQ1VzdDZNQUtLYkg1eHE2ckg0a1Jq?=
 =?utf-8?B?K0ZZQkI3MWV3SGhBVU42czVaaHRvbEowK1VkQWQySXZnSTQ5cnlXcm1pdUNG?=
 =?utf-8?B?TFBWS1ZaakkySzRIenl2V2RPMCtJUlBuWEkrTG42MGJReW5IREFNc3o4aHpn?=
 =?utf-8?B?d2g0SU5NUVNMb3psSkF5QzQ3WDVmQU5ZZVMxalQxZTV5RTVQZXh4SC82REJ5?=
 =?utf-8?B?a1cvMk9CRXgzTmoxMUpWSVFJZ0VRRzNaYTAxcHVFZjhuaFFIdFlhWFhDT3lm?=
 =?utf-8?B?MjZScUZmQzJ1dnNZRnpsa0FDcUlGcEcwWksvQ2RnQ21kazVlZVIxd1llVVVt?=
 =?utf-8?B?WmpvL1ZRMHhoUXJYU1VpOXJscTlsOUNmNVJLRzVVRVJpT29KOWZiUE5hWCtR?=
 =?utf-8?B?a1JOS3lHR1RkcXJEVjdsRjZ3YThOS0RDY0ZCRzk3amdaOGl0b2s0RmtVeXV5?=
 =?utf-8?B?NmdQZGdJbGNjdW5UZzZ2TTA0bmZBZnMyeEJxZ296RzFBYkxiK0QwMGNWMmR1?=
 =?utf-8?B?cERadHBiUjdseEl4ZDBtUC9ROER5WDFoaHp6Q0o1am5oMUh5Qy8wMXROdU5s?=
 =?utf-8?B?NXdZRk9kMEduaXhNbFNSRDE0ek1mNnh0M1daWGVWb2xHOHNUSjVLeGlVSXBj?=
 =?utf-8?B?RUdMQ1hENklxNTYyWTFQakhpWGthWUxrelpJaGcyblFwOTNxMHZreHZOaUMr?=
 =?utf-8?B?N1ZLQVdHT2JydTlmcVZOS3hQZ2xVOWVFcmU3QVVBa0VzWUwrcmpBdG5yNjhJ?=
 =?utf-8?B?WklUZVBXWGVyMndvb21aK3lVS09GbGQvbDU2TXY5eG42UWtIdjgxTDBET0Nu?=
 =?utf-8?B?NHU5T1V1REFWT3JkVEUwVlZuYXdSQk1CSURHMGc3L2FPMUlsWm44eEpscGVC?=
 =?utf-8?Q?cTpHfxhSjTE0x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f0db3c-22d7-4e60-57a9-08d8cd9cbaab
X-MS-Exchange-CrossTenant-AuthSource: BN6PR10MB1683.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 08:20:30.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dY6BuKlfaPpWvY4NEJPd14v831Z2jmqOmbW2L1GzvFmphyBMHDcYaml5fQFFYW9BvPTlggUWyvULH7ZuIiDLEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2338
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100086
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100086
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/02/2021 04:30, Michal Rostecki wrote:
> From: Michal Rostecki <mrostecki@suse.com>
> 
> Add a new raid1 read policy `roundrobin`. For each read request, it
> selects the mirror which has lower load than queue depth and it starts
> iterating from the last used mirror (by the current CPU). Load is
> defined as the number of inflight requests + a potential penalty value.
> 
> The policy can be enabled through sysfs:
> 
>    # echo roundrobin > /sys/fs/btrfs/[fsid]/read_policies/policy
> 
> This policy was tested with fio and compared with the default `pid`
> policy.
> 
> The singlethreaded test has the following parameters:
> 
>    [global]
>    name=btrfs-raid1-seqread
>    filename=btrfs-raid1-seqread
>    rw=read
>    bs=64k
>    direct=0
>    numjobs=1
>    time_based=0
> 
>    [file1]
>    size=10G
>    ioengine=libaio
> 
> and shows the following results:
> 
> - raid1c3 with 3 HDDs:
>    3 x Segate Barracuda ST2000DM008 (2TB)
>    * pid policy
>      READ: bw=217MiB/s (228MB/s), 217MiB/s-217MiB/s (228MB/s-228MB/s),
>      io=10.0GiB (10.7GB), run=47082-47082msec
>    * roundrobin policy
>      READ: bw=409MiB/s (429MB/s), 409MiB/s-409MiB/s (429MB/s-429MB/s),
>      io=10.0GiB (10.7GB), run=25028-25028mse
> - raid1c3 with 2 HDDs and 1 SSD:
>    2 x Segate Barracuda ST2000DM008 (2TB)
>    1 x Crucial CT256M550SSD1 (256GB)
>    * pid policy (the worst case when only HDDs were chosen)
>      READ: bw=220MiB/s (231MB/s), 220MiB/s-220MiB/s (231MB/s-231MB/s),
>      io=10.0GiB (10.7GB), run=46577-46577mse
>    * pid policy (the best case when SSD was used as well)
>      READ: bw=513MiB/s (538MB/s), 513MiB/s-513MiB/s (538MB/s-538MB/s),
>      io=10.0GiB (10.7GB), run=19954-19954msec
>    * roundrobin (there are no noticeable differences when testing multiple
>      times)
>      READ: bw=541MiB/s (567MB/s), 541MiB/s-541MiB/s (567MB/s-567MB/s),
>      io=10.0GiB (10.7GB), run=18933-18933msec
> 
> The multithreaded test has the following parameters:
> 
>    [global]
>    name=btrfs-raid1-seqread
>    filename=btrfs-raid1-seqread
>    rw=read
>    bs=64k
>    direct=0
>    numjobs=8
>    time_based=0
> 
>    [file1]
>    size=10G
>    ioengine=libaio
> 
> and shows the following results:
> 
> - raid1c3 with 3 HDDs: 3 x Segate Barracuda ST2000DM008 (2TB)
>    3 x Segate Barracuda ST2000DM008 (2TB)
>    * pid policy
>      READ: bw=1569MiB/s (1645MB/s), 196MiB/s-196MiB/s (206MB/s-206MB/s),
>      io=80.0GiB (85.9GB), run=52210-52211msec
>    * roundrobin
>      READ: bw=1733MiB/s (1817MB/s), 217MiB/s-217MiB/s (227MB/s-227MB/s),
>      io=80.0GiB (85.9GB), run=47269-47271msec
> - raid1c3 with 2 HDDs and 1 SSD:
>    2 x Segate Barracuda ST2000DM008 (2TB)
>    1 x Crucial CT256M550SSD1 (256GB)
>    * pid policy
>      READ: bw=1843MiB/s (1932MB/s), 230MiB/s-230MiB/s (242MB/s-242MB/s),
>      io=80.0GiB (85.9GB), run=44449-44450msec
>    * roundrobin
>      READ: bw=2485MiB/s (2605MB/s), 311MiB/s-311MiB/s (326MB/s-326MB/s),
>      io=80.0GiB (85.9GB), run=32969-32970msec
> 



> The penalty value is an additional value added to the number of inflight
> requests when a scheduled request is non-local (which means it would
> start from the different physical location than the physical location of
> the last request processed by the given device). By default, it's
> applied only in filesystems which have mixed types of devices
> (non-rotational and rotational), but it can be configured to be applied
> without that condition.
> 
> The configuration is done through sysfs:
> > - /sys/fs/btrfs/[fsid]/read_policies/roundrobin_nonlocal_inc_mixed_only
> 
> where 1 (the default) value means applying penalty only in mixed arrays,
> 0 means applying it unconditionally.
 >
> The exact penalty value is defined separately for non-rotational and
> rotational devices. By default, it's 0 for non-rotational devices and 1
> for rotational devices. Both values are configurable through sysfs:
> 
> - /sys/fs/btrfs/[fsid]/read_policies/roundrobin_nonrot_nonlocal_inc
> - /sys/fs/btrfs/[fsid]/read_policies/roundrobin_rot_nonlocal_inc
>
> To sum it up - the default case is applying the penalty under the
> following conditions:
> 
> - the raid1 array consists of mixed types of devices
> - the scheduled request is going to be non-local for the given disk
> - the device is rotational
 >
> That default case is based on a slight preference towards non-rotational
> disks in mixed arrays and has proven to give the best performance in
> tested arrays.
 >> For the array with 3 HDDs, not adding any penalty resulted in 409MiB/s
> (429MB/s) performance. Adding the penalty value 1 resulted in a
> performance drop to 404MiB/s (424MB/s). Increasing the value towards 10
> was making the performance even worse.
>
> For the array with 2 HDDs and 1 SSD, adding penalty value 1 to
> rotational disks resulted in the best performance - 541MiB/s (567MB/s).
> Not adding any value and increasing the value was making the performance
> worse.
> > Adding penalty value to non-rotational disks was always decreasing the
> performance, which motivated setting it as 0 by default. For the purpose
> of testing, it's still configurable.
 >
> To measure the performance of each policy and find optimal penalty
> values, I created scripts which are available here:
> 

So in summary
  rotational + non-rotational: penalty = 1
  all-rotational and homo    : penalty = 0
  all-non-rotational and homo: penalty = 0

I can't find any non-deterministic in your findings above.
It is not very clear to me if we need the configurable
parameters here.

It is better to have random workloads in the above three categories
of configs.

Apart from the above three configs, there is also
  all-non-rotational with hetero
For example, ssd and nvme together both are non-rotational.
And,
  all-rotational with hetero
For example, rotational disks with different speeds.


The inflight calculation is local to btrfs. If the device is busy due to 
external factors, it would not switch to the better performing device.


Thanks, Anand


> https://gitlab.com/vadorovsky/btrfs-perf
> https://github.com/mrostecki/btrfs-perf
> 
> Signed-off-by: Michal Rostecki <mrostecki@suse.com>
> ---
>   fs/btrfs/ctree.h   |   3 +
>   fs/btrfs/disk-io.c |   3 +
>   fs/btrfs/sysfs.c   |  93 +++++++++++++++++++++++++++++-
>   fs/btrfs/volumes.c | 137 ++++++++++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/volumes.h |  10 ++++
>   5 files changed, 242 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index a9b0521d9e89..6ff0a18fd219 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -976,6 +976,9 @@ struct btrfs_fs_info {
>   	/* Max size to emit ZONE_APPEND write command */
>   	u64 max_zone_append_size;
>   
> +	/* Last mirror picked in round-robin selection */
> +	int __percpu *last_mirror;
> +
>   #ifdef CONFIG_BTRFS_FS_REF_VERIFY
>   	spinlock_t ref_verify_lock;
>   	struct rb_root block_tree;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 71fab77873a5..937fcadbdd2f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1547,6 +1547,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>   	btrfs_extent_buffer_leak_debug_check(fs_info);
>   	kfree(fs_info->super_copy);
>   	kfree(fs_info->super_for_commit);
> +	free_percpu(fs_info->last_mirror);
>   	kvfree(fs_info);
>   }
>   
> @@ -2857,6 +2858,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>   	fs_info->swapfile_pins = RB_ROOT;
>   
>   	fs_info->send_in_progress = 0;
> +
> +	fs_info->last_mirror = __alloc_percpu(sizeof(int), __alignof__(int));
>   }
>   
>   static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index a8f528eb4e50..b9a6d38843ef 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -928,7 +928,7 @@ static bool strmatch(const char *buffer, const char *string)
>   	return false;
>   }
>   
> -static const char * const btrfs_read_policy_name[] = { "pid" };
> +static const char * const btrfs_read_policy_name[] = { "pid", "roundrobin" };
>   
>   static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>   				      struct kobj_attribute *a, char *buf)
> @@ -976,8 +976,99 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>   }
>   BTRFS_ATTR_RW(read_policies, policy, btrfs_read_policy_show, btrfs_read_policy_store);
>   
> +static ssize_t btrfs_roundrobin_nonlocal_inc_mixed_only_show(
> +	struct kobject *kobj, struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n",
> +			 READ_ONCE(fs_devices->roundrobin_nonlocal_inc_mixed_only));
> +}
> +
> +static ssize_t btrfs_roundrobin_nonlocal_inc_mixed_only_store(
> +	struct kobject *kobj, struct kobj_attribute *a, const char *buf,
> +	size_t len)
> +{
> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
> +	bool val;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(fs_devices->roundrobin_nonlocal_inc_mixed_only, val);
> +	return len;
> +}
> +BTRFS_ATTR_RW(read_policies, roundrobin_nonlocal_inc_mixed_only,
> +	      btrfs_roundrobin_nonlocal_inc_mixed_only_show,
> +	      btrfs_roundrobin_nonlocal_inc_mixed_only_store);
> +
> +static ssize_t btrfs_roundrobin_nonrot_nonlocal_inc_show(struct kobject *kobj,
> +							 struct kobj_attribute *a,
> +							 char *buf)
> +{
> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n",
> +			 READ_ONCE(fs_devices->roundrobin_nonrot_nonlocal_inc));
> +}
> +
> +static ssize_t btrfs_roundrobin_nonrot_nonlocal_inc_store(struct kobject *kobj,
> +							  struct kobj_attribute *a,
> +							  const char *buf,
> +							  size_t len)
> +{
> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
> +	u32 val;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 10, &val);
> +	if (ret)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(fs_devices->roundrobin_nonrot_nonlocal_inc, val);
> +	return len;
> +}
> +BTRFS_ATTR_RW(read_policies, roundrobin_nonrot_nonlocal_inc,
> +	      btrfs_roundrobin_nonrot_nonlocal_inc_show,
> +	      btrfs_roundrobin_nonrot_nonlocal_inc_store);
> +
> +static ssize_t btrfs_roundrobin_rot_nonlocal_inc_show(struct kobject *kobj,
> +						      struct kobj_attribute *a,
> +						      char *buf)
> +{
> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n",
> +			 READ_ONCE(fs_devices->roundrobin_rot_nonlocal_inc));
> +}
> +
> +static ssize_t btrfs_roundrobin_rot_nonlocal_inc_store(struct kobject *kobj,
> +						       struct kobj_attribute *a,
> +						       const char *buf,
> +						       size_t len)
> +{
> +	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
> +	u32 val;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 10, &val);
> +	if (ret)
> +		return -EINVAL;
> +
> +	WRITE_ONCE(fs_devices->roundrobin_rot_nonlocal_inc, val);
> +	return len;
> +}
> +BTRFS_ATTR_RW(read_policies, roundrobin_rot_nonlocal_inc,
> +	      btrfs_roundrobin_rot_nonlocal_inc_show,
> +	      btrfs_roundrobin_rot_nonlocal_inc_store);
> +
>   static const struct attribute *read_policies_attrs[] = {
>   	BTRFS_ATTR_PTR(read_policies, policy),
> +	BTRFS_ATTR_PTR(read_policies, roundrobin_nonlocal_inc_mixed_only),
> +	BTRFS_ATTR_PTR(read_policies, roundrobin_nonrot_nonlocal_inc),
> +	BTRFS_ATTR_PTR(read_policies, roundrobin_rot_nonlocal_inc),
>   	NULL,
>   };
>   
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1ad30a595722..c6dd393190f6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1265,6 +1265,11 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>   	fs_devices->total_rw_bytes = 0;
>   	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
>   	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
> +	fs_devices->roundrobin_nonlocal_inc_mixed_only = true;
> +	fs_devices->roundrobin_nonrot_nonlocal_inc =
> +		BTRFS_DEFAULT_ROUNDROBIN_NONROT_NONLOCAL_INC;
> +	fs_devices->roundrobin_rot_nonlocal_inc =
> +		BTRFS_DEFAULT_ROUNDROBIN_ROT_NONLOCAL_INC;
>   
>   	return 0;
>   }
> @@ -5555,8 +5560,125 @@ static u64 stripe_physical(struct map_lookup *map, u32 stripe_index,
>   		stripe_nr * map->stripe_len;
>   }
>   
> +/*
> + * Calculates the load of the given mirror. Load is defines as the number of
> + * inflight requests + potential penalty value.
> + *
> + * @fs_info:       the filesystem
> + * @map:           mapping containing the logical extent
> + * @mirror_index:  number of mirror to check
> + * @stripe_offset: offset of the block in its stripe
> + * @stripe_nr:     index of the stripe whete the block falls in
> + */
> +static int mirror_load(struct btrfs_fs_info *fs_info, struct map_lookup *map,
> +		       int mirror_index, u64 stripe_offset, u64 stripe_nr)
> +{
> +	struct btrfs_fs_devices *fs_devices;
> +	struct btrfs_device *dev;
> +	int last_offset;
> +	u64 physical;
> +	int load;
> +
> +	dev = map->stripes[mirror_index].dev;
> +	load = percpu_counter_sum(&dev->inflight);
> +	last_offset = atomic_read(&dev->last_offset);
> +	physical = stripe_physical(map, mirror_index, stripe_offset, stripe_nr);
> +
> +	fs_devices = fs_info->fs_devices;
> +
> +	/*
> +	 * If the filesystem has mixed type of devices (or we enable adding a
> +	 * penalty value regardless) and the request is non-local, add a
> +	 * penalty value.
> +	 */
> +	if ((!fs_devices->roundrobin_nonlocal_inc_mixed_only ||
> +	     fs_devices->mixed) && last_offset != physical) {
> +		if (dev->rotating)
> +			return load + fs_devices->roundrobin_rot_nonlocal_inc;
> +		return load + fs_devices->roundrobin_nonrot_nonlocal_inc;
> +	}
> +
> +	return load;
> +}
> +
> +/*
> + * Checks if the given mirror can process more requests.
> + *
> + * @fs_info:       the filesystem
> + * @map:           mapping containing the logical extent
> + * @mirror_index:  index of the mirror to check
> + * @stripe_offset: offset of the block in its stripe
> + * @stripe_nr:     index of the stripe whete the block falls in
> + *
> + * Returns true if more requests can be processes, otherwise returns false.
> + */
> +static bool mirror_queue_not_filled(struct btrfs_fs_info *fs_info,
> +				    struct map_lookup *map, int mirror_index,
> +				    u64 stripe_offset, u64 stripe_nr)
> +{
> +	struct block_device *bdev;
> +	unsigned int queue_depth;
> +	int inflight;
> +
> +	bdev = map->stripes[mirror_index].dev->bdev;
> +	inflight = mirror_load(fs_info, map, mirror_index, stripe_offset,
> +			       stripe_nr);
> +	queue_depth = blk_queue_depth(bdev->bd_disk->queue);
> +
> +	return inflight < queue_depth;
> +}
> +
> +/*
> + * Find a mirror using the round-robin technique which has lower load than
> + * queue depth. Load is defined as the number of inflight requests + potential
> + * penalty value.
> + *
> + * @fs_info:       the filesystem
> + * @map:           mapping containing the logical extent
> + * @first:         index of the first device in the stripes array
> + * @num_stripes:   number of stripes in the stripes array
> + * @stripe_offset: offset of the block in its stripe
> + * @stripe_nr:     index of the stripe whete the block falls in
> + *
> + * Returns the index of selected mirror.
> + */
> +static int find_live_mirror_roundrobin(struct btrfs_fs_info *fs_info,
> +				       struct map_lookup *map, int first,
> +				       int num_stripes, u64 stripe_offset,
> +				       u64 stripe_nr)
> +{
> +	int preferred_mirror;
> +	int last_mirror;
> +	int i;
> +
> +	last_mirror = this_cpu_read(*fs_info->last_mirror);
> +
> +	for (i = last_mirror; i < first + num_stripes; i++) {
> +		if (mirror_queue_not_filled(fs_info, map, i, stripe_offset,
> +					    stripe_nr)) {
> +			preferred_mirror = i;
> +			goto out;
> +		}
> +	}
> +
> +	for (i = first; i < last_mirror; i++) {
> +		if (mirror_queue_not_filled(fs_info, map, i, stripe_offset,
> +					    stripe_nr)) {
> +			preferred_mirror = i;
> +			goto out;
> +		}
> +	}
> +
> +	preferred_mirror = last_mirror;
> +
> +out:
> +	this_cpu_write(*fs_info->last_mirror, preferred_mirror);
> +	return preferred_mirror;
> +}
> +
>   static int find_live_mirror(struct btrfs_fs_info *fs_info,
>   			    struct map_lookup *map, int first,
> +			    u64 stripe_offset, u64 stripe_nr,
>   			    int dev_replace_is_ongoing)
>   {
>   	int i;
> @@ -5584,6 +5706,11 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
>   	case BTRFS_READ_POLICY_PID:
>   		preferred_mirror = first + (current->pid % num_stripes);
>   		break;
> +	case BTRFS_READ_POLICY_ROUNDROBIN:
> +		preferred_mirror = find_live_mirror_roundrobin(
> +			fs_info, map, first, num_stripes, stripe_offset,
> +			stripe_nr);
> +		break;
>   	}
>   
>   	if (dev_replace_is_ongoing &&
> @@ -6178,7 +6305,9 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>   			stripe_index = mirror_num - 1;
>   		else {
>   			stripe_index = find_live_mirror(fs_info, map, 0,
> -					    dev_replace_is_ongoing);
> +							stripe_offset,
> +							stripe_nr,
> +							dev_replace_is_ongoing);
>   			mirror_num = stripe_index + 1;
>   		}
>   
> @@ -6204,8 +6333,10 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>   		else {
>   			int old_stripe_index = stripe_index;
>   			stripe_index = find_live_mirror(fs_info, map,
> -					      stripe_index,
> -					      dev_replace_is_ongoing);
> +							stripe_index,
> +							stripe_offset,
> +							stripe_nr,
> +							dev_replace_is_ongoing);
>   			mirror_num = stripe_index - old_stripe_index + 1;
>   		}
>   
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index ee050fd48042..47ca47b60ea9 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -230,9 +230,15 @@ enum btrfs_chunk_allocation_policy {
>   enum btrfs_read_policy {
>   	/* Use process PID to choose the stripe */
>   	BTRFS_READ_POLICY_PID,
> +	/* Round robin */
> +	BTRFS_READ_POLICY_ROUNDROBIN,
>   	BTRFS_NR_READ_POLICY,
>   };
>   
> +/* Default raid1 policies config */
> +#define BTRFS_DEFAULT_ROUNDROBIN_NONROT_NONLOCAL_INC 0
> +#define BTRFS_DEFAULT_ROUNDROBIN_ROT_NONLOCAL_INC 1
> +
>   struct btrfs_fs_devices {
>   	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
>   	u8 metadata_uuid[BTRFS_FSID_SIZE];
> @@ -294,6 +300,10 @@ struct btrfs_fs_devices {
>   
>   	/* Policy used to read the mirrored stripes */
>   	enum btrfs_read_policy read_policy;
> +	/* Policies config */
> +	bool roundrobin_nonlocal_inc_mixed_only;
> +	u32 roundrobin_nonrot_nonlocal_inc;
> +	u32 roundrobin_rot_nonlocal_inc;
>   };
>   
>   #define BTRFS_BIO_INLINE_CSUM_SIZE	64
> 

