Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4523484811
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 19:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiADSse (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 13:48:34 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34596 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiADSsd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 13:48:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 872E11F37F;
        Tue,  4 Jan 2022 18:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641322112;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iRsd2YzCtMpk3rNgMMo7tt35rkeyy4Qyyym7yqcE3eM=;
        b=EMjy1VSqj63fk1hRsxc8IMuRprLiQv2rjxXKly3mDiwahDg+jvWN110BJYrbII5/e7QSwK
        +rqmgFHITvatOt7/sQnBCjJG1ZFhNPAfABvHmzvJN9KhkBi63Ba4Qaoy8JgpUMgf2Uo+aY
        kGaGZn2WIGFlwH7FiAZy/i56CWBn70c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641322112;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iRsd2YzCtMpk3rNgMMo7tt35rkeyy4Qyyym7yqcE3eM=;
        b=03gBtvji/Mk2qAD/tXOktronnTWPNjkptixJyukDG3wv55ppeHXS5nPgUQZowZTYbuYbMP
        l2+NDgrHbIGoAkDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 7FA21A3B83;
        Tue,  4 Jan 2022 18:48:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 02229DA729; Tue,  4 Jan 2022 19:48:02 +0100 (CET)
Date:   Tue, 4 Jan 2022 19:48:02 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: remove redundant fs uuid validation from
 make_btrf
Message-ID: <20220104184802.GW28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211216100012.911835-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216100012.911835-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 16, 2021 at 12:00:12PM +0200, Nikolay Borisov wrote:
> cfg->fs_uuid is either 0 or set to the value of the -U parameter
> passed to mkfs.btrfs. However the value of the latter is already being
> validated in the main mkfs function. Just remove the duplicated checks
> in make_btrfs as they effectively can never be executed.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to devel, thanks.
