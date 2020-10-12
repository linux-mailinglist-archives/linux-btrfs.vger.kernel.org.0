Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4C028BF25
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404059AbgJLRnW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 13:43:22 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:56289
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403994AbgJLRnW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 13:43:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl4V0GPVU+zM3X/794UG6vpJG8Scj/8KMsfWiDPW9EmTpxNHNkxRud2IrnQ0Ch08Flju/t+ysv1tBGr1K8brpA0MYWKm+ctOYUYmFhN/3FFQPuhTgXMHk3NyPz5mOYDW1FpaIcZqdxl8LYrLPkqF4rVnTcjp4GQpZs3n5K5gAZ+Iu3XvmXPO3cuGCYtw/+rJ5sKLqAllzR4ir62K9OxSgypYvIp+GAYJANgjsPeeeo8XWh0W/Uyj2G3fuks0lHKSD3i+fWXdv/6dq+2mBv9U1Jmn1nZMw8ebXAL8wUabgI1qvLsQu5VDf/VwrwQoraAnZz69G8muymCGBq0MD5mXGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dllnVPxyp3oozaRa7CIc9g9FXti0XUiHjjzVT9tAIG8=;
 b=flXZK2ieToz0h+VAUPvJp4/MbUA23FH23Xh9WIEh4kJo0eDYrORUL/ZKU3wEtoSyYXPEzJ6+VK4RAX46he5QB2sG+ASck10y+29da5BIgW+8/UXiaHFNspF2QJKYFdcwffIsHMpu2kA2SLPQMFar6zHhL5UXK9oRLBG86BWj+xxZP365JVS0Pb8OicszLZBNBFHcfTCKiEhnqy5w82yx9W+9qYVrUYzd5oj8QdOUsmbjwG6J8nchqgcgxkcYP0y7PCxX13gZuWlQQ6gMz3Nx0XGMmN//L5zs3UWe9pvf0/7raWMWAygMAsczFhfdEsVdVJJrL/a7YpPDNElEjYvYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dllnVPxyp3oozaRa7CIc9g9FXti0XUiHjjzVT9tAIG8=;
 b=Obg2mrEuPZhjSy4K5Z1AQU7+RaXIot8+iuJpeb/mmcvj2DwlUAapUeIR9wFikAWw1c4AbA7rHTnpR+qjnOzIrt/MAWhne7bO2X2O2srHrbEVPA5dDhI6m961scUHpBbQaFKDTFvm5vcKWXW4PMY8GrI3Vu+OBmjeQVrgsezN4wg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by BYAPR08MB5800.namprd08.prod.outlook.com (2603:10b6:a03:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Mon, 12 Oct
 2020 17:43:19 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::3819:8560:afcd:bc6c]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::3819:8560:afcd:bc6c%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 17:43:19 +0000
Subject: Re: BTRFS_IOC_SNAP_DESTROY and powerfail
To:     Nikolay Borisov <nborisov@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8e4641ae-ab04-d7e1-5584-a883f63c4ef1@panasas.com>
 <889500df-c3b8-dd16-ea9a-91d1944187eb@suse.com>
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
Message-ID: <0d4a1022-6203-34c6-2240-3d43bae6f270@panasas.com>
Date:   Mon, 12 Oct 2020 13:43:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <889500df-c3b8-dd16-ea9a-91d1944187eb@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [96.236.219.216]
X-ClientProxiedBy: MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28)
 To BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.2] (96.236.219.216) by MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 17:43:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b42d1178-f8ab-448d-eae0-08d86ed64e36
X-MS-TrafficTypeDiagnostic: BYAPR08MB5800:
X-Microsoft-Antispam-PRVS: <BYAPR08MB58002EEEF5C58A781CD19EDDC2070@BYAPR08MB5800.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orYPqpIje93qUkG+B1OgPaTFd/0XPKfq7vpp316uc/IbKwZvbcQGpwFRNs1QS/c3/ZgKLMucjL9xa5d4qc27jbxRwzx4730Ej7ryRqKnoXRPbs7xrav8n+IUdADm8JvF9WsTpoQY/KPwaRYIT2vxbyiB/Vc13zHZxODUyQqSnIpy9xY1mlNyqkVQnJ8p8ZFegMDFooGA33AqmOX2aYZc0vijPboAWx6899Z+4Ped9r21YZ3K7SDCocLh+a4V5KXlOKmVPer2trwr8Wx7gzA0XDBnPahY76S0S2uwYTb/J+OTcVEdWvfECTyFlkQahqqxX12TubUdlWfLyEcIUMmkCMAQa5x5n/TxQMll8EKkt2GGjeY0bylbfi9SMiGWtr3S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(396003)(346002)(39840400004)(52116002)(7116003)(66946007)(66556008)(66476007)(36756003)(53546011)(186003)(8676002)(26005)(8936002)(16526019)(83380400001)(6486002)(5660300002)(16576012)(110136005)(316002)(2906002)(31696002)(31686004)(478600001)(4744005)(2616005)(86362001)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: adnwcjm7gyiFqkO3DiItBVuFg/vbFSwfACLyiaFXfxSQTD8/NztSKil+mYI/lKwEh7j5zqobQaZmlPAWs+1ibaUfNr3Ervphz0PdY9POVU129NVkS4/UtyOSU4lC/lrbnf+Dpao6121tNlvG4x32DMGnF1+j6SORlYh4TypqSomvX1ln9uQsnfgq42L8+4akjMZfQSojtFWkdUdNs6Wz6ClPVI0bnKuiZOi1XOFw1Y4Ry3m1cpVEs64ApyBwQPSxfya0AhdV0mS4K3dKah/FUBRRBOWgNGf/kTvsBe/MJaJGgJY4k8z3KliOPO9nT0PJbnsVG36du2zo9RUxCiDIfg4iDW3qDo1ca68qukRlDxDfoR/QmwmCthUZZzbIhjwiVjpxE0cIIKoNTAMohidV3GKaNKnEwr+WJLkMKxromQxPKBqVrEL94U/7hnrVZNuP764iL7fE+qdCzIe9wn8nm8g5jIIesA0j2+8Blq5vn0EoQ4DOI550gRsrJHrf+fA9HbqS3/PM4l49EYK3D/Kk5T8UNLOUvaZ4GLUAQXk0lht8corwah07lrodgnV90y00kPDt2Foz1ZQAl8taxJ1tfKI4Y57tZsB7ONkFxvOBcwBYUL30/USKMa6m8qZfXb6UZp3XC3uXoDrCZ30kRRwk+Q==
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42d1178-f8ab-448d-eae0-08d86ed64e36
X-MS-Exchange-CrossTenant-AuthSource: BYAPR08MB5109.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 17:43:19.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+mVnxHpTkgW+6U35wVBK1mK/tTW9GfVrU2NgZE0lNyEX2IQCE0YAi8RGEkOFm4Ig0T7nEx1KwMGuSKfsSvtjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB5800
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/12/20 1:46 AM, Nikolay Borisov wrote:
> Nope, btrfs_delete_subvolume does indeed remove the dentry from the
> directory and adds an ORPHAN item but until those modifications of the
> in-memory data are persisted on disk a power failure might revert them.
> START_SYNC just begins transaction commit but doesn't provide any
> guarantees of when changes will be persisted.

Thank you very much Nikolay.  We will instead pursue a rename approach, 
fsync that first, and then issue the more expensive subvolume remove in 
the background.  If powerfail brings it back to life it's easy enough to 
re-issue the subvolume remove again as it'll be in a location known to 
house dead subvols.

Thanks again!

ellis
