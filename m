Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2BF4EF87F
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 18:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbiDAQ6Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 12:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349454AbiDAQ6F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 12:58:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4839C114FF1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 09:56:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EFFAD1FCFF;
        Fri,  1 Apr 2022 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648832174;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q/eJ4WmMK1cHgBeb5+gF6Fft4O5YhUv7QIZ25XaYmpg=;
        b=MpWOkC7YJ3UxfNQixnY0Hz5ijz3pPD6/HJW0h2zLx6ltJMPu+Pxm1M1yFll6eucURN2w05
        oI+m6ooYbDLwqdQV8CXdsX+VNqrlkwDyNZRYdn/qJKVRRBUSJvtVECGELfRXhtnfMStNxm
        0ixU9AEgLwMltx6v+/Q8BXtfO+Zj/PQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648832174;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q/eJ4WmMK1cHgBeb5+gF6Fft4O5YhUv7QIZ25XaYmpg=;
        b=QkILd+YapyoQLEeTPkPwAGREFDGL+/0mJqHriWSodTV01e/b9MCvkuj+95rjSJKS1EYwSE
        QvMUgXoy2oXHl/BA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E5F7BA3B87;
        Fri,  1 Apr 2022 16:56:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D79ABDA7F3; Fri,  1 Apr 2022 18:52:15 +0200 (CEST)
Date:   Fri, 1 Apr 2022 18:52:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/1] btrfs: fix btrfs_submit_compressed_write cgroup
 attribution
Message-ID: <20220401165215.GN15609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20220331215828.179991-1-dennis@kernel.org>
 <20220331215828.179991-2-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331215828.179991-2-dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 31, 2022 at 02:58:28PM -0700, Dennis Zhou wrote:
> This restores the logic from commit 46bcff2bfc5e
> ("btrfs: fix compressed write bio blkcg attribution") which added cgroup
> attribution to btrfs writeback. It also adds back the REQ_CGROUP_PUNT
> flag for these ios.
> 
> Fixes: 91507240482e ("btrfs: determine stripe boundary at bio allocation time in btrfs_submit_compressed_write")
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Looks like this got lost in the refactoring. Added to misc-next, thanks.
