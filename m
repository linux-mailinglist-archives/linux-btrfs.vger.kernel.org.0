Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58604857A7
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 18:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbiAERuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 12:50:46 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50509 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242546AbiAERub (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 12:50:31 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A8435C0151;
        Wed,  5 Jan 2022 12:50:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 05 Jan 2022 12:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Xs+UaHhj0GFgr2co0bND/XiBjun
        2HSHag97jVJxw3mE=; b=iLUVOVkMwvPMTUCRcVzH03XCWmbb/IlKX4saI7HgvoK
        fUzEnHJMEVRRUktJdvXY8tsKJy6S6SLCBP5PD6toBDFu1Tk7Bru0Q4fpTERzJiwz
        ltFA1M7bB3KDx4/Mih7tkP2Uaaq9zgYZ6i0f1KPacfsZKNsGf++Rvgx0u2W0VFQA
        iI9LllXM0cREd3JYY/XWqHbYPdz4V04VCJrLL1Ic04Vh+jLe8o9/d6Eaeea1yBKv
        PEFi/gqYHN7cZp0a0OtdIBgjzr4vQQUHxK1RVo0DxZBSVxQu3/JBUCJFQYGO7ltl
        9M7zsvGLWOGanslUkKpgwaD9w48pa6erSzbXX7D9OfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Xs+UaH
        hj0GFgr2co0bND/XiBjun2HSHag97jVJxw3mE=; b=LNikAb1uXgObQaZW+DG37T
        DpQkK0QV9P13DPFw/VnyCwkv6RfmKKgQrM0TXNdMUzs1MTjKTzJDkkkXwZxqN3aw
        3Zy6igIjYbhnZiZzcaA+ZtmmBC40KK+ptMi5TmwjBNaX+iET6FeyKr2yiW5S7iJ4
        NuL8iO8lRdVYTHSPeWiZc3CUVFq8PkzIfDDmjC9lsMgS7L9e7JW0CmsHn7eh/jeS
        TqF2j+7r230bPbTpXzWLkZonfi+xzMf+1d6R5GkurssdzK3+uMCjRVMES4x7jgny
        9r5C/KQWNm7V1zmWNEs64hp3ACxCuH0Gw/Ztz0yNFGov/UIwv+PylmYt+6Hi+aUg
        ==
X-ME-Sender: <xms:ZtrVYaceJbu4C0KEBdTXitCk7MwX5DNyiIHf3lZgn1_GPtrufLhj1A>
    <xme:ZtrVYUMzQmRzQqqbGJYEriRGXKYGZK2x0tIEsPCkACXDry76hoDVHT37UIPrMJXuR
    dJl81TVYeqViKEQdC8>
X-ME-Received: <xmr:ZtrVYbhdYn2lt-gWjhYHZkvYwRRwcSKJKLSee_uks3W9ZijVTXpDAojudXH3ScZKPAppBm5uI_1lT7HBUJ30Lg0RsDc2FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudefjedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeehudevleekieetleevieeuhfduhedtiefgheekfe
    efgeelvdeuveeggfduueevfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:ZtrVYX-jmP0U8LE7JM5wgIm2Zl459RkhGeeYTMbwQXFT_eli-r3wLQ>
    <xmx:ZtrVYWt7OTQdMHSttg_JzqyImluqvDA87toNmEU32A7u1WK28thcZA>
    <xmx:ZtrVYeFK5vJGdpGCEiy6Zc60UIBWwAESO_-C1-e1q4JC9FcK1Q6Btw>
    <xmx:ZtrVYbX_6hsEGHedZ0bPysqm9GhDHUL1H5CvZ307Lbx8R57QaOgJ-g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jan 2022 12:50:29 -0500 (EST)
Date:   Wed, 5 Jan 2022 09:50:28 -0800
From:   Boris Burkov <boris@bur.io>
To:     Goffredo Baroncelli <kreijack@libero.it>
Cc:     linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: Re: [PATCH][TRIVIAL] btrfs-progs: Allow autodetect_object_types() to
 handle the link.
Message-ID: <YdXaZP27ALM6KJ9G@zen>
References: <f4345fcac83ba226efdadcd4610861e434f8a73e.1641389199.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4345fcac83ba226efdadcd4610861e434f8a73e.1641389199.git.kreijack@inwind.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 05, 2022 at 02:32:58PM +0100, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> 
> Hi All,
> 
> Boris Burkov reported a problem when "btrfs prop get" is invoked on a link of a block
> device. This happens when btrfs is invoked on a LVM device (which typically is
> a link with an user friendly name to the real block device). In this case btrfs
> reports 'ERROR: object is not a btrfs object'.
> 
> ------------------
> Steps to reproduce:
> 
> $ sudo losetup -f disk-1.img 
> $ sudo losetup -f disk-2.img 
> $ sudo losetup -O NAME,BACK-FILE
> NAME       BACK-FILE
> /dev/loop1 /home/ghigo/test-allocation-hint/disk-2.img
> /dev/loop0 /home/ghigo/test-allocation-hint/disk-1.img
>                                   
> $ cd /dev/
> $ mv loop1 loop1-tmp
> $ ln -sf loop1-tmp loop1
> $ ls -l /dev/loop[01]*
> brw-rw---- 1 root disk 7, 0 Jan  5 13:42 /dev/loop0
> lrwxrwxrwx 1 root root    9 Jan  5 13:41 /dev/loop1 -> loop1-tmp
> brw-rw---- 1 root disk 7, 1 Jan  5 13:42 /dev/loop1-tmp
> 
> $ sudo mkfs.btrfs /dev/loop[0-1]
> [....]
> $ sudo mount /dev/loop1 mnt/
> 
> $ # this is the error
> $ sudo btrfs prop get /dev/loop1
> ERROR: object is not a btrfs object: /dev/loop1
> 
> $ # this is what should happen
> $ sudo btrfs prop get /dev/loop0
> label=
> 
> ------------------
> 
> The cause is in the function autodetect_object_types() that detects the type of
> btrfs object passed. If the object is an "inode" type (e.g. file, link...) it
> returns the type of object. If the object is a block device (it doesn't matter
> if it is in a btrfs filesystem), it returns it as block device.
> However it doesn't handle well the case where the object passed is a link
> to a block device (which could be a valid btrfs object). For example
> LVM/DM creates link to block devices.
> 
> This patch adds a further call to stat() (instead of reusing the previous lstat()
> returned value) when btrfs-progs checks if the object is a block device.

Thank you very much for investigating and fixing this. I tested this
patch an it works as advertised.

> 
> Reported-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
> ---
>  cmds/property.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/cmds/property.c b/cmds/property.c
> index 59ef997c..97dc5ae1 100644
> --- a/cmds/property.c
> +++ b/cmds/property.c
> @@ -391,6 +391,14 @@ static int autodetect_object_types(const char *object, int *types_out)
>  			types |= prop_object_root;
>  	}
>  
> +	/*
> +	 * Do a new stat to follow a possible link
> +	 */

I took a look at the original lstat and it doesn't seem super strongly
motivated. It is used to detect a subvolume object (ino==256) so I don't
see why we would hate to have property get/set work on a symlink to a
subvol.

I tested a patch that just changes lstat to stat instead of adding the
second stat, and it handled the subvol case nicely too.

e.g.
ln -s /mnt/real /mnt/lnk
./btrfs property get /mnt/real ro
ro=false
./btrfs property get /mnt/lnk ro
ro=false

> +	ret = stat(object, &st);
> +	if (ret < 0) {
> +		ret = -errno;
> +		goto out;
> +	}
>  	if (S_ISBLK(st.st_mode))
>  		types |= prop_object_dev;
>  
> -- 
> 2.34.1
> 
