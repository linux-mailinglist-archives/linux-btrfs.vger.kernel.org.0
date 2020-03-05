Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFED17A86F
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 16:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCEPD2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 10:03:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgCEPD2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 10:03:28 -0500
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92DB820848
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2020 15:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420607;
        bh=Hsu/4nWWjXW4fTZwDgk5cidvZYdjJPbjEOR2zMCo6fE=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=yWu14arwJVcif8dZY7kBkoicLd1VElXN4osC9NcGczyzGDp19XfXYLK4EY/Duc4vW
         JWrarlKnvzbO7DpyDSJX273PRqaxZYD8qQSRHx0pwu2D0tnXROwApajk0crWdCjKKF
         5ofAMqqIW350p/P7tqRfvnUmLZDa1ZjXyPQoRdhk=
Received: by mail-ua1-f43.google.com with SMTP id z26so2169820uap.6
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Mar 2020 07:03:27 -0800 (PST)
X-Gm-Message-State: ANhLgQ1+IH69YWYPBRHYuZW0hARVHAPCSJV23DmiAfbQCyu9Bg30vudR
        CzKwlE45qnIM0YpjZhLckd8EsmGo+urt0aqvsco=
X-Google-Smtp-Source: ADFU+vvFa0SFZyYntKIR850Oqt8isLt/L6sA9rlwsZoNqHlgQCGqQX8tFiKgo8p2NRvb8N1Ph1Ha0wMkGq9hUen15E0=
X-Received: by 2002:ab0:7195:: with SMTP id l21mr4653333uao.27.1583420606050;
 Thu, 05 Mar 2020 07:03:26 -0800 (PST)
MIME-Version: 1.0
References: <20200224171327.3655282-1-fdmanana@kernel.org> <5e044000-09e8-ade1-69a6-44cfc59fdc48@toxicpanda.com>
 <CAL3q7H7twdkw1LphkCWexABjT=WGxKHQvq7hsq+99VF5KJE3Uw@mail.gmail.com> <20200305141959.GC2902@twin.jikos.cz>
In-Reply-To: <20200305141959.GC2902@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 5 Mar 2020 15:03:14 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7v4iVheXM_hCt2jaK+JK360ZjA-Ff6FZTGOhm4Zho23w@mail.gmail.com>
Message-ID: <CAL3q7H7v4iVheXM_hCt2jaK+JK360ZjA-Ff6FZTGOhm4Zho23w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Btrfs: implement full reflink support for inline extents
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 5, 2020 at 2:20 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Mar 05, 2020 at 11:57:52AM +0000, Filipe Manana wrote:
> > So this actually isn't safe.
> >
> > It can bring back the race that leads to file extent items with
> > overlapping ranges. Not because of the hole detection part but because
> > of the part where we copy extent items from the fs/subvolume tree into
> > the log tree using btrfs_search_forward(), as we copy all extent
> > items, including the ones outside the fsync range - so we could race
> > in the same way as we did during hole detection with ordered extent
> > completion for ordered extents outside the range.
> >
> > I'll have to rework this a bit.
>
> Ok, I'll remove the branch from for-next. Thanks.

Wrong thread, the comment was meant for:
https://patchwork.kernel.org/patch/11419793/
