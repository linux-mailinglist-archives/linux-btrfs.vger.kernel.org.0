Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32E3734B51
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 07:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjFSFVL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 01:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjFSFVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 01:21:10 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2054.outbound.protection.outlook.com [40.107.15.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1439A4
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jun 2023 22:21:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAqCfRMHEZxF6sYFZN9PxWEQ9rt9myp9EAPSZba97WHZH8SKgUjgohilAyE54BSWK9/Rj/xhzT+8BeSdjo9YWVKX+bPDymL8BYhnTQvl7R5742ZFcwTW+MDivCLIDRY44qsC2TVjALRzhWY4hQDJrRn158ze7dBL4s1p5CQ04TCa/6Gmj1+A8yl2DZYTOTzQ38yG4hrUDgSPIbGPpEU6oWV3dw2/NyIGHlFSqnT1RgQz0HrdmJNA97S6UQRt6Vef2wk72+cA8ZL39q5UachtlxE8BSHdb48yDVWZuJbygiKP5mMYMsZ+swUAXWn0wIWSqkOG3C/fU+2z5alMmgISCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1obV/6ZXdNmD2aulgyhdYoVYOtAttzi4H/ttpv+rBU=;
 b=geXTWUf1Lfa7Y69H8Fx75IUMdXXoOBuTb2d6vbmyRKqKirNQa3XAMqsSpOxImSmGj1hWPmYTlMrv+N1H5Aic2i6gmVfuSxs6rPug2awr9WSQHl+kGXzEsh/r4JHqrud2DSyYAr+MO5KtjD1OSYKR1EGhw+YA7DqhgmhoTOP7jq76kfI808RrnOLy+MpvJb+kbod3XuPZDLEj7AuOQtQ+36cdbHN9ZGOyaCW6QT3fo27Weg6jB2WYvkqBuSaka2J1ZiEn8eAdwOaKjm4BPNlWb1M6YGL1gJpQuBoz9GFeP9LWDYs6cTm2VaRM/5/FI6bO14iC8a1In88QJmPMcd0MMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1obV/6ZXdNmD2aulgyhdYoVYOtAttzi4H/ttpv+rBU=;
 b=eD2fRX7Blo05QIHCATzP3ltfWyz3WmQ/khUnegOVWGu/42lwBkAzJFoIGJZpSRWHaeYHyiYSyicCBDfA969JrAgT30OKe2xzara9eW7QGB1ezoSYv+75yrgMG/a5envjQO3tB3HG8K4HBzx+CFSR3BtsBmkOK6fJUmx0tU407Jfr7JzoHzJkj9KDqbxw83R/wgxdHeb7qYku+Su6KTGLB8wMw0zNPThCzu9SrZfcWm0FKPYNsNw0ULD5oM7Cniuj/PyPLQIVRLOQzVxSOriPVrlllW3plmUr2W6/9HVwSy3onVen80cYUC7uQyDxM0sYgJdwYiTYDoOe5C7DcKWB9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB7725.eurprd04.prod.outlook.com (2603:10a6:102:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 05:21:03 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7b80:d77b:1fc5:2ba2%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 05:21:03 +0000
Message-ID: <2c4be178-deb3-cacb-92f4-7fa3eb17a137@suse.com>
Date:   Mon, 19 Jun 2023 13:20:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btrfs: add trace events for bio split at storage layer
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
References: <dd9a8794a1da2a4f3e7c47cc4df42ef972568ce4.1687133480.git.wqu@suse.com>
 <dlewtrufotjdnlj5bszhj4aj7a3exk7ag5dbm3f4e3z3mjbj7w@7r4c746p5suo>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <dlewtrufotjdnlj5bszhj4aj7a3exk7ag5dbm3f4e3z3mjbj7w@7r4c746p5suo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYBP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::19) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: c3091396-fc74-4dd3-6ad6-08db7084f9ad
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EaI8D1aTGHTJibTNSpfAE9JMM/QSSGUbnBy6yQbruqK2ze/Rt73Zbl1tSqq1vFPyAwsKUC8qAobZzunGeTNvYMiJSi6BSt0B5CwxyeVJJcr5Iu0YdRaainfCiJz13/iC8RoaGD7Jbymg7YTU2R9kMOU681TRrmxlVxV33M5nd198e+lS7w9qc1khVUsQwB4wqTLAj7BbBxnlIHdf/RMzL555Y4JUNVvIXT2yylIZ8ZB98A1NKiK4I5hSK6LAjP4jfbUb5StebkHAqV/j9KuTezk/dr+tD7EfswnAI+KzShQfnFU7z79QKIXhJOtTSYSGQN17jxCjvCybweQrOesyDsyVuUit7XKuDP49HLzbIcyxX8vU3WmfA+m7g6ofeL7+18DnivWuyriAAuzlbjUNs7jRcxTDIPxrY0DF3/nfuFcahMCeRVO/ebvivnn/ZhF26J4CeccMlSgf8EEsvCUMOd5IZ4CigSD+/k6Vbkjpeln4v2L6/vj+5sqTXaJ+tQVKNj0AizY1s/yH1AqiqJ9qhPo09R+Bj0pQSCdJh61G8qKG8PBv7i28HNwrWO6K6hW6ZnYv2nOMg6bnL5whJuvzbezwy4AY3bUPI0co29iWNrbAZ5ktNgiKmN/3GNHiN15p/3xR8Wt/ETFHXWnbkpbCjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(478600001)(4326008)(54906003)(6512007)(186003)(36756003)(6506007)(53546011)(107886003)(6486002)(6666004)(2906002)(8676002)(8936002)(41300700001)(66946007)(66556008)(66476007)(6916009)(316002)(5660300002)(31696002)(86362001)(83380400001)(38100700002)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm8vK3hZZFkxRmJpQkllOE83Ri9Za1Y0WktPaUNXYjdCTHV1RkZzS0oreVNR?=
 =?utf-8?B?MTZqdVYwaWNtakFRWFNtR3FJT3lFZEpHL2lNRVM1eTExUzd5b1pQaHA3dlRR?=
 =?utf-8?B?RnRJTmlpRFh6djBxRzEvU0xQNDRzNU4vbGNlakRqenBNKzlRSGh3cGh6L0hv?=
 =?utf-8?B?VVBhWDNNZTUxaGhYRFFHbVYxVktYMVdlUllpckVHeXZDOWh0b1ZHam4vYmR2?=
 =?utf-8?B?QUl4RWRlU1IzZFZsajUvckhieGZNbVdkY0xMZWNvUTRGVjBERVYxV083cWpE?=
 =?utf-8?B?RkVYRFZrNEFmQWtqMkZST3lCdXMra25qaDFHdCtWUlJQQnNCU21BNXZlZ1Ft?=
 =?utf-8?B?eWRzQkltcUQ1K2JVQjcrOE4wRkM1bi9IY2VOVFpXdURBN2dzby9UaTlIVHhV?=
 =?utf-8?B?ZDhibkxmSDJSeUtWSXdTZ1JOczZlVllGd0U2eEVDMzYzVHBwcDN2ZkMxOEFQ?=
 =?utf-8?B?Vm9TbEN5NjExZTFqdStpWDMzZ0I3dVZQV1pxQlJScGpBeitqSWx5OXlWMzhi?=
 =?utf-8?B?UG41YzhaUFR3TWJuYlhXUFBLZDlpWHM1Z2oyMWlYQjQ3dWRjbGUrNU51TUxU?=
 =?utf-8?B?cENhbUlHdnJESjdtbjE5UHFDcmg5NGt6aTI4SGVyTGtqN0V6SEZmRi9hcEdv?=
 =?utf-8?B?OThZQlNoUVp3djcveWZVY1Q4cDhROEt4aE1WajJNVFl5SU13dllUWEVLVlJu?=
 =?utf-8?B?QVJlcHl6by9OaFVncXdhOWYwM3p5WnFxRVBiQXRpYm5GOU1McVV5VmdYTllD?=
 =?utf-8?B?ekJZaVpxMUJWbVdJaUt4MUc1b2p4RnNDWk8zSnBzMEpyZGlVZ3lxTlU0WElZ?=
 =?utf-8?B?eERLU2crSHZmQVBaOFVBK09qZHZpV0FaUnJGVWpxYUxzSW1GYnZGU3R1ZXVO?=
 =?utf-8?B?dTJ5SDZwY1gxSFhhNFNHS1ZFQWQvQTR2NmNNN1pVWnhvbW1iNHFacHNIVG9T?=
 =?utf-8?B?M2hXeG9qR0w1K0FlbnNKdkdTN2cvcVVld3VJanRmOCtKMTRHbDVhSktIL25Z?=
 =?utf-8?B?SXIyZDhmdFJSTkV5d1RQSm9zTVAxNUV4UFUvN3lmUmtBSGZ6QWJqQlR5ZGhn?=
 =?utf-8?B?MFVkM1dqRGpyNTlMenJrZG5qcEwxRDJjeHpGZ3V2ZW9FSVV1WEFRN3lsR1JP?=
 =?utf-8?B?QlNaSHZQU3JIc2NXakZaRkpaaHdSUWxzVkY3OVlLMFVNQUpxTDJ3Y0ExRGQz?=
 =?utf-8?B?di9XRGhwaDdvY3Z1RElIN3UzemhlcmJMajN6SVRTRERjOXVaOGRoZ1BxVEJ4?=
 =?utf-8?B?cGlTeEVqNnI2VjgxdGFxdUd6a2ZXL01VcmlUU05RNitUSFFadzNvenlaV0Fn?=
 =?utf-8?B?bi9VMWtYU0pMRHpwVjhyUGlDczA0WFVvTlVMT3FmRzZ6RnhOTEpDRjZldzZO?=
 =?utf-8?B?cG12Ynp4QStTWE5JdFl0dm9WVXVsSnVXcFpteXBhSEl2RWFMeTdCZ3M2MVhY?=
 =?utf-8?B?cW5BRGlWWHZxb3FUb3F4UlpueEg3RFV6T3kwaEhOS295RXVFNlJtNWhFekk2?=
 =?utf-8?B?MEJLRDUzSjg5aWdjYzRLcnhFdW44ZVZzc2hwVzdDNHQxSEQ1endIZGlyN2Ft?=
 =?utf-8?B?SzErL29XTS8zQWhrNE9IeG9aTUk5RlJyZ2hNeVBmZk9uRE9pVmJKRjUrVGoy?=
 =?utf-8?B?eVVLTGNoU0dINU8wbXZSWGdWUFdxYWlQQ0RSVmh0dytYNVNyVzhHaGkrMC9v?=
 =?utf-8?B?dGhpU1U1WmxsUGVHVTBVWFgwbzJuc3FHZUpFeVh2NXF3RTlZZTE0UjBWVlBx?=
 =?utf-8?B?MmR2a2tqdkVxS2kxRVRSUmllRlNjRlRLUTh0WmlsTldOZmI3dVVoZkx1Z2ZR?=
 =?utf-8?B?d3JJVjZQSWY0MlloTnRQV2MwclQzeGxLa2pOWWtYdWR4dW41RnZ2Wmh5b1N5?=
 =?utf-8?B?cmFHcUF2cHh6SnVGOXZhRWoyemRpbWxuaW5RRUJpY21xTHFTV0txS1ZDZ0tq?=
 =?utf-8?B?L1pyaDdtam1ZVnVDalBtdHVYc05mZHgyR3V5RGd3cWJueXlTSEt4TzEvbTBp?=
 =?utf-8?B?SHJuQyswTDFRd2JpTElRRUc4aWlOVUJUOTI4SDB4cUFPOUc1UzJBUEdxVWxZ?=
 =?utf-8?B?eFRkek9HVkR4Q2lmNFEzdnYwU0JiWHV6MkZ2b1V4SkdiWW1wQWlhaWh1QmNp?=
 =?utf-8?Q?mpp7jRloKCAtG4+hrXywrdy2D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3091396-fc74-4dd3-6ad6-08db7084f9ad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 05:21:03.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhhZJ8kJ5+DXjWStukUmfR1Ch+och2AhzLJRnAdp4ztXbBVGanGH9U3PDzkwwo9C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7725
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/19 12:15, Naohiro Aota wrote:
> On Mon, Jun 19, 2023 at 08:11:37AM +0800, Qu Wenruo wrote:
>> [BACKGROUND]
>> David recently reported some weird RAID56 errors where huge btrfs bio
>> (tens of MiBs) is directly passed to RAID56 path, without proper bio
>> split.
>>
>> To my surprise, there is no trace events around the bio split code of
>> storage layer.
>>
>> [NEW TRACE EVENTS]
>> This patch would add 3 new trace events:
>>
>> - trace_initial_bbio()
>> - trace_before_split_bbio()
>> - trace_after_split_bbio()
>>
>> The example output would look like the following (headers and uuid
>> removed):
>>
>>      initial_bbio: root=5 ino=257 logical=389152768 length=524288 opf=0x1 mirror_num=0 map_length=-1
>>      before_split_bbio: root=5 ino=257 logical=389152768 length=524288 opf=0x1 mirror_num=0 map_length=131072
>>      after_split_bbio: root=5 ino=257 logical=389152768 length=131072 opf=0x1 mirror_num=0 map_length=131072
>>      before_split_bbio: root=5 ino=257 logical=389283840 length=393216 opf=0x1 mirror_num=0 map_length=131072
>>      after_split_bbio: root=5 ino=257 logical=389283840 length=131072 opf=0x1 mirror_num=0 map_length=131072
>>      before_split_bbio: root=5 ino=257 logical=389414912 length=262144 opf=0x1 mirror_num=0 map_length=131072
>>      after_split_bbio: root=5 ino=257 logical=389414912 length=131072 opf=0x1 mirror_num=0 map_length=131072
>>      before_split_bbio: root=5 ino=257 logical=389545984 length=131072 opf=0x1 mirror_num=0 map_length=131072
>>
>> The above lines show a 512K bbio submitted, then it got split by each
>> 128K boundary (this is a 3 disks RAID5).
>>
>>      initial_bbio: root=1 ino=1 logical=30441472 length=16384 opf=0x1 mirror_num=0 map_length=-1
>>      before_split_bbio: root=1 ino=1 logical=30441472 length=16384 opf=0x1 mirror_num=0 map_length=16384
>>      initial_bbio: root=1 ino=1 logical=30457856 length=16384 opf=0x1 mirror_num=0 map_length=-1
>>      before_split_bbio: root=1 ino=1 logical=30457856 length=16384 opf=0x1 mirror_num=0 map_length=16384
>>
>> And the above lines are metadata writes which didn't need to be split at
>> all.
>>
>> These new events should allow us to debug bio split related problems
>> easier.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/bio.c               |  4 +++
>>   include/trace/events/btrfs.h | 51 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 55 insertions(+)
>>
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index 12b12443efaa..204c30391086 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> @@ -669,9 +669,12 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>>   	if (use_append)
>>   		map_length = min(map_length, fs_info->max_zone_append_size);
>>   
>> +	trace_before_split_bbio(bbio, mirror_num, map_length);
>> +
>>   	if (map_length < length) {
>>   		bbio = btrfs_split_bio(fs_info, bbio, map_length, use_append);
>>   		bio = &bbio->bio;
>> +		trace_after_split_bbio(bbio, mirror_num, map_length);
>>   	}
>>   
>>   	/*
>> @@ -731,6 +734,7 @@ void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num)
>>   	/* If bbio->inode is not populated, its file_offset must be 0. */
>>   	ASSERT(bbio->inode || bbio->file_offset == 0);
>>   
>> +	trace_initial_bbio(bbio, mirror_num, -1);
>>   	while (!btrfs_submit_chunk(bbio, mirror_num))
>>   		;
>>   }
>> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
>> index c6eee9b414cf..1e6d87abd677 100644
>> --- a/include/trace/events/btrfs.h
>> +++ b/include/trace/events/btrfs.h
>> @@ -31,6 +31,7 @@ struct extent_io_tree;
>>   struct prelim_ref;
>>   struct btrfs_space_info;
>>   struct btrfs_raid_bio;
>> +struct btrfs_bio;
>>   struct raid56_bio_trace_info;
>>   struct find_free_extent_ctl;
>>   
>> @@ -2521,6 +2522,56 @@ DEFINE_EVENT(btrfs_raid56_bio, raid56_scrub_read_recover,
>>   	TP_ARGS(rbio, bio, trace_info)
>>   );
>>   
>> +DECLARE_EVENT_CLASS(btrfs_bio,
>> +
>> +	TP_PROTO(const struct btrfs_bio *bbio, int mirror_num, u64 map_length),
>> +
>> +	TP_ARGS(bbio, mirror_num, map_length),
>> +
>> +	TP_STRUCT__entry_btrfs(
>> +		__field(	u64,	logical		)
>> +		__field(	u64,	root		)
>> +		__field(	u64,	ino		)
>> +		__field(	s64,	map_length	)
>> +		__field(	u32,	length		)
>> +		__field(	int,	mirror_num	)
>> +		__field(	u8,	opf		)
>> +	),
>> +
>> +	TP_fast_assign_btrfs(bbio->fs_info,
>> +		__entry->logical	= bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
>> +		__entry->length		= bbio->bio.bi_iter.bi_size;
>> +		__entry->map_length	= map_length;
>> +		__entry->mirror_num	= mirror_num;
>> +		__entry->opf		= bio_op(&bbio->bio);
>> +		__entry->root		= bbio->inode ?
>> +					  bbio->inode->root->root_key.objectid : 0;
> 
> Can't we use show_root_type() here?

Good idea! Would go that way in the next update.

Thanks,
Qu
> 
> Other than that, looks good to me.
> 
> Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
