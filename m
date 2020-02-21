Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 511A6167ED5
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 14:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgBUNkt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 21 Feb 2020 08:40:49 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:34121 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728177AbgBUNks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 08:40:48 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Fri, 21 Feb 2020 13:40:07 +0000
Received: from M9W0068.microfocus.com (2002:f79:bf::f79:bf) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 21 Feb 2020 13:40:38 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.124.72.14) by
 M9W0068.microfocus.com (15.121.0.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 21 Feb 2020 13:40:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPv8g9qxuAGzPBH89nSbE+SuQw8qcJgSoN09+VQvg0Ob+u9VO0n4MBcfnAxrp/La7F5/wq4rxnpCX7oRHC6LLLbw00W8Jpi9rZ12qez1HeguyyDhZdYSuILX1ur+bm8YcJkV1MqgzwXk48xSSGEn7l3F7uS6KyI+F5HzchS7TGXsURGQDgkhfBhFHDY+4ZA2w7hbPnaNWonpMwajt76yFFieXKORrDsgWq/2edGveUZeLYg1mV1/ussajNwJ71IOJzbKJGdYpSEdjO3ZSawKclx/pWOKshM+J3rJOjsW8r8TmW+gAiW1MQbBA8B3KXTuLCQn0B7/Ymk+5bq8eN0Fxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Kj1VGQqpgpV5TtpaHwecBYojd60WN7HTS/jfAE1qF4=;
 b=E3cd9+PFsu8c+tbYynut+ERzsHIspBxZ8yZQLhQuDTxMbb5Rwx8s4uH/CRpVCFOli5It7pyxn9zwlfKjIlyN9hTNG0dTeNMWHxVN5BtEHL+1hJ8GwAv43yFnGBj6npSwxBpDU4KBVAKsv7XN3sn68hCUY3bwZAigPYUG37ev6e4ZlZabcjeDGD807+uZldIGBiABpB0RwO1LpE+msgglEIuYabNJMjVjhglmbSrbwU+anZjSG45aab7XCVAnz1d9rdCOsBYN+e+mBRB11y9F6PAYHdRZRc0k6Kvdq5luCVmCPa05Lusb/9pydjycLz2JqT3YJv+U5xjQ8fTn7V25HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (2603:10b6:a03:1a1::15)
 by BY5PR18MB3363.namprd18.prod.outlook.com (2603:10b6:a03:1af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.27; Fri, 21 Feb
 2020 13:40:37 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2750.021; Fri, 21 Feb 2020
 13:40:37 +0000
Subject: Re: [PATCH v5] btrfs: Don't submit any btree write bio if the fs has
 error
To:     <dsterba@suse.cz>, <linux-btrfs@vger.kernel.org>
References: <20200212061244.26851-1-wqu@suse.com>
 <20200221133559.GG2902@twin.jikos.cz>
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
Message-ID: <8e100fed-13ba-febf-14da-452635094aad@suse.com>
Date:   Fri, 21 Feb 2020 21:40:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200221133559.GG2902@twin.jikos.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BYAPR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:a03:80::32) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR11CA0055.namprd11.prod.outlook.com (2603:10b6:a03:80::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Fri, 21 Feb 2020 13:40:36 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 837d1d51-4480-4488-d898-08d7b6d3a20f
X-MS-TrafficTypeDiagnostic: BY5PR18MB3363:
X-Microsoft-Antispam-PRVS: <BY5PR18MB33639A3B84FE9A04F2AA31EDD6120@BY5PR18MB3363.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(36756003)(6666004)(31696002)(26005)(478600001)(6706004)(186003)(52116002)(86362001)(16526019)(8676002)(956004)(8936002)(2616005)(2906002)(6486002)(31686004)(81166006)(81156014)(16576012)(316002)(66946007)(66556008)(66476007)(5660300002)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3363;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUbKd3Xm5EEMxxceAEprHBap/8q/I9jiIR75A/fwUo3srxfVKIGxSWfRwKs6b2mSgunT82kDB0nZB2mxWImTE2PsytjtFjnFvWZXFTDK94yze8l+tBBuQIGA7pAojVRSB2mn5z8470H09CvWsMuC+MYIIFAXGdV1v/98H4lAVd0VDFeK63N+NgVtFw0IDhHQaskkgn1lG4hmV9dZwH0n9NslVkNJE74ExX/l14blO9LoRMvEO6XwO696HvszdsFJZigeTQtwMwogtPix0ZQp47tx0t3FsvPd4GNYdUUNaJEoYIv3SSq7eLEmJvx8TUd3eTula8aVkk5b47CSePfj6mamHy/HbQLsyBLLdUoOQIl9B9jv17fqmtZoj0ZPhGmyfUnvh8xSXiSB86T1OFUnuMmYCr5aYm3raku7NdAjTogOLCy7ves/zVpj2gdvvFk7tfiA5NKKNdQ5jDZb7127TZWLd2WtqJTm6zc+t1m9cL21dL79JMLqxIB0vrQMPbi6DygPiATapUIZgm4qtuusa7+2cnr42Wkc/i9m4YbxPeA=
X-MS-Exchange-AntiSpam-MessageData: MFy7zNBWPSPOI8bs1U9IUFivYvwWYa8Z9HHPkn7zP6gxW130pl2XRCFQ1ppaPFAGO7l57lTCFK4va+xJy3caVtbWuzZdCjzVP6HFHVhYZc32Zcl1JI/I99IYRZsD0i/Fm4AQ5+QGNscDWYs311e6Iw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 837d1d51-4480-4488-d898-08d7b6d3a20f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 13:40:37.2045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Juq4/+WcwvhSYsbqUM3LOeJkWFChdNUFuF3uzdwyeLPbs/0IYkwIrr5ogpLZvHc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3363
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/2/21 下午9:35, David Sterba wrote:
> On Wed, Feb 12, 2020 at 02:12:44PM +0800, Qu Wenruo wrote:
>> @@ -4036,7 +4037,39 @@ int btree_write_cache_pages(struct address_space *mapping,
>>  		end_write_bio(&epd, ret);
>>  		return ret;
>>  	}
>> -	ret = flush_write_bio(&epd);
>> +	/*
>> +	 * If something went wrong, don't allow any metadata write bio to be
>> +	 * submitted.
>> +	 *
>> +	 * This would prevent use-after-free if we had dirty pages not
>> +	 * cleaned up, which can still happen by fuzzed images.
>> +	 *
>> +	 * - Bad extent tree
>> +	 *   Allowing existing tree block to be allocated for other trees.
>> +	 *
>> +	 * - Log tree operations
>> +	 *   Exiting tree blocks get allocated to log tree, bumps its
>> +	 *   generation, then get cleaned in tree re-balance.
>> +	 *   Such tree block will not be written back, since it's clean,
>> +	 *   thus no WRITTEN flag set.
>> +	 *   And after log writes back, this tree block is not traced by
>> +	 *   any dirty extent_io_tree.
>> +	 *
>> +	 * - Offending tree block gets re-dirtied from its original owner
>> +	 *   Since it has bumped generation, no WRITTEN flag, it can be
>> +	 *   reused without COWing. This tree block will not be traced
>> +	 *   by btrfs_transaction::dirty_pages.
>> +	 *
>> +	 *   Now such dirty tree block will not be cleaned by any dirty
>> +	 *   extent io tree. Thus we don't want to submit such wild eb
>> +	 *   if the fs already has error.
>> +	 */
>> +	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
>> +		ret = flush_write_bio(&epd);
>> +	} else {
>> +		ret = -EUCLEAN;
>> +		end_write_bio(&epd, ret);
>> +	}
> 
> This replaces one instance of flush_write_bio, would it make sense to
> wrap it to flush_write_bio or some other helper? There might be places
> where not handling the fs error state would be acceptable, so eg.
> 
> flush_write_bio = as it is now
> 
> flush_write_bio_or_end = does the above
> 

I don't believe there are other call sites needs such special handling,
thus a wrapper only used once doesn't make much sense.

Unless we're going to introduce more path for btree writeback, current
one would be good enough I guess.

Thanks,
Qu
