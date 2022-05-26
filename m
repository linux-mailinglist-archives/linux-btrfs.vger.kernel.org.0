Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9387B53492D
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 May 2022 05:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiEZDGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 23:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiEZDGr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 23:06:47 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1456247
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 20:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1653534402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0mkjHrHR9/7KhqutGGKf3SFBO3dZTEjPFlxU8q8MPU=;
        b=VjTIbufDy2Vm36eRijPKE3GjfClQMsJZDufo86kqMLGIP23Fam/0GFkcXlAZbu9vdaaKXV
        Z4UnvFHBnRW8LgIV7O5Dppcw7FNNqF3mnnNXcGBQZ2gb6/TKO1RYCCyvPfA+5xjfPU1KLx
        BWID5dhwKov8NCOqRXIGpJy62BXjaeI=
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2176.outbound.protection.outlook.com [104.47.51.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-h7Y1x74IMB-Gj_DneEf0jA-1; Thu, 26 May 2022 05:06:41 +0200
X-MC-Unique: h7Y1x74IMB-Gj_DneEf0jA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQkY+3y/OckqiwnUf5Qw8Xft0t9+1trimjQZAuHHcZUNQVnKWIs+gsgungqnSSJFTXTJb29wLNH2EYmqJd9XDVcaGH3zONDnIBHQ6BZrlmPSMO8BUcUpHxgrsAf/ooDGb2sjiyoyRQgaB6L96UOZ4L90V8fmCoVe3QidLVDO3x7mqe2Vc+W9pv/47veJzqo8lQ4na474VCb2uMe0vohHMq0RJV0sHkpM2u3kQ+aYeqDDckfJe0Bjvu3ncvR+OEVIdN/bsO4EoSj0xg9M5Yap3rvBs6yUNav70XIweia1anMZ99sfQPNWvmmk/GqYBXTo6Q+NyASmIjaDAhvnYLFnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0mkjHrHR9/7KhqutGGKf3SFBO3dZTEjPFlxU8q8MPU=;
 b=AKxUkgkQbKaXLfnOR+Jc83UyCW3cTokbd7YlUllqlIA6YqaCriCNM5ZiZYWJ4dbsqvrRMcf4cnxlAoiHVJI5fcoKSKY68CRe/oDYIeJf7O5s8SHTFbiitQ+MU2sz8dnllj8anm3kJkd2N19l4XrZuaZHLPtcy4evhFrgEV+PfOxTKKMUMgpxFjpDZBdlSTci6LVO8ZLnVwtWYTwgCB7ThTq8An2LM2b6lwHd6Q/a1nUBjKYf8KaX7DHHTLuoQdpmbgKCpQH/IejCzNPyNKTG8HQzyuELCGRZhqSL5mGSbxk6z+iZbnfoqB93FDPqancy+5WsAYdYrv5YWI72Y8XvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB6PR0402MB2933.eurprd04.prod.outlook.com (2603:10a6:4:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 03:06:39 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf%9]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 03:06:39 +0000
Message-ID: <531d3865-eb5b-d114-9ff2-c1b209902262@suse.com>
Date:   Thu, 26 May 2022 11:06:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <cover.1653476251.git.wqu@suse.com>
 <b014412ee0713e01f52269e553c0cff3487ca495.1653476251.git.wqu@suse.com>
Subject: Re: [PATCH v2 4/7] btrfs: introduce new read-repair infrastructure
In-Reply-To: <b014412ee0713e01f52269e553c0cff3487ca495.1653476251.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0124.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::9) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e3cd7bd-9978-4efb-c0c0-08da3ec4c0a3
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2933:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0402MB29338366D56DE6C312152B3DD6D99@DB6PR0402MB2933.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c1no6msIxM7PL0QuNr6hypIcHmxyP2llcOYxmSl3r/FVVemfKSQEngrpclez7Nhmrv/zK9uzLoE/EH3OXUsVfjUXjJZr+dT4mRjqaGSxHLB/5RhmeAbBhZgfIHWUO3SfdUA99MYQBCZPYVUkCSKvf+Q7cxUjzMBh7bwm6sZw353D2fNEOjKf1UXtNSQu+aG/RpfzqvvApUihyVeq2YJe1G0MAVmwnbcyqkWEOmdP6vnh4tFE6hY8KXkKSa2S3u3Wvt6UoRIn9cwvpm8xax6l0uYG4OoRC5m4Yv8Mn1ZXqVKrJiYlMZWYbxvcGRZ6B58FNSWyAZou4WCx0ucvbIKB1mhx2NFdimGPDkpa9QH1ZCY+Gbqd3v1yv2D5vFEm4/eVdBS6DQIG3rId8Qc+tDtUFFbnuGkNSVv7J+S9OgufCsy6Ohn1EOdKuQ+ho/RfFW2ey7A3hJfJrBHx+C66baJ0vWzKx8Vwd8ta3RT8P5lwzxlTdJHY1bWQKa77ZlBy0i/FSM4RxDIEJksQnAH/KDhEU1YHnHwmlp7LwHLUAAFQ4YHHYJJdJkie0FKq6nSC19OfyNSGu1H0X7jqODp0/feHO4CsbzK4rnULn3NmjoHgISEMMLzHWDD62FUKMyl7yakRugfDZAKMfOn6KiOPv2vZsrnuFjH7Nu+/tEEF1UKsKTpr/fg5xZDSYeAsdX0JaaauL9MaA/0ViTkSny3SPbN3iKgQ5qqbz+2mMZPyXiil34M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(5660300002)(83380400001)(8936002)(86362001)(508600001)(31696002)(2906002)(6916009)(6506007)(6666004)(2616005)(31686004)(6512007)(36756003)(38100700002)(186003)(53546011)(66476007)(66946007)(66556008)(8676002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUlBZVdMQUpGYlFHZ3BwQks2VGRWSVRaS21Na2hXYmRCdHlnc0lnV3JyejR2?=
 =?utf-8?B?eDB4K2xneWgwa0ZBSWtUL3RRQlhSNVlRd3h3NkttbVBYVXBRZWZDWUphTjRv?=
 =?utf-8?B?VjdpWGd5QkVGLzA5enp4dGRqWkJiU0VLamh5bExqWXZPa3lYcmNTVGJjd3BZ?=
 =?utf-8?B?VDdIMjZSdWk4TVF3U2NaVXJBd1pMS0d0Qy8vMkxaUWRFMFhUajZvY01FN1h1?=
 =?utf-8?B?MExsNnp1WUdxU0JtbWpjeGl3bGJ4NWRaQS9rZWN6dU5LMjZ5SjhrekF4aGJw?=
 =?utf-8?B?OVFWbGlwWDJaL3o5SForcVZYd0dpSDA4ZmtTM2RCL2Z5aTNBcDJUMHR2WE5s?=
 =?utf-8?B?SitOMkJEaDZRVnNycEdWOXY2RHVSbGgyZFd0L3d1OERGakwzSDIzaVl6MDNB?=
 =?utf-8?B?VmhaMkppdjRlVTgwYVBBbHhabVpsamhJeGdiaU1Tc082VHVoTmdwM3hwVEVL?=
 =?utf-8?B?U1J5bVoxMzRWM3J1N3drSUJ0NU1Ud2tzUGFlL1dCR01SMjBBdjJ2WmY3anFB?=
 =?utf-8?B?NFhPWVo5N2h5RDE3MURDSkZlL0lPNVV3TEF3Q25pQXVBL21JVVBnbng1S2lj?=
 =?utf-8?B?ajFlMjFmM1FDVFRkWDRvWmdxSjhXdklmY3hPdEFsbHhjMTdnRjVyOU4zUjFR?=
 =?utf-8?B?RXRtOFBaUFNUUnRkSjlkOUJaaE9rQnpaWTQ3N2VFUmc1NzZuWmF3NENSckdv?=
 =?utf-8?B?YmRIRDFQU3ZtZEwrbVJ2SGtuZDdJMjlIaUhVRE10M2JVbVc3dGZZQzgva01J?=
 =?utf-8?B?M2drSm1RaWQ4Znk3TDc5UG1zeU5jTmttTVhJWjZmd205Z2FVV21qa2FDZGJZ?=
 =?utf-8?B?MndFRHlBQTJyRzhwMlpYVytjckNEMitvb2NxOEd2NHdnZUJaa0lBMm9hRDZ3?=
 =?utf-8?B?Z2hwcjZjaGpIWHdBZFd0WGdOMThVRktlMEFoZUg3K3ZIc0R2NUVnNm1JYUFr?=
 =?utf-8?B?cTB1dXk2bTIwY05ZZUJKSXFySExDVFQ1YmwvT1U2OTQwcm1NTm9LSmJNTUhP?=
 =?utf-8?B?WW4vZHo0YmZEV3lvTkNSd2I1VVZjbHJkdnpPYVhvUG1GM0x6M3hhaDJjWGdn?=
 =?utf-8?B?Vm95R3dXUDVuTzhsVjBiRmRkUTBpRTVtOTIrSzU0THNOejVOc0FaV1lBUGtI?=
 =?utf-8?B?UllpS3dlTFpReTdMQnl3c0lGbXdYRXM1b3phTXNndGptbkU4eUJrS2l1UVZk?=
 =?utf-8?B?SVJWWmloeGpnQVZtMVpkZTVWdjJBa2t5Y1pGeDJyd2Z5aGhTR0JyN0x0ZlFS?=
 =?utf-8?B?UjJFNnFMS0g0TEMwZGNkbnFoS2JaZVlKbjl0REhnYWh6RGR3bnV2ZWM4alFz?=
 =?utf-8?B?Yk11SkdablJGNEROQ2YrNUhwR1hpZFppanUxSFhkNTE2a2V3dkRBNTRvMnAw?=
 =?utf-8?B?aFBkUjdYWk9kSkdHaWpsbU1PN3lxTEM5bzF3S25zc085bWE3VEtGTXVtSzZJ?=
 =?utf-8?B?cDB3a2ZHNXIxMVd2OFdzNkNWc3M2NCt5dEhSMzVWZ3ZBZHJYRFMrbVNmOGha?=
 =?utf-8?B?ajcybDU4dzVlWHRiL2s0dDBqejB1UXN0M1dibGVmMUtpMU5CN0hydTRUMzJu?=
 =?utf-8?B?WHIvRytIYnUyQm9SVk1PTWFMc3JudTVZWGczS2FINTZRQW9UN2Q2MzltWjZW?=
 =?utf-8?B?TE1YL2paak1uNmtoK3oxUC9FYmxDVStYcjlrV1l0MzQvdmUzcmhSYldMOHhr?=
 =?utf-8?B?S3Fjc0lWeGJKcnlTL2dxcjlJU2tnRFJqQjdVTUxRSFNtUFMvUVhRSHNrUkhI?=
 =?utf-8?B?UmV1MUJSaC9wazRzOS9qLzg2TXoxS2RiTkEzblVva1YyQnFQUWN6czE1c2Jy?=
 =?utf-8?B?SFFtdWQ2ZWJIM0dITTJKZHBRTHNxQlM1bllINzJnbVFtU0xXajlrRFdtc25n?=
 =?utf-8?B?U3FVaWx0c2RqcmN6eHJXUVYvNjRLNGU0N05YV2EwanZQeU1qRFJ0RmQ1dGNC?=
 =?utf-8?B?NVFmOTdNYjdmWjRJbGZrWDhNY1l0UzYzVmhvSm9WMWJ6T1hNV21LMHRrc09Y?=
 =?utf-8?B?Yml2blVzbmlyK1RPVnhzUUhZQVhrblVpUVlVeWhWZE5hMFlxWWl2ZXlVcFZw?=
 =?utf-8?B?OE5WeEdWYWxPMHJBZUZDbEVTWW5HMDE1NTZISi9WbUcvUUtVSldRRjJuM3Nm?=
 =?utf-8?B?UXlweWhFOEdqdUFiMFdLSFpQQXJaQmRPdXN6aTlKZXFNMU5BemQ5bnJ0QllZ?=
 =?utf-8?B?WjA3bEJkS2JGL3pEM0sxeWR5ZTBSV3ltYTRiMno3aFJ1WXlZUmcrRzZWcldq?=
 =?utf-8?B?YWlnZmZ4aGVPdVZHdFlzNjY5K2J4U0cvVC80UEZNUitaT0FhdEU2NFZnK0pK?=
 =?utf-8?B?enVWcmt2VWVCS014aWhuMzkrNnJKZVliYm4wMm9zc3YvZ3ZKV29JbU14ZTlR?=
 =?utf-8?Q?CtHIf23/ePh+NgoYRg7dhehgnS3rF1aTPAfiv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3cd7bd-9978-4efb-c0c0-08da3ec4c0a3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 03:06:39.4534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yyN5yrno7fd8KjGSUUp0sxzQAin2Y1nB832gB9l091lyrAHwKVBLDwt5kd9hL5P+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2933
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/25 18:59, Qu Wenruo wrote:
> The new read repair infrastructure is consist of the following 3 parts:
> 
[...]
> +static void io_add_or_submit(struct btrfs_read_repair_ctrl *ctrl, int mirror,
> +			   u64 logical, struct page *page, unsigned int pgoff,
> +			   int opf)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
> +	struct bio *io_bio = ctrl->io_bio;
> +
> +	/* Uninitialized. */
> +	if (io_bio->bi_iter.bi_sector == 0) {
> +		ASSERT(io_bio->bi_iter.bi_size == 0);
> +		io_bio->bi_iter.bi_sector = logical >> SECTOR_SHIFT;
> +		io_bio->bi_opf = opf;
> +		bio_add_page(io_bio, page, fs_info->sectorsize, pgoff);
> +		return;
> +	}
> +
> +	/* Continuous, add the page */
> +	if ((io_bio->bi_iter.bi_sector << SECTOR_SHIFT) +
> +	     io_bio->bi_iter.bi_size == logical) {
> +		bio_add_page(io_bio, page, fs_info->sectorsize, pgoff);
> +		return;
> +	}
> +
> +	/* Not continuous, submit first. */

Hi Christoph, I'm pretty sure the non-continuous bio problem is here for 
all of our attempts to rework read-repair.

I'm wondering if there is some "dummy" page provided from block layer 
that we can utilize?

E.g. We have the following checker pattern:

mirror 1	|X|X|X|X|
mirror 2	|X| |X| |
mirror 3	| |X| |X|

After reading all the 4 sectors from mirror 2, we know the 2nd and 4th 
are good and should not need to be-read.

Then reading mirror 3 needs us to submit two bios.

But if we have some "dummy" pages, and added into the bio for sector 2 
and 4, we only need one bio submission.

Is there such convenient page for us to utilize? Or we have to assign it 
globally?

Thanks,
Qu

> +	io_bio_submit(ctrl, mirror, opf);
> +	io_bio = ctrl->io_bio;
> +	io_bio->bi_iter.bi_sector = logical >> SECTOR_SHIFT;
> +	bio_add_page(io_bio, page, fs_info->sectorsize, pgoff);
> +}
> +
> +static void writeback_good_mirror(struct btrfs_read_repair_ctrl *ctrl,
> +				  int mirror, u64 logical,
> +				  struct page *page, unsigned int pgoff)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
> +	struct bio *io_bio = ctrl->io_bio;
> +
> +
> +	if (btrfs_repair_one_zone(fs_info, ctrl->logical))
> +		return;
> +
> +	/*
> +	 * For RAID56, we can not just write the bad data back, as
> +	 * any write will trigger RMW and read back the corrrupted
> +	 * on-disk stripe, causing further damage.
> +	 * So here we do special repair for raid56.
> +	 *
> +	 * And unfortunately, this repair is very low level and not
> +	 * compatible with the rest of the mirror based repair.
> +	 * So it's still done in synchronous mode using
> +	 * btrfs_repair_io_failure().
> +	 */
> +	if (ctrl->is_raid56) {
> +		const u64 file_offset = logical - ctrl->logical +
> +					ctrl->file_offset;
> +		btrfs_repair_io_failure(fs_info,
> +				btrfs_ino(BTRFS_I(ctrl->inode)), file_offset,
> +				fs_info->sectorsize, logical, page, pgoff,
> +				mirror);
> +		return;
> +	}
> +
> +	ASSERT(io_bio);
> +	io_add_or_submit(ctrl, mirror, logical, page, pgoff, REQ_OP_WRITE);
> +}
> +
> +static void repair_from_mirror(struct btrfs_read_repair_ctrl *ctrl, int mirror)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(ctrl->inode->i_sb);
> +	struct bvec_iter iter;
> +	struct bio_vec bv;
> +	unsigned long old_bitmap = ctrl->bad_bitmap;
> +	const int prev_mirror = get_prev_mirror(mirror, ctrl->num_copies);
> +	int nr_sector;
> +	u32 offset;
> +	int ret;
> +
> +	/*
> +	 * Reset the io_bio logial bytenr so later io_add_or_submit() can do
> +	 * correct check on the logical bytenr.
> +	 */
> +	ctrl->io_bio->bi_iter.bi_sector = 0;
> +
> +	/* Add all bad sectors into io_bio. */
> +	bio_for_each_sector(fs_info, bv, ctrl->bad_sectors, iter, offset) {
> +		u64 logical = ctrl->logical + offset;
> +
> +		nr_sector = offset >> fs_info->sectorsize_bits;
> +
> +		/* Good sectors, no need to handle. */
> +		if (!test_bit(nr_sector, &ctrl->bad_bitmap))
> +			continue;
> +
> +		io_add_or_submit(ctrl, mirror, logical, bv.bv_page,
> +				 bv.bv_offset, REQ_OP_READ | REQ_SYNC);
> +	}
> +	io_bio_submit(ctrl, mirror, REQ_OP_READ | REQ_SYNC);
> +
> +	/* Check the newly read data. */
> +	bio_for_each_sector(fs_info, bv, ctrl->bad_sectors, iter, offset) {
> +		u8 *csum_expected;
> +		u8 csum[BTRFS_CSUM_SIZE];
> +
> +		nr_sector = offset >> fs_info->sectorsize_bits;
> +
> +		/* Originally good sector or read failed, skip. */
> +		if (!test_bit(nr_sector, &old_bitmap) ||
> +		    test_bit(nr_sector, &ctrl->bad_bitmap))
> +			continue;
> +
> +		/* No data csum, only need to repair. */
> +		if (!ctrl->csum)
> +			goto repair;
> +
> +		/*
> +		 * The remaining case is successful read with csum, need
> +		 * recheck the csum.
> +		 */
> +		csum_expected = btrfs_csum_ptr(fs_info, ctrl->csum, offset);
> +		ret = btrfs_check_sector_csum(fs_info, bv.bv_page,
> +				bv.bv_offset, csum, csum_expected);
> +		if (ret) {
> +			set_bit(nr_sector, &ctrl->bad_bitmap);
> +			continue;
> +		}
> +repair:
> +		/*
> +		 * This sector is properly fixed, write it back to previous
> +		 * bad mirror.
> +		 */
> +		writeback_good_mirror(ctrl, prev_mirror, ctrl->logical + offset,
> +				bv.bv_page, bv.bv_offset);
> +	}
> +	/* Submit the last write bio. */
> +	io_bio_submit(ctrl, mirror, REQ_OP_WRITE);
> +}
> +
> +int btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl)
> +{
> +	struct btrfs_fs_info *fs_info;
> +	struct bvec_iter iter;
> +	struct bio_vec bv;
> +	u32 offset;
> +	int nr_sectors;
> +	int mirror;
> +	int ret = -EIO;
> +
> +	if (!ctrl->inode)
> +		return 0;
> +
> +	fs_info = btrfs_sb(ctrl->inode->i_sb);
> +	nr_sectors = ctrl->len >> fs_info->sectorsize_bits;
> +	ASSERT(ctrl->len);
> +	/* All sectors should be bad initially. */
> +	ASSERT(find_first_zero_bit(&ctrl->bad_bitmap, nr_sectors) == nr_sectors);
> +
> +	for (mirror = get_next_mirror(ctrl->failed_mirror, ctrl->num_copies);
> +	     mirror != ctrl->failed_mirror;
> +	     mirror = get_next_mirror(mirror, ctrl->num_copies)) {
> +		repair_from_mirror(ctrl, mirror);
> +
> +		/* All repaired*/
> +		if (find_first_bit(&ctrl->bad_bitmap, nr_sectors) == nr_sectors) {
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	/* DIO doesn't need any page status/extent update.*/
> +	if (!ctrl->is_dio) {
> +		/* Unlock all the pages and unlock the extent range. */
> +		bio_for_each_sector(fs_info, bv, ctrl->bad_sectors, iter,
> +				    offset) {
> +			bool uptodate = !test_bit(offset >>
> +						  fs_info->sectorsize_bits,
> +						  &ctrl->bad_bitmap);
> +
> +			end_sector_io(bv.bv_page, ctrl->file_offset + offset,
> +				      uptodate);
> +		}
> +	}
> +	bio_put(ctrl->bad_sectors);
> +	if (ctrl->io_bio)
> +		bio_put(ctrl->io_bio);
> +	memset(ctrl, 0, sizeof(*ctrl));
> +	return ret;
> +}
> diff --git a/fs/btrfs/read-repair.h b/fs/btrfs/read-repair.h
> new file mode 100644
> index 000000000000..87219c786109
> --- /dev/null
> +++ b/fs/btrfs/read-repair.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BTRFS_READ_REPAIR_H
> +#define BTRFS_READ_REPAIR_H
> +
> +#include <linux/blk_types.h>
> +#include <linux/fs.h>
> +
> +struct btrfs_read_repair_ctrl {
> +	struct inode *inode;
> +
> +	/* The logical bytenr of the firts corrupted sector. */
> +	u64 logical;
> +
> +	/* The file offset of the first corrupted sector. */
> +	u64 file_offset;
> +
> +	/* The checksum for the corrupted sectors. */
> +	u8 *csum;
> +
> +	/* Current length of the corrupted range. */
> +	u32 len;
> +
> +	int failed_mirror;
> +	int num_copies;
> +	unsigned long bad_bitmap;
> +	bool is_raid56;
> +	bool is_dio;
> +
> +	/* This is only to hold all the initial bad continuous sectors. */
> +	struct bio *bad_sectors;
> +
> +	/*
> +	 * The bio we use to do the real IO.
> +	 * This bio has to be btrfs_bio, as btrfs_map_bio() will utilize
> +	 * btrfs_bio()->device.
> +	 */
> +	struct bio *io_bio;
> +};
> +
> +int btrfs_read_repair_add_sector(struct inode *inode,
> +				 struct btrfs_read_repair_ctrl *ctrl,
> +				 struct page *page, unsigned int pgoff,
> +				 u64 logical, u64 file_offset, u8 *csum,
> +				 int failed_mirror, bool is_dio);
> +int btrfs_read_repair_finish(struct btrfs_read_repair_ctrl *ctrl);
> +
> +#endif

