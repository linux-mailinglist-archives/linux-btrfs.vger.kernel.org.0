Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5176F411201
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 11:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbhITJn0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 05:43:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61164 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236246AbhITJnT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 05:43:19 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18K7kqEa019655;
        Mon, 20 Sep 2021 09:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+n6KhG/S5bW1E8Y0yROGyZI2zug6piGS5/vd9J57iJY=;
 b=WNQPv7BTToV4lv4pNCdzT3oV1/yJobAVMElMH8HH5HQjqNsbB/7VlPgUBdBCnf1F77Kg
 iVNKkj8vR6amwEZlGTv3jhskrNGoQVZvb4Q2ktM7oceji3GJImd24t0Hf8NkFcboLp7h
 LmtNUMZwMiijTDVy3HY5kosKoJbH3LsW1I+n2jgnb7pnRuIzwscWaeaRtO+UB89HcsOy
 W5S+mjSRf2j9x0pIt+2/j8ARrzetzNEA3Ypnzqg5I4szdTdl+gYbDyJaSwrBmJ8u3m8E
 n+Kt2SaHn91mBedP3MI0DzL7o+ztU9nXiQllRUING8yz2vqUsFaOYz/IEXTJ25VYaasa fA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+n6KhG/S5bW1E8Y0yROGyZI2zug6piGS5/vd9J57iJY=;
 b=TSR9vPv8Gdq949wzYQPpWuwoaHKXu0DvZoUMjfFY3atdJDBpj/+E505ytzn6jlnc8Kyq
 b0dzsNimRYuP0oxwJZnEfNN1i1JStNg6InnDl2D6McaAUNyr+7/XZbvxDnagAxwzX+xz
 8NWHj97QT87gPAgCklDYnUw2f/IKAZnpADZNV1z26U4xfUPWzUToViVic91tamCHEUkT
 Wr3DYDlLrNdUPPlHsDo6K0qNDs85I9uJbpdwTmDkCsfVITu4XmFntvnqymRp7Xc3sqNJ
 RG2Tr0ygnDuFHFlkUQCIhQGDrOCes2atGQBUdr28UboZz+nPcxWolNYopoXEJ4PUmLur BA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b66j2hpj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 09:41:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18K9es9U163507;
        Mon, 20 Sep 2021 09:41:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3b565ccehf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 09:41:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrBABEYcCm8f2yC0+z9bsLo7T+46jyBHiDQioQlDv9Q1d6bJsUqrZBS9mklx8bMF4diJj+i2Ms1LZMQiNguq+mA9qigB2uG4EBVlpir8dVdDZtcKypwH6QxceglL56XyhzDneLh4O1I6yZSRpKlD1YRLYsyPGRHh3C19W6fkwfjrqTrYPgnVeotWyMhYbxAuvuR+YfCgj1wKamH5Hbh4/rYZZiX8ud5NR1mbRc8Krl8XhbIOIuBbVf9mmdjWxJBTOjGHL1kbdmrlwFIGD06y41PppZT54mURDiE6ZSt3kxIjfOn5PEpXmmCU+gHGOuHhxlkCkYE6CjCChADHDQmMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+n6KhG/S5bW1E8Y0yROGyZI2zug6piGS5/vd9J57iJY=;
 b=Cuu+0QmosqfOI8Lk3pZeUxiyxWY8qahIc04y5krSeFF/6qH8TM5F7pBkGy6CHnFu4V10kmLp4y3pdvLQr0bUa6O/Ws72QU8V/wxKJ/kG6e87mBcU7O2n12VL6qh4vb5ztxwDgFT9s8/ckTEdyLeKxL+sKIcsdwleE3Nhq4pphQMKF2fiJYphGLD99aBmCnVKPlYx1gftHchaarLmJJI4Qv4cS9rexl2lK7LOFOjMlj7Fh6cyBrY/1zDAkV6OwMcCVqzCTgVOpnofYa5r5zbF4BDRn83RXcCLdAmKsLrRODk6Ck/02SBdOd3nxf4zV36f4RCDU9YlVZuxw9nxTojrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n6KhG/S5bW1E8Y0yROGyZI2zug6piGS5/vd9J57iJY=;
 b=AL05N9KoaOpwMNf/JJAiDN6Mws6M/vPej0KR/9SLTGgHbxf/cS9p34FHisboXQVOienhJSrxuZFO9/Zlg0CnPqkS8Fcerjggds4SN5418nNCDdoutHb+dOK7O7UZVQvN0Bn/XRTNzklg8EkBAy80WjxcMQy+897smK4gWVKqAIs=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4013.namprd10.prod.outlook.com (2603:10b6:208:185::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 09:41:36 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Mon, 20 Sep 2021
 09:41:35 +0000
Subject: Re: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in
 btrfs_rm_device
To:     dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
 <17f703ef-81b2-2a28-6ad7-b94e2944be0b@oracle.com>
 <20210920082638.GY9286@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <31cf3228-b666-d165-2d4d-b3f12bed3b6b@oracle.com>
Date:   Mon, 20 Sep 2021 17:41:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210920082638.GY9286@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.4 via Frontend Transport; Mon, 20 Sep 2021 09:41:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 486386f2-f704-4c7d-7eb8-08d97c1ad60f
X-MS-TrafficTypeDiagnostic: MN2PR10MB4013:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4013E99A784285C5BA314521E5A09@MN2PR10MB4013.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujtA8cxKXe6v81fLxM75mCjqQytWnJIEEqgLFPcmlNAYaMqbLi95VsdK4vkh+wK2l7xPgTm85eGXoGN1/PxBNL5JtmwosIgEd+QU/TEgkJXRI4Do0ataOS1gkLi6o80hBAe5Y1qeXYx8YAUwQU/TxWFrNVJJjjRRXREd6ksVuqjPINJDWFD6WFGiidpkkI2eBPaODFnv1wo2+UJtYTiVBH8xCaAbr8rNN0QGd4tsCQyFh1OcAfKG5zUs6eWBFX7imcT7rNpKCXLvKKAXv/R9GyqbjmgDPqqTtVn4BWsiKGQUu0swaUl5Vr6LxqazOkC1tBA4nlgmkidIjwgMrTDyVmdiqPNbOA1JJTS/Br7+dQfW7cfbIBBe+kkSPXvlkIoex8MHBW8TnXGWf/rkw/I8Dn5zA7GsuzbqksQHr9rU1UIpoZb/1n2d4Ynw7rkNXBTsJERGRBZ4rj8FchKsmrrrSoIo1oWKa2a+s2SNc5aFutzs4K6kpMGKPA5fYtrRPG7GIuugbbIP2O1J1yp2ZFqwH8JrnMuYsLldukDXQuTCFcU3lyaReOSA5nU5OzeR4drv/aIpVvSxqe5YmvHWu4qjHJAtjirLpWN+J59CTbvDJqQt0Uu2mJmfArPTUQMH3JfWHRASEtKiTDGWyr19djeZXWYIBsuLEji5OLGj1/r509zs+6RiinS3/NAM9CRh31NaE7wZNA2hXFkVdwo2Amibo5RSogQhw2EqyiQ+k3zOcFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(136003)(366004)(396003)(26005)(31696002)(5660300002)(2616005)(16576012)(110136005)(6486002)(6666004)(956004)(2906002)(186003)(316002)(31686004)(8936002)(8676002)(86362001)(83380400001)(38100700002)(66476007)(66556008)(44832011)(53546011)(36756003)(66946007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2ZydWp0N1JMZXZFSzZ2OHh2d1gra09vMGFRUSs5VGdZWXVuVFhNWnRBMkM3?=
 =?utf-8?B?OTlFdEV6ZmsxM2ZRNm4wZS94U0xWUk14UFJnSzhUTW9FT0JKVVNRRWwyeXlo?=
 =?utf-8?B?eHY1WUlnL2w1Y2MyektFa1dCb0JuZmR1TUdtckdORWZnYmEwQnZVT3hZaThR?=
 =?utf-8?B?WkwzbG05UHJ3MVFJWTlrNkoxSTkvdGdlVVl0TGozU1c2ZFlpVXhySnBIZWd0?=
 =?utf-8?B?VlQ5VGUrQXQ3eVAzcCswSDV5aW43WExPeDRnbVJ3bDRTeEJmNS9yOVF6ZTZJ?=
 =?utf-8?B?aTZIRWRwdkU1Wi9HRXZUMnljUVBhSXN4M00xQXJZYytuMGNDbmdDTUVtdWk2?=
 =?utf-8?B?WVB0ZzNHZ3ZlYXdEbWxOekFVK2ZCNm0vRzN6ZkZKSVFrY25XZHFZYW1ZUG1G?=
 =?utf-8?B?cGJUWnZoQkdVUTRxdnNOOVd6bFpQMmkzTkpPVWRleUhuRGM2Y3NOcnpSanh0?=
 =?utf-8?B?NEx4OFc0YkpYOWJoSGpZR1lQUmpSZm1yUmE0UW4xS0Z3UTlTM3FYUlZiRUxy?=
 =?utf-8?B?VEdEQ3NCaUwwRmh5NkI3ZkJ5NHhKMHJ6d1prelVpV25pK0huTnZwK0RmcC9M?=
 =?utf-8?B?ck1RSWhuVWNNR2dTaEwrYXVSZlhLa2pzU2wvRjRMdmlPSFo0VmF0L3NPUnNX?=
 =?utf-8?B?TWlCcE1BSzFna1VsTGFnNmZnRFNpT0M5cUJiVjV2dlR6c3hVZlZ1OURpL3lr?=
 =?utf-8?B?aTBBaGUwVW4vTDNaU2RranhSaHIzbElTb2k0ZEJzMVNPWHBTS3VrVnNNRDJk?=
 =?utf-8?B?Y0dyVHpLRTF1amsyUDRzTDBQUi95Z3NpYlZ4MXc0SzBFTndCWTh5a1ZRcXN0?=
 =?utf-8?B?a05ZblJ2M0lYcnJZbnNYaXpmTU9SUFM0V1hiTDAvSHBSOXZuSUlQcWlMTVZK?=
 =?utf-8?B?ZjRCcTZ4Vi9GT2gwTTg2SnlzRHVUUVE2Myt2WWNNQ0hRYnN2Qk0xeUlkYXRL?=
 =?utf-8?B?a0RRVDd3RnFXS2JwRHJnTzVoa1hCL0o2enlKSmhhZGFmQzA2dU9yY2dtYjFq?=
 =?utf-8?B?N3JTWVV3S0paRjdIREJ5S2ZIUm1ZdVd0NWJyc1ZycU01Mk1ybHVVN1dlMzdJ?=
 =?utf-8?B?MHlKWWx3SGlVYWJrZFkxKzl4S2phZ281bHp5SzRoNkw1a0xwblE0aTE2c1lY?=
 =?utf-8?B?aUZEODE0cUJJeE5ZZTFNTWlseVpHWHpzaW83bVBNcmlsMzRQclV5UkNWdUFr?=
 =?utf-8?B?cmVaVWZjclZsNGdhMTFWdGZraE9BU1N1bUVaOE9vNEFkcHhjYWlNUnVMNkFk?=
 =?utf-8?B?YmdDVkI0M3d3NklkZHgwNGROREpRbW13UGNubzBTdU5vYjlSNXFMNHlob1JT?=
 =?utf-8?B?Z09WNHBRZjk3Zks2SGt6VU52Zk02Nnh6Q2trWkQvRVlIQllyeTdkZUdyTnpr?=
 =?utf-8?B?c0ZKYW85WU9FVVFxSmltTnhOaUpBaUZwdVk5K2RVODdCUllXUmJ1Y2dZRkl1?=
 =?utf-8?B?Q215eEovTk9EUkhSR3gzNm1qNzIxcFZhdFYvUUp1eHVsb3Bqb0tSN0o4Z01r?=
 =?utf-8?B?eERUYnA5MVFzdDBsLzl3N0JCWmp3Y1pDaWVUVDdWRFBNVmF6cnMvdk9tRlFr?=
 =?utf-8?B?azRzc2IwdDB2ejB6cE0yUjE4a1M2UHViaSs1SnVhcXZMQURKQUhTeWEwRUti?=
 =?utf-8?B?dWxtbXZKQ0M0VmprcW5FMFIyN045ZXRneUxiNmFQYy9KRlpjMFAwL2lDNGFR?=
 =?utf-8?B?a3J3Rmo4ZXRnVmlwMXc4ODI3clVKNm9hdFFNQWNyMkUxc2I5ZUhDQlIvTzNu?=
 =?utf-8?Q?vTxf2rT827UOxRWPZ7aqsuvXAcQCgA35u+vMjbz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486386f2-f704-4c7d-7eb8-08d97c1ad60f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 09:41:35.3303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yElTVAKoeCGiJRsPCYsiP1zUj2Yv5N4rgsyxsgmaCUPgtRqmf3a0X4iHLG2G7Xe3/Gcz6zdAj1hL1Shc8FECg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4013
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10112 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200059
X-Proofpoint-GUID: J9nXc4h7IPg2O4rm-Pyfu34iW5rUFIdJ
X-Proofpoint-ORIG-GUID: J9nXc4h7IPg2O4rm-Pyfu34iW5rUFIdJ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20/09/2021 16:26, David Sterba wrote:
> On Mon, Sep 20, 2021 at 03:45:14PM +0800, Anand Jain wrote:
>>
>> This patch is causing btrfs/225 to fail [here].
>>
>> ------
>> static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
>> {
>>           struct btrfs_device *device, *tmp;
>>
>>           lockdep_assert_held(&uuid_mutex);  <--- here
>> -------
>>
>> as this patch removed mutex_lock(&uuid_mutex) in btrfs_rm_device().
>>
>>
>> commit 425c6ed6486f (btrfs: do not hold device_list_mutex when closing
>> devices) added lockdep_assert_held(&uuid_mutex) in close_fs_devices().
>>
>>
>> But mutex_lock(&uuid_mutex) in btrfs_rm_device() is not essential as we
>> discussed/proved earlier.
>>
>> Remove lockdep_assert_held(&uuid_mutex) in close_fs_devices() is a
>> better choice.
> 
> This is the other patch that's still not in misc-next. I merged the
> branch partially and in a different order so that causes the lockdep
> warning. I can remove the patch "btrfs: do not take the uuid_mutex in
> btrfs_rm_device" from misc-next for now and merge the whole series in
> the order as sent but there were comments so I'm waiting for an update.

Ha ha. I think you are confused, even I was. The problem assert is at 
close_fs_devices() not clone_fs_devices() (as in 7/7). They are 
similarly named.

A variant of 7/7 is already merged.
c124706900c2 btrfs: fix lockdep warning while mounting sprout fs

