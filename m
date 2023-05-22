Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD2D70CCB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 23:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbjEVVmH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 17:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjEVVmF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 17:42:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719C9DB;
        Mon, 22 May 2023 14:41:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD9661F8B2;
        Mon, 22 May 2023 21:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684791711;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhAJnEFhx4f149bphvvnCgoiHtAQXgN+icz30bzEh6w=;
        b=tR/UTXg11Y1KaQsni5njEapQISn38ZTPiBeEdZb3HzLt7llSNxTyz1wLGzNNPCvG/g9zkV
        iPQEZIAXi1ka3++zScNBbA/CyJpVgV/nPuzw/CZFOs27u/gZA+h72hEWK2t3d9xPVp8lod
        hT9ZqMOzWu6kxNIyyheElck+u8LKpKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684791711;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhAJnEFhx4f149bphvvnCgoiHtAQXgN+icz30bzEh6w=;
        b=dKmy39MdU0UBoBEe0TfHYcwAmzK8cXrLpLCF27e0aC3qQ+o53vbMvzcMNx965jkXharjab
        fZhL9+NupTAKoCCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C45B13336;
        Mon, 22 May 2023 21:41:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qednIZ/ha2QkbwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 22 May 2023 21:41:51 +0000
Date:   Mon, 22 May 2023 23:35:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        zhangshida <starzhangzsd@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] btrfs: fix uninitialized warning in btrfs_log_inode
Message-ID: <20230522213544.GR32559@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230516013430.2712449-1-zhangshida@kylinos.cn>
 <f90eb6c1-4491-ecd2-1fdd-56580088c993@gmx.com>
 <28116d72-d3a6-540d-fea8-542dd5d5ca54@oracle.com>
 <315c0548-835c-d54b-2086-cd3823c9b7b9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315c0548-835c-d54b-2086-cd3823c9b7b9@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 17, 2023 at 05:39:09PM +0800, Qu Wenruo wrote:
> On 2023/5/17 17:13, Anand Jain wrote:
> > On 17/5/23 15:46, Qu Wenruo wrote:
> >> On 2023/5/16 09:34, zhangshida wrote:
> >>> From: Shida Zhang <zhangshida@kylinos.cn>
> >>>
> >>> This fixes the following warning reported by gcc 10 under x86_64:
> >>
> >> Full gcc version please.
> >> Especially you need to check if your gcc10 is the latest release.
> >>
> >> If newer gcc (12.2.1) tested without such error, it may very possible to
> >> be a false alert.
> >>
> >> And in fact it is.
> >
> > I also noticed that last_range_start is not actually uninitialized.
> > However, it is acceptable to initialize a variable to silence the
> > compiler if necessary, right? We have done something similar in the
> > past.
> 
> I tend not to. Uninitialized variable warning itself is a good indicator
> to let compiler help us to expose branches we didn't consider.
> 
> Without a no-brainer "int whatever = 0;" we may even hit bugs that some
> corner cases may even use that initialized zero, but we didn't even
> expect to go.

We're in a situation that is not perfect, we got several reports that
were from old compilers but we know most of them were false positives. On
the other hand we want to enable more warnings that make sense to us
(because we can fix/work around them) but can't be yet enabled globally
for linux.

I take the reports or patches as the price for that, so far the number
hasn't been anything near unmanageable. I evaluate each fix in the
context of the code regardless of the compiler, i.e. the code logic must
be correct so it's not a 'no-brainer initialize to 0'. If 0 is the sane
default or detectable invalid value then yes, of course. It might need
some more code restructuring but I don't remember or have an example of
that. Usually just initializing the variable was sufficient.

We cannot expect that everybody has the most up to date version of the
compiler, the minimum currently required for gcc is 5.1
(Documentation/process/changes.rst). I take it as this is the minimum
and anything from that is relevant for reports and fixes. This is what
provides testing coverage, build and runtime.

You can simply skip the warning fix patches, I need to look at them
anyway and I don't mind. I might ask you for an opinion if the suggested
fix is correct in case it's the code I know you do understand well.
