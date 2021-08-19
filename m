Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC493F12FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 07:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhHSF44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 01:56:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:46991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhHSF4z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 01:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629352574;
        bh=pCv00nLDBSwdY5C7PZcA0AFjn5viCNME8Il3MlqVrs8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PCIRfMhGG10++QyFM0K/V1xNNB7A2i44g7Ib1v3wf7FTrS65gKorakbOnD6lL48nu
         v2IRp118OvJWDkB3LlkHJ3Re9w+ODYMtV7khDVtppQVi5951yaHCJqtNwSlWfXq9T9
         WiOGnsEH8rKdWlcz0OU4nrhrKwkSr0eFnukMluMM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MkYXm-1mvgP52v3W-00m5MA; Thu, 19
 Aug 2021 07:56:14 +0200
Subject: Re: [PATCH v2 09/12] btrfs-progs: make check detect and fix problems
 with super_bytes_used
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629322156.git.josef@toxicpanda.com>
 <fd18dba016fbacb15e30c25acc8b0f9e66d10fe0.1629322156.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f7090e6b-c0ce-b3b3-524d-49d2a6ac9cab@gmx.com>
Date:   Thu, 19 Aug 2021 13:56:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <fd18dba016fbacb15e30c25acc8b0f9e66d10fe0.1629322156.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HXNGfWwEEUp/6epRsFLg78XLj1GUKdCNvZkBARD6PWTQVy3APJI
 G9Z3Pq6Fu4TTvqVK+lNyvsXMrf6iCDVooor2/gtX64JV+rt3HWuKh6egcxLKHGZFc5zG6a+
 gN2EEg9upUfO0HEoC6/aIckXFH0O0fwhOy9nMKrH2DXQPQYzunp/9Czc1MK7uu6IvfrNADh
 reP+0jx/2LU0x8+Uu0Y3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l+w9o2KPUp4=:rdMo2ZDQMDUULp9iecsXAw
 mJb2b6mE7mXZzdSRQxASYgYnWOHPNxqEW7o1FK2DrRvPxXRemoF3qqhzxWzsU+Eu/F8XPNBAE
 +Qh0XJko+YaYDiEAK8F/Ovnc+X8qJZvXQKdBl7XbII5kPRdgNHrxfsZYlFCbpKkm6t3hvXx50
 B5Ot8qBcYi033kpmqfZK+RZKVU/Mf/1hmdkdV25FLPxIkopbN98jty68qhPqB/0tv1cFS0Pnt
 GH1kGRi6E0K3vKEXqUQrAgZdpMS31WBvNufM3Jwm02X0JBzwZeCmOGFnnkqfo06a3fX5h1qU9
 wspxF52aHsB6Qpu/LZ0rf2UrT8GLapuFj9JRMQMjufRuYhh3LHExSKYhj6ZQV/Q929d5aR9eG
 e0s+CUbXEQVyIiY1h/c2mahwj03FkB7kVupw5ftiZ/SOv1B5npz0LaHcQ6t1pWj2vL7MsrR6/
 NEem5F7xu2j+2rKFCBIfjeNRqPihS/Gn8aqs0QzIo6rTFN+0wtU2URJxFHaKfKN8BmqSNPkEU
 X3DEZsiNBrtjuvEP2u2Tacl2yEDKcrW/6usa2Jjtgr4e8ZQNX/JPnSDe/SRo8V/byNzXue3j4
 6IxKQrL37kWhDK4etdlxcJgPBb34mjSntaV/dZ6k/v9qww0kZrKB4hTKxrfjYZRfqZ9SSDBww
 dY+JfQmHMGzPFt1lylmLjnP4C21eZv6cQsmUWZ2dR7TbGFwNaSlWN4nbyuFmufXE+v4jFycoQ
 0QMGJSGX+r51fHQZYBHr+y5enuvuAG9+YEuKM6SQmk17bi1XjMWt9baZozwnlwJkzfeCVsDau
 QpyWmxJhmdVsoy38kA5vfVpg2nPKzvL3NyvkeQYBigl1recb+/OQg+ta9zy/VcDsIDSwu/6UZ
 zxqu3BQIc/HatUNtdYEpxgZRIcWPs6I+nda8QNxerE0L6oXP0EMkKs8ftj2B1bqV2gRQ9/hKt
 9r3XnKT8bbWL9v0waARmQVoN1ECu5bo/9kp5Nh8/JZ5u5DqbIvSDLioT8+/D5Lu91luAxiMRv
 C9wYQNIQmYjdBvjlNS1IQoY0MaMtszXhzNulbLAmRebBq703h9OKQc8v3VlnJXSJyFwT/ivmu
 d/I38JugVbvWTMGXfYu1sl5S/11yOYFMcTJw1GhsBlcL5M2cSBpfnZD9A==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/19 =E4=B8=8A=E5=8D=885:33, Josef Bacik wrote:
> We do not detect problems with our bytes_used counter in the super
> block.  Thankfully the same method to fix block groups is used to re-set
> the value in the super block, so simply add some extra code to validate
> the bytes_used field and then piggy back on the repair code for block
> groups.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   check/main.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/check/main.c b/check/main.c
> index af9e0ff3..b1b1b866 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -8663,12 +8663,14 @@ static int check_block_groups(struct block_group=
_tree *bg_cache)
>   	struct btrfs_trans_handle *trans;
>   	struct cache_extent *item;
>   	struct block_group_record *bg_rec;
> +	u64 used =3D 0;
>   	int ret =3D 0;
>
>   	for (item =3D first_cache_extent(&bg_cache->tree); item;
>   	     item =3D next_cache_extent(item)) {
>   		bg_rec =3D container_of(item, struct block_group_record,
>   				      cache);
> +		used +=3D bg_rec->actual_used;
>   		if (bg_rec->disk_used =3D=3D bg_rec->actual_used)
>   			continue;
>   		fprintf(stderr,
> @@ -8678,6 +8680,19 @@ static int check_block_groups(struct block_group_=
tree *bg_cache)
>   		ret =3D -1;
>   	}
>
> +	/*
> +	 * We check the super bytes_used here because it's the sum of all bloc=
k
> +	 * groups used, and the repair actually happens in
> +	 * btrfs_fix_block_accounting, so we can kill both birds with the same
> +	 * stone here.
> +	 */
> +	if (used !=3D btrfs_super_bytes_used(gfs_info->super_copy)) {
> +		fprintf(stderr,
> +			"super bytes used %llu mismatches actual used %llu\n",
> +			btrfs_super_bytes_used(gfs_info->super_copy), used);
> +		ret =3D -1;
> +	}
> +
>   	if (!repair || !ret)
>   		return ret;
>
>
