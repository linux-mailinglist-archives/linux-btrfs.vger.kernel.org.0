Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1307E1DA3
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 10:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjKFJ5G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 04:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKFJ5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 04:57:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B95AA3
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 01:57:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C868FC433C7;
        Mon,  6 Nov 2023 09:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699264623;
        bh=rzHnLpsLcwaSyMOYQyHFlfGI9zVL9VbpUnphQkNsJIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A5qnBZasSDZ8riDWZCC+bOZPnszAHCjGSJ098cRA0Uqp8Lj+C1SNyPfye9CoWTdMT
         TetnlELHnOSaAOnnByVCtILwRcy+uqY2aC2nCOmREbDiLy3Up4/DX4It37iVk2hcMW
         tVnl10aHm2i2CNeuihTOP174yu9pIkS6pke74nlSdmwK5TffdKGURt/kThfyJnP2JN
         cAHPkIy25h/5bFrCaelzgoWkTJAuNnRuFFuBp/TsOells19gBRvLpFS3CnsRZKUa5m
         cHpRCiU6rOtZ0jq2ICgBr5CJaKolJyEyY6ZLG1zEphtZHf5X9vTVSZ0hIzcZwnyDA6
         OqZTIgmADB/tQ==
Date:   Mon, 6 Nov 2023 10:56:57 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231106-drehung-besagen-7fdd84ca5887@brauner>
References: <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <1d08a205-b2c5-4276-b271-088facc142ea@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d08a205-b2c5-4276-b271-088facc142ea@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> Another thing is, the st_dev situation has to be kept, as there are too many
> legacy programs that relies on this to distinguish btrfs subvolume
> boundaries, this would never be changed unfortunately, even if we had some
> better solution (like the proposed extra subvolid through statx).

It would retain backwards compatibility as userspace would need to
explicitly query for STATX_SUBVOLUME otherwise they get they fake
st_dev.

> Which I believe the per-subvolume-vfsmount and the automount behavior for
> subvolume can help a lot.

Very much opposed to this at this point. I've seen the code for this in
the prior patchset and it's implication nothing about this makes me want
this.
