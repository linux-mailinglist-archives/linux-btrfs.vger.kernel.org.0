Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204E871688F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 18:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjE3QC7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 12:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjE3QCp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 12:02:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9341CE6A
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 09:02:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CCE260D32
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 16:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739E8C433EF
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 16:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685462534;
        bh=V8L/n/rq7STenMs7QStihxN4w6LmCGwfsKNls91KIjk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SgFJ+noHOLdat4mFFNQXZBXiSXhDMkJFZmfdWVplDhY7ZdZxcmt9esgzr0QO6spU5
         y6ogvBYCkfF8lE8HCjhRzyiwu64G8UlukFIw1P1uXHvVRqnfHvlVR3ipAUY8jNjenG
         sAl7EmFTnZpGoJF9F7dEbgY1ADi3e2Iw0pDvp7A0jT6PoT+0lSuN7E21hIB1U0Qht+
         N1E5RfvUL/L7pqE0/WI2J7XwsmUjtDwX4Xr7LiwD51yDnh0LGgLZAKj90ILsbDcR9y
         cCBPOtcwZcdmTmUggHzFlPPmiKCIFpEhj1KD7BYyJFwTIcVsgQx8bKTpFHBoCpN6Qu
         H0EZYXxT26T5A==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5552f7a9bc5so1142279eaf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 09:02:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDxSvlJrBQc2bPjnFb9baPzyI3Svn5RS6JLbEnpbv3juq89Oa/SL
        MMWZvBXbvBlTRpvG8ValfTwiEduJBurGu9nW+1Y=
X-Google-Smtp-Source: ACHHUZ5KA8jVrMSgL8Dm4l60PIvO7jrdx8kUUZH9R3secFCJX/PSjNBjQqSrys0EiSKNB0PGVW+okFTjKgCVUGou0Ds=
X-Received: by 2002:a4a:330b:0:b0:54c:ab15:a609 with SMTP id
 q11-20020a4a330b000000b0054cab15a609mr1019391ooq.9.1685462533611; Tue, 30 May
 2023 09:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685363099.git.fdmanana@suse.com> <8f1298da5496557ca89592916cd4a445b6048b8f.1685363099.git.fdmanana@suse.com>
 <20230530150359.GS575@twin.jikos.cz>
In-Reply-To: <20230530150359.GS575@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 30 May 2023 17:01:37 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5jE-qac+d6zFQC4mzAwFNWQVqOCUSF7a6tK2bTQtc7Og@mail.gmail.com>
Message-ID: <CAL3q7H5jE-qac+d6zFQC4mzAwFNWQVqOCUSF7a6tK2bTQtc7Og@mail.gmail.com>
Subject: Re: [PATCH 11/11] btrfs: make btrfs_destroy_delayed_refs() return void
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 4:10=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Mon, May 29, 2023 at 04:17:07PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > btrfs_destroy_delayed_refs() always returns 0 and its single caller doe=
s
> > not even check its return value, so make it return void.
>
> Function can return void if none of its callees return an error,
> directly or indirectly, there are no BUG_ONs left to be turned to
> proper error handling or there's no missing error handling.
>
> There's still:
>
> 4610                         cache =3D btrfs_lookup_block_group(fs_info, =
head->bytenr);
> 4611                         BUG_ON(!cache);
>
> and calling
>
> btrfs_error_unpin_extent_range
>   unpin_extent_range
>     cache =3D btrfs_lookup_block_group()
>     BUG_ON(!cache)
>
> If a function like btrfs_cleanup_one_transaction has limited options how
> to handle errors then we can ignore them there but at least a comment
> would be good that we're doing that intentionally.
>
> This case is a bit special because there's only one caller so we know
> the context and btrfs_destroy_delayed_refs() should eventually return
> void but I'd rather do that as the last step after the call graph is
> audited for proper error handling.

What possible error handling are you expecting?
This is the transaction abort path, we have no way of dealing with
errors - every cleanup of resources is best effort.

Thanks.
