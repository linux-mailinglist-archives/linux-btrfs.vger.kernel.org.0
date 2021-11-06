Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02360446BB2
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 02:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhKFBIt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 21:08:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:32785 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhKFBIs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Nov 2021 21:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636160762;
        bh=Z9EDlslOuixHZs2ImYxqTCcIP8SKFB2EmXKMHwNi0H8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=H79VAabSqgqEQrQDhJ2G+RoCyRcrxxJ92qpKQXqOHQqmE1chwZI2YDbsoGjgiRzY2
         id7axnuQk6Twh0KdA3SXOuvwvl4QOIuBl8WBSA0XPHQFz1D2S20qKv3ui3Dh8RNlQB
         +fLi8HCIKb1VTKR4YH5Kzojt+VRL9dF24tC6yFoo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5QJD-1mhmiC2exh-001UoV; Sat, 06
 Nov 2021 02:06:02 +0100
Message-ID: <59a47abb-4725-bbcd-ce44-2b78c46eda57@gmx.com>
Date:   Sat, 6 Nov 2021 09:05:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 5/8] btrfs: tree-checker: don't fail on empty extent roots
 for extent tree v2
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1636145221.git.josef@toxicpanda.com>
 <8fada4dda40dbfb5cefad7eabd16ac00a340896d.1636145221.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8fada4dda40dbfb5cefad7eabd16ac00a340896d.1636145221.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GuRiJ3F2xj8Sgxua9qdqTgtRJ1aZKW0u6PtIRFpfRqQ2oFgxRRo
 SRhRDDINKN2Mr1+Os7hFTrus/mWzY3Iyj8JwfG3gQuBpYiKzGQ3ZiM6LWhCQcLth/Blefq5
 Dd5FZ6G87Q/AQvWaEEdaaDBTSt7IdVtWwiLrDRHRLxpyA5fETHUsrnDPsC1K6N3lWxn1Utc
 5Jdz4MBvMIAhd5opIx8kw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:atPOeoJy0aE=:2pnyb3enlpDYFstOz2ykxe
 aylxegPRwkImasUXvN8bpYo0LqyvxPP46OO6AqFqyYmSPkCvD01DIjlRwxuJa8jJhA872mNM9
 TR7dDOmb6xEAUXHMTXg2VQQjgoBTuUU/7QjG3WOv99SUIVFk1DeNpDM3WFgxCbwCVqPb3Y2xa
 IBDZ8FFDv05r/0j8Wq8zshyJaatpNofmyxFmRRt/voVf7zmR0XlF/vDQTc0SeV5pH0prYM3pd
 iVZSLw+zR4SNHW+yG8GSjrvIBRfTmGA8S8PBdajH+fnAgbBWMWsJ1PG/qqoaKIfATNkgbu/Ol
 BMId2i+Al3wpSTBppf81BcevCC6TOqcy8QAaV4+4nzzXZyrx1JD3ys+3YxjGwyAxWjvOQhykG
 14pwCaX0u24V8L0TKM74RVREr1vbnz/w0AuHXktaRf8/WixLib+MB0Lki3A4qJ8mT5jSme6h7
 RalAaI6B4inaMKuwZD4LaRuB2eKwkbdPbTrbgeiEL41HYt8pcYzfrr8KiJmWus2ol+5aH86Gi
 IRZkmeqgRdBRiY08a935KgKuryRVLBH56mvm+oo6R4u87rTM7AHHFJRN4X9jp1WyP3XurVehl
 mbQLFwd+zL1LIE1lJXsEJa8pCSnA1D9kEkQ3AcrAfhR5+fcP9luhyEfGxjn6kN1lzSS4xyCr9
 NX+XcnUv2q9/RD1IC0C32DXi64Fu8EIehUKxQM5z7gLqctRq1DiVrjbMTMYBfpjJQowb6S9Q/
 16iwewbkPqIPJDsIG2UYWvn1S366ADi+z7KzBDQPkBHqe1RZcopflgdzcJmGdCSfMSbYSKSi5
 5coByDYsxUDojmtykw+9+Vao5bL+O8LtEBaosjAKpKl8DypuWIZT3+kumsMer2GWayyAJrE+W
 FPs9vi1/6W5B3txYKCH6zCeHF0zX+pDGOZiUt9+Rl1JJ4Gg2u3zfpnuYeW2o4QMtgx7ASF396
 DUePUN3FTyXGk+BFnenDG6HmK9gio7hSxIoZYHd0JbFMeOz+6E9cbmMdq2n695lbWb4Se6DqO
 bdm3/WRWqVN5/ntuTDWrmc4DNOrl7yH+vCkEuUR0YjKo4G6sDKG7CrscwhcCh90NlaxyglYO+
 m2V6IFQZdIOncw=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/6 04:49, Josef Bacik wrote:
> For extent tree v2 we can definitely have empty extent roots, so skip
> this particular check if we have that set.

OK I guess the changes in tree-checker is not yet complete.

As I thought there would be more and bigger changes to support those
global roots.

But so far so good for tree-checker.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/tree-checker.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 7733e8ac0a69..1c33dd0e4afc 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1633,7 +1633,6 @@ static int check_leaf(struct extent_buffer *leaf, =
bool check_item_data)
>   		/* These trees must never be empty */
>   		if (unlikely(owner =3D=3D BTRFS_ROOT_TREE_OBJECTID ||
>   			     owner =3D=3D BTRFS_CHUNK_TREE_OBJECTID ||
> -			     owner =3D=3D BTRFS_EXTENT_TREE_OBJECTID ||
>   			     owner =3D=3D BTRFS_DEV_TREE_OBJECTID ||
>   			     owner =3D=3D BTRFS_FS_TREE_OBJECTID ||
>   			     owner =3D=3D BTRFS_DATA_RELOC_TREE_OBJECTID)) {
> @@ -1642,12 +1641,25 @@ static int check_leaf(struct extent_buffer *leaf=
, bool check_item_data)
>   				    owner);
>   			return -EUCLEAN;
>   		}
> +
>   		/* Unknown tree */
>   		if (unlikely(owner =3D=3D 0)) {
>   			generic_err(leaf, 0,
>   				"invalid owner, root 0 is not defined");
>   			return -EUCLEAN;
>   		}
> +
> +		/* EXTENT_TREE_V2 can have empty extent trees. */
> +		if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
> +			return 0;
> +
> +		if (unlikely(owner =3D=3D BTRFS_EXTENT_TREE_OBJECTID)) {
> +			generic_err(leaf, 0,
> +			"invalid root, root %llu must never be empty",
> +				    owner);
> +			return -EUCLEAN;
> +		}
> +
>   		return 0;
>   	}
>
>
