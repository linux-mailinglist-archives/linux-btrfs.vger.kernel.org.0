Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1BB4909A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 14:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiAQNj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 08:39:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41550 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiAQNj6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 08:39:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E0AF41F39A;
        Mon, 17 Jan 2022 13:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642426797;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gJClO0QqJbcJHYK6d2nZm1yD/RXfDSiGlcibj7lPx3M=;
        b=ZjHl4E44+IQxjqGJ6iTvP7f1NB6FqVJ/K+iNVrHrihygdaMcFnQObA2BdHeL35rmapow3v
        kAboA4Od4tI5FPXwrXnvidO+bd6wbCs70s823jSIiZU6JSPLQaWujLDEDdOAfeIOxpEObt
        8DbfJS1DPYrcu7wpH2r2kUNdbbTxSVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642426797;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gJClO0QqJbcJHYK6d2nZm1yD/RXfDSiGlcibj7lPx3M=;
        b=jLOf9N8UZGlG0b37k//HaMRV+jHSeP9Ks31vlb9YJ3wJWFiKhcZL/lJmNzjccbLP9MoNGk
        2+avwLlfXtnFISDw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D9E99A3B83;
        Mon, 17 Jan 2022 13:39:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9F2FFDA781; Mon, 17 Jan 2022 14:39:21 +0100 (CET)
Date:   Mon, 17 Jan 2022 14:39:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Sahil Kang <sahil.kang@asilaycomputing.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/1] btrfs: reuse existing inode from btrfs_ioctl
Message-ID: <20220117133921.GF14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Sahil Kang <sahil.kang@asilaycomputing.com>,
        linux-btrfs@vger.kernel.org
References: <20220106150334.GD14046@twin.jikos.cz>
 <20220116024847.29047-1-sahil.kang@asilaycomputing.com>
 <20220116024847.29047-2-sahil.kang@asilaycomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116024847.29047-2-sahil.kang@asilaycomputing.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 15, 2022 at 06:48:47PM -0800, Sahil Kang wrote:
> btrfs_ioctl extracts inode from file so we can pass that into the
> subfunctions.
> 
> Signed-off-by: Sahil Kang <sahil.kang@asilaycomputing.com>

Added to devel, thanks.

> -static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
> +static int _btrfs_ioctl_send(struct inode *inode,
> +			     void __user *argp,
> +			     bool compat)

Please keep the lines filled and don't split when not necessary. Fixed
in the committed patch.
