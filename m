Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385543BEDB9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 20:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhGGSMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 14:12:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41708 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhGGSM3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 14:12:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 05F812218E;
        Wed,  7 Jul 2021 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625681388;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=arcGL37IXFLEts6gWmP1wv16bw/ElYgVy0MPnM9v2Iw=;
        b=xNuJk7g0LlmWP1R5bI0sP8nX7IAmaN09X0Zw+VUUURop+HxJU9lcEyBDqVW+sdJ0djgIID
        s41iYQxjPBRAGo1XKAhR1UBtgMKxwF2eUekkrOftNm22bOfBLp7/34jOvn+quploHrkjKI
        37Z5hJq2M5oZgyfdw5MZLqZHiRNL9WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625681388;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=arcGL37IXFLEts6gWmP1wv16bw/ElYgVy0MPnM9v2Iw=;
        b=2DW1MkvH1aW171QLHFrxR4Y8SIiswIWwMYBHYuDFZuwUk17OScL7sVWOIiXmZWMj9h8qXM
        sfHM791bXxjIccDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F25A8A3B97;
        Wed,  7 Jul 2021 18:09:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 39B4CDB29A; Wed,  7 Jul 2021 20:07:14 +0200 (CEST)
Date:   Wed, 7 Jul 2021 20:07:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: ctree: Remove max argument from generic_bin_search
Message-ID: <20210707180714.GR2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com
References: <20210706181325.6749-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706181325.6749-1-mpdesouza@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 06, 2021 at 03:13:25PM -0300, Marcos Paulo de Souza wrote:
> Both callers use btrfs_header_nritems to feed the max argument.
> Remove the argument and let generic_bin_search call it itself.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Added to misc-next, thanks.
