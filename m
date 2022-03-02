Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9A4CA643
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 14:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239367AbiCBNrz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 08:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242351AbiCBNrx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 08:47:53 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66A55C373;
        Wed,  2 Mar 2022 05:47:09 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q11so1575271pln.11;
        Wed, 02 Mar 2022 05:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ghcaWJvo4JoKJIENCblXGhxIXc0BBZcnYPvuqKbVrMA=;
        b=lXFINKMJtNazsjIJUmWRs+Kh3zaFKODW8vrjY6noZRi1i7QUaYka+dklE0Sf3exOa/
         SZxbYVI9yIPLLsRvUzhh7NoG+qdEgaxa7u3QmZLG4plfLsH92ADLjRJcP1GdB714IX/v
         4JI+X4ACMVUgoNZ1lOPlZu4S2l3QxSF5lOqHJtdQCDeLVycyL9DDckAl6xgOmFaWiFa7
         qauZR2FZ/bJRhR1pa3BLXOhyepHyZcE0VW8VyzEPs6j84iebA/yO8dPk+QnLKvq5Bl6Z
         D/0bldptz631p6iM/f60t+5J9i16veyL6LpXBCKYemU8ZOAA6lOE0w4CkS8tS6rTBb8n
         TAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ghcaWJvo4JoKJIENCblXGhxIXc0BBZcnYPvuqKbVrMA=;
        b=0DApHV/+pV3IX54kkI8EwJsypozvEyMnXh8lcHvBA5r+hM2Iaj40zeVQ2R1nr4XvSb
         STtBxwAiMGqS03qHwMggDnacaQl0ALXvW4goo3X0gNjhCufzep9J1ARqFaABZ0I/hwfz
         Z2/1O0iUPl67nHQm3DUd8Gl+H2I4PkBcHkmbOVH4lIw5Z5Lw8w/gR7WlkdYTxSbEhEi9
         3JvcwYU+40EvECiQzrL+HvxlVrht4ql0L4jlP07se6+k8VA7A9dQH/cP+lZpG7vgKQX7
         uhN+M7OVlRIkM9uxOjc1zyNKGWkDRJD/zBClNxQGsqUdbGvDD58mqM3vygOaTcBVfou7
         HLPA==
X-Gm-Message-State: AOAM532Kc398zoBZEvx1qIPndylj+W5ldMMzsNvqJQ0OaGPIt3N7vR9W
        e5R0s71qDJ3rj65IrEX39ZXyvwqgsLsyng==
X-Google-Smtp-Source: ABdhPJxFOtyN/1C1S2Z2Kt5616vGO7aZ0kkXc2MMA1ZTJ9qfaaBc1fPzDIzqsQg6/fcOUbg5eyi9Sw==
X-Received: by 2002:a17:902:f682:b0:151:a262:ad4a with SMTP id l2-20020a170902f68200b00151a262ad4amr449833plg.84.1646228829360;
        Wed, 02 Mar 2022 05:47:09 -0800 (PST)
Received: from realwakka ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id n22-20020a056a0007d600b004f3ba7c23e2sm21209937pfu.37.2022.03.02.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 05:47:08 -0800 (PST)
Date:   Wed, 2 Mar 2022 13:47:04 +0000
From:   Sidong Yang <realwakka@gmail.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
Subject: Re: [PATCH] btrfs: add test for enable/disable quota and
 create/destroy qgroup repeatedly
Message-ID: <20220302134704.GB2682@realwakka>
References: <20220301151930.1315-1-realwakka@gmail.com>
 <20220302044334.ojz2crbcc6eapvex@shindev>
 <20220302062659.GA1852@realwakka>
 <20220302082447.qetrvidwqlqkungi@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302082447.qetrvidwqlqkungi@shindev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 02, 2022 at 08:24:48AM +0000, Shinichiro Kawasaki wrote:
> On Mar 02, 2022 / 06:26, Sidong Yang wrote:
> > On Wed, Mar 02, 2022 at 04:43:35AM +0000, Shinichiro Kawasaki wrote:
> > 
> > Hi, Shinichiro.
> > 
> > Thanks for reply!
> > 
> > > Hi Sidong,
> > > 
> > > I tried this patch and observed that it recreates the hang and confirms the fix.
> > > Thanks. Here's my comments for improvements.
> > > 
> > > On Mar 01, 2022 / 15:19, Sidong Yang wrote:
> > > > Test enabling/disable quota and creating/destroying qgroup repeatedly
> > > 
> > > nit: gerund (...ing) and base form are mixed. Base form would be the better to
> > > be same as the code comment.
> > 
> > Yeah, 'disable' should be disabling.
> > > 
> > > > in asynchronous and confirm it does not cause kernel hang. This is a
> > > > regression test for the problem reported to linux-btrfs list [1].
> > > > 
> > > > The hang was recreated using the test case and fixed by kernel patch
> > > > titled
> > > > 
> > > >   btrfs: qgroup: fix deadlock between rescan worker and remove qgroup
> > > > 
> > > > [1] https://lore.kernel.org/linux-btrfs/20220228014340.21309-1-realwakka@gmail.com/
> > > > 
> > > > Signed-off-by: Sidong Yang <realwakka@gmail.com>
> > > > ---
> 
> (snip)
> 
> > > > +	done
> > > > +
> > > > +	for pid in "${pids[@]}"; do
> > > > +		wait $pid
> > > > +	done
> > > 
> > > I think simple "wait" command does what the for loop does.
> > 
> > I didn't know that "wait" command with no parameter waits all background
> > processes to finish. So it seems that we don't need pids it can be
> > deleted. Thanks.
> > 
> > Actually I've been agony about this. Does it needs timeout? When I tried
> > to command like this "timeout 10s wait", This command couldn't be
> > executed becase "wait" command is not binary. How can I insert timeout?
> 
> I think recent discussion on the list is a good reference [1]. A patch was
> posted to add timeout to btrfs/255.
> 
> More importantly, it was discussed that such timeout of user space program will
> not help. Eryu pointed out that once "the kernel already deadlocked, and
> filesystem and/or device can't be used by next test either". IMHO, your new case
> will not require timeout either with same reasoning.
> 
> [1] https://lore.kernel.org/fstests/20220223171126.GQ12643@twin.jikos.cz/T/#me349d62ff367a0a6a28076bdd5b89263fc8109c0
> 
Thanks for a good example. I understand that there is no help in
userspace for the kernel deadlocked. In this case, Just "wait" is
enough.

Thanks,
Sidong
> -- 
> Best Regards,
> Shin'ichiro Kawasaki
