Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A32641106F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 09:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbhITHrG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 03:47:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7864 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234245AbhITHrD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 03:47:03 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18K4YKb3019643;
        Mon, 20 Sep 2021 07:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NNns+Tyqxnp0ulYGA5P0p4hfDAVbEmmWRzaQp/C1+F4=;
 b=ru07silgf76+5mgBGxby2EeSXFH886eqQu775mokssD32CgBYa6+e1kOnUI+XThZNKdu
 OGrREoLDJqmukCX/TzBXykwtf/M137S4CIXIy1pIHE+DbKk6I26QSRqYu+6nwI4Ze2+Y
 YqKgQxVoQC00Ym6tEG3xWBJCao3a68OIRMSS99/msVDMlaOGqKT03HRbscR4ARp3xCsG
 cMJjUj8jEnRWk73eruUedk08B4g5XRpkIHXVpMzMkAOfS5CMcWna+V4lWqUptIHytguu
 MkZgs+95uJY7XK7lJU9Qd+j2qBOTfP0zdw6/hy31y9Em3UcJDVsE7q71dyY4IblP7VLa oQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : cc : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NNns+Tyqxnp0ulYGA5P0p4hfDAVbEmmWRzaQp/C1+F4=;
 b=rcLg1w0rMnYzbaPgEmyCPsPFwAEsqOl5vLc2qjcZ22WTmj4POsvbtv9XgpgGXkOmgUYQ
 PXxfl9rmpnNwggqWF/pGSu0t+6konzpzgm5dthOAh6P/tnl1NLggSEvzQqw6EHrVkaiy
 etYFqN2hYCfzKwGQCQxgTgCcHHX2/wScKpeSpt/tKcJy6TEKCSRW7A1HpAYCvxZJat6O
 EP1uGsBXYhFieO4Nj/wMXUisvQivgqGMGHVoqcCm2C6Hd3NtZguoNSS6pkV0myzA+3Pe
 AHigQUrPIsHKWg7viwf+xzZgZ7Qgj+UCzpFlxo14q4z3J06XNQt7G6brrLDF0NEe6oWF 0Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b66j2h9v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 07:45:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18K7jSOS001468;
        Mon, 20 Sep 2021 07:45:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2047.outbound.protection.outlook.com [104.47.74.47])
        by userp3030.oracle.com with ESMTP id 3b557v6bha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 07:45:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/8lTQnJgCNgxLUiK+QX6fxEhKZ1WEFRWonmrBYsXzU8wOpgf6ydVFVmQ42jBevohXZ9GwTj+efsyRsCg4NkY6GU7FMb4scmKHQ3VQdaoCne6BnjyEAuHkCNaJspSmxa2Zq/xdpzVOv9xaiZULJ8WbvdtWUb0xObRb7rI9huavMVBtZe8xe2dqWiFUVWRcZ4eOsWgBE5+HkHmwK+s/Gn+gRXyl4o445jpDseYDYPCgMh5krG0Zy7x28BpBlCKMjF3cJY7NEUEfPCxC4BTo/ldAGxTSp5PAlIqJoVgdGYZWTNttQvXL5/W0Pv8N0oObkgM61365x5mY96YihlqgX46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NNns+Tyqxnp0ulYGA5P0p4hfDAVbEmmWRzaQp/C1+F4=;
 b=lnYMTMLhO05+JoyZ/xcCsjLkJBa9/2IGS1oDhYKjAAWqwMvqp/UB5uZaaPFGfpQATPFAQ2AgiNgDH3e+fJDRZsJ5n/qZ+7M+EuS8QxsroskgZOdJrjh7IKHQUgMQfNSIuMuh8ixpnX+9OdUiwtY7kcuoPOFzUkvL43Vy+sQ5kuSwh2OVLJt26U6hZ2j6BogGVufk9O8qajRxzSQez9bpx/KzzeMhXeeH/Q4w95JI9p9EtcDpXM5UFo/owkxTdTUnQmvXEN1JANTrytOise35FVnmorSyaBNzUwTMyl2XlQnCrrXpZw3akDYe6+maLHWPtWcYrWp0CVxfU2ePeUWw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNns+Tyqxnp0ulYGA5P0p4hfDAVbEmmWRzaQp/C1+F4=;
 b=zQCPYKqhhLI5pVlG1xmcYMSJfGSelug9L3S4KUptq3rUsHGiDRkETS6IuRRDrru1vJpW1gagFrQDD/58JJK02t4B2DlsQmzTsVd3/+vl2e6Oanz/Han3aYdr25mChkwHwgY3hHPY2Y45r2GWHXaI5Q4CEpPybxqNBDyssr3YQ1Y=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3983.namprd10.prod.outlook.com (2603:10b6:208:1bd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 07:45:23 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Mon, 20 Sep 2021
 07:45:23 +0000
Subject: Re: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in
 btrfs_rm_device
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
References: <cover.1627419595.git.josef@toxicpanda.com>
 <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Message-ID: <17f703ef-81b2-2a28-6ad7-b94e2944be0b@oracle.com>
Date:   Mon, 20 Sep 2021 15:45:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0088.apcprd03.prod.outlook.com
 (2603:1096:4:7c::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR03CA0088.apcprd03.prod.outlook.com (2603:1096:4:7c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Mon, 20 Sep 2021 07:45:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a2b63b6-37db-426b-aca3-08d97c0a9a53
X-MS-TrafficTypeDiagnostic: MN2PR10MB3983:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3983D16A1E46346231DDF2ADE5A09@MN2PR10MB3983.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pei4tOMCtUeZiN8ld2KGYgEI1/c3giGy10mzKEeVbkKNuSN9LCBzW7aMQ2zKKKPKi0Ww2371FbGewQOnkqjiP5GhpVDSNZFP0o8KPl3HzqHKhLRtliaAYDTHyCf7m/NLHtE9N/zYRLNfuKPVjNQkjkvdNyZMUyg1YYPudrncY2YUybP/+QT5uWDn6cIEgXlIw35cMSIxQj0E2QEU/4DvKEK77m9l5gOBZ6a7aTv7mdx+oOj4ZXR1cZyKfrUf623hJ6y2yZ4CaHijJt3Aq3fRF03jV35f3Q+euGniFH/jOoLWECCQ/mDDqE9wvugsrrw0mDYtA1gpcMj5/O+riUsZP4Tk9MPvv6BPseV8kesmhgfNB7iu7kXSzjWUfzPdfURePGzie9JrLkMXpNzS1B+HRIO4peZjeQlCXgwCswlaxVHwuPO4i14FgnowmyoDPpKJ6F4qZ/+GxPsQM3ft1utDkRwUWgu78FrMsCqbGHEkjrPKk/pFb1cwc8c03JwKAiCMzB0kvzHNDvEJEDFynks33YRA0XNwTBnuHmS2MAcZ2yZN2f5YELJ/E8X0avnZhBnJZ3NKTkbpDC1F4hT40tHOS3phTGX4J54tc7gbqXDsYtTtW3XIzuJNKNSG4SdOE3kLNkz4ujtoegGkgpMrzrBYmkxAx4w/GrDgDHBcVE7eFkEPKGy9o4gPkpudq3TidIEIqtDSSBXuyUwN2UIsNhuwEX3lsVVHm5poleWEse4DrXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(38100700002)(86362001)(956004)(5660300002)(508600001)(6666004)(6486002)(66476007)(31696002)(8676002)(83380400001)(316002)(2616005)(4326008)(31686004)(16576012)(186003)(8936002)(110136005)(2906002)(4744005)(44832011)(66946007)(66556008)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBYV1VCU0J1bU1CeTRnb05MaXd0OG9JL3FuYlEvTjg0NWpjY0NXYU5GN0p5?=
 =?utf-8?B?U2pXZFVRQnJrK2dqSWxIU0g5NDJlT0Y5WHh5dWhNb2xseCtBOXM5bFVmOVdL?=
 =?utf-8?B?ZXgwZU5JYjdER3RZbFg2eDJsWDFJZXoxVjdkbXVXdnZYTUhjMGZpc3A2eFJp?=
 =?utf-8?B?VXpBdGlHSW9qdUx4MGdhT3lqVFZoOUpQY2l1VDhDdERVOEc3QnJzdS9PYkF2?=
 =?utf-8?B?RnYzUzQvNkI5NEpPR1pXWUNicWFDcG5rN1pXaHcrcG4ybkJGUVJVUE91ejNX?=
 =?utf-8?B?Nm56c0tCS0Z6QTRYSVRIc0lGYytEeVozNy9lQWtET0NQQTdqbkc5RmlwRWJE?=
 =?utf-8?B?ai84YjU3QUMxb0tpaTZ1YnNvdWtva2NWcDYwa3JDT2x1eGdMZWc0VU1PL1RQ?=
 =?utf-8?B?b01QVTdGY2J5QjlOT0pSbkhONGpZRTlwVmYxN3RCUThQWlA3T0lqNy9Xd3Q1?=
 =?utf-8?B?RTd6V0lVQ3duY1JwY1JWQWNDemcwTGVFTEZzVU5GaEZPMGxhcUQwaTRlRENZ?=
 =?utf-8?B?dmg3ZjNjVi9MNFlvb2hsWEgxcHdLWTRDamY0bi81eVpzeEZNcFU5ZWRwOHY0?=
 =?utf-8?B?aUhRZ0hoeWt0RTNyamt4Q0RHcXVuQ2MvSlAxU0FqOHp0UHEwN1FySUhyeVU4?=
 =?utf-8?B?akRoSWlTY2g5TnVzaHhqSlZuQXJlUDFLclpqcXNPakZwZU85OTllZldYTTl1?=
 =?utf-8?B?ZTRMY2JnMWFmV1E3cXY3bW5oM1UwVFY5WW56RFpoQVF1SU1uazAyZ1N5WEFo?=
 =?utf-8?B?ZmErS2F1Ump6cEJNTFFiUGxSWDArTHZ4elFoZVBpSGZuRitnODJIaVgra2NC?=
 =?utf-8?B?aVJZOG1wOWtoVi92MS9JTElNQVpNTlVYR0xkTkhKT2ZDdFlib3pFY3B3eVNF?=
 =?utf-8?B?TDVlRHF6cGdUK1lGaVdwREdNblNOZ0pSUHl4MHVkMktkZjFuRkoyaDgwaWFu?=
 =?utf-8?B?RXJlUlBHUE9tUHpGU243NGh0b3JTQk1LaERwTlVPWFQ4ekJ3eEhvL0dFQy9C?=
 =?utf-8?B?OG9aZzdrWHFYcm5kSDdIM3FuSmRtdWhFbjVLRThDMmpWeWdNLzNMekVhTnRp?=
 =?utf-8?B?QlhyNDc3dDkvbU8vMXJaanZBaUJrckFtZnRnTCtyTUVuODJGZXhqbkVaOCtu?=
 =?utf-8?B?c25zR2RkUkFaeWxWMVdOazVZcWJOUEpUNUVUc1NoVDhoN0JIeTBJTE16OEVa?=
 =?utf-8?B?djNjS1NnVDBUWUZRZDhScTFybVY4VnIrdllOekJvdTdlNUJmOGJPTlF3TkZC?=
 =?utf-8?B?QU9TZ01ZNEhPY2JWb0JLaTVpMmMyamg3Yi9BSEpCWDNGcmtMNWtneERnSldt?=
 =?utf-8?B?UnJmdTFJZ0pKemI5eWN4dUNhcFI2bG9HUWtuQkdoT3c2bktiRzZuMm5DbmUv?=
 =?utf-8?B?dHFYcHJCYXNUMCt1VkUzQ2prWE5rR0dSditwUVl2bVJzb2p2OTFvak45OGhm?=
 =?utf-8?B?Z3BFelo5Vnh5UTZPa0JvUFZycDRwdGFwdXB6cjlKVDdneU8wY1Rqd2Y4RFJ4?=
 =?utf-8?B?RkxoRzhDK0wwUDBsMXB3UjkyYlQ5VklPbFJnVDFyNnNpbGZvSGVZalRoOHVH?=
 =?utf-8?B?ZlpKZC8ycXZvR0dVZ2xvM0ZTU3d1MjBDVkJDcUFneFl4S0tOa0RrOVN0RHR2?=
 =?utf-8?B?dUV1UENxczhvYncxQ3Z1b2pUazlSQTJucUt2bTl0b3JpYm1aYWN1Z0xiNTlu?=
 =?utf-8?B?djlUdlBBdXJhK3oyUXhqRFNLME5Gdm4rcWxqQndnRStwTW9QREljVGlFVmRx?=
 =?utf-8?Q?mIbopQBcaHV/VyNW/iq+LF9f87JioNeKE2v7kTy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2b63b6-37db-426b-aca3-08d97c0a9a53
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 07:45:23.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fa2Bshp6taoZSgmvxJDGj69DbCBHYZ7M3joqCX+ozmXwiroS2jvT+E+9O5OA1vJFvmHmsHAeQDFk7z46Y9UilA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3983
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10112 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200046
X-Proofpoint-GUID: dKbSx10lUjPmPMLRsz-5dHffPQG4JIU8
X-Proofpoint-ORIG-GUID: dKbSx10lUjPmPMLRsz-5dHffPQG4JIU8
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


This patch is causing btrfs/225 to fail [here].

------
static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
{
         struct btrfs_device *device, *tmp;

         lockdep_assert_held(&uuid_mutex);  <--- here
-------

as this patch removed mutex_lock(&uuid_mutex) in btrfs_rm_device().


commit 425c6ed6486f (btrfs: do not hold device_list_mutex when closing
devices) added lockdep_assert_held(&uuid_mutex) in close_fs_devices().


But mutex_lock(&uuid_mutex) in btrfs_rm_device() is not essential as we
discussed/proved earlier.

Remove lockdep_assert_held(&uuid_mutex) in close_fs_devices() is a 
better choice.

Thanks, Anand
