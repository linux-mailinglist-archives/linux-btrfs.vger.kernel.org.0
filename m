Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16EA542D12
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 12:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiFHKUZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 06:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbiFHKTL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 06:19:11 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2705D2C3B26
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1654682790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1uiI8RElVrl8OXC/3qGsp8HjAaXxyNYJ+C/L/gc9Hs=;
        b=VQqmO++NLsScvjKEu8wAOX+zkfcNsHg6Fxrz23NomqteQnXaTf7I5aJXYp9gP8TyXxpZkH
        FGBjj8fInZtbVmpdgInB95KkGXxboTR02Mt6U3dxk/1xSshkSOOzS51JAwjWtA8pisKIjX
        VgiPK9QZ6jAdbn80JOkXZzoPfUfjInE=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2050.outbound.protection.outlook.com [104.47.2.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-795LE847Ozi3fObx1aP33g-1; Wed, 08 Jun 2022 12:06:29 +0200
X-MC-Unique: 795LE847Ozi3fObx1aP33g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7mXHk1qZ798TZAxfg3rT9HfCHhPV7ZFztWblot2cZijrpguYmRAyhbKxHY3ezmyw16DXOoZSV30k3ntA6xhT46CD0yNDTzluk6trVLlz2cdBUK2D15GDSIuOgl/NAOwZoWqQkZGfEdMqRa9gOXLuZY+6Sw4VXQg1c4yglTxbbThhUigcaUuJExn8yKca4jZcPQvthowP3BW5qNBkideMZsWVizBsuZEYeCfDGGiJKnOijcxN5R5vwpmrfJvD8l/YWXXKthQGMDEld2a0AK8QHy9zK8a/Mtobjw1TzOfepW4hx3Q5t8eDAVaIrohcKAn4Exus/d+rdGIVnmAKtn+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1uiI8RElVrl8OXC/3qGsp8HjAaXxyNYJ+C/L/gc9Hs=;
 b=NwKYjmKOJeRzEYTklKNU2xhdiqx52xrMldgo6ZqgVlMDfsPGU8FfTzZ9yvD1TUHkC/qI9L6o/znrcQWre05TIpd/lEJznOy5PALq+yTD1gxnq0N2b4/ObZn7xQcdNPeKHemrqnnxVqYz/YC2TUFRc6f3tMa1vxtRtjNvAQKpsm4aW5V9Kk5Ef434IIw3ZKl5rKru++eXyfZvOy5agTTix94Eeg1ZWdMBaJAVs4pIM7X7HZYAwtQkdLAxK8+CbyHXFgEs7K+r8iOlFpgehT9XX7MXQY9pRhtGxU3Q4afcwBbAMjK0cur+i9kXvniFHTFev4IqfEuzNrduBhGrIAeIaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1uiI8RElVrl8OXC/3qGsp8HjAaXxyNYJ+C/L/gc9Hs=;
 b=Ftn4HjNUlZZ7OAr/oQ3Prp0D2cieZGySSl/wDCPuNOqNN+s2wvOvmaU0fFB/LwwHUsLYVRYkp0MFxIkYjQgFOQ8PDdKmIRlXtMKjGUYOj/yjmNAaajeMtCY4Ft2JoenV2OrBT4UolTg1SDaHgMNUPKngJBRRMopp/Kbxla25apCIG81GmP7MAU2gDVyOa7TYGrrDEIyd+8lJ/Y88JSIS3FjRh+tFzGqfBgXULlZ3Sq/8HxZXWxWKtKBvdFcry+DiLRA1odpyRvc3G2R2Sw0/RYG5le69S7oQUaDP+dPHC8Pod559qiqE41HUphDZKfkozOwAXFTa4PzC7aQZ6Hnjqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR0402MB2751.eurprd04.prod.outlook.com (2603:10a6:800:b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 10:06:27 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::a57d:280a:598a:85bf%9]) with mapi id 15.20.5332.011; Wed, 8 Jun 2022
 10:06:27 +0000
Message-ID: <b4a9889a-2c9d-8f74-985b-f0b7b176a1fa@suse.com>
Date:   Wed, 8 Jun 2022 18:06:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org
References: <53f7bace2ac75d88ace42dd811d48b7912647301.1654672140.git.wqu@suse.com>
 <20220608094751.GA3603651@falcondesktop>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: don't trust any cached sector in
 __raid56_parity_recover()
In-Reply-To: <20220608094751.GA3603651@falcondesktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e0269df-8549-4322-d86c-08da49368d16
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2751:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB27519D9F1B45348FF3D3E0FDD6A49@VI1PR0402MB2751.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WpFs3AXRxp2BNovRqfNPtstIHq7qu6b6DXNhngvzlX7twCdiJ/B/Wr4eJw492QQ/z1YxMcX6k4L7SG+gyHc+353Du6VUI/XSTtTiDhPgI1MQVX5O8U/wMnlaCtcwK5Oj06enMk529UJtldFXlFVG/OWRtGYh4t154YKt2wD61i7AfHatfEV+eUndAxtIgji/eoCSWljQzD/pyHCi3ATrOmc8BHdIif9vNuCjWvfBriD67fBy8hBdfMdcBzBF5O2OzaYXhBdK9cOxKhGGfx+LK8lEvwZ3ZiGKy6n7LIDVKqWeHdwukyT/d6nht29l6C3JKM4Hm9SNjxPQ/CSxVMlr2cTZmqiY9A2SPFUuV2c3pwyyDCCmM5LtHrQcMTS1tQruz72OJedsce8+u/z40WwKGPgQ37GNqvJXJuvS9dIfwk9C9IV1MjdKLV7BJXk523D/rMfcpUSFQVxYYqosT1uCL40CVXt7gA/51BlFnX05bQCtKVl4jL/nmg79bJXWgEB6kMXkOKlktqSf7Rsf0n1UYpdmYi+u3HsJEigY7YcSNWs3DbXBsTgRQJpuWqHdtnPBfdisjwwPtjwMEHOFvyLi8+OYnof7OxJ5NWOV7KD+TPiiW8iJNs8TRHx2pKEzfZyFaWsbvL34pdpqA35MeFmI03XbSWU6/F8f95NlPl/mhXQXF152P8jo12mEljB/oaYl0nOj2CHakfJcVm7ocOmUYji9wCz9JAegjK8k3CHgrPEZcyydpDMdzoBUSLCkF01kdnh736iV/3+hf7m3DtlQVnUagCi68VDO5tY1AT4Pg3srRowTbO5nSKF36PuL8/+W+H3dxyYDADxveTHhfP5Qv6xPiz+pS2d9ojgSt4qhL/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(6486002)(83380400001)(966005)(36756003)(508600001)(6666004)(6506007)(186003)(53546011)(2906002)(2616005)(66476007)(66556008)(66946007)(31696002)(5660300002)(4326008)(30864003)(316002)(38100700002)(6512007)(86362001)(6916009)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTdiZGZFSkYvSld3R1kwa2hYNkRZRUdYZFNWT0NwTGg0cWUyeVE0Slc1eExo?=
 =?utf-8?B?VHlzWXI2VnorT2NqM2tVeHU4d0FxWXpVK3I2LzFsL0d4R3lJczExa1BpMnhE?=
 =?utf-8?B?UE1lb2pqa3NqV25VSHJSdWlwdy9mVzJWVHZDcmdzd3I3VXNmSjZZM2lSaDNF?=
 =?utf-8?B?ZkNNbndIWWpRT1FtalpUZitjdkFXMUNRRXNtaC8rSU8vL2RzY2ZCdlQvSC9k?=
 =?utf-8?B?bXN1K0VLN3lyUlZnT0M1SER3MmRKWGsxbjFOdG8yQ2g0aVVsS0c1QytXUlA1?=
 =?utf-8?B?VUYrU202Y1Z1czFuRlM3VXdsdi96cmxCSllnTlBrWUNseUxKcEdYMzcxandz?=
 =?utf-8?B?VmJvYWViaWJ5SUY2bmc5eFZjeExxRVJ5Z0l6TmRZMGRVUjhXaFJBcW03eUVp?=
 =?utf-8?B?L3dHM3hOK0ZFWXF5dWswN0NLY3daQjh6NzRsSGVaOUVMRnlWMmdsMWh0U2E2?=
 =?utf-8?B?SzRla0tFVUFJbVRLQmMxVk5iSjREbU9MRWwrRFdqUFRpTUV5K25VREw5VWVW?=
 =?utf-8?B?V3dXRmdRVXFSRmh2TGd6Q1VpSjBiTWo2eVFGV0x6dEcwNXorNEtNd1ZDaDM5?=
 =?utf-8?B?bnVRRGdaMXpwTk1sMitwb2c1c3RRbTROR1hBZERxWkpZU2ZwczRYR3RRVDF4?=
 =?utf-8?B?WVZDNWViS1BIMS9YckZrd0Ryak5nSlgwT01TTVkrUVNLOTRybHp2NGcxQzB6?=
 =?utf-8?B?SFU4UjRteVQxM0RybjlTTC9hbWsvVU8rblRSTXl0aUdjK2hxOXhTMEY4NmJj?=
 =?utf-8?B?QmxzUGQzbWxsK21NSU5FS0F1RklpU1BpbnIzYnkvYmVHcE44TER3R3h5aGNB?=
 =?utf-8?B?NzJ4dm5pQmc4SjhidGw2cndDdktCWjcvbk5BcElLb1B1czdRMW1RdXBEbzFj?=
 =?utf-8?B?NGZRb0t2bEhIUGI5cWpBWGMyS0d0SGU2N3dRY3VNZ2ppaU5pMGd2VVhaTmNt?=
 =?utf-8?B?YXcrd2paL2NYOVRheS9FZWZ0Y3RIOVJ1WUN2VVp6YjJ5bitxbGllVUhJZmY4?=
 =?utf-8?B?bmpLN0xuQ1JZWEJpWW54R0R6bEZXQktvWUNjZnNVUGhGZjY3dmpZOHhOZEZX?=
 =?utf-8?B?TU10OEdSNDgxL3EyRFpYbHp1eFozdERvWVkyTDN2SEpGbDJqV00xU3FtNnlz?=
 =?utf-8?B?ZmZJanFiTjR1MXpUdHZXQm0rRzJCbzVFU0k4Vnp4NjFMN0w0SE13UWlMVVFQ?=
 =?utf-8?B?eTV3Y1R3QXFmRkM2Qk1VeTB6ZWNRbHNndXg3dFRmV0x4cjBuZWFxcE5JQktl?=
 =?utf-8?B?M3QwVkhxcWN1WHc0Y2Z1dkE3VThRRkFEY3V4YVNLcUExdmVqQm5NbG54Y3Bi?=
 =?utf-8?B?SlNJcWVTSTJtMzd0aWk3ZENBcTE3RlUyaGxuY0huWUdRcTU5NHhQVkNSa1Vm?=
 =?utf-8?B?T2ZEWVBTMGJtbGZFbjJZMmFNSisray9GZHcvTElGS0xNeG5GMEVxUUpLeDNG?=
 =?utf-8?B?Tk15YkNxMTcvZ1FZSE5PS1RKUWVuZWVQQ05pdDFNUHgxWll1eE04YUF3RTNF?=
 =?utf-8?B?TUVmZ0oxU0xxaldOWmh1VmJPYmVVbFliUnNwbzVvRVI2WEdDY3dwQitoWkNn?=
 =?utf-8?B?bnhqRzJETmVUc2JjVWRSY1M2anV4MC9zMm1IL3RQMG1Od0RTNjdFNENadDFQ?=
 =?utf-8?B?Vnc4NWM0R3pUanJySXNFZ28vQ25sMDVBWlhRdzVwVk1pbFY3bzRhOHQyOFE1?=
 =?utf-8?B?VmJqeGpCV0JtRE5DbEZlNjEzYmVaWHc0QXpZMmNsSU1WYldHYnR6QW5jcUdm?=
 =?utf-8?B?b2xibzF0cVBEQzAydHZMa0QwTXQzejd5enhDQlJjeTlZMkNhQ2UySlhIWUIx?=
 =?utf-8?B?TXJvU1F4RTJuUmpVQ05zZzRQbUtRdFdDR2xqc0xNWGpDU01idEFmK0tvbnZP?=
 =?utf-8?B?Z0NMRlFSc3JnMmlxbXRhbExEMzVTM0t5NWNmemRueVdYSktTcmRkaFhwZkpz?=
 =?utf-8?B?TTNGTy9PQlFTbUErbExsRVFDMkdVN1FXSC8yYWhzWllidGp2eWV0U0o1N2dO?=
 =?utf-8?B?dXZwb3NMdVpjaHd0cHhlUHhpNGRzRnlNWDh3eE56ZG90SDh0SlhvdHlLNjRJ?=
 =?utf-8?B?U1FzQ1FLQ2lJK3o5ZFlPQ0lKSWE2dlUwcHJSemp1TnFqdS9RbHpRWG9BWFIz?=
 =?utf-8?B?VjV1OWI0QU5BQjBmZ1ZTekZBZmFZMGhuOGEyc056U1lPWGVCMUFQRndNQ045?=
 =?utf-8?B?WG1QUWpCNGJXczAxR3M1bXBsOTZ5eGFnY3FidjZ2eFNGYWlXVkxPRnJUMUkx?=
 =?utf-8?B?eXdLSDMzb1llWTArN04zSkNVcit1bHJjTnM3Q3dLeUdaeGkzWGYyaU9DSC9l?=
 =?utf-8?B?OURRV0xVWDFDL0FEZ1Rod2x4d0ZBN0U5TWdMbUtxN2V0NnlHbmZ5UFluQk5W?=
 =?utf-8?Q?y2ugH9jXnKb65ZE0bAZ391uVA0EBv1hB3oZ0v?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0269df-8549-4322-d86c-08da49368d16
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 10:06:27.2054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tV53ynTBEBTxzDfCfyozCD0qyjQ1/arjawKnUth2i3rw/9Mxi4HKG3wlAZcUqsLn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2751
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/8 17:47, Filipe Manana wrote:
> On Wed, Jun 08, 2022 at 03:09:20PM +0800, Qu Wenruo wrote:
>> [BUG]
>> There is a small workload which is a shorter version extracted from
>> btrfs/125:
>>
>>    mkfs.btrfs -f -m raid5 -d raid5 -b 1G $dev1 $dev2 $dev3
>>    mount $dev1 $mnt
>>    xfs_io -f -c "pwrite -S 0xee 0 1M" $mnt/file1
>>    sync
>>    umount $mnt
>>    btrfs dev scan -u $dev3
>>    mount -o degraded $dev1 $mnt
>>    xfs_io -f -c "pwrite -S 0xff 0 128M" $mnt/file2
>>    umount $mnt
>>    btrfs dev scan
>>    mount $dev1 $mnt
>>    btrfs balance start --full-balance $mnt
>>    umount $mnt
>>
>> In fact, after upstream commit d4e28d9b5f04 ("btrfs: raid56: make
>> steal_rbio() subpage compatible") above script will always pass, just
>> like btrfs/125.
> 
> For me it still fails, very often.
> Both before and after that commit.
> 
>>
>> But after a bug fix/optimization named "btrfs: update
>> stripe_sectors::uptodate in steal_rbio", above test case and btrfs/125
>> will always fail (just like the old behavior before upstream d4e28d9b5f04).
> 
> And I'm running a branch without that patch, which is just misc-next from
> about 2 weeks ago:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=test_branch

My bad, the whole situation is more complex.

The recent RAID56 is a hell of fixes and regressions.

Firstly, there are 2 conditions need to be met:

1) No cached sector usage for recovery path
    Patch "btrfs: raid56: make steal_rbio() subpage compatible"
    incidentally make it possible.

    But later patch "btrfs: update stripe_sectors::uptodate in
    steal_rbio" will revert it.

2) No full P/Q stripe write for partial write
    This is done by patch "btrfs: only write the sectors in the vertical
    stripe which has data stripes".


So in misc-next tree, the window is super small, just between patch 
"btrfs: only write the sectors in the vertical stripe which has data 
stripes" and "btrfs: update stripe_sectors::uptodate in steal_rbio".

Which there is only one commit between them.

To properly test that case, I have uploaded my branch for testing:
https://github.com/adam900710/linux/tree/testing

It passed btrfs/125 16/16 times.

> 
> This is still all due to the fundamental flaw we have with partial stripe
> writes I pointed out long ago:
> 
> https://lore.kernel.org/linux-btrfs/CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com/

Yes, that's completely correct.

But for our metadata case, there is a small save.

We will never write data back to good copy with metadata directly, due 
to forced metadata COW.

With my latest patch (and above mentioned patches), in previous partial 
writes, we won't write P/Q out of the vertical stripes.
So all untouched DATA and P are still safe on-disk. (Patch "btrfs: only 
write the sectors in the vertical stripe which has data stripes")

So if our DATA1 and P is correct, only DATA2 is stale, then when reading 
DATA2, metadata validation failed, then we go recovery.
And recovery won't trust any cached sector (this patch), we will read 
every sector from disk. In this case, we read DATA1 and P, and rebuild 
DATA2 correctly.

Considering I missed condition 2) and the full roller coaster history, I 
need to rework the commit message at least.


This is not yet perfect, for example, if the metadata on DATA1 stripe 
get removed in transaction A. Then in transaction A+1 we can do partial 
write for DATA1, and cause the destructive RMW, removing the only chance 
of recovery DATA2.

Thankfully, the above fix is already good enough for btrfs/125 (mostly 
due to the lack of operation before doing balance, and metadata is the 
first two chunks).

Thanks,
Qu
> 
> Running it again:
> 
> root 10:18:07 /home/fdmanana/git/hub/xfstests (for-next)> ./check btrfs/125
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 debian9 5.18.0-btrfs-next-119 #1 SMP PREEMPT_DYNAMIC Sat May 28 20:28:23 WEST 2022
> MKFS_OPTIONS  -- /dev/sdb
> MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1
> 
> btrfs/125 5s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/125.out.bad)
>      --- tests/btrfs/125.out	2020-06-10 19:29:03.818519162 +0100
>      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/125.out.bad	2022-06-08 10:18:13.521948910 +0100
>      @@ -3,5 +3,15 @@
>       Write data with degraded mount
>       
>       Mount normal and balance
>      +ERROR: error during balancing '/home/fdmanana/btrfs-tests/scratch_1': Input/output error
>      +There may be more info in syslog - try dmesg | tail
>      +md5sum: /home/fdmanana/btrfs-tests/scratch_1/tf2: Input/output error
>       
>      ...
>      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/125.out /home/fdmanana/git/hub/xfstests/results//btrfs/125.out.bad'  to see the entire diff)
> Ran: btrfs/125
> Failures: btrfs/125
> Failed 1 of 1 tests
> 
> root 10:18:17 /home/fdmanana/git/hub/xfstests (for-next)> dmesg
> [777880.530807] run fstests btrfs/125 at 2022-06-08 10:18:09
> [777881.341004] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c10 devid 1 transid 6 /dev/sdb scanned by mkfs.btrfs (3174370)
> [777881.343023] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c10 devid 2 transid 6 /dev/sdd scanned by mkfs.btrfs (3174370)
> [777881.343156] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c10 devid 3 transid 6 /dev/sde scanned by mkfs.btrfs (3174370)
> [777881.360352] BTRFS info (device sdb): flagging fs with big metadata feature
> [777881.360356] BTRFS info (device sdb): using free space tree
> [777881.360357] BTRFS info (device sdb): has skinny extents
> [777881.365900] BTRFS info (device sdb): checking UUID tree
> [777881.459545] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c10 devid 2 transid 8 /dev/sdd scanned by mount (3174418)
> [777881.459637] BTRFS: device fsid fc182050-867d-42b3-8b70-7a717d5d8c10 devid 1 transid 8 /dev/sdb scanned by mount (3174418)
> [777881.460202] BTRFS info (device sdb): flagging fs with big metadata feature
> [777881.460204] BTRFS info (device sdb): allowing degraded mounts
> [777881.460206] BTRFS info (device sdb): using free space tree
> [777881.460206] BTRFS info (device sdb): has skinny extents
> [777881.466293] BTRFS warning (device sdb): devid 3 uuid a9540970-da42-44f8-9e62-30e6fdf013af is missing
> [777881.466568] BTRFS warning (device sdb): devid 3 uuid a9540970-da42-44f8-9e62-30e6fdf013af is missing
> [777881.923840] BTRFS: device fsid 57e10060-7318-4cd3-8e2d-4c3e481b1dab devid 1 transid 16797 /dev/sda scanned by btrfs (3174443)
> [777881.939421] BTRFS info (device sdb): flagging fs with big metadata feature
> [777881.939425] BTRFS info (device sdb): using free space tree
> [777881.939426] BTRFS info (device sdb): has skinny extents
> [777881.959199] BTRFS info (device sdb): balance: start -d -m -s
> [777881.959348] BTRFS info (device sdb): relocating block group 754581504 flags data|raid5
> [777882.352088] verify_parent_transid: 787 callbacks suppressed
> [777882.352092] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
> [777882.352327] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
> [777882.352481] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
> [777882.352692] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
> [777882.352844] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
> [777882.353066] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
> [777882.353241] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
> [777882.353567] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
> [777882.353760] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
> [777882.353982] BTRFS error (device sdb): parent transid verify failed on 38993920 wanted 9 found 5
> [777882.455036] BTRFS info (device sdb): balance: ended with status: -5
> [777882.456202] BTRFS: error (device sdb: state A) in do_free_extent_accounting:2864: errno=-5 IO failure
> 
> 
>>
>> In my case, it fails due to tree block read failure, mostly on bytenr
>> 38993920:
>>
>>   BTRFS info (device dm-4): relocating block group 217710592 flags data|raid5
>>   BTRFS error (device dm-4): parent transid verify failed on 38993920 wanted 9 found 7
>>   BTRFS error (device dm-4): parent transid verify failed on 38993920 wanted 9 found 7
>>   ...
>>
>> [CAUSE]
>> With the recently added debug output, we can see all RAID56 operations
>> related to full stripe 38928384:
>>
>>   23256.118349: raid56_read_partial: full_stripe=38928384 devid=2 type=DATA1 offset=0 opf=0x0 physical=9502720 len=65536
>>   23256.118547: raid56_read_partial: full_stripe=38928384 devid=3 type=DATA2 offset=16384 opf=0x0 physical=9519104 len=16384
>>   23256.118562: raid56_read_partial: full_stripe=38928384 devid=3 type=DATA2 offset=49152 opf=0x0 physical=9551872 len=16384
>>   23256.118704: raid56_write_stripe: full_stripe=38928384 devid=3 type=DATA2 offset=0 opf=0x1 physical=9502720 len=16384
>>   23256.118867: raid56_write_stripe: full_stripe=38928384 devid=3 type=DATA2 offset=32768 opf=0x1 physical=9535488 len=16384
>>   23256.118887: raid56_write_stripe: full_stripe=38928384 devid=1 type=PQ1 offset=0 opf=0x1 physical=30474240 len=16384
>>   23256.118902: raid56_write_stripe: full_stripe=38928384 devid=1 type=PQ1 offset=32768 opf=0x1 physical=30507008 len=16384
>>   23256.121894: raid56_write_stripe: full_stripe=38928384 devid=3 type=DATA2 offset=49152 opf=0x1 physical=9551872 len=16384
>>   23256.121907: raid56_write_stripe: full_stripe=38928384 devid=1 type=PQ1 offset=49152 opf=0x1 physical=30523392 len=16384
>>   23256.272185: raid56_parity_recover: full stripe=38928384 eb=39010304 mirror=2
>>   23256.272335: raid56_parity_recover: full stripe=38928384 eb=39010304 mirror=2
>>   23256.272446: raid56_parity_recover: full stripe=38928384 eb=39010304 mirror=2
>>
>> Before we enter raid56_parity_recover(), we have triggered some metadata
>> write for the full stripe 38928384, this leads to us to read all the
>> sectors from disk.
>>
>> However the test case itself intentionally uses degraded mount to create
>> stale metadata.
>> Thus we read out the stale data and cached them.
>>
>> When we really need to recover certain range, aka in
>> raid56_parity_recover(), we will use the cached rbio, along with its
>> cached sectors.
>>
>> And since those sectors are already cached, we won't even bother to
>> re-read them.
>> This explains why we have no event raid56_scrub_read_recover()
>> triggered.
>>
>> Since we use the staled sectors to recover, and obviously this
>> will lead to incorrect data recovery.
>>
>> In our particular test case, it will always return the same incorrect
>> metadata, thus causing the same error message "parent transid verify
>> failed on 39010304 wanted 9 found 7" again and again.
>>
>> [FIX]
>> Commit d4e28d9b5f04 ("btrfs: raid56: make steal_rbio() subpage
>> compatible") has a bug that makes RAID56 to skip any cached sector, thus
>> it incidentally fixed the failure of btrfs/125.
> 
> As mentioned before, I still have the test failing very often even after
> that commit, and I don't see how that could ever fix the fundamental
> problem raid56 has with partial stripe writes.
> 
> Thanks.
> 
>>
>> But later patch "btrfs: update stripe_sectors::uptodate in steal_rbio",
>> reverted to the old trust-cache-unconditionally behavior, and
>> re-introduced the bug.
>>
>> In fact, we should still trust the cache for cases where everything is
>> fine.
>>
>> What we really need is, trust nothing if we're recovery the full stripe.
>>
>> So this patch will fix the behavior by not trust any cache in
>> __raid56_parity_recover(), to solve the problem while still keep the
>> cache useful.
>>
>> Now btrfs/125 and above test case can always pass, instead of the old
>> random failure behavior.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> I'm not sure how to push this patch.
>>
>> It's a bug fix for the very old trust-cache-unconditionally bug, but
>> since upstream d4e28d9b5f04 incidentally fixed it (by never trusting the
>> cache), and later "btrfs: update stripe_sectors::uptodate in steal_rbio"
>> is really re-introducing the bad old behavior.
>>
>> Thus I guess it may be a good idea to fold this small fix into "btrfs:
>> update stripe_sectors::uptodate in steal_rbio" ?
>> ---
>>   fs/btrfs/raid56.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>> index c1f61d1708ee..be2f0ea81116 100644
>> --- a/fs/btrfs/raid56.c
>> +++ b/fs/btrfs/raid56.c
>> @@ -2125,9 +2125,12 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
>>   	atomic_set(&rbio->error, 0);
>>   
>>   	/*
>> -	 * read everything that hasn't failed.  Thanks to the
>> -	 * stripe cache, it is possible that some or all of these
>> -	 * pages are going to be uptodate.
>> +	 * Read everything that hasn't failed. However this time we will
>> +	 * not trust any cached sector.
>> +	 * As we may read out some stale data but higher layer is not reading
>> +	 * that stale part.
>> +	 *
>> +	 * So here we always re-read everything in recovery path.
>>   	 */
>>   	for (total_sector_nr = 0; total_sector_nr < rbio->nr_sectors;
>>   	     total_sector_nr++) {
>> @@ -2142,11 +2145,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
>>   			total_sector_nr += rbio->stripe_nsectors - 1;
>>   			continue;
>>   		}
>> -		/* The rmw code may have already read this page in. */
>>   		sector = rbio_stripe_sector(rbio, stripe, sectornr);
>> -		if (sector->uptodate)
>> -			continue;
>> -
>>   		ret = rbio_add_io_sector(rbio, &bio_list, sector, stripe,
>>   					 sectornr, rbio->stripe_len,
>>   					 REQ_OP_READ);
>> -- 
>> 2.36.1
>>
> 

