Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7F942A1E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbhJLKV7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 06:21:59 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:42939 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235153AbhJLKV6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 06:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634033995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4HkSDjFOYunLpfrgmSSRwSHpFCHAn2yeEHQTZfWDlFA=;
        b=jtjxxNLuhUAXUyU5Aa2CKBXjOLrHUS6Kbv4fmlm5To5EorZ77nHw7w/l8Uc1Hzuqp+pCfy
        IJa+Ruguggxo+MJp9pqhc6pYaGn5/CARMWc98Ro9kNoXSqPzr/WGzbPCymPQK8X+n/082K
        X/cLNY/nRFu6EXvIOi9LitPJyJCNYZ0=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2052.outbound.protection.outlook.com [104.47.1.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-nZsXM0xoNJC0mlcNZBKZrA-1; Tue, 12 Oct 2021 12:19:54 +0200
X-MC-Unique: nZsXM0xoNJC0mlcNZBKZrA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKqRMzBQp9FsJAYG4Ji6LYmZ5/FwPgQdUkL2ov22QJ7lwSAuOpMFEp2JrkFy2PskLFwiRLdwrQ4GpK+Bb9dn20u3eFZJSKFk+oI9NDSuPUUsemitOrKCUv4uwMWZwklH132BTXlf/W7dWST/u+N7sXq/NhzihX5wcOQcbHeJwKIvJB4PqHWKTuU0tL5nRHiDpjoNhfO0PBSNG12cqezbY+AggokTuviC3tA4az8Lym0R5mUt6TllPw+zk+hXmF1i2sJDCrkI217PpH5cpbIgx4Jn/s5+TB8iE3kFQkJPe69eojRXu0tLkEuFKusJKe5wSrWFtgsaead3zjgbr/LV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HkSDjFOYunLpfrgmSSRwSHpFCHAn2yeEHQTZfWDlFA=;
 b=EVRTSyir5CgFy0sPOFkbzcyuCf/ejCqRjNoH7XCQ/tPw4c7Q1VHefZdkXGO3bOdxnYuI2ZavzKwjnV7xEQEMwcnXiNm/JqyaoZ3Sx6IXytEjA5SedZrN5S7MDanjKU0gE+AeSDW5Y0YidHOh0usJnTebp7PfX6tL+VbbG18q+eA02z+ZhQaJReqD2VlR+7OZDLo82zNWSplLKl5AcA5pDJvl9c95DROwOv+fBGxxr91huRZn0Lce37EZZr2khjjEUg4pX8c+rCjrROkeZIrSMCttI6EhZjif0riz5EZrSRZ+u3szrFv+jjMM2+M+i8aaUhTlHDol2iA48eD8QzUV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR04MB3154.eurprd04.prod.outlook.com (2603:10a6:206:7::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 12 Oct
 2021 10:19:54 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::2d84:325b:5918:7a19%5]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 10:19:53 +0000
Message-ID: <c2919020-bbdd-be93-7293-a2270df45dfa@suse.com>
Date:   Tue, 12 Oct 2021 18:19:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] btrfs-progs: test-misc: search the backup slot to use at
 runtime
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20211012083712.31592-1-wqu@suse.com>
 <20211012101230.GV9286@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20211012101230.GV9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::8) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:a03:39f::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24 via Frontend Transport; Tue, 12 Oct 2021 10:19:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 116a139a-b7fd-43e8-0f81-08d98d69d4fe
X-MS-TrafficTypeDiagnostic: AM5PR04MB3154:
X-Microsoft-Antispam-PRVS: <AM5PR04MB31543AC0C831A843FEA93A7FD6B69@AM5PR04MB3154.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/Rz7Eo8oaULhzZSE5nDhS6Dcy8VgZJrbVnG5ez1GAf1lVmnvZrJ9GfuzFmD1WGYUt3W2afpIv+WYZ4LeiT8FFlb5JsnAq9j5fgXaTdCak7TyN8/YVaN4sBMUWuCSSmNDSwzzTFqdh8XkP9n4X7wLyoC7zrJQlt+zHYZ6uD2wD6+MRFHzecZdbl4lEgEUUYzsxlwLx82I2HAu9VzRcM4OXeQ75DrIjYGkD2rAHSQkxi0mRVaNEPoGdlaKliQdc0XhyZBQ8lFGWxKrU3Fdhcp1eyiSJ8y3gQ28R2NH96wqiVSTTACfFkdCka9qA78gE/ZUI6B+qqvmVQEta9ENS5i4ImD4HGiTpCYwb7OcszhAlFdogtGSr2K52Na9DGy/E8RV5I5wJ6Z+D5sD6OV+kFxjj2V7dHTif3S0jg0NRnzvGNdMV2UuNz6nxM+JIaLRfJtWgt/PnsQsJ4O02OBCv/DbzoxpAGwnHQDFgscNtNQbHkLpDGQN2HQzYc86EHqhfC1qVPwts6Osjt+9RwEMEPpQj6b85Z/cZhPQ6W75xv238sYi5PZHjvGZncAXyfWEan/XMuIAUbM3h7N/oV5D92wfhp3pt8zRiM6kLxDqP3PzrSZoMcxbHTV3bUMyN7fAuMhPelHRPSfaYBoZt53n9aHmuNIrnBKapKJUt702gEHADRR4G7GbRDtv1gCl6A2fwE8ANZS6QEKff73b70kCAoOaOQTwZQm8z6bj7lhJKbwQIcrNgG25zj2hsYjO3Mxa0OZGkwPg682pblS9vZR7TJKqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(36756003)(86362001)(31686004)(66556008)(66476007)(508600001)(6486002)(8936002)(6666004)(66946007)(316002)(31696002)(16576012)(186003)(53546011)(26005)(2616005)(956004)(83380400001)(2906002)(6706004)(38100700002)(8676002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0VPcy9LbkpoYzcxQzVYUytSR2QrbDY2SUl0NE94WnF0Ujhmb09BM014OXZq?=
 =?utf-8?B?ZFpmbzRpd0FKem1vaGZ1ZXpuY29hQ0ZBOTBmZCt2YmU1YkNFWUl2ZElvYnVy?=
 =?utf-8?B?V1NGSkpMZEhhMXRuakc2OGFMRkZGc1lCQUJJa2JXZTNFZ0o2MW9scHEyNktU?=
 =?utf-8?B?b2t4ZWU1MFZTeFZlTlZDRUhKU1VTVFkxaTRLOXFmeHFjMEVnRHM4M3lLRUk4?=
 =?utf-8?B?Qnp4Ny8xclhmRHlodnVuNDFOMnNKaEMvUGZHQ1AzUkNET2JlU2ZEVFREVFpO?=
 =?utf-8?B?Tkhzdk9zQ214WEdUM3pSYWVNN2VmdkFTajVubzhNTS9aejFzSDF3MDEzMkhD?=
 =?utf-8?B?cUJZbk14SVAwL0lwRis2S3BXNUg3MVh6bXlTcVREV2FuV2lrQ1VrOFJNR01Q?=
 =?utf-8?B?TWN3dUNUVVQyelhsenhaNDdjQmIwYWZJV3RLeGIvRVQ5OUIwUHhiSkNuR0Fp?=
 =?utf-8?B?WmZFVEFON3U4alFQdm5xTlA3S3krVFhyd29WeFhHWXNINE9DejR2cU9kZTFu?=
 =?utf-8?B?TzhFQnFqbm0ydXljMEUyQ2svN01Ca2wxeFZxQXRSaGhaejByS2pNNUo1TWFu?=
 =?utf-8?B?WG12cmQwcXcvUEpLSCttY1VBR0pQY05pN1hxR09NTmhZNVgvYUhaVTVOOURG?=
 =?utf-8?B?aUxDaG9CWGZiaHIyaWZzZ1FEZmtTOTE2UTRKWHgyeUpFMmZ6TGw5VlczV3Jz?=
 =?utf-8?B?Q3lsSVVhVzZvdDNNL09xMTBBaUQreXdzZ1d1aE1OZ3Yzd2dEUlFGeXhTYXlO?=
 =?utf-8?B?emwxUzVsM3dkWDNwZVRsOHBQdnJ2TzRpemZSVWVnZUdMb0ZxVitheXJhMFN0?=
 =?utf-8?B?VWxaQlFpYWRLVE5qU0kxM2JrL2loTENXdXBsQlJZWFpmWFdrU242aEtlc3Bt?=
 =?utf-8?B?M2RyNnRVVHhObXA3OVU5bmJYb3RVUi9CMXhRa1hYRktHWVNuWG1wY3hkVUI2?=
 =?utf-8?B?VC9Nb2ZwSnkxeGcrTk5DZnlibXBzaE1RRnVFdFhKWms3ZGNUK0d2cjB3Q1dV?=
 =?utf-8?B?T2ViNGs3QkRtQ0JMUVU4a3dZWFlPSjhlNk0rTXFWeWFJU1gvcWdVWmFHbVl4?=
 =?utf-8?B?eHFnM1lvL0s3VXZ5UlZmTGovQnprODVWZEwzbTRZMlE0TXNsR3B1cHRiWTBx?=
 =?utf-8?B?VzBQNjJDRUpZd1ZaZmdoKzlJYlFnMmoxaFphOVVPT1F4TG9zbkpYUnllaFpS?=
 =?utf-8?B?T0xNVWpCbC82bktTMmdmOW83Qko1VW5uQUxwcGdsTW9OT1NxNER6TWNlWG9N?=
 =?utf-8?B?YlQ1RU9kUTNpSXMwZ3RqcTN4WSt5d1lIYVRaRTdUZUcvdHJIOUFsRjRxT1Fh?=
 =?utf-8?B?WWE5b1VwUWIzZEU1MUdBcVRJQ0MvNGt4bUcxNEJCZmpIcmJKdEo3dVU3eG1B?=
 =?utf-8?B?TzYrWTJkTy9MdjUvZXZGK0lHN1RUcytGL2xRQmxoZzlWMnJUN09NdkFUMUl0?=
 =?utf-8?B?Y1RFcmdGa1JtTm5WT1lxc2xhUWhxTnBnMEpJMENwOCttdmhIV00vL3dSbmtn?=
 =?utf-8?B?U1Z0MjYrYW1vczlQK2Q2bEw1SWVrc0Vyc3h5Vm9hUC9kYzlKZUJCMWxhbkVp?=
 =?utf-8?B?am9XNk8rWmNxaThROCtXZDVHN1IrbGhpd3pZNmxva01iNFplc0JDTGpscUFO?=
 =?utf-8?B?a1VPS0g2REZKbEI2RHc2OWdLSVU3SjdGYWpyajBlMncyaHZHUzNDbGJJVnFy?=
 =?utf-8?B?aEU3ZTJJY1ZJVlNjbXQrODAyR3hHMFdrRTAxNFFYdWcxZEl1eVB1Vitkd3E4?=
 =?utf-8?Q?awS7XvG4cE2BIn7R5+YhiOQudHm53E8HnuWPigx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116a139a-b7fd-43e8-0f81-08d98d69d4fe
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 10:19:53.8349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlG6wFSoGA3npYQW9tYk5iOGHwhPWK3FNrUeX0lbYOZN331N3L+DawF5ARNxZIRb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3154
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/12 18:12, David Sterba wrote:
> On Tue, Oct 12, 2021 at 04:37:12PM +0800, Qu Wenruo wrote:
>> Test case misc/038 uses hardcoded backup slot number, this means if we
>> change how many transactions we commit during mkfs, it will immediately
>> break the tests.
>>
>> Such hardcoded tests will be a big pain for later btrfs-progs updates.
>>
>> Update it with runtime backup slot search.
>>
>> Such search is done by using current filesystem generation as a search
>> target and grab the slot number.
>>
>> By this, no matter how many transactions we commit during mkfs, the test
>> case should be able to handle it.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Thanks, that's the perfect solution.
> 
>>   .../038-backup-root-corruption/test.sh        | 45 ++++++++++++-------
>>   1 file changed, 28 insertions(+), 17 deletions(-)
>>
>> diff --git a/tests/misc-tests/038-backup-root-corruption/test.sh b/tests/misc-tests/038-backup-root-corruption/test.sh
>> index b6c3671f2c3a..315eac9a2904 100755
>> --- a/tests/misc-tests/038-backup-root-corruption/test.sh
>> +++ b/tests/misc-tests/038-backup-root-corruption/test.sh
>> @@ -17,24 +17,34 @@ run_check $SUDO_HELPER touch "$TEST_MNT/file"
>>   run_check_umount_test_dev
>>   
>>   dump_super() {
>> -	run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$TEST_DEV"
>> +	# In this test, we will dump super block multiple times, while the
>> +	# existing run_check*() helpers will always dump all the output into
>> +	# the log, flooding the log and hide real important info.
>> +	# Thus here we call "btrfs" directly.
>> +	$SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super -f "$TEST_DEV"
>>   }
>>   
>> -# Ensure currently active backup slot is the expected one (slot 3)
>> -backup2_root_ptr=$(dump_super | grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
>> -
>>   main_root_ptr=$(dump_super | awk '/^root\t/{print $2}')
>> +# Grab current fs generation, and it will be used to determine which backup
>> +# slot to use
>> +cur_gen=$(dump_super | grep ^generation | awk '{print $2}')
>> +backup_gen=$(($cur_gen - 1))
>> +
>> +# Grab the slot which matches @backup_gen
>> +found=$(dump_super | grep backup_tree_root | grep -n "gen: $backup_gen")
>>   
>> -if [ "$backup2_root_ptr" -ne "$main_root_ptr" ]; then
>> -	_log "Backup slot 2 not in use, trying slot 3"
>> -	# Or use the next slot in case of free-space-tree
>> -	backup3_root_ptr=$(dump_super | grep -A1 "backup 3" | grep backup_tree_root | awk '{print $2}')
>> -	if [ "$backup3_root_ptr" -ne "$main_root_ptr" ]; then
>> -		_fail "Neither backup slot 2 nor slot 3 are in use"
>> -	fi
>> -	_log "Backup slot 3 in use"
>> +if [ -z "$found" ]; then
>> +	_fail "Unable to find a backup slot with generation $backup_gen"
>>   fi
>>   
>> +slot_num=$(echo $found | cut -f1 -d:)
>> +# To follow the dump-super output, where backup slot starts at 0.
>> +slot_num=$(($slot_num - 1))
>> +
>> +# Save the backup slot info into the log
>> +_log "Backup slot $slot_num will be utilized"
>> +dump_super | grep -A9 "backup $slot_num:" >> "$RESULTS"
> 
> Please don't use the $RESULTS in tests, it's an implementation detail
> and there should always be helpers hiding, in this case it's run_check.

In this particular case, won't run_check dump all the output into the log?

As here we only want the grep result to be output, not the full dump_super.

> 
>> +
>>   run_check "$INTERNAL_BIN/btrfs-corrupt-block" -m $main_root_ptr -f generation "$TEST_DEV"
>                                                      ^^^^^^^^^^^^^^
> 
> Please always quote variables (unless there's a reason not to like for
> $SUDO_HELPER).

Forgot it again, but it should be safe as $main_root_ptr should just be 
a u64 number.

But yeah, I should quote it...

Thanks,
Qu

> 
>>   
>>   # Should fail because the root is corrupted
>> @@ -45,9 +55,10 @@ run_mustfail "Unexpected successful mount" \
>>   run_check_mount_test_dev -o usebackuproot
>>   run_check_umount_test_dev
>>   
>> -# Since we've used backup 1 as the usable root, then backup 2 should have been
>> -# overwritten
>> -main_root_ptr=$(dump_super | grep root | head -n1 | awk '{print $2}')
>> -backup2_new_root_ptr=$(dump_super | grep -A1 "backup 2" | grep backup_tree_root | awk '{print $2}')
>> +main_root_ptr=$(dump_super | awk '/^root\t/{print $2}')
>> +
>> +# The next slot should be overwritten
>> +slot_num=$(( ($slot_num + 1) % 4 ))
>> +backup_new_root_ptr=$(dump_super | grep -A1 "backup $slot_num" | grep backup_tree_root | awk '{print $2}')
>>   
>> -[ "$backup2_root_ptr" -ne "$backup2_new_root_ptr" ] || _fail "Backup 2 not overwritten"
>> +[ "$main_root_ptr" -ne "$backup_new_root_ptr" ] || _fail "Backup 2 not overwritten"
>> -- 
>> 2.33.0
> 

