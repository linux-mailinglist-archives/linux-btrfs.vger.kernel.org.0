Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3685420A61
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Oct 2021 13:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhJDLxV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Oct 2021 07:53:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58064 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJDLxU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Oct 2021 07:53:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 731CD201ED;
        Mon,  4 Oct 2021 11:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633348290;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slPbpBqa93SsGSCMOhDQtfscxG5NdChTxcwUXZYbqTU=;
        b=xwjJgSpGv375/UWbWLOIKrpSZ/XrQrcWwJ8PVOLSyTPYdqbcsDwYRdxgnbiKTMyRYMdIEC
        VsOqLrnV8iroMNxtQj3fScjxL7BXYUBrMdkDU7UWAL75CG++BBGDIzGqeK5N3cLjcYJXjj
        GPaVu3ugsXPkgidtjGL6yq1JNNWLJ+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633348290;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slPbpBqa93SsGSCMOhDQtfscxG5NdChTxcwUXZYbqTU=;
        b=RuSo0qsJJ6KI9zkcSz6VmBkFR4bWqc07RfKEOupJaKXWoYNu0MdVZR8VudDRvTr1TukjeG
        9dfK3MlLmph++fDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4DE94A3B81;
        Mon,  4 Oct 2021 11:51:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D748DA7F3; Mon,  4 Oct 2021 13:51:11 +0200 (CEST)
Date:   Mon, 4 Oct 2021 13:51:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use kmem cache to allocate struct
 btrfs_qgroup_extent_record
Message-ID: <20211004115110.GW9286@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Hamza Mahfooz <someguy@effective-light.com>,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20211004105533.1605-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004105533.1605-1-someguy@effective-light.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 04, 2021 at 06:55:32AM -0400, Hamza Mahfooz wrote:
> Commit 3368d001ba5d ("btrfs: qgroup: Record possible quota-related extent
> for qgroup.") suggests that,

The commit is from 2015 and besides the TODO notice there's nothing that
explains why it should be kmem cache and not plain kmalloc/kfree.

So, why you'd like to do the change?
