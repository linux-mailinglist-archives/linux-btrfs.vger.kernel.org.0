Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB79B727698
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 07:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjFHFSq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 01:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjFHFSl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 01:18:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC24B2707;
        Wed,  7 Jun 2023 22:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686201508; x=1686806308; i=quwenruo.btrfs@gmx.com;
 bh=1jGLFjVFutlL15INtZAvqv+dncEd6i/m4rHvXBBMmGg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=azgJh8NQWNbUaBSZLWqGY+HoAK5Rm4HbdJTLlg9jWRF+cBQzEeacFhyLve4dmAinhfppBBR
 H0ajL4enkFG6hvF1V2HqCvFzOY9/0vrmMXftOGKDXHMdPy/QCDqL5hQ43PJSb/73OY+DiZ8jM
 i1cnjaUkPdxBrKw9lx6ixMLVRUfcMEvaPZsmp1QuocyIIEtqyAth5frq261ckmpl5ClQrKR1u
 you+c4ehw+2YakiLXArWDKsDZkjOGdtLboWp53oj6xXGwYoIW13/5Ay7rmbmna9ZZR/sHlh/R
 9swM8ytar6JC9ot4eyjAhHI0NDoQzTOkoCDhDoW+O1e7dKUfGQxA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7sHo-1qC67d11nu-004yq6; Thu, 08
 Jun 2023 07:18:28 +0200
Message-ID: <230384e8-55dc-579d-64e8-0c0263b72673@gmx.com>
Date:   Thu, 8 Jun 2023 13:18:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] btrfs: scrub: initialize variable explicitly
Content-Language: en-US
To:     Ou Shixiong <oushixiong@kylinos.cn>, Chris Mason <clm@fb.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230608024901.221232-1-oushixiong@kylinos.cn>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20230608024901.221232-1-oushixiong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6EfPHzuskSxAH6zrU41QsDDbzOkxv+G1nISa7FOgUVKJxduEZiv
 bGFVjlVn3sPr6hweyQ5+arNY35eWjIBHYe6LJmsfV2Mk+JMUVuSfy2UJzzUa/FVK+HqD0hQ
 rajl+QGAI+ti0ZHomWTAo1xCXUKiC4wGGDeEGKe2r3QUBQDrH/tV78dHWJvlEJ7Y2Cud07z
 aRbG3x3pxwVl/CEj8dcsQ==
UI-OutboundReport: notjunk:1;M01:P0:nwIOnVqnoZY=;TlhybxGQrgbpx67pnhiJaMmQFul
 9MaSWzK9TaqGHofGVGuDkz8hfMGiRbIJUTxoDlcQWO2edyIIpCKrJp/2TZgf8+IiX7cXnPGyL
 dNigMNjWGrwcsXtLqjzs+0i8H+YHZAWVst6ZeL3Eu1sdWllIf8Rcgf5k7OAQ+YbXzCm6SsMoK
 bKQVRZxdgzOU8yGiZJyv5yGJ+yM1wE7K4oN6HYfs5nX8lDuRxdFFYvtLbno/bTii3sZkNgwsC
 fTp6U7xuu+Xlb2eU20hPsfLNZ0A+GQ7JlkM7tL4ZHvfl2oQFEqS8+aFfhDsknsLqemt4yAheh
 iAfepHFXikLETcFEMfMylQPJ3307EtC0Lht0zqP36rb3pRlGPQOk78OLo59gBmIOwE8CjCP3c
 iV4Gs9/aTf0QdieiRmKVX1DLDuVTQ9wAdoq8HWMsKk0opnE+WPh0MW3zNlrZmeB/lzkNCARpM
 1keKdUYIss0pSqsIWkegItIH38Er58k99hfZ0Cpu3AaSw3liULgEoa2xsmxeI6m3TdM76QcUs
 fGqazMl3RRxnTGl2KykLDPBEqi4bL6T94MKXMHbFCWvUEuNLgoudT4zX8MJWi/Hla7uW+UBtv
 O+LjcQ78YtxDyAUveprOl0kQUEUP9iA56USfnDK/bmFT9j0JcfY50cm1A1SleV1HjEkFPq0Vz
 dIjc3jCsFKBoL5JEbGg/urDQNTGj0R3dHZ43HlbGjRzgyPYvmUXFGOnDLTPmw1SNLG2nt1X8s
 vMf/trPTvr+/MPE8VatwUcspTsvYKJInhD8CrqtOybIdGhfphkjexEVM5K/d02u8tG8/eCDES
 s+iQPTOK8Mp/hQ98YTUr45ZsWlj3Nu1vQvpACgWl6SUI2JvZIUGRF60rxrHh8aRYxUkqvy3F8
 BIY0C4lytbStAqVcdWGsbmOGUZ+mRW4kgRH8h5QG5tMSb0a5CWzeJU4RBNdwis4+6gtVHQKO9
 Zh937kFpSCf0xbPVleI2gB+JXeQ=
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



On 2023/6/8 10:49, Ou Shixiong wrote:
>
> Fix error of
> error: =E2=80=98ret=E2=80=99 may be used uninitialized in this function =
[-Werror=3Dmaybe-uninitialized]
>
> Signed-off-by: Ou Shixiong <oushixiong@kylinos.cn>

Not again.

Please explain how @ret can be uninitialized, and your toolchain version.

To me, this looks like a false alert, and it's possible your toolchain
is out of date or lacks certain backports.

Thanks,
Qu
> ---
>   fs/btrfs/scrub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 28caad17ccc7..0d5c87c52c33 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1962,7 +1962,7 @@ static int scrub_simple_mirror(struct scrub_ctx *s=
ctx,
>   	/* An artificial limit, inherit from old scrub behavior */
>   	struct btrfs_path path =3D { 0 };
>   	u64 cur_logical =3D logical_start;
> -	int ret;
> +	int ret =3D 0;
>
>   	/* The range must be inside the bg */
>   	ASSERT(logical_start >=3D bg->start && logical_end <=3D bg->start + b=
g->length);
>
>
> Content-type: Text/plain
>
> No virus found
> 		Checked by Hillstone Network AntiVirus
