Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A1D1FB2E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 15:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgFPNzu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 09:55:50 -0400
Received: from mail-eopbgr690063.outbound.protection.outlook.com ([40.107.69.63]:43334
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729014AbgFPNzf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 09:55:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEB9vjDRxCmNHlGqDe1CbtIRHjH2rlhI4yiyIJ52rWqQ4S5rffY/hJqZC1tdDpLPfQEKnG/OZLoY5jXa+b/reEGq1SRlWEWrxlQhs7++dt+67ehci75Lo49M3QZ8HQjml/3y9Awjlw1XLdZAH3A40ylzdxxqlfFkM0WZvtmVeBuObhEBpDryYPQ+cLlVmgYlqDddJN0n9/71Zxhl9X/sHR7t1RvWZ6SBJrbmPQXDQFsdQe1rANPQzlOHoL2IcW833vLblmYc32JZTQi0MSLoQpm8Gj1juOPtovLsi9m+WePbWwZfqmBygWytKrGkO4imEZNI7gJBuemEORgt7AV8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW4PS/em+CD3vnkbWwIE6Ib1W9g1vU0QSDJoxCXxyI0=;
 b=Wl+s/lzGNfSPuBaZ4W8WTFjzzvh7TB1YFRttAk+4AhKyNQTd54sCex1JNEB6KM0zbb6giPfMipuYioOCpk0U7hhuXRfDcySl5tEa/+KogAjj7Qi/yzNilNMrN27PTB/5lrGTLn7oVcGqW1TdYphNJDKJULPO84fjHkkWaAR5fYkVg7DG3FrcIxmWlg5lz4QDSQiP21rhxQ1Sm+hUhNBzs6lzGUh8ocKh7tpMuTQDiODaf/sHWAZ/Ppm0nUhZulHtZ5JUxgDpP1N+s/vfUzTPykYs8odl6yPNBgMA7YXKUyrvrp7dIHgvJzXsLMGoFwHbIkWgn0M/TM1VpqvLgrCKJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasas.com; dmarc=pass action=none header.from=panasas.com;
 dkim=pass header.d=panasas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=panasas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW4PS/em+CD3vnkbWwIE6Ib1W9g1vU0QSDJoxCXxyI0=;
 b=J1dXGVyvtqbOR14hPz3DqejQ+zYICJDIaHtDBpJCWmvyPC+Ieqb6j9MLlzxpqjgUIaNKvD8qLPWU6sc2CGrnD+Hw6jS3J89lMIwUR7b+77X2fN/3cQiaAtlI/ISecbsxhqzW35JfnPBJMr27dj5mQ27w8sqtG1Y3+Hy1hCShEUo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=panasas.com;
Received: from BYAPR08MB5109.namprd08.prod.outlook.com (2603:10b6:a03:67::33)
 by BYAPR08MB3862.namprd08.prod.outlook.com (2603:10b6:a02:86::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.25; Tue, 16 Jun
 2020 13:55:32 +0000
Received: from BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::1ea:2027:6d68:1609]) by BYAPR08MB5109.namprd08.prod.outlook.com
 ([fe80::1ea:2027:6d68:1609%5]) with mapi id 15.20.3109.021; Tue, 16 Jun 2020
 13:55:32 +0000
Subject: Re: BTRFS File Delete Speed Scales With File Size?
From:   "Ellis H. Wilson III" <ellisw@panasas.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8ab42255-8a67-e40e-29ea-5e79de55d6f5@panasas.com>
 <db40ba19-8160-05fd-5d25-65dea81b36fa@knorrie.org>
 <d5379505-7dd1-d5bc-59e7-207aaa82acf6@panasas.com>
 <b95000b6-5bda-ae0c-6cab-47b4def39f7c@panasas.com>
 <1a88f0e4-3fd1-b0bc-308e-c12b9f64b46c@panasas.com>
 <20200616035640.GK10769@hungrycats.org>
 <d832607a-bfba-4f52-7c4e-05e3decacbf5@panasas.com>
Message-ID: <159d7ee2-f6eb-ea7d-34e5-76d6e925a1cd@panasas.com>
Date:   Tue, 16 Jun 2020 09:55:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
In-Reply-To: <d832607a-bfba-4f52-7c4e-05e3decacbf5@panasas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:208:a8::21) To BYAPR08MB5109.namprd08.prod.outlook.com
 (2603:10b6:a03:67::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.20] (96.236.219.216) by MN2PR12CA0008.namprd12.prod.outlook.com (2603:10b6:208:a8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Tue, 16 Jun 2020 13:55:31 +0000
X-Originating-IP: [96.236.219.216]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9afdbb7-4b00-43dc-38e7-08d811fcef68
X-MS-TrafficTypeDiagnostic: BYAPR08MB3862:
X-Microsoft-Antispam-PRVS: <BYAPR08MB38624266CBDA78D7A2A4C5B4C29D0@BYAPR08MB3862.namprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04362AC73B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fMEMUIJu4dm2Hci1nZEnZGfiSJyjAVP7maUEGJBsG0gHPF75S9nsm5RsdHIDf6vNoYDpLd6yPD7SeBm07Xc0Q4d8eKB44pczoKKb2IKRsw4X5HesJOOMX9am3T3PvPUKkhvQss/HJdzEF7j07P12W9o9YFmWNGxs8XwSbLVhzezvypzX2ZYzo1DFF7ZtLeCW2LcC4SEtGvh9CfOf+7OdtM9E6XgDHQ1x3j0RuoCF0iFJWXA92ahg604QcUjMbnqrOQo3dfQW8DM/dqbAiy2r2Z7xY+29+7EGhM3pgSbGaN2xJg8QyQiXVIYbZWczMWN394pk3b3ocO386pXHp+8JNyGshAMKfbOikt1kjaZVqvW3fWoVb+T14aPHe7UT5Eae
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR08MB5109.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(136003)(376002)(366004)(39840400004)(6916009)(2906002)(31686004)(478600001)(5660300002)(4326008)(16526019)(186003)(36756003)(6486002)(86362001)(8676002)(53546011)(16576012)(316002)(31696002)(83380400001)(66476007)(2616005)(8936002)(956004)(66946007)(26005)(66556008)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iIYc4fm88YIliqTVVmZ2zSux0DI0dY+nXNP1Q4FnXOQgL98iysq5ssUKsAQNJPQEfjbRVoeByI+QMX/wUuAHdLr+gViX8nSAjFKBpN8aiaL8iur2bYx9MlLxVLUgB/htF9X5TKv3E0Nc13pjN/D4jG+u4WKwuOc6OYPSawgJ/3GeGWZuZ1ZGRizAKND6bSOIxBO7yh+lJj/N5zIK4pcHwKwrx6yGjEAUfxrglFJPHy3QFJweIZXP8mg9xbRM+jf3eaBEReOJNjNBXwuzkTYKZFVhLJJ/+FrPcvv41CzUAubQ8DRVCxmQavzLMG8XsvyTVrUh9onsaaGm5eTKIyf/INHh9/thXifYgyqKpGHWZFbIOYtAwV6Ur3HSvCLGiT+pe0gkOTV4YDF1MjaEZAaybXIdqvGMwnHlQG0/zeU/Fak/5uVfCnlkZJDWKgjJW6Wru48hNwJyz2AeWNE0YSDYhz2xPyCkWhbH3mdbaeJi/AauiA6eXd/W6LMR/PP/kBUB
X-OriginatorOrg: panasas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9afdbb7-4b00-43dc-38e7-08d811fcef68
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2020 13:55:32.0380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: acf01c9d-c699-42af-bdbb-44bf582e60b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WTAH6AwGTVlfJbsYwJGM6JVU1KJ3RUdzGtA/3wNOZUMwGp5zX+aXPPvkfyT7NbZVHmLli814aEci95Yk6CN+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB3862
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/16/20 9:25 AM, Ellis H. Wilson III wrote:
>> In both kernels there will be bursts of fast processing as unlink()
>> borrows memory, with occasional long delays while unlink() (or some other
>> random system call) pays off memory debt.  4.12 limited this borrowing
>> to thousands of refs and most of the payment to the unlink() caller;
>> in 5.7, there are no limits, and the debt to be paid by a random user
>> thread can easily be millions of refs, each of which may require a page
>> of IO to complete.
> 
> Are there any user-tunable settings for this in 4.12?  We would be 
> extremely interested in bumping the outstanding refs in that version if 
> doing so was as simple as a sysctl, hidden mount option, or something 
> similar.

It appears in btrfs_should_throttle_delayed_refs in 4.12 the limit is 
hard-coded to delayed refs that can be completed in 1 or 2 seconds:

  2868 int btrfs_should_throttle_delayed_refs(struct btrfs_trans_handle 
*trans,
  2869                                        struct btrfs_fs_info *fs_info)
  2870 {
  2871         u64 num_entries =
  2872 
atomic_read(&trans->transaction->delayed_refs.num_entries);
  2873         u64 avg_runtime;
  2874         u64 val;
  2875
  2876         smp_mb();
  2877         avg_runtime = fs_info->avg_delayed_ref_runtime;
  2878         val = num_entries * avg_runtime;
  2879         if (val >= NSEC_PER_SEC)
  2880                 return 1;
  2881         if (val >= NSEC_PER_SEC / 2)
  2882                 return 2;

Please let me know if I'm interpreting this wrongly and there is some 
sysctl/mount/fs tunable I can play with.

Thanks,

ellis
