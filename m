Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79577557729
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 11:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiFWJya (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 05:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiFWJy3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 05:54:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AC72AC4F
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655978065;
        bh=CNyeq5q1WYMbTL5+iB7vhl/fd+PRg3fcgQCn1R+K5zk=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=I60Im3P/fVWjnSHDnyTxjh7JpE0ReM3zPgGLVSJRlWg//zdC7z00RaMnLLQFEyyJW
         3rswpUBZ839XMGigDDuwdYasR7rK+uVJ+VkxzVE1wURcMq2/KPQbEP08fLbCfrnpso
         JyXnhuzqBkcsKxnEa08J0FLyyLije6++BLrnWQZk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MpUZ4-1nJ6EO38Vo-00pvJ6; Thu, 23
 Jun 2022 11:54:25 +0200
Message-ID: <419ccdc0-fb58-0db2-0ad1-b4fec52bb2ff@gmx.com>
Date:   Thu, 23 Jun 2022 17:54:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] btrfs: remove overly verbose messages
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20220623075752.1430598-1-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220623075752.1430598-1-nborisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9uKAI6YhTkihPTwVYOQmOzP1qFCVVvJSilV4CS8hWdVnH2y0Eoo
 ocBjb4O4ocmFdCIHpNe4D2PmVxxCcNTVWo6//uDNz2ttSZF3LuU/XtEwwRDRYF3EkRnl+GB
 MdV3ZdsB85u6DBkhZ/+vCpXRNc/kpBYIXAaRx9Fbv9gb3IrGuRdLGuZRN887VC3ppgUD+1D
 GMu+NkC05Eedzv/qR4hAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YY5SeH/xkvQ=:ArGjJDT6vKX2HPNqqUMatP
 4IngQVEf6GvFKf9w+aapVZlE3ZtvZzdFOB89e0Ep9lwp9l9Itum/U4Gm0dVnMAhBoSxnroWAe
 wuw76LgEV08KwdIUuEjMZN4OU4e+rPnrCDJE/7re5enin8OX0j4uiJvLDq9E96+pUMag58nZv
 umvZE8t0hcrvrN7iTSQ6UI3qfXS1fLoopWOgb7Y5Spiqq3DsMAySN+QG4wSBPw+aKLNP/vKSk
 Hxe/pDbiVxzEGo3MK/XIabT1cNqvlQ90TBrPxUTuomqt23cMinU5pA61hg7iinTf3EyKHkSgM
 iY/7gWejyfveht2uhT2d5ZQL41V+6iLAgGWfuz9FoCC0ppa+BSqyQrv7Qez2hq4mjHh5QHi8B
 tzIWXwwvSuS/mG01aXV2AhS7t+p1iB6xtW21xGjN/fJgPlqPrd9ks+B85080qPQfcJFo1m/nV
 rdbhHX7E8LPnaQUs3nKEpB0QgKX2k4n0DV/rvC515N/cDpCZgT4JNxIKZcBEv7rKupXjaK4Ic
 kLB+o+LQheMl41EDdPv0M+VERpDQ3/pRNGcPQsk3ZJ6RJRXw4PbOqTXsqfrMGbEia5arf2hNz
 vci/0AoPi7SV5pMoPrdKu3fJhl3p7sWqEZ1qqw1lNM4UIg7egpEkrL7wJXlHlowU9b9czvLWu
 nqdVXwSwISSUoVBH4Y4xEfAnGdprB+k5KxjXTL3JF7xzY3ZP+M0nzqc3ja5wph2z/PcuM9D4p
 ccyM9l2qODbzzrJeCms62JuTGR8tckqsGtvz+P97upB0lLtAaHmfSg11UlrrHqQqjXJkqL4hV
 i2tAtBFbzAZtm0iiZK2KmOWpGS7lX+/T1wVgjUMH0C/drLNt5iv3UX7bl7hc6n9QI8/z2wcMU
 iSvhKaXgvgByQ+XB3mxTRkia7OrLDGPe1RPGj49VzCyVI8TtUuHPBAOWWznsHc3KNYXFWO2JM
 5hoZW1j2AfvxOftju1S0qOGH7Ys6KAK5nyJT2uhepBoq7h64jpjkFQh2udWF/BW5wKcUJ82T5
 knGVBhLB1rgMQX3pPnHjoy84JW651moUhI7VwFzBoOQrsG40vWX78k64dCjXZZgbR63hEzPkj
 58p4IM3iRaF1PiJ6NOVBnvxQxjqu+pwmcNn3hys4KLX4Y0s1I3Me5b4jQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/23 15:57, Nikolay Borisov wrote:
> The message "flagging fs with big metadata" doesn't really convey any
> useful information to users. Simply remove it.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

THanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c3d92aadc820..8c34d08e3c64 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3508,12 +3508,8 @@ int __cold open_ctree(struct super_block *sb, str=
uct btrfs_fs_devices *fs_device
>   	 * Flag our filesystem as having big metadata blocks if they are bigg=
er
>   	 * than the page size.
>   	 */
> -	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE) {
> -		if (!(features & BTRFS_FEATURE_INCOMPAT_BIG_METADATA))
> -			btrfs_info(fs_info,
> -				"flagging fs with big metadata feature");
> +	if (btrfs_super_nodesize(disk_super) > PAGE_SIZE)
>   		features |=3D BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
> -	}
>
>   	/*
>   	 * mixed block groups end up with duplicate but slightly offset
