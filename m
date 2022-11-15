Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64F0629F82
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiKOQs2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKOQs1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:48:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C904DDAD
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:48:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 635906190E
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 16:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3424C433C1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 16:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668530904;
        bh=1GySTb8nbgmeUjUX4QsXBUbg7e9ZN51IxXzNWbGQTmQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CbQ3PBkZBPKwQ8rkL56CtsaqT/jMiTBz0/0khPOoWgZic/7eFx3f70BHQUOWlRUWq
         c9qKrLcabs7QC7Eeh5GsA0nEBI2Bqr0TUOYOj+pg6yem904ObsjG+WWehKVo6AiqvT
         Ryb1nexPxg5NyQFPnpHdGidSdrwMqGI6i3b553wRezK79BVAMidp2G1s0PqLV9R9EG
         d3KAQpvgwORoj2q41HATIrvSU4ezapd2BJYUd2F0hlfyekm92iJsB1GGzdc2CXj3CE
         a3WjVZMzSVHnsUbLgh8YOl/lAe/IFBsSKFmPdujlmPq6o+czkc182X5E+nivTHNRfg
         ZW2Hg4l9XfK6A==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so16888929fac.1
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 08:48:24 -0800 (PST)
X-Gm-Message-State: ANoB5pmn3SQEjn5dlBstSfa5UuL38eBDq0IyK+uMjziF1T2zY5DitRzN
        JrWZ3cCbpNP5+CqETz3Nuv9q+uzZn3pSp1ZCtig=
X-Google-Smtp-Source: AA0mqf5Nm249Lyb8PPEXXcfhYQjskrivCUHIZUgW/gWIloihryccNOjlTO1ZhbIrXARlngYbnL2qdD/OxawEfaxDJ/w=
X-Received: by 2002:a05:6871:4589:b0:12b:fbe7:b793 with SMTP id
 nl9-20020a056871458900b0012bfbe7b793mr849708oab.92.1668530903844; Tue, 15 Nov
 2022 08:48:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668529099.git.fdmanana@suse.com> <6e601151e5d290a6a6288928e9d8737aca82ed7b.camel@scientia.org>
In-Reply-To: <6e601151e5d290a6a6288928e9d8737aca82ed7b.camel@scientia.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 15 Nov 2022 16:47:47 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5VJM6GY5GN9zjOj3qPhPxRSZhtq8smZkBd4TVJ_vy7Nw@mail.gmail.com>
Message-ID: <CAL3q7H5VJM6GY5GN9zjOj3qPhPxRSZhtq8smZkBd4TVJ_vy7Nw@mail.gmail.com>
Subject: Re: [PATCH 0/3] btrfs-progs: receive: fix a silent data loss bug with
 encoded writes
To:     Christoph Anton Mitterer <calestyo@scientia.org>
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

On Tue, Nov 15, 2022 at 4:37 PM Christoph Anton Mitterer
<calestyo@scientia.org> wrote:
>
> Hey.
>
> I recently sent | received a lot of previous data, thus asking:
>
> What exactly does encoded write mean?

Right now, it means a write operation where the data is compressed.
I.e. there was no decompression at the sender side.

> Is one *only* affected when ones
> used compression - respectively if one DID NOT do any filesystem
> compression (i.e. compress mount option)... can one be sure to be safe?

If you haven't used 'btrfs send' with the --compressed-data option or
you are sure you don't have any compressed files, then you're fine.
Otherwise check your files by comparing them between the sending side
and the receiving side.

>
> Thanks,
> Chris.
>
>
> [0] https://lore.kernel.org/linux-btrfs/cover.1660690698.git.osandov@fb.com/
