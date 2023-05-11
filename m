Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77F36FE900
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 May 2023 02:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbjEKA4L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 20:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjEKA4J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 20:56:09 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2042.outbound.protection.outlook.com [40.107.241.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9241727;
        Wed, 10 May 2023 17:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHvLQKCLT0GeY0ESg37Vftmg9cnrAGeXbsCFxCpY4kSaH4OmciN23UaWSW/mEhhy53DphtPrAeU82nq5SlSe6kGcXC1+piktMbzc83KJUwxILCSqy3C+YtMk0MKpae3L96uKzIdG0SO0vUVA5ILluiqydqCecpjmh27Gs85cMoHG1rjhgjLcwCo4l1vHlVRgy333xXKFdRBFBOF/fjYz8BFOqyGNskPBx4ZTfsX1yXqHd8ujfaajm7rq2BbczCPDJ3p6uAacFR1W/7oMoi8kUMx91nqk4HA0OigOTG2NKKmHc6CvEcq+7UEa9edEiR54PTlzphH05HwzdY43E9JHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ttEok5xlrYx+Cqd1G33p5rDVgUxCZ47qsayCncxzYM=;
 b=TyMHmJg9xP8JJt63Jkyf9Vr1uzBsvvt6p4phVJHBslaffx0Ck91eshaZi0FlY5doJbC2HM8U0elzSVIfl003ZQaG7LCKGfUIM8E8V+USi8bOCpuEPUiTq4nx/V0iasQnt2OxUY611APFawBvTfJuNrByjISKCrCv9OackPdQ1eVMqUtpsxMzpjI6r3abSWbN2C8pDUNyPj3s7GL59vnnfes4Xi+hM5JBQ1yNagOeKr+rJpYl1gGxoK6c6fjRSn/SbO2HRdh1oKgt1k5XJ7DPujz5iJn1IxQho6mcu6vyhMvkKBJ0sIiF0/RSZwYaLtCQwTAKuQNgZuu3Zs0vatXk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ttEok5xlrYx+Cqd1G33p5rDVgUxCZ47qsayCncxzYM=;
 b=zMUA9p5jLj5/dvRupLS2W+PTzfKwd/lSIyQeHOmFYDgf1AIdlbTX6z4PveZl+sxR9v6R7JU5iKETDJGJa/YubgWMeKHQhxKPy1T3dNNuEGPo5XegZDIry/zWHt7U9YwR6fMEJWzlzDpgNbRFaLiRXh6nWQi1cKMm8SQ/eoblYPRmv4Rdi9KMHyw4Tecc+O/NJLUy9Ol6/lwk/DYB+0gIsJgubdsmW/KjuOt2pYEbgZQZpKzc8XEneI0DsmQ9TiehEgidZtQiSEDrIkXGyiwUopVRFTVgy7PHNpAQ9RpPOrPFW0A6LYacciEljvpc3Lm1UuO99P/7RLoS2gULGgFRpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DU2PR04MB9051.eurprd04.prod.outlook.com (2603:10a6:10:2e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 00:56:02 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::79ff:9640:3ffc:75f2%5]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 00:56:02 +0000
Message-ID: <b87eb7fe-747f-6f6b-19aa-9bdcf3907010@suse.com>
Date:   Thu, 11 May 2023 08:55:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] btrfs/228: sync filesystem after creating subvolume
Content-Language: en-US
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <6553d98ab74fe2fd627749f368d9623a0b12ee4f.1683716041.git.fdmanana@suse.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <6553d98ab74fe2fd627749f368d9623a0b12ee4f.1683716041.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0403.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::18) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DU2PR04MB9051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dda41e1-bff1-4be0-6bb3-08db51ba7cb4
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eR2H0z8A5KVTG6By4pvdT+55GgHj4Cw2jkXBEqci/40zNvkATTbHM52Es3/Gq1vH5RT2nq3Y0cvQD7IM9tRP2KI/PD+1QsInz1IQq6PwZieus+7QDT5707iwi+J+0ETyWrQj69B4aL0pWeZYgsrpBq013rVemvOnrb32K9vGrZYi8CtZSb4pdSDOquVmq7jz6gMfCTzf/d9NwWsa6i3QMe9+V9C/p17xc3FbHnWcvlY0OVLVCk1bChpXJE+V2Zg4mVZ2byelvOtWm6qhNqbAXNd43Udc9LPik8BPkQRfAdTLfvp+rnQrLY8YyxJ7nD/ni/TN3ESnK9+O3euRYKqPR2LI2rAZmNPENFDKgHlwdiNzpADNj4ARFCBm8NTw5vJs2fCKCkMS6f/XARlY+YP6gpDgIgEFEY/0opVOYhxPkDmr+fHDng1eI8A78rQEczJJGhHyrgJ57GuIieNXW2QxXNZEHVQYQlkeK/zchGUpa46G6Z3Dmtm1RDurDLf4RXv04cWi5GpL6lxUOL/eA6SjsrFSmz/JEqroA3LbiFYWWQP+uFh2S0uC9CvAehfH5vTHCH6yQrIipkgh3pZaKtpE42fpDH5QCMiXCWO9vf+aCDAbpFxwgifXK7vcjYVz6oAn7KIJWelT7+lArLVOGQQILw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(6486002)(6506007)(107886003)(6512007)(53546011)(38100700002)(83380400001)(2616005)(36756003)(86362001)(31696002)(186003)(4326008)(2906002)(31686004)(5660300002)(8676002)(316002)(66476007)(8936002)(41300700001)(478600001)(66556008)(66946007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWdoT2VQUXRGTmtyNzJlUEVuV3N5ZWo3TDVDamVrQXdRZTRYY1l6VzM2UWVG?=
 =?utf-8?B?SU8waDM4WHpCZGxTTVVwU28rcmtqcUtSOTdSRVpyNkpYb21oU1ZxWWhqOTZ1?=
 =?utf-8?B?MWFFem9ueWZJM1U3MkNBQ0RoY2VPdjREMTFVVThwTTdrMmRVMGlZaE80VG1v?=
 =?utf-8?B?N2kzNkNsc0Y1YmFSdHhjdkZGQllkbjhvSG1NMkluME51RFlDSU5IamxxVURx?=
 =?utf-8?B?cENWSXdLZ3RMckRYUkZZSFpMeCtvTE9Ua1M5UXZxSzRPekZrYVVjbWl3ZlJ6?=
 =?utf-8?B?S1dvbzV5MTN2TGdzS2FXVm1ISEVsMmEycU0wZWVlZEVjYUxndy9TRjh6dDA5?=
 =?utf-8?B?bmF4QnZFcjlvditHa1doVHVSbjFVMFdQQ0tkempLV1liU2hhVC8wSW5IKzg0?=
 =?utf-8?B?cVRHRFdUTFprYnNJQkRKMDdRZk54SWVVTDNwSHR2aEtGV3BGZGV1dnFVMXBi?=
 =?utf-8?B?cXo5c3A3MVk2K3QwSzJrNEE4c0FOZUg3M20wRmRQYXJzaWgxVG4yelM3Vk1N?=
 =?utf-8?B?ckU4K1pFRzhvTWtlUXVhWVNkNVRRTzU2MXBaWnp1ZUQ1b0l0UnlwZkJzd3lR?=
 =?utf-8?B?TDl3S0lDUFM4WTlDYnpGSXNHNGZ1WG4yczZNdllTeUxXcHErVC9sL2pLU2gr?=
 =?utf-8?B?WGtub2Fac2MyVEJ6SzhUT1BMb2dpRisvRktmZk9Ic28rRXNQeE81NXNpWWxz?=
 =?utf-8?B?ckgrejd3YUtYeWMwckRHaDBEeEpmeExxNk1OajFqbzFQWVhDWUs1ZkNkR1VV?=
 =?utf-8?B?NVlrdDJnaFMvU21oeStlQ3BaYThyeDdGeDZDY2pwYmF4Nm90Q3ZyV3VTN1ZP?=
 =?utf-8?B?dkplRFo3NVNST1N1cTB2Y01zenR1OXpJT3RJUnlvNEtDbXl4ZVhzZmVUZ2Fw?=
 =?utf-8?B?MG5mdVR1SlhFMGhjOFgrR0dVeUNpckFmQzArMzJ1WjQ5SFBxODl1dXVKaGNJ?=
 =?utf-8?B?cXl0SEdSeG5JSWh5RXg4cTczWVlCdnQrZWxWMzdJYjZndFIwbUJnL1FEUkx5?=
 =?utf-8?B?SU5MQm1mYVFsblh0S1owRHA0YmdvamdaRzdDdys0Vk5NQkx5K1hxSHJHSWVJ?=
 =?utf-8?B?UDh3MzBBQXVndTU5MkdrRzFMNUZ5aUNzb2R1L0xJQ1QrOFJJU0NPL3FoeDcz?=
 =?utf-8?B?Um9NMDBmQ2R3Y3h2WFVGWmtxL20rTjNaWHpSWkxkTHdudnJqK2V4cXlmRDFS?=
 =?utf-8?B?MzlzZlVGc3FVQjdEMThOTkluZ2tNWWVZSmFTbzkwSEp0VUdZeWE0djY3TUtH?=
 =?utf-8?B?RjF0cUtuc1JDeDkyOXc0bUw4NXVWV2NZREtFR0hQbWVCRmpJa3BlMWI4LzBK?=
 =?utf-8?B?Sk5RUmdlc1RQTmMzM2xjdUdsMmJtQ1VsVjNOSEF0YXdUUktsNG9wVzRpNlNp?=
 =?utf-8?B?QnJVanhXVkRFUFY1TDJ0TEFseStMV3dBTXB3Z3I0K3N0L3RlNGdhWHF4RHlL?=
 =?utf-8?B?VU02YjROckZMR2VFSDNhRFR3eXZXRzdJem1KSVBhWXRTdjY0cXkySkx0bUtP?=
 =?utf-8?B?SkowS0dBWFNINXppcXBRaFRsSCtWaWV5cW5EcnJITTUwNEQxZEVvWnQvbXNF?=
 =?utf-8?B?TWlMZ2lkNEV5Rlh6a1d6Qm5iNnVLMnNSSkc5OThuTzZjclNZVHZ2MEplTVEv?=
 =?utf-8?B?c1FjNUJqZGViTWNXdmRhellOb0NrTm9rNkpla0xYWGJKT3loZTUxSnFxTkJt?=
 =?utf-8?B?TnZwS3I3OW1oRlZYeEVQc0JUZGZSVmhkK1AwUzRwRVNOOWFZL29GUVlSUFhS?=
 =?utf-8?B?eCtGYkE3VGhsbWhnUUJ5dUcxbnBwRk8vWWY5c0dORC9hRi8razg3aEorMldS?=
 =?utf-8?B?Q1I3MzR4UnpUczFpYlZPZ1N0bm5SaHRSVnpwZ1JMbHptMDZSb3NyYzc2emlJ?=
 =?utf-8?B?NDJFbFpFN0R5bThST0R1K1JUaXBZUmxEaDdRV0Qxa0dwcXFOK2ZuK1pTUzFM?=
 =?utf-8?B?UmJ1OHNsZmxwQXNLcXdxQzVGaXBBU0Qza1l3OEFjY1QwY1dOUVpkK2xsRjNI?=
 =?utf-8?B?WlA0Z2x4WjVUNHV0Ylp2U0E4TXF1N2lubnlqakltRzU5ekFqTVpUWHNJMDhS?=
 =?utf-8?B?a3JaVzAxMHIvL25JdzMyR1BRMHJESnFnL0RlRHFMQmI4ZW1hbEYrZk1oaFVM?=
 =?utf-8?B?UE43eEd5VW90cjlJWGx5RkFGQ1puakMwcHBCTTFjdjA4U1VqTkltdy9NcmxB?=
 =?utf-8?Q?lrgUmLktBt+gJrg1fH5cd/A=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dda41e1-bff1-4be0-6bb3-08db51ba7cb4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 00:56:02.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtFpmhmd1lTzxjCiOmJko7MnbbahlRrn96rzOodK1bamCCA//f7iUMuH+/5OWi0+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9051
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/5/10 18:55, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test case btrfs/228 creates a subvolume and then calls the dump-tree
> command from btrfs-progs. The tree dumping accesses the device directly
> and therefore can only see committed metadata - this used to work because
> subvolume creation used to commit the transaction that was used to create
> the subvolume, however it is no longer the case after a recent patch that
> currently is only on the btrfs integration branch "misc-next". That patch
> has the following subject:
> 
>     "btrfs: don't commit transaction for every subvol create"
> 
> So explicitly sync the filesystem before calling the dump-tree command,
> commenting why we do it. This way the test works before and after that
> patch, for any kernel release.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/228 | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tests/btrfs/228 b/tests/btrfs/228
> index fde623fc..5ef1dfd7 100755
> --- a/tests/btrfs/228
> +++ b/tests/btrfs/228
> @@ -28,6 +28,11 @@ _scratch_mount
>   $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/newvol >> $seqres.full 2>&1 \
>   	|| _fail "couldn't create subvol"
>   
> +# Subvolume creation used to commit the transaction used to create it, but after
> +# the patch "btrfs: don't commit transaction for every subvol create", that
> +# changed, so sync the fs to commit any open transaction.
> +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +
>   $BTRFS_UTIL_PROG inspect-internal dump-tree -t1 $SCRATCH_DEV \
>   	| grep -q "256 ROOT_ITEM"  ||	_fail "First subvol with id 256 doesn't exist"
>   
