Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D15568C5E9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 19:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjBFShY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 13:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjBFShU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 13:37:20 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCDD2B63C
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Feb 2023 10:37:14 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id v23so13131213plo.1
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Feb 2023 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KLC/XkXNzAEy7VypcsOB1BhiDn5tCJJ6z4r2FO96gZ4=;
        b=Z6Xobl+ifCTmy3tuXbCb4/T7KQuqh1+ELYFMFncOG8gjGjYWHYVKBkKWf/hs7705kQ
         U9pBsHYgyI4LBsQZ4svp9ACnySmMw1lzFGzLx+r5Z3R6I6fYbCXXJfRBQAJhTeaJt2Rd
         DZ+n9H0FNUIhVcUTh+hGz3QzvSZi2ZTAZCEBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLC/XkXNzAEy7VypcsOB1BhiDn5tCJJ6z4r2FO96gZ4=;
        b=4I2ppSwxXYRO0MaahMPQdLJIvQw7UWvrzETYroRi2Am/+DtOIOV86OmxY0XpsnVyUL
         FRwJJM2vHtwZxF9Z9CpAN9bvn7rs6qN/db2RSXqLNHw2ecRL6r+djYgDqkADMuQ8TvbF
         rRjmfvViI18cbpqdPROZf3o8h0pr+BgI0BiwIjwm25HDZqeOAWQcj8OHKu4NhmzERVam
         WUZljve+mwnTxI4sHeDIuq5kkGN7Z/kRrFBZ+lp46iu+ITLhAODJpYAaLBIs4nLLozOy
         tG4b4kTXyb0eaZwQRnLCdhNxuCgHUyZkT2mhcKjAE3iNON98JFcKEZVsXM0DooHktGIm
         ylsA==
X-Gm-Message-State: AO0yUKUd6/BU9MxUoJEhV6JSRYp4Ajm5nbNCuzxEojh+0IDmR6RfJDr0
        nZd/Z4vB8WPzt5u62tHZsDvrug==
X-Google-Smtp-Source: AK7set/Rzubn+NGDwIh+RLUe/eGNYmHcdSo19eILBU6BpKaPvO08yVnkIMQkb7RsLOZ4nQQiabKtPQ==
X-Received: by 2002:a17:902:e749:b0:196:68ee:f363 with SMTP id p9-20020a170902e74900b0019668eef363mr27185847plf.69.1675708634329;
        Mon, 06 Feb 2023 10:37:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b001967580f60fsm7204461pli.260.2023.02.06.10.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:37:13 -0800 (PST)
Message-ID: <63e148d9.170a0220.20379.b4a7@mx.google.com>
X-Google-Original-Message-ID: <202302061035.@keescook>
Date:   Mon, 6 Feb 2023 10:37:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: Handle NULL return values
References: <20230204183510.never.909-kees@kernel.org>
 <Y99XGrFvXBL32cOO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y99XGrFvXBL32cOO@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 05, 2023 at 08:13:30AM +0100, Greg KH wrote:
> On Sat, Feb 04, 2023 at 10:35:10AM -0800, Kees Cook wrote:
> > Each of to_fs_info(), discard_to_fs_info(), and to_space_info() can
> > return NULL values.
> 
> The code says it could, but I really do not think that is possible at
> all, especially based on the fact that there have never been any crashes
> reported here.

I'm not sure that's a useful measure if we're trying to improve
robustness under memory corruption, but at least one of those helpers is
performing a type check, not just a simple container_of(), etc.

Regardless, yeah, if this can be done without NULL returns, sure, let's
do it. I just don't know this code well enough to say what's possible.
:)

-- 
Kees Cook
