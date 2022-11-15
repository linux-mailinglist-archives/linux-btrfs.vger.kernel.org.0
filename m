Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C7262A343
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 21:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiKOUpz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 15:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiKOUpy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 15:45:54 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555CD65EE
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 12:45:50 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 952B432009B2;
        Tue, 15 Nov 2022 15:45:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 15 Nov 2022 15:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668545149; x=1668631549; bh=tbL+tzIiaQ
        IKhMfXL0IuEwbJrZhjfH5B5VkVYglZeDQ=; b=n/eIiVIMnO8VnRA39J/OlAJJ3s
        uzVUHQw6v+4+Wp3W+qKK0iMD7+D4ZMxc+4buIf1zmYMVk3VwDOqmtP6IXALRneV4
        mqrJfhSJCpWmWcCVDccqF7Q/FkhOKZA+2NoqUxPWLYQJTj4T9Y31wX07A1d3D/es
        fK4uppKUfBKBUkv+srZo9EYxQgcv+aKqKxZ79SBoU9MG5vHwYDMXPKctKQMAvQDy
        hUtWxbwjCg8xUmXQdJvsRlPxPn4xOc62/tTKsaqmqscCiP0agxk1bI+CmThF/I5y
        E2WLCGzY7AVsEnb0HPcCEylc5qPUdv0NXMynkbE8vzrH+uWW8Gol09Rjkcww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668545149; x=1668631549; bh=tbL+tzIiaQIKhMfXL0IuEwbJrZhj
        fH5B5VkVYglZeDQ=; b=ujNkgrXqwbaCBWFdtg2JiecKMQlxUOZ7ram4FnHRo3ra
        uAze3quotCulMawgAVm0zGwKo9Qbl9eXqN4qQYvUnx2Xez3U9TuAzyftOm9z+uzh
        0Y2tjTVutjSv+MNVXP2c1TPkWqDR/zDmj6Mo4jsOGgQeSDreSJtzeU1gogs2WXRi
        B2Ev3L/QKzPStJ6bmds07oKLezspC1CJR0y3ilYmV4MTfb7BjHkcmYz7WGNDS0wV
        ik6EudNqwfXzppEObxIgt9lKNg1jDO7sifHhUfO1BkmNv4dC0ZHc1ZNg/HBf77b7
        v7fHaHck4vWXc7f+C/vCnEfj5WZhfkk+5SewvOYwQg==
X-ME-Sender: <xms:ffpzY_Eu6Fz5_JHSBldzX270hpMbHpdlKav2kL_kI4hPPMNnl7Wx8Q>
    <xme:ffpzY8WeKrU_aWttkI-_m2BKvKm_DDlppJz9P05Fs207P3ACofCuLT4xUEgdF2uZ8
    H0oMejH3Ib874IC5MM>
X-ME-Received: <xmr:ffpzYxLwxpgvqMoae-XRM0nHvmyG8fEHWPPmORT7K1h4Gr3RCII9q-dn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeeggddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvve
    eiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:ffpzY9HP3_luEcNpGVfCem8O7nTodqBgM_3g-dwwEG98dXZfrq1lcQ>
    <xmx:ffpzY1UG8YeUWPe9ANur7Q2u_hhVKjN60lYI1Btsa962Dw6n82P6dw>
    <xmx:ffpzY4OsknoEmprYXys9oMQM9qq6so07oV2_zeMuRUKFWlvUZgbGwA>
    <xmx:ffpzY2c9p0kPMgzjtjVIpPkdKEMhztLyI3tFHteumpPQGFE1rkOWiw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Nov 2022 15:45:48 -0500 (EST)
Date:   Tue, 15 Nov 2022 12:45:47 -0800
From:   Boris Burkov <boris@bur.io>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs-progs: receive: add debug messages when
 processing encoded writes
Message-ID: <Y3P6e7h+/5C8/Vl8@zen>
References: <cover.1668529099.git.fdmanana@suse.com>
 <90290fe5047d688d8eecdc1357e9379252ae5352.1668529099.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90290fe5047d688d8eecdc1357e9379252ae5352.1668529099.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 04:25:24PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Unlike for commands from the v1 stream, we have no debug messages logged
> when processing encoded write commands, which makes it harder to debug
> issues.
> 
> So add log messages, when the log verbosity level is >= 3, for encoded
> write commands, mentioning the value of all fields and also log when we
> fallback from an encoded write to the decompress and write approach.
> 
> The log messages look like this:
> 
>   encoded_write f3 - offset=33792, len=4096, unencoded_offset=33792, unencoded_file_len=31744, unencoded_len=65536, compression=1, encryption=0
>   encoded_write f3 - falling back to decompress and write due to errno 22 ("Invalid argument")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  cmds/receive.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/cmds/receive.c b/cmds/receive.c
> index 6f475544..b75a5634 100644
> --- a/cmds/receive.c
> +++ b/cmds/receive.c
> @@ -1246,6 +1246,13 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
>  		.encryption = encryption,
>  	};
>  
> +	if (bconf.verbose >= 3)
> +		fprintf(stderr,
> +"encoded_write %s - offset=%llu, len=%llu, unencoded_offset=%llu, unencoded_file_len=%llu, unencoded_len=%llu, compression=%u, encryption=%u\n",
> +			path, offset, len, unencoded_offset, unencoded_file_len,
> +			unencoded_len, compression, encryption);
> +
> +
>  	if (encryption) {
>  		error("encoded_write: encryption not supported");
>  		return -EOPNOTSUPP;
> @@ -1271,6 +1278,10 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
>  			error("encoded_write: writing to %s failed: %m", path);
>  			return ret;
>  		}
> +		if (bconf.verbose >= 3)
> +			fprintf(stderr,
> +"encoded_write %s - falling back to decompress and write due to errno %d (\"%m\")\n",
> +				path, errno);
>  	}
>  
>  	return decompress_and_write(rctx, data, offset, len, unencoded_file_len,
> -- 
> 2.35.1
> 
