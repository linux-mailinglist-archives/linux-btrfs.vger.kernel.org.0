Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C2B485067
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 10:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiAEJxb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 04:53:31 -0500
Received: from mout.gmx.net ([212.227.15.15]:34895 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229754AbiAEJxa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 04:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641376404;
        bh=ZKlAk/d+2xZ6BofgfsapaliGZ1c3z1Fz8FJ8PkR06jw=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=S4XjSzEHF4fJ8ffBmYy8UIpyxJ3Ph9JIc38aX90cbjvRqMUXubPluULxvF2PuYxMm
         TY1lYzl6Zv+EeddcwYUnPyVVEPYDDTJZZ6Tq0Kan8gLRa0FKY/u1n3FIdjjH7IIueR
         ST34Xi5/ppgM9vk4RMFbyRK9jGzUWWXC56dmMvsY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPXd2-1mjXqj2F0c-00Maio; Wed, 05
 Jan 2022 10:53:24 +0100
Message-ID: <486dd0a1-60a5-1554-26fb-69e1789a5dd4@gmx.com>
Date:   Wed, 5 Jan 2022 17:53:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Sahil Kang <sahil.kang@asilaycomputing.com>,
        linux-btrfs@vger.kernel.org
References: <20220105083006.2793559-1-sahil.kang@asilaycomputing.com>
 <20220105083006.2793559-2-sahil.kang@asilaycomputing.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/1] btrfs: reuse existing pointers from btrfs_ioctl
In-Reply-To: <20220105083006.2793559-2-sahil.kang@asilaycomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VMPNbQUHiNmf59p4nBbzVcWOgW6u/fHEKRVNmTp6IHOjS9ye/u0
 8c3FdwEXm5xJ5HmRNU3AqX0axpwaQqdmS1XVseSYKAaIj157U1C2oDI1uhhr58KAFiPnfsB
 QMyI6oLaBZeeTo8oRy08eNl2i84WCvAHI1eFYwhHAF/lX9gLzCpJdWHmYPWzREc8+h4hSRD
 cLVjaL7H2QAmErJRv1s1w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/yKohicicIs=:B8ISIQciQ/fhSOfYUU9wBb
 gGWBdGGjBnSYFoSf0AI42rmkbgZ492OrWChvr//yFCRqpQ7nbeSGOZ7WUYtXv2Cxdk8rRf9fn
 5dum5qAbrCi4grg4FHd5haaQKXnQ+13AY4SfyKjrY44a+JLdQYPtZHvhXnA1QhG4UIhem/xdz
 hiVeYqjt5sFyXveA7+/B6tNLZ5KfWN5wZsQkj8B6aC6ZlwLqJiTvz6g5mxW7ZjMa1atRSVr0W
 1JYfvIfzEpVCvCHaNizju53kOOkdv2W8ezHWP8XuW47WstLq5Z9sSB1iSmym+lhAS6i2f/w60
 ffqHGi7HtRiMYt6crcw1mCRnxUjPfKmxp58MxRaMsi6LIC1YazNnT+p3h/IVSnkJf59cv8Td1
 waX8nZAi4uv1D7JcrvLOUxqPzM0F6UwgQhLe+qnSOpYCFFkkB+m7g5/li2f3bUvx9VUmQhi0L
 lpPCHgcldog/+hGAzf3uGahNxMmVoWaK2bvnm17bhIoVzp+4QC+LUaEGF6yF0/e9wx12roe7O
 GQDOp07nFUyeIuyuprA8r+ob3eCxstFEwlYRCzu7yhv71PUNJYYvOwreWgJb3tGkO9oGFCr80
 tw9BqG1lLCuOjJbZPIKDFN6P1AmpCtCmFk68m0suKn/WJXF/cK9WwaPiqL/BqvUU96GS430yv
 WlRRgoZ73OgZt+TnEfWIfjYvPsC1D0/95X1Tht0TKoMISccXPig16DGtkA5qRM3R/izhl9bnA
 nWnAsWQFGLuStGS05H4kPpjZPlFSSf8D96RXJJQk9zA4gY1sawz3xBVe6KP37xqV9lJDmBOFd
 U8phfhRf6ospfKmU3VPsJn1vYdZyXVys0EEawK0OWWCpt3sh4LH7cl07xxB3fM0FIvdEL1hEF
 ULJVdyvXLjuo93/hwK4uyCWai33HGTk3KHSC6mvQnX2mGMTRMjyH2wUVbX8oE5AgDbdzOpXcr
 Rb4Htx5repHKv/bpFu39O+RNwVU6MbppcjHM1gduJ3FS9a4tli+lHiv6UThmVfz144z1o7Mvl
 /kjd8+vjgpGwV394OalcFSSGl9EDv/gw+2tyg5NWDYUhryziMDwPSQ0vm0KPus595GoLG1P3T
 mhS59w6eWeC+Kw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/5 16:30, Sahil Kang wrote:
> btrfs_ioctl already contains pointers to the inode and btrfs_root
> structs, so we can pass them into the subfunctions instead of the
> toplevel struct file.
>
> Signed-off-by: Sahil Kang <sahil.kang@asilaycomputing.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just some small nitpicks inlined below.

[...]
> -static int btrfs_ioctl_get_subvol_rootref(struct file *file, void __use=
r *argp)
> +static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *subvol_roo=
t,
> +					  void __user *argp)

I guess you're using the @subvol_root naming is to avoid the conflicts
in the existing @root defined locally.

It may be a better idea to rename @root to @tree_root, or doesn't define
it at all.

Since the existing @root is only used in 3 locations.
[...]
> @@ -4873,7 +4867,7 @@ long btrfs_ioctl(struct file *file, unsigned int
>
>   	switch (cmd) {
>   	case FS_IOC_GETVERSION:
> -		return btrfs_ioctl_getversion(file, argp);
> +		return btrfs_ioctl_getversion(inode, argp);
>   	case FS_IOC_GETFSLABEL:
>   		return btrfs_ioctl_get_fslabel(fs_info, argp);
>   	case FS_IOC_SETFSLABEL:
> @@ -4921,7 +4915,7 @@ long btrfs_ioctl(struct file *file, unsigned int
>   	case BTRFS_IOC_TREE_SEARCH_V2:
>   		return btrfs_ioctl_tree_search_v2(file, argp);
>   	case BTRFS_IOC_INO_LOOKUP:
> -		return btrfs_ioctl_ino_lookup(file, argp);
> +		return btrfs_ioctl_ino_lookup(root, argp);
>   	case BTRFS_IOC_INO_PATHS:
>   		return btrfs_ioctl_ino_to_path(root, argp);
>   	case BTRFS_IOC_LOGICAL_INO:
> @@ -5000,7 +4994,7 @@ long btrfs_ioctl(struct file *file, unsigned int
>   	case BTRFS_IOC_GET_SUBVOL_INFO:
>   		return btrfs_ioctl_get_subvol_info(file, argp);
>   	case BTRFS_IOC_GET_SUBVOL_ROOTREF:
> -		return btrfs_ioctl_get_subvol_rootref(file, argp);
> +		return btrfs_ioctl_get_subvol_rootref(root, argp);
>   	case BTRFS_IOC_INO_LOOKUP_USER:
>   		return btrfs_ioctl_ino_lookup_user(file, argp);
>   	case FS_IOC_ENABLE_VERITY:

There are some remaining ioctl sub-routines which you may want to
further cleanup, as they don't really rely on @file to do write check
(aka, RO operations):

- btrfs_ioctl_subvol_getflags()
- btrfs_ioctl_tree_search()
- btrfs_ioctl_tree_search_v2()
- btrfs_ioctl_send()
- btrfs_ioctl_get_subvol_info()
- btrfs_ioctl_ino_lookup_user()

One suspicious ioctls, they should require write permission, but don't:

- btrfs_ioctl_start_sync()
   If there is no running trans, it would bail out without doing
   anything, but I'm wondering if we should call mnt_want_write_file().

   As this means, if we mount a subvolume read-only, but the fs still has
   some part mounted RW, we can start a sync using the read-only mounted
   part.

Thanks,
Qu

