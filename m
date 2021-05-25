Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25A3390D1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 01:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhEZABB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 20:01:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:57777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232155AbhEZABB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 20:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621987169;
        bh=m+AiBf2aHMcRC2W5Vub1ikNLNmhuwki9HmfZw6Q24gg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=Y/jS5o87GX+oAV9W8TflxJBiFblruR2FXEbUWTc/RlsQcCzfEY/1z6o+m+BJlqIz6
         8LzsKlcLNc2sCMmLl5hWEtEXz2/TRrKsKiUQAjDjiyPW0EAW0/lJdVxFCoOUzO1Ls/
         UCASXpaWwaEGlkoaxQn4w1JL/5AMv3VrMZhw0DYE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MUXpQ-1luatE0NjU-00QPN1; Wed, 26
 May 2021 01:59:28 +0200
Subject: Re: [PATCH 7/9] btrfs: remove extra sb::s_id from message in
 btrfs_validate_metadata_buffer
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621961965.git.dsterba@suse.com>
 <9728b5a77818ff0c6ab80f2fa1de72c9f5c2ab32.1621961965.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <1cf8b1ca-fbf9-39ef-68dd-e423402290ff@gmx.com>
Date:   Wed, 26 May 2021 07:59:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9728b5a77818ff0c6ab80f2fa1de72c9f5c2ab32.1621961965.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AbzMMza+cqFhcEg3oo17e1a8YlwgQ7hqWC3vZONDwmmV1l6dXUO
 xLi31gMmJ+xDspgUvJ5IJt5rdgPlnv6sqLABCTIW3VUyQ/8JZJCQcs2PnmkRK1BeOr+Qj+C
 1XEiAGE8I2fsr/hIHvxIlWuejeCVY10JeZHpK1Tk2+6GBp9eyU0QDMaTkBd4vQiOc2OD0I+
 9G2PJDye1hB5Rn9o+dsbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F4dCWUIAU5k=:88Z/C8Ev34gbzQUkFXH3sy
 Ge486XPGrkC5mwSkTN8PZ629woQfv1F8J0OahmcI+xIe1zwkzYo3hvj2vTdxrUBmBKDdiYDk7
 7vYSqacZ3efGdZvp2f9latpnrvvopU4Ogc0YE2NyZGSH+/+rXXJyHWXEC9zWGPYGNxrEpJXUL
 h+CU166K6+s2QhUK5JGOJu8mpK3eCBRM48O+4Hu7PGG2MkfSpY8YRfkQF152uzzjPLIL2YLbD
 +UAY9923WHNqq7es+1w/RHlKsxSp58kbxmMpAborI2oexKBUgRTsvX1lGEKr5Kf9vF9YuFqyB
 ejeggQewPngFjvmAMo/A1ARf1PIzyv+2WpYdwFA1Wyv1T0MR4iFL9/oeRFaEWsBqQvo3DgJDC
 qM7wlZ2ZTaKdWvRoNezosNQrgKO7NVsuOU6UkKseAUvMgHwJEmfcz9MIxQPjmNggmIG6ZCGtk
 p7EnyJoFMDSjT2vw8F5NCiILtywS78nLlPNh8Ksnr6UpYnYB1Y7yQaHbJZ/LIeNI+NoTmrGRF
 3Ca0/a3bhX/VNPY/8vR6WWL//Dz1Ym5gHW6rYmJ4xx+9g6A5Ee8WeAuEfi+DiNQBYdh47PBM9
 QMZfZydsAT+AiAW8Twkoz+gHuFaPX0VAjeiv/bjHinWLV2V3qzMnFqgSWEeBL7s6pidvLl4t4
 U+j++XvipSidSsK1seccawwdIhHb8GI0cdzUyDWBfScd5NYskzTXrx5menHTwNt02etPv4vkE
 gpqDjaH6w+N3SP3B3LMbuatmfinKK+XeKXWW5MAbTFqU4lQ9MT4kPbFJU2aqkLYiigDLQJsJV
 z9RG2p1FrYTUxQeoQEgGgAP1OCLguTsx6cMMD4+GlcfhFx/I6dFcW6sk3Zj1BjiMyvRKJYtq5
 FnTzpRac3ijIEM0P5LcqFcBLOz0dYgWVPgIbFJSFYFUZlzKZonu8n83bVFpA0gg750QfySRIU
 NYidGYpVpVowI3vsKYAVV2rKO5H7L+WddWpZdTCcXNEYz6Fr9nuHpcIvE0s8eFlC1o7LPURVo
 bPbpaX5MdxXcQpmjQnjfBverr4WQAmrKuLqmYpf1SjkvzMrKD36sAtmTm7VtkyaCDUCze99Tk
 4k2FsH0YsXzApIHBWC/gkV+jP1DrFi6CjgbLbBdwxCxv/yENKwtOpOCdw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/26 =E4=B8=8A=E5=8D=881:08, David Sterba wrote:
> The s_id is already printed by message helpers.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/disk-io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 8c3db9076988..6dc137684899 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -614,8 +614,8 @@ static int validate_extent_buffer(struct extent_buff=
er *eb)
>
>   		read_extent_buffer(eb, &val, 0, csum_size);
>   		btrfs_warn_rl(fs_info,
> -	"%s checksum verify failed on %llu wanted " CSUM_FMT " found " CSUM_FM=
T " level %d",
> -			      fs_info->sb->s_id, eb->start,
> +	"checksum verify failed on %llu wanted " CSUM_FMT " found " CSUM_FMT "=
 level %d",
> +			      eb->start,
>   			      CSUM_FMT_VALUE(csum_size, val),
>   			      CSUM_FMT_VALUE(csum_size, result),
>   			      btrfs_header_level(eb));
>
