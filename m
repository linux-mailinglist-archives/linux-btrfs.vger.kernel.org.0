Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D07F6B3CFA
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Mar 2023 11:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjCJKz4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Mar 2023 05:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjCJKzc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Mar 2023 05:55:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A758101114
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 02:55:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A674C6137C
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 10:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12599C4339C
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678445696;
        bh=qFQ2ecjO0Hvh4BIGuOq8BcFH8MsZ8AJLY0azE08PHZ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tphuYYecqVVsDTANOZRJnQmH+JyBhMZp4bFGFHXrFpgbKZTXkLDD5ZBX5l1tlLF8l
         aLZnEBvsXq0C/4UWhyQAZu/1yVNd/Ui8HVcvvE9LuC4dCAxjaNgcPpYSI0g2WZwBRz
         xzsYRCCjNa3/Oy+7Il1Xp03iy8xrRFsr8To1siaw8lHyf9FeKI+LaGaL+OYposRcrd
         WMHtmGFjbuY9m/ng7WbPVgdP/HgAmGArbpB7UQZzMCPxtZzrrxSjNTBY6Bqj0ZqC5M
         i9/oIs8FburVuzYIr4157zbITMv0qmw8D5izwwPnYtEJvIYRAwqGeK7bt6BWcUtvNx
         8WQkQ+B7HSc4w==
Received: by mail-oi1-f170.google.com with SMTP id s41so3877167oiw.13
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Mar 2023 02:54:56 -0800 (PST)
X-Gm-Message-State: AO0yUKUYyGzknVnd2b/a5MyRTCFWSb+TRY3toX1hYT3Y24EAns6S1qdR
        4le7mUdLV7W+rkSVulVSCopB9BvO4X+BRhMqN+Q=
X-Google-Smtp-Source: AK7set+tZ6+2VWOvxG5fKLt7chtlxbfsujGosl8Fhh+r19+9QmEkPGtbl7TcoXd+dwIC2+fbGhgiEZ6FPOogjXN0RTs=
X-Received: by 2002:aca:650b:0:b0:383:c3d5:6c9f with SMTP id
 m11-20020aca650b000000b00383c3d56c9fmr8466344oim.11.1678445695324; Fri, 10
 Mar 2023 02:54:55 -0800 (PST)
MIME-Version: 1.0
References: <20230309090526.332550-1-hch@lst.de> <20230309090526.332550-6-hch@lst.de>
 <52d760f4-dec8-7162-40b7-4f0be14848b8@gmx.com> <20230310074723.GA14897@lst.de>
In-Reply-To: <20230310074723.GA14897@lst.de>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 10 Mar 2023 10:54:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4qmpY1c=t2P8fRn-Si4WDPhbdEQuVY7M-spc7-GqXBrw@mail.gmail.com>
Message-ID: <CAL3q7H4qmpY1c=t2P8fRn-Si4WDPhbdEQuVY7M-spc7-GqXBrw@mail.gmail.com>
Subject: Re: [PATCH 05/20] btrfs: simplify extent buffer reading
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 10, 2023 at 8:02=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Fri, Mar 10, 2023 at 03:42:04PM +0800, Qu Wenruo wrote:
> > This is the legacy left by older stripe boundary based bio split code.
> > (Please note that, metadata crossing stripe boundaries is not ideal and=
 is
> > very rare nowadays, but we should still support it).
>
> How can metadata cross a stripe boundary?

Probably with mixed block groups (mkfs.btrfs -O mixed-bg) you can get
that, as block groups are used to allocate both data extents (variable
length) and metadata extents (fixed length).
