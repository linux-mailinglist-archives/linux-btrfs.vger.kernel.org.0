Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957E9415BDF
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 12:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240314AbhIWKUu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 06:20:50 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:57610 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240277AbhIWKUu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 06:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1632392357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHrCf0jZ1YC/hAbo6kN1fkXfnUN7LjA0J6Jh70lm1KI=;
        b=gczwA968aGO/Twf3SjicBabYTVnyddi0naanj4hC3pRdecCwhAdFGA8PzSFPHkw54hkwPK
        Xc8A5s6mKOZ1rBMKd3EjQdB26I121GBlWSyMHuWUTa0q7Brw/dB+1OeZU6nj4bVF6TPl6o
        eCr2ro20ZeHjZ66474Xz9WWPnp3teAs=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-24-GILX8ociMLKWH8n0Zu2PiQ-1; Thu, 23 Sep 2021 12:19:16 +0200
X-MC-Unique: GILX8ociMLKWH8n0Zu2PiQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d81HmSvQDiq/z/x0V/mhA6RTGwMhbqOCv0D+lcVbVC+h9EGqr4McVZArPGeYM0rWhoqrmqVDzZ3qz56vGESj+4TXdXhp+2muaXC/fbL2zKVLW/+anfy4/GzGJSYJn8o5+7FhCcjr40w7uQTbBTsCHKPUGYXXwGskTcbxgHmEvzQ2LKrEDow5l5WANCgiq0PsUXreUjpH/ScmnVhF2CAxYqzUu1EP+Q1aE2/F4KBBDDej20EB0rOMiW1lm86bqvRHk30NkyzF35Th/86bwNxPpI17Hc7/t2l4ZnPBJWMcWiX3Bc7TSjCJEhNYizNfjyNi57mZQTZfpSDkzZVIxqyJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=KHrCf0jZ1YC/hAbo6kN1fkXfnUN7LjA0J6Jh70lm1KI=;
 b=bkZD+Q0VgDesXizESd73XjN2kBc+8ese7M/RY/VClNYxsk45BLNRS/1qW/zfIDsjD/wHoy23zUH5eVA0w62kSMdeLWdp/S3xZl+Gj8tzJn67VnGwxGtHtWpHAk26bmQkIOa9bqgUhtUT1wuAiwPSGHUUXTren6LevHE1sT48JaOs3tB7KQFLOnB+5u6xLUSz6SixfsOLEZOPHk30ASg4kSPLsxHZeiyGl9SUveCT51hYZGouDm5M6UBLruHojz+7SXo9Jzq35TOvdxQ8GwGJi1+1guUCWuo629NYPpqAS27DXXs3GnJQMI/RPKuH9x0iGmn2IBZ2b90DWyLASavFgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4279.eurprd04.prod.outlook.com (2603:10a6:209:4a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 23 Sep
 2021 10:19:14 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 10:19:14 +0000
Message-ID: <8af945a3-db88-d1b8-bba3-3f6180f91fcf@suse.com>
Date:   Thu, 23 Sep 2021 18:19:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Yuxuan Shui <yshuiv7@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com>
 <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
 <CAGqt0zy6a8+awo6ifUn4x+WxN=c6e8PnuMW5kYRodxOQ6vwU-A@mail.gmail.com>
 <72d66f13-6380-7fcd-3475-8152caa965c4@gmx.com>
 <CAGqt0zz+=nUYbNwLSPYwzYcNLgyxsWT22p+jwwFpAOcyAHAWgA@mail.gmail.com>
 <e83029f0-8583-91b9-47c8-a99d4b00a6ae@gmx.com>
 <CAGqt0zykaioT1LJAtOM8Zc4eJBXxTEy2ugBrLpgZ=BzCJzixXQ@mail.gmail.com>
 <CAGqt0zwchNdLKz4_qHrdbuxx7RWY9YbdiZ4KBYJcrwWa3sxBZw@mail.gmail.com>
 <529263b6-4ff9-1bf6-8566-ed1ec648a539@suse.com>
 <CAGqt0zxrm=A8v7Mm6CDNUv77Sxsgt_kp4uJpCbpbCGXrnUmBqA@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: btrfs receive fails with "failed to clone extents"
In-Reply-To: <CAGqt0zxrm=A8v7Mm6CDNUv77Sxsgt_kp4uJpCbpbCGXrnUmBqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::24) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BY5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:1d0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Thu, 23 Sep 2021 10:19:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 033b3379-00bf-42c5-dcaa-08d97e7b9806
X-MS-TrafficTypeDiagnostic: AM6PR04MB4279:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4279F32E3AC106C6EF017021D6A39@AM6PR04MB4279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHk4RUP8D6aZlPx1b3dQ0TaEKLJq9nUkxKQtRXctmxCY0JUIcqAXp4dnjV3K+bChJHYEI2bjfJIbk2C6M5j3yK3eXomwMZ/g810+CnyHRjVzVKAF/FcwWMC7nJMIojRNqxywlrVD3uAgStEnnv5KjkI9m2Vcfnul+tk96zv4FlCYNTGQb0l82x6QEEuw7mo0tuAn76Dp76OzquR6GPzp2siEvymFLbWuxUn/uVMyZzR9StdsjL8AKWcGyYCgiTbgrHZKrqI6NlkeLU9sPMx2wZ5i3BWJZQRjc3Yps9UgwjnbFzucUB3BAA6jUGOSDQtDU1CwwQb/JzvqlxULDfQTHqgsIh6sxP/7GiHXeeGiu35S0MABXZl2QD5YBkzSoK1M/tH+91+EzzSDf0ZKVAOofO/PoK0/jKP/GBJDtQ3zEXWFRYC21dWrzfhjBoN8fkhOOGFdS/m0M4JgdmtflATA3klaL+rTQH+Zl/8BtuotOFtsdqdVrW+1rPjBeFJ27Xuu/EYymUWgVLXEhklFSfpM4mHfeDUR0sKa8JKqim2hcaZopAfPqa5VDQN5vkS5HcQWsxJdsLx+NjSq9HIvgvQ2zcoeFOfUo7Ot7eVvVw8x1iN3bNQndSVwWt3XNETkVb8BhMTRuy0N9LKPIlZFXM4xHaBKKjwz5EDGW8JI0Qtn2Kv1m3NIQItrhOiX1gmhQeT8vxctvQa5fohYOmSLc/GUHBRuRov/fWKNeW22+mh6/sYSLx5G93Af1rvvk/3CKlPkLVcR9UL6D/Hj3cPI20lpzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(36756003)(6666004)(2616005)(508600001)(186003)(86362001)(31696002)(38100700002)(31686004)(83380400001)(26005)(66476007)(66946007)(8676002)(66556008)(4326008)(6486002)(6706004)(6916009)(316002)(5660300002)(2906002)(16576012)(53546011)(8936002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXFMUFpvTmRwZzZyYmY0Y0JxZWFjbnRjWmhnc2c4Nk04UWRxc1RrSTMxMWRM?=
 =?utf-8?B?MDQ3REJmUHMzWVV0Skd5L1lsaFZ1L0NPTVNZcFI5TmZCRThHRGcxSTdQSHps?=
 =?utf-8?B?R1NvSjBYRjFYS09TSGRtSkdnbXg4ZnVSbUNrdlVkWmYrOGU0R0RyeThGSzJT?=
 =?utf-8?B?SnlnUFJBenNycHpGb2d1VzhPRU1jNFJUSlBEUTVqQUtZT2lJUE5xdlVxYlNE?=
 =?utf-8?B?ZHA1WkVlQndqeGJtMGZCMGVzdWI4UHUwZ1A2REo0d01KL0xJREkvQ1dkYXZL?=
 =?utf-8?B?MnAyQXp4emZOVGxtMituY0dzeFR5enJQVU1zN0lKRGNCMWRuM3NUT0J2UGhi?=
 =?utf-8?B?ZTd6NWViUzgvNGNXcDIzNVRqR1E5cVRIcktsekxHQzFaSENTaE10bko2RzBp?=
 =?utf-8?B?RTJZQUkvUm1VenlaMk5JK0w5UjA2dXdDMlBKU0xXYXFJTWZTeFM5bG5aa1Rw?=
 =?utf-8?B?ZFNTYWF1QlErZ1UzcnJ3YUw5RHcxMUZyVzFxdVVpbVBITU03Q2Jzc1pseHF3?=
 =?utf-8?B?WUxzbktYUm9zL0ZkY3hHR0NucnNZS2hJMm5qK2NwRnlhK1c3UzNiNkYxS3Bk?=
 =?utf-8?B?TldCdG1OZFVFYzhLSFUrZGtuMjdrTVc4VFlUYVJKZzQ2c0ZMRU5ZbTRxVFg1?=
 =?utf-8?B?eVpQM0xNa3RIb2J1RzEvMVRCaFVZVjFZbDczZWlaUlhEN2duS3FwT3ZoeUU2?=
 =?utf-8?B?d1p5ZjlFK01mQWo1S0ZYL0JuUk9sYUF3emVlYi9tdzdWTXdrMTN4WjJzNVVx?=
 =?utf-8?B?M0E0M1h5a29CYTNaYzdQRlMxUFhRMXE3c3dNUUozcHo5ZTZNOU9UVC81OHR4?=
 =?utf-8?B?SDhiUmhKL0YvZUxCVTNKdk51ODAwNDBTLzBNTDduS2k1eTVqd2wwVU5MWUhZ?=
 =?utf-8?B?TDhoUDNaWEhUY0JncXdPa3FZSk1RNy9ZNlZlNmFaNWRFL0RMalpGb2FoSFND?=
 =?utf-8?B?SDlMcmJFSlh2Sm1zMG5ycU1VUnFwU2hpK3Mrbml0WGJHMU9MVlV3L1VZRDhk?=
 =?utf-8?B?TGRtUW5MYWtqYVYyVjAreDNTcGszN1UwZEY1SGZyVW1UY3lRUUs2VC81Z1V4?=
 =?utf-8?B?UzFrUCtCRkN3bEFBVy9ubzF4a054RStQTkZPSnRzMHREZzhtK1IxejBoV1ZO?=
 =?utf-8?B?dGdnUTBBNlZmUElnNG84dm1YeVp3aUIyWlNuWGZPSmNCMmNXaVBkNWk1YnVM?=
 =?utf-8?B?RHZpcTErdnIxa2JSL25ncWlmaG1YSytINjlFbHhiZzg2cGtkYUZyQzdwOXlw?=
 =?utf-8?B?ajlDZldsYmVpN0g1TWtlNW1Wdy9tSzE0NkFTdkdvY0tzQWRuOFFBdURhQnY2?=
 =?utf-8?B?MXJVSUxzTURiMTVNSlJWUXU2U3VwRThMWDJpc0JDWllmS2RZOWY5SHlOZGxy?=
 =?utf-8?B?dU1HSS9iVWtjc2cxQTBhYldHeEk4MEpaQm5uZ0xxQjl3Nkc1QWlqUzc1V2NY?=
 =?utf-8?B?eEFhKzBvdHpNTFRXdUtIb1pGUnV5ZUhvU0JBSTk3VFpXcTVGTkV4VCswWFFo?=
 =?utf-8?B?NVFNZ1g1MzlNRitlN0FvWktNdlNkaHo5WHRRSjVFM0lJaTA5cXkrTmt5VHYr?=
 =?utf-8?B?NiszK2tuNkhaak0wYU9yZUpHVzZhL2YvRkdqSVRPZGM5ZUR3Z3dkZWVYWDVS?=
 =?utf-8?B?MjhEYVUvTGVUNmlFV3BoaElCWlB3eFprZXRnWUJEZXdxTExlV2I4TmRjeFlY?=
 =?utf-8?B?UVdPc2F3Sk1KRnl1Unl5RnIvelhhWlB0UDdUVDJWMDVFQ2lVVGFDejBCV1Vp?=
 =?utf-8?Q?sOePTxMt4elQjwnyLHt2SJ8DX/Zq67LmVaJ37Bg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033b3379-00bf-42c5-dcaa-08d97e7b9806
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 10:19:14.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rL8ZzC4k4CLc06hjaHxQ1Ix/5v+tXSxlw+gTerU9TuWmXExGQVhjP0DO00hzyovZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4279
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/23 18:08, Yuxuan Shui wrote:
> Hi,
> 
> On Thu, Sep 23, 2021 at 10:45 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Mind to provide the full send stream dump?
>>
>> This indeed looks like a bug now.
> 
> Sorry, this might have data I am not allowed to share, and I don't
> think I will be able to vet all the files in the stream.
> 
> But if you can let me know what I can do to help debugging, I could try that.

That's totally understandable.

Surprisingly, I can't even find a proper way to get the nodatasum flag 
per-file.
Thus I guess things may go complex by using "btrfs ins dump-tree"

For the receive failure case, mind to provide the following info?

- The inode number of the clone source
   You can use 'stat' command to get the inode number:
   $ stat /mnt/btrfs/file  | grep Inode
   Device: 29h/41d	Inode: 257         Links: 1

- The tree dump of the clone source
   $ btrfs ins dump-tree -t <subvolid> <device> | \
     grep "(<INODE> INODE_ITEM 0) item" -A 5
   	item 4 key (257 INODE_ITEM 0) itemoff 15883 itemsize 160
		generation 7 transid 7 size 0 nbytes 0
		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
		sequence 3 flags 0x0(none)
		atime 1632391968.333333415 (2021-09-23 18:12:48)
		ctime 1632391968.333333415 (2021-09-23 18:12:48)

    <subvolid> is the subvolume id of the clone source.

- The tree dump of the clone dest directory
   The inode number can be get using the same 'stat' command.
   Then pass it to the same "btrfs ins dump-tree" command, with
   <subvolid> <device> and <INODE> modified.

Then we can be sure what's causing the NODATASUM flag mismatch.

Thanks,
Qu

