Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81247509D12
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 12:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388032AbiDUKE4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 06:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388030AbiDUKEw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 06:04:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A8A25593;
        Thu, 21 Apr 2022 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650535311;
        bh=v4cU4eAW+cQW0W293X7alJUNS3u4zCDo5GbphXXSZ9M=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SXDt/pUu8pOYmpAanM1/012yEx/1hfXqCok/U+DXn/6LgO3Yf5uV3ieqjKBtACcK7
         k0a0kVG++m04Sr/lvGlPqexCqg6kIVE4L4nad3vicY+E1xpyASUNyzopA/WDp1it8U
         7gcADdwfMWVmW7V+KX8NxeunwOkU83/ThsqWRiYA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5wLZ-1noMBr3CbD-007RYk; Thu, 21
 Apr 2022 12:01:49 +0200
Message-ID: <8a126e1f-66e2-dfaa-5880-399ff83ea633@gmx.com>
Date:   Thu, 21 Apr 2022 18:01:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] btrfs: Fix a memory leak in btrfs_ioctl_balance()
Content-Language: en-US
To:     Haowen Bai <baihaowen@meizu.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1650534677-31554-1-git-send-email-baihaowen@meizu.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <1650534677-31554-1-git-send-email-baihaowen@meizu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lUALets5R6yecAskXb3jCSGPCLbnANmOfpjYNJ5AfKECz3j3J0V
 j4wjCsHUtU4DBHCjivjUrA8bBhOzV3exK9oCqDJ40KjwBmmw8yN0icM323lSNEbth0DfWFG
 tJK3gYXXDYEULseKs5Pya2spnLbDLImmO+Y5VaXGpvuSJe1S5By/LZsnMlEsInJ3K9mriWh
 foLHa04P22QFMxMSyYUpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KIsuY3AJHJo=:Ec+aQaMKa+WDkVJdcMOcjW
 jMfIIZz40hJjZtmJdNJOIg+NJQuVh7o5nmuXYDQs/nVs3m+hd4JJaZ4rGYmJpBz39Ka5chyXv
 sMR7iJ0/YBLLACsjZywsxWwNMc+3ZPFBmja3MdC/Ewp2cFHAX3een8RvMga75pgFgujZQrfxM
 sdSlLogWlSNHir5p4xUNRxMxF++sB41fUhVd7AUz7UGMU3AKqlXSOTooDP12sJFXDm9r3RBOr
 B57Ga2GbMPHCnOQZtyPyRp5PDFRXzxYg7J5PDXbw8M3tZI+Qtn6oGC5N1D1Q4P/I9Pf8VnJU0
 dbO7y7eGGqpemsV1GLwoW38vSooK1LI5DnF3sjIiktO1tmHYkwVn2sNLzHJNdzSvliIsWz+Eq
 QS66UeGG5D4QItIESJGpzmh67naagvtW01jWdK6R4xlf0RfROWr+MzzAHCvEZXl/6ndwu0bJN
 6N9kSDzLg55UQZLAiS845aVfH2JG0H1c6lWKE2ZHQ4Fav2XiLdNlhchzta0KhA3Bi1xbEywc2
 oWur//qt35L6e+m0EyBBfknRIW4UEegl1a8NlI7XbKMR8XpTuaH7ePTCwZIthWvt7ezYJknSp
 96hOtrMnjVi8FlwlBIDtVEMU5FXR4sHtPW1G0tB0est7u4A7A5zs+0lDTAl5YHeMMhrkmCKy8
 u7v2VpGqUnpR+kr91CM937bmDysXcgGWPKrlim2yE81M47IlTANgsA+bjeDK+qABdJ53Cglgk
 nTG0TUkZFnitbgna4Ic3oXRi+mLF7rjPykXM32AquVVAGLIIOBqvklWDN+1UFYwvPJlH2h9ck
 LKaeeiG4bCmBCazIYjQPuNHIg4LlqvwTwp5bnJe4x3SapXBetxAWVUX0ogzVuYhASrmnB33pr
 KavvuPpX8XDxhNcbem1v70rhFj/YIVS+WmpTxroGoLzzQp6OGHLW6N/x8y6waojJv5mV+JsQ2
 +itElWbzJOJkRJkTRmL++4TWiVxMMiZBr+F5jAr0MnPnBD/OLFfPNXKMmcMiNb61BXonk/A2q
 fVrFym6PUQ6a/XaKfHaN/ZOH/jm2wRnLcD81rEPPtnfFYfl1HbkZFpmNW9eFiEL0QRzRVbgXv
 yLMqRo/vJOORvI=
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/21 17:51, Haowen Bai wrote:
> Free "bargs" before return.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>   fs/btrfs/ioctl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index f08233c2b0b2..d4c8bea914b7 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4389,13 +4389,13 @@ static long btrfs_ioctl_balance(struct file *fil=
e, void __user *arg)
>   			/* this is (2) */
>   			mutex_unlock(&fs_info->balance_mutex);
>   			ret =3D -EINPROGRESS;
> -			goto out;
> +			goto out_bargs;
>   		}
>   	} else {
>   		/* this is (1) */
>   		mutex_unlock(&fs_info->balance_mutex);
>   		ret =3D BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> -		goto out;
> +		goto out_bargs;

out_bargs will also unlock balance mutex, causing a double unlock.


>   	}
>
>   locked:
