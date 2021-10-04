Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9ED421366
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 18:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhJDQDx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbhJDQDw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 12:03:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A42C061745
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Oct 2021 09:02:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j8so1259475wro.7
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Oct 2021 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=RSq73NGwLhJ+QQFqJ+1aR9bP/d5pmA5DdawaLP3VzZQ=;
        b=TFNwqOqBywKlNFNcKNb1AgJq1a+uM2Oxw71FG5q9I5wYVwbwof31+PzUfQGIYUtkWj
         7N4FA9uHGuEqszNcXyaVUDYBGYzC0fWEAGyUM3IuLHOWXFclr50sumYMV8r1IjQOPgBp
         EJHWXCO/VeEhog/UhM1S6L6wnSRmStymWiTz4+L0Ff2kLY9G1zWATCQwndua61IDjloq
         w5vD/pcaPyGa1ci1NVkvcMA9rgzrRVD2Xk6fDGsUi9l5f19A7Ww1TPwgo2pXNqbk5tSn
         Ny03j7ZQTyoii0ub+oOX7C5ZacF2hCaisbOML41XAd4eq9hJy0FmF/soNOzkH0gIfgzr
         INvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=RSq73NGwLhJ+QQFqJ+1aR9bP/d5pmA5DdawaLP3VzZQ=;
        b=we1gAjrAAKOrnV9zQC9Kk0h8qjpFJkeYEUO96wQNDTHjXKFULpOKBxzDiWX5Z/dC6S
         eOYCnoEwO4al8QYyb9wQcHv84+CDFx6XXciAujB0LcAJQOgA/fIlXP28jSKbt3vAHq4s
         jAdFgNbYts0jz/jqW7BWPV1IVDNzqjOI7jv7FNGYU5aR2rvrdzvBNYrI8ArBOyy9VN8+
         jlRS/ozeQT9BCnLsF+3FGob6rgblPcTairBCJreuwIN+0JZs5eY13/oGnQfUrB5bSwxd
         7SImNBHuvUnEzFD/upCy2Ci++Prkpn6w3fp4vOsGPUEvOY7Y7OPXuzSx8CsfjnW8gmp+
         /MfQ==
X-Gm-Message-State: AOAM533R5Fj4q9/VXz6+Dzn4agBa0cY8Xi/xGZlFPWdnP1sW7rZmMg6c
        bCmkFE+HJ0vwoqVCOQar2UyEf5fNAIHJUjniefGFKmIs
X-Google-Smtp-Source: ABdhPJy4sjXAHkdOJTkiaSPBqlm4JqPvtotLtxOwllsV/dISNn2yFDUrtNgVB8yMRte31/evG/uo4kOPGyoFaXVd6aQ=
X-Received: by 2002:a5d:4882:: with SMTP id g2mr14889368wrq.399.1633363322318;
 Mon, 04 Oct 2021 09:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+H1V9wsz2y21qxaYAkNa2PuBUCnM4yFVpoSC5rGav-1LHdwHA@mail.gmail.com>
 <20211004095146.GU9286@twin.jikos.cz>
In-Reply-To: <20211004095146.GU9286@twin.jikos.cz>
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Mon, 4 Oct 2021 11:01:51 -0500
Message-ID: <CA+H1V9yopc2okgT=5XeCwvHF8oXPVhnojaf_rZOeuiThZEfqWQ@mail.gmail.com>
Subject: Re: Changing the checksum algorithm on an existing BTRFS filesystem
To:     dsterba@suse.cz, Matthew Warren <matthewwarren101010@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I don't know how btrfs is layed out internally, but is checksum tree
separate from file (meta)data or is it part of the (meta)data? If it's
separate it should be possible to build a second csum tree and then
replace the old one once it's done, right?

Matthew Warren

On Mon, Oct 4, 2021 at 4:52 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Oct 04, 2021 at 12:26:16AM -0500, Matthew Warren wrote:
> > Is there currently any way to change the checksum used by btrfs
> > without recreating the filesystem and copying data to the new fs?
>
> I have a WIP patch but it's buggy. It works on small filesystems but
> when I tried it on TB-sized images it blew up somewhere. Also the WIP is
> not too smart, it deletes the whole checksum tree and rebuilds if from
> the on-disk data, so it lacks the verification against the existing
> csums. I intend to debug it some day but it's a nice to have feature,
> I'm aware that people have been asking for it but at this point it would
> be to dangerous to provide even the prototype.
