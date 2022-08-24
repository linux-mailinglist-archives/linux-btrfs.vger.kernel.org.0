Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230AC59F83E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 12:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiHXK6H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 06:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiHXK6B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 06:58:01 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1252D66A54
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 03:57:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=du/cN4onSGliotsuqOTW1CIefICOxaGCGYu29NHG+c8S3cEGp09I6eSO9rjItUE2ALAtlHgmJhHEEtOK7AhA1+roNZDPEr2XihiWydyjVcOt5eL4L7JpiLFrF+q8Owob6u4JpHyPWFGy80EatvUxiEyykoQhLzrnsLvYP0Abd9q2YFAMRDQs2OUGzeF9ROVvOjBm8YMFE57j3i55kb1Iq1DukbQafd8OcDX3Qr3P7p2Fze4oAJcg9ZZmhW3tZvb5yFM0QnOo8UxgsZ73w8x5MYZE9nn14gpNNmpp5mM7VR03Wbv68Kkrc6dcA0rI6/YCmCWj5YHDnBK7J5SipbZ80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avs517xdVg6fLt9XXiCLE9yE6OIlru0oHhdirLFX1zw=;
 b=cA2wc119E4dL+9zxxesuw4w1zouRkIwgjfPdpEqtjlfYNkBUiZeJ2IUkWPQuzmKLfvGp6VTvHNzLGl6OCggM65x8c1wObrunckoVS3bzxT2Za9NewpuVBmHc1v4vl3QubBV7D7MPD3V9M5KeRSJ/PTIBR7fFpTLtMtZcTMZZx9S2+Q/wSR7BDZ/AfiHwWGyW15v8U6940200CxWj/70S48eTgTKWlKGoYKipzDjN/9U2QmQVOk/o3SEc4rgSpdKblm1Hrlq5fUdhx53cs0p5J00OOc2/ChQzsG7EjitwqVlYulC2PVFT4mV3ivfefSvNyUn7Pi2a1ROnPRFboF60AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avs517xdVg6fLt9XXiCLE9yE6OIlru0oHhdirLFX1zw=;
 b=iGqlSWmDXXw5RYC12Bbo91HF4RdJavJCOlByiUAAKIcSRSbGSfGB1hN9GWiWv3m8o1L0BUCFuDmVGEs7riNuxqQ1pDGMi+/z74h/1SUP1N4QLjDhJIDNbvTwUyrG2CGyVZimZgqpb+GLC1jX8Y9C/a+/rm7S8EDR3J9m9M0DKodPhCV5uQdV0S1QOb+69dGtzWOaQFIasKEoVSQgHVVloJ7KqHyc7Mgvm10eLfDkkC8od/94k0u5OaS/nyZpgKc6apWRYXuEtAZH5pkFhGk/Xz0sPop7LoqPaWcLTFIDRCuVwSsFZQ1ejRM+mTX2RTPGTdaiuazZsz/ZuggStH+3YA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM0PR0402MB3540.eurprd04.prod.outlook.com (2603:10a6:208:25::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Wed, 24 Aug
 2022 10:57:56 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::987c:9190:1b0:f3ab]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::987c:9190:1b0:f3ab%7]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 10:57:56 +0000
Message-ID: <05a3e4e0-54e7-1453-8b73-5457fa19bd49@suse.com>
Date:   Wed, 24 Aug 2022 18:57:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] btrfs: check the superblock to ensure the fs is not
 modified at thaw time
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@libero.it>
References: <8032f0bba42927fb4d87909060e03a647bb60c32.1660200417.git.wqu@suse.com>
 <b90a8c51-8ae2-5b65-7514-3c17ef34fc4b@oracle.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <b90a8c51-8ae2-5b65-7514-3c17ef34fc4b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:a03:117::38) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43bf36eb-dc39-447c-bde1-08da85bf8033
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3540:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tV8cO3g2W/SpPFrWia+UpsOsqCI+S2hESBnc4nW3Qoik64wsZdO77Ryg6aZXAAkz1ljvZShWqrQeRjWQSwJ6zLd8QXQSWWs38c0SQaStWpReyRaJu83BnxpTubTp5InRSbWVujGpiXKHuidKco4UGKB9DkSzJ56JuUj4yCv6tg7q+U4KOhmQ2BFNIZf4PM4jKrSxQOpMkL++o/ajATC85Cz/Bj4gyz9zFsbSbubZcZH/STOMlbUmHwNww1aJQt8NlBmlvIRSzsg8ptC5VGrrRZ/oagIqShq5HdJ2O6cdF6occM+HKDwUJtETNWAD70YXOglPgSqgJ+7eQKBgyAAbUGVK9LhxE9m/lHG0zrMzckRdSls1krq/Cst5QsAqzbNTfEUMoD7b4JL3RiVJaK3ElCQc08CnMykHsbCu6bwcBqgzPRRNNsWQRfwrbox8fejfnLmYnEKbTmv/9bUHkIhuZIKbN1mQPUPLQ/LiIDLy5aA3EaUu1cu4rcL6tHdTMihVNsHKaF86FT/jBk5gXM1v2RaXU0Znu1e6zO2vEjlb9F+SgzCwE+NljCW/sVzfDJ3rNQGcXnVF8E3O3dc/ao51XMj85/N+zhDIXWG5nNgbCwb5vp+vhkXOY+sp1L18phM5QXm9CA8/qyf1wOP+iXWO6uCi3FWYSYlKuQR+6HRTsoXaJuS+33lnczBEVUbPGhseX+mSMCjZNFziq9y1hXAcKmJEJbP4PJXkxfv5cT2RN24YB149s7oOk0+KCz2rNOdGtHjlo3d1c9KcvaI4OUH+9QXSws9X933uyM+uLhySs70qsY24DiUhFHbuT9uYkY0/XbYzLsjPBzQfaOHNAdxZrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(39860400002)(376002)(36756003)(4326008)(66946007)(5660300002)(31686004)(66556008)(8676002)(2906002)(66476007)(316002)(6506007)(41300700001)(478600001)(6486002)(6512007)(6666004)(966005)(53546011)(38100700002)(186003)(31696002)(86362001)(83380400001)(2616005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THJMTExLTjZSTjJBZE1zOWRkZmE2eE13eW5xeDZ4Tlh6OVZ5aDZSYmo2ejhC?=
 =?utf-8?B?aVJDTVBEdmtMcWVkRitpdDdjTTB2d05Cb0JvT1M3Y0w1V0hsNFZkeHhHcm9F?=
 =?utf-8?B?ZXlLU3ZFaTJMdEZWVVppZCtTZ3dnNWNweWRWdkFPWVByVDVaSm9GUGV6aGts?=
 =?utf-8?B?bXRGdmcvYjlMTHljWUNBWCtmTmV5VE10aGZVeEREMXdYN2hJVlhDOHNKeDkw?=
 =?utf-8?B?ajNWRUNtbnc4aDNRMktNbFY2TExsZHpuRDlLQ0JGS3dDUEZmOTlWTVFyUmV3?=
 =?utf-8?B?Z0NjUVpyNklQUlZFL2lZU01BNFFJcXdIcXpsSjYzbzVja1dTc2VjL3Y4R3pS?=
 =?utf-8?B?OHlMSFRadUZNc1ZzTU1xMUFoNDB1dzE5ZThHRUZGM0JpaDd0T084WjFEL1ZK?=
 =?utf-8?B?UldSdGN2UUhBbXM3UDVJWVdpYVRmQVlMdkVFNkZNUnRMSlhNYVdWQVdnUE55?=
 =?utf-8?B?NVVmTTg0VGtEQ0x5NTcyeXYvbVNmblZReGR2b3V4Vkx2UDRJV0FpemRDMlAr?=
 =?utf-8?B?L3RDRnY5bTRXR3VyMUFOTENOaTkxU3BXRHlHaWV4WVBabDBIZm1nNkFTanFQ?=
 =?utf-8?B?UXZJdkJkaHlIMzNtcUgzUzFWTjJnK2ZGc0ZRZUsyOWlXSHBCRmJIdE5PR3Z0?=
 =?utf-8?B?aWVsQW1vRW5PUzAzVTRBbUFuRituZlhKZ1JNdHREKytHVW5iVCtRV2FMT1FV?=
 =?utf-8?B?M28rKzhoWkZGUzFqdlF5UlJxMEIrQVJpOW9GMUVUQkVNU0MzT2E5NVJibmZX?=
 =?utf-8?B?Q2E4NytxWnhHM1B5bElubERScmk3U3R1N1A3bVl4K1l4dWJTVEFlVXZrNk9G?=
 =?utf-8?B?TWcyNWpNS0JVbnpoYVNEdFM1ZkNPb2MwRW1hV250WEZZb0JCdVFaVlNaK2pj?=
 =?utf-8?B?a21PRmg0RldEcGdMdi8yeUZqWXo2MDQrZXZyVm9qNmsxVGR3Mjhxc2RUUldB?=
 =?utf-8?B?SitiU1dteFZJYVpESVMvalp3ZFByUWVPZ3RncWxRRDJUdkpPaUtLeStlbmFQ?=
 =?utf-8?B?Qkl5MmxVaVZXd1lNcXFMR2dTYXAyN3JSZ1VxZUxMNGhUY1QxcEtjWnZLRlhZ?=
 =?utf-8?B?SjNZNGFSU2pIVTZXSzhHK0dpeFA3eUtoUmhJMmdmaFA3NEJMVnhnSzRXOGVi?=
 =?utf-8?B?ZmhxWVhaNE9FejFoRTBTN24vVHdmSWtmbUtaRHRqYWhjMEt1QjFibGoveFk5?=
 =?utf-8?B?NXorbzc0L2dFQTFDczIrMi9jUGVJd3o5WHRPeEJGdFg5SmRLNXB2K1lQRE5U?=
 =?utf-8?B?V2JoQnVibjQ3amRkdzNjWUozK2lZdUprVE1ybnpjTFc2aVpwN1ltWjNtekFN?=
 =?utf-8?B?Q1NNdkFHWFNCeXorZ04wZXgzK05rRUtsZFpLeVBkV2dNdGN1Snc0UlFVWFdv?=
 =?utf-8?B?YzBCS0wzQll4c3Y5dVhFTVg0bmdtVWlxTVByNlZOMVNsMFhWWTB6bUlwUUhU?=
 =?utf-8?B?WjBGRGk5SlJOREEwSXJROStDcmM4ejFsTGhzMHNxK0d3WWcxajN0YjVkTUdh?=
 =?utf-8?B?ZUF1WUxLVDdYNmVuWWd2MWNOOWFLb1ZWTWI3SlVteUxLRmFCc3JVNEt4TnEr?=
 =?utf-8?B?Mng4ZDFxc3VBaEc5KzBReFdjUXJtTnB3YnZUbGNqdmhXYk5EcmIxdWJ5NzJn?=
 =?utf-8?B?VUhFWkx3cFExdmJNZHAyQUF0Z3dkek1GdjNzL1F1NkQ2b3dnam1wd0tIS0t3?=
 =?utf-8?B?SisvVE9wQy9NZmF5ZVNFaDU0QmwxaE1iWnlVL0JJeHhUNWZNbEFyQWtuMGdq?=
 =?utf-8?B?elVwenpSa2ZDMkNGMUk0RG40WE56dVVIcTN0Njg0cTQrUnd3UW1XNWRkWUNi?=
 =?utf-8?B?WHc4S0tqVTJ2YnpTdzREc2Z6N1FxWkFCb1cwY3ZXSHAzanhzZWk0WkNUOStl?=
 =?utf-8?B?dFI0UEFmZ2x2bnY3cWpDcSt5UGhjNjlPdi9sdW9xWGppY3RnRnUybHhxUG0v?=
 =?utf-8?B?QVNiM1lHTzFLNndkYTFzNlFLYWt4blQrdGZOTmZENWVSYXA1T1RVaFRCbnVZ?=
 =?utf-8?B?cUZsRVVuaUp1SGNCVDlYZEhkUGpUdHNrTDVqakZYWkhPNEE4Mzg3Q1laMkxD?=
 =?utf-8?B?ZEN3b3ZEcHJRYTRHM2lLNmFaSEVZU0pWcFQ0V2trMmRYTWxVTWtzWTUvNkM0?=
 =?utf-8?B?Z2RQOEhQUFNORi8vQnJja1RaY1F2aWNQZm9pWDBjYmtEY29ZM25EVmJNeTJB?=
 =?utf-8?Q?jFsT0FScRxI7H4hORq42Ml0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bf36eb-dc39-447c-bde1-08da85bf8033
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 10:57:56.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgNeXcE0UpIONNR0Abn3XY3OALBDALtv4hqJQXqp7HMoSZd9hPVHXNRjI1NjxsKT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3540
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/24 18:13, Anand Jain wrote:
> On 11/08/2022 14:47, Qu Wenruo wrote:
>> [BACKGROUND]
>> There is an incident report that, one user hibernated the system, with
>> one btrfs on removable device still mounted.
>>
>> Then by some incident, the btrfs got mounted and modified by another
>> system/OS, then back to the hibernated system.
>>
>> After resuming from the hibernation, new write happened into the 
>> victim btrfs.
>>
>> Now the fs is completely broken, since the underlying btrfs is no longer
>> the same one before the hibernation, and the user lost their data due to
>> various transid mismatch.
>>
>> [REPRODUCER]
>> We can emulate the situation using the following small script:
>>
>>   truncate -s 1G $dev
>>   mkfs.btrfs -f $dev
>>   mount $dev $mnt
>>   fsstress -w -d $mnt -n 500
>>   sync
>>   xfs_freeze -f $mnt
>>   cp $dev $dev.backup
>>
>>   # There is no way to mount the same cloned fs on the same system,
>>   # as the conflicting fsid will be rejected by btrfs.
>>   # Thus here we have to wipe the fs using a different btrfs.
>>   mkfs.btrfs -f $dev.backup
>>
>>   dd if=$dev.backup of=$dev bs=1M
>>   xfs_freeze -u $mnt
>>   fsstress -w -d $mnt -n 20
>>   umount $mnt
>>   btrfs check $dev
>>
>> The final fsck will fail due to some tree blocks has incorrect fsid.
>>
>> This is enough to emulate the problem hit by the unfortunate user.
>>
>> [ENHANCEMENT]
>> Although such case should not be that common, it can still happen from
>> time to time.
>>
>>  From the view of btrfs, we can detect any unexpected super block change,
>> and if there is any unexpected change, we just mark the fs RO, and thaw
>> the fs.
>>
>> By this we can limit the damage to minimal, and I hope no one would lose
>> their data by this anymore.
>>
>> Suggested-by: Goffredo Baroncelli <kreijack@libero.it>
>> Link: 
>> https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com/ 
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Remove one unrelated debug pr_info()
>> - Slightly re-word some comments
>> - Add suggested-by tag
>> ---
>>   fs/btrfs/disk-io.c |  9 +++++--
>>   fs/btrfs/disk-io.h |  2 +-
>>   fs/btrfs/super.c   | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/volumes.c |  2 +-
>>   4 files changed, 67 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 6268dafeeb2d..7d99c42bdc51 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3849,7 +3849,7 @@ static void btrfs_end_super_write(struct bio *bio)
>>   }
>>   struct btrfs_super_block *btrfs_read_dev_one_super(struct 
>> block_device *bdev,
>> -                           int copy_num)
>> +                           int copy_num, bool drop_cache)
>>   {
>>       struct btrfs_super_block *super;
>>       struct page *page;
>> @@ -3867,6 +3867,11 @@ struct btrfs_super_block 
>> *btrfs_read_dev_one_super(struct block_device *bdev,
>>       if (bytenr + BTRFS_SUPER_INFO_SIZE >= bdev_nr_bytes(bdev))
>>           return ERR_PTR(-EINVAL);
>> +    if (drop_cache)
> 
> 
>> +        truncate_inode_pages_range(bdev->bd_inode->i_mapping,
>> +                round_down(bytenr, PAGE_SIZE),
>> +                round_up(bytenr + BTRFS_SUPER_INFO_SIZE,
>> +                     PAGE_SIZE) - 1);
> 
> The 3rd argument is the offset to which to truncate (inclusive), and it
> looks correct.
> 
> 
>>       page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, 
>> GFP_NOFS);
>>       if (IS_ERR(page))
>>           return ERR_CAST(page);
>> @@ -3898,7 +3903,7 @@ struct btrfs_super_block 
>> *btrfs_read_dev_super(struct block_device *bdev)
>>        * later supers, using BTRFS_SUPER_MIRROR_MAX instead
>>        */
>>       for (i = 0; i < 1; i++) {
>> -        super = btrfs_read_dev_one_super(bdev, i);
>> +        super = btrfs_read_dev_one_super(bdev, i, false);
>>           if (IS_ERR(super))
>>               continue;
>> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
>> index 47ad8e0a2d33..d0946f502f62 100644
>> --- a/fs/btrfs/disk-io.h
>> +++ b/fs/btrfs/disk-io.h
>> @@ -49,7 +49,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info);
>>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
>>   struct btrfs_super_block *btrfs_read_dev_super(struct block_device 
>> *bdev);
>>   struct btrfs_super_block *btrfs_read_dev_one_super(struct 
>> block_device *bdev,
>> -                           int copy_num);
>> +                           int copy_num, bool drop_cache);
>>   int btrfs_commit_super(struct btrfs_fs_info *fs_info);
>>   struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
>>                       struct btrfs_key *key);
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index 4c7089b1681b..913b951981a9 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -2548,11 +2548,69 @@ static int btrfs_freeze(struct super_block *sb)
>>       return btrfs_commit_transaction(trans);
>>   }
>> +static int check_dev_super(struct btrfs_device *dev)
>> +{
>> +    struct btrfs_fs_info *fs_info = dev->fs_info;
>> +    struct btrfs_super_block *sb;
>> +    int ret = 0;
>> +
>> +    /* This should be called with fs still frozen. */
>> +    ASSERT(test_bit(BTRFS_FS_FROZEN, &fs_info->flags));
>> +
>> +    /* Missing dev,  no need to check. */
>> +    if (!dev->bdev)
>> +        return 0;
>> +
>> +    /* Only need to check the primary super block. */
>> +    sb = btrfs_read_dev_one_super(dev->bdev, 0, true);
>> +    if (IS_ERR(sb))
>> +        return PTR_ERR(sb);
>> +
> 
>> +    if (memcmp(sb->fsid, dev->fs_devices->fsid, BTRFS_FSID_SIZE)) {
>> +        btrfs_err(fs_info, "fsid doesn't match, has %pU expect %pU",
>> +              sb->fsid, dev->fs_devices->fsid);
>> +        ret = -EUCLEAN;
>> +        goto out;
>> +    }
> 
>   Just a fallthrough is fine.

If the fsid is changed, the generation check are almost ensured to fail.

Thus I don't think we should even try continue checking.

> 
>> +    if (btrfs_super_generation(sb) != fs_info->last_trans_committed) {
>> +        btrfs_err(fs_info, "transid mismatch, has %llu expect %llu",
>> +            btrfs_super_generation(sb),
>> +            fs_info->last_trans_committed);
>> +        ret = -EUCLEAN;
>> +        goto out;
>> +    }
> 
>   Here also. >
>> +out:
> 
>   And the out label can be removed.

As David mentioned, we may want to do a full super block check,
and as I mentioned above, I don't think any failed check should continue 
the verification, thus I'm afraid I would keep the tag.

> 
>> +    btrfs_release_disk_super(sb);
>> +    return ret;
>> +}
>> +
>>   static int btrfs_unfreeze(struct super_block *sb)
>>   {
>>       struct btrfs_fs_info *fs_info = btrfs_sb(sb);
>> +    struct btrfs_device *device;
>> +    int ret = 0;
> 
> 
>> +    /*
>> +     * Make sure the fs is not changed by accident (like hibernation 
>> then
>> +     * modified by other OS).
>> +     * If we found anything wrong, we mark the fs error immediately.
>> +     */
>> +    list_for_each_entry(device, &fs_info->fs_devices->devices, 
>> dev_list) {
>> +        ret = check_dev_super(device);
>> +        if (ret < 0) {
>> +            btrfs_handle_fs_error(fs_info, ret,
>> +                "filesystem got modified unexpectedly");
> 
> 
>   btrfs_read_dev_one_super() may return -EINVAL and the error log will
>   miss lead.

In that case, it still means the fs is incorrect.

Unless we have some unexposed bugs, shouldn't every super block, which 
we committed to disk, is valid?

> 
>> +            break;
>> +        }
>> +    }
> 
>   I checked if device_list_mutex is required, but as we are in a frozen
>   state, you are correct no device_list_mutex is required here.

I can definitely add a comment for this.

Thanks,
Qu

> 
> 
> Thanks, Anand
> 
>>       clear_bit(BTRFS_FS_FROZEN, &fs_info->flags);
>> +
>> +    /*
>> +     * We still return 0, to allow VFS layer to unfreeze the fs even 
>> above
>> +     * checks failed. Since the fs is either fine or RO, we're safe to
>> +     * continue, without causing further damage.
>> +     */
>>       return 0;
>>   }
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 8c64dda69404..a02066ae5812 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2017,7 +2017,7 @@ void btrfs_scratch_superblocks(struct 
>> btrfs_fs_info *fs_info,
>>           struct page *page;
>>           int ret;
>> -        disk_super = btrfs_read_dev_one_super(bdev, copy_num);
>> +        disk_super = btrfs_read_dev_one_super(bdev, copy_num, false);
>>           if (IS_ERR(disk_super))
>>               continue;
> 
