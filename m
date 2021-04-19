Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63353648C2
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 19:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhDSRJY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 13:09:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53039 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhDSRJW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 13:09:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9DB495C0295;
        Mon, 19 Apr 2021 13:08:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 13:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=dYyvucGj2nI8wjqyn9TP6AlNdKL
        WIOOZAotSWMf0mhI=; b=HEOl2W5e7qd2z06Ioy4p+xwXwhS0a3Cex23t2R4AMix
        w4jU++nXaiGVhnklnRxCHVaaU2lC/VrJyPfpmddA2qwwpBPBCH01LE/22nYAWs+0
        ieHH6c0MKL+U1lSjlkl9MxWwo4fJu8qi428sot/8rJeOWf67OWvz7EDVw19gJe4Y
        tWXnLz/5sflJfdB0u1pGv36bdLMuZMKLmfrQ9sUtIZy5bsjcCxSddo1lvbnlOVeu
        3UlZ7NLHVLfotm5Xc1zCOfld3Vihfe1ASW83GXiRkPVWSZQTNcyDForZ/9G6vRr9
        wvl8aO686hRl5GHyHlt6V7K3YmdI2qM75LSUgK7kJQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dYyvuc
        Gj2nI8wjqyn9TP6AlNdKLWIOOZAotSWMf0mhI=; b=b4dhQb4EymyG/9jYhA6NCb
        f9uopOHYSzlsohHBegSn+ih4rF+QGckRd/dvgivZ5CIkFsD3UB3hiTezwpM6Xza+
        JQQxV4oh547MQFsaK/gM/H06QVv2aKjclkoIUyLWt9GP6txMCi+ZLyc67MFxSBED
        Taqbo6FcftUxFvLBfFz4jMG3SSh6JSH11dHLpIp2YVPcmnlbX+5vjRB7EOpbWH2F
        /hp4keDY9q4xY5/l5wVI6Zn5UT8SQ7DoGdhYOysM/DVLg7ENr+KzEAp4/i2/AfsJ
        EiOPpOL4lJ6KM9m1GXNw2yo+HdV7wAsIx6kX3532/HOgT1GZpbhkfo0NRjj7iaGQ
        ==
X-ME-Sender: <xms:I7l9YIlzS5n6M8AtFUqcwg6iUek9Rt8lbWQagvW_rUXe5-Q4dBHB6Q>
    <xme:I7l9YOstZno-h0OALScomSJonzB2YRIGcDYtTPOL4lWhIB7NRYaRZlG8EromqRMHf
    ow62g3PRIl1YSw8vew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepheduveelkeeiteelveeiuefhudehtdeigfehke
    effeegledvueevgefgudeuveefnecukfhppedvtdejrdehfedrvdehfedrjeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:I7l9YO9BeawgRH-FsF3wfok43wnKa5YwYWgZizBpX0JDnLQtulwy2Q>
    <xmx:I7l9YAP30vA19ETLS5Moj7GtYrIRNebGsDX5BRNw5JoWXScNtdAVXA>
    <xmx:I7l9YEGbmZk0cw5hop0HkR-PP2YbArxp6Q25hz7YfD6RZnmJ1yFFhQ>
    <xmx:JLl9YL2F_8Oke9yx-ebOZ0yeuKhr_uebmZ8jbNVz70fiF5lmbAm2wg>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA id B1E27108005B;
        Mon, 19 Apr 2021 13:08:51 -0400 (EDT)
Date:   Mon, 19 Apr 2021 10:08:50 -0700
From:   Boris Burkov <boris@bur.io>
To:     20210419124541.148269-1-l@damenly.su
Cc:     linux-btrfs@vger.kernel.org, l@damenly.su,
        Chris Murphy <lists@colorremedies.com>
Subject: Re: [PATCH v2] btrfs-progs: fi resize: fix false 0.00B sized output
Message-ID: <YH25FlnQ4nHg57bm@zen>
References: <20210419130549.148685-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419130549.148685-1-l@damenly.su>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 19, 2021 at 09:05:49PM +0800, Su Yue wrote:
> Resize to nums without sign prefix makes false output:
>  btrfs fi resize 1:150g /srv/extra
> Resize device id 1 (/dev/sdb1) from 298.09GiB to 0.00B
> 
> The resize operation would take effect though.
> 
> Fix it by handling the case if mod is 0 in check_resize_args().
> 
> Issue: #307
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Signed-off-by: Su Yue <l@damenly.su>
> ---
>  cmds/filesystem.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> ---
> Changelog:
>     v2:
>         Calculate u64 diff using max() and min().
>         Calculate mod by comparing new and old size.
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 9e3cce687d6e..54d46470c53f 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -1158,6 +1158,16 @@ static int check_resize_args(const char *amount, const char *path) {
>  		}
>  		old_size = di_args[dev_idx].total_bytes;
>  
> +		/* For target sizes without '+'/'-' sign prefix(e.g. 1:150g) */
> +		if (mod == 0) {
> +			new_size = diff;
> +			diff = max(old_size, new_size) - min(old_size, new_size);
> +			if (new_size > old_size)
> +				mod = 1;
> +			else if (new_size < old_size)
> +				mod = -1;
> +		}
> +
>  		if (mod < 0) {
>  			if (diff > old_size) {
>  				error("current size is %s which is smaller than %s",

This fix seems correct to me, but it feels a tiny bit over-complicated.
Personally, I think it would be cleaner to do something like:

if (mod == 0) {
	new_size = diff;
} else if (mod < 0) {
	// >0 check
	new_size = old_size - diff
} else {
	// overflow check
	new_size = old_size + diff
}

At this point, new_size is set correctly in all cases and we can do the
print. I tested this version on some simple cases, and it seems to work
ok as well.

Thanks for the fix,
Boris

> -- 
> 2.30.1
> 
