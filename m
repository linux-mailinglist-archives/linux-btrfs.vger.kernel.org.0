Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62F41C242
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 12:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245282AbhI2KI6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 06:08:58 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41016 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245226AbhI2KI5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 06:08:57 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A50A22503;
        Wed, 29 Sep 2021 10:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632910036;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31qJYULf0mtvOzYO/C8cDU+A4t0jzws0kc+NYRd8yqo=;
        b=yOO7FF4fGaXeo/kXkydmlAd9kk2mUaWAy/YtzGQOgSQ1ghOjnWeZ04FeFkwN37qMVz7ycJ
        jAfBGx51bFdXo1MJg+vRRr3jZdFX3jw/x0C0tOKhYszPnlw7Ylar7+p/fxv8OozvoJDH8X
        ZTmwChi6hek/s5MF1NWn2m0SIJ3Bfro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632910036;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31qJYULf0mtvOzYO/C8cDU+A4t0jzws0kc+NYRd8yqo=;
        b=rvQvOrzG5ef9rNV6DCdccBTDmUhj/QL+TQiyMU4NA8lgOgiXXxxixasSaduMRQW9spC2aX
        TyzMbPFm7Er66nCQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id 02C7325D50;
        Wed, 29 Sep 2021 10:07:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BC5C7DA7A9; Wed, 29 Sep 2021 12:06:59 +0200 (CEST)
Date:   Wed, 29 Sep 2021 12:06:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nick Terrell <terrelln@fb.com>
Cc:     "B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com" 
        <B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL][PATCH v11 0/4] Update to zstd-1.4.10
Message-ID: <20210929100659.GK9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nick Terrell <terrelln@fb.com>,
        "B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com" <B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <e19ebd67-949d-e43c-4090-ab1ceadcdfab@gmail.com>
 <4A374EA5-F4CC-4C41-A810-90D09CB7A5FB@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4A374EA5-F4CC-4C41-A810-90D09CB7A5FB@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 29, 2021 at 01:30:26AM +0000, Nick Terrell wrote:
> > On Sep 28, 2021, at 5:22 PM, Tom Seewald <tseewald@gmail.com> wrote:
> > Has this been abandoned or will there be future attempts at syncing the
> > in-kernel zstd with the upstream project?
> 
> Sorry for the lack of action, but this has not been abandoned. I’ve just been
> preparing a rebased patch-set last week, so expect to see some action soon.
> Since we’re not in a merge window, I’m unsure if it is best to send out the
> updated patches now, or wait until the merge window is open, but I’m about to
> pose that question to the LKML.

If you send it once merge window is open it's unlikely to be merged. The
code must be ready before it opens and part of linux-next for a week at
least if not more.

> This work has been on my back burner, because I’ve been busy with work on
> Zstd and other projects, and have had a hard time justifying to myself spending
> too much time on this, since progress has been so slow.

What needs to be done from my POV:

- refresh the patches on top of current mainline, eg. v5.15-rc3

- make sure it compiles and works with current in-kernel users of zstd,
  ie. with btrfs in particular, I can do some tests too

- push the patches to a public branch eg. on k.org or github

- ask for adding the branch to linux-next

- try to get some feedback from people that were objecting in the past,
  and of course gather acks or supportive feedback

- once merge window opens, send a pull request to Linus, write the
  rationale why we want this change and summarize the evolution of the
  patchset and why the full version update is perhaps the way forward
