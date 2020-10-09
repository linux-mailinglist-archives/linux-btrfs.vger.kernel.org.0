Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334F8289096
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 20:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbgJISKW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 14:10:22 -0400
Received: from mail-bn7nam10on2066.outbound.protection.outlook.com ([40.107.92.66]:58241
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725979AbgJISKW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Oct 2020 14:10:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgaOWY4t0Yshtljl8pX9DDasCFOZE8C0eLyV+kCyyjjgtiTHBJV4SGca1ApXDsPhROfXewsb61Y58BqSKr3nKP8j+vmutWjHRIIk1hBSYZuSux+8Uk3uPhdszo5BL5c5UzsmudH2M3venvQtrqY9eGEcnt20aQwhVjcoHHD3h+hz7KY2PuQ5fVFPOMEmIAhDPlqN/prWYppVFjv133ctDeT5ciSl8IBDHV2DVGJd/n70IRGq3N2ZVWLBYIL3UP50h8Citu3O5/gaYO5gUjnncWpLo6vQ1q0bZdeAIH5YdSfPyfCc4s32c7nGniQwqbBG5Xc+IL8cTkJ0KOLdDToGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lcu6CHV02dSluFlHbAsnuLDObJRW5YSZGrYKFNH410I=;
 b=bEIy2XuJkuc+PsPWJ0UK46y5uW3tOncXU6CVkLJQ4L/GZYwyY+jBKe4yxQ7Al9OAcNDKfcyS7JSpBB46ZELwk2i0ibyfk87FtL/6xP9Hw5B+eTFYqEjeJ9bv9US9rs+ybFQBAZuRKjDDUmayxc/DHDBcGVHGQB2qRQbVPqrpW6MyT9LwYk8EkzTm8klNKdJ4b9hhjHPhuUzS5/va5fc66kBTdu2g2eZrZIQzASW8unNDzEXMqp8lUlgPKeQzoLaTtRupxVDNy3OMvP6T4bguO4kqBxon9H2w1+IVUaWirnWPYtx8QsC1190Q6VK2ampTo5cK67BtoEFhQa9fK+Z5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lcu6CHV02dSluFlHbAsnuLDObJRW5YSZGrYKFNH410I=;
 b=VNgSmVElrxn+OKdr+1RyjR0FPudSMJeAHSU2XUUdEKXrDnprlHPfOoieZgGbZ2ZUQh3I4ZYYKSYcwxuwPDf+7CS4s7mzm506xEzSlDd3/wd/qT9uMPsoT01qjssk5iwephzwiKL65uSWBPIVervOC+bMdVxg6Tdum6ZXkljfdVA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by SJ0PR08MB6717.namprd08.prod.outlook.com (2603:10b6:a03:2ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Fri, 9 Oct
 2020 18:10:18 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::3819:8560:afcd:bc6c]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::3819:8560:afcd:bc6c%6]) with mapi id 15.20.3455.026; Fri, 9 Oct 2020
 18:10:17 +0000
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
Subject: BTRFS_IOC_SNAP_DESTROY and powerfail
Message-ID: <8e4641ae-ab04-d7e1-5584-a883f63c4ef1@panasas.com>
Date:   Fri, 9 Oct 2020 14:10:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [96.236.219.216]
X-ClientProxiedBy: MN2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::19) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.12] (96.236.219.216) by MN2PR15CA0006.namprd15.prod.outlook.com (2603:10b6:208:1b4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Fri, 9 Oct 2020 18:10:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed7cbc33-0630-43f5-e363-08d86c7e93c5
X-MS-TrafficTypeDiagnostic: SJ0PR08MB6717:
X-Microsoft-Antispam-PRVS: <SJ0PR08MB6717ACD97627334EB63A8467C2080@SJ0PR08MB6717.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLB/ckUG5xhqNKa+H+E6boDYYu5pQZIbr3YE+Rz88gBEfb7qeKhgV5IN3c3V8tXNaDER7RBJOPaK1adgD2k/F7tI//80dvAr+SNUkDHjrelVP/uEbLlnLkuUW/CouBD88s7ZKSs2Qf0r+IDV3rE0B2LYxUMd3D/dDzhamP3abuXPAT2S5tqZ5ezp4EL+oVSEXEcN37FRjmIOqwqvPxOMktLXtMkBULzOfAyJT82q7gn3/7CvIaCrNfR+mxleuxmbwHjUMB8Rjx4gsLkA2Iw2+kyDptyaVEx4UJEdgPzoOuDudbICZabn71SwmVkxqN1qyoJwieKyxUDE9aX7Vrsub2LI5B+ByQ1CqXAdWQXzC0gfQIsGoW24ABN8JDCTU+Wr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39840400004)(366004)(396003)(376002)(346002)(6666004)(186003)(16526019)(7116003)(52116002)(8936002)(26005)(83380400001)(478600001)(6486002)(4744005)(316002)(16576012)(2906002)(66476007)(31686004)(8676002)(36756003)(66556008)(2616005)(86362001)(31696002)(956004)(66946007)(6916009)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: H5bLeZM8YIgIkyR2wC96OkTBfgKVfH0CnayHY6pHMsQY3kNaZjXN6vQjol8u+CknwDpuj/oaP3bCKq1N4aXUIx1n8qOACM1dXWQW1Rf2NzJhiLNI/8kB+1UZjkR9ofZUq5/2ujLopRVT5tG8u93OE2lmjLqqnlO/tPkQDfhCjHrrj1rEgvnkfESTIDAXMt+SERTt62wHdf57smv2h5l6HEkowS3WsxKEjLk89ywlvuKmAlg/UhXb6YRZ7UT7zVTDYbfopXXPgWALKjcZVP+0rCz4PdRcb+rxFojt3qC6gY7ilpzeSdCYdf3AMYlUIUkJaT2XC1G94Kq0IIOrbJBf/cq7n1EML3C7XS8334h3YRqkh1Cs/x1KeZPpZN+RDjSYzHxyp5iinxBZ61sSSxVe3FmlikG86ydEDQXgonU9hxPb30wuzFD21EHxpf2e6MY/Ip5c+jqQoc9g8qpX5yOJl55PRqETYlrsAHT8LYEiM/qS2Yu1zA6Xb3vtlgzU1oQblhsYZWQ0bC3lkT0Fh1+ekG8lOsPHGYX4PgIVYg9yL52jlmGoQvBjEymhhPjncCdB8QX9E4gSEeFC1+VeHfDClomU/v013owWb9OLRC04lAsLYm8ZZbi8s+7c2yU2VwxjVfrAklOhiaVQqWRhHox5Wg==
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7cbc33-0630-43f5-e363-08d86c7e93c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR08MB5109.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 18:10:17.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1SjnMoxoROzjErvtLTYWORHDCLGefcXhkBoRNCMRG6MYXTRip8ivGlDOoZ7WA4h2UIS+Y128icVPgljZGpSpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR08MB6717
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi folks,

I'm looking for some insight on the guarantees of subvolume removal via 
BTRFS_IOC_SNAP_DESTROY.

Presume we have a subvolume under the root of btrfs as such:

/btrfs/subvol

If I issue BTRFS_IOC_SNAP_DESTROY against subvol and then a 
BTRFS_IOC_START_SYNC, and both return, am I guaranteed that subvol is 
gone from the root directory entry even in the face of power failure?

Or am I required to issue and wait for BTRFS_IOC_WAIT_SYNC to return to 
make such a guarantee?

Reading the code for the SNAP_DESTROY IOCTL, it seems that even if I 
just issue that IOCTL, subvol should be gone forever (so long as logs 
aren't lost), and START_SYNC is just a nice-to-have.

Any insight to share on this?

Thanks,

ellis
