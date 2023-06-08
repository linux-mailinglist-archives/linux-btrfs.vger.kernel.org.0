Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF10727CFF
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbjFHKhm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbjFHKhj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:37:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100672D60
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686220641; x=1686825441; i=quwenruo.btrfs@gmx.com;
 bh=pzcmjDrJgJTtRLMs/zVntmEfHRYz9+Iofyd91FGWO68=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=IFwBGbwejcGMKSdB6E/3Zo5CxG1QyFDEdKsHl1MmpPOk28daOkR1V3ajGce7IeYDYNsKYNS
 lM/FRKuyN3MZDTLILCWspW1pmZhnuMMBJRksh7Tz+Zwzz9BISPQBtDLvEjjeRaDGv0MytFuRx
 wvHNjU9I1PK7cR8nbHs2sXaGVOAjmbkX9u/hmX0QMmU1UwtVgN4l8pUAWMrZ8nU8jUXcROPpe
 LDqrdfcZjCvfRtGyJI090AGkoJlGjvzCCDbMbP2UjZymTahGhUfqMoEGFob6gsiefad2lAT6X
 TeIah77gaJ5QnbQ2/1h6wDyiejcAggShggYSm8P6n6vugKt/7E2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mxm3Q-1pxnFW29uw-00zGKe; Thu, 08
 Jun 2023 12:37:21 +0200
Message-ID: <80323998-a3b0-41c7-5136-7d4a68fe8dcc@gmx.com>
Date:   Thu, 8 Jun 2023 18:37:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 08/13] btrfs: abort transaction at balance_level() when
 left child is missing
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1686219923.git.fdmanana@suse.com>
 <77e4be6162916c2d23987cec9542acbc60ec2bde.1686219923.git.fdmanana@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <77e4be6162916c2d23987cec9542acbc60ec2bde.1686219923.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p1odnbXGkSpUXRt8m67HL24h5z3mVeNwWJRKLA8/qd1B8TxjpOY
 gtCB6PzeHu9CQSKTisAEpZpZ2Vba9t1j1Vh8uIvm0y0JNlZJUAJdc7BudVJiO8wRdsHqBdy
 ym2FCa9w7AWNb7nXeuYLsXp0lpiimg/bv1baENKdJ2i7aG4JFAlwMMThAa5zt/mgQYHRlPc
 5HISLT4g4rPAdwMS6nuNw==
UI-OutboundReport: notjunk:1;M01:P0:tal4UdQIQQU=;j7wI4GY2zhfiAU+KwhBkLvU4aaj
 jYZuqdJ3+ecXDz/PCc5ouI/bERE75bPGvIFiAN+j/NIa64q+rD0wZYRRjFB8EgzZPDhNIRLA9
 eWRnCRAhFBk0OGrZ8FAEmTaWdGxevV/IVmUooEP4mvv1vG27qAyDp57xIRjtGtQlU32ZA2Qgo
 L54FnJs4TiSOcaFPd4wRpOYPW27g72/NLnKrzdsIE5vNPiJ1VR3dpWWSRS6TdNL3NUtYWHoFx
 4/j5o95ALA9dZtqsvGDONWiENoTYSbqaGnQl8GTgbT74IqtMJH4DOoihxnY+KC0zWPKDgY8nQ
 gZdsveDN2nzbv0v33EfcxmRpMemvKF1WBifI7gmCVWzl0hZxY79Kmgy+5LO+oDkg2h294V7MO
 NRTQSCQo0ZNXWeVAS/t00L9HRMxpQfp3+gHOwkJBvEW/ES5W8aylKua9jpw56beTNz8352HpG
 YplZgCkvkFVgwwxC++7v83bD0jLoqT4uFUjJU5aZHJ/hSHqsgFlSKRMvS1QsxIVTsbh5PclG/
 fn9OrKwSN+lAK3BxRF7fp/R6mdzdTpJAh34wG2Jfj2eXGE6CzCw7y04raC3r4uW/MMDrX9J3c
 Pt8gwrEZS1pBvyaP+C7zjk7akowTsJt7ujvB7nV2kJUrUHojcxkQEZqY4B7rsWYegaIfI/f4P
 PO/hnuMPXNRAAJEjE9U5e9X2/yDMtG/ayiwGo/VEPMFtbUhlcKl7WYhcsHPFW3NwskFswmnUY
 UCfk9YC8iR8rQBgxz4t9iRwd6YIcJZL5ZRLZP9/KrCPRsdozA7yKczjOyeAZ8Jn2A660ohdr5
 dtBX+13dura0xJkQB4aUslc0kbdI2XSovGQ2rFafuyVVDkvDPrNf6ADx7GxFx7zQ7tXTPWptQ
 aohtRSu8YYPcyIjA9PWlPfKQKEcqkfp0it+JzF0fValgk5tw3v/xxA+kAREvVCaNdYB2jSnyA
 ICm6Mt0+7ScS+3xVHTKHDFQKmW0=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/8 18:27, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> At balance_level() we are calling btrfs_handle_fs_error() when the middl=
e
> child only has 1 item and the left child is missing, however we can simp=
ly
> use btrfs_abort_transaction(), which achieves the same purposes: to turn
> the fs to error state, abort the current transaction and turn the fs to
> RO mode. Besides that, btrfs_abort_transaction() also prints a stack tra=
ce
> which makes it more useful.
>
> Also, as this is a highly unexpected case and it's about a b+tree
> inconsistency, change the error code from -EROFS to -EUCLEAN, tag the if
> branch as 'unlikely' and log an explicit error message.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ctree.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 4dcdcf25c3fe..00eea2925d1d 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1164,9 +1164,13 @@ static noinline int balance_level(struct btrfs_tr=
ans_handle *trans,
>   		 * otherwise we would have pulled some pointers from the
>   		 * right
>   		 */
> -		if (!left) {
> -			ret =3D -EROFS;
> -			btrfs_handle_fs_error(fs_info, ret, NULL);
> +		if (unlikely(!left)) {
> +			btrfs_crit(fs_info,
> +"missing left child when middle child only has 1 item, parent bytenr %l=
lu level %d mid bytenr %llu root %llu",
> +				   parent->start, btrfs_header_level(parent),
> +				   mid->start, btrfs_root_id(root));
> +			ret =3D -EUCLEAN;
> +			btrfs_abort_transaction(trans, ret);
>   			goto out;
>   		}
>   		wret =3D balance_node_right(trans, mid, left);
