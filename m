Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048BF4B63C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 07:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiBOGzl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Feb 2022 01:55:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiBOGzk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Feb 2022 01:55:40 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B901327B30
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 22:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644908129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpMfpDyZsDAcKdKNAW/X/IzKmTCimdx0OpWa5LQVfII=;
        b=g7Ctwl8k5jNIUQ06f8fl64SnCw6eoblka2sK7+u36jj492TrKdW6/uhC+KdNc+zQfZT2+1
        XTam6BlvscGkAFlBOGwnEZ6nTznWA16k+bsTqhO8WUUQN4BOnWRMFipyAp7Hc/oHq1nuVJ
        +BTIB4Onda+UmzOf6QMxUQ2LdkGDuxI=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2058.outbound.protection.outlook.com [104.47.10.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-rkkBNLnGNOG4hwMZ_HqgXw-1; Tue, 15 Feb 2022 07:55:28 +0100
X-MC-Unique: rkkBNLnGNOG4hwMZ_HqgXw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1kBIqLcdINzUVEYDPaTM7SYVuOhbA85gCFy7AZQpuCgJqD3H8/rzR0Ft2OhdrVdinSa6qqcy9hbuFdT04xPDxN2/wRHwrZOtGnbGiWflu3B+6tbI0VXbNPfXQrC/6X6X/+jC0BlMRTCumhAwHIuPd1XVBgklYy+50IQ7SbMkUATbR5zq0gp17tBVp0X+oC0s5kOAOhbhxCNrYd3YLsFYeEZ3mp+hbi7+oAVAWlAf2UQjCb329LWBxOtwjTiDYDa20Cn8NFPBIW8XHdZtKEz/jignYN+Nd5NVEOoj8mEPLyJfZwyYCudubDrJTapAgrL4+75nyNC58+NlN3Pn/PVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpMfpDyZsDAcKdKNAW/X/IzKmTCimdx0OpWa5LQVfII=;
 b=aO/+z248K+ncjfQLZ6uhika8tdA/tPtoWqbL0CiOxF0NSkGFRA50cJ8OXHtQuWt/FZdEEHCgg/6zFtwMil+UyD3tyyoZpiYh/YlLthyUyMBd1yFSa8Y/dDC3RHqlL1S6sk6aaFS60hosyZ6YRxYimYbDa+nyhWvtLx1on5sWSU97VqYcynhTayxqqRiZ/pCTl+/iZFn1YEwZ/Dn2ocCgkLvL3KGOVh5u/t/VKaCwkUyUL14LmpX+VPwaAvbYGNxMdwuorhChg+0mqFy89lRFCmV8Uh6zv5zwUnct5ATELeuzKeCInTswpQJ+2/ONapIq3dgUj+gHN4yIKfBGr5Hv7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by VI1PR04MB3213.eurprd04.prod.outlook.com (2603:10a6:802:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 15 Feb
 2022 06:55:25 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 06:55:25 +0000
Message-ID: <870cb1f0-4108-75d5-6b45-e6a26a2be3d2@suse.com>
Date:   Tue, 15 Feb 2022 14:55:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1644737297.git.wqu@suse.com>
Subject: Re: [PATCH 0/4] btrfs: make autodefrag to defrag and only defrag
 small write ranges
In-Reply-To: <cover.1644737297.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::30) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc2353c5-03d7-4c91-9497-08d9f05024a2
X-MS-TrafficTypeDiagnostic: VI1PR04MB3213:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB3213F229A589A43A7C399F57D6349@VI1PR04MB3213.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZWWgj8MDvjEJySwpWl4lkEGZcsoVb0c0sBgYxFVuUOnunQ6I+9SvcLTCdUtO2WY+Bq22kOlN0fJYKvGUoblxd26VVlbcGBoOXPOyQUZb5LA8Sf/q5ZSXxRnQvcRHDwy52n8cWOjtjp5bAqp3mcI7bgYwVk5aSsmo3T4Hd/pwV4IZzuISrrUxnEV3sdJ73blV232MGEGHjbhYOWQuXfjas5PwJ8axjZy/03u6ZWwj+PsednV9PDmkctjVBO+uiJCMxxMQhHJ6/wiRvuUJ5Q9Bvia5y6HfRTcrnm0mSOcbFtL9CXZDvX3gQCTBLyCPh5OmNnCPQF4cQowHgf+AYzgPU//nWtUyI0Mxg0jORb0/GfoAZ7AJgp3YJNnWFRZgiVeSocU1Gpy3SWtxKqWCkWMet/XCuLiuJiOvQTHx08I3HWjvg/o+yonM4d7IwmvNplOg9JGr2gcbyZHpiUAIc2Nruc+bxY4F2Pli7NfgmamzR4F6dVbh0s33+bNEzXUKOGQ73/v54gUSOw4SxIYYHXNq+dHsPWYdqTYas6EBH6BRog6yYTUUtXV3JhqnDDARvk23iubIyi6lU+ZwP8+VQn9TRQgqWUw790nKN6FqNqkE9rJUS0B7/soPDPi+i27BQIXwD6lxuup/z2PiV3frFlZm6sf0TsTpXDE/PJMZAVQwRpmEBmJtx6LIHN/R2mJIkyEIoIpTr2fG3fB5clJeH/oJbHLzzm+tpYkGPuXx3itmqQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(38100700002)(8936002)(83380400001)(5660300002)(8676002)(66476007)(66946007)(86362001)(316002)(31696002)(6666004)(508600001)(6506007)(36756003)(6916009)(186003)(6486002)(31686004)(53546011)(2616005)(2906002)(6512007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0NWTmRIeVB4N0c4VmVnK2hydlNSTi9KdEJIdGl3WWQ1K0d4V3c3aWFqVC9l?=
 =?utf-8?B?TkwvUTRCYVlJbjlQdmV2Nm14NE9VSFVRbkE3SUh1YzFmM0g3OW50d3o2R0Fj?=
 =?utf-8?B?Sjd6UWN2b3JmM2JBd1o3bU9nYUZpT0N4MXZzQUkyTkNsRTdVV0FqblBnZThK?=
 =?utf-8?B?Z0ZNTzNLRjYwbVp5NnhCaDEzdkNDamtFZFJRMWZmczBweHlzdGltemg0dWht?=
 =?utf-8?B?TW1CZG0wdDdZdmkxQmZhS2dIM240Z3FhSWJwOEp4VnJmb3JBaE9SdVp6V2FQ?=
 =?utf-8?B?enZZc29TaUJpcFppblZZbW1lcEZwT3VpNEpRRm0xcnVTQko0Tm4rMDJEaWV5?=
 =?utf-8?B?ME1IMEdKN21NKzBqY2thc1NrNkNaVmN4QmcrNllaNkR0dlJPdUgyOVBSTnU5?=
 =?utf-8?B?eXVCL0E4aXkvZFNUbkhudXBUZHI2MGJBN0Qxd1VwN2FjN043WGU2OEhLemda?=
 =?utf-8?B?aXpsVDBHbHZ3T3hXY1Npd2J0dURsa25HOEUwWXlvOVJaSzhQVVhWNG41THZJ?=
 =?utf-8?B?QnpLVUlWdzJWcmhJbkpCcG00MkZEZEJZUFB6WjMvUUxjSGJsTEdmYmozODlt?=
 =?utf-8?B?MEJsNmtzZTFBN29EYVl3OHRGeFgwdS93OXZneHpxQ2diTTE0bERPMWR5Lzc2?=
 =?utf-8?B?dzJ1SWp0YWorTjNyYVJGSFhPNEt4QkFIeUdzZDdDZ1lGYnltU1l5ZHkvMCtu?=
 =?utf-8?B?eHByRVk4OHZZaUJYYVVEUVRGUDQ3QzdTZEwvMlZ3amlWR0JhL0k4M3l2d1lt?=
 =?utf-8?B?QmVCU0JURFNhYlk2T2d2NytTbW5DNkZnbHZhS1A2bnJLYk9lZnU2c2RrM2hR?=
 =?utf-8?B?M2NrSXJrOXlRaFVWNHhLbmZScm9pUW8rdEYvS1VnM2ZjSS8vMVc0MWJsN3pH?=
 =?utf-8?B?V2F3Q0RoTVc4aEFkekE1VnJrR2pBSFVGeGRWeFpMdzZtSjZyb2VUMWZhTklC?=
 =?utf-8?B?NGhjZ05sMTdnVlZzZ09hdnB2V1U4M0hTR0xDeUpBcDJvMnAyaWEwazQwU2Zw?=
 =?utf-8?B?cmgxQUhwUVFPODBwU0FZVE0rMGVFZVhBMEpoNzRNc1BhM2lsVjY0eHNLMTls?=
 =?utf-8?B?WTlsZTRrdXVOaDh3TCtvUURqMVlvNW0zOG1qNm1mOWI4UDVoWjlHY05ta3ZU?=
 =?utf-8?B?dXJOYVFyWWhjdUtBdG1zcVZ5MXhTUXEzYmxhN1FDaUx4UHZPQi9kb2hlVG1t?=
 =?utf-8?B?TXdJZzg0eHk5SktHbEZwOTE1bmRFem1GN3l0dGw0aTFpdWIvQ0YydUNyTHR0?=
 =?utf-8?B?bFpjLzc3QTQwdmxMOTE5Q2tuNDBsME1DNXN0SlM2QW1zU2pEM0NacTJldkdp?=
 =?utf-8?B?MkI4UDkxa3AzcVhXbWdKM2FjSDQ1YUtIQjRwRitnVi90WkpBd0d5TVhKZFhC?=
 =?utf-8?B?elFtcFlwWHNaU05sVEpyQTA4dWZuSFVZWXFJRXVlUGdqVm0veVRsdWlIL2xK?=
 =?utf-8?B?TWk3NVhWTFFwNHdLQkI0SDd6Q2hlUDR1SGxZSG5nclJMZ2NXNWRyRWVtamt4?=
 =?utf-8?B?QStuWGIydHptSmVnSm8yV1dXZXNPdmtmK2Nic0ZTZUtNZ2h2YkZYd0ZVRTZt?=
 =?utf-8?B?U3FGQ3g1VXUwR3Zvd09kdE14ZVRUQXF0WW1CK0Q4WXZtSzZMQ2JrakVGRE80?=
 =?utf-8?B?aGRxMkxwQ21aNE1TOUlKSHhDZjU2a1pxdlFvMmdTRjhjbFhSdVk0QTVVMFM1?=
 =?utf-8?B?ZlB5SDFuU3lMQXA1eTVsRzR2SGtpa2VXNXduSWdoaGtXUzZBVnE3Q3ZaOGd4?=
 =?utf-8?B?TVFKZ2tBcDJXbk85dEhndWY1Y3VmVGZsaXcwWnRFZkdQUnZjOHpGV1VRMlFy?=
 =?utf-8?B?bFVvRDZrYnRqSjA3VlJXV0RzbUNDZkZZSVptYWdTWnNvRXRsRmFHd0Fac085?=
 =?utf-8?B?V05VbDBwOEJieDRtRkw4ZGI0MWcyU3k4aEhWVkk3a1hocWhNamRGZGVVRUwr?=
 =?utf-8?B?aTgxWWs3azFZTEdaRVhFd0dKOVVzcUNBNTVNLzVSejdVSWhvYmdTVlUzOVJB?=
 =?utf-8?B?ZzVvMkhTT05GbzZxRHRNRXRYb0s3SGJrZmViM0RTRTlmVU92Q3VwQ283VFY4?=
 =?utf-8?B?UnBPektESmJqR3NMVEFYZW53Zmx1anNERDNYYVRGV2dzeVpzQW95TkJKOWVZ?=
 =?utf-8?Q?mjNc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2353c5-03d7-4c91-9497-08d9f05024a2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 06:55:25.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRACxrBxXpywSdXpeucKPLcCNr79RENkCy+2IAYlg9Gb4bSjQuJG2TDE7X6StSfX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3213
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/13 15:42, Qu Wenruo wrote:
> When a small write reaches disk, btrfs will mark the inode for
> autodefrag, and record the transid of the inode for autodefrag.
> 
> Then autodefrag uses the transid to only scan newer file extents.
> 
> However this transid based scanning scheme has a hole, the small write
> size threshold triggering autodefrag is not the same extent size
> threshold for autodefrag.
> 
> For the following write sequence on an non-compressed inode:
> 
>   pwrite 0 4k
>   sync
>   pwrite 4k 128k
>   sync
>   pwrite 132k 128k
>   sync.
> 
> The first 4K is indeed a small write (<64K), but the later two 128K ones
> are definite not (>64K).
> 
> Hoever autodefrag will try to defrag all three writes, as the
> extent_threshold used for autodefrag is fixed 256K.
> 
> This extra scanning on extents which didn't trigger autodefrag can cause
> extra IO.
> 
> This patchset will try to address the problem by:
> 
> - Remove the inode_defrag re-queue behavior
>    Now we just scan one file til its end (while keep the
>    max_sectors_to_defrag limit, and frequently check the root refs, and
>    remount situation to exit).
> 
>    This also saves several bytes from inode_defrag structure.
> 
>    This is done in the 3rd patch.
> 
> - Save @small_write value into inode_defrag and use it as autodefrag
>    extent threshold
>    Now there is no gap for autodefrag and small_write.
> 
>    This is done in the 4th patch.
> 
> The remaining patches are:
> 
> - Removing one dead parameter
> 
> - Add extra trace events for autodefrag
>    So end users will no longer need to re-compile kernel modules, and
>    use trace events to provide debug info on the autodefrag/defrag ioctl.
> 
> Unfortunately I don't have a good benchmark setup for the patchset yet,
> but unlike previous RFC version, this one brings very little extra
> resource usage, and is just changing the extent_threshold for
> autodefrag.

Got a small benchmark result for it.

Using the following fio job:

  [torrent]
  filename=torrent-test
  rw=randwrite
  ioengine=sync
  size=4g
  randseed=123456
  allrandrepeat=1
  fallocate=none

And the VM only has 2G ram.

This should really be the worst case scenario.

Then the full benchmark includes:

start_trace()
{
	echo 0 > $tracedir/tracing_on
	echo > $tracedir/trace
	#echo > $tracedir/trace_options
	echo > $tracedir/set_event
	echo "btrfs:defrag_file_end" >> $tracedir/set_event
	echo 1 > $tracedir/tracing_on
}

end_trace()
{
	cp $tracedir/trace /home/adam
	echo 0 > $tracedir/tracing_on
}

	mkfs.btrfs -f $dev

	start_trace
	mount $dev $mnt -o autodefrag
	cd $mnt
	fio /home/adam/torrent.fio
	cd
	umount $mnt
	end_trace

With all defragged sectors accounted, before the last two patches:

Total sectors defragged		= 6846831
Total defrag_file() calls	= 6701

After the last two patches:

Total sectors defragged		= 3466851
Total defrag_file() calls	= 3396

Which shows an obvious drop in the sectors marked for autodefrag.

Thanks,
Qu




> 
> Changelog:
> RFC->v1:
> - Add ftrace events for defrag
> 
> - Add a new patch to change how we run defrag inodes
>    Instead of saving previous location and re-queue, just run it in one
>    run.
>    Previously btrfs_run_defrag_inodse() will always exhaust the existing
>    inode_defrag anyway, the change should not bring much difference.
> 
> - Change autodefrag extent_thresh to close the gap, other than using
>    another extent io tree
>    Now it uses less resource, keep the critical section small, while
>    can almost reach the same objective.
> 
> Qu Wenruo (4):
>    btrfs: remove unused parameter for btrfs_add_inode_defrag()
>    btrfs: add trace events for defrag
>    btrfs: autodefrag: only scan one inode once
>    btrfs: close the gap between inode_should_defrag() and autodefrag
>      extent size threshold
> 
>   fs/btrfs/ctree.h             |   3 +-
>   fs/btrfs/file.c              | 165 +++++++++++++++--------------------
>   fs/btrfs/inode.c             |   4 +-
>   fs/btrfs/ioctl.c             |   4 +
>   include/trace/events/btrfs.h | 127 +++++++++++++++++++++++++++
>   5 files changed, 206 insertions(+), 97 deletions(-)
> 

