Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F9B2100DB
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 02:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGAAHF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 30 Jun 2020 20:07:05 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:60316 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgGAAHD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 20:07:03 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-15-6OPvVBxtNaClnbn2Vw6i4w-1; Wed, 01 Jul 2020 02:06:56 +0200
X-MC-Unique: 6OPvVBxtNaClnbn2Vw6i4w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMhMZFBBtaj01y/p5UePpLH3HJmrki1O33b9LODIXoYNgJURwDEZphV920fdFTL7k8I0QXWiSjLqhWNeiKYMBa+v3UM6MQfK9ChHPkXTQltuRZjue/2aBFES35LlYgSe0zqxgLJ0iLcVqH17ZbYepNVDLPa8OIIqIUmPJ0YYgCHy/bzOCqXATYPxBQLM5oT13iprVz2+vvx1z2/Hl0YAQ9OyPv33Ex2/gwoBcEONUBiIFV2SWj1oMww6x1IEbtj11D708tI7F+Iu5cS6SbRpzJsC4saRNz3zI34A5S656vWXkJOiIvdfYlNPEgzojEe27gvHX6iEtp6K5TsDCmlHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOS6C1gQdALsPjUTiOcy6CxCKSyI8KW1rrpybtufEvg=;
 b=SoDQ/RKJUXr2blVS8d7NciTVG6sOJb6k2pmN4ygV+nbYiYCv9H8AaQBct0HJ9UxtwxCFN9BfbU8Y9DmVvJqZtHhrgd9XalH1i/PS3KcKl1f3n1JLU8UQjIvd05vy9b1Q8epUjEYqDcSBb/sFwMKd2KCZr0CmllKh3yW4UwsHhELVjSwvsfmnHGzmpAqqC5FA5K+H56khzx8cfzf3SetUc1QLyidsQQgtyYdVYucIIZLPXxeDgpjMWsvjDclgkI406K3vPkgomUMWbIFW878N9Z4aNkqTasgjj9D2HpsPrba+szN2gRoPL50/LCIlKRgtcATVBQ3PlZCYvhpHCnMh9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB4644.eurprd04.prod.outlook.com (2603:10a6:208:75::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 1 Jul
 2020 00:06:54 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::688e:afdb:90d9:bdef%3]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 00:06:54 +0000
Subject: Re: [PATCH v2 2/2] btrfs: qgroup: add sysfs interface for debug
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200628050715.60961-1-wqu@suse.com>
 <20200628050715.60961-3-wqu@suse.com> <20200630165756.GB27795@twin.jikos.cz>
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
Message-ID: <a7cbc3a4-6a6c-8b43-0eb9-4da088be4e58@suse.com>
Date:   Wed, 1 Jul 2020 08:06:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200630165756.GB27795@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR08CA0009.namprd08.prod.outlook.com (2603:10b6:a03:100::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Wed, 1 Jul 2020 00:06:53 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc8e87f7-78a6-485a-b00b-08d81d52a9bb
X-MS-TrafficTypeDiagnostic: AM0PR04MB4644:
X-Microsoft-Antispam-PRVS: <AM0PR04MB464426EE5A4FD55F204E8699D66C0@AM0PR04MB4644.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: haXImk8BP/4Ip9CF60yu1oyGyeeheJnxypjcgT+E7XwrWDfu3FXyzz/1hNNTkeKz4+GFNJeWjzhbRJeZZQYj5THALaGZ6GJCapgmxeDtoVrh4FdUw6+kFmuEa8w071nNTG+Z+yNQQHUiiG9F8n8RusTj3SoUMbloUWcOwGv9/j/mqqz7iBvE2MYx014+GsxwVRsc7BRkQh64zatvQECqP8lN9cAglH1Q7lzWWpsGj2+6rlHWZkhHyTSh3yioVAjQqwOcrh3z9ibdBTJgakYMY6kgTBtu1Jhcuc/kQ9u1bqM+HpwswtlcrncsfgrIb061ZOTHg4UsvkDLwBewcESNWf7sOK6Oz30S5uDVILwrTv8pJJxCHd3e5fXjyhxb8OjlXuOL+wi405mlw6R2ZK+a2UCfRxw6N9S2UcjKKnnZ92IJx3OqXoE1UezZlR9q/zl0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(366004)(376002)(39860400002)(136003)(66946007)(16526019)(2906002)(86362001)(2616005)(956004)(16576012)(66556008)(66476007)(5660300002)(316002)(52116002)(36756003)(31696002)(6486002)(31686004)(8676002)(478600001)(6706004)(26005)(83380400001)(8936002)(6666004)(186003)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HZ2JxBg2WcT26lqr2ooHBV40p6gzX0v6CGiSj4QWyR2iQ3O6EBDme6/hva7BsmtizgmEK+r+FPjhEBsPZkck4x3ElKEDSN8M9Kjsr87qCio7oawhSstAnUIzJ2N7doqemE8C1zlkysriftww7+t/C5G3K/9CPfOAar+YEHU40QOQlyg3zXwZPKb7n7Z1kNgPX49fiomKoRzW8D2hqOXcEbzlfLvDVRluL9sBkw5XlbDeYb7w6zeAVjYQ7t9dx+J8Fd9vDdyS0AtZcq3yz7EET+z7+QdVo9QgifhtiKddP/G6iVpFcJbOaZigs3XZpD66BMQdBgdDx1qzNL8QNEJqgMBPk0iXHrjYtEj1OygGpIXBxwHwMS3VGT5VeNQvco4Z6fSqWppeMXVFjqn5b63jIqzOc32COoYJUx9H6aqPOmoDEShNE/1Rht6ZvdAIIqyrQwiIKi4Hr+FZ4qkPwhKKq9itIENqy7lvEWIYYXKJLHM=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8e87f7-78a6-485a-b00b-08d81d52a9bb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 00:06:54.6497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEdXYamSJ/OPE/yRKAEbFhi66B21Rx+cKqY8ts75S82zrK6xHkEEST7o2kNX8Vvs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4644
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/7/1 上午12:57, David Sterba wrote:
> On Sun, Jun 28, 2020 at 01:07:15PM +0800, Qu Wenruo wrote:
>> @@ -1030,6 +1040,11 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>>  				btrfs_abort_transaction(trans, ret);
>>  				goto out_free_path;
>>  			}
>> +			ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>> +			if (ret < 0) {
>> +				btrfs_abort_transaction(trans, ret);
>> +				goto out_free_path;
>> +			}
>>  		}
>>  		ret = btrfs_next_item(tree_root, path);
>>  		if (ret < 0) {
>> @@ -1054,6 +1069,11 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info)
>>  		btrfs_abort_transaction(trans, ret);
>>  		goto out_free_path;
>>  	}
>> +	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
>> +	if (ret < 0) {
>> +		btrfs_abort_transaction(trans, ret);
>> +		goto out_free_path;
>> +	}
> 
> This adds 2 new transaction abort sites altough I don't think it's
> justified, the filesystem is fine. If system is that low on memory it's
> gonna be very bad elsewhere too so we don't need to make things worse
> jsut because of some missing sysfs entries.

The problem here is, we don't have good enough way to revert back to
previous status.

This is common among a lot of qgroup code, and I prefer to fix them
later, as it will be a big qgroup error patch cleanup.

> 
> A warning would be better, though in that case the validity of the
> kobjects should be double checked where it's accessed.
> 
It would be even worse if the qgroup relationship is also exported
through sysfs.

In that case, warning is not good enough.

So I still prefer error path cleanup as the ultimate fix.
The objective is, if we hit any error during qgroup enabling or other
qgroup operations, we revert to previous status if possible.

For qgroup enable, if we hit any non-critical error, we don't abort
trans at all, but remove all qgroups along with its qgroup items, remove
the qgroup tree, then reverts back to qgroup disabled case.
This includes -ENOMEM case.

While for critical error like tree operations errors, we still abort
transaction.

In fact, I'm already working on a similar project, but for extent_changeset.
So I guess it won't take too long for qgroup.

Thanks,
Qu

