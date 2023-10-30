Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9210E7DB249
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 04:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjJ3D3b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Oct 2023 23:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3D3a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Oct 2023 23:29:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522F7C1;
        Sun, 29 Oct 2023 20:29:27 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U2YXOc017651;
        Mon, 30 Oct 2023 03:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=x/J/JQsPBvohoq+xS/Ue3K/BclXXJlctyA+CoDILbOM=;
 b=oN2p54Btc6bfSiMXTF3myaI350PGoo1oR3MMbZQdNS/9Ui/KVhBtECh8Bu0tTvBIJvZU
 fjHc2GOVwvnv1dRXxbaq+DSwmmQuxXxvF4CzytogR28OX6zlyVa4pSXqz435rutYgME1
 BWzUs2tpdpg+ZszMdpiAczHXyUVjlDWenqjioF6A9FRWxL+86ufUEBobLkONOFEEi77u
 hCfVsIpxm/ICq2iBifEYYty1Dec5pLpcID8dYOo15LehHbEtYjzWFEZmEzsMsUEyKHmT
 Z4VTRU8esr2fK0oZSz28bIU5MVU+NSR4TGFkMaYGsqxqVm3Bu/nDbJy47kGVZpubHZBF sA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0t6b1r06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 03:29:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39U35ZeK026167;
        Mon, 30 Oct 2023 03:29:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr3qaeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 03:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCniHZX5q15dhi0DKR7TVLi69kJl4vIVqf09ES0CAVN3Ke201O59U7pG5E9BUZuKIoHEP/Mz245yzYWMqo2AiyuCuDMkuQR+Vei0s6C/ur/feMrGyN6ypBCEoFN1JK77jOlzU/1UYZvn0TmsOxalxOOfDxlUEqRn/IcXLHmNqsv1+ue9xTfIVj8Hp9LsG3i9NLjv7EWqNPT7fLmlX3B94XUVQS1AZN/XZm1au0zkK44KtrD7eX7Zi6PKtutsi40ySFjW7ciBd9Uc01nj6ZdGKQP6ydwnjro+M8wyhQlVm+nikg/j7IMwRkhouW9CxBLV19FjUi7hPnXocyn2ckdI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/J/JQsPBvohoq+xS/Ue3K/BclXXJlctyA+CoDILbOM=;
 b=VnSajToGJ2ybub3t57OvOEmgJjZ4a/X7+UImYgLbYPuefdoVp2RW8iyZXqW1j3En6BzlBMo88hrM1AFZ5XQB/LscKhVup9yw2iMuQtvSJ9TyTTCbTLjoqP2JI9HubbCh3Z6rHEugcL2TTnlYkEZ0HXxZAktK9tmvGZKoOU7IaVS3vaPjn+n+N8KQrSJKiuKtnrPwWkgdPjth1RYSN7WIrKoZumI4cO3Pxxn1hRsS5Kq/zoYef7LjWpNedY8LGqIvzifMN81oQOvvgQFo7Zsve/jgunDnwoewKWZ2eorGsa189YdzI5ykjqx94dta8yAMkmkQ6fhrHadP524Ytw3ftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/J/JQsPBvohoq+xS/Ue3K/BclXXJlctyA+CoDILbOM=;
 b=HS82HlBJ4QJZqwaymnoZRiF8/cXXMSHWWtrfVMHgXGNl1LgoV3KM+pSfPFC7x4w8Z2OF9UvmDzYLL/yy6zeVIcSkcB7gPecm/c9QRddjNsM5xHgaHfqUf7NmLIpt6mkvA4+A8FnghqqXLjP/u7SJX8cwBNzvAVNcPY+Af4u2vno=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DS0PR10MB7904.namprd10.prod.outlook.com (2603:10b6:8:1b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 30 Oct
 2023 03:29:12 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab%6]) with mapi id 15.20.6907.021; Mon, 30 Oct 2023
 03:29:12 +0000
Message-ID: <4b206721-5bbf-4ed0-9604-fd1adb0f2729@oracle.com>
Date:   Mon, 30 Oct 2023 11:29:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v2] fstests: btrfs/219 cloned-device mount capability
 update
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1698418886.git.anand.jain@oracle.com>
 <cf97bf909b5a67464f5dcf2a802b7d80c79c472e.1698418886.git.anand.jain@oracle.com>
 <CAL3q7H5d7MHHJFKkkcpg0Nt7naDbURVTpfzXDa8yMTVjxFy=hg@mail.gmail.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H5d7MHHJFKkkcpg0Nt7naDbURVTpfzXDa8yMTVjxFy=hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0085.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::7)
 To SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|DS0PR10MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: eb83dbb7-aa97-4180-b9e8-08dbd8f86284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WLVy+z9O0XhpqbLYtCmJwqSjEFlaJ71XiXZKBxbjLxJLuhs2nDtfd0YbdEcKjs/churHQjG3Oyp/dIeopLzln+RwQaelPePF0utPdDVSllmXcihXbiy2LRWR7Ted+2H7AbUBCcNf9LXthXEjUuwKcMmMCzZ8A5NEniROFui6t55zSDCrpPn1oUxzjdLbri4l0W71zBh1dwhmLcAoIGwmGN+vB7zt9erhhJaJj5r0CVP1tZ/LnXNVgDoSzAxPn7QYmGJsZoahLLqc6DMEuCDMb/Dz3G8+x4RI6lVs5/NhvqeD5prEnHn8m4lrGtwGm3OB+uBRy4PYQishxPEiIj50btjk+jVLzlhXPpTphplj08Nr2RDILox/M7nwM5a6v+7wyBrU5H5H8tJKJ5SkAY24i4gGcFbf9hee3xB+7sg0UbNfiUvoM8gUVdVLSPaaq5PK5QfcK5RBunsW6SkBEsDI2JoYmb4m3xrowue/KhlaVpMCtlgHRKP2gq9SkdnJaP3+Pe+9NaEiPMWfaZ2VpRwGId1WEMtn/rgmHB3fEwvtVyJ6DAAdyTRpDFX8dqBuiliOHDt2OsQAcpI3IXF0z47EwdCbH3WFUSR3I3cBYtnBbRpYlPcAZXSwMO5v7tmgAqpFVDDMIZ10Q5SzRkfChFQ2xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(316002)(66946007)(44832011)(66476007)(66556008)(478600001)(6916009)(6666004)(5660300002)(6512007)(6486002)(4326008)(8676002)(8936002)(31686004)(41300700001)(6506007)(2906002)(38100700002)(83380400001)(26005)(15650500001)(2616005)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDZ5elhORmN4YnNqdWE1YkM1UDR6N3d1RWZ2U1l0MWtGRm1WaGJXVlZGZU8w?=
 =?utf-8?B?QzF3SDNDb1ZqdVlTNXAvZjJhSnNBRGpYekhnZ3FaTkNneWF3ODVYV3BqT0NM?=
 =?utf-8?B?ZWNaZ3lFR29FMDVkeWd2VlJFNi9tM1NBeEE1aUZsMDIxODZiWmVmMndPNkZY?=
 =?utf-8?B?akJjNzRueVRaQm5ISG5CbzlFaUNvRW0zajV1VDVXWjRpdTVUaTJZbmRldmVw?=
 =?utf-8?B?elJGQjFGV0NOenViSmJzTUhWb1h4QkZjRk5ScGdoVFBaSDVBSTk1UEVTVzF1?=
 =?utf-8?B?WGdrUTFTZU1zZmRpWHRta291aGdtTVY3elpXWTNZZHhUY2plb204SnczRzZo?=
 =?utf-8?B?L3I4UTJLZldzUitURmhaZGx2OGNtditaMDRsbXU5STV2Yy8zSldaTjZacGts?=
 =?utf-8?B?bFpDMm1IVE9yV2VhMUlicVBDOWp3blRDalZhR0VReHh5NUZ5SmdrbnY5b3cw?=
 =?utf-8?B?MW9vOTZnTUQrZzk3TWJPZkRxVmNOelY0QnR6VnFoVllUbmorTnF4VUk0YU9s?=
 =?utf-8?B?R3dnWGNYM3B0K09SS0JBNjJkNnVHRWRMVEZVaVR3SW9tMmg1ajN6RFNtZ1lw?=
 =?utf-8?B?YkFNdy9sZUcweUl4bXhSeTlkSVVPTVB4Y20rVG5kVXN4R2pCTktjU1QzS2tO?=
 =?utf-8?B?MGZ4S0dPSVF1ZGtFRGZNK3FrQkVRdFNIUHdDdmJPNjBXVllTMmI0Q1VYWXpl?=
 =?utf-8?B?YzEvWXh6cHl5eUw0TkFIWXJYN3FBdnZKZ3ZveURZS0g3ZzN0VTV6TkZIOVU2?=
 =?utf-8?B?MEF1NU9nUjczV3MvSWxBc2YwUldBVlg1TTNyOTlkQngwb0FZUTFCWi9JblVR?=
 =?utf-8?B?WDUwNjMxZm9wUGU5ZWdXQU1lZDZUTjNLSXJ2NmkzNnlOWHZkbkRHenNvTXFx?=
 =?utf-8?B?akxWRVBvOUpWSmJmSFRJWDc4clF5Z0FxZnkrOFZWamNNMDVNdkFCR3lDMXg1?=
 =?utf-8?B?Q0NEaDJPc2ZKS2pQcW83UFB2QVllQkE4bWpiaUJDOXRua2dnajdtTTAralFH?=
 =?utf-8?B?UVVRK056WkNBNmYwbVFGZlVsa3JUK2dVaVdPWElpQ1V1NGF6bDhhUE80U1Zq?=
 =?utf-8?B?bE9qTm9QRGgvQkRjZ0hiU1lSY25hMG9yTmdHWFNJRGNoaWpjU2ljUVJlSS9o?=
 =?utf-8?B?bTlhOHM5UFZ0UE56MytXcm4xMUNFWFMxVTVQdnEyMzBUbk9CU1NwNHU1Wnhs?=
 =?utf-8?B?dGttWTRnSWZ5aGpRR3pTQVlkeUtRZ2JrcEw4QmVWS2h4NnFvTXJ0ZkRqUDkv?=
 =?utf-8?B?M2twOHVWRTQ0TUkwS29oM2pMVHgyM0RUTzkxcWF0UHBRblJOUGljVFFlV05U?=
 =?utf-8?B?dW43Q0h4MW1KaVhqdVRzVFJIYXluc2UzZEZ5cnpxdnJ6UTVlODJlWTNRYWZs?=
 =?utf-8?B?MTZaUGtsOVRabG8vMUFDNW8yZ0wyTkNHUkY3QUM3M1NyNTFialMrRzZLejFz?=
 =?utf-8?B?ZUptRU5tRDY5OWExS0kyU2t6NFBySEpOcnpvVitKajRXNkd0UkdDYkY2b1g1?=
 =?utf-8?B?bWwyTTZYdXF3UXJMM2ExakYzRmhYRG4raGhBNTZOaUEyc0g1WnZPNDdHRjY2?=
 =?utf-8?B?bDRHaVBaY0g2VTIvYUg1VzA5R21aZ2lhV0NTMk9rOWNTVDNCbmt1T0JTc2tU?=
 =?utf-8?B?NjlwckZmTjJ3SEcyVjVZWU03SGYwaDhBNjUrajZTQVpYUk5NQU93VXJzQVRZ?=
 =?utf-8?B?YUZkUW5CM2xPRWdicE5GVHorQlJFdnJVZy8xc1Q5VjNxU3FrMEErejBlTldv?=
 =?utf-8?B?TnNhMkhKdlFrN0pLUHorZkVDcEIvUTRveW0vbXVqN3pQTG01c1NkNjdvUlA2?=
 =?utf-8?B?RC8yaXY2R3dSYTloK1NrZXdTbHowS0hDMUFheWZrWm15Rm13SEtkcXhzZXFM?=
 =?utf-8?B?REEreVY3aGN4Z0Jtb3FnQXZOYStEMEo0Wnl5QUVPUjNnRlZZZjVCb3Qya0Zr?=
 =?utf-8?B?WlY0aG4vSElxd0dGVnBaa2U0MGFXRklUM3QvUDZWN0Z0UndrYmdLaUV1MUN5?=
 =?utf-8?B?ckRjemR2dVZhMTRBL3NZT3dIRmpSUFhCSXVtbitiVU42TU9TZ1lEa0NoMFRO?=
 =?utf-8?B?Mk1IR3ZJUjhiRW5IY1VhcWZpbTNURVF2d0tTUkRBQTlTSkNQb1VTVGFhdkwx?=
 =?utf-8?Q?WeDlRFpmJLDcNwferL+oSpDn2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d0eP8IAY2EPkYqTcMo2naC4SGnlFRsKWnqlWF8osBQwp9gPKOIEzcv+0dBHH8BLUouj2GIGNts0++1RwdlUsw/6ES41jKqw7yopnc6qf8yCuJnriggf/wpbgH3FJwmlBnDZsoR1yTNolRuysq7S/obejLtTfcdwYr9FTRzqYH1Q5W22QR6jR7MX24kXEZD1ShynNFkVMShpYjwmpRT/AUx4YDBGX6ksgqku9s/VncD1M2htKicAm8jmB2x710rDcNitgA1vN3BITRphHoeyXRknzdjbT2LuYQzxEdiquOogf5JRV8dHviWzlO3hRe8BEAYlXmW+jen1NjRN8GRozT8I6qI8Z43WgWsThOW0bg2jjqYKZ+yfH0aO3ykLrcX0KsScCe5MlDKnM/HRfCqKxI6t6+QVpKssVauiONUnYWUfin7RTI7hHmUVloi0MnWWo/8/jdgaJ0HWdCB+ePM4MlgR/1xWC3TJ4GfhFKjKwvueblzTIvWvx4JoA5/eJ8ZhouFiNmzdRYOvF60pUBqdOCnhvN2VyOX9TPwXLFjOwdr/hqZ9/lTG7JGLqCmpaO0jkCe3DPSWO7xnn97GFHOetsMr+lndVItxaez0m2z2yaVmZGq3os7MnGTaltpRaPR8i8dbIq51VMD4X2I06wi0FE6e1Rq4QpGHUp2WQHPUsrSZEy0M+BOGhAzW4CiqJcn/Dylt8ZXvmHEbn95MogaFoMnzbyWgtlRQqHltmvpIXJVPr+Tj6s8jgzgJgVjHRGkPcfxqFhUT8tOX55naSKBUpLWmzclexwxZ3cBqe53ukCVA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb83dbb7-aa97-4180-b9e8-08dbd8f86284
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 03:29:12.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gljOIGQFpYiX/8aYQ3q63bgj97/DmLuHE0zEipSUzpXtnp9w0BFeIduof97o6rkV48lGkQVDiavgrrHXY7bOuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_01,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310300025
X-Proofpoint-GUID: 4wMuAT6o-tIZwLs9x216jlIpq5ifq1eJ
X-Proofpoint-ORIG-GUID: 4wMuAT6o-tIZwLs9x216jlIpq5ifq1eJ
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




>> +
>> +       # The variables are set before the test case can fail.
> 
> What if the _require_* statements fail?
> Then the variables won't be defined...

Oh, yes indeed. It was fixed in v3 by moving the variable definition
before the 'require' statement.


>> +       $UMOUNT_PROG ${loop_mnt1} &> /dev/null
>> +       $UMOUNT_PROG ${loop_mnt2} &> /dev/null
>> +
>> +       _destroy_loop_device $loop_dev1 &> /dev/null
>> +       _destroy_loop_device $loop_dev2 &> /dev/null
>> +
>> +       rm -rf $fs_img1 &> /dev/null
>> +       rm -rf $fs_img2 &> /dev/null
>> +
>> +       rm -rf $loop_mnt1 &> /dev/null
>> +       rm -rf $loop_mnt2 &> /dev/null
> 
> Also please for simplicity and clarity don't mix this type of change
> with the actual purpose of the patch,
> to make the test succeed on a kernel with the temp-fsid feature.
> 
> You're mixing 3 different changes in the same patch...

>> -loop_mnt=$TEST_DIR/$seq.mnt
>> -loop_mnt1=$TEST_DIR/$seq.mnt1
>> -fs_img1=$TEST_DIR/$seq.img1
>> -fs_img2=$TEST_DIR/$seq.img2
>> +loop_mnt1=$TEST_DIR/$seq/mnt1
>> +loop_mnt2=$TEST_DIR/$seq/mnt2
>> +fs_img1=$TEST_DIR/$seq/img1
>> +fs_img2=$TEST_DIR/$seq/img2
> 
> So this is the other unrelated change, renaming all these variables...
> This is making the diff larger to follow as this has nothing to do
> with the goal of making the test succeed on a kernel with the
> temp-fsid feature.


Sure. I'll move these changes to a new patch in v3.


>> +_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1
>> +
>> +if [ $? == 0 ]; then
>> +       # On temp-fsid supported kernels, mounting cloned device will be successfull.
>> +       if _has_fs_sysfs_attr $loop_dev2 temp_fsid; then
>> +               temp_fsid=$(_get_fs_sysfs_attr ${loop_dev2} temp_fsid)
>> +               if [ $temp_fsid == 0 ]; then
>> +                       _fail "Cloned devices mounted without temp_fsid"
>> +               fi
> 

Hmm. It is exactly testing what happens with and without the temp-fsid 
feature.

> This is too complex. Why not just surround the existing code in an if
> statement like this:
> 
> if "sysfs-file-for-temp-fsid  does not exist" then
>       run this code that fails with a temp-fsid enabled kernel
> fi
> 

Your suggestion will test what to expect when there is no 'temp-fsid.'

However, if 'temp-fsid' is present, we expect its sysfs temp_fsid
to be set to 1, which I believe is a straightforward verification.

And do you think adding more comments will make it simpler?
Such as:
# If the second mount is successful, then check if 'temp-fsid'
# is in the kernel. If it's present, verify that it outputs 1.

Or, Are you suggesting we postpone confirming the correct operation of
'temp-fsid' for another test case? However, I believe in thoroughly
verifying it wherever it's used, as this approach promotes a better
understanding of what to anticipate. No?

I will await your response before sending v3. Thx.

Thanks, Anand

