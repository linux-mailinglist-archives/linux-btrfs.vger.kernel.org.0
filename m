Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151CA6C2887
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 04:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCUDWL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Mar 2023 23:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUDWJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Mar 2023 23:22:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2358131E3A
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 20:22:06 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCKFu-1pnlyV24jy-009Smb; Tue, 21
 Mar 2023 04:21:46 +0100
Message-ID: <b4329200-650e-f46e-505a-e5248f187be6@gmx.com>
Date:   Tue, 21 Mar 2023 11:21:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Neal Gompa <neal@gompa.dev>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>, Hector Martin <marcan@marcan.st>,
        Davide Cavalca <davide@cavalca.name>
References: <20230321020320.2555362-1-neal@gompa.dev>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [RFC PATCH] btrfs-progs: mkfs: Enforce 4k sectorsize by default
In-Reply-To: <20230321020320.2555362-1-neal@gompa.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:n7C3P08sbdNdiVYzMwNluTkU+Dk63BHLfk6ChV4Idpw6zhcHTEM
 TnY2nizoHZYA2YDYvGv9mroopN0Nq4tafEX5QXCdVM8RErYq3P5N5c7k9rkcgktB9fJ642j
 iMBrGQVv+zdymXlqyOwy+o9KhUv2w07EBz5KlfYwb/8NSqbs6Jnh51pq2pfw8K8lsv94fkN
 N331L6xBulF79LC95Uckg==
UI-OutboundReport: notjunk:1;M01:P0:F4kdgacmWsw=;KFPWkjdKIz39b+fOCmSFfAJwUUK
 0cf6wXT1VeAknxY7r2SmeEvN23uBSVzAdSrW6ytbwTlCP0PYHuijWJbJGn/dTWCkOY/l1WboA
 ZDlPLqGQ4j8/wuOJw7/u1Tqr61A4Jq2gEtk7WJVAQ/1TN3nGvLhVhjiC3RIFrb7vXOEQZYh+W
 c/g4+2CPuiImfYbOlHOvQRB2A3iprpkTehRAPgq7IOs8Q1+6e6Qu42ggCGvVDWjIWjKIz2jUT
 15yB5yLrrhrMwIXWHeHQZ3rRz2SBG1LD8sbxaclRWyTYwc7wDFLjcAS8j2DuzyMm0GnqO2AJD
 kdTrs20y7y5g3+/lYn9SVINMC08+0GTPXoe9un8aBm8heKJZ3NpD+yYEDbS/LeNr4dKpJTS13
 pJYdYbw5koxeOUKSiBJosvCiKeyGJASBmi/6vHaIjIBTAfDk0vPiQS0/TWMb4ymm3ekQ2cT5d
 9u+qxK7vo2rCz3y0RagNiKC5vvAICnfLNlmnT3ctA72avqvABz/MOMMWwViSjyTPhNVyTa91t
 M0l0E7etz/4Fj1IAqC+HK5OVvDUpZHRgYb/Uevfw8BZKUtvUCSYIgYqFt2AkTVyCW9JD4pNNi
 XZUeLJAVBXGkCjKJ/ay4+Grx4b7Afev6YexDVypp5PLiTavydHAxLGGLGkn8/sguY7bMoAG75
 +lZF0Pf659OwC4sqr++6DewXM2hyESka2DTLnr19kANN+Fu4/FDd1dNDXrltUJNTPICpIH9A+
 NiY/MkiGQCtFs8UJqFx7NSod2QkQy3Zyao6A4d6kAn7p+d9m+OjR/KA3cGwy+lT9mSz6YnOTC
 YElHWOxMMdedPclIPl0VZdTXD7vepr8N0D6Zvp/xk1p/jkCuaxN07NG1ufyz6lCrtUzR3Zpck
 Lor3BOREKV6lqgfgw+ZNttxGAnzWQQ82kLcz1edEeZWgNhpk2o5VP5+GkyRWaSLQTI36Ram2h
 sMAHx0wQsdn6PJhmXqfUYwPutfE=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/21 10:03, Neal Gompa wrote:
> We have had working subpage support in Btrfs for many cycles now.
> Generally, we do not want people creating filesystems by default
> with non-4k sectorsizes since it creates portability problems.

My biggest concern for now is, I haven't yet done any subpage testing 
for a while.

The bottle neck is the lack of computing power.

I only have one decent (RK3588 based SBC, Rock5B) board available for 
testing, but it's taken by my daily fstests runs, and it's still using 
4K page size for the aarc64 VM.

Although I have an backup SBC (the same Rock5B), it's reserved mostly 
for upstreaming and testing for the RK3588 SoC.

Personally speaking, this change would bring a lot of more testing 
feedback from Asahi guys, thus would be pretty awesome.

But on the other hand, I really don't want any big bug screwing up early 
adopters, and further damage the reputation of btrfs.


Would the Asahi guys gives us some early test results?
(AKA, full fstests runs with 16K page size and 4K sectorsize).

If nothing wrong happened, I am very happy to this patch.

Thanks,
Qu
> 
> Signed-off-by: Neal Gompa <neal@gompa.dev>
> ---
>   Documentation/Subpage.rst    |  9 +++++----
>   Documentation/mkfs.btrfs.rst | 11 +++++++----
>   mkfs/main.c                  |  2 +-
>   3 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/Subpage.rst b/Documentation/Subpage.rst
> index 21a495d5..d7e9b241 100644
> --- a/Documentation/Subpage.rst
> +++ b/Documentation/Subpage.rst
> @@ -9,10 +9,11 @@ to the exactly same size of the block and page. On x86_64 this is typically
>   pages, like 64KiB on 64bit ARM or PowerPC. This means filesystems created
>   with 64KiB sector size cannot be mounted on a system with 4KiB page size.
>   
> -While with subpage support, systems with 64KiB page size can create (still needs
> -"-s 4k" option for mkfs.btrfs) and mount filesystems with 4KiB sectorsize,
> -allowing us to push 4KiB sectorsize as default sectorsize for all platforms in the
> -near future.
> +Since v6.3, filesystems are created with a 4KiB sectorsize by default,
> +though it remains possible to create filesystems with other page sizes
> +(such as 64KiB with the "-s 64k" option for mkfs.btrfs). This ensures that
> +new filesystems are compatible across other architecture variants using
> +larger page sizes.
>   
>   Requirements, limitations
>   -------------------------
> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
> index ba7227b3..af0b9c03 100644
> --- a/Documentation/mkfs.btrfs.rst
> +++ b/Documentation/mkfs.btrfs.rst
> @@ -116,10 +116,13 @@ OPTIONS
>   -s|--sectorsize <size>
>           Specify the sectorsize, the minimum data block allocation unit.
>   
> -        The default value is the page size and is autodetected. If the sectorsize
> -        differs from the page size, the created filesystem may not be mountable by the
> -        running kernel. Therefore it is not recommended to use this option unless you
> -        are going to mount it on a system with the appropriate page size.
> +        The default value is 4KiB (4096). If larger page sizes (such as 64KiB [16384])
> +        are used, the created filesystem will only mount on systems with a running kernel
> +        running on a matching page size. Therefore it is not recommended to use this option
> +        unless you are going to mount it on a system with the appropriate page size.
> +
> +        .. note::
> +                Versions up to 6.3 set the sectorsize matching to the page size.
>   
>   -L|--label <string>
>           Specify a label for the filesystem. The *string* should be less than 256
> diff --git a/mkfs/main.c b/mkfs/main.c
> index f5e34cbd..5e1834d7 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1207,7 +1207,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	}
>   
>   	if (!sectorsize)
> -		sectorsize = (u32)sysconf(_SC_PAGESIZE);
> +		sectorsize = (u32)SZ_4K;
>   	if (btrfs_check_sectorsize(sectorsize))
>   		goto error;
>   
