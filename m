Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AF83F28FA
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 11:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhHTJOa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 05:14:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19276 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232991AbhHTJO3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 05:14:29 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17K9Agg2001324;
        Fri, 20 Aug 2021 09:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QKnFeLwtF7T2/jbSQV9Dgfcko+I3N+dFh9MnzUH60g8=;
 b=lZ/hCvkDxwT7XD6uyf8oID4tacH9airp2oeAaeJUXswXzyd3ENb3UHnsoybhDxl2C0hY
 PYzYLBNAvKB/qL+pE9LIr3VNoGwAA0qxXoGkpAlOoraO7QH+FR3pp2wzXZUR2w7fBfDR
 BXjUcX7SpLFTjpPNbcC6FUHH3NhwGWL1iq+HzO+14NoeCeGIlzdRL/iCV5Ld7hs2c3Lz
 xlDVhbj7ugu+q8K2/I9gHRLCckuK5Os4auoqOZlPnT6ODnj9S/bGr+8oXHl9D/5+Mjc2
 tbcH3LXdq012tPugaoPg8vcT7zJFpHbLgw6mnAl/TyX8YR058DVWwEGOfLfG2LKsoVpW IQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QKnFeLwtF7T2/jbSQV9Dgfcko+I3N+dFh9MnzUH60g8=;
 b=BEopjs55TRqQkMEfxYBDQc6XgDKDesNnxIP79UhUDeXLXqwot79tna7XPRNMvnSQ4Me4
 FRfplRN3aAn+GRdPWGYxG/kLDTXauKAmrk1WHuwyXAhuRMWKfr0NYYmDbYm51NHqofGI
 ZgjZJ4RNGIJaN4uDSCsuSIZoc0UpUGHrqwNFcb29nxpxPIVDlyf6SAKYLh6THTgmkrdk
 xS8kMCPO4sj09VIXC8KCO4QWDL4fi4vTrm0wIH26+oZmlTefGO2ChgBLJ8r3kriX/3iC
 +ACmzlyiColgUJqG5NKFIRyTgRJYClxPU23DC6DUgXdcFjOPcnwc6eueTCT2Iavq2Uhk ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agu24p276-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 09:13:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17K95AAk015961;
        Fri, 20 Aug 2021 09:13:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 3ae3vn73d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 09:13:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMopZ2kLx3+1d8X+OiBRC6PtzBKSPrzYGm770wjxWMC4SkJziGl+eT6360xnxRosQ35EDK6HQrx7zy4HQT5AGvFDvtLwqbgSU2pU20sPksX+seoNnJbVqBQG9trzfgUOaWWNMC0mfOsi71qTP7S0NBcoXHj6vhawIMPlnt9G4kzGSd40E1kkY9SqiabtD16OYwOMXXIur4HMLkNRBb8PFNR5zsjkJIqhv+/WhFywMQs14dj4mePyuUB10Y2TT26iFf2nzLDIPGEas7Awlz7eUzvA3YuaTg5QzBsFGoKRIT4hV6stF+WhxWZbJxR4S0l7uCLYsoUa54266roSAF1QXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKnFeLwtF7T2/jbSQV9Dgfcko+I3N+dFh9MnzUH60g8=;
 b=LurtcXxHtTCIZklVub/Rjl8bemdKG55iGN5MayZLu5L5BFvbd9zfVkuwCWUGa1XEeKdJv1NIIqZWghconBHBwx93cIuVNZsTc2PNLv64xwYBBKuAi1VKcKynLmvqnyFrCx3NWCC+dfXJeinGRQHpuoysVkKVbPQECkbbGf2Iz6xfXrwuXVI5OlFnAKgDbUkHZBMYIy5/JUVJltr/MHvCAVMTzyEtdSzVZlRpcXlQj8I8nBnykeI0bXsQ/+Sv8YCwcQmEd1nwvWHnz/5tnBVl/XreYJ1zQcmID+SU5/TlbeZNrjSJeZywirDyioAoECi5DJkH7bCeQBv9N3a9bXxzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKnFeLwtF7T2/jbSQV9Dgfcko+I3N+dFh9MnzUH60g8=;
 b=Z+k7qLofdRBkhuhSjuA8oldg1AW7JaSJYE7AcGwExwDrldEZ9N3k5cEGVxq3CpMwc7+OyWGUWsI2Q34djqESWPijWLaHA7IvAO6TLbvS7L/Ae8iX/XlyB5eX0/MyE+DRXPSEZ9/LDQKOkqpBqH05vSrU3Ea5yYUKAOS3AbmZhes=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3982.namprd10.prod.outlook.com (2603:10b6:208:1bc::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 09:13:39 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 09:13:39 +0000
Subject: Re: [PATCH RFC 3/3] btrfs: use latest_bdev in btrfs_show_devname
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <cover.1629396187.git.anand.jain@oracle.com>
 <9a06b04b9003f86c3300e497b35b0ef0310c84c0.1629396187.git.anand.jain@oracle.com>
 <1r6ofu54.fsf@damenly.su>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <332e2d65-a258-8bf8-8f26-9571535e7075@oracle.com>
Date:   Fri, 20 Aug 2021 17:13:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <1r6ofu54.fsf@damenly.su>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0091.apcprd02.prod.outlook.com (2603:1096:4:90::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 09:13:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a667363-19a6-4bf5-1d0c-08d963bacc56
X-MS-TrafficTypeDiagnostic: MN2PR10MB3982:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3982BAC053D68C3814F56BD0E5C19@MN2PR10MB3982.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byxoSMXkLSxW6R+MJshix0loBJcMXGxm/mdl0MONUjTB3hdxs5oG+60LN0LvcxE5z4QJd+0wf3HDVBMqN0Ja5Lmzp/DbDPrQ4oQLnTbIZZ4uJaV5XVGeNaNwAyewaO0ctOweV4huWfrT9kXGC3b+gd63niUctHYqXffqrRfj2Kv/rfFfqP5FjQp+ENay7eOtC+ZMofl6jlUsx/8pwSDwQnbnFirzH1tI/ZP3beQTQyK3EFP0awZw/hdwc2JznHnon4v1PoTPOGbXR4Bqe0uci5zoESFc4Os7FTKq0NFrFyIvoStnGSUy6OQVE3/JwQV1NVy2KnuutPha+RfzLp1sljOVOJCTZtjENHOLJ72EymztvLIRC+vzTL/mtON3q8CBvn2EpXd3oQ6C7syDyfapHzAeK4/GZHbpLgX3ZyDi0PXcfAqmWH4aqqzL8CW+pecDW2EqFXkIsU26Q81mA0Xy1C+PRrVW0HAYWoSWi7XOHP9Hzo6RM+/TrJyDKBvsDcI83C32wvPNLDO1Zn5QKKq+Iq+8kcIH051SPoqf/s2ekDQQ8jJLpSMEgdxBViMM53rZjbV6yS3yNnYRRntxUlNGAqHLx4QV8MUWdzvK7oAiaTjiDkPkB6t+X5BxBHF9SQ0Bq8P3ZSy7wpkoU0MBVvyETEQBO1j0jnaHuW6DuOS7W1ups/Q/bIIEbfxB+PUxzWaLWTY/3f5nIHI7AOAlsCvXo/G3gjPopKNhCwU6jmk7S1HkOErbo9ejsFHdEF2iEg2/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(2616005)(186003)(508600001)(2906002)(4326008)(44832011)(5660300002)(6486002)(53546011)(6666004)(66946007)(8936002)(31686004)(38100700002)(83380400001)(316002)(16576012)(36756003)(86362001)(31696002)(26005)(6916009)(8676002)(956004)(781001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW1uVlM4c1RnWllENTFvZ29xaHAxNURMVlY1dE9TWGF3NjZQQm52RmZMUHBH?=
 =?utf-8?B?QnovdDdQaDNEK29NUXNsWEU1dVF0ZFExV2wwOHBTMmZObkdOS2p2WTA0TVVH?=
 =?utf-8?B?Tk1pY01tMXM2TjA5VmpWOUE5VWRlNHQ0TjI3YlJKTytCdFZoNDVXZkJGWGlj?=
 =?utf-8?B?aVFkVENNTTgrREVDRlRhSnJWbks5WTZJUVBPZDFld01TWURNcFNZOWZ3Umw0?=
 =?utf-8?B?aG54YkJYYjRjQlJEc3E4WnJwZmYyV3FOdno3Tk5jaTBCZXcraitYZjZCZUFB?=
 =?utf-8?B?cmk4WVh0QkdUS2VGYTk3Z1g0Yi91R1Z2TE02Z0lFK0YrYUZvUmY0M1QwbHlX?=
 =?utf-8?B?NzZYS2hLbG5OVWZPY0lhVldSdTRUMktTODl4d3lCSWpZNDg4TTNETmtKQW50?=
 =?utf-8?B?VmRyY3JDVm90WUFMOUwxT3dEZDlieTc2Q1J5dklZeWM5VjNIY0tISG9FY1pI?=
 =?utf-8?B?c1hGWEJNMm1nSUNWZmI1VUNWSmdVRkhhVkR2SHBUVmpqRUF3eThLdlhHWWZs?=
 =?utf-8?B?R01BcFhhYUUzV21XMTBXU3pFZFNiZ2E0bHRmS3VjVFVVdGpVS1FSdis1KzVR?=
 =?utf-8?B?VDRqdEtvd2cycndGZXFnbGJNZU5VbVRRS21BVUl2NVdPRGZrTy9zVWVkU2xH?=
 =?utf-8?B?dXBqTCs0cmxPZ2p1NGJMeGlGN0hiZldaUTFJQWtoay90dHFHSmp6ZDBZOGdx?=
 =?utf-8?B?bE8zbnMrL3BKcmRYalJlcFlaMloyaE4xd3VudkZwRTRUZ3JiL0VaR2liUzE4?=
 =?utf-8?B?Y1BMSGZTdjZ4NE5jN1huMjNlY0Z4U21YN29Kc1hUaUNDWlFML3c1SFJrRy94?=
 =?utf-8?B?ZFVUZmZZYWxhS3MxcDBoYnN2eEJrTnN1em9JMjhDenBna0paR2I2SHpvVWZt?=
 =?utf-8?B?R1NSenlMczhWS1p4YjlBVnlZRzMyTUR2RHhUeVpJeXZ5REJnMXc2eENTeHln?=
 =?utf-8?B?RDZFck5lMG0zZytDR1d4cU5zVWxaaWJtUnVwdnN4OXJaYmxGUE1JeGVFeWxL?=
 =?utf-8?B?RmNSVUV2Z3B2OFQ5LzdoZXBsd1JwNWtNdUFvakhFWkNMM3haVi96U25sK0tX?=
 =?utf-8?B?OEh4VHpMSnRwNWlhbDFxTFg3QTd4U1orSFFMRjlVS0hoRGgzRU5PQjk4b1pC?=
 =?utf-8?B?YjJpN0RIWlg2Smg1RCtVNnZkRXd0ZjIyM0JNSmp5UkhDWVJKZlBVb1lmN2VV?=
 =?utf-8?B?LzlqTTdyZTRFeUZrdHVRMjlmQjllY3Fvc1o3V1IvWVdMTFlDR2ZvclRVMlF2?=
 =?utf-8?B?TkEzUDJ2c3hoVTF2b0EzSldYQ3FFV0lIUEs0cGcwNXBhSVdPQWdGMzhDOXU0?=
 =?utf-8?B?bHFkUDlxQ0V5bnRHMVRyNnJ1MnJuVXljTDNjSVJETGVaR2ltdDZsR2ZDM2N4?=
 =?utf-8?B?bFpLS2hUTURSVjNienJ3Q2luaS9sUFFLVE00M21xTXRkTlBnMjJvbXVyOTNy?=
 =?utf-8?B?SnJEVDV5cFBsUDRaRU1rcFhET1lWL1l5Q3lKdDRxaWdCUlY4Yk5ycDFQN1dR?=
 =?utf-8?B?STI1QXppeDYzTW54a09RS2krYnNBcDNFaEdkcTl4cjlNL2tXZGVtM3B2NVpM?=
 =?utf-8?B?STExbXlLU1Q3ZXpYejRVN091Z1o4K0lkUDRvNlN0a25LV25KZWg1aFkwMkI2?=
 =?utf-8?B?VXJpOWtFMUpFdGFWd1RabnlFS3AvODhYWHB1WnNpbnhpdVBzY2Q5U2tib3Bj?=
 =?utf-8?B?L0Flb3lrMGVOZXdUbG1WcHhSd2c2bzVXSTRQemRYMURZNWFvaGZxSjNlcnp4?=
 =?utf-8?Q?qk9COJlje+GEUrb+EfQkiNLOWyKA9VxB96LkrUL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a667363-19a6-4bf5-1d0c-08d963bacc56
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 09:13:39.4232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tBBZHOz4QLtIWKu7b88f7Tv7sa7zrKcQiC65Y+mAnNeWEqqysxh4wh9dYeyLuzkRGJG5r8c3u1LgO6TahVJtnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3982
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200052
X-Proofpoint-GUID: ywlA13JCPXlddVdR3Bhhm5R-j7yCIpCO
X-Proofpoint-ORIG-GUID: ywlA13JCPXlddVdR3Bhhm5R-j7yCIpCO
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20/08/2021 15:31, Su Yue wrote:
> 
> On Fri 20 Aug 2021 at 02:18, Anand Jain <anand.jain@oracle.com> wrote:
> 
>> latest_bdev is updated according to the changes to the device list.
>> That means we could use the latest_bdev to show the device name in
>> /proc/self/mounts. So this patch makes that change.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>
>> RFC because
>> 1. latest_bdev might not be the lowest devid but, we showed
>> the lowest devid in /proc/self/mount.


>> 2. The device's path is not shown now but, previously we did.
>> So does these break ABI? Maybe yes for 2 howabout for 1 above?

  In v2 I am fix the path part. By replacing latest_bdev to latest_dev
  which means it shall hold the pointer to btrfs_device instead of
  just to its bdev.

> Mabybe a naive question but I have no time to dive into btrfs code
> recently. If a device which has highest devid was replaced, will the
> new device be the fs_devices->latest_bdev instead of the existing older
> one?

  It is handled by btrfs_assign_next_active_device().

  If the replace source device is also the latest_dev then after replace
  it shall point to the replace target device. So the new device path is
  seen in /proc/self/mounts. Which is fine and normal to expect.

  Similarly btrfs_assign_next_active_device() is called during remove
  device as well.

  There is a bug that we didn't update the latest_bdev when we sprout
  I am fixing this as well in v2.

Thanks.
