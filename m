Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64E01155557
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 11:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgBGKJr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 7 Feb 2020 05:09:47 -0500
Received: from m9a0014g.houston.softwaregrp.com ([15.124.64.90]:43941 "EHLO
        m9a0014g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgBGKJr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 05:09:47 -0500
Received: FROM m9a0014g.houston.softwaregrp.com (15.121.0.190) BY m9a0014g.houston.softwaregrp.com WITH ESMTP;
 Fri,  7 Feb 2020 10:08:48 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 7 Feb 2020 10:02:47 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 7 Feb 2020 10:02:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQf4lgd/CONjYQtZefiXwEM/s1KPAi/gy6r58qbd291BM/R2G87CW2b+MMVQ/P6K2i/2Bc+uHg1mBMND2Fj6EJ0sEBPJLbk0xVFZcgDrzHVNfuGb3Wqi794AiSXxHi3lerZGT7CRDOVngRIp6P/UicZaZZNpBNerKAwLX9865xNnV0piMcaWfdUt2YBwoF6BCNX0vLBhteMoxfXTS3H5DBk916W77Mb2gZIFKDuZTf0YYT2xTFH9RUIuAGZZfZQQRO/5ZTyVSu6kZ7+ZojpQ0fNIDm9XlIrOjG1eZdDk1jacMQ6RjL7sM3kRCAbSrG2/KVrIoP3ZMBMOOmySfefTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eH93KWe+99c/Ep6pgEWvvZLIagUQtr8i2j6pGsLrsU=;
 b=BwW2qUY5UrVDBpO6wIIKk6bGuwWRXnvoFQ0mN2cj1PuQ1RzhKeONL0rX/qmTxAJshdRjdt2zhciunt+FS/DUQ8/VMkPlvYHq89Sdg9GHtkTu4eM+K3mdrHxHKnYG89rXRCWt5iSHZNqSpiMu29Ff+pHXtggX5SwrM5GZrrqKYT2Zgn9VnbRG+ka/daGibUUjyFME/2fuMyLII79qvaB1MD40lUet1UcTZjOO1qN1siGMS/mBVXNGvSrWB4EN4uPlqAXlXCZ33nQtukrHAulZx2SvQM9gM0Smh2WHfs/e6ecBlIKdnsT/M0xxp9h15yEtVSH/QblXIS/sx1GVsV3rzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3427.namprd18.prod.outlook.com (10.255.139.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Fri, 7 Feb 2020 10:02:45 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 10:02:45 +0000
Subject: Re: [PATCH 1/3] fstests: btrfs: Use word mathcing for
 _btrfs_get_subvolid()
To:     Nikolay Borisov <nborisov@suse.com>, <fstests@vger.kernel.org>,
        <linux-btrfs@vger.kernel.org>
CC:     Josef Bacik <josef@toxicpanda.com>
References: <20200207015942.9079-1-wqu@suse.com>
 <20200207015942.9079-2-wqu@suse.com>
 <b7a6bacf-0434-9743-1ff0-41f9344421db@suse.com>
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
Message-ID: <829c0acb-a734-56a6-9649-5dd697fea6cf@suse.com>
Date:   Fri, 7 Feb 2020 18:02:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <b7a6bacf-0434-9743-1ff0-41f9344421db@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BY5PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::20) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Fri, 7 Feb 2020 10:02:44 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 408c2c2f-2b1c-4362-7ed3-08d7abb4e10e
X-MS-TrafficTypeDiagnostic: BY5PR18MB3427:
X-LD-Processed: 856b813c-16e5-49a5-85ec-6f081e13b527,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR18MB34279ED8A9C7C8A80B8ADB9BD61C0@BY5PR18MB3427.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(189003)(199004)(478600001)(4326008)(66556008)(2616005)(956004)(66476007)(6706004)(5660300002)(66946007)(31686004)(16526019)(186003)(26005)(8936002)(16576012)(8676002)(81156014)(6486002)(316002)(81166006)(86362001)(52116002)(36756003)(2906002)(31696002)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3427;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DzmIYQ0V1rguEJNblnz7pfRtOQjK8xDCJ3EwS5dJe434wigQfpQ3a6IvN6uUZIjqiVnQF3K1zfn7mxZ52HcqzsTmINsAZCDpPantUUB8nsateo6auPDgEWmwCpzs6iTSyKeVVruNN122/luIjRnfM7GimqxlqkFoxhi8dP7jQFxJe8A44cfe61NPdimBepTmJS/oNLImPTVVeFDulBV1MVVppRfBXxUu2FLPs1in3bCkb9U9ue2BBiHFLItYRszN+GPjhTvr8/geQDm1hBNuXFs0MsnFnV1ORdF2nHVifTWXA9EWelk+O5JoOtJ41YezTcuqjmp5S5tHpG9PXSUEVGDDD26hzrcNkWobQT/I0nKtj6lFGlCYgodDfA8oClSAU8jTyr8ZzZDXA5Thc9bN+z5aSC8l41PGPSRPObnURatJA5yvOFe7jA2Tz2aIpZimdJPJI4VpxbEwXweDUATnA/al6J5wjmz4lz3ETBhfYLJ2OCKLnXq+08MTOg/wNqPuagr2oj+H1JkUmdmcg5g8JCRIQ1XeeUrZX6SmnmvJaw=
X-MS-Exchange-AntiSpam-MessageData: s1ZTWN/w3Iao5ECxBDjqecjFrXJLMnWPxYaE7dn3dJLCK0LDE3UokR117y33kCqKE6dVk0tqUMG8KuhGMqiL4xnyZKcS8uZ2+zkT/V+X1PAuBhfBetYnSE8Llzub8F9a0NHOd2ce/y6b9wNvQ2msJA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 408c2c2f-2b1c-4362-7ed3-08d7abb4e10e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 10:02:45.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /E2AiMpX+Xgsz/bZMPEKqGkvPryUXFz2aqNrJqX8ErFjjq4Y8AH/kQdWOcoVNDnu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3427
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/7 下午5:41, Nikolay Borisov wrote:
> 
> 
> On 7.02.20 г. 3:59 ч., Qu Wenruo wrote:
>> Current _btrfs_get_subvolid() can't handle the following case at all:
>>   # btrfs subvol list $SCRATCH_MNT
>>   ID 256 gen 9 top level 5 path subv1
>>   ID 257 gen 7 top level 256 path subv1/subv2
>>   ID 258 gen 8 top level 256 path subv1/subv3
>>   ID 259 gen 9 top level 256 path subv1/subv4
>>
>> If we call "_btrfs_get_subvolid $SCRATCH_MNT subv1" we will get a list
>> of all subvolumes, not the subvolid of subv1.
>>
>> To address this problem, we go egrep to match $name which starts with a
>> space, and at the end of a line.
>> So that all other subvolumes won't hit.
>>
>> Suggested-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>
> 
>> ---
>>  common/btrfs | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index 19ac7cc4..85b33e4c 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -7,7 +7,7 @@ _btrfs_get_subvolid()
>>  	mnt=$1
>>  	name=$2
>>  
>> -	$BTRFS_UTIL_PROG sub list $mnt | grep $name | awk '{ print $2 }'
>> +	$BTRFS_UTIL_PROG sub list $mnt | egrep "\s$name$" | awk '{ print $2 }'
> 
> nit: But you don't even need egrep for this, you could have simply used
> "grep $name$"

That \s is needed. Or the following case can't be handled:

   ID 256 gen 9 top level 5 path subv1
   ID 257 gen 7 top level 256 path subv1/subv1

Thanks,
Qu

> 
>>  }
>>  
>>  # _require_btrfs_command <command> [<subcommand>|<option>]
>>
