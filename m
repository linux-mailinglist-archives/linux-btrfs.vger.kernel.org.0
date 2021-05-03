Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7AF371E54
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 May 2021 19:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhECRU5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 May 2021 13:20:57 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60325 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232233AbhECRUz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 May 2021 13:20:55 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 91E2F5C0167;
        Mon,  3 May 2021 13:19:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 03 May 2021 13:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=/UhmVzjDRf5RXFabl4kdUuqvEHF
        TXdox8npLlzRHfxA=; b=QWeV+Q8Kmln+++DcbTOOT/zUfs5CZfZUmaD/rNnpmuT
        nyr5Ld7fh5494DEihyicVIHaL6a7arc51SpfNFG/AB76aYM4i/4d8fecD4hndERJ
        wx3CUIV8U2bSjrc0dXQqWo2+4Tpj0rUScCpM8ZcZWKUX7B1o9fYnR53ILWhN7382
        IJSrJ2vsP4yg2fHtpapRK5i6jZonjSQiwn1cr06eGnBiCXeNb+DOj4/dA44qR38w
        IANXEB9mZ5HEsSnFreGD+DfzZC4BkiBmhV9Cc7Zpdh7/EN6XwxJluwd32IwwXoNC
        Zjy3S0nkKX/QK1ulwTMSt629MZtQAFS2hF+D43cG28w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/UhmVz
        jDRf5RXFabl4kdUuqvEHFTXdox8npLlzRHfxA=; b=pY5S61pjySQMAnG0tMa/9o
        q1axAyguPMxV2Mx5CjZiAPOWCzWJxoxlISrp83Q4Vg0MumQXDyKhN/jAHwJwqjI5
        uIJI10WVNPuBs43eyGYM4og20tYR3FL5WdLP8YDtlTMyMaB40MguisAhRkqgtC7o
        yntEEcln3cebSLitIgmI08e3CgtMdfvRBgaaC3kN8+yjgOfctQgmHEp4QhY12xjy
        Y9ukpsVhqD1Kkb5L2xjwhjsEDGxy/vaAyn6vAw3EMvR9A/v1JZhL+yWiEbzfG8wP
        KKBQBZQao77L/PrppjlobyLgnanfEYbUFBcok6xp27WbeUGyy9t3+E+3OnnZD8Xw
        ==
X-ME-Sender: <xms:vTCQYBEGc16AgVgMqDhBRKlg2S_OlZqbBszhFe5U0d0sI2eaq_KwCg>
    <xme:vTCQYGX3DiwHEAOFFurj7q3OKi4R69eHLsJo3F-KnEKFZhqHfoczPYqGMAB6lO8tb
    CgkB8VBQcKh_zXHbgE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepheduveelkeeiteelveeiuefhudehtdeigfehke
    effeegledvueevgefgudeuveefnecukfhppedvtdejrdehfedrvdehfedrjeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhioh
X-ME-Proxy: <xmx:vTCQYDJsINPxzVm2Ho6CGKLNnx0gCQDUYWfoDCw-ALgPDXqjVObpgA>
    <xmx:vTCQYHFp_mRVVRYy-VzvepHaHEVbVzJIm2Cb4kAB_2WLIepD_hiosg>
    <xmx:vTCQYHUvfgH_izQsgICnxzAh812RzCXF0KmljWfPccd1rf5uXFrTJw>
    <xmx:vTCQYOfR9I-228C1Rk2KddtzG3NohZijMoG1vRXSAkV71OIl45UkFg>
Received: from localhost (unknown [207.53.253.7])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon,  3 May 2021 13:19:56 -0400 (EDT)
Date:   Mon, 3 May 2021 10:19:55 -0700
From:   Boris Burkov <boris@bur.io>
To:     20210419124541.148269-1-l@damenly.su
Cc:     linux-btrfs@vger.kernel.org, l@damenly.su,
        Chris Murphy <lists@colorremedies.com>
Subject: Re: [PATCH v3] btrfs-progs: fi resize: fix false 0.00B sized output
Message-ID: <YJAwrUMlRK6dWXJv@zen>
References: <20210420045827.150881-1-l@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420045827.150881-1-l@damenly.su>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 20, 2021 at 12:58:27PM +0800, Su Yue wrote:
> Resize to nums without sign prefix makes false output:
>  btrfs fi resize 1:150g /srv/extra
> Resize device id 1 (/dev/sdb1) from 298.09GiB to 0.00B
> 
> The resize operation would take effect though.
> 
> check_resize_args() does not handle the mod 0 case and new_size is 0.
> Simply assigning @diff to @new_size to fix this.
> 
> Issue: #307
> Reported-by: Chris Murphy <lists@colorremedies.com>
> Signed-off-by: Su Yue <l@damenly.su>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
> Changelog:
> v3:
>   Just assign @diff to @new_size. (Boris Burkov)
> v2:
>   Calculate u64 diff using max() and min().
>   Calculate mod by comparing new and old size.
> ---
>  cmds/filesystem.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/cmds/filesystem.c b/cmds/filesystem.c
> index 9e3cce687d6e..b4c09768235c 100644
> --- a/cmds/filesystem.c
> +++ b/cmds/filesystem.c
> @@ -1158,7 +1158,10 @@ static int check_resize_args(const char *amount, const char *path) {
>  		}
>  		old_size = di_args[dev_idx].total_bytes;
>  
> -		if (mod < 0) {
> +		/* For target sizes without '+'/'-' sign prefix(e.g. 1:150g) */
> +		if (mod == 0) {
> +			new_size = diff;
> +		} else if (mod < 0) {
>  			if (diff > old_size) {
>  				error("current size is %s which is smaller than %s",
>  				      pretty_size_mode(old_size, UNITS_DEFAULT),
> -- 
> 2.30.1
> 
