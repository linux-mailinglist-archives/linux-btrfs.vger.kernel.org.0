Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2947D69DE90
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Feb 2023 12:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjBULQD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Feb 2023 06:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjBULQB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Feb 2023 06:16:01 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AA8B773
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Feb 2023 03:15:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krlJCLB5+nUXaTKh5S/DmO4o/5E4iWT1d4J/7oi69T5Cjubq1Pp6GKbyk9Q5hsUW8a6qFYtJTGBb7wJjyHwyj5arIolco6H1jGbjHCVoCacyZnEbvIhytov5cJmEU7HpinNEgXRIrvA7B6v6gvHWfwtx0Ok8g7w8MiKSfJFEx5m4A5xpgc1GO+W+JiQA86EYLwRwTSKn4gZZXmaTi3fJxsgusrjeYesjvS3xvSSvnzFHg/fiFwV8FPHgNbwbgrAmlpY/N3V30WYnT2lcj3mYdsl0fYhK3PpI+64X0rIqq6gnctrBoqPKg/F3FCgHKu+E453OF0daCeDh/+1aYnm9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDWAdKKEge5OMVeJ8wp+w8RINekYB2zSDygrK30Jh6s=;
 b=dk1dD0cPZqykfEJfnOzryJ1TVx2iW6ITl80zc7XOmRkDOx7iY3WCTsDqThzIjxVFrxYctYgdbXvge2lfhZvM1c1eo1dqFuCOp8Ig0wrkOiTXHkKl417v/9q35JPpqkqVa+EUUgPydoJrQf2ILA3KYuXYHQQJGUmUnh9SfM49qA78EVrl2tAOVibTtU9WEmgbBqH2rvM6To5oJ9WfrcWnBa+R0K2895aCZjcDypF9PCjP1m/brhp7TkHVVDqfOOxj1xG+sW5Gu/X86TPw5JSVfxV0ZkvUFmg1JhpQpkw3nQ7ukGKRLlwIXXZR9kMgvkrkwEk1QoWX2PfLbIZmMr+EFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDWAdKKEge5OMVeJ8wp+w8RINekYB2zSDygrK30Jh6s=;
 b=J1yk0YndP/uUU5CR8ZPeURZoR2K+jwJwVuTwY6lKeycomIRpku2ep2pvGDSYxLgkhtLasSHzp7zTrvv4K9kiGqcK0vRJOAH/VxMC0hbB0DmzKuIB2bUaJsHpSYRzk/huJuzsS3HkAIti9qJvEqrMabBaYAfknhNCp0H4qBNP8HR71W5PEmWfKiAPy3jgINZbP8k9DPpn8uQx+P3Q9WPGMt0C81KTXkIKNAAwFvGzXck+68ejj8oVsxRl5Hz9jALzLg8+UNZKPuBjrlv5ubUND8aInvCO6MQ+A2Bj9U8XGcyQqyAuVeG150YhmS4EWv6zGnqzGBcaOmYe8iSea0b4sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB7757.eurprd04.prod.outlook.com (2603:10a6:102:b8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 11:15:57 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 11:15:57 +0000
Message-ID: <283e7857-4797-181f-529d-235c29343fb6@suse.com>
Date:   Tue, 21 Feb 2023 19:15:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 01/12] btrfs: remove the force_bio_submit to
 submit_extent_page
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-2-hch@lst.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20230216163437.2370948-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: f41d763f-0174-4e97-d3e4-08db13fd0125
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BXjwnvOTJW9TEBje5Netkpb7DQRIKlQROdtACS3gebRy72G8L+3yjTdpvua1OyPmh0h90CHrRYgQoiVimiaQCEbNtA7OgoOeCvkdndeQZSDNKCs0PI0vlqkc6YCmFOmD6AJ8bXJMOLljNwX1JWbjgZSydN3MtPoGUoDvQ1zM+W/4HJORwAotp9y/KN/hcGG43H8RQV2lRxJKYxFjeMpblvqCCa4oJa7tp1S2879IIkwxsSAr04mdtPfqi/IkrWftXgW5cA5sGixC/jIumkJRFMCjCaOtyiilcQGcd4bdgFsw84t257NQJAk6H5i/zjv0qYZzgCQlYZcYWhqi7UdHt+tGdevEcqv54Er2GHpaDgEAYYeLGokJS+F+t6qnUoiwVKQUSI/V4+myjujBPfIUcTyUOSk3utdj39SSMcMhp+itQJrUrvKs4ecLsuUcmWseg2KpmDtwewTbMS5/BwRCWDxMHQj6J4GjI+E6JrqXbwRBQr3lwxTw/sV37RPqpumX+dyOwDHbXq1QYUWyGm42Kz24GSdck4TpsKg/wkpdJufraPUSoD9qV/jUMExeBxSuZaMwucHdiRA5ChBcegorBxZS/BX5aSMMbfyoWeZJPbg5h7HJWu7w5IK/n1nAFMPFP45SLZXudEeOzMXzCWVDa7y0MKAPPA/Hes/x7yaE3YDWvt2KWRJUexchwI3H8QCcsgy6vlyGCRrN9GFhvXzo/T8O6NVQ6THtC4o5MDUNWVU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199018)(31686004)(36756003)(86362001)(31696002)(5660300002)(41300700001)(2906002)(8936002)(38100700002)(83380400001)(478600001)(66946007)(8676002)(66476007)(66556008)(110136005)(6636002)(6486002)(6512007)(186003)(53546011)(2616005)(4326008)(316002)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0x3V2pEZVlReDNmWms1dzFFZkE3dlpyTDdtbHZrYnFxcDEzeXhDaVNaRmxK?=
 =?utf-8?B?NXNXNVIvTFIzK3kvWlNnYVJnRDZQM1Q5dmVuY2t5bU8rRU1uUndWRSt5Y053?=
 =?utf-8?B?R1duRUx4VTRET1VQNTdXc0hmUWIrZUExQllYSHk1QmJacU5PR3RrQkZtd1hE?=
 =?utf-8?B?ek41TFdTWER2Wm41ZUZrMSsvY1JvVVg0QzRNcHN0dW5FbUJKYXRrNk0zNWpB?=
 =?utf-8?B?OVhvaHFhbjBMa0NLY3lWWWovMUN0eVlJUGpjbzNwUTQxbWoySTI1UDUzRjZs?=
 =?utf-8?B?Wmlmc21ZdFZVRFNkZGw0T29iak1aNmw1eW9hMURMb3J1YjQxM2NqZGEvT2hn?=
 =?utf-8?B?R2tCUncreTQyNTFaeFg4NlZKN1Mwdk5xelI1cXpQY25QMFhUNEI5TXNJS0Zs?=
 =?utf-8?B?TkpMTm1zN0c5MEtab3lpSkgrNHRITDBNQ21JTHc4K2EyWmt2NWpQODBWL1dw?=
 =?utf-8?B?OVhwekR3aStmbTdYYkhaRTA2TldKU09MN0dhdnB3K0EyMWVUdlFFSHk0Qm5p?=
 =?utf-8?B?ZmxsbkVJSFV6a05DZUNiVjZFVWRTSTF0RXdKekpySVB3SWdPRWFaaHo1YTJX?=
 =?utf-8?B?TGpwY0NrRGlVcVgxTnhORDJBcEFmSTE1QldaZjBmV1Frbm5XbmFVUjJkMW9F?=
 =?utf-8?B?NDdZMXRjMFF3MktxakdBVldTNE53Qm1weVFyaXZTZ3p4N0dCTy9EQjJERk4z?=
 =?utf-8?B?UkkyUk83cEJvcnBvS3hzNG1peG9XNTM1R2dVOEFlNXR3UjV2VkV4OWhSU2RK?=
 =?utf-8?B?Z2ZlMDN2WDZoNmtQZ3pSdThVS2ZpTXV2QUw3RFJ4N2pJcU1uK3JUZGEyYm44?=
 =?utf-8?B?MW9ieE1LT3VNNnI3eVRPZjcyNnA4bnJNdjdJemJoZVowcU5wSEkzTVJDYmp2?=
 =?utf-8?B?ZXJ1L0hIaStKSlFlQmxyMlVSMkdZUHBBZHlpejltNUN2bmVnRlNVcnhLSDNh?=
 =?utf-8?B?aXVoU0U1alhNcW1tSmdSS2hFVVRCNHpEOFNSOHBKazZjTDE0QTNxMWVzcFpE?=
 =?utf-8?B?UTQwdUwva1VRQUZnbU5VTGNBdUdady94OENpUnhNVXZwK3F6MkdlSDBydXMz?=
 =?utf-8?B?cnhlYWN2UWdXZ1REcVBtTUxMOG1POTdPZlowQTkzZDdVaGhjTnpQWDJ1dWpN?=
 =?utf-8?B?bi9DU3E1dXQ4SExjQmVRaCtCMU9jT1pFZ3cwdm55M2t6NXdzWWpMamJObzBn?=
 =?utf-8?B?V1k1QTNWV0M4YkJTYkZNMzBxOTJSdnErbUwrYytkR3hJcys3eTJ3aDNMbVlW?=
 =?utf-8?B?cmYxa04vdm11bGR2Uis1eHFKK241K21rQVIwdGdnNE10eG9Udm4wQncvbXQv?=
 =?utf-8?B?aXhtbkp6QjVpcGxxeWk4eTg1ckRHTlFOUmEvaW5OWUNlc0svekFid2Mzc1l5?=
 =?utf-8?B?dit4YzMxTUV6a1Z4N242WmtZZVQ1Z3V0TmVWUjdqQUdFU2Y3cldLd21EdU1I?=
 =?utf-8?B?VG9OSFV3UXptcmFZenY4Mi94SG9ycW9UOWRPOUlUcFR0aDZLM0JURlZPRkhr?=
 =?utf-8?B?TjJsUHNTRXN1SlVZRGN3dFNEUm42VStpdENWZTJlYkxySE9YNE10NG9XcDB4?=
 =?utf-8?B?SkpJZjE2eVJWb1FHS3hhdVhJSERyaTgyOVpnazJadkE1REpaRDNCWmhLQ1l1?=
 =?utf-8?B?N0JjL05FZ3VsUVBpTEpLMmM5K0Rvamk4NmIzT0xRU202aWRKRXBwRnBoamVI?=
 =?utf-8?B?L2I2eU82dWpwOTdtUUUyZzdBYXc4N1A3bTR2a3lBOWdlT0lmWDJaWVFKaWxC?=
 =?utf-8?B?Z0tPM0krcjFqcDdreHlQa01MU3BNZEtnZnZKSmp3ajBuME1pcTM2MXRDS2Iz?=
 =?utf-8?B?Ynpzak5meGJmSmhlQklNWUxNWDdKLzViZ3puNDc3RUpCT3VyeVJ6N1hPSEZm?=
 =?utf-8?B?S0REKzFaaHdCNUFkQmdvUk8vWnRUTytLd3k0clU2cVZEOUo3TWlVZnRCV3dB?=
 =?utf-8?B?ZFNZMDZUeFRUU2J5TW5EaXBJK1Y0R015aFVKcTVBSTBTK0x4aDJDdlRGQnRy?=
 =?utf-8?B?a05VNzZ3MXRwekJlZ0xmQ3JNb20vWksxdEU0VXVqaFRxN2x6UnpWdENPRXph?=
 =?utf-8?B?RDZhVnh3VDZlQitzTWFldW1COVIzR2Rvd3V6UkpXaG92VmFWUnZwalE4SDZi?=
 =?utf-8?B?ZTBBd2NKZnZEeWhRbnJQSzJ0UDdjNDlmSWRmV1AyOEJmZVJVQy81bjVFbGNw?=
 =?utf-8?Q?hBdfjzUS3udv8oaoo8jKh4k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41d763f-0174-4e97-d3e4-08db13fd0125
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 11:15:57.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQDYIcfKn2+ZYLUoM/Xwj/Z96FQNO9mS2NhR5fWwUqbj1jQLvZ2xF+ox7wMD4Hu0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7757
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/17 00:34, Christoph Hellwig wrote:
> If force_bio_submit, submit_extent_page simply calls submit_one_bio as
> the first thing.  This can just be removed to the two callers that set
> force_bio_submit to true.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

One less argument is always good.

Just need to get the 2nd patch folded into this one.

Otherwise looks good to me.

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c25fa74d7615f7..b53486ed8804af 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1027,8 +1027,7 @@ static int submit_extent_page(blk_opf_t opf,
>   			      struct btrfs_bio_ctrl *bio_ctrl,
>   			      u64 disk_bytenr, struct page *page,
>   			      size_t size, unsigned long pg_offset,
> -			      enum btrfs_compression_type compress_type,
> -			      bool force_bio_submit)
> +			      enum btrfs_compression_type compress_type)
>   {
>   	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
>   	unsigned int cur = pg_offset;
> @@ -1040,9 +1039,6 @@ static int submit_extent_page(blk_opf_t opf,
>   
>   	ASSERT(bio_ctrl->end_io_func);
>   
> -	if (force_bio_submit)
> -		submit_one_bio(bio_ctrl);
> -
>   	while (cur < pg_offset + size) {
>   		u32 offset = cur - pg_offset;
>   		int added;
> @@ -1331,10 +1327,11 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   			continue;
>   		}
>   
> +		if (force_bio_submit)
> +			submit_one_bio(bio_ctrl);
>   		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
>   					 bio_ctrl, disk_bytenr, page, iosize,
> -					 pg_offset, this_bio_flag,
> -					 force_bio_submit);
> +					 pg_offset, this_bio_flag);
>   		if (ret) {
>   			/*
>   			 * We have to unlock the remaining range, or the page
> @@ -1645,8 +1642,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>   		ret = submit_extent_page(op | write_flags, wbc,
>   					 bio_ctrl, disk_bytenr,
>   					 page, iosize,
> -					 cur - page_offset(page),
> -					 0, false);
> +					 cur - page_offset(page), 0);
>   		if (ret) {
>   			has_error = true;
>   			if (!saved_ret)
> @@ -2139,7 +2135,7 @@ static int write_one_subpage_eb(struct extent_buffer *eb,
>   
>   	ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
>   			bio_ctrl, eb->start, page, eb->len,
> -			eb->start - page_offset(page), 0, false);
> +			eb->start - page_offset(page), 0);
>   	if (ret) {
>   		btrfs_subpage_clear_writeback(fs_info, page, eb->start, eb->len);
>   		set_btree_ioerr(page, eb);
> @@ -2180,7 +2176,7 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
>   		set_page_writeback(p);
>   		ret = submit_extent_page(REQ_OP_WRITE | write_flags, wbc,
>   					 bio_ctrl, disk_bytenr, p,
> -					 PAGE_SIZE, 0, 0, false);
> +					 PAGE_SIZE, 0, 0);
>   		if (ret) {
>   			set_btree_ioerr(p, eb);
>   			if (PageWriteback(p))
> @@ -4446,9 +4442,10 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
>   	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
>   
>   	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
> +	submit_one_bio(&bio_ctrl);
>   	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
>   				 eb->start, page, eb->len,
> -				 eb->start - page_offset(page), 0, true);
> +				 eb->start - page_offset(page), 0);
>   	if (ret) {
>   		/*
>   		 * In the endio function, if we hit something wrong we will
> @@ -4558,7 +4555,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   			ClearPageError(page);
>   			err = submit_extent_page(REQ_OP_READ, NULL,
>   					 &bio_ctrl, page_offset(page), page,
> -					 PAGE_SIZE, 0, 0, false);
> +					 PAGE_SIZE, 0, 0);
>   			if (err) {
>   				/*
>   				 * We failed to submit the bio so it's the
