Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF975568252
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 11:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiGFJA6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 05:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiGFJAv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 05:00:51 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150072.outbound.protection.outlook.com [40.107.15.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A7218342
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 02:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM/d8B0y7aW0UDP2B/5BfBChiuPcyb3AmjVvWbcfH6lq0JcrcIXxibgOb/yDSGCVo51wGuvslDitNTEyl6NKCDX8fpOROt9elbTL+9CYouk/AXIKQNcHTrVBzlXPhs4AMhTAyE5iZiIaUTHb24leMewDmVWJNwOQMMLB0kGM6m8caQNDJrULaFC5BXxs1+vouf6XByFKN7SnEKOmx57lXyMWa/3diL0eW3RGiLcoPakEwAcT1/gzQclc6Rfl9fgm/dPYZUc80ehXlQfVH+PwgB6Chz0UoB8e1sAxd1GspczEiNoT1LjII7u2D1e2Wq2hOA0mGhf8WzaYbRCiTKeTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFxCEJjHca3gKQZzb4UP2Ddu8/AoRCj3VhQK795jSRw=;
 b=bg9vPPCaA4CunpZ+ZD6CZRD25IPDsQKQN4tURKXDEZoUOy/IL1AQoVknx/UMYYnlo6ZomU0j4QvG785Q9swm70uEdLGg0GlSauMr5Dm16iwvHgd6YePd0tlEXDypeZK2rxQRfLQgDtizjarcoDcM2yNIyS7a3Ri+2dKe4Gmd8gHjZNZuDrUBEJiy7HPbBAdAgGQPSiU3JhcAv0wbUb3qhnerdyl+mgM5TCBWO7Ssy82lXBtW4eD+X5F19ajG7KQRx9RFG5MXL2YyYW5cSGUDCy/K+agQuizPIRxaTL/yPFabA6tjl/ZCyNs+8bR6Y9cxhejcB9OoVX4PDqKVVCgZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFxCEJjHca3gKQZzb4UP2Ddu8/AoRCj3VhQK795jSRw=;
 b=nqIugtFZuvEHMvjp8nyWCEIJNFYQrW8FmeFQqLcz37OMR0m2NG6yLrxLV16i13kQhPacm6LAY/g/XFF13E4gpXNbksUDb7g0fUGw8gpSZ3ZcGqx1MyyZPY53MXCbyNzM49E+HQ+tZsEX031zFV0JosyanW8WtefQTEdj/iqXhwL3lxyuYWSFcknTQbmLrtSnn94HdWORQMC0RlIv8mAa8VXBiPvkJjM8jVOw2pFkOSlOJdU8u/eMz3G3CR2kLOS57Gsnjz6G9sFxxokTtQFeqJnVBJXnXpUazbgotIzDnw1EVLML+trfLHEk6SEXU7FldONVdloldbysw9oezdzKmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by HE1PR0402MB2762.eurprd04.prod.outlook.com (2603:10a6:3:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 09:00:47 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c48:27de:73e5:ea97]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::c48:27de:73e5:ea97%9]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 09:00:47 +0000
Message-ID: <a9145ef7-8b00-5456-27ae-32328972955c@suse.com>
Date:   Wed, 6 Jul 2022 17:00:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC 06/11] btrfs: write-intent: introduce an internal
 helper to set bits for a range.
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1657004556.git.wqu@suse.com>
 <ad68fad714efc8ab938ca69af099afd0e1201075.1657004556.git.wqu@suse.com>
 <80911341-8479-5a49-7a96-0f75c12dce74@suse.com>
In-Reply-To: <80911341-8479-5a49-7a96-0f75c12dce74@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::17) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2246fab-0f2c-424a-5a0c-08da5f2e0420
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2762:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIZ6JPiJZgkM/ViXSFmpIELzo57PRwOzo8hz82gBo9D6jLfye5IIasgnGM5YSKE9fX+hk1Jc5Cv5rJ7Jzkdw/zishuIy3NgGl2UGbxpiA+PrkI9cGwNrcbkg3sdS+2yTlnt4YIkXJoDRQlqh70kA1l46GQiep+R7vuQvnBdqNG++/bQKSMFh1IGn8kwU2WpXlijcKPJqkWetSt884SXOgkhn+wYhHw/xE1LtBnaoW2zwfORaF6bSa/W9p0bELuOHIdhBsru3Y8Z5Y2VDZGZXFIHp8MH3IoWuIakVxuFNx7lDCGQgXBZch6uRPe/6XZhD/DjppdJqe/OUIxJdEi/MJGDxsXR1RSrW4YD15Zp4oQuDJ0OJTI8a1OHcbpoVFFW0hRUsPOJEsjfZvV1zDkrdVblUVIj00xZtiGfqvH1vj8RSWqsjiTBseLB9eRyh0FK76jGadX3nx1Pag65gchd5eWhPN0DqUDAAk4Mp8DgOhkH41MwNu2OhRlGbQegOhoUn6XZ+IuIJTkJOSjtc4+tz3H2R4S0PWGw5OJ1H7RsY0wAiziWIJy8VppJ5Zou4BXThLOGf1pi23ipfbOxZl3SOAQMtQqY6GlXeDl+I5apF79kg4Vefr4fWSTmLKibpva1f2yLmKdaOYn/GfnZWrg+2p6OtZxffm71b7R/Y21TAnxnqtMHGeaATVrEJzkHvM6fJmso1SkrVZe4rQtiT1qAh4+4MhsHLc+xLd+AfFyn46HB/wxNf5X9sIfwuczkzx1ibXOnrlYMgh5gecIbFcf6pMzT2WgoD/bG/9G4pDe8x6VIXjiZ3ErG4CsTeraIfuZAg3/F5bnYmeGbKv1jh0qXMKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(396003)(376002)(346002)(136003)(478600001)(38100700002)(6486002)(186003)(2616005)(2906002)(31686004)(6506007)(41300700001)(6666004)(53546011)(36756003)(66556008)(6916009)(316002)(8936002)(5660300002)(31696002)(86362001)(30864003)(6512007)(83380400001)(66946007)(66476007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdZOWRKOG81OGlFaFV6MkUxTVl6TWtrUStld0JNTmZVWHRNNzQ3ZlZFakxs?=
 =?utf-8?B?bmtOQnB2R1ViRHo4UENBOHZUMHBVbmdZenJmUjhIcjlVSUt2V0UwYnZLNE5Q?=
 =?utf-8?B?dkdwMUZMVGdxUFVINlkxdTU1WmQ2RXVDT0JUN1dXNnVNeWVnSjBlb0tOczZl?=
 =?utf-8?B?VDRBMjJpYnQ1em1XbmprMzNEOFlydWlFSlAwWXBSMGVLaUZYby85NHd3T2ZT?=
 =?utf-8?B?Y2hHMHZiUFVnV0pLRHhIOGFXbko1Z1JDTmRBdlRMRU8rcEh5L25jUXNkQ3Ns?=
 =?utf-8?B?R2Zsb2lCM2VqclJBaEJEaGhGNFlYc2loU3R6cXd1Mnd6eEVvQzVVQ2MxQTRV?=
 =?utf-8?B?R1M2cERNSlErTGFoc3ZXd1c5RFBLSVA2THVTcjBSK0VvTE9FVWJtYkNlY1p5?=
 =?utf-8?B?eGVnN3Q4NVlNRElzTWx6ZFppQ0d3T1B4UkJISjZ4MVlodmljb0dWNnE0cnpL?=
 =?utf-8?B?ay9NVzZGT0QxeXRUVVpMc1ZDakg1ekFLL3RneFVNQXg2UXdOVEtuejljMTYv?=
 =?utf-8?B?ZUYzVFBydnRldytaNkFwVDViZkE0RmduK0xKSGNFajcySjVLdVR0dWZ3RTJD?=
 =?utf-8?B?K2lMQkh2MGxjcVJKNnN1cHdvY3l0eWt0SHJIdUh0TUpZTWFJNzJYakJPZkJI?=
 =?utf-8?B?dHhiT1BUa3hybFpoVncrSG5qSHNhek5CR1NOVld6RUV3eDk1R21hcVVuMlRj?=
 =?utf-8?B?YWw4cEFJeTRyMk9RU1kyaS9Sd2QrdVVhYXV1L2p6Y3lTemZnQkJsRlJpZE4x?=
 =?utf-8?B?TFhneUxNU1psemRTZzBIbFJWd2RjSzZ3WGloTklnZjRnZnluRnhJalNlZGJB?=
 =?utf-8?B?cmVVK3FJSldwbDlJL1FDVEcxbzY4Z3dtTWUzU2pENU1TS0V1cVJwMVFEUEtp?=
 =?utf-8?B?aWNXL05ES0hwN01jS2RHS1FFL2MvUkVBTWVUVzVudGFMRjVxcnBjdjlQc2Y4?=
 =?utf-8?B?Mmo4UmlxckJZcm5JSTRKYVdMZzVhL3Y5QmN4d0FnSExSQ21JUVJuL0hWU1A0?=
 =?utf-8?B?TWw0ZTlqajZBYmdlSFpRTVMrUFlaMDh6Y2VBekNVZG84SXNIQmx5eGZLYUtS?=
 =?utf-8?B?aVRVSEtyMk1PaFhvTnVudi9ETHhyTHRQcnFTSHgvU2YwNXVUZVRQdTgvTmZX?=
 =?utf-8?B?SFF2UXJXVng5VHhkdyt4b2IwdFVNN01oVjNSeHBDNGRsTFRaMU5zTmJYVFN3?=
 =?utf-8?B?Q3h4YnE1S0lITk5zOTJWSkZoRXh0U3krZW5SSmdiTjFUZTQ0UDNqWkZ0OGJJ?=
 =?utf-8?B?dHM1UE5RcWsvUzBHS092dTNvcUozVkNHd3RWeTIzVFZSQ3JYQ0dvc3hQQUlh?=
 =?utf-8?B?Z2t4Z0h5Sk04R3J2NlZmS3FmSk03V2FJeExXbUYrUFdERVQ3ZmdmdjlDQVZh?=
 =?utf-8?B?TUJ2M3djMjZKOFBuWEFOSkYydCtSenIvMDVkYmg2VHRrKytjYkdHdEVvbGZI?=
 =?utf-8?B?OVBtT1FvbjllakZ6anlZUENkNkVCejgzTHdxTnFVWDhmdHhOWE9rL0FVZjBa?=
 =?utf-8?B?eGZDdXg3NG5CWHRlOWNUOFQ3S05uSS9OZ3RuQm12QVhub3hHMk00ZU9iazJy?=
 =?utf-8?B?TWFDbWRWeHp6U3dIcCtGcHVrdzhsNUNLNDNmQzVKL0NwS2lXSzBEOVBVRGVh?=
 =?utf-8?B?V0FRL3N0NmFrOHBBVGlaWWdkancvZDBCd0FJMjdJWkRVZHMxa3EyR2FJdXA5?=
 =?utf-8?B?Q2RzRDROOFlDc2pVMlZ6SXA1TEF3d3luUEdIQjB0TC8xSXZCUmh3YUJicjRm?=
 =?utf-8?B?elVlcWhkZTBqRHp2VjVobWdxaE9WeGZlRnVrR2RLVHAvRVJNajJBRnNaRkFa?=
 =?utf-8?B?UU9kTitROFNjRkRraFl5aWZQdHh6U1g1YmNCOWxNaFVvelQ1cHBQZjN0SmJT?=
 =?utf-8?B?Q3BDUHpoZyt0SldrWjYxVGVrVnJZUy83WVg2eE1EbDFyUEczZy91cnNwWTdW?=
 =?utf-8?B?SGE0SVFMbjZtelpCR1dFeElSY1NXUzJnVHBhNVZ2cUtWNDNqWFN6UUJaL1Zu?=
 =?utf-8?B?L2ZGbTB6UkRuck50SExzMnZJdTlkdlBvdjdnYzNtLzJKQjV2RjlqOFBGbUJk?=
 =?utf-8?B?eUNUYUNTbzU3amZnNkU5V0xRaWtQenQvRnJ0b3NZNkxVNTJsU1ZaWW5nZEVk?=
 =?utf-8?B?OXdKU1duN09zQTltWi9RdUFSNVZyZnpVT3h4L3ZOV3pHeER1VWs1ZlluVmd1?=
 =?utf-8?Q?jkMuxsnQjHL8lrF8AnpYUD0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2246fab-0f2c-424a-5a0c-08da5f2e0420
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 09:00:46.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/3g5DNxrJwxmqYzJ4kUi4LSKYARYgHwPeO5f4uUtncNEKvT08dxofzE59a1xHwt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/6 14:16, Qu Wenruo wrote:
> 
> 
> On 2022/7/5 15:39, Qu Wenruo wrote:
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Unfortunately there seems to be corner case not handled properly.
> 
> If we have a start=37617664, len=196608, and we have an existing entry 0 
> , bitmap=0x0700000000000000.
> 
> Then after calling set_bits() with above range, we only got:
> entry 0 bitmap=0xc700000000000000.
> 
> Note 0xc = 1100 binary, thus we didn't create a new entry for the 
> remaining 1 bit, and triggered the later WARN_ON_ONCE() for clear_bits.
> 
> I'll fix the bug in the code and add a selftest case for it.
> 
> Thanks,
> Qu
> 
>> ---
>>   fs/btrfs/write-intent.c | 251 ++++++++++++++++++++++++++++++++++++++++
>>   fs/btrfs/write-intent.h |  16 +++
>>   2 files changed, 267 insertions(+)
>>
>> diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
>> index a43c6d94f8cd..0650f168db79 100644
>> --- a/fs/btrfs/write-intent.c
>> +++ b/fs/btrfs/write-intent.c
>> @@ -259,6 +259,257 @@ static int write_intent_init(struct 
>> btrfs_fs_info *fs_info)
>>       return 0;
>>   }
>> +static struct write_intent_entry *write_intent_entry_nr(
>> +                struct write_intent_ctrl *ctrl, int nr)
>> +{
>> +
>> +    ASSERT(nr < WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES);
>> +    return (page_address(ctrl->page) +
>> +        sizeof(struct write_intent_super) +
>> +        nr * sizeof(struct write_intent_entry));
>> +}
>> +
>> +/*
>> + * Return <0 if the bytenr is before the given entry.
>> + * Return 0 if the bytenr is inside the given entry.
>> + * Return >0 if the bytenr is after the given entry.
>> + */
>> +static int compare_bytenr_to_range(u64 bytenr, u64 start, u32 len)
>> +{
>> +    if (bytenr < start)
>> +        return -1;
>> +    if (start <= bytenr && bytenr < start + len)
>> +        return 0;
>> +    return 1;
>> +}
>> +
>> +/*
>> + * Move all non-empty entries starting from @nr, to the right, and 
>> make room
>> + * for @nr_new entries.
>> + * Those new entries will be all zero filled.
>> + *
>> + * Caller should ensure we have enough room for @nr_new new entries.
>> + */
>> +static void move_entries_right(struct write_intent_ctrl *ctrl, int nr,
>> +                   int nr_new)
>> +{
>> +    struct write_intent_super *wis = page_address(ctrl->page);
>> +    int move_size;
>> +
>> +    ASSERT(nr_new > 0);
>> +    ASSERT(wi_super_nr_entries(wis) + nr_new <=
>> +           WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES);
>> +
>> +    move_size = (wi_super_nr_entries(wis) - nr) *
>> +             sizeof(struct write_intent_entry);
>> +
>> +    memmove(write_intent_entry_nr(ctrl, nr + nr_new),
>> +        write_intent_entry_nr(ctrl, nr), move_size);
>> +    memset(write_intent_entry_nr(ctrl, nr), 0,
>> +           nr_new * sizeof(struct write_intent_entry));
>> +    wi_set_super_nr_entries(wis, wi_super_nr_entries(wis) + nr_new);
>> +}
>> +
>> +static void set_bits_in_one_entry(struct write_intent_ctrl *ctrl,
>> +                  struct write_intent_entry *entry,
>> +                  u64 bytenr, u32 len)
>> +{
>> +    const u64 entry_start = wi_entry_bytenr(entry);
>> +    const u32 entry_len = write_intent_entry_size(ctrl);
>> +    unsigned long bitmaps[WRITE_INTENT_BITS_PER_ENTRY / BITS_PER_LONG];
>> +
>> +    wie_get_bitmap(entry, bitmaps);
>> +
>> +    ASSERT(entry_start <= bytenr && bytenr + len <= entry_start + 
>> entry_len);
>> +    bitmap_set(bitmaps, (bytenr - entry_start) / ctrl->blocksize,
>> +           len / ctrl->blocksize);
>> +    wie_set_bitmap(entry, bitmaps);
>> +}
>> +
>> +/*
>> + * Insert new entries for the range [@bytenr, @bytenr + @len) at slot 
>> @nr
>> + * and fill the new entries with proper bytenr and bitmaps.
>> + */
>> +static void insert_new_entries(struct write_intent_ctrl *ctrl, int nr,
>> +                   u64 bytenr, u32 len)
>> +{
>> +    const u32 entry_size = write_intent_entry_size(ctrl);
>> +    u64 entry_start;
>> +    u64 new_start = round_down(bytenr, entry_size);
>> +    u64 new_end;
>> +    int nr_new_entries;
>> +    u64 cur;
>> +
>> +    if (nr >= wi_super_nr_entries(page_address(ctrl->page)) ||
>> +        nr >= WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES)
>> +        entry_start = U64_MAX;
>> +    else
>> +        entry_start = wi_entry_bytenr(write_intent_entry_nr(ctrl, nr));
>> +
>> +    ASSERT(bytenr < entry_start);
>> +
>> +    new_end = min(entry_start, round_up(bytenr + len, entry_size));
>> +    nr_new_entries = (new_end - new_start) / entry_size;
>> +
>> +    if (nr_new_entries == 0)
>> +        return;
>> +
>> +    move_entries_right(ctrl, nr, nr_new_entries);
>> +
>> +    for (cur = new_start; cur < new_end; cur += entry_size, nr++) {
>> +        struct write_intent_entry *entry =
>> +            write_intent_entry_nr(ctrl, nr);
>> +        u64 range_start = max(cur, bytenr);
>> +        u64 range_len = min(cur + entry_size, bytenr + len) -
>> +                range_start;
>> +
>> +        /* Fill the bytenr into the new empty entries.*/
>> +        wi_set_entry_bytenr(entry, cur);
>> +
>> +        /* And set the bitmap. */
>> +        set_bits_in_one_entry(ctrl, entry, range_start, range_len);
>> +    }
>> +}
>> +
>> +/*
>> + * This should be only called when we have enough room in the 
>> bitmaps, and hold
>> + * the wi_ctrl->lock.
>> + */
>> +static void write_intent_set_bits(struct write_intent_ctrl *ctrl, u64 
>> bytenr,
>> +                  u32 len)
>> +{
>> +    struct write_intent_super *wis = page_address(ctrl->page);
>> +    const u32 entry_size = write_intent_entry_size(ctrl);
>> +    int i;
>> +    u64 nr_entries = wi_super_nr_entries(wis);
>> +    u64 cur_bytenr;
>> +
>> +    /*
>> +     * Currently we only accept full stripe length, which should be
>> +     * aligned to 64KiB.
>> +     */
>> +    ASSERT(IS_ALIGNED(len, BTRFS_STRIPE_LEN));
>> +
>> +    /*
>> +     * We should have room to contain the worst case scenario, in 
>> which we
>> +     * need to create one or more new entry.
>> +     */
>> +    ASSERT(nr_entries + bytes_to_entries(bytenr, len, 
>> BTRFS_STRIPE_LEN) <=
>> +           WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES);
>> +
>> +    /* Empty bitmap, just insert new ones. */
>> +    if (wi_super_nr_entries(wis) == 0)
>> +        return insert_new_entries(ctrl, 0, bytenr, len);
>> +
>> +    /* Go through entries to find the one covering our range. */
>> +    for (i = 0, cur_bytenr = bytenr;
>> +         i < wi_super_nr_entries(wis) && cur_bytenr < bytenr + len; 
>> i++) {
>> +        struct write_intent_entry *entry = 
>> write_intent_entry_nr(ctrl, i);
>> +        u64 entry_start = wi_entry_bytenr(entry);
>> +        u64 entry_end = entry_start + entry_size;
>> +
>> +        /*
>> +         *            |<-- entry -->|
>> +         * |<-- bytenr/len -->|
>> +         *
>> +         * Or
>> +         *
>> +         *        |<-- entry -->|
>> +         * |<-- bytenr/len -->|
>> +         *
>> +         * Or
>> +         *
>> +         *    |<-- entry -->|
>> +         * |<-- bytenr/len -->|
>> +         *
>> +         * We need to insert one or more new entries for the range not
>> +         * covered by the existing entry.
>> +         */
>> +        if (compare_bytenr_to_range(cur_bytenr, entry_start,
>> +                        entry_size) < 0) {
>> +            u64 new_range_end;
>> +
>> +            new_range_end = min(entry_start, bytenr + len);
>> +            insert_new_entries(ctrl, i, cur_bytenr,
>> +                       new_range_end - cur_bytenr);
>> +
>> +            cur_bytenr = new_range_end;
>> +            continue;
>> +        }
>> +        /*
>> +         * |<-- entry -->|
>> +         *    |<-- bytenr/len -->|
>> +         *
>> +         * Or
>> +         *
>> +         * |<-------- entry ------->|
>> +         *    |<- bytenr/len ->|
>> +         *
>> +         * In this case, we just set the bitmap in the current entry, 
>> and
>> +         * advance @cur_bytenr to the end of the existing entry.
>> +         * By this, we either go check the range against the next entry,
>> +         * or we finish our current range.
>> +         */
>> +        if (compare_bytenr_to_range(cur_bytenr, entry_start,
>> +                        entry_size) == 0) {
>> +            u64 range_end = min(entry_end, bytenr + len);
>> +
>> +            set_bits_in_one_entry(ctrl, entry, cur_bytenr,
>> +                          range_end - cur_bytenr);
>> +            cur_bytenr = range_end;
>> +            continue;

This is where the problem happens.

If this entry is also the last entry, and we still have something left, 
then we're screwed as we will no longer insert new entries for it, 
leaving some bits not properly set.

Will rework the big for loop to make the last entry insert consistent.

Thanks,
Qu
>> +        }
>> +
>> +        /*
>> +         * (A)
>> +         * |<-- entry -->|            |<--- next -->|
>> +         *           |<-- bytenr/len -->|
>> +         *
>> +         * OR
>> +         *
>> +         * (B)
>> +         * |<-- entry -->|        |<--- next -->|
>> +         *           |<-- bytenr/len -->|
>> +         *
>> +         * OR
>> +         *
>> +         * (C)
>> +         * |<-- entry -->|<--- next -->|
>> +         *           |<-- bytenr/len -->|
>> +         */
>> +        if (i < wi_super_nr_entries(wis) - 1) {
>> +            struct write_intent_entry *next =
>> +                write_intent_entry_nr(ctrl, i + 1);
>> +            u64 next_start = wi_entry_bytenr(next);
>> +
>> +
>> +            /* Case (A) and (B), insert the new entries. */
>> +            if (cur_bytenr >= entry_end && cur_bytenr < next_start) {
>> +                insert_new_entries(ctrl, i + 1, cur_bytenr,
>> +                           bytenr + len - cur_bytenr);
>> +                cur_bytenr = next_start;
>> +                continue;
>> +            }
>> +
>> +            /* Case (C), just skip to next item */
>> +            continue;
>> +        }
>> +
>> +        /*
>> +         * The remaining case is, @entry is already the last one.
>> +         *
>> +         * |<-- entry -->|
>> +         *           |<-- bytenr/len -->|
>> +         *
>> +         * We're beyond the last entry. Need to insert new entries.
>> +         */
>> +        insert_new_entries(ctrl, i + 1, cur_bytenr,
>> +                   bytenr + len - cur_bytenr);
>> +
>> +        cur_bytenr = bytenr + len;
>> +    }
>> +}
>> +
>>   int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
>>   {
>>       struct btrfs_device *highest_dev = NULL;
>> diff --git a/fs/btrfs/write-intent.h b/fs/btrfs/write-intent.h
>> index 797e57aef0e1..d8f4d285512c 100644
>> --- a/fs/btrfs/write-intent.h
>> +++ b/fs/btrfs/write-intent.h
>> @@ -106,6 +106,15 @@ struct write_intent_entry {
>>   /* The number of bits we can have in one entry. */
>>   #define WRITE_INTENT_BITS_PER_ENTRY        (64)
>> +static inline u32 bytes_to_entries(u64 start, u32 length, u32 blocksize)
>> +{
>> +    u32 entry_len = blocksize * WRITE_INTENT_BITS_PER_ENTRY;
>> +    u64 entry_start = round_down(start, entry_len);
>> +    u64 entry_end = round_up(start + length, entry_len);
>> +
>> +    return DIV_ROUND_UP((u32)(entry_end - entry_start), entry_len);
>> +}
>> +
>>   /* In-memory write-intent control structure. */
>>   struct write_intent_ctrl {
>>       /* For the write_intent super and entries. */
>> @@ -189,6 +198,13 @@ WRITE_INTENT_SETGET_FUNCS(super_csum_type, struct 
>> write_intent_super,
>>                 csum_type, 16);
>>   WRITE_INTENT_SETGET_FUNCS(entry_bytenr, struct write_intent_entry, 
>> bytenr, 64);
>> +static inline u32 write_intent_entry_size(struct write_intent_ctrl 
>> *ctrl)
>> +{
>> +    struct write_intent_super *wis = page_address(ctrl->page);
>> +
>> +    return wi_super_blocksize(wis) * WRITE_INTENT_BITS_PER_ENTRY;
>> +}
>> +
>>   static inline void wie_get_bitmap(struct write_intent_entry *entry,
>>                     unsigned long *bitmap)
>>   {
