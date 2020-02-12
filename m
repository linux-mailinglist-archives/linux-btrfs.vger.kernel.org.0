Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB3E15A9AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 14:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgBLNGd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 12 Feb 2020 08:06:33 -0500
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:43145 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbgBLNGd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 08:06:33 -0500
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.191) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Wed, 12 Feb 2020 13:05:26 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 12 Feb 2020 13:00:58 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.124.72.10) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 12 Feb 2020 13:00:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccQEWt6dgd+RNoEjToQcDqSarCzS3C6+LYnoUKcku5odFO9eL+a+FEthHDhcV7Sy5gN+5LLo9c606FNkfcX78Fn0HaWf9gDuYr4wpiBrV63co2Ng/pyaT7c3lttOgJDg+7BzLC6WJuPxkdfqL1FWdCCt6hhb9Nf/oZrVooYdJWJSmTXHxFmjd49moIuMaUVzNPlve2kGUNSA2mQCyVI5eyYxEFNHJIpWbrWLWVR/27+Y+xr1mUJM1bJlgxXlOoLYVMqtXQ/aqelyIcjaeqLgy16ZqokAqZdPWTcalAoawPGQaUiMnwhT3J3uK9xWktPFdtzwG3VpJHjoy4dGADz2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qjhOT1OYsGTrke+JQRjquRNdTfCIQ4+sJDcwRA5d8A=;
 b=FyDOkvOvUhNtAzNKhGyBWIrVw9jD3+rGpI2TrTB2elML1CZZI5AuOmdPxudOqSHJEO34Q0r5n35123u75lmjTrwGsmtClXFd1jSosjHHA14o//6ZG1GNmIJbh99sGIXzj2YeNKos803nj/F5SuYSpSdb67L6Zxz+O93cKuUK7PGLklbXnNnYPns3U8k+IjExI7qLJ6+gI5gnyKGA1ekH+wfIG0ShVvxLn7SzFOoikLQMFkW0U9miMGiX2gvRxVrlhW46X3VNBBVZwfWWpNMFYbrY7WwrWH66v9NmkERToJlzqOsPcqAjJNcxCe2CWKxpUh29hewaMaVGtpn2iaTA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3412.namprd18.prod.outlook.com (10.255.136.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 13:00:57 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 13:00:57 +0000
Subject: Re: [PATCH] btrfs: Only require sector size alignment for parent eb
 bytenr
To:     Josef Bacik <josef@toxicpanda.com>, <linux-btrfs@vger.kernel.org>
References: <20200212053040.23221-1-wqu@suse.com>
 <9d4bfc49-f914-aa2f-2809-a65a267917a4@toxicpanda.com>
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
Message-ID: <d9ac805e-8e42-0903-b80c-e7a55722f0ea@suse.com>
Date:   Wed, 12 Feb 2020 21:00:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <9d4bfc49-f914-aa2f-2809-a65a267917a4@toxicpanda.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BY5PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:180::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.16 via Frontend Transport; Wed, 12 Feb 2020 13:00:56 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fb168b2-7ce8-46e9-9873-08d7afbb99e6
X-MS-TrafficTypeDiagnostic: BY5PR18MB3412:
X-Microsoft-Antispam-PRVS: <BY5PR18MB341261F4A9789CF155C46B63D61B0@BY5PR18MB3412.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(199004)(189003)(5660300002)(2906002)(86362001)(36756003)(66556008)(66946007)(66476007)(31696002)(31686004)(52116002)(8936002)(6486002)(6706004)(26005)(53546011)(81166006)(16526019)(186003)(956004)(81156014)(8676002)(2616005)(966005)(478600001)(316002)(16576012)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3412;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHFXfFlXxM+jXxL04kUCdwZOJOs5WEyo7RYSUb+6gKgc5dg4GHJkZnqGrvGNwU+4TngLs1ZNlqY4eLYERW+a8wIj+02pCYYmYzDqx89aQajmH2vrDzL3joloSHkTyJP09iYtUn7Dcn6n3Kn6GLgIZFowgyjxz2+msKwzKc/r8Y1c3TROt4sQS/qu5P8WIblU+cPZhY9Aydc/acKWFSvqK+GruTZ+VMe5y32cQ1TyitFRer/97V3FEQ0m/dwYTjdFniT1wEGswE/c5DNnsnvo6B4IiFhnV3oOfuQa/U+MPYf5n4yHQ2pIf2rt3ZYgKHpECzw59MNd+h8gM4IGz9VOszsS9HxsIxwgRbkUSYTRpre2/WbG1RHcj9MtH1GJF3TgsXtIxysfU9Sct3x1Sh9UjnOVyrAlaXFqhhqgIbqUb13Me5EzG4t2/Wi+UpVSdPIq3x+oLzd0o9YHEjoYHFg5W3lh1Fjs4JoVmuRS0uWBzNWaVFmhrkWdOkTiu+0xoWd0F9NWGSoIJEwa7/R4pYtC1HOt8zatvsvCv9Ktc3C6CsCgkz4CnHlmrm/7jzL/tZzRECiWvPN05RLtaJBwZ/+NKHSJoeZ4zmWDbQ62gofO1Iw=
X-MS-Exchange-AntiSpam-MessageData: KHojrt3Yu+1VC9OzHsrk6+KSu6jef1wct72luD/LBeUCt3S1RUZyxjqWQo74wW/Z8SkpHY9jWdbtVHz1sEAzDtYuINCdkptud+o6ANOTCfTn61recLNQ398k0k/bI8i/nH1UOcsf4bYK8cdela8DCA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb168b2-7ce8-46e9-9873-08d7afbb99e6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 13:00:57.4134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYNE3YopGqU0L0QZh3JOV/BExvNHCAlwXAVrquERTnMPh3zTGwWIBRk50179NOEy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3412
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/12 下午8:58, Josef Bacik wrote:
> On 2/12/20 12:30 AM, Qu Wenruo wrote:
>> [BUG]
>> A completely sane converted fs will cause kernel warning at balance
>> time:
>>
>> [ 1557.188633] BTRFS info (device sda7): relocating block group
>> 8162107392 flags data
>> [ 1563.358078] BTRFS info (device sda7): found 11722 extents
>> [ 1563.358277] BTRFS info (device sda7): leaf 7989321728 gen 95 total
>> ptrs 213 free space 3458 owner 2
>> [ 1563.358280]     item 0 key (7984947200 169 0) itemoff 16250
>> itemsize 33
>> [ 1563.358281]         extent refs 1 gen 90 flags 2
>> [ 1563.358282]         ref#0: tree block backref root 4
>> [ 1563.358285]     item 1 key (7985602560 169 0) itemoff 16217
>> itemsize 33
>> [ 1563.358286]         extent refs 1 gen 93 flags 258
>> [ 1563.358287]         ref#0: shared block backref parent 7985602560
>> [ 1563.358288]             (parent 7985602560 is NOT ALIGNED to
>> nodesize 16384)
>> [ 1563.358290]     item 2 key (7985635328 169 0) itemoff 16184
>> itemsize 33
>> ...
>> [ 1563.358995] BTRFS error (device sda7): eb 7989321728 invalid extent
>> inline ref type 182
>> [ 1563.358996] ------------[ cut here ]------------
>> [ 1563.359005] WARNING: CPU: 14 PID: 2930 at 0xffffffff9f231766
>>
>> Then with transaction abort, and obviously failed to balance the fs.
>>
>> [CAUSE]
>> That mentioned inline ref type 182 is completely sane, it's
>> BTRFS_SHARED_BLOCK_REF_KEY, it's some extra check making kernel to
>> believe it's invalid.
>>
>> Commit 64ecdb647ddb ("Btrfs: add one more sanity check for shared ref
>> type") introduced extra checks for backref type.
>>
>> One of the requirement is, parent bytenr must be aligned to node size,
>> which is not correct, especially for converted fs or mixed fs.
>>
>> One tree block can start at any bytenr aligned to sector size. Node size
>> should never be an alignment requirement.
>> Thus such bad check is causing above bug.
>>
>> [FIX]
>> Change the alignment requirement from node size alignment to sector size
>> alignment.
>>
>> Also, to make our lives a little easier, also output @iref when
>> btrfs_get_extent_inline_ref_type() failed, so we can locate the item
>> easier.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205475
>> Fixes: 64ecdb647ddb ("Btrfs: add one more sanity check for shared ref
>> type")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> We aren't allowed to have nodesize != sectorsize with mixed, exactly
> because you ended up with weirdly sized holes and such.  How is convert
> ending up with this problem?  Thanks,

Chunk can start at a bytenr which is aligned to sector size only, but
not node size aligned.

Then all its tree blocks can be unaligned to node size, while the offset
inside the chunk is still nodesize aligned.

Thanks,
Qu

> 
> Josef
