Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEB572CF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2019 13:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfGXLLW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jul 2019 07:11:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:50191 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfGXLLW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jul 2019 07:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563966675;
        bh=kY0YpNdWgmms+iW+74pftbF7Uw6LTLd85ZCdXHzvIRk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YwRb0xtB5zVQ24V6OOiqVAtxd6UW/0DUVGjOdRUQ/uyKpkTYKtPcBQn27LI30qRHn
         8QV3WcOPC/J+Z/AqyzDKmLL8lkmB48C1iuuudGX0zXYsky4TnQJtiSMBfVQOFvT/hs
         C3cI5cQcay/032U5n3CANF5V91jGkfUmvq2QeI+0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.134] ([34.92.239.241]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZkpb-1hwaHt0gWF-00WmDU; Wed, 24
 Jul 2019 13:11:15 +0200
Subject: Re: [PATCH] btrfs-progs: extent-tree: Unify the parameters of
 btrfs_inc_extent_ref()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190724083554.5545-1-wqu@suse.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <5af35ac2-0c9c-f56e-a533-5bff17e854fb@gmx.com>
Date:   Wed, 24 Jul 2019 19:11:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724083554.5545-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dD4/HYzyZjHdJMPangs4yI1gDs1aQOhQ1OCSVdeRTVnhp4+RM11
 xWUVxF4wE85+a82y35/jeBrIZXj+XM2kJi7xvuQOzTRrCEuyUHc0tBFLGBrkje5rGJuour3
 oFALvNIEalQ1UQd0OH7m9T5BxCqLtK+ErxoOTPNzKKtb9r2mGQExli0I9M1xrq7Rue41Qz0
 YKsOt/8TmtkFC0vOYqQrQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F6eHA0cV1XY=:Pgz5w9UKnwc9LV729/64Np
 ngfAbHLSevQMSfyoQtOkure6CrNl3+ayDoRxyf0M9K/BhooGfdH198XEW4bBlCK2kJDkbYPZ3
 tj1gUNUa+/APhPD1cD9DcUxfuNHiKj+owKDILR13Lh9U2yx8fTizV7+rcY6AK1c+QT/ogQ9h8
 oD8JHw0mV/QJsQ8T5lnKVuHgM6RDfAqtwouaICqFeN2aiIZHNxU2J3vxHMjvNCcffWPyByamE
 v+ykHVLKOH/fi8tHtP5HnZ7QNTrPOCadByXnUwjI0SKEPsPYV7VNL5DRlZNgU2QHpS3AcK7W7
 CBTRl/YiXrf1dcvazxKZvw/1IlyQ6OTDUG2/xP0pWZMKOvdQqUqPQQZbxxH9UcUISm7ybX1tB
 Iskj58eDXd1Bl6t0NoGY5RcI3AauNd28F+P+HxcC8+IC0K7/BlD0t2KEZfw9BEWQAQgXpLV3g
 QL4Ir16SMbmV52PtL4tffgobAx5+qjeP2J4oLETXmzjWy2m1hmfv11qQI6BrSiguHjLAu6O2e
 TzuDjzWENnYMjUqtcjvdUVCCgMP7T6lDTU7YBO1Sohih2OO5ZjXndNlp53ZfwlabYf//tpcxO
 YttNmn4EWk6A6Xl24yodBBbjFwOdAXilrSPH3TlpwtPlVK7xsWQMc+RRHMdwnRh729gDOKdaB
 LhfXzPenkW7ZQA95584RaUxfbz/y05sMYOss46jNLNjLy47CroJs9tZO6loQRyTgEwIy/bRAN
 4gXNodbPZfKvkvLy18XmBUKFnCkGqJ0Uxc4pFRMPHa/BdrHgYU5pFWjDVWvRkpNxDfTvZlTUl
 Rn0vt9ftEZYJy3c/6mQJaYqwsySQn0YDmxjMi+lv+eSRkoCj01AuCXMq0/CmyiHZo/0iqF5w6
 ndPniVH7zIst5cWh1fGc6SdP8gusudiLCo86C1DAJkmpuspJ93wKTSKwW646zDnqtjnyd+kpV
 9ApkIJ/cVBCN6Bc01UEFJzNs9viPV6cFz8U5yT+9yJxv/YP72FfISc1FO7a0Ukte9wI6lNE/9
 mgxAKioIYXAV3uk6JESVHKicpT2hSXEVNH1t8Wz4VScGkrIbaXCnFCBgEv7La4wV89u74NRLw
 FOr5s5ma5SiRbkZISTtTnX1690V+PQwIh5/
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/7/24 4:35 PM, Qu Wenruo wrote:
> The old parameters, @ref_generation and @owner_objectid, are pretty
> confusing when using auto-completion.
>
> Unify the parameters as a quick fix.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Makes sense and looks good.

Just to remind, did you notice the next function named
btrfs_update_extent_ref() whose parameters contains @ref_generation and
@owner_objectid? This definition was forgotten to be removed in almost
10 years since commit 95d3f20b51e ("Mixed back reference  (FORWARD
ROLLING FORMAT CHANGE)").
This is another business though.

=2D--
Su
> ---
>   ctree.h | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/ctree.h b/ctree.h
> index b73abe140b1c..0d12563b7261 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -2537,10 +2537,9 @@ int btrfs_free_extent(struct btrfs_trans_handle *=
trans,
>   		      u64 root_objectid, u64 owner, u64 offset);
>   void btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
>   int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
> -				struct btrfs_root *root,
> -				u64 bytenr, u64 num_bytes, u64 parent,
> -				u64 root_objectid, u64 ref_generation,
> -				u64 owner_objectid);
> +			 struct btrfs_root *root,
> +			 u64 bytenr, u64 num_bytes, u64 parent,
> +			 u64 root_objectid, u64 owner, u64 offset);
>   int btrfs_update_extent_ref(struct btrfs_trans_handle *trans,
>   			    struct btrfs_root *root, u64 bytenr,
>   			    u64 orig_parent, u64 parent,
>

=2D-
Su

"Obey or die!"
