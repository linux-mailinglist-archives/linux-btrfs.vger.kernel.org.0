Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC05C60C8B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Oct 2022 11:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiJYJs3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Oct 2022 05:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiJYJsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Oct 2022 05:48:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F8A118764;
        Tue, 25 Oct 2022 02:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666691280;
        bh=bIXLlB4wBooNLomsLfg/1mtVH+54a3pPal+Ht9C3bds=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WTQgtmv6/GiistciZvEqeym+124StEMscUGKaQgTS7Ln5yZBXvb2rjfXukUROC79R
         DcFUB3pb7OoImxGVGo2OaShdgoAypl22PAgUgjgv8fcK5s6EQP4TY5/D8Ypn6wm1s8
         dvN+pKuoZ+4QO3jNPA1S7E2QxwWnU/PbR2BXizLE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnJlc-1pTzkh0ymK-00jGXQ; Tue, 25
 Oct 2022 11:48:00 +0200
Message-ID: <9b98c931-0740-8bfc-f815-a06018ad5547@gmx.com>
Date:   Tue, 25 Oct 2022 17:47:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] btrfs: volumes: Increase bioc pointer check
To:     Li zeming <zeming@nfschina.com>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221025082835.3751-1-zeming@nfschina.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20221025082835.3751-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GE6xPUqLgkODpcEcnn5tfOGCupCfr3W5gYY8HB25FMzL+FzuIHc
 x4C8DV3Ub49gVeyb7F66zU9XACQHe0UrjoVtG6cLcKmdz1SOzeKjcHVVIzRpiWohbWOfoY+
 yUml/jD6lzWm3yxCYl23dc/W/d+bg0f3/eHxW5KZIYZAbRk3DjP0O8NR0X8b48Vad3/+f6z
 rDazoSo7YJtSdd/sYuuhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+W4ZlgkhFY0=:gv5yqAD+trEtkFIQDJWx5v
 Smndu0nd1O5vCf7g3HXks00cIFN6gtojFw49sx1huoHfv0osQDGHTphFw53shLOZS5UW9jdhD
 ipGv54omHrz3KgPBJKitZA1v+vcc5DuRWFcFzJoFpvApkGpm+1jCwb8Q9XVSaiok29ETEu1Vx
 tWYFOCGHD3N/qWgH5AsHHGQXwKBMmP4ZF+f6q5W+Dm/HPASkzfoXENajAQGhOepK5C9pvz831
 vANoREeu+jdFPwnwSf5g5JmnfJhB6l62fPZ0oJeU79aDsl6NdlObcyTi8K9PQZrqB3tp5I6Y8
 lHIEUv05npRPTFkTnhF3eJqgwItvWiTk0Ite/el+VRsB9bgWATJ+5QJBuoC6SdAGw8YMbvER9
 kgco4gmbmpyafgcD3u9MJhLQh7rgBMybHznz1irFJgQp64KJa1zYvlH4UXybU7U6iyJ+HfIY1
 c/h+wJ93AuZGaCYMqj+gUZmZX0w5GrljN9MOgEkUZe+QYu1/Zg5sCafk2vGc5fT5l/pLbt+Sw
 kjYZHFCwmhS0W/6RHL3LJuRVJPxsXp1JS75W1FSj6lsAyFeCYaL/LWfk1eyNRgTJWlmB8AbeO
 41TyoLEen5GqU1y2IlfkHT2Ab9BnO2Vo6hdU9chjzXS1K8gHMvoCa3kOS8Z73wZ9ZyX9RlqW0
 FWZy2+BzNvB9HwwL41FkMn8YodHfOUumB82hU5PJRW1pA2o1qW6s3ReKICT/VJA0fNp0wwTcU
 J3V+XGt2v2bG2GuTIhvFWUkYb5vmOT9i/W7vOB6I3nxp1Qd7+m48D/vgIkL+AjJFGI8IbQdW/
 cGl+laF+jwoRnbfkcjv+Kh+DwzyX/y8eOV7ssbtkEqfVTyiory/ePxewu3xMd+wNFdH8tNWo+
 VNIbEMsYfIVlrnJOF42LGoFhCGk9sAkNzatAWNtDg8AaxGrmzooap4cg51ebINpV3QjVd6JIZ
 b7512B11dxNktC4EQQEsH3dGZKuIjiJNfnUxZQGstcnWbfQye5UaL++fIuZeQtDyfaV9D3+wU
 GRF+6L4T9NSC4AAuRS7QE5PdR1RVSl/IMuvExpfx7ph6ZfwvmKDKdygLf/wgp/TQLGpSZKiH3
 4OPSO0yLGJ5lNH/ibYMMjlT+uRESyugGJ9jssTFIkRzWaPCANFr3vGdPu2vgaHYN0jVimDKij
 jRSqbCPS7AhG7qQHvpf5jK2dAoJLJ40AjnnKvWHimE1ROVMiK6d8+EeuE9Bh7VAZxBBu25NVR
 obsuQPD38FJduNgGD++PC5Mbegej/ISulX51Lub12STrHn5Ic55Oi1zhU3OLPggUQC9XOBsDR
 r6G46TAVJ6UJhvJdUzCHq7yumGhtqRkWyPJl8lXteDwzvT0AK7STQbusLOuvoBJ+YUAP+ZTBz
 IltBDwQYsVboqhCCWrPK6wmR5p7nRv0riz61lnY8nLEYE97ktvZOEUFpxEJvsAMiElFqpZIL6
 M/4WKw7TRDxRYOGuPt93aF3TAEOu7ZZPoIJoU9IgAMZa0gSG3oLwl9mOGfgPtKK+7x7YD046r
 BljRY2J33Apk3UHKq4prkObHTujszRA1Tj3nFqsmRQ1Lc
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/10/25 16:28, Li zeming wrote:
> If kzalloc fails to allocate the bioc pointer, NULL is returned
> directly.

s/is returned/should be returned/

>
> Signed-off-by: Li zeming <zeming@nfschina.com>
> ---
>   fs/btrfs/volumes.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 064ab2a79c80..f9cb815fe23d 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5892,6 +5892,8 @@ static struct btrfs_io_context *alloc_btrfs_io_con=
text(struct btrfs_fs_info *fs_
>   		 */
>   		sizeof(u64) * (total_stripes),
>   		GFP_NOFS|__GFP_NOFAIL);

I think you can also remove the __GFP_NOFAIL flag.

Especially the only caller is properly handling the error.

With that __GFP_NOFAIL flag there, it should not fail, but we can not
just rely on NOFAIL flag to save our asses.

Otherwise looks good to me.

With above two points fixed, you can add my tag:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> +	if (!bioc)
> +		return NULL;
>
>   	atomic_set(&bioc->error, 0);
>   	refcount_set(&bioc->refs, 1);
