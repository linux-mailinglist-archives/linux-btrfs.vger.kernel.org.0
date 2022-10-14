Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3948F5FEEF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 15:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJNNsQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Oct 2022 09:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJNNsN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Oct 2022 09:48:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63DA1CFF25
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 06:48:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09F37B820BD
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 13:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77CDC433C1
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 13:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665755289;
        bh=wH1txcPRAvSEhe/cU05LZcjYAmBF5BDA+aQ289v7UW4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UgHskDp7u71Hgunil3PN4K/tbSlg+GChsB9vZlPCnEnmglQh8lqS+NP/aFu4Tybla
         O46d3OxfYntBlwWKtLihLMy+5f1kG0/5UHVbpMLHEsRraWYHZIqL0hicOhG41ShqFv
         zEFNmflwSzBcF2qDNuRllWF2l1w+bYFYyMZecnt/drYXutMYIT/xrga4vv9ZywqOEP
         yBvtlxv9XqjUAjqPdLHxp+IsXYE2gEZ1zULQf6sM/yqYbouz8siz7TNdhhA/yv/xCs
         8t0F3iBXH39uEvGvWjmzEapYkkcPsMJ11JizH/IfKjMXrj7CtYdY3fTrzk18yXRhTB
         uxKUzJem2cl5A==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1370acb6588so5878302fac.9
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Oct 2022 06:48:09 -0700 (PDT)
X-Gm-Message-State: ACrzQf2i85RLWITimulKXdSlIJCw/aCHIgvwZY2Hx8fl3uGCgEpsFisG
        AujuOcBV/EXv8ev92Kk3n8D7vIRYkZVRhtyY2TM=
X-Google-Smtp-Source: AMsMyM4WdlKOPYWD283scK7rtVrjcquAxjpsMHrex0rQ3pYEkUZiw1EBrEmV/uKeuSga7p5RizugrtrpOb3eRv6ScX0=
X-Received: by 2002:a05:6870:2052:b0:132:7b2:2fe6 with SMTP id
 l18-20020a056870205200b0013207b22fe6mr2821027oad.98.1665755288932; Fri, 14
 Oct 2022 06:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1665656353.git.fdmanana@suse.com> <903be4beb2a83dcfaa278329c59f055f5a15c42e.1665656353.git.fdmanana@suse.com>
 <20221014133011.GH13389@twin.jikos.cz>
In-Reply-To: <20221014133011.GH13389@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 14 Oct 2022 14:47:32 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4MWu6UuhcAbko51PuuV5ta6XP6V4Q_FBQuJybLM1vE7w@mail.gmail.com>
Message-ID: <CAL3q7H4MWu6UuhcAbko51PuuV5ta6XP6V4Q_FBQuJybLM1vE7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: remove gfp_t flag from btrfs_tree_mod_log_insert_key()
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 14, 2022 at 2:30 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Oct 13, 2022 at 11:36:26AM +0100, fdmanana@kernel.org wrote:
> >index 8a3a14686d3e..6606534fc36a 100644
> > --- a/fs/btrfs/tree-mod-log.c
> > +++ b/fs/btrfs/tree-mod-log.c
> > @@ -220,7 +220,7 @@ static struct tree_mod_elem *alloc_tree_mod_elem(struct extent_buffer *eb,
> >  }
> >
> >  int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
> > -                               enum btrfs_mod_log_op op, gfp_t flags)
> > +                               enum btrfs_mod_log_op op)
> >  {
> >       struct tree_mod_elem *tm;
> >       int ret;
> > @@ -228,7 +228,7 @@ int btrfs_tree_mod_log_insert_key(struct extent_buffer *eb, int slot,
> >       if (!tree_mod_need_log(eb->fs_info, eb))
> >               return 0;
> >
> > -     tm = alloc_tree_mod_elem(eb, slot, op, flags);
> > +     tm = alloc_tree_mod_elem(eb, slot, op, GFP_NOFS);
>
> And after that alloc_tree_mod_elem is also called only with GFP_NOFS.

Indeed.
Just sent a v2 with that change as well.

Thanks.

>
> >       if (!tm)
> >               return -ENOMEM;
> >
