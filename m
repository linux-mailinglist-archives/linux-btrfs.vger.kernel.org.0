Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9C459871
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 00:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhKVXfx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Nov 2021 18:35:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:45669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231550AbhKVXfx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Nov 2021 18:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637623961;
        bh=Z9/W77qsti5bD8UyDv7AfFg5JlsVhhtAmquSYjvbB80=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=FipZfZpJwxrVukhZTP6jOCrXlAdFGzuCDNA1yc6ZvbfTpUR1E6HMrrmIYYXfb+73k
         /fc99nuYgH3Zoe/j7mX3+pHdmM7n9sae/rlPbmRAOGf+8O8H/Xe8IqivcPLCBle9UX
         /SBSqRZ+aQLIZQUA+j5xpUDqbs6HIjBSwx0M1FO8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MatRZ-1mErS73K9b-00cTTJ; Tue, 23
 Nov 2021 00:32:41 +0100
Message-ID: <754fdf36-cc66-9a02-2e0b-e0fb54f65982@gmx.com>
Date:   Tue, 23 Nov 2021 07:32:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] fstests: btrfs/099: use the qgroupid for qgroup limit
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <595829c06353ab12280513ab880bb742a2389bbe.1637614211.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <595829c06353ab12280513ab880bb742a2389bbe.1637614211.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l/IdmX5uEyiNwlS7bz3BSB20JEKmgkGUTxgH8hybNKx3fTyu/MV
 EI9anfbUKy5zfXThJ4kwwOB+QGDvc10RDfnIDeCRez2GmSeNUVX6F7kxpohwbWemOv2vplV
 N72YRU8qFpuGsyQ+LboeKIXZVKYioyRI7UrYnTPlwhPY1xsrY54xzLyTJlqwqbdx0ubPDzz
 ORlLvyhOlTQMYIHeAHfwQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HTnUpxVhBM0=:Mb92FeDfo0QWVo9SakFDWx
 Dcr9K/U0L6a8qNgk1MIJAh4e/EFs8qCIktPRxGSLF+muPOJgKcpQ79EVTiX7DxTQttIrppVnP
 S7SCvgoQ+mmMQsNqWcu/mtNpafHc4vez5wb63SsrksDeR4VlmS0xP007PYsDiJryDmTjvX2A9
 e2ZdKApJlMrVWXeavudOw2Y1PHyYMqb0J5Uagc7iwrSSnUBMLkrVjN4g+/PRhrAKh+TpMc0oD
 4DIEybZ4hRSI5TJQ/hLZ95eNHa48CuGOPPUeScVGMhnukDJMzKFhhLSyJDVPPr/+IiQwepyzC
 9YHEKAYIwmaExhW9y6HQ50v/kDMjLNkUHfxFc+zo/6fKn/Hk4UkMhyTz7MEA3A7lfHRAnYtg0
 ZKgnEV4LK4SaoCwATshISk3SUMN6nbWm/8ggnJmTX6uTjyNptZW/zty7wSfbtHGzUxDpB8bfX
 4nUSCaH/dRY6oStmxMdcE5pM4R/hqznSWQM2eZacl0ovCYlYzBpDc7qbdaP3e+ROhzYRLXwYW
 EtvK57TiGxEll9Snm7K/WMpK9CO0gOBokHJebfshV4eLID8yHGUlI+CodAW1eQcIe9yPkorcl
 UmjbG8qg9umzoJsB51dtHFFkrrNIIilV9h5l+adRoiRfQQ01A+yipDg6nm+O/+1lX0tPgr3kU
 iIrrJs56L0n9Pw77FX4HP0yF9hEDQMRbuS1ftHlgDO5/oPjrlvcOodJ1o2Ztm0v97BBI6BbuY
 uRjk5lOswgkVA/X87bWS+CSd/yeoCgEm3i3Qb743xnwZB/kXrrFzNfV1Xo3xdty4xHWp0KV3H
 DlHQPau5S9AUgacZrykTuSO076WjOsFq/ppPcBlFRRcVNcmdQhyc9Pol98+juyw0+c7BkG+k0
 00W+yYULZ9Ub2uhA/oxymnpW+GkdbsXOQSNI2bWupzNfDOhdwOuIsEH+sex8U+ScsjfnItyo1
 DGI85nt6NCLIr/qjw4su2IC+Nne9dFJChmSB5SgTmr6utWotIrAqAcS6sYDRHw118CiOcs94M
 LCzmbD151hLW2hFJCT+8zI38A+BlwxAYshVz8ORlbLVnlMXKEJG38PJI2qrNBHejx5RuB/htv
 Yb7b8s2bNJ6p7U=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/23 04:50, Josef Bacik wrote:
> A change to btrfs-progs uncovered a problem with btrfs/099, we weren't
> specifying the qgroupid with the subvol id.  This technically worked
> before but only by accident, and all other tests properly specify the
> qgroupid for qgroup limit commands.  Fix this test to specify the
> qgroupid, which will work with older versions of btrfs-progs and newer
> ones as well.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/099 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/099 b/tests/btrfs/099
> index 375cc2b9..f3a2002a 100755
> --- a/tests/btrfs/099
> +++ b/tests/btrfs/099
> @@ -29,7 +29,7 @@ _scratch_mount
>   _require_fs_space $SCRATCH_MNT $(($FILESIZE * 2 / 1024))
>
>   _run_btrfs_util_prog quota enable $SCRATCH_MNT
> -_run_btrfs_util_prog qgroup limit $FILESIZE 5 $SCRATCH_MNT
> +_run_btrfs_util_prog qgroup limit $FILESIZE 0/5 $SCRATCH_MNT
>
>   # loop 5 times without sync to ensure reserved space leak will happen
>   for i in `seq 1 5`; do
>
