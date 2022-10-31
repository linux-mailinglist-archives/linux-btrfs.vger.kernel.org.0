Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9668F613B1E
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiJaQYf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 12:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiJaQYe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 12:24:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2559910549
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667233420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZiQBDyOLjORds9X4KpGcz9QvStDMZKbZf/Q+zflwYq8=;
        b=DXtcvETun4CZFpo05lHnmxewQLBmIt4wUJyn2IM3V87bN9ITnFLp8UNW8euUR6djD+032B
        EzPMlBNmmRZv0B2bJKdRIHanlHOQgwzhn3iXzpaelaofLChRYDbXPAM3znWMi8uQUAEmmI
        m/iLOUYfcRp0Dl9ZQQIMMKsSU5TCE4k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484-fUkDUVxTPOKan7_QaUVJFw-1; Mon, 31 Oct 2022 12:23:39 -0400
X-MC-Unique: fUkDUVxTPOKan7_QaUVJFw-1
Received: by mail-qk1-f197.google.com with SMTP id x22-20020a05620a259600b006b552a69231so9781291qko.18
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 09:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiQBDyOLjORds9X4KpGcz9QvStDMZKbZf/Q+zflwYq8=;
        b=XdqNDgtVm/rwc8jpXThTciqP5GNgzTRXgQxQwD3eZYXU9uRCuPgguLoBNDKkVnyrq/
         UhTiKmMI1xF0jSN9m9a4fgH9c8ntA9T4pnkZcdOP0jX7I0stXvmn0S10Nqq3MJ4QKwoe
         EK/AAeTCJVVPf0GYi7STEbuHguFSLYre+iOlkw41AOO1EspgTUNOrd71YnpzIUrmBQ69
         ZrWs2FrvygHDy6TyEZuER+HGLDMe+jx62d/T93o0CrRZB0KoV5JisvZhOhvFLUWfzHMJ
         6Lc7X/NG4edcI0HySmZhvXmUXAGQZdKwHLXhwQVbqrQgn8gtFSaArc25nfELpUCApUb8
         +5Ww==
X-Gm-Message-State: ACrzQf15dlcxuqMQ2jEDWjqKNDXnqpseUG+Y5gWmNCwYNc+Ni4CLdA+Q
        OnA5gPz+a3XYXz1x+ySRoM2HgY4vXDXewM6FkhpasJ+r6Ntyio7aCqXkvF22yDjvJZs25PxlOnS
        kxsx6lQNiGNrTfuEU1V0czDQ=
X-Received: by 2002:ac8:5b87:0:b0:39c:b5a6:193b with SMTP id a7-20020ac85b87000000b0039cb5a6193bmr11367772qta.461.1667233418558;
        Mon, 31 Oct 2022 09:23:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7lsq3nqxthtuQzMmKbW42tZC9EWJhq3A+jycMYXQ7UT7Wklqi5Jifzc+rG8KWOFj8lPdgnVA==
X-Received: by 2002:ac8:5b87:0:b0:39c:b5a6:193b with SMTP id a7-20020ac85b87000000b0039cb5a6193bmr11367742qta.461.1667233418300;
        Mon, 31 Oct 2022 09:23:38 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a29d000b006cec8001bf4sm4964648qkp.26.2022.10.31.09.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:23:37 -0700 (PDT)
Date:   Tue, 1 Nov 2022 00:23:32 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 1/3] common/punch: fix flags printing for filter
 _filter_fiemap_flags
Message-ID: <20221031162332.glfpxari24rpwwtu@zlang-mailbox>
References: <cover.1667214081.git.fdmanana@suse.com>
 <a1a5c698061d4c4e6c8994cde7b51969d8929de3.1667214081.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1a5c698061d4c4e6c8994cde7b51969d8929de3.1667214081.git.fdmanana@suse.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 31, 2022 at 11:11:19AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In the filter _filter_fiemap_flags, if we get a flags field that only has
> the 'last' flag set, we end up printing the string "nonelast", which is
> ugly and not intuitive.
> 
> For example:
> 
>   $XFS_IO_PROG -f -c "pwrite 0 64K" $SCRATCH_MNT/foo > /dev/null
>   $XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | _filter_fiemap_flags
> 
> Gives:
> 
>   0: [0..127]: nonelast
> 
> So fix this by updating the filter's awk code to reset the flags string to
> an empty string if we have the "last" flag set and we haven't updated the
> flags string before. So now the same test gives the following result:
> 
>   0: [0..127]: last
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  common/punch | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/common/punch b/common/punch
> index 47a29c92..94599c35 100644
> --- a/common/punch
> +++ b/common/punch
> @@ -130,6 +130,8 @@ _filter_fiemap_flags()
>  			if (and(flags, 0x1)) {
>  				if (set) {
>  					flag_str = flag_str"|";
> +				} else {
> +					flag_str = "";

Looks good to me.

We have two cases (g/352, g/353) call this function, I just gave them a test,
looks like this change doesn't affect them.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  				}
>  				flag_str = flag_str"last";
>  			}
> -- 
> 2.35.1
> 

