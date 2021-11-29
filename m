Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FE846209B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 20:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350545AbhK2Ti2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Nov 2021 14:38:28 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50152 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbhK2Tg0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Nov 2021 14:36:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 41902212FE;
        Mon, 29 Nov 2021 19:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638214387;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pqJqB4aG/B4QaE0V/N2msVAs/z57H6qb6kEwXl2hejQ=;
        b=baDTsaA2LE5KePEuPMotCVMCZkrDxZhnVDEjbd5VmNdC9FC9ZQgZeqbLM7htlnbIClHoM/
        eFGeNRg8nPwR6Cqs11tN2JjfeH7atk0E4/rJvvaHdiFgurCialzOg7Iy3yUPcnTSIrlWPA
        jSptjGMkOz9WT2r+WpIxx87fhe2g9eA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638214387;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pqJqB4aG/B4QaE0V/N2msVAs/z57H6qb6kEwXl2hejQ=;
        b=P3uUNNxq65aIbYKfGEOu4K820rFBDrSDvXsHpRGHBB76QYC7ATSeMdeoNv15GjHmwEAbSO
        Y+W98lIJ7JBm2iBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 383C4A3B81;
        Mon, 29 Nov 2021 19:33:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C3D69DA735; Mon, 29 Nov 2021 20:32:56 +0100 (CET)
Date:   Mon, 29 Nov 2021 20:32:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Eryu Guan <guan@eryu.me>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] fstests: generic/260: don't fail for certain fstrim ops
 on btrfs
Message-ID: <20211129193256.GH28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Eryu Guan <guan@eryu.me>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, kernel-team@fb.com
References: <175b1ef92bbd2a48e2efb80d0064ca91aab1402e.1637618880.git.josef@toxicpanda.com>
 <YaOeFrS/wX43Qw5c@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaOeFrS/wX43Qw5c@desktop>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 28, 2021 at 11:19:50PM +0800, Eryu Guan wrote:
> On Mon, Nov 22, 2021 at 05:08:10PM -0500, Josef Bacik wrote:
> > We have always failed generic/260, because it tests to see if the file
> > system will reject a trim range that is above the reported fs size.
> > However for btrfs we will happily remap logical byte offsets within the
> > file system, so you can end up with bye offsets past the end of the
> > reported end of the file system.  Thus we do not fail these weird
> > ranges.  We also don't have the concept of allocation groups, so the
> > other test that tries to catch overflow doesn't apply to us either.  Fix
> > this by simply using an offset that will fail (once a related kernel
> > path is applied) for btrfs.  This will allow us to test the different
> > overflow cases that do apply to btrfs, and not muddy up test results by
> > giving us a false negative for the cases that do not apply to btrfs.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> I'd like an ACK from btrfs folks as well.

Ack.
