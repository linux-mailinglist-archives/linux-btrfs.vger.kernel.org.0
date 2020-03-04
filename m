Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E5F17933F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 16:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgCDPXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 10:23:44 -0500
Received: from mail-eopbgr750080.outbound.protection.outlook.com ([40.107.75.80]:4917
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbgCDPXo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 10:23:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCNet3x4o7cDBiWSkpxDUP1HTkO++NUh2MWVLu04b5SE++YCQoAjxGu5XVZSZZNCyCioJQ0ESpwKEW3FG4L+Rtsp50ALQxl6n5MsoYEn4zshC4F8l2eZjSCnPDTgyWhthxfjx7nnVytTZV+/7i1bc6A2fpRBFWrZC7zb2UTw0PKZ+WYrK/NYjqFKsZyZv/DmNsnpKCeg2JzS/4yM0h8/uCtD+zWVK17qGyPa4JOanzxPKkbpEIHIriTrqBomOUHKS8XMi09e9d2pY7xnvdbA3zzzzX9g8beixXneggG+r55y//1AZNWeqXw5aMAj5v/fAUcW1sKhN6y/doFROJUxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umpY1LaZGWFdGaKBBcrD0um8hfY8sq2/8V8BpjoKaMU=;
 b=fjik+7UPzNw6VHM+iq92gVG0pL62Si9j4U+acogfzAvN3qqDBEVOtyeljvwDFbAtdly8spSaN4V3Fnf46HhmUs3jiwo4mfQCR+mTlCeJ3DTIXyuw10KXpyPJEZNwrwTf5uyiIOzkTaPV+ODFEPs4TAroUWdgwW8szvXFDXhyekphnnLqtNU/ppNR6p3NnfBrbloEHwZtn0h5HEgPsd5WKIBlMsuZvmVeV+XkZuBMn3GjMsbqggo8UKYfUDxXm0lxgAUN/XCvjxQETaXHnF7MVMK7L3KFS5vu/mXXIFdsvM4uyDZZ7ctfET0X43vuz6Dw9vW0hpblGWgsCEy5lc/KkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=panasas.onmicrosoft.com; s=selector2-panasas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umpY1LaZGWFdGaKBBcrD0um8hfY8sq2/8V8BpjoKaMU=;
 b=SD1TXzoPiKcO/s0PM6lRmICyrYFTWnUsIKiqX2eCItmUDsEiULblkZ5K0rYLCtRYgA6IwFxBoZHkjjPcwSj0FnJvVL9id5YCgEkBzYm3DUze6+Y10V/+tTp2ehBkIGlOsBf/EBI+RuH8DFinT1ZiLAN/HdgnjZxlvtek3gYFLVc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ellisw@panasas.com; 
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by BYAPR08MB6054.namprd08.prod.outlook.com (2603:10b6:a03:c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Wed, 4 Mar
 2020 15:23:40 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::a101:5ced:24e2:c7cc]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::a101:5ced:24e2:c7cc%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 15:23:40 +0000
Subject: Re: FS Remounted RO due to false-positive for OOS?
To:     Nikolay Borisov <nborisov@suse.com>,
        BTRFS <linux-btrfs@vger.kernel.org>
References: <bd2903fd-0939-357b-e22a-ef425ac48f32@panasas.com>
 <22b61d0f-c2be-304c-4a3b-89225ea58e4e@suse.com>
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
Message-ID: <51756827-ef77-f3a5-69aa-d9dc56ad1b0d@panasas.com>
Date:   Wed, 4 Mar 2020 10:23:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <22b61d0f-c2be-304c-4a3b-89225ea58e4e@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0028.namprd19.prod.outlook.com
 (2603:10b6:208:178::41) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.3.107] (65.205.22.243) by MN2PR19CA0028.namprd19.prod.outlook.com (2603:10b6:208:178::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend Transport; Wed, 4 Mar 2020 15:23:39 +0000
X-Originating-IP: [65.205.22.243]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43651edb-932c-484f-871a-08d7c050046c
X-MS-TrafficTypeDiagnostic: BYAPR08MB6054:
X-Microsoft-Antispam-PRVS: <BYAPR08MB6054B77B756BE4D94EB4CE3FC2E50@BYAPR08MB6054.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0332AACBC3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(366004)(39840400004)(189003)(199004)(52116002)(66556008)(53546011)(966005)(478600001)(66476007)(2906002)(81166006)(8676002)(66946007)(16576012)(31686004)(110136005)(956004)(2616005)(316002)(81156014)(31696002)(8936002)(36756003)(5660300002)(6486002)(4744005)(86362001)(16526019)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB6054;H:BYAPR08MB5109.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: panasas.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xune4QYs1MpF4OY97Ik8DNJ5a1yj3NWK6de9A/HKopCiNhA/VtAX/DwLJcnMtqxUA3lyjdy7v3kcZZwztkAlp+hLymm0HVvn6nNtZJaTiXnCMizn/lSI/MMm5eFnPk6EK+TGihVw0hJOtiVpbKEQMuuoKu+BIhf8XRkXBhaqif/YzF+4AqgkJXth2uIAM3nL34dpII3bSjyJeYjitlXI/+ZdGvZAYOAbD6xQH+j990ULrfoah2wSiJz1bx3JzxweopS5cuQUWO5ngHjae2MHRN4bLcIWLR3LQEZY/E05R1VN5csyy53OXSDJvtEQgLJwozIltX2igZLdr38C0pEHxz3f6x0zx7jA4Shwg4Y3KFwrt1zTlEsoy8HmLicaVDqc8BENI6Bfswzh3NLz+SQDe+Iu0dgbr5Phsx0hSKDA5Z8EWaCJNPqaliQnT16MzniN5nCdCJD9B9v4ooJAm4s/WW+PDv66I581WchLMDViyHb1681Prgv2CnwY4T2HQmNJTHhUOhe2y8LF2pib/1RwJg==
X-MS-Exchange-AntiSpam-MessageData: f9OfnuZ3s1LzJEMunkMFMkDYvxTXpiL/YYdCfosMvpbd92kp/j33vnpBFmZdufJZLrOIEolPyiXKO4efjcy1DokgMiUJYYQFRHp+7gLm9YFLQz4/8J/BgcvwwX9Nn7RFlFI/ydOpcqduiDNWwe1R8Q==
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43651edb-932c-484f-871a-08d7c050046c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 15:23:40.3610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7nOhjb98yUcVWTk5Q3BSVZLJRpUFQn8CzgTXJ2XIaZmA8cqrtjluOZE94Qn5n3FptGBMKzI7KfHp4afndQdrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB6054
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/3/20 6:36 PM, Nikolay Borisov wrote:
> There were multiple fixes to the ENOSPC machinery. In particular:
> 
> https://patchwork.kernel.org/cover/10709795/
> 
> But this series might depend on other fixes you'd have to do the
> backporting yourself.

Ah, that does look very relevant -- thank you!

We are moving to a newer kernel within the next few months, and this is 
the first time after years of running with BTRFS that I've hit this 
specific failure, so I'm ok with living with this risk until we upgrade. 
  I'll report back if I see something similar on newer bits.

Best,

ellis
