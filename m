Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C4A1B26B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 14:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgDUMtc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 21 Apr 2020 08:49:32 -0400
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:34788 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728698AbgDUMtc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 08:49:32 -0400
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Tue, 21 Apr 2020 12:48:41 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Tue, 21 Apr 2020 12:48:39 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Tue, 21 Apr 2020 12:48:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQPVlDet7Fz9I81GW1w2tnsgWGpgWA4I+a95vynTabHLwEWZW4WznzhBlBxNVMK0hXsolebE+okGGP8rYDDP0NVCY5VDnRKMI6T4b48TQzJAjUQCg4T7UkctFRPFTNa/DOgazYrD7REPO4rHb4PSJxbRjbq3bwy8umBaJ5fl51eVKcrQeKIwNKnEK4Cj+NppdXbkpj9opuRdD8Jp12Assc5PsDFZJmlX+yUkqicRh0mL6Okk78yoCnZjc0qnLbINYlp2NwNldI9ZJ8RLmsve1XX1EVCi7GaJyYCRynjllGGHlqEfBYYWqHn5uP71Cu7Etcb4HamFFM9SErZgPSdQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZmOUvglyY4R8efk25qw+Q9cnlWQeQuxwO4KW9yw0Tg=;
 b=Og2LA/+o7S2VnwLyJYNEAJOzL3qUwb975Q6Kc9PRCCvqVSWQ0ry/KfGXtGFI1ZfBcfNR6Dp2Apq6jhjzlW4ucPoMFx0s+okSai1a1Sv9+Y9PMLGLqKJwsLCPkpU0+O87CukEignbjqH9bVz+kJZ3r6x6FL9Yt52zMOBj9/YbmJiudYE9mc1XO/WAPQWf3p26ygJ4SUDqDG8xxHH723+RyVgE5rriBy2E+ogt+AD3ToZlPIHIft1dH7l5zL6MVApcpD7deaS9XKmOZGi1i7No1iJJFHRoBDL49T8Nx6fuYGa3GongX3YNy7tYgJURXKHOGBuHKhH8yEoZPxsWstx1aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from MN2PR18MB2416.namprd18.prod.outlook.com (2603:10b6:208:a9::25)
 by MN2PR18MB3118.namprd18.prod.outlook.com (2603:10b6:208:166::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 12:48:35 +0000
Received: from MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6]) by MN2PR18MB2416.namprd18.prod.outlook.com
 ([fe80::8cf0:641e:631d:7a6%4]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 12:48:35 +0000
Subject: Re: [PATCH][next] btrfs: fix check for memory allocation failure of
 ret->path
To:     Colin King <colin.king@canonical.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        <linux-btrfs@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200421124703.149466-1-colin.king@canonical.com>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <a6b24f6e-1611-91a9-2f02-ff852af0b51a@suse.com>
Date:   Tue, 21 Apr 2020 20:48:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200421124703.149466-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:a03:80::31) To MN2PR18MB2416.namprd18.prod.outlook.com
 (2603:10b6:208:a9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR11CA0054.namprd11.prod.outlook.com (2603:10b6:a03:80::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Tue, 21 Apr 2020 12:48:32 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4bdaf68-e914-459f-1b71-08d7e5f24dcb
X-MS-TrafficTypeDiagnostic: MN2PR18MB3118:
X-LD-Processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB3118F8F55A08EC139255142FD6D50@MN2PR18MB3118.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB2416.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(52116002)(5660300002)(186003)(66476007)(66556008)(6706004)(2906002)(956004)(81156014)(16576012)(8676002)(2616005)(4326008)(316002)(26005)(8936002)(66946007)(16526019)(478600001)(86362001)(31696002)(36756003)(6666004)(6486002)(110136005)(4744005)(31686004)(78286006);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Swa24krwbSvexWc+SEDUQt5Mns28bJyXW4XUUuhikMYhIt7ktjmKT/xN9djyKfjoVndTSDxr20ZRaJqkkoI0Cb6Zk13ISaaJolsirwmThqyexk+HPFxLcYMPJzYEA29x8IHx6EK1kjAQN9y6pmVUAAEZg9mgBUHFKhXhJBr988GlxdBMaaTcudSzV/nHxWnChn0UMZTkkC3nCaIHAgHDl/cqQHmJiJKWTLQjd9cw4WPT3flWs6gCvof7pElViirMdRQT/m43728gA9ChrPAod4EouwLqfId+0SDCwDEGV7sSQT/zp9FhRnBWRxkhodRG8nOIWz++iAiay4mHaGS1Y0TyNBecjBybIyRbJsJl8l1oKrxqRsJc8B96m1JNemt1A80BpZBLXDrjojn8yuTzuIjlsODkxDT+WMIBWVtIWrntGZq7VG2otPQC+R3VfdE+teKJyZ7svOwtjtsL8IVkVzUr1DF9TJQrVRplhbZyzaVvl9OlJzcZoS7tnE5MtEpcRcliNiYuqkL3KYitgTR72jhd4pbbZVzJHdRnuqDS/Jc=
X-MS-Exchange-AntiSpam-MessageData: cgg0pRxajhhzbLsSW46F00HhN6RZCdYGj3r5/HBjjYwM6tPzvJsefsjSnU1NMvVeiqGte3hyt0V9eBAPTM19Ducv2WlVQ8J07Wct0ES3MawqN4MEtL8PsWjB+0sF9w/mtkZpJRjFueul1KZJoob5Iw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c4bdaf68-e914-459f-1b71-08d7e5f24dcb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 12:48:34.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLZG4aZ0nwrDJXB0+upC1LEhfNQVbZWcv5W3f9QuJgmcGPjddtXu5I1bgimyvuiR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3118
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/4/21 下午8:47, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the memory allocation failure check for ret->path is checking
> that ret is null rather than ret->path.  Fix this by checking ret->path
> instead.
> 
> Addresses-Coverity: ("Dereference null return")
> Fixes: bd8bdc532152 ("btrfs: backref: introduce the skeleton of btrfs_backref_iter")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

My bad.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/backref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 60a69f7c0b36..78e6c9a64212 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -2307,7 +2307,7 @@ struct btrfs_backref_iter *btrfs_backref_iter_alloc(
>  		return NULL;
>  
>  	ret->path = btrfs_alloc_path();
> -	if (!ret) {
> +	if (!ret->path) {
>  		kfree(ret);
>  		return NULL;
>  	}
> 
