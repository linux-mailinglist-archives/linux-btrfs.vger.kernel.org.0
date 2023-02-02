Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC0F6875DD
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Feb 2023 07:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjBBG27 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Feb 2023 01:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBBG26 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Feb 2023 01:28:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDC172664
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Feb 2023 22:28:56 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3124j0LA013634;
        Thu, 2 Feb 2023 06:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=lmIyvVBmxAPvgZvWmX6QLe4hg2vY87vnXo3Co8XNYl8=;
 b=USASjT5ifvgZ5I6n4Ti3MkvCSAdwiOEnBNQ696Zqh6U1HOwN09T3pNoWuRVNU3aRHQSn
 2ypXOT4pmceKiBlQK4T21a3poqny1xjIb0DQ2PXihQhFdeZePDVvgwgujFXJuDFYt1lJ
 m1CpUOI4kR6AEuCs1HDu6rtHESbATuS1UFlIn6vb2+qFcDkSDuyjSJiLX8WL2qFOq9dI
 tovxKdtancMjC6lurH5Zkz+8LxJfQaOXR26szBQ5WuWymHSAp5KwPowv4QXDQJByKNEs
 UtCeM2he6neV/5P+KfAsvOGyjcLvcys8Y/3AZPhaW1qMsqxabPQB7y2k2Ti1f4OH5c4l lQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfq4hj30s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 06:28:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3125Uk9C012954;
        Thu, 2 Feb 2023 06:28:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5f710g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 06:28:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYc5G8EjF1aCnWiJShA0xP1bKXHblL6LT6wa0hetLhjBl4Zub1Dzw7xV0urF/Ow/y/He4TDLtm1IrWVqzmp/KFGi0BJDwcqmYc/wYEbge8oYtqeaTCe0TI6dElhTNLfABu90fQOe+NzokAUD5ExZapMM39Mwzl81V6dm1pj4DBfMX6ry630NI7iE0bkxBYy2vJh4ohmlOLZirjZMt6B4wbNN7NffUuafsIbUE/yz07UTTZoZdh6jjwlWWF9q6lrpGxYRAk9xJK/pAksVKEnvxMaw5gVMCsaFRvQulGh09dXrP0QoI30bWH+gBDoGkiZ5HAQD+oeTrKeRtfNSUf1uJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmIyvVBmxAPvgZvWmX6QLe4hg2vY87vnXo3Co8XNYl8=;
 b=g9i8ws7C6fNG+F1SCWDMVVf6H1qQFuLoPW3d/GpLWag95h5vfKLrzE6BWNhuiv5z0Cypk8VolKtL2P81Lp6rnVInB48w5IR8nyixjBfW24+4WssHNnjLx5An2+FPJ4lGLTHJUyLMp74wm0EDYaNV/EqwxLLd0b+Zaiqrxb1bsKHvgAvLsUZHwt7vAnAh+6jDsNlUklAw3GXuG4Yx3H/7ursh/+54hZYW1GqaX0Ad1aiw0r5YVvpddC49iFb+y6BZ7KOU6/I/+LDDJCmrLTNIzYQDn9H1qmmuc6LQ6Ug2hQdtYVWYrlRlP6ocWGH7dir1hh/LttmzofYbd4oyxWCrlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmIyvVBmxAPvgZvWmX6QLe4hg2vY87vnXo3Co8XNYl8=;
 b=IjaMNWXvDxh9oNIxaJjVqAUxZBHbDen3qVZDQga3ycWB7dX+CAWj9H6P3j0zlgFaiv8/JyJ+8I63VeivFFoBatam2/O3ns2VU1359I0NS7Dzz6E6lnBQ72/0frxIl/4VRsecA3yY3z7iLrQl/JsTXP54HaUgYdza87BI+3hMOAw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6277.namprd10.prod.outlook.com (2603:10b6:8:b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.19; Thu, 2 Feb
 2023 06:28:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6064.021; Thu, 2 Feb 2023
 06:28:52 +0000
Message-ID: <5195283e-7e3d-6de1-75f4-d7f635bfc0ab@oracle.com>
Date:   Thu, 2 Feb 2023 14:28:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 2/3] btrfs: small improvement for btrfs_io_context
 structure
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1674893735.git.wqu@suse.com>
 <a02fc8daecc6973fc928501c4bc2554062ff43e7.1674893735.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a02fc8daecc6973fc928501c4bc2554062ff43e7.1674893735.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:4:54::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 83164b32-4e32-4c45-13c0-08db04e6c022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhP+u2Jx4GA/ClGV2UGbsaK2u0qSbeBpXXEwEOcwwJnaTKiS+1AewiG4xUYq3xWk2VQaFDtO7TunJGQmAK38FrDgYWCcKfbnvO1VR8iIfKGs/f/nnhgvQpxsN3KWxZWtozCW9h8a6Upf891OXHnvdSQHHjxCB+tENi1ePqch8jVnnPPtGF/1QkrYtQ3ZhdfcCKnwiLC2t21w76b3zpspIuWJbPxZeZbftPkIS9y5Wws/KIO+Qs+p1kd2HYA8VDOAW8EEAC4rFl0jJOfWzeGUOmpRCvwVa6pWYrro9b8k/qmMQd+KTDJdBDwkofffltVgTqO7oaQ1Vaj6bZHWDTtz0XXVqfUSKeiLAUDAwPTonGGEGH42SgxKdaaoCyRnlpxLhEzx1EPOjJ73WrtjMeas17YX4bFNFVkKOpDEBD7bc2q1ol+O5U1aThb/AhcCPGMAmOinLDY7/pgwBY19iSCYhqVnjWXYHIRiLLWmvAY+Rf1FD2paTD6uU8DGzABb0CH41vVNiaTCAYKTxLt3hKyOxOIdBKaaK3Q8tBLtpFw4VNF/s7fVLVie/pmrwQxBfK+rjG9LkLQI/XSQyDjXVSZfyXHp3teP8tcxyuHFfMj2WfCKoxDNK76Fb8+OfWOMCYSJdgjbLjbjhQ2IGhkgEhIoDL0cnFxvjctmdzxhuc95U0AcbX2I0+lc+BNIXIHzK5vTzWLMifeBbScdzayS8BYhxjA6yT9cvrQYsH0Oq8FhESU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199018)(31696002)(44832011)(4744005)(86362001)(2616005)(38100700002)(2906002)(36756003)(6506007)(186003)(6512007)(6486002)(83380400001)(26005)(478600001)(6666004)(5660300002)(41300700001)(66556008)(8936002)(8676002)(66476007)(31686004)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU1FclRScEFEYmxrVC91TFlVUHRaYXBmVEdDckpCNFdpMjA2YkV1TWxmdm83?=
 =?utf-8?B?U0ZRSHRrd2ZLRTIrV1E1SDNXTTEwVk9zelpBcHUxeGxmaUhubVo4aVFlTEwx?=
 =?utf-8?B?ZUNsS0UzOUdIdXFpMm4zSDVZb1E1bHVuamtNeXpyVDF1SUdrQVVaSkNjUUhQ?=
 =?utf-8?B?OVRnM0xNYXpvZWN3dDRzMHBna1RZREVmeFE3cFZpQVNBR3o1VGUzTGd3bE5Y?=
 =?utf-8?B?ZXhWNXhsVFd3WjUwajIwcCtka051cWh3bHptcVNhUWtGbmZCbDIrdmJRVmFi?=
 =?utf-8?B?bytqR1ZRakFwS0ZXZnpnZkRSVFJtMFZwOGJVcmJnYnh6MWczZHJ1RFdwUzcr?=
 =?utf-8?B?aGNTd2hBRlY0cmRRL0VaYnhmSzNPc2Vhd0ZvOWVObkRoU2N6UWk1cTlOK3lo?=
 =?utf-8?B?QzZDMnlYU01IVGxHQjg3d01Wczc4TDZtekNNdTZZOW9jdGVPZWN1ZVpBdEkw?=
 =?utf-8?B?b0hvZkFxdXNPbGU1bGV4K2Ftcnh3eFEyUTdROGo3WXAxN0gyK0RUSVB0dGtT?=
 =?utf-8?B?Z2lCakpJRlI3NWRaRFJ4bElVNjUwTWlxcCtPZVoyUk1LUHdTYTRSUU1mdEEx?=
 =?utf-8?B?T3JXNU1QZXlmU05KeFIvcjVwVElIRDFvb2MwaTFIdFFwT3JJdVZpb1VaQ2xp?=
 =?utf-8?B?UnRyMVlIQ2ZkbnM2UGl3M01lbDE1UHlLeGNpTDVVekxrZmtkVWpqV3oyRUd1?=
 =?utf-8?B?UjBsWGdKQTYxVTJnajBDdTNZQzVoR3k5L3VHcGhPeldLaGNxVXJRVTB3SitS?=
 =?utf-8?B?UEtDdUswYlF5MW0xajVCUnIwaFZZbGFCbmo3NHVEdk1Zc21STWlBbFAvS1lL?=
 =?utf-8?B?V09wdklMY3FvdnZhdWdIT3RGN0R2a2RaRmJmY3NwTW16anVRS0hTUHo5R2xm?=
 =?utf-8?B?MDJoaVg0WU9GM1drd2o0UmI4U2kyRGZqUTZKNUgrR1h4SXFNWjhHZGs5ZFFt?=
 =?utf-8?B?STlyUlV4WjlHZnNqRnUwbGhNQnZyaC9DRll0U0hiMTQ2L2U0ai80Qm9YOW9q?=
 =?utf-8?B?V0xUNXhyaUpIWS95UUV6c1hPaU94M1VDKzk1SUpKM3RCdlBrY1g3TzB5MUxJ?=
 =?utf-8?B?OFRlTDNBbzVvY3Z5amVpYlhVL2M4aG8wU0FFY1IrQzRRNTV0QkV5T0xGQ0tx?=
 =?utf-8?B?bklReXdONlJsTDJ6bTYxeFZUS3R3VEhXVFNVazNqcUZXZ3JyVW5qOHRGV3Bw?=
 =?utf-8?B?VWxIRk82OERkNFdKRjd2bUJ6dVRRK2tLZW44aFhza2YwMzcrYzd4SDgxdlFj?=
 =?utf-8?B?d043VGE3NUZ5Nmh6dDhqeDllSUMxM2RRQVRSaTRkYjhCL0szYWY4RW5tSk9p?=
 =?utf-8?B?d2RHZ1h4c1prT01LRTFCVzVoRllnaXZlU21MWjk4VW1QdTBMdHgzVExGSnM5?=
 =?utf-8?B?U1hSUFQ4QUk3dFdzV0JqR3BqeUxQbVJoenNyRjE3eGxzbnVweEhkNG9DWDdY?=
 =?utf-8?B?MUdaVmNuWWp4MmhBQUllb2xmaVByZGN4QUUxNkE0TFlTcmRySzFzOUpoMkds?=
 =?utf-8?B?bk41a0ZkcmpsWXZTbzl4ZWhReWhRbGtUVnpuV3NDaTVkRmZjQVk3YVRNdlZT?=
 =?utf-8?B?OHJiZFBzbVpVT25BTlgvSlZUUDkycXhLVWFoL21MSTE5QUJnK1VXaUEyMGt3?=
 =?utf-8?B?SGVibEJZb0hQRFdhTTF0V3F6cjYxSGgrN3pleVltY0ZFQmZYMHlLcTdoVkVE?=
 =?utf-8?B?ZjRvUlRPZGo2M0NiVFBPZVhYZllha3ZJVVVKdXNvOFFKSmhmWTlzK0ZWWFZJ?=
 =?utf-8?B?aXZnYnJkQ2Q2dURUNnVOOTRMVGg4RC9GV25LbjRma0kvL2FnSGhGeWdWdXFr?=
 =?utf-8?B?bjVxVGs4bG5OR21SSmpHVkhWa3pSY1ZCUVRWSlkwdzBIaFNCTHhnR1JrbVJZ?=
 =?utf-8?B?VTRabkZUL083YzJjT3lwd0lvWGNJaUZ2VkFJaDhNa2NFUVA5ME5Ha3FtYzNP?=
 =?utf-8?B?eHA0bUF1NUt0Qk9WVDErai81Z3Vpb1FMZkY3WDhvMEN1akxXUWV0Q1pzMURj?=
 =?utf-8?B?dCtFMjNFTUloWGRheHhQWjB4WGNrU01sZ1ZlREdHZEFPN0pBaU1PdzdRd2o3?=
 =?utf-8?B?ZWVqQVMrelVRQmFHOTk0YWxsQzNBNEVUbklnQk45L3I3QzZnb1dUQzdISnlN?=
 =?utf-8?Q?PeIfuqxjbojAZ7D1/RHH0ELyZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NxpkEsL30McxMcUsFjwXnM6veS3qvFPLWGPgkLDzvNMcNbirhu5nhLyNlrkejqwLFx7CJHeKo0yBY+MXXDDEWI+KCR0ceG66+Tv+AicWsuwXhlF4zVG8+c7vPwePva5FVAXtM50vTfez7fAKryEQ5zpn9xiT/Kjtafs/tAcYUMm/+AMpZsYz7xaMrZGhvRpiqVgNQzJvyBo995zM8OIdCroPPxGv6RdsXy0rl0c9ASMMePGtRlgpxx5crW8dfhx0WS4NHWGt2GL6ork+FhHTDuzM9LRPCy11cmMooIx8qkz6DGmIuGyt7wDY6hKSOU8rIFerEGDDCzk/QW68X3A22pdtu3UNAjcLeuP9v9io8fNEGSUY54ZEhAsqclnDcImle6sdrSRoaXKp9reVHlCXgJeyBkbXRJXspwCA+Sya8sNfuJBpzXJGVRDuw4z4/xRaArpAjsEKa3L0X5KGTEQmRzvRAJQtAa8o6t1KqnIo4aoEo1gO2sYV5s8kOgH+7YcUDIufu5TdQgA9NDzQRyn6ONkhn6jSCRw2GvmXOUZZgJZRWDln8pAgNHOp3FlRLJ7l0nf4gvUsiMPlisIKcb74jCtFOrMzoSo790xUrm/MuTEiGcqeEubvitP4GZivIaWO/xzZj1QCwg/MicZF29dZYexW+z9ywA8WU8qaKVCFnZfKLqX2Xixb69y47sCCffx8AL5CvaoT1ANBezypGzdOz42Fs/lc3E8rVTLW4SidcnmicvEU33VblObEhH0yiSqPD26x4I1w/uGLBARf7hM9Tjc+PhO6+bCVLkiNdrZCT4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83164b32-4e32-4c45-13c0-08db04e6c022
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 06:28:51.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukOVuTXS+txBtC15k7uwgv0FCY49ru8+ciPWqKB8mGmcZNzImRpzaYXVOSFHxl2Z+4YDjq6fT/OmZgRsP2ufVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_15,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020060
X-Proofpoint-GUID: mteleJMrLE4SJllCRQT2VDsBNKzOy0qj
X-Proofpoint-ORIG-GUID: mteleJMrLE4SJllCRQT2VDsBNKzOy0qj
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> +	bioc = kzalloc(
>   		 /* The size of btrfs_io_context */
>   		sizeof(struct btrfs_io_context) +
>   		/* Plus the variable array for the stripes */
>   		sizeof(struct btrfs_io_stripe) * (total_stripes) +
>   		/* Plus the variable array for the tgt dev */
> -		sizeof(int) * (real_stripes) +
> +		sizeof(u16) * (real_stripes) +
>   		/*
>   		 * Plus the raid_map, which includes both the tgt dev
>   		 * and the stripes.

Why not order the various sizeof() in the same manner as in the struct 
btrfs_io_context?

Thx.
