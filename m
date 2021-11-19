Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5507457944
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Nov 2021 00:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbhKSXHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Nov 2021 18:07:38 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:47568 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231799AbhKSXHh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Nov 2021 18:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1637363073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQHjyk/P9zDh9o8hF8aMCRt+NdddsZkfMMuv1P4edJU=;
        b=Pa4VuwfHk8pwaHwN/YeIACOgMi2NI62GPRuyQEcujklYnXHctIviBQaoP2WX9+1HirHABY
        FW3HpppXdticg6/7NiIyc8OivznN1ZGt01iUiURiIDyxgFLmej3aY42Hspzntz5Py4Voej
        J1WQPWWASaSK3aLiNSdMll+PIe/KzfY=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-MydioqD8OR2WdydyeeQtwQ-1; Sat, 20 Nov 2021 00:04:32 +0100
X-MC-Unique: MydioqD8OR2WdydyeeQtwQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyKJbHsZgfBOQ+F6r9zBikZfslVAl4w1NHzEZqFzyoWiA/ml0wcwlXOE+n4yawGzkLzMnRiBFjTQBj8bRYPLTcxFbjQGzNcy7BzvpQojIrHew/7PYwOPUSUZoDjYC9agaRcVODE6EUWwZLaaARetw2fy1fyqci12DvDoZTF5TEr/pcvvFxINcvZ02vGXb3C1EoxRfx9TVYYoQbdPo/rkh8Xt9i+hNq7vt9C+vhhoyD8PyXKv8PVPOHdn5DUlkwLhR/3Za8DTC88L0+CwVEKiK1/d2WAQp6kNiK1LfrKM1P0gFN7Af2wi/BdqyabNTfPsFXJx1FnV64P35unkNdHweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQHjyk/P9zDh9o8hF8aMCRt+NdddsZkfMMuv1P4edJU=;
 b=fIkA3zDJbs9kkHGsRuhqWBU54bRw6crR+YEOoqCqsil6pMnIKs/stPu9Z00H8Xgz5qRa0K0YZI5BY67jwZWfKgxcN7C2lLjWVWLO1Gbu4SapEh2fOQ7sKkKgO5MkKPUmjvM3KP5pSogiIx79sNlhCkds8D3Zg6aPODx+kHcDicwFxeJklTQtnmRXNoJqti0ZR3wn7eh+NsZYxh1HflpL6xTKw0A8PzyFgaQuBMm8jE/ifBwSG9IidYrndWwNGLlTboVHpYU1dfvTKW42ypn8fFFKoWcq+lFczP36B4ZSiu0xjElNg1vyN71IE8xftIwpQa9B4JPxGV2eAaR24RKmng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU2PR04MB8901.eurprd04.prod.outlook.com (2603:10a6:10:2e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 23:04:30 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::ed16:bc50:4079:9286%8]) with mapi id 15.20.4690.027; Fri, 19 Nov 2021
 23:04:30 +0000
Message-ID: <7cf937ea-b0b3-ac42-308d-73fadd134b30@suse.com>
Date:   Sat, 20 Nov 2021 07:04:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2] fstests: redirect 'btrfs device add' output to
 seqres.full
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <bf24618b10a75719a23dda2f0a742bd322ec8d46.1637247167.git.josef@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <bf24618b10a75719a23dda2f0a742bd322ec8d46.1637247167.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:405:1::29) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
Received: from [0.0.0.0] (45.77.180.217) by TYCPR01CA0041.jpnprd01.prod.outlook.com (2603:1096:405:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Fri, 19 Nov 2021 23:04:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e195e3da-4e0f-4f15-d0e9-08d9abb0f181
X-MS-TrafficTypeDiagnostic: DU2PR04MB8901:
X-Microsoft-Antispam-PRVS: <DU2PR04MB89014D4AE80A02AE514F7A78D69C9@DU2PR04MB8901.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CEPYHQ3XCPmlco+7ckqYAGeRX3hS4y+mI8KVAEtazKa04SkfMOiOLKaL1jy0/BBhld0M8IryI0DYw4RbsIA6IDhfYInwrrhKHTD+gShh7FG4e2xNpnd5AOM7km24G6mtplYDvZuJB9i5YVvaM7W294x+Lg8x6GO0rEaxbIsB/MDR0gEwsx6q1TfpkqjToS9OS20YogisdET5E7qU8BRNcr3c3u5Lr3D7SbeBqQUtb7BuCRAPn1fYzDVzgHEkce3e5GlUnO7MLkqDYlrgGLnW/jTMULxXDUr4/Y3YvSS5+t/eAG85onO/mhKANyWiBNkGl4CxLYiHEqqSw5FVYlml9a5Gi8rigJRH16wAhTAfGONnL2EAAjgYVBK5h+CCYW1aTVHacb7Lq8VWSaAGoHurPi73p7xDzmZTChgga8Ps/an6q2ny7RG8MWlB+DxXhoDOJ4WmpYP5P0zzDL8vHpQd5yy3i0UtcNhy416GFa+g1bx1+JoknJhDgsCExBp4We2u49d1IWU7f3/H0XnUMB+Wp06R7LiHSRsfULfkkaBrc5fs5ryMbg+jufIspt58Wk9Gj51BUqR66rnyXqxezdfrdoduPGoGZEGzoLvnvtm80NIPFEwh+38cUkJWNruEJXBF8LXPrkB9UMImwZi6OVpubh0+7IEhpXiH7M/uAZ3NzV0ZWQu//7uSUeu14MvxUMdx3UrnrS84AS4OwyjOz2LZP+6Qi9pIFQ+lQ47UobRhHV3TCxRixn8vODRrnUkY48jCNtPFPIM2oXKH11rZ28fCUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(508600001)(26005)(6486002)(2906002)(5660300002)(36756003)(6666004)(16576012)(956004)(316002)(53546011)(55236004)(8676002)(31696002)(8936002)(66946007)(31686004)(2616005)(186003)(66556008)(86362001)(6706004)(66476007)(83380400001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmNRczljcnBTTndGeDkzQVdPRW51eThqcFovNmEyNEo4QllDdndTZWUrMGw4?=
 =?utf-8?B?YnhRRU96WU12ZHBYTTk0eEpUVHJLelpTZkNjNzAweWhoV1VzeCtyZVVPYlB0?=
 =?utf-8?B?MGw4WDB4ZFNON1hZbnVkNlQvYzQzeGdJRnV5c01xVUgrS2tVS1V1YlZWRXBa?=
 =?utf-8?B?WGthSXZNOHVSZTE2ZlhzdGRyZ2wrbmlWa3hURWZSVmVrbmQvWVY0TWg3R2NE?=
 =?utf-8?B?OHFVR013L1VwS2lsSkcwa1FGdlFzOWdjdm83YkNYbGZPR2kzT1VtT1FrbXph?=
 =?utf-8?B?UGJlVGZlaHJGWTljeVJ5S0tQa0Z4bUhReUdZYlpNbVBlbEk2cXQ5OW40N2Vv?=
 =?utf-8?B?NTdFMnNXYU1DM3RjOVVnM3NpdU1SZ2ZBSHV5K210eEd6eWFEVEx5NWVaMTY5?=
 =?utf-8?B?YUhxZWl4bUdjc0tnU0k3MGM2VDhKNVlaQ0VFdEx5M0lXUHE4Tk56d20vcFNS?=
 =?utf-8?B?Nk5QM3FkUmJxNlVKTmJORmQvNFU0dWhmTFNGbjVhNG8xbElMRVREOGFldEQx?=
 =?utf-8?B?ZHN5TXpxQ3lVNmJVVm0xcTJTbFp2Vnl1cG0ycVpYK2g2V1hnaUVHRldBNTUv?=
 =?utf-8?B?OFFocWFVeFJrTE1nSUVOTG55emU1V3JTNllNZzF6TDBwMTZ4TEdnNmxGV0dy?=
 =?utf-8?B?SlhMOG9GclJldDI3bnl2UTNwWUZ2anZ4Y052RE1XSlFOQVlDN0tWTjZoempj?=
 =?utf-8?B?c3pRalRFZzJUQnc1VnR6ZDhQSFIvRVNBYTNHVXFEYWsrN3VyTDA4dmE1OXVP?=
 =?utf-8?B?ekZteHhBOEVJZTlLQXN4b3Z2blVBTHlWSW95Q0RtejdNM2NBUURueXpwTTRq?=
 =?utf-8?B?eUFvcWtPc3plRkE2c3pIVW82Sy90MVpMZVRsSnd5UUdEVTRkZzluMlVvNTlO?=
 =?utf-8?B?Y2NzQkpML0NXd0NzK2ZQMVZ6U2ZxUGtUTXlOZXEyYUQrbUhtZjBTWG1qNDVv?=
 =?utf-8?B?bUhxTGpNTURGYWdlaGx6WTN6bk9vcjY4bnV0SkxUT0xLcUZwNlZybEFtcjU4?=
 =?utf-8?B?bUE2Z3RFT212THl2SzIxU3YvQ3FsZjF2T0xDTkJwWkNuNTNjbDRzYXdPTWlT?=
 =?utf-8?B?RGtnWkw2NnE3ZVlPdTVHTE5HSm1sVms5QXk4d0tnZ0VveVdtamxjeENRNnlN?=
 =?utf-8?B?Y21YQjFPTkpiTm5uY1NyYlU0TmpiYUNjTEpsdkVidnFsaUlEQWJUTklpbi9M?=
 =?utf-8?B?b1ludUZTRStDbi9KbHRDbnNRT1pFYmErSVc0NkdTZ0JxYktjcXpMUlZ6V2xY?=
 =?utf-8?B?Tk1HaXhHZU40enBZVktIbXVmY05scUdlcG96QWxpb0tSQldENnVRaFBXMFFm?=
 =?utf-8?B?dVlTSHB0ckJqT2xnYnpEQTNUSFZKeWtocXlJRGZWLzV3Ui82UVBXeG55REdT?=
 =?utf-8?B?cUpjNzFoYTZHcWhWdXFyOHJBUktMdGd0blhFTnlITUhZam5Tc2pRZlhGRExa?=
 =?utf-8?B?MzkxRzkvM1pOTXJwTGVmdzM0Y2hrWWZ4SnJrdGlyRWw0Y0twTW1FRkNQZi9E?=
 =?utf-8?B?TWJvRGpOdFc2cGFWbThVTWNlVVIxYjJ6QmxRTXdWSXdtZGIyc1A5UHZqaDYv?=
 =?utf-8?B?RXhGN1ZIQUtBUlFpZHR0M1kwdVRuUkppOXVCazVQR05UclRpUktCNEdsZEw3?=
 =?utf-8?B?bTh0STM2SlBraHlvaGIzenpocnJ5eTQwa2Q0dk1QTnRLeVBCQzNFMkFYOUdB?=
 =?utf-8?B?c050dDZlR1hhL1lKNkJSTVFLZS93VnhONHBnb0VTb0FWdHc5T1V4TG5UaDlz?=
 =?utf-8?B?Q3MvaFRXOHhWU0E3STgrNmFFNm40TFFUc3puTk94M0R3MmVEenYvM0JFNHV2?=
 =?utf-8?B?UVlFMlVvSU1xVkt2Vmtta3J4dWgwMnVrTEVhYWpLQ1lLTmZUVXFYbW94WjRX?=
 =?utf-8?B?OEZyb3Fhbis0bDVwRmlDSExXayt1Ymt3MWZqSDdwdHYvcTFPa3Q1NE9vdGZD?=
 =?utf-8?B?YUdzWDhKTEZoQjBxYXYyT0JOYUc3VjMrRVJmSTZtSzJCZHJOcTNSZ1FhdW1t?=
 =?utf-8?B?WVdqaFlqckUwZ3dmWFVqbEJKcDhCN25zL0lUdHBpVmVSbGN3N1BEY0hJYXFE?=
 =?utf-8?B?RXZ1cURoc09aMnFHcStFVCsyaW1DR0hnRW92S1hRQnBzbHMrbHhMWDhJS3ln?=
 =?utf-8?Q?iRwg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e195e3da-4e0f-4f15-d0e9-08d9abb0f181
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 23:04:30.5340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7Ha9g6F/pOw0VOLCQKHHVjnYonHitZFlcPrgsf/RD7uCTShRzs6kyQS1e4FQdOP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8901
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/18 22:53, Josef Bacik wrote:
> I updated btrfs-progs on all my test runners and started failing tests
> because I was getting the TRIM messages in the golden output.  There
> were fixes that went in recently to properly detect TRIM support which
> resulted in extra messages being printed.  Fix this by redirecting
> stdout to $seqres.full for all 'btrfs device add' calls.  If anything
> fails we'll still pollute the output, but normal status messages will
> get properly eaten.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> v1->v2:
> - I missed some of the device add calls in btrfs/176 somehow, fixed it.
> 
>   tests/btrfs/161 | 3 ++-
>   tests/btrfs/162 | 6 ++++--
>   tests/btrfs/163 | 3 ++-
>   tests/btrfs/164 | 3 ++-
>   tests/btrfs/175 | 2 +-
>   tests/btrfs/176 | 6 +++---
>   tests/btrfs/194 | 4 ++--
>   tests/btrfs/197 | 3 ++-
>   tests/btrfs/216 | 2 +-
>   tests/btrfs/218 | 2 +-
>   tests/btrfs/225 | 2 +-
>   tests/btrfs/238 | 2 +-
>   12 files changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/btrfs/161 b/tests/btrfs/161
> index 059b95ca..ed5b67fa 100755
> --- a/tests/btrfs/161
> +++ b/tests/btrfs/161
> @@ -42,7 +42,8 @@ create_seed()
>   
>   create_sprout()
>   {
> -	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
> +	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >> \
> +		$seqres.full
>   	_scratch_unmount
>   	run_check _mount $dev_sprout $SCRATCH_MNT
>   	echo -- sprout --
> diff --git a/tests/btrfs/162 b/tests/btrfs/162
> index ba37ef0c..7680e1e4 100755
> --- a/tests/btrfs/162
> +++ b/tests/btrfs/162
> @@ -45,7 +45,8 @@ create_seed()
>   create_sprout_seed()
>   {
>   	run_check _mount $dev_seed $SCRATCH_MNT
> -	_run_btrfs_util_prog device add -f $dev_sprout_seed $SCRATCH_MNT
> +	_run_btrfs_util_prog device add -f $dev_sprout_seed $SCRATCH_MNT >>\
> +		$seqres.full
>   	_scratch_unmount
>   	$BTRFS_TUNE_PROG -S 1 $dev_sprout_seed
>   }
> @@ -53,7 +54,8 @@ create_sprout_seed()
>   create_next_sprout()
>   {
>   	run_check _mount $dev_sprout_seed $SCRATCH_MNT
> -	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
> +	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >>\
> +		$seqres.full
>   	_scratch_unmount
>   	run_check _mount $dev_sprout $SCRATCH_MNT
>   	echo -- sprout --
> diff --git a/tests/btrfs/163 b/tests/btrfs/163
> index 1dc081f1..59f0461b 100755
> --- a/tests/btrfs/163
> +++ b/tests/btrfs/163
> @@ -58,7 +58,8 @@ create_seed()
>   
>   add_sprout()
>   {
> -	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
> +	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >>\
> +		$seqres.full
>   	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
>   	_mount -o remount,rw $dev_sprout $SCRATCH_MNT
>   	$XFS_IO_PROG -f -c "pwrite -S 0xcd 0 4M" $SCRATCH_MNT/foobar2 >\
> diff --git a/tests/btrfs/164 b/tests/btrfs/164
> index 3e69b35f..8fd6ab62 100755
> --- a/tests/btrfs/164
> +++ b/tests/btrfs/164
> @@ -48,7 +48,8 @@ create_seed()
>   
>   add_sprout()
>   {
> -	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
> +	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >>\
> +		$seqres.full
>   	run_check mount -o rw,remount $dev_seed $SCRATCH_MNT
>   	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
>   }
> diff --git a/tests/btrfs/175 b/tests/btrfs/175
> index 6f7832a5..dc6c1921 100755
> --- a/tests/btrfs/175
> +++ b/tests/btrfs/175
> @@ -49,7 +49,7 @@ _scratch_mount
>   # device.
>   _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
>   scratch_dev2="$(echo "${SCRATCH_DEV_POOL}" | awk '{ print $2 }')"
> -$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT" >> $seqres.full
>   swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
>   swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
>   
> diff --git a/tests/btrfs/176 b/tests/btrfs/176
> index 8d624d5a..9a833575 100755
> --- a/tests/btrfs/176
> +++ b/tests/btrfs/176
> @@ -30,14 +30,14 @@ echo "Remove device"
>   _scratch_mkfs >> $seqres.full 2>&1
>   _scratch_mount
>   _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10)) > /dev/null
> -$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT" >> $seqres.full
>   swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
>   # We know the swap file is on device 1 because we added device 2 after it was
>   # already created.
>   $BTRFS_UTIL_PROG device delete "$scratch_dev1" "$SCRATCH_MNT" 2>&1 | grep -o "Text file busy"
>   # Deleting/readding device 2 should still work.
>   $BTRFS_UTIL_PROG device delete "$scratch_dev2" "$SCRATCH_MNT"
> -$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT" >> $seqres.full
>   swapoff "$SCRATCH_MNT/swap" > /dev/null 2>&1
>   # Deleting device 1 should work again after swapoff.
>   $BTRFS_UTIL_PROG device delete "$scratch_dev1" "$SCRATCH_MNT"
> @@ -48,7 +48,7 @@ echo "Replace device"
>   _scratch_mkfs >> $seqres.full 2>&1
>   _scratch_mount
>   _format_swapfile "$SCRATCH_MNT/swap" $(($(get_page_size) * 10))
> -$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG device add -f "$scratch_dev2" "$SCRATCH_MNT" >> $seqres.full
>   swapon "$SCRATCH_MNT/swap" 2>&1 | _filter_scratch
>   # Again, we know the swap file is on device 1.
>   $BTRFS_UTIL_PROG replace start -fB "$scratch_dev1" "$scratch_dev3" "$SCRATCH_MNT" 2>&1 | grep -o "Text file busy"
> diff --git a/tests/btrfs/194 b/tests/btrfs/194
> index a994a429..2431692b 100755
> --- a/tests/btrfs/194
> +++ b/tests/btrfs/194
> @@ -55,9 +55,9 @@ _scratch_mount
>   # Add and remove device in a loop, each iteration will increase devid by 2.
>   # So by 64 iterations, we will definitely hit that 122 limit.
>   for (( i = 0; i < 64; i++ )); do
> -	$BTRFS_UTIL_PROG device add -f $device_2 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG device add -f $device_2 $SCRATCH_MNT >> $seqres.full
>   	$BTRFS_UTIL_PROG device del $device_1 $SCRATCH_MNT
> -	$BTRFS_UTIL_PROG device add -f $device_1 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG device add -f $device_1 $SCRATCH_MNT >> $seqres.full
>   	$BTRFS_UTIL_PROG device del $device_2 $SCRATCH_MNT
>   done | grep -v 'Resetting device zone'
>   _scratch_dev_pool_put
> diff --git a/tests/btrfs/197 b/tests/btrfs/197
> index 597bc36f..22b37b4b 100755
> --- a/tests/btrfs/197
> +++ b/tests/btrfs/197
> @@ -55,7 +55,8 @@ workout()
>   	# don't test with the first device as auto fs check (_check_scratch_fs)
>   	# picks the first device
>   	device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> -	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR/$seq.mnt"
> +	$BTRFS_UTIL_PROG device add -f "$device_1" "$TEST_DIR/$seq.mnt" >> \
> +		$seqres.full
>   
>   	device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
>   	_mount -o degraded $device_2 $SCRATCH_MNT
> diff --git a/tests/btrfs/216 b/tests/btrfs/216
> index 38efa0f5..5d6cf902 100755
> --- a/tests/btrfs/216
> +++ b/tests/btrfs/216
> @@ -28,7 +28,7 @@ _mkfs_dev $seed
>   $BTRFS_TUNE_PROG -S 1 $seed
>   _mount $seed $SCRATCH_MNT >> $seqres.full 2>&1
>   cat /proc/self/mounts | grep $seed >> $seqres.full
> -$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
> +$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT >> $seqres.full
>   cat /proc/self/mounts | grep $sprout >> $seqres.full
>   
>   # check if the show_devname() returns the sprout device instead of seed device.
> diff --git a/tests/btrfs/218 b/tests/btrfs/218
> index 5af54f3b..83ec785e 100755
> --- a/tests/btrfs/218
> +++ b/tests/btrfs/218
> @@ -41,7 +41,7 @@ $BTRFS_TUNE_PROG -S 1 $dev_seed
>   
>   # Mount the seed device and add the rw device
>   _mount -o ro $dev_seed $SCRATCH_MNT
> -_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
> +_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT >> $seqres.full
>   $BTRFS_UTIL_PROG device stats $SCRATCH_MNT | _filter_scratch_pool
>   _scratch_unmount
>   
> diff --git a/tests/btrfs/225 b/tests/btrfs/225
> index 408c03d2..cfb64a34 100755
> --- a/tests/btrfs/225
> +++ b/tests/btrfs/225
> @@ -48,7 +48,7 @@ $BTRFS_TUNE_PROG -S 1 $seed
>   
>   # Mount the seed device and add the rw device
>   _mount -o ro $seed $SCRATCH_MNT
> -$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
> +$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT >> $seqres.full
>   _scratch_unmount
>   
>   # Now remount
> diff --git a/tests/btrfs/238 b/tests/btrfs/238
> index 2622f353..57245917 100755
> --- a/tests/btrfs/238
> +++ b/tests/btrfs/238
> @@ -38,7 +38,7 @@ $BTRFS_TUNE_PROG -S 1 $seed
>   _mount $seed $SCRATCH_MNT 2>&1 | _filter_ro_mount | _filter_scratch
>   md5sum $SCRATCH_MNT/foo | _filter_scratch
>   
> -$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
> +$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT >> $seqres.full
>   _scratch_unmount
>   
>   # Now remount writeable sprout device, create some data and run fstrim
> 

