Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B84419E7C
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 20:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbhI0SnS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 14:43:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40910 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbhI0SnR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 14:43:17 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3006F2222D;
        Mon, 27 Sep 2021 18:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632768098;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BIK87Z1TSHRjJuqDlLTykiL9siE8UJtUszwhyeaFgI=;
        b=vk7Eu4NZzaeWWCiqfEE/ieG50xszc4HXtyYAwsVLHXZBAtRMJyoSzMO+SmeeefXKCuxkAf
        x7vjaISivMT5MAn05mTafm6ZvnhGKSnMJRegrast6pYjR5/s42V/lgHqiraxfa2opXVfQl
        kIG9Ive6G6ddGojAuum5vr2Z9sKdJ5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632768098;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3BIK87Z1TSHRjJuqDlLTykiL9siE8UJtUszwhyeaFgI=;
        b=qPoFOBnsCRchmDPrHXPRVLb1BuQ3z/sg+LgXBPh+69eYDWVzQ4/eGEImzKax3wlvanDlqe
        TyD3LVDlBhr/5xDA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id F04DC25D3E;
        Mon, 27 Sep 2021 18:41:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 15519DA799; Mon, 27 Sep 2021 20:41:21 +0200 (CEST)
Date:   Mon, 27 Sep 2021 20:41:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 3/5] btrfs-progs: introduce btrfs_pread wrapper for pread
Message-ID: <20210927184121.GD9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
 <20210927041554.325884-4-naohiro.aota@wdc.com>
 <PH0PR04MB7416B3EFBE477A4309A81A329BA79@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB7416B3EFBE477A4309A81A329BA79@PH0PR04MB7416.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 10:23:17AM +0000, Johannes Thumshirn wrote:
> I'd squash that one into the previous patch, but that's preference I guess.

Yeah, 2 patches are preferred.
