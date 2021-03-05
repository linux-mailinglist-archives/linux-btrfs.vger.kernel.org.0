Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C112732EC53
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Mar 2021 14:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhCENiX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Mar 2021 08:38:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40192 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhCENiR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Mar 2021 08:38:17 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 125DZ4MS073811;
        Fri, 5 Mar 2021 13:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PxAPdf+zCpfhn7B2RywOPcSlUpR+XbVQZ9num4TIU/c=;
 b=yf3tSk5Eiu2Oridzpzh6NZIWzvlUA+JAqrlMDh5/CnBR1eg4HHYzsFbJCKhNxWZAUFJe
 pRt5BpRq6Hsw+pfWd8en9etfrxHKeZwJvTKStganQx0JO34STiIs+HrhrkDgGjmzmT3n
 dS5a3NPNX8yd4DPim2vKBOhnxV6xBcl6PdGdMPPC+1ite3lz3ZZkGMZ1tIJQqUo/NouL
 ReIY3AgkpL2vebScHxfO/6OcXIQaKL2tQuktpLofT+HTF1YGRoTUj3B7FVWC4skOuSit
 LTK3TJOoqOdGeX1AJm6Ja+mYq3qavOvSd0YFY8nKCKb2hf+Q6SxtdRAbhgDpUgnncGoG aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3726v7g0fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Mar 2021 13:38:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 125DVBAx148048;
        Fri, 5 Mar 2021 13:38:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by aserp3030.oracle.com with ESMTP id 36yynt8h90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Mar 2021 13:38:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egz5bJt8x2q2kVNJRNJScEV5Zb80IESqv84qhGOBpV0xgWZd30oGgrE7FsSlzpIDa7eZyFe9kbDckKuRIjG1ReI0lwd9dQntRDGOUr+AhOIBAK3RcZq+Z0iVRP/bA4pA3SFxeYiZXE82UXz4UuYr+oW2gykonQXAUbHBbM0H7lGPA3Oaddd6bxEWKLExEyGFBRM8hiL5fMFyXNmBQmqsvxqArvXtmDbHyP0n8IxFWC8bwktZWT4lFOkAv3miTXuLFSMZ8ERg+MBbPJDa/l9eem6TuTExw6zoUkIrhKG6ICJu5k0gJAncYpXoKoiEhDTETdY3606CJNrIq6JAXCFIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxAPdf+zCpfhn7B2RywOPcSlUpR+XbVQZ9num4TIU/c=;
 b=Wq4At3iX7BkDLERxBxRUM7tivpjsBuC51cihI5DRBdgfBbfnhLcIcwsN+gGRtMwT/A2am/Pz9E/g78BTt7SjS4J/MSC7FkFHIO0UwIEzn6AB7GaR5UKr92ybwSanuAmLcLifFOZIZV1Zpu3rTBf3OZmli+clr3T3SklPNmARqOYQ9t6j+X7SA1n5hi2Gl6WVkiFjCK7jRcWLWmm2g99e051ATo9dSFvYHkD7YAsPrMuvcr6WnQanZWiP2uPWyNl2yl+lQi7GowfE3dPR1eYNzktMNrd6e4k5EvXEhFmN9VMti1Oei/yDLkJA6ghA9aHc9EKIteiIEC4Gos9AdBugFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxAPdf+zCpfhn7B2RywOPcSlUpR+XbVQZ9num4TIU/c=;
 b=ZSSAZisaUCdh5Yhsuw7/199jJlup1rZRZWciaCJ++pjCB6xSv7hjtFp71dnU+u+ViCS306M9dNtF3B1uJLxtcYPVmm+Xcb6sN/cwVHGYzCU/qZkUcYIDzC6zwSY74VeMZpiy9E4lYBhEoJZqSVUCsshAtVTgkSsKY6S4PU8sV7E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4208.namprd10.prod.outlook.com (2603:10b6:208:1d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 13:38:12 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3912.023; Fri, 5 Mar 2021
 13:38:12 +0000
Subject: Re: Scared with degraded raid1 fs
To:     Alexandru Stan <alex@hypertriangle.com>,
        linux-btrfs@vger.kernel.org
References: <CAE9tQ0dz-c05oGgzwwuJVfO9WUorwdUM_aDPy8Cc53cAK8AT9A@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <29e12e1c-b599-d807-0f3f-382ae18c3e22@oracle.com>
Date:   Fri, 5 Mar 2021 21:38:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <CAE9tQ0dz-c05oGgzwwuJVfO9WUorwdUM_aDPy8Cc53cAK8AT9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:ed36:d38:7761:518]
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:ed36:d38:7761:518] (2406:3003:2006:2288:ed36:d38:7761:518) by SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 13:38:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a80a8cd-8e06-425e-9267-08d8dfdbeb80
X-MS-TrafficTypeDiagnostic: MN2PR10MB4208:
X-Microsoft-Antispam-PRVS: <MN2PR10MB420894E28FB1DCB6D72CCF3BE5969@MN2PR10MB4208.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ht4ak+eFc4oYQNcyCu+ELDnw10zmFQeqNwUllpHzIec2leCud7rqjc1Kx7OwTBbEfcENUZoqrBPHZOK8EMAZSYNIxC24/gpp6Ad14MQchdDWNygWy1mki1xSWuQTPLygdCpbV2+Aup9HsC/7lWF1Nr0dOp836CFHITZhT7heR+wkcWTfEIA+tTMxrYuW/z3K3etYRdumQg1LfAsHfgeZoZntfdBcv9OHpVFkPipFZSenbyKSWFQxC5z1Vz+NOdmH2bTriPOHKFuR+Oew+NoGX5neDeHTOPJ9Ymclyfpxs+rnW/8N2qzVACbv3PNjdR6RN5I5DPWgNPn7uVhTWB3YTC7V78v5uPPS42sQkgiSOLH2JRS6RgYvyStc/78QZlqQyNa87F0SiTToMkrcT0jgYndYvsSeNehBv3Rub8m+c+o7VHkcxBa4hkE9VDNkk2Tu1n4+f+eTcqz8Sd3AZPwqB+HG/kE4yC7LpU+Cx8+952ljEGoSkC3NB/iJIOhN05lwZZPPkplfcEKqfpGLfXojZEpqW5f8MLwXTSaFDYTwSvn/Ui1EOMhMOsGsggqJGrsU83+5fUmsnp+CXXSRkdeTsUnG15n27ofL0fEURmt1CoHi6gjycg/fLSrV4FjB/83m83DdBZ56YS6TZ/cbbbqmlYbPlpyggMtCDK1xMSsCmvgG91AeSuXtTB3SxKqAcFFC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(346002)(376002)(39860400002)(16526019)(186003)(53546011)(316002)(66476007)(66556008)(8936002)(6486002)(66946007)(966005)(478600001)(8676002)(83380400001)(18074004)(36756003)(5660300002)(31686004)(31696002)(2906002)(44832011)(6666004)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y2dvS1BNMCs5NDA5NHI0MDNoK0VQVmtkdzMvSmtvV1R1M2dRbXAwME5BcUM3?=
 =?utf-8?B?VERQRllWWUNST2svdWpyd2owd1k5dyt4aDh3dG4vSUhaUlNlMmJGSm1xcVdD?=
 =?utf-8?B?WmxSZ1k2Y2NuMnRQYk1EZ2pTd0NkRXlOT2lJTGM1a1JCQXl5SmdibjdaLzc2?=
 =?utf-8?B?cm5Tb0dhbnBkZXhRVEFmbDFXcklOQmtJRmFFa2dJdkJqUi9xZTRBTjgrU2hm?=
 =?utf-8?B?RjhjWTBmMGIxakZmOHJCemdCZDBEWjNJRDVobUF2ZDBFQzZSU2dTbUdTQmJS?=
 =?utf-8?B?eFRWZHRkdmlRcjk4a0hSeHoyc2pLUTQ2aWlTWlc0V0JIdEtZZEJDVnkrUS9Y?=
 =?utf-8?B?S0VxaXVuZ1k4YU5qTzU5RlYzL0Rkd1dMM0hLYzNmblY1NXY1b1VHYlVFVngw?=
 =?utf-8?B?eHpmcEVDMzRoa01qZWlOQVZ4ekRubTRvNURadnRGUDJrK3BwNDRFUDJkOGh1?=
 =?utf-8?B?UmNLaHdTR0daYktRc1l4USs1andCQ0pzRHBBOUtyV3lNQllFbjUrRTJvQklB?=
 =?utf-8?B?SCtzWFVJK1Q1Sk80QzlxbjJCZjdLZlB6T1FjMVRxbkhRSjBTNmVrb1BjcWxo?=
 =?utf-8?B?MkIraHpvdUE0WjIyUGxkNzJKc1crbWpKMWU2R0FsUmViVlJWMERPMkIxU1F0?=
 =?utf-8?B?ZFBtR25saTNpSEtUeml4dVhjVnN6cFJLNlVZbXhLT1p1WHRXcTBEWHBPWnJv?=
 =?utf-8?B?NDg2aWVRak1BRGlUM214UHBPQm5FUTU3VDA1L2NHZXZ3aW1WZVdLYVBCblMx?=
 =?utf-8?B?N1hhbm5Ha2Nvc09HU1p1MXIzajZjbE1YcGpuV1BDZk5YM3VGcVRuWG83VWha?=
 =?utf-8?B?VlJUUFkyQ1p5Nk9aa1ZweFZVaXZOSElEck44UkJqbEpVSnRjVlFYVVlJY3Zj?=
 =?utf-8?B?UUtxNTVjeUFBei9IRFdzK0d5cGRabU9BaG9XMXYzd2dXNFVrWVpRZHM1Risx?=
 =?utf-8?B?M0xIY2FSUDh4YWxlUUxmSWs4VlBxRytwTXNGclJjRXNPQmtPQ3FuVzJXUmt6?=
 =?utf-8?B?cjYzaFFJZU1ZNThVbTZMa2QybjNuRWwrY2k2N1ZtdDVPTmhJTVlaRkhKVFQ0?=
 =?utf-8?B?RHUvK0FMRzBhcHFQWW83NEltWEoxMlRzT0FaNXpWdWY3eldDVFVZZFVTNVRN?=
 =?utf-8?B?YytaY0JqNGZDRUFqTTBDQmc2K1ZuMVhnbEp1VUV4bGdaeTIzZVpsU3cydGtm?=
 =?utf-8?B?R0F6VFNDQklXZUMrOFdIY01Ub25WeDh5OXhXcTcvVEdLT1M3YkJzQTBrSzVE?=
 =?utf-8?B?M245OXFFQitjNEZjUFJtdzgvYzZMVmdDcHlKWnUramg5dDFPK3pMZGVkTnRG?=
 =?utf-8?B?RTVPWUl0b0lYUDA3b2RmWTh4RGp3R0VvNzY0VWlUZWMxNTBDS0UwcnZoNkpq?=
 =?utf-8?B?UEtzWWZYeEZ6bGNPQnJNRWZPRGdnaFZXelRJOXVtdER0OEV6TDdXVUsrRDdR?=
 =?utf-8?B?a0Y4d25kcGFoRjJqZy9waGpMdnVwcEttNUdRQ1pJSEsrSmZ6RmdVMUhqcnN6?=
 =?utf-8?B?QVFUamZETzB6eVNtY2ZtR1dxT0RnMXlCSnppckVGYTY1QTgwYjYrR2JQSUdt?=
 =?utf-8?B?MDBhdlJtWUd0S2piTW8zTjd1b3ZqdGRtUjBsYWlxS1FueUQyQVhNTmQzS1Ry?=
 =?utf-8?B?cEZqdjZaaUxGWTQ0VE1RbGd2aXNFWmN3cmJSUm53TUkwVTFORkxFV2tZOXhh?=
 =?utf-8?B?clh2ZVdJeFAwZ0ZiaHRPUkJ6dUJHVG1lUGkrdUZvVTJIaUxFTDk5S21UcCt3?=
 =?utf-8?B?bElEL0tqVlVmakpRT1pRZ1F6SGVJTnQ2Z1o1WXowUEo4OWlmZUEyL3F4QmVv?=
 =?utf-8?B?OFp2dmZnKytKdjFrZFV2Ym5zUHA0ODhpSklqejlaTlowLzc0bUVQTC9INEp4?=
 =?utf-8?Q?JblVUslyoaAMv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a80a8cd-8e06-425e-9267-08d8dfdbeb80
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 13:38:12.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoHanzMIdT8LNyYqicOWorJ1FK+NVdti0MVJdHTD58VCAKyprU1NrhBawa9M+QKUlOIrZgjUIF65em3BoH0HMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4208
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050067
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050067
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/03/2021 15:15, Alexandru Stan wrote:
> Hello,
> 
> My raid1 btrfs fs went read only recently. It was comprised of 2 drives:
> /dev/sda ST4000VN008 (firmware SC60) - 6 month old drive
> /dev/sdb ST4000VN000 (firmware SC44) - 5 year old drive (but it was
> mostly idly spinning, very little accesses were done in that time)
> The drives are pretty similar (size/performance/market segment/rpm),
> but they're of different generations.
> 
> FWIW kernel is v5.11.2 (https://archlinux.org/packages/core/x86_64/linux/)
> 
> I noticed something was wrong when the filesystem was read only. Dmesg
> showed a single error about 50 min previous:
>> Mar 04 19:04:13  kernel: BTRFS critical (device sda3): corrupt leaf: block=4664769363968 slot=17 extent bytenr=4706905751552 len=8192 invalid extent refs, have 1 expect >= inline 129
>> Mar 04 19:04:13  kernel: BTRFS info (device sda3): leaf 4664769363968 gen 1143228 total ptrs 112 free space 6300 owner 2
>> Mar 04 19:04:14  kernel:         item 0 key (4706904485888 168 8192) itemoff 16230 itemsize 53
>> Mar 04 19:04:14  kernel:                 extent refs 1 gen 1123380 flags 1
>> Mar 04 19:04:14  kernel:                 ref#0: extent data backref root 431 objectid 923767 offset 175349760 count 1
> No other ATA errors nearby, there wasn't much activity going on around
> there either.
> 
> I tried to remount everything using the fstab, but it wasn't too happy:
>> ~% sudo mount -a
>> mount: /mnt/fs: wrong fs type, bad option, bad superblock on /dev/sdb3, missing codepage or helper program, or other error.
> I regret not checking dmesg after that command, that was stupid of me
> (though I do have dmesg output of this later on).
> 
> Catting /dev/sda seemed just fine, so at least one could still read
> from the supposedly bad drive. I also think that the error message
> just above always lists a random (per boot) drive of the array, not
> necessarily the one that causes problems, which scares me for a second
> there.
> 
> The next "bright" idea I had was maybe this was a small bad block on
> /dev/sda and what are the chances that the array will try to write
> again to that spot. Maybe the next reboot will be fine. So I just
> rebooted.
> 
> The system didn't come back up anymore (and so did my 3000 mile ssh
> access that was dear to me). SInce my rootfs was on that array I was
> dumped to an initrd shell.
> Any attempts to mount were met with more scary superblock errors (even
> if i tried /dev/sdb)
> 



> This time I checked dmesg:
>> BTRFS info (device sda3): disk space caching is enabled
>> BTRFS info (device sda3): has skinny extents
>> BTRFS info (device sda3): start tree-log replay
>> BTRFS error (device sda3): parent transid verify failed on 4664769363968 wanted 1143228 found 1143173
>> BTRFS error (device sda3): parent transid verify failed on 4664769363968 wanted 1143228 found 1143173
>> BTRFS: error (device sda3) in btrfs_free_extent:3103 errno-5 IO failure
>> BTRFS: error (device sda3) in btrfs_run_delayed_refs:2171: errno=-5 IO failure
>> BTRFS warning (device sda3): Skipping commit of aborted transaction.
>> BTRFS: error (device sda3) in cleanup_transaction:1938: errno-5 10 failure
>> BTRFS: error (device sda3) in btrfs_replay_log:2254: errno-5 I0 failure (Failed to recover log tree)
>> BTRFS error (device sda3): open_ctree failed
> A fuller log (but not OCRd) can be found at
> https://lh3.googleusercontent.com/-aV23XURv_f0/YEGLDeEavbI/AAAAAAAALYI/bFuSQsTYbCM7-z9SSNbcZq-7p1I7wGyLQCK8BGAsYHg/s0/2021-03-04.jpg,
> though please excuse the format, I have to debug/fix this over VC.
> 
> I managed to successfully mount by doing `mount -o
> degraded,ro,norecovery,subvol=/root /new_root`. Seems to work fine for
> RO access.
> 


 From the parent transid verify failed it looks like a disk did not 
receive few writes. A complete dmesg log will be better to understand
the root cause.

Thanks.

> I can't really boot anything from this though, systemd refuses to go
> past what the fstab dictates and without either a root password for
> the emergency shell (which i don't evne have) or being able to change
> the fstab (which I don't think I am capable of getting right in that
> one RW attempt).
> 
> I used a chroot in that RO mount to start a long smart scan of both
> drives. I guess I'll find results in a couple of hours.
> 
> In the meantime I ordered another ST4000VN008 drive for more room for
> activities, maybe I can do a `btrfs replace` if needed.
> 
> I was earlier on irc/#btrfs, Zygo mentioned that these (at least the
> later transid verify errors) are very strange and are either drive
> firmware, ram or kernel bugs. Hoping this brings a fuller picture.
> Ram might be a little suspect, it's a newish machine I built, but I
> have run memtest86 on it for 12 hours with no problems. No ECC though.
> 
> My questions:
> * If both my drives' smart run report no errors, how do I recover my
> array? Ideally I would do this inplace.
>      * Any suggestions how to use my new third drive to make things safer?
> * I would be ok with doing a 3 device raid1 in the future, would that
> protect me from something similar while not degrading to RO?
> 
> When this is all over I'm setting up my daily btrbk remote snapshot
> that I've been putting off for an extra piece of mind (then I'll have
> my data copied on 5 drives in total).
> 
> Thanks,
> Alexandru Stan
> 

