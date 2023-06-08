Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A539C727738
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjFHGWv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjFHGWs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:22:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F581FDF
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1686205359; x=1686810159; i=quwenruo.btrfs@gmx.com;
 bh=y0AcfhrEzuWwbr4dsuxXz0ptWqxnt6OCs5M4QVf62sw=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=dJaQ46sx7k1WUYOWbKgc4dJgpYHfaYFgsqeZSmfTBVy49FHBSnvKrD3CkcEYiPkFmtT41Gk
 8fkSocaMufbJhudpXpFg4qNnkkhWmnqe5UwPJayy+0rrlzIMtWZTN40yWe+QUeG2jywaSp3lB
 UivdYDM7P+KeFHqQPmOwCiBblhBfbHPQzNFJgSasBj4Q2LNzMWKNaN5/62C9n8qrD4ghlToxn
 hfNbALTnxbNaK6Gx8mHMd+FAgaMfBBUzkpso/3NSykDKlLBmCK3H6YEAMZvmGitkANjpjBIso
 9QjQc/DVUL/oiUiRT9VpkFTk+nnLXTG2i7o1gXCCAGztxPAnPpNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHoNC-1qLwc41lxu-00EtXS; Thu, 08
 Jun 2023 08:22:39 +0200
Message-ID: <d7bd5351-f8be-525a-8c54-d320982c4ba0@gmx.com>
Date:   Thu, 8 Jun 2023 14:22:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 5/7] btrfs-progs: btrfs_scan_one_device: drop local
 variable ret
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1686202417.git.anand.jain@oracle.com>
 <718713677855382e44cb57d1ad590063ca20d8f7.1686202417.git.anand.jain@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <718713677855382e44cb57d1ad590063ca20d8f7.1686202417.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B0dzzedmQnsN+O8gdtPcdvH53/uZlv0N+bf0fskPN41/DI6eMSa
 lxVV8LoeDEADP2VJmrFNpKyA4PLsHETG6sQScuD9FZpFWwlqjD0HZZdsMmnNOQvM+fjpfUR
 tQRXmg+94D/O4XcH9yHd+tBzHTfIvD8Dy6TVbhzwXjhZwXmjJxOseP3nrfaa6e4V0QD0QJ1
 MFViQuj/46P1Bk1s4MBBg==
UI-OutboundReport: notjunk:1;M01:P0:Nkvm0iHeNjM=;8zWU+h888VgT4tLOZG4xVE2455J
 lq+1i/MPYJV2K0X2UUfx9f2ksVjz4WUbKjYXeySaJfSNzUGnKd0wnLe7LmjLcrmcK19Syizgv
 HoLXkZJF/0VG4CCLDZGFBdGmpVmLDH4zalFdqZBxnwbj44kpsrZ4HyZW89+n0eEfS8RjmjyIc
 QDe2NffZnqUt4dem4uNSft5Jmk8GG4nQxZQ6MRvSHPEPJYJGFmvS7d+h+KV+EiCbcIwtbIlaL
 IvjBUKP26IC+I0THku3y7C8isINrXZuH+LrgO26Q42I7C32fPwhbfSzz9cALaYJSsW3Sf2gHx
 G6e6cwv3JfGZrN+3GBJpp4/Y+kiAbr0aSELj3yos0yXSjQaD33mTxApUzUHLDYmxWcChdz4Er
 pEZEAQlDbeShjV/AiUaoc1qHfCJLm/jz+zqFG2aCujV7Al8g626iOYT+ReViM0pgHI88i/Gga
 yLwcAbP1kCz6MZ86bTspbD7ImU1qZLMVEzkAUqoXem6zHlfib88U4ZtwlV4SjhZ5lwGGTmMDP
 dpFtcj18lVzqp3fs+8shU8QwNSGzvt7HSYqOEoMDuxFv37XcrvDaZhGD0C2b0ddHm1Y2/AGj8
 IVRJqd0i3Ym3glmcL+az3TKthuLTFzbPBkjXk43m5UYlsg+qUsARzZankWsJgRjdonsKSU9N5
 kWJuLHILClkqkjsRFzPMTaOXPRGlHCk1fbqL6OTE0Kfpo3cVziRygf2E81s5MxJkexV0LZvjn
 lktDJdW4DApoCdXfORiTs0GkOXlQYkVF6Z8GS7VEpIUXY0M4F09l69vKULWeRHVrN5BYlObdk
 GmLekv4qZGMh3OC2v3w0s/n3Uj0Oe5gF33Tdwd8/Ja373N5hlwOxYDOXvw5b02p2uei4CvNq1
 2g6P8+9vtJpBVVQV7+DLjZuWKotowXPRtLy23QF7gFAU6rB5hlqnde5alzlCLISofrrv5COly
 uLCuDEJ3Oj6X5Ak84iTVR3WCL5c=
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



On 2023/6/8 14:01, Anand Jain wrote:
> Local variable int ret is unnecessary, drop it.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

I'm not sure if this change is really necessary.

To me it's more nature to go "ret =3D what_ever();" then handling @ret.
And compiler is definitely clever enough for those optimization.

Thanks,
Qu
> ---
>   kernel-shared/volumes.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
> index 81abda3f7d1c..c8053ae1c7f7 100644
> --- a/kernel-shared/volumes.c
> +++ b/kernel-shared/volumes.c
> @@ -545,10 +545,8 @@ int btrfs_scan_one_device(int fd, const char *path,
>   			  u64 *total_devs, u64 super_offset, unsigned sbflags)
>   {
>   	struct btrfs_super_block disk_super;
> -	int ret;
>
> -	ret =3D btrfs_read_dev_super(fd, &disk_super, super_offset, sbflags);
> -	if (ret < 0)
> +	if (btrfs_read_dev_super(fd, &disk_super, super_offset, sbflags) < 0)
>   		return -EIO;
>
>   	if (btrfs_super_flags(&disk_super) & BTRFS_SUPER_FLAG_METADUMP)
> @@ -556,9 +554,7 @@ int btrfs_scan_one_device(int fd, const char *path,
>   	else
>   		*total_devs =3D btrfs_super_num_devices(&disk_super);
>
> -	ret =3D device_list_add(path, &disk_super, fs_devices_ret);
> -
> -	return ret;
> +	return device_list_add(path, &disk_super, fs_devices_ret);
>   }
>
>   static u64 dev_extent_search_start(struct btrfs_device *device, u64 st=
art)
