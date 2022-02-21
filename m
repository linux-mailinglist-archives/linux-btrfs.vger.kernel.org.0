Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8200B4BD2D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Feb 2022 01:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbiBUAQr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Feb 2022 19:16:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245348AbiBUAQq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Feb 2022 19:16:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8178E4476C;
        Sun, 20 Feb 2022 16:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645402560;
        bh=u55hKlChXTEXIJuV+e0xiIjiT2nKtCrwDTUv/GZniC8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SC+12ipn9rbHMsrVsmYy3Un09pxQVpkeoSYVL7Fp76hgJ8ynyDYZDTEOwe8xxl3W1
         iCr0qqG1r3UuIJkMV49Fc6EfibX2It0gNibwDTnDaW6FDOckJNJi2SJEFvWLMmMm4r
         YZY1P/nbxYR/sm74d4/3jwSyLE1j7ub86SJqAGiA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Msq2E-1oEioR24W8-00tBUZ; Mon, 21
 Feb 2022 01:16:00 +0100
Message-ID: <0a2e57ad-2973-ea01-ceda-3262cde1f5aa@gmx.com>
Date:   Mon, 21 Feb 2022 08:15:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: Initialize ret to 0 in scrub_simple_mirror()
Content-Language: en-US
To:     Souptick Joarder <jrdr.linux@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
References: <20220220144606.5695-1-jrdr.linux@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220220144606.5695-1-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C8JAjspcmErs2qvGcN+rf+gs5pzGazDeRknGb4nSBztbmyzskiA
 m9rvdxjYIuSlPwQKNsJs1CwrpBoPxYQ/puNKMgElBHkhgjzY//jcZtbFn7w+HX377mox0yY
 8ksMF6XX0qOIuy7Un30A/N+W7hwryUj0Bkya3FCNQuPjoNLn8Hry02cTy+19fs8f/UnaeFG
 iyqjwOaM/nUeUHDRhEE8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yHT8ct1YwXg=:4qNAuuwGPL0dLqTUBv6r62
 zj5vSKm4vU4+6oz1vjcziodlfbEPOa0pj9GfCrG9SS3JMaiwIhYjSbPr9nCXZZuojMOxWMQFQ
 7RtidxnLHDRq+JsCooYST+0Inw154w8Km/qCwm/Z0d8OV6on0YCDmuk9FLJlFdQBhoCGg/TfA
 FIlIDGSyqfnZgO1AlrbK1KSLNHZoTD4VJhwiHXmzsBPBYWXLK5XqKXwzAzPKwj6UvqGg+Zvli
 Uvnf0b7sxgbybCb0VLbjvlSqYg+UxA/h3z1zcAi40yo+ywuxDWgt8FI9pNKYdZLOHYIjDi4vu
 QKTVAWA+rdoErEMn9NDwKK8kfJ8wBqhFC+VL8AZUlH5r2afOLE5kiuBp200ONqKP+Q1vCRr2t
 UtfIqgkIs6X3V45EwoiZoHdXGiEC9lKr39EJWn1ekWDtD8OkvujklKpvnfVb3HPudNH2+gW+R
 +9mEP2wbKPyfdu0YN+IHxu6OAxhCPoaFkaBI6OZJmTsXctGIetf0q83mTcyNPV0hv/3WswbcA
 UY+6UTD327ePsxsSknt8FjWaddkcRuvYVXhsJEHLfnN1KxApInZc21ZMzGKnw5lXBcHjsnKpD
 mRrGk0Hl5hTuTP/IH0/lXrbWO0lJ48nHkeJ+5GQl451Pk2g5SwVNSizwecbELyA+0BrZ9OlRf
 c44lgZ9cQyxV1trcDOYlBWpzC1XGBgdp7LT+VWxJm0FY8eSHuN+Qvl8lsI9FDI4FkxeIQcXDS
 rthFP3zPRbZNn942ZiAkBOcnBEe0tajPq6GINlKy839j/TkGdwdhsxp5i/zHyY0HeOEfZBKiY
 dQ8GiaCYMRNthEnz/lSxZAiqjUL215EpJZ03RWdjAS1pecJyqnYSy+1Du42qPhQcJQd9SGR/X
 YsTWykG99zSWMcxtDQFb5rVnLOK/Zr1Y0ibPg4KgXmWsU/za1R6xIVf25D0Uurc+fiEqc6Nqt
 UJcW7p6fDiXeXNHETw/uh6tF2i1+khedwzMa4Tzu92FU25n2KVI9ra8nEBuymO9bovJmypWnY
 91Kw0Tj5y8nw0oEXi7baNMjpIFxS7l8bHzfBDY49/bsQE3ZgLLDayrujOchaDdVA4hqBWNCqn
 2DbeNLW8aA/Orw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/20 22:46, Souptick Joarder wrote:
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
>
> Kernel test robot reported below warning ->
> fs/btrfs/scrub.c:3439:2: warning: Undefined or garbage value
> returned to caller [clang-analyzer-core.uninitialized.UndefReturn]
>
> Initialize ret to 0.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>

Although the patch is not yet merged, but I have to say, it's a false aler=
t.

Firstly, the while loop will always get at least one run.

Secondly, in that loop, we either set ret to some error value and break,
or after at least one find_first_extent_item() and scrub_extent() call,
we increase cur_logical and reached the limit of the while loop and exit.

So there is no possible routine to leave @ret uninitialized and returned
to caller.

Thanks,
Qu

> ---
>   fs/btrfs/scrub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 4baa8e43d585..5ca7e5ffbc96 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -3325,7 +3325,7 @@ static int scrub_simple_mirror(struct scrub_ctx *s=
ctx,
>   	const u32 max_length =3D SZ_64K;
>   	struct btrfs_path path =3D {};
>   	u64 cur_logical =3D logical_start;
> -	int ret;
> +	int ret =3D 0;
>
>   	/* The range must be inside the bg */
>   	ASSERT(logical_start >=3D bg->start &&
