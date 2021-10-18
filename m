Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F54322C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 17:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhJRPZb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 11:25:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46826 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhJRPZa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 11:25:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CFB2F1FD7F;
        Mon, 18 Oct 2021 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634570598;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mra1+ylpn6yG5GNNxYWaExv1MCsXh1LBhmgvJ99UNA=;
        b=nUF7K8FeK1WIQMeF85DYcLAMBprWECylpL/FkPtw+tPJak1QWrXL8N+UuKRFMreyzmW9YF
        jPIcMUfnmcGXmL2LO/Z1GiD8CI0dWr1URn1VsUoB0gXOpF4en/GElxRECyc+3Sk5JIXVN2
        xEtGiNgaisIKDFbckfMuKYdxj7M1yJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634570598;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mra1+ylpn6yG5GNNxYWaExv1MCsXh1LBhmgvJ99UNA=;
        b=yh7iM7eU1put6Sa8MiK/ZodhvBKAL+LEh/s0YLloYpPZFCpD5TmidXznu0SsWtv8MRPPx+
        Q2VSmDILs4mKy9Dg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B20ABA3B8A;
        Mon, 18 Oct 2021 15:23:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF067DA7A3; Mon, 18 Oct 2021 17:22:51 +0200 (CEST)
Date:   Mon, 18 Oct 2021 17:22:51 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v4 0/6] Fix lockdep issues around device removal
Message-ID: <20211018152251.GJ30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1633464631.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1633464631.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 05, 2021 at 04:12:38PM -0400, Josef Bacik wrote:
> v3->v4:
> - I had a fixup for assinging devid that I mis-merged into the wrong patch,
>   fixed this up by putting it in the correct patch.

Added to misc-next, thanks.
