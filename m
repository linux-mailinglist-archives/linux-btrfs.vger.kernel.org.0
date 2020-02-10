Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D748B157345
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 12:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBJLPO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 10 Feb 2020 06:15:14 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:49245 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726792AbgBJLPO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 06:15:14 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP;
 Mon, 10 Feb 2020 11:14:28 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 10 Feb 2020 11:14:39 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (15.124.8.13) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Mon, 10 Feb 2020 11:14:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDwi2vcUbvy5UhQbt/vL79HfYDRiyLx47LpkHPkpRiMFKcw1vbgKmb4PCvE8mJLIiY6m6ikiRkFHgRAT/ya/Wupk55pD6U4P1iF6R8H5s6RPV2Wg6vZ8C7D9VsNSxbpb6rsDGJIlXsxDUIpzyEduTp9FIl7Uc8OoyV1a5lDbzsVqHzGUc5smOggV2mrPV0b2bEuG6Ro4MLbeokFYz05LuUhunKnZ1ThAfUxEHpDtpde9rnlzllEOwzQVOd4DcgIjRhsHoNw3jCJ3jtvlDOBQIuXo5GfybRQ0oQczxZeLihsW0px9Cfj9/NI2G4sMfrdil2ZMR5WvW9no1YxYgbioyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHEsHpI93xNAScIynh7NtvADYqXMnqThRsyt/z2+hMs=;
 b=EL/OT4k9mEg8VxIbqwYsP3cgQWXj0Zz0mvH4ypFwX+ymnsxxB76mZ6Sb5x7zB52ELvwSrYN3TIcrR7fOOyadE2VpdJhiAIu/XY1g6cXQB/tfKoBRzxNxfGlkb4QOhcuNKx/VZHwdM6Hw7vHQOEhhQRjjPpefMRwCMV6XrXxsEmBNiNGCzaw3GrpP3LBZCZeIrP90TqN7QgEvIFOmMiulRDk2oILdV2nIKtG0qUFbtWt3My4tXH7R3EWCe21/4YpHSu3sxCRPr3EeIKmgHiT+z2o1GvT0ECR3m96SwpaQdGrLkYGr9XlR1qLwVy0TTHfpNHA6UurPoK7WIEYcKWRxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3363.namprd18.prod.outlook.com (10.255.139.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 11:14:37 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 11:14:37 +0000
Subject: Re: [PATCH] btrfs: Doc: Fix the wrong doc about `btrfs filesystem
 sync`
To:     Steven Davies <btrfs-list@steev.me.uk>
CC:     <linux-btrfs@vger.kernel.org>
References: <20200210090201.29979-1-wqu@suse.com>
 <19c4d62368843534e7f45163fb19a086@steev.me.uk>
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
Message-ID: <58d4e846-f31c-3d4a-4b3d-1453b4ef10ec@suse.com>
Date:   Mon, 10 Feb 2020 19:14:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <19c4d62368843534e7f45163fb19a086@steev.me.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR07CA0056.namprd07.prod.outlook.com
 (2603:10b6:a03:60::33) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR07CA0056.namprd07.prod.outlook.com (2603:10b6:a03:60::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.24 via Frontend Transport; Mon, 10 Feb 2020 11:14:35 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f553780-5142-4ea3-2433-08d7ae1a6a4e
X-MS-TrafficTypeDiagnostic: BY5PR18MB3363:
X-Microsoft-Antispam-PRVS: <BY5PR18MB336378BF6050F31C16FE98BDD6190@BY5PR18MB3363.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(189003)(199004)(66556008)(66476007)(66946007)(6486002)(6916009)(6706004)(5660300002)(498600001)(31686004)(16576012)(36756003)(4326008)(53546011)(16526019)(8936002)(2906002)(26005)(52116002)(186003)(81166006)(81156014)(8676002)(86362001)(31696002)(956004)(2616005)(78286006)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3363;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCpyvDrCLZyZU0gaYPwHs/XpL/4odlTU2U71NvOlvB1+1BwwDa2z0ND4oBcWAsvck3WkVY1Gc0bFEfmDaP0dGa+3B90PiJl84AAh4Ujao+2+kDdg2c4w+r1dHfXAOIeyWZI2od5DMYMOH0gUJUoscjgU2ecykHHGy0UykZ4dbZNKSydMUYKid24LldxRlkba82E8OgWg1GvjcTFDCka8Xwj5fumnTbNHs3OTk40dQk8cj4i/hk6TqdmeezVjL4Gi9WzT9Y+j/y4FL6DFfdJpUqxcR26tlh9DgLVEh2qBn+h/JZfqmTG3pRu89ootMEjSYdGAzsCHlkHuT1DZh6OzMNlV3EuxcQ471Z1WrHlZqdcOzPOcCBlEyIIGkKI5Mkxj2WVwAifHAJKoZNf67J1BVNTHe9QjQKSkGkjpl1yAhxSmRrnPmYGgqzHLvE56inlrFon9IfpVfCmAp4oUjzfmSjLxBhcg5Obj9Gazh0QSKB9ks6gn+PBiNAbRjipj8emFr0XV7Y+3lfsF+sZ/9ILc0eP0AM/uIyhj3MKzl5JxtHU9CnxQ7BSMdx2Aa6H+agm6
X-MS-Exchange-AntiSpam-MessageData: oEFkKW+3spPLPgfO2NgOJPyt4zyKZ9UY8bHHGKQxo4SSlsQjJPskXu5v6UZOrYX3IQ7n3fXyfmGwyIPKsXo69vssvlB7fMOxIK7h7ER8LVXlj4zjtss04sQ3Hxrsv8Nejzxd4oseMxIYoj1LImYbNQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f553780-5142-4ea3-2433-08d7ae1a6a4e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 11:14:37.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buM+9BEnN7sTvPR/AD/jBoHJho7Q5QLehYphMVSKeq0SNmd3SKcYTq6LDEtv1cF5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3363
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/10 下午6:01, Steven Davies wrote:
> On 2020-02-10 09:02, Qu Wenruo wrote:
>> Since commit ecd4bb607f35 ("btrfs-progs: docs: enhance btrfs-filesystem
>> manual page"), the man page of `btrfs filesystem` shows `sync`
>> subcommand will wait for all existing orphan subvolumes to be dropped.
>>
>> That's not true, even at that commit, `btrfs fi sync` only calls
>> BTRFS_IOC_SYNC ioctl, which is not that much different from vanilla
>> sync.
>> It doesn't wait for orphan subvolumes to be dropped from the very
>> beginning.
>>
>> It's `btrfs subvolume sync` doing the wait work.
>>
>> Reported-by: Nikolay Borisov <nborisov@suse.com>
>> Fixes: ecd4bb607f35 ("btrfs-progs: docs: enhance btrfs-filesystem
>> manual page")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  Documentation/btrfs-filesystem.asciidoc | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/btrfs-filesystem.asciidoc
>> b/Documentation/btrfs-filesystem.asciidoc
>> index 84efaa1a8f8f..3f62a3608cb1 100644
>> --- a/Documentation/btrfs-filesystem.asciidoc
>> +++ b/Documentation/btrfs-filesystem.asciidoc
>> @@ -253,9 +253,8 @@ show sizes in GiB, or GB with --si
>>  show sizes in TiB, or TB with --si
>>
>>  *sync* <path>::
>> -Force a sync of the filesystem at 'path'. This is done via a special
>> ioctl and
>> -will also trigger cleaning of deleted subvolumes. Besides that it's
>> equivalent
>> -to the `sync`(1) command.
>> +Force a sync of the filesystem at 'path'. This should be the same as
>> vanilla
> 
>                                                   ^^^^^^
> As a user I don't like the use of "should" here. Can we not keep the
> wording of "is equivalent to the `sync(1)` command [but only for the
> specified btrfs filesystem]"?

From the view point of code, it's a little different. It also wakes up
cleaner thread.

But despite that, to end user, it's equivalent.

Thanks,
Qu
