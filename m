Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4260632B17B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbhCCBvL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:51:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:44238 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577364AbhCBGGl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Mar 2021 01:06:41 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12254G5D091926;
        Tue, 2 Mar 2021 05:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=njE7sRQH5KsE3uF1bNkf7Ii8BwUtavuDPFyybrfZY8E=;
 b=Atl8TIHT8fI34Ww6X+Qc8cKFmSeLP2OQicc48epBn6foKHyfC4ew4AnR+E0sOQCuIite
 xy4k5WbabUs98nrsjDiTG5K7wdhHUxRvO+OWKFNLr6X9pNPTMGOOIZRf9NnKWmgu6l8r
 54Mn/dfwWatNUnRklTgJXZcicfLW2BaPr5I6H6XBkdYo0qsN4INyn7TKIXxYbcgIUuIM
 e590dIMMsCPh6MNlEHd0Xs5JVJl0ivkfxlSx9M5HU/lGAR5yU1czvBnDt9jj2F3WX8l3
 c8I+OBcCzsIqfpWSel0RlQQ/D3xdiiCF3HCoof31VbexZYzo1R7j5loIOAuaeZ2p6Dl8 BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36ye1m659w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 05:04:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1224stX4026906;
        Tue, 2 Mar 2021 05:04:32 GMT
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2050.outbound.protection.outlook.com [104.47.45.50])
        by userp3030.oracle.com with ESMTP id 37000wg05y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 05:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtlOChQWfjLq6RfqMi5KbBv5s34NewkPtQANfnnoFHtkDUgBzN8Ikbw1bSpt51QiZJAGL4oZipHbdHpWpkndQQPMyM/0lGu5Gy01Hsj4YLln/CYF9bVznYDCq3j23UcltD2NLEiERZRcBfjYQxZca1D5Ud9sl9m3Uc5iGMC7OTE6x3nqjvVS97lYSJbXzl3xkzGvco8spr+OwWh3Ooq4vofdDmBDwBxrA4WeyHDEhWv3eESJ+A7+WJ1QYj4U9c90/b2q+Qcvgjn8lYP4IENdMTZc8uEERVMVpkuS7K0RjEd7U3XyP+3tmeDAwMth0GE/DYRDSeBZ0twlL8ZMyekrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njE7sRQH5KsE3uF1bNkf7Ii8BwUtavuDPFyybrfZY8E=;
 b=Qi3jSbNG7TZm4bxsWVdWSkceZaHjPYdQYvRIS8cJMH5of4CmZNFVJTwYt7Bw/m2BckuHEYC7cKVtOcEYKvSrRRbKqoKfuNece8TIDBf3zPZSgtMkwhayYW/d3Jwl06mfq30BRDi0AlQ+AAzwG7xE36y3E573Gfv8XbqUnRT6PRZLim8zrYfDUXgWl44b/e2aBNhSuUknr8i9bCduA+RvG41EMHw6Ozv0/+8c56Fn9gMpzbrJKyVcbZpGxpv3LolPvgfUI4QoB4z7NuRTHVVYGkOcQtY0kbja7aQqet8vbqwxlieWR2qcWRkMr/UqKF9e1OwqlEaph9W0zDvg3Y6cog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njE7sRQH5KsE3uF1bNkf7Ii8BwUtavuDPFyybrfZY8E=;
 b=RQyuBXTVp1APJvlIH/XqmhKOo7lqVHTRv5rLPnJuL2i1byz2geX85WDWd1kMRI3aR3qUAYZQH0K+wdBPq6xWm4twyN5rSJ8sh/obGTYa0SPrd9sxjM49UHkCOcVQPxMDA4onA0wl194Mqr82339E2oFYvJW2cp7gDZpacSN0Pso=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4367.namprd10.prod.outlook.com (2603:10b6:208:1d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 05:04:30 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 05:04:30 +0000
Subject: Re: [report] lockdep warning when mounting seed device
To:     dsterba@suse.cz
References: <tuq0pxpx.fsf@damenly.su>
 <50ff53e3-6e6f-bc6d-31dc-ac376ed944ce@oracle.com>
 <20210226151044.GL7604@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     Su Yue <l@damenly.su>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <4df51f3d-e63b-92be-aaf4-8198a0e95ff5@oracle.com>
Date:   Tue, 2 Mar 2021 13:04:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210226151044.GL7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.102] (39.109.186.25) by SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.8 via Frontend Transport; Tue, 2 Mar 2021 05:04:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 966e8653-f1af-4966-a9a5-08d8dd38a933
X-MS-TrafficTypeDiagnostic: MN2PR10MB4367:
X-MS-Exchange-MinimumUrlDomainAge: kernel.org#8761
X-Microsoft-Antispam-PRVS: <MN2PR10MB4367FCD89DDC2AB51F2F3F4CE5999@MN2PR10MB4367.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zH0Dau6z6mtVu0d9i6dt1cPrlybH+DwFz9yqk2kUDjg8NHqxMO3FnXepOCJ8wTCVAMZKIzjgvv3PaXg2v/WAHGkS4rSe/KecaNz9w3FeteN74kDXaMTyGRsEBX3zyvZv+hJfzhaKgYrCqxx9jfshwgDdTaA+FauwKecbVb6Z5QbJEwWr/Vjw106dLoZ0/PrzU8rR2T3bNTQpyAqzoaru/DulnwnLjHmBur20LNFoB1wxCCMI0Ie8kMbqgOFQNxil/SG2k4afXiuEXzMjXM3DExKC2odVwNYifcoRwltIa6EjmvVWNXQL4mACFwI5WtKQOELPrbTQV6l9CZ4uNHGDaScqG2VAQ5EhUQlvzlHG1JA/QAe4fiNCWMAGsDYOTVr6rcVagKz0UnT6nxBK7XfV+TZbZNugt51tmV4oPivIXjNoPwjE8EkrKxILJWmkheBDfCC1MdDJEfQIk9u59IE+GDYtusLx/37CwY+UEvAKhF1L2TDXgiBTouArrE/cxFkC5nJW+35NDVDdNuhRmGE9M+BqiGO96L1/or+XgngfQ5Dj5Ugdg1lhBXFq7vYqCPfztRvUdgw0wKaGlZJa8Gh164FXaS/gOd6/TyHjE5woH14FOOFHy+EZxrdmSHZQSXke8thVvwfUWXMaFN+bZFS5h2Gbao8kEYK5dJn1xuzMriN5SlRwY8LG3iHJlJ1LtCIP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(66946007)(66556008)(16576012)(316002)(186003)(16526019)(956004)(66476007)(2906002)(5660300002)(2616005)(54906003)(31696002)(53546011)(6666004)(6916009)(6486002)(478600001)(8936002)(36756003)(86362001)(8676002)(966005)(83380400001)(31686004)(26005)(44832011)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dFVBRnU2VWlVZVM4MnlMcC8vWlRweEozVHNtWjFwR2VPZHVsWSszS01WUjBw?=
 =?utf-8?B?TzlyQVJEbithcGtlV2VLS2wxc1hUbTBIZXYrblE3a3BhS3AxMEhZR3RmQnN2?=
 =?utf-8?B?T1hJUm5zVHVVZmdDT3dIc21zNm9DenprUlhWTFo4NW1wSUVUeUhmbWlLYlhz?=
 =?utf-8?B?TWFGQWVSM21tNEJuSk9laHdHWFVqc1ZlZHNnbUh1eCtmVkdEMTFWS0gxVDJ5?=
 =?utf-8?B?eEkzZk1NYUFjd291N3c1RUNZWExZNDAvRzhtZURkL1YyTE9YTDRVNy90WEh4?=
 =?utf-8?B?ME5uTUV0UUpDcEV3WnU3ZUJ2NE8vMkxUR2ZnVnA4MFY5S1AzVC80VkJraDM4?=
 =?utf-8?B?TlMyNUVGSWdXQXNCNUdrT1pGYXZaWHlBZHN5QnhTNk95eWJ5QTNDb2FWUWk3?=
 =?utf-8?B?Vms3Q0RVeUNZd0IrWFkvRGVKS1AzMmhrL3FuQVJ3SzErVlpwV3l1eDRpcTl1?=
 =?utf-8?B?SnFGbm5jYTJtQkZObHBlYy9Ja0xOVkQzWGc5TTNFazhyZkFmOTAzZzBuRWdT?=
 =?utf-8?B?cFJ0ZEw0WWk4NksxOHFYakFxbk95Rm4zalJpbEV3UXV6VW1ZeFpGVFN6Y0ND?=
 =?utf-8?B?Z3NtNWFYU01UbmJIenBISnJjdUk1SW96VTNzOXlrSlNmMXlpNThDanAvVmtw?=
 =?utf-8?B?SFBpRm1XUGExdTNyZUJlaFYvaDJvMVhhSzRXZGRDM2wveG1VLzNjdjRJTkxt?=
 =?utf-8?B?VEtMVDNVK2JoMjdJRGNvdkVrVTVNUzNtOHozSTlIaElZckxoNjJQS1BGTHkr?=
 =?utf-8?B?QmdveTRZMGdqZ2dyNE9sMVc3SWZGT3NhbkJUSTIySHdCdEIvWnl0QnJWd1h4?=
 =?utf-8?B?OGs5RHJQMlpHczMrb2kvblVRWU52R3FDREFBeW53aWJSTG4zUXhBWkw1Y2M0?=
 =?utf-8?B?cjRkOTY1Rjk5Y3IwQ1NLMCtaUVZRbXhTaGxhN2M4Zm1lcTA0V0QwditLeUJw?=
 =?utf-8?B?ZnJPQi9jeU1LOTBOeW1lM3lxTW9rcXdTRUVRYXArYk1PL2hLanFycnB2K0Qx?=
 =?utf-8?B?T3ExMCtETkpoMFZKam50OXFQZ1g0YWg5ZTJCRVpCYVZwZk93NjNaeXpSdkFj?=
 =?utf-8?B?Yk1xYjRmR1R1S3pZM0x2bWtIbHNrWFJHZGN0c2kwbFRiV3A5Uzk5V1BqMmRU?=
 =?utf-8?B?TVJ6VG0zR1ZhWU03dUZJOGpjQWpvV1dtdE1paFdBYWlpTUxmWnB0UVBrMmRC?=
 =?utf-8?B?dVIxbmQ0cWdXZkJZTDVJZ0wrNVpkTTYxekdhZXJwTzBZbjg0M2djaGNIWnNV?=
 =?utf-8?B?RzZ2QTI2TDRDakhYWm5XaklLaUtDcVp6WURFNFdYTGpwVGVXTEY1OE9DbFFC?=
 =?utf-8?B?V0p4RGVKMStBQ1Avakh3aUZ1WTdBSkJsd3ZhZnJwSEVaUE5vajkxNVRpQzFq?=
 =?utf-8?B?VVlXZFRjeTI2R2xwdzg0aExuYUYvS3RMN1JkYzVXSDI2VUlSRGl3YWM2R0Rq?=
 =?utf-8?B?VmprNGREQTROM3A1WGt5dXhSaDZMN1VNUjdpemFTdjArb29XNTEzc0NFSVhK?=
 =?utf-8?B?MVRCSWI1aWxNeFhJeTVDMWFZSE8wazdSbVUzbzRSYXpEWWxkVnhBcVJjL2p6?=
 =?utf-8?B?SmpDYkFxR3p6R1lad3BLY0E0VVBYSTlBRlRCVm9vS0p2ZXdtcHdvd2ZEa05v?=
 =?utf-8?B?Mm9GU08wNGhUdzdwQkZlNDEyUEUyR0VhMmZETHZFN3Q5eGxRMk9TQTJncjdV?=
 =?utf-8?B?VTY4V3JoTUJmZ1FjR1hZUU5zYlRHQ29KTVNHYjkxMEFhQ3IybEprZWMwbVl5?=
 =?utf-8?Q?nL44BfmmcbPIYJ77R5woj+cVtP3nNVY5Dim7R5u?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966e8653-f1af-4966-a9a5-08d8dd38a933
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 05:04:30.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKeBwhOHr8hrFJaeyxhzrtltp14MstCnAnoxh3cav1Ok9ZsMMiAo9YfHa3f4021RZzyzffTFfj0XLCBH0GRcWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4367
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020038
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9910 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020039
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 26/02/2021 23:10, David Sterba wrote:
> On Fri, Feb 26, 2021 at 01:01:02PM +0800, Anand Jain wrote:
>> On 25/02/2021 12:39, Su Yue wrote:
>>>
>>> While playing with seed device(misc/next and v5.11), lockdep complains
>>> the following:
>>>
>>> To reproduce:
>>>
>>> dev1=/dev/sdb1
>>> dev2=/dev/sdb2
>>>
>>> umount /mnt
>>>
>>> mkfs.btrfs -f $dev1
>>>
>>> btrfstune -S 1 $dev1
>>>
>>> mount $dev1 /mnt
>>>
>>> btrfs device add $dev2 /mnt/ -f
>>>
>>> umount /mnt
>>>
>>> mount $dev2 /mnt
>>>
>>> umount /mnt
>>>
>>>
>>
>> In my understanding the commit 01d01caf19ff7c537527d352d169c4368375c0a1
>>    (btrfs: move the chunk_mutex in btrfs_read_chunk_tree
>>    fixed this bug in 5.9.
>> Could you please try this [1] patch,
>> [1]
>> https://patchwork.kernel.org/project/linux-btrfs/patch/20200717100525.320697-1-anand.jain@oracle.com/
>> Patch [1] still relevant as the device_list_mutex in clone_fs_devices()
>> is redundant. We could remove it as well.
> 
> So the fix 01d01caf19ff7c was not sufficient, the lockdep splat is
> reproducible.

Yes indeed. Except for adding another reported by, the patch[1] applies
on misc-next as it is. Do you need a resend of the patch?

Thanks, Anand
