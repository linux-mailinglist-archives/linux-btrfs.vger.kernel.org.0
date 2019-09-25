Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F32DBDEE0
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406023AbfIYNXy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 09:23:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:57026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405963AbfIYNXx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 09:23:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4DA16AFCC;
        Wed, 25 Sep 2019 13:23:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A34FCDA835; Wed, 25 Sep 2019 15:24:12 +0200 (CEST)
Date:   Wed, 25 Sep 2019 15:24:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Cebtenzzre <cebtenzzre@gmail.com>
Subject: Re: [PATCH v2] btrfs: relocation: Fix KASAN report about
 use-after-free due to dead reloc tree cleanup race
Message-ID: <20190925132412.GF2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Filipe Manana <fdmanana@gmail.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>,
        Cebtenzzre <cebtenzzre@gmail.com>
References: <20190923065614.22481-1-wqu@suse.com>
 <CAL3q7H7s8to6yYjymkSuMpifZxJko+RVOXRf7abMuVO5SjS6BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7s8to6yYjymkSuMpifZxJko+RVOXRf7abMuVO5SjS6BQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 25, 2019 at 10:57:49AM +0100, Filipe Manana wrote:
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Instead of such a long subject "btrfs: relocation: Fix KASAN report
> about use-after-free due to dead reloc tree cleanup race", I would use
> something smaller like "btrfs: fix use-after-free on dead relocation roots".
> You don't need to mention in the subject that KASAN detected it, as
> well as the reason for the problem, both can be left in the changelog.

Patch subject updated, thanks.
