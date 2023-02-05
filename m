Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDE968AEA7
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Feb 2023 08:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBEHNn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Feb 2023 02:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBEHNm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Feb 2023 02:13:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B811DB8E;
        Sat,  4 Feb 2023 23:13:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13036B80AB3;
        Sun,  5 Feb 2023 07:13:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCD3C433D2;
        Sun,  5 Feb 2023 07:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675581218;
        bh=3dm7jZx2o2xV19vr+rbs1ATrGjrGK9Mp7lCwsGZvw7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lyWeZIurWPiXoZwK7fZVC/M8dOfFuplz5eOhd4FTXgYrXRfpzFykDrHMbbtMciR2R
         ZFrALA3yu4dih5w8n2/9xAIPcgRdyxFTFG6ZDqkAW9Fhj4D6UnunJBaodLfMrre5/y
         hJ9WWkEmis7UOUD/T7yROJPjTcfDYgigIrzg7HhU=
Date:   Sun, 5 Feb 2023 08:13:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] btrfs: sysfs: Handle NULL return values
Message-ID: <Y99XGrFvXBL32cOO@kroah.com>
References: <20230204183510.never.909-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204183510.never.909-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 04, 2023 at 10:35:10AM -0800, Kees Cook wrote:
> Each of to_fs_info(), discard_to_fs_info(), and to_space_info() can
> return NULL values.

The code says it could, but I really do not think that is possible at
all, especially based on the fact that there have never been any crashes
reported here.

So the NULL returns should just be removed instead, right?

Also, to_space_info() is a macro of container_of() which can not return
NULL.

And get_btrfs_kobj() is just odd, that probably should be fixed up as
well, that's an indication that something is wrong with the sysfs code
if anyone has to attempt to walk the whole kobject parent path :(

So while this patch might fix up the compiler warning, it's logically
not going to change anything, let's fix this properly.  I can look at it
next week if someone doesn't beat me to it.

thanks,

greg k-h
